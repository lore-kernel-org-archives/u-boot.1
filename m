Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892C7C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB42360D58;
	Fri, 18 Sep 2026 10:52:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xWNjVM1YVBSR; Fri, 18 Sep 2026 10:52:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B5BCC60D4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728772;
	b=ARr3cCCCvI3MbffdetifB19jCaUOFiEEpGtxFAUjaAtOXXhQVLg+fE+O2Po59T7IJ4C6
	 GC6M5IHq9t7MZhkEe/riEnpPj9mARkFcA7lv3DXEy8yZr0+EeYJg9o74NPkVWl9AxeF9k
	 jog51/cQG0/UevzLsF74XhUv3kW9qMTd6cr5cXScd0+jbBj4+HZaEHK/SO0xb9fuPlK3u
	 PhH0jYcvoH+E0+jcOZAotTF1Es0NLTgWzVMlUZAHq77MqAggadVVqTh9uaSlJe23IoRCn
	 FRW3ZswaAfnpujAlb6SqfxvWpWvnxDuykwZSEhw8o7TRvANvaFcSJX123ujGVSudCyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XPR0siUQ4HfpqH8NXE3o+LHL4KP8HHYVgCfe8T/jrRU=;
	b=rSolH9fx+9NKhnSwni8+d4P/1lH1ZZrwYRQrMp7azWodpTmGFXMArRwC4cR4IVvvKITY
	 kPKLpYlsizTvcNomnVdxC3hdlAp/gl8bvNljsRKNeW8jN0n6uV9EesIr9x8Llj1tN7CUT
	 sCxLTAl7s6x8LxxslRYqbz/o2nHCiQDtS6okYPqW4Om1OuYEac/ytCoOLIi1GXKg6AmTB
	 vQs+Y7hgl5omERG/yE8I6US/90hVB7XdIjUmvs/vPJqcRipKIlFub37bxzVpZ9IW1H8fD
	 8mwBjpLBN0EhGeMGJ5fSfj9NofalWCg6PaSNnnMYA7W4ce97n46/j8VHyqEoYX41xcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728772;
	bh=XPR0siUQ4HfpqH8NXE3o+LHL4KP8HHYVgCfe8T/jrRU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EuFmPtmNF4rc9iCH5BmOFVOB7k0/ql1JUOnypcKcYXU34yxdlulHBOBEy32mNczeQ
	 c+SrradYd4xn7uMTS9/Dn27L8SpbNtu6W8kq0S2Qf00idECXGA2OuK7INfxvNfhOPT
	 /6cGGxDNR8JlRL2Noj+3+dg5P6lc4j7tAZepqILR0eqd3HxDaezpzQDQEGlkGJKQHf
	 SSE8/GAsfBfu3r0m8AVNjSvx2FEHpFpRQlHpWSg3UtFVQb4ziwqAx1msToNrmK424h
	 pXpzX4/+K7fGoCCWV1hstlr8gAygFEhp4+dHTLgYvac4Y26PRbN5hlPiL04q3tVoVP
	 VFv+FUxo+ADaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5BCC60D4B;
	Fri, 18 Sep 2026 10:52:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B910279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81BF7811A2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyDRBrYZoojK for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4DE1081197
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728770;
 b=X/IwRWHCwYIk8EDTlTDv0+kXqFpYpyQ0tHOvEuOJ8a4SF4U+I6IKM8yUnBSqG+AlxXxU
 IttGK1PPUAGuo5SyLXrZSNRmDK24dBfCcgRXdFp7sn/nVeei17RhAGVsQ6noq0b6ennCe
 epT1HpTk/wOeIl0n8scVTeM9nA2PUJrZfWeRYCzcOufSXrgzFXJkArjBCTDyMGtens2C7
 YnqlYkX0ANzM47wkxmDJhDo/r5shFp1UaIS0AN2p8IApErDZ0mNOUOWKd2bidyX5L3Hs4
 FxUi8YMy848ATZaGnqffTgynN57syjxTtpmyc/Dh1GyWAu63uFVQp3D/y9dbmaD6hnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=XPR0siUQ4HfpqH8NXE3o+LHL4KP8HHYVgCfe8T/jrRU=;
 b=bETY+GCyFRqDlVwIxLJjjbzyxnn9Wm7Iu+D5McrH44gQGic91qByQmMwHPqsmrwATsmC
 KAHUpAbNC2ExI9ms5/VRm4Sgj1lazQ3uwFCX1CP0RW99Rfg6krA6qIuqI7wwNmd2UFiRm
 qBUc6ktWdVipwZ9hQx5q6UmveI9gl4GwwbbeprtPbL6L0pSHaVQTCJpS6c3zS3g2O/qti
 NBDh1eqsUnlK2jhC+cQCXvj1YrZXTNIGbg4IPrMj97iGjEzi4iIuvSFW7XAOZ887AcCrP
 a8FYrsxyscQCDgY/5UtOcVTG6NNnkr0q0AVVUDnLcDigMF1kUGgqxZN1fsUZLz778lQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=d8iYrsbf; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=d8iYrsbf
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DE1081197
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:49 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so4060185e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728768; x=1790333568;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XPR0siUQ4HfpqH8NXE3o+LHL4KP8HHYVgCfe8T/jrRU=;
 b=d8iYrsbfL1KDdS+38klmBjwVqy7eACW7Grv0ZMxSNDt9ME27WwDakOf5pM3vbcDhvs
 XxLy+RtdP9i8eEXppzIPxYhNS8MY2Tuvt3HvzR749CQ7xvfbQw5iF3knfsIxLfw3XBqo
 f3hZR6RfUe+9mPXRP7RrS9VtDXtzO4E0uVEz4Cp2MNTUPR6CJnZycfRVWOxjPerlQynw
 TTLPTqAsAFO12cjdDQOIvEmrhffZIVCIzlyDjH97xwdjMFmUPDFTg1IP6NS3KNK6IYIn
 LQmsUFpbSGluNc7hj9MCus3iAXH8F5Vo71dQqzKd16lUIakVt+Kjo+qjGvKTh2RqK+v+
 gSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728768; x=1790333568;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XPR0siUQ4HfpqH8NXE3o+LHL4KP8HHYVgCfe8T/jrRU=;
 b=ILaniRPFBYlffI5ukrvrjXiZRHzBwBo5BgEpx0D9qBrpGvje40j6g/uEBRnGxjzp7Q
 JRDanvw8l2Od7cVu/ZXCLbq1lVpe5IE6cpX36IFLh29eYiJeH68C/tmyD6pBuGAADpdl
 4gPeIQmtd8jhBLbpGEBZ/iLKsD2KAIuzzLCOB9ZpBx71Ahe6fw6Dv359sZNFYSDWN8fM
 2NcfayclwouLzjM4FxicfogeZ54ZzWGvmrWs5b+Kd5BMV0lqnMPOThthfcXuG03zuUdS
 5fNoBzabMeeBdHgK/uhPWdWBT2Pkadx1fgNJbgCfieigBEuiV1Lnx2RpIIo4XkmYzNB5
 z9+A==
X-Gm-Message-State: AFuF++n0+GtbBbBc0eY2PrAPhcJsQaN07fdeNSCIlu3MRRNqpCHP0nPo
 JHiHOP4pqggIHD3zDtWq8aobfXQ8N7s4LzxQYuwDPCDFCDy9TgHaM5p7/ixZXEfLGc8=
X-Gm-Gg: AYBFou0VHAD18rrWvSfEqMJ84tQLjQCDosZty+IqdYTRsJli/+dq0yYQU4ol+b920xH
 drYBHg+t4InEgcevv/0UzfG8CvFUY0XTFFDmDGuj1gr7YkLF2Q4j509Abh8LvlDK3J7f5XMYaGW
 B7G/eSjKAnHk3oeFQ+ru8RErYwrHJZAmNh1QKYPXUWgqwqDlPcL/mQ9ux7k4kjZkx/6P5aScAUt
 zTy4kItLmXmmeXU9dWMDth5HD9wGlJsR6l9wijWtzcx6EvAJWyXzLWpUNQaTSCd+fHSSFYT9A1N
 KTqfZnxOVegAc3j0Mi0eTrD+VdRKlPhHQ1LaLvmyLWbnNaVq25IjsrzlionFm6A2Q1Uyt2bB/Sq
 iHPnCQo3ViXhcrFpmWh3jCfndYoHmL4bu7AYvPIjof74CUoOAnG7lMDAksYaDYk5kXCBHzoz0K4
 W+L5QEIVUpw50hjdJ5LPC8bzZnPLFe0jm5zXLnIsL/OlxHpCbSUPtn3ziyxTZWvmS/TUAd4Ug9x
 yKB/zFLirgKq3CAnxYqUpGj0/eC9V04165DaHxRkYtdJHXRxVmhyW+KxNaLq3o=
X-Received: by 2002:a05:600c:138c:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49fc56ef0cbmr24058115e9.14.1789728767637; 
 Fri, 18 Sep 2026 03:52:47 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:52:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 00/11] spl: fit: Generalize compression support
Date: Fri, 18 Sep 2026 14:52:27 +0400
Message-Id: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0K6dkxb0wKuuIdhgWUqYxCathIN4
 e62GHcuX+bNfysL6AkDOxcr87hQoHlKIA8FM0M33RCoT8wkl5rXQkFwI1iKYOaH8xiyD1oKXp1
 U1RttWfpMB0uvffXSfjk8r3c0MU9lY6AQZ//es4vI3q9Q/i0sAjiUdaU6ozRijY0dyTn0xwkja
 7dt+wD2WiqXygAAAA==
X-Change-ID: 20260915-spl-fit-compression-62108358dc6f
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4468; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vrSI9z43d416MONGf9NNzg1JzgatN9m0bAHw6kCtRzM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf+c1XFYrWLLnpgDf5eWXSgulvQqXLPy09lTrL/fL
 C16uDWQpWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICprjdkZJg8K9uioaLLf2OIR/DKmq0zHK48ORPjZbg0MZZNvYy5rYaR4RFftOj
 HBVkHxG+84Cq9fC3lh0XojAMFS+Oqp2gqCXw+zQYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

SPL knows about multiple compression algorithms, but only two are
hand-rolled into the simple FIT loading code, in spite of a nice ready
made helper already being available right there.

Generalize the compressed FIT handling code to accept any compression
algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
requires xxhash in the SPL but which was absent to date.

While here, also extend binman to support passing a compression level via
its image templates, which helps squeeze additional ~15% size savings in
my testing with Zstd level 19 without impacting decompression speed.

This is done with Rockchip RK3576 in mind, so a small Rockchip image
template refactor is included.

CI passes all green: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1319

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Dropped redundant help text passage about SPL heap free() being noop (thanks Tom)
- Dropped redundant indirection via spl_decompression_enabled() now that it's directly
  queryable via the new Kconfig symbol (thanks Tom)
- Link to v1: https://patch.msgid.link/20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: Cole Munz <Munzzyy1@proton.me>
Cc: Simon Glass <sjg@chromium.org>
Cc: Francesco Valla <francesco@valla.it>
Cc: Anton Ivanov <anton@binarly.io>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: João Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Johan Jonker <jbx6244@gmail.com>

---
Alexey Charkov (11):
      boot: image: Keep the image-type table out of xPL
      lib: Build xxhash in the SPL phase
      lib: Let SPL minify zstd on its own
      lib: Track whether a phase has a decompressor
      spl: fit: Decompress any supported algorithm
      test: spl: Keep the payload create_fit() is handed
      test: spl: Size the FIT properties for the image name
      test: spl: Cover FIT image decompression
      sandbox: spl: Enable zstd
      binman: Allow choosing the compression level
      rockchip: Choose FIT payload compression via Kconfig

 arch/arm/dts/rockchip-u-boot.dtsi                  | 16 ++---
 arch/arm/mach-rockchip/Kconfig                     | 78 ++++++++++++++++++++
 boot/image.c                                       |  7 +-
 common/spl/spl_fit.c                               | 33 ++++-----
 configs/sandbox_spl_defconfig                      |  3 +-
 include/spl.h                                      | 10 ---
 include/test/spl.h                                 |  8 +++
 lib/Kconfig                                        | 52 +++++++++++++-
 lib/Makefile                                       |  3 +-
 lib/zstd/Makefile                                  |  2 +-
 test/image/spl_load.c                              | 84 +++++++++++++++++-----
 test/image/spl_load_nor.c                          |  2 +
 tools/binman/binman.rst                            | 21 ++++++
 tools/binman/bintool.py                            | 10 ++-
 tools/binman/btool/lz4.py                          |  6 +-
 tools/binman/btool/lzma_alone.py                   |  6 +-
 tools/binman/entry.py                              |  6 +-
 tools/binman/ftest.py                              | 34 +++++++++
 tools/binman/test/entry/compress_level.dts         | 12 ++++
 tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++
 tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++
 .../test/entry/compress_level_no_compress.dts      | 11 +++
 22 files changed, 359 insertions(+), 69 deletions(-)
---
base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
change-id: 20260915-spl-fit-compression-62108358dc6f

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

