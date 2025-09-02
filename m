Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8026BCA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 22:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA74283390;
	Wed,  3 Sep 2025 00:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IUyvmFCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCAB833C6; Wed,  3 Sep 2025 00:57:39 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCFD6832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-74549616950so3999341a34.1
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756853855; x=1757458655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5QlnHbkvVJv7Nr80HOZInWJMXhdkxRSkZ0eOjZwipvs=;
 b=IUyvmFCGWP2zZx2GYFnbfz59IglTYE7DaZqA/BdzUsrM99f3eiT/f18h+RptDxXCfA
 N0cqO2DAJ2c7rFX3cTUmqwm0jx7xk/4FM5YEvISVEQ6w6fXCi/xbjq+MFXVdqho8i7Nq
 8z31iDtn495yj+X70gguGZfA4/uvJdptcugi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756853855; x=1757458655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QlnHbkvVJv7Nr80HOZInWJMXhdkxRSkZ0eOjZwipvs=;
 b=Ub+Z3ff5dg7zqj9GjBHMytVkNp1Ojms7KG6Wr3UTV5Leeuk7PHtx/+Coz03CzkUYwX
 tIz32eTIjIK06+VRpTywoxRyWHpgaviMKKMeA7GoDzZW4E7eQ6KTio22tydlDfG9A0jY
 0nMsbCvkqATxzYVr/I00EDKvCAkcdcMJIwzh4k5aurtv9hNHuZis+ItcyqeoujZ30hcv
 0H4Zta01cIDAST3/jDVZC6jMiml4lhQfcx5+882V+u1bZjsHmQCHBf3QdqNFXUd0LSqK
 QndPifClNMsawO480JRZwsTyjXVYCRpO8F3jnyOK7whdc7WyeA6ctjgFGCdqn9HF1O6Z
 Ku8g==
X-Gm-Message-State: AOJu0YwQap47B3BMOjHrONXoS4sW8cZxqA0lu3YQIiJqyrYladxkpdtd
 x5H5qBKWR4tWFsHfkOUyDoHh49Pq9H7XgZcfrwSKNHR6MUfNkQMrb8Xh3dfkGcPejmsVwKeW3jh
 uHBeYciA=
X-Gm-Gg: ASbGncuIP8IgMIm42Od0RloESsZQsSjMQXAZFuY5WcmE8deS+0VG2POlcjJPwWLv4XO
 mcPoN/oF9KXsC1m8au9qAC70IBPArgje9WKcCXAIkygxAZXM3ufFGfd/pjvAOD3nO10+LYPbCjh
 IQyjpHRWcyRGd3TdTKZCOkOIdpGh6msrSGyJVy5dcGHfvEx65tHzMa6o5eBaybZPnsZedp28j1d
 sFCdHP+s53B0+69wCynqWWN17Fi70Jbk5wvsPArF1VjCsBpnQO5mGYaGic6WjLrk3s9ayuodQN1
 d/1QEYsjchcCvtR28G1SD2xvT/vtxUYwGThMZcn0rZWJpt/1AirNIAViDD7WlLkFHNApoQ6Ody8
 2jdT/Gz2wffs7v0HVGZxhm9VGdyIUtdefrXFCfCHMAAfc9UDO+x3KKPY=
X-Google-Smtp-Source: AGHT+IENy8f5D77evegbBkkZ2chj1ixy/kKQxM9menWALA2/xaUF85aXOeIhGcSGmWQ5elWVjkCM5Q==
X-Received: by 2002:a05:6830:6a15:b0:745:434d:6283 with SMTP id
 46e09a7af769-74569d94ccdmr9592381a34.3.1756853855534; 
 Tue, 02 Sep 2025 15:57:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457439f0basm1881854a34.29.2025.09.02.15.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 15:57:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20250822181848.3325832-1-ravi@prevas.dk>
References: <20250822181848.3325832-1-ravi@prevas.dk>
Subject: Re: [PATCH 0/3] memtest performance improvements
Message-Id: <175685385466.3367307.17625061308614630860.b4-ty@konsulko.com>
Date: Tue, 02 Sep 2025 16:57:34 -0600
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

On Fri, 22 Aug 2025 20:18:45 +0200, Rasmus Villemoes wrote:

> The first two patches make memtest run ~40x faster (when, as it should
> be, dcache is disabled), with the second patch being responsible for
> most of that. At least on the beagleboneblack which I used for
> testing; other boards and configurations will likely see different
> numbers.
> 
> This is for CONFIG_SYS_ALT_MEMTEST=y and
> CONFIG_SYS_ALT_MEMTEST_BITFLIP=n; one could probably get a similar
> improvement in the bitflip case since that also has a schedule() call
> in the inner loop.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] memtest: don't volatile-qualify local variables
      commit: 86c5c25b6ca99025ac8ebcbe5c53ea0f398d1f44
[2/3] memtest: only call schedule() once for every 256 words
      commit: 835915bb7d2b76d7e422b6d60628a0f7cef30ddb
[3/3] memtest: remove use of vu_long typedef in mem_test_alt
      commit: 42529beba5a262992b53893477e0de646c1754b6
-- 
Tom


