Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C832C55ABA
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5258F80E7E;
	Thu,  6 Aug 2026 02:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pZlmHkS1Ukdm; Thu,  6 Aug 2026 02:21:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C18D580E78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982905;
	bh=rabZObHPIQGJdCOq/x3c1HEZVeN8K/WIhNuSFS5TFb8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=P3sM7rsaDSeDvlaPmVPLU9LLbfzCcdxN2nL4d5LOlYziSv7VDnuEdU1yMSyU03d9m
	 QwWtVhPyA2K1F9zymWSXlfSlh5/B3onX/GQR/kZtdzvaiM7kAsGt1lqAvqz72bVd8Q
	 /ywgyf0F/wnUpwd2eYHXPhSiJXfIVsWRFbTXJKVjn2tejVaAngejmX2J3LpTr3Hz8X
	 bMII7lquTb34J2ZceUhjwrPlumumOBGx1UHQLUEwtYFS9pmQN9w0ZJyZYWX93T3keX
	 +ttyBrtrJQ9BpkFWtb3p5Ohzq0cNiuK6fem5SYUfURlQZmfaEDKco8lm2k9W2YoUhL
	 g872Uy2SPN+bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C18D580E78;
	Thu,  6 Aug 2026 02:21:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9D8E144
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D78DC60671
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jSKvH8AlaH6 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A85BD6066F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A85BD6066F
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A85BD6066F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbM5P170489
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:42 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5u5kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so1101433a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982901; x=1786587701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rabZObHPIQGJdCOq/x3c1HEZVeN8K/WIhNuSFS5TFb8=;
 b=DtdEbma+vuFuJoplpy9qvN1dX0Jwb9t6+1Dkai3SFr3l/1R1L5NtvG+UYQwtyX8gfK
 1076BQYs/QMIXvTcdPOubr8Xjz7ijph5qa8xCPfI+pqNhR0bHz7o9LLHhrPXw8NyOiZi
 18EoOWjjs6LT3L5YC+Z2rIzF1W/ecPmfCkmjIKEbeu3HFkL/bzmY2nNLNpYSmKwAx13G
 UVol9AanjVZIfe5BtmT4Nbj3z/eO+45hD0gM8pY/9XQizSHkPhJtiKge4Vt3GOjIYuew
 D7+awVBBndCWs7YWwf1ZkKlCUeCSdlC2llTKCD9DEH31dnyu5depp45nh2ifYXXf1c2/
 TZ4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2Qn9mI7i9uXUxmLBn8QVjg9L3KppjEmGXg7oQupGm6vtZFzNZdYCPSSvdQcthoZRjAh0td0o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YziZgeU13xcjCxoxems52nG1uu7mz39iFgUGVVvZ2OYwKm23+/z
 7uyyo6FYnUMOhJt7eQlZlQ9q0ODzoLfYTfv1RMZuGMVQ7yE7rpxSg/J5jwY9++xXE5u4/lVO++g
 bwcEpoG7Oo4bEeAh7xx6GJm3tXCcyvs5LDeYN6aY5lGiC7YjNVGTmFnwv4lb4CU9pdqgvU/A=
X-Gm-Gg: AR+sD11ZexDroKnjM1A0UTgXNeTeb1w42wfNTDA+mcXZgCccagFUgqDp50M/i10szYd
 D95KwnxdS7o7+nNWV5WBuAzY+vdGYSHwCo+yqQyeC+pW9fg/Ixf+iBSUTMN3SOzrQZ6gP/nyzFA
 +q8vI3cD4TO+Afy6W6SZ1TIycxOUH7a8Dnt2LS/yZoCwBGxmUnkFznadCur89WIlyxw5WbVYvxE
 oBrsscKyGVNDwkePD9LAyZMWdZwQS2KCuZE8qw3OMRq9fO0aWxVbzYuYKZ7SQ1NKsGL3VMgzHY8
 8QeMlGbCHDBXfhnnNCkGNA3jk+7O8vOe7+R+SDyqV9SXxrabMlaCdEcDWIdVOOZg7qI5bZUYSyu
 xHavME5Gsoy2bxS7Xpu/G22f1YydBJ/+XZx1T3jdmg/5YteFYHldGywahd/+1qDh8lXrmlHBF/X
 dCHqpWVkYzx6P7Z82PMU6S4jq3C6La7g==
X-Received: by 2002:a05:6a21:6012:b0:3c8:e313:8d42 with SMTP id
 adf61e73a8af0-3cb85fac08cmr13829025637.31.1785982901432; 
 Wed, 05 Aug 2026 19:21:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:6012:b0:3c8:e313:8d42 with SMTP id
 adf61e73a8af0-3cb85fac08cmr13828975637.31.1785982901023; 
 Wed, 05 Aug 2026 19:21:41 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:40 -0700 (PDT)
Date: Thu, 06 Aug 2026 07:51:08 +0530
Subject: [PATCH 5/5] doc: board/qualcomm: Update RDP flashing instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fastboot-v1-5-cab7d64e592b@oss.qualcomm.com>
References: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
In-Reply-To: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: _CGttswklgd1VOjfRdkdgwlpmZgXcSer
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX7MCIexX+rtuk
 wLD3jWySkAFZM6iRZUpHJBxPyPIOHNv8VDZO1fZH5QCy2LOnsg/srUFoDGEZGuOe2vkZMV7ZZAh
 xqggOe1jz1ehWYEI8FwhjftdFu5gPSfO1b/HkYjxHnslUfh41n+eRja3wiS25NtyGsAt84yBWXm
 k45ZKHRxXaz+vQxWzo18cecc8sxYnMNUobD4tctrhru4Wrkzkw45FBa8hukihEGwPCNCRw3HiSM
 lP70+7bpJpxiY5Vj8JhyvhP3nGDkxuPrfZ0mwEtam5OamgCmhhmP8LKbks7VdqnOiY/21YvDw2G
 uMt3lCduVM7LHbJPLvTfk/nOst+HijHjOeoM/SCMpCLU2K4+QzaqRyj5wIdI/JgH+qQYvODM25Q
 qkzSVUPIKNVpNhh9V7xG0s+9hUhNkT57CpGBzBEUwiPjksR9+w85b9aAiAf5bPWUICd4HwTOpQ6
 eLJRmFwJc5/MWSJUGbg==
X-Proofpoint-ORIG-GUID: _CGttswklgd1VOjfRdkdgwlpmZgXcSer
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a73efb6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=r5MC_wQ6cbKlY4jr-AgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX9R02pD6JaOpY
 dYO+PhL8PRr+zaQ2yD3hM4anBeh0PdplF6Z0vjodM7oLpyh6K1tup+b83R7aKkHa12vB5HyxTqt
 HkxHMoeeMpQ3DsKC1VQytAPk5EN7D1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060016
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rabZObHPIQGJdCOq/x3c1HEZVeN8K/WIhNuSFS5TFb8=; b=hyQ7n6slDqWFe/+c
 iN5fDoS50bv46AdSy8gV39VqNdzPrMyd8AN22POC+IjO7c21pmFzv3rpm0gBL6IL
 NiJx4B1RT8xdpG0Y2D7xom1XtUvazi8WhDwXAmQ4yAdNIkPBiH/qwab4Z/wm9ivW
 RaiyokHDejI9TjiXVz9ukoc0TEnE6p7Ix7YsZdfzUQlkbsZTHanCleNJVyMBgQuY
 5iLSkL120QZST/bIb3JjjBbcmgVuEYjHVMXsCqQ02PjgB0/0DIrU+d9GTfrSRuUz
 yPFdiqf6sUGNlIpiX+E48cdvvq+MNZPJEfKNF+SVFFbza1TOqsmaFcg51Uf0GIQE
 Jz58QA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982901; x=1786587701;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rabZObHPIQGJdCOq/x3c1HEZVeN8K/WIhNuSFS5TFb8=;
 b=RynaFiMv2hcfbVicJRmWhlElIxFWO2KD/LTtsQCgQ6WusMU4rRVKKv1IJJUz8VA6MU
 4T+gxy5ky2OuKyKyIqqL+d62Y+SBzVAI3BTCZJAFFYBsCmLu630QnctOfPZYx/s+Lk4e
 h+VfQvv9NimOQvkv2yv43XuWmaTWCQREK01tH/Sfp0cy0ydM+jqKZOghzy4Jqp7n5ZAz
 4V2bwGyslsBBhQZGArVXKL3D6W2cbExtxEwa5UF8TBpyKXD9z3aKz/X7PXet/69YmD3u
 AsvVOz+gRwVv19hXdrD5dWsgbBeqNwN0E8uHk7QaMmYw+t2MobLINbG0pXQ24hDSUZCg
 Egfw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hyQ7n6sl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RynaFiMv
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Update the flashing instructions to include fastboot.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..fb3fde7c381 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,6 +42,22 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+This board is capable of network connectivity over ethernet. However, the
+relevant network driver is not available yet for U-Boot.  To restore the
+original U-Boot or flash modified versions of the above built U-Boot, 'fastboot'
+can be used.
+
+  => setenv serial# ipq9574
+  => fastboot usb 0
+
+  C:\>.\fastboot.exe devices
+  ipq9574  fastboot
+
+  C:\>.\fastboot flash 0:APPSBL u-boot.mbn
+  Sending '0:APPSBL' (620 KB)                        OKAY [  0.042s]
+  Writing '0:APPSBL'                                 OKAY [  0.030s]
+  Finished. Total time: 0.342s
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a

-- 
2.34.1

