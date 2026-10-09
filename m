Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B703CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 11:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4FDA606A0;
	Fri,  9 Oct 2026 11:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6uAYAxlGhyz2; Fri,  9 Oct 2026 11:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF90F60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791547174;
	b=B3paCiWmcF98M6nnsmev6bJaauYsDJQPA4k1Yl75OUfA+BmOtbxwo8vOFweSU5oj0xaP
	 xwVy/JoJbNhJ9ff9/ZaZUrbQaID3C84GiHVmRnO8FeOr9a+/r5mLGy2w4Pr5ekZeMGs86
	 AfeTsCFIbwTx3Jkvj8NPec5rf6isLe7vfk/CsiYJ7ib9MXRh/Rtif8XCyyGZWB0+9koli
	 DeTFJSBZxeOt2t50mY904P6yey877PezTPOCevhS1PpkljJUHvYpVN9b6xbJUroAM+rnG
	 Qm/dA7TJ8Acw7tUYpw7U5jg43A12bQkLnaZ1bhJy1oPhtXrA/2Tyhe9224uP6X3b5vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791547174;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwCG+Qymy1E=;
	b=p9CEJolLpVAyHe8AOApn8FpYd0cSsrQ09tMQNDBv5JCoOjRupaHXBLyI2DhokrMCb8xr
	 7QE8blNmKWV6DEaO7Qc4RFozxn9yWcyu9/JeeI+g+YKaUV12KJLjROQOA30fXGI6i3DGd
	 JN9KNmr0Bx940KibHJGRrmchFAZwEz5fAD7g1/hgDl1s60Tk+ulsG5IHlnN5hOB3nlt/W
	 88AgonvNGHMHw3uhjgLVoRBXiSlvqjzprq8EwMpFida840K5rOG2iSDq7B3rJH72FbFH8
	 5hNagkUSAizEkgCbykCauUhfG4CUE4jOfRSy3aoF4dymGM0JL3Yj45bEcTwY3+xf4EQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B955cUpm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bl19RQGc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791547174;
	bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwCG+Qymy1E=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qHe9yyf2hwkyFz97UFvCD1SrOHdbh9loSl/hYRDCKigZooMLDkx665xT99QUhOF4k
	 1OwpGrBthXzJZzlWwiF5mLnngCkq4S+HEXoE75WG0fedVB+KkhQnrQxaqFgIrqB+sy
	 PTgImiuw9jf835hoFuiN+esxVERnTXE6uBl3rxtJvoW4j0ou8qacmNX6ZgDFjhRlQQ
	 6e0lw60/Z3HzxQplyxbJx+nAgpUFVu+I5kG4OzlFsT9B4GpQdejiU5rvE9IdmgU0x0
	 OeKmjPnytL8kNXsuATtzpesJeUuGIUjGwAp/9DCaFcWKG7zOAE+vD2OWuMnGdgKVNo
	 SRNfrawS8ERPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF90F60680;
	Fri,  9 Oct 2026 11:59:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21C5C156
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F29D60680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFWwQeK_fGXt for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 11:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0B086066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791547172;
 b=G7CmKBVkoaA5lpSHEsLihmi12sSFjaV1y3UOre+MD/3arLQw7UMjd8ntU9noTU0vhlqs
 +D63Qbvv55f8YZoz7V+6Oilsbo6N0G3aUdFtJXY/oZb8ojrZYgbEJoV+Pz3JT6SvkXOrc
 PaPGXUE8Cyw8aKvCso28oNQK0tSablDlV7FeNQGpv3UCFX7CmulHVoKQRWbEVswl7QGtG
 vUOqvh7IMu8y55uUrky+qStpabVT6UMe8ceJx56GAV42Tx4QjqJc5n0S+OjHumSs4p/sD
 GwFYEcUL9TqQhgf1gszEupzk0AYKJ3w5msTmUJO3//4BZ76mKzbSUCLRX9wOnS7GIqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791547172;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwCG+Qymy1E=;
 b=gfVAWwYhbyQ9U91pZq4zwV/gjVGFT9xzV53jBANxxNXt3AXKsfWfilJi2ANY3F3LLZra
 DO9a15hjSeOBNUm1QX1R6tlRFiZ9Ze+gITgnSIgdyy87SCFl5ZNtK6YSrnUJf+/VD6Ouu
 1EY0dqi8vim360bFUFM0sDjKSFkJvE+SRXbM7DI/fO31ZF47JcqxmvIws/6MGO36PDTnu
 w5kw3S+ffzGxxVyGTj1s+Kt0DefWuUzq8HNLQ7hUXafasVTayav/JfeYtoyCtdJTqvsCE
 Dm/XIEBe4V/7tqQRcqbEuf9K2Ckre+XiKiCNQdgWly7R7cqiwxqhbvP/BT2Eod47iRg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=B955cUpm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bl19RQGc; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=B955cUpm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bl19RQGc
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0B086066D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:59:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699A4rXU1336510
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 11:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwC
 G+Qymy1E=; b=B955cUpmuQ5U/fVJ3ly6N69H3iLRgmN+iWTKAzGULmdCP25s7F1
 p5sMlcnemqlkbu8u3bq4hBNtIRc1SZcetvg/vP7D/bR3bXs6sa2DACaWf4Iw2czD
 d2KDSzamrpzFPbc5UouCsEt5oO7KwqihXyrlcmI7cuPtKmHekVk7N7jdFwaCxfIx
 nV6eFLGUhuymumyh+I9xpxRkHW+84gF7UV2J8a3n3Yk8LpXWGzSO7toXXuhs5DqW
 UnOAY/e3B1bxNh81n5ybiCA/8jnx7jmGfqS8yEGS6gSQe/stqLQ9zsp8xd0+/Thm
 FsdtmFW0GCIb3oTqBNq5AcB9yr0RfPoohaw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6x6wgbrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:59:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so13360837eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791547169; x=1792151969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwCG+Qymy1E=;
 b=bl19RQGcjcgdyMkmsWTbUBNTeYFBPv3/1WH/b7Ffqr5Dvg9BFtIZuHy2zrvOceFedv
 ufuIewmjXC/v0f+ibiD5Tdn6HWzQImzIJrGw53dQX+zuis2CBWULgGX6FKqF1fTv9qad
 43MWgc8EKqNd4l2KFjge3tHQyC/PGIRq7v31Gq7WI/pZ8prHjk5WCMktCbZf9Sx8KEpu
 7KTgEWLZ59M9GMZwZCeFNF0QC9jirNL5KC0FOATnYOU92BIqe04BNR2M/qmAMPVrTRkO
 rqgS88x78y06Z7RYFbvLQDiWVzJjxvixazojyyXafMIlyQ6iol3FXi8SW8XroYVA83Qy
 1aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791547169; x=1792151969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PyQF7OpOopInm4OIqkzsDj97X7Omp+ShSwCG+Qymy1E=;
 b=KyYQElGpRSHNWE7BNR6+nMArttoxAm/x4BfDiL2KUcYTsc9UCjXxcE5VYLx6VMrMMl
 lSlojAXVZBGRJYNVoLP0r+fOv8smGAUD9Y+d50EBynNq7U6cmGaNOLgp/UyDxPLioPKG
 9f690zQwbbl+CDI0W/yCGy4XRpQTeiExHkxAAiqEW4l596YHgzfwM298sCLWGiP61Fyu
 5ras8hndVkaqiZP6RtRdiHIbsqrAC9yy0rZ1gQCzguHxxwUHAIukAn1OJTKII/QH0pts
 GbHGTf/d4U7DGNKAW/rzY6xraaUB+LU4+UlvbjgwpL6mVlyz+w/cB4PdqUagHQ5WlWv4
 xNPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwKiqU3aD0Z3oBqZeHWa3LwVvSe31jTGw795oStz/a1NrlW3TEAHg8aRYYatkRMp1Hj4JVrPk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lfIW6x2gPjcpd/vBQg0GRskZ6UYXzhAZHmYhndVxE9rV0QW/QK
 PYNwlGAA/mC2SgfBmpjQnSJxJV+QunUf1Ag9uoObw7nvOCUNst1nP+2Om8FerxH9WSCYHB5M2YL
 oZNzKVwLewFEeIKYDZv4rcK4z7GZbqrOTTbHOEUyGOvV/3YwjoBC3ayFf6Erz+Ovhlz+IG2M=
X-Gm-Gg: AYBFou3oeQn1s3OH+/7O1Z7x07iIEG2fRdZtf30RfMDgQA+T1GG+/m1hCsiCCAa/Rns
 8V+xOzwPaYNt4dqyTLTUdmibceq8J9Tl5j4XdjVTqCVGaG+/pMdDmyReKK67WrLKeTWIOWjLe4d
 da1uC9n3yWxP0pmefsAiIXm34Lf/UzVBgNrnirx8mA0tLgiFo1c6//0P1AznasiZjR9m7fM1mn7
 MAwwgPi6dQ+umRPSYGq3cc5pXK8/Y+AH7QAEazsXtMgOAl/ZJ7iQnSnt4jUUNPli+DLoUnAkDuw
 0LG6H0ApOfAlu6Xt6UJN9xJkDq16PKhFHMGDGbwsL9vv6I0TL6EnJtiFstI/wcsGY1bmrCt8Mxl
 5bIyo4axC3MAQI8El0x09QUrAT0y+Na/L6AqaNMaMP2i2Cn/BV5OCvY8yuaLRfVB4FMz049Aw2l
 J2XX63SQIcehw8GjSt+g==
X-Received: by 2002:a05:7300:fd0a:b0:351:25b6:c867 with SMTP id
 5a478bee46e88-3537dedd5d3mr3675367eec.2.1791547168753; 
 Fri, 09 Oct 2026 04:59:28 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0a:b0:351:25b6:c867 with SMTP id
 5a478bee46e88-3537dedd5d3mr3675325eec.2.1791547168191; 
 Fri, 09 Oct 2026 04:59:28 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca67b21sm7187100eec.11.2026.10.09.04.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:59:27 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2] configs: Rename qcs9100 defconfig to lemans defconfig
Date: Fri,  9 Oct 2026 17:29:20 +0530
Message-Id: <20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NyBTYWx0ZWRfXzlkoSXN2TzbQ
 jupjUqo2g81n0Rn8u7zzracWVkumZcyejIz8ZH+zEIkaQ+nE4KgGilsfz29TVzKY1KmFHRiDv77
 kLV/Toa4ZsM/MD/KBETe4VwBBDc+imY=
X-Proofpoint-ORIG-GUID: VtoSS-j-rHKq1e8lNVOZi_HIYXAaJUNl
X-Proofpoint-GUID: VtoSS-j-rHKq1e8lNVOZi_HIYXAaJUNl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NyBTYWx0ZWRfX2Kw20lBOVPMw
 i4iKiaFpU+JOj3K6npA29NbCwSYcETE+Bmuj2XeCJ6XvYvw6GC9cvOAvk3S1XPCCpphtTb1xAYa
 ucdnbjWeVK4Vu0v+z48uWTa6XoO2Jp3Uw+spS11smtpfC9rIY6W0dvpJHsylC5CnymwmkHZLeYJ
 +Bjs12muDTcJxCxvBn8P3XZf13vXk5v72fHTRhzfLZ5Vd4yjuWIttY2E62acS+2bWKvomggwKoU
 20u6WxWJXBjjLXXbOwlyZjJyF3KJpQc1unbjUnRHiXEVgyJ8mCNkybHwguG9/SbxYHlC5WmpRQ+
 RUDgcCuxPRfEleE4/zn+WfwYoe48TDFM5/xeiRTOdLONR3WOvcnTV34hGD+FOgvj2tuA+f639Qt
 /cfmJNLF4W6fyMTIvWWZUb5Sd/2YSK0vPR7O7UwG5VvLlH8eUeZaX+in0NZ4QbUbUIF/xuN2MGb
 5GnJEhn/E0bNAvWApQg==
X-Authority-Analysis: v=2.4 cv=ad30Dhot c=1 sm=1 tr=0 ts=6ac8d721 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bzf1J8flYh53ol4bH3YA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090047
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

Lemans EVK is an open evaluation board based on the QCS9100 SoC and
serves as the default reference platform for the QCS9100 family.

The existing qcom_qcs9100_defconfig currently targets the
qcs9100-ride-r3 board. Rename it to qcom_lemans_defconfig and update
it to select the lemans-evk device tree instead.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Change in v2:
	Updated the commit msg

Link to v1 - https://lore.kernel.org/u-boot/20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com/
---
 configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_lemans_defconfig
similarity index 91%
rename from configs/qcom_qcs9100_defconfig
rename to configs/qcom_lemans_defconfig
index 1cc04cb96bd..1710e317fc0 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_lemans_defconfig
@@ -9,7 +9,7 @@
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
-CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
 CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
-- 
2.34.1

