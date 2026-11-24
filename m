Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68433606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s6HhlDyh;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k9IBm7Z4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jzYoHyVi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30877406A4;
	Tue, 24 Nov 2026 09:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFBnliHwc1SP; Tue, 24 Nov 2026 09:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 259D340675
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795510949;
	b=BLKQGtemBDnreaBURsgMRSAc1oZ8Q107SdBxEvf/looQzN0xHKFDZlDYWX9RdXKpGql2
	 0+PtqwFj+YDKlEqVLUb3Vh+s0aIaJulqWxnfh4MjdpeGmoGx+BnG4PB4KgYzkMPf9vkJx
	 TrdiDuikCRQ28KkClohrq+SY4FXt5iLzfISbpD5ZQaYGMt/vJTtzLxK0xn1iJwjkh4WnZ
	 oypbDlzcMbYtX5mj/ae6e7UXE5n9IqPle6u0yfhzGnc+q6Vu1EoUg4ZRUVLNn0CQXI3cq
	 w1diuY2F71nx04kxrbT1uZ7qYf8zEsNkIkUEodP9VE1/ZawbxRaMsAL/WQr1hLwOGYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795510949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a3+2hAZ9vrCZiPE2bHul/W92AX0ixDCGXPBC0BHCVIM=;
	b=pPexovdN9G8TlXHVzxLArPycgk4GjcHroQlE86G6ZnEU9gWWZy8RxKAuHVEl7WwqEY6y
	 FNdjw4hlH9SDmbSZOH1g40P8FHrjM0+66gdePDP/JGl6Z7nyumcr2vQ3bLMQWRb+XnsIl
	 YTbwMduiL+riuPXTkUS5y+Yxe8jFwb6urGE1IkDBrN8MccD+ibZa3X05pf36zhR3ChGCi
	 No5EFSHlyiTN8gxlPw90/+yEp1ACplKhliMBgRselv5tcx9NJH5Ai8z4mpr7S8hd9Co8F
	 mMPm9cD+TJavKG9YkwJ0WPJ7yfSA9MW+CCZpSIiUyy2OlNfPjlZJdKlfmpyRhHJjkjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795510949;
	bh=a3+2hAZ9vrCZiPE2bHul/W92AX0ixDCGXPBC0BHCVIM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s6HhlDyhMYdV4+l+V3T9Ml2ZP5jroXL/uU3GOQGn+L0vtIipk0HnAE2uMwIqnSQkc
	 X+NOcNIFUFR3tpfKQ2DnzkRwokQGwiUtiL7bLf+a7wMvGO60lu5tF3vgHf0gzYd73o
	 rnQeGE7/phfkUu++GZhH5UCj45RxcNmgRFKWChIyBVgBc4kV7CUz3QMhjgurjenaF0
	 w4EU39iqm2uFsT/LlG81Sx6bcDFYI6RX863bRIcIyAyao22Pwd36WvZnumtYDLa0cw
	 7h1PxJPwuFHn7qSpZsEiKGaZN8XbsHW8ZmugiOrcwt3UQMu+pxSEGs/nPguUaJdlJY
	 GJQpWpqbIg+vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 259D340675;
	Tue, 24 Nov 2026 09:02:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FA16715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E98B8400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OykrUnRZNhR4 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 33D8140068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=k9IBm7Z4; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jzYoHyVi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33D8140068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8dFWq3701144
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=a3+2hAZ9vrCZiPE2bHul/W92AX0ixDCGXPB
 C0BHCVIM=; b=k9IBm7Z4hhLStwsEf2kTr4XCSScVmspihfknRDTfvx3xpP2lvnE
 ehu5IU7HX+GXpnF+Y73e+OXbz1xrJ+Luy5Nk+vJeX5Oi2+DFSqAcZIJ089tyNTOY
 JaWJkDwgvL+XHDJhJB9lGMvapJ9Z1U1RJ1DZKyzGfb6R3GuVTL2SrxabQZVNry88
 IL6+wYYaJ3jTojdEbYMHo9ZgYbUywOOikd8VLF7DMxfzAHf9lYZhgCI1xDx6K0HX
 XQPfWzsJYEbygDh/0Xhy7f/MDdLNRcpxjHuEU8lIveO8GLzspUASNX2Sr1nlJQHG
 uYU6HPHsIlqjfY+ot22CQWuZ6tDH1LAHcyw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1ndy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:02:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383ec96a7deso4907996eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795510943; x=1796115743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a3+2hAZ9vrCZiPE2bHul/W92AX0ixDCGXPBC0BHCVIM=;
 b=jzYoHyViBcHAFldFknLhq2eig6mOVSoipmaAyx8A/WO9cbZs5RyU6gLszL8YO5hNM/
 A58YuVdbftvzVe24YGH8wY9oMA4Or/+QqQC1i1dVAEcPpKXTPLBpH8jf1gM7FLYONEmS
 2RI297CHv1c0uLUhFCvsFLwZqHDWaKVbHCE5+snA/duLjVL73dQlTRhEow8okb2wMyyU
 jVFe6yxYBkSKnZWqINL5vzRb3WSK7NNvK6kqeRhAiGWXg5448Pfw5zneOt15rRLr9SCt
 tku8K05T6gBzRtTmlPSMqGgmxPvjpYFtuieRT9v/wc34RTJGEQL2eZBr6gdycWDd7djQ
 nSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795510943; x=1796115743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3+2hAZ9vrCZiPE2bHul/W92AX0ixDCGXPBC0BHCVIM=;
 b=Vq48GlX64DauzFNl85NRajk4oGqtSCXaE4bINpCKK1uQugZ0/TG/7Okz7sdzRf2gY1
 6uE+P7SaPhnH9CwMD4HSxA2regi7iZ2L649pMC3CnwkpJP09nGDgIaNYFflAHJRO+8ot
 DbD+oOsI+mvsXEEDCOdFAEsPVONBPoPR/k0yLC/1zhwzrokykrTdQTGW/qV6FsGcJuur
 mU+NnA1nh9ubzGuAQ5KtD9mC3G4cBwjFvT4ZWkuwTgL6ST/xvdS1v73AEW+NCplSahr4
 ld2lrwCKqKzNgfS+AntbQ1wBAs5094Guh/0SlZgZnVrJTyHOv/nQeEYIJYdX77GwGcsD
 fUTA==
X-Forwarded-Encrypted: i=1;
 AL+hErGwiiZxWNbmTSEDfgh/41jW97kRJ41c5TxHigO9sDOl3BsQhWwhjdAydAu1OikqEHmU1z7uU4c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8wULwRXjtq+By+ZTsrpKEnpM3KOHGksdixHmkaqH0Dpj3/NcO2
 cyzOKmQbbuaOnpvGT0GlpH6jOu2AZZtVqFAG2UyXoWALfB23LHhixWrNP7JewbbpcH0J9P1HNMY
 Hs4kXxX99oIyl7QsK0uPofHguuNMHG74jCYJc8V3U/ROt8KMA4xBwpNS1E/cEJeJ7HqeOj6Q=
X-Gm-Gg: AZFdTZeBz03MzS0KydTcqrRZFFofcuIYcsKdP21kQGQrpzfHqFns1UR1fvtzbLhoR12
 MX/5xE1V8D8u0JHXfc/MRUCNqTLFJQcl9t2jjrYSP+iH4BIdD7TL/ISaklrncJzCBGmWri7h6lV
 hblTomFXMdwPghCi/IOqmRm0rrV4APw4rPTp07bvREsN/Dx0q0z8sf4d2FZYUBb6KBtTuSPmLlq
 5Z2mrIM1ZKf3PHXI5E+gF8DfTiqj/0yHLGwkkOzWDKtjbcqOgxjnHiHrPWSlIWePuQ8B5I88Es/
 v3T4FIetWv2cmm4r9RGfGGA2PCOy694d3QCclPd0JTFKYU/XgF3zTAz1Bo29Cvw7+RLAQzk+5ym
 YMs+lSqI/XivDEkHopkOUpaA2hNxblttuaufu1/uLC/ooO+2Wb8ViLwJ7pSqjhknwX7+R/aPORP
 dz
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr16310459eec.5.1795510942831; 
 Tue, 24 Nov 2026 01:02:22 -0800 (PST)
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr16310420eec.5.1795510942162; 
 Tue, 24 Nov 2026 01:02:22 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm46429154eec.14.2026.11.24.01.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:02:21 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, royzah@gmail.com,
 deepak.g10@oss.qualcomm.com, dlechner@baylibre.com, 3305708832@qq.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, jbx6244@gmail.com,
 dlan@kernel.org, anshuld@ti.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v3 0/5] net: add Qualcomm SA8775P EQOS support
Date: Tue, 24 Nov 2026 14:32:05 +0530
Message-Id: <20261124090210.2560500-1-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05529f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1xilXWlzQkcr8tkQ2YkA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: g03HQ_SDuLXyJoAabWj0oZGMy0DbuD0X
X-Proofpoint-ORIG-GUID: g03HQ_SDuLXyJoAabWj0oZGMy0DbuD0X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX3o2t4meU+cJO
 2MtBW1tRz8V3Dv7iFardg74sj3r98IqPRkjQtKt2BfzH5tLgfdICOv+PoyXIKanDjmzazxmoPM+
 ZCDy5Pg5hnxZbkeXQEe7qV/dUQuIEUs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX+NgVFi8juaqB
 HfpDZyZpGbt0M87OX0Hq/tExub7U51E1Dcdw7J3iNFRMt683KqAWGgs1r5NvEYdksE+YQm5L/sR
 28tRaLsYGCdDYwxh4OiEH+nmwcY+bZCHkYNh8rKpPth8t2NOb1l/SvTVHI36qcy9xYtPXzfW62y
 +vfBeXobHD71fvBN61LEz4qTw4UBGVVggRzVQ6H6oyKD3wk+4v/23Mv3/BrEQb5YLsStByrcK/b
 21wxQVkpadjuo/foTDGuczpeFamtVvSqOnQma897UF2Lh7Tx5kKXUsZqQvSQQ7cl+ComCZ5BWVK
 TMDkZbCIpwu/MZwiznL+/a3P046TpCGeG+jV2oYRk2eqWFKWXnnoQaA6WO14NZ9gHj04/mooboS
 pyCdAjqOrl75j4lMPIDX/lOnbXGOGSgpD9Jc1Y7CNHh2wy+rPbtOwGYvMorW9Yq8xrxVFdCsArl
 vjCi3fUvi2SCiXmzs/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

Add support for the DWMAC Ethernet controller and QMP SGMII
SerDes used on Qualcomm SA8775P based lemans platforms.

The series adds the required DWMAC EQOS support, including
platform-specific DMA channel and MTL register offsets and
2.5 Gbps link speed support. It also adds the QMP SGMII
SerDes driver and completes the Ethernet configuration for
the SA8775P-based Lemans EVK.

Dependencies:
https://lore.kernel.org/all/20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com/
https://lore.kernel.org/all/20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com/
https://lore.kernel.org/all/20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com/

V2:
https://lore.kernel.org/u-boot/20261121063919.3313168-1-mmanikan@qti.qualcomm.com/

V1:
https://lore.kernel.org/u-boot/20261115181936.1750625-1-mmanikan@qti.qualcomm.com/

Changes in v3:
- Let SPEED_2500 fall through to the SPEED_1000 GMII handling.

Manikanta Mylavarapu (5):
  net: dwc_eth_qos: allow platform-specific DMA channel and MTL offsets
  net: dwc_eth_qos: support 2.5Gbps link speed
  phy: qcom: add SA8775P DWMAC SGMII SerDes driver
  net: dwc_eth_qos: qcom: add SA8775P support
  clk: qcom: sa8775p: add SGMI reference clock

 configs/qcom_qcs9100_defconfig            |   1 +
 drivers/clk/qcom/clock-sa8775p.c          |   3 +-
 drivers/net/dwc_eth_qos.c                 |  48 ++-
 drivers/net/dwc_eth_qos.h                 |  41 +-
 drivers/net/dwc_eth_qos_qcom.c            | 276 ++++++++++++
 drivers/phy/qcom/Kconfig                  |   8 +
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h |  21 +
 drivers/phy/qcom/phy-qcom-sgmii-eth.c     | 486 ++++++++++++++++++++++
 9 files changed, 850 insertions(+), 35 deletions(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
 create mode 100644 drivers/phy/qcom/phy-qcom-sgmii-eth.c


base-commit: 990319a87e60fbc2ac26a386f2ec940e4f97978f
-- 
2.34.1
