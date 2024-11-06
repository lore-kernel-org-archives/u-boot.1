Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273AAD59F6F
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 20:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B29388DF1;
	Wed,  6 Nov 2024 21:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="njnh6Qnu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAuHenm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03734891D6; Wed,  6 Nov 2024 17:34:43 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F25A88C4D
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1730910880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wc75YXtvttjLB/42L3sQUpGCLpSROudA2/pqQSX5+K0=;
 b=njnh6Qnu/6XPRcVbuBc8itqsYdLqXH/OswylN2Yn4QPZ9yCVTN2NfI57WdeUiiW2d2/641
 TOsK2QaSeL3dqCNHKn3u3kEVEcdWbNpY1PNCKrEDDqU6NEC5H8ZBn+n1J2SAYTPD3Weyd0
 0deI2KAdcw4yH2aL+ONnUdIVt0DbkisLr55lLMyaDS71FHwXQ9oZUZk/+vZgKpost8+VVq
 fVzAG8m91oEDA1zi2SNDEpQsQVCm3uM1FbKplNfxhn/RpfsAnBtG3nXb7wYU7dHk8n3esa
 nRjYR1Yc/f4c/li3shmut50LQG5FoNfnKi9yY9EQdXq8gsJYY0pT0kiJMfygMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1730910880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wc75YXtvttjLB/42L3sQUpGCLpSROudA2/pqQSX5+K0=;
 b=UAuHenm2G6RYVY6BOic2nkb/Nh9omyK2Ig+J/AFAqHRxUQZYVJ7L1Hhibyw4T6rlzaAbLK
 ySWK6PBPqX+F0fCQ==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Nam Cao <namcao@linutronix.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>,
 u-boot@lists.denx.de
Subject: [PATCH 0/2] Fix boot failure due to misaligned DMA buffer
Date: Wed,  6 Nov 2024 17:34:30 +0100
Message-Id: <cover.1730909884.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 06 Nov 2024 21:19:57 +0100
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

The first patch changes the default to align the buffer suitable for DMA.

The second patch changes extlinux_read_bootflow() to use the default
alignment.

Nam Cao (2):
  fs: Use ARCH_DMA_MINALIGN as default alignment for fs_read_alloc()
  boot: extlinux: Fix unaligned buffer for reading data from file system

 boot/bootmeth_extlinux.c | 2 +-
 fs/fs.c                  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--=20
2.39.5

