Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FE7C36010
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D7C8144A;
	Mon, 31 Mar 2025 12:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="WqydFp5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9557281703; Mon, 31 Mar 2025 12:51:04 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DFF8129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1743418260; x=1743677460;
 bh=Sn63+a+dgYzQYWxS1fvvlAaqHFTBVZ1EuuW25Q2T7x8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=WqydFp5oPLpIgglP+ZfMx174bXrSuRK7K1fDQCH1Jcyna0z04Kpde3ypthn5LZIx6
 4ijOrD2B2XMaAyFlACc9HrtukI6sXsc0iFToMhp4ksb5yAo/WT6gzAa7XDEDRI8vjG
 fqIoJDgnCiLF8XX7ZZwYcTMTv6Xm+k69sTg2njwQV2bBbPFmPg2L+UVdH4AYVCIiyg
 BbJ/F/Vm6zHn8oGjXa2I7ZJZsQfedF/6fwcm5Qyd6O7qfUmeFGoKVCj8kWGDnjOvOh
 WbtokyXZ+gkN6fA1Bl2H68tdHsqdQmO/TRjIa7+Y/3DsPo9BCdyb7YzOZQd7JvC4C9
 36X4J8Dtfr5kA==
Date: Mon, 31 Mar 2025 10:50:53 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: of_fixup: fix condition check in
 ft_board_setup()
Message-ID: <TlPBr1xkfRenczU0WcGBv9sE7lK4IE9wywWJpvgAtirzcEYdaEkeLDniq7jwEUvMDpGJfY6u2jiKH6HhafSrTo7OE2S-mjXcvSgyZ2Sxwqs=@samcday.com>
In-Reply-To: <20250331104327.321339-1-caleb.connolly@linaro.org>
References: <20250331104327.321339-1-caleb.connolly@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 0530c2d95ab1b9c0ddfd877bcc22f146ebe2579e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hey Caleb,

On Monday, 31 March 2025 at 12:43, Caleb Connolly <caleb.connolly@linaro.or=
g> wrote:

>=20
>=20
> The fdt_node_check_compatible() function returns 0 on success which is
> pretty confusing, and we were using it wrong!
>=20
> Invert the condition check and refactor things to be more readable.
>=20
> Additionally, add the check for the RB1 which needs the same fixup as
> the RB2.
>=20
> Reported-by: Sam Day me@samcday.com
>=20
> Fixes: e64503f1fcdf ("mach-snapdragon: implement ft_board_setup() for USB=
 role selection")
> Signed-off-by: Caleb Connolly caleb.connolly@linaro.org
>=20
> ---
> arch/arm/mach-snapdragon/of_fixup.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdrag=
on/of_fixup.c
> index 55368dd43b66..588c92c5cc91 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -160,16 +160,16 @@ int ft_board_setup(void *blob, struct bd_info __may=
be_unused *bd)
> {
> struct fdt_header fdt =3D blob;
> int node;
>=20
> - / We only want to do this fix-up for the RB1 board, quick return for al=
l others /
> - if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2"))
> - return 0;
> -
> - fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> - log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NU=
LL));
> - fdt_setprop_string(fdt, node, "dr_mode", "otg");
> - break;
> + / On RB1/2 we need to fix-up the dr_mode */
> + if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
> + !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
> + fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> + log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NU=
LL));
> + fdt_setprop_string(fdt, node, "dr_mode", "otg");
> + break;
> + }
> }
>=20
> return 0;
> }
> --
> 2.49.0

Thanks, this fixes USB peripheral mode on my fajita.

Tested-by: Sam Day <me@samcday.com>

-Sam

