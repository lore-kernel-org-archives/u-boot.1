Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2CD5D693
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAD1881FD;
	Thu,  7 Nov 2024 22:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="pey01pzs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xH3ebjF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C12892DB; Thu,  7 Nov 2024 16:01:19 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719B389246
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 16:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JeLDy8qnfae8A7GHch+U1dALPh9WBs0FUsOu7zXDJJo=;
 b=pey01pzsn/KKEcm5MPLl3Xv2k21zQnxaYVFz8huKxvIZWURbgZaGh1HjqLGW+G7KI6dwHh
 knbXCgmm9TYNVxbm85nULWAZJGVaLFC2MuPLN+nHA+AmSPFZk6ub4FBq4QY9fJik9BmJVY
 8ZLY0Sh1nYGCXCtXzEBbcIqttnytaRbhDc4v2JQPWIFBdD2MUmyvgHWlGJucfb4POn0mg4
 oMsIVdO7Isu9qcjNRG306hgbav+EJjs6dqKBOYP/hLLiJ56BexrOk0DWRdwUNX77N4xbK6
 h7ADx1BMMDsT4JOe5SikSsKJl4LXQkTgWfRLvsAg1aeXx/SpEtErrC33wCK4+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730991677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JeLDy8qnfae8A7GHch+U1dALPh9WBs0FUsOu7zXDJJo=;
 b=xH3ebjF4HwMdbpFkj3oH1xPgefROs1t2XUMoD8UaDCQvoBDlKatRDg5z6TWVfPbJx7z4uM
 iJoHsq0bxeJRSQCQ==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Fix boot failure due to misaligned DMA buffer
Date: Thu,  7 Nov 2024 16:01:04 +0100
Message-Id: <cover.1730988601.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 07 Nov 2024 22:53:17 +0100
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

Hi,

We observed the following sporadic boot failure while booting from MMC
device:

=3D> boot
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
Boot failed (err=3D-14)

The reason is because while allocating buffer to read a file from MMC,
alignment of 1 byte is used. Thus, the buffer doesn't work for performing
DMA, and garbage data is read.

While looking at this issue, I also noticed that if no alignment specified
(align=3D0) then fs_read_alloc() is documented to use the default. But the
default is no alignment. Therefore, other users of fs_read_alloc() which
specify align=3D0 may be broken as well.

The first patch changes extlinux_read_bootflow() to use proper buffer
alignment for DMA.

The second patch changes the default alignment of fs_read_alloc() to be
DMA-suitable, to fix other potential bugs.

Nam Cao (2):
  boot: extlinux: Fix unaligned buffer for reading data from file system
  fs: Use ARCH_DMA_MINALIGN as default alignment for fs_read_alloc()

 boot/bootmeth_extlinux.c | 3 ++-
 fs/fs.c                  | 4 ++++
 include/fs.h             | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

--=20
2.39.5

