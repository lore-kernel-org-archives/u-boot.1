Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D37606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cp6mnFYH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WJUZF2XI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6C7640A06;
	Thu, 26 Nov 2026 16:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxN9-YvBIUeQ; Thu, 26 Nov 2026 16:50:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A492B409D7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795711827;
	b=jQ388zcGovLsUHvejMMKgqgQm+Kak9b5sGGu7X8pS0dZKcGMtIEut12QgGZZHoD2btlJ
	 MZVIDy7bcWQW6Q43Sl7PWj7YseDNEtLbSsOy/CnEssQW14xBPjc1v5c23K0Q7jdqD/UbA
	 T39xKxU7F/K+yd9bujnTXs7CfP6VFKSVCU1GRV0bhY42RpQ/ggQ9ERVABeLgdgDTiG5AS
	 OQw5itP3mFzyjycI8OBxzHxwIxXPFPD6aTMjQ3OfcvPQsEPulur1vqpPv54hA5SX++lSI
	 lNVJcYqez1+EAw9yZR/6DMKjXpYUqGtVfamKoFq3+y8ghjGrR0KFmWRNO/NXSHtjShw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795711827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1mcxbLRyHCqXk0pRH6uDX+r4T08rALYDr0pxGCeTaPc=;
	b=ey+YYO7gIHIpCuPQg0wcnN0N4VbuQ8NuRND0e3Tz3PnZfotpeplRN04yvbBPTGfWPQYQ
	 gXt5fQiV2OhwyEHwUVtqFxwTBSJw+EtVgOCorF35DMutEXAbpDjyxuGROv5Cn/qAZKUJy
	 rpQeapVvVejgYD8swYfpZnUAeEGJIGecYnJbqN8Qvysc+jihclcv6E3+XOmwPVFNMDvrL
	 TKmJwamj+jfvvtR0AN8flB+PSiicjxrSLQpSr55XzV4py/E5F0J6Nk+hJIv7yDJkPCNxX
	 8mw6LfvW8WWadoaAb287vjS/CH0knCtxw+kAsBuDD82MQdHgzvLBExFfTHXnskcIzTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WJUZF2XI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795711827;
	bh=1mcxbLRyHCqXk0pRH6uDX+r4T08rALYDr0pxGCeTaPc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cp6mnFYHYIGSIsEePs/lMquVjJoAWv6ikgJrp3o0p+JgauPZYQM70oG5WysEthI92
	 96WT5uha/BBCSOAO7huYZiwGLaNAhClqv3BPHj722vhF4AX0rWitLKHxzDQy8B7JHk
	 yG5dzsoCML+8fgxK7qNng386WRk2y6ftqvu9axjOKU7rm6dcVlXC+nniG3QUQpQvx6
	 p3oe3UymN/mJ4+qrmqov72VubzhFfJKzz/Qz2BxNXkDQ3rbg1sTtyXEtXw/aOQ69ag
	 v+BJrTGQRylTEgHQIyNdAW+c4ipaQmEkMkmKPxrmqktkNpu2FDvItvG5x2OidE+xEK
	 R1fVEfuK98VLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A492B409D7;
	Thu, 26 Nov 2026 16:50:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0E7C32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E251740952
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9SXiCzSgVZM for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 16:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 158364090E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=WJUZF2XI
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 158364090E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 16:50:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 860C01BA8;
 Thu, 26 Nov 2026 08:50:20 -0800 (PST)
Received: from [127.0.1.1] (unknown [10.57.18.148])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24053F86F;
 Thu, 26 Nov 2026 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795711823; bh=HHlRGeQaiNTo5M4fxI6/yjH5Mx0vfC1UfXgGVrcPFig=;
 h=From:Date:Subject:To:Cc:From;
 b=WJUZF2XIClgWeV7R7Y/QHRDo2Q7bSvzmtVFHapQYjyMS5mEVemP7AJZdHKLQCifmU
 jJqwGALjJk+JieCgyw59vaOQT18qTz7OvTpMFdObMir7K01toH968NtYr5X/lybpr4
 p1lgLQM48hpivrrq34Yus/32E6MsqXdby8nB5Lzo=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Thu, 26 Nov 2026 17:50:13 +0100
Subject: [PATCH] arm: adjust val to 32-bit in aarch64 longjmp()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-longjmp-v1-1-4ac5fd87653e@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBPUhVRXiRZpU42UhlYE4d2zW
 n7wv3dDxEAYoSluCHhSJO8yRFmAmXs3IaMhGySXSgip2OLdZNeNDbpGoyRXFWrI9RZwpOt7arv
 f8dAWzf7OIaUHcraG+msAAAA=
X-Change-ID: 20261126-longjmp-db9ec62068eb
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=HHlRGeQaiNTo5M4fxI6/yjH5Mx0vfC1UfXgGVrcPFig=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBrCGNON/lYbweYDssh3u108piX/8WiU4S4MPZS2
 Ppd0nkj9F+JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCawhjTgAKCRDLSfhWdqMG
 lHl1B/9syGakH8WZr20WBBcsDmzQEzug94Oxj8RH+owAvZh6SUgOt9kLWYTx23Fc7BUN1Y85uFO
 RBAYF7/ZKDYMxjFtizjTcuTu0EQ1efpmBEwySKtTAyj+y5fAnUq73AP5gj+646uK1D/EOpQMowW
 Ysd1cNT3A94LhRom2+RcJS0jRhEA30J0Q1MV6fcfDG/1WIM4rvpX5nOPBzaoMmNlTsL0JDNaDJ4
 jNDRjP9V1b7xQxfu2boXT41UyKW4CvsylZDlvaGsDQZZxo/hcp1nn0tKH3GmP/bMpaHvirrKmU9
 PE+lF/jZtiiotRHQ/VACL7yYYnormdRXRsn07oim826FeLWi
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The second longjmp() argument, val, is declared as a 32-bit int, but the
AArch64 implementation is using it as 64-bit.

The calling convention [1] does not specify the value of the most
significant bits of a 64-bit register containing an int, and they should be
ignored.

If a zero val argument is passed in x1 to longjmp() with non-zero
high-order bits, it will be erroneously treated as non-zero, and setjmp()
will effectively return zero instead of the expected one.

Convert adds operands to 32-bit to fix this, and also the operands of the
following csinc for consistency.

Link: https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#682parameter-passing-rules [1]
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
I tested manually with gdb on Qemu with the lib_test_longjmp unit test.

Also, I verified on Qemu that the following still run fine:

  ut lib lib_test_longjmp
  ut lib lib_initjmp
  ut lib uthread
  ut lib uthread_mutex
  setenv efi_selftest start image exit; bootefi selftest
  setenv efi_selftest start image return; bootefi selftest
---
 arch/arm/lib/setjmp_aarch64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 01193ccc426..d668cc102f1 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -34,8 +34,8 @@ ENTRY(longjmp)
 	ldr  x2, [x0,#96]
 	mov  sp, x2
 	/* Move the return value in place, but return 1 if passed 0. */
-	adds x0, xzr, x1
-	csinc x0, x0, xzr, ne
+	adds w0, wzr, w1
+	csinc w0, w0, wzr, ne
 	ret
 ENDPROC(longjmp)
 .popsection

---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
change-id: 20261126-longjmp-db9ec62068eb

Best regards,
--  
Vincent Stehlé <vincent.stehle@arm.com>

