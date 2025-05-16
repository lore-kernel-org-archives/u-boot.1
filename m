Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4168C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7B680107;
	Fri, 16 May 2025 17:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G/+YpQ8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3118006D; Fri, 16 May 2025 17:40:24 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E6B82A9E
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30e8f4dbb72so559881a91.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747410021; x=1748014821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+jpkRSTZYQHUzaIe4KSD8eUPlBCWrUsipiwF0ZORoTg=;
 b=G/+YpQ8bi7OSEpjqOM6SCsj3Dq9BKDmjJoehXiD3ir/Mg6uF24i0KXP5xZ1ogCzcNF
 v88GkoDq3KpDpgJ/gG9sGnFLJqc73gLKm4oPBO7Do4fhPnQecvyKoyaRin2SnLmcC53f
 Ce8tC0C513MmPeGMB1ONPBRnQ45ry9bMXVxmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747410021; x=1748014821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+jpkRSTZYQHUzaIe4KSD8eUPlBCWrUsipiwF0ZORoTg=;
 b=k72jNS1n7Bwwd7D5M9R5L7OJp5td/dU/1D7lgkaT3wBwg230WRVaefb0+rAbbC6lYd
 L8t4VQMgvrI0SzKgF7fW35SMWi1z/qqErUtB415WkJ/mkRlEnFKSLZsz6cU2hgCJYF3J
 ZbRw63CIB7NZ2NAX8wLUWdN2reZlF4YgW15QPKc2a24fCiGPIZ8imFCqHZFXjWSZ/M2h
 6i2HkEl6VBj5OHBUBSeLhS32cVjUGWt6KyaAJFzolMKkT+K3IsJnHheQ/0HmHpFhAZ84
 lysehpF8st9vCg5Svu9iLpuWhH5Df9AfuRTdSHpn2h87nywxLcrNWLzOw/m3A/Y+WsjG
 VfIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyGvSZfQPtuXy6Zr6gYLNGv29BvOSYINCRo029GHecBEpj9U2MsyYPKYUY9dUNWRDtaAJPzLE=@lists.denx.de
X-Gm-Message-State: AOJu0YzxnoGlrX+nMX194pxwwJA7k1KE2SMmySVHPaqjnUtIIR3hJQLM
 bsdQ2GUkpubuI/uXLGtdBD268ECG+LCbOkhBBKn+sMmFmYWBotwRlz2wSBlzrNkmGXtyv4gg7uQ
 Q2Sq81veylauETEbbExIyUxlLgIX9ZT9byr3wZ/qx
X-Gm-Gg: ASbGnctNHsdBncEeDxh9yMZdEvOQUZtxFqZ2jbjep5eoPnWGByVCbHhpnmf4AJuPx4t
 PZJZ6Rz/LOgtw9f0mXEMGq5vj8B1fGMbz+KkGK0Q09u9PKRVM2oeLSWioDjL8qCcdqAooN1YVmO
 c65FOOFfBP1xb0us0KzRFg10xwt6P6kqUNgw==
X-Google-Smtp-Source: AGHT+IENhMo7ovmIydXv+7rSkboFV4ZfyBVqR6yk81lhP0dHTzU20N69BIFX9A1hB4i3ZV6Eo5WqI/n2DsiDaU7CxTE=
X-Received: by 2002:a17:90b:4b01:b0:30a:dc08:d0fe with SMTP id
 98e67ed59e1d1-30e8314fd42mr5423980a91.16.1747410021072; Fri, 16 May 2025
 08:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250515-bl1-support-v1-1-fd4365542877@ti.com>
In-Reply-To: <20250515-bl1-support-v1-1-fd4365542877@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 17:40:00 +0200
X-Gm-Features: AX0GCFtgaWpnzwNZM5mEUM7kdkWoWDYtR0yLcm57VZ3Xe3EivDiCoqzJcTVPjgc
Message-ID: <CAFLszTh0=HXZ1pubqUXppuR1gpi0y8Sr_xsiVj28K1VPa1iTnA@mail.gmail.com>
Subject: Re: [PATCH] binman: add atf-bl1 to etypes
To: Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 15 May 2025 at 17:16, Bryan Brattlof <bb@ti.com> wrote:
>
> Some SoCs require a Trusted Firmware-A (TF-A) AP Trusted ROM (BL1) to
> initialize the SoC before U-Boot can run properly. Add an atf-bl1 etype
> so we can properly package BL1 into a final binary
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  Makefile                      |  1 +
>  tools/binman/entries.rst      | 16 ++++++++++++++++
>  tools/binman/etype/atf_bl1.py | 23 +++++++++++++++++++++++
>  tools/binman/ftest.py         |  7 +++++++
>  tools/binman/test/347_bl1.dts | 13 +++++++++++++
>  5 files changed, 60 insertions(+)
>

Acked-by: Simon Glass <sjg@chromium.org>
