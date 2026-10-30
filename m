Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B138606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PD4o7Y93;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZwhKZLMb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1450A8111D;
	Fri, 30 Oct 2026 21:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYS-aN_94tP4; Fri, 30 Oct 2026 21:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52C358113A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793395147;
	b=dgpCK4XfIHulPXZzez6fH8TnhaQ/jFRkO6tqRd/uneJIkTQuRsI/TFVbMWWBAqVWuqMh
	 9p56W3DStnOjADRaA06y/eSGsUVvptsqJRIFzSpK4n4EH8XQNe0yCI33gkVpbKSyJVBHj
	 bxXEr7e478N8XaD7kvQKwpVibu6911gK0HjJW6e/kor/tVT1hxHkVjePimjiTBPWsekgs
	 krskHO0K/sy67yviDBPCXijm9d063GPIBJz1SszqendFEduo/12hGR0wrM1cXRXLTZvJb
	 930VmwkI+qgZ38YIkxlCtsyuOR2yxONXf5t7H3TmWTN0NBgx0BFT6GukzqgPrhAlPFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793395147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wl20uyjT2Bz31przKWT/cluUySWLPW664YUi1LZeU+k=;
	b=mvDYMMK6HTPmDZbqECay+Ns1r0YOSdNc0JbXbxt79y7zMy3YyCEGDk8dD05h5AE7rVMa
	 BO0zTW+wv1eoqThSd8QVeTVFbUfQXeU89s56ekOPkcwylPFL1EtsrtdpkbJkbETeATADJ
	 Qlr1RPna8InGbi9BmpT75IjsWTBKvpimALZNTDyTCEJiLeqsOxHHpd5D4byyAJmErl+/Y
	 va4Oxe1ZB7YcMwM/zQxbRHUPCV428o4Tzu89/ykWGO6SC3sAfhcLhf8wEY++DEs3OBQz5
	 5kY0sy4/mOO9dkAaHiZyuF97o5yV15aAzFawOVjWMg+/BGMXG8cMj879i8OH8ff2ENw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZwhKZLMb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793395147;
	bh=wl20uyjT2Bz31przKWT/cluUySWLPW664YUi1LZeU+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PD4o7Y938ll0rAOYW2WFs5rUVmnRcwdxMjr7GC7I0SZrLS6LUppYy+Ouc3YW85rZO
	 Lmbts1C2KWpVQLWBOA4sf6L+5K57PCxiWbb2JoJZ2cnHT/01pnvb0BOIUQeZOHQYzK
	 AOVmGPNn7Yux/o9Ppbsw1l0JPJVJ8iHHTcQEtxw/60r5TMhJ8avGYPqmlfIil1P4uk
	 eY/i5XvwZgwFs6ICx6aYoo45K1MbRvPDwork4OuVnCH2k8a4pyS8QewCRRS326iL5O
	 9jV0txuyzxqi6x71KMBRIj6XkueCEmEyiY2HjIUjmAq1ym3x5svg2kN849eD7gDLHm
	 Qge8sPW6EvT9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52C358113A;
	Fri, 30 Oct 2026 21:19:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D030C2AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C14F480F66
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HMSk3Q_XdgJ2 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 21:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 114A480E3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793395143;
 b=mUvzs4wxO8IsaXTdjjjzukhspUb+/p1k7JCPFmO3h6M0gze16LeOx3HlRsqIFFnKtasq
 s3uOUZYAFgKc7oiJnzbF77gnKvypp47ZlP6trL7pL7rcogwxXwMd84gtlZWFIsJNQPzxR
 ZMIn4PimvnUl2tVM6EHgp/bq8KkcuG+mDiq0ITz5RrB3u2+lmiJnKCKPPP60LvI5x6eLO
 VsUFzV1SpSg11GixU2sUabMS9TSEghLWMdp0vFh+txdVWbmeS8B0M4bGMdbibEojG2ESt
 51qj6mkgKViRUdLM8vGGlBo8a9PHTzDqzWclNVfB0z1+XB49vqzAy604/Gh7vQMrY5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793395143;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=wl20uyjT2Bz31przKWT/cluUySWLPW664YUi1LZeU+k=;
 b=V5HtGmDUfRqEuDvY7AkuxBCZo+twKVAxRrto5HqhINmzDG9EWQuoDkNAwcXJ7w1Ryhv2
 i7CHfpYP/c5jpXunpUL6kLAmdXWcsTwvj+olAC8M+x2pRY9O7yMvr+mAHyNbJCOfyRebb
 uRs8+O2CqF7wh9wWwXJ5jNXCGUm+DjiYst+59ATwS5nR3QB9Fj4yNDB8NZlXiQq6dCgXh
 7JMaCku7Ooy0+63nG8cfFZW+M0UIhHgQpjIlKMuZyxpIenTiHMswfbSJmJcUeXIZ6rjos
 Sxl2EipUs91emXyvnOzWLcjCshkafr1Az+B3huABaTglXo+6u17dOhMv61L4ojIw5DA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZwhKZLMb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZwhKZLMb
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 114A480E3E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 21:19:02 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-845f3fa7f38so527313a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793395141; x=1793999941;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wl20uyjT2Bz31przKWT/cluUySWLPW664YUi1LZeU+k=;
 b=ZwhKZLMbMqDvWmVqesbQGcAS5xdIys2mdk7jr980huZiloXNQusWxYRyiu7DHN8Sdd
 ziMl3efHPhqQe9bbfsSiJ5AcUnKHjb2z9QoPJco3+2CGkn0+fpEae0yJtCouFj1wIOEe
 u5JYSq08ZyG0Xo/AacKtXVs/0LPZq1PwsYPLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395141; x=1793999941;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wl20uyjT2Bz31przKWT/cluUySWLPW664YUi1LZeU+k=;
 b=1sheRmyk8AaDHamx3e7ahzH0G+TUxec0UuF8yvMQKrItXkbCa7M4yE93LUkRjjZSfj
 5AtN28Dpao2it/yboESkadhjH0HctaXTNUDbByzcUlG7SxE/mXFt9TBB2TOR3sgeYq6U
 lyFCkFH4IewEbd/kl+SbAmH7WZLUcSqpA8jLa3UZ8JUE555KsGR8OONZMxyeb9kECi70
 2hpGKUfzoxaerivqHjntB1U/ZZrFi0XHe6qmidskTHcOdwqTP653wcjPgz9PG2RIr8Mu
 6nObEdkyCfbyfXVLkTzfgqoU3ZyV7iu+M3g+tYwrRRb+xxW91M+U2B3KU1ks2KDsjAQL
 7TbQ==
X-Gm-Message-State: AFq9FYJxnN+0nF7FuhHYlWZC1xYBsy4hoB6WqBvwFSyKZZzbMdctoQ1k
 jLJ5oIJG4X+STAytIkp288/TvI9jvGSdUXfcX58EKmE2M7ficJV89zDZdfm8ZQUoYq4=
X-Gm-Gg: AYBFou1N4bRK7tpIIANYdwaa+/T2jWIG4caRngqaq4HPLHogpZx8JmowKsuBsT2/qpS
 fPjRybaAdH8QtDiotsg/qXRXZABQBGF8jSsZz/b19J0AwTCMpBIYOezDtjwFBxrin5orNINwIDc
 oO9jN9TwIM2M4B090VFpgRz+c1zKWAbimZUhqus/TcRtBWqQPWgXkOtnd9qTEO0lyBPXsIxfeTr
 7f7eNbAUhT4BkwGrHZpZN5eR+BrjemihHd0pGqF/OVb/5WkUWodCiMXLmM0lO5rAP2R7tjm2bA5
 cIZc5xuiT1y8MdxzH8rRF3npXhLgER4t+AUlPZAQHHWJdybkG9JIJ/Xfn+PilI6Oj+8JZkalbUG
 m4ithUligHKO2ivakDTXcGMv9SlVYUmpqbMLFH+huVV0qeqi8+Wag5M7heKVLVYNd2jj/NMelMf
 i/GKN1sNnm4R7spEbj8xsatvUehd77xgBssDiDT77/BHJJnSMsBybZ5pOPdX0WLa6xN2SBo/d3J
 6+LGYe/lgGVe3ludD48TK7anZ2KB1BtXlR0zip1XAtqghFevK08W+mGfq+RHf7E7BR34r4FJk6k
 58Al5um8iR8jTU8NloOXugDvr5M7p3CDh/aVLZNlCxiGzuXhqpRaY+/4YnR4XTC/wPofQd7mTjM
 ziioP21h5C6OaqqzYzpD8zuSqo7iOIRMULnwOSBeWGhJwrRa1wvHMIXh1YFWGlQNKQR7eMsPbzT
 X997NSjIQ81ptaXRF40d8VgpVEVh5Gog==
X-Received: by 2002:a05:6830:640e:b0:821:a94d:3b51 with SMTP id
 46e09a7af769-85d36660667mr2490264a34.25.1793395141633; 
 Fri, 30 Oct 2026 14:19:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm2829799a34.22.2026.10.30.14.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, michal.simek@amd.com, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: git@amd.com, padmarao.begari@amd.com
In-Reply-To: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
Subject: Re: [PATCH v3 0/2] scripts: dtc cpp flags via response file, GNU
 Make 4.0 cleanup
Message-Id: <179339514100.3804820.2015981666227142707.b4-ty@konsulko.com>
Date: Fri, 30 Oct 2026 15:19:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 10:19:06 +0530, Suraj Kakade wrote:

> This series raises the enforced minimum GNU Make version to 4.0 and
> fixes a dtc build failure on long source paths.
> 
> Patch 1 raises the enforced minimum GNU Make version to 4.0, adding
> an explicit "GNU Make >= 4.0 is required" check to the top-level
> Makefile, dropping the now-dead GNU Make 3.x compatibility branches
> and documenting the minimum in doc/build/gcc.rst.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] Makefile: drop GNU Make < 4.0 compatibility code
      commit: 14f5984c276aa04f610b916b1df6d4cc1694b723
[2/2] scripts: pass dtc cpp flags via a GCC response file
      commit: 334d8ce83af208d35298bd756ee46c407b4649de
-- 
Tom


