Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D524EC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9AF8857E;
	Thu, 18 Apr 2024 05:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hn+Jho/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C529A88579; Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E40988527
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78f103d9f64so2097685a.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411612; x=1714016412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R9zC7nZ4pHFIML+IO7tI6N1TF3rUuiS1UIymEjr4C4k=;
 b=hn+Jho/4wWp4vIWt5LaYTiS2sfPcgn3oIkYZNKxn7BTqES4bwjoqajfmEKeDecH8JC
 jU2DLVfT7zFl0gC2C0VGZP2KvCHge18gwqz4s/Dbhm0K0YW3+K7uJOBm09or0Kbj8c3D
 kTBJgF0TBZBnY1HTkNDOz3GFicCMDbZzwmTg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411612; x=1714016412;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9zC7nZ4pHFIML+IO7tI6N1TF3rUuiS1UIymEjr4C4k=;
 b=pMlDPwASsJAtPGUVhMEzRqiFJVZe2vwHGKYKp2yQ1/g5f9IZgYS98fh86Omwa0p50h
 0xrXig7YB8iZIbZOmeWI/rBDddLbl0MEAJvrbIXgSjZ6HhYpfE2INvjbL83WfqCjAZ32
 1Gat5b4AbgqhNG7YtRP9/76d6viFes9PPhKeT+DyNjnlkEdKjzelheOu+qk+NyMkgfoD
 AdRmZuOI+X08N/Q7fhvyioSDLiIKch4bSlW9Kus7wJQ5jINOBNiUjbV1Y8NNNUzoBq5D
 kEveO4Z/V8rnctvuNecQz4sp6IhHOdjCkzWcoQy2CHW8ruSaMayyWIvEBRQVr8LNM+8N
 ZI1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdydEaaJZMyChgECDnhjLlVzr0eyC1xoyeMJFWdv9su81NUJCsUV8cGt60nbPomxiKckQNYO5vP3MA1L62EVWl7HHfUQ==
X-Gm-Message-State: AOJu0Yx0lo1kCLgwAsWQjaqgOkv+ZNJ3cwHUtdTm6GeM8xrO7pdlDfQA
 zCZMV6/S9YobimJMY46CE8uvmG90LmqK5P5wnRjrwng3vmnziU7sKKDAKgjZ+ok=
X-Google-Smtp-Source: AGHT+IHef6e/s6WUV8qAefxG4Ot7worZOhj9g2pCh2RV1LnoEf4tjYHXa8qGIYbRKMg5nXBhv++hGA==
X-Received: by 2002:a05:620a:16ce:b0:78d:62b1:76d6 with SMTP id
 a14-20020a05620a16ce00b0078d62b176d6mr1840186qkn.10.1713411612327; 
 Wed, 17 Apr 2024 20:40:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 =?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <xp66c7g532kqzu6tai7enm3ribhhvftsr2o7uqfv3qmodcxy5l@tarta.nabijaczleweli.xyz>
References: <af5db6b1165d5f800f21463592779f8e@manjaro.org>
 <xp66c7g532kqzu6tai7enm3ribhhvftsr2o7uqfv3qmodcxy5l@tarta.nabijaczleweli.xyz>
Subject: Re: [PATCH v4] tools: copyfile: use 64k instead of 512 buffer
Message-Id: <171341161129.1250683.6018198501710683659.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
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

On Tue, 09 Apr 2024 14:14:34 +0200, Ahelenia Ziemiańska wrote:

> This is a trivial but significant optimization:
> mkimage took >200ms (and 49489 writes (of which 49456 512)),
> now it takes  110ms (and   419 writes (of which   386 64k)).
> 
> sendfile is much more appropriate for this and is done in one syscall,
> but doesn't bring any significant speedups over 64k r/w
> at the 13M size ranges, so there's no need to introduce
> 	#if __linux__
> 	while((size = sendfile(fd_dst, fd_src, NULL, 128 * 1024 * 1024)) > 0)
> 		;
> 	if(size != -1) {
> 		ret = 0;
> 		goto out;
> 	}
> 	#endif
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


