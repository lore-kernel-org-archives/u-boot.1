Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D4606A32C
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XerMc9Z/;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8J44vlD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2JKpq2p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 929A340670;
	Sun, 15 Nov 2026 19:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbzsxeGdCCtJ; Sun, 15 Nov 2026 19:00:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DCD10406C2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769249;
	b=az8ZQ2b4JKnqIF5edhC2+fPczyhcgnIMxVD5U6hmvvL9bv4uPszHKqf6VyuWYrtTximi
	 oxxLdYxgwXfKEerGOxsCLojtuSbEimnRKGh410K+8PfMN4B124rNvhUvLzCIhYtFIHSUL
	 pVKKuAojZw9YOKPR+gQtgl8Cg1qDlBzLlXdM7w2B8J4s2PMc/dWUVCCGXeMZzUM4T7a0b
	 I4hELk9RenX1/FNbf4uovPydWM6z94m1PKFNdeAw+JrsxHt34PciZ0xFpSysmx7UxrewX
	 TYDb87sRT3/+kSKt24jM0LXD7RawtYFRUcCCFW9CY5T0H82yHujHa9QtccT1CaxoEcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fpdj5RKcrNzdH4NSk5BJEsvaDsadM/3Qhnp+uKf40Jg=;
	b=cXhEOplNm09+zmZKMBuyukEADnWjoFmNxmy+nO4Nv3UKE46PTZ0KnzdZAfFDyTmVQG4t
	 LlBkkjM8H8VyDFBw3YQUiIXkOUoFOAcNGIgFuyF9VRBcj3aD/mZjcujMnXS6pWPk/sgXC
	 BBP7huKLoYMADr7K3fHeb9ty3qw4MRi89fnZr0BQqSGAvRHVS3bFlniV4X81d3BQNXIqT
	 3fngU+PhowcBgiNMmLvnkhnLO+/bV1BV8LaZugcnRnKziz5rarfnaOAr3Yx/QUjcxt/JH
	 rGk9lApaxirCJqhfdYYRMtpGRiK0RW12E2REIrYRcAMSDtrM1jS9dZbh1LZewkeN1CA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8J44vlD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2JKpq2p;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769249;
	bh=fpdj5RKcrNzdH4NSk5BJEsvaDsadM/3Qhnp+uKf40Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XerMc9Z/+IUKBEAC9NcGOrgh3+5aiYYBEg20l4oZ3kf1Ll5emXdsynIJLk4OtwZJ3
	 WDYGPorgicEyL9TNo9pG3DW9rAWPFp3BhXspmA9hxcu1YtY4JeQlOlI7RmJ+sZZ1Tj
	 ohZ1wzEHtkxKOIzhOxIIAkEDxLQBTje9v45OdflISHUlwGMumU0eNaYN/DhV0vtaVq
	 swZ+XpGKsZVgvZhjbomOYi+K/9pC8//jIybWl2N0FbnmO2s6R+J2AbX5sBgiH/694I
	 hs/w6i2uv/Rn5CmsroBBz340kP50N3bwVdWYI/A6rHRTBrCO/KQVwIT5F6LYVcNAEH
	 qH0AUDdpCYoSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD10406C2;
	Sun, 15 Nov 2026 19:00:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14BDA109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9E59405AE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqKPJWdpCxYy for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1D51F40555
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8J44vlD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=X2JKpq2p
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D51F40555
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:06 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFBCM72075598
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fpdj5RKcrNz
 dH4NSk5BJEsvaDsadM/3Qhnp+uKf40Jg=; b=h8J44vlD2qfTrO72zsW4xcHnZBC
 dkui6cjTjFitEK8zKVrGI5HVfGF4fbI4oG4vzdUBuFf/fGRUFQKGfFK4HsiB4Qjb
 lQx0WrSHgEzSP/1IER8b1u29EtIGJeybWStTcXKRik+ApW7Sh8r6CfajDvYNsMgY
 wtrZ0a61MCnPj/AyPE+ghTxG7yinoPr8BcQAHJs5feQx1EZIq6T2rgw3DvuHzEfH
 hUve+TngznCWeiUgFaMl7lySD7ROEbrMyyqzJ3wAS8zhMnBeAsD7Vo04QP0y9+OG
 hHkSn/e7cnNNogVRB7SklpfmV6yRxlg/NeQEDao7fiOxMIphCW85kLQ6Q9w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhkg9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3724667bc16so1791430eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766805; x=1795371605;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpdj5RKcrNzdH4NSk5BJEsvaDsadM/3Qhnp+uKf40Jg=;
 b=X2JKpq2poZlwbMojcQ7GWiHH72dBnajf8GbSfSFXAIl8rHpi6yL4xJHaE4W1atFVVT
 bED6fNbKyIKMjhSv8q0zCNtaMZgApMI9lP4N6T5WEVU217HWnikGvrsnpCdL9Fr144Xt
 2OztgZsGmlrXFNbyvVHmQj1/uoyKhQIeMJAosmKYnphaWAYXs4rIFc0wGfY0FHpliict
 e2NQUq98CLsGGzv8fn9Y7ZMzDHr9hm+6zNV9a23GdJ54iYuFmJE+0sBfB/GMSQ58D9EZ
 sMSRKCL8kT/e611dl+lFTlqfiscU1zNPVZ3roEJhxPJhewSrk2FMY+xDbZLVmeH7NxsD
 BiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766805; x=1795371605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fpdj5RKcrNzdH4NSk5BJEsvaDsadM/3Qhnp+uKf40Jg=;
 b=kA3dNfABSEALVjZklWyG9Mac0ZSNs1YcJqApjAciOfjG+kDQfO4PrbPlU13VWBosVJ
 09eswrliLCMK8un4IExqRw4XVdzupoSoPp046gUcx+t5NfsFTLVeMiwfFInKC/Ap2jZy
 3DyqR7LiFeu+BnzNVca0i7GPyW3nE2QWoaYG0YY27/7UVzM/GEALKDDuKZ6ORz7ijsv/
 zB2Z/XFlefLmJ68xzVTJlsRLF92p8NcnpXzvRey4ed+rveKUlh93LNq8xcVcpN+7uO6Z
 1zxlM0oV8nLNavKijnJ0FlX3qc/wKe3VVNa3Lw7K35/y1dWRuaQRaRivMCvzSGAzl7dx
 91Gw==
X-Forwarded-Encrypted: i=1;
 AL+hErH2fhNMjH7xAlN3lHfwP0SbU8n1YgeI9pR3gOcJt9QutA7gx7uouNCs/8Q6X5Fmz+ZTm07lTEU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+n1qtgMFJFqOcXWumXD7gVEXrra3I7QRvK4PXsf99BF1x0l9Qa
 I8A0kYBpcHy+3DSPlJVPN2bJYxgVkhGz4C/HK/Tegc082yrrwYDMZbh854Zmu8pNEcLRnC5bDil
 XxZEmvpbqrI+m4JiyVZX4ALAFmI8lhczqwKlGvKyEDWLDAOErYpeet3spR2Wx3RC7n41peX4=
X-Gm-Gg: AYBFou2jCX1Zr8A88N19muhfvegmhc6U5OTcKAgUXPoDnDFAPxAiv69BLZFJd4nHKiq
 t8XWee9alcxoz4Ao961Qppyzmfd4AivHe0KhCnVVgDDHdkk2ycnMIpU2IrZjysXch3v0DI7vBsN
 xKiggeSr2KkwWjJVNfp53WfhEN2Iv3soVuk3dJ4RAzgOKveg/EkOQ6HcrFLLs2SkBw7lVdUySg7
 msVIRwZeYmYyzj3coFZpWs9WE/DZ9UQxtmN7ckU3UsVKNVSgtFjZUwYWEWJQtChaYzdLdsd/UsP
 cHMMU9Y5UoHSypNjJhqxroiInzUa5qfYn+JSRJg7xQGWmsQBfoaxDw/s4Z1sT03a8Msq6BTsRHH
 T5UXhwtyIELhN3Q003+GoyyRJtGTl3oPcHO1PLYag7Pak0KEVkuJx2xRWnHZcu65enjwnFE9gen
 FL
X-Received: by 2002:a05:7300:c00b:10b0:36a:647b:2d7a with SMTP id
 5a478bee46e88-377db7c8ac3mr12419838eec.0.1794766805290; 
 Sun, 15 Nov 2026 10:20:05 -0800 (PST)
X-Received: by 2002:a05:7300:c00b:10b0:36a:647b:2d7a with SMTP id
 5a478bee46e88-377db7c8ac3mr12419807eec.0.1794766804799; 
 Sun, 15 Nov 2026 10:20:04 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:20:04 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 2/6] net: dwc_eth_qos: support 2.5Gbps link speed
Date: Sun, 15 Nov 2026 23:49:32 +0530
Message-Id: <20261115181936.1750625-3-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EGHJlE2Jyv6aYD1P7mYBU2NW2BUZqKJ4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfXy5AredfoL5qr
 h52knviS67u9pL6+fpfDaGhH6jJMuexpR7AOL1ybvkJ7aAMme3fwZHruBFO9y23/yrn568ZilLG
 ME0AIXgxNwc1vKUdRjror9XBNEvUcfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfXyAyCemTP9zL0
 Xotv5M6cuu8dpOJ28b2EAyNRDej57ONZ5/WjtE4Qyx6OuWfyLOIlmZnN00EamAyEIz17PgAbWtG
 kB9tOORsaqTQZQm1opBz7+Vutz9packd4vgrqsDspTpsaKlD70/SiAa6uCz0tC8tghxsVDqQrAW
 SC8WaU00Jp855DHBHm7FL7FjqlPQP7uqQ1f0oXkvtrrtsV0pBIAZhYMcxxZJAUmzl4cNmU59nFv
 lTz05G3kr9kq6hB9biwn6ky5iE+wdXRWBAlRikRyMyHgxn7OVkJ1Ofg2CNEEc15Gwpn5xRmbl5J
 GgAK40H22uPJNGxIAec5EDL5XgkiY+u4ZZeGJyzOKIHUtnKo0ky3wpQdN54xttCnpPXveBY4imQ
 iUl0s+E47+h1s/Db7b2hYhQsxK9VqK8tx3Loy5aS6pqxovX+WpdYs08nTdJ+MKnB15MCGAd6XTk
 a4s0yJr/KtEUU8wD10g==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af9f7d6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=QFJn9Ik-wN-IVgwQvG8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: EGHJlE2Jyv6aYD1P7mYBU2NW2BUZqKJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150072
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The MAC port-select and fast-Ethernet speed bits use the GMII encoding
for both 1Gbps and 2.5Gbps operation.

Handle SPEED_2500 in the generic link-adjustment path and leave the
platform callback responsible for configuring its clocks, wrapper and
SerDes.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
 drivers/net/dwc_eth_qos.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 6f158202124..de06bb46151 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -557,6 +557,10 @@ static int eqos_adjust_link(struct udevice *dev)
 	}
 
 	switch (eqos->phy->speed) {
+	case SPEED_2500:
+		en_calibration = true;
+		ret = eqos_set_gmii_speed(dev);
+		break;
 	case SPEED_1000:
 		en_calibration = true;
 		ret = eqos_set_gmii_speed(dev);
-- 
2.34.1

