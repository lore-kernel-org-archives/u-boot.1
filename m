Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31688606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HhENgDJd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lcEhAjZJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B71640B04;
	Thu, 19 Nov 2026 14:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lnhQ9kiXB_4; Thu, 19 Nov 2026 14:56:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39CC640ABD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795100193;
	b=cxjxq17ADXBiIjUROav1VUEEbpSICOHiSMqyeBZsDTXADLTjXWaHwNoW+EL/dj+910TR
	 Qdp5yoqeOoTNNn865DwZ+CMaL0OuHKwclaLLDCjXTKRvRgsqsphU9HV0osiXVrPP53ihh
	 2cuFLz7giBRqZnNELUev3rOwf+kXv66ZMhlzWdK8rnsuBdx9/E4kpKGl4l8tw0G/76cHc
	 lZI/xa+HtnyCHWd9ewuC0MIj6ZQzSIZSJsZSvR+YTT+R7WF4HkUGDW/IogMqaGkhPP3jO
	 JDVfDL1VyiRFIx8VDILbtvldLdMuFlbeMFSW+emkVADfuMsGRvxmfosuA5V8NtGEkOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795100193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tJTuHal7lgu63SsmXaJ6aBEhmc4Iub5mNoRuovekXXk=;
	b=F+Y+XBpa3lRLRLwOQDuzc9LIoLiI43EQ7WBOIK1spsuwmSSsj6GgSI3Xj0VL9K2RRpnn
	 ztWShz4puVYkZZ/MG5FNgkywN1RRD8QxFXNFArp37RwcoGiWvRTpbcF2imxEdz3AFiKmy
	 WF9phIJ/gAzg+Si4UtEo+aiDbxZqQe+t8K5JfnA8xyGE1iFoolrApAeorABd8+dQJIIdC
	 lq3MeTEETileboEnoy3Uwf43FuIXaALhGiiP2FsiS14EO2JIAItdCPpJD5p4073awAgKA
	 M78soLCF0qR2CxPSvzKshe5NAS3QehhgOD9s6VXTWNrASR/99CnfwtVPpMZ/R5XBrwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795100193;
	bh=tJTuHal7lgu63SsmXaJ6aBEhmc4Iub5mNoRuovekXXk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HhENgDJdhZ4n2U/EASXC541KPbo55Es2kJICs/vtvkjnioLgVCl3172vn3qi9FH9N
	 1SGlPoXJmJI3yQZsMehroHjI36KAyoy1dkxC7uvZ7hKXF3Td6r27MKL8htJ8W25nCL
	 m4hWD6LYhccCBPKwOq89ls8TYO45BYWmllieMtjxUFz9a37J+0IlmDl4y77MmlDzat
	 5fHKzSbalrHgj9P6PfdGxX7VvsftcZfFOg9zPewlmyIR/ib9XW8cOZCMQiDIJUsIaS
	 Us5TuO6Vli3arKPeg1HSCoitNkBkxj//PPjGH87rR3xiBXpzZQIuaJFAqoyUkt02uO
	 eLIA65QG6uZZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39CC640ABD;
	Thu, 19 Nov 2026 14:56:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D68BE2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC8AE60D7B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:56:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mK6ei9dxgUal for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:56:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23F1460608
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=lcEhAjZJ
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23F1460608
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:56:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C389A1575;
 Thu, 19 Nov 2026 06:56:25 -0800 (PST)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37013F673;
 Thu, 19 Nov 2026 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795100188; bh=x3Ln1FJkgVTZtFO58NclDB1xhphC4GJXP7nCHiHZbZI=;
 h=From:Date:Subject:To:Cc:From;
 b=lcEhAjZJr9RqDl1HT5AS9qdjZuJKzZPr9z2wh6wAdf1Hrabw849wa+HmHu/okS5fS
 gomUJzALFn0c9pqcRWJ7wS0j0nf7hJZ0Su68NFaaaxjRkRb9dtKFmDfsVp42VmyK2n
 9x4DdWj9TkF5pDYlqnzczOLaPjq8A4MQfgg8Qln0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Thu, 19 Nov 2026 15:56:24 +0100
Subject: [PATCH] rtc: sandbox: initialize all rtc_time fields
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-isdst-v1-1-c57fb757e877@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4as0s9ZE22hwFbHQGoxFSQeRiLsrl
 l/yv3cBYyRkqMUFEQ9iWkKCygT4qQsjSuqTQefaKqUqSdzzJgtjHVpdemsKSO0acaDz+2na37y
 7Gf32juG+HwXcumhpAAAA
X-Change-ID: 20261119-isdst-536be628c635
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=x3Ln1FJkgVTZtFO58NclDB1xhphC4GJXP7nCHiHZbZI=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq/w4bpkfAm4BvK+/CyS0h44ImzvpW/S/qA7T3D
 rV+JnqyUqOJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCav8OGwAKCRDLSfhWdqMG
 lFIOCAC/Y1oljBxsQh35bzdsh1o8X+d90v0xVJFhjSFDET4oCLs3tL5DPyVGZg7w/tyJk9hXROO
 9zzekkcz5Vz2XD+R45GCeacih0ujNEgRzdQuCNh5Ama6Aujgp+rtblL2yF0dl/l6k5H2V4P3n21
 aIKyH2PmmddFezHE2zu664gZ/HwepK7GG3mhMdxm2QVJZC6XpCauliScs5UplJ9Sjla3EYYPhNE
 QIIK1XvvxcDtXM5FjYWDu+XU9tnjZaMCd+pvIFyrQT51hl1um2e1KN0Se3KX66NOZWSw8MO77PQ
 gPYQ04j3cxoBQaXJMhDQMuS0iOVOKUWMPHj71bLDkrY2zC+n
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

The get() method of rtc drivers must initialize all the fields of the
rtc_time structure, but the sandbox_rtc_get() function does not initialize
the tm_yday and tm_isdst fields.
Initialize them to zero to fix this, as many other rtc drivers do.

This can be verified on the sandbox with CONFIG_VALGRIND=y and the
following command:

  valgrind --suppressions=scripts/u-boot.supp \
  ./u-boot -T -c 'setenv efi_selftest real time clock; bootefi selftest'

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/sandbox_rtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/sandbox_rtc.c b/drivers/rtc/sandbox_rtc.c
index 1ade5d50b23..dfbfdd2763c 100644
--- a/drivers/rtc/sandbox_rtc.c
+++ b/drivers/rtc/sandbox_rtc.c
@@ -28,6 +28,8 @@ static int sandbox_rtc_get(struct udevice *dev, struct rtc_time *time)
 	time->tm_mon  = buf[REG_MON - REG_SEC];
 	time->tm_year = buf[REG_YEAR - REG_SEC] + 1900;
 	time->tm_wday = buf[REG_WDAY - REG_SEC];
+	time->tm_yday = 0;
+	time->tm_isdst = 0;
 
 	return 0;
 }

---
base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
change-id: 20261119-isdst-536be628c635

Best regards,
--  
Vincent.

