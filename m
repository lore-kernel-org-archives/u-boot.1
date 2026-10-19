Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906B60B5069
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FhOvB6a/;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=IHDWnxzp;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ZsdGtHel
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1AA240629;
	Mon, 19 Oct 2026 15:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFAoh5iSEaqc; Mon, 19 Oct 2026 15:27:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C1724062B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423660;
	b=mEZaNjPsCmRaATGpqc9oAm9knfG5/tlBF/j+3T/0wMDKAfPWgwzSFy4nS7dFljU/C6RH
	 d076JH8gStmv75HujlDZhXpHrsaqJT7O34T5l0G4g08A7JO53H84eeUwAzweCO4dunW1z
	 DpySdk70itiPC1Q+f+morU7eqB0DrkG6j3qU9yQQ4vyoknCw+ts8KRK16h9TDxu5JWRQO
	 ajEyX4a/ALbL0QIdQrsNmpqiziVjeOEATmHh5K3mIofGyqgDDNrfOTzFpOvJItoTqXHjV
	 wt1XOX73WYTWYdShC988HDeWLwmsnJkXHRpA2xPjASjN0bMWxq09bfhdlc/TEADongg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=okdECsTm7aKg1cTPwt2U4AAouYTDAoeNbIJZwbertY8=;
	b=cseqalYdPrvoa6lVpZSV7Nt/jm6KvavJX/Cn8W2o+fUGMYI0uGNqTMTpjydjn4+LjT0D
	 lXFEPVKLrcrWY/u3NKKUBD+ISllMn2SV4mLw2Nu2UIa6oVm74GhUDius+94fpGyO1aJz4
	 MvQgMbuFMniuUX+1xuZcyuWEVdaOFVyiJJZMpl9keJdGXhjuL4XsajUkwDYTh4SNCUKvH
	 3YHTNMeabcsOXPgbCASE4ktNIdF6TOuJ1N2LwFzNSdpW+kvCVHHx0a98vgbGTrkKRQd2y
	 T43EKni1utiDGunArFTLrQ5wWFT083PO/4+z/MPoDKSwPOR8eX3QwJPe4ZGyOFiQSIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423660;
	bh=okdECsTm7aKg1cTPwt2U4AAouYTDAoeNbIJZwbertY8=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FhOvB6a/QcCh06PI6WK+jgCNwT1qy8i3+rgCcEiXsorFVxCRN/ek8EQWoHlZsdXyn
	 CzgeOJr36uTbqvugUNNa4qCE8OFsF0MKbv6X7P1G+YWeGs7SSjWP4rKQ2iR7s39MDj
	 VslP4rYIFn0D27FJUSf5v7TlhnyMflocLub950ta5vcClc+64UpQLUVaGNjkifbzP/
	 c4o3zmFiSDZonmsrDPpskr5dT/QkXlwE4Ku5znIMS9Ki2gRIhMM9Djt9HreAFydM8C
	 hCyiNoEPD/eyvXvEgmTnRiQqLQatoFmqO6aM841+lIoc1GIaltz4p4jdiBi9dMiy95
	 BtJhygw2gUdRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C1724062B;
	Mon, 19 Oct 2026 15:27:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81C4B23F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67971806FF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_S-_W17kbcF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A36C80E20
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423120;
 b=cGk2XKtsRyMaqjajAY3IDsje60Dojz3W49h44UryymqfNW5uubtrNYsCRvNRjUf17ltQ
 9/8BAEdQ8fXCnl8oL5KRrzS0K0CSbDuVSHLxxktIelpRnVlWx2uSwWkPrVJ03IsmYsNdi
 vTNaogfnAG2zbRCr7Shpw4MixIZAPwhBS5t1N7TpXnadW0DWUbAA95gp7eQvt6gc2/Upb
 IlLYlUDeumzeZJhEm9qpEgbEHEoDHv1wlivOc/hi4Q7El4wHCsk3w03i1IQhMjIkliOz2
 i9y+Il5hNQ9xlTiyVGwpw5Iq1R9qP3BwUs1rc5rfrXw2RoPR2P5bg9PsmOdm8V71c1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423120;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=okdECsTm7aKg1cTPwt2U4AAouYTDAoeNbIJZwbertY8=;
 b=pBY/ZURj/i3twCl819peEY6iCnWMff9Rp0wXmB0IUuFQsTe8BWEdNiv/UVewjy3aO9IY
 H5S3tivLv2qBUnsKAzgXKJnWvzUM0Y1V/7P5xkH/k8I1aLBIkwflYtOl7YBzMSk+fiSl9
 W1pqssSoidiZUhr6k0gpxvxJfE+tTy63rJeeJICznq1BV25OrPN4ii6RMHeyP/gy87oFl
 Wtef3rVd+ODjQWCr/1uxJ1Y1Sd0Jinfr3h/cVdPODO5EG3MZE4aqhHbEhzS8rorQ8j4Ah
 /zglo3lwMJNYt47qbKrG13ddV1etEsrls01JjoutF+Zy+apz2frtumIKhLT6rE5AFOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=IHDWnxzp; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ZsdGtHel; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=IHDWnxzp; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=ZsdGtHel
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A36C80E20
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423102; bh=okdECsTm7aKg1cTPwt2U4AA
 ouYTDAoeNbIJZwbertY8=; b=IHDWnxzpCq5c6Ync606S3+Hclq1FU1qOvaBx8xANb8C57mzp4f
 5I49MEnDZDtwVs8mtGUwKnFX07Mj0sQxaat6k0rviehiAfWANF8iOtvGvp44NMrYH/+eEbTI7RG
 9lFhnUa+DPCbmxahF73cB7XyavOzbR//BRMJqKn067FZjNVGfBeohCt5rJ3s7vJQYEl3f3ARn+7
 kcMwYYPTyY+x6OjH2nOdNQ2jXIFVpcJS1vT3Lj0vm/aE/GbATHY/6RKLxKsOT8pajRTnZRpVxWV
 UBsUjoKl9IfSSru5e9G2/zWOLjlJiIlgsiH7/of1W8EqkgZeaJcHT8Bke0SGGMSHInQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423102; bh=okdECsTm7aKg1cTPwt2U4AA
 ouYTDAoeNbIJZwbertY8=; b=ZsdGtHelJ0muzusmS2YqxsNgYKrjO1i9wH5dzPnCB/72zditF6
 N6anaORGnRxLBUMHKEgTO2HBjvksixePeMBg==;
Date: Mon, 19 Oct 2026 16:18:22 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_05/14=5D_powerpc=3A_mpc85?=
 =?US-ASCII?Q?xx=3A_Use_the_private_libgcc_with_LTO?=
In-Reply-To: <20261018083516.49229-6-pepe.schlehofer@gmail.com>
Message-ID: <87BAFD71-4712-47D6-AD90-62BEB295EBC1@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:07 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>The LTO link rules put $(PLATFORM_LIBS) inside --whole-archive. This
>works with U-Boot's private libgcc, but pulls every member of a
>toolchain libgcc into the link. With Debian's GCC 14.2, turris_1x_nor
>fails to link with CONFIG_LTO=y: ld rejects the hard-float members in
>this soft-float build, while other members reference __morestack_fail,
>__tls_get_addr or __SDATA_START__.
>
>Select USE_PRIVATE_LIBGCC for mpc85xx LTO builds. The previous two
>patches add the routines it was missing. This has no effect until a
>later patch allows LTO on mpc85xx.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Bradley Morgan <brads@mainlining.org>

>Cc: Tom Rini <trini@konsulko.com>
>Cc: Marek Behún <kabel@kernel.org>
>Cc: Priyanka Jain <priyanka.jain@nxp.com>
>---
>Changes in v2:
>- new patch, instead of "Makefile: Link a toolchain libgcc outside
>  --whole-archive with LTO"
>
>With the whole series, all 71 mpc85xx defconfigs link with
>CONFIG_LTO=y.
>---
> arch/powerpc/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>index f20d58b4de6..b4883e00458 100644
>--- a/arch/powerpc/Kconfig
>+++ b/arch/powerpc/Kconfig
>@@ -21,6 +21,7 @@ config MPC85xx
> 	select SYS_FSL_DDR
> 	select SYS_FSL_DDR_BE
> 	select SYS_FSL_IFC_BE
>+	select USE_PRIVATE_LIBGCC if LTO
> 	select BINMAN if MPC85XX_HAVE_RESET_VECTOR && OF_SEPARATE
> 	imply CMD_HASH
> 	imply CMD_IRQ
>


--- Thanks!
"I'm not a very positive person" - Linus torvalds
