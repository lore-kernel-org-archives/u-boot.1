Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DC9C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 21:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B0BD606A6;
	Mon,  7 Sep 2026 21:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOlmFCuBOR-a; Mon,  7 Sep 2026 21:24:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 799F960690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816254;
	b=YhSe/+6jZ16OBxaHAWQQx1qdHNW6NmRukp57rrhm9EC2n/OtA91swKMROG2J/hNnfN/Z
	 MCYoysgBYJUfLVmTE+njDOpo83YjQIdm67zHit/LhCuMLdfTUAlRSoPdYPOkeQL9xXr/3
	 RyxVgVSzTQL8SfMUdE8L5q6/JOZla4GjSi0EDsdtkZWtvLtqswGER8OYZh69a+iI2IH1t
	 8wUBVA8maTN4PjJtUs1o8JDEntEu6/RpRUI2uJV3GUwoI1wDLyvq7HZ3OGCZjiknxaQLX
	 GibTaEweS7idKPAiM3FhPkbOIIncu8ZcVDBoDjJpDJdrHzRF4+NFxj0Y9U1ZSRCsC3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788816254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t8/QKxuYIOAzM8iCIfe4Rns8kvfQlzsdhBTdAeSDhlY=;
	b=QbxKkjAaC7djevb8Yy4BngPxq4D0VO1jFvQ6i2zm5GqZewnoL0IN+zMsdfX1d1cMnsb4
	 rl/z8UM4XCd9PltpVPa+4i9KwaORK6zeimeqswGsENaGg6r3SmiDM/32mryYmsfBZtk/f
	 FpyFqVUo+q09RpgUjJGs+ZR8C1Xc9XfrVPA8AZ8kvvnxilKeP5ZiXXeFpSzwITYSpIIuk
	 OUZpx4Wg0wkkUpFRMgKv2zeJ1AueHmEcYBgF7qtlcMSKyXqPLV2lMKUbQaKyCymPzDYx9
	 Ztp/EwTg7hn3Zn/s76qtEFKB5QeMb+6HJF1WCyLQMBEfb8npxB165EOJuLliOkL33SA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788816254;
	bh=t8/QKxuYIOAzM8iCIfe4Rns8kvfQlzsdhBTdAeSDhlY=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kRgqI2cLvlSpNIztdiiNkvAv6JwosvV9Y+b/wMhVWPzDOprlDNo+rWnZ9fz0FUk4X
	 eUkO1yGkcfiiJcnFxp5CbaNwGmp54tYzX0RlsxII8uq6WgR9QutbUZ+j/fXhwxCfsR
	 w9FbV+Z1j6ELRIzcjqKKzQEpPqzLm1s6L5L8ky27Zf1bVZeXf2l7nBKTtDmnMB5ZaU
	 rCQi2LmH01VhUKtH91ig2LMa//J8UR7A8CtCa8T8bn7Wkxd+DJi15Ie7glqrT09gPE
	 PDcHytBbQz9RJlBtp2BcyFnQ+S8lRiWCI0EcSdRGAbYuronzJ5hJFzcWsFVTgQSoo8
	 g3EyYI63FJxbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 799F960690;
	Mon,  7 Sep 2026 21:24:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F37F0AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E50C180849
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_U5N27nXZnj for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9B0648083B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788816250;
 b=H5vGCP8ARXCe/Boec+yoGD6WEmZgfy6iA6/KutKoqHArjXeibCuVdx8zB0RNfN9V8Gv0
 8rmny3ZWe/U+y+ITVcwANIZAi388VlhrgQ3wz4shQZd1jOBxflZl8yiUVozRdehX23iL5
 yFBTG0p+Iip1cwDSSuKuJaIoJXtT0DeiHvtXHhngs+wEwsxdQt/zvUJ5Q62fSy2Q29CN5
 C4Hg9NGCogAfdt2+HJOmIR4EPArgPStrRJOhzZsm/OxOKgA1reoHMhvrDspy5QOl6h+5e
 t3OQNWAVaQ1O5FSOS1WFPIWP3jlof0Wf2yDkd9Acbilh0WqR60jSuFCbL4sWg4HO4qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816250;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=t8/QKxuYIOAzM8iCIfe4Rns8kvfQlzsdhBTdAeSDhlY=;
 b=gXnLNRZB1JRQwz99uf3McQiU4/1mWCC6h5o5eszWpqAiq+/Fy6MzpK/0J+fmQa+cRc1b
 qgPkxkUH3LKi6tz2CmJKAMHTV3zRsb6WyiXZWcZlw2WUmAHO6gi+chD0v5uXkvnz+wwE7
 dcCCNju+I/ZeHwdrRKHAiYu7kzus1Md+0Sk01AR53GCdkbH52fiMa0NLC6NYK8oAhFWKR
 8q4DBpPJyxqW05t8GOVLOU3gClxynQum1f1N/tIdygFLjTn3QKNdmddJKjaYmo0twb8nP
 8D6yKD/0ER1MTRw0NqfzRg7C0mWVLvru1Bqir7UZb0o1PA8TIR/o3WbaTEQ33MjAeHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=Vsn4NlNQ; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=Vsn4NlNQ
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B0648083B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:24:09 +0000 (UTC)
X-KPN-MessageId: 73fb101a-ab02-11f1-861e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 73fb101a-ab02-11f1-861e-005056aba152;
 Mon, 07 Sep 2026 23:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=t8/QKxuYIOAzM8iCIfe4Rns8kvfQlzsdhBTdAeSDhlY=;
 b=Vsn4NlNQ0LicBFQ/FmZozdaC3WVpdt1RCoH62akC5p1GsEmk09ztKeYvusZy5kMbC0xeVdR+Ps45n
 hEe6rwR3iVwHm6mCCM47gayVHsiHxZRLaXmkkXEWUsGdm/PaVmQBYiAaFvzxs23rxTFkXJwleC2++/
 AXE4NElt0Kfo5oghLHADR65rzpLqQcNOQz3ekvYtm0ppVmf6Z+QfIBmukwXcWb+3r6919AJvGmgouS
 tdc2gpAdQXUcnRpoXU3O9Fn3vB+1kgD0YtrKcyWxpQcqiObaVU5Kzc4dAGhmjyvDUznlhT/AebSm8d
 9yLYkOxLZDxKTvYRzKLF/gj1cd1gfKA==
X-KPN-MID: 33|58FeQ0QsBK4ag8bnEtJV6DGJ0dmwgBKvUq4zrar62q8ogsAAQfbEUbrLHW+HFE7
 42IpljMX/DEeFP+kpcZ6dvpLMn7ovC1PSo0TG5+T4oy4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|YavA8tLVNzCQAUz1y+7h9DcJLrV0K4uzcy7Fc1dQRVm9HX39leu6v6wLbF2X2EA
 2KSYM+yABU3fMDhuEddo1DQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7383ba93-ab02-11f1-9281-005056ab1411;
 Mon, 07 Sep 2026 23:24:04 +0200 (CEST)
Date: Mon, 07 Sep 2026 23:24:04 +0200
Message-Id: <87pkyosqkr.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, asahi@lists.linux.dev,
 kettenis@openbsd.org, sven@kernel.org,
 neil.armstrong@linaro.org, bmeng.cn@gmail.com,
 trini@konsulko.com, fberder@outlook.fr, j@jannau.net
In-Reply-To: <20260904-apple-nvme-fwabi-v1-4-f7ede661c469@jannau.net> (message
 from Janne Grunau on Fri, 04 Sep 2026 21:22:42 +0200)
Subject: Re: [PATCH 4/4] nvme: apple: Drop the PRP null check chicken bit
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
 <20260904-apple-nvme-fwabi-v1-4-f7ede661c469@jannau.net>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

> From: Janne Grunau <j@jannau.net>
> Date: Fri, 04 Sep 2026 21:22:42 +0200
> 
> Now that we program the DMA direction correctly the NULL check that used
> to make commands fail passes. Another side effect of this bit was that
> non-align buffers on the admin queue were silently allowed and that's
> been fixed now as well and we this don't need this chicken bit anymore.
> More importantly, starting with the firmware installed with macOS 15,
> which is required for M4 but can also be installed on the previous SoCs,
> the controller no longer exposes this control register and any access
> SErrors instead. Just drop the write entirely.
> 
> Based on Linux kernel commit 8ce883fd068b ("nvme-apple: Drop the PRP
> null check chicken bit").

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-6-bde19ce8db04@kernel.org/
> Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/nvme/nvme_apple.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index 54821f80c81..948a56e518b 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -26,8 +26,6 @@
>  #define ANS_BOOT_STATUS		0x01300
>  #define  ANS_BOOT_STATUS_OK	0xde71ce55
>  #define ANS_MODESEL		0x01304
> -#define ANS_UNKNOWN_CTRL	0x24008
> -#define  ANS_PRP_NULL_CHECK	(1 << 11)
>  #define ANS_LINEAR_SQ_CTRL	0x24908
>  #define  ANS_LINEAR_SQ_CTRL_EN	(1 << 0)
>  #define ANS_ASQ_DB		0x2490c
> @@ -257,9 +255,6 @@ static int apple_nvme_probe(struct udevice *dev)
>  	writel(((ANS_MAX_QUEUE_DEPTH << 16) | ANS_MAX_QUEUE_DEPTH),
>  	       priv->base + ANS_MAX_PEND_CMDS_CTRL);
>  
> -	writel(readl(priv->base + ANS_UNKNOWN_CTRL) & ~ANS_PRP_NULL_CHECK,
> -	       priv->base + ANS_UNKNOWN_CTRL);
> -
>  	strcpy(priv->ndev.vendor, "Apple");
>  
>  	writel((ANS_NVMMU_TCB_SIZE / ANS_NVMMU_TCB_PITCH) - 1,
> 
> -- 
> 2.55.0
> 
> 
