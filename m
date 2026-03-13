Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA044107BCD1
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A467843D8;
	Sat, 14 Mar 2026 00:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qz2DIeu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05568439E; Sat, 14 Mar 2026 00:39:52 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2B5842FC
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d756f2a06dso2558046a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773445189; x=1774049989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYvGoUAouQTFrreS9Jh7N0/vCytCN0r/MSG8tQ1HMmI=;
 b=Qz2DIeu4lUsHA9sThn4ArYX8tujqNd020h4lGf9fhWUPyZOkVI6cP2iNOHbfL7KMLY
 DyQ4vo65RmZM8+Huo7WatCWDa8Wu445+H+SsjkMvznY852nXCV+h64ZH3n2ZlD6qpDKg
 nhtfWJt8OTBdMCTCzYgndxNB/E2OqgX0GCPzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773445189; x=1774049989;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYvGoUAouQTFrreS9Jh7N0/vCytCN0r/MSG8tQ1HMmI=;
 b=JwohFU+01RekaXdN5Fj/F1TRvK0/25trDTWR8ai8ODdbPhgy4gTxnogte9eS7f5uCi
 dzFxbPWSnBUPnlWI6rv0IOMIfzfKQuTECE2YORJcOKvdnXUS4pSkS1X8iw1e6uBMVLCc
 WkJqHNk19C7Jjtqt8CSeLpw6bqJeupZq3+1tup82UoaRq7pNLwb29Zrx1tGrlC2dbmh2
 +hnD495iMehdcxzYFN73ImBW8qWyQv7eN2IZnB7MG+8XurrKbd3ihSjZrLsKCHCFKXyD
 3+gJjtu30POoAnKLd4hG+IA+pNB0stKIEAktmzg+UnMHp+R3FZyIx23/kPGibE+I5wEr
 8RPA==
X-Gm-Message-State: AOJu0YyuK1TYz2SiRC5EHHQf1Z5q2NCh4r7vtRf4j3p32ygoXFuOBmho
 ZSyGKU+iCs71PIxylW+0ZP9HaBUdZI4fTAwFbY/NMIFC+DxtURtlOz6Xoekzhez0Ars=
X-Gm-Gg: ATEYQzwMy3B3PZ2MnuyciplIkgUDj88ho6MDEAsbBTYkDTUWYEgzReDYRhjHPMW5YLm
 vjRkoO4NkkQOE8VM/HDUXXUCL7nhW9uCSTR3qush0vpiWsy80tWCd0iOlbkmojyJiAbp/ubhkJ4
 quViAocIdko7wCG2+/XrPFMMRU79tTqx8Oj6SnlHJZgVsS3kZ/QSpwLaaCk8p8nIqinOW4KwvVX
 /m6uIhjW0+0jOaM7m3rOFaVKB3T+Ylq/ZOW3diRm9AyAA3CXmtu/eWutE3+miQRxZE+jh1bx25y
 qImvtqraM+g6ZS8GnRESit4FHLaRlzUf7GUb6F/f9qpBFIWJsSwdpRSKugE1y6kWgKyKZZ75OkP
 KooTizd0h7NCtB2Z0WM0rlxyV9Ea+3kKkm53Rfm8h2SQ7nNQlka0WJ6MTzVGCzJH3DbbpUuPKtq
 W+X4EdHov5sSIkjHlutzLJuU/wHQ/CPERAvSOe8LWHLqZ17hNSx5yaJWghWmAcBdo9NdC99UfJZ
 t/Cqc5pVzm6P1X9i1sbnu4yVPa4liW5Sj7xFmW6b6mbuO4=
X-Received: by 2002:a9d:6450:0:b0:7d1:48dd:b439 with SMTP id
 46e09a7af769-7d776b27c64mr3862152a34.1.1773445189216; 
 Fri, 13 Mar 2026 16:39:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec4c8bsm8096892a34.25.2026.03.13.16.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 16:39:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, vigneshr@ti.com, praneeth@ti.com, bb@ti.com, 
 Sparsh Kumar <sparsh-kumar@ti.com>
Cc: afd@ti.com, n-francis@ti.com, vishalm@ti.com, sebin.francis@ti.com, 
 d-gole@ti.com, a-kaur@ti.com
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
Subject: Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS v11.02.09 firmware
Message-Id: <177344518785.1178192.2824747751706882574.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 17:39:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Feb 2026 18:54:16 +0530, Sparsh Kumar wrote:

> This series updates the Resource Management (RM) configuration files
> for AM62 family devices to align with the TIFS v11.02.09 firmware.
> 
> Background
> ----------
> With the latest TIFS firmware (v11.02.09), an additional virtual
> interrupt and event is reserved for MCU cores to DM usage on am62x,
> am62ax, and am62px devices. This series brings the rm-cfg and
> tifs-rm-cfg files in sync with these firmware changes across both
> TI reference boards and vendor boards.
> 
> [...]

Applied to u-boot/next, thanks!

[1/9] board: ti: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 7f9c2a6f7be787cdd87a4d640354ca205dc8ccb3
[2/9] board: ti: am62px: tifs-rm-cfg: Sync tifs-rm-cfg with TIFS firmware updates
      commit: f2c4fb442d058be9acefe61ed64d7abcdad885e3
[3/4] board: ti: am62x: tifs-rm-cfg: Add the missing tifs-rm-cfg:
      commit: 964bda9e805de2716b9aba8d67759218feb5a7ab
[4/4] arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in binman
      commit: 41814276f03e93be0cba2f04e9b45aac93b38c26
[5/9] board: beagle: beagleplay: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 2a64978fa89a8024779ebdfb21141ba7bf468cb0
[6/9] board: phytec: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 19b9af32b2921b9109014332c14b69b682461bd5
[7/9] toradex: verdin-am62: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 64ebab10b5eaebce34d455201581216fb72a8ecc
[8/9] board: phytec: phycore_am62ax: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: 73b8caf965b9c0ff73d89456033f72611f26f040
[9/9] board: toradex: verdin-am62p: rm-cfg: Update rm-cfg to reflect new resource reservation
      commit: a66704e9a18ba3a290a95ab22d87ecc3e2b62f56
-- 
Tom


