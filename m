Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220B606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v/Aq3MVO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=e5Ez+8n1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4121F40891;
	Fri, 23 Oct 2026 13:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7av28u6_c02; Fri, 23 Oct 2026 13:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9115840632
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792762229;
	b=CPuVyT8gv4HsRd1dJWre8ls1ZIEMqx9+TYetPK+XCe7XVwMhUGhx1Oxon2us+bZjGjAO
	 MAM9mgY6Q7nQUP8UuKywcdQ92VXVCLLRFo1H8luGl3320zsYtMzHJGkrqCtHDItvOugcT
	 HegQ6rXnDiCvMGj9ModqZ527iLf7k7yFiIBrNO5FcOu+N07rC8UGcpVrP+uTH8VgEkgo8
	 MpBt2N0o5qq+cqpYkUkbOOxkTYWvlP7xpPAwVgqojWPUE3t4WWWY9SLX42Qnqa9+6PtD9
	 kKJiKRUdIGYASaqEH7FUo/NJyMsAtIyZXn/WK1HbnmU6+hs9a7HYkC4PW5lcRZnwMjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792762229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BlUJKATv/Oq0PQHYCF0C+U0OM5YkB+3H0zepyfOty5s=;
	b=FDCygEemw766QeonzIWP2irx5PTuQAe7XkjJddxovVdPuDFkNahSLkJbq3pM4AtEKV3r
	 +ukFipS4R9Ni9udf/cDuYKMb2J5MDy5+HlF0/s6pyLW8gkO1het59VOBmBHFbBf2ojIsH
	 hn3QnNv1vH1Oji+oPzdDZ+u+x/EI9vwDoLQCbF+qSoQv7hbHHhNL28mPVd8wxuCQr5YH8
	 mlE6E67J4XP3B3YsuVHWfQnYdKPQCciewjl+vBsLCFw4PyrKWLTo5aeWJWMfDeVh8k9r7
	 ygviTFAPP4ZP3MZLTBu8VJFTsrcO4x0S9d7oEipkVCoAnUJD3rgzp4aeiLDV51zbxew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=e5Ez+8n1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792762229;
	bh=BlUJKATv/Oq0PQHYCF0C+U0OM5YkB+3H0zepyfOty5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v/Aq3MVOJGWCLLR0/9Jv0os1Ma9usNgP7VKoXlTbBA66V6TgWdDQW6a2DMDLeqAB2
	 /HFP1GhMehaSREsY2Ewkk46110nQo18lPATwyPbo7WLWKr6BKMvLzGV9YOgQIw7Gc8
	 nNmg34439z/Z0WNGsIV6sgbaa6oXIJi5VmE2Wym/Deb8JmZ0gFXWRc3dDxL68TrxEv
	 W/9k02EeXNn51Fld6JcvReI9B+siAlw/A1UM+DtgnrYHm56hqYYD2sIApG+z1LHpmC
	 YxxlX4VC85bou+OfydRSu9Szf678StyhE8XUvUACThQ7gr5fNqD1ZzDF1GbqK5KNP2
	 keYgkcV4TwC9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9115840632;
	Fri, 23 Oct 2026 13:30:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 16F18235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08A0F40632
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6FQs_ckhgcz for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55443405C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792762225;
 b=nr+7MO5RB+ZjhQqhSWXuZONDWYyXu7m0nhJkA9mWQx0J/0ey1YBxnhtGJ2E77bUBAq0b
 yXp0z3oXaMq8aedOR239yeTVMiqd7DUhHVdYzhMjm+qjRa85MFb0yTewnSJIuGCBa5Ebn
 +IE3CEvXzhfxjoed8tDcvzKiKuoGEUK+KwNmEri5htAcTkifjtlP5H3GoRUn0mstmyVAy
 FYj/SVUHm3AzwgAWW+SE5ZFNWi1P2Z+6krd9X4u92D1LMavWwn+OPhRGsvyq/Do5HfPN7
 zrvNqCou0pRNcJF1ljWH6E51O/6YstOZih2930VfkiDuIvMi3TnFJZCSjDxYdC3mPTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792762225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=BlUJKATv/Oq0PQHYCF0C+U0OM5YkB+3H0zepyfOty5s=;
 b=QzIAu+gIeH8gW3zZ1QN0i0UGHCtPG044pcIX/ncGNKC1mIZ/LyLDWTS5QV1V43zBZWzf
 XmNGkSLgr8L8v8UsQuWdf1rarHDJoyw1jzTVssMLRWkS89uedYIYDRV7BVDZc2mCbwvdr
 THqsK7d21iskt9MlhIrET5LjqjN3ewaTsWRP1O805d340HTF1uBVhJArOjk+BzvwiZtu+
 AqWMd+JJw6vF31vkkn6mkDMjphCUCE/TP+efqdvVY4NFMNWkZ3sSjhLVUz0GS66rhtq5/
 HpqNzjVhjrqCSKn7hd57au1O/HIRruR5eFffdV349maj3BrmuIV3ozM5ZfQYvT7n2OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e5Ez+8n1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e5Ez+8n1
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55443405C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:23 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f432ac553fso827298a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792762223; x=1793367023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlUJKATv/Oq0PQHYCF0C+U0OM5YkB+3H0zepyfOty5s=;
 b=e5Ez+8n1/QTZxlc7LQ0E0F+ozRJz0eUji6FwFG2aGWcBqtpcSq234z4CoCCBz9bBQQ
 6Rr4v1ayisElu3gq41bfvYjhhs2cOvd02Qe8kyChTRphNHOXklg2bYc6GduaUSam+OKo
 /9h3M7p23KFU8GeBBP+XmyNTz49v5l5jRr9qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762223; x=1793367023;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BlUJKATv/Oq0PQHYCF0C+U0OM5YkB+3H0zepyfOty5s=;
 b=Rcxa1bRUpK7gkhTACGsup+7dqa84JSCa7uzTjLd7ixIUwTVVayQiig17mwpc2qXAgY
 vEBwRd4PW4IfMyzdz6IxoWYYG4gqc5HyGNlJc057YihU7aX+x3bXZA2ioxblTE4pst6q
 CEpoGY+IulDazbFw0SMkVo7gcfBjc7ryQYzIvZqoyo2BMpMGIvwcdgFZBIRwBIqn6B9h
 2uBD4+AkqTLaVpUHl2jlt0f4YoHjW5zdk0iJJ9QbSGxUtKR1og22rlSLRsvSRdS9XLrs
 NqkSa0Nx44+L/VmrkyL2FCKlxuDF/gsDgjO7eGECIRvrG4irzXRvC9fWy/l8gklSxdc2
 duig==
X-Gm-Message-State: AFq9FYJtF/FJi7SUqhUG1+9AKACP8fNiXGde8BnT4pxdCIFWtjU5vut6
 7ryKAuDn1svHh/PJ912i5Fz+psUNvqIqJIHfDKNB58AFEguUNb8sWtgIjNuSAci3FMPxoZGRePt
 adZc0SXu3GS7C
X-Gm-Gg: AYBFou3X3j+jfOrJDvmX3g1U4sdWmRaPrcl4k0pDsd7lYxIeL7jBUy1yJdV9cfp6pMH
 e4zWmk8Nvu6ii7V6LxbtfP2tFGBAuNrHeBlgTp7V97z6QNcba9t793mQW6YSza632DAiCGhXFlY
 weknT0l8+e2j63IRq0qz46PQ23G1MHLaPseh1m23ZziJmFkneZBDdCkA/5w8u0f24b3Sl5YXlUs
 2WXeJ/AizhGgjiAN85tQe9/X5ys3llXUEdYTyEMmmikmLCMxsd+EiKFnBObe9RozfMAtlYcpAUe
 WKjSi8ds3k+zOuXLByP88DZQCVE3Wh8DZ8saojJjx5hVFd0M0B8B3rJ8Gc07/maO2c5rgkALeml
 F9NGYF/8wwKnIXz8rMqWZPLDlc8amwjwOtRb/wk6A1qcdXduamjVef/n2GEsA+cnh0E93tHyVve
 bcEmst2ypUofTNcaSO+T9e/a5LnPBmpRs/nTkUgouY3CwNXMTuMR0is1ngOHbovIwPQHUjHCQQQ
 kt2w2N3QKAepwp/BqXFQ4qrNgdzQAYiyoJWPSCqzcjnUQMgrP/dBdWjHBXOMOj6qgDI+anCKgnH
 oHRWnVay8y6J7ML9bFqX4lKkznY4QdmJ21GDDonRB8BrsyP1QO44ttCvmOcNRaLaE1+gErJ5WXz
 d
X-Received: by 2002:a05:6830:410b:b0:849:f0a2:a7da with SMTP id
 46e09a7af769-84fb2324554mr1387272a34.11.1792762222848; 
 Fri, 23 Oct 2026 06:30:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf59d82sm2183155a34.15.2026.10.23.06.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:30:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Bryan Brattlof <bb@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
References: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
Subject: Re: [PATCH 0/2] arm: mach-k3: intoduce system dt fixups
Message-Id: <179276222172.3884908.15161238817073954579.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 07:30:21 -0600
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

On Mon, 12 Oct 2026 18:47:02 -0500, Bryan Brattlof wrote:

> The AM6* family of processors come in a number of flavors (62, 62A, 62P)
> to fit effecently in a varaty of markets. Inside these processor
> families there can be a number of configurations like number CPU and DSP
> core counts to fit even closer to the power or cost their usecase needs.
> 
> To avoid the explotion of the number DTs for the different combinations
> of processor flavors and configurations needed in Linux, use
> OF_SYSTEM_SETUP to remove nodes in DT which are missing from the
> processor's configuration.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] arm: mach-k3: am62a: remove dt nodes not backed by hardware
      commit: 2c1826f91d5e0f3e560aac790813d86c31c34892
[2/2] arm: mach-k3: am64: remove dt nodes not backed by hardware
      commit: e0ca8e2227e8a95cb91719778a4d2c0e25227fbd
-- 
Tom


