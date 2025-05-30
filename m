Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC0FC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 19:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF1982C49;
	Fri, 30 May 2025 21:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gQL3vQuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22B0833F6; Fri, 30 May 2025 21:39:16 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40C782C49
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40669fd81b5so1440598b6e.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748633953; x=1749238753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YowqWadhm9JhqdhPT5npgl6xg++b6OoA4ozrAcq9Qlc=;
 b=gQL3vQuqUNMIbt24fb2LzJhxuIVe8hV4DC7ETEzNTR3IW5FC23bTwAJJvh4pHnv7LL
 kRipLoY0HC6wqDG+7sWWC9jASZS20ooknFw5lhkqMOVwM4PH5ysdX9uut5qah2s5V6gE
 MI2jSFM/DLePmvhg2Oke2oer71mNS74ORyw0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748633953; x=1749238753;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YowqWadhm9JhqdhPT5npgl6xg++b6OoA4ozrAcq9Qlc=;
 b=tBMq2zGE0wc44UDxi6wtoHmT6J6BE7VUXjPsrwsIaa5xA6bg4HlJ6pKA6ct/0F+ETy
 9nG9XHwvj44zoejR2jtWxwY3vy/KyVIaosECTQuibNCR+3e6RzmbzIOJKi3AbbEy9Ng8
 oE8riaImRMiLuiU8EHaq0m5E2Lky6rfaQ6hxrugH6WwaXTmwQP0i5IDVxZ0+1iwyLzrK
 wqfS2qhGoG913hboY7XskJgQtllgXOYBzOd+pxEuOvvlh4EThEyvY6B69JH7Tjm/qiM9
 R8Kpy7Gb5yP6I+hCuT5EN7lhlkmo3yWkEduHq+exJWEn0GvqkLIiAmUUODv16LTJ3aQl
 QW3w==
X-Gm-Message-State: AOJu0YyhtrtHQW2ig7AsRLCeQJ8wOEPuPpm9bBiACMKFecptNkKwt5er
 swxh79+4OnyUxG1MxuzcUT0lZaTUdlmPjfH9WwgyKntyKAR/4Lukx8vMogGwAMkMPj0oZzdoh7D
 JVJMnor0=
X-Gm-Gg: ASbGncsW5fgazEsxNEPGFx7vltC5Mr3Y683KS851eMYOwUD5yboQ0ketbkB9v4fmHMl
 IUAtiWEcrWPVf6kWUWQ9xsZW+yMlI7+/qCdsozaT8oK6380KBnqmABOLY+sB+aUN7VwOdurZvyi
 dWgl6gGAgySSGocCQb3SU7dbvVTYnVGk9L6Hmw9RbVLuwW2+m4O1YIFB+Whmub8XETZV2ITO6mC
 P9offv/RolcJIwQt5fHD6BEoidO76Kr6cE9JP5GO7pkfhN9kioosPmdaR+HH5s/SJuRIYBVLkep
 Z+sd9FKZtAymKD7tFZhGMEXhQWSBYRNxynNGP+M8Z0+dlnkvU/Weuu1pk1Su0CusliSpp9s7Z8v
 VrNpwfsh2QJacaBQZnHbkEg==
X-Google-Smtp-Source: AGHT+IHv3r3feaOKUYLfChPvhJxla6tZmornBEKXJWEiH37QddDMFXlrUgUTSRDwwhpQUbSqmvZAPg==
X-Received: by 2002:a54:451a:0:b0:403:3195:58cf with SMTP id
 5614622812f47-40679631124mr2398367b6e.1.1748633953457; 
 Fri, 30 May 2025 12:39:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8267sm491805b6e.37.2025.05.30.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 12:39:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250506140412.190005-1-trini@konsulko.com>
References: <20250506140412.190005-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Rework sjg-lab calling test.py to be closer to
 test.py stage
Message-Id: <174863395234.4062885.594223264453587129.b4-ty@konsulko.com>
Date: Fri, 30 May 2025 13:39:12 -0600
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

On Tue, 06 May 2025 08:04:12 -0600, Tom Rini wrote:

> There are a few differences between how the test.py stage invokes
> test.py and how the sjg-lab stage invokes test.py. As a start of making
> both the code and the output and artifacts similar, this updates the
> sjg-lab stage with the following:
> - Pass "-ra" so that we get the summary information in the job
> - Make use of TEST_PY_EXTRA for passing "--capture=tee-sys"
> - Re-order some of the arguments to be the same order when possible.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Gitlab: Rework sjg-lab calling test.py to be closer to test.py stage
      commit: c7f360f20d848f9e2b607885a280084290732566
-- 
Tom


