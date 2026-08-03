Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9676C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C58A605E1;
	Mon,  3 Aug 2026 15:59:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bOmgCzUO0Pvl; Mon,  3 Aug 2026 15:59:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8347960619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772741;
	bh=y2MVJ0CiAhA7JSVj1nB3eZGW6v6raypro9I5/Hvh9j4=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=d6/GK2a1e4E6TW+hK490RylwmD8BUVfcSpQ1gqrjzyo4GP7mEisOTqLSUIzL/VCxG
	 lvLZ7yIq9euIm81B9HjQiuvEQ3bSjAmFKdVpa8rnXgNawu9V+uDf2GVQxW9aji7VOe
	 ZUuXF/TYdGN73Cy/hj7z57+kWrypn3wmuPERjy0tkCqSLZ4AGMH4858Bjzr2P1bwwv
	 iwI6nQ+qr3s27mp35vfVzfbnMsR1ZPak23Bef8f2uyXzHRH3QvC6UZiY222TRWcccF
	 aFWQfLP0PsaCc1KzrwhBAMk9Px4Ecx6EoUJWSwHlFRkS1Jf3zbdEnzrM9d09SWe8DR
	 xI8y1NHfg7SeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8347960619;
	Mon,  3 Aug 2026 15:59:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 078A73A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 051A080B1C
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJNL6kf-uN7j for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:58:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EC1F080B34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC1F080B34
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC1F080B34
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:58:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673FJbO02172760
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:58:58 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdr5b9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:58:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so2373917a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772738; x=1786377538;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y2MVJ0CiAhA7JSVj1nB3eZGW6v6raypro9I5/Hvh9j4=;
 b=SzYi8fKKy5W1lb/pIagQ0KdnYywYXnOANnGzHC8tczga1oikfE2aHJGB3pnaMiEVvr
 T7+lHy57JTJPEC+UfwQvpIJuh1sROYV2AGypXCVd4+E023mpeJJz1zvTlB9jQardfmEe
 2A1jaHVD1tbmVoamc060BL2UqZrGnpwv7h3Cj38+wpD+riUdSl6DAkjLwP0JZdN+wp2D
 HFGJMbl+4o+9TFgfXHFgQzlZ1v1ShhWYZO8mncxMeielfhZlcNwW54YFoGRMUm0egxNk
 V26bcwFtsfp7O4NrZXfdPfjrfwxuwBff/asC00j4jVn/Si/V/ZXQk4/lT9cbh+ZKh10R
 JMBw==
X-Gm-Message-State: AOJu0YwowcEJuMzQg1F7WtYoVkjNoj6yeN/MGwUIeNLsdD4oyBZ0jorz
 FaXvT1bOHTr/rJUEa2jumOIwLedar0rOERZBh3TbQzDYe09HbjnEvMqHt25H+woiI5DEFsVj2at
 VoMTmYLsotVPJVXdyYm6jyeaJ1aPvY9LEIekDWC+iKJmFagP0QcZA3NW0fVAquZSFk0ne8qRYrE
 rcmT8=
X-Gm-Gg: AR+sD13FLBOXSQRi4gwnYKvo5XQYFpdUlBdqXgkxF4q3jpKKRgLgzUyvnwdkvl3AE1w
 gsmOcD48FBk79wBl56YRn18of0cZp3ENJEsQob3p4lnCLYojOIcpdFeAtnuhN1lg2EfKxeWoloi
 etAi/JBcnMsWsWGx8HRv/UFFOM5+8/r4XSG8QD7tWG7peQ4TwgDykil2eNDl5OLusjNzth91X8T
 bWtvehbI8pBzC6YuZnV28slPjjEWrKE6X7/mHaNnXRcJp4VJizL1+EpmH03MHD3kO06kmjA9LI/
 OB9vbPCNAaL/eK5oW2BV/tKs9ltIZL6K48JZ3LrLkP8pMBbr1mMmsoj4BM7z66SYOcrygLuAMzz
 U+gufLQYR3opZFOkVaO6kzpCRXHDFxSiiaOORwi9Ijk+GYjaUSIYjJA7crnZZjQtmiizxZU6xjK
 fuU2XEVLXG447DRewbHKgoo2Lfhle6
X-Received: by 2002:a05:6a21:3a87:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c92a750fa2mr10793293637.25.1785772737573; 
 Mon, 03 Aug 2026 08:58:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a87:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c92a750fa2mr10793248637.25.1785772736973; 
 Mon, 03 Aug 2026 08:58:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:58:56 -0700 (PDT)
Subject: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Date: Mon, 03 Aug 2026 21:28:45 +0530
Message-Id: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALW6cGoC/0XMTQ6CMBCG4auQWVsy9k9x5T0MC4QpNBGqHWw0h
 LtbceFmknfy5VmAKXpiOBULREqefZhy2F0B7dBMPQnf5QaJ0uJB7QVPTX8NYRaaKmetQ2lkB3l
 +j+T8a6Mude7B8xzie5OT+X5/yBHVH0lGoEAkp42WldJ0Dszl49nc2jCOZT5Qr+v6AWfsV0anA
 AAA
X-Change-ID: 20260731-snagboot-4e9f66f0252d
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=5729;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=uCvFr1Fccs14ypimBCHVnZ9VCokei2kzjmMcTu1pRec=;
 b=juniXc2gOjdLMncv647RZn1mkbEO/7k7ZWiGBDfVjS9DpoTj5DGoRa0i0HhKy+7NH5ybsbZuC
 KOUgS9uOSbUDKH+zwx9t6OVpaiQ7LTF2ZzkcAZkc2xpvOpVpKTUsKua
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a70bac2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gu6fZOg2AAAA:8
 a=EUspDBNiAAAA:8 a=4GZlKNTyZuL0fuDD4_0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: 2XqV9Q1GJKMzr0oWL-edFqnnL4cRUNUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfXzzqVbhTGh5Di
 t3IIhu+DGDRQVdVfblTewnay9wnIjPrhH0tzsYgGZLytQ+1GUl2CKLfyuuKyneF13vaWGpb+M2X
 w3RMNx/pjWdL/hEctnOy9l99rs759ilUxTrSz558Zff3j6WAViEu6p9RK/ktfUc/jU8AFcJBY9y
 4slF+gXAayrdOFxgQJczDcBSx6Ng/KQBm/NHpDFDDbC9KhJM+/WctedEQUcWV57j7UaD6AAoRsc
 ElB/rYOOReq/rakd09WJHUz3gtYu1ZFw9RM9xYz0P7Jzq96iLv01LVXUkEM1sDT2ImOzgex+LBC
 MLTKBa9xMFisLeWP0PZPUfJ9NJlIrjanYxO4uO9h+pBPFkehBa+NStn/pW+zOi0JMJPEFn4mTZD
 XiW1WXgIMV70vmKkIf5ugElW/t3dIs0PHGa4Wd1tOjC62SdsuC1DUAfs7+K9cl8RZepzwuEIUI3
 jKaS9LoqvE754bioJBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX3BD1jD1zqz9i
 NEGJ8f5kTws1v8Vk58SUdsW+2fFMyeeSPnUsxzupUwZq1qYFJbjyeqUsCm9uz6R/dFgebE6VSKo
 /xdyFAoj5XNW6w0NMMa/Y86Gc+6rVnI=
X-Proofpoint-GUID: 2XqV9Q1GJKMzr0oWL-edFqnnL4cRUNUT
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
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y2MVJ0CiAhA7JSVj1nB3eZ
 GW6v6raypro9I5/Hvh9j4=; b=PSsB9n81POPwvsBlZ2KXoUxJcv37zJ/gFexfpH
 0a3rSMDAIk/mDQayLv1XhVv4Rt8EQ9uDjp6OiP0fqBlwcGa+DngjEWCOBeyV0l9+
 +iFiXNKEpv0giAs8W1ZpbABu/Gm0ZZvWi0jz+vwsLiKZZJdYaG82Lz3tXEUAfQIz
 PBzURdWkKvBWdJwT7cbCNwkRrzpLdXNd2ioov191rZb/l69Oq4XYpo1qTEfhB58j
 GCbOaPhVICfKggmcW1TmQ/pMeME9ErhvzY3FKvnrtyNLAb7UxhjAvJH/gV2tdpBs
 SEE39TiczWWnaGsasSuNM+9B/U17TikWkzb8FEfomV9Qk3gA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772738; x=1786377538;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y2MVJ0CiAhA7JSVj1nB3eZGW6v6raypro9I5/Hvh9j4=;
 b=jydJksvTSaeaGFrUaTNuvOMJ0ZNfJ16pTbRmXq44TAlh5fhrHAPfjszzIdLRWgFV5j
 Bs6GFQCdik0d3yEAYaDc7lydqfv4tEOnqBK6U4QJIHqWMuI4OkRK0nDijdsuZwVDjQwo
 jxsq6ZxH9+RbA03UBp78m8sj8dzGKLfLLZ/BW3cMlWjB+n5TTfwui+r4WROnTXzVkEHM
 aZaPV4cXbMYvdGQaEFDf7oxL4t/vTC+FwDZx7aOXwRvnK/MVYC9rPbDdmbkKg5jM+NeO
 yGBVHPGlUpHrRR1GIeebseIV+Ra3+NMehmsnJlDfrdDcAUhTw33GLdpmsbj54UJO/06P
 XUuQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PSsB9n81; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jydJksvT
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

This series adds support for running U-Boot in snagboot mode on
Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.

Snagboot is an open-source, scriptable flashing framework that provides
an alternative to the proprietary Firehose protocol for device
provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
Qualcomm boot ROM EDL mode and Sahara protocol to download
and execute bootloaders. However, instead of using the proprietary
Firehose programmer, Snagboot loads U-Boot into DDR and uses the
standard fastboot protocol for device flashing.

The framework consists of three modular components: snagrecover
(downloads XBL/QCLib to initialize DDR and load U-Boot into RAM),
snagflash (communicates with U-Boot over USB using fastboot to flash
system images), and snagfactory (orchestrates parallel factory
flashing tasks).

In the snagboot execution flow, ROM code in EDL mode loads
snagrecover, which downloads XBL to internal memory. XBL executes
and initializes DDR, then snagrecover downloads U-Boot into DDR and
transfers control to it. At this point, XBL has left the MMU enabled
with its own page tables and has not initialized PSCI firmware or
populated the Command DB. U-Boot must handle this non-standard boot
environment to enter fastboot mode for device flashing.

Support for Qualcomm Lemans-EVK SOC in Snagboot is now available in
https://github.com/qualcomm-linux/snagboot/tree/qcom-next
Soon these Snagboot changes will be upstreamed to https://github.com/bootlin/snagboot

When U-Boot executes in Snagboot flow, it has to deal with missing
platform services such as TrustZone (TZ), Hypervisor and AOP (which 
populates CMD DB data).

This series depends on the following patch/series, which are already
picked up in qcom-next
https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v6:
- Forget to send summary in v5 cover letter, no other changes
  in v6
- Link to v5: https://marc.info/?l=u-boot&m=178577208345353&w=2

Changes in v5:
- Make QCOM_BOOT0_SNAGBOOT_MODE as hidden config dependent on 
  QCOM_SNAGBOOT_MODE
- Disable C (Dcache) bit of SCTLR_EL3 register during MMU disable
- Remove now unused QCOM_COMMAND_DB_OPTIONAL Kconfig definition
- Disable unnecessar I2C configs (for Snagboot) in Qcom Snagboot
  config fragment
- Add build steps for compiling U-Boot for Snagboot mode in
  Qcom Snagboot doc
- Link to v4: https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig
- Removed Lemans EVK override dtsi: arch/arm/dts/lemans-evk-u-boot.dtsi
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Added documentation on U-Boot for Snagboot 
- Link to v3: https://lore.kernel.org/u-boot/20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com/

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection 
- Removed updating MAINTAINERS as the defconfig file is picked up by
  the "N: qcom" line
- Link to v2: https://lore.kernel.org/u-boot/20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com/

Changes in v2:
- Changed SYSRESET_PSCI from 'select' to 'imply'
- Guard show_psci_version() and qcom_psci_fixup() with CONFIG_ARM_SMCCC
- Disables the MMU and invalidates TLBs at the earliest entry point
- Add qcom_lemans_snagboot_defconfig for Lemans-EVK
- Link to v1: https://lore.kernel.org/u-boot/20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com/

---
Balaji Selvanathan (8):
      arm: snapdragon: Make SYSRESET_PSCI optional
      arm: snapdragon: Guard PSCI functions with CONFIG_ARM_SMCCC
      arm: snapdragon: Disable MMU early before U-Boot reset vector
      arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
      soc: qcom: cmd-db: Allow boot without CMD DB data
      arch: arm: dts: remove Lemans EVK override DTS
      configs: add qcom_lemans_snagboot_defconfig for Lemans-EVK
      doc: qualcomm: Add snagboot mode documentation

 arch/arm/Kconfig                                   |   2 +-
 arch/arm/dts/lemans-evk-u-boot.dtsi                |  19 --
 arch/arm/mach-snapdragon/Kconfig                   |  20 ++
 arch/arm/mach-snapdragon/board.c                   |   6 +
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../mach-snapdragon/include/mach/snagboot_boot0.h  |  27 +++
 configs/qcom-snagboot.config                       |  46 +++++
 configs/qcom_lemans_snagboot_defconfig             |  18 ++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/snagboot.rst                    | 224 +++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                          |  15 +-
 11 files changed, 358 insertions(+), 22 deletions(-)
---
base-commit: f79edc9ad08ec0c3e40323ff17cc7166ad2b9e71
change-id: 20260731-snagboot-4e9f66f0252d

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

