Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4149C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 20:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21270810E8;
	Wed, 26 Mar 2025 21:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gbMk5pZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A4D81A0C; Wed, 26 Mar 2025 21:06:13 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7238070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 21:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c09f8369cso84975a34.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743019570; x=1743624370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nS4C8yzqG4fA5XLVi7Vl5oXvaFTKdx6DQGZ5yQDkizE=;
 b=gbMk5pZMvhKfX++E91bCRNfRQMyV04KzB7gX1xl+JtPC2JRA+fv/NgH/xUKg9rW4CN
 nbu2saga2TQ0WhOTaHBOdaYa9EZKKgUGjF2OnsJk+E/RVFXPBxBCUu9QaMDxmUlRwX6f
 FVx+kgKaq6YIcLcAyxDPga0NvOmNRVxjVVhaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743019570; x=1743624370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nS4C8yzqG4fA5XLVi7Vl5oXvaFTKdx6DQGZ5yQDkizE=;
 b=t7NQ62GV//9QXoWgWuiNZYEVZh+Ksj/tr4QI3HLZJ0DVPSGP4pdanOl0BG/v57dqTw
 RUJ8OpGHugQzM8kz2E0WG5EKnyXuzuupP9mCKRd1MMNzCdQZjgG6D/suYiirc2i4hGvX
 z3PHszrloNzlETIgFllysRJXbfAvV8nkE6MmclPMVTj7yUla9uBFWegWRAOnrD0SYxq2
 qFZQSZuvNfcGTRuxpFHhY/Pt34ety0nZSdSqg9l24pis4gyAWqjdNJm3vlUvtsWTMP9R
 zaOTm9byiM30nKNqSGiDl7QrTJjuWqi5kONZaL/tznmaFuUV2lpfl7OQBS6IzKK1KjI6
 ga4g==
X-Gm-Message-State: AOJu0Yy9Xw2l5aZxYh0Tn9uoY83gqq2xg65RHYEwnXfYOFaO1zw2lorj
 j/AfAYBDXq1TI3zo1c00ltiob+RLRT1V/HRVBwtqlkSzdMbdbj/qd0ZEkTJhpDU=
X-Gm-Gg: ASbGncsTwFWbpvxiRok+4lI9br8eXl6uPjYZMRddPewf8Ci1i96nZJ29E9SnwBDgsTo
 J048/6Z4LAvg/SifpDXD1sfID0OV1y7E3EtMTE3OmoVEBkN1moZ3eonw3+g3cjcCoajW2FUtx/g
 IT45+RMqXPcmqCay+MkWq+fsA00eB67AjcqY3boWOCMxEKvGXqn1UTKL3A7zGygwjcQCGy7ASOq
 05RLAodMNGrO23d2Qtv2iOxooo8DZ6k+0/6DFwil1CR/Pw8mFtgSvMOU7AHtSdK6aO2wWAbawds
 mWBikCk7NTM0IPovbXoHTuCqB30RCgrXjiinLWIbwkPEtZVu599kC4la+Vr8eNZ99UyXviwSev3
 OW0qP
X-Google-Smtp-Source: AGHT+IHfXDqYvx1eT7hUX0j9ZfCoIJ8o2/6Qt5qPqom2uz1SvbdfTA0H4DgXc4hBEVRddQPf0sfG8w==
X-Received: by 2002:a05:6830:488e:b0:72b:938e:31cb with SMTP id
 46e09a7af769-72c4c96a06bmr630848a34.7.1743019569915; 
 Wed, 26 Mar 2025 13:06:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c0ac7b8aasm2431300a34.62.2025.03.26.13.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 13:06:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250326165336.547689-1-sughosh.ganu@linaro.org>
References: <20250326165336.547689-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] test: lmb: fix the lmb_alloc_addr() based test cases
Message-Id: <174301956860.548118.5380481679425281659.b4-ty@konsulko.com>
Date: Wed, 26 Mar 2025 14:06:08 -0600
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

On Wed, 26 Mar 2025 22:23:36 +0530, Sughosh Ganu wrote:

> Commit 56f186a68b3 ("lmb: check if a region can be reserved by
> lmb_reserve()") fixed the lmb_reserve() and lmb_alloc_addr() API's for
> some corner case scenarios, and also added corresonding test cases for
> these corner cases. These tests were checking, among other things, the
> lmb_alloc_addr() API. The above commit was applied to the next branch.
> 
> Subsequently, there was commit 67be24906fe
> ("lmb: change the return code on lmb_alloc_addr()") which was first
> applied on the master branch, and subsequently got merged to next as
> part of the rebase. The second commit changes the return value of the
> lmb_alloc_addr() API, which now results in some of the tests added as
> part of the first commit to fail. Fix those test cases.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: lmb: fix the lmb_alloc_addr() based test cases
      commit: b052de94fa14577cb5d9e724edeb09fee674d582
-- 
Tom


