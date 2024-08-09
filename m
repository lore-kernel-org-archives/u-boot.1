Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0263DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E07887FF;
	Fri,  9 Aug 2024 14:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22D28895D; Fri,  9 Aug 2024 14:28:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7D8E788606
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76DE213D5;
 Fri,  9 Aug 2024 05:29:07 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87D33F6A8;
 Fri,  9 Aug 2024 05:28:40 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:28:36 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, Seung-Woo
 Kim <sw0312.kim@samsung.com>
Subject: Re: [PATCH 1/1] tools: fix signature of toc0_verify_cert_item()
Message-ID: <20240809132836.1ac2b1fd@donnerap.manchester.arm.com>
In-Reply-To: <20240809112216.36587-1-heinrich.schuchardt@canonical.com>
References: <20240809112216.36587-1-heinrich.schuchardt@canonical.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri,  9 Aug 2024 13:22:16 +0200
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

Hi Heinrich,

> Avoid a build warning with GCC 14.2
>=20
>     tools/sunxi_toc0.c: In function =E2=80=98toc0_verify_cert_item=E2=80=
=99:
>     tools/sunxi_toc0.c:447:12: warning: =E2=80=98nonnull=E2=80=99 argumen=
t =E2=80=98digest=E2=80=99
>     compared to NULL [-Wnonnull-compare]
>       447 | if (digest && memcmp(&extension->digest, digest, SHA256_DIGES=
T_LENGTH)) {
>           |    ^
>=20
> Use a pointer instead of an array to signal that the argument might be
> NULL.

Seung-Woo Kim sent a different patch for the same problem last week, and
Tom merged it earlier this week:
https://source.denx.de/u-boot/u-boot/-/commit/59fff91f2bea2215c7b16415b9a0e=
6714fac5573

Thanks for reporting anyways!

Cheers,
Andre

>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>


> ---
>  tools/sunxi_toc0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
> index 292649fe90f..545c3771853 100644
> --- a/tools/sunxi_toc0.c
> +++ b/tools/sunxi_toc0.c
> @@ -412,7 +412,7 @@ err:
>   * This function is only expected to work with images created by mkimage.
>   */
>  static int toc0_verify_cert_item(const uint8_t *buf, uint32_t len, RSA *=
fw_key,
> -				 uint8_t digest[static SHA256_DIGEST_LENGTH])
> +				 uint8_t *digest)
>  {
>  	const struct toc0_cert_item *cert_item =3D (const void *)buf;
>  	uint8_t cert_digest[SHA256_DIGEST_LENGTH];

