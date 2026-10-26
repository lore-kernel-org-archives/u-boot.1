Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0F606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cDhVmA4g;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QoxcT51p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87FA880F0C;
	Mon, 26 Oct 2026 14:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6GMlVuD_GtF; Mon, 26 Oct 2026 14:05:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 946AF80EC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793023503;
	b=NLBB67ti2R92sNTtv2yPpBC3eSRWXujJf6GsdxMxC4W/vm1fsuFR0Q/TCDL6WANtMjM5
	 zELbiPUbDnSm6HFcH1bIBc3ORPIDT7mO/KHQ3btuUf5ydk4B1sqV5ceD1CBpRSsNW+Wfl
	 DLGvTAlh28erTU5A5/LwcQyuIaOEBRLxA7MrmqGUKfuh/9FVKvlLt2ywbKkMJMPEe+gwq
	 rjdLKVggIUkyZ95s96Q7FPDJ0CShdFJVbEwc1dCH5cSz9fiTXOrJYtGXHwV3bJhK1UjP7
	 RvBDDiC4OFvpGFhPnhdxFgMvvrABCFGp/VK03CnRqd2V2UsuA6+z5GDL+JRO/+6RHqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793023503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a9xnQeCyTcebU91o7yc8y7cU7SF3uSkH153WqSaOMWU=;
	b=mqTv5bPWGuuUSVumstoN8Y+67QTr24ZnMgOjX3yITFfeD+iv4nONEpGH30ijQtZ2ti9O
	 wNny41rrcUxdNETuwVxu7rDqzmr8M7PLblHgMC0MR70XcsNUHSd+3OmegSQiBuMmDIOJx
	 kuSZdxXHfdupq9gJ+jhnyoIsvaouz2oG5ED9qy0Fz3H5cior/8zI6YzMvkg59Kq0UVysd
	 Ay2wOwPuBJ6RJ91zhkX96BWsnANQoYBAcMxlcDF2BIsy0xaPo4KuNknw90Vcb1h4zMBEl
	 cYv9e7LJkAkQglOiZFvJthASmHRq4FuQX3T0ZDoAs2fULhZE88KegdGMf/nu0PCLaiA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793023503;
	bh=a9xnQeCyTcebU91o7yc8y7cU7SF3uSkH153WqSaOMWU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cDhVmA4ghouX7spT9o0n4dlbb3+6LtVvPBa7P74FMe5fAW+K8KHGQWWdQQ/7gjwzA
	 cCqI7SXJYEWzdZiKx5B2MpMjvh4X64tfNEpClww/XVPKVauw46JonpMeruc4uiBs+I
	 Ylhy48+mSKu9nS6qUJzikKWuhBH3yG97LSJq8xpTlj59sC0AIRnCpFK6tOcWWAahok
	 +w8q7LAAGCvzrW8AVAcp2zkpLaFCJyP43hodaskozxb8ROe212y7DTTj94va+Mzn5C
	 b778ofBIM28S0P39gJ1uJJXrg4colYLFz/oHI/qtdmq/Moof4ZPQIo38SdzxTeIg9K
	 GxJ9/shRBV/4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 946AF80EC7;
	Mon, 26 Oct 2026 14:05:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53A32279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BAB54065B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HS0uSwPXxUi for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13D6440653
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793023495;
 b=XtFmblU9RNJpRmHPm6PcPAvs9iRa4H3RCuD0hufMidv+X3iKLc08s69o7xvF9hEDAi11
 3KUENgt8VMIqzCnikBg0uA0tBsyetoya9hwWKDPt5Rf5OleO70qnjbBYSe2LrDtzI2rjs
 u7QplQrA1zb7IIOvcDMrElVbCuf1GYdywMzDno4BjOFgXXo3NUiwsKu6RtBtCJBuKeBoC
 8qGUDcpOVCrwc89LvN56d90bNLFfjIPpHvOTPyBt3aG8FavwsroERT8uCldpjxdJUTrQb
 IT9cKRQmw2wBeqIDmmYjkV3Qjfst2F+P/VxYs2t08/4HOI9nS2EM3iumTi2wbCbhbCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793023495;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=a9xnQeCyTcebU91o7yc8y7cU7SF3uSkH153WqSaOMWU=;
 b=TqkjhK38MR7EBmaTPtIMplxK15S2kBc1TepOR7S4gUg7MlDT3+6Tb9hq2YUCipaFqtl+
 kz5SGkFz1IVBmIQC8g3Y+05BWrZZg88fal0nlx6rHQk2K9/NMJwS1ZkhBhL8thnvfKIKp
 NbM++1JVBPhuv4ElZxUw15QiZPnLV2Fm3kc0WIxUJNAESv5fJAN3lw1DeWZtUaZkTfCqh
 kT7jPBo6P/ntLLeHfK/AZcfYAts8o7NCVmN2KMnXxF3vz6hGMb73I7zNG1OGdVj4xR/sd
 IwWakd2I1BjcEJXUOQHQuQE/uxpaZ66UcMab0Db+mimEMjCpPJX6HfadjTNSCGgGfIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=QoxcT51p; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=QoxcT51p
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13D6440653
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=a9
 xnQeCyTcebU91o7yc8y7cU7SF3uSkH153WqSaOMWU=; b=QoxcT51pH9aQruLx42
 tOsnjYmKy6IF/1/82sH1s98jhzE8ugJFH20Y3Z00ovE8MdBITe/upS/38swoHER6
 eUinM4Ha/Lz4M/Fx3/9txTyZHq+ypOOrBgeQ8XBWVj5H39B3eNQNOZx2SkZzIvwp
 SPC5QQVswv/iJadHmYza2Kb80=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3N95qXd9qrufGCw--.5946S2; 
 Mon, 26 Oct 2026 22:02:19 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/4] bootstd: Support scripts in raw partitions
Date: Mon, 26 Oct 2026 22:02:14 +0800
Message-ID: <cover.1793020986.git.hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3N95qXd9qrufGCw--.5946S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWkAr4xJw1UWF1xKF1xZrb_yoW5AFy3pa
 92ka98tw4kGF1fX3y3C3W8ZrW5AFs5GrWrXry7Xry5tr9rKF48tw1Sk34YyrW7tF9Yqa4Y
 v3Wvvry8G3Z8urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqQ6XUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8gwF12rfXWxkvAAA3w
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a script_raw bootmeth for U-Boot script images stored
at the start of a named partition, without a filesystem or a board-specific
bootcmd. It supports legacy scripts and FIT scripts with embedded data.
Image reads are bounded by the partition size and a configurable limit.

The raw and filesystem script bootmeths share the execution handler and
script parser. For known-size FIT scripts, the parser passes the buffer
size to fit_check_format() and rejects external data before verification.
The existing FIT_FULL_CHECK configuration controls full structural checks.

Changes since v2:
- Split the series into shared FIT validation, execution-handler export,
  the raw bootmeth, and sandbox tests.
- Drop the legacy parser bounds-check changes from this series.
- Move known-size FIT validation and external-data rejection into the
  shared script parser, with tests for both verify settings and source.
- Bind script_raw inside its C test, following bootflow_rauc(), so existing
  bootmeth lists and bootflow tests stay unchanged, including -G coverage.
- Label each expected C error with its corresponding Python case name.
- Reuse fs_helper.setup_image() with an sfdisk partition specification and
  generate the disk from test_ut_dm_init_bootstd(), avoiding sgdisk and a
  separate initialization test.
- Preserve the CONFIG_SANDBOX comment and clear verify on helper failure.

Validation on this revision:
- Sandbox build: make O=build-sandbox -j8
- Sandbox pytest: 3 passed (bootstd image initialization,
  image_fit_script_bounds and bootflow_script_raw)

Previous version:
https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg09207.html

He Yong (4):
  image: Bound FIT script checks by the image size
  bootstd: Export the script bootflow execution handler
  bootstd: Add a bootmeth for scripts in raw partitions
  test: bootstd: Cover scripts in raw partitions on sandbox

 MAINTAINERS                           |   1 +
 arch/sandbox/dts/test.dts             |   8 ++
 boot/Kconfig                          |  26 +++++
 boot/Makefile                         |   1 +
 boot/bootmeth_script.c                |   4 +-
 boot/bootmeth_script_raw.c            | 152 ++++++++++++++++++++++++++
 boot/image-board.c                    |  19 +++-
 configs/sandbox_defconfig             |   1 +
 doc/develop/bootstd/index.rst         |   1 +
 doc/develop/bootstd/script_raw.rst    |  51 +++++++++
 doc/device-tree-bindings/bootmeth.txt |   1 +
 include/bootmeth.h                    |  12 ++
 test/boot/bootflow.c                  |  81 ++++++++++++++
 test/boot/image.c                     | 118 ++++++++++++++++++++
 test/py/img/__init__.py               |   2 +
 test/py/img/script_raw.py             |  98 +++++++++++++++++
 test/py/tests/fs_helper.py            |  19 ++--
 test/py/tests/test_ut.py              |   3 +
 18 files changed, 588 insertions(+), 10 deletions(-)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py


base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
-- 
2.43.0

