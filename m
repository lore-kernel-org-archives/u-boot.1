Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EF606A321
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KqgousNq;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=lVQVy/ww
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0782E60E65;
	Fri, 13 Nov 2026 02:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FX-lHdcXIdvK; Fri, 13 Nov 2026 02:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5075260E61
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537199;
	b=UBzRORh6JIHjGTqdGSKbwRHzR3z8J6heWcAKIbO1Q7ErvbVajsJ667Sr+Vyg0pDUVwcc
	 wD+qR+cA8mTFPbOMngnOLRhKkDUjlEAekiHIEptGOXsvpA5ZLjHdTOKKL2upeYYKGWaWM
	 tOuD1P6VMMiLjbNjOa5FhsCRaMXVa+Ob/MW8WzA9hDHQt1f4bP3A81TkAYt8jK+uUITKA
	 70Xq8WAOs4WOHDWOHSpyrIR4Kjy3CzpU7ZFSNExmFTfH4TzZtpVHauiE+BDXbf/wCaVpW
	 VP5r6pjaSi2Vj5I+52KE0Yet2wkvRNjJkxeV68qGthtYcktNA50/fyd4JFFVw2J3qKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0xs+zHxPOFONK/Tkts76/lgClcstWnlzwZwlZLJEIkY=;
	b=c0jY79SepnbcR6UA6rYbklbcZgLfIShDFC1ShnR/H6rFIwbD+HoX4HwAH7wp22Droj9X
	 3NPIZRLcs3J3oovU169Vahg72VKc7o5wzZuPziE4kqGDx4lSvj93nEOPboYNnEZR8Vizm
	 7vLpBgVYc1r6tizXnTZfl8NVfCctpDsbCn+TKGK6pgm7+KC5mSHr29aW0Hx9Bvwa8+/bJ
	 SBvIlEzrq0nejhbuc6hYP02lfoozPqm+ZwIkQIRm1w52OFAGz9jlR95pPq4C8QRD5gMi9
	 jUf7rr64k852oDVYlEZvovRfK68lvv22BFu1qUrsgFEpcj7pNEmLj81cTExWIzGJnnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537199;
	bh=0xs+zHxPOFONK/Tkts76/lgClcstWnlzwZwlZLJEIkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqgousNqylkv7EGWZoTVUlE6/wW3FkH7Fp8KotOkcgeYy1f+DGpxhXeLisGq8LkKE
	 TZ6Qmwe2ueCTL1+wurS9k8sGEJ+/i8g4xaElSJA5T6CP3k0uBdznfF/RDKPvYRv5Bi
	 0f7cDuTMMpjjmLIftZ3lSBMuICIOElR8W0olek7M8OBBZzOf6C0cWgx25kIOJWz4x8
	 2t8RhBdjTG5uZ5A0HDhCJ3ZZ9d1xjU4DF2conyu0zq975+ax95FhANEmi1ktCOJifr
	 foI8jJfyWLrq42lqgB5LxpSJCV3dfTAJ2jLm2VJkKQw14aLzfU+K8KRBHjgS3g8yWg
	 VQGaKkcuwPkNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5075260E61;
	Fri, 13 Nov 2026 02:33:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 567D62E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CF5E400E6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aK7PBJa40pUW for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61FF140082
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=lVQVy/ww
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61FF140082
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:15 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id D6EA74572F;
 Fri, 13 Nov 2026 13:33:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xs+zHxPOFONK/Tkts76/lgClcstWnlzwZwlZLJEIkY=;
 b=lVQVy/wwKdMP7mMgqu78e3H6687NqF7qjR5dxagWbFjKudT8v8vOYFfrQuxd05AYWLulde
 zWatL+7BBW4FECjS+zgY4xT+KNCMpS2IYzRLmKYXca3SeXZhz/0R34CQ6qANGUSGNA67uH
 PUZl5U9OU0zthZ8M1avoR5+E8GtNSlMW44iNfFAHYheV/Mw8qPGG12981QTjjDo46j4TnL
 kra8gbYJ8h2TSgjIZplwTZZF0es7cdtZBw5t/lgEjPGEFzG6pzG0gaDxSBldpWtWTi3YmW
 n3MIh/LyaxGt25m+B4fDTfl49eGTxS3pn44HRLB4LHPSkVbFDsRDbZKNBujYIg==
X-GPT-Reason: This is a legitimate personal/technical communication.
 The mailbox (alastair@d-silva.org) perfectly aligns with the sender
 identity (alastair@d-silva.org), and the content describes a specific
 Linux kernel patch (mmc: sunxi) consistent with a developer workflow.
 There are no phishing signals, no urgency/fear tactics, no suspicious
 URLs, and the message follows the standard format for a technical
 software contribution.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 05/26] mmc: sunxi: Scale data transfer timeout with transfer
 size
Date: Fri, 13 Nov 2026 13:32:15 +1100
Message-ID: <20261113023236.569054-6-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
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

sunxi_mmc_send_cmd_common() currently uses a hardcoded 120 ms timeout
when waiting for SUNXI_MMC_RINT_DATA_OVER or
SUNXI_MMC_RINT_AUTO_COMMAND_DONE. Large multi-block reads at the initial
400 kHz card identification clock (or across slower eMMC/SD bus modes)
easily exceed 120 ms and time out spuriously.

Scale the data completion timeout dynamically with transfer byte count
(~4 ms per KiB above the 120 ms floor), clamped to UINT_MAX to prevent
32-bit truncation, and fix the debug message typo/format specifier.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/mmc/sunxi_mmc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 84f4e4c2198..12c92b1e2b6 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -417,8 +417,16 @@ static int sunxi_mmc_send_cmd_common(struct sunxi_mmc_priv *priv,
 		goto out;
 
 	if (data) {
-		timeout_msecs = 120;
-		debug("cacl timeout %x msec\n", timeout_msecs);
+		/*
+		 * Scale timeout with transfer size (~4 ms per KiB) so large
+		 * multi-block transfers at 400 kHz card-init clock do not
+		 * hit a fixed 120 ms ceiling, clamping to UINT_MAX.
+		 */
+		u64 calc_msecs = 120ULL + (((u64)bytecnt * 4ULL) >> 10);
+
+		timeout_msecs = (calc_msecs > UINT_MAX) ? UINT_MAX :
+				(unsigned int)calc_msecs;
+		debug("calc timeout %u msec\n", timeout_msecs);
 		error = mmc_rint_wait(priv, mmc, timeout_msecs,
 				      data->blocks > 1 ?
 				      SUNXI_MMC_RINT_AUTO_COMMAND_DONE :
-- 
2.53.0

