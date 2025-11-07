Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75423CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0806D83DF3;
	Fri,  7 Nov 2025 15:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WjYAO9AO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C400683D0C; Fri,  7 Nov 2025 15:17:14 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D8E83DDF
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c5333e7033so260313a34.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525031; x=1763129831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iunmwaeXQgfJqnpAw7YF2jyhA1xJVOuGfJa59iNd2Q=;
 b=WjYAO9AOVu5c7TlLb3GLXivsmmCfkWoGR052Pcl+mUWp9/M0uWDwEpOONblFKbx+wl
 WbrzLxu42maTURi6qDjOjIEBZIjxdJGIeJPrMdEm6m7aipPtuNiuleKQBr4zf0YZw5hq
 lHkmrSRA/A/YIkgKab/F4ga/GCAqhhQDAGvPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525031; x=1763129831;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1iunmwaeXQgfJqnpAw7YF2jyhA1xJVOuGfJa59iNd2Q=;
 b=mAcEbXtIpXghS4pVUCSlWDf68pYCGv4/+jfM26wVQnspeg2J6PCifyEM/pAi9PlL76
 7FuCEaDYMhUYf54sEvO3MhgsAymHsJpLtzurZu9sXwUkZ6G0pxDlhbojbOe47BRwMV6q
 hSguasdjSHjgBZID7VUPXU1q4ADnKnPsDxUseOQOVCZyT5RSpYwoqCQltz2jWeSxmNkd
 iuzpO72wjoVbeUxVcGMwkj7h8hRoUpEqi5ry2Q7YWjtFIPRXq3tM5dsB8H4fYPnoAGPO
 e8XiyvQlCdOzUvDJHICedWGWSxquigN4cCR6QvS0Gh3J4SaNvxlsr9CUgSZI9ffnTqwE
 3rXQ==
X-Gm-Message-State: AOJu0YxYuulvhuNMUYVQEQ6u5JLQluGbf5TdroNAYTL+kn8HiAYjVQMC
 eSxXxXpromHZxzpaaXTD6F4JvAo+AW1Bz9+HeECFDuq6wPR8iF1Qcaxlea+g2YTfEgU=
X-Gm-Gg: ASbGncs2Z+V53SBgtUqvgjiUBb39kSJUgVQuEeahNPiJsTrYwDxQhFgvREOe1SZAizB
 NXv04cMcnBU71PEOqsCVgXVDz0ktWffmKjEYjleP/v9Jic74neYwR3NLfGk4pbcvFprvKi3Tgow
 eNfdrpj+SqaPCoeC+eLYTWiXPeQoLUR0BMovcmPFZcP0qY7Q8Dd4aRRZPVCrEsCSYWilYe8a2bH
 FRw7hg6fsuhVcjdYZ+4OeiI7889LP2eBhvTYHzM6IFil5K7Qfh9MRLnwfgjJtm2fLykSzMQKq2a
 BfTcfdjXyRscpgpsBCsuiUd0VW2qFGIwnRoZd6XnvtK/JdpEC/M1VbcTI7N356ptne6N6eCPqiB
 5+OHnxxlpzHmjNTvezMRSFxIgVDS7fzkzcRWn0EfB2lyBfP/Tez3R2lcHsMPCmc20JrE22Yviiw
 y12K5EXQ19aoTVjmGk5CxTajUNbi1o3cEeiWS9kw==
X-Google-Smtp-Source: AGHT+IG4qYsTTAsnmOetuEjR+yC640PXYWOD9nrPp6Q+6iHQExYpaDe/eArSA52KvF0zJWNZE1MP5w==
X-Received: by 2002:a05:6830:349b:b0:7c6:9fc5:f6ae with SMTP id
 46e09a7af769-7c6efcd85d7mr2379666a34.2.1762525031342; 
 Fri, 07 Nov 2025 06:17:11 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <20251031-spl_loader_fix-v1-1-3fdc65b5af1b@ti.com>
References: <20251031-spl_loader_fix-v1-1-3fdc65b5af1b@ti.com>
Subject: Re: [PATCH] spl: remove redundant prints in boot_from_devices
Message-Id: <176252503066.3410992.2077060615264247705.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:10 -0600
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

On Fri, 31 Oct 2025 13:16:26 +0530, Anshul Dalal wrote:

> The null check for loader in boot_from_devices was moved earlier in the
> code path by the commit ae409a84e7bff ("spl: NULL check variable before
> dereference"), therefore the subsequent null checks for loader are not
> necessary.
> 
> This patch removes those checks and refactors the prints to be more
> useful in case of errors.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spl: remove redundant prints in boot_from_devices
      commit: fdf36c2e9ad4f770ee951398a86bd55404d9b7ec
-- 
Tom


