Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C858606BFDD
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ytii40u2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JQltiopw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E388B8168A;
	Tue, 10 Nov 2026 13:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ABF1AdhxCZo; Tue, 10 Nov 2026 13:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EBDA81567
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316014;
	b=YHIADTph9cyTm+seHY/OhQ9XkZcN2LfpooA78Isqjm+pNamuvz/QH5gkEL87lcPoydf0
	 9K4rDowzBAEfBrZm9ss4cl2KaVM8Yggs4iPAH9dPdhqZnaWzEJ7jlZOTgJe3gUjIkGsGg
	 tg9p4tsFzPaxpaG55VG0zaofhP+INLOzgZTEG1ZgVkRyUcPxyH1Ik4/yqf6qUbQDjdu62
	 SEbBv5vDTcua2R5shLlbt47SJiwakFxKYhoyOsNUUWH/+3e5kTD3Z04DfLIzqeVvSGE/i
	 /W+xwiUenTpHI6xICyMZneAwTYUTpzJNuYa5fgEf8m8paqhiPaurAO8Ui2Ub9AaXKxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yi+pQQqs7hlqNN4dA1J74NWYGmiWNAEahQCKHwVieIM=;
	b=SZo5MvyEGiJFsSMEld+wGGfK0dr4R6MjwAhOR9DWre24ZAGNo4znKfpSrxZgEk3/iehZ
	 uPNzVLPaaENqPsqO6K/9pqr+Cm0ZcnXAQZ9VnLPZQtm/HMQY6e5Ax5QEJep2d9TKSJUPQ
	 QDMik425a/gRJJdvcNejDUzzCifgpeqOE0OGDzNe6u8pLY2KjILSFAGGjhHmuvJcbeMUi
	 6aVa6bkLFnkQq/bWr8vide24MvW04xFv8daSsl6CThd77O1rPcj723QSvh8CXD+CVqwNp
	 DFaFY/oZ2b1AzgDCbTHvxhTbLQk1ild2p2g/pn9F9i4LU3rct8OUfisgiRl6VFguZsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JQltiopw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316014;
	bh=yi+pQQqs7hlqNN4dA1J74NWYGmiWNAEahQCKHwVieIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ytii40u2/D5o43vjGDUgA/0Ep5lh2NU7NHVaAPX13cQblFsm8dKV/dKhac3YRpKpI
	 6hH6oaIN6PTKNPEl6vpp6dwOyzUsusC/LqbQO9q+ozn/FoHYgstNJRLuctH0y/R+jX
	 0cU/CEqp0qOvDDkHJwdbvNWDnBOc6Htr2sW9QMtP3qwf/MWjVOow905ANOrGf11TI4
	 /4IxUpg+GryuvDwWHprGuvNRSClpCvQD+tAN60dLgHqhLnTQ/+O62c3/9qwQgo7LA9
	 N+sUOYx5ddwcEvCbUiSUPnveWUsyQo2XzB6fHieYcgyaBnHUEnch4HrP/6zzA87MpG
	 iUhgvANAaLPIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EBDA81567;
	Tue, 10 Nov 2026 13:06:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 052EB2FE
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA8DD81111
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6cuI-a62Zko for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EFD38111D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=JQltiopw
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EFD38111D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5401516;
 Tue, 10 Nov 2026 01:58:35 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9052B3F632;
 Tue, 10 Nov 2026 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304718; bh=lO73k4cKDzAIZxU+cTLTSQ59eqgM2dt9dH8kOOAihuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JQltiopw0j04PqTM4J9STg25HLZ7ZbjM6uYcSYmXMqyYbpWdOK4Kw1075uhWYlj6X
 2KJXTdrFRh0pFFnedQzdrmHGB9egrD39RldVT4R3Rb2E6xBoWs2ubFvn52pwvc7xkt
 OYpJLEo8s2/lCXZMvEe3rYYkruTXVy+M4VscE86I=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 18/22] corstone1000: enable bootefi selftest
Date: Tue, 10 Nov 2026 09:57:59 +0000
Message-ID: <48a50ae8dc9f219a71171ea95958b600394f929a.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
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

Enable `CMD_BOOTEFI_SELFTEST` in `corstone1000_defconfig` so the later
runtime-variable selftest patch in this series can be exercised on
Corstone-1000.

Keep `CMD_BOOTEFI_HELLO` and `CMD_POWEROFF` explicitly disabled.
Enabling `CMD_BOOTEFI_SELFTEST` would otherwise make
`CMD_BOOTEFI_HELLO` default to `y` and pull in `CMD_POWEROFF` on this
PSCI-based defconfig. The intent here is to enable the selftest command
without broadening the rest of the board command set.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Reword the commit message around `CMD_BOOTEFI_SELFTEST` and explain why
  the selftest enable is needed on Corstone-1000
- Clarify in commit message that `is not set` lines are intentional
---
 configs/corstone1000_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 876b915b6a4..e16b13043ac 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -32,6 +32,8 @@ CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
 CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_LOADM=y
@@ -62,6 +64,7 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+# CONFIG_CMD_POWEROFF is not set
 CONFIG_USB=y
 CONFIG_USB_ISP1760=y
 # CONFIG_RANDOM_UUID is not set
-- 
2.43.0

