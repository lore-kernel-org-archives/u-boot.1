Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED412C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A37660DE1;
	Fri, 25 Sep 2026 14:27:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0lVDL9IgU5k; Fri, 25 Sep 2026 14:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E833E60E15
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346436;
	b=j25bFzehnJdBw08UQuENiENGioyXZnQCs3YLMgyiUyJjFTwgYW99dUfONQlushMCoKDz
	 oydZdaQGY9gFiZMUB7o6WLnje5veiElx/awEOFsIpWD9bZYXe7ihDzvOXtSFb2X+H5qJO
	 yXNxn/RbRi41I5gwKfGjmfJReKbr5uLwR692CmlB0Vl0eUL3e5bNFaOC5H8Im9EgsS1K8
	 4CbK8+CxGjEJad0Guugjxlml+6mD4kai4TquUg0SoeUUOSucjtB1FWCjc27dfXwiHRNxU
	 Twtx4GSAK5OhowtTsHZ+ijNuY0zl5ik+DN1lERuON+hhwvIQbPWaaMMzBIQHayaDlVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7kF7NYTBzORd6Hpdea1qGjel+05lpOBDJtnxZUFig3Q=;
	b=fHGhIDHI5/fkKB0pycKLwB6bwKqKYYKMfhKNMew1HK5xQcmyFbRa1Mv3aQIefq7UCCa+
	 VYlRLhqRzXaZHHn9QGD9wLylr1SH0f9do+1jWjR17XeupAQFs9j4QKpMq+RhI3mo+HLcL
	 W99krExqUR6lfEDNf+1V2C75jpcghutHqIw6b2FbtOWKk2m0kkYZ5YNZDdn7P/yhyJttL
	 JQCC6YgkasKu4kqSRWwlgJRJ01wOl65ClruGUR9h2/p0WAixukfIc/Qbxh23eSLr+Kj0g
	 ntbjdGkssMbLX2/YHg4CflfKq1ahaEE0cw4bOoZs+T8xMvpa1dBguJOj2LmF2f3bEzg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346436;
	bh=7kF7NYTBzORd6Hpdea1qGjel+05lpOBDJtnxZUFig3Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FtL3YryNFumw/9oq/oLDP220jJs3EmRXXXVLq3Egzxp10n2s5FjVyuiz3O8F7ZezD
	 eWwX4F+st4m/0i8OSWQkEFNWb/HR8+jIe6ODpLw0oOgjUQXHQkgrBJg0QwTHkWeHr1
	 2fucUbTgQnNmaqiXzTiktr5GSHbwlDc63bwAUrWlxUBxCefVabyrqR0SffhMEF6P7F
	 hQjQghL+oFwYhWM2KaWuPBqX1FPjqpBYOrviodZPU3AI+Lk3kyf4EZw6p92+fmDICd
	 j+aKXplck9tAiv3iO/pzp0PWpZEmidMLD9i8ffQ/k6dAgDhYbeRPZ0DsyJ2Lre/KKJ
	 sQSNtCZIOvuDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E833E60E15;
	Fri, 25 Sep 2026 14:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE830E13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D054C811AE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBoks7W0Iqby for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F85A81208
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341108;
 b=SwKtdKbL6MhWXGA0NBY0MqlkiMQhbVJ9MY5uTUu7FXDDuKgLEmwyrbucLEhVPrgwuyks
 u9r9BO+IGhoj2XKTUq/z0iDHZMaG35TKci7L9AyqZcE2utNW0QGMU9iD2oyQAtnERv0jK
 h2bSJ3au6OLoxDU9ZJyCMnv8z/Ay4nHUGXiWiYGsBrkgaNu0y/R6gSmYYIWnJDWoMs5vt
 pReShHN9fq9YN+ba338nOAl4tuxGrsb0N04wz9FsmJtr9kNUMHbWXaM6v8i0c17U6tObI
 N4fG/dYaj9SIjs/TOQXsIE9zYedR8LInoRQ2nXBpIHbj0bDuFwJSBK6pcI4L7oSd4FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341108;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=7kF7NYTBzORd6Hpdea1qGjel+05lpOBDJtnxZUFig3Q=;
 b=anA1ZEg3rYZpxhMwEdBrkQxARmKRSD51cQT0BRHXueRJDq7RGtikq/A3jRFmMPbu3qSV
 AFeN1jtdrqIA/q+iuwNCUQhd+jMsg7vf70EZhz3nVDhJh8tZdKv/NPt0usE0n6yEs4igj
 1mzhHyvFAmV6sOtiTYFb8HZQxyOWnlC2vDpW6T799XbEBFtLL3AmpeXjAA04cPcfEwMid
 k8DzkylXr8qoUmdxiCrFtUXQDacZuEAW9C5rLNGSDehRULIPlccZbo+I+h4Hs2pmdXgwK
 hlMccujtHlRHuJV8elRvQC+kUhF7f0yd7LZTTI1p7hmeFIdhwk6hBYIoWqeiLPSf6fQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EPVLPDdo; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EPVLPDdo
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F85A81208
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PBLhBH900428; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7kF7NYTBzORd6Hpdea1qGjel+05lpOBDJtn
 xZUFig3Q=; b=EPVLPDdo2UHrkm+S3+5yA6coJThLQwmQN6tEUf/6v5bvfDxwVkm
 5k4SCXvfCN//Uqhl+67vSVXjcUI7mfpTG/muuLRziALq4EFfn+xISYvnnw7ehd8P
 l2ieBIaB8RB1IVni4RiBjEx9TFhHayl5BSW3LfbquO+sRr/4Z7L7xrswLX3DBT+L
 Ryzxfx3tsRm54tiWNRsE8xR5oZzaOhFrFFYOh+96fYQlcy9bB/xKvOnRc9VnPgxy
 F12aAVMwmFm9jH7L4//IP9GRNOmeMnIIP9/+7rXKHu2cM/K+YFPpLtiZNMfqIg1o
 N82xWClCiROz/Mz/mNjq1gmkQ6lnkNzSPsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr1008d8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwDaN518185; Fri, 25 Sep 2026 12:58:13 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 68PCwDMI518169
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id 86935605; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: abhiv <abhiv@qti.qualcomm.com>
Subject: [PATCH v1 00/12] qcom: shikra: add eMMC SPL boot support
Date: Fri, 25 Sep 2026 05:57:57 -0700
Message-Id: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX7sFcA7A3ZRlS
 Y8KO4kX3Jyt9Cd8XoZI7Iggjl4+s410wF+y0OZV9OODkQv0SwlAJxerTbteCr2EGpCHeK0w+xVF
 NzpR4k1HN3Ca0V9OVRaQH9B9oZwHweEc1gpFzcf4cKiu3Lrjk70UttLnQGTuD3XElyazq88WLA9
 7lrpoYmKSxjQHnyZ4BTHB5pTW409HjkTmegRbRRm2QEn3PLDR4n/8Q/Ydj2W1BT08agRJ4deHQT
 1Cr3shW2g9qzYsTs6adW5sghFjf6dTxPpy57kriwFcZIgMd79Pf7Vp+iKsdmURiHpk7pr9i4VP2
 wfkps0wTnqGr+UsFZpGA3IkEuoBCyWKyxSHewvzAH5yW+/FthoEhO+U7my5FMa7KD6Z6GPZBC93
 JUKlkZG5Ks58rkM7MCQw6IY0J0KtXVyDHMmGYTMMbI65qF0vHxjwg3ap0jGjlMX1G04xwrTOQi1
 +qquWIiU9ez6leZlIQg==
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=8ghmld7vRPOvBHcmCosA:9
X-Proofpoint-ORIG-GUID: qyF2ijpUlb2VgmmbIp6xDUdV7uB1KsGM
X-Proofpoint-GUID: qyF2ijpUlb2VgmmbIp6xDUdV7uB1KsGM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXxrbt3T0rsH+F
 MqNepWNf3N8gCKPdBIFDSrboCCxL2GrANGxmdlmEkLKjwGs0CdZYC1L70aUuFZntfPaoVbj8zSg
 ZNVK7kfxw0SR0mEyvTDZJofsbtZrGkk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

Abhilash V (12):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP firmware dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  misc: qcom_geni: load firmware from declared storage
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  configs: qcom: add Shikra SPL defconfig
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  43 +++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |   8 +
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/mem_map.c            |  24 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 +++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 ++
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 342 ++++++++++++++++++
 configs/qcom_shikra_spl_defconfig             | 110 ++++++
 drivers/clk/qcom/clock-qcom.c                 |  48 +++
 drivers/clk/qcom/clock-qcom.h                 |  24 ++
 drivers/clk/qcom/clock-shikra.c               |  73 +++-
 drivers/misc/qcom_geni.c                      |  98 ++++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   9 +-
 include/configs/shikra.h                      |  11 +
 19 files changed, 922 insertions(+), 46 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 configs/qcom_shikra_spl_defconfig
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

