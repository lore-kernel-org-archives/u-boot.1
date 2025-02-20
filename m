Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE99C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C9E80F56;
	Thu, 20 Feb 2025 18:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l0c6UDc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861F580F68; Thu, 20 Feb 2025 18:19:28 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7A780EC0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso22240795ad.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740071964; x=1740676764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bOh2pNBYGQZ5qcH2A5CFteGYg2iU71Cr+/4qwTLv/A=;
 b=l0c6UDc/NN566+bb0EwyZxELs2NY4F5NEYE58SIxaXTNlchF75b1c4hurYl5zxtXU6
 sEhwxtKnG5QdyGPxuu5JKrCt32G3ipnMfxrOPkscXazIT0HkbshOONzdHT80IncjUvLt
 mCOcJjFGtj82hVnUtBxg1Vp/XmiBkCjSmnx4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071964; x=1740676764;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bOh2pNBYGQZ5qcH2A5CFteGYg2iU71Cr+/4qwTLv/A=;
 b=oqtHp+1pLujgOvnKHTujsycDRwR3GIw3ymOfC/hI5ScWWh34O5PqrBBcubUhbfQW9C
 BY3xC/kEveWJ5+Eu4/iSWsDC+XUc6h6z0viWEy0AQtnlYSVssGt/wpxYKZ6vzwCfybdm
 lwifV24MlqZpws4uZFmhEf9zfqH/XG8yuGuT1wUlG9C0lEnLFkaISRhZEEZDxHW8KpE1
 U5g1dx4PCrEGArvSbeGsKt5A3+Prl4hVFCO7Yk3GqKIQZRCFN5QzN0sKB/i4rLwqQK1O
 oH9xU/ZWgUXd+yA0nklrZ7sVSOXg+T84giOq3mY44wr5f++LsDD+Dm0M7WVf0WBeD/kr
 ztKw==
X-Gm-Message-State: AOJu0Yw/rFTRhdgPcWsCz6UwE1r77b2JiY98FfvN3gWgoVJwXqEN43NQ
 knQdGhNBOlBIJCYojjXaLRNCk8y85FDGnkfPtKju+V7x49wWx+tYN4SVGQjsnj+jXdnisgDEDWZ
 Q
X-Gm-Gg: ASbGncvO7jPi3EGnJ1zb4pXr1hFt1aebi5LJVchL4DGKKNSvLIkRpIiosbZiXRwQSYe
 jDEaRr0aXf0WN8OeVQQ2XJYJLU9Hc48NKPnT2Rfi7MOI8dtb/Y/ZDSGv4hRg/H+8r50Cj/rVmHW
 m613+ENI2LiqvrI9alvel1ErBNcKshyzexd6FrvzdxiY8Bzm4N3m56B0n/DvIDy60nZ7zVuRGCK
 zPxfSVOxOYdAu9F8/ewD49cb71rJlqy71YSusYFdks0zX0Av+K1kRlZo29pOyWlTea2Z96+wN2u
 r0FBeD/MKMUf
X-Google-Smtp-Source: AGHT+IE3mm6KUB5GOXgUS0XFIidXDe2LuLroF2U/Nss/Tt6pQuU/cgcWv1zZAkL00zgOC0a5FmqtaQ==
X-Received: by 2002:a17:902:d4c6:b0:21f:97c3:f885 with SMTP id
 d9443c01a7336-2218c5576a8mr66334305ad.18.1740071964549; 
 Thu, 20 Feb 2025 09:19:24 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d021sm125324105ad.157.2025.02.20.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:19:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250220031706.1196038-1-kever.yang@rock-chips.com>
References: <20250220031706.1196038-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250220
Message-Id: <174007196374.2923422.9005199216344763521.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 11:19:23 -0600
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

On Thu, 20 Feb 2025 11:17:06 +0800, Kever Yang wrote:

> Please pull the fixes for rockchip platform:
> - Fix for rk3399 bob and kevin
> - Fix for sdram more than 4GB
> - Fix for dwc_eth on rk356x/rk3588
> - Fix for sdmmc access on rk33080rock-s9
> 
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/24690
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


