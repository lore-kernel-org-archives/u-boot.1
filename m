Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36893D339BC
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 16:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B59083A24;
	Sat,  6 Dec 2025 17:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gD8k7m8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C71483A3B; Sat,  6 Dec 2025 17:12:29 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297E4839F1
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 17:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c78d30649aso2726074a34.2
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765037546; x=1765642346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FODOaCB28Ao+XZXMuwx8WlEgieu5YUADZ9aiedGEbKc=;
 b=gD8k7m8IyN0xvNRv2RhFH1URnfarKCuvzhmUJXinxD2aaUUXCf90kmbB4faLp3w4I7
 MbhN6Vq6v9AQbdKMTi3+b4tCPeCJ/bmpsy0EQT8ecVSIcnCsu/1DQ4vygXTngKbKfx/Y
 w5BHwBcXQ1MAHD2CyoIBG/ltfP3QgPotPyEeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765037546; x=1765642346;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FODOaCB28Ao+XZXMuwx8WlEgieu5YUADZ9aiedGEbKc=;
 b=wxO/kQ5FVF9slrIqrpB9sTaqKEQ6onV/OWagwkSDDVbwJjewLnAYfRZPEodblTdL/X
 i/eooa+HfYQfdNx4n/5gqAsjISMTj5UrD1GjtsRyueuw99iMt/xei8q6dtcceZzjqRtz
 BnbEpLb/ADhB7TvtpJ+5HLDB6sh3oXYskqtyVs5M5xcGx7up4XXzNLUxmN0e/ZeO8K0e
 iNEnUM6VgvIFtdCNjaRb7t+BIKdujPBzg/3lw7s+ff4iKOxenPG5qGmLCp/jw2UV/0fX
 ehmmVmdIApVsOXaWpLLYRwmliwiqcIQsDW0ZneXEwPdt5V5+dhKnBtxgVpHW7UFr5XO/
 zZmw==
X-Gm-Message-State: AOJu0YypE6R1fkYzpscMTQhKsx92nmezsn7htnWOJ/7Ad3XjDDwvs45n
 CVXR66G52z4fsm9A9l/BG2sIMcGHfk8R+tehjnfF/dOoBU3n/1q/2gVDlTf74z/LaS4R/raAniA
 jfQtuw+U=
X-Gm-Gg: ASbGncvn3dFY6Rqk8neAfOtCu90kYSdWZtvpXId55/my0s3eiSOsERYlpYO8FkNd47o
 x7OY4Fa+b8kJt10NNWNLzZpeR+y1ebeDbpaAyyQN7A3ZTNA4KhqN6vkD3TOMJBVKy4lrfZHYLEK
 ixXF97fxUBxUaXDbMLDcOPYaCqtGYKKohz+xKPS9OZz/jBI7InMBrvnzFSSjIgRTGrF+4swZXdj
 k2tfZa2Usjra3OZspFj3BacFvNUksxIm86S9aG+GdMFOhKRST2CJ2kk07G+Tkv7YxIF8tmlthkj
 UJQxa/45HuZU9IbNePlmngmFaG780LoXdly0VXJpBYrtqNUSQ8sAGK7BUKtOWa+HwtHMo1Tcgec
 l1szA8KdWbV0uPlXAQsOA4jXh+sb2hYMJF3nassMj9JvOI3v8DCFSNVzjOlowJtGb/PjhZuv+wZ
 +3xCx4KWQSi1J4Kt5jznecDz5QUpS1pWy3wQKpfo6QesQZYlg9LYI7Kg+s7tU=
X-Google-Smtp-Source: AGHT+IHrpqYzAal8/aQnwEBxaDR1QTma2E3wWE/E9Q8wEVDjyh5EKDzoy3P0ZNGVgEfBFHMckTyHsQ==
X-Received: by 2002:a05:6830:448c:b0:7c7:64b7:83e2 with SMTP id
 46e09a7af769-7c97083d179mr1691948a34.31.1765037545896; 
 Sat, 06 Dec 2025 08:12:25 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8fa21asm6946180a34.1.2025.12.06.08.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 08:12:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Linus Walleij <linusw@kernel.org>
Cc: David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251205-linusw-kernel-org-v2-1-40c8652749b2@kernel.org>
References: <20251205-linusw-kernel-org-v2-1-40c8652749b2@kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: update my email address
Message-Id: <176503754513.2614327.7805558596533159407.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 10:12:25 -0600
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

On Fri, 05 Dec 2025 17:01:38 +0100, Linus Walleij wrote:

> I am moving over to using my email address at kernel.org.
> Change this in all the affected MAINTAINERS files.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update my email address
      commit: b5d592eff12c8a7ad6a8d88573faaef0894f00b0
-- 
Tom


