Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC8EE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 21:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A3583AEE;
	Sun, 28 Dec 2025 22:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="m+sb9T92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C54383A94; Sun, 28 Dec 2025 17:45:15 +0100 (CET)
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F263E83A57
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1766940312; x=1767199512;
 bh=mi1BPcT0sucn5McrhPLE/rymmK+HGjzeVbKyjHMDxTU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=m+sb9T92PWo1GDG02f8xyRIqoiHoa2+qD8dOIeinxTG2mt0/aPlokwQeHUwwKTX6d
 9GgTKX7q10l8WAi65ADPwEJeZld1jBQB4UuPtM5mecNCBTDK17zmTefdkbn7A9681V
 jFaEGtPRGTP/9dhV3vVgORpAhYRBkOVgT4dZZDUMegdKYb45/av1/imvwCWyMoafqY
 7dXblT+DsaQT1fISYwowL1SUUfGPDzV1UBCRRSL7fn9tMlG6pPtM2VJVC7lN8ViMgV
 Ov5Cow5O1yyusL5uPMbOFSTfDWVuB+A/7ljE9az2G7hRgsQ33WI6dPqGrctcs8WFAf
 +IKOiisNrvqIw==
Date: Sun, 28 Dec 2025 16:45:08 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 0/4] fix integer overflows in filesystem code
Message-ID: <20251228164500.313817-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: 2e3264e44293fdfe40c6846221d94113c94e7528
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 28 Dec 2025 22:40:09 +0100
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



Timo tp Prei=C3=9Fl (4):

This patch series fixes potential integer overflows in U-Boot
filesystem code. It includes the following patches:
  fs: prevent integer overflow in fs.c do_mv()
  fs: zfs: prevent integer overflow in zfs_nvlist_lookup_nvlist()
  fs: squashfs: prevent integer overflow in sqfs_concat_tokens()
  fs: ext4: preventing integer overflow in ext4fs_get_bgdtable()

 fs/ext4/ext4_write.c |  7 ++++++-
 fs/fs.c              | 18 ++++++++++++++----
 fs/squashfs/sqfs.c   |  9 +++++++--
 fs/zfs/zfs.c         |  9 ++++++---
 4 files changed, 33 insertions(+), 10 deletions(-)

All patches have been tested with:
- sandbox_defconfig

--=20
2.43.0


