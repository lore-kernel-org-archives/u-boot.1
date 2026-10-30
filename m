Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MK9MYI+g;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hPTYJt12;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eABHmjFA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45A7260ADA;
	Fri, 30 Oct 2026 13:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcnNQKie-neY; Fri, 30 Oct 2026 13:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7997460AC3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793367740;
	b=FZnbaN7MrOHJcx0nm4S2RSqFwtntZ+hToFr8Asd/4+9mkS45zrIdyuknAtbYRqBRjbDg
	 wVUwnDIXksfNSI4wn+fjRq02EHc+lxNSmGXTRLSOM9O+4Quv8IL8NfoM3QCQHqS3v2WGt
	 rf8GMN+SCxOQpeOeW//oGnizfF3XcDCb88APo2R9nPE5aKI1crumvZ5k9ns86KuFX3pcj
	 3PTeOHAYnq0HbnLSkgYWDvI49kSwd86N6UPIx2lsbD9dzlsugGKpNNqB7y5iBt21YNJZs
	 pr2vY8wG4xR57m7D01nUfDTFYOLSDSIATh9csAAppW/LRhdT86nhTOxyBdgKYv6GX+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793367740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=20w/sraRfcrw9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=;
	b=KcoMEXUK+JxL1EBIoimGEMbZ7vDFR0YlNIGOjkDUjWjXLEdkkRwsVHABM0t5VxLNj/51
	 lGeg4/j+db0ppxkrxduNkMXfmAePnon/FYhAy+5eE0PT7xgBg+XOge/LDcneztyA8EH7j
	 +93HNgGeY2DYaN8siqUSX3WSt7E6jevHeKmF/9LRjWMfrNHsF9z+k/l8DiLazxxRV3GED
	 //s9r8PKgzWELBIXTQ9oH1I3mq8YMP/ySiQdJXaphfxpXSR8abDkWswQPQyJBSrRu3zCm
	 Vtse3+pGZewxEOR2b4DDcZPe0D+fHGaT1G3PNSI2P2n0CJhdH3zlHJKEE4I0vCQYc/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793367740;
	bh=20w/sraRfcrw9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MK9MYI+grw1YPCcoxrUDgsCLUg0+h0LKOKVXVkSexPrc/WIzEbt7US32XEMBPSwWI
	 f3B4Hdk1Nu+lCi15uvJTj6giXdOBHl9A/jFAiY6TTmwdB79pngKivCbdMB+OFt/+z/
	 Y7FtOhMn6aFF29GVSQwPHhGy12HCafEx44c9IfccbYJQIxHCAt3U4gczKsvOW2Q8sk
	 mK1v5lKShSxnnefXC38tMUgk4XDXoDVCquXFPjNLyG477Rq0y140VUqK1LxdOckJgV
	 tT6tZDV2fzmJGIkyK8wLWeM0eI+YlvpYKGvOb198oECEGTI2AFSUXsNEbmjRhxWyhs
	 yOzKL7zL/eZcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7997460AC3;
	Fri, 30 Oct 2026 13:42:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 146BC529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05F414052F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCN2OWNQVHas for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:42:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CA3240243
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793367737;
 b=KM3IRHwJ995QbuQ+2L2+NdU4IrWIiHfILbyzr9rhaPFWhJYDFMjYlbClCiWqdyaKmRyC
 byqSCBzp5tDoVQOpblWQ4POEB1X2xFivsK6rwvx4d5n+tlyMFtm/ETHN1JlbHZPNrYZz7
 NN7DnejCPpvMNYWl5pkHNolza85lgRI+xAkxgmp/n4goedgaHYJz0Z+W9tZuqe/o7ThDS
 hT8DZtgBEvaMGODCYnPbi1z524LXjbQr2/R5kTvXVgtkUShgDKXdGMEdpYgrgs/qIs4xS
 sPcoywVhXc04KkwiQjfGeq/wqXoLZi5PM8VYHHdahWGovDTAitWF6GcYTF/dlfOU3tg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793367737;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=20w/sraRfcrw9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=;
 b=UYLxnXIYlRr9b0iDjMpmIoOpHIagHatA8AnUK4ML9iAHVnC1/PvrtmQYM2BR118JUl2v
 EO7/ut2jOkCXu15/1iVQU9+sbKFwe9ZcsCtMDsK+xu5tVqliK7Xl+K/gO/cwPMv6Nxg7B
 UWTGRSptzrSeDZ2LLEAB8I+cHbnMB0pQAiuRT3rea9s+S6MWj4bKgAe8jmfftkOsjIZ6s
 eAQi1vZ1eoHfXCrNYpYDP18QzfMofgZCaHl+ud8P9w4o5Ip/kGUDy05d3NMnfuEsbf8tM
 HwghU6NPVtcjMnSdm+k7OTVwWLppBC98QaIFR9R1LOyLKUS05N8/eF497cEYOdHq6dw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hPTYJt12; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eABHmjFA; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hPTYJt12; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eABHmjFA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CA3240243
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:16 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGXM93679113
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=20w/sraRfcr
 w9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=; b=hPTYJt12L16dbrmBB6+yffGnNNx
 kmZZU/5M8HkcuHUF110StIzyWkTNuBPQ/mwKNM6JuykprULQhAj1t4+OaKAupNko
 z65R/fqoz2zR7sWICet2z+XVlPuMeOowO1JsVTef06orMaQZmNKWc8etuhawupWB
 1Y6Qq1Tvqb6IbhICKsrLV9VAkNTh/gMLsz8kp2RvJ3NSXkOpSaSsiNaNTeVhOpBu
 sdfB61ROEqNTBiAlprIY4m4fQKdTjOJtsUdh/Y2Ukwp+fTLs724b1Ypdb9GYHHcw
 /EkFys1qIVSpyqAsvQuzQIQtgX9hYa2kqFaBUuketGwd3Ssk7LNNrprhOng==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk9aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:42:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so819265c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793367735; x=1793972535;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20w/sraRfcrw9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=;
 b=eABHmjFAYyUiUAXoKK3j9amV3+5ooUJCBvBJbA5X9w+ZE5tlrafbwH+UkhhuNqIB3a
 Q9UM2HSP/m5qhd8uZ4+K/waz3sAmiAv/60xmb/7bx0OM9eEETfzcHZGl0BpYMLH/kvw3
 NA6k2SMdV1EtQX/fXNSG+GAEOOXQcm5UoT/JF3Cgt/bC9p9jHF8Asos9/T3PHbQalMNN
 o/YczybNfa0xZH2qMFyZUopXzSc8CEIP2BFesWHcBvGv8YCxyLrPRRkhq+rEW/waZPVZ
 CRRDp+ZVa2ZJdtPPAKph3DhftTAKDTDVQYPDOrmMLeGmur49heMARd/3P5RJ4735DWFd
 JDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367735; x=1793972535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20w/sraRfcrw9uSWfzbKn5tqrTmRAb2vJ3+hrm2+KuQ=;
 b=Pxu1+uFRiusljnUmhgtHA1YnyJahKEUGITEePWUUx9/pYcZYVkukHjy3nHiL9SHD4z
 SuJk0UUyDXwfKKn0+TlEIeeS5uVT6Zv6sWb0+kBeoPwxrT6Ep2++DzpjEE3eC/ODIlpE
 HH+luTrSGrm/PNF3cVwMWD75aQSALqcV9Tc/8ss3oU2kWr7er83FUDXBgyjSNDwEFuE4
 Sqp5zns6POnMF14WM6Ogks1IN/yfVu6+lUFpyia3iVdGWTihzEd5VeQ0hmChVll/Q+xn
 XMawAM8hlTjFao30bmDaawbbJOHXbcKzywKRSJl11IGPNLggaK8xAaY6HDREnPz9a25F
 OUrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByeDjnNpa+cc5CrK9VlrMNlDym1XweMrHBXKGgyrQeTeRBJk7wbQjO8yzAC3HoPQf5/hQaKTYE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLIDINKk6jxiTvDLT3BvP5Qt1VHxgm+olVhx8IIHqQN0ZSkO4Zp
 P//VNsSnCr7n9SP0TLQjtaC7SB4Vau9xOZUg1FL4OcJyIOUbt+DS0Ojo796b1PBb5X7ebSAlpME
 nNm6ye897kslllmxPeVCBbVaYY9Bd5GVpK8dMoK35vh9vXIO47pJTmB20cFDcodIbKDcDQbencq
 ErINg=
X-Gm-Gg: AYBFou3+dxP4XcoGTMCkDdsI/5XwLryTKN2jAsmgiH/jOn15WyO3HgNBRGHzuib7Xux
 uCLp6xTmBURUQJvZru/H6QowufuWyJiDcJ+VfOUx19BEzeyM8trFync/Fey90bFufX2U/JiE3qO
 q9+d6r5naxZWnFERACC8olzItNr04LyWUNtUzv3h/60IygH6CxVCV0HfmzHLqgsmZgYWTDfxal7
 nhOzC2MFDlAGfAXsX2OKeOpjTd/aU96KdgrGrLwNOHOAQMc0WZ6XW8l5GB033Im8KOuND7calBy
 5ltRru+3uwcQXGGlMHQzuw5cZz2HQRO7JIegNiZzF0M+KEK/ny8H/0mIouY5sYwAMJUjGelEhAA
 FhyOiFHsIjOuEvuuRbi7SvlhjKrcrLMQ0eDNMC/dzV+XnAitrkoM/98eGl5cV55RHpulkhwgbQV
 KfTAuZu8LL0bow0EvJY/x9ltcoyJ+yB0HhQWseqR+xoLiVjcJTKv0vndvpOe1BKTMN+2dM
X-Received: by 2002:a05:7022:eb45:20b0:184:992:c9ef with SMTP id
 a92af1059eb24-1ac5de547a4mr3180091c88.36.1793367734504; 
 Fri, 30 Oct 2026 06:42:14 -0700 (PDT)
X-Received: by 2002:a05:7022:eb45:20b0:184:992:c9ef with SMTP id
 a92af1059eb24-1ac5de547a4mr3180049c88.36.1793367733946; 
 Fri, 30 Oct 2026 06:42:13 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c2e9dsm9610667c88.9.2026.10.30.06.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:42:13 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v3 2/2] configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
Date: Fri, 30 Oct 2026 19:11:45 +0530
Message-Id: <20261030134145.2349821-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
References: <20261030134145.2349821-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX1cTbYCInxL9R
 6A3zp0torp/XVzJfv+O6xDgjNWAtLYWwr/Qb/YWF967vdoGGU4jGN+3I6d8q8dHFfZ4vUFvJASr
 kpOOEJOZQghRQIcRBnpDKP824D2bLuUlxTikV4ptK5RGfovvJw6r/pc/H8TKaNr6nicMeY/I15Q
 zQOQ4bO3Vkvr49k50PHaZpkRqlQkAKV7OI9yR6Q0+HappKjABHVU2zCTKaWg2A8EnbEvAj5XEJG
 09rDBdLRwTXVQh+ZoEWEmG3hdvBXI8p7lMACTBYP6eeljg1noNj750CleEWjICJQ06pvfA05lvo
 KjcMK80DoKxFZ7LryeBUgJWDnUkjfL1+RZSXigWr02SHLqhyKsaPJqLB6E9cPOoWgBGXvj1nVt0
 3mQVeFLnBHO7/n/3GM/gxDrTc3J0coWhUoHWIpreYYC2VHAb1o8cTUheom1wMpGlxhUMiQCdXk4
 CgP0WC+i1sGo88OgzRQ==
X-Proofpoint-ORIG-GUID: XWcHgvrU3ZwPb5o1wF7NFPNuCe6uxSI1
X-Authority-Analysis: v=2.4 cv=IeoSymqa c=1 sm=1 tr=0 ts=6ae49eb7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fGWB4MedpCl_aG5q5dgA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX8oeooFjl/UtI
 fCObGlxNLHk3hqRbMCTIB1JD4uUt9AqX2YszdGKns0+mu6XD4jrNrUO9xhz3fr4+AEtiVqvMXU0
 4BfWQILP9bihII2WqAtV6Wuj9qkeHd8=
X-Proofpoint-GUID: XWcHgvrU3ZwPb5o1wF7NFPNuCe6uxSI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054
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

Enable CONFIG_MMC_HS400_SUPPORT in qcom_defconfig to support
HS400 tuning and DLL calibration.

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..a66b38bf7fb 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -101,6 +101,7 @@ CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=16384
+CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
-- 
2.34.1

