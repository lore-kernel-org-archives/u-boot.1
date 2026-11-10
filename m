Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E8606A7CC
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cYl8/A2G;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kU/VV1uk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECF34812E7;
	Tue, 10 Nov 2026 13:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hs5EC8ZpDRwV; Tue, 10 Nov 2026 13:05:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 378CE812F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315939;
	b=elp1Nw8px1+l9E4O4OLPcuzOcSLMbKZKQuTRcrS/EGHc1KD2U+nB1z9siFEySL7QO4N1
	 rS0o719I52UGDlxO6r02B6+x8pTUJdPh3YFzNTfdzB2CvDLUTTEWG3UB943JayNV+BF+r
	 cQ2aA78OYKEmO3weZVGQ4yiW8YKBA165vyNILdh1naB14j4IhorALXn41pW0RVVksk2nn
	 bOUpnysgcouepYNnrFHPwzqW00y3JFUuNoTOfwRZ/5A9LmfJ3d+IVCfFoMaEPSXXNUvPj
	 GPTWgnV+HngLBoaAB23cqIQhXNKIFMjbxZgZKtFd9OINBOckLzEomSJdNoP6CadDiLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=F9gGwsaSYCd8HEvxHGvZIMOoKEnY5RoJEY2vVfoxQRk=;
	b=T/KGIYrd929BFmNeJojncEuLj64zwPhL3NgPGBAbhb6nC6na7aHZwBHFVZVP0q28nY54
	 LZhjTAS3la4lMl4t8olFt0cN3WxED6b7ke7z/vs3iJi+DciyQsYpvlN8P0sGYZZI3Evay
	 JNmU2qdwQi4o6/k60a3e65ZMOFBxQP3gFUvgCI0o7F6dUT92NeaV74cLMwZwKy3Uai2Hk
	 KUR78kcXWy1OsaxJ5OLdxmdV4WnrsVHLH6N58x0ULvgzZNFuqkvFmtcja0G+9ZkvitXXu
	 gu80tufMaT9ut3c1BlfNTimizrzB5lTI+cqKBGc8A5YOx8sNJ3rxiog52zvP30F7rHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315939;
	bh=F9gGwsaSYCd8HEvxHGvZIMOoKEnY5RoJEY2vVfoxQRk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=cYl8/A2GN00B6EqKK71bTplbe1tESnHZncNh3ccIq73BhmUrBEanpsxiL+KazHQtz
	 LEV+hKDhK4q31QQjxHg7vjlv/kdiG3Xksx7tsJYw/lAig0j4g0rBayofWZNBfT4j7E
	 I3G+P3QtzXRpK6W+r5/IZXnYhpY141iEKYw0Bz5nG8la5D42kf8Mt+0NKQ1oRpZGyj
	 UwGK7RSmTSbk76m/VUYmm1+7WMulzyZa5NHXp0QGMWCbQHgckU5OwUC4vH3hF4Tye8
	 7FX5xCLnms2QACnYG8m/mTIL1gwd9qdZwnERbzRTxqXOEEQsXNDEeqlDixoclmPI20
	 BJd2UpCcbafPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 378CE812F1;
	Tue, 10 Nov 2026 13:05:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBE7EAF2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8FF2607FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lT0rcy0v84iz for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F26A760790
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kU/VV1uk
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F26A760790
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE98742B68;
 Tue, 10 Nov 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F55B1F008A1;
 Tue, 10 Nov 2026 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291577;
 bh=F9gGwsaSYCd8HEvxHGvZIMOoKEnY5RoJEY2vVfoxQRk=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=kU/VV1uk3dhq6zvMCtAKB2TWLRaYQCkmwOmsHeqT8qVnGmMqsLEEfKhzcPMkVZoOo
 L2doVcgokKdykC3/IrSpKw74drf2RN4umN56hreypTDYTH+jGyuFt/BdctVw59ZaJU
 qUM7KaOgFIjSkp3u3qD+M2UBLZhvSXAHHgW+9msRZV0LVJlvZ4o3O5uTtwLECvqm82
 clF13SvN+oofYE/QEUnIHZfg9FOqOwiCuxAwiShVxrJ0/G+74LMaHeTV/Cu5w4rim8
 ybvL2kHtyqH+n07swHyPeECEHK7Q7QB87z0W6w6u6r8zWUU0cpUy6DmDmckcowhCrC
 g3TcAAA2ROSjA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B4080488ED;
 Tue, 10 Nov 2026 06:19:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] sunxi: H6/H616: SPL PMIC access over RSB, use it on
 the OrangePi Zero2
Date: Tue, 10 Nov 2026 06:19:35 +0000
Message-Id: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3QwzQzPdouIk3eKCHN0kS9NE4ySLFFMzk1QloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loArw6r7HAAAAA=
X-Change-ID: 20261110-h616-rsb-spl-b95a3b8d564e
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291575; l=2079;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=aMnnAG5SZDw5T5D+CG0C0FFS+7JltfHPunUls57Ms9s=;
 b=rkt142fKq14S+nlyY8UKKi9kg/xHaSRtg28hoLPj1YLFEQUGedg+fO3EJFLjGhONPXtGDsmJU
 ekh4JWuEUHUCBaryzrixcUZFsmZI8pqKxxK4MO19tUFL93TTPfqNTO4
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On H6/H616 boards the AXP305/AXP805/AXP806 PMIC can be wired to R_RSB,
as on the OrangePi Zero2. TF-A then switches the PMIC to RSB mode (Linux
uses RSB too), and it stays there until it loses power. The SPL can only
reach it over R_I2C on these SoCs, so after every warm reboot axp_init()
fails with "Failed to set core voltage! Can't set CPU frequency" and the
CPU stays at 408 MHz until Linux cpufreq takes over.

Patch 1 adds the H6 generation to the SPL part of the sun8i RSB driver
and uses the RSB address of the AXP305/805/806. Nothing changes for
boards that do not select CONFIG_SYS_I2C_SUN8I_RSB.
Patch 2 switches the OrangePi Zero2 SPL to RSB.

Tested on an OrangePi Zero2 (H616, AXP305): cold boot and warm reboots
come up without the core voltage error, TF-A and Linux still find the
PMIC on RSB. A v2027.01-rc2 build with these patches (together with my
sunxi DRAM and USB hub series) also came up from a warm reboot without
the error and with 1 GiB. Build-tested for orangepi_zero2,
orangepi_zero3, x96_mate, orangepi_3, pine_h64 and Cubieboard4 (sun9i,
the other SPL RSB user) with no new warnings.

These patches were developed with Claude (Anthropic) as a
coding assistant: it investigated the problems, wrote the code and the
commit messages. I reviewed them, and they were tested on an Orange Pi
Zero2 (H616) as described above.

---
Arun Iyengar (2):
      sunxi: H6/H616: support the RSB bus for the SPL PMIC access
      sunxi: configs: OrangePi Zero2: talk to the AXP305 over RSB

 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h |  1 +
 arch/arm/include/asm/arch-sunxi/prcm_sun50i.h   |  3 +++
 arch/arm/mach-sunxi/pmic_bus.c                  | 22 ++++++++++++++++++----
 configs/orangepi_zero2_defconfig                |  6 +-----
 drivers/i2c/sun8i_rsb.c                         | 10 ++++++++++
 5 files changed, 33 insertions(+), 9 deletions(-)
---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261110-h616-rsb-spl-b95a3b8d564e

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


