Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A05606A320
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MaRNAgGk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbskNZEa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2F1A80F55;
	Thu, 29 Oct 2026 13:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 542PQBZHy0pB; Thu, 29 Oct 2026 13:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 225EE80F7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793281662;
	b=EE1BFVBmdDra/JBhZmRjYC73Pj0lXTDLQUc1ZEkZXXw1iRaZJRP+KX2QkzE6u19+p5yJ
	 8BDOp+eboLLmtIZW9AgFVautoqwaHoq0MqAL1Nbq/RmTGdY/cfV/PsQQQjlGtansWkHHg
	 G/ZLN2KfSHUas6NKgHj4Xk7IkJQrlentwF2Ci4jN4+KJtmE2fHBbvyUhSwTYkSDguOfPT
	 7usOA3EOmK11c23sb7HmzpKmWtcSqxgo5NfBVYSg6YrT+ht4m0sPLg2XkIb/rhQ6FAFxu
	 or+P8N0pw9cYoXp2i77h9PHBQm7ai5IbQ9VLiynfc/2mcFnEn7ucAQeIKjU2AToGYcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793281662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9VC/rzIZoDrmXajnR4OE0bGx4PGggs4BECaPWHwkHTs=;
	b=EL9J434Kn3sUSrVkIMtCRZj3HEF79xAeNkkdzLeXSzMeg4OfYzR9PMZtjzSWVTL2h0P2
	 PM/8HKTkwbEbT2hRHtR4AvbPOmflwrYW25sVxVlQ+2crcuSek7rMfqbIILNig5R8YwFqf
	 FdtgLZ5esnxOFkUzsBjrntXQE2DfJGXfyuW59vuNgGFqJ92CH7dgrbuvAkyzajfjyqf/I
	 u/vWCAkqZgnUMA7l5yLkxwbusQHPyz4TrTlFchixJNKRCKjHkEw+zaAP+z8RYIjabYRrt
	 erbedvztALtx+aZPVNfmUUWpgrDIiHoKywfMaZIYjcdi1VP6iETwYwIlLO+BIAyzriw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793281662;
	bh=9VC/rzIZoDrmXajnR4OE0bGx4PGggs4BECaPWHwkHTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MaRNAgGk1C2FCesEGkIsIRq4nExnyasrQFnnsvxGtoM5ExZeGCm3XhQ0iZH/SklHs
	 MwIXeUMEZpzQtk9sreARBzZSsQakwWgrUOu5hX+4xS2MofBKauZS1ahv2cynLb3kRn
	 1nFT1qiJSSe3TuQV93qi591x1EWyxnqdVh3aqBi4R8xZlMuZYIADiW/F/fMnz+alRD
	 MJ5UMmkC/qHuleOVnkEPu3RpEzvUBsaFHS+z7rM9zWqHyQpG7OniIpdppj5HIeGLwg
	 0wacTWmt/ebsII6s0eClS4FYwAAXMSErChblEsCtcDPpMXZl8lN2ETi6+Ac+GeDuTg
	 vIc0+7OvjkY4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 225EE80F7A;
	Thu, 29 Oct 2026 13:47:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 912A7972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 779334075F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDFVogczfVUU for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 13:47:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFF9640759
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793281659;
 b=T10W57rMv8HYjoGaS+/SL4JVe5DSKdbQSKkHTmboT1k83Lkkw8w9n3eQcsZRVBuwvVMj
 RHAA+FSoFIFy0vFlXfvhn2k/MjZpHe522vdhUHapOQFplGiOEh8FQe39DczOae2xjvMbh
 Za/lE1s0NWvNVSDuLVUfHO+A/Fx4HIXA6skKJc4hUv61B7FESynvjvyWrn2P/6PIc0N/a
 d3er+zHY57gPgv4NnK/iU/ypaypXOn+E8d0Fz7oDBvtoPyfBKZV7Ahm4+cFhEcB06H9pL
 3aJCYhBmwZCn4+kBrl6KM5dlKmBl6JuD489g43xslQpgmKI44QrSiDOqaA51yVJ0UNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793281659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=9VC/rzIZoDrmXajnR4OE0bGx4PGggs4BECaPWHwkHTs=;
 b=bBeLrFIhJW3HLUL7V/+0lpRPXZmOC9AwxsjPNK3khQP8WdN6g6giEuxPU3fMZprgDlha
 3s3Al5/cY9dkhBhiZU4eMh8m7ZZMUvssikLPexMAjXnaEFuCtgE90T5sHfXCJ64D9vLVb
 v6OhOR4RaJD44E+dFS9ld6eWWiIBOzmH8GcY8WDoNZa7m2d4VGwt7Q0GTMCb3pYo5wFXE
 HfwXsibcUVYNJ4gn8vkfZ/gistR43yTTGxYJZUloR+Ag0ge+2/hK/yrGmIjwzX8RlrF1A
 DIRAcVHUC/nm/bSyxby/UPj2/HXtVKIw/kz5VEovNTl5zQzg4Gu4efPbt0cYyBDNNaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=cbskNZEa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=cbskNZEa
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AFF9640759
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 13:47:39 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-36a17a332ecso3146067eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281658; x=1793886458;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9VC/rzIZoDrmXajnR4OE0bGx4PGggs4BECaPWHwkHTs=;
 b=cbskNZEal9PSmd6duHDKhEBmSU4mwj6pbKfhjf8cQQvyAgVAmLkW5OyL2HdrEAgft/
 gsRmqwYEdsjhZI2PzANjU5Iqv2CDwAl8hrWavR3qf82xN/rsj16jsXpvMOorfMFcrcW4
 taw7tusWj8w2gVEVf7zc8y/TRVqA4EsZXpAJt4xcC1nWm1NYcjfwhIRUiVd+695QvC3f
 Y1FAOt1PX+swuUDoPKm5/E3uwJ9pEuK1L6Zjjc7Mqu96bMBNaHtcoR8y6b7GWCUjQvI/
 m1XUsWYyCYqG1VA2ZS05jNaQnSBRV/w5GhfcoegrMUHDD1eUdtWE8FWYX891zdQk/hHC
 bT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281658; x=1793886458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9VC/rzIZoDrmXajnR4OE0bGx4PGggs4BECaPWHwkHTs=;
 b=HjQB2jwM53Q/RBoe0hOFGbxVYRF1/QefgmaXX6GSio6f5+ix8LWSBOYT721C2boxlX
 jiRxtnw0KWWGDdV/wISP5j5EwxVlpnY4PbhrivTdp4Lfc5v1D0jK/TIBfkg+wb+npPmr
 a1XQpaP3LIPWDXsBKEF7Eo2fS4tZAIWGd57BGjXw7YpTqU0j+iuacTDZt8EC1I0JC1Mi
 VJMdYdEDnPTWbi0mued/7QqktbLS9Zix4ji99j0lHdPD8/0T8RA6SFwLJ1+yqppjr56O
 Lle/Z5V9c+EgPB6BgeamNf1ptMorIJCEa2AVgjkSrHtwcHZkVk92uAnRGlNPgYGpNAwv
 mfWw==
X-Gm-Message-State: AFq9FYKHm+ToalSG7WGf1FSP75HvRIqEezafqve9b3YCh7rdPZS8t6wW
 ulBo6oK67PDx3MltnncNWMA1kolcREYM3kipHNOMin6Pmbhx/FkPvezmhjhwOA==
X-Gm-Gg: AYBFou1neXcclsskglBF2dLTrp8nuwCaZAjQp3tys0p6/BxJiUfGAGIekZeSH6EnwOl
 MDZD+PKv0uWUa6Mh1/VXChojg9dBIVSOHihKJbZfsEyl/vt9byo1+u00Uul9eawq5c4He/4zgRz
 /+e7pZsonU9O5RqlH44kLsfFB3vz5lA84I5iOn75RvQtIyl9itwp4oUPrdSDkDL6Hr7tIXbwdPX
 xuAxDXAaVbowjFyDhZp3CIXcmsLz48toZZvp7hBqrTcOUDvqzSkg1z8RYfjrWYlasCnquZptYEI
 Ert7uP9ozklOk9pYg7HrKVI4YHFidb3f3YwRyhyg2u4AWLBlmCLEwmQw998eDXDtTlGjlYSlJ7J
 6hS58N84R0eiy+LDriKTd3BzwbxlwMdJGDzpFPqayYqS9boMH4lkD0wDaS1yzW9JgtxFaEtroFC
 IxF9FFbaRvZrlihHCPwZivpwpL2kJQ2XGRgxtfT7topqXXI1UewzRPSp+Ti3jZjrb7icbIQBPMQ
 oAOpKUaVWPxy3Agze8CNjH/k5p9KdtxsDJwCGaBZmPh8cdagxan1rPXwZWwZaRMtGVn3Q65WVex
 vpVK/ep2pLBqHOHuXAXsd3sNCOEoQA==
X-Received: by 2002:a05:7301:e10f:b0:369:f4d7:19fc with SMTP id
 5a478bee46e88-36a201fb427mr7607758eec.41.1793281658034; 
 Thu, 29 Oct 2026 06:47:38 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.182]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2390a812sm18032339eec.14.2026.10.29.06.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:47:37 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v1 2/6] mmc: spacemit_sdhci: Improve voltage switching
 diagnostics
Date: Thu, 29 Oct 2026 19:16:51 +0530
Message-ID: <20261029134705.3767-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029134705.3767-1-linux.amoon@gmail.com>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Improve error reporting when setting or enabling the VQMMC
regulator fails.

Refactor voltage handling to determine the target signal voltage
before updating the regulator, and report failures when the
SDHCI voltage-switch bit does not reflect the requested state.

Keep the SDHCI host-control voltage-bit handling specific to SD
devices, while allowing the VQMMC regulator to be configured
for other MMC device types.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mmc/spacemit_sdhci.c | 85 ++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38bdd..836201ce83c 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -222,15 +222,26 @@ static int spacemit_sdhci_set_vqmmc_voltage(struct mmc *mmc, int voltage)
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	int ret;
 
-	if (!mmc->vqmmc_supply)
+	/*
+	 * eMMC VCCQ is fixed at 1.8V on the BPI-F3.
+	 * Do not attempt to switch its VQMMC regulator.
+	 */
+	if (!IS_SD(mmc) || !mmc->vqmmc_supply)
 		return 0;
 
 	ret = regulator_set_value(mmc->vqmmc_supply, voltage);
-	if (ret)
+	if (ret) {
+		log_err("%s: failed to set VQMMC to %d uV: %d\n",
+			mmc->dev->name, voltage, ret);
 		return ret;
+	}
+
 	ret = regulator_set_enable_if_allowed(mmc->vqmmc_supply, true);
-	if (ret)
+	if (ret) {
+		log_err("%s: failed to enable VQMMC: %d\n",
+			mmc->dev->name, ret);
 		return ret;
+	}
 #endif
 	return 0;
 }
@@ -239,44 +250,54 @@ static void spacemit_sdhci_set_voltage(struct sdhci_host *host)
 {
 	if (IS_ENABLED(CONFIG_MMC_IO_VOLTAGE)) {
 		struct mmc *mmc = host->mmc;
+		bool to_180, ok;
+		int voltage_uv, ret;
 		u32 ctrl;
 
-		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
 		switch (mmc->signal_voltage) {
 		case MMC_SIGNAL_VOLTAGE_330:
-		case MMC_SIGNAL_VOLTAGE_180: {
-			bool to_180 = mmc->signal_voltage ==
-				      MMC_SIGNAL_VOLTAGE_180;
-			bool ok;
-			int voltage_mv = to_180 ? 1800000 : 3300000;
-
-			if (spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_mv))
-				return;
-			if (!IS_SD(mmc))
-				return;
-			if (to_180)
-				ctrl |= SDHCI_CTRL_VDD_180;
-			else
-				ctrl &= ~SDHCI_CTRL_VDD_180;
-			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-
-			mdelay(5);
-
-			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
-			if (ok)
-				return;
-
-			log_err("%d.%dV regulator output not stable\n",
-				voltage_mv / 1000000,
-				(voltage_mv / 100000) % 10);
+			to_180 = false;
+			voltage_uv = 3300000;
+			break;
+		case MMC_SIGNAL_VOLTAGE_180:
+			to_180 = true;
+			voltage_uv = 1800000;
 			break;
-		}
 		default:
 			/* No signal voltage switch required */
 			return;
 		}
+
+		ret = spacemit_sdhci_set_vqmmc_voltage(mmc, voltage_uv);
+		if (ret) {
+			log_err("%s: VQMMC switch to %d uV failed: %d\n",
+				mmc->dev->name, voltage_uv, ret);
+			return;
+		}
+
+		/*
+		 * Non-SD devices may not use the SD Host Control 2
+		 * voltage-switch bit. Keep their handling separate.
+		 */
+		if (!IS_SD(mmc))
+			return;
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (to_180)
+			ctrl |= SDHCI_CTRL_VDD_180;
+		else
+			ctrl &= ~SDHCI_CTRL_VDD_180;
+
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+		mdelay(5);
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ok = !!(ctrl & SDHCI_CTRL_VDD_180) == to_180;
+		if (!ok) {
+			log_err("%s: SDHCI voltage bit did not switch to %d uV\n",
+				mmc->dev->name, voltage_uv);
+		}
 	}
 }
 
-- 
2.56.0

