Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A53F8A157
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 11:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13C3840AB;
	Thu, 16 Apr 2026 13:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NeK+k/mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A971384105; Thu, 16 Apr 2026 13:01:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86BB8407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 13:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776337241; x=1776942041; i=xypron.glpk@gmx.de;
 bh=dpZRirgUt/pe6MAycu65G5vVxiEFo10mJ4w3MZFxHs8=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NeK+k/miC7xGHOSDIZe8nYgaKtWgJMkKFnDBqcB1LBtt62YOImNgEu1jm40ENKqF
 98fv6khU2EIgBfRDxLVwx/xS3xex6YvRnwzVp2qMN4IMjI1g0+bC4D8HKoL89mTTV
 RBAlJx0zwq5hLWEBJ7WgBScCXlZdFh18WIxH8gWETobMk3oHP0EYlTfemyccqdhYw
 dI94UXFvEstnDbC6dczrfRixn+VUR26Aa8umD/dGRJJSUv6pnxfp119E84iPzcYR/
 mRJ8vfAAlFz4RHUgpim8x/+wMK2kwdCrYtUscUCsnuPIRzvo5KXsKuguHfsPSvlyw
 p9MV4aIkO2688drN6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1vhJ5x0udw-00l09k; Thu, 16
 Apr 2026 13:00:41 +0200
Date: Thu, 16 Apr 2026 13:00:31 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/7=5D_include=3A_hexdump=3A_?=
 =?US-ASCII?Q?make_hex2bin=28=29_usable_from_host_tools?=
User-Agent: Thunderbird for Android
In-Reply-To: <8a5a44f1c0b0ede9e8a3f66e9cfad8807963e756.1776302806.git.daniel@makrotopia.org>
References: <cover.1776302805.git.daniel@makrotopia.org>
 <8a5a44f1c0b0ede9e8a3f66e9cfad8807963e756.1776302806.git.daniel@makrotopia.org>
Message-ID: <0F930E8B-9434-4365-9F64-2714E6C2A117@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iv8WLX4EbCHqVpSdtgP53MbwQfr+eGckLUbUKKUlTCI3RC0nCAJ
 D0JRaByTBdQ2yczRgtfPT+mgJAz6r04IJFJQyrZyoGImHyYnzO4238TtlCiClI4SnVYYc62
 j2UOaVpgONCjUNGPkcIQYwRj9uRJdJ9cngeM8WStvr2LZvHRe956z2RQ7tZC6PgTfBgzByz
 IOQZ2A5o4Jo5tEC2EdH1w==
UI-OutboundReport: notjunk:1;M01:P0:nES1zTdEjc4=;uAfuJBTwlQpAyhM1ROjrGe0paew
 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
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

Am 16=2E April 2026 03:46:42 MESZ schrieb Daniel Golle <daniel@makrotopia=
=2Eorg>:
>Make hexdump=2Eh work in host-tool builds by using 'uint8_t' instead
>of 'u8', and including either user-space libc <ctype=2Eh> for host-tools
>or <linux/ctype=2Eh> when building U-Boot itself=2E
>
>Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>---
>v2: new patch
>
> include/hexdump=2Eh | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/include/hexdump=2Eh b/include/hexdump=2Eh
>index f2ca4793d69=2E=2E5cb48d79efe 100644
>--- a/include/hexdump=2Eh
>+++ b/include/hexdump=2Eh
>@@ -7,7 +7,11 @@
> #ifndef HEXDUMP_H
> #define HEXDUMP_H
>=20
>+#ifdef USE_HOSTCC
>+#include <ctype=2Eh>
>+#else
> #include <linux/ctype=2Eh>

uin8_t is defined in stdint=2Eh=2E
Don't we need it in the HOSTCC case?

Best regards=20

Heinrich


>+#endif
> #include <linux/types=2Eh>
>=20
> enum dump_prefix_t {
>@@ -20,7 +24,7 @@ extern const char hex_asc[];
> #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
> #define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
>=20
>-static inline char *hex_byte_pack(char *buf, u8 byte)
>+static inline char *hex_byte_pack(char *buf, uint8_t byte)
> {
> 	*buf++ =3D hex_asc_hi(byte);
> 	*buf++ =3D hex_asc_lo(byte);
>@@ -52,7 +56,7 @@ static inline int hex_to_bin(char ch)
>  *
>  * Return 0 on success, -1 in case of bad input=2E
>  */
>-static inline int hex2bin(u8 *dst, const char *src, size_t count)
>+static inline int hex2bin(uint8_t *dst, const char *src, size_t count)
> {
> 	while (count--) {
> 		int hi =3D hex_to_bin(*src++);

