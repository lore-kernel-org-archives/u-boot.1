Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D210FC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF854091F;
	Thu, 13 Aug 2026 05:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kWvuwapXSRy; Thu, 13 Aug 2026 05:57:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CDF940939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600622;
	bh=J4nySVYO+S2EgoQQHyFEG3c4/TLiNeLzQT6rYePE3qI=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=My8B6lI47MYDGsOEIk7vOttFSWL+m0DdjIIdIin6R6+SwHDIEWjZmrrujZ8W6BmKI
	 J5OdgXuDULnmqWkwSWNgGgn8TVSx4CKmxw4RnpAx94KlPS/wSgrdxCEGPHZ0t1V++z
	 Cwkv84A26ZbrCYbbp9TrFljZ6r3AqXlokdJ5fBFeD0iglUgavLXHTGlLlc2T85U5dP
	 kRcqo8oYql/cdJUjfm2jP6uA/hC+PVq6W2rtknodKQoUJRyGODQcLZZRCn4gXfptkF
	 KTMQI1Vmsjc7i07h7kBUbjxo9D4bxLU9vL5Vkm+NaAx8qCP1DA1cxKZp9sL/Pi2Kb6
	 b/jOMwbFmWGeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CDF940939;
	Thu, 13 Aug 2026 05:57:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 789AE1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BCCD608D6
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0gWnqSBT53u for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:56:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3EA6B608B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EA6B608B4
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EA6B608B4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g1xI628997
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:58 GMT
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0xsk2233-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso2131621a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600617; x=1787205417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4nySVYO+S2EgoQQHyFEG3c4/TLiNeLzQT6rYePE3qI=;
 b=aq1fBU992D7ZUgN2VAtpg9JqMruH/jAlvU3xqVfDUpZiSlJS+bbtiWyPnBTRjRLiVp
 t5492NqeQ/9AQHMz8imAx3GpcNfYJEpRKXUWfpasq3KedsD8wBrKt2DxrAAfSUYm0B80
 PWPcgOG90/0HO2fbvzw05FykzMutUJNi6WjB56AEQjxdio2btM/aB9yd+BNtbWWLaM8X
 A7OvbNxvIRriDFhQN/IeT6lQyTUlnc/8e32QdBkfcAab4NUuFAg4/SSgaD6PXebSq2QJ
 39O/ytIsMAUA7kDsuULwBpNAoWo0If5rZ5nbLxy5X2c2FHcDbrGLZTuoHkY5v5hPWzPV
 wCIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTVocyFbSDDz7UMQHKekM/kCJEvQL84XHaVWnIZkFdkRbykv4Fwx0xBYIl4ufQITP2pyS9pMM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxJezSdgWQhCcBTVp/p6d6blpNApBeHJfIGDK2q1gDYwujsKk55
 zWQDwJ1mOL9CraG+WbvMT1Y3RrL4uAHW2r7keh+nj9BE1QZTToMezP5ITfOqzLeESZlcMjxg4XP
 xX6fQJ0Wk5XSWE2RId831XLXsFxtj0Pxh0LzPWvuWYnqAqQO0TLe+FMLXX8PdZjNvxKf8tZQ=
X-Gm-Gg: AR+sD11hhIimff1GmKvKE+42ZR0z6vK1YbTCFU6V26qeFPWU3y5jUjIkPSU8+8i0CMz
 cWrmgC/9CqgsD7tJWztv+fl8PAVlqtbaFa8CV/0WzZb9U4+QGGGbM+4AKo6eMetyJnt9fBx67Ne
 K5hmPEC/29Bc3xdhEbFMkJm33s7NwaNygfPD7hT90CwvRVqhZM6U5p3qx0YdpqaD6p3xgocOV93
 TUM/7vs5xQJtVFnVYloZsIlyDqQKxMv+0bI6csvM8crRMBYZ37oiN/hok79TIDpxeZUL4TVJhFn
 2nOVQQZydqNcpIMVIjyXrwkFXEocYl+OiTAhIHaVShJw5SKcbWV4cykRNMkC7nbw/chFfn6jGQX
 2UdnrgI7HasATZfy/+pm0EZEWWCJNubWDvOu/qrI08OpTrw5nZdUhJ/T/rLRFFkMtP1necUVPfd
 WRgB82AgeSf+jky/A9asNIJdsdm7Fn
X-Received: by 2002:a17:90b:5444:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-3931e02a45emr4447953a91.4.1786600617027; 
 Wed, 12 Aug 2026 22:56:57 -0700 (PDT)
X-Received: by 2002:a17:90b:5444:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-3931e02a45emr4447928a91.4.1786600616567; 
 Wed, 12 Aug 2026 22:56:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf7317a8sm3506605eec.14.2026.08.12.22.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:56:56 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:26:42 +0530
Subject: [PATCH 2/2] configs: qcom: ignore OsIndications for
 capsule-on-disk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-qcom-capsule-dynamic-fw-images-v1-2-e595ff79496f@oss.qualcomm.com>
References: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
In-Reply-To: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600603; l=1366;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=b7IP30NZLN/GhYuWnLjKvJMbPAaZSeYJ0lIFVEWU828=;
 b=NyyMaAkNQ1cmrbz/Xwe5qiTW+IGwWx5UEVMMeGKrVZ6O7tIgBITd7sZhKKP58hVDtzFUyu9Iw
 igkToATZQV3AGHjlxncyJXU22Ls4dZcXZJqoAw/RBOTvdzxMz7yCjAM
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: EDBOr7lPn9Cb1g5ueqEJC78AwhPYPQHT
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a7d5caa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UxYVAnjABKB-LPHNzu4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfXz2iMrcDv+2T3
 B5JqeSI7HCauO/HEAyiVvlevQPxwoTxEOdikcEdzYWP74vKzTCnq9SyO+tQ8HmtaAlkjjCo5/4j
 hpBkzTdf3PyuLxDWHiq+5ef+uyse+Ao=
X-Proofpoint-ORIG-GUID: EDBOr7lPn9Cb1g5ueqEJC78AwhPYPQHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX8toESaczqcEm
 bs6Hblwur//nx56qeO8Zq8x+09MkbQ062bharFTblPX8AxIhtBQRAZ67axoBHOPwnM3L0XlLULv
 pGB5qgsieuPkcAozEFXbRtrwZwwmEO+4gkiVbd9zeeZHp1UNaZprkFRs7Wib5CrIx8TNYuoRKBm
 Y3iodSODiJYwqK+qq1M0iwvEPqPdyzmSNaPeGOTJ2+p0U+x62ca2iZKtpmmmnpUdG8Cs3pefimp
 w7IrrezI8aInF3EaTSNgsj2nNOnPuyPlVDXcUdcjNaofF7GoHXHeL+ubeFabAkTY0+O9UppCRU7
 /wNwtRkD+YEpVCUWUnM3zfUBCG7jvNy7dpXexCHaZDdayj/CR28fzMwQI56p3cg3AIKgPtFJl2I
 oRhWxsk+wBUtk16UciP6J3eoSmx1/CrPZHJQOFpiZQftsbCmLU0ZBHXBlXOzo02dBYhrtoNMI3C
 TcgkZLDVi2pf3+hsfag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J4nySVYO+S2EgoQQHyFEG3c4/TLiNeLzQT6rYePE3qI=; b=emsqA6jDFCOyZU7i
 OVIoj9ZGUoJSeeaiZMW8+Z22lm8TZAqe/SSSVhb9Z+W6LfQ0m4/IkQ1ttguUsgMq
 CS7wp34gsQvwjYRmddMso4hlma88hX//1E0elp4y/1E7pvEWnN8Ty09RbVlLcCbu
 RBkCEQ7eyyf56S2SBalWB8s8f3pm4NxWuXz44q3gbAZqareZ3SqUg39z0WZXSvR3
 vDgSnj0HTE8AGbUIvByjVo0LexgfwtsloMfkrd07Xu/uYQqVZoYpSw3aulHfF8/Z
 eMRQvxMjCn0erdu3v0KNt8lVX26naSd1ghpMhn9OS661C6kEupdnOyqJSuTXUOWQ
 ayR9qw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600617; x=1787205417;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J4nySVYO+S2EgoQQHyFEG3c4/TLiNeLzQT6rYePE3qI=;
 b=ZHrllmhb2sWGmMp6o/uz+Fh5gHJaB0gD+QxTJqHk8t5h93JiLMc1PicgGXrP/iiLaG
 qIKAwbTnoTAtQoRTL5q182spwzOBzciX3BnR6+8NaELPONqbG/cowJ93cZvSnqurSTdm
 pLHbOjYgpeLct7YVkXjYE7YD8yKDkPDbU+j7uFiNpefkqVamg4cE20eSC9Yej3fX6Kq3
 TBanxuC0TyQQvPeo2Kah6JkXHrFpuupEU2WIYWnhS21IiitIxIAqVfumTE/ELd6kHe/Z
 jd2ljz9JS64f5GlbXWs01Vpud9oz5h9K2bAEaBUCBxEHkmm/poDvCCVi9p/ydu9vQPDF
 JNFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=emsqA6jD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZHrllmhb
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

Qualcomm boards apply capsule-on-disk updates from U-Boot without the
OS first setting the OsIndications EFI variable that the capsule
runtime normally checks. EFI_IGNORE_OSINDICATIONS makes U-Boot skip
that check so an on-disk capsule is applied at boot.

Set it once in the shared qcom_defconfig so the boards that include it
(qcm6490, qcs615, qcs8300, qcs9100) all pick it up.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
The option defaults to y only while EFI_RT_VOLATILE_STORE is off. This
series depends on "configs: qcom_defconfig: Enable EFI variable runtime
storage" [1], which turns EFI_RT_VOLATILE_STORE on, so the default no
longer applies and it has to be set explicitly. Apply that patch first.

[1] https://lore.kernel.org/u-boot/20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com/
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..960c44b1f70 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -9,6 +9,7 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
 # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_IGNORE_OSINDICATIONS=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y

-- 
2.34.1

