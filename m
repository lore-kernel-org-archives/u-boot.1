Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB86606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A8BPu9bu;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlJoEOkF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0T64Bno
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D65480E49;
	Mon, 16 Nov 2026 16:03:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7qVkWz6dQCG; Mon, 16 Nov 2026 16:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 53BA880D15
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845035;
	b=a94Nvve01310zt85v7C4zi4uDrQ1e/6MgW2STWD6Bmj6n3JP7ceYJF9G896fopiptb0/
	 WcK61xTHwiJe3MwZx7Na3QJixhzro8Tompjt4u9FFe+Kqf4416NWTb0BAJcXnbE22cbI0
	 Jonsi3wcDN8HUm+yLGv8qf2eAcE1L68iXphzD2DrTzvkH8k4rvoQ1B1HawImEklTky4fk
	 0BP/Jf6uwT2559KM5Q7dwmy73dVALxTxRYjeoD/VShVHfw2gMekRw/oLgrLQhbwBF+eWU
	 T8a7OxHaFaJRSJdQARtyopqyuMMI6w0bc0WAtRpCTgWhqP8JIVVnT/9tJMY+B4V/Ofw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q/Cny1FoorGwRSZA5Y7vMao3fqqdcNv1Fwlol/7Fw1k=;
	b=FFOKV2n0Aw+tC/6ofAYacsBbFq4qWE/QhCW2lAq5tbDdx6/u7mAcnySy983tUUMGPUEe
	 hW+pmcFfuOJiyBi3S2ZamOTL17ZonQ3oC0D/JccE9lxLNpY05z/mCl7DwsHb+XHwT2b/B
	 eq72uk3vy/IUej8juCfdO5kySC6FBjcYkqzmcuTte2Qu2HG2wqqXt+bpR52UwOjr6ZFy5
	 HIm5j1UHo5IxB360oGNnyZWFLg2lFIy62vNdC+RN9qLTg3M+csqX8BqX0rTi2HwjJQIY5
	 NGZM3nZVOrVesM7I46wG56CEkF0TOLWBmAo9daOsn9SRFWlkD/EGZEgKsGwwNFAJXBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlJoEOkF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0T64Bno;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845035;
	bh=Q/Cny1FoorGwRSZA5Y7vMao3fqqdcNv1Fwlol/7Fw1k=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A8BPu9buouPMn+T2yK6yfHm80cEAaHs7DiVl7Ful3p9M5BHgOPPb1O1XKKbv/B6CV
	 7kU26svGj0SONtwDuzt1WsG1Tx5KHnnJ+F1t09O7R30y9ECLi/XYhOlul++QVmQZeY
	 y7+Kl7dEgSxv/MTEesNubXH6mpr1Y6koZaYxCx98l3JfckoKOtSJZUWl8I6bp7lDFe
	 zJcro38lxaAdukabKSfdN9We1sMAg9yKqWb9EP0N4ifiX4dE9AbNnQLopTYUfGChh+
	 VkvqAxRvwWPpFOmwBfPbXDmMMkAxd2AvC+4wyBxf1lj+Qo6GTZ088PFh8VKjwrLJRT
	 6iHtHjWUcxnDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53BA880D15;
	Mon, 16 Nov 2026 16:03:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F0AC4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 452FB80D15
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-r5xVYIR_Nh for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3323980CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZlJoEOkF; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B0T64Bno
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3323980CCA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGDrYOH1727350
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Q/Cny1FoorGwRSZA5Y7vMa
 o3fqqdcNv1Fwlol/7Fw1k=; b=ZlJoEOkFABzKIqvNF/2Khk5Wf2Sca14XMtO6R+
 +2QeNz4dYwxA5IY71zN33Y+3jZgoRVw0N2sIQIfhbtOoN9cink1NWIj/JXLTKjce
 cHBwLSpmcLQ1F+m3JZdPyotU62anfzrwbYwfwDifp9t6EY57UsEBn1INM0tK9axl
 M5UE3a9A+wXGPTk/D1r5hQbHVolwdqHtWyFbxjjE5fN6WJP3SDmKn30lLzFiY/T8
 oILoH4ShDmUR8WbLrC2nooEjxn9tLf3sYm4gX8UoYsO4NVngc9pgEzfIOUVB6kjT
 Lgr4mC9dz+ILyFuU3WJzYRmsCSkWsgoQeTdsQ6hadyHBb2wg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqhant-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:03:52 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso1694727c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794845032; x=1795449832;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q/Cny1FoorGwRSZA5Y7vMao3fqqdcNv1Fwlol/7Fw1k=;
 b=B0T64BnoZwgQpOlYR79jQtBFyGMKmWdHSuPVO+2/BhVVAE5sMA5WualCOFhgJzEjAK
 1WsB77w6pe/WTXFyPJ03hUYtKI6YXscMH4+uBXFPHbgRMyyOz439zlfYzcoyLOr7VvmC
 nQcthYbT3SHr0j9p27vr/wTjuzCTd7V5o81w0rk6hu4zKOaOZ8U/+tsdDT7V0DVMEo+X
 1JnBsliON39FXNVAb+HsFxcfZ6mIjVUnsRY5Z4plaQ3f2OWgln3EW17dAgPAnWJFXzLq
 REQbRHTqO8bZywV5S0kzdE4r1Hmu1K3039MquYkVBg34amXAm93NCdCsRcwtZMFLPQWT
 FByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794845032; x=1795449832;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q/Cny1FoorGwRSZA5Y7vMao3fqqdcNv1Fwlol/7Fw1k=;
 b=LldpNSv0QTs0KwupkuKdjU9Yb5xPSRr2ggELgl1pTm3dDIJmk9JjwMTsnxSOTsqWQD
 jp1SAbHhDQS8lsiav+ht36BRMAQqrLtounrMJ/pG6moIZ1zecI03PqeeDXu1x2oi13k7
 hX7ecKak45DDg5iTMtMnNtt7dA1mLPvob86jBth+7/q7dMRSkBeOgENl2FIM1pKOmWjc
 QRZFdzdyg/0Ii4v1U/TDS1PIT3TQIGm0rEzYSBwL1wnmQEBcF9bb438kDrDUUUdanPme
 crnCDA+hbrgQq2dAisO+Wsv7iBUpCsQfnIUS8hSw2kyftUFf+k+cKiF7NxpG7mrcgBRf
 A9mw==
X-Forwarded-Encrypted: i=1;
 AL+hErFGNt8/XCb7DgviPyxFDISyUz1h0/qxD/HcE0sz6JBDOyYSMVipNgZzXZo8V8MFhbpdbNpv4IA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z89D8ty6UQg8gHyYRmacL6OMD+wwOOFxQJKHKW1E2BftRk6uSia
 Lc0+w80EYzcwNRH4COyKY9rsyqtFu6c8cv7hV5sNDvxyh/s5XJMqCCS5wqVt5H+gnvzZNn4ZN+K
 7gffcEia1EnycTj2Q2KIIHwAXNTkMI76/n2fSX35QKW0FwoNY2sVLTz1pgtwBCrXSPB3DWmBW/c
 Zsx3Y=
X-Gm-Gg: AYBFou09pYO8GQtttzLnAzu4zJ301DywdWGpdjDnvBCPWQoXigFQMGsFTIWkqPHbOrx
 ELLVabYGqWQGoy9YLMdZrmh+HELoU/sGY389UzuT429AjXG3uksHMt/9yUriDlCuwlAdGuTX+Y1
 VJ5uj1aE37H0vQ66aJOO24EZX/jrgYW3KJ7hcesGNHtlYzw+GYA9EKSNrjSB4qZKPGTemH88K0E
 bzimh8I3TpBbMZC3LCyVfoNPtMVOTIptB9f3s2H5gZmAZhdaYTDldY14L5avUqaOmmNhvM+rn8j
 H9UUStPNUxN0S1I+3UzvCFbCe+BbZ+7uySPUeOk/Sn8iKQQTogVhlVkjqMSuE51dyUHvLASXkzG
 WdzNdkrMwcgcTsKRMHLMN4q3DBYDvxZNs7/KsYmbKd1wk7LTnM6J92QSWJyvp4PJj//zFllMUC3
 G1WGJbwWjlzWHKH5E9XYu4pGzFJZvFu69cpAEdOb2I3WTXefa0SrYhPhUKf0FtRIcWkUZzQMBbw
 CzdEg==
X-Received: by 2002:a05:701b:2706:b0:1b5:126c:eb88 with SMTP id
 a92af1059eb24-1b5126cec12mr7593598c88.45.1794845031515; 
 Mon, 16 Nov 2026 08:03:51 -0800 (PST)
X-Received: by 2002:a05:701b:2706:b0:1b5:126c:eb88 with SMTP id
 a92af1059eb24-1b5126cec12mr7593375c88.45.1794845025274; 
 Mon, 16 Nov 2026 08:03:45 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5329ec87bsm6757898c88.0.2026.11.16.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 08:03:44 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 21:33:39 +0530
Subject: [PATCH] clk: qcom: shikra: add rate setting for USB20 clocks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-shikra-usb2-clocks-v1-1-1807bba5f437@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFop+2oC/1WNQQ6CMBBFr0K6dgilpSIr72FYlDJAg4B0qJoQ7
 m6BlZtJ3s+f/1ZG6CwSK6KVOXxbstMYgF8iZjo9tgi2DszSJFWccwXU2d5p8FSlYJ6T6QkUivq
 WG9mEDguPL4eN/R6jj/Jkh7MP28sZ/iUwIJE+REV0ahLBhRQZj0Um0lxJ4KDpY8d48M63erxPR
 PHs9dNMwxCHs1srTQh7YJciUjK/miypci1ZuW0/cT5cgucAAAA=
X-Change-ID: 20261116-shikra-usb2-clocks-6e3d98c4f026
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794845021; l=2699;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=U9JTMKF53hyYZRFKP0/idg1WWFLD4IjYk9K1cSNQrJQ=;
 b=6CpEedu/tCc9nPqpLoEIwUZdZ4O94t9abZJXQ6Q013Ao0OUoyfOKPAsslK8cpkGx2Ba4p6hpR
 PObmZEnUceMAGeY2HTh9ZjgVYrYfNUNSmXRo1BGoreiB6UdGBCm61DW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afb2968 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vLHSfudRPOpNzC4oepYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 0_-hsr51_S8jBMsVGxn_7gQRMxjSrXEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MyBTYWx0ZWRfXzgQFtbrLZFUn
 2ChFCuLKNMCBXhs+2pwF7Lr3iLsdX56pznHE4g6vRwlCBY1dnKECYOhfNc9CqJ3cBrhYEnquOEh
 r7ce10TOFR7KgZpamJgvLoibpPDq3JbgxiHE393dfzMcaVB9TILsZIt3dd5PFSygmMBETyn7uaS
 3Ef6dQ0tMDwa7GWb5nKwxtrM2GTI8lAM/pMbPe1INPheVZGytMQZpkF4fAP/FFUe6Mxs7AU9Lt1
 inzomJVz2X5w6uwxolQ2FvU0ACMICCvcFKz7Xupr+F6ZM9bOUlHSo+zhKWpOl+qKB1cd3uhmFol
 XwDkHO5gizpMR+Ww3a5nKOzWdzaLCjp2jBp+8ZJ15b8JGzA/ZSNnbcwNdGrHvXREGrlHplnYbxE
 QYGoIqAbAIHQ54hWfZatt5N/OtAhvesozno4vuMu24EeKmXtZ1RFDbE14zpiU2yZyaV340bVrp8
 41J3sCuAvQv+MM7yw/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MyBTYWx0ZWRfXw8Xa2JwPAf69
 GxNG7ODTZk3mH5bc7n1i4NgDit44ClNrvXRs4AuCpzdAZD05VYhbTZeZFdKpkSAdFvIlOKV1ccD
 EdYj9GqsFJQCzjrKI3EqqZzb6pde+68=
X-Proofpoint-GUID: 0_-hsr51_S8jBMsVGxn_7gQRMxjSrXEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160063
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

Add set rate support for GCC_USB20_MASTER_CLK and
GCC_USB20_MOCK_UTMI_CLK.

Taken from Linux commit 01cf3e27824d ("clk: qcom: Add Global clock
controller support on Qualcomm Shikra SoC")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This depends on Aswin's series "arm64: qcom: Add initial support for
Shikra SoC" (v5):
https://lore.kernel.org/u-boot/20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com/
---
 drivers/clk/qcom/clock-shikra.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index edf001d81a1..fe3fc471304 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -16,6 +16,8 @@
 #define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
 #define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
 #define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
+#define GCC_USB20_MASTER_CLK_CMD_RCGR		0xb003c
+#define GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR	0xb0020
 #define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
 #define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
 #define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
@@ -76,6 +78,12 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 0, 0),
+	F(120000000, CFG_CLK_SRC_GPLL0, 5, 0, 0),
+	{ }
+};
+
 static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
 	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
@@ -114,6 +122,17 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
+	case GCC_USB20_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb20_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB20_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		WARN(rate != 19200000,
+		     "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, GCC_USB20_MOCK_UTMI_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return rate;
 	case GCC_USB30_PRIM_MASTER_CLK:
 		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-shikra-usb2-clocks-6e3d98c4f026

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

