Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CE60A3806
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TNmdVyQ9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F98405B1;
	Thu, 19 Nov 2026 12:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6GsgblqZYA8; Thu, 19 Nov 2026 12:39:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5358C4079D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795091986;
	b=MStkGNyA+MBVEnmv7HVkpWq6a8f3JEbl0XmgOgLaH2qUXuPS+uJuoeq06tzhcYh11XCp
	 HiLXMHKZw78C9ZKqNqbnyD2/+9HWwO1b07RY5I4NE/KD4wP9Rr+ZeYEG6BUlGaBHaaSPb
	 k8W4tnZPNmEg0XKLBJl+EKapGkcvDx3knXbhZZvoYE5SoPgamWyXkIWzu0K9vIbddhp+8
	 cauVehdTnH6qg/hBUhZt4ndG+2VO+df6hfQNZ3OcQgEVEzBoIA6bRxB6+6j2ZCnXop3Ww
	 sVQ2E8VQY8BQjWZhJzQ56AYFYFH9ZrGGfm3RUdOXx3eXDJIKIX5J3QmEvsKQZH2Zw6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795091986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B2mlqlqa/WAN8EobpQsI9s/++1CU+aJBvzQ/61bqBNo=;
	b=sPdNuBag+bax6JI4FB9UWkrQnlY8QUatS0xq//9d47Fe8q9RsjRK+LwYPDWHVMRVBbCU
	 HSVKCkdx4PEOgKyk8LHzlvNRVLmiRP6ABJ1h6kwbvlmXTUvkHafOvxNQ105JjxUeXyjuc
	 GUCqIWqIue2/2+kXpEoJS2YNqoEJbDNJotIPm5MMHfrj2VKNVt6T+o6y/puHaD29twnHf
	 69k/V05H1T4oPGmZ+gluK4Wm2JIkOzbHLY54taAz9fnrMYVGJutLw6hP7ylZ5WIH040oe
	 vIkPO2pG1/dRBzB7HF7j5B/CxR/Sp3EFAaVbMNyX381l/26elB+pOkpKVYcIOZFb1Tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795091986;
	bh=B2mlqlqa/WAN8EobpQsI9s/++1CU+aJBvzQ/61bqBNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNmdVyQ9yUF8lSXCKoV+Bv2JhqFkmGBSMUAo0z0KsbwXvuVuGbVJ7uvC+Qk0kZhK9
	 WYz2w/IfUwvbtF2R/zniPVglbt722ZhAyDuLbs3ZRST81DoDmQMnSAf9PIXmclTaJa
	 weHZt8aMSNZsUpKgp3XBqlHY+3ANtxuM34y+qMGaXk7clfJZVTBWpyOX1pu3PUwPPB
	 YobsKFpl2OF43OP5I/R7xgE9V969PQxuVJFQP71VKh2jpJBbSBVEkKJiKlioVVxb7R
	 PbVPERV9+KSXeyKGfPqOS/+MWZKdinQg1m4ImsrXpKY7o/NO2tHWlMs3BT1HnAgxeL
	 b5UPWntXqA8Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5358C4079D;
	Thu, 19 Nov 2026 12:39:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73291A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64E9C6069A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDwVH6fwLuhx for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3A4C6064F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=114.132.58.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=114.132.58.6;
 helo=bg1.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3A4C6064F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:39:38 +0000 (UTC)
X-QQ-mid: zesmtpgz6t1795091869t5348f6b1
X-QQ-Originating-IP: 3Cq9HICMTojnD4Vlv33/hNROPFG+Qrq/YUY0cZjGWAU=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 20:36:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2497436415492871703
EX-QQ-RecipientCnt: 12
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>, E Shattow <e@freeshell.de>
Subject: [PATCH v3 2/2] doc: riscv: Document SBI firmware inputs
Date: Thu, 19 Nov 2026 20:37:37 +0800
Message-ID: <F81AEFDFEB39EFDC+179509148315.3129810.13722784015329315775@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <AEF561F2E6C94301+179509169842.3130233.16129671820912856303@rustsbi.com>
References: <AEF561F2E6C94301+179509169842.3130233.16129671820912856303@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NpDnuZ1ZkWwzDU1bRazh1CjrIqltFJAlgvXvyYE704rsHO7m6uDcFnvc
 coeC3y7xqLmFsGt9QzfnPO5vcZypaJ3A3quFZcUKAkX/UHka0f0HfaVT40oOrqAJpOy358I
 AMNuh9bE+NsIcS2yotnhQNnSrZQUbTBoAzCJruLmQehYMvsERPFfEzpF6Q4t1pJfjK3Fb2o
 WOBC9OoLehwGXjkq3j/wYmsiIjck0rF39pEFrlTrGB7hmiAupBR4VqEWByaDID1F4JreWI1
 MfzBhrstOLCSfv/Yh/aoAS0PgFv6snmIuOWLFjT0RBx8RNHavs1yEJ7Qgm3KY/vc91+5KbU
 7F6DqoT+emUVc3xcc6vm4Zy8S4qTe9YCSHnLNqx/UB0kyRQtHLg6FSgYCPpp3krjEzmJUPQ
 5Vufx2ciBrq9cFxxAfaDHt4TfCF7WAAmATC52DeXUsp8IBfZAQvnbz8XSLNpHKR1SURXcgm
 xsLRDCFgcaBZynZ34Crax8tvy2n7wRhAIYoFmlEngtjDx3lFODxAFyWoyo0kLktZFj89IJq
 mVp/D8bsSYAUwwxhua+7GFhtcKiPPbvr53OmKZSQP46loVyQPpOe2x/s30JexfUyX59PYfG
 mKmnYeNR9ihbIzFcq9DbNcCtTuQO+F38s43o6pMasQyfB+7cUVHas2H8j+Wx0CasWIDk8PO
 h+DMrCABUD2GikpFLX76Onlw1MafnkkgyH4Hcw9Sm4Pw0zZ5Mh5NT9ug6PMdIwSoSyeR9J5
 DF8mLPorE5u6oFzyDPdL590ccJQ+3YHmcEMnmkupHCe9hfHsfXPXMVUS9g9WPPU3jL3+zti
 tRYeDFtCAp46Vn/v4sJLWYDqP4FUckItUNNJndcGphfMAep07AX8GD/kWeH6WN69+R3tt+R
 yTkdQTstqnlNiUUI/viFycDUb0eZERvaBfzK96UvCTRteHA7OlyLZfM9ONic1vZ7wTTrx5J
 qBJSJXJlEFCEl4zSJv4qizQ21PbM+8CKWooU4XVk+qgcoRykBjqa5LvnzzmA4F9MYhuy/zZ
 ondKBrPqWQ0dnxPv5OJ56iPpdTLPMpzyrqkgc3zpBHFM8EOE5LRD4AWhssEneEPX+nx9NTY
 EDnH7m7eGySHaRDEJKmwVo=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document how board builds can supply external SBI firmware using
OPENSBI. Explain the FW_DYNAMIC handoff used by SPL and show how
to build U-Boot with a RustSBI dynamic firmware binary.

Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
Changes in v3:
- Use OPENSBI= for both OpenSBI and RustSBI.
- Link to the firmware instructions and scope the load address
  requirement to firmware that requires a fixed link address.
- Explain how SPL passes scratch options to the firmware.

 doc/arch/riscv.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/arch/riscv.rst b/doc/arch/riscv.rst
index af0c48b8982..4064d34ce31 100644
--- a/doc/arch/riscv.rst
+++ b/doc/arch/riscv.rst
@@ -72,6 +72,26 @@ To examine the boot process with the QEMU virt machine, you can follow the
 steps in the "Running U-Boot SPL" section of the following document:
 :doc:`../board/emulation/qemu-riscv`.
 
+SBI firmware
+------------
+
+Set ``OPENSBI`` to the path to the SBI firmware binary when building an
+image that packages external SBI firmware. With ``CONFIG_SPL_OPENSBI``,
+SPL starts the firmware using the ``FW_DYNAMIC`` handoff.
+
+* `OpenSBI <https://github.com/riscv-software-src/opensbi>`_
+* `RustSBI <https://github.com/rustsbi/rustsbi/>`_
+
+To build with RustSBI dynamic firmware, use::
+
+    make OPENSBI=/path/to/rustsbi-prototyper-dynamic.bin
+
+For firmware that requires a fixed link address, use the firmware load
+address configured for the board.
+
+SPL passes ``CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS`` in the ``FW_DYNAMIC``
+handoff. The print flags described in the Kconfig help apply to OpenSBI.
+
 Toolchain
 ---------
 
-- 
2.53.0.windows.2
