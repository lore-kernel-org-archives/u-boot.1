Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EEDCA9ED0
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 669224065B;
	Tue, 13 Oct 2026 05:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czKe44XUSrGK; Tue, 13 Oct 2026 05:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A0F14065C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869595;
	b=cfmVRBx++zJf6xsLdfbEERTv+heK0COfLlCWzRvN4XJ1avMeUUvP/A9SKI03/F4OvIZi
	 4rvlwhXJuKLvVuS4xhWnRRkh1JVCNZLkZs+7beUPU7A7t04UdaxoVRsLc9msy/IePB0C/
	 Cr/t+O5JxBvEHo1bsltOw2hXLapPKLftnsTpzjmeB1QW8bEvTnR0m359fMf5+IUaP/BMv
	 8hUf/G+y9Q/G1XVRgcQDiT+T/wvD/fdAdB+/EYGeMr/MrPqRh/OT9inqQcADCcNdnRHZ6
	 5zNRMDvNmvBFG3D7vbBq4GO3yWwaXy/0/PSs+eH/SXjuYhmZOeybMSj6BL8plmEYzMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	b=pI8ReEDa7Oi1cVlqoziky3MZAvwzRQHop38Wpouqwb31REs9kX97XZ9dNheFJcPFcaHR
	 /cVdRm6DxdQcNhgO7qsAIAXiDnNNnwsT33d6RtvwlMKfYUWvH4Lj/dxuyroMzEHY8ojhL
	 iRvVXKdXyvuSZBNNTybiPrC1Pyom8LO03DjCm4O0SxHqFXgVh/Nm6a+0reDmw+/SLCCpg
	 AFQA8Lx1fhl/CGzNesf0l6AbAPgKklMLfy8jaBouAYqSWDH4hd4EZnnS8UyTbPB4twUBI
	 j6IML2U6RA1PMd1cv30UUq56hidR6HpMVFMgrbJLMg2QjXyCL3ToTiJNQaADn3BeQYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869595;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cgxc3E7QAqgo4CHIWq5DLUxUaMYOlg8gMHYfPWqFll5TqSDO2BEQ0693WPYQJf36v
	 gRqKwoklsOWbguLT8sbhWXPZJMOnozWtknWIb4X3eIVrmdH0rfh+3gAK7+6XE0DhcX
	 HV7KRmTjDQ7pQ+BnJTGW6PUn98UnK1ZOLH7ERyX6nkmRNQFNeW4/E8KX92SV2bj3y4
	 LsI7xfp93Wde2vgmdryxYrEIN/IaoT8AnPciMRHx19+zuIAHo8DP3kXX+hkaiZk92Q
	 ipthdHMKbXNZrJTB7u04H81qXKh0udfPQ46RRJBMQeuB6ljd+6eWs6OMEBsDqgR9jZ
	 8+CkJwJRejqmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A0F14065C;
	Tue, 13 Oct 2026 05:33:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E5091399
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFBE480C38
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vt-4LO85Q7K4 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1208E80C47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869590;
 b=Ut3AF1FH8dguFd1c5KT0mxIKNDk+Kp6RjO/lhc7EMf2U5ycN8vaBlqLLiatT48zNSz2w
 YFU8hs4Y7rKI/gL8t8bXtnVxzmOVc69RxdH4Qx9hqElezXv5d4ylnwKR9JzlAuRer2HTi
 JD+hQv/kmcw/2uGlvOg/EnF7PB18kDaORpIK6QuWFOCEjBjQw04R37t/VogjK4sTj5H1c
 mqVAdTGBPBtvnfBNyP0nH+7QKFXbnY4aOijBRMSF/p3MSbe9Y881fvuN3XrJNslco3Veb
 GeoLY6dArRPgdvRw4to239hAvF1t6DBbHEWu95FmPKX+3h8JX7LHadT7szdoU9QFF2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869590;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=hCdlWTLzlZhnAouCVCPOR3i37cxQPSGiaGTT3izpMDsGRkmeGqfI/PyBxnRYTeku448S
 FxbIVKKGK/BHkGNf6fsBPunmtmO81l3DU89ypi6CL/9alccqWaOIp2Zeg2bhukNAcgw+R
 dFRNjgXz6uoSwGadV5OFH+UWkNE4B/zc1yvrW8+sKbl/ux97OZBW2FSj/GNp5dkFDVURo
 dhxDUzuVIE1SnIE/lEJ+MHnfRJuOPiDbV4To5MUwyql9nUB3g5D/7dAL7BoytxZbMGak/
 WoPvSBNhWD9DCvFMuGbrMgHdKxQsIMhA2eH7nbv4tmyvxs2QXwRrjUNFf3HAQSJkmlw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Xj7BowXY; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Jsw6/QKh"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xj7BowXY; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Jsw6/QKh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1208E80C47
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20mwA302843
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MKOaeljaoXm
 S4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=; b=Xj7BowXY/2S3tdfmGelNaZ14S5T
 g3bdk+hJquHHvmml+1Kd1VNmIqLrn/k6tykHrv5UQywRqCMGyWpJRnr7p1lE0WGB
 mvFjsQoWjUJaEZAwIju+fnT19Hug5bTq9lIQbDfyIXAsrMe3t+gJj0N9Im/FK0pT
 3ObTrVjYQDbtmvAeeNApEol5Upnh3ysZteoOegx82STOpuY0bSe4hzyKxrLb4TiM
 UjpZ3Xwo+b0vzfabsnlPkHHqrRX8vO3RFr1J5RNfTExPWR0KU7VaqyjI6NqyLW7t
 26jeqvkxkRxvsYWgh4FQPFd8cMY1EHnN7VY0/d1FHraojerRIZp4G/gMN+A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sq95rj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:08 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3592749a017so2297048eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869587; x=1792474387;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=Jsw6/QKhy7QuL8rzuotEXSpCAxVHoIEHLCW8UMTC90srYZKLOHr2NBWrebTQgGBikU
 rZyRC2X263mtYTsghJETXAK0UomXOna5NAQMCJrCObFA/0mNl5ej36nHCQL4YAOixZYe
 MmZWgz6NfUrWSZ0ta3/uEoUpG3ssG1pB4ybqiQX3M6PiYZ5x8LR3/1sx8vh0RFH8TWNU
 A3gAkExwtZdJ0IaZ3cB48U+zM25Pg03umVm8zU5dEALOQD1OleRYp7iZ8z2BDqR0mEVO
 2pG1XfJXjN2Rnpzl5eLs9FqBGZCFaXzBVuzrMFV9EcDx4hE3U5+R857d4HjsuYeGI/F7
 gejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869587; x=1792474387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=mTc16D4u3GDFDqI/KfRrI4xht9FurTxIiWsshLkEU1bGUSpTukWMTWQrfxld9DlKNI
 9OMOv6Z4hnx86fkfRa06BhFgUb4LaTmSJoW73q5H3Rk6om5zBvXjTHsg3dZhsj0Gz7Ak
 aA/EGGnHp+aqJLQXEmIvx6TN7RJlwm1iL9RkIUj2j+TK13bUTKfoj5rJxQMbp5C5HT0V
 qArYtk1L2XJcUy0OB0kvcKwCL5xDbG33SmFv9k52F2lpEp9+kP3zbs8yqaAgTtMSX3Lt
 In3B9fEcgZwPkwPCgtdwkhv6pvj/dskMhINkGEMHJav7JUJYJfEsxWeZ94d6GkQWnAxN
 IeoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwHyFgI4k1JyB3bPx3oOjTzZawFVR+wTs7ZjAHVaiG4pAXa4Hy/D8dPr6w8nme9xx1glbXtyc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI5hqY6HiK9nbrk6UeMAwy4dqCSFs21gau4Xy+LnKcOZj3MUX1a
 wUV9WDSI/0cyZGRgtXnqq1f9BDBB/6JUlobZVD4HzEwetysyix8DThWBTGp4S084BZSgmyGaL/F
 1qWbMvP3ClIepEI9uXD4Zbh5fK08jJsHQNUCXj2I8DRSOsrpjO1d7NHXqT4XSBxGC4LQv6Zg=
X-Gm-Gg: AYBFou1qq/dT3+cnDoc1TFOSafDRnsPkQawtuVksysI1o5ZSCHsxdbpJfNGRDwMHu8w
 LNz/N+CmRGqFGseEhWkcBxHQaA1rIrs+1S93AsZLGYteHwsgVAfAUQkwuCMFnqRptyyU/JAGghX
 SuLWY+8LW5QQhkA/OE71qRi0eX2LkQH60E80K4EsZTdb6DcQDv4w4JpGxUJ2DL7yVlV5LhVPlOw
 XwQaTdPK4hmQADts4LpvIk1Rx1XdzV/kixXKcuVmoRR9RBmk2YG0roNLzDfP1QJRgqMcgjtkxrg
 Mbp3awx3OE8De81Y/cGzE2Pn4jcA+bBFqzKZOnDZsmEfI66odmh/TaDElBX54GCG/UHQ9RggBCK
 5SNVK9xgapvA7SIkKgpJ5lk/keJ4NFOTEx2QxnvirsRV+rng=
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id
 5a478bee46e88-3536c593e65mr17375925eec.19.1791869587080; 
 Mon, 12 Oct 2026 22:33:07 -0700 (PDT)
X-Received: by 2002:a05:7301:29b3:b0:351:77a3:55f1 with SMTP id
 5a478bee46e88-3536c593e65mr17375883eec.19.1791869586350; 
 Mon, 12 Oct 2026 22:33:06 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:06 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 08/13] mmc: msm_sdhci: make tuning callbacks optional
Date: Mon, 12 Oct 2026 22:32:39 -0700
Message-Id: <20261013053244.2954876-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX24tLrEk+kF8Q
 Bc/FJD/+LLcG9Bd1BA+OGnuwSZJ2uQ8euIDJBQRanBgxOpzc/DiVqfH+K0fuXrZPow9GUP4dAZ4
 2whq/cMcflvZ0fCf5Uc9WHM3HNZ+7IG6UbkidiHiPc8FFyV5gaAPq9kx3IMKdeAV8LfRSKfp362
 5T1F3NO0IWA26asPEn6OGc06Xcx39AZ8weYjHMbGENfNZDKr4udDoQPFCBbRyD9beqVdnZ+nikN
 6xkG41rKq9B/wHi1P6KfQn0iCNGaH8yIshvlSXGeaMST0DJreZN6c3b3e0LiFvfCMtxbLF+UN0I
 bjnrOC0tD6JLjEp/26zxNMYFjpjaUZ/IS/cTeV5XH7NlPBAa6qBJa6DzRSZBwysPsd+dftdT6PV
 hM5ozWtt5i27A8nQNyVlq9qTxDV6jxdiewTsZVwYcSbvHTJ/jA3sIPvGugKJrxytYfXqLFVMgJd
 CHj7swEv38ih0+RKmDw==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6acdc294 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ybWPJh-q2Zyr6sHLyusA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfXy/TRMWkiCzJX
 jASrNqZSDFHlgvDIgWn2VXazVXHjTbKRu0wgKXvRSsp3l0jUTLUWY6MdoyuEPljwoUZtdsUVZpA
 MrqWwiGFbDIiSTQ0+DlQitOnzW+Otss=
X-Proofpoint-ORIG-GUID: QeQWBkeOAuzHEMOx5jQtIovK71dfEbi8
X-Proofpoint-GUID: QeQWBkeOAuzHEMOx5jQtIovK71dfEbi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 503ebf0c5ee..40e2ee15801 100644
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

