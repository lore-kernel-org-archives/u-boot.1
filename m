Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B72CF8552
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3909089065;
	Thu,  3 Oct 2024 04:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KOCyix3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783A689131; Thu,  3 Oct 2024 04:52:44 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54054890EB
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb25aad5dfso4949766d6.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923961; x=1728528761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99Qh+7ONHJaN5kXT++F/z7oUd/xW93PLhngdYIezVNc=;
 b=KOCyix3V/kYOZC7CO8yuyEJSb6aPSJkTMtbxNkNL4Zdn+Tc14VxLyibzMzTMK8hBs6
 kaHY+YyIIH1W5W+OI2MSD2MIqNowqmG2mjXjwsOSF5tG/3FWFn9g91VvIWopIc1F54Ej
 IIE5VlYWCq3IyX+lupNkeDNNODvDE2IQ7zIbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923961; x=1728528761;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99Qh+7ONHJaN5kXT++F/z7oUd/xW93PLhngdYIezVNc=;
 b=paZSNg1wk0eKohZi+TbVPcYtxk887jwYMOuR3MHShmLPUrmlILnkNSPWv5xV6AvzUw
 5WCxDSbBFrNVgmkidmUMN7nBKGrjHdU3kAnq6zBlCRbQQD/KlBESvXn3F/ld1ZqvA1m/
 eONKjaQ4yP923z6A3+0bk5+9oIYQcjRwInj48ccu4yI+d0nze8T50qQ3/GB6VPIRzNES
 kEByQUQxK11kcklCtcASqJRNTFAu6ppHe1ViWMTurKlyqBAaaPNb0tQOQ27eUzxfELlu
 83PYosS7o2Bkb3FhkVCP8Qh8WbQdHFp+wBcCnQK0aps0npBSxwwTxwLhq5eUXC4Il4hY
 tdeA==
X-Gm-Message-State: AOJu0Yyl9/SQyDUrjqd2BR7y/M5esKN+qhz2VNORbhJmOhzzhQ8s5vnZ
 IBnhpNWoWRlxVGMubq4z8o0twl6hTkzN4WF3TnaCHyTLJiIp0grscmEIywzv5RQ=
X-Google-Smtp-Source: AGHT+IG52T8LbmcWhFqSNjdgi7j9vD5ot1CmWN9h6JkEw5jY08eJal2RI9oklzKS5cIu/LZrVyxFGA==
X-Received: by 2002:a05:6214:5d8a:b0:6cb:3c08:1721 with SMTP id
 6a1803df08f44-6cb81ccc006mr68438546d6.48.1727923961302; 
 Wed, 02 Oct 2024 19:52:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christopher Cordahi <christophercordahi@nanometrics.ca>
In-Reply-To: <20240920082806.74253-1-bastien.curutchet@bootlin.com>
References: <20240920082806.74253-1-bastien.curutchet@bootlin.com>
Subject: Re: [PATCH] spi: davinci: Drop the preload of TX buffer before
 read/writes operations
Message-Id: <172792395919.1516896.4432938741386278871.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 20 Sep 2024 10:28:06 +0200, Bastien Curutchet wrote:

> A write to the TX buffer is performed before entering the loop to "avoid
> clock starvation". This sometimes results in subsequent writes in
> davinci_spi_xfer_data() to occur while the TXFULL bit is asserted,
> leading to write failures.
> 
> Remove the preload of the TX buffer.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


