Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7F606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RwyhmB6p;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZMOtMVgq
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E04C3406FA;
	Wed,  4 Nov 2026 16:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZRrPlIPHVpwB; Wed,  4 Nov 2026 16:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F9384072B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793810241;
	b=JyRNF7tJhyiX878Qx8QNaZGuDJkEoccpZZrL4Of3/EEhEDmZ50tVdPgXFKE+PMK9V+HY
	 0nx289R5ZpRxJ1sk1jqccmM0lDeT8NOkSn3rMmVnccnSRrnjGpLMKXcKLG7XnGEDE+2gM
	 GUKPPBElfkVG53AF/Gr/KjpFwfaFl6XeCwMEQpY7l4BcgQeYPs6zmjCddqwJu+CX7hZ+U
	 kkaooWkIrUMsKrcJh8zZK0T33vCYxdPrDk9kg+Hkb5ZUMw0UQXrHWm5liQc5GeHH+wnuS
	 QalgDNZmejqInDtQLVBK+YtjtamzFlUsbcvnR2J7xu3f4pCUSv2Ka4NLoyTQpAB7Tiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K+TCE+oX4366MTGwWTPuhHG9aOKkTHO8cf38dlyolFs=;
	b=cn8TaC7b2gxXmL9zF9CV1+g6v2cf3HInNNxOna2HJYxSXPrBjTBdTamdpJs9YLRx8q0E
	 8b/ffnnTfXu52+/wH+uJfmmmKmT/JyaiM0WI5PyzTirKxd8y2PIIwiqgLF11/mXru3bD1
	 A0pzmTIfalSioba9ykhsF/ypYMAo2Tx6DIlwLlAGqHsZhPfsqeZtnj0ABVDxath3PGve7
	 OB9UTpCztv3y5dHfJ7QiGFcG2eO32Wwl0vARFioZXuLnLIENxDzjr5p8tHN+wH0wgaUpi
	 eqQdv/I8b6lQbW73pjDi7A41kgUWq/RirOblXNEFmIwyycZCMs404LhFXc8ojs3dG+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810241;
	bh=K+TCE+oX4366MTGwWTPuhHG9aOKkTHO8cf38dlyolFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RwyhmB6p5Hp67toAiSE8l1Lj8QxJLAh1d5mI0s4Aiw79ZWmY8kZY0n4O2rxdfT1Xs
	 9HNAAu3qYirknQj7oTSyvjLna4vkMhdGxQCXC6r0IglziacCZccbjI9T5dZXLjT5kq
	 B1OsBwJQzmEI2G3mFVrSXtVX6dlbiuJCPMv6GlMMc3hzp3SP0liKeI+No4DPYIRJRL
	 UNmcPJ35D6TM1Z9dwaphcM9wnreIiQMI1+cOLi4hIbwDcW3ty1kypARKPCtxzcMaMD
	 AeCJVmxZUkJcHmujldTZ7zgFjHCBsDU83xwtgXaHGCfayEMFYfldjuaIAR+uqYegUx
	 NIFAt/sX4JsxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F9384072B;
	Wed,  4 Nov 2026 16:37:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D41E8A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C629280CA6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 246HEbGw8Jjk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBEF480C9C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793801499;
 b=J6Lganuqyk1noKnASjfB2VUPDgux8juoxDfsGfTJQbWBNMhlOG0pToA5FUli7BEe/dM/
 KDgCRsYUYXYTfHigDA2ynQaq1a2Y2iOdnLwy80WB+28nNSzTCCvTiZma4jP/8wT4mjifN
 3PCjj0Y7Qzjii4Z2v0MrJXwgT/QsBeXpQ3o3xuNspLZ8EENct7DiVZiURIRMQyIgHPGqz
 N4arM7Recnb8DuNSWmxyDrpNUcGeOUS6JJXCAR34OmP47e+cSiXKDYTcuaA93jU6YqDtA
 mJsSAU9Pfq7bSlJ7rbdXKcbnH+oYVy+/u2c0kRU98B2BQzaFaWxGYIEwlJdTsKhHI+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793801499;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
 X-Virus-Status;
 bh=K+TCE+oX4366MTGwWTPuhHG9aOKkTHO8cf38dlyolFs=;
 b=cZSmDKZbFG+84v8GFsHIBKqQbzkuRhmplfb84naF8vCuG8XgLumv7XbIKEwtJIukHEql
 bI7buuzx8VWGzJK/KAmN+vZ2QghjdEVVdInZiDbQKpgRY9Q0CAiIVuHsGDVbJpCqOd4Yr
 3nKK0J5ZOMQNd4KY95Z9dDszfz5pzmEf/0OA6Ga4Ojq5VzNO4WRqtwV5V3JssIL6hNyxq
 vJwo+1AlxtgBSLDo8MH60RxPgZptkCnaWi9ni5Z8BY9kOvRdUXRUOaZaxaIKV39J7XvbW
 7n2MvvXdsDjx94H2sVgf+XOLbbB6nJXY/cclVFeOf34nL2ZfH/evtH/JXWHAT8DGDLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=qq.com;
 spf=fail smtp.mailfrom=qq.com;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=ZMOtMVgq; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=xjmps7114@qq.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=qq.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=ZMOtMVgq
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBEF480C9C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0CD584828; Wed,  4 Nov 2026 15:11:32 +0100 (CET)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com
 [203.205.221.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88E48480F
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 15:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xjmps7114@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793801478; bh=K+TCE+oX4366MTGwWTPuhHG9aOKkTHO8cf38dlyolFs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZMOtMVgqfdzIfD/neKWzTuwse6Y1Xtj1KgFaFd92+czFBUAtf4DvbhD0RZh0FqdWN
 wNpCPoBji4ybeXjxEWPXqllvgSvQapu1R3P92GHO7dgg0gIdDzYvlE6w7gc7X+G9pf
 /9mMuAHYH7ONtxtrq9WzeGmi13NR7D/nBuG4k9MA=
Received: from localhost.localdomain ([27.38.1.195])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 2D030261; Wed, 04 Nov 2026 22:11:16 +0800
X-QQ-mid: xmsmtpt1793801477tg4f4rwm6
Message-ID: <tencent_6C5B293C811C2C4B1C6DC17B52A6E3C87E08@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+WZ3pdeBQwqhF4+wkuuVNpFAJp23vrxJT07FddgXlOBdjAdRjLe
 LR/6Nzhe76zIHclnCzpsOoAzd3FMffNgFM4v5s2bXCcvZhkCu2/2FyRL9n/F3yguRmHc06oD03r8
 VGOY6GO01sBig6pkSFJHlVu9aRUUjzSkuG7IGQwUdbuKzRQmCSS1Wrs26OOWT4VSP0zTX2rw0ln6
 tj+yh5eKd9hLIt3nFtgviKy4+1Q2w/k0s2NGgIoaa9SnB7KeX5sajZtuVCo57ZhIFBaBG9oYQ9FQ
 H6I6T430D0YZ7V2mkTK7B+juAwE0eaIHi+AsAqlNqI88htWalEyvXuQfyvrv4Nafi1Vrs/VZb//Y
 hIwJdJKsgu6oIg7IbAW8yP3tL4kg0lws69u7UlwpfGo2ZaIIdHk3xuqEG6Qtlyz5qLyaBPjmo5Xe
 3SUrEF0Q3rPXimHOAbg9dXdQ1KlSbX4nOZOYY0L+1auPl69bYGIFzXFTkMoi6b9X/W9gwVa/WrAJ
 V9myUI+VVmlgT8MVc1m6zO86oGgzbGJzI5pinGnDftaidGtx2JIkHU7yYBJbeSfT7SzyoNTkT7ex
 tD9jlIIF72dqeqEhQ7X5FU67hCHkz5cM691gQdibSe15KT9HmfAGLxIrJt8Vzi+2cKcWhd8fy8f9
 0zZYqTJW9b+hjtQGKns3ywa2YWhBvEK+w23iAp5X96t8B0ppHxMwpiO/n8uRqG0LusC5il0bg3ns
 SqWtRjy5sfjdy6kiBoevIeg2kZOmvKw2wIijjZX5NPQCZ/4auKhJnX9c8LzqEsQx8orOISqgLb7v
 VziPqyOGgpCvxGnP0Pv+sQvEgyNczNmacGVScMfZ8+FEKPNCFZpOmvzAUk1IbWACMU3b9qlP6El8
 RNyvsLKz0g1T2I5NFBnG/HZcQMFtfrKBV+Ovi3kMdITOqcJcuvKzSqwzU+hgKJDIQARv+YIoYSRs
 fahQtXFCbjyRPQGk/Pfncjn4JNWHlmHD/0Sx1juW2cQda3K20f76KOP7gWdHE4o34Q/XvEQa00hW
 UdT5eDrpRz7uFXN63WFiKcKBSssnpf8wE2B+CN3VSVSbIU5JBT86l7X0k4b1kIdPqVAjBX3NatVM
 HC5sUT/oubap5VovI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: eli <xjmps7114@qq.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	xjmps7114@qq.com
Subject: [PATCH 1/2] spl: fit: add software rollback protection for verified
 FIT configurations
Date: Wed,  4 Nov 2026 22:11:16 +0800
X-OQ-MSGID: <20261104141117.12284-2-xjmps7114@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104141117.12284-1-xjmps7114@qq.com>
References: <20261104141117.12284-1-xjmps7114@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A verified FIT is authentic but not necessarily current: replacing the
next-stage image with an older, still correctly signed image reintroduces
vulnerabilities fixed in newer firmware.

After signature verification succeeds, compare the configuration's
'version' property (covered by the signature; missing counts as 0) against
CONFIG_SPL_MINIMUM_FIT_VERSION and refuse to boot if it is lower. 0
disables the check.

Validated on real StarFive VisionFive2 (JH7110) hardware: signed
version=2 FITs pass, a correctly signed version=1 image is rejected
independently of hash verification.

Signed-off-by: eli <xjmps7114@qq.com>
---
 boot/Kconfig         | 11 +++++++++++
 common/spl/spl_fit.c | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6..7ec0bde1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -224,6 +224,17 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
+config SPL_MINIMUM_FIT_VERSION
+	int "Minimum acceptable version for FIT configurations verified by SPL"
+	depends on SPL_FIT_SIGNATURE
+	default 0
+	help
+	  Software rollback protection: when verifying a signed FIT, the SPL
+	  compares the selected configuration's "version" property against
+	  this value and refuses to boot if it is lower (a missing property
+	  counts as version 0). This rejects older but still correctly signed
+	  images. Set to 0 to disable the check. See doc/develop/spl.rst.
+
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 46ebcabe..9dcc58a0 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -781,6 +781,30 @@ static int spl_simple_fit_parse(struct spl_fit_info *ctx)
 		if (fit_config_verify(ctx->fit, ctx->conf_node))
 			return -EPERM;
 		puts("OK\n");
+
+		/*
+		 * Anti-rollback: a correctly signed but older FIT must be
+		 * rejected too. The configuration's "version" property is
+		 * covered by its signature; a missing property counts as
+		 * version 0. CONFIG_SPL_MINIMUM_FIT_VERSION == 0 disables
+		 * the check.
+		 */
+		if (CONFIG_SPL_MINIMUM_FIT_VERSION > 0) {
+			u32 version = 0;
+			const fdt32_t *verp;
+
+			verp = fdt_getprop(ctx->fit, ctx->conf_node,
+					   "version", NULL);
+			if (verp)
+				version = fdt32_to_cpu(*verp);
+			printf("## Checking rollback version: FIT %u, minimum %u ... ",
+			       version, (u32)CONFIG_SPL_MINIMUM_FIT_VERSION);
+			if (version < CONFIG_SPL_MINIMUM_FIT_VERSION) {
+				puts("REJECTED\n");
+				return -EPERM;
+			}
+			puts("OK\n");
+		}
 	}
 
 	/* find the node holding the images information */
-- 
2.53.0

