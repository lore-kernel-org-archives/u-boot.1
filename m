Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA39FCA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 05:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E6BF60681;
	Thu,  8 Oct 2026 05:20:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3tVzfOxxp2a; Thu,  8 Oct 2026 05:20:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 791FB6068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791436822;
	b=oM3Wz+c4ba4HExyKia4BFGs8BaotzYmlW8GlVun0YSvBkXj2YAKfZzAFzH8ukfrsWwC+
	 RkBNcGA2gdsfRnr56hVN45knxlx0mpxP2Dq8BGQPXgXxJhP0PmZEZHcuBOgUwxca9pxIn
	 7plULQVgW5lZxziNz+vIm1rp5tyMHCZmL2TDY+wriVeAehu6NYiqI5cikcF6yznTCHmAu
	 UXxRj0gZoT4Yzmv2MPWi4buvZ2SevUBEhTTEvwwdTE9/x01h9iP8stXWTN9co/6Xwxdyi
	 9UfTaQiqoR4l98415geJ/dzeym2O1RhXIc0l0ODCzxZCpIgHH6ZKchptTSvId4tkThQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791436822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/TiBGeNLB/xT1C45tORSKE7EO7LiXFsXZt31VUNTHkI=;
	b=OzB6xgZw0rsKt4MoPv9OGBH1eKGh8U3i5H2LHMq5SPld6fqwDuVsnCkGp+YOREYbgF6D
	 NbfJquDIaGOSG0tBRtGsQpddZ5SyO8vofzVT/vh+swghiahz4BqrNVeiF+vTwJhzmHOV8
	 PGS6Np4z2sEY06qXZsFSeccTPxuHi1nOSPkrWWZOPqSkVHOZja8XloYOE8IdpQInLjrp/
	 ii7RUrcFPzZ9sK4rsLhXWybEfwKiDCeBmj2/eHxtmIh5cDRjIbQ1GNXuZLSSfky4QMT2/
	 eskquKY8ZaeAjgLESLLWroSZ6DrpRpDSKkzzA7isV6NDR4mBhGHMaFDKmaTFtPPKphA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791436822;
	bh=/TiBGeNLB/xT1C45tORSKE7EO7LiXFsXZt31VUNTHkI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d6DDNoWHVsK2xoz06X33fLVafiPVLZSdwGl8iQwFCBPnL+y9k9Mtlib1MXKj0uR76
	 NDUgQOcOrUSZsBVF3FtWSBxPAyjH6wJdDczg0NSIWT/JqfommVx5bN9syoOZ4KhKbx
	 c0uD4zwqLOMFC2isHn2gj/pWdODv5UaWcIfxbHRl+2EwEJMOBKXzkQRK+nQQgj/Zvq
	 Saw+MG5V531mgxvyIxwiTJJX+uGeIzUZnN91zOrSPxfHgYiFhfF4xWZtpt/1SMONQG
	 vKDfo86JsTsJVAVGadPaHR+I7YzVaitb6R5KVryHiNV4r/COLEuj09B5ivf6j6Fa+M
	 EIQXMN+g+9Ykw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791FB6068B;
	Thu,  8 Oct 2026 05:20:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4ED0317
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA85440832
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89xPfmlaBx5w for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 05:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 424944081B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791436817;
 b=df1QNlK9bz3SsnJHCBD7ZApf/nI8w4epgxKnbAEoBraER/X+oxXcfNW4Ofd2NvlFLhey
 1NFLubs7mezOY7jsdCLKBh2r8a7+2CmVAuzz7mmccUGs7chciFE/JvPL+NFCW4RCt2G8H
 9qhTsGDjhPf0l1XUspiQg02Q8N/+H1AWw7+EHJRaIox+D3KtcIDKNRxSpC0liLBbnVSRr
 YzkmhV2c69sczfcyQngpYhMqyRkLOqS3cNgLKuxANQUlmIRsXwYVSXWm/WIGwQ0rsrRTF
 aejnPJxUJtnjInUHtMx937F6xhS45/p/+rYhtxOB9yTkH70lroeXlQOBgHPxBt2OeSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791436817;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/TiBGeNLB/xT1C45tORSKE7EO7LiXFsXZt31VUNTHkI=;
 b=lEU/Z90mzjSt/sl1MMFaCKH7d719yXtYwofOhRY2CSt2p03ak+3i23ubS7yEOxoht5ct
 sUoNOlFSgHj8U1KlCYx2lf1R38NEpFQpKxkGANZkOYv7+9WTM404lun8OTZwO0kljgNQ+
 Xmj5EOW2Sis48sRiTd++wPJRsWpD2LB1U5lg7pcbeOh4FiiTd4xDu2Ro1UuKlRa/+uYw2
 lQ73uqdNPCWgf0kRFuOvcCRPEgKhB5MNJJs4LWJTdBetLxH8Q/4XLDYw0Hobu+xTlomku
 c/FelS0zxv5+R3XrCfkrZxxmEsgg2lefL5ktygNoP5aB2BvIOKRi3GrbxM/pj/jOrgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mg1U6fMP; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="G9z3lZ/Z"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mg1U6fMP; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=G9z3lZ/Z
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 424944081B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:20:16 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BRTS2895383
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 05:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/TiBGeNLB/xT1C45tORSKE
 7EO7LiXFsXZt31VUNTHkI=; b=mg1U6fMPTP2pChydU6UCVtSmTz5bEO57Jnxzue
 XKABSa9FLrjdD3QbYtyyTrq6Ns1nYFskVsgCLN7DbKWF6rODeqDbFMjzfGHM/fav
 IRTMEMUOlzDU9LBdAqr1rQITlLndNgWl6PcScFFCHTGPxzMb9PH8Osvlusza/Z61
 ySuOmv/+tuCnei0W2e5TR9pCGkrCECQOH5QdcCcwrjabw2mH2COgNc5XwywXvLpW
 NJ+0XXDrelTpZSUZypvwh0Y7zNIVMyVzdlIyR09dNFHilhCJ0ATXFnDxKrX/r+7h
 rWShbUhZGiwLS27nWLeuE2DAZjo6j58O5btU9YHcmbLui3dg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg8t77-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 05:20:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14fed306427so16321215c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 22:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791436815; x=1792041615;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/TiBGeNLB/xT1C45tORSKE7EO7LiXFsXZt31VUNTHkI=;
 b=G9z3lZ/Zgp0SqyFcngPKxhfv48r90eoQQN8FXFdrYzdCKZQDlpOf6y9yAY0iD6qIWn
 0kJHJlOmG0ywtt+3BUNYNseSxoX+LOhufitCLhQKQYYcSKrh91lr7R4wpWZ1Sqs8NKyL
 oZbMNIOXIk3CQMO0Kch3bTzGjkJ9scId8qQJGc2UCxSPmNjDFTlDUhKqagxlLSC2JFR/
 Jrxj08ZZ39roNGsurYuEt+oclPAzE9RmGaUUp6JnNLA0/pzozOsLqJouhPwEJqukPZ2a
 wNmxuAlIt93ivFCY7tO7FsNORoBFN+hkp0EpeKdtuc4RqlUjXK3MLOOPetINC/XCecJ5
 9AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791436815; x=1792041615;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/TiBGeNLB/xT1C45tORSKE7EO7LiXFsXZt31VUNTHkI=;
 b=H/haZ+qChzVrLSt6rr5eTPxrdhUhtZdMdrb6na/asofB8Q0FQDUaAxeAXaBnxf4ZCH
 4THPbvXwyiTiXJM3ZBuMExxwVhefQTXC7N/DNbGVzjQ7pGuO/NduhE1zMwuf14/wMP+1
 KQ0gM4SQKyXfYoOX0N9rNSVi6UrGifoeMJAXiKYKOo30bWvQ62iJFvzjNdjtLxcEGNc0
 7/p7mqPf6ALzgu8Jcqp1WI+7aaXPPyYiRYEPUwoj+/jquUrShu9XIBr9k2Dt8uVjixKF
 2wT7cMbdI7m4I2EOsz2cpg+eeBk+15dwquI+65l75XS0w+YONNUYjwq3+TtTjg7yVGCk
 MMjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR4CQOV7N6ZXL/RsEOsT7z/CBX08FtdABat/SBH3yqssIBIFSfP8gJ+D3IHE8IaiFHalQ13yk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuIj9INMrWTNciWXpoeHGmZiyPx4nvv2s+l+tjDCqNbroPNnL0
 4wIamQrMjcIVScpW54qsJjv0Y+e8WSCouI/4PGj2MZpEgkFBVXJYibdGrCwXMyEHe6vXngIYOQX
 XrkQHo9mo/6A/VT/9QWIzUjJQO8KIFbFcLMYlsDvCTd4mg6XcIWKr1N8Vbrra1WPzeTxvE24=
X-Gm-Gg: AYBFou0J7hmVusRbRzZ3mOvewMTEZJGWcbKpCcHvjKY0a0xR8YeqyTSyQM0qqnYtqhz
 FiZm5EFerPVW0TZqINCAyhM6HkY2ifIZTi7O+baQVTEdKeHg78ckBgWOcwfC/Zp6HfpRQI1KLZ5
 o3P3A0D2kGZUap+PGmaPAz83uVMFo/4HwxPYfhePXWQ8emWNrsqPTa5R1O6Mvbe9WctmX5eid+N
 5WZU4izWTgwPiWgTx9N9hGUl9VxAEoxP5KBrkrJnsEgu0IIMk+ESeGknYbA0LGDxRPFf399weeR
 si92gEl9eGXv+rm1QCDi+10sjmCi1RVpC8Nxfb18uQgiSO5ozSDc7p8TjJ5JkqWG7nXA5P5sKwM
 DezLTyiZho29jXdhxZgSU1oh8GH8ZGP5xwCeuwY2tfs736aeUH5+1NvjUTFZIQKKkzUDwSfu1MZ
 DG9pWRoty9nCyO8NbjmGBUsMDh+i1sFwsG0/jc+w==
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1620966b83amr6991047c88.38.1791436814604; 
 Wed, 07 Oct 2026 22:20:14 -0700 (PDT)
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1620966b83amr6990967c88.38.1791436813727; 
 Wed, 07 Oct 2026 22:20:13 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16167ef2e54sm9958325c88.10.2026.10.07.22.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 22:20:12 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 10:50:07 +0530
Subject: [PATCH v6] spi: Add Qualcomm GENI QUPv3 SPI controller driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-spi-v6-v6-1-2a8f6c05ebb8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAYox2oC/yXMQQqAIBCF4avErBPUxRBdJVqYTjUtSpyKILx7V
 ssP/vduEEpMAm11Q6KThbe1AOsK/OzWiRSHYrDaotEalURWJyrjnbPYWBPQQYljopGv76jrf8s
 xLOT3dw05P57pzWpqAAAA
X-Change-ID: 20261006-spi-v6-1caa26821d6a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791436808; l=27350;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=T7cV9JsuuJtjonaOU5sYMUCaFZ5yuAEvoAVqCTyf4oo=;
 b=QBiICmciOlLcT5J8PhlPeaalhowo/S+l545g7zNNy3+Nq30/eCGZZ6QTQcDh2/hB0uQzStcCC
 YYlXHxL5tnWDqxlVqnuaphMI4r5ZBoAjldj/wll4o8OoDuJ6QiaBFjU
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: Nc1fFd1wI8WobsyoKP9bBq-5mdxQVgPL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyMSBTYWx0ZWRfX1b4ny9odstN+
 X7WcSVq2Hf6lgdSf4jwvh3FcAWgrTdJvXO0rFlMjmvmwmGXSh0oSlgX1RkAJm4dgfacikI/imN3
 L6n8siepBGS5SKs50mgBk0x5s1maEkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyMSBTYWx0ZWRfX3JupYNT1tEWZ
 dEWxODHPXFBi2aPNWeEM3g4XSZWCnoUpw0rq7XdSJsyVrIWADgV0eFEt3iZbNDD+IHJULXngOUM
 poMTWC2wymcx2WHDExsTtvQoVcxeqrq6na7Ddx3Xq3mkHFZgtQpgHNrvCFjf/DbxLJIAy+J/sdk
 PBbvztrZPsBR17Ux/U6Y/09hQux0b4DAlw5xrnVHLrczsJMyhAFJZQY52ieTOTyg/mhpliVpHq9
 9HimOBNCzj76qTt7o1O1VAepp03h8/N8KWtadEv/7JEJpuShrsSF4B1Qnp6friROsHJTjY3DBpP
 UFZilhF2e1WqevmlUrsq6X6PVAPvEcr6b6rwXzExZ2eIQTwC4NTK37LWeFHjNXZFO+Dep9Hl7r2
 HHtdg8Xdiagj91qcXm5vpx7GQSg8P4MCVQe2+DieT0mLZsmF78GCDG85yrpx/CdKIlsJd95z1Z1
 pnpz4n7FSS6lXzgTYWQ==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7280f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8 a=sYlAhso2FhR3wPXm5ucA:9
 a=JutqKRNgYwafejv_:21 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: Nc1fFd1wI8WobsyoKP9bBq-5mdxQVgPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080021
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

Add a DM_SPI driver for the SPI-protocol personality of the Qualcomm
GENI Serial Engine, found inside a QUPv3 wrapper on Qualcomm SoCs
such as SDM845, SM8250 and SA8775P. The Serial Engine is shared
across UART/I2C/SPI protocols and needs firmware for the desired
protocol loaded into it before use, via the existing
qcom_geni_load_firmware() helper.

The driver supports both the CPU-driven FIFO transfer path and the
Serial Engine's own DMA engine (SE-DMA). Whether FIFO mode is usable
is read back from hardware (GENI_IF_DISABLE_RO); SE-DMA is always
available. The driver picks FIFO for small transfers when FIFO is
available, and SE-DMA otherwise, matching the mode-selection logic
of the equivalent Linux driver.

Add the register offsets needed by the new driver to the shared
include/soc/qcom/geni-se.h, and wire up the new driver's Kconfig entry
and Makefile rule. The TX/RX fifo-depth helper it uses,
geni_se_fifo_depth_mask(), is provided by the RX_RFR_WATERMARK fix
this patch depends on.

Validated in both FIFO and DMA modes on IPQ5424 and LeMans platforms.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
Depends-on: https://lore.kernel.org/u-boot/20261006-geni-rx-rfr-watermark-fix-v3-1-b368fe3fbf70@oss.qualcomm.com/

Changes in v6:
- Update Depends-on to the RX_RFR_WATERMARK fix v3 posting (v5 pointed
  at v2); it still provides geni_se_fifo_depth_mask() used by this driver
- Fix stale u-boot@lists.denx.de recipient to u-boot@lists.u-boot-project.org
- Drop stale Link/Message-Id trailers carried over from the v5 posting
- Link to v5: https://lore.kernel.org/u-boot/20260913-geni-spi-v2-review-v5-1-b80cef576afa@oss.qualcomm.com/
---
 drivers/spi/Kconfig         |   9 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/qcom_geni_spi.c | 780 ++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/geni-se.h  |   8 +
 4 files changed, 798 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cfbedd64c4c..99870085f8d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -463,6 +463,15 @@ config SPI_QUP
 	  mode supports up to 50MHz, up to four chip selects, programmable
 	  data path from 4 bits to 32 bits and numerous protocol variants.
 
+config SPI_GENI_QCOM
+	bool "Qualcomm GENI SPI controller"
+	depends on DM_SPI && QCOM_GENI
+	help
+	  Enable support for the SPI Serial Engine of the Qualcomm Generic
+	  Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper.
+	  Used to access SPI devices such as SPI-NOR flash on Qualcomm SoCs
+	  that have a GENI/QUPv3 wrapper, e.g. SDM845, SM8250, SA8775P.
+
 config RENESAS_RPC_SPI
 	bool "Renesas RPC SPI driver"
 	depends on RCAR_64 || RZA1
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 13d9c5dce80..c1ade77c75a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_OMAP3_SPI) += omap3_spi.o
 obj-$(CONFIG_PIC32_SPI) += pic32_spi.o
 obj-$(CONFIG_PL022_SPI) += pl022_spi.o
 obj-$(CONFIG_SPI_QUP) += spi-qup.o
+obj-$(CONFIG_SPI_GENI_QCOM) += qcom_geni_spi.o
 obj-$(CONFIG_SPI_MXIC) += spi-mxic.o
 obj-$(CONFIG_RENESAS_RPC_SPI) += renesas_rpc_spi.o
 obj-$(CONFIG_ROCKCHIP_SFC) += rockchip_sfc.o
diff --git a/drivers/spi/qcom_geni_spi.c b/drivers/spi/qcom_geni_spi.c
new file mode 100644
index 00000000000..c0c1d08d724
--- /dev/null
+++ b/drivers/spi/qcom_geni_spi.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm GENI QUPv3 SPI controller driver
+ *
+ * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <log.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/read.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <cpu_func.h>
+#include <spi.h>
+#include <clk.h>
+#include <time.h>
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+
+/* SPI-protocol-specific SE registers, on top of the generic ones in geni-se.h */
+#define SE_SPI_CPHA			0x224
+#define SE_SPI_LOOPBACK		0x22c
+#define SE_SPI_CPOL			0x230
+#define SE_SPI_DEMUX_OUTPUT_INV	0x24c
+#define SE_SPI_DEMUX_SEL		0x250
+#define SE_SPI_TRANS_CFG		0x25c
+#define SE_SPI_DELAYS_COUNTERS		0x278
+#define SE_SPI_WORD_LEN		0x268
+#define SE_SPI_TX_TRANS_LEN		0x26c
+#define SE_SPI_RX_TRANS_LEN		0x270
+
+#define CPHA				BIT(0)
+
+#define LOOPBACK_ENABLE			0x1
+#define LOOPBACK_MSK			GENMASK(1, 0)
+
+#define CPOL				BIT(2)
+
+/* SE_SPI_TRANS_CFG */
+#define CS_TOGGLE			BIT(1)
+
+#define WORD_LEN_MSK			GENMASK(9, 0)
+#define SPI_WORD_LEN_BITS		8
+#define MIN_WORD_LEN			4
+
+#define SPI_TX_ONLY			1
+#define SPI_RX_ONLY			2
+#define SPI_TX_RX			7
+#define FRAGMENTATION			BIT(2)
+
+#define SPI_ERR	(M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN | \
+		  M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN | \
+		  M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)
+
+#define SPI_XFER_TIMEOUT_MS		250
+
+/* SPI-NOR reads/writes are page/sector sized; skip DMA setup below this */
+#define SPI_DMA_MIN_XFER_BYTES		64
+
+struct qcom_geni_spi_priv {
+	phys_addr_t wrapper;
+	phys_addr_t base;
+	struct clk se;
+	u32 tx_wm;
+	u32 tx_fifo_depth;
+	u32 bpw;
+	u32 bytes_per_fifo_word;
+	u32 oversampling;
+	bool fifo_capable;
+};
+
+/* Bytes packed into each 32-bit FIFO word, based on word length */
+static unsigned int qcom_geni_spi_bytes_per_fifo_word(unsigned int bpw)
+{
+	if (bpw <= 8)
+		return 4;
+	else if (bpw <= 16)
+		return 2;
+	return 1;
+}
+
+/* Scale the wait budget with transfer size instead of a flat constant */
+static ulong qcom_geni_spi_xfer_timeout_ms(struct qcom_geni_spi_priv *priv,
+					   unsigned int len)
+{
+	ulong rate = clk_get_rate(&priv->se);
+	ulong ms;
+
+	if (IS_ERR_VALUE(rate) || !rate)
+		return SPI_XFER_TIMEOUT_MS + len / 1000;
+
+	/* len is in bytes; add generous margin for controller/DMA overhead */
+	ms = DIV_ROUND_UP((u64)len * 8 * 1000, rate) * 4;
+
+	return max_t(ulong, ms, SPI_XFER_TIMEOUT_MS);
+}
+
+#define NUM_PACKING_VECTORS		4
+#define PACKING_START_SHIFT		5
+#define PACKING_DIR_SHIFT		4
+#define PACKING_LEN_SHIFT		1
+#define PACKING_STOP_BIT		BIT(0)
+#define PACKING_VECTOR_SHIFT		10
+
+/* Configure how the SE packs/unpacks "bpw"-bit words into 32-bit FIFO entries */
+static void qcom_geni_spi_config_packing(struct qcom_geni_spi_priv *priv, int bpw,
+					 bool msb_to_lsb)
+{
+	u32 cfg0, cfg1, cfg[NUM_PACKING_VECTORS] = {0};
+	int len, temp_bpw = bpw;
+	int idx_start = msb_to_lsb ? bpw - 1 : 0;
+	int idx = idx_start;
+	int idx_delta = msb_to_lsb ? -BITS_PER_BYTE : BITS_PER_BYTE;
+	int i, iter, pack_words;
+	unsigned int ceil_bpw;
+
+	if (bpw <= 8)
+		pack_words = 4;
+	else if (bpw <= 16)
+		pack_words = 2;
+	else
+		pack_words = 1;
+
+	ceil_bpw = (bpw & (BITS_PER_BYTE - 1)) ?
+		((bpw & ~(BITS_PER_BYTE - 1)) + BITS_PER_BYTE) : bpw;
+
+	iter = (ceil_bpw * pack_words) >> 3;
+	if (iter <= 0 || iter > NUM_PACKING_VECTORS)
+		return;
+
+	for (i = 0; i < iter; i++) {
+		len = min_t(int, temp_bpw, BITS_PER_BYTE) - 1;
+		cfg[i] = idx << PACKING_START_SHIFT;
+		cfg[i] |= msb_to_lsb << PACKING_DIR_SHIFT;
+		cfg[i] |= len << PACKING_LEN_SHIFT;
+
+		if (temp_bpw <= BITS_PER_BYTE) {
+			idx = ((i + 1) * BITS_PER_BYTE) + idx_start;
+			temp_bpw = bpw;
+		} else {
+			idx = idx + idx_delta;
+			temp_bpw = temp_bpw - BITS_PER_BYTE;
+		}
+	}
+	cfg[iter - 1] |= PACKING_STOP_BIT;
+	cfg0 = cfg[0] | (cfg[1] << PACKING_VECTOR_SHIFT);
+	cfg1 = cfg[2] | (cfg[3] << PACKING_VECTOR_SHIFT);
+
+	writel(cfg0, priv->base + SE_GENI_TX_PACKING_CFG0);
+	writel(cfg1, priv->base + SE_GENI_TX_PACKING_CFG1);
+	writel(cfg0, priv->base + SE_GENI_RX_PACKING_CFG0);
+	writel(cfg1, priv->base + SE_GENI_RX_PACKING_CFG1);
+
+	writel(bpw / 16, priv->base + SE_GENI_BYTE_GRAN);
+}
+
+static int qcom_geni_spi_fifo_xfer(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				   u8 *rx, unsigned int len, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	unsigned int tx_cur = 0, rx_cur = 0;
+
+	while (get_timer(start) < timeout_ms) {
+		u32 status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
+		unsigned int i;
+
+		if (status & SPI_ERR) {
+			writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+			if (tx)
+				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
+			return -EIO;
+		}
+
+		if (tx && (status & M_TX_FIFO_WATERMARK_EN)) {
+			for (i = 0; i < priv->tx_wm && tx_cur < len; i++) {
+				u32 word = 0;
+				unsigned int p;
+
+				for (p = 0; p < priv->bytes_per_fifo_word && tx_cur < len; p++)
+					word |= tx[tx_cur++] << (p * 8);
+
+				writel(word, priv->base + SE_GENI_TX_FIFOn);
+			}
+
+			if (tx_cur == len)
+				writel(0, priv->base + SE_GENI_TX_WATERMARK_REG);
+		}
+
+		if (status & (M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN)) {
+			u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+			u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
+
+			if (rx) {
+				for (i = 0; rx_cur < len && i < rxcnt; i++) {
+					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
+					unsigned int p;
+
+					for (p = 0; p < priv->bytes_per_fifo_word &&
+					     rx_cur < len; p++) {
+						rx[rx_cur++] = word & 0xff;
+						word >>= 8;
+					}
+				}
+			} else {
+				for (i = 0; i < rxcnt; i++)
+					readl(priv->base + SE_GENI_RX_FIFOn);
+			}
+		}
+
+		writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+		if (status & M_CMD_DONE_EN) {
+			/* Drain any residual RX words after CMD_DONE */
+			if (rx && rx_cur < len) {
+				u32 rxstatus = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+				u32 rxcnt = rxstatus & RX_FIFO_WC_MSK;
+				unsigned int i;
+
+				for (i = 0; rx_cur < len && i < rxcnt; i++) {
+					u32 word = readl(priv->base + SE_GENI_RX_FIFOn);
+					unsigned int p;
+
+					for (p = 0; p < priv->bytes_per_fifo_word &&
+					     rx_cur < len; p++) {
+						rx[rx_cur++] = word & 0xff;
+						word >>= 8;
+					}
+				}
+			}
+			return 0;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_abort(struct udevice *dev, struct qcom_geni_spi_priv *priv)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	writel(M_GENI_CMD_ABORT, priv->base + SE_GENI_M_CMD_CTRL_REG);
+
+	do {
+		status = readl(priv->base + SE_GENI_M_IRQ_STATUS);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	} while (!(status & M_CMD_ABORT_EN));
+
+	writel(status, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	/* Reset TX/RX DMA FSMs so the next transfer starts clean */
+	start = get_timer(0);
+	writel(1, priv->base + SE_DMA_TX_FSM_RST);
+	do {
+		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
+			dev_err(dev, "DMA TX RESET failed\n");
+			break;
+		}
+	} while (!(status & TX_RESET_DONE));
+	writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
+
+	start = get_timer(0);
+	writel(1, priv->base + SE_DMA_RX_FSM_RST);
+	do {
+		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
+		if (get_timer(start) > SPI_XFER_TIMEOUT_MS) {
+			dev_err(dev, "DMA RX RESET failed\n");
+			break;
+		}
+	} while (!(status & RX_RESET_DONE));
+	writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
+
+	return 0;
+}
+
+/* SE-DMA: the SE moves data directly to/from a physical buffer */
+static void qcom_geni_spi_dma_tx_start(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				       unsigned int len)
+{
+	phys_addr_t buf = (phys_addr_t)(uintptr_t)tx;
+
+	flush_dcache_range(ALIGN_DOWN((ulong)tx, ARCH_DMA_MINALIGN),
+			   ALIGN((ulong)tx + len, ARCH_DMA_MINALIGN));
+
+	writel(lower_32_bits(buf), priv->base + SE_DMA_TX_PTR_L);
+	writel(upper_32_bits(buf), priv->base + SE_DMA_TX_PTR_H);
+	writel(GENI_SE_DMA_EOT_BUF, priv->base + SE_DMA_TX_ATTR);
+	writel(len, priv->base + SE_DMA_TX_LEN);
+}
+
+static void qcom_geni_spi_dma_rx_start(struct qcom_geni_spi_priv *priv, u8 *rx,
+				       unsigned int len)
+{
+	phys_addr_t buf = (phys_addr_t)(uintptr_t)rx;
+
+	/* Discard stale dirty cache lines before the DMA write lands */
+	invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
+				ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
+
+	writel(lower_32_bits(buf), priv->base + SE_DMA_RX_PTR_L);
+	writel(upper_32_bits(buf), priv->base + SE_DMA_RX_PTR_H);
+	writel(0, priv->base + SE_DMA_RX_ATTR);
+	writel(len, priv->base + SE_DMA_RX_LEN);
+}
+
+static int qcom_geni_spi_dma_wait_tx(struct qcom_geni_spi_priv *priv, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	while (get_timer(start) < timeout_ms) {
+		status = readl(priv->base + SE_DMA_TX_IRQ_STAT);
+		if (!status) {
+			udelay(1);
+			continue;
+		}
+
+		writel(status, priv->base + SE_DMA_TX_IRQ_CLR);
+
+		if (status & TX_SBE)
+			return -EIO;
+		if (status & TX_DMA_DONE)
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_dma_wait_rx(struct qcom_geni_spi_priv *priv, u8 *rx,
+				     unsigned int len, ulong timeout_ms)
+{
+	ulong start = get_timer(0);
+	u32 status;
+
+	while (get_timer(start) < timeout_ms) {
+		status = readl(priv->base + SE_DMA_RX_IRQ_STAT);
+		if (!status) {
+			udelay(1);
+			continue;
+		}
+
+		writel(status, priv->base + SE_DMA_RX_IRQ_CLR);
+
+		if (status & RX_SBE)
+			return -EIO;
+		if (status & RX_DMA_DONE) {
+			/* Force the AXI write to retire before trusting the buffer */
+			readl(priv->base + SE_DMA_RX_LEN);
+			invalidate_dcache_range(ALIGN_DOWN((ulong)rx, ARCH_DMA_MINALIGN),
+						ALIGN((ulong)rx + len, ARCH_DMA_MINALIGN));
+			return 0;
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int qcom_geni_spi_dma_xfer_wait(struct qcom_geni_spi_priv *priv, const u8 *tx,
+				       u8 *rx, unsigned int len, ulong timeout_ms)
+{
+	int ret;
+
+	if (tx) {
+		ret = qcom_geni_spi_dma_wait_tx(priv, timeout_ms);
+		if (ret)
+			return ret;
+	}
+
+	if (rx) {
+		ret = qcom_geni_spi_dma_wait_rx(priv, rx, len, timeout_ms);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* TX/RX_TRANS_LEN and DMA_TX/RX_LEN are 24-bit HW fields; split large transfers */
+#define SPI_GENI_MAX_XFER_BYTES		0xFFFFFF
+
+/* RX DMA requires a cache-line-aligned start and length to invalidate safely */
+static bool qcom_geni_spi_rx_needs_bounce(const void *rx, unsigned int len)
+{
+	return !IS_ALIGNED((ulong)rx, ARCH_DMA_MINALIGN) ||
+	       !IS_ALIGNED(len, ARCH_DMA_MINALIGN);
+}
+
+static int qcom_geni_spi_xfer_chunk(struct udevice *dev, struct qcom_geni_spi_priv *priv,
+				    unsigned int len, const void *dout, void *din,
+				    bool use_dma, bool last_chunk, ulong timeout_ms)
+{
+	u32 cmd, m_param = 0;
+	int ret;
+
+	writel(dout ? len : 0, priv->base + SE_SPI_TX_TRANS_LEN);
+	writel(din ? len : 0, priv->base + SE_SPI_RX_TRANS_LEN);
+
+	/* SPI_TX_ONLY | SPI_RX_ONLY is not a valid opcode, use SPI_TX_RX instead */
+	if (dout && din)
+		cmd = SPI_TX_RX;
+	else if (din)
+		cmd = SPI_RX_ONLY;
+	else if (dout)
+		cmd = SPI_TX_ONLY;
+	else
+		cmd = 0;
+
+	if (!last_chunk)
+		m_param |= FRAGMENTATION;
+
+	if (use_dma) {
+		setbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
+
+		/* DMA: issue M_CMD0 first, then arm DMA descriptors */
+		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
+		       priv->base + SE_GENI_M_CMD0);
+		if (din)
+			qcom_geni_spi_dma_rx_start(priv, din, len);
+		if (dout)
+			qcom_geni_spi_dma_tx_start(priv, dout, len);
+
+		ret = qcom_geni_spi_dma_xfer_wait(priv, dout, din, len, timeout_ms);
+
+		/* Clear M_CMD_DONE so status doesn't accumulate across transfers */
+		writel(readl(priv->base + SE_GENI_M_IRQ_STATUS),
+		       priv->base + SE_GENI_M_IRQ_CLEAR);
+	} else {
+		clrbits_le32(priv->base + SE_GENI_DMA_MODE_EN, GENI_DMA_MODE_EN);
+
+		/*
+		 * Set watermarks before M_CMD0. Only set TX_WATERMARK when
+		 * we have TX data, since SPI_RX_ONLY doesn't use the TX FIFO.
+		 */
+		if (dout)
+			writel(1, priv->base + SE_GENI_TX_WATERMARK_REG);
+		/* RX_WATERMARK=0: SE fires RX_FIFO_LAST at end of transfer */
+		if (din)
+			writel(0, priv->base + SE_GENI_RX_WATERMARK_REG);
+
+		writel((cmd << M_OPCODE_SHFT) | (m_param & M_PARAMS_MSK),
+		       priv->base + SE_GENI_M_CMD0);
+
+		ret = qcom_geni_spi_fifo_xfer(priv, dout, din, len, timeout_ms);
+	}
+
+	return ret;
+}
+
+static int qcom_geni_spi_xfer_once(struct udevice *dev, unsigned int len,
+				   const void *dout, void *din, bool xfer_end)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	ulong timeout_ms = qcom_geni_spi_xfer_timeout_ms(priv, len);
+	bool use_dma = !priv->fifo_capable || len >= SPI_DMA_MIN_XFER_BYTES;
+	u8 edge_buf[2][ARCH_DMA_MINALIGN] __aligned(ARCH_DMA_MINALIGN);
+	unsigned int head_len = 0, tail_len = 0, mid_len = len, done = 0;
+	int ret = 0;
+
+	if (din && use_dma && qcom_geni_spi_rx_needs_bounce(din, len)) {
+		head_len = min_t(unsigned int,
+				 ALIGN((ulong)din, ARCH_DMA_MINALIGN) - (ulong)din,
+				 len);
+		tail_len = (len - head_len) % ARCH_DMA_MINALIGN;
+		mid_len = len - head_len - tail_len;
+	}
+
+	if (head_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, head_len, dout, edge_buf[0],
+					       use_dma, xfer_end && !mid_len && !tail_len,
+					       timeout_ms);
+		if (!ret)
+			memcpy(din, edge_buf[0], head_len);
+		done += head_len;
+	}
+
+	if (!ret && mid_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, mid_len,
+					       dout ? (const u8 *)dout + done : NULL,
+					       din ? (u8 *)din + done : NULL,
+					       use_dma, xfer_end && !tail_len, timeout_ms);
+		done += mid_len;
+	}
+
+	if (!ret && tail_len) {
+		ret = qcom_geni_spi_xfer_chunk(dev, priv, tail_len,
+					       dout ? (const u8 *)dout + done : NULL,
+					       edge_buf[1], use_dma, xfer_end, timeout_ms);
+		if (!ret)
+			memcpy((u8 *)din + done, edge_buf[1], tail_len);
+	}
+
+	if (ret) {
+		int abort_ret = qcom_geni_spi_abort(dev, priv);
+
+		if (abort_ret)
+			dev_err(dev, "abort failed: %d\n", abort_ret);
+	}
+
+	return ret;
+}
+
+static int qcom_geni_spi_xfer(struct udevice *dev, unsigned int bitlen,
+			      const void *dout, void *din, unsigned long flags)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	unsigned int len = DIV_ROUND_UP(bitlen, 8);
+	unsigned int done = 0;
+	int ret;
+
+	if (flags & SPI_XFER_BEGIN)
+		writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	while (done < len) {
+		unsigned int chunk = min_t(unsigned int, len - done,
+					    SPI_GENI_MAX_XFER_BYTES);
+		bool xfer_end = (flags & SPI_XFER_END) && (done + chunk == len);
+
+		ret = qcom_geni_spi_xfer_once(dev,
+					      chunk,
+					  dout ? (const u8 *)dout + done : NULL,
+					  din ? (u8 *)din + done : NULL,
+					  xfer_end);
+		if (ret)
+			return ret;
+
+		done += chunk;
+	}
+
+	return 0;
+}
+
+static int qcom_geni_spi_set_speed(struct udevice *bus, uint speed)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	ulong parent_rate;
+	u32 div;
+
+	if (!speed)
+		return -EINVAL;
+
+	parent_rate = clk_get_rate(&priv->se);
+	if (IS_ERR_VALUE(parent_rate) || !parent_rate)
+		div = priv->oversampling;
+	else
+		div = DIV_ROUND_UP(parent_rate, priv->oversampling * speed);
+
+	div = clamp_t(u32, div, 1, CLK_DIV_MSK >> CLK_DIV_SHFT);
+
+	writel(0, priv->base + SE_GENI_CLK_SEL);
+	writel((div << CLK_DIV_SHFT) | SER_CLK_EN, priv->base + GENI_SER_M_CLK_CFG);
+
+	return 0;
+}
+
+static int qcom_geni_spi_set_mode(struct udevice *bus, uint mode)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	u32 val;
+
+	val = readl(priv->base + SE_SPI_LOOPBACK);
+	val &= ~LOOPBACK_MSK;
+	if (mode & SPI_LOOP)
+		val |= LOOPBACK_ENABLE;
+	writel(val, priv->base + SE_SPI_LOOPBACK);
+
+	val = readl(priv->base + SE_SPI_CPHA);
+	if (mode & SPI_CPHA)
+		val |= CPHA;
+	else
+		val &= ~CPHA;
+	writel(val, priv->base + SE_SPI_CPHA);
+
+	val = readl(priv->base + SE_SPI_CPOL);
+	if (mode & SPI_CPOL)
+		val |= CPOL;
+	else
+		val &= ~CPOL;
+	writel(val, priv->base + SE_SPI_CPOL);
+
+	return 0;
+}
+
+static int qcom_geni_spi_claim_bus(struct udevice *dev)
+{
+	struct udevice *bus = dev_get_parent(dev);
+	struct qcom_geni_spi_priv *priv = dev_get_priv(bus);
+	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
+	unsigned int cs = slave_plat->cs[0];
+	unsigned int bpw = slave_plat->wordlen ? slave_plat->wordlen : SPI_WORD_LEN_BITS;
+
+	priv->bpw = bpw;
+	priv->bytes_per_fifo_word = qcom_geni_spi_bytes_per_fifo_word(bpw);
+
+	writel((bpw - MIN_WORD_LEN) & WORD_LEN_MSK, priv->base + SE_SPI_WORD_LEN);
+	writel(cs, priv->base + SE_SPI_DEMUX_SEL);
+	writel(slave_plat->mode & SPI_CS_HIGH ? BIT(cs) : 0,
+	       priv->base + SE_SPI_DEMUX_OUTPUT_INV);
+
+	qcom_geni_spi_config_packing(priv, bpw, true);
+
+	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	return 0;
+}
+
+static int qcom_geni_spi_release_bus(struct udevice *dev)
+{
+	return 0;
+}
+
+static u32 qcom_geni_spi_get_tx_fifo_depth(struct qcom_geni_spi_priv *priv)
+{
+	u32 val, hw_version, depth_mask;
+
+	hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
+	depth_mask = geni_se_fifo_depth_mask(hw_version, TX_FIFO_DEPTH_MSK_256_BYTES,
+					     TX_FIFO_DEPTH_MSK);
+
+	val = readl(priv->base + SE_HW_PARAM_0);
+
+	return (val & depth_mask) >> TX_FIFO_DEPTH_SHFT;
+}
+
+/* QUP v1.0 undersamples the SPI clock and needs 2x the requested bit rate */
+static u32 qcom_geni_spi_get_oversampling(struct qcom_geni_spi_priv *priv)
+{
+	u32 hw_version = readl(priv->wrapper + QUP_HW_VER_REG);
+	u32 hw_major = GENI_SE_VERSION_MAJOR(hw_version);
+	u32 hw_minor = GENI_SE_VERSION_MINOR(hw_version);
+
+	if (hw_major == 1 && hw_minor == 0)
+		return 2;
+
+	return 1;
+}
+
+static void qcom_geni_spi_hw_init(struct qcom_geni_spi_priv *priv)
+{
+	u32 val;
+
+	writel(0xffffffff, priv->base + SE_GENI_M_IRQ_CLEAR);
+
+	val = readl(priv->base + GENI_CGC_CTRL);
+	val |= DEFAULT_CGC_EN;
+	writel(val, priv->base + GENI_CGC_CTRL);
+
+	writel(DEFAULT_IO_OUTPUT_CTRL_MSK, priv->base + GENI_OUTPUT_CTRL);
+	writel(FORCE_DEFAULT, priv->base + GENI_FORCE_DEFAULT_REG);
+
+	val = readl(priv->base + SE_IRQ_EN);
+	val |= GENI_M_IRQ_EN;
+	writel(val, priv->base + SE_IRQ_EN);
+
+	writel(priv->tx_wm, priv->base + SE_GENI_TX_WATERMARK_REG);
+
+	val = readl(priv->base + SE_GENI_M_IRQ_EN);
+	val |= M_COMMON_GENI_M_IRQ_EN | M_CMD_DONE_EN | SPI_ERR;
+	writel(val, priv->base + SE_GENI_M_IRQ_EN);
+
+	writel(0xffffffff, priv->base + SE_DMA_TX_IRQ_CLR);
+	writel(0xffffffff, priv->base + SE_DMA_RX_IRQ_CLR);
+	writel(TX_DMA_DONE | TX_SBE, priv->base + SE_DMA_TX_IRQ_EN_SET);
+	writel(RX_DMA_DONE | RX_SBE, priv->base + SE_DMA_RX_IRQ_EN_SET);
+
+	/* We always control CS manually, don't let the SE auto-toggle it */
+	val = readl(priv->base + SE_SPI_TRANS_CFG);
+	val &= ~CS_TOGGLE;
+	writel(val, priv->base + SE_SPI_TRANS_CFG);
+}
+
+static int qcom_geni_spi_probe(struct udevice *dev)
+{
+	struct qcom_geni_spi_priv *priv = dev_get_priv(dev);
+	u32 proto;
+	int ret;
+
+	priv->wrapper = dev_read_addr(dev->parent);
+	if (priv->wrapper == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = clk_get_by_name(dev, "se", &priv->se);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(se) failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&priv->se);
+	if (ret) {
+		dev_err(dev, "clk_enable(se) failed: %d\n", ret);
+		return ret;
+	}
+
+	proto = readl(priv->base + GENI_FW_REVISION_RO);
+	proto &= FW_REV_PROTOCOL_MSK;
+	proto >>= FW_REV_PROTOCOL_SHFT;
+
+	if (proto == GENI_SE_INVALID_PROTO) {
+		dev_dbg(dev, "firmware not loaded, loading now\n");
+		ret = qcom_geni_load_firmware(priv->base, dev);
+		if (ret) {
+			dev_err(dev, "firmware load failed: %d\n", ret);
+			clk_disable(&priv->se);
+			return ret;
+		}
+		proto = readl(priv->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+		dev_info(dev, "firmware loaded, proto=0x%x\n", proto);
+	} else {
+		dev_info(dev, "firmware already loaded, proto=0x%x\n", proto);
+	}
+
+	if (proto != GENI_SE_SPI) {
+		dev_err(dev, "Invalid proto %d\n", proto);
+		clk_disable(&priv->se);
+		return -ENXIO;
+	}
+
+	/*
+	 * SE-DMA is an inherent capability of the GENI SE core (mirrors
+	 * upstream Linux's spi-geni-qcom.c, which never gates SE-DMA by DT
+	 * or hardware version). Only FIFO availability needs checking here.
+	 */
+	priv->fifo_capable = !(readl(priv->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE);
+
+	priv->tx_fifo_depth = qcom_geni_spi_get_tx_fifo_depth(priv);
+	if (!priv->tx_fifo_depth) {
+		dev_err(dev, "Invalid TX FIFO depth\n");
+		clk_disable(&priv->se);
+		return -ENXIO;
+	}
+	priv->tx_wm = priv->tx_fifo_depth - 1;
+	priv->oversampling = qcom_geni_spi_get_oversampling(priv);
+
+	qcom_geni_spi_hw_init(priv);
+
+	return 0;
+}
+
+static const struct dm_spi_ops qcom_geni_spi_ops = {
+	.claim_bus	= qcom_geni_spi_claim_bus,
+	.release_bus	= qcom_geni_spi_release_bus,
+	.xfer		= qcom_geni_spi_xfer,
+	.set_speed	= qcom_geni_spi_set_speed,
+	.set_mode	= qcom_geni_spi_set_mode,
+	/*
+	 * cs_info is not needed, since we require all chip selects to be
+	 * in the device tree explicitly
+	 */
+};
+
+static const struct udevice_id qcom_geni_spi_ids[] = {
+	{ .compatible = "qcom,geni-spi" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_geni_spi) = {
+	.name	= "qcom_geni_spi",
+	.id	= UCLASS_SPI,
+	.of_match = qcom_geni_spi_ids,
+	.probe	= qcom_geni_spi_probe,
+	.priv_auto = sizeof(struct qcom_geni_spi_priv),
+	.ops	= &qcom_geni_spi_ops,
+};
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..41d5b921d1c 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -64,10 +64,18 @@ enum geni_se_protocol_type {
 #define SE_GENI_RX_WATERMARK_REG	0x810
 #define SE_GENI_RX_RFR_WATERMARK_REG	0x814
 #define SE_GENI_IOS			0x908
+#define SE_DMA_TX_PTR_L			0xc30
+#define SE_DMA_TX_PTR_H			0xc34
+#define SE_DMA_TX_ATTR			0xc38
+#define SE_DMA_TX_LEN			0xc3c
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
 #define SE_DMA_TX_IRQ_EN_SET		0xc4c
 #define SE_DMA_TX_FSM_RST		0xc58
+#define SE_DMA_RX_PTR_L			0xd30
+#define SE_DMA_RX_PTR_H			0xd34
+#define SE_DMA_RX_ATTR			0xd38
+#define SE_DMA_RX_LEN			0xd3c
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
 #define SE_DMA_RX_IRQ_EN_SET		0xd4c

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261006-spi-v6-1caa26821d6a

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

