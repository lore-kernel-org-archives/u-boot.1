Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DECC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 17:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE78B408BC;
	Tue, 21 Jul 2026 17:43:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzGgjdN9jV6R; Tue, 21 Jul 2026 17:43:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0D83408C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784655790;
	bh=jf6nor4LNfiFi1+fzSZ3BIthyV+UgruBIOrD0u2Fs60=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M6gqkb5xkJEfIy1hfIKYp/HAL2D5nEJl6w2I/W6W65cI0W6jNK5P3T0vKOAKDTue/
	 jrMN5GvJjpZlcEq1L7qxVFHnN3zoj0F0sLRXUWTVx0AyGk5L/2rhOP8JXv8YKd9ZwV
	 lI0pVjF8UwfB4505mfKiPwA5bCKwvK4AbRU+2CPwY9Z6+uT9bSAuuyHyKydJF4KRvB
	 FRZtR7M7d1k4Q32//OqbR61wdWugbSrfqGhZYRcV+5zNFOYVqVAzOHba2z2z+sFb0q
	 quELSlwd3GevxRruJVDlykoGXK9sQ8rZQxfFvtLSCSdWPYRG9xDaZTcsfznbZgO8Sq
	 oaQSgWsjNOd7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0D83408C7;
	Tue, 21 Jul 2026 17:43:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AA5910A3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34F1280C75
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MEUnN_thWTa for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:43:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3B27D80BDD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B27D80BDD
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B27D80BDD
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:43:08 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a38d7904b7so625458eaf.2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784655787; x=1785260587;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jf6nor4LNfiFi1+fzSZ3BIthyV+UgruBIOrD0u2Fs60=;
 b=L0zGTZLCG+qOxpigLjRP3l68QNRTnAJdwwn4UZQlKdwfAslcyEI52wbIx2APiBi7Ky
 7wMl/ON9tzsAbGWvYeMAYfYdJMge4Ny8NmaD8+pfY0EJD5bDzIWMYx2lM01yOtIZE18m
 itx5ttKTIoRey3af+o87g+wmp7ESsdVtV0lc410Cdd/qZXXMA1J8Zd9ok/JvbjkGdHvH
 zTh8a+koi4V7Buz95y5auqj/GQGPDDpPtOsEGyhtvugTVOTdxPtWFdZHETr7YydWlRbh
 +lLofX6NmuIo0LqajRny7tRdc3ID8k5CMNdV6mTU464BSZGuMLKxkqVUXmgDOkzGs8WC
 cS6A==
X-Gm-Message-State: AOJu0Yx6z9qBkXB8Cm43nK+/YQzvVMFaEiaH6I4HbdjY7IgXZHbSjI1r
 +z5dfh8vPnx3oYAKRL/kRqmP/MiSFA/Ks60Gao678c56P6EHUZwPvPtSv69jLnkoCxQ=
X-Gm-Gg: AfdE7clH5Ieze14e8+uYK5vUaqGHKFc9c1wKAF4uTWSf5HbqO3bpujh6lgIjQA5xqpJ
 bZLY1jog8RfGzZ2yZssKSEDtxth+uGgsLu30xD8KdGZt6v7FasngXVnb6xh/IFKPJRr+HQWhgeF
 nnNZifcKWsI/Fv7VUc63l3Q8T/JdeEzF5k/IAclz+68j9JrrLdqwI97rPUIzSJEy71Ut22SL5sq
 MiJuuo3w/TmqI1uXxckFCQsLxjPwpESRIJBB9NhYes6NY6Cf2nCwn2oLfwf0zDWur4be3M7KLpv
 Paorw688p49nyfUD5jTIfk6BQhUUB1DzMZ53m75K8iwqMWMdQFuPv2AnBiKenzLrBpCb3Urk66U
 /vjowtbIZOTsLMgiKwXzywXjzKlIN8a7WQakaz0WdYGKEGU0TvHamQV4ov48Ef3ZSSCM9YQXb3g
 wfkA+WgIXJ3xH5o7XGcd4uKLsFAveNx9IftIMshnQ9jb9N0DfjvGDOSqnFG/QaRR9vWNlcV8PjW
 9/4K2Tkqwa8b8MBBSqsjkP7YA==
X-Received: by 2002:a05:6820:6aca:b0:6a1:1419:3a0b with SMTP id
 006d021491bc7-6a536a9be16mr10219317eaf.53.1784655787275; 
 Tue, 21 Jul 2026 10:43:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a516be0203sm10945853eaf.5.2026.07.21.10.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:43:06 -0700 (PDT)
To: Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.u-boot-project.org, guodong@riscstar.com, 
 raymond.mao@riscstar.com, tanmay.kathpalia@altera.com, 
 junhui.liu@pigmoral.tech, peng.fan@nxp.com, leo.liang@sifive.com, 
 sszhang@vsit.ai, oyst.lnx@gmail.com
In-Reply-To: <jf3kajqvl7zz3xgrhxsmwlki6el6udc3r5drlzuylfrxj4g4u3@uhy5mr6b2cd7>
References: <jf3kajqvl7zz3xgrhxsmwlki6el6udc3r5drlzuylfrxj4g4u3@uhy5mr6b2cd7>
Subject: Re: [GIT PULL] Please pull riscv-for-v2026.10-rc1
Message-Id: <178465578608.2668026.3734174156589530459.b4-ty@konsulko.com>
Date: Tue, 21 Jul 2026 11:43:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784655787; x=1785260587;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jf6nor4LNfiFi1+fzSZ3BIthyV+UgruBIOrD0u2Fs60=;
 b=Vlk8PAk9ZNPPMFamT6s0KvjDo1asH3bDc9l4oxnxblLmLymPjoA9Zg8IXOPeH7MNZ5
 vU9/Oi8JxHifG5RBIrRQzbC53Q4dhdmXLni3JUf3k4ba5JWLrDZ8DNsWLhKS8stbhDIL
 qqDUY1Z4wkjbZkLeEvF9DIrBcJjZqFqBLVSLw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Vlk8PAk9
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 21 Jul 2026 22:50:37 +0800, Tim Ouyang wrote:

> This is my first RISC‑V PR. It adds support for the SpacemiT K1 and
> updates the MAINTAINERS.
> 
> CI result:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/676
> 
> Thanks,
> Tim Ouyang
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


