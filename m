Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C65C369A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E088398C;
	Thu, 10 Apr 2025 03:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPayfhSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A11C83987; Thu, 10 Apr 2025 03:46:26 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E691983957
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c759bf1b2eso131101fac.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249582; x=1744854382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veavvMiX/8pFTmwPSOEVAmD+f3+UEbfnRUU4ziF5snU=;
 b=GPayfhSGkCArQqYkieOqMU1ZCq2kComNm2PHO9CDOPZu7oqsSNbnu83SjZMkzhwpu4
 xtusZMf6owKG7j+wZPAEbrwG9QHEgBIqeM8C71Qnvu3SJkwNLumcICAR02rohL5QlATI
 MUhVBf96WrMWVP3Rmlm/n0F0KY9aK6VMxL0+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249582; x=1744854382;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veavvMiX/8pFTmwPSOEVAmD+f3+UEbfnRUU4ziF5snU=;
 b=k61NKgf0wNZju82WCACMXlNsRs+RS1Fv2hpM4DE9gZy7cqJPnvBBTrUg3wVwx8QuG0
 J579qEbpOSCy0wRAdjJoJn/p6FUFyKVdqSjCPjyo/CFMtQJjqPONy1j0E7aDfnENBC3x
 lKkGjvAsC8eXYJNKYBZJB5DfcDr4r4CBY/x5N77sxJhqHjds9nH+gFZ0x9HhgngnhqCp
 kPsOPtG+46fsDzFBWtsCjmwyB6UZn2xyokYd65dvantbElMB508+Rx0niysSC9TWdVih
 gHHehfbu11oUP2tXNP643ab/jf/zP1tErjSsZiWFiYXn9StTYzIMQSI7J5U1+ucW9xGy
 /khg==
X-Gm-Message-State: AOJu0YzzDDBlu5K/N0Nd1b5hEoyvpHCjl7Kxer1XhrRkzK6PYqJQI0Q0
 ktfg+t4Z4q5HJ9BrpKGaR8OobEQJhhMhyvZtSfmMBMjYgux/VRYuZuPSn001/HJyf1PYfL7JpIA
 I
X-Gm-Gg: ASbGncvPkd5HB7eM8gYE0NVuoyP7NbOrTSLBRPi/cvowgSD/TkiHM9leSB9w7pXRFi3
 Fj8NmsGeNcjqOw5MY2S8IYsSrAMZ7mWnWY0+U2RlxlLx+2J3kvxDLNJoQYHLpIra/Dsedth6Ibm
 vxTppqNhUkUc5Sdqn/kHiVE3btuZRSVN4XV626QjC/4iWnUhSqRqukraxj01mHu4mTaMtdSeiBX
 nFuwHC7rgjkpLKFOXlRF6NaY3QJUkVGKRw2dy7KnUnGToQFJy2ic3ToMnBmlcDqdar7uflL+4U5
 kDHgJRimRySjApphhL0IpvPIlTYMqyn51DVVplaQ3WL9+cWr+qvhfgVwDHTRdyWA6/HolIAVjg1
 1
X-Google-Smtp-Source: AGHT+IHDPeHXcgzxlNVtXCQErMu444Ny3nLgc/ZoX2KRtQ2PWydlJqmBvl5WUeoFMQZbhTB6+DEwcQ==
X-Received: by 2002:a05:6870:f22a:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2d0b5be36f4mr337529fac.18.1744249582681; 
 Wed, 09 Apr 2025 18:46:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jason Jin <jason.jin@freescale.com>
In-Reply-To: <20250324083406.1536773-1-vincent.stehle@arm.com>
References: <20250324083406.1536773-1-vincent.stehle@arm.com>
Subject: Re: [PATCH] ata: ahci: remove bad free
Message-Id: <174424958187.1824423.3912963682238323506.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 24 Mar 2025 09:34:06 +0100, Vincent Stehlé wrote:

> In the case of a memory allocation error, the ahci_port_start() function
> tries to free the `pp' pointer.
> This pointer was not dynamically allocated but does in fact point to an
> element of the port[] array member of the struct ahci_uc_priv.
> Remove the erroneous call to free() to fix this.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] ata: ahci: remove bad free
      commit: a345f44a60f57a2741cda9315312d3df28bc22f0
-- 
Tom


