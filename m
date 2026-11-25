Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC56606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tQj0GR8V;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdtOLP2K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9569860891;
	Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kUCbnu3qY5G; Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AAF4C6088B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610587;
	b=iwqzBPaVKCSOLZpsbyxnJfeVedvRrMQbkr2SPVERtis/9vaQhskr5K67BcRp4OZFINQm
	 3Px+gx9He1WSJCiGaQB92p2F8hIu0rSGaZz6xceb9YbEFLiuIQPBN1/WJo+8tEgUSAe10
	 bUgwhRaT3kx991RPzZoRWUshk4weJlBiSH0he21fZU7W/QXkPoKXvvi4cN5g3usg89PZb
	 N1+ZOj7zv6eUDeP0UJiHvsHPpjmZCYOuoG4hBPynascpRTuxx8QWNQ5ScK4aH2U1UsDHx
	 hMXD51kX3QFA337RHdSNl8nd4B2cnm+PB/RhyhwZtWL+4pI5Tf8Y3axvWjQDb4gDPiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TguIi6LJJHsAiHktyRxIoLuxMSBrayG046+MGe+ZjUo=;
	b=U1AMJPaWcYQn5ZX/nfFuej7tJzBCc2Z+/CCZSNVBeaJtNvtvOITO2ZYuUFt2Wt+HMemZ
	 BrR6UU9yuZ8y4X2SLc0jprVPPs79fvSQlNUQOHnLq6IIK6qts8yGeWCzPmJ9RJvmXF+IW
	 7qboomUwm+OllVcqlnHp7ZxoRXMtjnDVd0eA6WRBdBl1Yo6GC1INglgEoET0U8XnNbmNG
	 xgd1ljmU7i6teXCoRnRo90oNqthbtjDoTyUY3Xg24QusLOrZlVxVjHeyk2aInp7WMwxJ+
	 876a/MKkIpOa82mPe1WI16vK7/e7KucbIFeYCklvfd0xf5sXmdbTcNcTB1Qih7ZpI5Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610587;
	bh=TguIi6LJJHsAiHktyRxIoLuxMSBrayG046+MGe+ZjUo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tQj0GR8V9RU82kAVTWD/k//eNpTSnr/G9W4LeILTedUNKu5UHZb3EbagT7m54I6+1
	 +jnS4x4kbYOTTbUi/PrGuogELwvhDi4i75J7vxFvSO6mOAi+l0l6H/i7JZFDGc0YMg
	 bdcNKeoKya6gxHmZIQSnP9ZKCc+4ZQUVNBEjFvjMGUO5xcVpaH00B8odLGsGl8afIy
	 3JowIj7dKZw94Nz8a6l1/u222HeiQ94oTUodr+B+w/A4moUKJhJC52X+NbCeMsZDi3
	 HLrqdLmWZwG20S7s+uUcsoR0cDcSYWCVR1pt9lFgmWPrXBsEwPnGVqoSmDTX62BKKq
	 VA0qzquBBN7QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAF4C6088B;
	Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 682D8325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DCE1401FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eLpmJsx5W-FA for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2B36840116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tdtOLP2K
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B36840116
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:03 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso56453115e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610582; x=1796215382;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TguIi6LJJHsAiHktyRxIoLuxMSBrayG046+MGe+ZjUo=;
 b=tdtOLP2Kba1ALwDIw5RsE6NjnbLr39N9oKNivqiVo8wWFV2l8xOH5Z7dQFEnkj8SGZ
 AGMscSy2wHi9rOU+4cr5zseDy7fwBBFA6Xn+Qt3dILTDVInIAbUpWV7ehDf5JAYBbt5W
 XVBqbDQKchbVq/Cr9Yji6ptvca2xNwMA7jclfRIJX2cYlTCFYdwF9f+NzFRDdl76y83j
 q/VlXP5wTPIsNtm1ULKQ4cHBLCUi5M0du4T25H0M+nyQfi5/2sVFzS87bPDcSlU0WVq0
 RUPNLo3lq4+LyWtCwUkIosM/O1BtbVHku1xJKyOK6ucb5b9jnun4zPI/axwo3hWW9Mnw
 3P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610582; x=1796215382;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TguIi6LJJHsAiHktyRxIoLuxMSBrayG046+MGe+ZjUo=;
 b=qJrrDP4zsbmq0eh3oHnLCu0j77blqpCq6qg35I4qlqJ24soqCxmX/RVrxY//5HAHE5
 HZvsTddADPGmQDeCbqVc3XNd3xpuUEHTy+w0tXr10yCGPsJ7iOsg8sM7LnafX+LTYqHy
 xRGO6n7RESUNFjtaxILqJF+kxPTHNzm9mza3xUhGQtwgBGnKxOUXrvhG+zpZQ43K8eyL
 xRIvfjKNxiuFoG59Pu6BMMpJpOtztVISSHFQcqfRgH7EjcimwkEGiastvMWlLSf/jSQ8
 FbFhMyL2FmYMRz6wn4v+lu6pExT4OEVyVNdVNI9XRAohIU5+P7TvfwYSP/cT4xxUt5DM
 L8wA==
X-Gm-Message-State: APuU4Z/VVWXvZ2yrfdBQDakmiwm6JywdTXizgLW+OSZNwDqoPXp6DLDp
 Zwxk4RUGoSuEDkIy2JRYl05cpNMGruhuPHPfq5MFHJShtrUsIPk1u7gWC8liGKqa
X-Gm-Gg: AZFdTZeQNZ++6sDWdo04PV2+kQiM3jz+zO74EFo8ulcNMfqahEQHS3Dq579bN/kl5Cj
 146cg2A+FhY0SfPOxcwFCN4qXl47E7Fey6QZ4efPYKwTJiwUMtbbdEWwaQvZP81fdp0crhT5f6X
 Yhekn+sYGkZzaPv9Wn8nekxnFmH23RykwtlUYYVncS+5aZ1wk/UezfnUGOSKIByIy3BJG/4Rk8B
 58YZVvXQAsIW9t/W5Z5EPBD9dwzq6zEqrhyRLyKItMGyxE9QAb3LJsYP4J7URXIhR/eawA71eH6
 Dd1QUFWzi1HvhFOomAxSTJqfg1lx04NZXHv5G3L3E93dDqlhuxh+Y5PZREm3VUUJJzGxUG1UfUL
 4X8Gacb8L/1f9+gmKgD8QbwmU13QKE2GQUX2FaY11u/ryyFcAs07aNtUhYitO/XocQdHKjQrrK8
 ZKhmk0n0UQEuBSS4B/Ke4e46ShUwcYE+ZUFha6tKkd005l8+Xj8mI/IWcC/h+IV2l1HFkvWRR8E
 v0WWpxi9D/Apf60hWHS/u0pjdeTbCRt2q/gRvllurmtXxG1ntCoQVC9qqBPx5Iv1IeNAnQphU5S
 jqw3+vOBh5cfZakzGCtrZKrcFD0Uwk9DwmCKlStyDBrf73OslAGVWO5L6XWXMQ8cD0BiOJhXU0I
 taDoe56D0PDQprndd+EuKu+NcuqtPJkei8CehTcAg5voG95ooCjqZUFHUeZmuO2qBCpbvC+uKeo
 Mo+H0AhrfupKMTxzPxQR/5MfBOrsQ5cz9Z+Pt79iMWUtQfPqi2kA82Hw==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4bb888120famr364559235e9.16.1795610581794; 
 Wed, 25 Nov 2026 04:43:01 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:01 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] Avoid 64-bit divisions that need __udivdi3() or
 __umoddi3()
Date: Wed, 25 Nov 2026 13:42:53 +0100
Message-ID: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot's private libgcc does not provide __udivdi3() and __umoddi3().
v3 of the mpc85xx LTO series links mpc85xx LTO builds with it and added
both routines [1]. Christophe Leroy asked why the callers do not avoid
'/' and '%' on 64-bit operands instead, and Tom Rini asked to update
the common code [2].

Patches 1-4 avoid the divisions that make the mpc85xx LTO builds call
__udivdi3() or __umoddi3(), in btrfs, squashfs, mmc_berase() and
get_win_cnt() of the mpc8xxx PAMU code. They do not depend on each
other. Patch 5 removes fs/btrfs/dev.c, which nothing uses and which
holds another 64-bit modulo. Patch 6 converts the remaining divisions
in btrfs. U-Boot never runs them, but builds without LTO still link the
ones in the RAID5/6 code. My reply in that thread announced these
conversions for v4 of the LTO series. They are sent on their own
instead.

Patch 2 and my big-endian fix for squashfs [3] conflict in
sqfs_read_nest(). I will rebase whichever of them goes in second.

Build tested with a buildman world build on a fork's CI, and sandbox
test.py gives the same results as before. Run tested on qemu-ppce500
(btrfs) and qemu_arm (btrfs, squashfs, mmc erase), and on a Turris 1.1
with the mpc85xx LTO patches on top, which boots from an SD card and
loads files from btrfs. The PAMU change is build tested only.

[1] https://lore.kernel.org/u-boot/20261119133310.22732-5-pepe.schlehofer@gmail.com/
[2] https://lore.kernel.org/u-boot/20261119200924.GB3176972@bill-the-cat/
[3] https://lore.kernel.org/u-boot/20261125095537.37979-1-pepe.schlehofer@gmail.com/

Josef Schlehofer (6):
  fs: btrfs: Avoid a 64-bit modulo in __btrfs_devread()
  fs/squashfs: Avoid 64-bit divisions
  mmc: Use div_u64() in mmc_berase()
  powerpc: mpc8xxx: Avoid a 64-bit division in get_win_cnt()
  fs: btrfs: Remove the unused dev.c
  fs: btrfs: Avoid the remaining 64-bit divisions

 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c |  2 +-
 drivers/mmc/mmc_write.c             |  2 +-
 fs/btrfs/Makefile                   |  2 +-
 fs/btrfs/compat.h                   |  8 ++------
 fs/btrfs/dev.c                      | 25 -------------------------
 fs/btrfs/volumes.c                  | 19 +++++++++++--------
 fs/btrfs/volumes.h                  |  9 +++++----
 fs/squashfs/sqfs.c                  | 21 +++++++++++----------
 fs/squashfs/sqfs_inode.c            |  5 +++--
 9 files changed, 35 insertions(+), 58 deletions(-)
 delete mode 100644 fs/btrfs/dev.c


base-commit: 79497816056122c49b3b135e14cbac59374e636c
-- 
2.54.0 (Apple Git-157)

