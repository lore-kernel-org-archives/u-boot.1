Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FD606A336
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vf1hy5AS;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=pmQjG3lj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 703DB606E8;
	Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pUJtUlwSqqxG; Wed,  4 Nov 2026 08:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8188760709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782267;
	b=sdoxSDIKCT1B5lHQrtBTKaKTf6dcM2Qn9M0Itb85rm/u5rNxySuGrdU7xUyViS1bFmik
	 zKMbAB763xQDbHJcGBfjGnKJqnbTjOvBDXvfOluoYB5FFdDV4BAIQQZvR5isqRiJjF62Z
	 ZiUAfhmFfhK3Q2/8X5nVD3solOp/0/UMLJeY2kGB1oXdwn97hXa9c41kTuBIAkwlQRjXH
	 G4CJZFM88F6IlbiPI2ysK2glAMEWu6w8oe3X5Z26d+k5Rg1ugE41KX+IdqjN35QxPF7eT
	 wkse/W+H3jor5sPzdQTCTVvUdQSbJaBWmtH1s/eJjC0c7NrGNXcp3yDc1APBeSmCJGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RlhR+mTkKLGogR0A0UJ4I3AJKgNU1EBj2p0FhmPNhQE=;
	b=p7kC0zpVds5pC+TOt2tUP9/if9L7abG47TORrKx3l6G2Xw0/aYHYL1LICKc0gSdNU8mw
	 HzZAIwxLe5CFUuHROH07KruDn+LLhGETozpUPvhi5/BdSDgA8oHJvaPdbPAstiwm6P6ek
	 M8NJifMcAhrDyZj69wNcVKTOtgG5VoaWRNJ3RvwW5k2wLjXUEGTS54N1EvktORcjS1ubL
	 a4qi3t1tvrl+ApSG1gMQiGIK7E6dKq3Nv80rvVGZ5bY+hMw5vZLWTBMfPt9/N0BZNzF+V
	 Jy9PhKTyr5A7Mu29f2kGwl1OkevJ9Ogqg6HgNeAv0AB1fX/BGYWuMdqJ4DQsfNpSzlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782267;
	bh=RlhR+mTkKLGogR0A0UJ4I3AJKgNU1EBj2p0FhmPNhQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vf1hy5AS2uevPpR1GD4E4K1wNzhguAf5/Y3aVf+FUAq8PmKtZWf4uZDTbbxtU02zK
	 lFdcej+5MQXTA/uGKTb2cG8EAwcMSEL7pc9iS2rLSI7I45Ct18+634yyJziO6tK56A
	 jzN260L5TcrydpN89BeQNYiVD0R88Ek7IKg7g3e/rKkTqr8ZP3TfMp01pXKspCtAg9
	 BmcPn8XotsFKrAAwQc3wqea52eDygN8O3ifbdLXuiKiCqdDMQgYBKFF6Q0VqFPgOIT
	 MIfVQM2CnLBEiZ0Oon68jQDvymDLJp+JOzDkSXlNrSuHWXKQnGDm4qbqRpcDCZuRPx
	 Rl25wI0ybm6ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8188760709;
	Wed,  4 Nov 2026 08:51:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA6C0932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0D0E402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZ2L0M3PJTL1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B547F401FD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782263;
 b=opzYRiQqnkUjM9stOItXUh7cy17gwHYP1N2GgVK5jemmHKrSeJn4y4q91L/427vr9C+W
 xXzTlwydI/4MTD7HaoVi6TUhQ1D3NWkNplaAGiFwRcEsPZXIQvMmvgq6BHeK+cNJT+iG2
 0KAEsEFVeoxDDzmALXV6SihE+SB9AkL99OEd1f8bK+bqhlsCJABG+QVcle9rwtkFzta9K
 /ReLuzxSAjhUigVddllHVkef2Pge7g4gQohM5KUaFXcixu5bJTfC5EhK0JOGOWUmW/rVg
 YXF/xw1rCHO/y++gkmSUy5I1racvrXA7gevS5cT89yCI1PSyqTS4Z63Fr+voOTvdOEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782263;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=RlhR+mTkKLGogR0A0UJ4I3AJKgNU1EBj2p0FhmPNhQE=;
 b=GqxICYVjP7LbyJAv4t34aHIO2MGYonxZaHtHSVz6y6o9Xl8XHc01tWsT99QrbUt/yK5m
 /E5WAWtAnxChjBAUNgNeKoxyFcPW6jG/lR9wTcA1R/lvwyMnMB7p7/ppCf7wHrEMLD9nF
 wNSO+TNAnhmKKFRX9Fu30WOW1QXJFDpX64Nl4KDVr9u7sZms062/PruLL8H6KGBDWWfEM
 s/A3tMIn8U0Ro6/Hrcu+6YmuakR6eqtHbMyu6XPahU4aevJHtZX5hHRU2VCuTLnIUvAiO
 kt6QS4M8AmKqZEQ/HVMSpJJLU6et7ou/wvAfeiKvBJNjjRTvVlH256UYRwadPZxka2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=pmQjG3lj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=pmQjG3lj
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B547F401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:02 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso2547775e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782261; x=1794387061;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlhR+mTkKLGogR0A0UJ4I3AJKgNU1EBj2p0FhmPNhQE=;
 b=pmQjG3lj1hr1heV3w680PQxT8BFDkHl9v5YWxyZJVunFEILbAECnbU30HJTaEsmH8m
 +vMdhlAkqAvvmZI5owU/1sJUqZYc+PqNWVUN1TAfUlxQc6s6pH48akvH2zpry4tUrD8Z
 gNR3P1PB1IxSCmXFOUP9Ng+Kf83L8Hahp5SSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782261; x=1794387061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlhR+mTkKLGogR0A0UJ4I3AJKgNU1EBj2p0FhmPNhQE=;
 b=a7iryFepcbfxDf7n+3Gz8bfxcMYgkP36TFclt7fPr6V/E5YUGXR9m9lFLtqEJzfWxQ
 c5feU+h4j/Xa/I+PVAmKhGdwon3JLzXt6VSCXiIXtUheth3sprCrm03XRS9n4FF1ocJ5
 bvZzHd45PCk0dEaklRtGAkWbcX442+mnU2EyarRscbnADvD7T8lhxL7Wz1Q+CtD0WX6e
 ku9Hl1xBK+gdWKTm2CZBsehPS7B7Z4IZWZmMlGCbfTQRYxj9uNDFeqESTQ8SIabCXgil
 2uRizTBTt7Ti3P80wJ/3PQDIzMNGih4wPfbMgw2LPOVt5K9cfXB/K2cumPM5Ja4HewRt
 zUhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjS4v2fA/4qhrppiugi4GRSm4ZSXriGTvUe/p9X759jjy47DHIscRQKLwOzusBcUmHyACTDiw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90NymPP4OAdLF8Kxg4TDN91VB/22yIGvgIkXfXFZk4zvA8L4RU
 tn1eKzZv9jTb16NJ6kz7PPEW5Mju3TON+tabtCIfAMip/Wm/8GR6U70QVR5IvCaABd4=
X-Gm-Gg: AYBFou1NBeD7Cyprm28TQOUcWIGmpd1J9zvsgXNTwPLATDnVEHTfEF3kqD7ph6NMuGn
 MJ3be8U7UKTIkS1vpq6qITlLVEzf/uMmBiarPnyheaF5FXU2ooEhYQLMlAz2ztGowMIinnnwnmW
 AO2PCNQ/v0iNDw7wzZfuPVytehrX4aAvV8cZhy93fheA1d2dqoXGH9CXQJA8S+oQmSm6M70gVMT
 WFyNazDkdQrljOvXg5GsVCMGx2RY985fA4kfK4/4q6otWr6PBI+UDSDd/Ea51Vp8rD6Afw1iOOz
 8DlvwVdDxcsBFS+b6KRRFyY6I7IqulQOPphSHPwmbMFWHKxNwxK8XVK1FuMNKWpOw8CIxwxExcv
 jN4/S8Vl/k8i0xrf1g70NFnt8y6oOz8AQcxlwBET98f4iC8NTrJvtPZvGKYvLwkcBYG09g7x2U6
 77WLfCpQSogPlq8oXoEgJjUQ9WNXFBWkgvZui3hIeLsMEUCAlE3bmEiP2IT1lxiELe+xtZbTG+i
 Nvzpp8iiRP+B239P9ITCPsp+idQmsbQIENDfXn+wEjncUiK6qwxKGInl2aG3THzqZJEzXKY+apS
 o+BB7LMF1TWn0exF9FC2JFjxgyhd1opWeXMeQK0P+QzFVDL5yLVMGmokar/4FTPX81VMts0lXJk
 F1dVroNSsZyru6iG3hvSxU3X/n+c=
X-Received: by 2002:a05:600c:c118:b0:4af:79ee:f660 with SMTP id
 5b1f17b1804b1-4af79eef775mr198274255e9.31.1793782260678; 
 Wed, 04 Nov 2026 00:51:00 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/33] arm64: dts: st: add SDMMC2 support on stm32mp25
Date: Wed,  4 Nov 2026 09:49:37 +0100
Message-ID: <20261104085036.4012238-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

The SDMMC2 controller supports SD cards, eMMC memories and SDIO devices.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 513410ae43bc77b240091eecf3cdeb6eb5b6b83d ]

(cherry picked from commit e7e96ebb4e18e0041a6674b0382730dbdc845838)
---

 dts/upstream/src/arm64/st/stm32mp251.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp251.dtsi b/dts/upstream/src/arm64/st/stm32mp251.dtsi
index ae36d703532c..44938c036e30 100644
--- a/dts/upstream/src/arm64/st/stm32mp251.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp251.dtsi
@@ -1668,6 +1668,22 @@
 				status = "disabled";
 			};
 
+			sdmmc2: mmc@48230000 {
+				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00353180>;
+				reg = <0x48230000 0x400>, <0x44230800 0x8>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SDMMC2>;
+				clock-names = "apb_pclk";
+				resets = <&rcc SDMMC2_R>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency = <120000000>;
+				access-controllers = <&rifsc 77>;
+				power-domains = <&CLUSTER_PD>;
+				status = "disabled";
+			};
+
 			ethernet1: ethernet@482c0000 {
 				compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
 				reg = <0x482c0000 0x4000>;
-- 
2.43.0

