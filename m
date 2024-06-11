Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FCBC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1747688738;
	Tue, 11 Jun 2024 23:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="G/EKZuD6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYNabsC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2863388743; Tue, 11 Jun 2024 23:01:04 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CF488709
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 2426C1C0017C;
 Tue, 11 Jun 2024 17:00:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 11 Jun 2024 17:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1718139654; x=1718226054; bh=nX1KqV/5La+Gg3LoDKvlM
 hupxfgVUmidJToN3Z/+1iY=; b=G/EKZuD6ZgUzsoE4E/w/P1HxHvITwOtTNdUva
 w+UWmoA9YBCFrEYj4J7xqPQStsezaKVUnu56JY7XOzPfJHQQumghg9y5nxVKpTkV
 1VMvZuILa/Uicev/pDieefh7hYXP060EHY+FMsYyUHzDYqFGij9QEsvMcUhwn8yx
 f6DrUODfykKMTz3LexhDCSzQGJlyF4ZZUqblS3ws1KY+pcP+0Zvlo+oMmWhziVL+
 YqTKa0mG2E1KL8I0HiyJj54HQFgOAougSKAXitdWgz1ki7QopDr3WwuvOiqkaZ04
 0VaTEL+CFhu9OsZfdc2n4rCr68o+7vcDrL+6zimY10Uch026g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1718139654; x=1718226054; bh=nX1KqV/5La+Gg3LoDKvlMhupxfgV
 UmidJToN3Z/+1iY=; b=nYNabsC0Z6HFYs7MkIslQMa5ygvbLeO4OZ7yZ+EF/L1l
 rvZJ07jGgpljVM8bf1q62WY4y2ilgO/jYif2tW0UBHjp3VmSfWjj8ZmCEIdld/Sp
 hVXOInjlAENpNfdyrXq97hRwSAH8qO/miwMXVNiUEUVQj8gBAGBJFaFVEv4yPLaO
 2VfIdzE1uRMTum90taNPzq49cXSvst5vpJKmmemosSGN9oAJ6ahTYUiG3npt7n2w
 daxJsDj+OH7ZlPy7ipcGZcoO9uvCKlRyH2suB/SCDRR1DNvlZApuEcXtGN1h7PQo
 FgFX4mvYM+RNFWEwDLaBN6AASIgd9YYsZMw4i+Dq6A==
X-ME-Sender: <xms:BrtoZqr1YNhey_mAUJGHSBHJK9GCgYTRZ04srF_lXnakehlCm3srog>
 <xme:BrtoZopxrWo6zDsx0tAioyQ362pUlV5rxK0lMrknrRDWDwA-TI2elmExdIrgELd7z
 dP2iFCNmMFhLJJZCE4>
X-ME-Received: <xmr:BrtoZvOrc46OLnluOAuUMuN-3aWveh7GSxbS_9QKmhh3CI4tm5FX6DDjCZ1dy7Vgns5kHkMP1po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
 dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedutdduveeileejje
 etffehueejudehgfffjeduhfeuleeludfffefgffevkeenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
 horghtrdgtohhm
X-ME-Proxy: <xmx:BrtoZp70oxaIsP3Lolpi6KgRZ2fndL5ZHL2laq4DRMo63JGK_5pabw>
 <xmx:BrtoZp7fgLOnCZsKQTmbcM86hId07YJARc6ZcWFCl2qLqDhj6amnAg>
 <xmx:BrtoZpjGVeHUxfcxkhB87YD-Fer9QyRWt1oRbbG9xMhwaaml4tntUA>
 <xmx:BrtoZj6wr1huoBbBVwNSIypClxeJfBguVNuiHkyOjMlXPbK6pwO6pQ>
 <xmx:BrtoZjlnB1TIr3W1y1decckldwK2wDNApEpnjLITMJSdrT1y0MZBjuh6>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:00:53 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [u-boot-test-hooks PATCH 0/4] QEMU Updates
Date: Tue, 11 Jun 2024 22:00:21 +0100
Message-ID: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.43.0
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

Hi all,

This series updated u-boot-test-hooks to adopt QEMU 9.0.

It also introduced 3 new boards: qemu-arm64be, qemu-xtensa-dc233c and
qemu-loongarch64.

This is required for CI changes.

I'm going to respin other series later to utilise those new hooks.

Thanks

Jiaxun Yang (4):
  qemu-vexpress*: Pass -audio none
  qemu-arm64be: New board
  qemu-xtensa-dc233c: New board
  qemu-loongarch64: New board

 bin/travis-ci/conf.qemu-loongarch64_na              | 12 ++++++++++++
 bin/travis-ci/conf.qemu-xtensa-dc233c_na            | 12 ++++++++++++
 bin/travis-ci/conf.qemu_arm64be_na                  | 13 +++++++++++++
 bin/travis-ci/conf.vexpress_ca15_tc2_qemu           |  2 +-
 bin/travis-ci/conf.vexpress_ca9x4_qemu              |  2 +-
 py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py     | 10 ++++++++++
 py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py | 11 +++++++++++
 .../u_boot_boardenv_qemu_xtensa_dc233c_na.py        |  6 ++++++
 8 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 bin/travis-ci/conf.qemu-loongarch64_na
 create mode 100644 bin/travis-ci/conf.qemu-xtensa-dc233c_na
 create mode 100644 bin/travis-ci/conf.qemu_arm64be_na
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
 create mode 100644 py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py

-- 
2.43.0

