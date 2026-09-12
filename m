Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD459C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A33A66065E;
	Sat, 12 Sep 2026 12:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0wL9SAJAlts; Sat, 12 Sep 2026 12:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D59236064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216650;
	b=c0vIzoMNbpZOM80L1NGWRKf5j1wtpuldbOz0A0RwFfFYCBKjSKaSpYHyZo8pgeL2aJ1p
	 LnDlkFsyhCF+nbvy1ILLqBk2rGubZ2GyZdOlPBRhA726SVZ24gKGECl5zr78nyHdSyM/i
	 /XQAItrF8TUsvWXSk/z22rmsrks9BE3fj4SksQmRsf870lsG5IXBjRabKqvTnJxpD51Uf
	 MVKbaw2jWZlHYc0AHW5g3WeQ255cYt58nz3LklU0k2U3a3Cs+5Z64qjg0dEeEdj6Ti+3+
	 hijedOz8sCEXvY17ENUOBMtsktscfnsgw0Nu9KPewoyQTfVJU893gV3fgF1kHMio8cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	b=TZNVbgdP9A8dzRFiz+U0puyTptwwQI66cQlWgjfAqyCzKN/PO02PASfiee1f/AJuibh3
	 n6z4RCaksUD5682Bo1LFNO6P+dcn+B/WZPRktog9/H3/Po3JtZ6X9dDmjqPbdnn5EsyFi
	 ItmbT9sDDlyaGcZDhaGadr3hiMG2za+g9fMuAI/sMoeDjnVoh69qsZyBDXq3ip4aSQJuL
	 Yxv8DjU2vfacse6xn4M6+qIoiq/bxwsInD/uyKEUd9Iy2LwritIT/d7yzpYQXsSJ4vIss
	 uEIklCk0TFbZvO4wbhKkmCzfJzD+86s4BJIaxjc33UhkPag63JyZ88cqvU0d6MHVAhQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="gOrEWtF/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216650;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxE5K1gqg8j5qvrvELyWTsWzgViu/iSLExKIbFpBHRsQ+2Z/Erxrs4At/OSZTaio6
	 3H7IqWt6RTBuVKq/7+g0dRkouWUnmUrwT/M2uPmGjzZZ5d6yrK7zUnH3K9ZQLasg23
	 tUL046OEsiEBJyBpKH0Jvx2MatjX+xnWLLlQS6Mux01izI8ktGOzPQmvbYp4yL9KeY
	 HZ4tUEefCQ3cpZW4FOLiYj0sIzhLL6K3fVN31AgisHatINRu4V6Jf7SHy2mCK5fsCI
	 rz5DIc34jn+f/2UIT7wLiUa4LxMtcqwDBkSvtiwaZUHYQMiASXnQkabuNNUhSecfad
	 4kgqSBc/Y9Htg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D59236064F;
	Sat, 12 Sep 2026 12:37:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04DAF23F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB69860662
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGFnk77hvmAK for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F1C460631
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216648;
 b=b8YyeMx5AG9p7fWjnqgU/ZuYtXpLwaAg8k8GvgQIIo39qHU3hBQl+sEuu0iVRtTH0K76
 TITBA6KolOOHin0j1SbeVFX5y8SLH334unfSZAWseHQYCp6t6Njz8QkvGQQVXFPxLl7Fq
 RdXECs6zNCLtoC9PEnSGQiEox7jvxnpeWZMPFJ5eB/VlRnH9Gq3Rubyybozy+mikft3Qj
 tMQydIREG7IIOFGho/W3Qo2v/XKitcfYPiynT7Qu3eo1PP8axPCHbkoEvGhLIFVEC/uKj
 CFEUqRCxeWEtKg36c6orv6kImMHZpCioBPfSx/Mm7MD9CRvR/ezUz2DB75lasarCUJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=FxIjXGPRl4LE1VE4PC5Zuj8W2tMqcqP9xxv408kQTKjvqss1JMNLgBG1Cq1kspeVTURM
 Y+KIRSLIDaWZzveMt1TDDVyskiDLbss0GvWrnNPJpk4bLe0dNUiTHXZDrTP9N/L3E5gH+
 VKFdyIZqP304Q45Bh210hnF6bukGjQ6tPBUcwiZ+VaMz7AHnrSQfx/wRbzDa3MCoFWYrN
 WZnBGn2DCyZLVBROmjvqErjzmIOt2Gsp73LlE7Q2qKe0k2ay7HAbVw2ql8RcFhC2M6Fh9
 TA8Wr13ih2x20GEmVcUttw3TgmdtM2nSMRXenPkwBg2eI9BIUof0LM31IvmMA/eCx7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b="gOrEWtF/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=gOrEWtF/
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F1C460631
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:27 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so7420255ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216647; x=1789821447;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=gOrEWtF/612YNfPlSTVJLXlMeACmPn5mWA0gGHy4U3Q84gvL8HkgR2LML351o0pcty
 /MxaHE24OyhcnWkLWb9wN2y94L6ZSOF3wgjk8sC2c5sQyoEnoHYy1dRnbc35Yr1k1eoB
 fIqo7oza+ZzD/jkFbU3lTzEnrTI904eXmrC0IFM+N+XpKdhFLOY8v4ZHRAbbL2bk/F7S
 /LWyZN70E/dY9FQ0rcJpymXcZUcShzwO7nJdj2Pz9suL19TI79/jOCIQRiS47wcJ47S6
 G+jqwK2J9+vNVUEMF9E1oyLEvo30bknmmz6OC2MFfqdIVMHtGVE9IKAAAZ9825nprOPv
 zMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216647; x=1789821447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=AjzyC/TFILTUWvbbYorUd0yQR7dmQFYP58ltOc9K/9FfGZo3sJLstQKv9o80FheXOO
 aguMsKpk21zvvHvz2h8yATsbKJnHIgW+ddAyMJQg+sBdNPHBgGL164PG8yMRlOqonI45
 U1wuJocFwsGtbfSkwx5BEL1Cd1i/FejzPx+KV3D71G9soR98q/8SLDi+V+2AAiPsN/zy
 ECnu2ZOPGC1C/n3H++NwI63le59UhMOQaDwmjaAbGOfdv8RlOgn3yjtPrRAW7KL8s4bK
 774Dm+MfTXNlP02q6gctSozVmmQ5oH9uWzXKidqvAj+3Hko/zeG+IV8Nnq7U67CRApcq
 Mdig==
X-Forwarded-Encrypted: i=1;
 AKwUvByequJG5AB1Q7MupHg6KMGM3ch0oN/CSW2jK1FmUITk5lEcP9HxGAnfJSE4YbkFAOYRR4D4YhQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kGbuhJm34raBsEA4KJpH3QLAUj4Okmbgkt/dTMJ26B7S8nQwwL
 ZLKx5PldLih01haxoGvrexi74oiCmRUbQlko+y+Mq4SMLBU8a2+sv1+l5C2N/9F3AJFB9ezfxNl
 YKsA4
X-Gm-Gg: AYBFou3i+EH6QvwK7kXP+EgdqZ2e8QKsPesPsGImA1BJzou8z01zGmyKiko2BnxUFNb
 mjrFlqSn8sabxSeQEzxeOGIEJyB7ExUHrIe0QRQNuBI/6ZKk+2rk6BfmKycIq5YU5MO7zE1+/cO
 fLLYk8Xm3MKHLN9TUmerI1xPTSz2R6uvd7+4UZQ+tBfcO6AOADWgVGH+YHK91187kus/S4Iufxn
 QDrWnkU0dwUqwEBaEfocgLr1nEjx9K0ykHj1HRUMOyZYMv/DhZwGtuJrgHrxpJSMZFh1FSmo3ST
 vfIXggdCDPlWyElJvuR5FdEnfVI30CiBRW1lxdQ2N2JmaWnaGaDsxCxZTpr0O4uceJNBZ+Kwgs/
 lSpu1ElAusNuAXdLF97NyM7JO/mzDRSS0Dz29W+ip+EkjAsIGo1/y/nnnIWpnl4rjdigKYQajrw
 KyucxO8FxwczTAJzB3MpdvhilRwhWDbzfw8+q1vNuqyHk97utc7xXmwyT+eA/rHNCq2W5gNDiW8
 DCtiRo2zpRE05uZnyCS1EYICx+Hhb7IL6IVKaqXb5cSf/wJE9K4Q2wcQ1KFoR/HPa2GdISlYBi1
 RVna7RbeXkokSXOwF7NhamGU13prtXa+WUXp
X-Received: by 2002:a17:90b:2542:b0:398:c150:e7b3 with SMTP id
 98e67ed59e1d1-39d9bbe548bmr15120177a91.4.1789216647222; 
 Sat, 12 Sep 2026 05:37:27 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:26 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:57 +0800
Subject: [PATCH v13 4/7] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-4-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Remove the change on MAINTAINERS.
- Force DM to use alias by CONFIG_DM_SEQ_ALIAS. Since the sequence
  of mmc devices in DTS are inverted by alias.
v5:
- Remove ADMA support since it depends on CMD23 support.
- Enable PINCONF support for related power source setting.
v2:
- Enable ADMA support.
- Enable SYSCON support.
---
 configs/spacemit_k1_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0604c2feefc1..5f9923c7f470 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_ISA_ZICBOM=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
@@ -48,6 +49,7 @@ CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
@@ -61,6 +63,7 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
 CONFIG_PINCTRL_SPACEMIT_K1=y
 CONFIG_GPIO=y
 CONFIG_DM_GPIO=y
@@ -87,9 +90,28 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_DM_SEQ_ALIAS=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SPACEMIT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x4
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_EFI_PARTITION=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

