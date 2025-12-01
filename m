Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3019BD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 20:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5F983D39;
	Mon,  1 Dec 2025 21:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D8GoRsmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D228583DA8; Mon,  1 Dec 2025 21:08:30 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB60C83CAA
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 21:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d13986f8so3249031a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 12:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764619706; x=1765224506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nrz7lhOh/Lt4Gh8kUvvt3rS9lnY5aQmEwA3wIihrzOo=;
 b=D8GoRsmtxJoZPZjb0TH5djDvujUxtiR5dMkma9wyCV1A7/whU4Q72gvjL1iRffXNnb
 YLZxxX7F007y69wMDxwBROl9Lh+AJJiv/I432HWFSOLjrb1sICioPZAlaQ4Ycu1q2gjs
 2k7XtaadiGpsG5g7APD15FhYcveI2Em1+PF1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619706; x=1765224506;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nrz7lhOh/Lt4Gh8kUvvt3rS9lnY5aQmEwA3wIihrzOo=;
 b=WtAW6PM0Far5KgEsQqfYXX2ptTBMdiXKlbKXPk+2OfVNiGxmz6lKv8WRuw/M4FUx3H
 PUBkX07/209xsFRzsjNLdYvghJGwO8WJNhDeeTUedKx4AFtuKcXYV8zkStvCXPKv/SVh
 NiAUAJiK7EnkP2FqnLmNcVJSTMoKWlRSSiXnLQShWe+rXA5K0HrIZ66xLLTrD8bE3E/M
 6jxnEyYcLKDv2XqyNCL/eXrZ9rj/7CskTqAjFh97JJ3c157sS5k0M0+faXQLclw3v4+S
 4ERDzF+HXzaTDJcy31qh1A0+MtjSSFQSTxkV+FUgXpc/CBEcHMAIudZFpMz6VFqBintN
 753Q==
X-Gm-Message-State: AOJu0Yy4Z9og3TNwMrYBsQE/QGHSrALG+MlrJOSxprsVMas7jXI3Ogmg
 r1zIhD4PoxYEVqcuTLvkgou7u15vbPNF84ufgGectUjUiQYfqZANaV6RuxSdSPsQgBg=
X-Gm-Gg: ASbGncssHzRgIr+5pn0zQJBSDtFCTzgwYY6J3WYDwCFKga1zJNzM1hJaA06fzoKAyv/
 LTbw9sXk0S3Az+hGJ8g95jet/T3dC9J/ulQ8z2Xn8b7aWaZNY5xPFB7EFzwDeGXca5XwtrJ1ZAi
 2RGZ79fUn9GpxYY8wIKui5JlCQMc6P4QQmvKyMyJmLLc23XtLcRsOHqqi1ks2DpK+GA+cRAs1Q5
 2Xp2nD4PxFssVk/NzMY9OTNKyUFBX5122kVERAzGs8b3kkTfIQK6Foxo/xUxsp2gd4eEqqklK4U
 n58tW2MXo0//B0w7+PrDLi51LebnxYpQShhd5kIpRURnzTVYXvDs5pvfnER+/V8nYnEFGLkU9iV
 nwdLHKQ7Iu9C0ASIm07Ijdi+mEQuYeM8sbtfyOeTdRjSXsBf4SLYzgoc38ySTGGguUIgyPQQtBV
 rPtsMvXaNcXAJdTSpJxi3SgF84uzl5y2yXLK0D4/K66/tEuqh6
X-Google-Smtp-Source: AGHT+IHKGLkR3aUFHIO1yqwnSXTC5OiqaBmYsvjwPtCNSMAPufUIrzNUabPuKUheviYUdVqghGOyWA==
X-Received: by 2002:a05:6830:440d:b0:7c7:60d8:9d7c with SMTP id
 46e09a7af769-7c798ba4d6bmr18919520a34.16.1764619706612; 
 Mon, 01 Dec 2025 12:08:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fde226csm5103402a34.19.2025.12.01.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 12:08:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251126234946.3909525-1-trini@konsulko.com>
References: <20251126234946.3909525-1-trini@konsulko.com>
Subject: Re: [for-master PATCH] Azure: Rework jobs for disk space and 29 jobs
Message-Id: <176461970562.2272036.12395343417084457821.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 14:08:25 -0600
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

On Wed, 26 Nov 2025 17:49:46 -0600, Tom Rini wrote:

> The problem we face currently with Azure jobs is that we're running out
> of disk space on the runners as we build. There's not a good way to
> split approximately 1500 configurations across 10 jobs and not be close
> to or exceeding that limit. Split this in to 29 jobs instead with a goal
> of averaging an hour per job. This split gets us close, but there are
> still some challenging jobs to try and break up further. The list is
> mostly alphabetized but with some intentional changes (catch-all are
> last, mx/imx are together, SoC family splits are just grouped together).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Azure: Rework jobs for disk space and 29 jobs
      commit: 5e9f5ea30f6d371ddf93ea472c0885e48504c968
-- 
Tom


