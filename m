Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E072FCD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29409839A8;
	Tue,  9 Jun 2026 03:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WUWnpnex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C66283FEC; Tue,  9 Jun 2026 03:41:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627B78341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6b571750bso3584910a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780969263; x=1781574063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp65/bVFpGfzdlCPUrMmusa3YFo9CClfHUivmhSwZaQ=;
 b=WUWnpnex8zF99amH9KHfWSA/UWnPJ4o7AClf96bwqclNxXPXFr6Qo/GTDbEuddGk6G
 ylxhaYae2FR5YSEeWio51QY7Q8r1e3ebt+ZX+yr5ArMQvWKyfQF65U4S2528QguJ8GRm
 UZ7lmM/fUZtnZcmbda4Dis/FZzcoSe8QJxgVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780969263; x=1781574063;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lp65/bVFpGfzdlCPUrMmusa3YFo9CClfHUivmhSwZaQ=;
 b=k/oNAiXGCYGk0hdi+Ik/w6H8646XGxSoGDv+FSnibL4htfoagCNQoM2G9BKPLcgqZ2
 /sdzrSGwmjL6IgohErnAlxVO1PZTtaqoRWwHguNXJuqUBmvd9SBPBXkn9X/AIH2PKbOQ
 ksgotlLeYzRCfFmqczpb+9YKnapuY5PBIy+eSJWpEwx+SMupq+O8QhWPqIiTsoZgzHT4
 /tMKs2YV/EBvXh1fDaNXvtqCMwlJiHhGwIqA4hGVg6Q4Nh/vhF/zfnLoRHPn2j8Ht4mn
 KMw6TTRNQwIHzlpaITdgsolnKAC1Dsxstl0XU5Lgc7timrkmkCvnmnD5FV9zRXIEBu8r
 +xiQ==
X-Gm-Message-State: AOJu0YzP5ecKCfsRlNZieVUfG4kTaT7spKwdcUbQX9q6YnoBZfbPCMvQ
 Eih421I4DelGbL8unOUG/lfqlgu1G7PPsUDnYQ47j8UeJHUy7uxglSb7BAVsFdUMmNc=
X-Gm-Gg: Acq92OF4vh12QGDm4Rs4XH2PigCUYzyyUSnV5qPcH5DZEwdD1wpQpD6+Ydy0xYMTPOJ
 T3PLU+cXo4esI/mBQeBpbBR8zvszTf4bIJ9Ct92jiXTKiaMOt8OA8KOE0XHYzen3qyIiwIXV8no
 W8ZJenFdM6Kzrpy6pvElsUKWPvdshbHF6l4lgt5SlaE0T0sm+7XAXZeyubMZu9/R6KBcuUBW6jV
 se6pdEy+hFirrlqFIEBDlW9+2YUtvG3OsoUne8cd90EQ99HaKzISKXxJIfwUTnHMx9BCcuyYDHB
 3O6k8RMEwUS8Zk4RZVlve3gW9A2hI0gjuvrEWGmmjPFR+BoeMIHa/XDTTEvSR+SDVZJN3CblzWk
 BxWSZs6kY+tJCJsAR6eGFof5s0YpRTnHNnDwMk5sllBXnyohPIPZ1IizahNDEUQbBaicjp18TWL
 MqJ3fy6I6qT3h65wvDDXmcGNCT6VfSC52j/aCfWiQzCycdJ3eCRXmO78CoBwwC7R0Otehovbl85
 czIzHOOUVK4U3t+mPCslkrDijZtpavadfTVMZLXHbGpKSxFidIvsuCj2tDGBVqfgk4hTPE=
X-Received: by 2002:a05:6830:3892:b0:7d7:c985:3a30 with SMTP id
 46e09a7af769-7e751a6a795mr282487a34.11.1780969262938; 
 Mon, 08 Jun 2026 18:41:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e726c2ae05sm6219972a34.15.2026.06.08.18.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 18:41:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>
In-Reply-To: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
References: <20260518141712.3597880-1-jamie.gibbons@microchip.com>
Subject: Re: [PATCH 0/4] mailbox: mpfs-mbox: fixes and syscon support
Message-Id: <178096926139.3611135.13555143533502241783.b4-ty@konsulko.com>
Date: Mon, 08 Jun 2026 19:41:01 -0600
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

On Mon, 18 May 2026 15:17:08 +0100, Jamie Gibbons wrote:

> This series updates the Microchip PolarFire SoC (MPFS) mailbox driver in
> U-Boot.
> 
> The first three patches contain a set of bug fixes and cleanups to the
> existing driver, fixing MMIO size calculations, and removing invalid
> mailbox channel and private-data handling. These changes are independent
> of any devicetree updates and fix issues present in the legacy driver.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] mailbox: mpfs-mbox: fix MMIO mapping calculation
      commit: a05adbb9b30115ef7d04668d35650f311458dd2d
[2/4] mailbox: mpfs-mbox: fix Driver Model private data handling
      commit: 1173e02c9880d9f7d1bf15308490493332b03a61
[3/4] mailbox: mpfs-mbox: fix driver bug and cleanup
      commit: 763435d0e3124539dc36c730c3832a1b4162d3f7
[4/4] mailbox: mpfs-mbox: support new syscon based devicetree configuration
      commit: 6c128738240d7e3a6020676501ad382af3359f3e
-- 
Tom


