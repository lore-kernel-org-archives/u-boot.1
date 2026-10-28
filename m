Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F48606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aNNrqnDK;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pk9Ltd5y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FAB28115C;
	Wed, 28 Oct 2026 14:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OuHZl-xiYGt; Wed, 28 Oct 2026 14:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B95181144
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198832;
	b=YGFPSs7/4RvHvuf8RJVPXz/0SoJRQC8QA2MGoohFlCsFOQSKqxEjxzaAoV9VVEyFrpSV
	 mujEZWBuJE7niTjmQq++mMR5Cm/xsAb/LCGoZLssDNu919fpkR1p6uY7LMb7aw3VSOWek
	 bBlSp5j5D8m3cjWH6oFBZQfiY/Mt+z9wKDPz/88aG9/SzW1jf6U/E9lhy08mt6gitmaDw
	 qZLEJIRv8nVB8EMVxwsPwXuNyfxmvK1eGJnTBPxukiQUUncFNbIaS+Abs29xU7pu6AWK3
	 tzalifn2gtZ0e+XLaXPnEPT+F1zxW+kVc0zW7GzYJ2EJS4QXD3U9mZ8663Awy1XlZXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
	b=YCm4SSCJmlfo0WzZEgzcGO3/Xg1ImD2rPAcgPhq6mdasyogGqR8qrEhJxyE0UQm8u9aO
	 pOXG/okxaUTrJVZw9hZ4kQeVtL4XLIlJFmRUgVWBfJajx1F3uqegSKGoiMGor+nsoAyov
	 7d+tUy+zrvL6mgn44A191lgZHE/aEzmSDBKWFHR8NbCfeb+sw0uQn37+P2X41IL8cHQpp
	 uKM0OahPmeWGraJyugipO5GWjnQ4P950rezxfNmIPTaSAnVsO7jN1wq8PASuMc0zg08dc
	 nQFoqJ2w1AZ86YDx1fuSJdrmVjWlpIOFIqU2dqcYiOdH2wqcFjCpolNnCx30NpMITmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198832;
	bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aNNrqnDKmh6wC/2jQcYKE4NlmMNooyybnzquV6899UsZCJli8m8Iwjo24faIptuJN
	 QvjHHMTZMsZicZvddtWN9OVIoa/94Wod+RD48O4X9oZTzOv4MF9Aq8IojiNf2uZ36J
	 1NOOOJhjhFwCV1tpiWWWagoLUckltnhS5mIPJoRTQFc1J6S0OmFYIyIedyfp75q/NB
	 +2xcXffqoINLTnFPzkXIjbi4gWzgqWbvwyqva4n8dArXCHHEN0SUZUzN/mOsXkVVcV
	 is79hjEtGdVMuh+CqyeQyq7YJe9J9bor+A5LdpaNCE/VE9b7Cu1Mfqe0DctsIaoglL
	 AHul9d9Tziddw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B95181144;
	Wed, 28 Oct 2026 14:47:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6EF8529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8C584009E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQKY1qe2EryR for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:13:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 86F07400DB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196795;
 b=GfzW4v5B43FkTKxkx/siLTJYVSlvE89DJouYHtijjf4CmLt3EZZk9MdCVgvWAuKF8xmb
 zukoTatCoTrsD7Ljc1RjYNnSoMBf3noB4qJE/wwJwJIr/C12kbUHLgAxlT8Sbd9woWzdh
 Et2eHQRHiMQCk4+co+89h3VSBsB+OSfXHADC1MESNK3dhcT1wcOly9axsIA53SfeaOgpH
 6b0ac0M64pWhC+rjcu4EGO0iQnIcrNC6Nak7fS/jc6FxW1p4uT8TQQUFw2sFWXYlP6o0x
 g5kGNOtncA2VfUfE34senaoRpKVh2+Fx/DbJ7P21c5mQETlRQTo3CWLp7yx/ph/C9uQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196795;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=owUX1dT7jJm0k/UmqwQSLjHRHyDvF0jqwkq6hNaDSjJx763vq/Ig7Ve0reFaiYtC3pVS
 p1sHrxzkO6mYjtsQb0hmDAvE0C38myXql3gBvdacTgV/7FhS4KYzpMSz4jD8pVjzujKVI
 2WunI7gcj4EowxdcSU38atWdjacCGKBw+zOfPmeosuB6JxZ7ytcHd0FR2+VAZ4l8wqCN9
 YFvVNp2yZjF6KQgMvo4jeFI6wzBUTiYreOa1A28GF+b99wuMPh8twsCAagB4cDQxEdcRh
 6E6XgbC+zTkGq08YPlmrBbl24JWpPPMPeVf1/1gwefOXJhNLdhx6yaGR8zt4wRjQzEA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=pk9Ltd5y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=pk9Ltd5y
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86F07400DB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:13:15 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c411b7a2710so12170466b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196793; x=1793801593;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=pk9Ltd5yCAcCw5a3vRd4T2VcWSl9GKd3Hf3pRJhVhpWDD3Jy2W5KgTuqSjUPp7+01o
 sywwhi7xRsyD5YaUoFNJ9Mfbnepd3O3kQTXHZJ8p8bNpf+se2C2DccDa+vjbQHd0YzK6
 mBOv3w+eP55NKwcrTHHqsEp02sCCi86+8PWLS/GxoUGyDc2lxbhruMuS8cOEoLL0dimr
 7gIDVKUB4YNy8jcCFmUqzzbbW722b71P1aIgHrZbj3MVSUzYafsqhOEyvxoHYzgFZJtC
 Wn4CXkcJb3BhZef2GWtbM2sdQr+ZASK5QqcjvQX50eMBCG6bhLtOUiaSlHmn/NOPC0kf
 o8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196793; x=1793801593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rNuvwm8gNtyEXa5FMKF6trIxPBkXqQXY01bOaHBBnmU=;
 b=2EE7zfCY7tkS4YW87i6+k6UCiIJVAgrHuukeDXgRsRj+WTT00ctMEF2zDG9gPDBtu3
 BCHcq6dAgUvUiCKw4GFrzkT2TLyy23uSNKY7Bth8fR5WxZKUA5RrEh31HYL2mXz35hhO
 mhSCpO14CKj0YtNFJ/oHuU3QZAnfBk4aDVBWdggWdFgpaTXXQBvLn9COFviy1LMrYqVM
 74pEZmBCqD0k8mTOK5sYY+mfN7C7NGgApstfkD/VUOK5OeqWH0Br5SfBozQGsPacxars
 ENrIQ/5Md0tBMOw4HmDmVs5hNEQPNB3McwBD1F+sL/HRPsKrMJx0LBsETZpvnvp4c64w
 PneA==
X-Gm-Message-State: AFq9FYK92MU3S61OwNXL+/2AXI6lXkdMrJsZXcSUj3J1HLRC7AWVe9AG
 mbUIKZbF928ipjgwfFB4VuMK4T3dXUA/uXIkTMDiLxWZ50mcxNNxN+LrAwu6U0/quyMNZd+dP6l
 s8qSB
X-Gm-Gg: AYBFou1Mru6O66qNLrXz0hQS6wlhpxKjK81SS1rQAlaOfnXEya5YzDkvdD7HmX1a+mc
 trTpZWSrW572jM6THuo+3tizT8oYh2EWwDPV2JZmRpYY/o5OB8DDS7z8fEf5bbcdUPenQApxgEQ
 FGxtMn4rqZC48eJpjLvGEGsTutHQ8M2s7s9ON+wt9tClQd5/Q1f8h3kxrVM6H6NmlAuZJ4iALjX
 ZZcnRZ/Sh4BDs7Goxu8ZIiQZAnVntjp3NnYyueBXd2FbJIM8OnnnBkQJSl/wkXNiZFmO5WgZnUd
 L1O03VT10ltbN8EUiMM8oIZDWMG/iAoNmrXIO+xLFDDYSs/dRqew9Lx4eWeymEmhDYM/UKvxQ50
 4P3QXfutanXch1LLNho5/JhKU4k4HBAUu/PK7kfIF9B/TtaIt+SfxhiGgFT0hyqsg4qERCvhKHE
 4PoXc2LSxKE8+2dZdiz8DP/q1Pd35Dw4Lb+BYnb6x9ggzwdS8rt/t2wFEplZsWpNmM9jNpwvvyX
 nKu/w9AEnveyrdKqrT3eKG39aXl0xH8JbG54lGyBCkuV0sc1DpLx/RPje9HQcdW51hBI6Id4xXj
 KKq7qjVR1hy7U+pwrOfZo5UKzxdYFYe8BL1kqM1lM/RPr6TbQ2dPcBxAXT9KfpJHmYmPp7QaVBO
 oWi4qkYqjJA==
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr310066066b.4.1793196793123; 
 Wed, 28 Oct 2026 07:13:13 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd350c61sm612006966b.11.2026.10.28.07.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:13:12 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 42/63] usb: dwc3: import from kernel v5.17
Date: Wed, 28 Oct 2026 15:09:08 +0100
Message-ID: <20261028140930.3025368-43-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.16 to v5.17.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.16..v5.17
Commits imported:
84918a89d6ef usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
117b4e96c7f3 usb: dwc3: gadget: Prevent core from processing stale TRBs
666f3de741f7 usb: dwc3: gadget: Support Multi-Stream Transfer
76c4c95dac0d usb: dwc3: gadget: Skip reading GEVNTSIZn
a02a26eb0aea usb: dwc3: gadget: Ignore Update Transfer cmd params
bc27117c7cdd usb: dwc3: gadget: Skip checking Update Transfer status

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.h   |  9 +++++
 drivers/usb/dwc3/gadget.c | 74 ++++++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5c491d0a19d7..e1cc3f7398fb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -153,6 +153,7 @@
 #define DWC3_DGCMDPAR		0xc710
 #define DWC3_DGCMD		0xc714
 #define DWC3_DALEPENA		0xc720
+#define DWC3_DCFG1		0xc740 /* DWC_usb32 only */
 
 #define DWC3_DEP_BASE(n)	(0xc800 + ((n) * 0x10))
 #define DWC3_DEPCMDPAR2		0x00
@@ -382,6 +383,7 @@
 
 /* Global HWPARAMS9 Register */
 #define DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS	BIT(0)
+#define DWC3_GHWPARAMS9_DEV_MST			BIT(1)
 
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
@@ -558,6 +560,9 @@
 /* The EP number goes 0..31 so ep0 is always out and ep1 is always in */
 #define DWC3_DALEPENA_EP(n)		BIT(n)
 
+/* DWC_usb32 DCFG1 config */
+#define DWC3_DCFG1_DIS_MST_ENH		BIT(1)
+
 #define DWC3_DEPCMD_TYPE_CONTROL	0
 #define DWC3_DEPCMD_TYPE_ISOC		1
 #define DWC3_DEPCMD_TYPE_BULK		2
@@ -888,6 +893,10 @@ struct dwc3_hwparams {
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
+/* HWPARAMS9 */
+#define DWC3_MST_CAPABLE(p)	(!!((p)->hwparams9 &		\
+			DWC3_GHWPARAMS9_DEV_MST))
+
 /**
  * struct dwc3_request - representation of a transfer request
  * @request: struct usb_request to be transferred
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7e3db00e9759..a0c883f19a41 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -331,9 +331,17 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		}
 	}
 
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
-	dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
+	/*
+	 * For some commands such as Update Transfer command, DEPCMDPARn
+	 * registers are reserved. Since the driver often sends Update Transfer
+	 * command, don't write to DEPCMDPARn to avoid register write delays and
+	 * improve performance.
+	 */
+	if (DWC3_DEPCMD_CMD(cmd) != DWC3_DEPCMD_UPDATETRANSFER) {
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR0, params->param0);
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR1, params->param1);
+		dwc3_writel(dep->regs, DWC3_DEPCMDPAR2, params->param2);
+	}
 
 	/*
 	 * Synopsys Databook 2.60a states in section 6.3.2.5.6 of that if we're
@@ -357,6 +365,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		cmd |= DWC3_DEPCMD_CMDACT;
 
 	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
+
+	if (!(cmd & DWC3_DEPCMD_CMDACT)) {
+		ret = 0;
+		goto skip_status;
+	}
+
 	do {
 		reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
 		if (!(reg & DWC3_DEPCMD_CMDACT)) {
@@ -398,6 +412,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		cmd_status = -ETIMEDOUT;
 	}
 
+skip_status:
 	trace_dwc3_gadget_ep_cmd(dep, cmd, params, cmd_status);
 
 	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
@@ -1260,17 +1275,35 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
+	/* All TRBs setup for MST must set CSP=1 when LST=0 */
+	if (dep->stream_capable && DWC3_MST_CAPABLE(&dwc->hwparams))
+		trb->ctrl |= DWC3_TRB_CTRL_CSP;
+
 	if ((!no_interrupt && !chain) || must_interrupt)
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
-	else if (dep->stream_capable && is_last)
+	else if (dep->stream_capable && is_last &&
+		 !DWC3_MST_CAPABLE(&dwc->hwparams))
 		trb->ctrl |= DWC3_TRB_CTRL_LST;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
+	/*
+	 * As per data book 4.2.3.2TRB Control Bit Rules section
+	 *
+	 * The controller autonomously checks the HWO field of a TRB to determine if the
+	 * entire TRB is valid. Therefore, software must ensure that the rest of the TRB
+	 * is valid before setting the HWO field to '1'. In most systems, this means that
+	 * software must update the fourth DWORD of a TRB last.
+	 *
+	 * However there is a possibility of CPU re-ordering here which can cause
+	 * controller to observe the HWO bit set prematurely.
+	 * Add a write memory barrier to prevent CPU re-ordering.
+	 */
+	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	dwc3_ep_inc_enq(dep);
@@ -1513,7 +1546,8 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * burst capability may try to read and use TRBs beyond the
 		 * active transfer instead of stopping.
 		 */
-		if (dep->stream_capable && req->request.is_last)
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
 			return ret;
 	}
 
@@ -1546,7 +1580,8 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		 * burst capability may try to read and use TRBs beyond the
 		 * active transfer instead of stopping.
 		 */
-		if (dep->stream_capable && req->request.is_last)
+		if (dep->stream_capable && req->request.is_last &&
+		    !DWC3_MST_CAPABLE(&dwc->hwparams))
 			return ret;
 	}
 
@@ -1623,7 +1658,8 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
-	if (dep->stream_capable && req->request.is_last)
+	if (dep->stream_capable && req->request.is_last &&
+	    !DWC3_MST_CAPABLE(&dep->dwc->hwparams))
 		dep->flags |= DWC3_EP_WAIT_TRANSFER_COMPLETE;
 
 	return 0;
@@ -2638,6 +2674,13 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	reg |= DWC3_DCFG_IGNSTRMPP;
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
+	/* Enable MST by default if the device is capable of MST */
+	if (DWC3_MST_CAPABLE(&dwc->hwparams)) {
+		reg = dwc3_readl(dwc->regs, DWC3_DCFG1);
+		reg &= ~DWC3_DCFG1_DIS_MST_ENH;
+		dwc3_writel(dwc->regs, DWC3_DCFG1, reg);
+	}
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -3437,7 +3480,8 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 	case DEPEVT_STREAM_NOSTREAM:
 		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
 		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
-		    !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE))
+		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
 			break;
 
 		/*
@@ -4067,7 +4111,6 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	struct dwc3 *dwc = evt->dwc;
 	irqreturn_t ret = IRQ_NONE;
 	int left;
-	u32 reg;
 
 	left = evt->count;
 
@@ -4099,9 +4142,8 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	ret = IRQ_HANDLED;
 
 	/* Unmask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
-	reg &= ~DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
@@ -4118,9 +4160,11 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
+	local_bh_disable();
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = dwc3_process_event_buf(evt);
 	spin_unlock_irqrestore(&dwc->lock, flags);
+	local_bh_enable();
 
 	return ret;
 }
@@ -4130,7 +4174,6 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	struct dwc3 *dwc = evt->dwc;
 	u32 amount;
 	u32 count;
-	u32 reg;
 
 	if (pm_runtime_suspended(dwc->dev)) {
 		pm_runtime_get(dwc->dev);
@@ -4157,9 +4200,8 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	evt->flags |= DWC3_EVENT_PENDING;
 
 	/* Mask interrupt */
-	reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
-	reg |= DWC3_GEVNTSIZ_INTMASK;
-	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
+		    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
 
 	amount = min(count, evt->length - evt->lpos);
 	memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
-- 
2.53.0

