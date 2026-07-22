Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F16AC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 22:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16B6880B1C;
	Wed, 22 Jul 2026 22:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gG3Xm2Yqsxr; Wed, 22 Jul 2026 22:29:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29D9D80B4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784759360;
	bh=tt1O1KjDyScQtEo2GWlE+iV3Xnx6i8Abl1Nk088JY/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGODluJmcYFFGqjpnrRSeGwHll/A//S8Y9ue30jrrUssgjzZgJdKevCJXOw/2uyCC
	 9xY7WmT3a/SyXQu4ncqgbpI2pW3xCQ+cCU3v3esK4roUSG47aHrgc/zk1CM9pyDcPz
	 AyWeZrIl4ArFB+jOzQCTdUyYxvZDE9KK4kYW3LhfnUIxrN3g3VC9srSlKdeMlaA1lI
	 WcOmcGha68pugPzDWekYb2CnepMjPMDymcf+xSi4veIv49CJsxUOhFkq8moshz6DsB
	 npnDezLZ4+jhqknmyU+c1pZq896Ymyk2SyjLzRX2LWkzFwBxzFYQ8RyJAjks/Ff6A2
	 /yMCv4whKFxqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29D9D80B4C;
	Wed, 22 Jul 2026 22:29:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F1A3B1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F316480A90
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruVgT1t4szXc for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 22:29:18 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D664B80B1C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D664B80B1C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D664B80B1C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:29:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DBC8494B; Thu, 23 Jul 2026 00:29:16 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D98618404D
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:29:13 +0200 (CEST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8efec2c28f8so42756d6.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784759352; cv=none;
 d=google.com; s=arc-20260327;
 b=fRIPod6tkfveTbGBTacYJh4OyZL6TsXlJ7ylM26z0s8JENi/vL31uM/nkcmw+97htf
 vBKqt3foYdXevu9Jb4umTVMDtP0k9HFIniQh/pESrbosk1xH+VVZPxWNdw/fGo7lJGIO
 WEukkrlqhOEnwOMmfi0+VBV8Sk2DUuYb+RFOcIYwilkkzIiKmYRvGpnRWtlzrt65sNq4
 AzFFKzZXlFlYLhTuxbUgLcObs/in/mwgJDuAuuwkwpQh56sHclpSGmO8nYKn2f72SNBM
 If5C9ZRtSzmq1XkI6DgaUzTHVWEkkoOlKBzHflKzwyR611Tkn9rPzV/hSvQqXk4Sj/Yf
 lnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tt1O1KjDyScQtEo2GWlE+iV3Xnx6i8Abl1Nk088JY/o=;
 fh=jxpVsFpwwmq2WOastSCtwSWfvt68HrUDALPUzrcZkTU=;
 b=dgKQGi36PzBZ2VWdQauBmG09H1QIiflrlRxp1iAvyh865+Bz8uts69j+PmnwN5Jt2i
 0+QwThiI5fwcHM+lHluctBIouNEPphjTiGtfy9Hm247UgEVle4Timx2643wmqUciehZE
 NHN0DaQdXKgZRGkv+6TKJ6X8UAIsyHlna+4xW+u9RZ+K0ucsNeKIjCgeseKxIDlbN/Kx
 xYOl4y+Cl2c+s4g+T3yMDtBkpDupT6twY3Xy/zgCEtBpgJ+ZSOnbFfuzT6F6CqSI4/U1
 WEXIYJ9kWqbjCci8mExPqjQNMRfs6RKO214mjR2wh3+QWOvHvLcnpAFhZU7erdqeu2AM
 7IyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784759352; x=1785364152;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tt1O1KjDyScQtEo2GWlE+iV3Xnx6i8Abl1Nk088JY/o=;
 b=fw1tf0OzHCKWNSU+bic5T8a0oL7tV6HUMBZWlffUqm7yBKp9VAS3/hjAtV7BIsWPGc
 5BCgKWFJRL5L7dW013ObL6YFEfLXyYKcyfhm774iHbGjSJQ+lnCYWv5SB+I48C7of8AY
 Aa8Fq1qWV0LwpoJJEpAGdtTBAtAKuKfntbbWiQVyFowuyJrGooSbCyAahZPJVScKHvFS
 7I7o6fJlW3qNyxCzG4KGj+grRetW5R94jl4t02tvHH4qrgFH/ikdNN4QV9s5H6da1n5G
 PIBO/UQo18ZHcxYxcFe+ZSJhW7N8nGIwzMCKOo6AIJNQUYckZjDZrwpxU/clWWOHBOly
 h0KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCKjJalPlCdIm1huKCl+rdhPebVo6m4iQJ6BhBK4PCIHxSNpIRL8sLG51JNKxaXMXy1GcOOKA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh2ifxR9meaFk0a84YYL9M7g8z1nk8Cf3/wyNt6JqngrVqhvT4
 AXlIjQw0cCbU2UM2uegDSUmjtfOt+itSvBUBBPvzojqdOZvjFjESncL2r8Bf0L3K1zj6q59Cohs
 Vg4AMBX3JzckKG5tom/IPCiy3bNSO84XTzdjv
X-Gm-Gg: AR+sD13qecQYyg/DDGWpEuIhJp/WYWeo9pQPcce9MoRElRoZMXdSGoUTK/QDHrL2zRv
 XLeFaDy0L2vYuSffbsrMLridS9cMaB0Fymk2wiJ9mIQbc8hdRu6ZxCfXjDh3BYRfYGAed/IxA6h
 4aBC3P+aO+DwfR0rLV+CFp40WbeLqRuKrosw08+u+5U8RYdHVbhMjX5NgVv4PcXt9cNuWLzXAFQ
 ++4/fmloQ+TDGIRjCw7sHaDc9K98Tkarqj26DSfDb1iqrt49FTJTge7l9BsH1RYBJMPjAGqWVV8
 TRNmjLW30Bf93bA9jSQ63nfGd1AG9Lz2Ir8EPN0nVqVZHPA10rV0w6o5lwU8i/jgl3nNZ1Ts5sy
 o7EIa8rHqWX4pts6e4JPjsGk+umG++SP7sYm1jW1xKcx7wo4NuJKuTYsg
X-Received: by 2002:a05:6214:1c8f:b0:8ca:164c:a85c with SMTP id
 6a1803df08f44-907ca625684mr9672266d6.34.1784759352416; Wed, 22 Jul 2026
 15:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
In-Reply-To: <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 22 Jul 2026 23:29:00 +0100
X-Gm-Features: AUfX_myS7L_iVpsp8Kv4c32ROugmarmde0Zip9uC1axguVFRqjJ9ECOENrplPiM
Message-ID: <CALeDE9OEtA3ES0ykpcbfdrr3pjNz5+8hdaZ=mZcjaj6wYZTnxg@mail.gmail.com>
Subject: Re: RK3399 TF-A hash verification failure for atf-3
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Vic B <u-boot@vicb.net>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784759352; x=1785364152; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tt1O1KjDyScQtEo2GWlE+iV3Xnx6i8Abl1Nk088JY/o=;
 b=e/+LYQuj7DKvL22I547DcabtM93jApV7kW4Xgwly5RimtnMyh5/k3FiazrYNLC4qdg
 goFhEDrsALBHzqMXRBZvaby14cwLQ1h1zg8DuY1RP1gUtHRnD6DSnfvpkaLSeVozCd1C
 NWaZZwd/3DF3najQr0UzzEj6YcYg7YwbCpvAOxNo6VzkL7RzeJ0BjjlnDHskJ88i12IZ
 Z6HQmiVrF3btDmCXCegRwejz+cD9BiLZVsw/npCikJl1JrwZ/hWuk2OEJmfCQe/K2PiS
 KVWjpVwPEvdMReM5P8gAXHzSV7uFnwgiiEitXQacPU47y9NnvrVECNnI/v3nVn0WPyCr
 OBwQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=e/+LYQuj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e/+LYQuj"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 at 18:13, Quentin Schulz via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> Hi Vic,
>
> On 7/18/26 6:03 PM, Vic B wrote:
> > [You don't often get email from u-boot@vicb.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi,
> >
> > while trying to compile u-boot v2026.07 (or v2026.04) for RK3399-based
> > NanoPi R4S, I run into issues with current mainline TF-A (using 2.14, more
> > precisely the lts-v2.14.4 tag). I'm cross-compiling both TF-A and u-boot
> > using GCC version 14.2.0 (Debian 14.2.0-19) from Debian Trixie.
> >
> > First, I encountered TF-A build failure with the
> >
> >   region `PMUSRAM' overflowed by 3928 bytes
> >
> > error message, which seems to be a long-term issue know since 2018:
> >
> >   https://github.com/ARM-software/tf-issues/issues/650
> >
> > and recently also mentioned in this mailing list:
> >
> >   https://lists.denx.de/pipermail/u-boot/2026-April/613754.html
> >
> > Although some discussions suggest that this issue may be compiler or
> > toolchain dependent, I've eventually found a solution in Armbian
>
> Debian toolchain issue, reported to TF-A last year, see
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8.
> We wanted to rely on Debian upgrading at some point their TF-A, hitting
> the same issue and working on it but it seems they are stuck on
> lts-v2.12.1 (which is slightly concerning considering we're at
> lts-v2.12.12 already) so this hasn't happened yet. I'm building on
> Fedora and my company's CI has lts-v2.12 pinned to avoid this issue, so
> I'm not going to be chasing this myself. Can you try to work this out
> with Debian maybe? You're not the first, not the last I suspect either.

I can see if I can get the arm distro team to assist.

Peter
