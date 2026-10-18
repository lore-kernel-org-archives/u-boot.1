Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD1CCF2C7
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 01:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B55B408D3;
	Sun, 18 Oct 2026 01:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLl8wtHn5wyM; Sun, 18 Oct 2026 01:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C582240845
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792285532;
	b=kC0AR1akLXfoAPa6HLQjgs2p8eg8kotLMZ1oT9QORIIusZtHqU6frCBnReBwDprKEp9y
	 3oUxLojBFzgZcIblwuud1+5m2g7Na8pDZwMyndlqrBEj7TWytdm6fkpHike4SbHmjh7LJ
	 gXcrDrhJqbSbnAQ4cINU4hVKjxbr590fzFjdYtePcURnr1uUdnt6G3iuPp8FYFKUO19go
	 uG3XiwC8CRZwtkuoFdx2INXpYq3SX4tczPEC59ClBBS0W3eLRMv9ZiTd02xSrVjP64hYt
	 ER2vIO4r0akQKQrT1tGSuyLmISG/gBnbJ+cccXiuV5ixl1suo42PSjrl18rpmIsRoUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792285532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JChx1A7M2oYzLDdN30PzvV7uPKm7R42CKNH6VlGY/Vw=;
	b=swB6/sK+e5wrOj2MK9w1uROFthdWRANUEn59rRMPgvIBfzjRHHVnmbID01f6fNrmVlRA
	 6Lzm9Aes19p+2XjvJ4O7rPJfCuv4KjqXxO4vIEoW1ehv3bqcvPM/5d1hmZ7vJMyQgmmP6
	 8CItr7qG69yXfVJ2+nFpsRYG0QJv8NcfBUAh6dnSlYwyGiMcxmXISDinPZJqYgeBwXa2F
	 RWnb11ntxBH5xxyJf+TW/g6ynA60u0RyIz2ybDBbUbuL6/umPejFu03rdY9+U4z7bwhEG
	 r95Kaxj2bQYE9jGUXFzCd6y9CNJz1jkThesp3sUhqAj5uG8zX6EgdNj2Yhzws/LsPHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792285532;
	bh=JChx1A7M2oYzLDdN30PzvV7uPKm7R42CKNH6VlGY/Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=arXgeB6F5QilYqv3+ee5/GZw9nt+1mNjnFJolk3/HyPOhaeqNOJfTGD7vVnsxjIJt
	 lkkfBJQzVVwaxgr+7Kt26iHru0FB2xWYLc+tcuDobgemLWj2RlWYdG5Si1subXIij1
	 XBnB+yCWWcfuB6dqq30mNToCVWOKemRV4ukoo2QVu8k4egpnRPiGa/Wxv40X6mPH4v
	 GPYJ3KfSIR6gSWl/ODG/AQUo2BSeG9ZMEsGXChfEIsQ5qOYZV2Zn+f1PFIK3SL2MQj
	 7XnCPEe8jzOpBUAS11/3JOwugcotaZ9NHp3vXKagiQtjNtzKKnEj+Ug5Nog9XHKvg3
	 l8dnmIWvR/FOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C582240845;
	Sun, 18 Oct 2026 01:05:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A71879D
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B6666064C
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0jMaGNpPPJ7 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 01:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A1E96061A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792285530;
 b=F4xlM9jZKm8p78TyOFCiIuDBbaTbucbxoIcVFharv0gZ8Uud6klzih+JMd3KN49GKWHv
 B7N77f+SPKfRrqvZFKs2Skb9NK/aRYPwRAiTwFwjOKawi8GenhabYl3W3QF0eloRqMr8d
 6Iih8Cz/K0fm3QO6Vuk1XEqLDFz1huCLhf/p44niiyUTZX5cYZLQho6Rn2fIz8rmmhdMI
 tpuIJyULFH6Ym76MPwRepkgbLnQoby+Q45YpoPgoILeHNNFG511wEi0bAoiUewqwk9pUv
 OwtRi/z7zWII7Bbtg0B+v5XwYtWYNI6x+jjbMyOjWcIeEbfw4nd9Cv7zouNVYpr97gQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792285530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JChx1A7M2oYzLDdN30PzvV7uPKm7R42CKNH6VlGY/Vw=;
 b=EnA6IUUWC6PXIEUo5Gj2zFKoDXHQlmoaids2OI6Dz5cbJrlGTwgTyCBPML5MUfyr4Tkb
 oe1+1HLIQnjJkoQdEYT5VNlG+C7NEAyW3/mT62EsNmmUOUuBXZRj/7UzpquHYLAPqs5wV
 EelWNZ76bec+L1OPS7PFqyp9XcOh1ccpIXimxdpgcF5a8LSc2rh0twdXNU8RInLXNFJsz
 gSqaMIXe04B9Ro3ZiaM2POfvJNdZjCkr7Thu8a01Jx6LxumKGSXpMhBP9kRm9aHegblQj
 Xic5nzS9QlJpDAy4z+HiG7natOBLuRBoRAH8+MKK58XKlVoVAcflGS34bm1x79xnZOg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tM3T4Gxo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tM3T4Gxo
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A1E96061A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:30 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so812522a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792285530; x=1792890330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JChx1A7M2oYzLDdN30PzvV7uPKm7R42CKNH6VlGY/Vw=;
 b=tM3T4GxodLucLTH3l4XgyHmqu1gKKCRekxfCYnlSmBXi5C+t2lZNFQwMIbSe/y2bTu
 iamL92OnqisrLvqLaJeAhWn1wiwK0JXTmO9l4uRsFzpnRYRO5n3Ymg9NJC/0455dXx30
 W8ObqBKLYmhNTEjA4kzYdovm2LySD45xS77JtuQdXD5XW+b3AUsADTGTg146LgLgCcdU
 OwwiHtA6QuOpW7+evWw0yMV/zTtEZO+jGRI06COtBUE0mekOGrooBHe7vyk+ddG04YYL
 rZUY/FjEMlscQRmvdVutCQ2il58J0JHun33NlgrLpsUjd2mRt7j4k1MQVW6Yqs7wwoVs
 Mcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792285530; x=1792890330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JChx1A7M2oYzLDdN30PzvV7uPKm7R42CKNH6VlGY/Vw=;
 b=NuRs2ZPgdhRImyMJBPyoDyPw0468AEz0bYNP/AzMywpdNJKEMPyFjnc45vFWn+9VW4
 7a2feEpCSR6c8MZfxlTGYcZvmLMO3V3XlqdPcWr6WmFx1uiCdqWeHlGj9PSYLWdIVu4i
 d1t5W48Cy3jVnSzBUK9rP70dmL/6hLiPgQVaZTq1Vvts/cVpjx++/KmFrKRZwNCKzjt3
 NjRMXaf9k9yXEQ7rilAcpxaCQs0In29oezYyEpmxn9ncgfvRE9A6OWW41JVsf4M3XbGj
 6rCQYe809plhQMjCBInM6OyTWtuTaZJrTZVvnl/SZpL6noAgEHJ9eojg5ieJjv0OCjEQ
 N27g==
X-Gm-Message-State: AFq9FYLmLZX0QvDLwrHhOaIlPdKENLpGBLlyguySyb9RpXxOVFfvX7BF
 0Pt/lOB5Rcac7SNTmWs+OfbtxKX47hexehSRP352xW8u6puMim2ittRE3JMDbnrQ
X-Gm-Gg: AYBFou1VyfDNq3A87PVtTrteoJ8a61eyM44HkNgiXKkdLYiQgFrAo2rK1E40FooUycR
 0jId+qxqxjiMNUx/Eq4Swkk73xpJI5bw+wPWtXFSn5u2BG74cfJagG+VMGppoXcXow9VizxAanP
 Xd5RsM7nZNoWU0nZnLh0oIsrrXVSAFBBmUDUJTeYg1A+4Ygfu6SY3nUskEDk9vrdusN70KbANvw
 D5YZZ0NpmaJ+HH5F8f+eyiA9BLRJ+7CWTUaiu6UyIfbeMIAQHyT8qdZ0TYkmKTHT7ZG4DViPGkk
 wLW1z3J+PtcUZHgPXg0Pzj85VByCXZBoCZ3srvgeCk759HYHD1P3Q5Gbw6WRWQDqo16D4EEOh6w
 Yt5t3fkKzrHq8sn86v/0pq6PgK6cRRuZFabr6wRkACqjScVLVpvdwKJZhwA7QVr4DMG6fns1okl
 T4Y7+XX2EDVfWYZeZ4HPRNmcExVcgHfqJd/doaRRmUZUDSOLOkHk7PPUj+Ah1J53WvetdTQ5yxR
 VQJJ+4oWaLstR7GjkULAUNzvcqR2nArDFBqbxWdjUFK4HspKsG2r5CVbQXPs9tsnUCi4U6pnmqt
 MMSQpZtgchTAVhoZGCfHHWnBT58QPnuBb5RVH5c8DMTNu2uvP0tOsYhTfEmXLRhySw==
X-Received: by 2002:a17:90a:e7ca:b0:3ab:f38:2b3c with SMTP id
 98e67ed59e1d1-3acef13eb0cmr3235863a91.28.1792285529716; 
 Sat, 17 Oct 2026 18:05:29 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc49c263asm9567288a91.17.2026.10.17.18.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 18:05:29 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Date: Sun, 18 Oct 2026 09:05:21 +0800
Message-ID: <20261018010522.1324982-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atPI5SKH7ZaiytQ3@google.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
 <atPI5SKH7ZaiytQ3@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Oct 18, 2026 at 03:13:41AM +0800, Kuan-Wei Chiu wrote:
> This is a bit subjective, but my feeling is that this has become
> somewhat too verbose. Ideally, a commit message should explain the
> "why" rather than just stating what was done. What was done can
> basically be seen directly from the code changes themselves.

Agreed. I'll cut it down to the reasons: why the clock lookup happens on
first read, why a smeared clock is preferred with a fallback, and why
the "no UTC clock" result is remembered.
