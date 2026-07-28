Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD4CC54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E8260907;
	Tue, 28 Jul 2026 19:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvyWieu-cZPI; Tue, 28 Jul 2026 19:14:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98F8C6079A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266089;
	bh=CswldRSLF8BmjKtN13hUbecJH7L07v7ilXXWD08DrGc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TnnlaCIn/IX4Id6V9lf8b7EV3w/jwGV/pBm2Nxys4pAYHmPzeHKdbECc333nuaAy6
	 oL2WtKtBwOvWoI0MHtqRcmeXLtX1eU92+lhXtxt2LMrM6qt4kKHwkvFlFrzRXCoFX/
	 8ThACcANr+W1SXZGx+YGD1l/wEDeoJXycgwot44S58Hbrqx0yaIfI1V9TWM10iIFyI
	 bNQ8HXmzYMEGjHiwPUavIvfpNaUT4O+4cAww3SptTOVnL+xxtiFZbRn0DkQV4RUdsl
	 janGK/oXrndBcFxMENuV19arw11fIUmrSnC+twgN3LrApVVOaFp4nvN6LxTYk7aPCC
	 QpQGsnVH1t6fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F8C6079A;
	Tue, 28 Jul 2026 19:14:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6154526C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 532E240A4F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYvHanZUU20Y for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=aswin.murugan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EE02440A67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE02440A67
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE02440A67
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFC28494B; Tue, 28 Jul 2026 21:14:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8EC8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:41 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SICDed3505803
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:39 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjk9wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so64481a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266078; x=1785870878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CswldRSLF8BmjKtN13hUbecJH7L07v7ilXXWD08DrGc=;
 b=UfzO15ly33rpyk5nO0Mv32PCcRPFCfQr6lX88iyq/LnAZJxAUzI+b+Go5hfgobH3DJ
 /mvodpbyPKArz1rNB08QUHRpPmzLdF7j1J50hU4qaPawCacG9RjwLOrPUBmOsHhV2RU2
 K+GoEJEP3P5P8DX32wX7MBi2nXwp7jACl1EUhNM6LdDe++MQydkYfvUF4AD8tGtTJcUP
 osHwedcYiN2DtNwiJWblqISiIiT6RCKWskEh+/CnsjH+qCR7/6v4scA8vGbZuLJw9rAn
 fKXfSJ0T1+06Qjck2RV83QaWH0bCx5ey01EK5VATkentCDQzccU1Qtx7tXzOtvINSAID
 foKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkpyHux986+OK6hJVyKAV2cH4BBHSCD5/w1BDFesZ79L70DXX424b/tCL+tTtxTEwLpREWiTc=@lists.denx.de
X-Gm-Message-State: AOJu0YwRwlPlkD3pCDLJojZ6QUVG8rBPwBnlZjG/RXythQyEtxkgdiXd
 fV7v+SwcTXitpXxiqSLnIf01hPEgUMW/dG0WTB1BzCB29AskK76X63Gwly0p0tzfZFPuJzY8fSH
 DcLHDnyxBNgoZGmNpE3RuCxd+rMSLKIOC8Org7ACMP1LYynSRLpY6wbN85g21pnz/
X-Gm-Gg: AR+sD11xvG6/tYR6jQhmmDKzwuqJ5OnWPhaQgdZV4p1Cl7eSR6QGPABBVc0CsTuF2Ym
 cYVagxhejEiwMAfrhE9KxHR+ZA2p9Q0Wc/q/X072Mz5Ki4fzJ/ZrbrWlLUOHYneST8xRXPz0Kfm
 EmA2WVuoRZvBLmrE9/W4hPlVQUbTqmAfG1CYCWrJaD2bCKpaDqvCO8wpQPZ/YqKeomvpvIku53S
 OjRBqVYt7u5bTmuD2Rl8L+M3PtBTwyBQlmfWUnrHHlExpElVPYDEd4Epby2VzdefVevPrAp9cIR
 oY9740ed5M/RDLOftqwPtyj23EweNgrXqC/r1XQl6L72k1kdGXxns+vX3Ijy+WPBZZWy3d/ZSkL
 UpGdoJvA/M4gfiQIf6sNkxhp7HhpyAPZqkvE4MgwwplZMhYy9WyrUp6xnTR+F0FOA5CHJjUZPzO
 k19NNyfxwGQf2JMnvp9Fw=
X-Received: by 2002:a05:6a20:3c8d:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c8ba5b6246mr4725164637.46.1785266077197; 
 Tue, 28 Jul 2026 12:14:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c8d:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c8ba5b6246mr4725095637.46.1785266076503; 
 Tue, 28 Jul 2026 12:14:36 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:36 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 3/5] mach-snapdragon: Add FIT multi-DTB selection support
Date: Wed, 29 Jul 2026 00:43:59 +0530
Message-Id: <20260728191401.849143-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
References: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lvh6xj9aDZ-4K-JJcvkLNiLOF-pmgIKL
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a68ff9e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=WpC_2p2GkP3uGsz4AisA:9 a=CPy9-WOLo-BVs_eY:21 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX8syrSVTxK2X5
 s1UvPkBzyA4pCjSDVw3g3mFnhViwa8tvlFmItIx3wkD2FGHEp6KR1hq0s7MuW+RAsv31WfJ+8Ui
 vQmiMlpKTvFCHQib2uTlH0C2vR2T7ig=
X-Proofpoint-ORIG-GUID: lvh6xj9aDZ-4K-JJcvkLNiLOF-pmgIKL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX/JcKgpVaOCfm
 t7rXz5k+RNPWqG66chSzu6fb0Ns4GMbJKke9ddxy0XCRl9suYsZbdGNL0fHGVLsGerEBK26afCo
 4Trv6DDpVgj/10H82ztsZGPPIpue7WM30mXDUZQsU3vlCQi6ROP/fmPJpbfZ+CXZPXEDX3jQg4b
 ALKU+9QvcVU/915ynZm9/UE7YsGfAoBeJVWlID8uZZiThcdR+8Pn339K3xnDaFTm5FzYJuDmCvF
 YE/zUYLlHWVN/d40ozGe8LGv79mZRFBDHXfQPINj8S0nMvkGIYiX+J/FGfKhqf2UdQQc6lpJtcd
 3XPNxTY4LYjortQuf2F9krGP+bKUS91Jq12sP6o8QPmWQHXipOJASf5mOeFafmeBLTOE5gsSJS+
 ss5fToZsqWiB8CLqG/vQoegZJMXnIS89FxjeZvqxQHoet9/NMuoyIz7SQ48Dg3ra9LjHoMMn3rt
 74aZP6NpXKn8FCwa5JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CswldRSLF8B
 mjKtN13hUbecJH7L07v7ilXXWD08DrGc=; b=AXeQPk609iaTwfy3YA9fWqeqzQL
 KVfT9yE0SYtVimRbvvvOufV7GBVRmdr5eE4ClZW3U2hCP/t2jv7KHg4MkyPAy6bF
 vnFf5RpklG/tTmPEuWrAGI3ilyinsKM3i1uzxJ6NRGmMj7oQPPHQNl7Vww8g0enY
 RyOe7KF9U/tmxXSL2USnf0bQIGdISlHF8xo0Ohr5BuQ7IPQuRGwuwaaSxtnkzsNC
 vA2zgFMPidGY0mxbDAqvs5qV73nHmUq/r8voI7rENN03coWYzyXt8OclFTe7eCcr
 s+ObZmst9dzn5t7gXhojaBSehPTG388QutnSLxmTw0SqKghX6vp8/5TzkWA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266078; x=1785870878; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CswldRSLF8BmjKtN13hUbecJH7L07v7ilXXWD08DrGc=;
 b=NCEOoN+l/FAWJsPVglanqNMrZBcWIUj1NXJRLB7q1vgo6dhmKojvV81znEfQkFzH0r
 OKHgAECQnTQ4r9lR2i1P5oLmx4QfdZXUQkErFLuPZLZoRmkxRmtJfAi4np0cCiM/JixW
 gBXPYmkuQ4k8wMmKdALzJSfgme29NeA6aJabFEj72uWDQmJE4GBDfOY2bDc5FWnNdtd2
 GWw+fobLPkUR2YxgJYhv0nNVk/57c9mxeEQsX62Gw0ongjzL5NiOqOvqqC7/5GuDQN3q
 12Bu2tTrHhGba2i9Uromv6WC3WB7nPuM5t8D8pClbuaVAShvXgxnmIxaN/JTs20y6mBw
 InfA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=AXeQPk60; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NCEOoN+l
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AXeQPk60";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="NCEOoN+l"; 
 dkim-atps=neutral
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
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for automatically selecting the correct DTB from a FIT
image based on hardware parameters detected at runtime via SMEM,
TCSR, and IMEM.

The FIT image (qclinux_fit.img) is loaded from the "dtb_a" raw GPT
partition. A metadata DTB embedded as the first FIT image is parsed
to build a "bucket list" of matching identifiers based on detected
hardware (OEM, SoC, SoC version, board, board revision, peripheral
subtype, storage type, DDR size, soft SKU). FIT configurations are
then scored against this bucket list via their "compatible" string,
and the best-matching configuration's DTB (plus any listed overlays)
is loaded, overlaid, and installed via the "fdt_addr" environment
variable for the EFI boot flow to consume.

This is gated behind CONFIG_QCOM_FIT_MULTIDTB and is a no-op unless
both the config is enabled and hardware detection succeeds, so it is
safe to enable without affecting boards that don't need it.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
1. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
   of accessing SMEM, IMEM and TCSR data directly.

2. Separate hardware discovery from FIT parsing and DTB matching
   logic, reducing complexity and improving code organization.

3. Load FIT images directly from a raw GPT partition and remove the
   FAT filesystem image based loading approach.

Changes in v3:
1. Runtime IMEM address lookup via DT: Removed CONFIG_QCOM_IMEM_SIZE Kconfig option.
   Added qcom_imem_table[] mapping SoC compatible strings to IMEM addresses.

2. Split SoC version sources: SoC hardware version now read from TCSR register via
   qcom_read_tcsr_soc_version(). The soc_info->plat_ver from SMEM is stored separately
   as board_version. Added socver and boardrev metadata node matching for finer-grained DTB selection.

3. qcom_load_fit_image() returns int: Changed return type from efi_status_t to int,
   returning standard Linux error codes for consistency with the rest of the driver.

4. Code cleanup: strtok() replaced with strsep(); memcpy + manual null-termination replaced with strlcpy();
   DDR thresholds use SZ_* macros; compatible matching and FDT loading extracted into dedicated helpers.
---
 arch/arm/mach-snapdragon/Kconfig             |    9 +
 arch/arm/mach-snapdragon/Makefile            |    1 +
 arch/arm/mach-snapdragon/board.c             |    7 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1033 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |   61 ++
 5 files changed, 1111 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 5911e76dc1e..98b6655385e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -49,6 +49,15 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_FIT_MULTIDTB
+	bool "Enable FIT multi-DTB selection for Qualcomm platforms"
+	depends on FIT
+	select QCOM_HWDETECT
+	help
+	  Enable FIT multi-DTB selection for Qualcomm platforms.
+	  This allows U-Boot to select the appropriate device tree
+	  from a FIT image.
+
 config QCOM_GENERATE_MBN
 	bool "Generate an MBN-compatible ELF binary"
 	help
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 6132847d7f4..74ccdd9bd53 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -10,6 +10,7 @@ obj-y += board_spl.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_QCOM_FIT_MULTIDTB) += qcom_fit_multidtb.o
 obj-$(CONFIG_QCOM_HWDETECT) += qcom_hwdetect.o
 endif
 
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 80bf510d31f..9e7d27b37a3 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -26,6 +26,7 @@
 #include <time.h>
 
 #include "qcom-priv.h"
+#include "qcom_fit_multidtb.h"
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
@@ -442,5 +443,11 @@ int board_late_init(void)
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
+	/* Try FIT multi-DTB selection if enabled */
+	if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
+		if (qcom_fit_multidtb_setup())
+			log_debug("FIT multi-DTB selection not available or failed\n");
+	}
+
 	return 0;
 }
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
new file mode 100644
index 00000000000..a0bbf737548
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
@@ -0,0 +1,1033 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Automatic DTB selection from FIT images based on hardware detection via SMEM.
+ * Loads qclinux_fit.img from dtb partition, detects hardware parameters,
+ * and selects the best matching DTB configuration.
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <lmb.h>
+#include <log.h>
+#include <malloc.h>
+#include <part.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/list.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include "qcom_fit_multidtb.h"
+#include "qcom_hwdetect.h"
+
+/* GPT partition name containing the FIT image */
+#define QCOM_FIT_PARTNAME	"dtb_a"
+
+#define lmb_alloc(size, addr) \
+	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
+
+/* Maximum values to match (SOC needs 2) */
+#define MAX_MATCH_VALUES 2
+
+/* Metadata DTB node names */
+#define META_NODE_OEM          "oem"
+#define META_NODE_SOC          "soc"
+#define META_NODE_SOCVER       "socver"
+#define META_NODE_BOARD        "board"
+#define META_NODE_BOARDREV     "boardrev"
+#define META_NODE_SOC_SKU      "soc-sku"
+#define META_NODE_BOARD_SUBTYPE_PERIPHERAL "board-subtype-peripheral-subtype"
+#define META_NODE_BOARD_SUBTYPE_STORAGE    "board-subtype-storage-type"
+#define META_NODE_BOARD_SUBTYPE_DDR_SIZE   "board-subtype-memory-size"
+#define META_NODE_SOFTSKU      "softsku"
+
+/* Property names */
+#define PROP_OEM_ID            "oem-id"
+#define PROP_MSM_ID            "msm-id"
+#define PROP_SOCVER_ID         "socver-id"
+#define PROP_BOARD_ID          "board-id"
+#define PROP_BOARDREV_ID       "boardrev-id"
+#define PROP_BOARD_SUBTYPE     "board-subtype"
+#define PROP_SOFTSKU_ID        "softsku-id"
+#define PROP_COMPATIBLE        "compatible"
+#define PROP_FDT               "fdt"
+#define PROP_DATA              "data"
+
+/**
+ * struct overlay_entry - Gathered overlay FDT image info
+ * @name: Overlay image name in the FIT
+ * @data: Pointer to overlay FDT data within the FIT
+ * @size: Size of the overlay FDT data
+ */
+struct overlay_entry {
+	const char *name;
+	const void *data;
+	size_t size;
+};
+
+/**
+ * add_to_bucket() - Add a node name to the bucket list
+ * @name: Node name to add
+ * @name_len: Length of the name
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int add_to_bucket(const char *name, int name_len, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	node = malloc(sizeof(*node));
+	if (!node)
+		return -ENOMEM;
+
+	node->name = malloc(name_len + 1);
+	if (!node->name) {
+		free(node);
+		return -ENOMEM;
+	}
+
+	strlcpy(node->name, name, name_len + 1);
+
+	list_add_tail(&node->list, bucket_head);
+
+	return 0;
+}
+
+/**
+ * search_in_bucket() - Check if a name exists in the bucket list
+ * @name: Name to search for
+ * @bucket_head: Head of the bucket list
+ *
+ * Return: true if found, false otherwise
+ */
+static bool search_in_bucket(const char *name, struct list_head *bucket_head)
+{
+	struct bucket_node *node;
+
+	list_for_each_entry(node, bucket_head, list) {
+		if (!strcmp(node->name, name))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * free_bucket_list() - Free all nodes in the bucket list
+ * @bucket_head: Head of the bucket list
+ */
+static void free_bucket_list(struct list_head *bucket_head)
+{
+	struct bucket_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, bucket_head, list) {
+		list_del(&node->list);
+		free(node->name);
+		free(node);
+	}
+}
+
+/**
+ * log_match_values() - Log matched hardware parameter values
+ * @log_type: Type label for logging (e.g., "SOC", "Board")
+ * @subnode_name: Name of the matched node
+ * @num_match_values: Number of values to log
+ * @match_values: Array of matched values
+ */
+static void log_match_values(const char *log_type, const char *subnode_name,
+			     int num_match_values, const u32 *match_values)
+{
+	int i;
+
+	log_info("Matched %s: %s (", log_type, subnode_name);
+
+	for (i = 0; i < num_match_values; i++) {
+		if (i > 0)
+			log_info(", ");
+		log_info("val%d=0x%x", i + 1, match_values[i]);
+	}
+
+	log_info(")\n");
+}
+
+/**
+ * process_node() - Generic metadata node processor
+ * @type: Type of node to process
+ * @metadata: Metadata DTB pointer
+ * @root_offset: Root node offset
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * Processes different types of nodes in the metadata DTB. Handles matching
+ * hardware parameters against DTB properties, with support for bit masking/shifting
+ * and fallback values.
+ *
+ * Return: 0 on success, -ENOENT if no match, other negative on error
+ */
+static int process_node(enum node_process_type type,
+			void *metadata,
+			int root_offset,
+			struct qcom_hw_params *params,
+			struct list_head *bucket_head)
+{
+	const char *node_name, *prop_name, *log_type;
+	const char *fallback;
+	const char *subnode_name;
+	int node_offset, subnode, len, name_len;
+	int num_match_values, i;
+	u32 match_values[MAX_MATCH_VALUES];
+	u32 masks[MAX_MATCH_VALUES];
+	int shifts[MAX_MATCH_VALUES];
+	bool all_match;
+
+	fallback = NULL;
+	num_match_values = 1;
+	memset(shifts, 0, sizeof(shifts));
+	memset(masks, 0xff, sizeof(masks));
+
+	switch (type) {
+	case NODE_TYPE_OEM:
+		node_name = META_NODE_OEM;
+		prop_name = PROP_OEM_ID;
+		match_values[0] = params->oem_variant_id;
+		log_type = "OEM";
+		fallback = "qcom";
+		break;
+	case NODE_TYPE_SOC:
+		node_name = META_NODE_SOC;
+		prop_name = PROP_MSM_ID;
+		match_values[0] = params->chip_id;
+		masks[0] = 0xffff;
+		num_match_values = 1;
+		log_type = "SOC";
+		break;
+	case NODE_TYPE_SOCVER:
+		node_name = META_NODE_SOCVER;
+		prop_name = PROP_SOCVER_ID;
+		match_values[0] = params->chip_version;
+		num_match_values = 1;
+		log_type = "SOCVER";
+		break;
+	case NODE_TYPE_BOARD:
+		node_name = META_NODE_BOARD;
+		prop_name = PROP_BOARD_ID;
+		match_values[0] = params->platform;
+		log_type = "Board";
+		break;
+	case NODE_TYPE_BOARDREV:
+		node_name = META_NODE_BOARDREV;
+		prop_name = PROP_BOARDREV_ID;
+		match_values[0] = params->board_version;
+		num_match_values = 1;
+		log_type = "BoardRev";
+		break;
+	case NODE_TYPE_PERIPHERAL:
+		node_name = META_NODE_BOARD_SUBTYPE_PERIPHERAL;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->subtype;
+		log_type = "Peripheral Subtype";
+		break;
+	case NODE_TYPE_STORAGE:
+		node_name = META_NODE_BOARD_SUBTYPE_STORAGE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->storage_type;
+		masks[0] = 0xc000;
+		shifts[0] = 14;
+		log_type = "Storage";
+		break;
+	case NODE_TYPE_DDR_SIZE:
+		node_name = META_NODE_BOARD_SUBTYPE_DDR_SIZE;
+		prop_name = PROP_BOARD_SUBTYPE;
+		match_values[0] = params->ddr_size_type;
+		masks[0] = 0x1f00;
+		shifts[0] = 8;
+		log_type = "DDR Size";
+		break;
+	case NODE_TYPE_SOFTSKU:
+		node_name = META_NODE_SOFTSKU;
+		prop_name = PROP_SOFTSKU_ID;
+		match_values[0] = params->softsku_id;
+		log_type = "SoftSKU";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	node_offset = fdt_subnode_offset(metadata, root_offset, node_name);
+	if (node_offset < 0) {
+		log_debug("%s node not found\n", log_type);
+		return node_offset;
+	}
+
+	fdt_for_each_subnode(subnode, metadata, node_offset) {
+		const u32 *prop = fdt_getprop(metadata, subnode, prop_name, &len);
+
+		if (!prop || len < (int)(num_match_values * sizeof(u32)))
+			continue;
+
+		all_match = true;
+		for (i = 0; i < num_match_values; i++) {
+			u32 dtb_value = fdt32_to_cpu(prop[i]);
+
+			dtb_value = (dtb_value & masks[i]) >> shifts[i];
+
+			if (dtb_value != match_values[i]) {
+				all_match = false;
+				break;
+			}
+		}
+
+		if (!all_match)
+			continue;
+
+		subnode_name = fdt_get_name(metadata, subnode, &name_len);
+		if (subnode_name) {
+			log_match_values(log_type, subnode_name, num_match_values,
+					 match_values);
+			return add_to_bucket(subnode_name, name_len, bucket_head);
+		}
+	}
+
+	if (fallback) {
+		log_info("No %s match, using fallback '%s'\n", log_type, fallback);
+		return add_to_bucket(fallback, strlen(fallback), bucket_head);
+	}
+
+	log_debug("No %s match\n", log_type);
+
+	return -ENOENT;
+}
+
+/**
+ * qcom_add_dtbo_tokens() - Split a comma-separated token string into the bucket list
+ * @str: Comma-separated overlay token string
+ * @bucket_head: Bucket list head
+ *
+ * Splits @str on commas, trims surrounding whitespace from each token, skips
+ * empty tokens, and adds each remaining token to the bucket list.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_add_dtbo_tokens(const char *str, struct list_head *bucket_head)
+{
+	char *str_copy;
+	char *str_ptr;
+	char *token;
+	int ret = 0;
+
+	str_copy = strdup(str);
+	if (!str_copy)
+		return -ENOMEM;
+
+	str_ptr = str_copy;
+	while ((token = strsep(&str_ptr, ","))) {
+		while (*token == ' ' || *token == '\t')
+			token++;
+
+		if (!*token)
+			continue;
+
+		log_info("Adding vendor DTBO token: %s\n", token);
+		ret = add_to_bucket(token, strlen(token), bucket_head);
+		if (ret) {
+			log_err("Failed to add token '%s': %d\n", token, ret);
+			break;
+		}
+	}
+
+	free(str_copy);
+	return ret;
+}
+
+/**
+ * qcom_parse_vendor_dtbo() - Parse vendor_dtbo environment variable
+ * @bucket_head: Bucket list to add overlay tokens to
+ *
+ * Reads the "vendor_dtbo" environment variable and parses its comma-separated
+ * overlay identifiers, adding them to the bucket list for FIT configuration
+ * matching. This influences which FIT configuration is selected.
+ *
+ * Return: 0 on success, negative error code on failure or if unset
+ */
+static int qcom_parse_vendor_dtbo(struct list_head *bucket_head)
+{
+	const char *vendor_dtbo;
+
+	vendor_dtbo = env_get("vendor_dtbo");
+	if (!vendor_dtbo || !*vendor_dtbo)
+		return -ENOENT;
+
+	log_info("vendor_dtbo: %s\n", vendor_dtbo);
+
+	return qcom_add_dtbo_tokens(vendor_dtbo, bucket_head);
+}
+
+/**
+ * qcom_build_bucket_list() - Build bucket list from metadata DTB
+ * @metadata: Metadata DTB pointer
+ * @params: Hardware parameters
+ * @bucket_head: Bucket list head
+ *
+ * This function parses the metadata DTB and builds a list of matching
+ * node names based on the detected hardware parameters.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_build_bucket_list(void *metadata,
+				  struct qcom_hw_params *params,
+				  struct list_head *bucket_head)
+{
+	int root_offset;
+	int ret;
+	struct bucket_node *node;
+
+	log_debug("Building bucket list from hardware parameters\n");
+
+	root_offset = fdt_path_offset(metadata, "/");
+	if (root_offset < 0) {
+		log_err("Failed to find root node in metadata DTB\n");
+		return root_offset;
+	}
+
+	ret = process_node(NODE_TYPE_OEM, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOC, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_SOCVER, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARD, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	ret = process_node(NODE_TYPE_BOARDREV, metadata, root_offset,
+			   params, bucket_head);
+	if (ret < 0 && ret != -ENOENT)
+		return ret;
+
+	process_node(NODE_TYPE_PERIPHERAL, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_STORAGE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_DDR_SIZE, metadata, root_offset,
+		     params, bucket_head);
+
+	process_node(NODE_TYPE_SOFTSKU, metadata, root_offset,
+		     params, bucket_head);
+
+	ret = qcom_parse_vendor_dtbo(bucket_head);
+	if (ret)
+		log_debug("vendor_dtbo not applied: %d\n", ret);
+
+	log_debug("Bucket list: ");
+	list_for_each_entry(node, bucket_head, list)
+		log_debug("%s ", node->name);
+	log_debug("\n");
+
+	return 0;
+}
+
+/**
+ * qcom_fit_calc_size() - Compute the true total size of a FIT image
+ * @fit: Pointer to a buffer containing at least the FIT's FDT structure
+ * @buf_size: Size of the buffer pointed to by @fit
+ *
+ * External-data FITs store image payloads after the FDT structure via
+ * "data-offset"/"data-size" properties, so fdt_totalsize() alone misses
+ * them. Walk /images to find the true end of the file.
+ *
+ * Return: total FIT size in bytes, or 0 on error
+ */
+static size_t qcom_fit_calc_size(const void *fit, size_t buf_size)
+{
+	int images_node, node;
+	size_t aligned_size, max_end, end;
+	int offset, size;
+
+	if (buf_size < sizeof(struct fdt_header) || fdt_check_header(fit)) {
+		log_err("Invalid FDT header while probing FIT size\n");
+		return 0;
+	}
+
+	aligned_size = (fdt_totalsize(fit) + 3) & ~3;
+	max_end = 0;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0)
+		return aligned_size;
+
+	fdt_for_each_subnode(node, fit, images_node) {
+		if (fit_image_get_data_offset(fit, node, &offset))
+			continue;
+		if (fit_image_get_data_size(fit, node, &size))
+			continue;
+		if (offset < 0 || size < 0)
+			continue;
+
+		end = (size_t)offset + (size_t)size;
+		if (end > max_end)
+			max_end = end;
+	}
+
+	return max_end ? aligned_size + max_end : aligned_size;
+}
+
+/**
+ * qcom_load_raw_partition() - Load FIT image from a raw partition by name
+ * @partname: GPT partition name to search for
+ * @fitp: Pointer to store FIT image address
+ * @fit_sizep: Pointer to store FIT image size
+ *
+ * Probes the FDT structure first to size the real FIT, instead of
+ * malloc()'ing the whole (possibly oversized) partition. The caller is
+ * responsible for validating the content (fdt_check_header, fit_check_format).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_raw_partition(const char *partname, void **fitp,
+				   size_t *fit_sizep)
+{
+	struct udevice *blk_dev;
+	struct blk_desc *desc = NULL;
+	struct disk_partition part_info;
+	void *probe_buf;
+	void *part_buf;
+	size_t probe_size, probe_blocks, fit_size;
+	lbaint_t fit_blocks;
+
+	blk_foreach_probe(BLKF_BOTH, blk_dev) {
+		desc = dev_get_uclass_plat(blk_dev);
+		if (!desc)
+			continue;
+		if (part_get_info_by_name(desc, partname, &part_info) >= 0)
+			break;
+		desc = NULL;
+	}
+
+	if (!desc) {
+		log_err("Partition '%s' not found on any block device\n", partname);
+		return -ENOENT;
+	}
+
+	probe_blocks = min_t(size_t, DIV_ROUND_UP(SZ_8K, part_info.blksz),
+			     part_info.size);
+	probe_size = probe_blocks * part_info.blksz;
+
+	probe_buf = malloc(probe_size);
+	if (!probe_buf)
+		return -ENOMEM;
+
+	if (blk_dread(desc, part_info.start, probe_blocks, probe_buf) != probe_blocks) {
+		log_err("Failed to probe-read partition '%s'\n", partname);
+		free(probe_buf);
+		return -EIO;
+	}
+
+	fit_size = qcom_fit_calc_size(probe_buf, probe_size);
+	free(probe_buf);
+
+	if (!fit_size) {
+		log_err("Failed to determine FIT size for partition '%s'\n", partname);
+		return -EINVAL;
+	}
+
+	if (fit_size > (size_t)(part_info.size * part_info.blksz))
+		fit_size = (size_t)(part_info.size * part_info.blksz);
+
+	fit_blocks = DIV_ROUND_UP(fit_size, part_info.blksz);
+	fit_size = (size_t)fit_blocks * part_info.blksz;
+
+	part_buf = malloc(fit_size);
+	if (!part_buf)
+		return -ENOMEM;
+
+	if (blk_dread(desc, part_info.start, fit_blocks, part_buf) != fit_blocks) {
+		log_err("Failed to read partition '%s'\n", partname);
+		free(part_buf);
+		return -EIO;
+	}
+
+	*fitp = part_buf;
+	*fit_sizep = fit_size;
+
+	log_info("Loaded raw partition '%s': %zu bytes\n", partname, fit_size);
+	return 0;
+}
+
+/**
+ * qcom_extract_metadata_dtb() - Extract metadata DTB from FIT image
+ * @fit: FIT image pointer
+ * @metadata: Pointer to store metadata DTB address
+ * @metadata_size: Pointer to store metadata DTB size
+ *
+ * The metadata DTB is the first image in the FIT (fdt-0).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_extract_metadata_dtb(void *fit, void **metadata,
+				     size_t *metadata_size)
+{
+	int images_node, first_image;
+	const void *data;
+	size_t size;
+	int ret;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0) {
+		log_err("Cannot find /images node in FIT\n");
+		return images_node;
+	}
+
+	first_image = fdt_first_subnode(fit, images_node);
+	if (first_image < 0) {
+		log_err("Cannot find first image in FIT\n");
+		return first_image;
+	}
+
+	ret = fit_image_get_data(fit, first_image, &data, &size);
+	if (ret) {
+		log_err("Failed to get metadata DTB data\n");
+		return ret;
+	}
+
+	*metadata = malloc(size);
+	if (!*metadata) {
+		log_err("Failed to allocate memory for metadata DTB\n");
+		return -ENOMEM;
+	}
+
+	memcpy(*metadata, data, size);
+	*metadata_size = size;
+
+	log_info("Extracted metadata DTB: %zu bytes\n", size);
+
+	return 0;
+}
+
+/**
+ * qcom_count_compatible_matches() - Count matching tokens in compatible string
+ * @compatible: Compatible string from FIT configuration
+ * @compat_len: Length of compatible string
+ * @bucket_head: Bucket list head
+ *
+ * Parses the compatible string and counts how many tokens match entries
+ * in the bucket list. The compatible string format is typically:
+ * "vendor,device-variant-subtype" where tokens are separated by commas and dashes.
+ *
+ * Return: Number of matching tokens
+ */
+static int qcom_count_compatible_matches(const char *compatible, int compat_len,
+					 struct list_head *bucket_head,
+					 bool *full_match)
+{
+	char *compat_copy;
+	char *str_ptr;
+	char *token;
+	int match_count = 0;
+
+	*full_match = true;
+
+	compat_copy = malloc(compat_len + 1);
+	if (!compat_copy) {
+		*full_match = false;
+		return 0;
+	}
+
+	memcpy(compat_copy, compatible, compat_len);
+	compat_copy[compat_len] = '\0';
+
+	str_ptr = compat_copy;
+
+	strsep(&str_ptr, ",");
+
+	token = strsep(&str_ptr, "-");
+	while (token) {
+		match_count++;
+		if (!search_in_bucket(token, bucket_head)) {
+			*full_match = false;
+			break;
+		}
+		token = strsep(&str_ptr, "-");
+	}
+
+	free(compat_copy);
+	return match_count;
+}
+
+/**
+ * qcom_find_matching_config() - Find matching FIT configuration
+ * @fit: FIT image pointer
+ * @bucket_head: Bucket list head
+ * @config_node: Pointer to store matching configuration node offset
+ *
+ * This function iterates through all FIT configurations and finds the one
+ * with the most matching tokens in its compatible string against the bucket list.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_find_matching_config(void *fit, struct list_head *bucket_head,
+				     int *config_node)
+{
+	int configs_node, cfg;
+	const char *compatible;
+	int compat_len;
+	const char *cfg_name;
+	int name_len;
+	int best_match_count = 0;
+	int best_config = -1;
+	int match_count;
+	bool full_match;
+
+	configs_node = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (configs_node < 0) {
+		log_err("Cannot find /configurations node in FIT\n");
+		return configs_node;
+	}
+
+	fdt_for_each_subnode(cfg, fit, configs_node) {
+		cfg_name = fdt_get_name(fit, cfg, &name_len);
+		compatible = fdt_getprop(fit, cfg, PROP_COMPATIBLE, &compat_len);
+
+		if (!compatible || compat_len <= 0) {
+			log_debug("Config %s has no compatible property\n", cfg_name);
+			continue;
+		}
+
+		log_debug("Checking config: %s, compatible: %s\n",
+			  cfg_name, compatible);
+
+		match_count = qcom_count_compatible_matches(compatible, compat_len,
+							    bucket_head, &full_match);
+
+		log_debug("Config %s: %d tokens, full_match=%d\n", cfg_name,
+			  match_count, full_match);
+
+		if (!full_match)
+			continue;
+
+		if (match_count > best_match_count) {
+			best_match_count = match_count;
+			best_config = cfg;
+		}
+	}
+
+	if (best_config < 0) {
+		log_err("No matching configuration found\n");
+		return -ENOENT;
+	}
+
+	cfg_name = fdt_get_name(fit, best_config, &name_len);
+	compatible = fdt_getprop(fit, best_config, PROP_COMPATIBLE, &compat_len);
+	log_info("Selected configuration: %s (compatible: %s, matches: %d)\n",
+		 cfg_name, compatible, best_match_count);
+
+	*config_node = best_config;
+	return 0;
+}
+
+/**
+ * qcom_get_fdt_image_data() - Get FDT image data from FIT
+ * @fit: FIT image pointer
+ * @images_node: Images node offset
+ * @fdt_name: FDT image name to load
+ * @fdt_datap: Pointer to store FDT data address
+ * @fdt_sizep: Pointer to store FDT data size
+ *
+ * Helper function to load an FDT image from the FIT by name.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_get_fdt_image_data(void *fit, int images_node,
+				   const char *fdt_name,
+				   const void **fdt_datap, size_t *fdt_sizep)
+{
+	int fdt_node;
+	int ret;
+
+	fdt_node = fdt_subnode_offset(fit, images_node, fdt_name);
+	if (fdt_node < 0) {
+		log_err("Cannot find FDT node: %s\n", fdt_name);
+		return fdt_node;
+	}
+
+	ret = fit_image_get_data(fit, fdt_node, fdt_datap, fdt_sizep);
+	if (ret) {
+		log_err("Failed to get FDT data for %s\n", fdt_name);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * qcom_load_dtb_with_overlays() - Load DTB and apply overlays
+ * @fit: FIT image pointer
+ * @config_node: Configuration node offset
+ * @final_dtb: Pointer to store final DTB address
+ * @final_dtb_size: Pointer to store final DTB size
+ *
+ * This function loads the base DTB and applies all DTBOs specified in the
+ * configuration's "fdt" property.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_load_dtb_with_overlays(void *fit, int config_node,
+				       void **final_dtb,
+				       size_t *final_dtb_size)
+{
+	int images_node;
+	const char *fdt_name;
+	int fdt_name_len;
+	const void *fdt_data;
+	size_t fdt_size;
+	void *base_dtb = NULL;
+	size_t base_dtb_size = 0;
+	phys_addr_t dtb_addr;
+	int i, ret;
+	int fixups_offset;
+	struct overlay_entry *overlays = NULL;
+	int overlay_count = 0;
+	size_t overlays_size = 0;
+
+	images_node = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images_node < 0)
+		return images_node;
+
+	fdt_name = fdt_stringlist_get(fit, config_node, PROP_FDT, 0, &fdt_name_len);
+	if (!fdt_name) {
+		log_err("No fdt property in configuration\n");
+		return -EINVAL;
+	}
+
+	log_info("DTB: %s\n", fdt_name);
+
+	ret = qcom_get_fdt_image_data(fit, images_node, fdt_name,
+				      &fdt_data, &fdt_size);
+	if (ret)
+		return ret;
+
+	/* Gather overlay entries once: name, data pointer, and size */
+	for (i = 1; ; i++) {
+		const char *ov_name;
+		const void *ov_data;
+		size_t ov_size;
+		int ov_name_len;
+		struct overlay_entry *tmp;
+
+		ov_name = fdt_stringlist_get(fit, config_node, PROP_FDT, i, &ov_name_len);
+		if (!ov_name)
+			break;
+
+		if (qcom_get_fdt_image_data(fit, images_node, ov_name, &ov_data, &ov_size))
+			continue;
+
+		tmp = realloc(overlays, (overlay_count + 1) * sizeof(*overlays));
+		if (!tmp) {
+			ret = -ENOMEM;
+			goto free_overlays;
+		}
+		overlays = tmp;
+		overlays[overlay_count].name = ov_name;
+		overlays[overlay_count].data = ov_data;
+		overlays[overlay_count].size = ov_size;
+		overlay_count++;
+		overlays_size += ov_size;
+	}
+
+	/* Allocate base DTB with extra space for overlays using LMB */
+	base_dtb_size = fdt_size + overlays_size + (2 * 1024);
+	ret = lmb_alloc(base_dtb_size, &dtb_addr);
+	if (ret) {
+		log_err("Failed to allocate LMB memory for base DTB: %zu bytes\n", base_dtb_size);
+		ret = -ENOMEM;
+		goto free_overlays;
+	}
+	base_dtb = (void *)dtb_addr;
+
+	memcpy(base_dtb, fdt_data, fdt_size);
+	ret = fdt_open_into(base_dtb, base_dtb, base_dtb_size);
+	if (ret) {
+		log_err("Failed to open DTB: %d\n", ret);
+		goto free_overlays;
+	}
+
+	/* Apply overlays using the already-gathered entries */
+	for (i = 0; i < overlay_count; i++) {
+		log_info("Applying overlay: %s (%zu bytes)\n",
+			 overlays[i].name, overlays[i].size);
+
+		fixups_offset = fdt_path_offset(overlays[i].data, "/__fixups__");
+		if (fixups_offset == -FDT_ERR_NOTFOUND) {
+			log_warning("%s is not a valid overlay (no __fixups__)\n",
+				    overlays[i].name);
+			continue;
+		}
+
+		ret = fdt_overlay_apply_verbose(base_dtb, (void *)overlays[i].data);
+		if (ret)
+			log_err("Failed to apply overlay %s: %d\n", overlays[i].name, ret);
+	}
+
+	ret = fdt_pack(base_dtb);
+	if (ret) {
+		log_err("Failed to pack DTB: %d\n", ret);
+		goto free_overlays;
+	}
+
+	*final_dtb = base_dtb;
+	*final_dtb_size = fdt_totalsize(base_dtb);
+
+	log_info("Final DTB size: %zu bytes\n", *final_dtb_size);
+
+	ret = 0;
+
+free_overlays:
+	free(overlays);
+	return ret;
+}
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This is the main function that orchestrates the entire DTB selection process:
+ * 1. Load qclinux_fit.img from EFI partition
+ * 2. Extract metadata DTB
+ * 3. Detect hardware parameters from SMEM
+ * 4. Build bucket list from metadata
+ * 5. Find matching FIT configuration
+ * 6. Load DTB and apply overlays
+ * 7. Install FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void)
+{
+	void *fit = NULL;
+	size_t fit_size = 0;
+	void *metadata = NULL;
+	size_t metadata_size = 0;
+	struct qcom_hw_params hw_params;
+	LIST_HEAD(bucket_list);
+	int config_node;
+	void *final_dtb = NULL;
+	size_t final_dtb_size = 0;
+	int ret;
+
+	log_debug("=== FIT Multi-DTB Selection ===\n");
+
+	log_debug("Loading FIT image\n");
+	ret = qcom_load_raw_partition(QCOM_FIT_PARTNAME, &fit, &fit_size);
+	if (ret) {
+		log_err("Failed to load FIT image\n");
+		goto cleanup_fit;
+	}
+
+	ret = fdt_check_header(fit);
+	if (ret) {
+		log_err("Invalid FIT header\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
+	if (ret) {
+		log_err("Invalid FIT format\n");
+		ret = -EINVAL;
+		goto cleanup_fit;
+	}
+
+	log_debug("Extracting metadata DTB\n");
+	ret = qcom_extract_metadata_dtb(fit, &metadata, &metadata_size);
+	if (ret) {
+		log_err("Failed to extract metadata DTB\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Detecting hardware parameters\n");
+	ret = qcom_hwdetect_get_params(&hw_params);
+	if (ret) {
+		log_err("Failed to detect hardware parameters\n");
+		goto cleanup_metadata;
+	}
+
+	log_debug("Building bucket list\n");
+	ret = qcom_build_bucket_list(metadata, &hw_params, &bucket_list);
+	if (ret) {
+		log_err("Failed to build bucket list\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Finding matching configuration\n");
+	ret = qcom_find_matching_config(fit, &bucket_list, &config_node);
+	if (ret) {
+		log_err("Failed to find matching configuration\n");
+		goto cleanup_bucket;
+	}
+
+	log_debug("Loading DTB and applying overlays\n");
+	ret = qcom_load_dtb_with_overlays(fit, config_node, &final_dtb,
+					  &final_dtb_size);
+	if (ret) {
+		log_err("Failed to load DTB with overlays\n");
+		goto cleanup_dtb;
+	}
+
+	log_debug("Setting fdt_addr to selected DTB address\n");
+
+	ret = fdt_check_header(final_dtb);
+	if (ret) {
+		log_err("Invalid final DTB header: %d\n", ret);
+		ret = -EINVAL;
+		goto cleanup_dtb;
+	}
+
+	/* Update fdt_addr environment variable to point to our DTB */
+	env_set_hex("fdt_addr", (ulong)final_dtb);
+	log_info("Updated fdt_addr=0x%lx, DTB size=%zu bytes\n", (ulong)final_dtb, final_dtb_size);
+	log_info("EFI boot flow will use DTB directly from this address\n");
+
+	/* Don't free final_dtb - LMB manages memory and EFI boot flow will use it */
+	final_dtb = NULL;
+
+	log_debug("=== FIT Multi-DTB Selection Complete ===\n");
+
+	ret = 0;
+	goto cleanup_success;
+
+cleanup_dtb:
+	if (ret && final_dtb)
+		final_dtb = NULL;
+
+cleanup_success:
+cleanup_bucket:
+	free_bucket_list(&bucket_list);
+
+cleanup_metadata:
+	if (metadata)
+		free(metadata);
+
+cleanup_fit:
+	if (fit)
+		free(fit);
+
+	return ret;
+}
diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.h b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
new file mode 100644
index 00000000000..257cbb5fb43
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm FIT Multi-DTB Selection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * This implements automatic DTB selection from FIT images based on hardware
+ * detection via SMEM.
+ */
+
+#ifndef __QCOM_FIT_MULTIDTB_H__
+#define __QCOM_FIT_MULTIDTB_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+/**
+ * struct bucket_node - Node in the bucket list
+ * @list: List head for linking nodes
+ * @name: Node name string (e.g., "qcom", "sa8775p-v2", "ride", "ufs", "8gb")
+ *
+ * The bucket list contains all matching node names from the metadata DTB.
+ * These are used to match against FIT configuration compatible strings.
+ */
+struct bucket_node {
+	struct list_head list;
+	char *name;
+};
+
+/* Node processing types for metadata DTB parsing */
+enum node_process_type {
+	NODE_TYPE_OEM,
+	NODE_TYPE_SOC,
+	NODE_TYPE_SOCVER,
+	NODE_TYPE_BOARD,
+	NODE_TYPE_BOARDREV,
+	NODE_TYPE_PERIPHERAL,
+	NODE_TYPE_STORAGE,
+	NODE_TYPE_DDR_SIZE,
+	NODE_TYPE_SOFTSKU,
+};
+
+/* Function prototypes */
+
+/**
+ * qcom_fit_multidtb_setup() - Main entry point for FIT multi-DTB selection
+ *
+ * This function:
+ * 1. Loads qclinux_fit.img from EFI partition
+ * 2. Extracts metadata DTB
+ * 3. Detects hardware parameters from SMEM
+ * 4. Builds bucket list from metadata
+ * 5. Finds matching FIT configuration
+ * 6. Loads DTB and applies overlays
+ * 7. Sets FDT for EFI
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_fit_multidtb_setup(void);
+
+#endif /* __QCOM_FIT_MULTIDTB_H__ */
-- 
2.34.1

