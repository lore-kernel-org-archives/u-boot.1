Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A5EC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4099F4051D;
	Wed, 26 Aug 2026 16:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBGV-VbLnRUT; Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762070;
	bh=3OsZCgGWRFZPs9fH8sR4E2bJnzrOO5oIpNsMRLDA+xg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nkJIoBuBB4JViCn5KBPdzgyltb5YntnBxlFdIjTI9/sR2DF9L9OmuUj+Vk7VyYQFg
	 J+KkhBBqOKX6n/dGLlkpzXz9jj6NGepWZhtM1eGvZHGJJcRyPMyvGUn0N/BIDtgxln
	 NF0iCuhGzgpq3yuOAWq8f9OALIIAXQzf6EA+h0OCE/fLxHnDEpkx5s8Iw3fUeAI4PH
	 qgrDa8A636aPeBKVWqC67t3At+BaG+IA7qPMU/vDxwweOuDkKIKcSdCKp3FyAr/2Qv
	 oSJwDhjxLLWbEjAqzj5xTQwrtuMIyEbiugZT1hbDOtDHmFgpnvo9y5S4e4eZ1D0Dds
	 MI5a38OpTbJ+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E4EB4052E;
	Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7850629B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69DB280AEA
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCaFhicNkM4f for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=lEtIyCWD
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1693980AAB
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:26 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso180702066b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762064; x=1788366864;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3OsZCgGWRFZPs9fH8sR4E2bJnzrOO5oIpNsMRLDA+xg=;
 b=lEtIyCWDfJTi0EcbIYsyqsNcEJpIT9PJEjxrY6L1XCr245mF5qKFwTvfIWlp1EgclE
 VhhYZ9c6H9DkdpZs87T13VcAaaPHex/l4XCJq5GV6cLld6GBXcokMDrnzZwHc/eCY4uf
 SGyqzxGw2KNnhxk7B0kkG+jcYnFU5NBX4Sosqi6rhsv89xYe0d6dnqVEPvvw2qLfN80a
 gHDR4CdQh3hpFD6S8JkJnG3c5YvKaEGJdfffz36hbBUch6v0CzOCLct8kiRIKPF2boKb
 OzMIYvLhC2U62oRXFL4/yeFYXrtYabk8tIGNLjc7ibYXrd4WLLk9nfI0LOrGY/gHppXU
 Tc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762064; x=1788366864;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3OsZCgGWRFZPs9fH8sR4E2bJnzrOO5oIpNsMRLDA+xg=;
 b=IDX4vbHUiaRg3o6afmkAgtJCWW3QDS6y2UxfiESgIRv+Lk0KsI4xQHQDeOEdhbxrPB
 NjT8B7eO/9YPNzoptA+59rh6xze3T1dt0iZOi5w2RhP/01yk58avwr2Dlk/1rZRDuOmO
 IBru86tRdIH5jm78MLvty7/AktteHl39QltC22dKkPd+zR74XPlIPavo8DNzCuuSpHjw
 bPGAYLHoFlv5c6kbOUGp5R7oMaR+SEWzVwBsj9cHnmWpjG+zHfF2+pQacQZzCPF02pPX
 0Bvg/LcJ75h6hzIinKAgOPPmIoJ7Cmsm13iade0yjNbjynVqXuKvrIK4arQJE7STCtnd
 kgbw==
X-Gm-Message-State: AFuF++mvcav3FtjDbc0gq21f/RcCtfqsB4I20mm378cGixYDPUTM/9Bi
 JHkaAWdnsVS+Se9hl9OefXBoodweoBVfyQhYqU0kURiEKoS+4dnGz1H8dhEFy6cx4LQ=
X-Gm-Gg: AR+sD12w/SWQKjM4YBp/VIjAgYnTJQxiwmjHcZ6/lbiYOQ7jEJi68SUtIqvD2HlKhxY
 0myv22GL0oKEC/BAjnCFEIqWxt1MDDyiOJsgvMnHAcyEubWp/CtqGLWmtLEbJOsYSvlljUVdZzh
 Uw9IQj2/iPV9rnSC1treAp2ag8V2sqS9sWvdMuO9O4gT8RPQ2ZcGMxPOI8xBRvQSQWqsaG31PpN
 WWIPoNRlZpPfvSXl+n5WoHOogo54xssFh7Cvy3AJncuNXrQBBVUB4av5KJ4wBp6+q9YMpN8gFPr
 Kn2JiXK6Ko+x5qSmKhnCjNIIrr+tnoXLxR14jfEX7h64YedYkCdx0EvHoZuFkl4L8mPkg1A9OCG
 d+p/I9V5MIhtRANMyRmeb74cXD7bTvpQvMmAAAyHwsfyfQdzesC8wLC/XDfSmcb/Nhd0eHDzP1Y
 pI24kLAfzHoEdbAd1PFHId6Q9/o76Aa89Zv2TiCT9lYGR7uvlEv2r8zkGpgY3C9gaY7kAPVZik5
 F5dawy9hi/YZoesgzDEDKhKBsLV7qa3whaiyPhPmw==
X-Received: by 2002:a17:907:c408:b0:c24:6045:2a94 with SMTP id
 a640c23a62f3a-c250bbbefa3mr1310680466b.4.1787762064474; 
 Wed, 26 Aug 2026 09:34:24 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 00/13] pxe_utils: small fixups, implement BLS type 1
 boot on top of them
Date: Wed, 26 Aug 2026 20:33:52 +0400
Message-Id: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6CMBREr0L+2pp+IDW68h6EBS2DfEMKaZFoS
 O8u4MrlS968WSkiCCLdspUCFoky+g3yU0aub/wDStqNKde50UaXyg5RtdY0hbZXLhrQZk4Bnby
 PSlX/OL7sE27ep7vRS5zH8DluFt69/+LCSqvSwbQMlBfmezfINCGcPWaqU0pfYnsnF6oAAAA=
X-Change-ID: 20260604-bls-db6a30b913ae
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5344; i=alchark@flipper.net;
 h=from:subject:message-id; bh=EVb/JCTirL+MwhT5g5e5+1bax4zVP4jRKe/2J79FjaI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1iza9Yxdl+7XGS/R9epnYjYNGAU2bfV7G/6k8NSPr9
 vt5MlI7OiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqskCG/1UGUgWWIacFA67J/ed6s9er6EGt1uX9RjbPIt9xci7SOMfwv06vo/f
 /qQ2Xv6xc9jLEVWXfFR3+v3vEfp/4Z3r86J8DlTwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add support for the Boot Loader Specification (BLS) type 1 boot entries,
as generated by default by systemd's kernel-install when loader=bls.

Given that the format of BLS entries is pretty much the same as PXElinux,
reuse the existing library for the parsing logic.

BLS type 2 entries are out of scope, as they are effectively just EFI
applications and should be booted as such.

This implementation is also only allowing a single top-sorting entry to
boot, as the standard boot infrastruture currently doesn't support
multiple entries per partition-bootmeth tuple. I have a proposed extension
to enable that and will post it separately as RFC - that enables the use
of `bootflow menu` to select the kernel to boot without jumping through
several menus with different behavior as is currently required with
extlinux.conf.

CI passes all green [1]

[1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1089

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Dropped "default y" to avoid increasing image size for platforms which
  don't use Freedesktop-style userspace and won't benefit from BLS (thanks Tom)
- Fixed typo referring to BLS type 2 when type 1 was meant (thanks Simon)
- Added a kerneldoc for parse_label_keys() upon factoring it out, not just
  when it gets exported to a shared header (thanks Simon)
- Shared the pxelinux getfile helper rather than making a third copy of it
  in the new bootmeth (thanks Simon). It moves to a translation unit of its
  own, so that PXE_UTILS users without bootstd don't gain a dependency on
  the bootmeth uclass, and boards without PXE_UTILS don't pay for it
- Allocated the entry buffer with ARCH_DMA_MINALIGN rather than 1 (thanks
  Simon)
- Stopped retaining the parsed label in bflow->bootmeth_priv, which the core
  frees flat and would therefore leak (thanks Simon). It turned out to be
  worse than a leak: a bootflow is shallow-copied into the bootflow list, so
  the pointer was shared between the iterator's temporary and the stored copy
  and could be freed twice. bls_boot() now re-parses bflow->buf, as extlinux
  does
- Added a test for entries found under the '/boot/' prefix rather than at the
  root of the filesystem (thanks Simon for asking what happens there). No code
  change was needed
- Dropped the number prefix from the driver name (thanks Simon)
- Added sandbox tests and updated the bootmeth/bootflow expectations that
  binding a third bootmeth changes, plus a doc/develop/bootstd page (thanks
  Simon)
- Added a patch hardening the "append" parser. A bare "append" dereferenced NULL, and
  an "initrd=" at end-of-line computed a negative length before malloc()
- Link to v1: https://patch.msgid.link/20260604-bls-v1-0-4ce6d1ee4711@flipper.net

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>

---
Alexey Charkov (13):
      pxe_utils: fix W=1 kernel-doc warnings
      pxe_utils: accept "options" as synonym for "append"
      pxe_utils: harden the "append" parser against malformed input
      pxe_utils: extract per-entry key parsing into parse_label_keys()
      pxe_utils: export per-entry label helpers
      pxe_utils: optionally ignore unknown keys in parse_label_keys()
      pxe_utils: accept "title" inside a label as a synonym for "menu label"
      bootmeth: share the pxelinux getfile helper
      boot: add a minimal bootmeth for the Boot Loader Specification
      test: bootstd: add a BLS entry to the Fedora fixture image
      sandbox: enable BLS boot method
      test: bootstd: cover BLS entries below a prefix
      doc: bootstd: describe the BLS bootmeth

 arch/sandbox/dts/test.dts        |  12 +
 boot/Kconfig                     |  24 ++
 boot/Makefile                    |   2 +
 boot/bootmeth_bls.c              | 370 +++++++++++++++++++++++++++++++
 boot/bootmeth_extlinux.c         |  20 --
 boot/bootmeth_pxe.c              |  22 +-
 boot/bootmeth_pxe_common.c       |  34 +++
 boot/pxe_utils.c                 | 146 +++++++-----
 configs/sandbox_defconfig        |   1 +
 doc/develop/bootstd/bls.rst      |  56 +++++
 doc/develop/bootstd/index.rst    |   1 +
 doc/develop/bootstd/overview.rst |   1 +
 include/extlinux.h               |  23 ++
 include/pxe_utils.h              |  62 ++++++
 test/boot/bootdev.c              |  14 ++
 test/boot/bootflow.c             | 467 +++++++++++++++++++++++++++++++--------
 test/boot/bootmeth.c             |  38 +++-
 test/py/tests/test_ut.py         | 122 ++++++++--
 18 files changed, 1200 insertions(+), 215 deletions(-)
---
base-commit: 2d379a529c257606946831a6dac1c37de6a3f8c0
change-id: 20260604-bls-db6a30b913ae

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

