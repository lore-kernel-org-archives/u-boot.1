Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FCBC5DF67
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06AE2407C4;
	Sat, 15 Aug 2026 22:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNAhxyDaLxjh; Sat, 15 Aug 2026 22:48:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28775407C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834126;
	bh=AdDsT+W1vwryWekVOMqsKHt7ouNjgAV5cqBYztPgCto=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=es7EBT1SwBSyeYxLM3Pk6UVOzhj9UkzM8z+lq7jpr34gBu8QpNmzE+fQCF+pPEXj0
	 z5DGdpKWe5J9jWzA2rV8LbyioUDGUzfOc0bFlagQ2d/A+uUJ23Qc2meUmIlemyM23t
	 TqblOZcAKOvvL9s+3HA2rVhOHaMZPVCkZZU+1EgshlLA2APf1960c9bF/CgBm80lW/
	 LOTMTg6Sr9M3vSxCVnIeKsLZb2AmDmML+lMMUrO72Jy3EmYUfT+LoS2yJLQipewDXl
	 uJrwuDUEbgO/3sc0hKUypk25FUwbUDa6RqNOBjEpvbekFz9uTVNyk6aKzdYRgWrw5V
	 8aeAhu/iPESbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28775407C2;
	Sat, 15 Aug 2026 22:48:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0745E333
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E13B380EA1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xIJHiu25nv4 for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:02:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1A47380E4E
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A47380E4E
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CcT7osMi
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A47380E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:02:26 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4998590d392so22793315e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831344; x=1787436144;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AdDsT+W1vwryWekVOMqsKHt7ouNjgAV5cqBYztPgCto=;
 b=CcT7osMivfRG/Kj/m5dBe6yFMiI5dQ/iWArsAGJUtNXQUk4y48KWLpjuT77eaAX4BE
 o49vF6zzhuPF7629Epick/liXzzhiTPQA7+iUbZ6GQHOHdGcbpeIUMmtgXeVXzI0SyZb
 f5tlYG3wYl2kHfeahUG4Udd4hhU/Iw2SVFjP8t+PcPUyHn/Gwoe1/s6qWktxSqua0c9J
 S/urTeqP2p3wLHGleA7ut7kojop2zj/gnOZ7DzOCaWXIWh7AppLzmOmSWke/Ma+H/3ZM
 jN0kM57w4nNJ5jZlwAT/ROmaR4nveP0uajPUsrUqJXePBIu+ABt95aGl0+rWD/Yshops
 j/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831344; x=1787436144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AdDsT+W1vwryWekVOMqsKHt7ouNjgAV5cqBYztPgCto=;
 b=sOD11TYR9LhrU0FjuG2N5KP35iYvVzR3/53SXca3MFmgcfZQbiZ90zvJwZjUl8KqyW
 zrkZsF2SVUoKHbaQB0nduDNI+WSOlF3r2Gtyq3q44KluNA8g8He4fzthCJtINHGxBvLn
 jQIeAugCIrnf2xoTmksz9HCIz+x+8YRJ4SzQRTFKPVnD9e5X5eobYi4etb2sIWZ3F1Cf
 +/yTAz0XPJKVRMrr4k/eEiZ46ucnVEqAPqQHmlnVOHE6argAGOIX16D0DLFMyoHKu5fX
 bFT0DSPKqkkPigcJV9t+zWFHes2ECIUOJshUgB66M+1fLaMu9zWHhV3BCbplgByuwtUs
 n3AA==
X-Gm-Message-State: AOJu0Yzs8lsJl44SWShTZYvnGMvgz3xaEyN60tAr5L/cTH6S04GmgGQE
 9YKxPwyjd7vjJVmlDdzi2pl6oV4z8rfd4Xpzwgvu/Ane6z334mzTArLOFh2x2dtkvjk=
X-Gm-Gg: AR+sD12h7baLykdIIhkCx8uUlfrRGa2mGQPdrMI+WJ6FPP6cwWt8O9LNDhLpnPyBWtC
 M8Inrlg39e++TnOfBKvpXF44ag53xj0dbSJaWXu/JySx/K06paZ2HIa8PLOKbp6Q1P06gIxs/KV
 Ii+JocxwfB6ZdCi3LtT2G6rmmbhch2HZQ+B9098TSA+hTQ7NnBlPpZY2fSXnPmzKvuETr+42P1K
 UlAUOrL7MsAllIiaVFajkaTIy+vAh9CsYXF68DFLcNlOhHyKGKdXknNWAr5VStLBciobO2b3fSe
 iLQmDyP/iNpsmwYeGlUeNvxviTeIGdTi8trMeOsZRR+45IwIHkja/dcrEZD2NYQ71kPATg3r/p9
 kVmp5vVVKB4iK+/ync7qThtDXKN083Qt8M368JRHDPS1G9rV3pRhTX0r9In60FdurB3Yht8cEOR
 1w6c5yGEwwVfWdIFxANRZGx3mjIDT/M/Xc9Vfpxe6Tcck1nOHMvXnAYwgQcpjed6m0rQ6gODzhS
 L0Il6tn48ICiTQSFJ8t6jkecrNB8T8LuA6j+ast+5dYZErL9d2080wiFeHMR4LYdq30SkaHS+r6
 AND8xaLLk8DRnHqdagDgpgaHczCrwhRyfpI=
X-Received: by 2002:a05:600c:8b05:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-499879923ecmr242719015e9.13.1786831343936; 
 Sat, 15 Aug 2026 15:02:23 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179055255e9.10.2026.08.15.15.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:02:22 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 trini@konsulko.com, Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 0/2] fs/squashfs: bounds checks on image-controlled offsets
Date: Sat, 15 Aug 2026 23:01:13 +0100
Message-ID: <20260815220115.11335-1-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Two out-of-bounds reads reachable from a crafted SquashFS image, found
while auditing fs/squashfs for image-controlled values used as buffer
offsets without validation. Both were reported to the list earlier; these
are the fixes.

Patch 1 covers sqfs_frag_lookup(), where the fragment index is checked
only against a superblock field that is itself part of the image, and
every subsequent access derived from it is unchecked against the buffer
that was actually read.

Patch 2 covers sqfs_dir_offset(). Commit 57e0bb7bf00d ("fs/squashfs: add
sqfs_dir_offset() error checks") addressed the negative return value; the
positive range is still unbounded, and the callers use it to index the
directory table.

Neither patch changes behaviour for well-formed images: the rejected
cases all describe inodes that reference data outside the tables the
superblock declares.

checkpatch-clean, builds for sandbox with no new warnings at W=1, and
test_sqfs_ls and test_sqfs_load both pass against images generated by
mksquashfs 4.6.1 (the default plus the three lzo fragment variants).

Review of the exact bounds is welcome, in particular whether patch 2 is
too strict in rejecting a directory header that would start within the
last SQFS_DIR_HEADER_SIZE bytes of the directory table.

Pranav Rajendran (2):
  fs/squashfs: bound fragment table accesses in sqfs_frag_lookup()
  fs/squashfs: bound the offset returned by sqfs_dir_offset()

 fs/squashfs/sqfs.c     | 50 ++++++++++++++++++++++++++++++++++++++++--
 fs/squashfs/sqfs_dir.c | 42 ++++++++++++++++++++++++++++++-----
 2 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)

