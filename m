Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAD1C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 923CE81097;
	Thu, 30 Jul 2026 13:38:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5SWTCa_hJWT; Thu, 30 Jul 2026 13:38:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D262B810C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418733;
	bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HO1cS3OvuRClrbNEarhdmPmp7kMSoaRjPcVhSP+s+SVVXN+aWWR4Dp3NjF4fM45dl
	 E1RjdyQCL/G9Yypopuhlgxc7dJU6ReF1NynPHHK6eRhKMI/6AQQzuRyRoj+hBCBsoS
	 P50dw51b4TPmwabS40uxW9c1KNMBv5wdi8/vC6EdS+brXy1EtK0Qt11W9ZfqgR4TET
	 VrNI7Dpiyjyc12YfzKbH5qo3yjbgcZL/Yjd8xKQakrBSeVZ//bsqBn0gbY+2S4CsXX
	 kZLzZncrAJ5oJZonFOynxYNmDXO1x4EH1hET2rFnvWqQAZGgOoJlYMD/COTHBqpURE
	 CWzHxE9MrUZVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D262B810C2;
	Thu, 30 Jul 2026 13:38:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BA0669
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0694740AF0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDy6Udw8vTar for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 43C0A40AEB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43C0A40AEB
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43C0A40AEB
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:46 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7ee4f241f42so626519a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418725; x=1786023525;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
 b=mkyTqQzsVbTqMFvWEKWpMpNdk3l1zlZUs93WZ7YHHUCwzd9ZnleGXEleJ2dkR+1bcT
 nwOYK6266staHDple3nAAum6hhHpntmN1qFM8i8AKSuaZbhQUtSK4cC9LhB9pMb7dnYZ
 9qHWmhWU/+ZeRpdWIuzZ1E3TRP2eEWfriAP+BBleLLqaEWqjfA0FwzUv3zNoX8CUI/pX
 NUL/jx1fVkUU0xr5DBFbqY9vFxrH/2h3Vu3uohB5uZX27AoKpBODWUWBREl6OxFNM6Gn
 MPSu32i4kysYvmJLhCuYw0iRqMYsvyer3ERnJq/vOJK65KfNxkqv7uNKENA3xKhfzGht
 qZfw==
X-Gm-Message-State: AOJu0Yz5r29VDRpbatO7zrP40T0hBGAwG2KzAMS/EhHCEmrewWCHqFUQ
 RDsTCJHTpI8WwPY2YjpirSZsftcTvhRJiAS4ZbNEZBMB2eooZIhN1a2ZsMRBnwjYIQo=
X-Gm-Gg: AR+sD13RBz4BLFV4slEZBE6dpaZ7sbwOQW84kpVBEU0KiW/MtHPhtIxiAgQXZxwVuNa
 L/So21PBsqffzyLO25URd31QX3FDhzarMlJXRh2/tPgv9VTRlsLNKhz+YnF+drE6Gb10BBsKHE6
 OMp82u/Cx1bB035MKhA4RAlA48hSE6IKfnrPyJupbzYMYDLqFvAYHjyl9tdnweStVUpnajsphuD
 peSqx0U1tRUriH3PeMmLyok7Do5BfMHyxO0z8pIChSSV31jbv3kdzJzwsZmYMhjJ066GGOIU35G
 gTPEVzEK6KmLTBDl14D4dF/xDR9p3Rsfxk3hP2pDrwbqfIn2iv8Az6UtBjX3lMj1eTyN/8wnvrb
 Sbp4T5hn26YFPzNqfxfXRm7u8Y6CvvzgYc0+NhcQd+kZSZO6jP7TbLIfi44+oNDuTAtGG/FKMwe
 Mx5n0FLO18rT1YM3Ejf/BliKJro6yH/oDhI458zRObcUwXJ6dHU3ZDQrlCXjEnd2Yx74+h+z6jX
 eXBEOpJ7lwKTXrVgkpbfzwECj8ISHgI0tYAtfcZrao7K+CSF45YHkkCE8x84Sy5g/PR2qsbXQgQ
 XzWol8X9
X-Received: by 2002:a4a:edc9:0:b0:6aa:da90:8baf with SMTP id
 006d021491bc7-6acd24677c1mr146586eaf.17.1785418725151; 
 Thu, 30 Jul 2026 06:38:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: malysagreg@gmail.com, linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <20260716122649.646-1-Caleb.Ethridge@analog.com>
References: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
 <20260716122649.646-1-Caleb.Ethridge@analog.com>
Subject: Re: [PATCH v2] arm: dts: Add SD dts for the sc598 EZKIT
Message-Id: <178541872373.2173019.9984368036382916013.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418725; x=1786023525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+/mtLWnpvaKlgzTb9e8BfiXNckpJ/cvKs/+yTOPna4=;
 b=VvydAvaSa7OzsfN2kDcaVNRis7L5G6XvQKlRsJMmK/AuRTCrRnEGliELAlohQQieuZ
 bbEZk16Z4swK89Ai+l9HLMn1Zf+wlZB86Tmu+cFoZ5fMTenbSXS2ZInVWALUVJApP51d
 9w7YFkewoWA6GcG4jGZGT/3HXaTumwpWayhAI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=VvydAvaS
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 16 Jul 2026 08:26:49 -0400, Caleb Ethridge wrote:

> The eMMC and SD card on the sc598 share pins, so they cannot be
> used at the same time. Previously, this was managed with a patch applied
> by the relevant build system, but patches are brittle and have to be
> maintained. Instead, they have been replaced with two separate device trees
> , one for eMMC and one for SD card, which inherit a shared base dtsi.
> The build system can then select between the default device tree which
> enabled eMMC or the other device tree which enables SD card support.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: dts: Add SD dts for the sc598 EZKIT
      commit: 1a86b8764f8fc13599faf247b4d2f78b4fc6cd3d
-- 
Tom


