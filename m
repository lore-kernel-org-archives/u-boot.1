Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DD2C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24FE4608F1;
	Thu, 13 Aug 2026 05:56:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHjfLTMgWTYU; Thu, 13 Aug 2026 05:56:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 455AF608A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600613;
	bh=AmVz+LUmnlryVJxWGTvQWfLlgyms3bfsIzuqEe7yi2U=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=veDU9hM6lwdByuxuAHJl/P2cU0V6wlZ2g3vmKF24F1NjVHUqmAXBHlQHmgK7NiP+L
	 YZ852nsPlR1ONM72S8S/x4BR+aR9blVsOM8SLQrdD/A+lbcGYpJ81SEUDMbwOjKAgP
	 V7l+h2x64zSPbFOWaBCVqrMiJpseItOmFwE8mtyjoDye/twJNlsn2uwj2BOS10FYEf
	 QloSnoVHEgRWE/z4MAyu6GYLCKFqcTGZ/QzHW00R8iQqg6nZu7x/lnAwyX65v/1NBx
	 6n+Fgs5JAZLUR2dcjaDg8KjjDOhqH2F9qVnEDC3v+imW5wr5BmZCkG8NBNjyFQBvsj
	 pgY8LZIfTGT3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 455AF608A1;
	Thu, 13 Aug 2026 05:56:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FB512B2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91B90608A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ShLWM9plz1FD for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:56:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E4BD6088C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E4BD6088C
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E4BD6088C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5h1WP2189863
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:49 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g181801kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:56:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso1916559a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600608; x=1787205408;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AmVz+LUmnlryVJxWGTvQWfLlgyms3bfsIzuqEe7yi2U=;
 b=jeAnaqsm2ohz0Gpyi4HfLcJmvJnxjhknN5nNNn0Mhhf+aJoBPIc6VtFPLd2LxK2g3v
 JZh4aQqOKkrqeChr4UlkzfLoeKEhzAEbsdzn+R5ZlnZ6Dr+1hPPntyTJNjXhERCOeNgo
 0+EY3tOiWidLwDKV6km0q1Rle3fO+eaevU5/1z3MAcMWxC1vF59uiqHROaePhuSKtQqR
 BSglQQT4+FFy2FTkQtb1yEwD9KQLWfKp0/hJVCYWFjtzGnXwo7GQBD114UoAEhw75IDO
 FoXCgZ+w7E5EtltDVtZHvT9v3WE+J0IRTbDF2VYx7shG4PBoGvOMGVT2Fr3HY3dUZlmo
 6+Bw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3fxW5HWcegZhqW2r6TaiYypznJjGIzCh025eBEBwzMRSpDFBzXQ3+J4ViW6CQ3v5JlVjjhHE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzhmD+7veDdg9oN17ODGVxWvpBZnZgom4M42iaxrGNkcM3jvjne
 pH8Jvo3Ak1zwKhQNqkII8xxIcOt1YG6Up/xJ/wjt/YnUrcecmpJ2sFjm9d3wBexR9cFZcumAUro
 YQviBtupU9Bgj9Se3jqfrBwWMWXK8Vm6f5/BTasOKYZCoUmSyaNe8okmyriXJhhSqy4p+bx0=
X-Gm-Gg: AR+sD13zqR472Hb6mAQjYe+JHHe4LzT3bsW8nhLgyi5KlZY/r1F5trmSwNJY7Znop0x
 09RWwBsaYzzzmQi+B5BWk1FqMAA89qkevI9m4IvN9HO9TXVE0+OltBYO+Ehg25ZQUIo8ar7Ua00
 ZQqLAenx5mpjHFUl5yNLZbRWhtQEKc6Rrm/ikEFH5/OjXWjP/weXtu5js7fWccEX9m4vOaWDEHY
 fs28ZBaMU1yejJiUtz3nJsHVPC4FG8WWqrAXOMOT+YLuQ7nazOFDdJ5+mf8Jur7KW/NkSV1Zth0
 bimyjpv4MQGzoQFqG+VFJiio3sDOJ0/MjQqYv4JyOD2Q9ZWRN6S61Pvxb6HdcIpa9/orxNg7Ybt
 m70u2DR8vR/CEAl+MIv1TYpV+a7vjCq4B3TvATlLYJA4g/EZkhnyaU9qL6Osyi9rkLLpPuYF+lr
 B5zbpMBzwbUJkXBZgc8+PYOVpyOor0
X-Received: by 2002:a05:6a20:9e0f:b0:3cb:82de:b952 with SMTP id
 adf61e73a8af0-3cc550629c2mr4876435637.2.1786600607993; 
 Wed, 12 Aug 2026 22:56:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e0f:b0:3cb:82de:b952 with SMTP id
 adf61e73a8af0-3cc550629c2mr4876393637.2.1786600607516; 
 Wed, 12 Aug 2026 22:56:47 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebf7317a8sm3506605eec.14.2026.08.12.22.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:56:47 -0700 (PDT)
Subject: [PATCH 0/2] qcom: capsule: build fw_images[] dynamically from the
 partition table
Date: Thu, 13 Aug 2026 11:26:40 +0530
Message-Id: <20260813-qcom-capsule-dynamic-fw-images-v1-0-e595ff79496f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhcfWoC/x3NQQqDMBBA0avIrDswSbCWXqV0kcaJHTDRZlAr4
 t0bunyb/w9QLsIK9+aAwquoTLnCXBoIb58HRumrwZK90s0Y/IQpYfCzLiNjv2efJGDcUJIfWDE
 6crajl23JQY3MhaN8/4PH8zx/2OyfqXAAAAA=
X-Change-ID: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600603; l=1355;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Icx7pMwkYXTkv0S1Zh0oBpG3aIt9OO9rxLTM3XVvk2Q=;
 b=IZgkYNifAKWOEGi6wSxaS2epRXckzkiKUVaxdhwQrjW/jrCFBYP3Tr5l+AmYjzMWFr6XkUF5a
 MrycShgC4FJAokoYucyAFYeAPs2ofgBWJ8nRWJm5lucrKLIZvCDQX/z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfXxd8OF/6CQat1
 /0Le57vyrEDitO7kgxf06qxZp7MTeX62IBAIRCkUpS3gZEDriIaBeyx0/s4HP5dMZ8Ao5tpfYbH
 lJpyI7AcuaglYpdbz6O3caC13OKwtok=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7d5ca1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GtNJVZBKoMUgjfP-iI8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: H3fSkeV4zIyNr29sxWwASwVnMU4on-4z
X-Proofpoint-ORIG-GUID: H3fSkeV4zIyNr29sxWwASwVnMU4on-4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfXwdVyvzxu+KFc
 L0On5oTmYU14PX+3XPBUx0RMSNbBeT5Gk/4yj/zzLtPMlmvva/rPSXAaFOGiws+gz9rHMJ2eDqP
 f5IfWjdiyXYImhNMiq+M5hI4DjghSJMhPPlOyFhjr8wKWefS5vb4wuaBz4i4xv8ffjX8UYNaGxt
 GWO2i/sAZg9TQztFUfl59zrqd6rdN1XHfjFoEZ6OYccECXkthz4mrZm+WAGUwRtTtcCu5eGMTPx
 o5VhMSPEMYNmwGP4JMQjH9axqnj2jdN2/9ZN0dBF2SRRWCa4hgPGZRx5JSvPcn3res5kVziAxTn
 SgsjPn2bt3F0BLRea8j2ZUrudmBAwOg/3zjrD1Fpm8JwBzwM+ODoLCZeci+Prp4zsELYkvHzLOd
 sHkUl3oZywDEE1L0CYJNoQ2WyShIUoz/uKGXUZeNcyXdAM5CD3+3CUG39ZBxn8FAd9c2gEEc6UP
 dA/inYEu7vTcIQLpPEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=AmVz+LUmnlryVJxWGTvQWf
 Llgyms3bfsIzuqEe7yi2U=; b=QaQxIiTFDs6PIyYoc6M4Wl8RP8+Aa7PvtKOJMu
 t6cnFHb6aBkF83HkzUiyN09J5k8OotsKr7RDDEH+VudepoUDbcBSVbcYodP9SqaA
 dYg74/LzOVnrBJGs64D8OQ+P8c6WveABrgkqjYHOq+ZeQdrlPgWoefETwB4TwdZv
 pXTZK1Uh8l+7jctU9idfwYSBAZdCT9dQXNTjObz8+/O7F2g53bVDFo9dLbgkJk0p
 x5/nMdFoE+P8+jg0h1VZWNKnsJTEupRYYSGndQb5SSPkqSAPPvTzXNh6ZqLFTr3Q
 KLPF58+J0/Kfo3W4EsxqGKYStbHzyUHIHKvzn3eYByM2RUQQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600608; x=1787205408;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AmVz+LUmnlryVJxWGTvQWfLlgyms3bfsIzuqEe7yi2U=;
 b=R9lWzLfz4Nosa/PRocpJafKFoB0o8FbADdekKAKKEplonO5tRXUli0o/BjWxMJaZym
 Khi1KXhXBaGQcbUNjJD9yWuTkemYKvIm/ySdvCcR3ffpHmSImBEXAJYaWo+tpt7WgHk7
 OWA710AKo4kWvPHLdGB9FuHf4dIqNIjPH984yV3BUELykWSws7SU+jmwaF4OzPi8cewh
 9wPDy5zsX4ij7xvscf2DZ8+nMOh6w2vF2/XL682I88RT64c1FujRWCF6d/waErQOavO0
 sdiE1AYC+K3xc0rp0FrPxGnZTI0CCj7g/fIRPx2BoZ3C15+H1/iqwYmqG/Ufi3c/e9WO
 nVOg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QaQxIiTF; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R9lWzLfz
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

Capsule update on Qualcomm boards currently handles exactly one image:
U-Boot itself, located by find_target_partition() and hardcoded as the
sole fw_images[] entry. There's no way to update xbl, tz, hyp, aop,
devcfg, qupfw, or any other firmware component through a capsule.

This series provides a way to support capsule update for multiple
partitions (not just U-Boot) in Qualcomm boards.

This series depends on following:
https://lore.kernel.org/u-boot/20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com/
https://lore.kernel.org/u-boot/20260720-runtime-v1-1-7f904b4cb3ed@oss.qualcomm.com/

Balaji Selvanathan (2):

qcom: capsule: build fw_images[] dynamically from the partition table
configs: qcom: enable capsule updates on qcm6490, qcs615, qcs8300
---
Balaji Selvanathan (2):
      qcom: capsule: build fw_images[] dynamically from the partition table
      configs: qcom: ignore OsIndications for capsule-on-disk

 arch/arm/mach-snapdragon/capsule_update.c | 757 +++++++++++++++++++++---------
 configs/qcom_defconfig                    |   1 +
 2 files changed, 531 insertions(+), 227 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-qcom-capsule-dynamic-fw-images-f303270b2503

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

