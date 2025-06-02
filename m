Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7743C5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD99382CB9;
	Tue,  3 Jun 2025 00:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cpHr2Ted";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90C782C7C; Tue,  3 Jun 2025 00:36:46 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1C382C7C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-401f6513cb2so3499133b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903803; x=1749508603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAqLxPNctgCZ8U1UFIVKUu9xfoyZGj5rsIaEcM1W0U4=;
 b=cpHr2TedGX0VhgeC20tvl+Rpx4lQh3dQVWI/F90h3rbU88E8HocVVEdnJcgs+UeF0b
 jndc+e1cMdMoloYJEnEyXdtjLteXIKaSb+SB+S8khCkRHF1vq++Xkp978uYsNbqDEf/U
 4f33+GAL7j1U4dU02/VA8l+qBSN/ArNRozzlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903803; x=1749508603;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAqLxPNctgCZ8U1UFIVKUu9xfoyZGj5rsIaEcM1W0U4=;
 b=VEglJJprYaGZ2ulFVGZtiQdgLzZrA+8NYGO4ObyjSriUO2FMzs4DYzJ2UpMj53c3Y1
 VAPjNZO28LcVGU2GnLkRwjPIpLGTXtyR/yf+8jq4YvXfa2TKVPiW6Va4/1kXM+GA6Iuw
 dWHbE5nC6A0j2uoHZ4PkR+csl0d914UPpZ3GmWna7jLMo3yY2zQXlvqsNO+K1k0S/hAU
 5oymtZNy8ySrJ9hG81R/9RGCdUCznh/rt6brF09a6FmQNeJqbZbtWsZnokwED1SqoBjE
 V1oTjDSo42shHhOXdGTPZqoKne8/L4ffJtdy6gzTBCykfMowCAVYkfDq7P/qur+LEQvk
 DpMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkCbVlalMUcekAAr38XiftY+ueN2YroR1ahU9B7xlVrlkBUEUsYRaYsboEfqxLrSh/4u/2GIw=@lists.denx.de
X-Gm-Message-State: AOJu0YwTitoh+ouLjQ+7xyKRdf/raL92BcuSPo3iZL4TCsOkroTAociy
 4RAF8srWNScOrrgDnOV2c4v1J6vBSz7xt+qug/xmRqFALWzsJ1kEIG7jWurbCwf5RjDV432AO0L
 XJyeWGK8=
X-Gm-Gg: ASbGnctdQgCBjUmCwQo0LidWDeMEDAUQlEvX14Y/QZEKzWlbswM9vabeB1uJpqt2mTh
 pduZ5AsVLWpUPC9PiJMBKPTO3A6XLO7eG2TxNVBB26kxhbZCaKi+N0cq+NAxDxezGtU997agDDK
 sPzfFBqeQsCa5O/5ZFdlue8PrHwkSI+3VuFdcVjNo7XhL/Bq4M+IWJzf7jh22TZjqKAesTslNVa
 ra+ipBuSmKmWQXOLnhVKwlGICHJ8+3ysceANOEarM1WIIbL/UWm9Vd4xdBiQKcGiinv1QpoO/+v
 ucf3BgOs5TnFMF8E/x3QMgRWySXIZ0eR+WBSEPw6Ru7w5FtxS179UsKrV+E+xnZr2pah4gpn/fN
 By1FESV1H5oI=
X-Google-Smtp-Source: AGHT+IHjVZc5rkHf6H4vesKypDBDJsECpcc8Qp4XQZK8WDvcmwztp/7jsUgel2Sis4RnZjx5L7PHWw==
X-Received: by 2002:a05:6808:3319:b0:406:4e0c:9aab with SMTP id
 5614622812f47-408e35a35d2mr196461b6e.11.1748903803017; 
 Mon, 02 Jun 2025 15:36:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678c1b622sm1584145b6e.11.2025.06.02.15.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:36:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>, u-boot@lists.denx.de
In-Reply-To: <e23cecfa-7b2c-64fd-5850-e85326e69e22@denx.de>
References: <e23cecfa-7b2c-64fd-5850-e85326e69e22@denx.de>
Subject: Re: Please pull u-boot-i2c master
Message-Id: <174890380159.1382323.16537379481632515225.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 16:36:41 -0600
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

On Mon, 02 Jun 2025 14:40:39 +0200, Heiko Schocher wrote:

> The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:
> 
>    image: android: fix ramdisk default address (2025-05-30 13:44:05 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-2025.07-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


