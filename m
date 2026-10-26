Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A79606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pBPAKqVB;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=GPZJ4TY1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4470405D2;
	Mon, 26 Oct 2026 00:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUEJPdhO0oyG; Mon, 26 Oct 2026 00:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED9FF405CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792975280;
	b=IBVA1ldl5vxF3+BWOgkO0k5bWjqMGmwZo6QwSbCJ4LIuHDHWQlwEWZ9XTy+k1LITczaU
	 RWe/YRqO/xtHqrjZhPCGRnrkJGdM/CvzrDDRUrfxKOsGirMe/h/4a+Tkq9kIvCwNI8r8A
	 /YJB4Hc9wNge/Uc8TcMlOaxgc21fI5aGnj6yAGrhmaI8IsKKKzbHCtLJ+oKgsp7M6FyvI
	 Sk9Zw0JpBE1cMmJ8DF5aPjrNH20QhJJNT5ykwYmV+SuAzsBix3CHW4s9Yttm6ZIXEkeut
	 ZLe6W8MgJxOkKyUbcgxWCK2wob1KHH1dgcPJRnBktD7cdWPonsh2LEh7iyihqu6Ze4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iWc81igRxYtxhGPJXzJd+ZxXbCY3I4/yx0dEI3aFNhw=;
	b=MOcj1dJ1BOKRmN2yqfyzDDtRO5TyM9F37/sJDVE+uqGioBhBwwnDjKsQPfpvfwjNVdDd
	 DFTh9bQ4oEywsrfw2azOnvCDuicN9vEmUHV1k2kqCg0BnHqUr+0sKraD3sCdUkYMzMwIb
	 3BfkBUdyNAwGim/yOFLi9o6Tp5gPMs9jBn6XbnJfzIbv5T5S5D8q33kiRvtcValC544/T
	 fFARJYI8pT/Bh9V340eHk1Z9Oa16lnadePkNFrvLB3afGS0HbE6vTFs5JDsTABEmQPi1s
	 GwX8G8sEa7zv4bXypqm2TP3Xy4rQ4cpEReoDn7f89M8vMgDnylJ09H+PEWVtOstqIYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792975280;
	bh=iWc81igRxYtxhGPJXzJd+ZxXbCY3I4/yx0dEI3aFNhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBPAKqVBl7ech8JrJQkUk8k0jIrZnKoXII0ssg4wOKJq2UMLJFlsmI3HmLMS4dXii
	 ZfspfcxAH6VHXuxx2Y9pNrfI+Zk7vpmeLHVEfYR9fp5SXsmlcUaswyCs42r9Fsb/2Q
	 QTCCtQsonbpvS2CAKh+Zw1cbUKFVJvFTFqGriM9eMeWAA7opXtcvNULwq3Wtk8mhhU
	 FJ5S+08ipb136MijhfnsYFdS9FHGYxxaTTH1NKWF6JEm0jXGc1Tt+V67iCVEQ84llR
	 cYE4RW+DkSTHhJpec1tqaDx+cEhsYAMS/2ATHBEXJtW3G8kB4Pn3xFLelTm7IxoVac
	 xY2tB/zmBSF1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED9FF405CF;
	Mon, 26 Oct 2026 00:41:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 95048334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86BBC40098
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XM1biqv_5Xm for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 00:41:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 761E64008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792975277;
 b=pNmBauSgTuY5hNwdNE2nU94phSrPaKc+KQ/gqOWrdHsw3gOCYXhPWXUJBCOEaiIMLIma
 HxswNpC72EiOASjaMQtLmFcWLZ3+7Wm01imj3QQB8xOcYGuNbYjRKfbiVlKcWESsLEgfJ
 NEW1VofTWIsU7PEi0Uw6TxpChcQZHt0bai90Mr9Shx2LJV6YghZGMkuFmyoAvwJO1SiRu
 eLuV2ecqzLoE3DTq90MdU+imEop8nmTvtudOX6jWxfeLeTYqdRdwAr5Y3CxIgb4Uj5d7Q
 lXWxuVm/LnwScuaCVrV7sm/4KcXmh5j3Ckx6HEW3bQoTwBQ/dIZL7nPz4rccnvWyKmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792975277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=iWc81igRxYtxhGPJXzJd+ZxXbCY3I4/yx0dEI3aFNhw=;
 b=V1RvN1rGY9mPv1SgN6wm0uMWvpPvjhU866gF3NDMot9axgD/c82aR6eOSUbJh8JA5Ojg
 0jlISehkpo4Gi7wYu6GV1hkf1F7Ok8kk/sbiphVgC/BtegYlwild73eD4gR5ZmVBY0W7S
 RM0rFAtRDDajS84X5zorUnR5dkZSavczspeBw31kMV620QdWcMlCr6Ql542SCpttIf4EV
 78L+U0kdR5iM23MV5g2bmx03sI5GK+KA932PNUGs009NSH7KBeyu6eXz3P/Gkgg9aKg1T
 VUUOBSaSZyWlxluFm4UwftoBx8GJgPYmi5jBqWXtqMyLZHv34J9jhd+fE+qf2VHbppg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=GPZJ4TY1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=GPZJ4TY1
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 761E64008E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:41:16 +0000 (UTC)
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-1517bda04a0so2508825c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792975276; x=1793580076;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iWc81igRxYtxhGPJXzJd+ZxXbCY3I4/yx0dEI3aFNhw=;
 b=GPZJ4TY13S8xUeXNAJVHeIHoafPof3OfMebLVbYCOREm9Ld/Dn8rRBHdNsGNJwofXB
 jN4zUPeBlQtpw2b6qHMiT9onxji7bLuR1YXIH2GA/YCb59pnnskvbQjZeE29Si99gzmh
 nUoGDlubbXwzJuWYc/+QY6jmwLg7yyfTHFny3Uzh9Tkr9ZCPy35bweOt/siC9/RevAky
 +bhk6IRKWNtEFbT5MK58Q1qhK+S5931P521v1pp65YtE/0kgGoecOj6vjSFKENr3cJhU
 A6XHN0tADd5Rpv5Im02tg1mgCmbYMcgDIdTXt4SNs/jmOGWSFO4Xxk7ns2l4hXEwW4vI
 YwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792975276; x=1793580076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iWc81igRxYtxhGPJXzJd+ZxXbCY3I4/yx0dEI3aFNhw=;
 b=PHU5HHO7qoR1vHk0UdSfGlz8Y5ZwI1Vu67V5SiqsVas7J8fpT/Mp/Jf6BaI7SPMcfP
 ezWhnwoPgC7wGknOpWi4SR5H6IJpUWpFVxTlk7lw7LBGcXz1dmS7CAYBaro7680gpQFa
 /jJgk7zxd/lWnrdx5AxkU7vEZVQZCsY4vMa5TqbLEKAnIYraqTflfkO31bM/Om08s8Hu
 LzMJk1ke2hHDoVVZRFHfE6wW4rBpG1dIk9WQFRR8kEeJUNtZt1iuwQrlXNh+B951FOEx
 nnHRBuUEHbGo3D2f9FKe7sPh2EMxTAxxGPunpfQdx983sO6lmljiHln3i2+dd33k7jTI
 H2LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz80KMsJlG6v0+rkiggsJjqyExlD4FPTRcQsjztEeK5vH6Wf4nzxVOjmYLixZ1inua3g2eclKE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLqwgQtL8Ge0JZeQhpE4Q/lX1CGudgYykFwKdDjL9a49BDqLgBc
 3ORePuvUB3dqS5DBdrrKqtxoGMqM+Ft5CZbQ73c5lWhv35iTaS+OLmKt0jEhSul5yhr4SfM2tjw
 F7ObsYa0=
X-Gm-Gg: AYBFou0GYPkzFaFCrii7BOTA5To8V7XzqWfiV3lYDb9pZwV4ZsHGWRFjwQKOTWplGZV
 rAzJFZl5sSwACpWZe4gd0YjNFHwbANdKffSZZ4fXdp76zuS/d/+LE9z/JOTz/Aq3BtayNbeHRHN
 MIbOKfTQ2TL0rYYCB6HGdxkWMArUzCVEZz3EFhJrffg0B+xHolMTrGlFCXr6Fdtp4khdlCG7qd5
 x50M2xRbkFR/qtrVBks9+/jOcF9tOZaw5+eF+LMtMtt8WvV8WZ8WlsXsO0QZQR/KIW2KOzfpg64
 Drbn0VLcQdLwbeTnhE0r1mIOSb/tITUjd922pIq419/MiGL9ed0wWkxTauDv2HvMoaY6KtGCKtx
 mYZTgqPVCeCTZT5CssjzpFMKgUCICB5CRQ8HmfJN3Jw4+/xXWlESerld230S55E9ylA2JqJ0eJR
 0FnQs+Z3hE2FQGJ1UrIu5KNoRWKqzSvkywvCRv4QBnbXeqfIE0H4ibUhREAnUsMGYmL5acDR0Oy
 HyEa/FzuS2WDzMw6lWcXuxp2kHsQtmjmwzMiCJfM9qPQpLPMX40yXducTSrNqOh9c3+YLzv
X-Received: by 2002:a05:7022:3a09:b0:195:76af:b810 with SMTP id
 a92af1059eb24-19935fc69dfmr9391650c88.25.1792975275924; 
 Sun, 25 Oct 2026 17:41:15 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm41372447c88.17.2026.10.25.17.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 17:41:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:41:09 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arch/riscv: Allow booting from NET
Message-ID: <at6hpaOpeblVMLdT@lliang-1876.localdomain>
References: <20260904-riscv_add_net_boot_option-v1-1-125c3edbdb1a@maquefel.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-riscv_add_net_boot_option-v1-1-125c3edbdb1a@maquefel.me>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 04, 2026 at 09:19:05AM +0300, Nikita Shubin wrote:
> Add RISC-V spl missing NET boot option.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  arch/riscv/include/asm/spl.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
