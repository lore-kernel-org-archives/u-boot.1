Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC3606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T6amhBDs;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KdBcwdEz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31C4C80C9C;
	Tue,  3 Nov 2026 21:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kv10i6ZSVtVJ; Tue,  3 Nov 2026 21:26:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5671E80DE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741213;
	b=sWnVqzC0P6LRnOo1/cGrmgxefban2ijGZawOWfxauE4UCaZIF2cA6rCtSFSY46aprGnZ
	 liS+uwAKf8h3QYz8z1jJ+dUyJwjeMN0zRsbFDr9+YRoyJ8d7fFQK6UkP0vP9po+SRPs7t
	 AeAyC3GiEww1+Q4WG58Vsh+FL+J3WOtqcY0ynP3d/N/p41epEBKyAriMm5+G0ukR2emZH
	 o4Q3oABXlCQwmebdyV7EDa4krchHlNICz66DMwmiIZje0vndJRzQR9uFcDAxK4+mLBCvz
	 xRq4bvEVdv7XX3/0e2Wx+aW4LUVpZzOlQ1I/4wwZsOUvNWTWt+FsYi3Uw5dUh4t18ng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IPuuEjULbuYUZDIPRuwv0UK/8Sfo+17MeiC6M367bKk=;
	b=Lqab5oguWxU1UhwwJ0S1Klk18MzuywmUncymADYCOH88ibYSEG4o5Z82dIOSXLN0RRwK
	 uFbPacbCfaAD+URPojEcM69uSHLuvlHkkZNvNW0w7x7mOqqq1Ea7hxw/DGFH3cAelgzy9
	 hH+LuGJuTj2rNttG/NZL20QzHkLewHJwnsy7ZOpKTYGBrlghgrAuTFXsf5pzoiHN2jdKQ
	 UW30/9fMVn7mqP2emm4pNVYtgn045WG1pFXlJiORMqQj067ZEGs9Muykhpg8lHhPEzk18
	 BM/oaKKeHNRiZmCwrvHlnsC1Nr6DAvqXY18VVCGdTwGWTSIZR4egGH+nxpbeVpaBWjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KdBcwdEz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741213;
	bh=IPuuEjULbuYUZDIPRuwv0UK/8Sfo+17MeiC6M367bKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T6amhBDsrr0MoqO/7zP/sYtOVlki0JVJBkINeiNpYTfzZOH2KnqmkyhgNgLVlPchA
	 ML8omGbd4Kxs8hlrIFhhTgvFmRoHRq9C+ZEyV2h9uhmZVWYXcGxnQioAu9Jdw6fkMM
	 RTyDOM5lHWmRsQsFdeJuZ1xooe3jyaFZFdJygZBIuXaOZklMyEDkXtDFZDYKmdtV6A
	 Yw8mPs1GKMvuwu9WwuB33OUmIZvYu29yVPFgh/rCdatQOdXyf3Cw6JX9HyT3nCLN3g
	 7++eGUE7Dqd+oesynKK+AAcFwtWZu+Uydr44dJapWSGjHufUluZHv6CGJUS8LDFelr
	 JeWp3T7tCFr4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5671E80DE2;
	Tue,  3 Nov 2026 21:26:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B0632B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80E2580C86
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H1R2JZxcyVu8 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61E5C80C41
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741205;
 b=oiUBEkq5TwvgTNZ0zQBinFZRu6lYIcj2zjysRgqmGjcbC0ITNX08e5HusPbeVwXICdvM
 KRZ0WzxaoW+rXKJHJzZIy+rg8vFUO06jqBM2a9yofI484JW/QgSKdK0Zj+usaTNRIoj7U
 +8WUYIY3aJqBTBQO31chOouK9FNOlh4W/HbTlYmvhnJTUK6xj7xdpxWWaxgpV+l1LqOLV
 uNQZLbqks0YAyx8yXSkyUlk7ew4Xz5SJbZ94LJwHKTTBy6F4EBgSEHRwsydTY+cRlwIQC
 Dzg/RMuukO4PwLGuEe6Ssh80Suz4Cl2vlPojNviCHZJLhGqWFtOlcnkqxhjsTnK2ytQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741205;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=IPuuEjULbuYUZDIPRuwv0UK/8Sfo+17MeiC6M367bKk=;
 b=ICDTFeSz5fpylyQfK/dvG3MEBjNrwyjKjr3BAKw9OECdrO/3NXhfYtl/Ba6srCtPTY0Y
 kPyUrHsPEJgLzWfw3ev4K271fzeLCcVSWCN/4kDYjQNHK18lfrZxpyyAMeiv76lJGwvWv
 YtTIdjiCqo1PjWXr5iJ9DHeNNCm3ZPJT70jb4ROMrEyGxBNFVd3z7eYrjGhCFcWgA9Fko
 sDp/sU9IXA3GaBEVnBoI8raA03QrV6TnyLHYDi8tuUJapTEPB9ub1J+Xp/7tPMw/qcB35
 kZ1xKduEem3L3m1d26/mlhUiSdD1jpNhK5ygQpPLdqKyjZjrducG6NXDiqd6jnBgGvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KdBcwdEz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KdBcwdEz
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61E5C80C41
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:45 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-823e4047037so5078a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741204; x=1794346004;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IPuuEjULbuYUZDIPRuwv0UK/8Sfo+17MeiC6M367bKk=;
 b=KdBcwdEzyjGJAoGR7/C+PQYOEukgQAksKockJM8Q1+Omv4bhWN5a6D9s+lZbJbMwPP
 pfmq0QXbbnLreiqZR4pRggOc3oa+SnMHHzLT+53HEGyy10CFFIM1dG36eu639YM7BgW4
 92QbxqHzOXybj2rYUhYbtd046jOAb/rZMMLVaXnwbee0h2UFpB52AuYoxxIAQwbnZa8B
 B3ICuy38Mx4wNdKOoQt1OaftMVTd7aK3SuS2Gxg9YvlIC6OXm5pTIwLzgTXRP2qx0dfg
 k7tdszu0gKGvDaiKD6Sv0nLmVP/191nW2aKuqR713DJacti86abPYA9LaBfTcNPJs4L6
 rQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741204; x=1794346004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IPuuEjULbuYUZDIPRuwv0UK/8Sfo+17MeiC6M367bKk=;
 b=HcQV7ZxfVMB15RlrcymcspsrFJQshT8isMCsA5VvP8L5eMxYrTNFZrMFTWDfZGKWEz
 49PhLFSyPitBdBxa5HDPJmtpMxz5FBqPLHXbKP4+T3Zd+WP3haFGlZHs/EJbpDppyVb1
 uhEjy5nGNr/H+Mmxkil8l1vEuICgHuJ6c6TbEuhLle+rsoW2GsqPPv7v6bIQbTZnnwph
 vvT40qmt40Savanr1CoS7sgKVE1wLQIn2ldKElsT9lsknf4aexw/q+OnEBvHG9DnRo+n
 oLtcwoyVXsxqzrQBl7Rm1xCVFhhPDeV5ex6LtPVSEzCuifUlVIJyI7xSK3T6bYwrnaaQ
 qBmg==
X-Gm-Message-State: APuU4Z+gGHr1mBLUGbx/8uLkPd6IE7jTosJtrNjKjewqCyHBgAZCqBDF
 7HLHQJbQluWUnqHfowdrAyCEeqFn0LAkZ4xOvPmMrmfM0y1C/hQjG6LWLlQZfUjg9dU=
X-Gm-Gg: AYBFou1LbNHsyp2vJ4Pg8pv1fgeCuaWX59OcRlLKMKSbshc1S9T4EVyMsaPcqkj18eP
 r1md//JCjcXuznBgW3ThknJhSLuvKScbKNsAYzFaFzkKqpLNAu/fGMp7FCjOsk7R0gRbwg+L4tb
 lrH3DHdyvkcB3MMIUljxpGJomF3LJZUYT3MLMMUZwkylCuyTo/W/FQ01m4M5XxrwryLJvf9xad9
 m0KmlKCUhCTjMp/D0bg2GmPfLriJWoXLT+ar5usGDXrR5z457usPRrn5/DfCbW9URQkS5WiPCtm
 Vu004QjNVH1RUkVwrMzozjm7pF/UxabObxcitDTgi3z9sdhvuWBdSxTOLVJLU0jku8fxXITSzX0
 nIEkiwlnApBRxFdVZzo5rAKGt2MKYTElVHpL96u1yu+Vm6NjLlQJOuXIq+44zNFl407SmPuKuMG
 vzqPKF6tZIDfRJDpmSRPDS9cFQC71c0dTqybNXr7G+qJjIJll6pWCHHHF6jYwF8qDVLW3XWNJeH
 SX3CTXz2JkciM3ehtuMEZW2tfz7p/zsqYT056vrxqlpFpDrKkDiIMVaykuBGXI5ZRghfUgTzVm6
 bLLNb5PErD9Nzqael8JEWzmskFY8k7m2
X-Received: by 2002:a05:6830:6814:b0:843:cc20:9d07 with SMTP id
 46e09a7af769-85d363f05d2mr11518237a34.16.1793741203922; 
 Tue, 03 Nov 2026 13:26:43 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de203dsm289371a34.6.2026.11.03.13.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:26:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Nov 2026 15:26:03 -0600
Subject: [PATCH 4/4] spl: atf: pass the bloblist to BL33 in registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-spl-bloblist-pass-regs-v1-4-bbbbb7e65fdd@baylibre.com>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=bBf+kHfSUgc90/yLIygyfYtvUL2G7h/g+44x2clXQ6k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq6lGG7PfI9lKLQvgp1lrM+A/XcOyG9BbykoNnj
 OFSF1tMwQyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaupRhhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9cYH/jB4pBoJo0HyFBAGvpqs7/0X6v8qWZu48w/SgPe
 xj0shPam6a3HdSwb/2FHPKDz7+HgaMOi0iQjN3N5NAzKRCRZ82iKiLk8/CDxqdD0CSJRcCmrmje
 4osgO4sLDnrAzwE47tUiWwHZkocaIa69k0+Dug4y+pzbLTlYVbTFRNydrPJKxMbQ9N8TmCXsv6m
 EuoV2ER14HvlDiLNOjaUkNdvhbfQLKESeHUCJLjNrpm9dzzftrryh6+lQdaDSys5IdPlq8+GsMi
 imMTs62Aw+6O+qj2r0NZ924dksAQgI0RNFn0C7V2zhRAaa/Yv9zNJ83mCRgj6lE3zoMgOK/gYqL
 Cico=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Make SPL_BLOBLIST_PASS_REGS also pass the bloblist to BL33, which is
normally U-Boot proper, when SPL starts it through BL31. Fill in the BL33
entry point arguments that SPL gives to BL31 with the register
conventions of the Firmware Handoff spec instead of the primary CPU MPID.
BL31 passes these on to BL33 unchanged.

Without this, the only way for BL33 to find the SPL bloblist is a fixed
address in memory.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/Kconfig       |  8 +++++++-
 common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 02eecdb5c98..2ac885d31e1 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1243,7 +1243,13 @@ config SPL_BLOBLIST_PASS_REGS
 	  specification. The next phase then finds the bloblist without relying
 	  on a fixed address in memory.
 
-	  This only affects the default jump_to_image() implementation.
+	  When SPL starts BL31 (SPL_ATF), the registers are passed to BL33
+	  through its entry point arguments instead of the primary CPU MPID,
+	  and BL31 must pass them on unchanged.
+
+	  This only affects the default jump_to_image(),
+	  bl2_plat_get_bl31_params() and bl2_plat_get_bl31_params_v2()
+	  implementations.
 
 endif # SPL_BLOBLIST
 
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index c1233b54cf5..7b9b0fe096d 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -10,6 +10,7 @@
  */
 
 #include <atf_common.h>
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <image.h>
@@ -41,6 +42,28 @@ struct bl2_to_bl31_params_mem_v2 {
 	struct entry_point_info bl31_ep_info;
 };
 
+static void bl2_plat_set_bl33_args(struct entry_point_info *ep_info)
+{
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASS_REGS)) {
+		ulong args[4];
+		int ret;
+
+		ret = xferlist_to_boot_arg(args);
+		if (!ret) {
+			ep_info->args.arg0 = args[0];
+			ep_info->args.arg1 = args[1];
+			ep_info->args.arg2 = args[2];
+			ep_info->args.arg3 = args[3];
+			return;
+		}
+
+		printf("Warning: Failed to pass bloblist (ret=%d)\n", ret);
+	}
+
+	/* BL33 expects to receive the primary CPU MPID (through x0) */
+	ep_info->args.arg0 = 0xffff & read_mpidr();
+}
+
 struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 						     ulong bl33_entry,
 						     ulong fdt_addr)
@@ -87,8 +110,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
 		       ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
+	bl2_plat_set_bl33_args(bl33_ep_info);
 	bl33_ep_info->pc = bl33_entry;
 	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 				     DISABLE_ALL_EXCEPTIONS);
@@ -162,8 +184,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl_params_node->ep_info, ATF_PARAM_EP,
 		       ATF_VERSION_2, ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
+	bl2_plat_set_bl33_args(bl_params_node->ep_info);
 	bl_params_node->ep_info->pc = bl33_entry;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 						DISABLE_ALL_EXCEPTIONS);

-- 
2.53.0

