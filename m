Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591D7C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0A36075A;
	Thu, 17 Sep 2026 07:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0K8feIDJBNd; Thu, 17 Sep 2026 07:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2B3BA6062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629332;
	b=oJwmFwsYKRbGqY+jdXcMWbcjzUJLMUSbOl2Go3iuyD771a7ywUMfmZagPE7WTX5IE7Rn
	 3Q1Flty7WWh+2twu+/P9VtBK+rR9Qj4R688ZiY44RYgzKzJphokTIRMdDT0YFeQi4Bro4
	 yq+9r1p3d/K0Dsaqk4vxcD9UCP5OyUz1lripoq+0icAVwrF/F3h3ZU0kdIAJAWQX8rxIE
	 3GsK5sl0sS4VcAScg4W+Px5LmwFujbV2lf2r1ak3ClWpkjiA2wQ3+F6ZcxjtUgtMhlQDE
	 vsRXqNP+PXHbWpB1YmmIhsim1uxcKtmRcJ5v7CzvklQryWtzXuj8bT8ei7mlC2bJ4Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	b=O7ln8Qo4TqALOg9S6jqLG1Dg6gYL0b1iojXsd9e0xOabJ3bAEb4F+RmaSwr+Jz98ft8F
	 +i8GRJVLEw8IDz/miAL/f6lxXQgb53fTH36lsSgVIxhnZt7ZygV9pUdh3qi/0ZwD2vNrV
	 YBDiu+ow7i5rR9vodTKGsI9k/rmt8s6KkT24U2wnvmXF6mHtk0FN3RsHGyGOAj4kTJSW6
	 /hrP0eDwLQRNMWlwD2i0K7FlD/Zth0hpnCPLqsHzqjOBpZ8EBdaELwBoxH+S08tzGtLnt
	 dDwSBtTmnaJ21F3qrGDNOHwuXt4EbW5nWPKH+jctB+kahJB9u5WZqs+KSrrBDPmH4jA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JbC9+Yp0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cj2ZNBYl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789629332;
	bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gGU4q1l0MUtSLBFDBL+ZkzQJ+zJ4OmTbDwu+4uryT2hktdO3ek9IEFfWTIWRYMaz7
	 gsJ8txBPFvAyXTU5bQOYVEzekIWqmMYFksNSgO6YHzd3XVcBGNRWv4oZ4EdvWF8urz
	 QeVAw6XYqqquKqibilHWqDVDA9rjlJrW0rla5IK6VULD119Q3LvtOljQj+AUblv+Wo
	 0LfJnLzmdFaNTIZbpjcN6qjXocNYRJ7Y0tNtBt/aWvHuIMqM3Rh6QQK5u7WFhLzkGH
	 fZ9zesma/Ju2wf80b2hmaWJc2YujFg7uDgfX/Ptfh23Eysdr90TvA1pibrteSkjoTu
	 +XELOK61VezOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B3BA6062B;
	Thu, 17 Sep 2026 07:15:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2A9F422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94C816062B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ugqvfUi0V1Sd for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:15:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4289D6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629328;
 b=NSoJePx8vt06FaFeLvDgrimp5tykNSzV5Sv2VX6+pG/kBKo9xSMsRp0Hn+1IJq7636n6
 FTewdJNP9wAj3C+W6taJdhaOQyzaXatUifszPBSGkOMzg3OGFDZxiB84bol8lvUPQpS2j
 VzrYnPmlasFgunrQzMTQdSXWFOgT9FkdG0Q7f/zHY5G9J0uhTyK4Sh4z8ZSutRRW6l0WH
 qfJzs5enuzVdEStMwJc9B8xkgdjMG/gfMH0oQWQOOenv6q1CG3x1xrkO4RwOmJrLvTEOv
 wQShBv1QW7QAR34Xhhiu8sLK38iuxyeNltlcFRl41KA+a0sIqYclY1H76txona7vqxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629328;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=piLzextJxBBcNhztct6AmsdaZsBuWP3ozlsjtvWZpxutbnRCHbfAQ5VpLBVAUmvGGu/M
 VUdN60vWDbVO6cE/zB+Unt0vIKkQY+H/klo1/trngoqMyfR6RZ5gsARn8UDEh/A+JaOhn
 9x3DET9cdYjLeUkTVwYPdkJpQjwGYCYPQeeP+m2iQrSY96frtrHzIOOXEKtxcle6QV4rt
 48FLHdKDtytSjZGU0r8HdAWpTvrb3Jj3/Q7wAYh/oI2hsZyJCkEKWUF9U1GxASpo59Duw
 29DGoiq2Aqxoo1o5a2Ngy6LtMZacDlQKDYWOCWusD8ZuyM1NnLhmlvz/FRUGneJy1CA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=JbC9+Yp0; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cj2ZNBYl; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=JbC9+Yp0; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cj2ZNBYl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4289D6061C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60sED1375590
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=hNqixf2OBM/WK4ayNFlj47
 umGz0vK2TYZks2HNrjOV4=; b=JbC9+Yp0kFrNsXHkJkd6aB+7qJ3cff1TFHH8tA
 tdJRdKRmhOr0We6ZRWyjTxu5COb6z1Ny8P/VLSL+PiOVK1t5r5RqaAmTco0BjRHz
 N6hzBhIBN95Dgga1O80ODYMol3Cz8QMEO2Jk1sNCDT4bIKsOSnSHkeqXIHLxOhYD
 QiEXQz6WrUj3ftmBnFKxLFa7TdqSgnfNCK/1+JGPY8NKKB/NKsYmJqj+q2BlTR1Z
 LGuqdTVxPy9jigW/hxgitiZqcWPqgEb91mEMPBMEGcgZcFEVicMLQepcx7VIYZBL
 hL6YrAP9MvYDkND7VwncYcCUZz5WbCZc9ijuuXFraDQekSBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy6atwyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:15:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso766019a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789629325; x=1790234125;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=Cj2ZNBYl7/aT45zD/hJLOaZjR8N7p1YmyV+9/hygj0aeBW4JfIOt/ef7sQmcwl2l8X
 D1m8PWDUttvieSzdX3BKaBRdjwhOnDY6yezbWINESvckfGvEcvI0/pItPjNsAYoz2w5G
 K1kxSOmVYMKR+9IufXwXRQZdk8vywSSPQyOJtmZWQ8KL2Da2C2KpGA3pgaumw10gOqM3
 X9cucdj5DNCC3995XLvg5txOGbaz3ZZumGvlkBwbZhlBfHMe0nZ8L6XysuIBSIn3xdnp
 rk/oR0Zn1aq7hfeFqxw/jqIaVa5M5PqxWDn+bnVjN+2zEeOurz0pZK3xiUIJpBv9gvVS
 /R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629325; x=1790234125;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hNqixf2OBM/WK4ayNFlj47umGz0vK2TYZks2HNrjOV4=;
 b=gdb47LLCX4+ZD2ZY3wLOZnIPk0/uNpF5zkd33x6QhqhIaeWhnf0q3OfP/XxTPFvSxQ
 JblYwJZ/P5Ckf8I/VVQFjtgd2C7KEnI/ayrAjofG211ozxK6SzGiIhYadd30vwA3Ki9o
 eFr3OggjndzQsfgN0fWw515ajoXLE7svyq3ad/61nsUtDuO393Wj9fy2rAh9qmagejQJ
 wY5OhQYsUoin8F76xqOkUKN4OpyRVu/XVtxPjexawJEiOHYm0IB0uf9aF4blmlE7FN9t
 nCs+Mqe5QrPIcmzeoFntFux8lwTBYD9WkRl5cCHS0umgAhgnKnkA7IsOQGTkjNVvXwoQ
 x7UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqCBWpNRqmLQGByPIKzHNsRzO6UdcD6rlttMybIavEqvEPzm5RWS5MTr6zGUXuaxIM36dJjGk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++leMnFIw/Qp7IB4FLhuKEgY+UzTt33fxSW2dbbxHTu6+nQU41+n
 JProezr4xOphqefWxBTyoV+ZbHpWMsFFIiDKhqDBSeKri6ZlGqP+aDVWYDZQRmxGCgKW6FvOawI
 7JzH7h5IvlsItoDa3ZR4ue2VPtwcjUOXDty16E5bP4+BWkrAMVljLwHa21ZD2M68AFPLbn0nfia
 JuFBA=
X-Gm-Gg: AYBFou1hK+LTIT0EZ000ZMprCH2JmEjkAvLbdyixXLIMftF4L4PrPbzpVnrRHZM6iFe
 AjTduzwch2evNjf8c+Iv8yP8Tor/qIGv8zCjTSIj8gKpouI1FFVB8X2DWCiR/FOi9ObVghga3MU
 3xMPhXNlq/DDpd6VXIFc4ARHlQ9pOROxC/Z0VjXkJfXBGMZ4pOHh3qAAUYaTpdqceUNur4Uju+E
 j1jCwbftYfuoQ2eXYOsXEYzCLF3LZbWEw4KSUR+tgMHsjEqscWNy0Ir6oxnpGnlWSzuKydPh5qC
 /D3pdmz40Bq8Aq4Ex2mpTb9zHyS/LCTNnfOfINqbbAEETLxLYqw4R6mZUXO7PYJDynOF/vhAM21
 HOffDba1JJdMlPC4SXvJc8KNhSdw9uE1lWTuGby7VXc73lmiwx22jRMvqXyopS5HQroIZ4+zYNj
 dU/z8qZbKgS9a367c6Hs+iYcQMK481VA==
X-Received: by 2002:a17:90b:2252:b0:39d:ec42:df69 with SMTP id
 98e67ed59e1d1-39e1e4d3ff4mr12556943a91.20.1789629322320; 
 Thu, 17 Sep 2026 00:15:22 -0700 (PDT)
X-Received: by 2002:a17:90b:2252:b0:39d:ec42:df69 with SMTP id
 98e67ed59e1d1-39e1e4d3ff4mr12556491a91.20.1789629318551; 
 Thu, 17 Sep 2026 00:15:18 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm12175810c88.8.2026.09.17.00.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:15:18 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v3 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Thu, 17 Sep 2026 12:45:06 +0530
Message-Id: <20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqTq2oC/zWOyw6CMBBFf4XM2pJ2pGJZ+R+GRe1DmoiFFoiG8
 O+WEjeT3Jubc2aFaIIzEZpihWAWF51/p3A+FaA6+X4a4nTKgBQvtGYVccPIkVHC0TAtubTCKkj
 rIRjrPpl0b48czDgn4HSU8JDREOX73k1NIVilNVqu2RX2eefi5MM3/7Fg3melSKq/ckFCiUYqb
 K0VtYrffIzlOMvXTi3TgXbbth9bEAJi1AAAAA==
X-Change-ID: 20260714-ipq5210-52e1da5af9fc
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 2xts_eKsJwvLosqa0f0zlvz4dixzO_87
X-Proofpoint-ORIG-GUID: 2xts_eKsJwvLosqa0f0zlvz4dixzO_87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfXwwL1+xY7ILTT
 z3q3/uZL5qWky6GCSa1a1CIAnnTLpank3Wr8axKjBaRoShAou3cDiwf7ruk+fD7HH4e8mzar6MB
 Sy5yoneTWidP524MVlOCiduLzgK6dTI23J67Jrw70BSDK/pF35hqlRyguxzbSU7hbBToPVvxmkr
 kEzjSkHt2/ZgPpCd7qTNHIE0nCrr0mvQzZjLoyM6ulzVZBeSfGOyS5hI9Sn6DVwkpGgajHk1YMj
 iBc48vrQakDmrN8A/vJb0wNVGiKkasiaXbBceeYTN9AU0Wjuh6uGRlzehQ2G5+lyeb8zMK/rbVz
 CUScM57UKfh6E5RnIzxpiivLe7FrsIT/N5OxmSHXtED+Xuk1jjzj02xHzdb8UMPosRqjSwQPAC6
 6q+3+DDN+dHlNpghuzzwNuEuigWRfZHIg3AK5koSTh0PsylgdhSoTY0n8fvYGPd8jO+Bb35S+Uv
 x3tyFlJfRvkk+YcmDNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NiBTYWx0ZWRfX/Wf42zPJoBSd
 gn7r0PSJ9lOKWT2KJKDKaQd9RDxPvJvpDQvRJR7FXqf/dWuDYyFdnK8i8n0PRzes6LjuN4ZjGsE
 2NbM6euBSGv2ShkyBG3jdbF66mrGe28=
X-Authority-Analysis: v=2.4 cv=VIRIDNPX c=1 sm=1 tr=0 ts=6aab938e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p580P5g6mWtK41y3Ph8A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170096
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

---
Changes in v3:
- Fix review comments
	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
	- Remove load address from MbnData and for all entries in boards table
	- Remove '--melf' option and modify the 'bin' argument to take
	  multiple files for combining into multi-elf.
- '--melf' was actually not removed in v2, but included in revision
  history. Apologies for the mistake.
- Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      configs: add qcom_sm8550_defconfig and debug fragment
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk      |  2 +-
 configs/qcom_sm8550_defconfig | 16 ++++++++
 tools/qcom/mkmbn/mkmbn.py     | 85 +++++++++++++++++++++++++++++--------------
 3 files changed, 74 insertions(+), 29 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

