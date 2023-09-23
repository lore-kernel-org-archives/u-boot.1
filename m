Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BCDCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD4786844;
	Sat, 23 Sep 2023 20:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eGwNPXgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69CD18691E; Sat, 23 Sep 2023 20:16:55 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423C68469B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50307acd445so6249273e87.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695493012; x=1696097812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CX3msvIbHB/GBJZFnPuv5Gicq8zBtQu7R/U7c/aIDYs=;
 b=eGwNPXggdGkXNMHt3USVXKXhXJmZW/HoMx0LvXpcg7zevscKPnvOoNmgpELk5k3jML
 yda8mlatmImCGXrG6XnnhOWO1jQ20UMh1oZ5YgFgaDVEOGcWM/T9ILCBOYpxDlXiez+x
 kYJIBf7vUkMAiJ8weJ/lPNDvgN+EfMIchj+Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695493012; x=1696097812;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CX3msvIbHB/GBJZFnPuv5Gicq8zBtQu7R/U7c/aIDYs=;
 b=P+Kcs7++84ukLdhwTieR/G7FEkMUZLQbN7pdcemd1tTtV1LxTOQ5m/XLJyuzKpeiZl
 iD+dryClpAuuepMwfPMgPBn5KS4M+VJA14Uyz6rM6ZIeasudKe+eud0G1LFCsqoTHTvq
 7BPQNFksgCECRwrm1ugcFghAIlvt7/nSAAZ7ozm+LNQHu2SvfGX7fVlZXeJtvz3IOFA0
 J0WOuiBkcLkDH3BXSXkVSoJmG5hCfDq2xeCG0grpxdmfEPVWipbWaIBUyr/ldHn96hhg
 aF6wMk8mNC6HYBMDIo5077yiZolBDS4uCZGC/NvbfRHwK6BYk6uLSvOBFHltE4H0Gs25
 B3+Q==
X-Gm-Message-State: AOJu0YzCbZyVfHJIkQl/JrsFiDwDnZ4SO5cXJ+aPYx6t0lPNCKKLkwSH
 gOu26YYHH0suxyS/W3ii1wh0NmKGabj0n4yd05yRkfNiqQXd1RbRGcnroQ==
X-Google-Smtp-Source: AGHT+IFETt+RmX84LcAO1wDZ1F5wcJLLVRF/kcl9bG/FeSVKrz+vTG26zPrn0G8kKHK6HuN14yiDsgEeetrdM7QlVOI=
X-Received: by 2002:a05:6512:3714:b0:503:970:4dbf with SMTP id
 z20-20020a056512371400b0050309704dbfmr2138900lfr.15.1695493011915; Sat, 23
 Sep 2023 11:16:51 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:16:40 -0600
Message-ID: <CAPnjgZ2kgk1Oc17wNJqH+33PGYf150Aaex_ZnoZMY45f0YsifQ@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17830
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=48&view=results


The following changes since commit 4cb31a9f3560b293670de95e76c1f3cf2f9e1ca8:

  Merge branch '2023-09-22-assorted-bugfixes' (2023-09-22 18:25:37 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-23sep23

for you to fetch changes up to e278ad9a2ea5e4a089773a8fd79a5ea0e8572316:

  trace: Fix alignment logic in flyrecord header (2023-09-23 09:00:37 -0600)

----------------------------------------------------------------
trace: correct format of flyrecord
minor bug fixes

----------------------------------------------------------------
Fei Shao (1):
      patman: Respect include directive on Git config lookup

Maxim Cournoyer (1):
      tools: Fix patman launcher script.

Michal Simek (4):
      sandbox: test: Fix typo in test.dts
      trace: Use 64bit variable for start and len
      trace: Move trace_clocks description above record offset calculation
      trace: Fix alignment logic in flyrecord header

Rong Tao (1):
      binman: Fix SyntaxWarning: invalid escape sequence '\('

Simon Glass (1):
      buildman: Fix full help for Python 3.8

 arch/sandbox/dts/test.dts     |  2 +-
 tools/binman/etype/section.py |  2 +-
 tools/buildman/main.py        | 10 ++++++++--
 tools/patman/gitutil.py       |  4 ++--
 tools/patman/pyproject.toml   |  2 +-
 tools/proftool.c              | 39 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 47 insertions(+), 12 deletions(-)

Regards,
Simon
