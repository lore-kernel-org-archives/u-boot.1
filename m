Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD91C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA1E80548;
	Sat, 22 Feb 2025 06:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZcMpHqyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18DA8056B; Sat, 22 Feb 2025 06:26:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4838D801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 06:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740201954; x=1740806754; i=xypron.glpk@gmx.de;
 bh=DR744WecCDlH9TI6A/SdMPTCWXbuLRadGE9lXcvmkm8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZcMpHqyZBEeVo85iBF7VNHn6YxjV25ZlZXQnxmTEER7k+9FsvXdiwVCBh9flPcCB
 Eg7QOOq2I+HysZDNNKZHQtNQZPBMlZSvf8B544Qoh+3Zrty6LFs7B2eQOtEncgogJ
 mSQEgmJASS+K3Lm9Hn5puwJ1V6EBEljpM2xFTdRqRZELFJzLB1TZKaodcCh2P2X+l
 uMsdsLbE2oV4AEDRfzteW9s1KUi8j7heaaXBuQetFSO7yblIiR4/NzaZj43RKK/rJ
 8XSZMgHpIL8+rRuC1dc1zkiE8xUylimH/ks4RUh+VKfJcH+3Jb+ubzd8gJGJhQji3
 e5bXkF9JimGFEawP6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1szSy22YXw-00jbov; Sat, 22
 Feb 2025 06:25:54 +0100
Date: Sat, 22 Feb 2025 06:25:52 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de
CC: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [RFC PATCH 3/3] riscv: booti/bootm: Verify image arch type
User-Agent: Thunderbird for Android
In-Reply-To: <20250221125855.300717-4-mchitale@ventanamicro.com>
References: <20250221125855.300717-1-mchitale@ventanamicro.com>
 <20250221125855.300717-4-mchitale@ventanamicro.com>
Message-ID: <CEED6988-8760-4F8B-BDEF-3F3A442CA107@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rb+LWK/8NuTVgZjwOh/N0mtGwm2cnxZRvxSgA08SFvCMhalx4FP
 fFoD4jGYqA8Eew/FS6wFt2DB76Mx/r3p18o+enfXRlPbiF6FTiJedB1OzPKMtGGxYKKzQiy
 Pt5eAF+/4JsEwhETNWMDxGPxM5Fn3rUDMmZGeZxAWPeku4sSAzfynA4sLaZiOy0lz/Kp/es
 jAAVSaJ+1ScjM2e2X0OBg==
UI-OutboundReport: notjunk:1;M01:P0:x6FyxAapLI4=;C+KjeD9NvQIyal73jZ5pRZw0ynS
 8c4gRVhI2hf3ledk/E5myJULME5Jo+3Mr37loQ1V65IBzmvn6i0L/pHxGhEek/sXwSoZjSXhi
 XM2TBlD1N6GWf54RT2yG+48KjHaKioYGjzqoo3Alxc/Idt+PbpLcqCNUaQuWLS525qwliaxRi
 CcMPd6et5fAoo+L91Ef+qi0ZRDhONv6Y+ru6nm8eFH2kcNmCSfRuFAk0G2tmCyGhlXS3IUUdf
 XxKkhumxFrieIeS/fz+i8cFq8tYloriVKAqzoKOv3HYDzJ7rNNnSLWbjC1Q0y77ifWVQz9/OM
 tLvyDscGt45OWrfgz05J97TqAQFTJSDUIPsUc2VZ3uw5lT+PLunQY0ix+zB+heH8Oo7U9KqHi
 WwI3SHBqJDYuJOajY9/ZnrYQIOXvNYcCp2qydPsb1FZzCGuG9AGsEndvsfUj9a6ii4eOx79oB
 w5wIbc2RcsIW3QhFF9drNHufAyF+2BNy9IYLfIR5jK5y+MhlP/2AGy3gUjhtw1HAnEXVqWX8U
 rv4AfLkNfNsswwlPzn9HsZ4ItpP8I7CoPKTO8DLyg2U2q+gRXb/ANzvCXib1Uit9ryttUb622
 6XxfDLUGQCUuiCwkbak17VXL1ljbEOSmBafXLh690FoaIhhuT+zixrsYLWucBrHWtafqCuRyk
 +6/imgpEQsP9n7iXCi/7opljUOv3YVpMhE/sv+WEETzaxHHVa5emlcPFvBIdKK04jZ7wwni9Y
 XqTogFq4ybYuw0A85rG7oZE/VaCpzTJ+ArEfUK1fUOTfndMB4m7lTK541j3O/qN6t+PGjZqTR
 Imn1+vm0AG9FHlZkOI7OHybXfYo8R3CV5m/801FQb5gCIOO8CjatI2XfvRG/bcUiKUXHvG2n7
 XwETCS/30moQxuY2d2Mxj3dMOrGxtaVsmCEsSsYOCxP+PFe3pQNaoEKhgBvFLz6xI5f8OWOjp
 +LCnlfl731HNbKVqPdXz4tCMLoeSE5y+yO4fZSvkF6xqcuLbo22eeXgtk9dfXmNIWaqM5f7QM
 3EqbB+HJqiW/7BMTtEnXGYvW/RLFQ4/8MJU+bfX8Oo9hPZxMcth4Gy1D+JNL+yz+UK2WLcXnS
 1SXGfwJUBMHy+xqIHR4zVimI1NoLvcroX0A/4Fwo9BFi7ev3Yy2+jgEVUWSmtRX7ox3JM+tmB
 9KOo8vVyWO8ZIxidinBhusMCMzEMLqFb2aYaCTnebsN2h0AhOu8nacVwPMOBh2AUAA0fBA7Xj
 Nh0wJaYRXFW16ppyExyJWPinyV3GrRwAQpsAN0SlqO8WxYt0sbpxWzQpDHIir9Kw4/e8BN2u2
 t8k4mOXMJQO7dEnSm8qdcdZb9I8K4Nysb5XXR+6PXOcN6Wh9CSBgPjeZYqOYHP91bdM8p9B6z
 +1pArFDi/oL74AiRpcBptldPiDH6/dfaJ70quCYiiVS4b7xX+r9uqKUsT7
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

Am 21=2E Februar 2025 13:58:53 MEZ schrieb Mayuresh Chitale <mchitale@venta=
namicro=2Ecom>:
>For bootm, disallow booting an image that was built for an arch type
>other than the current arch=2E For booti, set the arch type same as the
>current arch=2E

Hello Mayuresh,

The code change looks fine, but the commit message could be a bit more exh=
austive:

A commit message should provide the reason why you are making a change=2E =
E=2Eg=2E you could state that booting a RISC-V FIT image of different bitne=
ss is not supported by the current code and that you want to catch that pro=
blem early=2E

The current commit message sounds like you are forbidding booting amd64 fr=
om i386, too=2E Please, mention that this is a RISC-V only change in the co=
mmit message=2E

Best regards

Heinrich

>
>Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro=2Ecom>
>---
> arch/riscv/lib/bootm=2Ec | 4 ++++
> cmd/booti=2Ec            | 5 ++++-
> 2 files changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/lib/bootm=2Ec b/arch/riscv/lib/bootm=2Ec
>index 76c610bcee0=2E=2E90f71bee6a5 100644
>--- a/arch/riscv/lib/bootm=2Ec
>+++ b/arch/riscv/lib/bootm=2Ec
>@@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *imag=
es, int flag)
> 	announce_and_cleanup(fake);
>=20
> 	if (!fake) {
>+		if (images->os=2Earch !=3D IH_ARCH_DEFAULT) {
>+			printf("Image arch not compatible with host arch=2E\n");
>+			hang();
>+		}
> 		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
> #ifdef CONFIG_SMP
> 			ret =3D smp_call_function(images->ep,
>diff --git a/cmd/booti=2Ec b/cmd/booti=2Ec
>index 1a57fe91397=2E=2E00921ec4a9d 100644
>--- a/cmd/booti=2Ec
>+++ b/cmd/booti=2Ec
>@@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>=20
> 	images=2Eos=2Eos =3D IH_OS_LINUX;
> 	if (IS_ENABLED(CONFIG_RISCV_SMODE))
>-		images=2Eos=2Earch =3D IH_ARCH_RISCV;
>+		if (IS_ENABLED(CONFIG_64BIT))
>+			images=2Eos=2Earch =3D IH_ARCH_RISCV64;
>+		else
>+			images=2Eos=2Earch =3D IH_ARCH_RISCV;
> 	else if (IS_ENABLED(CONFIG_ARM64))
> 		images=2Eos=2Earch =3D IH_ARCH_ARM64;
>=20

