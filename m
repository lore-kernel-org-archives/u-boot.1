Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF92C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF51440C8C;
	Fri, 11 Sep 2026 10:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aeauBOLXs3pm; Fri, 11 Sep 2026 10:49:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F95240BE8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123740;
	b=BQXRWXsbumhDK3SONoE1hHehTP3+dMWTtkGOLqGb6tJJf/i3A+KsSxc1lFISv08r0zfc
	 upDqsVadrTqNxVFACd2UZsrhNepDF12CYJMXwSAmvm219qJpnPEZIafF8Bd1QGKepfL1/
	 oMXrBs5IDGNMkqyQl5PzSSUtcXVmrtOuAv8D+uj8QzWEXPWsYooOLMbOQgux80YfUK1ij
	 EvrDBR3guSzQsDwXPiBfVEKONy7APR95ihGwHcr3M8F/LBv3yX2RI7rXedQzbZXe9fcH/
	 t9TL8pr7rwc5nINdxmBwgymMyLaYv/ezw19gMS2xwge8VTyqpwGO6Ya2gsGSEXAd9ZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q6EuFtJr9TqGYnHGZzpImL2fZ84ofhxCcRAZicbNz4o=;
	b=G8fgQOghkP7Pvk54ArTZYakTb7/zfsAfg5fYtKbFOYCd4EHKJZNjAGMdEaxZEZc12ln+
	 I86PjX81zPeirUvQkEK8ttwQg+COug7LtLWnXA4uYckviDPJcykW9XB6sstehVw9jelxq
	 5c0V8ghTQBOrJER6xQ0H4vcK0Lp+iEBSCqEfDdHd83vNZX1F7K8mldfZ3pcup2YQ1isBz
	 txybTZfMLGMyZNSoD1V6HmMc4dl8PMkqzEZ8Gw895UK3d0HvSZRGZhNTNSqSA1gRj64Jn
	 l++hzIL02yC3BGhOBe7RayJeX2IG2AW7/e+CKmhqKSFMTpUOLaBxwyXf3sMSz6VAUAg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123740;
	bh=q6EuFtJr9TqGYnHGZzpImL2fZ84ofhxCcRAZicbNz4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EsndjqBQIDlKn/5Oe+Nv9M/c33RMjh6pmPVp/jMrjrootP6PGC3sP0eTaPZYhrZnI
	 adCjlDZ+6FFF1BEwT6TljWhn654Tqk7avl3v6sm+kph2V4j9DmjRQ1bvtoXR1ZDIqx
	 Qjny3npuO25aEH8ZrgTgF+wetn0dY/6BeG8b/mLYLQ194cXw94a45kkqj2o4oEgw9n
	 nw8CG+ndp1C6L1rJzgCMKXhIBttYAJKDbcOt8ezHR9NgQGtu6DCJnQNpgnaTtt4s2C
	 p46HNg66ZqLZrIjPusUkXoaYczh0KDH3cHZ4NyZZa1Wk773UpEjgMnPyVOfSQGqLY5
	 QcwgddUKP2qOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F95240BE8;
	Fri, 11 Sep 2026 10:49:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B6C914C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1106C812E1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nV4E6nRPVUbc for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A868F812D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123736;
 b=KfeuJMhwV/aNZpINjEQPcmyFWwVFZrO3kJBqB8w4RU71U0JuhKiEzKGwEE4NL5n8ka61
 A5F8Np+HSOCMVPBVD5EfnQXHh0nOX+zlcW4/mDVp/JMYnt1klTPBqlpt+470Etwu6qJwv
 8FC80clfj6GfLO0H3VCaPmDUgbKf48qhHZbcDWQbkpFjvWpV3QEki/yLCFF8BzpBG31E0
 0E5S9JPFF83aBqBDcFzaBwLkWx9Au4YU8xIiz5vagzTcSYFBb5VKJoMrILcKJKnXh7nfj
 m7z5AepSTYGOI6aTEuR8rvLPWZZOxGIlC74GjbwPc0bqs8EExzLeOLpVmk7UlP53Kag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123736;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=q6EuFtJr9TqGYnHGZzpImL2fZ84ofhxCcRAZicbNz4o=;
 b=LGJAYgOl71wqDUiFBZBrFyEX2xcZfNjYtxWi6Vmil4qgCpw3J1ulyQHXCddtUQbfiTgj
 07+u0oGvZCeEA1TMpmd2jpZvvfdE5Ypo1Sw2Qn/K9kDv+So4xytZMyKPdhRCR1T1Bngil
 DqNZwdm6Vw/hKkJjzp8a3vGCJGQwp1otYI1IrRKbMqcec3y8vpQGmjq42TgeITOBPCtyu
 yq/TfDGM+R2D9zlc12F5IwyywH0mQk97jkK6yB7auSv2OePn4vhuhaxscO4GjzeGxa30T
 OyE7goMInJe4D+NY70WjOAOn1Dcy+5yUPBD0lVsGFwfQhfBZb9TwXLOl9uhZEJdzrLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=L3hLNvVq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=L3hLNvVq
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A868F812D8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123730; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ce0Zz9eaJyIzTQiyd6H3wICdSsdLJoipItrocNYpTh71mGahXkXYgEB5nxAtrD+Ff0CmZHBPl+ylYD5Dn6yR9PbfNtw+uzhmlJYA4zozOP97eOXkvsYDeAnRHbi3fkioKL1LgFhrfNsNsnaLVuMYF5DZp5GFBfGbdS5pdPFnI9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123730;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q6EuFtJr9TqGYnHGZzpImL2fZ84ofhxCcRAZicbNz4o=; 
 b=TBbUGsLAfKfMo4v56JYm4+wAUuG/oWZXM6Yq5tFscoxWY215WOLftZ5Mm5BbtzqZOVoChz7bRTAAdDqKZG1lgu3yhZ9NhPSXwtgfynrZg/tziGsB6NuNAD9/KERjVii4cZhJp7PdvIFHof8smbCWRQtH4+xUryjKwEFJRmGEks4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123730; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=q6EuFtJr9TqGYnHGZzpImL2fZ84ofhxCcRAZicbNz4o=;
 b=L3hLNvVqeTeQOKC7ya7RDI7m7n+fb4z5kD5yRLcV0tTDV7DVTE7IAnWtXYD4W/2N
 nHFxYBDhsYki7MBLm7CZmJQ/vk4wFaO3phBLCB12gZTM9ahkJxWphHWQUfO2h/j40E2
 ORaZnscsGXuZ+BNAJN6tNS4VykztxqINqxmyC4PQ=
Received: by mx.zohomail.com with SMTPS id 1789123729641251.5828987265221;
 Fri, 11 Sep 2026 03:48:49 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 17/19] doc: arch: Add documentation for LoongArch
Date: Fri, 11 Sep 2026 10:46:02 +0000
Message-ID: <20260911104604.2910944-18-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Add a brief introduction to LoongArch architecture, some notes on the
implementation, and the toolchain supporting status.

Signed-off-by: Yao Zi <me@ziyao.cc>
---

New patch, no changes since v3

 doc/arch/index.rst     |  1 +
 doc/arch/loongarch.rst | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 doc/arch/loongarch.rst

diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 60c93b3b6640..10903b806d2c 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -9,6 +9,7 @@ Architecture-specific doc
    arc
    arm64
    arm64.ffa
+   loongarch
    m68k
    mips
    nios2
diff --git a/doc/arch/loongarch.rst b/doc/arch/loongarch.rst
new file mode 100644
index 000000000000..d744db6a4999
--- /dev/null
+++ b/doc/arch/loongarch.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. Copyright (C) 2026 Yao Zi <me@ziyao.cc>
+
+LoongArch
+=========
+
+LoongArch is a RISC ISA developed by Loongson Technology. It currently defines
+three variants: a reduced 32-bit version (LA32R), a standard 32-bit version
+(LA32S) for embedded devices, and a 64-bit version (LA64).
+
+Notes
+-----
+
+1. Currently U-Boot only runs on LA64 variant with the highest privilege level
+   (PLV0).
+
+2. LA64 is distinguished with 32-bit LoongArch with CONFIG_ARCH_LA64.
+
+3. U-Boot expects hardware-maintained coherency between I-D cache. Cache
+   topology is probed through CPUCFG; L2 and L3 caches, if present, must be
+   unified or instruction-only. This is true for all commercial LA64 hardware.
+   Refer to arch/loongarch/lib/cache.c for further description.
+
+Toolchain
+---------
+
+LoongArch is supported in upstream binutils, gcc, and LLVM. GCC 12.1 started to
+support LA64, and GCC 16 started to support LA32.
+`kernel.org <https://mirrors.edge.kernel.org/pub/tools/crosstool/>`_ provides
+pre-built toolchain for both 32-bit and 64-bit LoongArch.
-- 
2.55.0

