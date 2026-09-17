Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D204C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D8CF80EFA;
	Thu, 17 Sep 2026 07:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEQ_S2SVANI9; Thu, 17 Sep 2026 07:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E143580E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631299;
	b=JWITKu6nFZM9JbdmZQduS3hqef1RZSnqQ4kEtzGkz+1PvEuksTtWay1WQZAwxh2B9Ngh
	 8i/R8fu68n7dJQOGCRsO3Xfi47ugqe9iQX21VX/Fy1n6XB+AMByHMkFSWqX1hqWbmZJ7W
	 yUmhiYBKJ3MhPNHpCsQBAZ6sjsJdjz6wub2lcM6qL/WMqMnGW8SF9LT5X79MMkbCkeaO4
	 c1fJoEUxCFPkwVuMceEgW5oIIqrIuqg8jCG8sBPEEM4Ohu09OpJNBXGzz2Pt1nICJXwzx
	 RWiErQLbfJ00ArSkn/YTglb8BG724GzLMPnaXIWMFsEKwFQ8wiZ4w17nBsEuc/O8fbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	b=JmpsLz7HBmg85Jp4MVxoeXyg3L7xOMOQyaYtrvNGswEoVfAEOiU37uSvV/9wlQKw5HWQ
	 OPEIWkCVxEhUKBwbXqIiGVH7ZfKSoB+qNy/nValTCt0Fdl8bYDxCAwqsOxBDH8fNbyaQk
	 Gcopn/s0rn76oQLaOzML16NuIWnf/sHYTEJaalXvNEa//2pizLXUMR+y9WR2i5pzCnfmo
	 4Ko7isguwcp9wD7cbDAzQjGQOOsUZxcJQHJYoaEacLRHsFpUZSu8WzKJ6K/qYvGJLSojr
	 FBBOKBF0ddKiMSUUS/Sc9LgYleu4npM7LJvkvm5Rjm0sqmVDr1b2QQ3vZSYrT4LR1Jw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631299;
	bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xuer87t2OTKzaVPFbqUdqF+eNRbSKEppShX7WP57nTAVq7lLWJu38iC34iDzRM0AG
	 R7ETb9RlnlpDGXMr0CvN8HLWsci3kc4ak6JPObC6gbY05GMxk6GBp+5APsC+h7A27O
	 O/0X++7W3+lFVLfndp+cR3NmN/3Bcf9cEHlegXSv3WYmI1SFewo7KuEMR2utbAtUJe
	 incyVMGBE1xfKzyfeXyrEaljyaaSqm2HHDWMCMN2b9pc82tOJ6RcVNtjyNieFoEanH
	 ZZlty2RpPW61FA88cjyqAe+Nm507KxTbuJ3iUUuOta19/FjKO+oXS5Fbz1lGZFpL58
	 1tqtx1D7EYMMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E143580E9C;
	Thu, 17 Sep 2026 07:48:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2FAB29B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98FED6069A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZPZqqh6Qq98 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 793E76081D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631296;
 b=X3ysJoiUQON9j802zOG2G7ZcbI9e9sg2gTSzeWXMiOo/dhKbs2qH8zE2CkuMPDiuH3Iv
 7s7TLg2Xw+69PhrS6h7iF2Sm1C+oNEQFJTYCM27jLoEYsoE9i/iHFwragVp1S0t7EqlWx
 nTasVsi3r0bDgjXxgPNpXXKfPN9fiLTytbIx65Tpd3ezubhxVNB9hnSESFeTU9wPlC4mS
 qPLnXG0MM6TQH9uKGfdWuyoDSm5A3u2epGPiqu52EvLBUsCiGZZD8AvgZSeUSG3Rl4x48
 9/2i2UZsCsFuRE+j0931xmxOjw9esJQP9YaOzcw889lOcZCMoinKIJmR00lL2z4hQlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631296;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=VQ/+ydm0kuf2rhHqwQigDegXPwxDSzs0mS3DrE9AKiXeUrEbUNggNf/FzU+kiRUvBoUM
 pbnwdz5+ytN4DMZk7iWF2AcuL29WdEN3uynfEDeV+BoV+2bQVSUL6UXp5Xp4vlOm8bfPY
 oMCzRY0GcpXC4TpaOR1JR+osy2MzCdPFDKsjlv3S0uyTF+vixLMwlhfujke9GT9zTOZ+y
 F+Z8U1vbt+0WUTYhQdIjOInFMqzI8xguTe2MKWSd6ORmH23MHeb8DwUHRyutJQ2i277FW
 2pvs5NbWMGejbd4EpGe1gZ4c50BAQ0ZLxMQLMooYLs5eynwImgU97yhWKNXki99DDGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=DztQ3Gz1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hbpwAxlW; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=DztQ3Gz1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hbpwAxlW
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 793E76081D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60tEm1375596
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=; b=DztQ3Gz1NRuFDC/h
 YgNhE8FfOhJC6Mfr524dNLtnEbkzj/qNTp6g+GQ/zeSdTBa03FiPvl87VYyS+nkV
 0YCWbEe/gy207hOrIj7Ank/t/9Iqi0Mu5A6CT9Lst+f1yktGVbU3SDA8N1B6ab5q
 fa5sF1t6jjS4qVDQqyaYH94GMEPExwuRjXJNVfBePdihFaGOBUypZigkZgRMkZuN
 9si0dSIikswesEmnAc2khhcZD8+za7ZXzwt8GiXcqy1trN4UWf/gPSG1YA7KWwQw
 mvBVGv4/1GZ/lpHcXQ8Gt2NvXONhD64ifG9GxSOTxwmQPEdYbhN/tGN4HBlkPGk2
 502GCg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6au2jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:48:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso567543a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631294; x=1790236094;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=hbpwAxlWfX05/FluZpZujgIEQV/DVHAfvzye2rH6Q2Wwv32Mc1igvdUYdLW9wHN5ZU
 o2/QGuKHGlJK4m90WjtFoy3iIP7vBuO15We3U6vk1BfoT40PYz1trWOSdJByXhSYY5LV
 3g7otTOesAm/zx6fi1N6rSIhkHTbkwrINF4HRyd3Spj7ddwIxqxFeieZ771NaS7SqGvn
 K/li7IRCF1sth+3UymVeu89zV+fWBjaU+bD7/NZS24NPZt/nhkHaR0qMqzkYg+dyF410
 xv8nvqc4gEuOwG4OZ5Jsy94ULtwNO8p4s2/H7F4X5hvyEqq3TwFf/jCoJ4e5fU319D6K
 R+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631294; x=1790236094;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyJ1pfgdCUgZZtvSU0nqq6gTdOgAycnqqivr1oRZNDU=;
 b=cwj+MPt4NY4Y592RXqT926/LNW2ioOQm9NJ8kwhcUhNBzRP8iRCmsWyuo3MgqDW6PS
 5QrZzicwzk5w/NWyLeTrwbVt53Hfe41phNUNvkSU/0XYqtAMq5Sp+LsVvO12FFKCxjBP
 hCfMpsq2q9W4NglwzEMhBBgINuRESemfi4Q1e5ZNc0yJe3dZcfdjSAs65rZm8B9PEgZm
 p95PI6BVhZCSVomHuJmivmluCHH3VRhqitmT086uD1eD7p5XoQUecee5K+CUwCwgUFeE
 4a0I/vmER0qCR49OP13q6hbLdWMGa5HAcRx5FXJ38tiGB7b7SAqOf0ojSDCUsUmkcLEs
 GfGg==
X-Forwarded-Encrypted: i=1;
 AKwUvByt9ErptqhawlkSdZ4sm5eGxfPbIQkojWCPdXBh5yMI4y9DX8SS+DusEqQdhgNHGCko15BFp4Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nHIDZFlNA3/211HqidZvaxGCdR9Q3NDXRHx6KS2v/FKmOqgUoc
 wKIQgN350CTB7R7jdI8uCjN9sHyCKin0f2TVkN0LIq5fpNt/Zt2L6BdCKZUmeVhUpOWWSTcyeOz
 +s4VLlm1UE/fY1bSbNiIFz/VDsuWStmRnoM7c1KYDRLg2K8f0E5zsbouIuhF7HMH8oXRH7FM=
X-Gm-Gg: AYBFou1w7VJfGXPeM7Y08WR5fmzQvryQAB0Bi/+dGVWXvjs2J0LDqlfEo2OBZTeqRFD
 xGbAlKtgnHQ5FMkldLM/xsHsHLUizIvoOoflbHlKRP8NmUqQAzzwxU68mH5Wj3d1/ItGNTe28ML
 ICdGVOFgj+JuETj4ybvAKoNenla2MzEwoqypaJNbdCWkP8Dhg7gou9SLFUtgMtxd8DXUMMcMZ2T
 lYyLbArwoCrH9He/883m1ISlayChf0e6ZMiwpyOOY5xSdtRbQn9B4r100hLKz/9er9/G2lRWf5t
 sYxmavpbet6+jOF5bwRCQXiissJTAMrEmwJ4YopP7dpbyKV1lBkvsnywX6T+A9KWX+sqBj/Q/NW
 nqQhwjNL7kmHZu28KJTT3JGJX2gse/aaH99//9xtMUIazmtnZxO1ajjgYS3rRWEyjsO+32Xqdcm
 c66BoBBKlblTOdtlbbopODDDMLMrTDEQ==
X-Received: by 2002:a17:903:32c5:b0:2dd:4f83:eef9 with SMTP id
 d9443c01a7336-2dd8dbffecdmr133338845ad.4.1789631293807; 
 Thu, 17 Sep 2026 00:48:13 -0700 (PDT)
X-Received: by 2002:a17:903:32c5:b0:2dd:4f83:eef9 with SMTP id
 d9443c01a7336-2dd8dbffecdmr133338245ad.4.1789631293343; 
 Thu, 17 Sep 2026 00:48:13 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:48:12 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:44 +0530
Subject: [PATCH v10 15/15] doc: board/qualcomm: Update RDP build instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-15-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: RXE-z0RwQlR5Ds1iwHelfP_VQHczXP5M
X-Proofpoint-ORIG-GUID: RXE-z0RwQlR5Ds1iwHelfP_VQHczXP5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXzvAf8fGgDVkG
 uqYg3aHW2V1loZN2vHXiwFEhTSafRvtZCj5SLWiDLTZacanR2f+utpJ8QPxZaIJFGkK8Ow2CdiJ
 p3IMMU40mp2Z5Bg1lJakTGir3Qw7oMl5OYBsu2YgvNU6yrIrvebsIuRFrrQcMvjY5WFzj8uErx9
 uDj7cdR10LdAX8jJaB3OCCcvJfjgL+lw61+SFZajW/6AQ3V100yMb3HGRY5d1nQRFS5QM2WgIfg
 9M+Z8YHxCAdPhvf16ZDr0kSSVvAEOm5LTo0WiFMMFLMJXC/u8wiTxtQiTANBqjSGTEW9l4Kaawv
 yI4Fta0WLZdy3Sp12+tUoErizvd7BxYmCOUCm27uD3QAgbvL03BNkw/oYy/58xA0uhYDWJEMGxG
 cKbjdYf5qrnFJrTZYiO22I1XiVfW+Aw84TDFrGahhnXkrqEU406gRDf/UMcgZC4S4vrOJwiVEJL
 6RGPGQHdbxJ0wEANevw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfXxHil7XLBv+Tb
 qfbPwXqHebDHDT4w4I2COv+eWnUPThM/QqeWkS1PpRevUNYiNA2xucRycvR6u2epJGgjoBOTuQM
 tRRaJ3aaP9h+jJe76Fd07qmnGFqDEPA=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aab9b3e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=FmD-qdgRN1vrldnJjaMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

Add details about the SPL & U-Boot proper build steps, converting to
flashable images, source URLs for the needed binaries and scripts.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 96 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 4e63fe624b8..27101cc2d0d 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -25,13 +25,17 @@ about image signing can be found in :doc:`signing`.
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
-	IPQ9574: (MBN version 6)
+IPQ9574: (MBN version 6)
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
+.. code-block:: bash
 
-	IPQ5424: (MBN version 7)
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+IPQ5424: (MBN version 7)
+
+.. code-block:: bash
+
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
@@ -43,6 +47,81 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+--------------------------------------------------------------------
+
+Please refer to the following URLs for more details about the platforms.
+
+	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
+
+	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
+
+1. Since U-Boot SPL is enabled on these platforms, the build command generates
+   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
+   top of the U-Boot sources and ${out_dir} as the output directory,
+
+.. code-block:: bash
+
+    cd ${uboot_dir}
+    export CROSS_COMPILE=<aarch64 toolchain prefix>
+    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+    make -j8 O=${out_dir}
+
+U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
+U-Boot image:	${out_dir}/u-boot.elf
+
+2. Convert the SPL image to multi ELF
+
+.. code-block:: bash
+
+    cd ${out_dir}/spl
+    python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
+    python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+This u-boot-spl.melf should be flashed into 0:SPL partition.
+Please see below for the location of `tmel-ipq52xx-patch.elf`
+
+3. Convert the U-Boot image to bootloader image
+
+.. code-block:: bash
+
+    cd ${out_dir}
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
+and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
+can be built from the sources using the following commands
+
+TFA:
+
+.. code-block:: bash
+
+    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+OPTEE:
+
+.. code-block:: bash
+
+    make PLATFORM=qcom-ipq52xx -j16
+
+These binaries can be combined into a flashable image using `gen_its.py`.
+
+.. code-block:: bash
+
+	python gen_its.py --arch ipq5210		\
+		--qclib_path `QCLib.elf`		\
+		--qcconfig_path `qc_config.elf`		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template `template.its`
+
+This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -55,5 +134,14 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
+.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
 .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf

-- 
2.34.1

