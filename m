Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC179C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F7E56060A;
	Mon,  3 Aug 2026 15:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwMrabCk9GTN; Mon,  3 Aug 2026 15:50:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDFAA60619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772215;
	bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=jyOWF4Q0+b7pF3Uoj0NpuC3QzEvcv+1QgHxbDQvEE5sdlmMz5t9bqFB2mBhLWlrSf
	 Q7GNShTNGgIPTCN1oQ2D2HMOHweEpbApBgWGYiqOFM4jfuHWJm/QfyFe8RAhMJPcpw
	 +CdnjN6d3ZCOYPzp2ZP819uxNHoafQzsuJvb0nVn+G0Jn7v+/ZWNjdlA7628hGoNed
	 8C42jORewroLp9/VQH3ain8oJa/GqBF6o7fUZKVcgyYuyuH9moyyJlVMVLsazVBQac
	 baYlOgmQU35gMyLVRTX1ZzB07CDMguB2VXvIFMe4McDipGzwGzVYtRYwGdKO0d1vfw
	 SzcfInfPlUm4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDFAA60619;
	Mon,  3 Aug 2026 15:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8191C109F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 729E9809C2
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3VqplOG1eOJ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:50:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 56BBC809BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56BBC809BF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56BBC809BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:50:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBspt1149485
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:50:12 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrbabjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:50:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c860544c077so8495275a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772211; x=1786377011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
 b=lVT6p1nW1sND29SbcH3z10GtWmL6nHVSNQnsLjHEKVbZ/AlUnrP07fVGs/g+yEGbih
 m65QWpmJPJia/nJgQ1+pZRFZ5QZmdHW6ZnVzzbNzIGz/z+VDaO20fwi6dLNxn4ve/xfw
 6lQKbls1HwpgtkUo3cjGm4QUIc5sQIVGhrI8axZbVUXU7B1bEfO16EqCTk9nKiZ2uIUK
 UwQORZVE5q2fuG5jyD/4zct/G7N3kwh37h9vkBM6gQZ3f0sLnEt7n2igMulbXWW7ZW5a
 XqnYVJ7CIRIKWluvBXVeLSiUDkxEPiiSEvL0KQ5x/WXYmI/call3WA113Yn0N7dhDrWL
 EIHw==
X-Gm-Message-State: AOJu0YwF2R4TQAhTwwyWqIVJgM7dvmFuCSkF9sT4KHBVNHZ6p37iQRwe
 0qKFlNkBk1DvkWwVhFoQZybF6W+p4jmY4HXnpNPvPMTV7K5dZ1tolw7TkH7RPSBCWH93VLWJzD+
 6Qxk+46dkMt3tTDgW4dSUrI+M6ZFjL26zNVo1pBspetWL5+HGifOA7aF9WjqpquNJtnEJo2o=
X-Gm-Gg: AR+sD10g9JOcnJXqKhCYwFma8t6MYYPcoOWzBB3ow6961obA3aVGbg/qJeEPWDAk/zk
 7o0LQWAhfwnK8tobWF1V9tHqIzQhOvcL4wudC+1Jrlt63OwQDniQEWLHTScYOtd4rYAVplAmtnm
 4bQ6J7LLP1BKCnfBQAXWfmneZrp1P/UQSo2VvHYWN5OkWFsGYe7HcX0qr55UKEq1YdwDE70wOT0
 Wfse1qFPjU8646z+hG60GbHbTBuTQkK/kMTeM0i2K+ApFSErkjUiOFyPbtuW7XN514AJGBO5Xon
 4oFgKUkmsCHP6CISlVIhDfJ1OwybdyW2wklbtO0l2mSJIJ4ybUd+1TCllPgc0m8hXwJGPJvSew1
 /ie+x/MejKBxrHLQXae4/c8BP4lP/Sxuu5jj5PQNc+FszgJ0uARFrXWCfIDFNT4nECZSwdLoI5B
 GRNQigbHfieIMkCgEule/qyGv8Eqmz
X-Received: by 2002:a05:6a21:3a47:b0:3c0:278c:6a31 with SMTP id
 adf61e73a8af0-3c92a51df73mr10466671637.11.1785772211037; 
 Mon, 03 Aug 2026 08:50:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a47:b0:3c0:278c:6a31 with SMTP id
 adf61e73a8af0-3c92a51df73mr10466630637.11.1785772210647; 
 Mon, 03 Aug 2026 08:50:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab13255esm29356854c88.3.2026.08.03.08.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:50:10 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:19:33 +0530
Subject: [PATCH v5 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v5-7-00ef4542934e@oss.qualcomm.com>
References: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v5-0-00ef4542934e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772171; l=3909;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=LY8OFdvOtMbLByzWD5efz5SC8SbiXB4RXMSXv5czkn8=;
 b=myBUhSyveTTy9rzBomXKrVTuThRPmFNuK3K5ZEGjYH/NP8OPFg8rPgWzDCqZxlBvUd/dF5PS+
 6Xq7IAx3Z2TAhPnCDg10fR7Gc0FvyUEkIsrtewsdH5HtTqVdSSOfhC+
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX8Wy8eNSy+XvB
 jQArsxvbTyfguCRPpTTdLjDPFxJUjpKeaA4hLDkAbhbrEQ2aXkKn0RQZsTOLhvolmXMbR/iY0i0
 GtLugJSupHSNT/PxsgWEO0PlW5v1nlw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX3P2N7KVVUUdY
 LpLtDSz6CP6reGc2u+a4vk/JXeswQN34qjAu3zrvPktdqmpgrpLyS0Seh+V7Rezl8GdnrnJNyVz
 NBYV+MlfYuiqjjyJvnQ/MPR3CFsfMk1yvdgQxJeQFNE676lL6q5k4LjPrl9yghhbuBeUatwYYld
 IAGfg3nWVAdspGQ38xrgB6qxkfEyF0bthSO5w1+7/fiAsrYufRzu/+H2oefCst4uHZToDw+ft1c
 y1Wn/JAjCHEuT42OtWDy5gW4yvyXaU9+IFdUu4jPB9YjnQRqJVziW8Q+mLj0TV5DVrfeEoa91uA
 Ov8rUABWaLdDqAzCuwIbNIpEq7oINXW/ZWS6nKuzdFPUqRQP5bosQU4zoEXtk7gD7AOQb3aykOD
 IGBq3d9Wiwm+m3w5Pgkn5aUEnAjJeF0hY19NM7vWdijTE8VgvsPZLlrOpGD3vVvhHvWXkxkj+ns
 EGuqhx3lO63tlH6sK2Q==
X-Authority-Analysis: v=2.4 cv=RNSD2Yi+ c=1 sm=1 tr=0 ts=6a70b8b4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=daLpoQ4NbywWfa45J7kA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: c6QA5VpzIkovEg4lASJjyTpZ5DO_crzr
X-Proofpoint-ORIG-GUID: c6QA5VpzIkovEg4lASJjyTpZ5DO_crzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=; b=UfL8Pb2kska0ogIi
 4SlFulJzQ43fvNhc7MfsYGlQF8JdXXHzGoBrM4hzY1V2xAElZSfCJxsintp6oGcO
 py7TeRggEe3cnLFP/XfsF0Nn8USsvTlm5NI6Im01mpUKN6h+Qmn5Qc5FIC/mhIZZ
 nTlDP/InTQHcs+hgxLpYPLPVcFoMW4F9mDPqLnOZGgC64XogINtnKYL37luZYfE8
 f7srgl2YU8tMsVN1mp52f2erIn8DG1555fYC++C8WpbN3xck/14XvsST+RcfO+s/
 /zXvbIfkwvF+t7pi+f0aE189SKRJYthIZsJEmZZCDO0re+vEjO+Q3pnooI3lsq+7
 T6p0Uw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772211; x=1786377011;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i1nWdPsJrUBtLcmbeYE6780ZFyVYKKwNrNPhVaavmb4=;
 b=fdFnDhdRbIzOGMcAiiNMnlfCevVVlKP+mcd+osb6Qs+qQnHD2b/XFzHgPaC4Iyddoz
 GpOI/QFotWTx7MV1HZkp6vL/gApc0OZIr8aYMVhLiETNv0NOXzDf6vcvgUMUS9Hrkao1
 l2BtHudYjA0xdyM0Xi4epmaktj74gBRqaeLGMdeTFhEVpY5lj9EVzheZMNC8843xqq9J
 LdQ/9kfflbTWtn5/9WZMSzZ1pRhaf3iZV+lpksJgIkUM4PzDEye4h/rIc15zyLySqc2p
 3SkbZ3HjpubVMbDaPd1nhlQR2m3D9MM4amiCDwc6bLkpfPUq7SW5uUwmiqke9lDg+l0R
 9fCQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UfL8Pb2k; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fdFnDhdR
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

