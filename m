Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312AAC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5AA83460;
	Sat, 24 May 2025 06:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H7RqcqBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E713835B6; Sat, 24 May 2025 06:25:56 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C108835AA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad69e4f2100so63687366b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060754; x=1748665554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lwXKAE4z3q2VxPDhLKOAWTij1RYNxQlBuQvPxjFz/ro=;
 b=H7RqcqBvZqxm1tSdWMCEu0CavqQhRVAPCmTxKbQfUYffeANVvqHb3VlIYMBqSWq2Yb
 KdO3lDefc41rEtTfFIY986ZJS6Ul0LjP+7V36FhidzNJRoV+jzasiNEH41nmOffd4KJl
 3eLvPIGQeAuZdD6N03A5y2pfeJRtRp0SZ7mj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060754; x=1748665554;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lwXKAE4z3q2VxPDhLKOAWTij1RYNxQlBuQvPxjFz/ro=;
 b=Ew+4xYy9S7V3+ydSz7pgMqkNlpRCNfWcrBrubERXIxkJwrKWdlYRLjx/5g4wIwtg+D
 rxYH2zVCjfsv2Mjn83Un0aeINC/+llzOkzShibz8R4LLn5ng99dfIb61m+RvOti5ZodE
 d6glrGvtUu6wog/2srPNA21K8H9Dse6cBQLO31mUaRU7tNqCI2wfe/8eZIeCo7KO8LFV
 gICa5yStkik0rOhUwzj39x+eDukn5J2XWYZFIaStjsKWuPQDFmv1gFtc9BBuLhPezoon
 QQe5Ng6SQqonzTNh/Y7O9EMfWMgeP15z9wmq563+lDZ+DwxmiUG6KF97ZK6EUwNTWCtk
 Xh/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIsXDNTFAHfvDpxDOFaFeG7PvGd8RANMD79m7rUJQOJirtXuda3nBeItBlHK/6WMHRrXKt1M=@lists.denx.de
X-Gm-Message-State: AOJu0YyQjzEVN6+36FbxQpcWp5HBQCoLW49RVDt+j9OS5SZgBI4u7SyA
 zOZ533mfPO12qaTP8myOLhhKJAV7Fusi3iFX1PNtM9ZeMPvcr9TsG3ePG8tRGank7bj8CWJwiVl
 rIxAOjsAVtsbORIzAVJk9UabhXKKTvYZuR6gObNXf
X-Gm-Gg: ASbGncvQ4RM+0sW9/BLKt+AcnuSoJirvyfCFsGgzhQof1/gc0VOKZl4gHU6P+6Cw50U
 Yyg9tSjnfRb/7SBf8QnT/nm/ZJ+KfhKmAL0yQvWVFvnUNUnsbe4ynlFyR96dsCq3RAopyA5nIXM
 6XRDUVVDWB1jgPjS0I5DYK1fR/+vOoMDM=
X-Google-Smtp-Source: AGHT+IGOn5Pl5bIp+1srTRmZiw7Z0BucXHTi0N5uozivpBoC8cV6trIQRmUKDj/dHCFiLSVW/Hocnfvk5oiLYU+v4hE=
X-Received: by 2002:a17:907:2d26:b0:ad4:f9fc:20a5 with SMTP id
 a640c23a62f3a-ad85b1d0f81mr122613066b.32.1748060753821; Fri, 23 May 2025
 21:25:53 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:52 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:52 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-3-sjg@chromium.org>
References: <20250508072907.207175-3-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:52 -0500
X-Google-Sender-Auth: rXplq00UYOl5LCWLAf_uzQNuEXc
X-Gm-Features: AX0GCFughzHOrnZMVwoKTrBy65v2EqMbkZpsOXA_vqOKqOCTjkiTG3we-qmBUlQ
Message-ID: <CAFLszThsf_6_+b1xWM_BdA-P0ANc1OM18pzVr0W5WFmcSWaS-Q@mail.gmail.com>
Subject: Re: [PATCH 02/20] u_boot_pylib: Provide directories to gitutil
 functions
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

For testing it is useful to be able to set the current directory used
for git operations, as well as the git-repo directory. Update some of
the functions to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/command.py |  5 ++--
 tools/u_boot_pylib/gitutil.py | 49 +++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 16 deletions(-)

Applied to sjg/master, thanks!
