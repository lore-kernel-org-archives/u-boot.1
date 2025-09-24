Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FE6CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 00:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44C58341C;
	Wed, 24 Sep 2025 02:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kXV/8h30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E055A83448; Wed, 24 Sep 2025 02:28:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A328341C
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 02:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7939ac99c29so1141157a34.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758673708; x=1759278508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IluQxoKOzhTMjCNbdZsKaVHdQhqrDlVzJUv7w6MXMZE=;
 b=kXV/8h30YOCNuGibPN7itKV0uU5PdIfeHQ0rtqSlM2kAja659BT77UjjKKUwj06/2u
 58hvfQz4n6o73+nGTVUkZe8dm4VDU6e1/lQcashV3dRlCphM4teJeLS/F00UqU73Y5mS
 FX7lHigy/tMOjyfx5TMAnLermXBl/ZZiDNHt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758673708; x=1759278508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IluQxoKOzhTMjCNbdZsKaVHdQhqrDlVzJUv7w6MXMZE=;
 b=W1JGQWryEXYfCA5UjZ309x1Kpn9EibmgV2WLJjHxMkAESHtJdogUnbg8FSXrRWjZeo
 Rox/818Zmx3yxpwpg/zGZpo+KCmn/iX/r2tQmpMspXlxfmcg+woBxW3rc4qNSGCehzJD
 jpk5apIJQNdPv1/AO9uIDWxmEAb0Ka/6lGpe6CsEavyH3Msy6BmX2AX56xOo68ts3Rx9
 GOOFGzdDrs2QsbsAaUGHyJfLxmKvmsPV4B6QsUEQXoUZOyH3G/3MzQd1nPP1dfLc9CR4
 ukPN3q18ND4/oVe4bgPbKXVsAb5x/Or/x/eqkLFwRvkuSI5TSEtj/UGhIiDir6bCYBHC
 dAqg==
X-Gm-Message-State: AOJu0YxtZyPNbhkSOMepSl9u9cGyk3mtxxzwxjx1hfXWnZ5E/DTtLmJF
 ENcXh6j2aE2+NAYGjbB4bUj0tx2i6cs1CXD40CyBdCbqkSOD495leOGTT7m+LDNQtx0=
X-Gm-Gg: ASbGnctDuEmzDYFpXPWc4GAcrNNJh172/Olw4LvkYOWoHzxo8++No5nYuWrzAcG3/zR
 5HQB88Q/MXuB2f8leQk+ES9R7scd0fHWyXlHGQGcrXPnocHbzNBeVfoiTGztW2BZdyOy8VPIuRd
 wnjrfmNyVccuJJe/Rzz3esc3AhrQJSG9h0Muw8PP0P0O8kqaqAOHpwaz3grnqxZBPS85dDjQtTY
 pEYLmZKTj3l0cp2ErT0msGjzF27dFY28IIeVzAIOL0YfBFJRw0hTWpsfjr25po9m5CqR6R3Pg7/
 RCsB131DH1h48CE8V0kDep1OuDh3PXRGhPFdHuzFOqeupXHTJKXUTPL82lPXQ5SUFO3wCOkPfDx
 uQ/935dat0N2cm4eO+B53Q4CEiKA6GjicLYAXwt/OLbXFCvhBdlMHzls=
X-Google-Smtp-Source: AGHT+IHOeQaohBC6wk0DSVHz4AeWVhvtj4yYOUmaYgxWeMZUK28+LIQXYmpQlwaL3RGAKAIjzA7baA==
X-Received: by 2002:a05:6830:486b:b0:794:83c6:20c9 with SMTP id
 46e09a7af769-79483c6243fmr1507078a34.22.1758673708297; 
 Tue, 23 Sep 2025 17:28:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7940065a943sm856439a34.40.2025.09.23.17.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 17:28:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Simon Glass <sjg@chromium.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Yao Zi <ziyao@disroot.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, Baocheng Su <baocheng.su@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20250919210457.291632-1-raymond.mao@linaro.org>
References: <20250919210457.291632-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself into the list for MbedTLS
Message-Id: <175867370658.246334.8825190426318310404.b4-ty@konsulko.com>
Date: Tue, 23 Sep 2025 18:28:26 -0600
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

On Fri, 19 Sep 2025 14:04:51 -0700, Raymond Mao wrote:

> Add myself into the list for MbedTLS.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Add myself into the list for MbedTLS
      commit: d3074f3d699d188bbeb68feacc473d8bc53ce762
-- 
Tom


