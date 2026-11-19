Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403DD606A332
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UsmoWct6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12671606F6;
	Thu, 19 Nov 2026 09:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ursCoGRGfApy; Thu, 19 Nov 2026 09:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5F9E60A94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795079990;
	b=PPqmNfaVVL6ta+tWyajQLaReyPDX6ghhUB1VDw1Cno8cFhnutDYkS+OcAOq8Hu49tVQC
	 j1vhDGb9EYhjCaRRJdjvHmpTrxD2z1pdvs8Ui3HVDf6s3+J4pNHg6JFSMbkWVLuCTJryx
	 lRMyJE0nNrGljI8/A+YtXwTlRqoAKTf7usLwLAufdZQjs2iL+O2gJCmagkIdgXyHN/S/W
	 3xj14tZc/Iiu286fLyVdKl/3l0djdhxoh3gehc2ipKFaTnP7ZT8IH9NwrZtRleNcvX66n
	 AqBOMT7KZYoiSckUy+AjrXp+g9hiIsJRZqtpKXdfZryyVeTEzS8OueLb2m1tcUcxcBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795079990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=57uM9fqyp+9Ukrrz8+WOu6bbUHkfSXerAbMIv91mRw4=;
	b=CR94PryfSU68qmCyvqq7/oG++xYVdyMLjQjzXphYCNkfLRb/aMP9YYfqpopQ1SZxhguU
	 POBW15tUkJ/nFnjUOPXGvBop9de+vaqRAVjrwA3uIGHAh+bD4T2mbcC0LBZZHguECkSf0
	 VUke4kMMgezBaz6LsMS6kFS5zOsSx6tWqdNxeCHj/4TiKeWwT/dFctmh0jSPv7QTGr466
	 ljRXV6cgxgoNS7ICzIshfZs5dJjIGb+xOLtTcAyoUrFEMIsmsUz3cxsdcwVAEWQFv/Rnf
	 Kiwuk8s6GbEvHILMhTcyp8XrMYIIlll6ORbkr4XZR+thfwKy0No6xMeKUYUcDROSlQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795079989;
	bh=57uM9fqyp+9Ukrrz8+WOu6bbUHkfSXerAbMIv91mRw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UsmoWct637R1phX/omvWTcqluOwNimUKJ4dMUWMDEyMZ0dH619USUbG6wau3QZLDE
	 FJgSQ3RyGd68tju9lnUCD6A53+KdyP9Yh9VXMK/hmjHv6H4YQTdFOJ8Acyr/Hlb+GA
	 GHYjY7sNJUAkWeQ+N/DNJSFwZZR4yGAVmgp4cBv09uN/qFoNOd8JS2yu+GlknuwkGB
	 ne5fFKAHiGCIJtBa78akCK6Y1TDNJ8AYHQxdn8fcBcRm0WTJ2IF9cb11Q0KButES41
	 qXO8RFtQspMw21KWCsfV7tPYinY2d7tTDn17sq4aCwkAndKQ2L+iNchemwL0YQlsHL
	 1cxA01LofHX7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5F9E60A94;
	Thu, 19 Nov 2026 09:19:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C72570B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 533DE404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lCdH4vQJc5gq for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:19:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4295C404E2
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=43.155.80.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4295C404E2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:19:46 +0000 (UTC)
X-QQ-mid: zesmtpsz3t1795079886tb4937d8a
X-QQ-Originating-IP: wiFCxWD7O6KmJpk4Su/6CISArDiX3OhIUNS+iiTkA8Q=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 17:18:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14524517842153177509
EX-QQ-RecipientCnt: 11
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: [PATCH v2 1/3] riscv: Describe SBI_V02 in terms of the SBI version
Date: Thu, 19 Nov 2026 17:18:40 +0800
Message-ID: <C333C8B0E169374B+20261119091842.3062208-2-luojia@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119091842.3062208-1-luojia@rustsbi.com>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRLj+a+1JRyJWRwt1EZ/WoyN0yIO1SG5/xsSqw6tGKW4RM+shplapE7k
 JCjmXzGWeBS3wBTlY3GxTvAO+7LliAndjlIdz1YXVZwquRf+7HBnAAyei2IghHG0C2mlEzR
 9XD8FhYehvjeJDzRLfv7d4hws3O10hEHsfnoC+ZDrMxV9cYpnxL0WnPmwrQa4gVhAatDa1X
 l7zJjdBVAO4dtBhZ/dSH0ndZ+QGhqfJh1V/OEWWwwQCAIR8fjVh2gK8LoQY3ZiZjS9QLSDQ
 mVhLvU5bK8Rup+k0chx99mn5HQjIgTXD150CKTgKtnwcxFnSJl/dVlsdcyWnUuZ06XGXNba
 MBqYquZYf9pIrzaPWqHxk2EypMQWWMREa+IzkfdA42K0YdCnwyvAYL0CgCfhOqA5oNPwMf3
 QPK05TOgzusBnqKvuWfX8S7DmDDtR1L/JsuWSjLfP081ZSP74Wu687UzpqO0sQUFxg85wFR
 8Mtq68xL/M3jw/+5CueNYuCpQE5xriujQ/vl//p7QMzfLAqZULZ+pELzmOuHgx794YK75U9
 08WtjjPWRfVN0hTrldB6WgbHSUjbd1+kZEMDG+A174bz5DtTd1xRLMbftpXMVE75VV8q43q
 f0vhT+IOEqoybnPgyg5DXg2bUGtTtVJcXLTXcVt5gsI8KHW7u/RWs5JUUBCb35lg2mut5Ur
 /wh2XkxNVUrBC77dTeri341YJ3NgteWpeuaM0j8yS7HQAXnRrvbFG5XnayooqYQZQbz+vxC
 JQhq8p5wblPnxoE/xaLEM01qBlXXDbQoTG1XLOV1NLgOcB28nEa6sWbWJsX8dHVTLjY7Bxw
 K7m/rtnDz1O1gJLlxg7Mhv62il6IgsZ/W7XwZFt5ESyv7AMhaRFPapQjiqVlUs3IV+n+OWA
 CYMEyIyPgZ1wsBSkZ/u+um9ukGgbc0WhC6duF6Bgxjw3adlz9ppHOje+KXxWRfxG3txjAQd
 nTS4IaQIhZ95/Op+dCfCgAyvvs9XtW/jbz/tvxHVv99J3wqx/8fMcmFOS
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe SBI_V02 by the SBI version it requires so the help applies
to any SBI firmware implementing v0.2 or later.

Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
Changes in v2:
- Split the SBI_V02 help update into a standalone patch.

 arch/riscv/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..0edf0247983 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -476,8 +476,7 @@ config SBI_V02
 	  single hart needs to boot and enter the operating system. The booting
 	  hart can bring up secondary harts one by one afterwards.
 
-	  Choose this option if OpenSBI release v0.7 or above is used together
-	  with U-Boot.
+	  Choose this option if the SBI firmware implements SBI v0.2 or later.
 
 endchoice
 
-- 
2.53.0.windows.2
