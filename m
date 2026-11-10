Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48C606A332
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 22:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qnx5ajhp;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pBOI9aV1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTfjSNRF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D864440A36;
	Tue, 10 Nov 2026 22:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2vgKRoxnTHA; Tue, 10 Nov 2026 22:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CAF7540A30
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794351158;
	b=oFnssUqu11ofTZ2AlNV/qh1FXjiiqUqoqTP4FW7WMJ8/z/r9n0+612SCUGtdNeilk8RF
	 78LgTL50voyBDd4HASHgw1/EVIfC2VWBZUFxiQtFHjJdwN+qav7dZfF4rl0WT+Pv/dZKG
	 QQmkLbQseqNDWVzO8FVvm5wV/Xzc5uYTuUSs2Rcls3oVnVTg//8RlEj8ejCKV3/JubO5T
	 7JwtTfOrJznh+OLBvAZnoMrnQcS1AW7qQVwNzB2oRAQzZ0sfYL5XubmNZwLdmekaKHPK3
	 H9rHlWA9E7CCd5fJyMDI3ppD+kJv2bP+QglDpBmOquoFK7GOc+nHKTQysAjHp410mqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794351158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:MIME-Version:Content-Type:Content-Disposition:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C83UMdKKf1YqC6eiICXeudkKfE2P8rRGSF4eK5WD/u0=;
	b=Z2lapF7/pL/vdXIMSqfHBu0gIaL6qiA2hKb/Jwr33S1MrVEpMkJJVBZWUkO5z1/uCC1k
	 4w6qr1kSMTMLjdZHwgrwcN0ekAegNv8q8aRYvn3tNDaPT5CsHEb6HaCRDYVuanyHZCWDS
	 2YJ8Ko/uGupJfQ1X1rzlef8E7aO9ggWqrHoazOmetvk5OvYG3H/zFwCPk52tBV1fxWNFZ
	 Xa3RoN9GaNyhTSG2bUl1r8vKNjO/RTkw4DQDf6b3ipG0GrSMwqw3OPy501Mr8PVwq4XD1
	 H+c6PXxfl4ONa/Z9AlpPUGmXEHHmjzVcm1Q/lif+JtFZX6Zd3S/mCoLIZQ8CgdOU8aQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pBOI9aV1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTfjSNRF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794351157;
	bh=C83UMdKKf1YqC6eiICXeudkKfE2P8rRGSF4eK5WD/u0=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qnx5ajhpj/cJGyZOj+BOMWLopv5XggHVZjlAkHwOIeT5BaUG+XWa7MAW2TjJ1XpIX
	 MgQXz7ZquCMMPGSNuVNO1Y2eM1LaI57Xz5KbI6Aa//L14rhA0QuxgNdea8toYwaO0y
	 AMO4kMmaNgohhBcX/bFLHgxb45k8U3Yn7aNuDDibgJ5f1wNznOAKB99O/ljc/XgZqz
	 YEY+ad7N6fGV9nmF5YMVHPYNkOfdDQhBknIHSUIHM7mcUi7lqJmwmdVr5MK1d/Kr1k
	 SdLAF+FaYxZipe0TgtkQx8LJ6gGkDbxS4boMQneqBOznABE3zb/JirKumqZOM8jeVR
	 t3jWPRJKlPy4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAF7540A30;
	Tue, 10 Nov 2026 22:52:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC1E69D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E09C640A30
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yrW-gKB1QnL for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 22:52:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A95D740A24
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pBOI9aV1; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NTfjSNRF
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A95D740A24
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:52:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAMKuPJ1113966
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=C83UMdKKf1YqC6eiICXeudkKfE2P8rRGSF4eK5WD/u0=; b=pB
 OI9aV1SCiSe3TmJS0jjDCwPbiH4Lg3D79ViRC8f0CdvKEngXAY22hwaSTDZL5Zaw
 BJ4FOnYm4P5dpi6uO8YvBFWnjceQudnnbFR5p76k3Mq1Mj8jBZGnCT++WHV2Dt8O
 bKfSkAorKZZ9M1KOdz7DUwj8i8liob97pCVg9PSof6etLdVWHJkhtJSgOBlRdnrO
 FIjVRgbUZab0UwdWpi+bOTjJMGtPIf3wRingOuDghcUsuSzj0GQrBQ+f/EEJPrtm
 6o8BC+EiC6xuU1qIVRbrsCPwpqXTsaUp6freU8WVqlNiT+fBzugpusCn9oX7vwIp
 tZ85F3iFpsyw9JE8LxKw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c8tnq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:52:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-37549877380so1955571eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794351153; x=1794955953;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:mail-followup-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C83UMdKKf1YqC6eiICXeudkKfE2P8rRGSF4eK5WD/u0=;
 b=NTfjSNRFtfoVa1+wERtVYD2Go51iX5YycbpHiCPZm/tBDa25gkf/GWeQvaRk4dWLEC
 Q7Oxqpz8shjOXwRMWfBUoYP/K1rqVT4L3l7Kl7hqcaKYNiXDCmqpg6ILQiG8M8SNZ+oC
 t4UUSXs/k4v0OoLHViJA9MuOavaIcZYgagwYhWv08jgcaIVtkTJ94srtg5BJcesKVqvS
 da93unJyLULR/3xQ7UGTJ4YtoQMVz6VI0HFiusOFBw6JOaGwJKEkGsSYHkb4AkUvv9MD
 60Akf8loduUT5KXKunPcrZvn6CoI1GKdKPun1LDriyIGgglyXRONEVNuv7wSYlA/hfsU
 cxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794351153; x=1794955953;
 h=content-disposition:content-type:mime-version:mail-followup-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C83UMdKKf1YqC6eiICXeudkKfE2P8rRGSF4eK5WD/u0=;
 b=Y120YJWtKbqFpt907b+RA+KH9mt4sBEkQZpxu6rsTxu5Ms0jlvyrkLxCpagys29qOa
 KNW4Sh14SXknf7+qFtRMmDmD37hjuDh1OCkyILfr3qjBAtqGYcUIDltoy2h7+IaHvwYR
 S/inLqV+KSfz0QSCUqxDXwoH0zku28aY9QHtol5O+8ZLGoFGBXutoyRAeLoURMaojdJo
 fpm3knY97FatvysqGbkqehhRgiEfnIbvPZ/RK25El3tundq/b9893F54Qb8O7KAHpWVQ
 7/o7ZoBd7jbxinPPtoAgJTRrKTE7jHsxg5vKau2WR4GMkvqd0A09QepJJeYigYr1ZMvR
 560Q==
X-Gm-Message-State: APuU4Z/nS9/+6NyljQ8noVCspVJ6qOoCbDW24iutcqCWiSR8U5EBUVTJ
 q0P8ZVPyUbwTfkfXMplKPba57Zd581bmQN9JsCADYpEduFj7G2lk2kHFLpUh60oAlQ5emMVf+dc
 EpOZAmvHyJO0paae17Xd4oClEo0Uxnn2du+YzZPoKb2XUviv1KeCLVbuFz9ITi+zt2b2WqPe1ig
 7QYgM=
X-Gm-Gg: AYBFou2URbV37lcSQEiUyY6YyLR3/x1ntU/kwxy2UThzlilS1mCItJsekpPpGDUul4g
 /RG4UpBKtEaZ9qEUrDjp/ZCIJXOBIgVj86tlfMjxZCTxsX2s21wt27ChpIjVRd86XgCcTU4c+8l
 V2IyTiySZl8hXDA3vUQJNIUwHXMYJiBzsoEK2AFs4kPYf8Y8wAYIs6swc/V7iMljt675v/OyyPd
 GauuTjaYmH6NCu7w08X7XuVftUePm8JqO4jfQqBk7c+3StM2GVj3iph0yMyVFN6N3OkqImCXG5K
 pUVF5bN5uG7TCKHK01mn1X9v4eJtH8OLjTT8DRGRzyxZ5RozqZi827QdFI+X67+ChHQhsCbXVCd
 qKWCQGG5gSjQXR38/dDmqZqIv5wQhXJfNy+8oPhRafFVxMUkJhAu9k7t6tjGeRmZwg5/L+9nTHW
 CL9emvHQi1KriyKdyNiO4Fxo17B0dn/g==
X-Received: by 2002:a05:7300:10d:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-37683955a52mr1170843eec.5.1794351152657; 
 Tue, 10 Nov 2026 14:52:32 -0800 (PST)
X-Received: by 2002:a05:7300:10d:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-37683955a52mr1170798eec.5.1794351152007; 
 Tue, 10 Nov 2026 14:52:32 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375212e76e2sm10939660eec.24.2026.11.10.14.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 14:52:31 -0800 (PST)
Date: Tue, 10 Nov 2026 14:52:29 -0800
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, trini@konsulko.com
Subject: [RFC] blk/scsi/ufs: scatter-gather read support
Message-ID: <ptmm7jaltdwuyxj5ks26oht2cj6ckp4at6prvra27l4r6idkiz@xzyj2s3spx25>
Mail-Followup-To: u-boot@lists.u-boot-project.org, 
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com, 
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, trini@konsulko.com
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA5MSBTYWx0ZWRfX9sOnA4p2ngMt
 NroYCsuwogIxB7PSWMTkfhTF2VO/Lfj4Fx+O2MXkYOV+dY92YYThb/Thzd1rlZTD3TuPbMppaMB
 Fka1KlGHLniPWUv7wRDeswgbuXdXVhScm8qQMaug6L9sK71//znXlg3nI+/P+PdPDv53pz5QM03
 Ho5oNUPInKZmEVFALG6DmLq5JnKBBakgFzuF35e+F4IqRc5cer++oP8hEw29iW/1zOysDddtwdY
 8Za6KPRPUB8DuAub+dHdNtEX7gjPfIA93ki+llHrYhId7bonDXHK6IPVZzmwaGO8B1Bt4UVGaNp
 Znqcp137NnuBH6269PPu+Nzf9sC66dLemg6CU4yWbad6U6OShQsgrGuM0TMOT42s8nJfLbfGe8/
 qafECA8FgtJVPwJ9j5UUTWu/N5Dzep1Bt3La82CJJZjzYliiV1kRqfYcfLZD8P8tWiAXl78NuZ+
 qrNq36jZH4a1IxplMNA==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af3a031 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Vt2AcnKqAAAA:8 a=1VxDqnHFAAAA:8 a=7isBhgCY0gcKgaBrPPYA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=v10HlyRyNeVhbzM4Lqgd:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-GUID: y4WazpNUhoEjL3FayZuZkvr6foj9v8VI
X-Proofpoint-ORIG-GUID: y4WazpNUhoEjL3FayZuZkvr6foj9v8VI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA5MSBTYWx0ZWRfX5C8K/bXH1tS+
 kgu+zFpDw0icbdP8kqrJdwi/NoiBKm3D8QrTv6va4Y6t6oC12cUQKxZh9/ABb37k5ffY4fq1iU3
 sdTK22gUm9ZHcJIteMHj9UIK4BM6qVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100091
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I would like feedback on a design for scatter-gather (SG) reads on SCSI
block devices, with UFS as the first to implement it. This is
a design discussion only; no patches are attached. The struct/function
sketches below exist to make the proposal concrete enough to comment on,
not as a finished implementation.

Problem
=======

blk_read()/blk_dread() take one contiguous destination buffer. The UFS
driver splits that buffer into several 256KB PRDT entries
(prepare_prdt_table() in drivers/ufs/ufs-uclass.c, MAX_PRDT_ENTRY), but
a caller cannot read one LBA range into several discontiguous buffers.
Such a caller has to issue one command per buffer today.

Use cases:

- FIT images: a FIT can bundle several images contiguously on storage,
  each with its own load address. Loading one FIT means pulling several
  images from storage into several different destination buffers,
  which today is one read per image.

- ELF loading: U-Boot has no path today for loading an ELF image
  directly from storage (bootelf expects the image to already be in
  memory); I raised this gap earlier in [1]. If such a loader is added,
  its segments could land at different, non-contiguous memory
  locations per their program headers, and would hit the same
  one-command-per-buffer pattern.

In both cases the data being read is logically one transfer being split
across destinations, but the current path pays for a full command
setup / UPIU exchange / doorbell ring / completion poll cycle per
buffer. SG would let one request cover several destination buffers
instead of one request per buffer.

I do not have measurements yet -- this is still at the design stage.

Proposed design
===============

Rather than extend the existing single-buffer read path in place, this
adds a separate flow for scatter reads that runs alongside the existing
one, with its own error handling at each layer. SG is not inherently
UFS-specific, so the block and SCSI layers below are meant to be
controller-neutral even though UFS is where I would start.

1. Block layer (include/blk.h, drivers/block/blk-uclass.c): a new
   optional op alongside the existing read op in struct blk_ops, plus
   the scatter list type it takes:

	struct sg_entry {
		unsigned int addr;
		unsigned int blk_count;
	};

	struct sg_list {
		struct sg_entry *entries;
		unsigned int sg_count;
	};

	unsigned long (*read_sg)(struct udevice *dev, lbaint_t start,
				  struct sg_list *scatter_gather_list,
				  lbaint_t blk_cnt);

   with blk_sg_read() / blk_sg_dread() wrappers (LBA, scatter list,
   block count), returning -ENOSYS when the driver has no read_sg.

2. SCSI layer (include/scsi.h, drivers/scsi/scsi.c): rather than add a
   parallel set of command-building functions, struct scsi_cmd gains an
   optional

	struct sg_list *scatter_gather_list;

   member. The existing scsi_exec()/command-building path in scsi.c is
   reused unchanged; when scatter_gather_list is non-NULL and the
   normal READ(10)/READ(16) command is built as today with the list
   attached.

3. UFS (drivers/ufs/ufs-uclass.c): if scatter-gather is enabled,
   prepare_prdt_table() grows an SG-aware counterpart:

	static int prepare_sg_prdt(struct ufs_hba *hba,
				    struct scsi_cmd *pccb);

   that builds one PRDT entry per segment, within the existing PRDT
   size and count limits, with the cache flushed and invalidated per
   segment instead of once for one buffer. The existing doorbell-ring
   and completion-wait logic is reused as-is; nothing changes at the
   hardware-facing end of the transfer, and existing single-buffer
   reads are unchanged.

4. Kconfig: the generic part is under SCSI_SG and the UFS part under
   UFS_SG (depends on UFS && SCSI_SG), so other controllers can add SG
   later without pulling in UFS code, and builds that do not select
   either symbol see no change in behavior.

Thanks,
Urvashi

[1] https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg04243.html
