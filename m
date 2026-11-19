Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31826606A32C
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ugxz6jvF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2524060B5C;
	Thu, 19 Nov 2026 09:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ne-S3XdO3VCZ; Thu, 19 Nov 2026 09:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1DBF60A94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795079946;
	b=BNFARWqX19RgsfVxmiH5SPr3UQ8e21YdkFQ/TiCsIxxwd4t8ac6BlyxxvDXXI3115/MI
	 iSZUI00PMfOLkwGvTRJ/l4BJXUosu1/WZSzHqkYZ+u4GPWXrE7GIKR5VnWSGqiM9IGT7O
	 4uv18Qjht6qZWzly/AQr4WiF1/Cgl70p1oeCyru+OQXrG2eZDrPnoKWMzMXCgBUWC4rJR
	 oKyj08ahlZJzSaG6VST+xRV1GxYPmUPO9HBiEUZ5osTojy5gb91k7X9MzDU5b8qG6SXES
	 zrqls6z38o+J31KYQekidWk5gC6r9uj02+/dCU/i01CbPfZ3mehyyCH+uyHsILIx6GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795079946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mHFzqkQ+hC2H1wWNmwnYJT0VnLgQLGmXBQSEphfG4OY=;
	b=rfmhrmnUqTK3lUS+eQcy+3eUibd9V14I1T9DDrapomJAuriO0ZYtCRcEnmNcpvKrYTF5
	 tDRMhd3EOq3uZpOljcJYIWc7cTdpJrruIa8yfHfD9KJoRCDaeEEEr1LjQcS3I4yPVhSxD
	 2n1/r/NHjC5nIaAi+CBau4/bNOb592GKjak+MgCtj18D/r6OizFxG5DNpK2WK5/+r4RPb
	 soePFHudwpnUILBCOQU3gP9lgZqy94gvUkx0b7tMvRX/M7No3YNiRUsV9J5gB8k+Wfout
	 SORYc9wKvThfRjQjzgu9ki/ROSfTtiNnBx5rw111qFvE/C8OhkAT0cGbMOfXZWrKpPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795079946;
	bh=mHFzqkQ+hC2H1wWNmwnYJT0VnLgQLGmXBQSEphfG4OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ugxz6jvFv3HG6bjM6VW8Nt+1ra7N9xSgT1zr8Eo1JzOldUdSk9fbMl61xZaC+9gzo
	 1CVjUVu0oYhjCCOllwM+glj7KnWt0Y5/Yr+/qw3JRV1EJtlKHEZldMO8OrJLd9L6R+
	 2jopCjpl/bM4i8xBG3BlgBiMEynJZXIpswSTMSDGfJp72RjQH3rthRWvOZDuY500En
	 80iP0KrcDWurpaEoSAexrPwovL3EJbcbvYIgcdKi5ky8rmUegZxhYYM13LKd3tD433
	 IVcSyavFIvFw8mAkviwTltQyK8tsswV+HisG6nr0A7qEFkFFC6gSrt2RceUKJFu9yE
	 LncOYPKcM7fXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1DBF60A94;
	Thu, 19 Nov 2026 09:19:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8D81A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9CCA40A28
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5SDI-1PPJgp for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35C434056B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35C434056B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:00 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1795079882td421304f
X-QQ-Originating-IP: RLC+JcwoC65DfqcINboYnoNRo1WuSaa+/HzrdaizFIM=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 17:17:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12890668473877890152
EX-QQ-RecipientCnt: 11
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: [PATCH v2 0/3] riscv: Support RustSBI through the FW_DYNAMIC handoff
Date: Thu, 19 Nov 2026 17:18:39 +0800
Message-ID: <B92B10779C0D9EDB+20261119091842.3062208-1-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ORU3Pd/i+gCn+TN0JuuUolJpRzv/oB8D+goodtM7WTXGAZV++YkAlOJc
 tTg4or2+eRUEIpKUxa/kDK8RZGc7cZFIhxKEIUHVEmB22o96bZDDZmOW4UxflN7VNAQAHMi
 Lx4FOBzhlWhs7RFna5SwJy9iCCtBeX8/BFYv3v5zMiEmxXcu4qRqES7SLL894rj2qnURuiZ
 uxjfEor3qt/1512kAmXGKsEKYgTzLNPeKC6wcSez+DJHnRQS+GSmpWjoFPyw7z82pk8KtA2
 /ibQ+Vie/FWvPXPuSVZAsOEuDa1oBeyIyacVVeFN2STsIDk/Eq1Vyu6Pwqxn4jySTQ1/26B
 5kxUUVJIQ90MouriiQsYWg1Q4CvA7TqGQ35WJhz+oJyjM6R9TGyhXo2Pc/Zh8QkUzahLLRd
 YTu4NYOeV4My6AHPh3WXwuUBiyvS+qf7udWTKo4xoLT6/GtWQoJ5XsekbBLs2B64rOPVj1g
 9s89HjXQIrwWeoHMYKHA6sZxr7S8YChdi79vbE0WMw4BeqJandFsYC2ROT9UbbIz0bVH5Af
 aIe66rBUPJF2Dl163n0b8Q9Cwse0G1T16OcB4zYVkfqNUOeKcPHypwaNgA84YK0L6jWAfGY
 Kae7oMrgv9hvXtYp8Py/ldt4PmozGkacdu/Cz2gtBAoYk5BnQgQt41/s1VBtYswdBhMIpAx
 y1flkYp7asOn5nmKFuNGW/5WwGk+5wEDflz5PdK4nce4U0kcJxwND8XAr8MbbDeZtbmeaNt
 fyKvdZOIf74/j2HYMUchQmjP7CUeFTGjCRHJvVpZBHcDbMQ60LSIiXN+4DCILymq1x6LK23
 oyXPyKQyvPV4il3n/+cj1PBZEFwAXFVN/pQjlNdKD8F0VDzRv2x17roiEq1azz7EXoGmKDv
 dzUQedCgfZEzeIAtzn8XMcujQu83e68Cz+LudGzOmVrF3ObrAhfEgpPxB6ygYmSqa3vIrMO
 mBBmmelEPHInk6MnLG0NjTKBMzvRk5yvVN4VwQNg/lJllFPEV64FrjC8joFmuVYSLNVk=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RustSBI Prototyper dynamic firmware accepts the FW_DYNAMIC handoff
already used by U-Boot SPL. This series documents that compatibility
and lets users provide the firmware with RUSTSBI= through the
existing opensbi binman entry.

The first patch makes the SBI_V02 help text firmware-independent.
The second adds the build input alias, a binman test and help for a
missing firmware blob. The third describes supported firmware and
the effects of the scratch options in the architecture guide and
SPL Kconfig help.

I'd appreciate Tom's and Yao's feedback on two points from the v1
discussion.

1. Patch 2 keeps RUSTSBI= as an alias for OPENSBI=. Both use the same
   FIT entry and SPL handoff. Would you prefer to keep the alias or
   use OPENSBI= for both firmware implementations?

2. The FIT description and SPL debug message currently say OpenSBI
   for both firmware binaries. The U-Boot "sbi" command identifies
   the implementation at runtime. Would it be useful to pass the
   firmware name through for display, or should we keep the current
   labels?

Changes in v2:
- Split the series into three focused patches.
- Reuse the existing SPL handoff and opensbi FIT entry.
- Put the firmware documentation in the RISC-V architecture guide.

v1: https://lore.kernel.org/u-boot/2744044E69DD25E5%2B20261115143808.1812787-1-luojia@rustsbi.com/

Zhouqi Jiang (3):
  riscv: Describe SBI_V02 in terms of the SBI version
  binman: Accept RUSTSBI as an alias for OPENSBI
  riscv: Document SBI firmware support in SPL

 Makefile                       |  6 ++++--
 arch/riscv/Kconfig             |  3 +--
 common/spl/Kconfig             |  8 +++++++-
 doc/arch/riscv.rst             | 17 +++++++++++++++++
 tools/binman/ftest.py          |  9 +++++++++
 tools/binman/missing-blob-help |  2 ++
 6 files changed, 40 insertions(+), 5 deletions(-)

base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
-- 
2.53.0.windows.2
