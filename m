Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF1ACD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C79784928;
	Fri, 12 Jun 2026 14:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lK0Q4pFI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC2D83FEC; Fri, 12 Jun 2026 09:54:58 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5989C8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piyushthepal@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c8585c51f1fso776313a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781250895; x=1781855695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WR1EIYBBBDEypUqfJRsw3U9PNsuv9LKfUWz+8OkqLgI=;
 b=lK0Q4pFIFQykiW6GnG5dVmH5mJF50q+QS1XmeOk7nx+fp1oGGspgHpYBj5dn4stfnQ
 7WKlK58ftoqRjaLS3mZ47rttwGHs+Q9pg/SOf5FBUs47uUpi8AuJx2sbaTlnhhAlRsq/
 gX22rPBYyN5+fki7Hune0gcNKfDkAccULn63oahRdlDIRUtsxm4bxgmKZq4a92EF+DhA
 pcwNMlV5PCLWNVr2n451p/TBh3o4IoHks23gpiAqnSFyEz6nNb1B1lBaTl9dWyifjawi
 Gkz1+4eJpp3kLrVghkzOCGDRCmrZRoeP006o0DpYLPknffoZoT8kB4gN92/tuiM5n3kK
 +1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250895; x=1781855695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WR1EIYBBBDEypUqfJRsw3U9PNsuv9LKfUWz+8OkqLgI=;
 b=ia9TvgTjFGsit3bTjJQuhhSkTpLipKuocCAv4WGE0TupX5fAdkDb0bapsCuhSOnzUt
 M45rHATBYpUI86Yak/7N9mysV2JJFaKJroU9PL0FGwdvV7uQykoWPok4Z4e1Bm4AKLWM
 Okvr5xvFg7jfmGQjwc86AbTgHxDh7F+5Q3hAsL+9CDtJWmYQyQs/rUNSs0pdDTtjv+JM
 6htZhn2uq5qZQjD35zHYKPB6XAQsrAtOIQd3SlZNxgcnd2X67ztgSZF176jK+7P5iRJw
 nA0xVCAXPW+g/I7OlZmVILYKiFr8yc874sFHf3ATFEovHA7WFPO2pNAAUS9cw0wQ4CjN
 N/kA==
X-Gm-Message-State: AOJu0YykHjV4wTJ/kPKivk2b0svhNnKxG2efLoVNeeekUKCVFiZtk7sC
 gCfWteyErnoffGsfZLq4gB4i0MQvyfjnTf/86oHLno3P2T6Fev9YVWBUSU3+Gpu+
X-Gm-Gg: Acq92OGDoaJXVq6t+dJ/2Y2pxdRP0ivxRaQ7PhLOUaxsG6w/jI5s/YJCglwe22q9eip
 r88IvoGCDW51wlDmR38sYVuOmmxgqma0czrjXT7nOs06lvvUu1bHrlxQ8LJIaJuTC8+LJh1r/i5
 pFORFJA2K8KOi95oYHH+A0ckOuFdoeqZVpiZtbET6BGKznpAstn/lM8CbgWAjmUpmf74c+yU5VU
 IwN8HD9cOHw/HSX+pMnQZIUoS2U/FrNdtNJ9PMr6dYJQ1tptDEMG6Q1xcaDfs+DdQkQmroEYErX
 AryptkI//w3hE5yABDw12CjhgzGXGmkh7kuJ7E2F/D+oAtIBOhxbacs2+x5OGG7qjD/ukn2ZVRg
 2UczaXjn5AQq3bGi/kwyHkpGFJDxmSL+yHuiwtUjyfU2kaB23VOSo+jPo7jhMpx4GPrsSPGHFOU
 +GxmBeVyk6LfIhO9QKFMKgXaFT2B0k2zzPUvuAXrPEcMLXfJ/qB1g1PpU=
X-Received: by 2002:a17:903:390d:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2c3fd132a29mr19386445ad.20.1781250894680; 
 Fri, 12 Jun 2026 00:54:54 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm11197655ad.62.2026.06.12.00.54.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jun 2026 00:54:54 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, eric.kilmer@trailofbits.com,
 Piyush Paliwal <piyushthepal@gmail.com>
Subject: [PATCH 0/2] fs/squashfs: fix two out-of-bounds reads on crafted images
Date: Fri, 12 Jun 2026 13:24:22 +0530
Message-ID: <20260612075424.83462-1-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

Two independent out-of-bounds reads in the SquashFS driver, both reachable
by pointing U-Boot at an attacker-supplied image (e.g. ls/load on a crafted
USB/SD/netboot rootfs). Either one crashes the bootloader (DoS); patch 2 can
also copy adjacent heap memory into the loaded file (information disclosure).

  1/2 sqfs_find_inode()/sqfs_inode_size() walk the decompressed inode table
      using on-disk sizes with no check that the cursor stays inside the
      buffer -> wild read / SEGV, e.g. from a simple "ls".
  2/2 sqfs_read_nest() uses the on-disk fragment offset as an unbounded
      source index into the fragment block -> out-of-bounds heap read when
      loading a fragment-backed file.

Both were found by fuzzing the sandbox build (CONFIG_ASAN) of sqfsls/sqfsload
with mutated images. With the fixes, the crashing inputs are rejected
cleanly, 2000 fuzz iterations produce no further crashes, and the valid-image
path is unchanged.

These are distinct from the 2024 SquashFS CVE cluster (CVE-2024-57254..57259,
fixed in 2025.01-rc1) and from the sqfs_frag_lookup() fix (e365a269df5): the
earlier work added NULL checks at the callers and fixed the symlink-size and
fragment-table paths, but left these inode-table-walk and fragment-data
paths unbounded.

The two patches are independent and can be applied in either order.

Piyush Paliwal (2):
  fs/squashfs: bound the inode table walk in sqfs_find_inode()
  fs/squashfs: bound fragment offset/size in sqfs_read_nest()

 fs/squashfs/sqfs.c            |  50 ++++++++++++----
 fs/squashfs/sqfs_filesystem.h |   6 +-
 fs/squashfs/sqfs_inode.c      | 106 +++++++++++++++++++++++++++++-----
 3 files changed, 134 insertions(+), 28 deletions(-)

-- 
2.41.0

