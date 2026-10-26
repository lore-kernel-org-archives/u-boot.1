Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RO9XBzuB;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=i/4pvcCa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25E5A80C1E;
	Mon, 26 Oct 2026 20:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ALF6gSuIG69; Mon, 26 Oct 2026 20:10:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D11380C17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793045459;
	b=BtY8ZFUZM95LfTI0ogDyZa4wmUc1guDK1PhALeRotsrR46kaICVd9/rBV7Utm7DNWBMB
	 GyIeoyKv6Tkv48n9ZSszSIEXWbEzQFMnh4nRUVNDOFRqIq+P6UzLvZUCFejf5YseXTSgB
	 Xdm78CyHCvN7Fvh3d0Ay2mmzELA5xsLTYPqKx3Xon/PSKaItv12FfCuWy7RpsBahpn8Qh
	 FXo0DeV+/vrH5dfbl1YckZq9KjsJQwXpZgHCdluQtpmMiTc3tuT4qAD7VEMar6mr7biqZ
	 tT2fCXfMja7XMaeNNSmpT89OCPM7c3b0FzwEkgti62aW3GM44fC+qz6gvMU2iyHJ77g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793045459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0EM0yl452rLvOFUZWuQW2IjRhwKe4rwFtkl8H+SQE8Q=;
	b=KeTtnzKkWQ4cPiLe+EZCoAn/ElOJDMK+9ortAKqcnRjgo1fpU5ZRXSWSxPU76PPZ/ObH
	 aFh9m/u+mUPOtZH9pH3lHG0wrxc7kRPsInuL6PIUwyJmeaDunT4OnWH2K60pxjltojLzY
	 8DmFtreqfprXfirSVYhuvk5R4InmVprDQWpcRsxrZtyQc56hx46kr+2M3r05OaMeMnE9X
	 W5kz0f04ScC6/ozIfGwEqcUTnRv0ilUS/gLdrE0khT2vBfRJBfWedFmfFQjO75i3xVCCg
	 21hTycqM6WBPTnpUyeh0QGqPa84BW/4lfMpVUMRIC9cgfTUkqhj6V7z7Lr1ctuSlPug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793045459;
	bh=0EM0yl452rLvOFUZWuQW2IjRhwKe4rwFtkl8H+SQE8Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RO9XBzuBx3+BnvgNZVqjiiiUk7479Pb9GQTFc5Aofs935N3biLLJn1i4XgypGhpuF
	 NdFgpAAZOGzcC4NIOqjQNznZC+wf+AXyRhbUQ6+sG4e3ZHvi5rVbJuzq86/fRjjk/q
	 y+z6bYmuPpeOp4x59Mp9I8wnza1yMMLaGdCrjTKvmkrbMRRH2Wir9/vt8DVN/hY9CO
	 B6p8YTm/JzY2UQrrpGjP439txxX1NwiQB7Qza2KU8pTIR106p7PSsQRe1QFdQ61PN7
	 jWqvlq4PF+kh4PpiojLPHCisoXfWZsIfTTllc01oesB2uPsDwGX96hevXCkctwUiNx
	 Qp8OknMXnzmVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D11380C17;
	Mon, 26 Oct 2026 20:10:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B560E35F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6E02605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsN7kko7x1t5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 20:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E091F605EE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793045456;
 b=Y5/FpSZjW8Mp0Lv0s2voH9Gd6Uo99JyJQR2gkw+CeLptQLof5MM4oo97YHGS9LDnhAqQ
 9F8JjAaBB3nhI3V7aoanldvF6zDjbgpaYzMvVkwDkEacKfzg6MXJnnqZoku1lK4V8ihLN
 hAz0/+c4P5neregU9JT+eFmrNI0u97Lwmu5jCaqSf3qP7Gj6Nng0Cha5zIfwRCmuKxgn6
 //wdqng4jgQInadDaQY5pfvKEdj/Bkyi3aqnAOtanaJjK5DaJh/yQ4g9FmN4Q9N1Wp/sQ
 xQwP1PTO5+Bt1uIhssuCe2Y2tRRdYqKdy3LjIeGkUjDeIGfJqGsum+US/8miT2mrUpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793045456;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META;
 bh=0EM0yl452rLvOFUZWuQW2IjRhwKe4rwFtkl8H+SQE8Q=;
 b=dqEO5NnVlgQSkGTrVJIKIcoeI7BoQDbKy1bQ7Lq1+9REioRi2OTurT9lt86DNW/XIzLd
 XCc53//Zx5Eu1x3t+yKKz5zJxBL0XoOaFhPQSHbxy95udsS0fUsmjOLHLUlODZ1FWKxJt
 Qpw7FT/A2Lme9UbAtPEYIni/9k1HJVtR83dKygX0yt0IaJ8znBtYWfgDnDG5XIEvEKpIR
 SKoTbIFKziNkHFt8DRBxQcXD+z9RTb93luJZz7yaHmOXUevPPV1/sJ7I2CGL8QqHPU5i/
 2YurqVaelPcaurAFBKBYtqtMIA2BBhvYJE61uv6acCsVD9hzs5dy3n61l76qq5qab0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="i/4pvcCa"; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=i/4pvcCa
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E091F605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:10:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jD4WH2b4BzMlQY;
 Mon, 26 Oct 2026 21:10:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793045451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0EM0yl452rLvOFUZWuQW2IjRhwKe4rwFtkl8H+SQE8Q=;
 b=i/4pvcCaFLKC+nyv5u/EBupusQBQheB5qo2N41p2LUYL4JU2U3Yc9E9830AiluGv048g5O
 dGOwCpFiGB7NglnO6kuli70WbH8gYcQazuhMXUIB3rLw6oneFNBpHktQplBLLwj+PYbjpT
 LqdkQG/YEPv98+FeQ2oOhq2Jjm4sI3BajGSkagIEfxRLjeaCbVjY+VqW85u/VfHSeyFFzu
 7Sb1zGaq4AshwJu8+ive/dSUop11FuCqOGqyAJYM0VQQqU4Qhya6rfheZS6UxWnYtUjATH
 KLZkqsNIQEC98gXr+KfakWrG+vQa+aQQWXkEyuW5XuLwy5PFvqDX9an1ic0lhw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] tee: optee: Do not warn about TEE_ERROR_NOT_IMPLEMENTED
Date: Mon, 26 Oct 2026 21:10:24 +0100
Message-ID: <20261026201046.400670-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 33dc627150e4c10e028
X-MBO-RS-META: m6kd8xfpomwzgmj9rhtg7mbndshs1deb
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the RPMB is not implemented, then do not warn about it.
This occurs with older OP-TEE OS 3.x :

=> mmc dev 0
optee optee: Enumeration command 0x2 failed: 0xffff0009
switch to partitions #0, OK
mmc0(part 0) is current device

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jens Wiklander <jenswi@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/tee/optee/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a47c76811cd..9b18310776d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -112,7 +112,8 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
 
 	ret = tee_invoke_func(dev, &arg, 1, &param);
 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
-		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE &&
+		    arg.ret != TEE_ERROR_NOT_IMPLEMENTED)
 			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
 		else
 			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
-- 
2.53.0

