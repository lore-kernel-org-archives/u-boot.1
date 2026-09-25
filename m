Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1469C98324
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9857460D97;
	Fri, 25 Sep 2026 14:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id keJYMVIthhjm; Fri, 25 Sep 2026 14:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6C9260DB9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346422;
	b=ALMWRd3VA9nCB7cxnQ9AGagDx7E06SuPuZ68hjhqiOfnizFFfK/YI3XBZJBuhVs86wxB
	 rB39OqXy75gBNECBuXN+8Jr+7ycidCkAHdH02Gf/dZMK+quTVz1tlbPhkmF+OUydbkR1J
	 iKZnOVdq9HHkau84DF591Ic25rsX0N1w8x8w3xarssvUfBTvyRNG+BIGkm+XyykYRV/Pl
	 yJxect9Hy1BTDut6FmlM7y5mPVpzfB4bAQ+Ym/UbfCxOKiJRIxqmH61qEOWGsEQapZcBh
	 7m8ZLAD20RSUPo/UKzRUswoFmmbHZehOfJDeXKI38RwkIm1ku0EB9RllNYeFmcpbFNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=byEX3BMkIhfaIT+GWIuDQRUuBqwzxUhkSYE1HeGHHWk=;
	b=GLfcGdwaqMo6/eAv4gg4bWNV3JosIkqODT3pziLUrYa44RsQ8+I6A3t1UaYcayBUqmZv
	 wxGTqh8vFQaejYzDvqczTtTF16JJlYPX69+q/jEwqB95P0g2auqIpDuYWaQ9XU27J0wft
	 alnCaW+i1miTU0lyG6XyKaANzivY766NLsD4XXmffD9TKYwTTHFQL7t6Yg9qAd39B6DqX
	 8HLsmlXdLErfrVC3yPTkps/g/yIYSVYxYxGPQjIBUifbZ5yBd247s0p4paw0Vr26G7WMD
	 YXvaLCUUp5mEG8ERVhXDsu6phutt9gO0FU88CxoWa6k7YeFiOyQQ5t4Y9m/ha4am9sQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=qti.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fb+Yaioz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346422;
	bh=byEX3BMkIhfaIT+GWIuDQRUuBqwzxUhkSYE1HeGHHWk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HqNI9GHaSc3RcyWj0cgbc1WCdxr/ZX5pjOWJx/MBKtD7XqSf+SwndbHOUZUdSM5Hw
	 nNIOl30G5qxU2ZmLKJvLUWYtXbb1E0u/7517bRXyEd9rYSOPaQy3NIy14CXG18b9xZ
	 E8kzJ6e8adLAPbd9AihIoZbsprNEaU88Va6JO5+wErmNOJqV8BTk0knLBquI6l5k7X
	 /kz4LlNhFwRv8TAvBdt7GeDH2abjpCN0N37v9tzEPdRC9vw0NsZXpRboMQqAky/cLt
	 6DUgM5z6IbLNmYhb1V/JY4hgcudY0ZunMEtwk3Uun+Ks07fgaY/xXopBEcPjvg1mcy
	 GTDc7M2bEweMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6C9260DB9;
	Fri, 25 Sep 2026 14:27:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 31C7AB00
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F01460D5E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ck_bjveQ7xk6 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02B0760C13
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341105;
 b=DzlIeOdWQ0ED95ooSea9N0HlAkNr3vVJ16kGVMeN22qg/baLZ1pDuiKzXdK66oknB0ZS
 8sDk0Ntkzz4SbEE917hn6ZnrhI8y1H6RFBYvzWmmby6KSh//V7ASMLllSnVwHsha4M4lv
 2xcZCocmFMKGDRri1zWjXi27uISzrgNgjoEKnLVEyMoNQi+mR74QZ7PAboolbRl4MVMSt
 BDUx56WrlMnWCb1TOuQ10pYLJmepbQdhRMOyBQQsxfpFnGVLINdWp2eQ/omWzkjc80Mut
 e5ENmmKhOkFpAXqZTGkLLQP0FYJ5YR8rdgINon1ueNErfksSA3igQ2o14PWc9lajACw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=byEX3BMkIhfaIT+GWIuDQRUuBqwzxUhkSYE1HeGHHWk=;
 b=Y9EEen9eKW0oiJxSTFylmk35Yyusl2oSmRT9hkk4D8YAgilKnVC6XDxf3c2hH/HCKBjJ
 ci8P6NEOed2XkgLYbPJRL3bemtVB/aEvVbwpeIU8Fh/0ADAoOaetijocbtFuUgOdRLqY5
 TVuRngrFFnP9rdvNPww5gNcZUaCLJNup87ySnJ6BEnZtv+Nvvg8eJMONOEbplpla2hiXm
 v0PdWE8e9LoJy83TG6QSV8X8TWjOlh/SFfWQdoR51fISfRo7gX7VQ2nxGNXN2N5x9okLB
 TcoumtKNUA4D8wkZnM+8LarGqZNY5J6+i/BHw17B7R1y4kafdby7ji57qfNNV9swBjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fb+Yaioz; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fb+Yaioz
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02B0760C13
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4Yd772911789; Fri, 25 Sep 2026 12:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=byEX3BMkIhf
 aIT+GWIuDQRUuBqwzxUhkSYE1HeGHHWk=; b=fb+YaiozER7hHZuBpSp170NzcrK
 hP4kX8xFjBOlLSNfiw+f7YKOceUnOYHFWWLgt2m3tql/WtMQpJqd3d+9vkuystBV
 yVvMPH8dfOcz5fKlROf2/X7quS6mNwprkiek6vO7lDufU/QK4k4W8dz9cNMuRT/E
 cBlvEU2rZsiYJ7IZYNhMtK3ggwyRzCfzYpV4wKrCCvW6K9y7ThH1+iD/ZOMh9TWf
 ka1uGHNDjrCV2TQcUQZLBA4FRdVwRSPa1Bq/s5lZDcZMlszYk9Os/fLZlt31qUsO
 zs9CFU0h0oEWiFjtXntDwP0hopKIwvJB0MU4WqHiR6kR3gIQWya1DwFrPuA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm51jpf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwEId496547; Fri, 25 Sep 2026 12:58:14 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 68PCwDBQ496535
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id C54CA61E; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 09/12] mmc: msm_sdhci: make tuning callbacks optional
Date: Fri, 25 Sep 2026 05:58:06 -0700
Message-Id: <20260925125809.1360030-10-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: kZr4g9Q7pUa-qwzhA_SfMAtXZa9A6Zny
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=AWXtbog4CBKr6sa7RggA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX/6VtCqh3dkuI
 Dz9925mIeR3NptQVsjCbb/mFhIK4cor5jM4vmEX8bVBu4wbNX9LBM73W6YVscrklFU/MgM3RVLR
 BgrwNWsTNgMRQrLc5UsZ3pl2p/+HtLY4WgAz/4gpYwNpMdTifxfFP/dsZt5eFvbSr4gaQjoJnsJ
 hkP+peSsSWzPEX+p7sfh6X4zzdU6lfo8aHOjyp7gfjComMnaSlgXdbAjyyXfmIutybOYdaTnUkG
 4STKwoHYU7yEcUJV/o7jmBhfioPjeldC+sw+guAgAtXl2niL+GuYiV8H3Hhm5R95DMQFvc1FvOw
 PgqotXz3j1Cnv4xe74XinVnJIyoqDKl+W7kvZovcm4T1/vq8THpbYNnEUkOPRrvPNrYhXhsKlQj
 /lLROpqnQ4PJM78W4gKd8KkA0w+G4MhkfRhFceBC9SS9coFuXxkKLVyy6ibjksYCSZFvShBy0IE
 6oz+z/7tJX8KrddpHDA==
X-Proofpoint-ORIG-GUID: kZr4g9Q7pUa-qwzhA_SfMAtXZa9A6Zny
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX2pdprW3JbEb6
 bFwn5AWwXkUZ4YBFtfCT4ZPBBo6kd1wOVK/4IptncLXjsehzdeQNGpLNJe11bbPD6yTzw0WsOIB
 XaTwoyw9eB32n9cdQfKnPKySpJ8R9jk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
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

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 71a5aa15958..155bc2ef379 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1

