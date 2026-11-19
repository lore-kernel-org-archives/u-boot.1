Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF61606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SfF4gMNO;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jov0TGwi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KxCBre4E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A10760A52;
	Thu, 19 Nov 2026 06:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvyFb01VWDi3; Thu, 19 Nov 2026 06:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 631E160AA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068594;
	b=ZCulJtqAP/HjvdSmlC/2jP2VO46bpJK7grrLA6Q3KoG6nt39BOdzPbwUENKGgidDluvC
	 oEyNPGDONAHqHjCn7NCMnbfVvwTgEnIXr4OyIfuafcNZxP/HRYTOm4C3HJGgM+z4uJBQ/
	 gCbD19UDqRIRFhXlPSIQUxClqgG6dkV1L5yPwqHYUVG1leQGhbmBXxUq0mVrcmoT2pjQZ
	 +qCuyOrltvmya3RBsmZBWgzFgoDqvSorIn7Ix+40niIlZ4Epi9FPDk6tfgbRLATLwdkAm
	 WyCkJ0IA/aYGAI1So/h0T5sK0bjXePfycr3YrbbcEfxaD2ortBuywHw3MkaUfxgoxeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QbjsfG0lB1ob/1AeE1noHnDJSuKbvy+IGJXZaGBMXNs=;
	b=mB6dwsbcs3/cbvJKAYEfb2wVSGvvvIYYZqb54IQ+sjvlyUreo0NVqcBrJWXT/lPwCkGf
	 CyGFki1Xpzywb/oo/UMMTed2ADwFFJWef75fLl5SfNUQgKaoFyxOl3NjpP63B4UlrVDp0
	 NAjGzf52pgeWccS93zrx4eDnYB4MV4yf+/9zuw4xxrAH82UWkHrby146/LTAsjO81OuV2
	 4CkVPZBWt9ckLcjyWpPZdfywoorwzze9qIWjnvUeXjIU++Yl+DHl6fijRqw4w3ZVSGiMM
	 4a8vD0aHbCAMO/YPbUwiGi2jXK2MwWymY5yAuH/JAGcvT65/pkpxYl1OHnfuwCTh1yw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068594;
	bh=QbjsfG0lB1ob/1AeE1noHnDJSuKbvy+IGJXZaGBMXNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SfF4gMNOJfZgfXUafg2vJuuJrAyylfw4TEO9VarUssji9Q9Sv/8Zih9z57jf1NVbh
	 KQ86C6pL+4MNg37Xhxk3hwQGoNcvBCbozdNQNgF+vNeAbEN1LJE0ivF+it1N/NIIpA
	 2u7awa+t7rqhmPfTs+v8jJ2+SLpVBf09MqZnfm/8w8eY23pnnXHX3BszGfyI12sLsM
	 xQd48GE6F1UsKcV4NUbY7EXF306RlfDPUG2xqR+Q87jjGuTmNiC7z4M5rcu+igZfw8
	 PamNSYGTVvXP3gDlYTZGvkZMrG1X2Pha4BKQMWdvgW2ejg40UIvcf9/VbPdZ6o1usw
	 uoIWlxMs6uBTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 631E160AA1;
	Thu, 19 Nov 2026 06:09:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 653C4E22
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BB0F812B1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTW2iIGgYGgc for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DA2F8110A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Jov0TGwi; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KxCBre4E
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DA2F8110A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1BPsa936395
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QbjsfG0lB1ob/1AeE1noHnDJSuKbvy+IGJXZaGBMXNs=; b=Jov0TGwiaGNORHq5
 9Er2ccSc+ZoRgS9oUlmQYuXqYlpVugqFTqGQCkpRV0izkXBxIIHMTFcBSjdbswkC
 smwmW2O3tsawQUsTW/wqdwCpX6+jfnUEZDUs3jPf4HtU38EUMVzrw1hlriZNO5qX
 7Sn/ukZc8xoXkkb3fiqMkDZbYNuU2W/eg50uGiKOSNhXN2l5GMJ29pYbJl8uN5M5
 quRTTz1xm20Bucj/jFy1n+oR7+AncW+Ytvrmzqj2BntnfAjlh1Jh0wtN0zlu9Q0G
 53ulKLZw24sx8WSEAv5vh/wckRoYrnuHLTwqInk0yvNQrC2BJeKLLoZG1Ra3uXKy
 NtrMsg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcs6cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:09:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-38131260a5dso4909224eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068588; x=1795673388;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QbjsfG0lB1ob/1AeE1noHnDJSuKbvy+IGJXZaGBMXNs=;
 b=KxCBre4E47o91VOlZXUdEbz40hKxLIrWtNmWv+6rWKlPR5V4i9LyPJtOKBdTMl5ZrZ
 G6b1rPkPtzwXWLOG9mA2oC4q3Wd5fwl0BwMMb7U2pCcAApUEY42YLWKaO22YDQ1SMl9y
 muEbhHU2LpPRJ9l23uXNuGDe6eOX2m3kl6ddQOkS4a437plgIwlm71YBCUd+qfD14kq3
 spz2R0BSx0wHCKbtOqF1ENG8vJTxOe/kUz1nGRp2gfs2mOpkACqcjFQmgE9uwdRGLqos
 nPVBqMyT9jqgQxMEY4gBPGVapGsRmxL/QR7o1kUFIxVImx0QhCl4fwoBjZflhhPYgBCD
 06dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068588; x=1795673388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QbjsfG0lB1ob/1AeE1noHnDJSuKbvy+IGJXZaGBMXNs=;
 b=BIOlZ5YuTVGiz95lNWTb0mP2wlGNZ8Rf9DMzGZGRakclG2nFpg5ey+rgrb26YT84K3
 JZdnN7s6HFK5ES7XySnIj1UnMubdzzwkEYtWciCkaZQ9kHkKxx6KNI1N1e+YceC1sjKS
 fHGqa/nVqjlTz+Z/EWmU7UqMfX8oAkHMfkt+YZ1ejn8sweC/ZnjtVg183pXosz2F+3Tu
 ObNC6JQCXX9ymX7HWv0EIF4nP/izZAz/zwO44Dhebctsnzx4FueL2V+LOqbaWLy9/Sh1
 xtMTNP9Zgkdk0BFB6Dumeep28gAKrvpndG6UubjBNT7B1JriXRipjgn3ae8BGIts/g57
 DFjA==
X-Gm-Message-State: APuU4Z+vf0fSfE88wfq2aJ+zlk3tmjtHUOaKFT9QJiqkhqSx69UCyLre
 6UYJfZ8/r7TDwAX3dyt6TkHz42SVt3JefluiTuDPHR0SVxSfmITyzgJKkrFFX7rpwEXlARO9Z8Q
 u1adsaqdM40kcMFdrb2/YZvL1M3n7xaJKc5bv0X+P6P5zjs+00w9WvD6H2DeuymU9Y3Xql6M=
X-Gm-Gg: AZFdTZekntOvrh7jILT3/7H9ObTaQVnX7s1ksQGM1o6KcSOGgBWVE+sCzzhwFZyIxkt
 L/+S9xVzFJjN3ObQJ1adJfZ50rSr20RKUCRmSmwhgpCrsQApM+Yw6gTv1bRA1mkIQp/p4mR76U9
 nsnI9AW2PCSccwToU63GhEDPuRZpsM+OxboQHefn+PinyCO6V1ovU0kDJhsO3jIETbA+PzXIsDM
 uazjL88XLw17JG0zYdqFwx/zB0tiZ2ujpcfsCXwOsTV2DdGWXIkvtKj9AZSpQq47HywlbePkbKx
 e2PnhbBPzofxXCDMvGT1YYFf8nMN9CA7BaRntPVYAQCxl8wrSkLzJFp9sSu2pIEL9k1KtJHTrNE
 Io1pXs9qITtPxr2YoP04YMl209tXla1JACEMAbRyLafAZmZ0KGTpawri3cN6PC1WHLomLzwF/ID
 DZkTwozyMG7BItA7nroIkyGA5+u+tS5PXs5/KaLyQX5phv4OTdLw/sRywpwGpdM7BCp1hA016NH
 xYQpA==
X-Received: by 2002:a05:7301:8613:b0:36f:550f:bb0d with SMTP id
 5a478bee46e88-3827d71f00emr4783023eec.5.1795068588027; 
 Wed, 18 Nov 2026 22:09:48 -0800 (PST)
X-Received: by 2002:a05:7301:8613:b0:36f:550f:bb0d with SMTP id
 5a478bee46e88-3827d71f00emr4783011eec.5.1795068587486; 
 Wed, 18 Nov 2026 22:09:47 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:09:47 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:39:17 +0530
Subject: [PATCH 2/5] usb: tcpm: Add Qualcomm PMIC Type-C port driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-qcom-pmic-typec-v1-2-d197e6d7da5a@oss.qualcomm.com>
References: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
In-Reply-To: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Yixun Lan <dlan@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Dave Klotz <DaveWK225@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=13322;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=AtGff+c59cI+jN41Rj07pWyRGSVgy4U3LxBltllhDnA=;
 b=dSgRKq3wc+mbdvT+W1F5c1e3MU+iiuIj7Ekp4aqoNxwnz2IJUa0KFiLfUiSEMlonOq57oUYJp
 6Rk6R96rduOADv3jdrM+HPi5CXdhBSqDPHNSs/mT/ubQNABk+dDF0Ij
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: _jrCGXCye9_tDOvCJzw_HgQN-O1JZgBe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX+oaxKYRfuaKI
 +Ec2daJ2vs9EONlJCPVhMEHzFV0pHGhmrts5QD8xyPLI8owT9PDNwWqRIfRvT2GNvRTSykCp4cW
 iA5sJN4SfzJaPV2GOSn6rGBXM2MxGIQ=
X-Proofpoint-GUID: _jrCGXCye9_tDOvCJzw_HgQN-O1JZgBe
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afe92ad cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ravqU0Kxx93UXrZFX_QA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfXxKOxv9VN040a
 727b428oQTk7477XAeNR/Kdi6Omnh7A40OsZzKVmbeFRyV1GPfmi1hnRTmsPMnc5ym+COpsjZZT
 mUSv9c9uCUzf/Opkze4itgTDXskHfJ0IET7RHaSc3IYEieGSk/xRIYlw5GCb5tN1l5wPJKnh07I
 MDLm7hZIAeyE8bCms61/xfAg9OPBhKDAtFvvg8I8D7jl3j9CQJ2q5MtbZDm2GKZR08bDaH0tfFz
 1f/aB5kS3rZmzf0rR+v+xkv7xe7/RePy3rgW/mH+AtX6CSn1vecWR0uWkH/i0M6sRxV0sTzRzeQ
 tzIJzdSswsQBF4P580BlrycnCRS+Jz4Fe6ncwBmzCnXerSWCVEq37DeKOKmTxbyAPWbASlWbYAk
 sJ0m9O7wTwaXHUQ8IbzANNYPeceBXTCFhaIyH6guCGpScoxc3Q57uZ9exhC7G/ABb7YaGeCHOLV
 abTd90LhzkLR9YzLPcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a TCPM driver for the Type-C port block found on Qualcomm PMICs
such as PMI632 and PM4125. It handles CC attach detection and VBUS.
There is no USB PD support.

Taken from Linux commit a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC
Type-C driver").

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/tcpm/Kconfig           |   8 +
 drivers/usb/tcpm/Makefile          |   1 +
 drivers/usb/tcpm/qcom_pmic_typec.c | 456 +++++++++++++++++++++++++++++++++++++
 3 files changed, 465 insertions(+)

diff --git a/drivers/usb/tcpm/Kconfig b/drivers/usb/tcpm/Kconfig
index b1ea7253720..5313d9a86bc 100644
--- a/drivers/usb/tcpm/Kconfig
+++ b/drivers/usb/tcpm/Kconfig
@@ -14,3 +14,11 @@ config TYPEC_FUSB302
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
 	  Type-C functionalities.
+
+config TYPEC_QCOM_PMIC
+	bool "Qualcomm PMIC Type-C port driver"
+	depends on DM_PMIC && DM_REGULATOR && TYPEC_TCPM
+	help
+	  Driver for the Type-C port block of Qualcomm PMICs such as the
+	  PMI632 and PM4125. It provides Type-C attach detection and VBUS
+	  control for the TCPM. USB Power Delivery is not supported.
diff --git a/drivers/usb/tcpm/Makefile b/drivers/usb/tcpm/Makefile
index 668d33155bf..1849f662882 100644
--- a/drivers/usb/tcpm/Makefile
+++ b/drivers/usb/tcpm/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_TYPEC_TCPM) += tcpm.o tcpm-uclass.o
 obj-$(CONFIG_TYPEC_FUSB302) += fusb302.o
+obj-$(CONFIG_TYPEC_QCOM_PMIC) += qcom_pmic_typec.o
diff --git a/drivers/usb/tcpm/qcom_pmic_typec.c b/drivers/usb/tcpm/qcom_pmic_typec.c
new file mode 100644
index 00000000000..f4b9cf1d5e5
--- /dev/null
+++ b/drivers/usb/tcpm/qcom_pmic_typec.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Linaro Ltd. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <time.h>
+#include <dm/device_compat.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <usb/tcpm.h>
+
+#define TYPEC_SNK_STATUS_REG		0x06
+#define DETECTED_SNK_TYPE_MASK		GENMASK(6, 0)
+#define SNK_RP_STD			BIT(3)
+#define SNK_RP_1P5			BIT(2)
+#define SNK_RP_3P0			BIT(1)
+
+#define TYPEC_SRC_STATUS_REG		0x08
+#define DETECTED_SRC_TYPE_MASK		GENMASK(4, 0)
+#define SRC_RD_OPEN			BIT(3)
+#define SRC_RD_RA_VCONN			BIT(2)
+#define AUDIO_ACCESS_RA_RA		BIT(0)
+
+#define TYPEC_SM_STATUS_REG		0x0a
+#define TYPEC_SM_VBUS_VSAFE5V		BIT(5)
+#define TYPEC_SM_VBUS_VSAFE0V		BIT(6)
+
+#define TYPEC_MISC_STATUS_REG		0x0b
+#define SNK_SRC_MODE			BIT(6)
+#define TYPEC_VBUS_DETECT		BIT(5)
+#define CC_ORIENTATION			BIT(1)
+#define CC_ATTACHED			BIT(0)
+
+#define TYPEC_MODE_CFG_REG		0x44
+#define EN_TRY_SNK			BIT(4)
+#define EN_SRC_ONLY			BIT(2)
+#define EN_SNK_ONLY			BIT(1)
+#define TYPEC_DISABLE_CMD		BIT(0)
+
+#define TYPEC_VCONN_CONTROL_REG		0x46
+#define VCONN_EN_ORIENTATION		BIT(2)
+#define VCONN_EN_VALUE			BIT(1)
+#define VCONN_EN_SRC			BIT(0)
+
+#define TYPEC_EXIT_STATE_CFG_REG	0x50
+#define SEL_SRC_UPPER_REF		BIT(2)
+#define USE_TPD_FOR_EXITING_ATTACHSRC	BIT(1)
+
+#define TYPEC_CURRSRC_CFG_REG		0x52
+#define TYPEC_SRC_RP_SEL_330UA		BIT(1)
+#define TYPEC_SRC_RP_SEL_180UA		BIT(0)
+#define TYPEC_SRC_RP_SEL_80UA		0
+
+/* CC debounce time after a mode change */
+#define CC_DEBOUNCE_US			2000
+#define VBUS_SETTLE_TIMEOUT_MS		250
+
+struct qcom_pmic_typec_priv {
+	struct udevice *pmic;
+	struct udevice *vbus;
+	phys_addr_t base;
+	bool vbus_enabled;
+	u32 last_misc;
+	unsigned long debounce_end;
+};
+
+static int typec_read(struct udevice *dev, unsigned int reg)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+
+	return pmic_reg_read(priv->pmic, priv->base + reg);
+}
+
+static int typec_write(struct udevice *dev, unsigned int reg, u8 val)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+
+	return pmic_reg_write(priv->pmic, priv->base + reg, val);
+}
+
+static void typec_start_debounce(struct udevice *dev)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+
+	priv->debounce_end = timer_get_us() + CC_DEBOUNCE_US;
+}
+
+static int qcom_pmic_typec_get_connector_node(struct udevice *dev,
+					      ofnode *connector_node)
+{
+	*connector_node = dev_read_subnode(dev, "connector");
+	if (!ofnode_valid(*connector_node)) {
+		dev_err(dev, "'connector' node is not found\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int qcom_pmic_typec_init(struct udevice *dev)
+{
+	int ret;
+
+	/* Configure VCONN for software control */
+	ret = typec_read(dev, TYPEC_VCONN_CONTROL_REG);
+	if (ret < 0)
+		return ret;
+	ret &= ~(VCONN_EN_SRC | VCONN_EN_VALUE);
+	ret = typec_write(dev, TYPEC_VCONN_CONTROL_REG, ret | VCONN_EN_SRC);
+	if (ret < 0)
+		return ret;
+
+	/* Set CC threshold to 1.6 Volts | tPDdebounce = 10-20ms */
+	ret = typec_read(dev, TYPEC_EXIT_STATE_CFG_REG);
+	if (ret < 0)
+		return ret;
+
+	return typec_write(dev, TYPEC_EXIT_STATE_CFG_REG,
+			   ret | SEL_SRC_UPPER_REF |
+			   USE_TPD_FOR_EXITING_ATTACHSRC);
+}
+
+static int qcom_pmic_typec_get_vbus(struct udevice *dev)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+	int misc;
+
+	if (priv->vbus_enabled)
+		return 1;
+
+	misc = typec_read(dev, TYPEC_MISC_STATUS_REG);
+	if (misc < 0)
+		return 0;
+
+	return !!(misc & TYPEC_VBUS_DETECT);
+}
+
+static int qcom_pmic_typec_set_cc(struct udevice *dev, enum typec_cc_status cc)
+{
+	u8 currsrc;
+	int ret;
+
+	switch (cc) {
+	case TYPEC_CC_OPEN:
+	case TYPEC_CC_RP_DEF:
+		currsrc = TYPEC_SRC_RP_SEL_80UA;
+		break;
+	case TYPEC_CC_RP_1_5:
+		currsrc = TYPEC_SRC_RP_SEL_180UA;
+		break;
+	case TYPEC_CC_RP_3_0:
+		currsrc = TYPEC_SRC_RP_SEL_330UA;
+		break;
+	case TYPEC_CC_RD:
+		/* Sink: nothing to advertise */
+		typec_start_debounce(dev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	ret = typec_write(dev, TYPEC_CURRSRC_CFG_REG, currsrc);
+	if (ret < 0)
+		return ret;
+
+	typec_start_debounce(dev);
+
+	return 0;
+}
+
+static int qcom_pmic_typec_get_cc(struct udevice *dev,
+				  enum typec_cc_status *cc1,
+				  enum typec_cc_status *cc2)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+	enum typec_cc_status cc;
+	int misc, val;
+
+	misc = typec_read(dev, TYPEC_MISC_STATUS_REG);
+	if (misc < 0)
+		return misc;
+
+	/* The PMIC is still debouncing a mode or Rp change */
+	if (priv->debounce_end && timer_get_us() < priv->debounce_end)
+		return -EBUSY;
+	priv->debounce_end = 0;
+
+	*cc1 = TYPEC_CC_OPEN;
+	*cc2 = TYPEC_CC_OPEN;
+
+	if (!(misc & CC_ATTACHED))
+		return 0;
+
+	if (misc & SNK_SRC_MODE) {
+		val = typec_read(dev, TYPEC_SRC_STATUS_REG);
+		if (val < 0)
+			return val;
+
+		switch (val & DETECTED_SRC_TYPE_MASK) {
+		case AUDIO_ACCESS_RA_RA:
+			cc = TYPEC_CC_RA;
+			*cc1 = TYPEC_CC_RA;
+			*cc2 = TYPEC_CC_RA;
+			break;
+		case SRC_RD_OPEN:
+			cc = TYPEC_CC_RD;
+			break;
+		case SRC_RD_RA_VCONN:
+			cc = TYPEC_CC_RD;
+			*cc1 = TYPEC_CC_RA;
+			*cc2 = TYPEC_CC_RA;
+			break;
+		default:
+			dev_warn(dev, "unexpected src status %.2x\n", val);
+			cc = TYPEC_CC_RD;
+			break;
+		}
+	} else {
+		val = typec_read(dev, TYPEC_SNK_STATUS_REG);
+		if (val < 0)
+			return val;
+
+		switch (val & DETECTED_SNK_TYPE_MASK) {
+		case SNK_RP_STD:
+			cc = TYPEC_CC_RP_DEF;
+			break;
+		case SNK_RP_1P5:
+			cc = TYPEC_CC_RP_1_5;
+			break;
+		case SNK_RP_3P0:
+			cc = TYPEC_CC_RP_3_0;
+			break;
+		default:
+			dev_warn(dev, "unexpected snk status %.2x\n", val);
+			cc = TYPEC_CC_RP_DEF;
+			break;
+		}
+	}
+
+	if (misc & CC_ORIENTATION)
+		*cc2 = cc;
+	else
+		*cc1 = cc;
+
+	return 0;
+}
+
+static int qcom_pmic_typec_set_polarity(struct udevice *dev,
+					enum typec_cc_polarity polarity)
+{
+	/* The PMIC detects the orientation itself */
+	return 0;
+}
+
+static int qcom_pmic_typec_set_vconn(struct udevice *dev, bool on)
+{
+	int misc, ctrl;
+	u8 mask, val;
+
+	misc = typec_read(dev, TYPEC_MISC_STATUS_REG);
+	if (misc < 0)
+		return misc;
+
+	/* Set VCONN on the inversion of the active CC channel */
+	if (on) {
+		mask = VCONN_EN_ORIENTATION | VCONN_EN_VALUE;
+		val = VCONN_EN_VALUE | VCONN_EN_SRC;
+		if (!(misc & CC_ORIENTATION))
+			val |= VCONN_EN_ORIENTATION;
+	} else {
+		mask = VCONN_EN_VALUE;
+		val = 0;
+	}
+
+	ctrl = typec_read(dev, TYPEC_VCONN_CONTROL_REG);
+	if (ctrl < 0)
+		return ctrl;
+
+	return typec_write(dev, TYPEC_VCONN_CONTROL_REG, (ctrl & ~mask) | val);
+}
+
+static int qcom_pmic_typec_set_vbus(struct udevice *dev, bool on, bool charge)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+	unsigned long timeout;
+	int val = on ? TYPEC_SM_VBUS_VSAFE5V : TYPEC_SM_VBUS_VSAFE0V;
+	int ret;
+
+	if (priv->vbus_enabled == on)
+		return 0;
+
+	ret = regulator_set_enable(priv->vbus, on);
+	if (ret)
+		return ret;
+	priv->vbus_enabled = on;
+
+	/* Wait for the transition to vSafe5V or vSafe0V */
+	timeout = timer_get_us() + VBUS_SETTLE_TIMEOUT_MS * 1000;
+	do {
+		ret = typec_read(dev, TYPEC_SM_STATUS_REG);
+		if (ret >= 0 && (ret & val))
+			break;
+		udelay(100);
+	} while (timer_get_us() < timeout);
+
+	if (ret < 0 || !(ret & val))
+		dev_warn(dev, "vbus vsafe%dv fail\n", on ? 5 : 0);
+
+	return 0;
+}
+
+static int qcom_pmic_typec_set_pd_rx(struct udevice *dev, bool on)
+{
+	return 0;
+}
+
+static int qcom_pmic_typec_set_roles(struct udevice *dev, bool attached,
+				     enum typec_role role,
+				     enum typec_data_role data)
+{
+	return 0;
+}
+
+static int qcom_pmic_typec_start_toggling(struct udevice *dev,
+					  enum typec_port_type port_type,
+					  enum typec_cc_status cc)
+{
+	u8 mode;
+	int ret;
+
+	switch (port_type) {
+	case TYPEC_PORT_SRC:
+		mode = EN_SRC_ONLY;
+		break;
+	case TYPEC_PORT_SNK:
+		mode = EN_SNK_ONLY;
+		break;
+	case TYPEC_PORT_DRP:
+		mode = EN_TRY_SNK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = qcom_pmic_typec_set_cc(dev, cc);
+	if (ret)
+		return ret;
+
+	/* Force it to restart at least once */
+	ret = typec_write(dev, TYPEC_MODE_CFG_REG, TYPEC_DISABLE_CMD);
+	if (ret < 0)
+		return ret;
+
+	return typec_write(dev, TYPEC_MODE_CFG_REG, mode);
+}
+
+static int qcom_pmic_typec_pd_transmit(struct udevice *dev,
+				       enum tcpm_transmit_type type,
+				       const struct pd_message *msg,
+				       unsigned int negotiated_rev)
+{
+	/* No PD PHY support */
+	return -EOPNOTSUPP;
+}
+
+static void qcom_pmic_typec_poll_event(struct udevice *dev)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+	u32 changed;
+	int misc;
+
+	misc = typec_read(dev, TYPEC_MISC_STATUS_REG);
+	if (misc < 0)
+		return;
+
+	changed = misc ^ priv->last_misc;
+	priv->last_misc = misc;
+
+	/* A mode or Rp change was debouncing: report the result now */
+	if (priv->debounce_end && timer_get_us() >= priv->debounce_end) {
+		tcpm_cc_change(dev);
+		return;
+	}
+
+	if (changed & (CC_ATTACHED | CC_ORIENTATION | SNK_SRC_MODE))
+		tcpm_cc_change(dev);
+
+	if (changed & TYPEC_VBUS_DETECT)
+		tcpm_vbus_change(dev);
+}
+
+static int qcom_pmic_typec_probe(struct udevice *dev)
+{
+	struct qcom_pmic_typec_priv *priv = dev_get_priv(dev);
+	ofnode connector, supply;
+	int ret;
+
+	priv->pmic = dev->parent;
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = qcom_pmic_typec_get_connector_node(dev, &connector);
+	if (ret)
+		return ret;
+
+	/* vdd-vbus-supply is deprecated in favour of connector vbus-supply */
+	supply = ofnode_parse_phandle(connector, "vbus-supply", 0);
+	if (ofnode_valid(supply))
+		ret = uclass_get_device_by_ofnode(UCLASS_REGULATOR, supply,
+						  &priv->vbus);
+	else
+		ret = device_get_supply_regulator(dev, "vdd-vbus-supply",
+						  &priv->vbus);
+	if (ret) {
+		dev_err(dev, "failed to get VBUS supply: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dm_tcpm_ops qcom_pmic_typec_ops = {
+	.get_connector_node = qcom_pmic_typec_get_connector_node,
+	.init = qcom_pmic_typec_init,
+	.get_vbus = qcom_pmic_typec_get_vbus,
+	.set_cc = qcom_pmic_typec_set_cc,
+	.get_cc = qcom_pmic_typec_get_cc,
+	.set_polarity = qcom_pmic_typec_set_polarity,
+	.set_vconn = qcom_pmic_typec_set_vconn,
+	.set_vbus = qcom_pmic_typec_set_vbus,
+	.set_pd_rx = qcom_pmic_typec_set_pd_rx,
+	.set_roles = qcom_pmic_typec_set_roles,
+	.start_toggling = qcom_pmic_typec_start_toggling,
+	.pd_transmit = qcom_pmic_typec_pd_transmit,
+	.poll_event = qcom_pmic_typec_poll_event,
+};
+
+static const struct udevice_id qcom_pmic_typec_ids[] = {
+	{ .compatible = "qcom,pmi632-typec" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_pmic_typec) = {
+	.name		= "qcom_pmic_typec",
+	.id		= UCLASS_TCPM,
+	.of_match	= qcom_pmic_typec_ids,
+	.probe		= qcom_pmic_typec_probe,
+	.ops		= &qcom_pmic_typec_ops,
+	.priv_auto	= sizeof(struct qcom_pmic_typec_priv),
+};

-- 
2.34.1

