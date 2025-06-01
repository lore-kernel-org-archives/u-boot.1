Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A978AC5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4527829F5;
	Sun,  1 Jun 2025 17:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qQ1J9FVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC5982A0A; Sun,  1 Jun 2025 17:33:50 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391D6829E7
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4033c70577fso1977469b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748792027; x=1749396827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R2k4A0f8TgWSiEcGdnqzNxAZmpPkeipyVLRSqt/hixw=;
 b=qQ1J9FVbdS/jRj/lWwaE28F/yDZi8kx1avuhKHjB/gsnLmeS6784yM75RCP5GuVGYn
 tNDQ2FAjBkXhoXkaG/uF390MskBfc45U7mGQGZy0dLZDBTajuRLPK9IdrA78TXjkKehn
 G7x3hbnsWiaoqqtfVtZ+IYeUYG4F0fg3hy3jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748792027; x=1749396827;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2k4A0f8TgWSiEcGdnqzNxAZmpPkeipyVLRSqt/hixw=;
 b=hPgXNoO5VrJ8598aOp5K70aYZM730OhKuY6ixfPqCe1PIPpALX+bJlgcfnyMahdVDL
 yliKqnEfdv2gA5lpWR2V5ARmbyzO+LJdHsBQH/B91fyR5kiHrFBFfXQy4IOA0IMKhwDB
 SflVcw+EsrtzrJcKoxPVaOTVKL9Q2sWthV/uZusOdlqNFnv6NOHwhoqvOkkW3zKzkCY0
 Q8gxk6ycbRNW4BceT2a61jLW48izZhVO7NxyWYZjbshToF0ypvolYZtiGTzY5b0nYM1Z
 /YEUgLfRgHGuRn8nQsu1iT6BEzmBSqUQTccOirN7fPkwlz3od3vkE00+FVRlGu+HLL5k
 ADwA==
X-Gm-Message-State: AOJu0YwpefsaYiuAH2igzqeGMmNTy0SZZdBnS8yKAGGbQA/nHechJSPp
 dYvu2rNzQjUT08zDY2skhNHUHPYPsHt6mbv4qkCzkvsj2Nma/gDgMVp2ZVoE3DgiXfDGMsFsXPy
 UzhLFxuM=
X-Gm-Gg: ASbGncvSbBQ7wIFyC7SGqDZRFVNuXvpfqN8I2NndzDuOISh9BhLD0vmWE7yBiC2HX0E
 bAAWNX67PyIjg01/3sNNdheSUqMDewKsdeoRAPAE2RxGEUMo34cBISDZrXkK+tO7/MSq93uJqTH
 i5hWE+KiSn2L+cd/c+DH7wNvqY1EHh/n+sV4LIUY+E+mMkw7baowv8zkR55pdrkW3qCzLhU534W
 QltFkV4s7z4MymS8Kf3ZZImeX1uFrvJ5HZSBTbMIAOpaFkMauKq7eOKxRxX8cAYWqzEWUt0f7FJ
 H114mqArx/rEu5LCTmL3T4Yzx+KwCrQ5ggZPUYKmZJpQ78Ia9K2TThgwYaj7yefXy+E7iT1vs07
 RAUFo/xaMfC0=
X-Google-Smtp-Source: AGHT+IFGKqJQf39TAWZIMg7SbeK6YaG7++FL0hUoXPWbC60GTgvzZeYhi+UM/sK2WUHu3tEfvicPPw==
X-Received: by 2002:a05:6808:6410:b0:406:6671:6d30 with SMTP id
 5614622812f47-407a653dae5mr3057395b6e.5.1748792026930; 
 Sun, 01 Jun 2025 08:33:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c400e1sm1132764b6e.23.2025.06.01.08.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:33:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTi==8DGQfUkPhdm0wBkKvHmh43R2+kzPH2LLkMC_ac4Kg@mail.gmail.com>
References: <CAFLszTi==8DGQfUkPhdm0wBkKvHmh43R2+kzPH2LLkMC_ac4Kg@mail.gmail.com>
Subject: Re: Please pull u-boot-dm into -next
Message-Id: <174879202529.1104969.11353794461353175362.b4-ty@konsulko.com>
Date: Sun, 01 Jun 2025 09:33:45 -0600
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

On Fri, 30 May 2025 12:54:41 +0100, Simon Glass wrote:

> This is for -next
> 
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26422
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=80&view=results
> 
> The following changes since commit a619c4410956f446510749b6dc3989849616b7a0:
> 
>   Merge patch series "Enable env in SCSI" (2025-05-29 18:36:51 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


