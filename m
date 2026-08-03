Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A4CC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC6BA80BCC;
	Mon,  3 Aug 2026 15:59:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fC1uPtp0RRWS; Mon,  3 Aug 2026 15:59:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 610EF80B40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772775;
	bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Dwvp8c4KhbvwqLmTZJ5usgNMt6Z98bRtD+fVhzj/XZZjaVoJbsucCOzU+LsO+BrCh
	 5n9ufJNhYTNvIzr5r1yRchwW2JvgQm/TIBPm3SJJd7ss8dkpWXwdZMFBIxpdrtq7BU
	 7O3sKFJUJ9s0liIUt2aILr5LmqjXztcINve9TXPjZ+XQh6oPgqvflRmopRCYYREcO3
	 MDRDjoxmN3K+Lsz0zobMwdgyGrWK38bvcrygv/nx/+PZAZXvg7s7VYtnWQYNAJLmOH
	 zSBMMZaaJI5mQKuQnf6ecpwo8ot7rEUgKpPMXi6orwECkLGJP3xml6moEwk6Q+Otua
	 y2u3IXZ/SjKtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 610EF80B40;
	Mon,  3 Aug 2026 15:59:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61A5B2AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 542276066E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RzoK2412oK0Z for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9837B6060A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9837B6060A
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9837B6060A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673FJNNQ2172318
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:32 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdr5d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so3587189a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772771; x=1786377571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
 b=DRmJVEVLch/oIGuc52VcPg7M5S6Lg64sylKkUC5RTUk7L8DACHjnnQU3iuJW8/Kwvn
 ZnTcNT6a3+ZVDWAL0+g1wHfSLVZ8X/mO2jLX+YZkVMx0D/qQ7QPEOWuGm52r+LzaQqB1
 HpmhWXdhlIe/lOE9Lg2gli8a4+Ll11qF0g5ATlLs6vuXrHJl7wDSWSVi4Yf9r+6uTv6W
 kDAl4fJAZrz9Ba9aRmz8Vbzv53jQHRKTa/3vKtVmjlwrKUlYUtWsYWZS7ryUCgteed/o
 dPtvXuvGohiNMlgiaTSGeeuTuEs4aqWAlz13IZW5NdXw/J4sijOxGL2c8Tj8t6b+vLbf
 z9wQ==
X-Gm-Message-State: AOJu0YyUQfo1T8FPs3/qlRsNquwc5h/Tot95CVdtjK/91mNAih7jV7dW
 ySZQxVl4OpBZn/wL2EAmJpX3mFXrYH7sVLSTlyylefb1QQDe/pmQIUc0iJjAgaEoAKmHyFSDYLR
 YTl3gcZ+XjNtfUTseCQQzLK8mqnKZ+nImA5VOyZXat5x/RsE4t7pakY6vQKDweuywLF+bHWQerh
 HCU0k=
X-Gm-Gg: AR+sD10XabKBrYh6I2rsveFHSKQvr9lJAETWOrltuBRLh/cO+Dpt82QBuFDsuCioVr/
 5HvcXQEluvP3GgggGRqKwskXlcIb+fgTt1xN+t/leU7w+DEZycnYtoAp2/pBUOzitDEX68+L39q
 ZuJ8XTdoNZdVH1Tqb8g9qGfCgtbYQTBjVa7J5b0KsoYYqOUzi/XqfmvDMXKPk8tG2UbySg3jmYN
 d62/Zczn7hz+LP2XtfSHWOSl2zGFYy0AmGSRT/KtbnHCAcJA/O6xCTnMxq9Qc4pp7o1ChPKaYlc
 lafgzX8YAVUsuHZngrhIZjZClIIR35R37R3mGAjJabQVRtm0JxWxDTj78z4GuhIyIx6TbgUpGxO
 2Ogx5KG1IUFcl/4STT23QFt0qv0fBl1LMLXyta8szWrSymTduD6pmjGSMs+I9VbiN8s57/eKO4r
 QxzBqEiMujlTq84yomRwwd+rIAPfkG
X-Received: by 2002:a17:90b:4b02:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-38fbc3f24b3mr9901611a91.7.1785772771002; 
 Mon, 03 Aug 2026 08:59:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4b02:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-38fbc3f24b3mr9901584a91.7.1785772770558; 
 Mon, 03 Aug 2026 08:59:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:30 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:52 +0530
Subject: [PATCH v6 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-7-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=3909;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LY8OFdvOtMbLByzWD5efz5SC8SbiXB4RXMSXv5czkn8=;
 b=TRSSATqz64y7+QMcg9zePPRF9wn4gXZcQq5I8WEWzeUhqSXJ8/kIViPQ38OSIPYBd9RAKHtsN
 O83jjNceOFLAc8u7sKX4S2ERwZqoCjiYKWQMxZ5mX1a39XoEQY4e1f8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a70bae3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=daLpoQ4NbywWfa45J7kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HsM3NgKiomcVtUxWNHswvBOKFhnj3l19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX+1dOLyn7kzaq
 SXMmLAo86Xr1aF1BeTPus8bvqAULzjLUugL9Twzokhi+IyCZXs3uGaZJZ3R8CbegyO4Ao6kUHfv
 5idoQhFrIXEreXGMY/0Xi6oHbTr2RCrE1H4b23VfebijRcpo0smR3aCjLWNpHvX563YOHxGg2Ql
 0ahN/W97JWVWdTxj1Fw96PJP+F25rPpmXZKCO7+nq6WTUbQUKqNlbHxkcLHn8VtUgC1XPQTGbUX
 5gljcdVyy5j85DGIX/CyGfT1WZecLQGaPjIsjLUrQ56oh/OOv8hpG4NMTO5F36PLV5jusInS7bl
 dut+D40PsjJTk9AZD/YQBvQ9wkgrKcjZzI7E30UeHHFhkWBy4npnJSfu6YbbWWd/JqhZyrdXQdn
 f+EzFs0nxO9X1M9pku6Yy4Y0aocdm8f9iaahH+CnLzkctTzk1Km4Nt+1ZWISqZZm3iWtkOV4rXU
 Mqc6whBuXf3mZXXch1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX41pU9G5kv/yq
 k456bzvbuRKQaWrKt3xgbBg+xOIZtdngWKwy3pfc41qnw2wMnYUNfnm33SXxqi9FKMK/JZwH1sC
 99DHw4tPHUmO8UAXSkm6oTuh6MRa+xE=
X-Proofpoint-GUID: HsM3NgKiomcVtUxWNHswvBOKFhnj3l19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=; b=F1gHKBPBFzJjx26I
 8EbxpMy7UWQ6y7G5vqfwE9gaJQ2dFfd3V5mVvx4gpHwbpNXrGx8F0rr+HOqdqrpu
 pm5OgcFTrDoPhxt4fisky3YfaGZXkE0ztXJEhDX/iMxhOHhniJUdBXi9RqHo69le
 hFPVTMe8zvUIQUiq4s5Uex8NuNwAs780YLG0c3AxU+q01KOktKx//nxhPw4Ppvbw
 lnNdZ81V8VMyAwV78HFdjnDxx/bFVrSHBh2tLMXTyJYIzjtez1X8jagyDTs4fLqw
 9MyWFEc2wZR2HhFwLTz5uB7HbApxX4xuqV43GrStDCvP3ulFEmT25tlEOjmy+cVm
 eiyi0A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772771; x=1786377571;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
 b=Og73U0Jp553FDpI01Qn9yPFzsa9FiNpPyXaHnJoVIJZlvXpASiuWYrTq6ptdWo3Ngw
 nSvncU0pqPBxKTzp5XBNdSRHzYlzy4v8VJjtMpTL2Q+TP/VQ+oLe6QJZGmUFx9n7suWR
 kJ6d9WXEwv1qRoFftnah/owDLLGcp6yQdkMZQCbMxuUz1ollNdenefR5JekP+3FqVOMU
 lM/dghqaEJGWVa4KM7gZ3srYxbGzEhH2bFiY9bxUCklTiB7ppl0EaSYLHKnxNMCgh41H
 +QsPNvVG09fB31kjXpovlywyYDBUr+pk+X4cbJiEjkLN5gmILRLLlQaAtidGi9mkzTgT
 umpg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=F1gHKBPB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Og73U0Jp
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot and directly jumps to it. U-Boot then
enters fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Disable I2C configs as its not required in Snagboot mode

Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 46 ++++++++++++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig | 18 +++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..20b514a0a5d
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,46 @@
+# Common configuration fragment for Qualcomm snagboot mode
+# Include this in platform-specific snagboot defconfigs
+
+CONFIG_QCOM_SNAGBOOT_MODE=y
+
+# Disable configs that conflict with snagboot mode
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_IOMMU is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# PSCI firmware is not available in snagboot mode, so nothing implements
+# poweroff (neither SYSRESET_PSCI nor SYSRESET_CMD_POWEROFF are selected)
+# CONFIG_CMD_POWEROFF is not set
+
+# I2C peripherals aren't accessible in snagboot mode (no Command DB / RPMh
+# power-domain data from XBL), so probing them only produces noisy errors.
+# CONFIG_DM_I2C is not set
+# CONFIG_CMD_I2C is not set
+# CONFIG_SYS_I2C_QUP is not set
+# CONFIG_SYS_I2C_GENI is not set
+# CONFIG_I2C_MUX is not set
+# CONFIG_I2C_EEPROM is not set
+
+# Use default environment instead of loading from storage
+# This ensures snagboot mode works even with corrupted environment
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+CONFIG_ENV_IS_NOWHERE=y
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+
+# Fastboot configuration for partition flashing
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..d6906c1e501
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+# Platform-specific settings for Lemans-EVK
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+
+# Timer frequency for Lemans platform
+CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file

-- 
2.34.1

