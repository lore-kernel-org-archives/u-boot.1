Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F20CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE528323A;
	Tue, 12 Aug 2025 00:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y2DE8r4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B94D8323A; Tue, 12 Aug 2025 00:20:58 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFFD831C2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8817b8d2d0eso169624639f.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950855; x=1755555655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PehNwJqxigRVGWNusaRJUBq8wUU/jSGI+gdHBC10lKw=;
 b=Y2DE8r4Lv1AZ4SamZYP3xkOu476nM7fmDFZ1p/MJ1bMilJgQsbI5xGGGiRsaeC6ipQ
 TOKSM6odN2yIOt7HUaa15AcFuHy0DyLH4p+sAgQctADn2y6IBi1qlrz2k9qRD8wGJa9N
 C40RvFvZSNyfE2TfK9vLapcynNTv8mGj4uYt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950855; x=1755555655;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PehNwJqxigRVGWNusaRJUBq8wUU/jSGI+gdHBC10lKw=;
 b=amznArE5fz4YbZXytfPSZO76ll6RUqASazezmraBoSQzdDOEmNiKPSS3ly3osUIwgM
 YG/dr2SQpQEvPK4roz4eFCDs6Oat38GXp+Kj+xeO3xmRkEXumLuIrUM8IJypJUtgSHSq
 ugJ8+ZRj0g8oLTQBTYjaIQfVFkjD9QZFrO6PAeqPpdA/mDVb2KX7cD2XF5TNQvawVlyq
 eWjJ9HX6TsbDNH9E1FKVVUG372X3PxZtWj/cOhAySDcvcN8e/4YMd/6N+6dmekCWhza1
 1SgsQwXPV2Tjldp+1aspvZQXHQt7ThKJUrRBJlsinuE73IMqC3nzD9x+N2b1EQHXNPfo
 MFvQ==
X-Gm-Message-State: AOJu0Yyg84h9hjhgJxC13WZ0oVeffrwBau0jVt2Rz6zepQ2oC+3PSbO3
 YhkY+GRka5lmFMpHtCmIoHhK7BmanhiLioYBWbCdXVR0gdtZDWuZglr53upeGErRO0g=
X-Gm-Gg: ASbGnctwvrkt1K3zWRAA2LKQSbr7qF2ZIBVUABs7SqfWYPU6QCRVHIAF/a1QQJOoWK8
 /hZBQ/gaPodlxmnsHascO4F8iNyqA/zZDxJ3puILKpnpc05kKAt8uiARtjgNCFOnYHE2LIjKz7W
 /fCsF/WIb81heOa8jjzLttgCtMp3aNgyl0892e9+Q5OC8jzvVPHp5K/iQ+VT09MzHqecnMtj//S
 C56RejguumKnzhyFkyL9C2+NHoKzo4Gu4NMUO8V1fmrTl6v6wTu9SgpvxKtQ6xz31yw7Yqf8UgY
 8IMPHMLbRpDxwBtpjid2sQN/hLujLSJrknw4k1JRR/QLWlZGXJWx6JTy4HtoFJcplE3KtxxEg8S
 At91sv8ifaAndyRY2nsSfjp6gyuwhvox+YljiMow3cb2GTA3tFU64GMk=
X-Google-Smtp-Source: AGHT+IEibhm3rVzrQcDZHLTAMcHTn51T00T2kYz3rD12TGlHtPPTgr421ID4hgNoWINUMl+7i40fcw==
X-Received: by 2002:a05:6e02:3e8f:b0:3e5:29a3:b552 with SMTP id
 e9e14a558f8ab-3e55af0ba04mr21804065ab.3.1754950854699; 
 Mon, 11 Aug 2025 15:20:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:20:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: ggiordano@phytec.com, bb@ti.com, d.schultz@phytec.de, 
 nmorrisson@phytec.com, joe.hershberger@ni.com
In-Reply-To: <20250730154217.1116751-1-w.egorov@phytec.de>
References: <20250730154217.1116751-1-w.egorov@phytec.de>
Subject: Re: [PATCH 1/7] arch: arm: dts: k3-am625-phyboard-lyra: Disable
 unused watchdogs in U-Boot
Message-Id: <175495085322.1657597.1612876603151416331.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:20:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 30 Jul 2025 17:42:11 +0200, Wadim Egorov wrote:

> The watchdog driver probes all available watchdog devices.
> This causes SMP boot errors when bringing up secondary CPUs.
> In our setup, only a single watchdog is needed to monitor the
> boot process until userspace or the OS takes over. Disable all
> unnecessary watchdog devices in U-Boot to avoid conflicts
> during CPU bring-up.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] arch: arm: dts: k3-am625-phyboard-lyra: Disable unused watchdogs in U-Boot
      commit: b17c594ac499c8cfb91093d62ff83d90a547ecf1
[2/7] arch: arm: dts: k3-am62a7-phyboard-lyra: Disable unused watchdogs in U-Boot
      commit: dfd185939d9e4dc89e4365b142a14ffd7e775854
[3/7] arch: arm: dts: k3-am642-phyboard-electra: Disable unused watchdogs in U-Boot
      commit: dcc85e9aba41c82e9b54d2d925f83233842285a1
[4/7] board: phytec: phycore-am62x: Add watchdog start to bootcmd
      commit: d27b7a1c777abe1bc103c983d0af082345457e7d
[5/7] board: phytec: phycore-am64x: Add watchdog start to bootcmd
      commit: 9de098a9f85eaec64389fd7ea1848110e6da36f6
[6/7] board: phytec: phycore-am62ax: Add watchdog start to bootcmd
      commit: cc6291e3b4a4a8520a3c4bb44eae2ecd8f1e9c0e
[7/7] include: env: phytec: k3: Add deprecation warning to legacy boot flow
      commit: e8eab15d14a9fd17ee5e99cc045ca15ff5aa8eb1
-- 
Tom


