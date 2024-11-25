Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688AAD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 02:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2C7895A7;
	Mon, 25 Nov 2024 03:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nP07BvAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F27D8912A; Mon, 25 Nov 2024 03:04:20 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38DB289604
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ee7a400647so40350787b3.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 18:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732500256; x=1733105056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pkTBmnxRXQYYlLOR983Dni7bAJnyVSbSbPr0ygcwQOQ=;
 b=nP07BvAzYxFynQZZRzHEcHbELdi4P+Ibz8NYxWQcrvJXwYVh1aCk+rxouBy3+yG7vT
 qUxcEPT5IKFJHNL5l1NTjHDRbexRZGFwdKudRHbvtf7KkmoltX7hnyj7eYLa43krZlCx
 YzlIrteG1mr6y4nDPbNXmoJGKVn6mULHwgpnLyc/qlzhTfKxLq9f9KHTJP0gNt66R88j
 zIKiY01cwUTeuQHbCvNMSL3p3YPsRXElTdTFqz4QGBLHuyktFWzj8Uj65y85iZZYxyuN
 M6abxJssQi6jofM2/a/Cl7SSOBLvS+MrDUfbOheHrU83bZrIOQgRVtkN0H/pM/vgtY7x
 nt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732500256; x=1733105056;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkTBmnxRXQYYlLOR983Dni7bAJnyVSbSbPr0ygcwQOQ=;
 b=cBKJ1i7FA7mw0J7DhcCULCyK12PFSYVJ670k9WmDCjAiwee71UhjLK4KDz2ONWII5O
 Xwsi04nqBly9SctOODRO691eRn4INpHFKd/38qov006/WJEjm6oGNX9wLHbdF6AKLtYA
 cRRGEq4N3I1OJSrB+TZUl6UjCfUnDfQc+/AYHtt91hjYlY91FRZSu07GvNpIdEm+/1/I
 hT7dN5hEmVUxbQhj5KIu41nUs944sfvs55Z9A3OO2LkpoTxiZUU0MrTz5vG3d1HCCrL2
 LmRM6EqazKJwSqSfe5wFxza5QNOJUiJUnfgEJbZIEM5HwKYsZW6iQUv7ld5lSAcTk6gc
 gK0Q==
X-Gm-Message-State: AOJu0YwNsK8RObN7NxsXghZTodFMMPthPj/rvytNFZWQulbcdaHNNgIC
 Gr+Bnm5i3Z7yNt6On24PC05MH06UOrP5OLFhf82z8LQB1EWIJ0M3zdsmxBefiNPmN3Nsql+K+O4
 q1oSMEuuUI9YaS7it/o+zAQtGm7ZZ6JIIK6M=
X-Gm-Gg: ASbGnctqHHIkG/H5C6/yK09ipqI/Kwg7A50pbtCUYbwCh3FjRC+ktDowikvcI5O6/2l
 wOUzHzWN1fG+8Eks/mSGkooZ7UfjB+w==
X-Google-Smtp-Source: AGHT+IHQH+i3dbt9S3rwSSX/wdcRli8IpPTXoXW1mOmJAKCNBykzVTpP11M1SpecGD+ADQQFl3NuzEGvCzu2WRUrNG0=
X-Received: by 2002:a05:6902:18d0:b0:e30:dfdb:19b4 with SMTP id
 3f1490d57ef6-e38f8c1c588mr8247256276.53.1732500256673; Sun, 24 Nov 2024
 18:04:16 -0800 (PST)
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Mon, 25 Nov 2024 15:04:05 +1300
Message-ID: <CAFOYHZAJA52O9NiKtHxSRdaP=Yu_4FG36VReai=gSyWhHZG_=g@mail.gmail.com>
Subject: u-boot mailing list issues
To: u-boot <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I've noticed a few odd things on the u-boot mailing list lately.

A couple of weeks ago I seemed to stop getting new messages. At first
I thought this was just gmail deciding to helpfully file messages away
for me but they didn't appear anywhere (even in spam). Then I thought
maybe I'd been unsubscribed (there were a couple of automated messages
around the time the problems started for me that I'd just ignored).
But when I went to re-subscribe I got a message saying I was already
subscribed. Recently I tried again and this time I was re-subscribed
successfully. Just now I got a "Your message to U-Boot awaits
moderator approval" after I replied to a thread.

Is there something going on with the list or have I just managed to
get things into a confused state.

Thanks,
Chris
