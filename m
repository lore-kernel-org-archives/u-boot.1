Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883D606A330
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nd6cX3fF;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuHVgcz6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hNo5E2iT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 156F080969;
	Thu,  5 Nov 2026 18:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f5L9W0vgxRot; Thu,  5 Nov 2026 18:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A71A5810DB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903249;
	b=NtQKtIsVKnG8F2ID+y6SzMv7OklHFuxIU/q230oVqLADn33/5MK0qtEcDIoIpIcpGpXV
	 qsanz+hJeluurYO0fUoJoIRT/FZeyzNjQhj/4F0xVcVDxdBVofrjStJqeDrVzHM3YYFfL
	 B7o0MkLAavfWjQHyr71CriRerv4LpQcVa4kMxxf4d9NCXPmT1ExtzvoaeIyZrTTXGU1D5
	 S/Yz5UgLOjD62RmEnYT65EpgqC+pxfUnjzcuk3qmocBDC9eTBPASqYG/s0JWm9DeHrME/
	 q3pGq10yVs3gCjW8nVeBpN2UqLc3ynqvVDP5x6m9SKXW4WElEMHrPWvRdsI1kX1ZIUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UOQFBXnlqZebKOeYXBBvyJ0GfV0dY3/OW2qVtAN2bbM=;
	b=JehNzkB2U0Gk7GHdjZMfbK1nEgZx/w5q/yNCvXNsqruib9/0ToYIyMx4BxthEhM+vQUy
	 RMfsFoxywpI4Pv2hFIzT+zBftt2Ryp4O8DQZVw2dI++QA43e8wlnWDY6XKYbmVVDZoV1I
	 I0ApJ5T/bM2uSnDHTkewYxcduS9bhOMbVU+Za3FZzbNgtp+27rpYD8s982RSQXyvIDyfk
	 8wfsqa3eH6vJVp6OGTRQyfjbOBL4wBmiK2SMEq/roECDDz5EwWZ8zuaJR0yy1SZUJWE7P
	 BrXoQ+Whrp2XukFzcRUnGg5nM6Z1hzNKBb6cA9CMGLAFuktYfjmpPx2IkdK3I5QgXFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuHVgcz6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hNo5E2iT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903249;
	bh=UOQFBXnlqZebKOeYXBBvyJ0GfV0dY3/OW2qVtAN2bbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nd6cX3fFiGqIWAxoNXo+zyf/fIJ562wsmP2OF31UOsrmlg4vvnqjG0DpO9fZCjfZI
	 SD/0TeQSgDZOikZ13sdE9aYfvnkhw0mkOEwMXTGa0VjN5ngxBaLa7Q+JR/Yc+30wLR
	 PuGiJ2qHfpZHLPeZpD/4Z4OietbSFfyEkCk4LT5fXJKtbemd7VSuj1Djkck9BsiVoW
	 6mzw+fBpbmGeaSICASFPyEzdPUW6rzv5TCCkd59VMHe293EbSo4EJimYMDyhC6r33o
	 x+V/Q3G6o+JL8eqOqcmiC/k+JhFm+QXaJOKu11SpF5AWlSIqexsS/hfBN2Wed6Z79p
	 n4rcj6uYJ0sVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A71A5810DB;
	Thu,  5 Nov 2026 18:27:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95C1D31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B578810DB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mhG6Iai9DaWx for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DF1480969
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EuHVgcz6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hNo5E2iT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DF1480969
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:26 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeMcG924142
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UOQFBXnlqZe
 bKOeYXBBvyJ0GfV0dY3/OW2qVtAN2bbM=; b=EuHVgcz6OQ3JnKf7/tgYt3VtBVy
 Bqyvb0GhTLRdM4j/Aq3/N1aw28K+6FyX4T58h7gHuSwLTpPPGtgQTTCsXg+UYQ+H
 fclQXMky1pCymomtyDsyDZv/7TX1rvT+vJNFFFK2p+UfxDPzPzSur0wmlZsz2LZo
 YOqC0BAaL1W5AS1Oq3TwyLCli2efx7r+T3y+cSIW+GU4VLiyAhLv42YPOYF0Js4K
 /5/24M2sUTo7ZFuEiRE+xcRFgfkPh2QvBpwS3C5Qp7SdbDFMXiXnU65V/0ZvhIqw
 +JsrKFLqvNKgDwjim61ivuD6snvDXTT7vF1tuyDKInUBhpg7IvLzYvdULvw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkt7tb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:27:26 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1acbaf81bebso2813533c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903246; x=1794508046;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOQFBXnlqZebKOeYXBBvyJ0GfV0dY3/OW2qVtAN2bbM=;
 b=hNo5E2iTOviSc/kL+gNQb9sGyP3/ar/QNEDufqO2R7fwqllQoUBGacflSOjcNXe6Wo
 s+W+fQEVdnCpOjxkPLxdIPat1q2k8/BW6sRm/NmeWijH/WJPpXUQqYztXqvALO875QF1
 +v4iZ+gAfZwFugOO9fzZf53iAAje1SbSsyZIaRqP9713Y3JRChnSxFc6ZTG18sVd/4MH
 Uc+TeLXGfznOPeYLNAh+pIiPoqzixxQLqIFWr93MXqCwM51OH0mLNSyB1cDVcmrUV7id
 3jjjMcAyaJatx45erL+iO6Aw8A9/cGPesti+AmWUt/JBO7k5k2q77PiY4FZlMKV6CsOM
 ZDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903246; x=1794508046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UOQFBXnlqZebKOeYXBBvyJ0GfV0dY3/OW2qVtAN2bbM=;
 b=oSfDk25MdBH79Zp8sumIbBgrsuZoOZ64f8xeQVOBRqt1JZBq/3SHVWOaJrZSPHpEKz
 mZFkhCCwJ6WA3PEQc/DOE5vYy1Yx21qJH5cAxDoyhg78wiifsIYB38TaFEMgoQkLmXDu
 OqDqAUaRkm/KmqlEaFdGqEGz8b2G/XFJuJNsyBUdQuJ8op+YBfanccfJ7Q+ReIGSzkyo
 9JUo+G6acXmICx1Vc0S4Hwpvm45zaxq2BN0Kp8JA+AX/e05T0Ktp25wuaQBiuEltuPf2
 q0n5QUVLD0nHim9LwOiQvXSeaJF3w6QFOermpHzxJfySQuYS//VLm6gLZYxq/4IMkqvI
 GA6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwh0rAuBem5EfGrQfgQG9IPmsH7ttYJpTCMJiAixDLqx0BzntPRcTvPChrkkSnOIfWVVMXnn4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9dPw+BnV1iu4Qy2dXwHOwsXoSmY/mMk5zW4YzE36ayWDl9EEcH
 yKdCcBjeflT7b5/BGqKsEVzQslb5TvjR38GusZLaB31sliUrnWGIbbpPkPsPwbS0Bz7bjRf+jAn
 6Wy/u6Y3a58al+h5acrTidn0ILBG9pL2yxJXvOFGrfgCSI3XDY6uogNIT9CucDc5QCo6fdhc=
X-Gm-Gg: AYBFou3zFNE2bY/0fIdJD68YTt6c7OutWYU6Z/0hd3hruCMNUJDoZxpNnSy+M0gI4vo
 0XElyyJF0oKD0fv4yspM9KYGy9nkPsi4RtrDXl0oIyNqTvpl5VHKy8MnMFF40f+EG4+knMxyFlh
 lcQu3yXU+VttlFF2OwxHhnuBubkJo4MnsoBvp2DU6lcMOgphFKIilVGXSHfW/YGBK3/YLX3/W33
 IOrgsYITAF7UWH/QRPEsjCyWS31uf1xuVw9t/1ZWQJo7IKdGywF8XLZtMD0OkaTX3XjXp3m3csk
 o3Jxi41tiSiCvgz/sqhuE8zbgfn+b12KjaR4wK+ar73f7LEKOYjc4E2dCE7qsACiQdjp3pSpPWs
 j6cLGLFBkwESSTZXeQX2IT5kuGmkAu9ylz+5IZIkYXJwzXBo2EI68RFIdpeQETPB3uYpClQqDPs
 rBcUICkGcf+5yYCRaDoN1DFbYAVnI1sVn6xUK/QuH3VIxKDCf/uAnh1htApMCShY1Nwp2l
X-Received: by 2002:a05:7022:ea8a:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1ac56c9fe97mr25781668c88.2.1793903245080; 
 Thu, 05 Nov 2026 10:27:25 -0800 (PST)
X-Received: by 2002:a05:7022:ea8a:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1ac56c9fe97mr25781617c88.2.1793903244304; 
 Thu, 05 Nov 2026 10:27:24 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:27:23 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v4 10/13] arm64: dts: qcom: Add device tree for Nord RRD board
Date: Thu,  5 Nov 2026 23:56:11 +0530
Message-Id: <20261105182614.2405482-11-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX8EtnpMh4mNM8
 WnXUbjXv27rBpdZNfhQ71w5NTdUdHqUB0yoSbsFWS3D6hAcQOxDhAtV8XLSGPtMB7H6PEXsOwsf
 UbsOmC5rqeOihwT6sBtX+2CXBIO8Aa0A5AR0/+Ai1NPcoX9saKOpjnHpvbMk6kYAsEIedQzaRi6
 cEPHKo6ewhpfqxCj+jziHevCjPIc32NYqCQM2PtkOz2zFDsKlZRxpkDcyjrI+F1EW8/T1kFw15a
 o+LsuxssU2iSNtUZpyQ3sY05WjspcibagN28n+0aC7ZDG3B0MoMQUCitoFGhxDwzwE0mEVzJWt3
 H/tZGDcQvk/SvUfMCn2qFuMhlaeWjqmr3LwnVLCkGPqyBuNByS/lElc4/SvGY0lE7iQ5MYugMjF
 jwYpU9Hs6klhlpsf0Re7xj7S7gALa94p9AHEN3umBV0jbBk5FjSMS7abOdtOQiU6NbErpAI2h4V
 bPoHfm/7A7riS8UHnww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX6KNR4kiAsnkA
 VD4NzF6Y0vTZ0MBQrxj0ETYKvbg2KT8q/jNaqZigvzvLJo//JtCeAZcP+1zk6n3dDEKr+EUvPK6
 1CKdewGRVWsOC/iJK++eABbTjdJfYHk=
X-Proofpoint-ORIG-GUID: gy14WRKSYP065JnjFWl_fh35oGxCMamn
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecca8e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5sLx7e1TBNyWi_Ja1bEA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: gy14WRKSYP065JnjFWl_fh35oGxCMamn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073
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

From: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Add initial device tree for the Qualcomm Dragonwing IQ10 RRD (Robotics
Reference Design) board, which is built on Nord Embedded variant. Enable
the debug UART, UFS storage, PMICs, I2C and SPI.

Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260914031412.140856-7-shengchao.guo@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 32afff1e816e10185bb571aa9d89dc2eb061d548 ]

(cherry picked from commit c672b9b3f6030f1ce66f0f1d94b3ff25fe12b7e6)
---
 dts/upstream/src/arm64/qcom/nord-rrd.dts | 424 +++++++++++++++++++++++
 1 file changed, 424 insertions(+)
 create mode 100644 dts/upstream/src/arm64/qcom/nord-rrd.dts

diff --git a/dts/upstream/src/arm64/qcom/nord-rrd.dts b/dts/upstream/src/arm64/qcom/nord-rrd.dts
new file mode 100644
index 00000000000..3673003c8b2
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/nord-rrd.dts
@@ -0,0 +1,424 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "nord-embedded.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IQ10 RRD";
+	compatible = "qcom,iq10-rrd", "qcom,nord";
+
+	aliases {
+		serial0 = &uart15;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		xo_board: xo-board-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <38400000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+
+		bi_tcxo_div2: bi-tcxo-div2-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-mult = <1>;
+			clock-div = <2>;
+		};
+
+		bi_tcxo_ao_div2: bi-tcxo-ao-div2-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK_A>;
+			clock-mult = <1>;
+			clock-div = <2>;
+		};
+	};
+};
+
+&apps_rsc {
+	/* PMIC A - Kobra_MM (PMM8650AU) - SID 0x0, Bus E0 */
+	regulators-0 {
+		compatible = "qcom,pmm8654au-rpmh-regulators";
+		qcom,pmic-id = "A_E0";
+
+		vreg_l4a_1p2: ldo4 {
+			regulator-name = "vreg_l4a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-name = "vreg_l6a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p2: ldo7 {
+			regulator-name = "vreg_l7a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8a_1p8: ldo8 {
+			regulator-name = "vreg_l8a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s1a_vdd2h_l: smps1 {
+			regulator-name = "vreg_s1a_vdd2h_l";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_s3a_1p8: smps3 {
+			regulator-name = "vreg_s3a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_s5a_mv: smps5 {
+			regulator-name = "vreg_s5a_mv";
+			regulator-min-microvolt = <1328000>;
+			regulator-max-microvolt = <1370000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_s6a_vddq_l: smps6 {
+			regulator-name = "vreg_s6a_vddq_l";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <570000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC E - Kai_MV - SID 0x4, Bus E0 */
+	regulators-1 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "E_E0";
+
+		vreg_l1e_0p9: ldo1 {
+			regulator-name = "vreg_l1e_0p9";
+			regulator-min-microvolt = <936000>;
+			regulator-max-microvolt = <936000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2e_0p9: ldo2 {
+			regulator-name = "vreg_l2e_0p9";
+			regulator-min-microvolt = <936000>;
+			regulator-max-microvolt = <936000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3e_1p8: ldo3 {
+			regulator-name = "vreg_l3e_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC F - Kai_MV - SID 0x5, Bus E0 */
+	regulators-2 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "F_E0";
+
+		vreg_l1f_vdd2l: ldo1 {
+			regulator-name = "vreg_l1f_vdd2l";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_vdd1: ldo3 {
+			regulator-name = "vreg_l3f_vdd1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s7f_lv_sub: smps7 {
+			regulator-name = "vreg_s7f_lv_sub";
+			regulator-min-microvolt = <1036000>;
+			regulator-max-microvolt = <1136000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		vreg_s8f_vddq_h: smps8 {
+			regulator-name = "vreg_s8f_vddq_h";
+			regulator-min-microvolt = <500000>;
+			regulator-max-microvolt = <570000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC G - Kai_MV - SID 0x6, Bus E0 */
+	regulators-3 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "G_E0";
+
+		vreg_l2g_0p7: ldo2 {
+			regulator-name = "vreg_l2g_0p7";
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5g_vdd2h_h: smps5 {
+			regulator-name = "vreg_s5g_vdd2h_h";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1150000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+
+	/* PMIC H - Kai_MV - SID 0x7, Bus E0 */
+	regulators-4 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "H_E0";
+
+		vreg_l1h_0p9: ldo1 {
+			regulator-name = "vreg_l1h_0p9";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2h_1p2: ldo2 {
+			regulator-name = "vreg_l2h_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC I - Kai_MV - SID 0x8, Bus E0 */
+	regulators-5 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "I_E0";
+
+		vreg_l1i_0p9: ldo1 {
+			regulator-name = "vreg_l1i_0p9";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2i_1p2: ldo2 {
+			regulator-name = "vreg_l2i_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3i_2p5: ldo3 {
+			regulator-name = "vreg_l3i_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC K - Kai_MV - SID 0xA, Bus E0 */
+	regulators-6 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "K_E0";
+
+		vreg_l1k_vdd2l: ldo1 {
+			regulator-name = "vreg_l1k_vdd2l";
+			regulator-min-microvolt = <904000>;
+			regulator-max-microvolt = <904000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2k_0p9: ldo2 {
+			regulator-name = "vreg_l2k_0p9";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3k_vdd1: ldo3 {
+			regulator-name = "vreg_l3k_vdd1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PMIC L - Kai_MV - SID 0xB, Bus E0 */
+	regulators-7 {
+		compatible = "qcom,pmau0102-rpmh-regulators";
+		qcom,pmic-id = "L_E0";
+
+		vreg_l3l_1p8: ldo3 {
+			regulator-name = "vreg_l3l_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&qupv3_0 {
+	firmware-name = "qcom/nord/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&qupv3_1 {
+	firmware-name = "qcom/nord/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&qupv3_2 {
+	firmware-name = "qcom/nord/qupv3fw.elf";
+
+	status = "okay";
+};
+
+&spi16 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart15 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 181 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l3i_2p5>;
+	vcc-max-microamp = <1300000>;
+	vccq-supply = <&vreg_l2i_1p2>;
+	vccq-max-microamp = <1200000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l1i_0p9>;
+	vdda-pll-supply = <&vreg_l2h_1p2>;
+
+	status = "okay";
+};
-- 
2.34.1

