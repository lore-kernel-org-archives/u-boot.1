Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED1BC5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C83D04071F;
	Tue, 11 Aug 2026 05:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L3d63H8PfplK; Tue, 11 Aug 2026 05:19:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCA2940714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425552;
	bh=z3i+08OZHbvU+2FiqRlwGjE6dFsl7NfhpqCkr6lFmIo=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=aYXlbFgldsGmBQlkZ9TQp0OpJkrG9n8FKZcxTrPO0eUkKFuV4QPpkcnobYVt4Vxr9
	 qoFyEiv8pFYljK+zAEDWLUtUmS0QLnonOqcb/4HNZzskAWfCXoHuuyBH2M7Lb96ye1
	 gj8gNuLZukT+ltoVK5EAbXqeF4ECn+GigRa3zOSygpPkz/rSyHWHALQ7Lj3Axb4RLL
	 CylM4UkIWTSqXfEzh/mUW0oOi2a03WEVSGpdL/tq/oGyBzOwfcR4eibvHn3k8LriK0
	 Kfnl/st4MJFreHqiqb6idwgV/utSADbjqkANrwBcQ6VdiOhsYBN7B0kvFab8GRcweR
	 /vtUMsjzgAi3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA2940714;
	Tue, 11 Aug 2026 05:19:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 562F9259
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CDDD60634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4ZNyRlQj8UI for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 39FEB60629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39FEB60629
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39FEB60629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqWF82997309
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:08 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf2cdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso76521785ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425548; x=1787030348;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z3i+08OZHbvU+2FiqRlwGjE6dFsl7NfhpqCkr6lFmIo=;
 b=jgvBAut7qgVVxwi7rIa9rvbhnmMfs5SOLsBYJeo2lZHcXqaw29PvZ0NyZSf1/b1YnT
 E6AGeva6Ovtm2msxAKRpWVvp+ja/elrwodwrG0oiWf30+YUTajPzVZmrK8saMrq1bEjm
 IyipT2oADtMA142v5/0WpC3BWt+/FL4NPWcaHiuAm8u9llATjsaPg6omCdRKYYIoLmiP
 SBiHafGL4HmHPg9jzNgubIe6lS9rIGoZec95ICXM7oPwGl5+j6J9XwIx59y1Leeytv7Z
 Izx8IQdJxbBaba2IJoZ8ko9+kKxJ2vRTUiAv8NEYk6jr80vCwec7G2gSSoBpIShx+7oD
 ovbQ==
X-Gm-Message-State: AOJu0Yy09TMqDhhPZ1We+7VNNed0YkGYbqzsIeCCt99DmIOl/m7SoGjS
 6wyEvemgdjoNzMbMVvEFAIxiHFaY6T4zKkO0o6qZH05TPitobvffjh+lwQ1IbliVpjoWpYoHFuy
 TnzYqS5a2SIKxUf+1KNqnRS8A5GwRaZR/TTtY5D2pdwomXjoYdJ5+vXV3o/th48CTCTALFH0=
X-Gm-Gg: AR+sD13mRZ5ApAgRiicY8jUTUrMf2nN3pWlTMn320xE2qCMJcvvwzmkjhmrQW95vGJq
 MY2wajXMd+JRwEQhWSoqENT/mJnOiB8JrTdvSdomMTdgw7C2PcY/osw43xgZYsXGhxULye4gsLf
 WPJEWbv7nI6Vy5LI0cXjl/W1VJKgVEOrsua36BmJZUjIG2lOJ5VOZwG25d3Uy9CvgvLaO34504A
 xxm8R3D9R8I4rGInbEa1b959P1FCI+jTijcuOj6Q0eTgLFWRpChpvSjUDNfCxS6oaFhri6I8+G2
 fhoAJrRXDJXvc5oiW83mMhpqs8X0mpjPZfS/urpe8hAi8HS26dq8etMyZpoNGTU7Af8req5gYBW
 sgvBh588GuvXOIibWG+HIN2WQUUgr3bww6JT1I3u1nm6Y+MK8RZgenL1CPrjzElCtVd+T7DX0dR
 E5ObNCu5Rc/gab7W//ri9nVKx7Breh
X-Received: by 2002:a17:903:468e:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2d317904fb8mr11086385ad.16.1786425547662; 
 Mon, 10 Aug 2026 22:19:07 -0700 (PDT)
X-Received: by 2002:a17:903:468e:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2d317904fb8mr11085745ad.16.1786425547204; 
 Mon, 10 Aug 2026 22:19:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:06 -0700 (PDT)
Subject: [PATCH 0/8] reset: dispatch DT-declared reset modes via the
 reboot-mode framework
Date: Tue, 11 Aug 2026 10:48:35 +0530
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuwemoC/x2MOwqAMBAFryJbuxA/qHgVscjnqQtqJBERxLsb7
 GaKmYcigiBSnz0UcEkUvycp8ozsovcZLC45lapsVFcoNjUHRJwMtyYy3p+bd+DKtFYrW9WT0ZT
 qI2CS+z8P4/t+Q7cICmkAAAA=
X-Change-ID: 20260810-b4-reset-edl-rebootmode-3b7ca0c34fba
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=3931;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7an8ITXzDdegARTeokpmVxZvjhHK/rLkg9KT9myZ1DY=;
 b=dTlrscNxXqZRlok2/bh/W+QTHx3TYTmfmcNGDvEDLHseHxOMBFPW2tobgPlk0avViPnS7C41+
 KQOc/8XwVk8CIYk47HELJoBPBwOGPqBKK6QroSSn6p6MbjLLXNrTHKa
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 6pKw2_Hr21ClpVJl0bll-pORfzW_znEP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX6HizPltS9DNA
 yuyZ6DuaSX47Ma9ZshFfsB4GTBV4nfIDUdrU851MxbW6zIPGfpMFrsS5O2BE2CIECVrcH3e6EAn
 e8b84RfKFUx0umcu7gw7Nj/7zPCeHwg=
X-Proofpoint-GUID: 6pKw2_Hr21ClpVJl0bll-pORfzW_znEP
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7ab0cc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pUax2vqHjk9CiN5rtFkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXyRlHeRc3DvaB
 Mi4vdW4cvhA/0DQJ3uVDSDXMJNOY6N3X2u9X3s6Jyc38CJVlMGN9BHkul7McB5DlFWDP2oVDjEx
 bpyIPLAKsufqMQV4G1tT2KlkNfAf80RSMNzf2TOHBxdmSrXUUd4eZHO7NCyzDObI5PM1ojRVXFy
 faR+R2IfAdOSXAD6Yv4AAm1+7U/gZ1ZtNV79/69zSgsd5OzkhhNMKK+GROY1hM3cSqDSC48cnJd
 bkpbrW/OzswVd13jI8M8eYBhyt63odgulUed06sSy2KYuWSVak/ffP9T6h2ThW2qY/RgoN//tj+
 UmfOmUW+agDTEGbl4PUXeiXsB3oAMLG6iVWgaAcmo+twJnjLZYDxycXjl9ei31EccAk1ChuYgHe
 yya1IAGtgpkTAdB5HjSstzQMSsBOmTL6OVQIHDD3/6dOB/28Q02ArEdtETY4SDA3yfUcntFLSUe
 6f7eHbJ7+6G/s4RhEhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=z3i+08OZHbvU+2FiqRlwGj
 E6dFsl7NfhpqCkr6lFmIo=; b=jzvCP/eq2KnsnkvdzS9PN4i+Ipcx3DUGjHs8An
 naC5fLCtFTBK0xoTmoClaaZChSSfcyPUjR+73Z65n+sythbLlwi3FpUg3DFssRlG
 /MSuJlaFJDIGBEHhIe4dj0+XQ5t5U1KEvZ41jYe3bpA/W9Oqr0WAPxDilggVMLt0
 09h5xEKoNUpd80hzgoz/ZbyEeWP/wrgeiikvcSUC17d4f4bGGomYlY6RY1RWrVnM
 9YxCu2LDlTNWgFXX93L8gc2S8wC3HJKxTA57GHlbyh1Xve8fthwGcea/rq7BBCJk
 diyf1Yrt61O1hmT4/wXHAEU5jiR54W/W3USd5bdfwuZUa3Mg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425548; x=1787030348;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z3i+08OZHbvU+2FiqRlwGjE6dFsl7NfhpqCkr6lFmIo=;
 b=PaBk1EwsRBqs1nROOWeD1OWJVNArecJV5NLGbQ8xnwumilP1LDbtRknBmnElCIp+Z0
 a7oiUQUajndD2Nqi4zzt3mQKrTqR03sJeKCGgaemcQotjUbDyLACBgsOXLMKqgcmsHPI
 wcXn342UbcimGk0IVjdMmpOmUth+HG6Y26/SHmpDj4/jVcgXQ/BEOQWhwjvGN/Df3oK+
 3MpssoGGhKs9dmjYER35RUrGxCN8HiF/DG2sPfmh56g/tgf7mNOO1ySO4n9KOn6tPw8x
 az+nGVUI4hgRfJYCTJZ7bQl1QFsF3erPL+hHQx+nMWuCxFfmu5fXXK5kSbBibl16jZYJ
 Anxg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jzvCP/eq; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PaBk1Ews
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

This series adds a way to trigger named resets (for example Qualcomm
EDL/download mode with "reset -edl") without hardcoding any magic values
in a driver or parsing argv inside one. 

The design mirrors the Linux "PSCI reboot mode driver" work, which places
the reset descriptions in a "reboot-mode" subnode of the psci DT node. It
tracks the v24 revision of that series:

  https://lore.kernel.org/linux-pm/20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com/

The magic layout here (up to three cells, <reset_type[, cookie_hi[,
cookie_lo]]>) follows that revision. The bindings are not yet applied
upstream, so the reboot-mode subnodes live in U-Boot-private *-u-boot.dtsi
overlays for now and can be adjusted if the binding shifts before it lands.

The path a request takes: "reset -edl" strips the leading '-' and calls
reboot_mode_request("edl"). The reboot-mode uclass matches that name
against the modes declared in the device tree and calls the backing
driver's new "trigger" op with the parsed magic cells. The PSCI driver
folds those cells into a SYSTEM_RESET2 vendor reset and the board enters
EDL. "reset -l" walks the same registered modes and lists them.

The pieces behind that: the reboot-mode uclass learns to parse up to three
magic cells per mode and gains the trigger op alongside the existing
get/set, so a backend can act on a mode rather than only read one on boot.
A thin PSCI driver, bound to the psci "reboot-mode" subnode, does the
SYSTEM_RESET2 call with no argv parsing and no hardcoded values. mode-edl
is declared on the qcs6490-rb3gen2 and lemans-evk boards, with the
framework enabled in qcom_defconfig.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
It follows the direction Casey
suggested when the earlier sysreset "-edl" approach was reverted in
c480bbd92b32 ("drivers: sysreset: revert support for args in request"):
  - argument parsing does not belong in reset drivers;
  - the reboot-mode framework already exists for exactly this purpose, so
    the mechanism should not be qcom specific and should not hardcode the
    reset magic values in the driver;
  - the "reset" command should be able to enumerate the modes registered
    with the framework.

---
Balaji Selvanathan (8):
      reboot-mode: parse up to 3 magic cells per mode
      reboot-mode: add trigger op and request/list helpers
      reboot-mode: add PSCI reboot-mode driver
      cmd: reset: dispatch named reset modes via the reboot-mode framework
      arm64: dts: qcom: add psci reboot-mode edl node for lemans/qcs6490-rb3gen2
      configs: qcom: enable PSCI reboot-mode framework
      test: dm: reboot-mode: test trigger dispatch and mode enumeration
      doc: usage: reset: document device-tree-driven reset modes

 arch/arm/dts/lemans-evk-u-boot.dtsi      |  7 +++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi |  7 +++
 arch/sandbox/dts/test.dts                |  6 +++
 cmd/boot.c                               |  6 ++-
 configs/qcom_defconfig                   |  2 +
 doc/usage/cmd/reset.rst                  | 42 +++++++++++++++
 drivers/firmware/psci.c                  | 16 ++++++
 drivers/reboot-mode/Kconfig              | 11 ++++
 drivers/reboot-mode/Makefile             |  1 +
 drivers/reboot-mode/reboot-mode-psci.c   | 58 +++++++++++++++++++++
 drivers/reboot-mode/reboot-mode-uclass.c | 76 +++++++++++++++++++++++++---
 drivers/sysreset/sysreset-uclass.c       | 27 +++++++++-
 include/reboot-mode/reboot-mode.h        | 48 +++++++++++++++++-
 test/dm/reboot-mode.c                    | 87 ++++++++++++++++++++++++++++++++
 14 files changed, 385 insertions(+), 9 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260810-b4-reset-edl-rebootmode-3b7ca0c34fba

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

