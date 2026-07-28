Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487EDC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5B2E40A49;
	Tue, 28 Jul 2026 19:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id COgFF-rv2O2D; Tue, 28 Jul 2026 19:14:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A202C40A10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266069;
	bh=7BwvrBdT8Z+ksBuq8awLHeNtgLrgnQyxyFrVy7ZM1HU=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=xWXgY2nRxyc5ufqQt5GkRqDtP23/v9jKBCL1igXTN3j/r3ZwX3/xc2cKDMRJXI/xq
	 K1ZfCuOvQW3VbaJjnZNib9EIc8pFJssqU4NC01uNQ67ZMc4wSLBZFDfWOzxkYypVQR
	 ISeL3mUZQVxE9IKO6GPs7GA13CZH6UvimZyOcuKzFXgYiqvA5lsq5SckRlYf0Kbjlp
	 vfbeC7RAdfRy8dyfbgq0RPpYIOMWyH6cC1n37CDqOryrqAPxWaRruvhbyUmBdlgWMT
	 CcSVFZzJDhZR8ra/Tzwo1Priu4iDJazbReZEKEBqX4k0L9suBp/Yo4nONt29bTlaeH
	 4nEQsA0AH22xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A202C40A10;
	Tue, 28 Jul 2026 19:14:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE3D245B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C451040364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMwyQbJibcMk for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E99CA40099
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E99CA40099
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E99CA40099
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD868494B; Tue, 28 Jul 2026 21:14:22 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FA08404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:18 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIC2f83578958
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:17 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpuygac0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so64243a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266056; x=1785870856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7BwvrBdT8Z+ksBuq8awLHeNtgLrgnQyxyFrVy7ZM1HU=;
 b=eTqG5oZkojqzQusF1klXpKtiq0EadPK6y1l1my3Rhy3SWndvY+8EmXMxQvmi0fYieQ
 wn2pFCyD9BjvCw+oXRboqKtFz1zuEljnebsyMwAEHs/HnSIjme9y9kTxw4RueUZIQywu
 LKLkfdyVPUgyF81y9x9QATYr4V6OEc+NXeUw2zXkDS+KWgKDnhYMECtAymhtazPZFXj1
 DdTac8VTcwoOiYGzgBFrHu+K54cYZAd56CDH7AxyhmDXyVKvlnQ8B68AGu7p/iAu/b9D
 03wqljCzn99GPf10keWntl5Bf6qHNFmfE/o3+1KtDcsypj6jAdFYDjJgiICWAV5KLpMW
 TlDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJa5VAj+I9G1MjykDvut7dw35ocDRFZiW+r+4P/ZnZPEzjbAiWb4I7xGk/+EmZXSRmu2kKz2o=@lists.denx.de
X-Gm-Message-State: AOJu0YxcnSdYMA6u4HF7d2eRZ/Lf61n9yT2qpXF5xbWBjJBb0yyD22oy
 XG38qEKWEA3Ie1YSpRtNc1Q0h2N6r6tTFie7yyYHcxp54qHHL31Ke9C1esYtHXRF+waxlYF4OFB
 i3WPgZhUTK+LJ/d4MCcqEy9o3SoFV78thgxUSjedZrdrnQGxPCxw8Ne1I
X-Gm-Gg: AR+sD12paTSRdrp3da4aR6zllwhIIc1WqAfVjK5Xv8Xc7yDd5emnR0/4R27C/2pVhh0
 WuiI8rJBGKgRY/bq3aIoCznJ3IZ4hxc3L/ahOD5CbWXIVUtVKFI43sSJH99uAFp1ZbLorIabQXu
 Q8YMRRgSUFg8Jr9904iUBMupNxKlQco1bVwArrbFgC4Jv8/80hdOfVzz9iJvT2ATfaYPZoMgYLe
 cBJw320aBWkjYlhKvU91xAPyW+q2hMmXu8s7p0Sz2eRlckYODzTTu7VvjE6EK9Yst3/2zTKjRSp
 29cdzyYp3k4Tn8xfa1u/sTkhzwYQyzXl+N+CHXigf+Tl0ICErAp3/Yg+HLjFMcy+oXxZbv0Lw7E
 EJGR5wTfy8ujrZ3n8fVOLG6C8pth7UX8aRfwIv1kl/0BnPKu8mLqPJZt8PP5rNLntRM4TFoLdvn
 JllBfTmKn19mSUg7McBBU=
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id
 adf61e73a8af0-3c8ba63bac4mr4984959637.72.1785266056321; 
 Tue, 28 Jul 2026 12:14:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id
 adf61e73a8af0-3c8ba63bac4mr4984910637.72.1785266055844; 
 Tue, 28 Jul 2026 12:14:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:15 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 0/5] Add FIT multi-DTB selection for Qualcomm
Date: Wed, 29 Jul 2026 00:43:56 +0530
Message-Id: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oIKnsjJS11jrRFaU0Z2cQPufupFMWyHZ
X-Proofpoint-ORIG-GUID: oIKnsjJS11jrRFaU0Z2cQPufupFMWyHZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX0iOR0UlV5DTS
 6XBD0Phd39ERPToGcIXxDEe0hA/Op0CW9pYF2vu0/xrfQ2xFzD/Mm0YLgmHpvF0dbehVn28vZsQ
 IEu1uujPDYMwIhMG/w41p3DlGXHh50uHxIvdAe/hA748pukxqwX+ZczkoomYWnpfr2Uzbs/1qbo
 GV5ck1aBHMyVQPGtTXendByfUF65Ez6ql+SZExmg0GBbbMwpzMgCyF/H+tNZHqNrzP8F77ufd8t
 Q8c4ODKwhdRW0AGx5md/lilTbvHf0flulAru3W4MZ+bnmeQBvqZE4wr5qFdEgX/Hd6xzsI9LBIj
 hbj+c+xoafGG/KXa2AcEqB0nQjqWFmDNbvzvOLAMl35JQe/Xa3c6PYFPbrRdbjNj5+VZ+/1gW2i
 WRhYhKrxQ6qt8vaiN/B6J6TiZZFaGX1P/8sG26KQ4OfjxBjwZGZvUu6/r7khuxtYL6ZhOxOaQM2
 kOToegWRzEXFjS4P8+A==
X-Authority-Analysis: v=2.4 cv=aoWCzyZV c=1 sm=1 tr=0 ts=6a68ff89 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=cSziVDP4AAAA:20
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u38HHJEOLTUlGKIKg8AA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX/O7Xom0YjMLM
 L7LEnqYVrX1+5xs9t2maJPRhTwRZdrUFJUENQzvvP/IuMvfYzzRyHWDTsWaPp+yDnmuQ4lNqP7o
 go55p9K+Lh1eORfFh27ag+n+fK7nJuI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7BwvrBdT8Z+ksBuq8awLHeNtgLrgnQyxyFr
 Vy7ZM1HU=; b=Hy238cJmGaFeaxslbtDkoPg1hbcxu7Gn4gQ4gGoL463bQVDJovX
 GKnFwir2Kps/2u/u7iWyiTD2dOhZ0KkPc8/D7dprMRU0DsIJzFPPZAGkrq9gLl/0
 yjNeC4z40Zr1pkToAdX5IcenCxIq4h2caYL+LuiT6hDAEOgwXt8Odh9boi1m9YLL
 HifTCMZWbsa5VrXRX2KFzfUBJieS1hZqMfrEmTINP/cvMjzWOOTXuEcsiVHUtvM3
 DFn4lJjoDXWLWTqjviBEmZ5iAkgBSutXMndEL5epBcgLQAJMS4iAVOK/tCxSig3Y
 P9o0ps/iHWIFciPpbazLwq+2o+XuebrqfCQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266056; x=1785870856; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7BwvrBdT8Z+ksBuq8awLHeNtgLrgnQyxyFrVy7ZM1HU=;
 b=YcAVdOq3iBYanlJmguEgj95cJ3z/Y8FYXOW9NajcQ0/Dkw2ODmlh21Nmj8kqa6ZPlb
 LYhoTIKwrax6vqP451Jn/QObj5/qtSepQIYFxO9WTfa9izT9H7ov9TXwoXJx41FrljTx
 nTCjdcyokAT+NHejlPca3of+sG/7P/a7yBJlYkv+P6xOIGuBtrPFp4yYkUXJu0KcqPbs
 cqmDc898A2yemLkSXo/5aWKQ+TFCWTyIVDWT57X9uIU4G9ls4//NUNlRZC5AYAqlWuSv
 igfhPo8ARq9ns/IPCS0yV+dOLEr6ruq7IsKAaUie41avm+bxCdXsPlTWIJFL8kd0mipI
 PcjQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Hy238cJm; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YcAVdOq3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hy238cJm";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="YcAVdOq3"; 
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

This series adds dynamic device tree selection from FIT images for
Qualcomm Snapdragon platforms, enabling U-Boot to select the
appropriate DTB based on hardware parameters detected at boot.

Qualcomm FIT-based DTB format is documented in [1].

The FIT image contains only DTBs, while the kernel is provided
separately as part of a UKI image.

The implementation consists of:

1. Hardware detection infrastructure: Introduces the qcom,hwinfo
   driver and qcom_hwdetect helper to collect hardware identification
   data from SMEM, IMEM and TCSR into a single qcom_hw_params
   structure for consumers such as FIT multi-DTB selection.

2. FIT multi-DTB selection: Implements DTB selection based on the
   aggregated hardware information. The code parses metadata DTBs,
   matches FIT configurations against detected hardware attributes,
   applies overlays, and loads the selected DTB for EFI boot.

[1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/
    Documentation.md

---

Changes in v4:
1. Drop the SMEM cache infrastructure.

2. misc: qcom: add qcom,hwinfo driver to provide a common interface
   for reading IMEM boot cookie and TCSR SOC version information.

3. arm: snapdragon: add qcom_hwdetect helper to aggregate hardware
   information from SMEM, IMEM and TCSR into a single
   struct qcom_hw_params.

4. Refactor FIT multi-DTB selection to consume qcom_hw_params instead
   of accessing SMEM, IMEM and TCSR data directly.

5. Separate hardware discovery from FIT parsing and DTB matching
   logic, reducing complexity and improving code organization.

6. Load FIT images directly from a raw GPT partition and remove the
   FAT filesystem image based loading approach.

7. Drop IH_TYPE_FATFS, mkimage FAT image generation support and
   related documentation updates.

8. arm: dts: enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
   qcs6490-rb3gen2 by adding the required qcom,hwinfo DT nodes and
   board-specific offsets.

Link to v3:
https://lore.kernel.org/u-boot/20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com/

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

5. image: add IH_TYPE_FATFS image type: Added new fatfs image type to represent a raw FAT
   filesystem partition image, registered in the image type lookup table.

6. mkimage: add fatfs image type for FAT partition images: Added fatimage.c handler that
   uses mkfs.vfat and mcopy to create FAT images from a directory.
   New --fat-extra-space, --fat-type, --fat-volume-id, --fat-mkfs-opts long options added
   to mkimage.

7. doc: document mkimage fatfs type and Qualcomm multi-DTB: Updated 'doc/mkimage.1' for the new
   fatfs type and options. Added 'doc/board/qualcomm/multi_dtb.rst' covering FIT ITS configuration,
   QCOM metadata format, socver/boardrev guidelines, and image creation steps.

Link to v2:
https://lore.kernel.org/u-boot/20260129184817.224101-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
1. In v1, a combined DTB format was used for multi-DTB support. Based on
   feedback, v2 implements FIT-based DTB selection instead.
Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/


Aswin Murugan (5):
  misc: qcom: Add HW-Info aggregator driver
  arm: snapdragon: Add hardware detection helper
  arm: snapdragon: Add FIT multi-DTB selection support
  configs: qcom_defconfig: Enable QCOM_FIT_MULTIDTB
  arm: dts: Enable qcom,hwinfo on qcs9100-ride-r3, qcs615-ride and
    qcs6490-rb3gen2

 arch/arm/dts/qcs615-ride-u-boot.dtsi         |   10 +
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi     |   10 +
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi     |   10 +
 arch/arm/mach-snapdragon/Kconfig             |   17 +
 arch/arm/mach-snapdragon/Makefile            |    2 +
 arch/arm/mach-snapdragon/board.c             |    7 +
 arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1033 ++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_fit_multidtb.h |   61 ++
 arch/arm/mach-snapdragon/qcom_hwdetect.c     |  167 +++
 arch/arm/mach-snapdragon/qcom_hwdetect.h     |   52 +
 configs/qcom_defconfig                       |    2 +
 drivers/misc/Kconfig                         |    9 +
 drivers/misc/Makefile                        |    1 +
 drivers/misc/qcom_hwinfo.c                   |  160 +++
 include/qcom_hwinfo.h                        |  109 ++
 15 files changed, 1650 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.h
 create mode 100644 drivers/misc/qcom_hwinfo.c
 create mode 100644 include/qcom_hwinfo.h

-- 
2.34.1

