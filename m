Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20228C5CFC1
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9C0840831;
	Wed, 12 Aug 2026 01:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikGHpC748HE3; Wed, 12 Aug 2026 01:12:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1C5E4083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497170;
	bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LmP82wDnGuOYz+j9Q7yJ5temB0bwCEBXVyfvkgcF4F2Gz6PJefffBjtZfOJlloa4Y
	 H+WmmUUcSUe7H+Z5plYvnov1z4W5we9AOhKTITWdr+L9afeCNBWhIShxOXVtn29GIc
	 AzRso9Ec9EXaCym5MbEvlh+RQZbHs4cQjXCMKNWKUJe4D+eGqKrR4yXMuyWnqqRb1C
	 n/Qr/2EcS2ABKv8kC2eKp8nW6y1KKJDdmx76ynhPMMKm9sJt4qMYxTHSjBYxTlYJd1
	 g4unZ370Sp6Lakf2V3FNmDIHI0apQMveMJ8I2bGSjQqEqiJYAS/TLqtumT+CqyQSfV
	 DpFTuaxJbipyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C5E4083B;
	Wed, 12 Aug 2026 01:12:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58DCA49B
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EF454019B
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Zr1oNSdc8Et for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 26F7540394
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26F7540394
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26F7540394
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNGvGc2070952
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:47 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc3c32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso307135a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497166; x=1787101966;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
 b=T0dfm7QyGNZuGyAWQxnSCUTUa4CojoHae9fLf60vq3RlV+aC/9SJTeWMwjcY+wI4QC
 BELAJNIFTy29REpycYaZXv/L9uRjLQZfLmNQiIS9wHvPA0v5MAHl8i+QHaQSxvK4Sb/E
 +1EGkvWc993haFk5AyiGwx8qEqi332bAxIXKl+QcDgy8fMyMUiejXm0Vp7nfRD4r196X
 6T4H9okAmB7gXXrHQKBA6OFFsp1uhz8vrTPfeio4eBe8k8n6IGVDZV30IuW7lXDnIlEQ
 mUBBVsQfbqQIASy9Ix9nv96Ovq4djrQx3JENedLcXJNbvAUwd0utW9rYTJUJUb6zdZGs
 iVEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RryQTYNg7IS2G7zHepINvJy2rOidSLqON8zC7up/Pad4ndSn3K6BwlXcNW4l1O67FyHkE7bjls=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxl4RxV9SJdDYyKzxSM6R5nWPlNtRgsfq10KcR4fk9aw3wLL0S7
 jvTyYpUA5nGGTi1nW+v7WilxxAT8WQIf1wyN1/rf8VF1ew2urLHS4bo7sY9e3qHyfUnFCg52Fmq
 8feqZ82ac4ORuFMCadawlgXg52gwi0YaJeJ4mUQoSPTFs1vFmHv+/vBcloo8+cguY/RgFtlE=
X-Gm-Gg: AR+sD13ZVvTrG/647/whzCnTbSFYPI1UbJFaUm4wyHGEFolZ2KLcGo28VVMuNF637Bh
 QnGDaFHejMQluCL9NiU9PUfk5pV3NYdLhNDdDHv4ArubiP5lyz79ehJAcyIMGT01El5Y2MELJNR
 Q41kzKlmlOWrBBqOeaUCQwgfRtylvrnXwu74ZddU+PuQCTNUmhT7pq1VZKlzmS83KOw4Ro2OujL
 ohieZw/3eS0P247gs6eAuoXOhaVlnqwYGAREbgeILnKISfgUK+GC22Ahl0rqYopUhXZmdmHcnfF
 YbZc7JejblmtrlUl+K9nq6m205wSYyDTSsLe3FomOSvHQCDeLs1vsnri/HTemrivtcz2/oJH3Fd
 r5AklHuI4yiHHKDm8B6pLy4gp4u05Xm64NlEcpwH7kMA3Zih2oVnH4hV4HBKJAQRQbox4oYPqLc
 K1Nuxzk5/UnDeCv+dalKZGEzTKvIfM
X-Received: by 2002:a05:6a21:e8c:b0:3c3:a31b:3949 with SMTP id
 adf61e73a8af0-3cc3f5ec25bmr1184881637.11.1786497165833; 
 Tue, 11 Aug 2026 18:12:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8c:b0:3c3:a31b:3949 with SMTP id
 adf61e73a8af0-3cc3f5ec25bmr1184818637.11.1786497165402; 
 Tue, 11 Aug 2026 18:12:45 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:45 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:42:04 +0530
Subject: [PATCH v2 6/7] arm64: dts: monaco-evk: Force vreg_l8a always-on to
 protect UFS VCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-6-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=1227;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=FiwIxCY0i/8xVvpAD6Hnjv8hNL6PUsBBG58wx4+CCtg=;
 b=U0S0AOhf5+0PnPGg8PwHVNiWV90V4wYciW49N0BvWFRDB5WyKgocwPFxDLrfYkA0/drtoPDyT
 VlF5I5kdN48AEI86IsUJOQ69czfINohE5bk+qTBBPBRRjKc5v3bxGg8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXzwYRmm+rVSZ9
 +G4UBDxsEDvYcFE4okR8E6++DXyg3mGMfxsydZVzGMW/ps/8yXerKh57qMdNnQM/oGRH5gxQl68
 xLbt43h/Zm3vuaH93hRHlN5TbkFdEik=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXwUkms2egwfvy
 OSUT3FtGsbPW9sjLeZPxHz9MMIJavXk2NYSH1VyJpLku+a3yrZsPRUtA6kwDo5vdx9UYNX4TacJ
 hfNaMgODC6X6cxDApKp2xnpv1YrGoHvW6YLWXI43IycAA2FD7Rq6pPQIofMxn5npPSObYKXjl7g
 togqhcjdVKTx9s7vppZV0ZmciFPYrWQJDRnP5eWP1yNgiXuQFJ4kqR/QeyfVeAfeYi+CRBGJtCA
 BKgPIJpmbJY3o/lTV+7AWq7mKB4Hg/+GCNkdBj7/3sgi4ZV6/BSAF39crlDs5FmIsRGexW5Lbyp
 2QY0lIY3BkHQ/zkroztMjJoApBGYnbBqoDUWwhTb8D02Ysc9sPVm8nQP6xx35mDR7cIEdX7PQnE
 a5M7/usU1od88PSNpX4quPkaYZhWerkbSRyrcoRnqaM4NOJH3iiZjleb854HJtB4ykviedpoIJN
 f5Y4VfvIZBhzovSgK1A==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7bc88e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qScA5Q7lTU9RTaJaGUcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: h6SQOO4cktwjBAv-tENu60g7-Yd76OOD
X-Proofpoint-GUID: h6SQOO4cktwjBAv-tENu60g7-Yd76OOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=; b=ACx7kMz27WrzlpFv
 WV42v5VEQ/GsEf6MlgInKwxmjfOv4zC/FgykL+HVv/BmTMIHwANnx3M2tyW3LM5g
 OO6Zh1Lk1lrk4hHVhAu7s/AZKSfqRi5STHmoo88nydzON9GHV1GjnHCSkYJ5ix9g
 7voo0Rp5rwkPg/Ksufl29zj3sTXBfO8ojs3Xu/8WW37Y7jJhslnSiVw8Ai7U/+pl
 0Ox1GHSpKgcfd/ObRnh6ozgXFvjoq5/gMGti8x1jU3aKHOM6APmUsGCZH+L64GsX
 MIy+OrhFqWjhS6yY8QKycOEdn/32cqW2KbsFXibN7Njjwo2xXuyYaAW+7UlhjFWX
 klXlAw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497166; x=1787101966;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoNQ7V8WoTkq6DP/Oxia9iRH/gaGhsaMeCNUcoAflyU=;
 b=FFZ2v9aGWaB7ENG9jumodXz+SqgzOG27PJ9ZS0OktPiNriQNmscQwwDbsTec6pwW0F
 zKIRGOoDnb5FfdEaueDSXSeuUFN0eU3thC5N/lQYyED+jM5L64TXXqc+r4rSwIZ2zjHE
 jAgzw5oRhqHt4zU0rnzbftIdcrstZPQOBHzdU57vznbILJi1hFHaIYheFVFz7a9Ij94c
 6ksK8Ulmv+i8uT7r/uyl9u4kSpr50jCi+lzkMsDk/z7FFth6uIIYzDjXQj8XJFvk6E+9
 evaY2j9bqggtxOHHWUmAo09NAq4IeDdvs6QI9rqyZ/p4jtnelhaZQ1qddxYasdyZpR/r
 aScQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ACx7kMz2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FFZ2v9aG
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

vreg_l8a is the shared VCC rail for UFS (ufs_mem_hc vcc-supply) and
eMMC (sdhc_1 vmmc-supply). UFS holds no regulator vote of its own in
U-Boot, so nothing stops other consumers from disabling the rail
while UFS still needs it.

eMMC's power-cycle runs after UFS has already linked up and started
transferring data. Its power-off fires a real disable vote on
vreg_l8a, glitching UFS VCC while the link is live. UFS has no
recovery from this: every following command fails (OCS errors, UTP
timeouts, "Card did not respond to voltage select! : -110").

Force the rail always-on so the disable vote is rejected in
regulator_set_enable() (-EACCES) before it reaches the RPMh driver.
eMMC is non-removable and does not need a real power-cycle.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
index 5520d111864..8e9102eae4d 100644
--- a/arch/arm/dts/monaco-evk-u-boot.dtsi
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -34,3 +34,7 @@
 		};
 	};
 };
+
+&vreg_l8a {
+	regulator-always-on;
+};

-- 
2.34.1

