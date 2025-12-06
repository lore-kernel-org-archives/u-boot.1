Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E07ED3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B6383A5A;
	Sat,  6 Dec 2025 15:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PT13iBnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4269E83A84; Sat,  6 Dec 2025 15:11:03 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCD683979
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so2904327a34.0
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030256; x=1765635056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynhfckTWYAIQ10Aye4yX6tYfdd8bSguauA4PYEuPIKM=;
 b=PT13iBnznQ/dLYp6YRvoTz3At7Xo4xcoBl/nE3FFnsh6VVUi64KbSFB4qUE612Gea/
 Udmx8jhmFYDv6eh5NDuIjQ1+x3sV4Lu9lZE4nPPKRsrI/zXVANDjhEcHYjHsqGphFrRh
 U9e2hjCuWheBFX3pDcLVakljHoE7HIku+yZtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030256; x=1765635056;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ynhfckTWYAIQ10Aye4yX6tYfdd8bSguauA4PYEuPIKM=;
 b=rYl/V6jtjMGTf3DukIB8VFWDRcOOHw+QiqvDG5zW8RPtmaCSGc3zsPIYrP7FRgIlwX
 EnLO3XtX18piZ3yMUo9TjpB87oRdJJDVYpXO1pWRqdAIJ6cYu82xWCIEGw0qi5Dn7khq
 1vBL3CN8eCxN8GmS/gdWVvJ8W540QjA1tU2MLeaHysaOTbT51j8yZHLcYW2GRywrzHDs
 qZEjTMvWGpug64gH++BxTy933YrhFSOK7Z4EHubSxfGVsOwY5LLQFel25qjNYM75sbwF
 qm+xby1L6cy6thKhdNthon9kLWTNcwfqBS5tJepARgDCLvm0C2ey5AuG75wRZdcCZyrd
 8HOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5t8U0oJcP8FVUTvZ2TS/hbeA+uHJ5WtIJ1NUSwP+qbwGqv3jNie9IzsxWRE/qzvvk4Axs/aw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0iJho9MVwq4WswdzVUG+XkcnY6c0GMEbTyo9UXxzNhyUO6Pyb
 8ttKPDZRuuzUZHhU2Pc9tA5lz3pzrN2Ds9dMBDO4DUcN51WhDQ6GEdGvHx+YpRhQShIKh5Xg/IO
 cQOTvL/Y=
X-Gm-Gg: ASbGncvcXbCpm5dDOvfnDkV8iWdIlQxZ5DrRsT6SAdpoAcfXtXCAzG9S67P9HTfCqU2
 LK6zEimTe5IjQkbKp9jrz6HCypRNoPZG9l5OD3rP41SZSLcf/66Zh9WK1tqZdkLSnY+3rZ4MpMr
 NXInUOKa7r8V1m4azCmcqwdBoFGlZ1bfcF+DJkZMoi+CdnI2RVnFSzDv9Cu70ZNkLru2E2G8zsr
 4p7cjX3xu7T/rKL2lIoApUR6j6+MECjkSQrs/3Nnb1P4vwgvYIZGPecO65aokJotYbozh+1COfo
 odcnZZlgTlXYrB5eLoUJVO/RHcBIPXYQippGO1+1wDgW7AbXlVrckL9qR2yVVIwdWv33aOl/i7A
 WZRd063NgT7zgrAX8bEwDt0SVXLrOWTzpxN6o4kVA6qKdTR8tBa5ZrjT0SlUM5Zlrk/r/7Yk3RA
 uxV1d/VoBS8qZmK+U43cempvhSJKEXiTxVfkoTywcbZXn+v8CN
X-Google-Smtp-Source: AGHT+IGwbOOJyNmBRJhYsg/3Wx/IH1X9YGenKvvpcSop9LPWTQkUHDqVyVuuF0oL++LVglzwKg/U8Q==
X-Received: by 2002:a05:6830:4d9b:10b0:7c7:3416:ff8d with SMTP id
 46e09a7af769-7c970786d71mr815729a34.9.1765030256005; 
 Sat, 06 Dec 2025 06:10:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20251027002458.16741-1-semen.protsenko@linaro.org>
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
Message-Id: <176503025514.2523567.1012799477389645993.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:55 -0600
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

On Sun, 26 Oct 2025 19:24:58 -0500, Sam Protsenko wrote:

> Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduces
> inconsistency in how the countdown is displayed. For example, in case
> when BOOTDELAY=5, the next output is observed during the boot:
> 
>     Hit any key to stop autoboot:  5
>     Hit any key to stop autoboot: 4
>     Hit any key to stop autoboot: 3
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] autoboot: Fix inconsistent countdown output
      commit: af38567cadcaa4842d85af179254886a50c93fc9
-- 
Tom


