Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D245606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RXLI55yy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v6stMgJu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67E6160741;
	Sun,  8 Nov 2026 23:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbgBAEgbc3JV; Sun,  8 Nov 2026 23:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6F2760699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180861;
	b=H/wyVKKQ+IhERb3rkqs8mSkNle3H7fShwA3L6/e7SiSFZD4s468tPkeyMtCaBw+XDtQu
	 g6LfsiKkmAsRH5qCLh0jzBZZ3RK9Fx31RJ6zUCTQuFFnVX1n4qEOxVxiQT2OwG+2W08/3
	 a8b+WeqECTZYiwGjz+wZyCk6k066hAVR1Iwd9NYqkrEjvCpD62iU9I3XadykRzabN6dpn
	 UH4eGLWbZ16wk/x3Fg7ofzzXqXWC8loluqrqt71Uoy93hpog5TsFKwd60QWGyGR3bhGCr
	 vc7UODmr2waKxBJYNsMeDpg5mz3SAiwnagwjVA+XhqI4zPbqcthTEIV+EVh/nPkrIyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M9phLTMyTeHlxMQlgqp3stVbLJcWHFnkKqeD4OISAbE=;
	b=EOFoP4XkjEDFCRZG9lyAevF/muWpMiV5P6mPG6d2OcjJ8KWHsMoxcDkJTnLq+Zv1AeSE
	 Zvl9pqLh7i2FHFg7BIp5hkQQcGizqrBH9kr0DQlYqriDqUbLxvMraQbcC0sRtn4BRDTD6
	 lVN3gsfJdcvVpat1cU600f7sI4SFnnLLoaaFW28y8VmKrfEFq2nh9rk3xgkxLQlCeKojG
	 MzmYyoBsTKYDfWoqwGzXm2BOY7HVyZOxYKwKDp8rAK40C6/k0Cddt9eicm3/UXLvs/rof
	 KQtwb7z9ncu3TOzeg2T243uXYDj9gPQTSRr45bv2ql64MbxeJs23ogEAxeTKWaBzLXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180861;
	bh=M9phLTMyTeHlxMQlgqp3stVbLJcWHFnkKqeD4OISAbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RXLI55yy3kCqUBHldYhs4nz7GAeyeuu9UW+/xO1TnCYVoz6elpNHk9iwpB4VlMgbk
	 OK12MzLfz2iPFu6RnkYdVha0+O3M7tTkRW9hkLMg0+v1O+OsrDFHhTlaAplYfmA5Z4
	 NX6lNPq2X4+iaXPwUOeHvBUQvkseqr7wdcwaZes/fJCCD37Kvf6Qy8YVTXydlJWpYt
	 ZC78LPUnNMGEESS18/9e5QRPIvSl09TmEZNkoGaJQWekLUCehsflz3rChCf/CIWF55
	 TQS8aZxVx85PIfFTrVCx/veVmFFaD6d8e3OxWLc1karKZkAeft4VqpxRuwKTOqHK9e
	 x4dDtE/USJfuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6F2760699;
	Sun,  8 Nov 2026 23:34:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 924DA235
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FCAA4064C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHX0VVgpBNyQ for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F18D54064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=v6stMgJu
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com
 [IPv6:2607:f8b0:4864:20::132a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F18D54064B
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:17 +0000 (UTC)
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-37000e7234bso1137815eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180857; x=1794785657;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M9phLTMyTeHlxMQlgqp3stVbLJcWHFnkKqeD4OISAbE=;
 b=v6stMgJuzTCD82gcPM4cPCw93jUDtgxtctkEi6bTdnyZOO/uu5l7w7NUov/0NmK/zH
 eAhaOKChyesmGMEBQX9MSmKbS6SPP5001VTzbqfKNBIwb1F0ZlBsKfq+oXkQtAM+nlZR
 NX80ZwLYG4dI0n4Mm+/2OnpC2WSmkaaaSDtXQ3/MioLq4vH1Zh1pSdUgLjedONf96tM1
 EUi7AiYqeECRuTn4N13AsBBa7YP4ToaNtP5YyUNwDLZc+kV7dt9K+q0W20gWuCi7QKKu
 ign4v6oPjEf21ArBqmEbIVTuIVcMR/DeA1eScifQRglSf8/Pk69VkTF2Nk5HUWkcNNxz
 Icxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180857; x=1794785657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M9phLTMyTeHlxMQlgqp3stVbLJcWHFnkKqeD4OISAbE=;
 b=rx7VOT942zSATqRZihmxv64vfRtL3xUAVjvufI6XtfEB6CsBcOBtLB9MmyLI6bveoJ
 edNOjdPmhKYW9gVvmb6JNJGgtKwCRb4aEaMrwErUjlYY+8KnHnRlmoVWQUIpSqpq7X8l
 9oGOonPDZdp8sioNvdQ1j3BVEbi/12XloRhpXUcPtDeuCevYU4B9L3mVtvWSeq2gbK2i
 DuVBbaFph046e3uXAgJW1TVsmR3Z++i0DsoAQ/uIXUXVICqCoQinNOCy0T86f5CsGLyd
 cmsCVdOnFGtuj/1I+aKwkSsvOoFZme5/eLOZQD/HEqUsIkKhfgDHxG+uWDX1pxFUnkfk
 yReA==
X-Gm-Message-State: APuU4Z/mSQ7jO+CSqr1q375PsSp/D00kILwwv13GOyM8792FfP6kQgpm
 SvMSiYDsvEdBnFS++IOn/jzJ8OTpvGNJwiBmmfL9b9fBxEgk+TpEJ3RaqBetoHBY
X-Gm-Gg: AYBFou1BbvHUPVOiSMIzqOiH3GSPbTOLvvObXBfg9hrLx3xA3mT7rZgTE3NtqaO/iiA
 uGsZ0FXlIc9nJWwqSXSzaxVl2CbF0/5UyRFq+bvmPNxggHW8bdtQ4LShk8w54eX+paB0ttdkXlE
 Q7cggKbiNtHeJwtyH3R1ZL0SXCPottvVcOA94gg8QwVpEuut3RjuC0k/v8kLqcgxEqtaorHwXAg
 Tn8WgOM/UpXrdHIky5ErcwnQO1lG4n3us+lwEnCw3SxoIiXfNlYbo4HbL3pntxMlHIaos4AJl8I
 OiVU7grtxGd3fw231ia2v6wkXQ6Kktj1wmKbGrWcfblN5cl48LWDZqO53768eyHy02G4R5cx08N
 pbh5lIjy4VtoQq2SK5Cb3ovYtS3wEZS33uim+3k2KKWfNAWvw87vtIv8FEepS+E+tDUZF2sM8JT
 ZXZMCHC3ybG3PGh4UYqldPfpLmPqVfMtNrp8kq9wlmdBu/DzRF5mLbYUmG3aOvHqj5GQQDSTbJr
 cJGcCGb154HO8tq3qIg8o6PV2mq45G9LE5ElOjvzdMQsaCmb+8au57opycB3CEjodPMuKR1MHDo
 O0/TdvTfIXZfTgD/Yqdn4/5TDFBmTDOCujAZjb/ELUpU0vn/gvi3c70R0jfcIBad8fZEyYSaBpS
 fAF04qavZUKeFKacZ6yiwRGeWRg7MhwgU4BcZqxEL4HAFt+kwxYUYuuKzaq3CrAqkOqWng4LqBz
 ieWXyqdAdE
X-Received: by 2002:a05:701b:2319:b0:1b2:4188:840b with SMTP id
 a92af1059eb24-1b39feef9f3mr3788820c88.25.1794180856580; 
 Sun, 08 Nov 2026 15:34:16 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:16 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 3/6] MAINTAINERS: Add entry for virtio RTC
Date: Mon,  9 Nov 2026 07:34:03 +0800
Message-ID: <20261108233410.1556875-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6ce499d0..106218f0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1889,6 +1889,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio*.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

