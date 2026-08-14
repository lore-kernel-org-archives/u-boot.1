Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E55C5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AE7840DBC;
	Fri, 14 Aug 2026 13:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOp8h2SreWBg; Fri, 14 Aug 2026 13:51:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBF8040DCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715481;
	bh=Sr7LB5Tkd7hjjFiawT9WKcFss7jxY+94Z1TwdTICdzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SY3JFGhO2+3Ve/5WdfKrw0bPiSnf4gzNddS5AzOXDe48ZC2F8u6pOvh24qaDlLsSg
	 7sPCdWiV1l5UXHUW6kuhueJMoDympruswYYCYce4vRw4nJCP7Mti1GVma+2nwKqRxB
	 QZ0PW5lubqn0+XjQtV7sivH/FgHzEmfYfOj0hLoF/HjDOgWrPGX5rhR/528HnYrnp3
	 KRYvXwHuqmvT5DRjrRQNejcwrIdJ4ftZhSNKnHMgDY2kYQZc2+NlB68MNmhI2N+4kT
	 8ltdLX5TDHZ75EHlsII5z//ytAg55QvT7LUAjTUHSnCswm5uiJsmkNpHZ2yBBx/KEh
	 j8MQmFBXp42bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBF8040DCB;
	Fri, 14 Aug 2026 13:51:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B240361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F170A608BA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uGstEM6_X4P for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D14D60626
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D14D60626
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=V62vDzbr
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D14D60626
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:13 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6acc2a10023so578050eaf.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715472; x=1787320272;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sr7LB5Tkd7hjjFiawT9WKcFss7jxY+94Z1TwdTICdzs=;
 b=V62vDzbrpnT0s5nSMOMhDoPdArWxvIpMdlaONX0ZjlgiP3hZPamDVaJwLEcLjHwD5P
 377iOVF/xaWUyt73iIPNZdlvBbXeawUv//bk1NQPgZc+5cHyLborSA3H6Cyc2fCjjzAk
 /eiTZBVYPAFdgDDYvPykKiyO1jEeTeYvgjT3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715472; x=1787320272;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sr7LB5Tkd7hjjFiawT9WKcFss7jxY+94Z1TwdTICdzs=;
 b=rxDtp3VyXNqY3elhqGKcRiD/1WTzxy+KylwCWjJ0CEnYoNUzHWM1yRGdvePEHrbMac
 QzW/ezFuXOv2B0dfyLo75YBr+lKrut/2eTWthS9AfbwumGinm6MsVQLuuApFBi+HU9lV
 WYZ+oeMLgT4/kQYVbQvwES3496nduuv6ugB5F+FPAfCQTP1bxeKflVvyk3hWyTbDX+nR
 wFsqZhimI15UyApAt//0LTpIbYVWx7lY5VIIgSMp8cEvqnvzmu9RXa9JB3DX7Q1hdNSZ
 GQAJAdBXbnqWO35d4MdvZDPPFPRGtzQ8LHdUhBPljIBJQABO7CMMvpqEw6TB2b4/qZz1
 /Vmw==
X-Gm-Message-State: AOJu0YygRmYmCJu/uFXqRdHZ3Bqeq2fq07fnkGfgmh3tQL51Jl4bnCvZ
 LGVIxS3sA0cNJEdckt8/z8FwUQUMp71hiIXd4mhExhaYRMpDUlak6AeyG5RwYXZ204Yi5nnS3h3
 T8BDC2WM=
X-Gm-Gg: AR+sD10MNB0tv9cy7aV7vKC3dkDQrzG8H4Y37avfnGx0Ima2kZEZ7jGk9VE01acxORl
 BndzbsP179tVSjJNlFW9V3SUx2xLJMxv/bLSyMsQo4s6145zJmaVYQMI5NIp09e7LcnllzhZZ7u
 gu6uBaVsYRn4EaCzxQwqy7ofM1MRpI2u6CcbGBB6UyvErvT1S2lcr7Dx3QcmJptpyk/lY3R7poS
 LvjK/ffaCOjODZA5bzJeAd3l+aCwuyG0q+2Idd3EY0WcjZpHajlbeAwggFcHRGp1EmLwlItJCHF
 rHNiMtGmnBCRGhpDgvs/9Pq2R9R8tvt7NOk3ZXsMsrVROudo9o8wQV8jJtr7XbUnNePqTEaCGgH
 fxymxdoh4lvrVHhWgBFiIJxWypJKGgM16zdUBPLzVXGkxJXf3QIvzaU4u0RuamC356r1glk8+m0
 FtAfNRfUPDRmyv0VaSDaB+xpqs70M2FpT+eNu6s/M3j7CUeE8eELniZrVo0/6kzZ33x/+YxQFzw
 6uUCRlyaeVwZ0rCXhV/WS2U9SitjCZn3LJdM30D/nkgExj60YIFRuoHoDbQfqbkdcsSgOKJmNGZ
 xRUediwq
X-Received: by 2002:a05:6820:1513:b0:6b0:ac70:f741 with SMTP id
 006d021491bc7-6b0d690bfc2mr4606731eaf.28.1786715472057; 
 Fri, 14 Aug 2026 06:51:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: malysagreg@gmail.com, linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <20260716122649.646-1-Caleb.Ethridge@analog.com>
References: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
 <20260716122649.646-1-Caleb.Ethridge@analog.com>
Subject: Re: [PATCH v2] arm: dts: Add SD dts for the sc598 EZKIT
Message-Id: <178671547110.3828101.11134436842548673624.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Applied to u-boot/next, thanks!

[1/1] arm: dts: Add SD dts for the sc598 EZKIT
      (no commit info)
-- 
Tom


