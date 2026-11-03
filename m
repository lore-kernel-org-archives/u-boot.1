Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41E606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1P69gTep;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bs3qv4ot
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FEBA80DB0;
	Tue,  3 Nov 2026 07:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-_z1-Pn3Ixj; Tue,  3 Nov 2026 07:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB8AC80D32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689966;
	b=buBiyejl/u6qSz6f3xDBtibPX5CwSwgSeCOyamR204UBLUYGrhsoboWvKeNFuUcP+huc
	 xsOW8kDV/A1GwlRGj5Gh9b6GVsWe6fj7wrUmwHMretqfc9QJxizGLfcPt4pXaud6k4hVO
	 vX/fq8ffnA3oZHRojZkoLXbhJsiN0+gqwgjoBSjGH8hKB3w4YfD/1bSZdj+m1Quw1mLjR
	 UhXJYsgBT9xJOkg/nbw9U7tXD7PJhF04CqnZu+2ZJuHDAFQMiZHpKUwvQZ2HnmU7UqrUT
	 RDUh+nMMPN1DR7VcTJIl7aB4/STGNfCtgWLUYMJwU3hfs84CKmZFR8OHwwA0Tucc9CQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zEnsIvSrTOb8NUZPAEchoKqUxTOAGB6QpeJhV6hMBbc=;
	b=gL3XdozH6nJvjhITxq3hP0l3TP9cPjZSPFLewvTWZILIZYyy0ueLz9izVWlrWNzfbmh1
	 scA9IESE5bQvA9uLazLcEUFpQ/WQ7tuOY9+4IO2/XNcTHNIweCSXxUzPNFZ6JwATnFQdV
	 W0KEosH4OSU/9a9VYeP+L7Vz4EHWv7X8MSDGyh9OwseUTEaUNkOk9Q7/PXQ4oFRvhJOeh
	 YOJCp7QXRsqeHu3v5Jhon9UlcjXQFMJZSweJ5RqNc6r732SSAHmyLrLgmxl5sY8J4sYXn
	 Rp7hjbUdVlOn2eRVYbjWqKEVHvjgyPt4/969qRb0UX9bTa/OuN9Pz5V31onOFeD2AUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bs3qv4ot;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689966;
	bh=zEnsIvSrTOb8NUZPAEchoKqUxTOAGB6QpeJhV6hMBbc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1P69gTep2zW0PnZD1OUDKrjCRA3TweCyNJ9VpWFrJn5627wrpd5tPcyRHtfFQetX0
	 3TyHFen7qUtjoxB604okZcTlw+7GOQouo8H0DtBfyP6DIXKQqk7jmWUl8MmBPhJjhT
	 vp1ZUnD0Pv+q8fdPRyaIH1KJ0IL2U0Wzlk+8rnmF3wgrYPujTDP540kBQ3prnDAnI6
	 RW5GS5iHRkli6TPWIn//c0UV30anIcb8qLpPJr+K0QukRA/1GxeKnP2/GV3N8ZcFq4
	 WDr6WfkWEvj9GPT30GqUYrV5nPBNqQEk+flm8Y7uEaaAb5qSNVnE9LLH4icEV+eh97
	 u0neqMPCV00zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB8AC80D32;
	Tue,  3 Nov 2026 07:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9F93235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBFA380D4A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZCDsbcwV67En for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A5F680D16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793689964;
 b=PJc0nD5GP91fM84Pdkj28qizT2CEcHmgyVCu2JAYWOG1OqjCOkvzVY95tkqVF8U06/ol
 maHfL9/Y9cflaKWVOZARv2juZ7dKfJW/YaRE68tVFjyByDD/LbJ/O+OzeS8abBWT3DOov
 T+5gkJoMqUO2t5cJFeQtLxxGrDsZMhl7I2KwWkeIlU7gxXgwU0D76HpSj/TTHhEC2oahv
 Zda3Z3MEZuIwL6/QV60wgZj/3kvfJP4QRXrCGDmG9YTx/wFZmY/wph5navNBLToxHuuJU
 s51LDmHxVQgFBY3VG2yFDdFgKDVwJ4RHEAsKUPQoOgQNIbrEOdnZFA7q/4Ibxr3HxjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=zEnsIvSrTOb8NUZPAEchoKqUxTOAGB6QpeJhV6hMBbc=;
 b=CPJHThcIRsixEvyLG9iDpyjYMYS+6SDCC5hp9YPNPzx6hgm3b5H0rAVMnZhf2jND+wzU
 3dWQEjjZaMqR4ZqJzHiwIHZG//b1MbHx9eppr/DtMgZ3oyp2rmnBriAMfZXAeo47Mgt9j
 aExSXansi7lwCXS2p94WShsweiix1kJxu8f162UwLv6cWllVRfNjFQJ/r0CbHGm8rhXYA
 mLtcllBG3tBu8tRcdTuns8w2ExyN7lAhgFxLVqWfdLlLdBwISHsEnJpcSzQJksu+/zpuw
 A9JJvIKzrpPVrhniP2SOLfv8iFZuPxc6GVmuK2ODD8zygLoaGkcIcQnoIweHuyJrY6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bs3qv4ot; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bs3qv4ot
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A5F680D16
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:12:43 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2306547f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793689961; x=1794294761;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zEnsIvSrTOb8NUZPAEchoKqUxTOAGB6QpeJhV6hMBbc=;
 b=bs3qv4otmNhvbxp2b+pYk3BholYcUdQ35DozTOTdGFuR6IrBJvyc+dKl/0EaoOw7fK
 shBSk0/zv568hr+wBFAMqfGnDTYds4Qp6fumqholQkh2rkNj+LXQf0sV5ooRRgrckxnw
 Zcyy73vgrCzF6dfPDkRDW972Z+hR8R0gRPluQ+eZ8Hxn0QZP5Ok5EAC4+qL8Lael3+Ip
 D9dvP9D3MfUHgwVLnZlYUXFEzHCEVvC7BbDwDknS9V+12S1M7whcDW3asj5dPkDDv3y+
 U8g9BE5Zg4o1mEGtZxB8ZNXc1fzUH5Z/poGuDai0zJgSONlnZNZvISMHzaoHEA00Q29Z
 RB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793689961; x=1794294761;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zEnsIvSrTOb8NUZPAEchoKqUxTOAGB6QpeJhV6hMBbc=;
 b=GctVluAuARvh7hV+hM1OnYk3ZrlB6KzzVWdRvsYg3izEW/YtUMoU0M746UIx5u2Idt
 78s3Tl1s9WwrSjNjLEF2EaXsNZfNX+pT1j3wkphirENz17BqK5H/I+eOppYIFnyVyH0z
 jYLE/xo2FImH0OmHzI+N+BuCvgd8jhXZNdP7+HYb963kvdHfBPOftqS+7wBV2/hIgFje
 wQMJYS0F8BLcjx8WUfc6eraj7SrRl1hTm8yHfTDc9gEfP1FCO7dfomtrBlSRD0lqweP4
 F/rz294HCK2Bx6EtcjzvYPS7EjmORYirWjBAZFpakKUmS6SJG8jB/zNC2/e09Y5xV1Vm
 iULQ==
X-Gm-Message-State: APuU4Z/RGOMUH0cP9IBiXvzT6aJbyzDkVDCNDPir8YncYjbu8pNqREtc
 B4hAgnDkELTVORKE79TwwUzGqY+RMd8aN5grcu+6yQA7961LV0oEZmp3+L8xHuMATEhGjhD2
X-Gm-Gg: AYBFou31/iADygQwFPH8DFat4qmfJSxY3ZVOQ5Zap0RQf5Wv10yj7AlwT0HXq1LU1BO
 XOcoh3Wz5M08TuxIBq0TVOlJrIhIvymdfGmFcPPzfJc9Om7aypRKyABEH+MvpVbElSiWjh44xaz
 u9nAgi9umJqseDOWv8l8rfv+zoefgKbsedNLZui7LPQhMb7Kxz6rX361BoitzV3jwyNIGfJEjuu
 JslqSV91KXsQD1zcSMq+JFMRbF2l3HHgGLOMsNYMMfbYbUyTwOIws6OA5F37qlH0xup7R4qC0Ho
 bwQI3RHYw0EvKquaDXlnSXt5HwVJtGKwobnN7mWMTHmxG1MuVoMprTWx4GeYsNvsgcLzTKuqGTJ
 75x8OUX2J3rOr1dS8a22dbzNPLArY34sQG9l73QwTcxrZITY72FR/UhSHbf+qV8qsLs7Um4iK34
 Jw+PUQvxlxgVVmpa5wl35moyx/gRnQd2pzPnGPsWrBTPFNkAdfCe9UOwG3IAfccJYhOGTZ3KDt1
 Y8GFfvEANHy92IIa63ElIBO59G03YYEKXZYDmbtq82tDs1B9AtdkjGFAuEDg1hkh3XXR2KMV/WJ
 AAPe4ym8J3bqSxUiNiPWpSN01YyCotA=
X-Received: by 2002:a05:600c:3114:b0:4b1:32c8:27db with SMTP id
 5b1f17b1804b1-4b132c8286fmr96396005e9.22.1793689960840; 
 Mon, 02 Nov 2026 23:12:40 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm35792405e9.9.2026.11.02.23.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 23:12:40 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>, Benedikt Spranger <b.spranger@linutronix.de>
Subject: [PATCH 0/6] mtd: ubi: Check lengths and PEB numbers read from flash
Date: Tue, 03 Nov 2026 07:12:39 +0000
Message-ID: <151582f9-d68b-4fc9-9f07-1a8b9b1395dd@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

UBI takes the sizes and PEB numbers it works with from headers on the
flash and from the fastmap. This series checks six of them that are used
without a bound, in the UBI core and in the SPL loader.

Patch 1: validate_vid_hdr() does not check that a VID header's
data_size fits in a LEB, which Linux has done since commit 281fda27673f
("UBI: Validate data_size"), and ubi_compare_lebs() reads data_size
bytes into ubi->peb_buf, which holds one PEB. Apply the Linux check.
A new sandbox test (dm ubi_vid_hdr_data_size) writes a static volume of
one full LEB on the sandbox NAND, checks that it attaches and reads
back, then rewrites its VID header with a data_size one byte over the
LEB: 'ubi part' attaches it without the fix and refuses it with it.

Patches 2 and 3 are for the SPL loader in drivers/mtd/ubispl.
ubi_load_block() reads data_size bytes of a PEB to the load address
without checking data_size against the LEB size, and
ubi_attach_fastmap() uses the PEB numbers of the fastmap's used list
and EBA tables as indexes into the fm_used bitmap without checking them
against the PEB count. Both now treat an out-of-range value as
corruption, so the loader moves on to another copy of the LEB or to a
full scan, as it already does when a CRC does not match.

Patches 4 and 5 are for the fastmap code of the UBI core.
ubi_attach_fastmap() hands the PEB numbers of the fastmap's lists to
ubi_wl_init(), which uses them as indexes into ubi->lookuptbl; patch 4
checks every PEB number taken from the fastmap with one helper and
falls back to a full scan when one is outside the device. Patch 5
checks that each volume's EBA table header fits in the fastmap and that
its reserved_pebs is not above the PEB count before fm_pos is advanced
by it, as on 32-bit builds the advance can wrap around and pass the
end-of-buffer check. The SPL loader parses the EBA tables the same
way, so patch 5 changes both.

Patch 6: check_av() does not check the size of a static volume's last
LEB against the volume's usable LEB size, which is smaller than the LEB
size when the volume has data padding, and a fastmap's value is not
checked at all. The size goes into used_bytes, which bounds what 'ubi
read' and ubi_volume_read() map to LEBs and look up in the EBA table.
A second sandbox test (dm ubi_static_last_leb_size) writes a static
volume with data padding and one full LEB, checks that it attaches and
reads back, then sets the LEB's data_size one byte over the usable LEB
size: 'ubi part' attaches it without the fix and refuses it with it.

Both tests fail on current main and pass with the series, and patch 6's
test also fails with only patches 1 to 5 applied; with the series
applied, 'ut dm' on sandbox shows no new failures. The fastmap
paths (patches 3 to 5) have no sandbox test: sandbox_defconfig does not
enable fastmap. They were checked by building sandbox with
CONFIG_MTD_UBI_FASTMAP=y, where both tests also pass, and
igep00x0_defconfig (32-bit ARM, UBI fastmap and SPL_UBI): both build
without new warnings.

Linux and barebox share the code of patches 4 to 6: the checks of
patches 4 and 6 have been proposed for Linux, and all three for barebox.

Patch 6's test builds on the test file that patch 1 adds; otherwise the
patches do not depend on each other.

CI: Azure build 13722 passed, all jobs, with this series on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request,
merged with main ee9fc27f2a2:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13722

Ana Bobillo (6):
  mtd: ubi: validate data_size in the VID header
  mtd: ubispl: check data_size before loading a LEB
  mtd: ubispl: check the PEB numbers read from the fastmap
  mtd: ubi: fastmap: check PEB numbers read from the fastmap
  mtd: ubi: fastmap: bound the size of a volume's EBA table
  mtd: ubi: vtbl: check the size of a static volume's last LEB

 MAINTAINERS                 |   1 +
 drivers/mtd/ubi/fastmap.c   |  87 ++++++++++++---
 drivers/mtd/ubi/io.c        |   5 +
 drivers/mtd/ubi/vtbl.c      |   6 ++
 drivers/mtd/ubispl/ubispl.c |  44 +++++++-
 test/dm/Makefile            |   3 +
 test/dm/ubi.c               | 207 ++++++++++++++++++++++++++++++++++++
 7 files changed, 337 insertions(+), 16 deletions(-)
 create mode 100644 test/dm/ubi.c


base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
