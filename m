Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26352CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FDA83FB0;
	Fri, 10 Oct 2025 21:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ug5gklZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D334B83FA7; Fri, 10 Oct 2025 21:23:21 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE8483F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6497c23a47aso694371eaf.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124198; x=1760728998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQvUOOR9lRAMW4g539oRTs06ud84baM7GXhx0Rm+C2k=;
 b=ug5gklZlV4reAnCJTwtTw2pE0Hr8Uqtfh98qUWxUtxIkJDSzTomPkblexjgdfOYKSu
 1SQ4/7eQr3nTlRFH9ggCk1V6YX6ZkLO96tvV6jbZ88smYQgoHw8kZnvEsrQYnZ/t68Mw
 +8LSJg67yCYgPWH1TYP5PsyhFptxeQHqVnRLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124198; x=1760728998;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZQvUOOR9lRAMW4g539oRTs06ud84baM7GXhx0Rm+C2k=;
 b=uqeBeZanGUvF4cRNCy+e3lVxKtEPEVWxbaOIUWALpI5g9h1pGBPAXOWFPS1D917MO3
 nXcdLH3uV3XKOazuTRcJJX2mZR+LQV1yvLVZLYYXTuLFgV0pBciq4RPOUej87C+SBLlN
 gTxfWWOKt7pbBry3DnmXZkuNC8FTheXI56w+xjYdsHG5QCWiRmlGAAbExs2LcaLN2wz3
 FpF2CBUaVOsO1ipkytZa3OKOBflZz0rjNv1sHTNeChjleBXC4Y8srXCxdo6TeP63VhKY
 nfvlnpFJDYmWilm0QpeiOQ5AjfPBIu1gSNqAVcRqME073ZF1F3TRe3K5s4yMSWVQm16g
 Ts3w==
X-Gm-Message-State: AOJu0YxEPhOYixVj3Cht98Acv/bvooTlFcu7WTQJTLbOxra7EZCzJ+iC
 CXn8dw7xvdzOuCnTrjlL/AuSmkK5cc5GuUPJqSeICFzqpohc5Byy2x+Qi4MZccNA2F0=
X-Gm-Gg: ASbGncsKHq+VeMV715VMBq73rHCQPmfi5XbOsgn+MIZZuX5VC0nwLiJWwbziaZDMBZ3
 X8hBanBBVFp82R0NtembF1A2wQSe7J/zzdUeI2x+gamqI5P2fkfyqbahM9aVkMRyrdxZM9xGRBZ
 AR18O21DFjOrXCKpxqJL5jJF4YO2qdPGWEofYPPDKHVVumQxzxS0h6XgzvRN874tkA+XVkyxXzE
 GyabrQWw8Etnrb1fuIX0LrtMrGvifqalTFu3lWzKga5gLUtCUEf5J2g9NgmYoK99lkibC4flp9m
 pisL5cFIcyaYkI9n8qpl5WMfq6QYhiUZBRTzif6/0aIvaJqIAySLAtzkIbw4kxwBUzs3PspjBcz
 XI9G9lx+GQpwYK1tN5A2jl0mLfEk1zEgVRZ2NsGWzabvAZ4qARLWQMrlLm3nwVaj9vBaBF9G4IW
 JRfXY=
X-Google-Smtp-Source: AGHT+IEEtx9bg/2b+eg6Z3n8YRj8ZUzpyydW5m0sjWCpXzTH676RXpi9FvRGT+/94kakJTc66NFo5A==
X-Received: by 2002:a05:6870:414d:b0:322:5c2d:58c9 with SMTP id
 586e51a60fabf-3c0f6d27fb1mr5342236fac.24.1760124198513; 
 Fri, 10 Oct 2025 12:23:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: a-dutta@ti.com, marek.vasut+renesas@mailbox.org, afd@ti.com, 
 n-francis@ti.com, jm@ti.com, p-mantena@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250909044816.1670246-1-s-vadapalli@ti.com>
References: <20250909044816.1670246-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] configs: j7200_evm_a72_defconfig: Enable DP83867
 Ethernet PHY
Message-Id: <176012419738.1180358.12438111095600230276.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 09 Sep 2025 10:18:15 +0530, Siddharth Vadapalli wrote:

> The MCU Ethernet Interface on J7200-EVM uses the DP83867 Ethernet PHY as
> described in the section '4.9 MCU Ethernet Interface' of the J7200-EVM
> User-Guide [0]. Since the config corresponding to the DP83867 PHY has not
> been enabled, the Generic PHY driver is used. As a result, the RGMII delays
> do not take effect leading to packet losses.
> 
> Fix this by enabling the config for the DP83867 Ethernet PHY.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: j7200_evm_a72_defconfig: Enable DP83867 Ethernet PHY
      commit: 0a71fe2805eb8c8b1ede9525a28810266b77bcd7
-- 
Tom


