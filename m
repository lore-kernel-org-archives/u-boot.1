Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBA606A330
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nmMA03Iy;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CZ1zh/1p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FDC8406C5;
	Sat,  7 Nov 2026 16:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjq9YX1oKFEC; Sat,  7 Nov 2026 16:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7ABD7405E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067632;
	b=NhfKgy4wDrlZj8jL323ECQfbFVSZPtB++QB0OW/dXhLH4pLCJcrmTnPyK3zvOREMtm8c
	 jtCbRRpuNDCGDGiZb/z5AcA1vkT0Zl6iMcjx0pNjN8pvBBGIzdY6ooYwMjttt1KWAufXs
	 ZcpyvzUUanWjBV1ffP9a77H2gG/GreDx1+Q8XypKHlWXkOWW/YV+Rr4kSDInSRZ5rXLEN
	 G2ed9Y/ixZ0R4QXJbT6DXqVlSvP1Oq4BldjUQDJt2hK8vxSyVAQs4eIuZkPN5PS2ONctz
	 qoC+yNQatZ0ZQoTR5HrTdrbmaRnKv0fNxus++shE6c8iLabQE3VmzfpCx8t3nUuTgFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9RuNS2QwetDmWulne5o8hkBxRoU0vMaCznXKw6b9NFU=;
	b=QxFOEiJLzss6Za47uewSJO1mQRWXE5+Oi1qLPqVHhQyC92to2xuS7jRFkE/dyP5NrtTR
	 F+xg98eAhKftNS4SDYfhZMTsq9rERHpBTx5W2mZAzqgb7/K7npJmr+fqSp7dhTVf7Nw+i
	 b6kX8RaXA57qlJZzFqoi0xnRSOAns/vuFEv1I+orPaMOEObcdzXwdd6YGqTAGIjSXIfu/
	 1ZF/9kcCDe0FLs90OEegxw+bL6OpLHgjvM/LOG9EUHGCQfdh/LwndJqUrBOlu46Ctr4mk
	 mXiEE3/dDuuoKZhBfmYEUL6Ao9rlXwvjI5brBXX9LIsg3RjZhBzAmUClsRvT/vU3SZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794067632;
	bh=9RuNS2QwetDmWulne5o8hkBxRoU0vMaCznXKw6b9NFU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nmMA03Iy76KmfB+7/8dxe7nOAJFuby6xxpZudJey7i3XBgOfC7LZrliOI3XF3dREQ
	 fOsY4zSfptF/yOWjGBKSYbvd3ZsjmEehxw4uUjIardshdqyzGTGfN8M5U9JSrYn0RB
	 L0lS4cu1Ju9tXDsyaemVXV7SmB0fIzJZZBdeOTPp+2h/aWV57CwA69qM3QwLrRtfvL
	 kt8xcLGZ5Mccmo4LoZV6HVf9E0Q4QNLkL5LX/eLteAH0+eIk58BAfmYT6RFLKgvM03
	 Qz1Cz5OKD3D8z2cSVa+xEIu83pTKKIiCCR6cPAsxb9uexKybrSwAn5NY8eVAq8B+r1
	 jFtWmNm4+4eSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ABD7405E7;
	Sat,  7 Nov 2026 16:07:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BE7737D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D3A981314
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwQhGXPdEA9A for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF3318130A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=CZ1zh/1p
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF3318130A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9R
 uNS2QwetDmWulne5o8hkBxRoU0vMaCznXKw6b9NFU=; b=CZ1zh/1pj3u5n8nHHk
 AErwBib71GXfZ34UZwaLSqURMpCRn1IoNvibGvt6Kv9RpIm4IoLBwuwK1852oXj5
 +ZkRdPZla0soKoXxSLzQis6uk+RKjCld+OouG7gUhfjhZ7ByMHrGMdVa5p3Wl/Sp
 BbHCPOpSCjFMs9j+GOIGAuG5g=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3FCH3S+9q+f2SFw--.1483S2; 
 Sun, 08 Nov 2026 00:04:08 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v4 0/5] bootstd: Support boot scripts in raw partitions
Date: Sun,  8 Nov 2026 00:04:01 +0800
Message-ID: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FCH3S+9q+f2SFw--.1483S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW7uw45KF45KFyrKFyDJrb_yoW5XFyUp3
 95Kan8tw1kJF1fZ3yfG3W8ZrWfCF4kGr45Wr17J3yayryqgFyvyr1Skw1ay347ZFZ5XF15
 Z3WDZry8GFn8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jog4fUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8RinemrvS-goyQAA3j
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Sorry for the delay in sending v4. Other matters kept me occupied and
delayed this submission.

This series adds a script_raw bootmeth for U-Boot script images stored
in named raw partitions, without a filesystem or a board-specific
bootcmd. It supports legacy scripts and self-contained FIT scripts,
reusing the shared script parser and bootflow execution handler.

The series also bounds known-size FIT script validation by the supplied
buffer size. It adds sandbox coverage for valid scripts, malformed images
and unsupported images, along with a helper for creating test disks with
named GPT partitions.

In patch 1, I have addressed Simon's review comments by replacing the
blanket rejection of external FIT data with bounds checks against the
known buffer size. This preserves support for filesystem FIT scripts
with external data contained within the loaded file. I have also added
an explicit check that fdt_totalsize() fits within the buffer, even when
FIT_FULL_CHECK is disabled.

More generally, I would like to propose removing the FIT_FULL_CHECK
configuration option and always performing full FIT structural
validation, regardless of whether FIT signatures are used. Structural
validation should be required for all FIT images, independently of
signature verification. Would this make sense as a follow-up change?

Thank you all for your time and review, and for the feedback on the
earlier revisions.

Best regards,
He Yong

He Yong (5):
  image: Bound FIT script checks by the image size
  bootstd: Export the script bootflow execution handler
  bootstd: Add a bootmeth for scripts in raw partitions
  test: py: Allow custom partition specs in setup_image()
  test: bootstd: Cover scripts in raw partitions on sandbox

 MAINTAINERS                           |   1 +
 arch/sandbox/dts/test.dts             |   8 ++
 boot/Kconfig                          |  26 +++++
 boot/Makefile                         |   1 +
 boot/bootmeth_script.c                |   4 +-
 boot/bootmeth_script_raw.c            | 152 ++++++++++++++++++++++++++
 boot/image-board.c                    |  57 +++++++++-
 configs/sandbox_defconfig             |   1 +
 doc/develop/bootstd/index.rst         |   1 +
 doc/develop/bootstd/script_raw.rst    |  51 +++++++++
 doc/device-tree-bindings/bootmeth.txt |   1 +
 include/bootmeth.h                    |  12 ++
 test/boot/bootflow.c                  |  98 +++++++++++++++++
 test/boot/image.c                     | 118 ++++++++++++++++++++
 test/py/img/__init__.py               |   2 +
 test/py/img/script_raw.py             | 101 +++++++++++++++++
 test/py/tests/fs_helper.py            |  19 ++--
 test/py/tests/test_ut.py              |   3 +
 18 files changed, 646 insertions(+), 10 deletions(-)
 create mode 100644 boot/bootmeth_script_raw.c
 create mode 100644 doc/develop/bootstd/script_raw.rst
 create mode 100644 test/py/img/__init__.py
 create mode 100644 test/py/img/script_raw.py

-- 
2.43.0

