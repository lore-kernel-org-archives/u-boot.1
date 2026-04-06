Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7EEF46C64
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 17:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CFB83C2B;
	Mon,  6 Apr 2026 19:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeWuBmk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498BB83FA3; Mon,  6 Apr 2026 19:28:14 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42D083936
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 19:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so2423039f8f.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775496491; x=1776101291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=seKljE74plO8It6lT1Hwx60dQkxdbup/VSqT8J4DrV0=;
 b=FeWuBmk4ggOnKAN5mo9WklRZ2NEc4Yt9lvBWiZehC/ztVIttN9aQ9J2rPq78KF/8IF
 pyvai0TXWjAK4007LktotINv196/yoKFsJXrkTrp1FzMqZImvUOQsuUP4lenaGbpn52w
 F6QtYJXeAky9PGYFo+eL+Y2zIMsYD6gzrl655pSneyI5T8CSEsEx6dra4o9jTn1g4Vz7
 kQ17tgTl6J59mjDnniZF2Ylc9oZvgd5vi1Z6aDIwrq7y1Gz8Y79zaoFiuP5yO4hsIv7z
 vVvCboj2ISEItveCKOg4rEoWe6yUGYRqFe4qNh1DEftjV8xKbw8ItQhte/98R2nr8+9O
 LBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775496491; x=1776101291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seKljE74plO8It6lT1Hwx60dQkxdbup/VSqT8J4DrV0=;
 b=YYdLDnI1YsXGsMSxWmuS5fjEj/0S2Ra7U5hgzrVlEIDYt7rl2w5H71xdt9d/8vj6VP
 jGJXaukfuteWwX+ncO1wgUxnANvTmwZeIsVC6j8WuUO3x0W1me+HfVitbHmZzvVyPo45
 BLMMpvIMwbNaD0X6GWuXaE+HFCgD+9VcYTLAtn/3FPauUfm69qW+Oi6Znsr9T8HqQfBj
 SuDIrP+Fdw3efG7a3R8UWJoLsY0o3DfzSHmM6WhRIc+zrcyD+aWpKU2TQ5dfxoK6daWV
 uwgpey7Tps8hOQe7Kkfy8Z7rU5dpkKFa5IuxAQ6fjkVK+jIl8my3rEzfq9MTMJp2Pxax
 5pOg==
X-Gm-Message-State: AOJu0YzdvTqeeNUAgGVRDcuP8s/ddrmlGULKQohRseJ9jZi3CJPZvFqJ
 f9xsO470FE4bdWFl1VYCUj45YAuRPzJ2dJhqm0lTAdaa3+XD6dpEzcC5ZWo8tQ==
X-Gm-Gg: AeBDievjVkcMqSu2P00k/5EkwP0ocaXZCb7wsbU827dE0gNtbpRZmEMkHSj4CzpjVOX
 82FE7CMzEKsfWjpae7dZBX672eb6McAHkxyWGxu8fqcwhGKoTQ4xF6G6Wy7RBGYPKvpnMZSnXz1
 i2hw5AKN3mhWCiIZRnC2MjrT7kR8GOAF0t5cK6yfeVGEVC4rlU/otmUOSFDTogj959sKuXU4UsK
 O+swjE2jQ9fZQOAoqpmzHFvgLbY9a/B6cOE506V2umws4KiA8SXLt0IR3UxTXaXtGRE9aBiC3BU
 TRra6SPqIsIzO0mfYVA1dwmfRTLo9tXXnjJ1elUe7UYbJdsR0tWrzTX5RRsz1HIpZAWvkWP57ZT
 U1K8MIXh7nRb4OEwHHosgX7EGhe3reNUOG7x6FnRDy9QhWeBiY2yYZrc1dESkZPXOaqBd6WqUCP
 M4pLvCPjFJRhgTSxiPnNcu3lLBMRFfk+sW4XbYkO1kK4NEXa2RrDotLut+Z6cK9woddDu7hpy9U
 BORYV/syNzKSaVUW7mTBW9BxJ823u0USUdfQ/EzNN4oMW5mW/D8326EPd7MXpe8QGL3Tpfy/9zt
 5TzB4hPgBBg3rHLiXzG++76t0KzH/CZ5tm3vdjk9NZ2gWYNrA+dy4lz/8sVc6TIXHnIp3ehf5Hx
 9lZIHPdAVJW3lsMfFi8QZ+Q==
X-Received: by 2002:a05:6000:208a:b0:43b:4aba:8f35 with SMTP id
 ffacd0b85a97d-43d2927b855mr17121453f8f.12.1775496490492; 
 Mon, 06 Apr 2026 10:28:10 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm42176342f8f.31.2026.04.06.10.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 10:28:09 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2] Add an initial CONTRIBUTE.rst
Date: Mon,  6 Apr 2026 18:28:00 +0100
Message-ID: <20260406172805.368902-1-pbrobinson@gmail.com>
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
v2 changes:
- Numerous spelling fixes
- Updates to some sections
- Add reference to other docs

Note I didn't split out this to other rst as it makes it hard to
read if in a text console, it needs to be readable in offline text
environments as well as online.

 doc/CONTRIBUTE.rst | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/index.rst      | 10 ++++++
 2 files changed, 86 insertions(+)
 create mode 100644 doc/CONTRIBUTE.rst

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
new file mode 100644
index 00000000000..514d0257b39
--- /dev/null
+++ b/doc/CONTRIBUTE.rst
@@ -0,0 +1,76 @@
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
+contributors are expected to act cordially to, and be respectful of, each other's
+contributions and opinions. There are many code of conducts for open source
+projects available to review if you are unsure of expectations.
+
+Repository
+----------
+
+The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
+
+Further more detailed documentation can be found at the following link:
+https://docs.u-boot.org/en/latest/index.html
+
+Contributions
+-------------
+
+Contributions to the project are welcome. The U-Boot project uses a fairly
+traditional Linux style development work-flow using git and `a mailing list
+<https://lists.denx.de/listinfo/u-boot>`_.
+
+Patches should be sent to the mailing list using ``git send-email`` or the
+equivalent commands using ``b4`` or ``patman`` with appropriate sign-off and
+attributions for the code in question. Maintainers should be copied on mails
+and they can be found with the ``./scripts/get_maintainer.pl 0001-fix.patch``
+script. Please don't send patches as attachments, and ensure corporate mail
+systems don't reformat patches, append disclaimers or other unnecessary notes.
+The b4 tool automates a number of components mentioned above.
+
+Patch Series
+------------
+
+Patch series for a specific subject are welcome but they should be constrained
+to a single topic with a cover letter outlining the intention of the series.
+Each patch within the series should cover a single change, be self contained,
+not break the build or cause a regression.
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

