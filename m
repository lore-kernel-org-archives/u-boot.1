Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19257606A884
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G5tN4prU;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lb2krkt0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6C5181217;
	Fri, 13 Nov 2026 15:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHKn6yce6YcX; Fri, 13 Nov 2026 15:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 356A5811C9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794584923;
	b=f4OX0ZH954WVhwWeKNWw82ntdDPCkvaTKTBmLC0niuG3PQYTiqteME5suSFxD66d0Jn9
	 Qk3br2cgPCt74e7Yh//ahN2hBFjPdqF3BsJ2OacLcMl5pnkce7csP7PBkZjpwY7oKDB3Z
	 5N6K9h0p6cSulKjR20NHqlWiGUuy3MZmFjTHSV46ADP8DEO56i41oJPVWuUKJEjh7Foex
	 Qm4grFCo1HeBZ4Q/8Q3NCNMlLA12zGKJeWUEC1GkRI/yDR4WVjxY1/KE5lz0M7IkTxcR1
	 5KOF+VMzoVcIMEzom6Uyse8SiuAicUG0TfgMgNOEezfdQyPcRUdygLVjVNT7BkyztNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b4G+JKs7Gn8EiwYgsLn3qswPZiGRdEIsr83LMANSoEM=;
	b=IXjI78+pbHGcwbMQaMYBd3xmvyxedjZRVu3zrwGsHYriHe7D27+mM/LGont2oKQw7okW
	 8gOr6lNis3beysnWmbTYZIIJXx/Zso7kQSjca0Bi0sl98RiFQbl4zPrMuCfVk3h2rO2nr
	 I0oLgf6AsIJLrSgS+3IdWHDY1d+JIFx9MadrcMEh5UN12Bw/l8JI0lb9e0P98MhAAw05B
	 2h9rnzXiP0qKb6i1Z+zYNFJvVE535tfXRY3Y0u1kHXul+dbDeUwUk7V0G6AE/u6VN3bTx
	 aOdVO30M/zs76A/bP/kE2um5DWDyATIFTNffY2rJ8WKkCMDIoOjk6CktL1pWw4Qhnvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794584923;
	bh=b4G+JKs7Gn8EiwYgsLn3qswPZiGRdEIsr83LMANSoEM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G5tN4prUP9xd2qOf/8geXVWPyn/G/3KyeOm/6f8Q2FnA176Y3rp3QXSsqszveoqGB
	 MtBmR0QhyQiMxwV2dDTYLv/Tie2gm3XxKAdzX3JFQbMO+HjnJacGtfR81CZDrqNcEa
	 hyb0MGfFmaF5167Iukj1vl1rjJxaRT36IMorYR7hQzMxc3YC2EIEM3X/8XdP60IRYR
	 eez+zmxOCHEHB/cIhXMIA/GOcItjXKeTZ2wTpn0RkxeVqPR1e4L8OWUo7RW1gcTipF
	 T5yiR8PP9GibZPw1kEqV38fyKAVdMvh/EOpvMfQ1NDAMRIgYTrmwM1WP2EkLFtJG1/
	 Be94rciRS9JKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 356A5811C9;
	Fri, 13 Nov 2026 15:48:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 607C92FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51DBE4009F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xOV3b-jIAdr for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D9A140093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lb2krkt0
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D9A140093
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:48:40 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4ad60ec5eaaso1695340fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794584919; x=1795189719;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b4G+JKs7Gn8EiwYgsLn3qswPZiGRdEIsr83LMANSoEM=;
 b=lb2krkt0iikB1LwxtWOYZqv30/CfK+O3vJzBcBj+GqZVnNpVoUGlDQ7gifaRVDfHcn
 iIQ/4/pOgbxBW83/NDP8Qkr/0qos2DaNBR6l24i0/RElEchc5bPx+6nIUNkqsKT5xLMc
 hp/ZHBJfMckRphcxo2Bfx32O1CvB6Jjp+j6KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794584919; x=1795189719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b4G+JKs7Gn8EiwYgsLn3qswPZiGRdEIsr83LMANSoEM=;
 b=HeRwcQ7mqe5HCGQMSeRFGJdW5NkAg1yE8DLQFSYMMbqA6k5f9WOXyRrZgS2uJljmVZ
 eWTj60Zb7ZaKAvVnvTJo3Puy5dKUmch5vsASsJi+1CXI0eBhJQVYz8Br7zxER6OWA7z5
 +PkWRKm0R+DhKhHOo3rIGgQq5FvgV0oLKF5YiLP3eIH8W5BcOIavVYG8O2LG3sIiUHjL
 fSnHO1pMMd/+brw+Lr35npqtqoO+DXTVpjODGjCBUV/4L8ZGVqClEHTIWo2tsPeH/CD7
 43g6JdRpMyVBVqGOXGDgPAKw0K6tuN3CG+GNE79uCIlSUrAQBPLPZkr1hw/zFTZjcm8y
 5ESA==
X-Gm-Message-State: APuU4Z99IFD5EYEHNMYB2r17LlawgR+NWn0yk0G/LLOXNbCxEVrz/iUk
 4XQOf1sCivxytQUmX/0QpGoKy7uubHXdtXwwpbERJYdr+ybqMg2lkNbzUXDTJMqjS7lT5CI5cRz
 G6s9CqxPUwA==
X-Gm-Gg: AYBFou1PyGd03Gqen59tL9ksTOF3ztYL8/R8cIlffGdTNmljUn66rC1zbYleXBS1W60
 Hvb8swDcmPXFAyO1Z8ONaZybgm0NtCEti1WpwSHjcEHDN5Tnl/VzQQlot1O9Nc7OHdVjOhuB+fl
 vWa88d9VrfjnuzDRdobiIwYL9v+J9Lmd99qkUc1rRWgDLrJdsDSPo5LGOyELXyvrlTj8kDlFXUj
 FsSih+QVvOVz5JuC8SazZZSor5f92qHdZtep1zm1Hb3pD4ELVMDnDt/LJlm0E/98IPstlqXc9t+
 nn0eLHmTnjpQtEpkk+a5Crn59EMGV+nnFIY3IEbmFFYTia0WYt9qQGwZCsoga0Ww1oJowiXPEz3
 AlyWT4dGwaKZLwp0mOOEoIl9Cafe66PsiVnN1EHuCi8hdzaD+pdXzCJeJTnbJvDKsbuhTCc3xCU
 cgTUdeNHYTT79KFktcA43W5v6sDr+qmqfYOT6bEjlfO9iDGszOoY8sZAKzcG3WhAGJjSZmKNGW7
 N8y7ymKoXHnojelHqUN7VQFzA7/r1jgZr53vq+mjClUHcY0Y8WG6KJSjH7ThagQfmpswO0wkVdZ
 kckgYCQZLVr6SlHiB0DNJBN/rKDCIoYBqxvJLG7oz1+1kFARaJiXWQsDVegQsFrhCtyUEh3y0SD
 WIlOZVrSFmmK3nwV2EGqmr9ecMvr0SR5+urDIBy18P1G9Vegj//KmHNO2cI4tqonTf+0RRSkAI7
 0AiCQnRCjskRRwAZiB7/dNJ8NCpMv9/123czpsb1JqNGAxkTBVOD01hbk=
X-Received: by 2002:a05:6870:5baa:b0:494:2141:c0e4 with SMTP id
 586e51a60fabf-4afdf72b256mr1832575fac.29.1794584919098; 
 Fri, 13 Nov 2026 07:48:39 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4afe200ffc6sm1575288fac.1.2026.11.13.07.48.37
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:48:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] sandbox: Take over maintainership
Date: Fri, 13 Nov 2026 09:48:37 -0600
Message-ID: <20261113154837.1214404-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Take over the maintainer record for the sandbox platforms from Simon
Glass.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS               |  7 ++-----
 board/sandbox/MAINTAINERS | 42 ---------------------------------------
 2 files changed, 2 insertions(+), 47 deletions(-)
 delete mode 100644 board/sandbox/MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b38ffee2886..72fb303c5b58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1568,12 +1568,9 @@ F:	cmd/rockusb.c
 F:	doc/README.rockusb
 
 SANDBOX
-M:	Simon Glass <sjg@chromium.org>
+M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	arch/sandbox/
-F:	configs/sandbox*
-F:	drivers/*/*sandbox*.c
-F:	include/dt-bindings/*/sandbox*.h
+N:	sandbox
 F:	include/os.h
 
 SCMI
diff --git a/board/sandbox/MAINTAINERS b/board/sandbox/MAINTAINERS
deleted file mode 100644
index 9f5073bf287f..000000000000
--- a/board/sandbox/MAINTAINERS
+++ /dev/null
@@ -1,42 +0,0 @@
-SANDBOX BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox.h
-F:	configs/sandbox_defconfig
-
-SANDBOX64 BOARD
-M:	Simon Glass <sjg@chromium.org>
-M:	Mario Six <mario.six@gdsys.cc>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox.h
-F:	configs/sandbox64_defconfig
-
-SANDBOX SPL BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox_spl.h
-F:	configs/sandbox_spl_defconfig
-
-SANDBOX NOINST BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox_spl.h
-F:	configs/sandbox_noinst_defconfig
-
-SANDBOX FLAT TREE BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox.h
-F:	configs/sandbox_flattree_defconfig
-
-SANDBOX VPL BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/sandbox/
-F:	include/configs/sandbox_spl.h
-F:	configs/sandbox_vpl_defconfig
-- 
2.43.0

