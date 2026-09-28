Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877C0CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2B32405C2;
	Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qm3G4bqIw8oD; Mon, 28 Sep 2026 18:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 933B1405B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790618818;
	b=QgHqfovKZ7w8I7iGkjd3MxmE/CG2jOcvIO5kt6ptbqdCxXXMQDMWu0Gwdn+BokDFDYdq
	 m0jW5gvRy5mwcJ1n8THAA9Crrd+pcbncracAiEoBEmnMK0jGLJ8H7pe4YnF2VmM/Ljdd9
	 XsjRZ7exZ0dLh2rkxQsQ01Kz7WPl3SBrZ4ryRIFTQB7g8Z/vn08OpNDyxi2KmkkRcT8Ib
	 kgeMY6UOsVjSV87FxvgcxXUY+c//SQImpEaZUk3NJRRxvrOx90Ourdp+Eo1lAJL0iHsUD
	 GIn9TZ1QJhblkn4Xu0z4Eey6G1GgBmiL2FGdVUKtwZQlOPxQ6w7Fo0MEe9zaizRO8Sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790618818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w6EXhBgKbRX4dz4PyjxL65ic4KzGzyLxDoEqNf9TiTY=;
	b=JyQRvu+4Fo0yPkNmx7dR/yE1JESIXZTumzzUG1YXYe+pklcejMAae0JAZkyUKFlCiDPl
	 Y9eK0AQfbsHoZMFuzNmZRmK41mC+1JCTd5l2sQZX+sBi08IeDMJway9jNWCRwbIfLnBbl
	 y3n8Pp7KhYDXrfwIKLdN2Vkiw70XNacK67WHP97keJV94/v7qYHdRuwgrH8JIPh0tCnn8
	 +PaRoeHBvzyhoKhTUhLOlwLfaRmaU6TPSdBse691EMWwSe3NnylIWJLEMdyhNhYp5ph/y
	 WI6DqgI1IXT8EL/dKNtV7hbJO8IFhsAy1bipAwZLpR3Dobe/daL45nRqFz50Gs79Ncw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790618818;
	bh=w6EXhBgKbRX4dz4PyjxL65ic4KzGzyLxDoEqNf9TiTY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=t6a0Y6cYuMxXfx5RkA6zdx9jEa4JyOA6K3EqQP0K5QC7CbnCtNVkocA+13ws9oUGg
	 Ansx7B9Cdjt8TEABziszcEQDA/KeN9ucWEGGwUVCvYIqNefD8/WH+1717q9lZiE0hz
	 P5OKYfBgrpXCCcQn3Fcc1fZb/WBNaI1jUV35BR1wa61cEDJiD82rO4CL1uZA/sWcL6
	 6ssxegw/Aw1WDTJbELG6g/4SWh+DypSfI8hbbGyfPG7xGhPxIHXqJvdLb8SqtzX6GA
	 y/G372xYVMGXY3mJN76yLGTKfh3quU+LYqGSoX6RtWUzKPZdt89poSZVnPqRKHyXBU
	 4rCNYhgH2T6nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 933B1405B0;
	Mon, 28 Sep 2026 18:06:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4967432A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ACDE40210
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9f7MX-HWXsV1 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2B52A400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790618815;
 b=Q6WAt2pwHvphQE+gyzOmmPxDug9HDfTJ80f3jmuNp5yXjyb6Jb+UjAKxPklJbq8KxnJK
 i12vsSifEbPYzA5tpexgo3iVFT8olkd172wgw5pm64d1+viQsrBghEB7p+bCV0TY/LzZ3
 JgI+FEQ5N5YOGC/WgaW0QuWnrsJSuLhVln5zTbcPQNigkoGTkEi5l44mIv7gm7vQk4LKZ
 dWIDJ/+giV6EROZ19VSzS6nqK15vP8NN/utE46Ufx4AtQ0kPr88iMMzg66akXVsrlc/Jj
 5WZdpcld+hmsNWGLJNsE+8hqNoq+xo9z5QyUTqsDYTrZ4rToVzR1Ssq+B2+FQVTnsUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790618815;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=w6EXhBgKbRX4dz4PyjxL65ic4KzGzyLxDoEqNf9TiTY=;
 b=s3xuet4uswLIcLz9QvoyRF5kBVGTZiz+lSM91hGvo48/DMtz6rP+f+yk6iHtJv7/+dIY
 f0YqtO32Tr3KUNKcFt41JOg75Q4GyP9RKyeASBK72Dngfx3iLm6tXoSMILOmXeUTClgS3
 lgNPcoEW8E4Md9HvM16JI+0H8dKQ+tOCABVlZzuaHGrF0WZDL5FbhJ8DsT7HMgOwJVmo4
 lOinJvPv5v9l9vzjDR/P3mXHOMcx1CYP2e6pDsibMbTfEObpPPwZCbXdKXnyQlyKd6T32
 ig62YI4BxMeXYyjU01IpDUFRYaKtvTc60WOLxNrAnspUzl9Ol7OMEbfCQZn668tv+SQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PR9VLNNE; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=atdHJGTs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=PR9VLNNE; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=atdHJGTs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B52A400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHwUkw1941044
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=w6EXhBgKbRX4dz4PyjxL65
 ic4KzGzyLxDoEqNf9TiTY=; b=PR9VLNNEyTBZmea7+2/bSte5QFOsDgD4sNCG7c
 xio+LZSYDA5ESv7fDn5MzMWNTaUbdft0fwQphilpk8HBij6qIzBdBUuolhoSZaYe
 4UPUmtw38bB4X7MQdYmhsoCBn8aPFSF0M4rtFLjWZb0jwHzMjT/T1BW1ok/RcDc1
 cl+JDFZJxdZuS9WbjKRDwqwSDoA8QpI2PJP4RID1jegKihwBk+VJMO7pwdUglCOv
 u/ly04tB+178k4TlC7e8lh8btN4Eam28nBv9kn0IM9+JrardMxpA+kvSgTM0HOHw
 NBS4st7dFDvU/rG1nbptR2Jrz5O8cmdsWH0JdFQgJGgD8XTA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mtpnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:53 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-879b1d03d5fso52359957b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790618813; x=1791223613;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w6EXhBgKbRX4dz4PyjxL65ic4KzGzyLxDoEqNf9TiTY=;
 b=atdHJGTsRTrJeGyaaPM29s0972p05lVpn4Bb8bArVq9/XxyNDgic2IZtbnDrkgGQ4I
 DSdfL3+yYyd4ogIEAOJO+fiQoPsqb7Ed4t6qpV7hSb5HPKGY/FWkkFeda4mcjuj1LlYB
 adOEvxqwMgc37E+bf1hPj4pV93pWNgPjpPJom3hoMlO0jhRuXOkfsoRAHyh53IZSg2KP
 /w3+OWfOPklFHm57D8rH/khbMH22z0fmlGEnUsS1i1/PFYlJRSR/Vh41a4sBdlDMhkfc
 +RHVUy/6/dn0uB7e2dxS6wQlHlpmxI0RdvLiftzlriutrqb14YM85O/xpxQbJlbGW1HU
 1icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618813; x=1791223613;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w6EXhBgKbRX4dz4PyjxL65ic4KzGzyLxDoEqNf9TiTY=;
 b=cniilY+c1quMqBRK4JdRLfR9i96IKElwqiwQsUvawTBonxSmpkA2FO49jMMNoiKgBr
 spUpIKPOfA+QkFSr3lFiZJ10eI9FH1JygsCBhD8sDC8srT2VKBCaURdft3Bc8D9sKnUu
 DWuX7lShyljsUH9mTSg3AM7Gb18s0SUYGfIWU9lGZsRSP94zR/L2VeVHAyC8AXn0vT6F
 A2eGq+X5ucyUsbcH7zA6lIyyhI8ngot7n32DFf98Bri9VSYY++ZSo5uo2raitbC+99fx
 gfDYmXCgFzbZaZ4nHSjGW8V2QArd3lFoLIQK4T/jFuXF8EAy7IOZwqoD8KO4dX0/In/I
 Ap/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1pFAeBmAvNn4pjLMWuFO24cY7StkElpNlFP3mwS9C4BK2IqBoVEbLOuYVc+LfOGMLYbGL8xM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLl+FZ8RfqV3f/WVW564+pDBK1oSKURnNW05WQMn8LQM5ld8CrV
 MgKrf9ux55+7KMQZW72wyiVLZGoOktjXfunvrjz4XDrQl50Kcit1D9jkELeyEteLF9KBZis9KXa
 aZlQlavbw2Gs3m2L7uRmKKgfZE9qzfnvM+llskhrZIqNUMltolj80StnHr69Ux1/DbisCsftajA
 N0RG4=
X-Gm-Gg: AYBFou2UXLFrcvKM5E5NoZZYPe7DDnRvjMII+F+27UJ4lMUsFrHbBRz6oyKNy+iru3O
 bkjpKlNozZJn9e+XakmdlH0J4lWugQIWxMEgmmmTrK3EyVSB1wnYQqfNYqJGDmKONe3k7UMmFQV
 zZTqR8JbxaFWam95f0WXyZUdVkR/SKpLgAr4i4ezUgBO1RSZuIozAMfJCdIRC85ntCBGBYsu4Nc
 aK2fe9MeNskX3Zt/iNWp2rycz9cBB+49ye1bg9U+gdbApNUTjOTFb21bsjRA+vbBsEAIhnuGNHl
 0o6qr0oB4I2k7s2ooDBYUWg3IZUZc/2Xkm/tFPiQfo6QlL9EL5ZdLP1T5WPVyDuIkAuW4vvEkzN
 Q0UGlirEjSIqkjw8ypeP3y6C18IPET3Gj0ejr2WLH62Gb8tk6HqiJkvR022s7mBp66UaxCkkm
X-Received: by 2002:a05:690c:60c1:b0:873:5bd1:98bc with SMTP id
 00721157ae682-8a64e6e39f4mr60277447b3.46.1790618812799; 
 Mon, 28 Sep 2026 11:06:52 -0700 (PDT)
X-Received: by 2002:a05:690c:60c1:b0:873:5bd1:98bc with SMTP id
 00721157ae682-8a64e6e39f4mr60277277b3.46.1790618812345; 
 Mon, 28 Sep 2026 11:06:52 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm49390177b3.11.2026.09.28.11.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:51 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Subject: [PATCH v2 0/4] qcom: add support for the Arduino VENTUNO Q (QCS8275)
Date: Mon, 28 Sep 2026 14:06:50 -0400
Message-Id: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALqsumoC/32RzW4bMQyEX8XYczegKOrPp7xHkQNFUvUW9W7sX
 Rstgrx7ZRsoEB96ETACv5mR+DGsdp5sHfa7j+Fs12mdlrkL/LYb5MDzDxsn7XpAwAgFaTwuM8s
 yXm3eLvMynsboAUhDyEXr0LH3s7Xp993y+9tDr5f602S7+dwmDtO6Lec/98yru839x/7qRhixQ
 I1M6kDgdVnXl9OFf8lyPL70Y3j7fMSc7XTpD9ge2cM7b3Lo9fc7gWYt1grIGSu1UKML4IyKsDp
 LCbKytXSv/4+C6HNuUFJqUrCCtwRCOVkGTx5L9TnV4viJ6jepRC+Zk2NLUl2PlcoxAxl0ms0ol
 q+UgOv9OLChKHlt0kiTIDqJ6FSrAmHx9JTlXPbYskUGYKoWiMT5SBKSWojYi2Rt/isVyFhDzmI
 Wi+sB5KioMhtHLDmWZMFHefoNy7XvuGbOVAVbRSGhFsVnX0VjdqkouhJuVOXVxtt6pm2/KwaAR
 EEUtK/q8y9XGyKocwIAAA==
X-Change-ID: 20260924-monaco-ventuno-q-63004d5589db
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: j1antdUeJQVtsMxJBXlcT_3redu7u5q2
X-Proofpoint-GUID: j1antdUeJQVtsMxJBXlcT_3redu7u5q2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX2VfWym/zGu7m
 b5fLW7z9mvzK+34BlOQ2iuKlxxbcq5lm52aJYdqHD0F/k5e6PYpeaberrxeMEOf5UAUTrsg0bKb
 eI1nTSKsRIxFvf4Dfr+BLK42/0WiQy2eFw6O2DDe8vX15Dp5zMAd53aIPjvySACZfvPcYtqBFbq
 jX1g0qr20IH2xbu1KdB8MkLDv09fZ6dtzI8r2GUDirEPwjkZt7IUc0bVOyj1kDQu+YiVH5HqKZ9
 VUFMGztCazyD+mVLPDyceJz8zeqUUeOmNGtQ5afBehwFM+Bou55+CQpui8OtVZgQC8wwddvFMqX
 skTxoCYoEiRvdVYyc5CzUdLPJYHXgZ4SO3g7flWEqJAgjjypA9UShdUvSp9c3suia1IUhaAkQUA
 gUnrArdPTOjCpe+F5Yyl0hRdrU2xwse4uIbkzS9UFkegRBzPn8lTxitIBlK6zDGukmGrvPuey8C
 pfP0nzbQkbe52jxoyBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX2dpJUDWTmwjz
 K5/muAZJH4h82hAENFGJpPdphcBE/rtSo2eQOQkt3vXM34xUl5kooL7+Le7fSgAlhjSQpvsZWEk
 FXgmP/tncHIXs5tphIsAmb+ye67vAUw=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6abaacbd cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=voM4FWlXAAAA:8 a=b45o4kL6AAAA:8 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=dOeE5pAH2eQalPq40Z0A:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=IC2XNlieTeVoXbcui8wp:22 a=dhdsR-PFWuPJUldTnwXm:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280072
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

Add support for the Arduino VENTUNO Q (QCS8275), running U-Boot as BL33
after TF-A [1] and OP-TEE [2], both under review.

Depends on the QCS8300 clock and pinctrl series [0].

Tested on the Arduino VENTUNO Q, booting Linux from eMMC.

[0] https://patchwork.ozlabs.org/project/uboot/list/?series=525523
[1] https://review.trustedfirmware.org/q/topic:qti-monaco
[2] https://github.com/OP-TEE/optee_os/pull/8053

Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Changes in v2:
- Rebased on [0] and dropped the SDCC1 clock, QUPv3 clock and TLMM
  patches it supersedes.
- Reworded the commit messages and retitled the boot CPU and board
  patches.
- mach-snapdragon: depend on ENABLE_ARM_SOC_BOOT0_HOOK and keep x0 in
  x19 across the PSCI calls.
- Link to v1: https://patch.msgid.link/20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com

---
Tyler Baker (4):
      board: qualcomm: tfa-optee: enable the OP-TEE library
      mach-snapdragon: allow selecting the boot CPU
      board: qualcomm: add Arduino VENTUNO Q support
      doc: board: qualcomm: document Arduino VENTUNO Q

 arch/arm/dts/monaco-arduino-monza-u-boot.dtsi      | 26 ++++++++++++
 arch/arm/mach-snapdragon/Kconfig                   | 18 ++++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
 .../mach-snapdragon/include/mach/boot_cpu_boot0.h  | 30 ++++++++++++++
 board/qualcomm/MAINTAINERS                         |  7 ++++
 board/qualcomm/arduino-ventuno-q.config            |  5 +++
 board/qualcomm/tfa-optee.config                    |  2 +
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/ventuno-q.rst                   | 48 ++++++++++++++++++++++
 9 files changed, 139 insertions(+)
---
base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
change-id: 20260924-monaco-ventuno-q-63004d5589db
prerequisite-patch-id: c0fef6bb02a82b4f5b61501e49cad1e7708daef7
prerequisite-patch-id: 06388f0977fc92b03e70c487e8034329b387b91a
prerequisite-patch-id: 091a7963c8a71ae7cb102acba6804e07e8aee469
prerequisite-patch-id: c016bba5ae2cd43dfcf4d7c221c621ddbd042934
prerequisite-patch-id: 011832f8e6a00a4be544c1364c57de5627968df3
prerequisite-patch-id: 54ead588cee6911c64149ddaaea6298697e536c7
prerequisite-patch-id: e8b558b8a84bc2fb2c4c4f6c383bcd68179d2195

Best regards,
--  
Tyler Baker <tyler.baker@oss.qualcomm.com>

