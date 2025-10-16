Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69812CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 17:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4BD836F0;
	Thu, 16 Oct 2025 19:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ogyp1Uuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BAC98367F; Thu, 16 Oct 2025 19:38:25 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E41B836C1
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 19:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7b4f7a856acso334346a34.3
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760636302; x=1761241102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S83AQMrjZiqRFrg+8y/PJaMGAxy3pHxlttYm7gUpHAI=;
 b=Ogyp1UufI5VuTIQe3w5velJCl84dj1/LNyM8oqw/S0z+t2yzw/yewnAQiWfU7xIK65
 LOSljQ+6XdiQZFG4kDR81nOSv6y/EJ0xZ9oUAo1IGXFKNJe6+BXMf5X+ZqU4brZOViin
 SYxC6L9cjSP/cnNIKiwVgkm/curGAQcr7GGqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760636302; x=1761241102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S83AQMrjZiqRFrg+8y/PJaMGAxy3pHxlttYm7gUpHAI=;
 b=v7mtBxdt5LlJbX8VSHE0QNmWEw0M+YBIzcZBbxpkM6s75suAAO3K2NSf0rmhAzDvM7
 uOvQDAoIej+afXim/ygpOusof1J/G5p46oiKuh6vm7B5s7gOZdZepwnoBKTQ2AtRHEtG
 9YYRHpgHH3QPmSq81jISwEkyDXG87JnkXYa1kTTg4Iz/9qdTcoUKb7uxP+vD+x7dx1y+
 SwEmMSkzZmw650rRgEkhzQ8brQo35lzJqpf9EvuCJvXKG08CvWWlaVrMe4LhpuKCLD/l
 CGckoBbhuW2GAjArWIPQbvmJyQAUddj4Yyg9hNOKuhEGOUp8b97Ze1qNfSjjY6DS1J8M
 92VA==
X-Gm-Message-State: AOJu0YzEjA4rMPia7w9Yqh713zjTS/1rkhZPo51iEyR0VccOPd0StHTl
 fA3HUxBP9PK+vxsuVg9rAnCeW6jK1iTvRLgVF5VvnreXEAU48oDU2d0K9vBJHXXkEv0=
X-Gm-Gg: ASbGnct2Aopsr4DOJVtxMoQRLezaHRN2n7ugfO8oA2yhb1kkA9VXrXlFZyCzNH11Uyp
 N5qPNXWBMeYpieuUQ5gkGv3YybH2/7YsXXDVsKOV/xL0jZARPizV5zkeka+vHUG3sp4Vcr3gdYA
 hpVoncpaCIuvTS+zqtRCA/VpSFu6I6KmvjU/AIvcXKaUgHaEpF+gw1IdyaJTPuFxSfhacWHJ5TK
 3Ybx49WrxuYlw5FSEZDo00GL/ldJGrEy8fMX+g/uCoPTuCkpkR4w0hPuWj4adV4YcQXScNeY/Ob
 yiGBkq9J4XrnX9ebCiFIAfkDZxNUy0U/IdgxEB9bJhSZ0hCGhkcFI1iIC1QZhP4XQM6zNP2Nn6e
 R1LbwUM3tOQ4ZaYkP8X8nGrY94xKGliR67nI3O73/ouj/UFYupGQbAM6hF+V26X4r+m8G2IRbW8
 i/4b/FjkupF/0El8GzktOKSAhQpl/wPD2XSyqJXwHMfJVhEMcw
X-Google-Smtp-Source: AGHT+IE0kTIjbTU5WzRce/sIWOiWnhMoEHZPJqRwGBM/Wp8q/9qjCFT7fZfCio3+VSrYjYALCNzwlA==
X-Received: by 2002:a05:6830:6d0e:b0:7c2:736f:ff98 with SMTP id
 46e09a7af769-7c27cc05050mr296535a34.30.1760636302220; 
 Thu, 16 Oct 2025 10:38:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c27a206ac7sm335079a34.17.2025.10.16.10.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 10:38:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <bef2d7bb-25d5-4d41-821f-6aad1f565c95@mailbox.org>
References: <bef2d7bb-25d5-4d41-821f-6aad1f565c95@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/master
Message-Id: <176063630118.212270.16579390578025899998.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 11:38:21 -0600
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

On Thu, 16 Oct 2025 14:34:48 +0200, Stefan Roese wrote:

> please pull this batch of WDT Kconfig related fixes:
> 
> ----------------------------------------------------------------
> - watchdog: Tighten some driver dependencies in Kconfig (Tom)
> ----------------------------------------------------------------
> 
> Here the Azure build, without any issues:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


