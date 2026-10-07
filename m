Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F50CA600B
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08F1460871;
	Wed,  7 Oct 2026 19:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iDplTP9EuPX7; Wed,  7 Oct 2026 19:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A7706080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791401978;
	b=AqlW3DXi9jCuNvo+GbeMrhVcXS3CvOPW2Lx7+6scJ6nUKyuB8bxCfQ5mkULIVWjp0An6
	 v+QvxfcFPmWYJy4Tr0MxorOvfaAIV9v40c2cLLWf71Ld5X6IizhKVm5dLhW5M81olyHSM
	 I6uIv0Bj9TiR5dl7E4+zTQUXRcMxu3f7Kle6ET8+bGLSpFgbv9SHQfKBAIikUCzgSwKj1
	 z5Uy0Q2nYtZiGwL0U4B++nalXuQmhiKOJMtA7MPuSQi1s7R0z3Iu+syKTdh0cE4BNX4t8
	 G7P/vIAWLsD/8F20srdNiIAl4Oloff+6AqYxU7v1iEkJqHJHp3AjLytbhsoUGL0wQ/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791401978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J/w9bTEcV95Dyqscer9GGkqFjy8MA1M3U3wI2thi0Q8=;
	b=H4YjK5WvE4a8mISI5smlDz8K0rWKphpQ5r9+OK8RV9nQ3bicRqcsxJ9JAOqmJQoVbDg7
	 WJrXZuqU7seaSUORjh5yKnJQm24d9uXuCNLWZsPTltHoj+0KEGq6NAKk1PnA2JyPOwk2o
	 XGNnvlRqJvjJFcyakHmMlk7bNz2fnEgzojkLCmTETvIuu6+8WUDaXPcslKJOORlpdkzTy
	 2WQW6J/C1sU60XlOXGMEz16RBSyt94HnGmsAqQSqJNj3+eCAcbNoiR8MuiKXPwvNrIJyD
	 8qUDcjygv8OwIs6pq6bUhj+sX9yPyZaRsqsWU9YwqehgIZb0gJmFf1EMCRi2eXoAvqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791401978;
	bh=J/w9bTEcV95Dyqscer9GGkqFjy8MA1M3U3wI2thi0Q8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tyY0WkFdWG0cWZiEUN+lHm/FJyNHVZiIksxDZHef1njYhiaakq+IL/hQlk2NO+Lqd
	 zXPoHuAu2sU2JWY3LNzhEV9XAHNZ4QO9lM3JHy+d8oNdLqk6Iovl5I0aFYVx/cnhK+
	 eMeBZb4mdD5oFeRTFvxaXVBlTJUFqsUzMzedQbpe2XRFEXKxdGYS+ZsLssb4cAK7ki
	 yTjZ+Ah21yBUQcqDpUWL/YacNswDv9DYcvAIX/fxhF7xDZccZUZ1ev41TAcdM5dVaj
	 uk7m+FPv3ztY4aWVrMh3br4YJMLmTsV76n+veC+4/ZDdaUq+YsInNAyUs9uh8ShLf7
	 lK1MJBMJkGYYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A7706080C;
	Wed,  7 Oct 2026 19:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39D3D75
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20398810EC
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gv4kiTi_kblk for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DA3C0810D5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791400155;
 b=b2pDD12qnloqO7dyHGJ8Hp7o/MuI+FyUtTIZZ/L6pzARzVSjE+dGFiSva3UXNF47lI+g
 SG8H125cnyzH8+84N6Yiv7sIzOJfqq074dMvE2BhqJzB0Psr7BZEN44IInnEEhQHQv3ZO
 aJvYDwL24yaHLb/NrzDrIoKwAzwqutoIwwYx0kuH4Dpp33YdtXC38UpfgDOQqCjkTpzHT
 fzEsid6qLuRIVDq7E+cjMTjnGBpzeDpff1BWIdxfbI0gPecdx/7AlgBvpCe7ft+HWuN3g
 cpnTW5Cd9fZHzK7FrOlsYBsYh9yFww399BoLWcruhZCt2KtlxTDDvx1fuEFTPGAJGJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791400155;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=J/w9bTEcV95Dyqscer9GGkqFjy8MA1M3U3wI2thi0Q8=;
 b=p0MKAqUVqwK6bU7Ogp9r4Vhe3gkLQKKUAhSd2ltN8srMmPRQ8gmzDl+48hsU/veo3iaQ
 QgrbG2DTeguZkb9Sqszc5KM3FV9PbdILSyLNQ8N4Pajz4791ueFXqG+JY4PhSCla4Upd3
 X+h+wMzlp/XMYaIGaPpQLYrLbVq9noJiNtu7Fo0sesl6gjvkSmSRaEnf80wg3kL7t74V5
 4pzlLNmJdA3DsV+odty/1jHsYJTlgioyuUoxK2r5CCnQfGLWiFnfJyUFMBNKEKnGRdYMS
 +GNofbfwrsXC1WHbMXOFGcEY/QH2/mL5lXYiGDbeLJ1vvaXePM9SdxWJAH5QLpOSOqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=WOiwfPwH; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=WOiwfPwH
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA3C0810D5
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:09:12 +0000 (UTC)
Received: from LT03.fritz.box (ip-084-119-040-110.um24.pools.vodafone-ip.de
 [84.119.40.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E6013F02B; 
 Wed,  7 Oct 2026 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791400150;
 bh=J/w9bTEcV95Dyqscer9GGkqFjy8MA1M3U3wI2thi0Q8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=WOiwfPwHqn6Ne5jByKfrxAHo7fzkIi4OHYTLfHBtBOLPvIDONkHPcLYE4v6RwCC44
 piGZKnr+KF9Bw94I38aBoW5TUZVorzO0hqJ6c9eha/sW2hhVWp2MziJ5isR0ij0hBd
 l3aJJqScgfYSmsavTn32TuF7ZIIiPZ0GpVYQxPkpTtveqGfyLtJjPjQdO3xv5FvbXh
 VYhu+z3onx2Y44Gguk9xqOACJ/CUAi/yrY8lOT6un7nuAo/4jyvdSFXHFEZStggCRJ
 nF0hMm6yMQ04S4sn0ojTbcc5W2z4ed00pD872wR//ESpZCRLBlgwHPK9LF930VBSDV
 3K3jsK0miS7O2lfhiwOCshHpuf4m8ov2B2U2GOmt+LTgI7xa/x1dDmZpD7bC+wCLiK
 BwcXEvBp59tlklVHW5wKu894BO+MjCvVxWriAcW/5Ucxx82iCCGtDwVaR49OkAyFBT
 Fqw74vuzRcgQMoODXkxsjHV0eAobM2xmP5vXwvk+vDqZA+cnlQB+bOFv7XlxrzWbrX
 HGHE1T6F77psgABWwRoOBsuqHtRbJAjzwo7Haort0btvw4Wf/twbUVV3yQCqkeRqLj
 +KKe8xSO8aRpJD7Ag+aTR720P7r1drwptlKfscZAWsXkjm8v8A0jK8uDNgJ3RWPhCp
 HR8ceJ32zOPJDQvkEIVqnksw=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
Date: Wed,  7 Oct 2026 21:09:02 +0200
Message-ID: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently we only support reset but not poweroff on x86 QEMU.

* Provide a new sysreset driver for qemu-x86 and qemu-x86_64.
* Add nodes for it to the qemu-x86_i440fx and qemu-x86_q35 device-trees.
* Use the driver by default.

Heinrich Schuchardt (3):
  sysreset: provide sysreset driver for qemu-x86(_64)
  x86: add qemu power controller to device-trees
  x86: use x86 QEMU sysreset driver by default

 arch/Kconfig                         |   2 +-
 arch/x86/dts/qemu-x86_i440fx.dts     |   3 +
 arch/x86/dts/qemu-x86_q35.dts        |   4 +
 board/emulation/qemu-x86/Kconfig     |   3 +
 drivers/sysreset/Kconfig             |   8 ++
 drivers/sysreset/Makefile            |   1 +
 drivers/sysreset/sysreset_qemu_x86.c | 155 +++++++++++++++++++++++++++
 7 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 drivers/sysreset/sysreset_qemu_x86.c

-- 
2.53.0

