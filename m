Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B77C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C43B82952;
	Tue, 20 May 2025 07:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J1tri2Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A90482BDA; Tue, 20 May 2025 07:22:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7799828F8
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a3673e12c4so1576058f8f.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718520; x=1748323320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cb+Cy+LMF0AJN6j2LaRgA2WQUPWQDOlC6+lYcWQbSXQ=;
 b=J1tri2PnxasXfJ9n7EdLibYjjz6LC9YSEeH2GQQtpDZfMmDcXy2Cil0LcTDZwkmHWe
 EkRKh7/IxWd5gqNnD8YBxrurzHAHBq3mzkFzpHsM7Hah84hNbI9tRPGQdOOgLbXHNRm5
 nBP6jnySN5Z3OsH/zprNMg98+8snrrpcs6PrkwUn+fZKF/oH6GsSYUNiCkugU86cjohC
 kJMyCWg9WCYOQ6ImI4QM6rqUmigJwFSemE1XEsE2WOuWtU8SxD3fTauKoas8yN5bwZ1u
 VtgDCvasVHHixY723c0059U/T75GQU6GwIM3xBbY5CiXemIKSPmaBEHe1gjPVYWmonu0
 DRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718520; x=1748323320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cb+Cy+LMF0AJN6j2LaRgA2WQUPWQDOlC6+lYcWQbSXQ=;
 b=h8QjH0l3lR0mB/c2EaCEAwH+GNDzANAWG9fYj6dG/RGG4FfbTdH7jNFoZ9RNJs58i0
 VpggHVHNz+WBeOFzq+jsaXLoneor6WzWPTBxxSDNVpGoV9Fd1Ip2JeSc26lCkyUiZCOQ
 rp04HZlY8vhP8nitZ95ttNSW++67Pfsu84TDz01KCCqkjWMwfub8qyyovKzwPDLU43Sr
 BVJQi0LJoX6/19yhVhhwuKaZzFA/c1uStFc0yaznFhHOyLOmvyYHyjRxUthtHhIyhYG6
 NjLob6mlsCA/ZX3Okm21zQzz+/WxJdjDMrgSyF1ejMGwXMduCdCewjFTY9zuZHkmLfWN
 IcWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/y21Z7D9GQqADi6OOMVxA4ezNqOCliZw8aJowT9RcHNfKNbK4tP3gUvB8eUNC49DUVVlDjrM=@lists.denx.de
X-Gm-Message-State: AOJu0YxtP7MSym1P+yaaXXAM260LL/5t4A4jKt1KqmGlWZ9uWxqg3dTQ
 Fh0rXtx7neVZpB6ywOMPKFcc1fIeZCLtnv32HXGOGQH6ytuRwDM8sA1cOXZRfLpfkn0=
X-Gm-Gg: ASbGnct0qrlVCfAexo3spo1l+CvUNVLdYcbdG6HpAQ/Yp5g5CQZ0uw0TKKz5gv4KPpl
 z2VaXJGNw2nB2o9FBJLfkMtcXjDZvwVs06N/qsiykhFeUTganDaKDZMIKeshizqKtNirvrs96r6
 CoC7jbsL1oFQriT1OlBYCF4/qt6GRRCIb6cZAimTzRXPqAlaeFMRLJ4QBamemIvs1XqLZNtGp69
 Lyd165pE228TAVTqfq5s24UpDPvFkqZbog4WAp/v7air+31kTYA4b+NrFgPg/4r7qx6UXwClYMG
 wg4FR9ZerSHE/en7S/3YNNhdPYiBkotAJwO1DKSU3ImVf/AYjcCZHBAmGdaX1e0xyjg0oXFWIj4
 =
X-Google-Smtp-Source: AGHT+IGIqGQSWXwPBJwjEmJp/8b95A74Asad0vpjXr5ky/vdIHxNqzijeOs8/AJS/Yh6cwPZBSKaUA==
X-Received: by 2002:a05:6000:1ac9:b0:3a3:77d7:b3e2 with SMTP id
 ffacd0b85a97d-3a377d7b406mr1784134f8f.41.1747718520073; 
 Mon, 19 May 2025 22:22:00 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:21:59 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 00/24] Update kbuild
Date: Tue, 20 May 2025 08:21:11 +0300
Message-ID: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Last time the kbuild scripts were synced with the Linux kernel was on the
4.20 release. Updating directly to 6.x makes the diff difficult to read, so
let's do the changes incrementally and bump to 5.1 first.

Since the number of comits is bug, I am splitting this in multiple series.
This one includes most of the commits for Makefile.build,
Makefile.lib and some from Makefile.

commit eeb5687a7139649e ("kbuild: add -Werror=strict-prototypes flag unconditionally")
commit 3812b8c5c5d5 ("kbuild: make -r/-R effective in top Makefile for old Make versions")
commit b421b8a6cb87 ("kbuild: remove unused archmrproper")
commit 1a49b2fd8f58 ("kbuild: strip whitespace in cmd_record_mcount findstring")
commit 88110713ca9dfb ("kbuild: hardcode genksyms path and remove GENKSYMS variable")
commit 1d8001ef358 ("kbuild: generate modules.order only when CONFIG_MODULES=y")
commit 45c4372d00 ("kbuild: refactor quiet_modtag")
commit b39a691617e4 commit ("kbuild: remove redundant quiet_modtag for $(obj-m)")
commit 5439f09f488f ("kbuild: remove redundant 'set -e' from cmd_* defines")
commit e5d289100d3a ("kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule")
commit 3a2429e1faf4 ("kbuild: change if_changed_rule for multi-line recipe")
commit ee3e46b7efd2 ("kbuild: refactor modversions build rules")
commit 4317ee3b6a5e ("kbuild: remove redundant 'set -e' from sub_cmd_record_mcount")
commit 392885ee82d3 ("kbuild: let fixdep directly write to .*.cmd files")
commit 898f5a009f22 ("kbuild: move archive command to scripts/Makefile.lib")
commit b79c6aa6a1f1 ("kbuild: remove unnecessary in-subshell execution")
commit afa974b77128 ("kbuild: add real-prereqs shorthand for $(filter-out FORCE,$^)")
commit ecbd10d90e94 ("kbuild: simplify rules of data compression with size appending")
commit 58156ba4468f ("kbuild: skip 'addtree' and 'flags' magic for external module build")
commit 172caf1993b7 ("kbuild: remove redundant target cleaning on failure")
commit f3fd4a3f3a38 ("kbuild: remove redundant 'set -e' from filechk_offsets")
commit a2237fec1e06 ("kbuild: Enable dtc graph_port warning by default")
commit 70523a3ce5ff ("kbuild: disable dtc simple_bus_reg warnings by default")
commit e4aca4595005 ("kbuild: de-duplicate fixdep usage")

Ilias Apalodimas (24):
  kbuild: de-duplicate fixdep usage
  kbuild: disable dtc simple_bus_reg warnings by default
  kbuild: Enable dtc graph_port warning by default
  kbuild: remove redundant 'set -e' from filechk_offsets
  kbuild: remove redundant target cleaning on failure
  kbuild: skip 'addtree' and 'flags' magic for external module build
  kbuild: simplify rules of data compression with size appending
  kbuild: add real-prereqs shorthand for $(filter-out FORCE,$^)
  kbuild: remove unnecessary in-subshell execution
  kbuild: move archive command to scripts/Makefile.lib
  kbuild: let fixdep directly write to .*.cmd files
  kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
  kbuild: refactor modversions build rules
  kbuild: change if_changed_rule for multi-line recipe
  kbuild: remove trailing semicolon from cmd_* passed to if_changed_rule
  kbuild: remove redundant 'set -e' from cmd_* defines
  kbuild: remove redundant quiet_modtag for $(obj-m)
  kbuild: refactor quiet_modtag
  kbuild: generate modules.order only when CONFIG_MODULES=y
  kbuild: hardcode genksyms path and remove GENKSYMS variable
  kbuild: strip whitespace in cmd_record_mcount findstring
  kbuild: remove unused archmrproper
  kbuild: make -r/-R effective in top Makefile for old Make versions
  kbuild: add -Werror=strict-prototypes flag unconditionally

 Makefile               | 65 +++++++++++++++----------------
 scripts/Kbuild.include | 22 ++++++-----
 scripts/Makefile.build | 87 +++++++++++++++++++-----------------------
 scripts/Makefile.host  |  6 ++-
 scripts/Makefile.lib   | 55 ++++++++++++--------------
 5 files changed, 113 insertions(+), 122 deletions(-)

--
2.49.0

