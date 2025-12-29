Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47C7E92FD7
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 20:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE37783EE3;
	Mon, 29 Dec 2025 21:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="jy/Pjj9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C8A83EF5; Mon, 29 Dec 2025 20:44:29 +0100 (CET)
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A54483EA6
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 20:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.preissl@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1767037466; x=1767296666;
 bh=PRDm3Uyeayd1Ycu6Oxvm5C/K9OBTQc0kTuKuKMPs+yU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jy/Pjj9d6LrL1lSyMIVlQHGNbsjfvhAHeAUPVmU4ox7XNEhrkZOk3bOKMY4SmEMPg
 iO789rZg7YpIizOVDq/ubBjlg2ooEBK607DUNnNcq8iaKuIV1eflIJ+rh5qH+0yfJf
 w4THUO3930s2Yw8f1/KglyAf9vKkYxf3GVPq6kyWl0Sp6ThHqLkm/fAuXZ0KSHjLKp
 3XgaAHp4Zvn+kmCDs9nlO7+DkYyb1Ck8JjoTh3lq6vPU2Pc4qZ/lin/DmZJDha5I7F
 K4Kl9uBLQkhuQw+5GUaHQvXS/dwyHiyFO/WHp9gfCre9Ch9Ie99xkKvTZTvCEYVbC+
 +ocq0OQ0P/CAw==
Date: Mon, 29 Dec 2025 19:44:21 +0000
To: u-boot@lists.denx.de
From: =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Cc: trini@konsulko.com, =?utf-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>
Subject: [PATCH 0/4] fix multiple integer overflows in fs
Message-ID: <20251229194418.69780-1-t.preissl@proton.me>
Feedback-ID: 156112983:user:proton
X-Pm-Message-ID: c575f28e0a3803599e4230c36aa1d87d2dafee11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 29 Dec 2025 21:36:43 +0100
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

This series fixes integer overflow issues in several filesystem
subsystems of U-Boot. Without these fixes, certain size calculations
could wrap, potentially leading to under-allocation and heap buffer
overflows.


Timo tp Prei=C3=9Fl (4):
  fs: prevent integer overflow in fs.c do_mv
  fs: prevent integer overflow in zfs_nvlist_lookup
  fs: prevent integer overflow in sqfs_concat
  fs: prevent integer overflow in ext4fs_get_bgdtable

 fs/ext4/ext4_write.c |  7 ++++++-
 fs/fs.c              | 16 +++++++++++++---
 fs/squashfs/sqfs.c   |  8 ++++++--
 fs/zfs/zfs.c         |  5 ++++-
 4 files changed, 29 insertions(+), 7 deletions(-)

tested on:
make sandbox_defconfig
--=20
2.43.0


