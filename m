Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D51606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rIojYCnJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r7VF8UXg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C61E181029;
	Wed, 21 Oct 2026 11:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWwWK0C_35xl; Wed, 21 Oct 2026 11:07:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01F3E81004
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580835;
	b=TENzk9zRqdjK1DNN3//qU1qxTs7j/RK3RGMgONVCMrS2dns/RSt/0LF8ql2Cxx+X3QCF
	 A8hkerzpmWImd7eM3pVPTsWCYNxmDdTxZmSPivCD8OwDR8FUXO13K17z7zpYiGxBC4L+S
	 fHkbVZmTTJykAv2ybfR70SgRRdZR7nfxA9PKSEBjtMdOHy2grJb4Dor8DIh46ayHsNu3r
	 SwcaLlrMCyYZ+VVFotLRqEo+VsFXkAPoq2oHv9mBqlMKZXfRM4mboOvniZn8QQrlBSCcm
	 rVnZ13x43GG3N2rr+F1cLi5g1m1fIqF1BFWmHXyD1Oiy+NeoF1gHQ2eB59M2G/aDKkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580835;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sAuWhIt8Kql8Cg4PgukeblLe6vpRqnr53lNmXvMWBlA=;
	b=LxN5Vgzjk5gQAXYHLFuWly+yIUpIT580fyshHOrbbvD0f0IF2K1OB5SeWvilOARyunal
	 zh6Gl3YRJBH3Yv1ZOk7dMuJLBbr4AiT51ZT7lY99M0RC9WWYG93R3Km5O3KknHdm/3XJ8
	 wqofWttb+W5Jeu122MnZyavv5Ph3Sz8Fo2XbN5mCKeqtExnD9TprjXJoOvF9bFkwu+ebW
	 6jO9CcnMb0TbCiNJOpwNiocUcOX+3dh782hjoL1kNtpaNi/5jGERBB5FGjW5LJUBqPig+
	 Jt+teMp7k7TJRrCU1VMJuD24gOO82mI4SYK8VDNyr1n8uSgk50xTJPwrataE8gOx23g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580835;
	bh=sAuWhIt8Kql8Cg4PgukeblLe6vpRqnr53lNmXvMWBlA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rIojYCnJpstCNJNVe1gLNmwKLxaQoO7fgGHtkC2f7yJNcmTqlRoLNCNNXO8VGxp0V
	 eBVr4da+Ki6TnhY5NDLVgx2eTW1sgFG/teQfeSqdKqQ1X4PEvmsNs1T/MhE3bWqP4Q
	 WILnoAzvFtIXFuN4Fg+DctGCB3+iwawBAF6eNprZto6ww6KrYQLi3KguEm+LlYDm2q
	 4QANsMNDbYmn6rUVrTAJBbwks+/P/u1qIPreWtI8h3ANTOalHZwTV9JQdb0h+bvACH
	 EWrVGpYXr7lyggCRQ/Ejfm+f61s9DCSj+FvoA614O+DfjBsmzGMbmsjAEJNpGiCHmh
	 OtduzsKQaShRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01F3E81004;
	Wed, 21 Oct 2026 11:07:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ABA4380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40CA3606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbUXHPcPN0oq for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 708626068B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580832;
 b=LlKAnzOQgw0zGpbQrzYLYG0PdYCGJRImBz2LFqCoHWKRrFVsxvrpUXKwO4FYfQo+rpgu
 NgKvQl7okyrvImQmJ1FfJmddkBOp70WiMswnVGnocdzswi6L/EOeH0/uutw1uenroOycQ
 VPJih52h7TA6ZkWVDV99bljny+BOhzKD8eshL6zVjJuN8p+XpIw3Xe3NKA5ckqckA0VeX
 LUf+dVFE0mOY2sX9bmJi8ae7rxBDDkDZfTBJyZjjDbWZeJAfH8eym78GJm4ck8VFk/p53
 NCzGdNlvVHJRB16MGxcxXk1NdksCnegVXUvuy5/cadcOs14TXZZ8Q4nAJsc0ymcPpBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580832;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=sAuWhIt8Kql8Cg4PgukeblLe6vpRqnr53lNmXvMWBlA=;
 b=KOkzSkZ6tb5xrT1PXoPPonbFl2qCcni857LJD8qh1cX3SxWmGHHWz533KBDFnO5Ychyw
 jgXeUISW8C/Jv77OPNzi/D2anNZUmSrwIXQgJKuiZhfjFMVd6+aYGfKihF02ljadRKcGZ
 4Chz4Qj4y6sh9CwZxmXtgEzWblgvgW5QK51Xce6jy4gkOBILbhPMKZGMezkUNjyfrp2QF
 80m3CkC3oCot5kHeTDdIMZoK808UkYyRgebGscPC9hqpp04ma2s8Ow9zbvMW5zcj2tUm8
 iMBlAiCKEdhzORn9f9AnRD6TrHNhl/4FMqSzqvyTLVwwChgGP3+dOKbBcqyF0moPgAw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r7VF8UXg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r7VF8UXg
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 708626068B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:11 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so487459a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580831; x=1793185631;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sAuWhIt8Kql8Cg4PgukeblLe6vpRqnr53lNmXvMWBlA=;
 b=r7VF8UXghKfsZeZ3sC9l8m0aa0dG7wibbJNYYdYmTC5p0jObXJRUkxEZBX8ZGWWcBB
 M21Evck6bjdFPGl4UhzE/U1UPeQ5nFc/mfIZvsHZRf7E/xGmkvU400MKb3V7pkTpxKW8
 Tfgo2JqY5aHXXfBtIYCkGqbbpqzq4YisamXESnP2PbSKL8NDjzKTcBXhPWTrtP/f3cYi
 zQ++yq1dgkgY3X6YKT4rtmCsopQ4eF0dDs8g/WN+lCR1Bu+mF3BTP0X37gnS342ye1mR
 qUIGyjbvE+ERShhyxxrkKRTqxPMR9wzRG3QFr/N9AX0WzYkV2fdOBgREjjLDXy+5F3Q2
 aqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580831; x=1793185631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sAuWhIt8Kql8Cg4PgukeblLe6vpRqnr53lNmXvMWBlA=;
 b=TiF5rd2dk6/MJC/quVdTyHMlyx94RgisNleN8Xix7CF/5tmoUvJ/3lVyQEP/0xuPM9
 aVCOVMuKZWqhLZDVBMoYCCwNf6aI6DNYKCmdKw6uOcbqwxgIXhsjSwo2jpBqAk20XfpC
 BUgQg0tdhBeFj429z1wbmly+sodRdpvDY5yeDonSv+lUOW2nVY/THyetAGOCg6zUvllV
 N9NO2pWFp8VNTmCs/iL6Msj1oMBiLeduCUf3JPMEzn0E7IZ+hsqdcl9Rz3HpjqhaReEa
 cYvWGAClKo3lquFqsYQgUu2NGtV+Lr2M0xxa+R8CtnIa+u0MFOb6+jrYdZ2BHz/QejPI
 2P/A==
X-Gm-Message-State: AFq9FYINZlUWM7Jkj1eJnMul5VWrIehDIPnoZScsicF1ZCAI3Fmlx4Lp
 YSWRujhEC45NtS+/sFUaIiBIoHRxCnh7NG0yhOL6yGWDh7g6VE9gFz1JpQhwmY6958Y=
X-Gm-Gg: AYBFou2TqKRPnUXKACIqIUR4qk0gmg2ZE5XCOC/DpL2+TqLu/oBWAtLmDQC2ezozylO
 tgmiFl3WRgx9x/h2c6Uj+aqq3hJK6VBl46chuIIlBJ31DBbaWq/SjEhfaVjfqElbA4PxIG8V9aj
 tpX0wBq4p8A0VgGKXgx3LKzfLRXG6Uk+0fmYrN/4EKAwAvqrc0I09+rQOWDjf4O+IDRmCrPk5cw
 fhW9IZFZAX5xUBcvGErFgEsM5OfX6ixfRQCvVlufqnZ8CUJ4PzKwAHgWopVj3yiyrJV6ENgg2rw
 tBnHtUKPI4oJqAGo5KytXiHYEvJ24Z+rX1eXzzdZiawjr1ruovlITt3F99C7P6YJPj49YMe52rw
 THzAhrsjj/BvOReiowIhzEIpEcfLBJiFEtnIJjPw5oBAvKHWmgRl1QMgqXKJgDEiXcV+NVtuvA3
 Mjj8n+AnvF4ev8UNPNV7q5M7FnTvSH6YI/0KWpTVCqvo3MYfXGmoAizpAUOm5KWqPEd4SxTuQGb
 +r27M5rCMWBRWOfE6tTlakkAk4jJENP9BZgTpmL36WJlSHEuKoJFscMIYHciuCUjKyxXhudvJ+1
 rhhNxZZYvtAdISWDEmJhOUFQbhPnAArmOYO0s/ozI0W4N5WywBqgilIuD9wUf/EkfuZiJx3zI67
 BAtlN8D416/6N/QgQERkzS63pDUHGJ/T75VY=
X-Received: by 2002:a17:90b:3848:b0:3ab:188b:c5be with SMTP id
 98e67ed59e1d1-3ad87084014mr1508216a91.45.1792580830569; 
 Wed, 21 Oct 2026 04:07:10 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:10 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v4 0/5] virtio: Add a virtio RTC driver
Date: Wed, 21 Oct 2026 19:07:01 +0800
Message-ID: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU v11.1.0 added a virtio RTC device (virtio-rtc-pci and
virtio-rtc-device), but U-Boot has no driver for it. This series adds
one, so that "date" and anything else using dm_rtc_get() work on any
virtio-capable QEMU target.

Patch 1 adds the driver, patch 2 updates the virtio documentation and
patch 3 adds a MAINTAINERS entry. Patch 4 lets sandbox tests answer
virtqueue requests as the device would, which patch 5 uses to test the
driver.

v4 only trims the commit message and a comment of patch 1, following
Kuan-Wei's review. The code is otherwise unchanged from v3.

Tested with qemu-riscv64_smode_defconfig and RTC_GOLDFISH disabled, on
QEMU v11.1.2, which reports a UTC clock, and on QEMU master, which
reports a smeared UTC clock:

- With -device virtio-rtc-pci and with -device virtio-rtc-device,
  "date" reads the host time and advances between reads.
- Setting the time fails, as the clocks are read-only.
- With no virtio RTC device, "date" fails cleanly with err=-19.

On sandbox, "ut dm virtio_rtc*" passes.

Hung-Chun Tseng (5):
  virtio: rtc: Add virtio RTC driver
  doc: virtio: List the supported device types
  MAINTAINERS: Add entry for virtio RTC
  virtio: sandbox: Let tests emulate the device side of a virtqueue
  test: dm: Add tests for the virtio RTC driver

 MAINTAINERS                         |   6 +
 arch/sandbox/dts/test.dts           |   5 +
 arch/sandbox/include/asm/test.h     |  25 +++
 doc/develop/driver-model/virtio.rst |  10 +-
 drivers/virtio/Kconfig              |  11 +
 drivers/virtio/Makefile             |   1 +
 drivers/virtio/virtio-uclass.c      |   1 +
 drivers/virtio/virtio_rtc.c         | 244 ++++++++++++++++++++++
 drivers/virtio/virtio_sandbox.c     |  15 ++
 include/virtio.h                    |   4 +-
 test/dm/Makefile                    |   1 +
 test/dm/virtio_rtc.c                | 306 ++++++++++++++++++++++++++++
 12 files changed, 627 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc.c
 create mode 100644 test/dm/virtio_rtc.c


base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
-- 
2.43.0

