Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA5CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A9F83285;
	Tue, 12 Aug 2025 00:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7RcLshT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CB78323A; Tue, 12 Aug 2025 00:20:59 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A07831D8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3e52146df5cso51937585ab.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950856; x=1755555656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9/oYkbMt/AKogPBUq2OaRe1d1b8MdjCAmnRTRqVT3iA=;
 b=t7RcLshTsi4ZUorhqYYv2D01NWaVq03/mrjgKKaserlcHpCDNxwt/Q2GrTtgfaTlx9
 E1gIW0BMAEFUVzAFfLOMjrl22LexVA8sJXdXcukMcQs2zsz90fwBjciy2j2cpgjpqujH
 BFUjtO/ir4oFe+WvQzal7OZBQBawsjn7PnyAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950856; x=1755555656;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/oYkbMt/AKogPBUq2OaRe1d1b8MdjCAmnRTRqVT3iA=;
 b=euV/6p/9+FjDt74DUqsIZ92MAKdQFqGiZOY3XEbTBzTNcvkS/Dd1TU6zASpetRorBG
 gwgvD0zo3Ym68YIUYHyw2hJ4Pi6Y79PY/jALbZVD+UiDHdCAM9e5RTLGX1AzI+2AlFQc
 rd7BVLDzC+il3iVsM7JZwpN5ZzLet0/0UJmclgzXCosZU9rkSTWrq8FFPEQim10VjaVK
 TWNzsVqG7v1U4tdIAFSmHvyaMtnnW9umiy9a9O9S+DEJ+rSpg7eL2vVjeNRSsUUQhYYY
 Rk5JOKajWrsHhww5lreeFK3eKDv8FYkburnir8qQkPHR/lG1tt1frcOvYStHpJVV1xYN
 bmfA==
X-Gm-Message-State: AOJu0Yx+kePcPsal81zYEb2J3v3UGJmsTa8A1xT4NjjCl1Kfz07JBg6i
 WokUdFI9XsCVRR/w3b6yXv6Txh0IYgBLCUmNMwgAhX4o+LadXyvfYyOfCT/FI/PokOZYRRYHMfd
 I3L1lcs0=
X-Gm-Gg: ASbGncuyW0Dl3e+lKCBebnQQvffUb91sehNgux+MZZOrplueZ90ort5+NzQPZb/SXVj
 YHR/gLmLaU/jB9h8CG4pnadJNX4QSY+yuRFpa4O58ZcrE7ByFVVmGpBWpLWdIUrybGMWvAAtcQ1
 +C1e1cyXaEBUkV+VsyW7BBA1bW9aUwS+bxWqfmq3GlAzDVOW9sjW6FlNBLz1gk6pAY1ctkfHi5M
 H1NFnXVu04RVnLUILvJVGVjIDPy5Yc2pmT+2ftdsYKiumQ41eIwwjsMKyTR5ZCR4SL/MrdFeSwv
 Wji9fYapOsdHEz3eZYihGKo1gvStAgnks3wRKCwwyy0fIvCnvEvmn2ksZ5WUqV+XntRFBHJwmY3
 oIWsNIhmBK2AIehUb0ASTUsXwZIkfJiW77bx33bKPa0ZqMSIuKC0e93Y=
X-Google-Smtp-Source: AGHT+IFAS2uCrfGyWKZZ8oThZN1emIyMPe1O93DhDu3Jt1usY49TYfQ/yQTSLxZ2i7Xr4RsiEloBgw==
X-Received: by 2002:a05:6e02:12c2:b0:3e2:c5de:5fb with SMTP id
 e9e14a558f8ab-3e53313f9b6mr268304605ab.18.1754950855965; 
 Mon, 11 Aug 2025 15:20:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250718011521.1333839-1-trini@konsulko.com>
References: <20250718011521.1333839-1-trini@konsulko.com>
Subject: Re: [PATCH] pci: Add missing <linux/sizes.h> to pcie_iproc.c
Message-Id: <175495085483.1657597.1185034974576023342.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:54 -0600
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

On Thu, 17 Jul 2025 19:15:21 -0600, Tom Rini wrote:

> This driver references the SZ_ macros while relying on an indirection
> inclusion of <linux/sizes.h>. Add the missing include directly.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pci: Add missing <linux/sizes.h> to pcie_iproc.c
      commit: 5bad0bc4f7beeba8e972005fd0901cf368315815
-- 
Tom


