Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29FC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436FC886FD;
	Tue,  2 Jul 2024 17:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XmcjZWqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6235C886BF; Tue,  2 Jul 2024 17:51:17 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B6087C86
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5db7936b3so2544516d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935474; x=1720540274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UyosxtcjvcSMGIAMUsWpj0r5nJZMV+jNm3Gv/IjcFxI=;
 b=XmcjZWqoGHNfUpMyOnPbXpdbe1ocphc6pOPnrlKpfv0HvAjTKPL9p2JXUVWezKfh2q
 cYkkQUc/Y75r/HJr8TUUGQhSFVIvd2IWyDxUHR9ndKb8o25XiKzqQPAEDLU1Yx249rBv
 uwuxYENEI1gucMU0plwW8i7eaqFUsqLhA8sak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935474; x=1720540274;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UyosxtcjvcSMGIAMUsWpj0r5nJZMV+jNm3Gv/IjcFxI=;
 b=m9QyPAYXMap0ndKQ7ggzkRjTxFf4+/vijdSkpZU6M50/hPWQF02v8kgdMcMqj2gHo5
 hochCwtO9eVnkIScdv3mPecaywXNhFWAAP4HeHcXa8z82cKOKHdqg1k44MmILPU56uL7
 eg7ahdT1Gd7ATW+jxyGZJ14445ZlllDYWytbneQ4a/XtAE9WKmWnmKKomgxu9DSdpa++
 Wjkw9sB/7LpxPkeTJri2DPBuyd8yJZpWyqq0lam0q2jkM+W21MqJhy0ykvVB27CNZU6E
 LhTtAYNxZHzc+UJmjGtYL/4Gj94Ib/o0xSUMjZhgQYqbptvNqtMbQVvcvERcB2Xgn4Yu
 NQOg==
X-Gm-Message-State: AOJu0YxA6kjGbRN6IggKI02r9xHjx6NnouN/LCv7qeDk5P1PIY/AoJ9r
 1mMylGEz+xvR2AgvcAWSDXxuxit0JPGggKnCsC1EGt2dIhn05VSQ84D16fDFqCzD7DFhA8gHLBk
 1kl3+PR5IWF7d0EaUEnwt0fFDotMsnvHD094ACdnvetbAJxk=
X-Google-Smtp-Source: AGHT+IH/jvIcJP+shsGlExLifVUYON0VdKIHgN+FLHFPvwMna3Z9sl3YYBnueU3scR/WvN99HF3M9nyTZNRZZvS/pVQ=
X-Received: by 2002:ad4:5de9:0:b0:6b5:46f1:6b01 with SMTP id
 6a1803df08f44-6b5b7185e04mr99828206d6.61.1719935473877; Tue, 02 Jul 2024
 08:51:13 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:03 +0100
Message-ID: <CAFLszTghO10vjaofEVwqPKinG1gvRf8Jy1--77kx3SgkHLrFxA@mail.gmail.com>
Subject: Warnings with xilinx_zynqmp_virt
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

I am seeing errors when building xilinx_zynqmp_virt:

Can't set hash 'value' property for 'hash' node(FDT_ERR_NOSPACE)
Can't set hash value for 'hash' hash node in 'fdt_35' image node
Can't add verification data for node 'fdt_35' (<unknown error>)

The problem is visible in CI, e.g. [1]

A bisect points to this, but it might not be helpful:

46f04087712 (refs/bisect/bad) arm64: zynqmp: Add support for vck190
revB system controller

Also the board seems to be the only one still using SPL_FIT_GENERATOR.
The migration message was added almost 3 years ago. Would it be
possible to move it to use Binman?

===================== WARNING ======================
This board uses CONFIG_SPL_FIT_GENERATOR. Please migrate
to binman instead, to avoid the proliferation of
arch-specific scripts with no tests.
====================================================

Regards,
Simon

[1] https://source.denx.de/u-boot/u-boot/-/jobs/861282
