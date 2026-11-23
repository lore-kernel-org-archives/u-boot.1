Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B32606A332
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WL7XUR8A;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ARpnSYsW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UipZTyhj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4939380DB1;
	Mon, 23 Nov 2026 08:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WxafbELQNIO9; Mon, 23 Nov 2026 08:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EB7580D8F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795424243;
	b=fCifGdXuNVT1c+/5yovUssm4K+H4W0ozi5F+FuueGmKhPAaXCw7DN23kCcsdPfkzrFEL
	 7PZKy/my+cEGtESvpUyJl4o/SBpWPxq4xgh+FJvzcHqWuQArHVktYemf1SP3M+9uq3aoW
	 l922MSNFaPG6c1NY/ByQ+ETI7TtlvtRytC6dC8oJjb2BxSQ2V7yLu0Mvv+VR9J0X19xD/
	 V+pBZhhuzzqTWfV1VpTPeW9qlbJ/CauM1KGwfQYn+P/KFM2IaRroQ8JoGmBUNq8wy1221
	 rzXfxNfmRX1OUxOuY/ehC7fZe+TwQGn4a1YgwksHCvi+fCeCZZ0tL6KxWjxP1FPE65Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795424243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9YjoFVJQFee7gz37PjI4++scg5Wq+OnE0ukl0Rm2F+o=;
	b=cE51IRnm9tapXFWK0/eBOUwjKnUg0pwqF3NtraqXAeq5DWzErjkmGT4i+e3lPMngbKpY
	 5Sn6qY3dzv+7oUtzGoTvgavd3Em8JyLN1pgMg0ALNtLl0qEnpA5O/yiCSdLfO6nHW5jTt
	 8VDO5+Gys0dDfbaNqACvsLiyghu9HtsK3yNVoc6HDrXwggY13lhtqQu71yVSguGEYhvj8
	 OHBGOZ8t3IiBVJzN5QAI0osMJkM3WhU3MmlvIdNqJMtJGUV+xazDwW9zK6SkZhvNUQKmv
	 H0A3V/Rdd8jbM7kCxVNTh9pfvFBKw5RbsgK9AGD0JjuNUn2UM2/FJofGLUuSJX+5e/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795424243;
	bh=9YjoFVJQFee7gz37PjI4++scg5Wq+OnE0ukl0Rm2F+o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WL7XUR8A3+tj/kEHEKGgImhcJ5I582k+I/Tm6LwLWf6bNWOyKbICy73aYT0dQaGlt
	 PWB0f/vgu7J0fs+Wof51lj4xmu34USLtufhRwBc2oeNVHri8mbmQnPpijonndsb/R7
	 S9A4KEqLoH0l90ZR5G88YptsuvLMVi7W0u2z/XM7HlSiP2eKn85ra0NzhMOuJY9xg2
	 bPq7k6JhtbRKXyO2hm5isYcSdy4ha4kZVDIGiJS7rW7AOTWjFpMN7Wsv5CoQZWBv1h
	 CfBszSIhkSQlOxTVaE2Eiwg/7si0RponT829FP8fV5rndbpH8ZAP+5cpOZ8k46dbI1
	 +k0Bf2kSDa9RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EB7580D8F;
	Mon, 23 Nov 2026 08:57:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB4F722B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D125440063
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qb3P1hlxrftW for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C0034005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ARpnSYsW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UipZTyhj
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C0034005D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN683Gm1126608
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9YjoFVJQFee7gz37PjI4++
 scg5Wq+OnE0ukl0Rm2F+o=; b=ARpnSYsWOQOTGF1YZj7tgmjjA6ZKcMtWknUFoZ
 PtHB8Uje1hqa6cveBdAeKX7uoA0M8bvKEbeMd64thhksTJ+q4HnQxqS9LDl8PrXm
 pY/0Z4O+q5JBHPt47zMsXOjOugKNuRsbKburKbRPQQaciUyiFydMBeLQLBrKsLDZ
 wk9zDn6q2QECDafEBUq5ns4VhhVHQ9MKtr48Iv0hUjcJs5vN2xHtFAkWtV8nMz9R
 2Vk5rAyk2oJyKQy26WZN8DkkE8aIE4aY4+nsnLRJA4ydOVltfEKnjYeb1y4i4gzg
 HDSU2yhb1bqrUoIqHQusY9KIhvJAkVj0cqerqZuTNy9iFFmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00kb8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so496018885a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795424237; x=1796029037;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9YjoFVJQFee7gz37PjI4++scg5Wq+OnE0ukl0Rm2F+o=;
 b=UipZTyhjbSir3T3YpMc1nUcJ2v9/WKgss7n4oLl+6ZjcJRzs9SYQFkIccaS+hWpsC4
 q1AHFAN65D9KEdEWLJYcLjB1X21lXHS9ZIyqCW77l3xL4XFeZDbwYQRADstQw6qr7ohT
 XI4VV0F1JDkZ6ie4cMIT9Gd8bkpdnbmVuExKFq8Fcqm6Jz6zNjIGJ+tNwK39/y7g2FCi
 Tcwvqk+mL5yA+lJpOg5fSPZmEuXxw19qewVynQOFdoz5rnJBCXHmAmmngbwZzC5ZyKds
 NqPokEIn8H461cD1Hc+V5U8FhnTbm9fe5yl3qxTlEALv46ZVMM15kuWHMQyk3xCdsfps
 AJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424237; x=1796029037;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9YjoFVJQFee7gz37PjI4++scg5Wq+OnE0ukl0Rm2F+o=;
 b=meGOSyuI+xlSjgdxdpWLrLSQKR60X05rB4hPY+oKxkxT+vq8CSwfCtkLxZ2LFM7S6g
 R25BQylDj0kQ1XDc4XNryOg4fkCfs3CZdS8fwx6I5tZcAV6JNXaYhKmimPyjyZ1sccuo
 gBZsSa/5FjGCsT6UyobIsB9BFr3eux3L/F93CBWbA4yHPP6Kh/IRxFOf7pcmUX+opbxa
 U/0F8uGPzYmVpBkEidmFcKCySKq0DOyZLSLwDNTJrKmAjfjpY+DrQM2mStf2osehPr0a
 6xo5Crab8cIC3bA4+l0EeZoXogMtXedq/SzGKYxxWfAGWQmZwqYG0VNe4f446DbpU8jz
 VsLQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEM5SKXdtvZ0EHXSvvSMYyIED+v/5K+iHJwlITZIyiS9t+lSsmwzXtjzIEzIc99e+UUk/gmOdg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/xd/Jp3/AfVt6R2lN+hLfXvxUeLczyRN0IXv8pt8IBrSgRq7CN
 ZsvZAOfFTY/XiitOuVq6DubBn1U67uF/Imi+zVnC8wNogcOuvRTW6e7kKo/zXkWALJ2/br/vSET
 wr5iHXxgr7SclxcavN5r8Umz+DM4lloN+f0jZSi4X2L9WjP6bmHueb6BUsvP5yyEteute2AU=
X-Gm-Gg: AZFdTZcIOujBnN37E0Bdx76zFrPDFprZ2T8P0OpOzCTzljHVvhlsPESCo1z5RX4Ku0w
 K/J/hp3JvADxffZTxuO7sq5OIynblqgRa2h4Ukip400w8oIf7+hdXIguD8APRqWOI9UdDpLoHfS
 5gBW/ATnGJ5IPDZCgXnYZGdL9kJMlxLpww66gtX1jHOvqvrhpdN/ZIMGpRo6rT8Qsi9l81o3mZM
 I5crB8+ZZfa9e1geaKTVMHwmCNmTAWGdeOrczulvwZELMSR/xQpfaQS2Ep2kryusDxwMiq6iu2E
 W8C35tZyFJhZWK6niD0TWGL+dSBR+ljYF9z8sOwuuk3jR8ykBnzPn7o71YwToy3lPxetE4KfmoR
 HXZHthLRJ80adWjUEIjmW56jYs78JlOnUSlSyCuRwh9aqCAvM/Ue1M/+XuJrYeea/7JCdVZqqWG
 S1krqc35HZttD1
X-Received: by 2002:a05:620a:46a3:b0:949:7069:3fab with SMTP id
 af79cd13be357-949bab3e9aemr2022580485a.83.1795424237386; 
 Mon, 23 Nov 2026 00:57:17 -0800 (PST)
X-Received: by 2002:a05:620a:46a3:b0:949:7069:3fab with SMTP id
 af79cd13be357-949bab3e9aemr2022578285a.83.1795424236979; 
 Mon, 23 Nov 2026 00:57:16 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc6fb3sm374976466b.62.2026.11.23.00.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:57:16 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v2 0/2] mmc: msm_sdhci: drop the 1 ms delay after every command
Date: Mon, 23 Nov 2026 09:57:00 +0100
Message-Id: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7RDayo+uvIdhge0gk1iqHUQN4
 e5WLuDmJd/L+1lAKDIJHLMFIs0sHMYEepeBHbrxSsguMehCV6owBXrxKG6wjK+OJxQaHVrvcG8
 a0+v6kIIaUvseqef3tnxuEw8sU4if7WhWP/f/5qxQYUV9VTfuosqmPAWR/PHsbjZ4nyeBdl3XL
 6QjIGHFAAAA
X-Change-ID: 20261030-msm-sdhci-wait-send-cmd-4383f2792022
To: Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, Sam Day <me@samcday.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX6Efm+M8Biv02
 66V+KYmXSDc2Cuz28Gy+Ez+1ivIXV4kNuC/i88GfR+uBhdhWWCa1/G8kwPrA4XLpzt7eAYDJPEq
 cJ2sCSo8RqXpCK6E7ZmlaRFAywUvpar/FR84rn8qrsIgDSyyZQgXHhgLxhtLFLCJjuwVGMvisSb
 fu+nT0wVzFlcQaZM6t02HV/RxALKofQfOZmVbksc/rr9WEK9dzRHj/o0G9sMTk2YAkbmR+sUHQf
 Am2M3+Tvaz1n8xF0JdDCmi1JsQNlVDDfwN1glU9PCqB0k4vsfq6mBCpc3fLfyv2rrcIgQHh8n1I
 n6zw7YVj52mvJ/HOsQMGX5fJyd5Q+wglYrzq43PW2w7saJVRES76AlT3+ScwfxbTMdkZ8pZfOov
 E8O1YojtKS5QLx0bbgeyzalLfefoorePJ8lai38UmynGHC907mBXuKm5Cp/lr0ZTAmU6x2nnaYw
 xls7ykSDWr7aLQJeR4Q==
X-Proofpoint-ORIG-GUID: W1QZK0Yo0PdYombLpB3bBTZwO2vEG8o5
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b03ffee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3qHKjgvK9PkHQGQTMLwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: W1QZK0Yo0PdYombLpB3bBTZwO2vEG8o5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX0StilWToLZi5
 Z/kh6nTRlUN38+Dv6fheKRAeI0xbDGwuo3fKskcf93wYlCz2uixz8eVLYVtkK9ETNIAdUBG46it
 yPBb/wjcqjoACZh5Q/5NCNARl+HNzwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230035
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_sdhci sets SDHCI_QUIRK_WAIT_SEND_CMD, a 1 ms sleep after most
commands. It costs 2 ms per multi-block read and caps USB mass storage
on an Arduino UNO Q at 46 MB/s instead of 201 MB/s.

v1 only dropped the quirk. Stephan Gerhold found that this breaks SD
card detection on DB410c, DB820c and RB3 Gen 2: the CMD55 after the
first ACMD41 fails with a response CRC error.

Root cause:

The same failure exists on eMMC, where MMC_QUIRK_RETRY_SEND_CID hides
it: the CMD2 after the last CMD1 fails on its first status read with
INT_STATUS 0x00028000. Both cases are a CRC-checked command that
follows an R3 response.

After an R3 response the controller keeps a latent command CRC error:

- it is not visible: INT_STATUS reads 0 before the next command;
- it does not expire: the next command fails even 10 ms later;
- it is removed by a status clear issued a few SD clock cycles after
  the R3 command has completed. The clear sdhci_send_command() does at
  completion is too early.

The quirk worked because it delayed that clear by 1 ms.

Testing results:

Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, eMMC, ADMA). A status trace
was added to sdhci_send_command(); the identification clock is
188 kHz, 5.3 us per cycle. Each line is the first CMD2 of "mmc rescan"
with the quirk dropped:

  Without patch 1                                    CMD2 result
    as is                                            fails   6/6
    50 us .. 10 ms wait before the CMD2              fails   3/3 each
    final clear of the CMD1 delayed by 1 .. 8 us     fails   6/6 each
    final clear of the CMD1 delayed by 12 .. 32 us   passes  6/6 each

  With patch 1 (85 us at this clock)
    as is                                            passes  30/30
    1 ms wait before the CMD2                        passes  10/10
    10 ms wait before the CMD2                       passes  10/10

The 1 ms case has the gap of the SD ACMD41 loop. With patch 1 the CMD2
is sent once per initialisation, without the retry.

Both patches, no trace:

  eMMC mode                          HS400 (200 MHz)
  1 GiB "mmc read"                   302 MiB/s
  CRC32 of the first 128 MiB         same in U-Boot and Linux
  Linux boot from the eMMC           ok

Not tested:

- SD cards: the UNO Q has no slot, so it is not confirmed that patch 1
  fixes the reported failure. Stephan's alternative, retrying that
  CMD55 through MMC_QUIRK_RETRY_APP_CMD, works on his boards and can be
  added if needed.
- v4 controllers.
- Other SDHCI hosts: patch 1 is in the common sdhci.c.

---
Changes in v2:
- New patch 1: delay the status clear after a response without CRC
  (SD detection failure reported by Stephan).
- Patch 2: commit message reworded ("after most commands", Tanmay) and
  shortened. The code is unchanged.
- The Reviewed-by tags from Aswin and Tanmay are not carried over: the
  patch now depends on a new sdhci.c change that they have not seen.
- Rebased on snapdragon/qcom-next.
- Cc the maintainers of the boards that use the driver.
- Link to v1: https://lore.kernel.org/r/20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com

---
Igor Opaniuk (2):
      mmc: sdhci: delay the status clear after a response without CRC
      mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD

 drivers/mmc/msm_sdhci.c |  2 +-
 drivers/mmc/sdhci.c     | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
change-id: 20261030-msm-sdhci-wait-send-cmd-4383f2792022

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

