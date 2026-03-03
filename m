Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2F5EDEBF1
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 21:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41A9483E7F;
	Tue,  3 Mar 2026 22:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCEdKEgJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A1583F61; Tue,  3 Mar 2026 22:47:11 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AC8839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 22:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-437711e9195so4810147f8f.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772574427; x=1773179227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0nBD5xeVeFnBMShLZCVb228So6ni7UljH6EM2z3FYjA=;
 b=iCEdKEgJb+oH2Qd79S0vsLwQHL7l2lQQUfKBor4/liIlNRWIugoZO6/QtMRdNAwpcA
 lHs50sduTmgjTdKxCtY9YXQvJ5JH8iSgaDvw8YrzyksJGzF7l1rInTDhGrNtmTEgUigw
 Zu+4Zxjgr/24kR2plUd/2DuDDuegkfkG5yBzgDXb4W8rYQgeJy4fD7h5BRcUyj/jgQ/y
 7zeuG+nnjqT1dSHx1wIRPOAgOU57OEhYlxy8fbSwXkbB1Woo4o82MKqc69AhbFTT47GQ
 yZ7UAY/BdmD4KugTF1BPXzbBuZDNO7SEaBUIpSbAL3J4pwVqP2l+lnemfIWGNny5+Qj1
 NtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772574427; x=1773179227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nBD5xeVeFnBMShLZCVb228So6ni7UljH6EM2z3FYjA=;
 b=SfOzu8vJU/tscShgEzM3toMFVwlbWgx8FAzagbH9Mq7zIoirZbY5mtlV6CQWdQ4/aA
 37ar7P/D4kyh927n6n1EyLvPpILXUDW17kLHCR2We7yXuR9nTjydn7Annd0vlYn86WFs
 AMgD6jIYH0bjfWX9vnAHN0zZNMgXmUOTXvL6Iu4zvgZRlDydJ0UgQhrs7xoWrUBJeR6z
 LuGzE9sGuisyULaRPVc+rCBeISC8hrUccC0GoEYruAEFUdAO9ENTHCEkZmbMp/2aZkun
 p2698kJ9M43kN86RRGudp36X9/DyfPqDwUxhLW1VkAU+/4pydgRKp3b43KxskDkb8Ilr
 ER0A==
X-Gm-Message-State: AOJu0YwdB3m2wl5gKtT7WCOjJASR1e2RcTpC91kMdIn8kj/jbncopJlv
 QdPVcWSZxkjM2SLI3Dt+INWMXn2ygnp5e7Tkqlcb8n7ZxYTMTbFz17V6B36LSg==
X-Gm-Gg: ATEYQzwMdxv8mik5URjvhBooTy064ELdkGzW47HP0tRFgZqdGwHrY+U/A3zK7VieHFm
 J43yax0o8NBAjkoYR/190BCV4Ne2Rxvm17D08nc1P0/FbTQaW0ms98q+3VQov6F+JPCHQW4Oifd
 hIoj4vkIOdSDR7X5Hr/aavV75/c2NvSS07LECxfnM30OPZge6qbjUI3PKedOEEI1IGs/VE/qwb0
 uaWzOAAHeC9GQTd7gnREquJwBQuJCVl+sXjv3Joq1Q2qZjc1vvjgGuLBslYK4uqDmLf4MRg/rc9
 rJXGl92pkfXdv1aUtfzu6daSas2Vts3cnQD7+8FP3V9sDWsMg0v0CLSh4IX1FsMUlzXokA6zQwu
 cCeFXoACQlGjzjrX0e4X63kbTo2LlvmKghkcVgg7Uz+Q1fiKXM3hGeBjBB37VM6AZFcwr+np535
 Ku+Vple5kNrx+M44D6jJuvs6zCTv1cL4a9Ug596kjB11cJ3K8tjji/ouXDWX33zMlNMte3Egcz3
 3GfMiTRz96K1YusnCOWiC/93g/crVX5mcsp6rVTNmPQdF/He/EBSsTuKapd1VvLpmFMqalXUpO0
 E1C2o0QPcSE=
X-Received: by 2002:a05:6000:2c10:b0:439:b744:c5fa with SMTP id
 ffacd0b85a97d-439b744c836mr16496431f8f.30.1772574427297; 
 Tue, 03 Mar 2026 13:47:07 -0800 (PST)
Received: from cypher.home.roving-it.com ([81.187.95.213])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-439c1fc577bsm6291599f8f.19.2026.03.03.13.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:47:06 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] Add an initial CONTRIBUTE.rst
Date: Tue,  3 Mar 2026 21:46:46 +0000
Message-ID: <20260303214653.4096007-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add a contributors file to provide a high level overview
for people who wish to contribute to the project outlining
basic details and setting some project expectations.

This isn't intended to replace any of the existing documentation
but rather provide a succinct top level document that's easy
to find to enable users to understand the project and get
started as quickly as possible.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/CONTRIBUTE.rst | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/index.rst      | 10 +++++++
 2 files changed, 80 insertions(+)
 create mode 100644 doc/CONTRIBUTE.rst

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
new file mode 100644
index 00000000000..7602e5c5a6a
--- /dev/null
+++ b/doc/CONTRIBUTE.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
+
+Overview
+--------
+
+This document is a high level contributors overview setting overall expectations,
+so people can get started quickly, the rest of the documentation goes into the
+details.
+
+Code of Conduct
+---------------
+
+The U-Boot project doesn't currently have an explicit code of conduct, but all
+contributors are expected to act cordially to, and be respectful of, each others
+contributions and opinions. There are many code of conducts for open source
+projects available to review if you are unsure of expectations.
+
+Repository
+----------
+
+The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
+
+Contributions
+-------------
+
+Contributions to the project are welcome. The U-Boot project uses a fairly
+traditional Linux style development workflow using git and `a mailing list
+<https://lists.denx.de/listinfo/u-boot>`_.
+
+Patches should be sent to the mailing list using ``git send-email`` or the
+equivilant commands using ``b4`` or ``patman`` with appropriate sign-off and
+attributions for the code in question. Maintainers should be copied on mails
+and they can be found with the ``./scripts/get_maintainer.pl 0001-fix.patch``
+script. Please don't send patches as attchments, and ensure corporate mail
+systems don't reformat patches, append disclaimers or other uneccessary notes.
+
+Patch Series
+------------
+
+Patch series for a specific subject are welcome but they should be constrained
+to a single topic with a cover letter outlining the intention of the series.
+
+Generally bug fixes for existing bugs should be at the beginning of the
+series before any enhancements to allow those patches to be picked up early.
+
+Each iteration of a patch set should be versioned, allow enough time for people
+to review previous versions of the series and incorporate all the review
+feedback before sending a new version. A week between larger patch sets is
+considered as reasonable amount of time.
+
+Development Branches
+--------------------
+
+The U-Boot developers use two main branches for developing the code. The master
+branch is used for the current development cycle, while there is also a next
+branch intended to land changes for the next release early to enable wider
+testing of larger code changes. The next branch is merged to master shortly
+after the tagging of a new major release.
+
+Similar to Linux there is a two week merge window post release after which a
+release candidate is tagged. There's typically a new release candidate every
+two weeks post merge window until the stable generally available release.
+
+Release Schedule
+----------------
+
+There is currently four major releases a year in January (.01), April (.04),
+July (.07) and October (.10). These typically happen on the first Tuesday of
+that month. There is currently no release branches or long term releases.
diff --git a/doc/index.rst b/doc/index.rst
index 43398627d89..9ef6aa9c258 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -15,6 +15,16 @@ if you want to help out.
 .. toctree::
    :maxdepth: 2
 
+Contributing Guidelines
+-----------------------
+
+General guidelines for contributing to the U-Boot project.
+
+.. toctree::
+   :maxdepth: 2
+
+   CONTRIBUTING
+
 User-oriented documentation
 ---------------------------
 
-- 
2.53.0

