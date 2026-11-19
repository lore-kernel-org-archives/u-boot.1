Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410C60A260B
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HixtPJ11
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D104060D7D;
	Thu, 19 Nov 2026 12:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a226uh8QMljl; Thu, 19 Nov 2026 12:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D744606A8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795091853;
	b=FXCbuXXPylXqqEALNTdGUdpV4fcPWQPQ7T97cqQ6+wRV35n5WjcUQNATG3torB9f5fMP
	 tEtNa2O/8bpSzV2wawL2wiWnWvdHTvrGEq9/MzXHP55oupEEx9/7ATf7OvsUlzXx37I1N
	 dxBIwxwPQgi80ltXhBY96PS8muHUhTU+kOGTTAWBELFaQ0vKcJb0PiSoH7I/gFiyTNHJM
	 rq8n6MRAWCFutuoV27GdkY8wIHkzwS5Z9LtG5aJm9MEinIZvTlNmjoKFkqNfIy5XddUFJ
	 9qWMghSBu23xW4KxlPoLaXI88sAdVVCsM6B+8u8+3MA3F9GtZdZ01v5L216rYmpK7WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795091853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:
	 X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nhft6BAF0+8twuiWH8QDZQPJLLiWpcnQyh9JXErtOrk=;
	b=ggwS6s+QMSFMsEFCTqmzkQSBOgm/xQ175AMyCJCgq1QNqsRu8aNUlhhG9MXl837Iyl9s
	 W4nzhKoaRkO47MYtNvKEXyjES3wSem09+j+5LkxznsRXWCtlYYSjSE/fCPhHQ7gZHemEp
	 HbXj88QZch8zOKtkOq/UvM3XMEojLNh+Tu0KoYQemuIgRyJ9bXZm5zw97nxrcyRM578nX
	 9F/4tKTKEXA1Log+UrrHdR2oxHw0FkYG/P0TtdjMTyYLOPYn7YjvRM4K1CPzUdv8lvwCE
	 4c6E3BayebGEWyByXDyWuiYKRDF+f6AmnjGFsEndisuxhPTVTAHGSpCpDVQC3SQE5qA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795091853;
	bh=nhft6BAF0+8twuiWH8QDZQPJLLiWpcnQyh9JXErtOrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HixtPJ1120dz43akpMqL7XIIZZGWcTDL40OuOsf+RN11ZFMNkbCg6krXbt0l7nZls
	 VzRgXBo3C4s+VmyyGlIYqS+sl1/obFcAom9XwDxHVjNBr0jZ4tBEM2+K/ljt9MFqTN
	 F7eV12j/plH7o9eMZlfw6akYtYK2liOLXZLGuxE4v8E74ROxQZcsCQLE2rQNlxFbxr
	 DV7M//+JSNLz4vrmapAlpAzWkDe2nQZE/+tpFIfr4QOyuskZtOCQEWYbpxu8Kq+WLn
	 mjbQ0e4ChNw15aVisawLwldzvVUUNFYr0IwXKhrDJ9cFAgi2sU5896gm7CNTeuWlzY
	 YPJl4k96CpPrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D744606A8;
	Thu, 19 Nov 2026 12:37:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF1A92FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B478C81310
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i0P3pUFypfzP for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 650D6812F9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=54.92.39.34
X-Greylist: delayed 98 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Nov 2026 12:37:28 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.92.39.34;
 helo=smtpbgjp3.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 650D6812F9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:37:26 +0000 (UTC)
X-QQ-mid: zesmtpgz1t1795091799t26c71d66
X-QQ-Originating-IP: b3aAt6UU1zY9IM0OUc/IxXR/O29T0Kp6Cycee0mAvvI=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 20:36:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11210066373992293083
EX-QQ-RecipientCnt: 12
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>, E Shattow <e@freeshell.de>
Subject: [PATCH v3 1/2] riscv: Describe SBI_V02 in terms of the SBI version
Date: Thu, 19 Nov 2026 20:37:10 +0800
Message-ID: <C599D6A43F5A478F+179509148315.3129810.14969508321037793663@rustsbi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <AEF561F2E6C94301+179509169842.3130233.16129671820912856303@rustsbi.com>
References: <AEF561F2E6C94301+179509169842.3130233.16129671820912856303@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MxP0tUKC/CfA0D6vVLslQFhLHvr9ygiEvjOhtMH+BYHJsRr4xCOEBAgi
 1uDoDvbJtyZdMNMHUc+mkXMtqbPJ9v1J/eF+6W5bVKWz3zOmBmMHjrjlxnIFgT1kwOZfMQi
 BeV1TwOIN0yJOC3zsmeVUCiCBfY5SC2wn4FVFe0N6fUB3uHEpeaX9D64rUAj2rq+eRJa1J1
 LxXv34IRsR+lPpzJ2Md9SU0DybSGYIfr7ocXRQzyb0rsnDMzP3G7nP7Ir9yu9fmr8zYtche
 7PAeSXYyC0LeyXgsLQ+epvUcHmLHA5+tfXb9BqzU2h+GK9lI74vh3dduD0eRLm75FohxrgP
 DZUsGik+FP9SUL+YN2RWPCSBJQJDIXsAsWwsIZNolOOCZDePhs1O5Xon/90UTGpCzEXEYm9
 FMZr5xtf6UwuNNYRs81ibGQt+zU2VjGuYnOej4RAiauEdWVIDhVdsID6niDakdp2hO14sWd
 pLJdcEnEZTh6D6Q8SjKyuLeho6aR48ju5EbXG7AfZdqGwCBNTcbo9mMqgXjKfSG/dz0WKvw
 VzhIX59b3fCTm+4FhjKGjdoM/oe0k8M1GOuCFeclx8Ta85CoXmtVU1VJGjY3erafsQJ3XTt
 yqYDjTc3pmVzEraNYeqD67y2Nc+6IJc4mb4sd3rAWwXGBGmHukF0I2uPEwYAeJJT/Z1JG5e
 EGgDOjFl4hJ+NZBPL+LJZuOFSGsVf8cVjhB9Mt7WzAEt1Gbt487Y+eaWa5mgTe5bLAo3Uww
 ZVvxAKVSRmHtQa7r0EJCB+sHHB2oZwNUaWhpd+8lXVrOS8mUu/V1gcyH4I7ekHhEiy03cHw
 PQ+GPieIaaWhR+YLhZvKpFNSlhMc7i5lM1CsJzOYVaP04n1hC5w+WThspup3NESlqJu/H7z
 hyQAV/8BkuNy3OdNYPwQWnPe+GRrph0Rzawb3sKiN4tLTU00ZSliQnEiogYNgXSBLET6VHt
 N7TvMnjk7Z/rc8G8ubsA9uql0bnONxjpfv5+Rk1P59rYIBAKWjM2eLI02wW35dlc3+hV3DF
 mXzwO4f0BNjj6+YNKcjlIZJSQOaUo=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe SBI_V02 in terms of the required SBI version so the help
applies to any conformant implementation.

Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
---
Changes in v3:
- Use Yao Zi's shorter wording for SBI v0.2 or later.

 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 386241efd4a..9920476bfda 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -476,8 +476,8 @@ config SBI_V02
 	  single hart needs to boot and enter the operating system. The booting
 	  hart can bring up secondary harts one by one afterwards.
 
-	  Choose this option if OpenSBI release v0.7 or above is used together
-	  with U-Boot.
+	  Choose this option if the SBI implementation used with U-Boot conforms
+	  to RISC-V SBI specification v0.2 or later.
 
 endchoice
 
-- 
2.53.0.windows.2
