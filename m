Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F97CC7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8331286AE7;
	Fri, 25 Aug 2023 23:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ENGbizgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7308186A77; Fri, 25 Aug 2023 23:53:41 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF3C286AE7
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7225259f52so1440922276.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000417; x=1693605217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoprNLVkFUFkV++qoHmOukg9lGo1tfNxalKFur0FoN0=;
 b=ENGbizgD1WsR93mZ/Tv7b3/dczuwp+S5fWKtefS/0x8nms5XPVKZJRNF9XIFPFMcnG
 GW79OytxVWfcgT5jZKBepqUhQ+IfQjeCOASg/E1HvUNC0pJcPF14IGyJ5hiNrMaag7wU
 2OXqK8Q73MPo2DiLRvA0U5MViqMZLdlM7deSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000417; x=1693605217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoprNLVkFUFkV++qoHmOukg9lGo1tfNxalKFur0FoN0=;
 b=bINma5T3nfgZkGW0ryOH4BGK4RTmvLqrvWnveiIIRcYMtizgBG7HrFGrZyGD0JegmG
 A/bDbRC6PCQQmOYrmJp8h1+EcZ39H2tYRnXIal2Nx3s96Iw0xj0iQfJf8eL1rk1MZlqI
 RFvCypNuXEGYa+cOevah3kbKRc/qlDK1DgKwvx6ga/Ee13TfWLiFTMvw6eWUJ/+c+TQL
 EN2VNyV83mHVoqlIalyM64wmL7r1lzjhoA2Q/Xs/3a2AG3Ko9lDep0NTtwhanFassawo
 GZnlkYhgcNX6Sug081xHHs1m312wgQnN4Tcf0ZLXv/vytwdStKG1qH0i2INeS8HvKHeU
 sXmQ==
X-Gm-Message-State: AOJu0YxoFJr/IXjBdbWfkbaUaiTldMqojYfUONXpjgaNPF5sQr1c+y/N
 r9pE+iYiBftfXI01GnhLFKJ9gZk/u72M6fX5QZI07g==
X-Google-Smtp-Source: AGHT+IGTkFbeiguDsdtszJlhEVoJEztcWQyU08+sXmU7h08lLTuvOLt3/UbaLHip4MeyYnckeaJkJA==
X-Received: by 2002:a25:874b:0:b0:d05:59cd:a89d with SMTP id
 e11-20020a25874b000000b00d0559cda89dmr17591314ybn.30.1693000417358; 
 Fri, 25 Aug 2023 14:53:37 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a259391000000b00d1d0841d911sm563082ybm.17.2023.08.25.14.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:53:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robimarko@gmail.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 00/19] expo: Support a persistent configuration editor
Date: Fri, 25 Aug 2023 17:53:35 -0400
Message-Id: <169300040145.157317.8377091210198781910.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 14 Aug 2023 16:40:20 -0600, Simon Glass wrote:

> So far cedit does not support reading and writing the configuration.
> This series add several features related to this:
> 
> First, it adds support for using a file on a filesystem. This is in
> FDT format and provides enough information to reset the cedit back to
> the saved settings.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

