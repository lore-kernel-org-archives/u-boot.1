Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E8606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mFi07ZI+;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=Er9gFCDc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E7646069B;
	Fri,  6 Nov 2026 07:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aw1hPxWV7SJ; Fri,  6 Nov 2026 07:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 962A4605F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950096;
	b=gmLTLkOhCyhbRSgDbHBINRSSiqBp06yfaR8uc2NfywDdhLYT/OT/a70K958vW31HerfC
	 UQmJT1y1J/NSIzaejn40c1+bWhLDNN55r9Rrd/nUFrE3mcKSbIg+xhGm8BUvFU1M+/OTH
	 44K8iZkwdMYStZXWkoz91uELzhHrs03a7xfNcAnEcD5SvYqwQuBXze2YA3EMxt+xJo208
	 Wap6LBZV8eKvXPdKg6ywxXl4Q3If18oShsePxgkY1qAAvocJbicf0v/UdILNDdMvfNIe2
	 OCDCCow7PsBEWLoEDXM6KMksLfdf9fHshmkNzgX0c6+K87h/H9BpAXDXcTRDSia8DSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+dIJzILRqjuRRAsNuujohm3QakI2eQ9SW/tTJyArGpk=;
	b=q3/wMVUtIqZ/KIYfdLhxdGNpXegLgxw3gQFfQWfqCfWnGH8LqVLqL+PgyS5ZTR1m0Ioi
	 guYkv9idNb75z0AmDIdvbro/VWwjQOOgkS48dWvsaQYVXAtggkisBJ7Vr3t+4e+QJzTQl
	 +Sp/tBLw2qWAv4rjRYqDNkxDuqU00M6Cat50gmnf0FK/pPmSD2kP1HM336FoyvEvq7OJn
	 Pb0XyCaXZ4sByOe1xE6rn6TiwZ5prFqLwj/g8CI0DU2ZMwRmwXS7ZZQhF12znvWlTIp6t
	 pjCR420zpYrEpZH3Jc1ocESAXHsNq6rleI9dH1qOHps85KKWyQa8XMljLFTrm/WgZtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950096;
	bh=+dIJzILRqjuRRAsNuujohm3QakI2eQ9SW/tTJyArGpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFi07ZI+fbPF/C3Wjaa2W/0A8/Wj9q/UL9+lrGPEG9cOpg56DZxRrPlCefg7PqLB/
	 WSrE9q2L1CMHvvHvbSL/kX5l2ALhLeCHailsTX9+10GxnhLuXHtXzoMNCGzOhoFHb1
	 6ZDPTToshm70LHysHgShDQLCYTjLQOdUmnoq6AMCZs3QPzuZD8nDL/QTIgokJKxm+J
	 KrBntw0plZN9dZqTOPOw9kJoncMYjrgHLVRqijqpo4g7+19XI3e6YJLXP6p93xWB+s
	 0mhZeMb0BLk/UAgjvtDYyUCB2vKo2hg8lI+YfJuaGdp9clIB2oI184bLTNWRR9GllG
	 knsP6MQggNwNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 962A4605F7;
	Fri,  6 Nov 2026 07:28:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9B382FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F83A81105
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQ2o3FSRf7JG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:28:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2BD3810B7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=Er9gFCDc
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2BD3810B7
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793950062;
 bh=+dIJzILRqjuRRAsNuujohm3QakI2eQ9SW/tTJyArGpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Er9gFCDcJjsqvNy+jpkIvHwOHqv9BCuAZ5FX2Q1U1mNf1RBojhMQkXA7tZ6jCBJAe
 ogdUVA5FBP45sc+pU8Qk9Nhlh/y/lh+vBCkP0HVIpyVqZ4vGYg/kgz2KpR1sNdslGz
 BIAgYG/P313R3Ep30M5eLVaasfwv4n2oexYmr27W8q74DQMDMF/oS2aMJ5h4kuKOtN
 oF255twTILKIZTW/jlw6S8fTDLhyaKyUTeaWHjjG9KmXQymQL9GJ+bYMnQsqyHhUdL
 MD0+lj/gZJA4N0F8WB5KEP04b5zNww8VPdnCgB9IdRbn2NNcKYFiTHq+iic8tZQvdp
 K5jaRSi3nAwwA==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id C6A3E5F8E9;
 Fri, 06 Nov 2026 08:27:42 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH v3 4/5] tpm: deactivate only unsupported banks before PCR
 extend
Date: Fri,  6 Nov 2026 08:27:28 +0100
Message-ID: <20261106072729.1714418-5-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106072729.1714418-1-tkirchner@emlix.com>
References: <20261106072729.1714418-1-tkirchner@emlix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at mx1.emlix.com
X-Virus-Status: Clean
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable
the unsupported algorithms") intends to deactivate active banks with
unsupported algorithms when extending a PCR. However, it calls
tpm2_pcr_allocate() with an algorithm mask of 0, which deactivates
*all* banks, including the supported ones:

  set bank[0] sha1 off
  set bank[1] sha256 off
  ...

If the TPM refuses this allocation, nothing changes, and the same
happens again on every boot. If the TPM accepts it, no bank is active
after the next TPM2_Startup, so nothing can be measured on any later
boot either. Moreover, the allocation is changed regardless of
CONFIG_TPM_PCR_ALLOCATE.

Instead, if CONFIG_TPM_PCR_ALLOCATE is enabled, call
tpm2_activate_banks(), which keeps the supported active banks,
deactivates the others and resets the board. Otherwise, leave the
allocation untouched. In both cases, the extend fails while unsupported
banks are active.

Fixes: e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable the unsupported algorithms")
Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tpm-v2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index b727c645d73..18ec9eb960d 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -362,9 +362,15 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
 
-		ret = tpm2_pcr_allocate(dev, 0);
-		if (ret)
-			return -EINVAL;
+		/*
+		 * Deactivate the unsupported banks. On success this resets
+		 * the board, since the new allocation only takes effect after
+		 * the next TPM2_Startup.
+		 */
+		if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
+			tpm2_activate_banks(dev, 0);
+
+		return -EINVAL;
 	}
 	/*
 	 * Fill the command structure starting from the first buffer:
-- 
2.47.3

