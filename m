Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8470B87136;
	Sun, 12 Nov 2023 16:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKv0IQcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971F586F89; Sun, 12 Nov 2023 16:45:23 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9B586E2F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c50906f941so52314661fa.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699803920; x=1700408720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QF77t3w6kK2IRgmKxygMspMHryYEUtHFl0sYxN2BIXQ=;
 b=VKv0IQcErX1XwJPWV9q7ufJqDwRmD4u9hmCf0KWa3V+txcp0NaEpsdqVUn33WlFf42
 LkS7PMj0/tResuXaQVFxaGMDm6U0M0T8N8PdaiypXAtnCLyDigLzqT0MfBUbUK5EPhNd
 spwBrPDQz8qDbdVE4gQE1G/pniahqc9Qoe3buqkQd9nqgnQ3vdbMIre30fwzH9tP1YHg
 h7l9QwbyqMrfr+ZNv0yohIyFXFnnEc8yx6/FuP5XFksN+HlXaqMqjsPqBcBY+PilkwsR
 j438wAWFzm/Ut8rzJ/xJdwU27JvMOvkIvcguCcuUtfSo3HchldqBWE7VZs4Fpg9HSn28
 soDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699803920; x=1700408720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QF77t3w6kK2IRgmKxygMspMHryYEUtHFl0sYxN2BIXQ=;
 b=SCaTIKQ/zg+1hLpK03bvTrUIURR+tCV3Hn6quet3v9OW0CxgS+2+pC/UCuRjIvo7W+
 9eAAbl0Y/tdeHOI0Gg8ZyUMYUsxCHlFxLSZK/JHjlYwR8tLgPByHuVmjn+j0VeqoeH7E
 xehotOaGVQNFOYfJV1SUkGZOHj2ErnxMnpvWtap+bBDQkLtteGqf6I6SYPcvpT39jrD/
 V+/6rUZaTGFTNsnrXN/gi6my+ffEHhUp1sSvRSwxQ1MKMysw2ppnubVFsCSrGYZjgnOb
 3K3Z1rPo5QV6hYiHiaHYCdtZfwoXVQ2J7OzN9X0adIS7P2/L7k+g/azof1IHPmAVWDqq
 Ol9A==
X-Gm-Message-State: AOJu0YzGUdeIpWSdR89qvuS99Kg48Wnf2BO+sl6PVj45shLacGY55OfY
 K0txxgGh8wQa/16oYZBnge0=
X-Google-Smtp-Source: AGHT+IGJCAtstEhpfHHD92pvIwWE9rTy2Q9Djy+aNcI8DspNksIE7SQHvUp7TX8Gx/4uEHDkQEdrjg==
X-Received: by 2002:a2e:a28c:0:b0:2c6:f6cf:aaf6 with SMTP id
 k12-20020a2ea28c000000b002c6f6cfaaf6mr2793620lja.46.1699803919857; 
 Sun, 12 Nov 2023 07:45:19 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 o16-20020a170906359000b00989828a42e8sm2670146ejb.154.2023.11.12.07.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:45:18 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/1] sunxi: H616: add LPDDR4 DRAM support
Date: Sun, 12 Nov 2023 16:45:17 +0100
Message-ID: <2704944.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20231111091000.26744-2-iuncuim@gmail.com>
References: <20231111091000.26744-1-iuncuim@gmail.com>
 <20231111091000.26744-2-iuncuim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Dne sobota, 11. november 2023 ob 10:10:00 CET je Mikhail Kalashnikov napisal(a):
> From: iuncuim <iuncuim@gmail.com>
> 
> The H616 SoC family has support for several types of DRAM: DDR3,
> LPDDR3, DDR4 and LPDDR4.
> At the moment, the driver only supports DDR3 and LPDDR3 memory.
> Let's extend the driver to support the LPDDR4 memory. This type
> of memory widely used in device with T507(-H) SoC and new orangepi
> zero3 with H618.
> The compatibility with T507 is not yet complete, because there
> is difference in the phy_init array.
> The LPDDR4-2133 timings correspond to DRAM Rayson RS1G32LO4D2BDS-53BT
> found on the NOR SPI from the Orangepi Zero 3 4GB.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


