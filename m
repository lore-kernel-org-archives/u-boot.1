Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14225C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 19:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2D828BC;
	Thu,  8 May 2025 21:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="e/LsU1DF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A4B828A2; Thu,  8 May 2025 21:09:39 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC7D8211F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746731376; x=1746990576;
 bh=9EOsIj1Uup5qXppdZNPIHT8ytQiw4a2Kozv0kl5e4Xg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=e/LsU1DFjfY4hkxfsJR39FmpsbGo4GsnuGR4hNhlX4VGvXIRMv5aUVVp5iqn5ns3i
 1+0D8Wut5+hGdlf7uXagHHJZ0kpuIS9b79fs/mS0JwciJtRPml1+z1FDw4FKLFJOCU
 x0N1fGdw8HkgUOJ96qtkaG300yTGWirmDkzIBwcKU6VOLSKgRCOTmR3Hdm5/wApf5H
 Lq3uiBIl4qMqOYZAQxk+XQFWBDE2HIEwAsFQEt2xugPeTBq0g0t6hPtLa1hmDKSBfa
 fXoBLyC92RxHnN7ZLAUg5Woc52GlmjkyLnE9W+yahNoA58H6eP0SsJv8C4KUVB3OY6
 L9t+O5nY7YUzw==
Date: Thu, 08 May 2025 19:09:33 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/1] arm: cpu: armv7m: add ENTRY/ENDPROC macros
Message-ID: <a88cd4e4-c558-4fc3-86a5-e25e581d7b5d@krotti42.com>
In-Reply-To: <20250508185943.628503-1-johannes@krotti42.com>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
 <20250507225123.GR5430@bill-the-cat>
 <20250508185943.628503-1-johannes@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: cec93c9e620c7434afab25e1d7ba266bfe345bdf
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

Hi Tom!

I have tested the patch on real hardware and it works. But have
must add an additional board which is currently not in the U-Boot
tree from STMicroelectronis. Maybe I will release a patch series
too.

On 5/8/25 21:00, Johannes Krottmayer wrote:
> Since GNU binutils version 2.44, assembly functions must include
> the assembler directive .type name, %function. If not a call to
> these functions fails with the error message 'Unknown destination
> type (ARM/Thumb)' and the error message 'dangerous relocation:
> unsupported relocation' at linking.
>=20
> The macros ENTRY/ENDPROC includes this directive and should be
> used for all assembly functions.
>=20
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   arch/arm/cpu/armv7m/start.S | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
> index 0c07f2140c7..3355167b3b0 100644
> --- a/arch/arm/cpu/armv7m/start.S
> +++ b/arch/arm/cpu/armv7m/start.S
> @@ -4,13 +4,19 @@
>    * Kamil Lulko, <kamil.lulko@gmail.com>
>    */
>  =20
> +#include <linux/linkage.h>
>   #include <asm/assembler.h>
>  =20
> -.globl=09reset
> -.type reset, %function
> -reset:
> -=09W(b)=09_main
> +/*
> + * Startup code (reset vector)
> + */
> +ENTRY(reset)
> +=09W(b)=09_main=09@ Jump to _main (C runtime crt0.S)
> +ENDPROC(reset)
>  =20
> -.globl=09c_runtime_cpu_setup
> -c_runtime_cpu_setup:
> -=09mov=09pc, lr
> +/*
> + * Setup CPU for C runtime
> + */
> +ENTRY(c_runtime_cpu_setup)
> +=09mov pc, lr=09=09=09@ Jump back to caller
> +ENDPROC(c_runtime_cpu_setup)

Kind regards,

Johannes

