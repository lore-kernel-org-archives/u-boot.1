Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC82C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 23:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7E680EF6;
	Fri, 31 Jan 2025 00:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="atsWmQSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B7680F1A; Fri, 31 Jan 2025 00:02:26 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A09805D7
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 00:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f1c94936c5so662097b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738278143; x=1738882943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1AezTEfUj++wb9EsLnlnGVNAwI7UoU4ZEUR2smrb4k=;
 b=atsWmQSE5c961y6XwZVNjuMWn7GBa1VvSXvJCI6Q9oGT7xbzs9iJGvnlRGvictPzCd
 77Dwt7aDs54QglnTMB74VZePM8b0hBdbhsmDuyhBGD8BwLbTghO7fjf5DMtN0NuyYgTN
 aA474Y6OPiVNTG3ctinh4BWWWWTemJ8t5Pr5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738278143; x=1738882943;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1AezTEfUj++wb9EsLnlnGVNAwI7UoU4ZEUR2smrb4k=;
 b=OvryxbkmVYkfB84TCzuCb5wjf0ZM8+TUr9Rq/LDAlr1wqSGcsAgWFdvei/CPJsVIgE
 vhljXpAnHXUn+UEKKJcOoOZLtN6tiPp44NkpF4OFJ2MWm69Zn9rw79khFgqEqXw9zjNJ
 uC6U8pNcqgT6cy4oWxrG56iNY1bmLPc6RbbO8kKdjoEtn/WFwdd+bSVGrvEzsLFxszRi
 LoBjzqRDVi36E7FH6m4t1bEfFNOmv7waEYkaLE4Ceu7oFkQ08rrtYlgO93JWlP3qSPey
 4+tkNYa4j68HeqpmrjISHAlBvc5hqSHp5IG20EmuZv8lG3QdDhJp3dcfrChzFKbfSpzy
 rgpQ==
X-Gm-Message-State: AOJu0YyFmcbk3Rrm966jtpw9AjfEoan79uju0OEUIag8HyKUhii7giQ+
 8qitBOdY2L/jR0OBPzEzGm1D5cG90SR+tgbFx2YX09aiZLIMls5XrPl4llilb2k=
X-Gm-Gg: ASbGncvOdrjHRjZBUteGUaMxywK/f3KGWLuun9nn60K04NFamYWO2TQfVnnhJz6svnj
 KLuNE5/eUrKC0kBE1LQ5toBF6DM/mUQe/Shs9afz8Sab9KAe2icdMQDELANSUEqvb3XL1nnSoeq
 UeVDfmDGLHd1VLeLP2ASG8DPr+OXbJi0TWfbUA4rYAdu8KNFQj4xbfFhVkK64sJY2l8Aiddo553
 BfEaSFl/R6HjeJqadaeMs1LIIbBvDsMRgVEWUIlb4s5jwQbfaSdZV+Jg2kFWLEA2x99Gijm/Jcp
 EVB6eNrWCp+yxw==
X-Google-Smtp-Source: AGHT+IEj4Sz2a9PSThErLXjnAi1UsC0UvMD+buoKbOO0hW6JTfmSbjQtZT41NBhqpgziLjBKbksBMg==
X-Received: by 2002:a05:6808:1913:b0:3eb:5547:b9b with SMTP id
 5614622812f47-3f33c460ab5mr1280582b6e.16.1738278143405; 
 Thu, 30 Jan 2025 15:02:23 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cda0fsm564725a34.25.2025.01.30.15.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 15:02:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
In-Reply-To: <20250127145256.1133143-1-sjg@chromium.org>
References: <20250127145256.1133143-1-sjg@chromium.org>
Subject: Re: [PATCH v3] test/py: Add a report show test durations
Message-Id: <173827814169.2499127.6050019195760524065.b4-ty@konsulko.com>
Date: Thu, 30 Jan 2025 17:02:21 -0600
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

On Mon, 27 Jan 2025 07:52:54 -0700, Simon Glass wrote:

> Execution time varies widely with the existing tests. Provides a way to
> produce a summary of the time taken for each test, along with a
> histogram.
> 
> This is enabled with the --timing flag.
> 
> Enable it for sandbox in CI.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


