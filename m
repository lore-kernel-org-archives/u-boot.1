Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B9AC982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 13:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8D3580C64;
	Mon, 21 Sep 2026 13:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eEaDp3SLZiXw; Mon, 21 Sep 2026 13:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E89B180CFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789996375;
	b=quMpkB8wFCUhpng0Ou+6Jyxa5sie2q19dSXhyU0NGiT53+HIJmKpaKNLMZtQZVC8799W
	 KZqDNBYPA4KHsMDrMa4Gm/MkSu4L2hJ9z3lC3iggsoaNjWW+J1wVc8f6dkZpF4GEn+0XT
	 yPUgM0OYwBfI6P02gW2FCmbkAklOhhbSkdogr6y67LdtU74uFuAvNoN2k5x1jTDS3CFe8
	 QXP8EtB2BTNe3hLQz+Br9CW9gA02HTxIZeLCB0nFVSFEb9OtDih57ODgJOzxum355aDzo
	 BxFRXx9AgS8ORDSta7S7qKqN7RpdWCSD4P0OsXNIGP8vGfFUu8mCyL6CfhEYPjwf2aQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789996375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
	b=MRh3m1DTRNaZxUouTgeXI7M9xQag9H0HcN0U1HdNKUe41gbr/hIqtJHArGbXagqqQP3N
	 a+DrA2OuMNsyJ/rpTgpUNZZdjt1Ezf2xHW/ozgjc4bFXZn/6LhqlgMjPmsa+olQVpdFnR
	 apTikfdFju9fT0C0QWLK0nbXu51iAc/a7Njt+4C0yRFJM4zk81fHl3qoquq2Vz2ZceJRR
	 qGLt6DDjdAO2uG3lYowPnIxa3JyudNfSW30VheQmpL8Ra5ojnud7rl2gdBnEwPURTPHcE
	 siXamA+KWNW6b4fZvGc0o1by8qIsBAfCG7wCDgdEQom5c9QgecFLDQBtZ/40YZDtteg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789996375;
	bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GuPNGpFSpTQYH9si6Hpc5YS/D8pVfGSKoNCmne8f0Qa9ROOVfZ5ki7r8mx5sLEqSi
	 Uu9+R/m6q+anFeqdNQGETjD+ixQWZOfDerTknMnc9m6vtNsVJwwS8Or8m2Zt3A8PuR
	 yw20QbgyZ3legzmHmyWJG8ayOZsNZXu1XpotHq8n3uDA5ifFNeK4b85M+p7B8Ii61X
	 7C/vxNFj+esqWigLjt4hB1Z40QkirXccNmKSH59L3Kcw3IOW/HZz+QK0cHZpuwlX1r
	 Uh+EnEmK/sRFVlDT9dWGm5HX+t87nd6sBCqOceUGUXccoI1Hu8SiSzvg4L25/1u2ya
	 vhK1J7YXOWfNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E89B180CFA;
	Mon, 21 Sep 2026 13:12:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 891BE522
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 591E8606F5
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_P_dzAdt1aC for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 13:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E47896060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789996360;
 b=K9jdAapA4Qvjq0yvOsNIZXPpPyoeW5Ek4G4vKCXZPItPFot26tqvLf7kD8iqXLXK+kpz
 lZusYIm4uZvyz43IFRw3yksPway06X73SR28N0Mj9i1tjArUD2LHTOEacnQ2jZ5zZrJCe
 8o7VHnn3Ej8MCkich+9hhmhZ2dZjLRV9FaovmSLHRJeg/LSP8S87J3s2s7rwqquEPdkRQ
 y1dDse798Ytoy6RtXhIQCepVSiri36I3+7SiIAt2XL3bMgG3JYgFg8st7cuOuw2Oa2JWf
 l5P8MBg9CSGwlX9jCk3rdPdZVmLBUFnrSJH0xLsjuDrUek/gV1J9SzZd7Sh+xCXmUvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789996360;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=2QS8O7+uuJFtGRn7LRwfL9rHE2q4c85Z4CVKYb/KGmc=;
 b=RqiAS5NuL/IrcbqR+7zorCFOsJV23Xv4bHu3NFh5mdeeRJ1OpTLXyGFg8/w2x60Y7fna
 DTNEVOWuqCeQzIQeGtdtR/x1osMlWgbMw2XuYmgepSWR3xjrfcrj1EIuTijOwPd8l9owh
 s4Mr9Z/yx4x/+CmVr26p3wvot9+/UDKIHhc8DbZL3WPWnYGVgkOBBBUrUQO6t1l7seNtB
 musY4aXDuRW/X4G5vqqjQDvm8ir9E1KHwHFhh0+X4nSdVDLAg0mvMf5O8+KoONLFjMmUg
 u2/ct4fe06/tNlkyeKZM3sj+YvVYb1wYLJ4ggAZABy9S+KSaPiUtnTDAXpJWGVUIHDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=D28joQ8N; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=D28joQ8N
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E47896060D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:12:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E8E1CE0;
 Mon, 21 Sep 2026 06:12:35 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C653F86F;
 Mon, 21 Sep 2026 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789996359; bh=ptEepnh7FErnZ+6NMvzv9Ctc0RzYMMkJQpdmVpHa8Mk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=D28joQ8N34srLqq9cHGBzP5SEVe7ePD+0RIomrWS0i1ioaOgE6uplqOKaUJZJvHCB
 lxhKDqBUSeWQa6TbEWYZYuxMM6S+yIi/MTXh9/SYYZ5Umv5cE4xjRmsRSZIwIRq8cg
 8VW2FWZYRbf6GXR2595/2QrKQmtMylz9dl8aEUw0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Mon, 21 Sep 2026 15:12:21 +0200
Subject: [PATCH v2 5/5] doc: uefi: EBBR conformance profiles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-conform-v2-5-daeb00359af9@arm.com>
References: <20260921-conform-v2-0-daeb00359af9@arm.com>
In-Reply-To: <20260921-conform-v2-0-daeb00359af9@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2973;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=ptEepnh7FErnZ+6NMvzv9Ctc0RzYMMkJQpdmVpHa8Mk=;
 b=owGbwMvMwMV42vNHWNlitimMp9WSGLI26trYbZp4Wzpmt5JfN3/d9al8K819180oOsa+oYRf1
 Mw2rOdyJ6MxCwMjF4OsmCLL9QSRBX1RAYIFFVo5MINYmUCmMHBxCsBEBMzZ/xmYFbxh0NsSm+l2
 9JjJy01Os+xztwu3/WgQr3r6i7OwwKbCK0h82+rIjFifOUYhfvJnvI71cxbp+4YkVC4/Fh+/+eP
 SN8uYF59sXivgKKB39KRqdPtKzV/rdzfJnpc+YKqzbndUiwj3k59TArw7ZGpfTXxvdMxh9dG80m
 2l1c6PP9cvFshn3RQRE9rDJqlwxXOD9vaYXzPKK8Qkl3Qvn3Q0aF+FbPHixFWXrqUHyz++drJeX
 DZLzijmykvzd8s3TrOUmnJkeoMhO/PNzbUiMzM7pWqOaZXYC1dlbr4d0ZSf79+a4rZpiSLreUO+
 jT9t3H24E9wmfmEPaP7V/b9ZkeHRSSX35okOFlIKNzcBAA==
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

U-Boot can support multiple EBBR conformance profiles, and it can advertise
them in the ECPT; therefore, remove the EBBR fixed version 2.1 mention from
the documentation and add a word about the ECPT profiles.

While at it, fix one typo.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/develop/uefi/uefi.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..9dc34495f66 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -14,14 +14,23 @@ Development target
 ------------------
 
 The implementation of UEFI in U-Boot strives to reach the requirements described
-in the "Embedded Base Boot Requirements (EBBR) Specification - Release v2.1.0"
-[2]. The "Server Base Boot Requirements System Software on ARM Platforms" [3]
+in the "Embedded Base Boot Requirements (EBBR) Specification" [2].
+The "Server Base Boot Requirements System Software on ARM Platforms" [3]
 describes a superset of the EBBR specification and may be used as further
 reference.
 
 A full blown UEFI implementation would contradict the U-Boot design principle
 "keep it small".
 
+Conformance profiles
+~~~~~~~~~~~~~~~~~~~~
+
+The EBBR conformance profiles supported by U-Boot are inferred optimistically
+from its configuration and the corresponding GUIDs are advertised in the EFI
+Conformance Profiles Table (ECPT) automatically by default.
+System integrators should review the advertised profiles and override manually
+if necessary.
+
 Building U-Boot for UEFI
 ------------------------
 
@@ -323,7 +332,7 @@ Capsule with firmware version
 
 The UEFI specification does not define the firmware versioning mechanism.
 EDK II reference implementation inserts the FMP Payload Header right before
-the payload. It coutains the fw_version and lowest supported version,
+the payload. It contains the fw_version and lowest supported version,
 EDK II reference implementation uses these information to implement the
 firmware versioning and anti-rollback protection, the firmware version and
 lowest supported version is stored into EFI non-volatile variable.
@@ -1019,8 +1028,7 @@ Links
 -----
 
 * [1] http://uefi.org/specifications - UEFI specifications
-* [2] https://github.com/ARM-software/ebbr/releases/download/v2.1.0/ebbr-v2.1.0.pdf -
-  Embedded Base Boot Requirements (EBBR) Specification - Release v2.1.0
+* [2] https://github.com/ARM-software/ebbr - Embedded Base Boot Requirements (EBBR) Specification
 * [3] https://developer.arm.com/docs/den0044/latest/server-base-boot-requirements-system-software-on-arm-platforms-version-11 -
   Server Base Boot Requirements System Software on ARM Platforms - Version 1.1
 * [4] :doc:`iscsi`

-- 
2.53.0

