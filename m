Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538FC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE4182E35;
	Fri, 27 Jun 2025 19:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DXhGPj/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BDB82E8E; Fri, 27 Jun 2025 19:39:53 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A22B82E08
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-404e580bf09so45262b6e.1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045985; x=1751650785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4SMISfF0tVQirHtvc9Rc4JmHoojs1gS6z60yTecEtE=;
 b=DXhGPj/I9nIWaw789NKaPZeYoiEONE/1+TEv72udqphlT6G/6KyevmGMU56Mo30aov
 aPZ75Mc7oz5vTaULqJ0xtOspYPRZ4u7c8Z6cjpFvLSh7aDbplO0mqvmOFyQKxxuV73SN
 zp9LcxuSzz3S5blbhj6KBYW6OyTE2vSokp3bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045985; x=1751650785;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4SMISfF0tVQirHtvc9Rc4JmHoojs1gS6z60yTecEtE=;
 b=XkQqlbklEW4Iaf8vManSRo6GKMlFIu1oz2Mzxm2QmtvzHyBH7X8oTxmMmhb/o1eqco
 BPiB8+MS1up6KEDj0P1qFPBDYpkQ9ou0EKTN6FijNNsyb7WJDCwGSmzdlkql53k3mCa0
 xCA7HVLdPCRfaKUgmRKNOMJhaASyXRbhLTE0C7vx06A7lvcppK+OQeobRHeTmfwyUvjK
 nZgXak9VrWFqammlizVaytcRGMC7By3wHyRXuljx3u+vDod+rw3j38NNcwFo3PU47Tsx
 3yyCTEpMP1hSQ0dkGvsECm/Izm0ysZZFumc+mTI/oUiXzkQ7OUf8yMMUvwtmTxkhaZ1O
 Oo7g==
X-Gm-Message-State: AOJu0Yw4G6YIeXI6pRO4sM+PhH49iK26Oknn5KMXOMj7L0lqmmPyKBKc
 MX8REb4txsZaqjweSevJBBRKz8ikaJWyUEud7+g3JQwI+EzMoPGJnrdzfRHVT60VmLi6VBjoL2y
 625tJ2iA=
X-Gm-Gg: ASbGnctkrFG4T9HTQk9C6F1sdQVcWans2Ei+D9MoV2LzTg9iciMcNKqYGdQmi6WFLr5
 dth4QNPgq1Rh5MWYunpxPlTytWDiLrnEvHJVTkQnYbZ7jQEF+cIxZ6IB2MkopHOsFXSkhp5BGXl
 nwceqC+c27AN26O7mlN433BhGkNd+lY3Ue9K1SyMamftlSqaYwzOA4G+TujsiwqINML7vKYaQzj
 oSzRdDhtK0FBMEgnu+l5x12CrOCkn7QtiERjEqjPXWOqsM/pyOf2KIY7VwGVyNUAqql/0qB+UiS
 s2xzyFvYUXSQ+3Ge/8oPcVF+iwYV1uIVEb6LPamQCJNQiwDmP59J2wbhT+4LQFTrUE8Okk7ZSh4
 W6h9/nQClQGIym9+wEK8Zeg==
X-Google-Smtp-Source: AGHT+IFjlohbeH9FyBNqi14+0goLwaV9diphyXM70MQJgkoJtz6C3n4kMF3OflU3wNKupYK2ZKbHoQ==
X-Received: by 2002:a05:6808:14d3:b0:406:6671:6d1d with SMTP id
 5614622812f47-40b33d79c62mr3411208b6e.15.1751045985319; 
 Fri, 27 Jun 2025 10:39:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250620162502.3419508-1-trini@konsulko.com>
References: <20250620162502.3419508-1-trini@konsulko.com>
Subject: Re: [PATCH] tools: rmboard.py: Fix conversion from run_pipe to new
 helper
Message-Id: <175104598465.3877702.5422272073108171897.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:44 -0600
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

On Fri, 20 Jun 2025 10:25:02 -0600, Tom Rini wrote:

> When this utility was converted from run_pipe and to the new output
> helper, two problems were introduced. First, the conversion for calling
> "git rm -f" wasn't correct. Change this to match the other conversions.
> Second, the final call we do we need to construct the list because we
> print that command for the user to use to inspect remaining references.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] tools: rmboard.py: Fix conversion from run_pipe to new helper
      commit: adb6e0bad69dc6beb233576ada1ec8de5f4bde65
-- 
Tom


