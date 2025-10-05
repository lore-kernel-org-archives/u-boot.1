Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291A6CCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5AA807B1;
	Mon,  6 Oct 2025 00:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbdFbUYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0B6807C0; Mon,  6 Oct 2025 00:12:07 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618E1800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so39976945e9.0
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702325; x=1760307125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=djGLDaCPI+Z58EfZHA1Eb4mCBIq/E0fkKKuAVEgwRQQ=;
 b=QbdFbUYmltDRBQZs0ZmtSGaVpS4sCGUu5kWkJpQcdayERrKB6sQKV0uFZdG63OOU4S
 GRDXtS0kkOZ1YLn9qLk2Tpj3wqy9J3KLB7FRI3NotO7WQBa0Tx1HgrM+D9/x+M5TTm2c
 nvPY0gkPQTc3kbJ0Y7booeDyRsSjoMPutsQy3HgS81DrCobCAHT5NJWkyPuoPl3rAKuW
 xj5UStRDk9NMFZ2aBYbn7HaiZLumnxe3GMdWY7q565f2EiUKhRVyLRmfrSnn9uz9fT/v
 R2hndXQWArzYOPEA4AY7ZSPygFupVmsO43KDvNetGzbneeR8n8LqB2Ho8iACn1RAqlDq
 3oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702325; x=1760307125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=djGLDaCPI+Z58EfZHA1Eb4mCBIq/E0fkKKuAVEgwRQQ=;
 b=hb9njyEY++Cptgi5v1NIOYSWBnKjNhmKc5UhLetjKM/EkDQdD6+vSo8L+k/zAEtE1D
 x5bgeZagYOG/huwnyT08g9ztFghOQttJ8zeDCKZil8EKRQv1H+agTs/29sw46//J7c95
 tlKrrMfQhIew5P3lhe8ri9kbnGBkhYQ53BF3Ku5f88h9bzQc1XQjjmrYDh+AGi5QihzQ
 J1EwfO64l1GKNyC4GRuuH0f1bKSmZlzXKbq2xHWL9DDQHvhJZ8ve7Bc4mFz+RcRl0ulI
 b01endxqMNd4qjmGldEh1qsRfEZnh5ImS0lBxI9dPI2MCnmWtDnW5JQivDiJrF0mHvYy
 nBcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgVgT7MufZHz5RY1YrbuVKdYovigJ01O6DzRBaxp27ROr9HNm2NzS/stjxdMFPCIex2nhzFtk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxzvg9/zycq1gqLZoM4s4gvYP2NFIuZtwrqDeQmTlclPFu+Wc7
 XC7QleiZ6SCY5yZwt36R5a6cgT6/LX8/CpET2wFtfb9RzhLmbU47ybYm
X-Gm-Gg: ASbGnctOFFASxYDdHtqNnuxwEEHwzcvx+LyCpwtcDourpF8GyumSb3xiA4m+LyLxNdl
 4aep6P9LMhuG8OFIRkl5eI6ls3+lPiZ1BfahFioUWdGrkYSkO3SZj9n3F+tRk4Nj5wm2ig1dEbk
 gDGSenzmzeJHQttO4wXuRWs+0k3PyWyq+mXbm+iL466i1BfmwH5Z2SFb1gVdS6BZwofqBpxF2Fx
 cG0gSjCoOO4mNOgNEk+ABMFhrnLcWtGvQco8T2L64db9iBOogseaLFQOdkvFW2hVbnkEDyR/CLI
 W6qDrPvM6Qjf2L/BQeuYHoDWSbW7eF42f/Frj/Qwi86Qbjmb+YoSTuhCfPIX5lgT4Raotav9Y/F
 fFlb+UrvuXYqj+2vbJkR6/O9ppvrF8G8e06yC+Piq74bqEW0d4+pXLw==
X-Google-Smtp-Source: AGHT+IFEX09G+66PqUCBa+JOfrSad7oEjKAuyZtF4IRlLcUvMQZgnYeHNHvXkR+epzRIUrkqR0A9kw==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4c7c:515c with SMTP id
 5b1f17b1804b1-46e711549a1mr61985405e9.34.1759702324570; 
 Sun, 05 Oct 2025 15:12:04 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:04 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 0/7] doc: make pdfdocs: Address issues with the make
 pdfdocs target
Date: Sun,  5 Oct 2025 23:10:07 +0100
Message-ID: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
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

This patch series address several issues that were affecting the make
pdfdocs target.

In the end, the make pdfdocs could be considered fixed. It is at least
with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025.

The thing is fixed only after the 6th commit. Each commit solves one
issue, in the order as they appeared. I hope it makes sense.

Changes from v1:
- Use already in place kfigure sphinx extension instead of
  sphinxcontrib.inkscapeconverter.
- I have kept the dependency on inkscape because: (1) ImageMagick's
  convert fails to the job, and (2) it's what's done in the Linux kernel
  on which kfigure is based.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Adriano Carvalho (7):
  doc: make pdfdocs: Specify texlive-xetex as a prerequisite
  doc: make pdfdocs: Update the description with the needed steps
  doc: make pdfdocs: Add pip install -r test/py/requirements.txt to the
    list of needed steps
  doc: make pdfdocs: Ensure SVG files are converted to PDF before the
    compilation of *.tex files
  doc: make pdfdocs: Update kfigure sphinx extension to support inkscape
    as well
  doc: make pdfdocs: Increase the maximum list depth
  doc: make pdfdocs: Remove redundant "-j" option

 doc/Makefile                              |   1 -
 doc/board/beagle/am62x_beagleplay.rst     |   8 +-
 doc/board/beagle/am67a_beagley_ai.rst     |   6 +-
 doc/board/beagle/j721e_beagleboneai64.rst |  10 +-
 doc/board/samsung/e850-96.rst             |   2 +-
 doc/board/ti/am62ax_sk.rst                |   6 +-
 doc/board/ti/am62px_sk.rst                |   8 +-
 doc/board/ti/am62x_sk.rst                 |   8 +-
 doc/board/ti/am64x_evm.rst                |   8 +-
 doc/board/ti/am65x_evm.rst                |  12 +-
 doc/board/ti/j7200_evm.rst                |  10 +-
 doc/board/ti/j721e_evm.rst                |  10 +-
 doc/board/ti/j721s2_evm.rst               |   6 +-
 doc/board/ti/j722s_evm.rst                |   6 +-
 doc/board/ti/j784s4_evm.rst               |   8 +-
 doc/board/ti/k3.rst                       |   8 +-
 doc/build/documentation.rst               |  28 ++-
 doc/conf.py                               |   4 +
 doc/develop/memory.rst                    |   4 +-
 doc/develop/trace.rst                     |  10 +-
 doc/sphinx/kfigure.py                     | 212 ++++++++++++++++------
 tools/docker/Dockerfile                   |   2 +
 tools/patman/patman.rst                   |   2 +-
 23 files changed, 252 insertions(+), 127 deletions(-)

-- 
2.34.1

