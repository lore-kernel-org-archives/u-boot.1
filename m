Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F40606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jktBUPIc;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=SjOpKtqq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2563812D6;
	Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pF_FIGILwnZR; Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00EFC80F69
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792858455;
	b=aNMEgEFsFDPrwRaBIqlJtSxAbcMd/Uk+H3OrMUwBMMwn55NQFC+55IbgM/x5MTxIZFmd
	 h2hWg6guJPPkHnUzJkczsFBr1sAny6mAaRWxx0Wvsv4XGHAmv1VQzcB1svxWV7Qqogryu
	 eYIEHDDxdntekp841JzVFGdWcw3R+pyQLcjyJ1qWYqeZP1DfxkAfbbUdWr0N+irAlUHOG
	 47JldhxuKRamLk6W8s/pilD06ca06SQ/WWegZ1d/GjZsZ3QVQ7cA9g6JbJW9Ddma7C0Qm
	 d0TG8xrVYd2rtVNE+BEZ37yDE05W8RziODml20YUJ7sKLZH/sdvKvwB4iCkmkfIj8og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792858455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x/Ckj1kqvGe1NhEHJbV7ndQmUmLUq52diLZTX/23Bq8=;
	b=gvIvc3ThakCwlgxm2uLAItbsgzDry+rg8e2iURDLT7Vsh6dTeSSQggpppHB7axDX3IfT
	 PcIpPInuu4OCW3fgb1ipmyQwNxSIWT/MINS8rg0O8o9oCnsrMRfhJFSdLYl7YtmBY/fMh
	 HoxRVMx7e7Y0lbg4jC6zXW54M2soSJi41nm7kZlp3hJmwGriJDc0gmseNjrBkQW9epfMh
	 L3XmmJoX39NP0OPyovmScf7T2bbUxivAo9BeyGSAetDJMQzs4S01ZusGv6YjHMIwN4CII
	 dqBcKO8a9b2R+90XLqNchZtVlv5sc3nUVYL7ieOxPy1zi0s6LWNG+c80XEJJxpRU+MQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792858455;
	bh=x/Ckj1kqvGe1NhEHJbV7ndQmUmLUq52diLZTX/23Bq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jktBUPIcDNhawXhQuOCU+wme5KrozzBBYtSMzqDYV+oesI+othyTzHN2hjHaEfFSn
	 75H8H095t+/2p6f5OMW7PJqiGUXVgAgNyMloAur3aIvaWkpaOhnYk4FvWYSC5reX4N
	 Hvu8avgOTwZoNazBnOTHTqzPlzzjoQsx9tegGcXQ1oDZdwYepm6bUdCkoxbdkPZhFQ
	 ZvVtr4f9E4WDxAeqXRVGRT2Y/vKmGeYRYNIaCuqkADBkbCO/yYik9uEUuUsoLGRZu9
	 yZvuJC8baL7KCZcUSU+r4nf1exKcrALaRFoOMDIILDQIpE3TyeHqNkoyXR0C3oQIv7
	 fBPi851Bl4rWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00EFC80F69;
	Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E16694D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D360160625
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ge51Op8w2aH for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 16:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3638A605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792858453;
 b=c4Vr6F1t5pCKToRb1BR0HXmKrftwLRo0LhkWXl5zgkhPoTPI/F97wpsiKHvEJm6Xnxm8
 V9rDfjB4lTVQRuSbK5VKJwhgXRfDYl+m/qIw30pETDqOiyjK3w2jSwUvs9FEvN4JeSvcY
 50i4CQ/mfv6bEERfpJcGgI/3Rz+n7hBhrEwS5YDIOQzIVBF8I+nGLQKPHg6VnDuibdKL2
 mGLXCaKEyG9sGYAK4FMNfILyp4LADeiy4OqSjdQbCspOEBt2e+yYxxiGJpBdeL5brklJG
 ekK6eAaVxRYWRx7UA1FM98j3q4gYc6Qjh9Vg1a3XiB/DRcDK4c/1huCLHXwpNpF8mhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792858453;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=x/Ckj1kqvGe1NhEHJbV7ndQmUmLUq52diLZTX/23Bq8=;
 b=A2PjPzUyhyvbGNvf90qusQUoDSFLXNXwFpsDLABxxymn/h+97S+VMy1df3ksEYeFdnWC
 G096HxgD470Rg/XBk1TJLYRN7fPu+JxKmzQAAGVfi6GEJ67wugG9EDlTyExEflsEqwHv+
 27HR1wa3h1PU6/n+y8NsXMXMu0t0CCiPHn2JFvvvwcQK1cELxbdsWm7//h2VCL4CWITvr
 nsGAiCpiDKnFGFMKILeRrue7c7QF+C7b+TckPG75HPysaVG0wdwwsigr1Ux2btq+AbPtl
 ZvPqOszNkEIeMweJKjOrWqxWql4Xj4d2nMrhNuNIRc+Ih3JNiw4AsbFUBY7iIKwzcqg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SjOpKtqq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SjOpKtqq
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3638A605EB
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:12 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6dd7070699eso1310737eaf.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792858452; x=1793463252;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x/Ckj1kqvGe1NhEHJbV7ndQmUmLUq52diLZTX/23Bq8=;
 b=SjOpKtqqa4JfpkJXiWqEODud7MrWjFuUCkUI6T9neX/wR0hUT2nrKaZ95yWTxC2spN
 kRdqzYW0RwuMsDCJN6D/u7kICN36b7w7xe8hc20lNCRxBOd5GWlQm6MD4h1K4KbEkkVv
 +iG153uAQOWX8Ed0f8kl0et6e43PQ5dM9PCdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792858452; x=1793463252;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/Ckj1kqvGe1NhEHJbV7ndQmUmLUq52diLZTX/23Bq8=;
 b=uObGLDPm5KtmyyDn+uepNvX3NM2Rym6gocB/VLcbFYcRgPsn9LRGinKgxvMP9uIzGY
 dw/1wgwnPj5NkEvapBYDEkP47ABYkLd0bBHNR+K4Le974X32kKX3oflFkrygTarsbR4O
 ErWY1Pd3uNEzZ0o81CYh12oxEGyYzan8ewIHnDkMzUQ0Ob9cdN9HVuRJxGviLuKsL+Uq
 UA7bkUof185ywdMXMb8E3hSzZnRTk+RwyTiKMSVL1NlBWSvCJEyPFPhE2VrK7Juvz2Nf
 Q+vxAIKaIqccBSQfVvwbZ9EstBcSq6hull0CqR1NwviiO5fBFZ6ZJ7Tc7sWaWIOsY62L
 58vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2CrSglImpn63o6AdE9g4+uHTfSt9KeC86GU+0+xhi5rFWDI5MJttRS4hsMThNMcm1tZydAtc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIvvBC6e2hVdo1p5hjz6mwfqt0oljJ3w/LgvjWxVQqgcJPTkvLn
 AH9jWrc8zPPcJ3sXS5MbF8P4O+loeY4V70A/JL5S15qEdkK5lfKJvO16WrBJsja6MjY=
X-Gm-Gg: AYBFou0JRE0iWPZMiWpUbQq2PgFDVO211zNRfDYUcx89GVkmo/aT4CeoeyOqMchaCdx
 AmoyF0mxFaJwYcGgiAGKHFXqqrVX+s9YQMzsTVnYzOlkxkFViTt89op980U/MkvlqjrDNnW7ol4
 I+/JFUyRhYasNh+sO4ayVrdKqIj8g5VBRxjXKHboF9O+mzM2nQdX2qYF9o/sSW5HNEITy9h+wyA
 9YRY6alDs7q5yJoKhVUQuTNitxKsIKo+Ak5K2WYNwTyxuX8xvUPrChSouO7tFl3ieC6kGcE7qJs
 PPHqWfifrx6xsbf7WS79qeYo3O3uPMjo0aGa3gPFS4dtSZF5izknWmvKKJo+SJLZkySstMIf4Gv
 +hcqY2Gk7zdq39/5r+dUx3uTBpBiLahicyRziObrXICyZIeR/XraqgTt/50mr5HPCFFza3SGCgL
 Hji4AANic6IKCuWfA2T3k9GAUA75GlbisROcmu+Zdx+EDUoQZmQCYMBO1PmGqlW3yrQA9WMmv/P
 4jexsALggGUq7jlLMetH8un70K/jz1+HotEQj04QOaj4zoKL2koon2TSbgRCb1oQXHqFOoerdHF
 xeuE1ONgL0NP0bV4lOSU7E0WymubbpycefxlAcJwYVAKrb7wBn8jjQ1/BEsuQkrorBrOtJMwQe0
 1jbrVmmMYMc9SjaJMrviTjJBqz0EiFa3JXRfglqJfClAvkhLUfl1hVfAw
X-Received: by 2002:a05:6820:5716:10b0:6b7:83c5:fe01 with SMTP id
 006d021491bc7-70ba0ece443mr766217eaf.66.1792858451628; 
 Sat, 24 Oct 2026 09:14:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850f8458d8esm2652012a34.1.2026.10.24.09.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:14:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: anshuld@ti.com, Ssunk <ssunkkan@gmail.com>
Cc: takahiro.kuwano@infineon.com, vigneshr@ti.com, Jacky_guo@xmcwh.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260506103053.537-1-ssunkkan@gmail.com>
References: <DI5GHDQSZVJL.2WY7OPMAER9IA@ti.com>
 <20260506103053.537-1-ssunkkan@gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Update XM25QH512C to XM25QH512D
Message-Id: <179285845006.52652.13052550056909898071.b4-ty@konsulko.com>
Date: Sat, 24 Oct 2026 10:14:10 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 06 May 2026 18:30:53 +0800, Ssunk wrote:

> The XM25QH512C has been officially replaced by the XM25QH512D according
> to the XMC Product Change Notification (PCN). Both parts share the same
> JEDEC ID (0x204020) and have identical parameters.
> 
> Update the flash name string to reflect the current active part in
> production.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor: Update XM25QH512C to XM25QH512D
      commit: 0b5ec2d91bfe6fa230ff9b65c87f3dd5fe003b36
-- 
Tom


