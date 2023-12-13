Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E18C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F0386ECA;
	Wed, 13 Dec 2023 21:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cZaeBMGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C74587646; Wed, 13 Dec 2023 21:01:27 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF3F8749F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbcc63b7c68so1695976276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702497683; x=1703102483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qx+hZ2dW2DhzBWV9ah+UIb3u7WuI0mqLzlIVuMRmEk=;
 b=cZaeBMGjCA3dgA7M/g9BFqFLsEIa4oI0tKrxIAKQGdVYic4Et4VvROTb8PwtDzE8jt
 nkskuU0d4cqg65g1cQBDaEyFV95EJ5rSQ/89vwA+wCWH+Wx1NsbsJHZiwiM9P6bYYmWX
 4ILz51YinOImypsgiM2YNui7VGCn7wcMwBgJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497683; x=1703102483;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qx+hZ2dW2DhzBWV9ah+UIb3u7WuI0mqLzlIVuMRmEk=;
 b=HANyaanudsDHutGAM4kDztUvcL38tOfH97j9yhhQRkGLWVEUB0z3GpIQT+1iz+CWyT
 SLQzwmDQ8zEgPSvPw/KNTcLk32Rl/ApwChtqTMRb+xLK+jShgaifsGYsOpQ81UGKajWh
 MkxeE058aPfLqSB+0KjI/pEjw0EuP4MRkfSwrTwqceIMzcky3Bi5qU7q7ip9MlxZn2t9
 ZcKlEYd9Iu3XFS9S8v+zDiX4xW7brNJRVMc3x/DnfO6kDImM8Vc4/8BIVybJhiejXwMG
 1sXEKERU7y14+ywgjgTpqWxIwJQsQksXZx7i25xHEkokqlD1/wG/HneJCrq36j9vxNZQ
 DmaQ==
X-Gm-Message-State: AOJu0YxXjvOnc5LJ74YazwIr6NJ9GkDwzlVdPFkRq3Znmofj7BIuPagK
 B7xriRVs0YdlKgTvYJXkgSqLNw==
X-Google-Smtp-Source: AGHT+IF6Js/+8Vnspj2WKBMmkNORaO4jxP7E1Zj/Fa4Z7XSCvfnlPXXqryLm5rna5+dsGZbmAXZyKg==
X-Received: by 2002:a05:6902:1366:b0:dbc:b14e:4774 with SMTP id
 bt6-20020a056902136600b00dbcb14e4774mr3643230ybb.40.1702497683742; 
 Wed, 13 Dec 2023 12:01:23 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5b05c3000000b00d72176bdc5csm4176069ybp.40.2023.12.13.12.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:01:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Evgeny Bachinin <EABachinin@sberdevices.ru>, 
 Fabio Estevam <festevam@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Qu Wenruo <wqu@suse.com>, Safae Ouajih <souajih@baylibre.com>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, 
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 This contributor prefers not to receive mails <noreply@example.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/32] bootm: Refactoring to reduce reliance on
 CMDLINE (part A)
Message-Id: <170249768190.2729322.17736686943926786117.b4-ty@konsulko.com>
Date: Wed, 13 Dec 2023 15:01:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Mailman-Approved-At: Wed, 13 Dec 2023 21:02:58 +0100
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

On Sat, 18 Nov 2023 14:04:48 -0700, Simon Glass wrote:

> It would be useful to be able to boot an OS when CONFIG_CMDLINE is
> disabled. This could allow reduced code size.
> 
> Standard boot provides a way to handle programmatic boot, without
> scripts, so such a feature is possible. The main impediment is the
> inability to use the booting features of U-Boot without a command line.
> So the solution is to avoid passing command arguments and the like to
> code in boot/
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


