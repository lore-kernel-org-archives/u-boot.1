Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2885606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oME+XuG9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oo05Mkqq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9010660743;
	Thu, 12 Nov 2026 16:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvuifnpcTqOz; Thu, 12 Nov 2026 16:55:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D27E1608A5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794502549;
	b=D0LlYluSfCDKQzmQ3VhW63ZOOzuChNT3djIDs4FA4mtVdvO9TzYnWUnyLkojOucS5LDz
	 xt1qcLp2wr6PPP1tc6EnhAT4FCEYNkQjKDm7bvOEx1AqLq9Lq9dM1V5ArYgSh16y2AqDG
	 IXV1On6SsEsom1aTbbRQfVRlTyPqseZJaqExPQU88wZUHS0M2fcsL0U0Hmjzhoy5qYzUD
	 66UOnNSHAuN80NJVcBQ3X4i5OsZITeMsOp2jqBQycnqh/TuvUK4Y3j7vWbytTaJpHOv82
	 zM4njs0luGVpQA+y9NvP1wM+FXYlTZ/+S0oTjq9sIQFPsjebMAylxWZjmxX9qd8sw8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794502549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hqDKFI4BWqt6d+cBv2Ngh3k7G1zWEIQx2VUo7xzzbuw=;
	b=n8mdycmmad6udtbA9fLFvdbjANolvZM4x7sFM/4kYWdCDFFVzd5LS9qCkB4ZgzhGHcpD
	 pJnlnz6a7JaJu4/tokd/CPOUv3gz1WneCdX87eL29gjE3ekSsxXGLt0k7t7RBPNiuZgqc
	 xO90YMWVLBtbgTcuHOnFG0eyZu9eZE9rLddGkZm2Hcb+EZMlQapY4Y5Bv8UZ8UtLRaR/2
	 dyB69H9WG0Y41E8Z7tWdccYm8rBXfpQfVqI3oF4clDluLTyvM84JNMmUVqaw2ncZgLO+F
	 H8c939ksSReKMzFK7bNqGBDdXqKFeNmZFrByZHYJhu+HQvxijdoYYXZXQvkOgYOFMlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794502549;
	bh=hqDKFI4BWqt6d+cBv2Ngh3k7G1zWEIQx2VUo7xzzbuw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oME+XuG94D6z/sX3yeE+b85vJbs2WUQFhl3ssyvq+0+pwVuZI6un8hsDnAljhkUc/
	 4BCqTc7gb8jdVAtvD/dI3alU1dpnp1MbRWA8x620XHQPtvgsAbZtw/+92gqXmTs+Y+
	 EDNLagY2e3yfnh4DlZ8Zc42hZAhDnkVoI+olHL5hI5PdNmHag+g8sGPoVbTQCBTkIS
	 myPQCcbr10tD2lta9N2AH8gqYn1VuaVAj0W1BdaU7XsOM+M5WbYq3WHqDKx9z20deZ
	 zwrRTRY9/ZCa0O2/RuIbxw9o8wn4mQgBmKyB3lIm9U/gF7lcqN0753ytq1zy99MscP
	 71arm3sRzTm6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D27E1608A5;
	Thu, 12 Nov 2026 16:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 749BEE09
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65CEF40AE7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ddg_s95hUV_X for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98CCA40AB1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=oo05Mkqq
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98CCA40AB1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:55:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797771516;
 Thu, 12 Nov 2026 08:55:38 -0800 (PST)
Received: from [127.0.1.1] (unknown [10.57.16.216])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D91D3F673;
 Thu, 12 Nov 2026 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794502541; bh=QRBmkaP16QJyS7Uk4Un0/IjRDmDyJs8LwOLrF0d5nGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oo05Mkqq2//1Ysx5aVKBK6vXtYOCFNIXbYSt2vnCsIM0VwSYN6uunv3/DrLgKJLxJ
 UET37B3nrfk7VGsqw7sXQAaUtDtRjt7k/584Gbdle4ltRGAyP6znwpSeCqn4Im+wHN
 BfCo0cG3GPslb30Rmy5TlRj+7P5at6tEpQ0/eN4k=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Thu, 12 Nov 2026 17:55:34 +0100
Subject: [PATCH 2/2] efi_selftest: verify getinfo() returned buffer size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-getinfo-v1-2-b7eb8c837985@arm.com>
References: <20261112-getinfo-v1-0-b7eb8c837985@arm.com>
In-Reply-To: <20261112-getinfo-v1-0-b7eb8c837985@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=QRBmkaP16QJyS7Uk4Un0/IjRDmDyJs8LwOLrF0d5nGA=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq9e+IL4/xt5mVp6Jh4jPIo4a27WMpz5WnUHH4S
 JA3mqKMTGKJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCavXviAAKCRDLSfhWdqMG
 lLppCACsoAeB9ycym08k7XfTAXbniWZ3ft2l71//eoHDVVXO62DiaqoSvjWcvvKRNjytJ1vscjh
 74KKDUFEhIRaeXAU5oZEp5nPYb3FEosHOT2Jl9+stgA64iUtZt0p+N0halb9BcwUfMosnt5BJ63
 9OxWE+eyml9qdHWc1gzVWKx/UaUESWaVTy6cdCGSN44NZ4vyWBOPSXhtBWIjU1RDl8y56KUYBNT
 NC0X4ZAj11QatKLrSSHmZ1Z2xLnumvL29mYIL6bdL2L7CtgMyurOnOSdU/GjzupdFGpEqUnMn4O
 IzhT+ZJ7t9m6C1+dqKJmsMWXNfkUc6KjOZFgE4tRkerJWyXg
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the block device selftest, verify correctness of the buffer size
returned by EFI_FILE_PROTOCOL.GetInfo().

This can run on the sandbox with the following command:

  ./u-boot -T -c 'setenv efi_selftest block device; bootefi selftest'

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_block_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_block_device.c b/lib/efi_selftest/efi_selftest_block_device.c
index 847d93693ee..ae064189603 100644
--- a/lib/efi_selftest/efi_selftest_block_device.c
+++ b/lib/efi_selftest/efi_selftest_block_device.c
@@ -467,6 +467,12 @@ static int execute(void)
 		efi_st_error("Failed to get file system info\n");
 		return EFI_ST_FAILURE;
 	}
+	if (buf_size != system_info.info.size) {
+		efi_st_error("Buffer size %u differs from info size %u\n",
+			     (unsigned int)buf_size,
+			     (unsigned int)system_info.info.size);
+		return EFI_ST_FAILURE;
+	}
 	if (system_info.info.block_size != 512) {
 		efi_st_error("Wrong block size %u, expected 512\n",
 			     system_info.info.block_size);

-- 
2.53.0

