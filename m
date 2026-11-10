Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC5606B2E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M4CWm3F/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=szYnjGGN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF87F8168F;
	Tue, 10 Nov 2026 13:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Jn7JUu9prV3; Tue, 10 Nov 2026 13:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D587981664
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316000;
	b=SLPNjUcod854P6lgOxrg/VF4PFpcOYhf8C2yasQcxr0vfEWDDBkckc5+FLzXaC1buwUQ
	 oDgrc9Y+gI7JbJkiEPFlruYWXzUDZfvTctajcKfPqo6s9Jw7JHMILitQJclDcRAZ0Umm2
	 EFcz+DP7hRha+YoKRyEYVro4nav0ulWyhSPeMQZg7z+Vo/RJDQ3abSFNNzbrPG8+I7leq
	 nbo9Mz82Lulb9WSEPyWna7da/G7cTIdE6r+ZQpfemLaJzp+96SgU5VzBRn+2Ln7gVENLN
	 3hMUwLfA4FbbPAslYIWjrzQm8KF5xpmkq7BYYPUVThql+Oj8FhivWMtnSm1/dA/fl2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5DuBGH0WSi8C9AMUm8HusX5McqfV6H0o86jd4J60s4k=;
	b=g8Os3RHwbV6v4SmGswpBeQhpuWnszvkwNNNkUKjyRNrAkxmv2SOdQKvPOsmWp1J9vJ85
	 nL8WfFXzfXQkbStoWR64wd4+LEqkV0jCdEI8eJwW0UkTEgkDBPAtAbjzgTWSoJ3hO+0cQ
	 Gkys5varvQJjhs0+2rUAwQ46BJrwGEnXGXLsI/tIM4t110UZJPj4jwMMULtLi4zmAo6EW
	 6Eti7nj1nDY11yBEI9kAye93rDqvIefN3pqRvA08wlpdq3IZ1NOMeEpcMUi89E4hHwFXT
	 bjjjyGVQOl9xkI7ZEr5M6Cpq5/forMjLPhA9zhltJ99fs8GGqWY2BcDkj7Dr9suEmzw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316000;
	bh=5DuBGH0WSi8C9AMUm8HusX5McqfV6H0o86jd4J60s4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M4CWm3F/COoWpY+9cf92JuHmfZ0sAJKEcwOSKOpgFdmgTTfjRH9g1THtVvEU6LOdr
	 QflIiY70urDIcB9wcWgxobkyHSGj9PLjcNEZzC3WMrqKf0fcIyPRw3B8Y+xJAXOsZ5
	 QdxpoNVUqx414wB6yHqNNulPQ1eJnloS9+i2+bSsJUEyD2wXylpSQmWNRMtfz7zfbt
	 ETRB+FCXzZD/9m5Ux50JFrak/qCnhj0/2nyRMyTEO1kI9SAsINCshJ2AogEPQFqSDa
	 5vDR3gAri7T5KWJGIrn5ZNd2kbaj8ccsqalF08eoXaBTGbVEBi7swSbEg4MKpafbrs
	 TAp+pLbd70Ouw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D587981664;
	Tue, 10 Nov 2026 13:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2628F731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17DEA405B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwOVRSN-YdWP for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61968405AC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=szYnjGGN
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61968405AC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54E1E1EDB;
 Tue, 10 Nov 2026 01:58:28 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39AF43F632;
 Tue, 10 Nov 2026 01:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304711; bh=hyoU3vKMI1bn8KsVtp2lH0EwZ3JoXKcCeyGzcDbt91U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=szYnjGGNZjpf/LmmY8uJ3TkGhFTWIc74+ERCSGqe/yliIEYZNR6rJIZYJKqIriTVA
 5KZ32b4SObOdeMb9FYADYcPQ8wnZMh/u7f3M7ZKdFyT104f/XtTEfgo1+ah9xyujCq
 ehMEtFqpZV1ijB4TL8jmqSMaLbK+WiTWsiUKetm8=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 13/22] charset: mark u16_strsize() as __efi_runtime
Date: Tue, 10 Nov 2026 09:57:54 +0000
Message-ID: <df2bd118f6a45ba4175ccb61c4f4fde6557fab12.1794221712.git.harsimransingh.tungal@arm.com>
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

Mark u16_strsize() as __efi_runtime so it can be called from the EFI
runtime variable paths added for FF-A/MM communication after
ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Split the `u16_strsize()` runtime annotation to a separate patch
---
 lib/charset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/charset.c b/lib/charset.c
index 8ccac4048c0..8a9ca667827 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -408,7 +408,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
 	return i;
 }
 
-size_t u16_strsize(const void *in)
+size_t __efi_runtime u16_strsize(const void *in)
 {
 	return (u16_strlen(in) + 1) * sizeof(u16);
 }
-- 
2.43.0

