Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B18606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xRIEp/C+;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvFbOkEi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WJtL+UIY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFC480F8C;
	Tue, 24 Nov 2026 16:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0k0eNMOGw0X4; Tue, 24 Nov 2026 16:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E97E80F52
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537815;
	b=qbq+EDfYP9ZHh3UejG8yClHwg5xucqdzHGl2u9iFsWE5eDEpj88j1ROJby9/HEoNCOiQ
	 V7x9ufcGqcplws8868HELeHsUhDG9npTI0+hrNSs9jcxr3oTIehGRIkPe/+1bQ+E2uq6Q
	 ePChUeIHXl+mThRoeQqPME8zBiCvuV6JpyPNhY+Fatc4TygLACez5NlLYJVuojDYDBH75
	 IjMEULRcpBJylnEXto8hDFAXe/53KDD7e2rvPiaqVu35nDVVLnyQVYJOuGWMgq3NIDwRz
	 0iHMz7/blactTCXx7z+VCIzn17M8rHN8cNv69zbuT3DnCXFaAZlgfdHr0H6BP7VB7ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eMG3Xe4DmiWxfwBIPpoUp4Da/lKJqL9LRGXkDMS6xXk=;
	b=Ce1YLJE+D+kundY9qXKztNgwO51YsI7uqG4riPBQSDrSbSP9xmoH/1e3r32arc4hnYo1
	 j7XsrheUAl3FuvTz2ndLuu2LhCA1bBAneVV529lrmGBXmYwVcewuX9oZtOluNKNs/9hDJ
	 zW4Ezmhos3WCF3gAhkecaLQckG1w1M3BBE0cHvqlR000+cglOkMv0mMa+CHvhIUv+ydK/
	 elwGFhFA+6+M6zotKcvcWhlUc1c0+ZPA5zdKt/NDV5gjpxZ02W6cEg7HAKZHEL7ckCg/X
	 afQFawx6uNu2QjZRBJZ2dUvGdAlrohTbQgy12ViNj+JDG7bFq+Xv93f5lvGvbwSuphg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537815;
	bh=eMG3Xe4DmiWxfwBIPpoUp4Da/lKJqL9LRGXkDMS6xXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xRIEp/C+IE8SQyj8BShg7642tTVe5cjIN5m83Mmo2vDOGliJi9ZjNNg6FPc+ze800
	 9bMkhWUArC5CI0cVjD8eN6aTTRPrMZrxDFzNtDvdTM0gQ0XENhf5qR0GtnuDVi9QUg
	 FfLis0CJFeVMJ4JbTvEaSM5IvmZs7aFveb4MuEDS/rp8i8mCaOklcciQClKWtRSXLv
	 /K5X+8QiqXmhHiof6mXEIZF6OD0fH/DpW3pGTfkD4guyRYQxdn9ownnMEAlhEqaJtD
	 GDxOqj+CcBWFQlkMZ6q0jbo1E9mnZRMZHIvlTyHvhMF5hCofET1AxMfKMY3qz7oNq7
	 fz+aNCw3sTU2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E97E80F52;
	Tue, 24 Nov 2026 16:30:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD029499
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2A7A40642
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPaPC2p9GBii for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB1EE40764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XvFbOkEi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WJtL+UIY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB1EE40764
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFLajm1331932
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eMG3Xe4DmiWxfwBIPpoUp4Da/lKJqL9LRGXkDMS6xXk=; b=XvFbOkEifmLbc2wa
 R0E1dS1khKs7S773Kh8Kbebt/GVXOqud/2JoQTVe715TW6KQ/Ktt/WnN4lweTKXu
 Kw/vNY/h7DahrVagRNW4nLOjtwyassWD6wgcAp/mDnsVdzJiRN79pT00Ne5ERByL
 ACORxbfZkloSXljY+9U5P4SmXjPWHf69yyR7mvhj/vjer7pqwNqNIX/wRNh3zXmW
 3o4nakc5O3n6lWgYoH14PdA3OjTdM96iTkwALSSUXtQthWH+yvt+cg97O4ai5rhs
 KOLaFlx4cg+xcM3qmtE27Y/eAkUPAvPhXx8OG8WStwMziN4G9ottKycWg5thg9Kb
 rkNchQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb3t5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:08 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-990aa76e3daso785868241.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537808; x=1796142608;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMG3Xe4DmiWxfwBIPpoUp4Da/lKJqL9LRGXkDMS6xXk=;
 b=WJtL+UIYQ7BMwd3EqZYjetyX9FeC9NUkxo55kCDTeNK6ESC5mIsZphZQW380J8czY6
 a502Gt4fpb3+cTK3PZYVKqnYwFmsbN2sU4XGl8U7O3h11uGtR3LztcMwm37uu2weQa88
 gHF5EJf0zAhxdVN7jEqvk4P9sVAIs2wpcRlzYiQJeF2IeKfWNCfBWgBnCmgrzy+ah8su
 v1SGyhFTXk9Pmu+i1/aQy0dFDmYdUy0j3x3XlQGS0rLde2zoO0E3nXFEcTd1HMZP1qI9
 KfDQnfp3/m1NU/cB5uczNLq4aQk3ESmP7D3CqKlsx2q4ammeFF+DW9cV1c9+o7urZvh7
 FoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537808; x=1796142608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eMG3Xe4DmiWxfwBIPpoUp4Da/lKJqL9LRGXkDMS6xXk=;
 b=2AdykxhO21puGsDLWLxpP4J54dqWkVpjXOkCRj3bjElkE5Eaf7WeGgbs2tl7J/lu5K
 4BHZ3HoeLxMA5Z7CrQulvJB7CJN+Lo3WO0vKywX21sm/uQCpT42JpQUHS4pFJj9xsn95
 joIILZ/k56my9LncYbLkLUqzrnxjiJYgF/QKgVMym56QLeSXaI5CKSPQRqO9ZKIrDSIF
 yL/+XjbsK0hAWLnUDqOlClXmJzmalqVwYVl9hJq5okEzrtpmQ6jsP4pyL2vH4h2dm00s
 nUbNlbSpZ4RfO6uzd+sPDa7sWJ0mruLEq0dRoZSaURS7Zl1Ie4v5/R30KZCJPBjC+ale
 vvwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHJ4d7uzDiQhl6TyKGRw59yCTlT/cSgsZOl1KKYEWvpGm1j0l+ho+pMp4F+s+guf7VoZ1cC308=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8hFxkDI0DKhEJ5W0RbJZktmC+ArH8McYZ2EDIOprTZBsUuVM0e
 oa/nrUtNdcfU7A4Rx/nG8SYt4Q2sFkkKx/NtQwTbluufxkVP3EHkrf96+0d4hFwsFN8YryBxuUY
 Oi1bvHou754gRykH7sQo6dpF3ViNvBa9WnOZaK8akz83zcaN3ysArVYqHVqMqaGWGRks9Nb8=
X-Gm-Gg: AZFdTZeZ9F1ljlbF+eArF3SAFfrrnvGYyUuCXhLeEXmTN7M+0LAGrsBlZ6smWEn4bqH
 1Pfv3ICes7Y+18kRRsx3kuNgwRuGfjxJeW1hsX2WKTxnWIuvHfvluBB+FyciAy/YdXlY9tudr+s
 xVo0pEXeXJpW0Cne/4XKzul1ijyOgSs936bBqFqgoSbfhTKNuBZ4qqWfCZWkKkVv4btsSGVc1qq
 Nv4bXr+uvhpWxxVlIgfSALEtmyGqpJwZNZdH3FM+KEeQv4wpyWazj9ZzfXDsFH+IysGnCw9On+A
 RRI/q+o/5+DivQPVavIwvtpTMFhaMnZlbDN1FAQRQ29p3pWpibwOMP++5Wz9MSA1ERX5QlrlP0F
 SYhUbQYC2hKLbVBNxCZLhCw6QhKFk1kOrwHV1Lshto+fUsCfxTnTcXtaDej5hLmGC1c/vGHlVjM
 sqaED4ex+t9Erp
X-Received: by 2002:a05:6122:310f:b0:5ee:13ad:6c8c with SMTP id
 71dfb90a1353d-5ee8aeaadcfmr7364599e0c.7.1795537807399; 
 Tue, 24 Nov 2026 08:30:07 -0800 (PST)
X-Received: by 2002:a05:6122:310f:b0:5ee:13ad:6c8c with SMTP id
 71dfb90a1353d-5ee8aeaadcfmr7364508e0c.7.1795537806746; 
 Tue, 24 Nov 2026 08:30:06 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:30:06 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:25:04 +0100
Subject: [PATCH v2 7/7] test: dm: fastboot: test the flashing commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-7-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b05bb90 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=rOiDLTwacElUy9sY8VYA:9
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: cGLL4VlUn0cjBF9fKbw8SC5zjLr4DQXR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX05N8j//X9SX+
 mMopaju6ADD+NH03eegOsPbroPheSqUKocpAAeOu9xU6lGRQPIjLvVQ+Ma7pxNpCdaFgIE79SrY
 /Q87XgVGSWSRbWqeG94D0GuPRFIBelE=
X-Proofpoint-GUID: cGLL4VlUn0cjBF9fKbw8SC5zjLr4DQXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXwi/I9pjrI6FK
 RogOg4seATzGpgwSTrhPhoNLjBzMaAXO21SW0CC0hIIzDxtzQX4srfG+d/GJmGc2qcryS5LCwga
 VP3NSWzWlEe0alYuK40/joKZMdFu7JWRq3oLCIpsn2bVDQjyqInWpMC6IXTnniwx47Dz+swdBBa
 bTIYI5j7Y16GaFOmSfxhW8txL6bFgXLNGWJU2NnWibMlU68fkFY8cFX3ZpHROCszEbTYreb/Cyv
 9YYEFQisW8Ic0Hrt5Q+Dqup19rQOWQz2lgpHCCtVx/5OV8ydW1zS3l4WKjs1jIKVqAPyGJd/483
 EYjQ67Fc49gFl3Qgbqc8ATi/zLJ8x4sVUBIaLVyv6QNsz3r75qLaaZXb4ivDuY2+U39F9qx7L22
 E9v9fgqeTvEOQWUGIb7ih+e38ooe+3hFLrGOzNJiDV4vUtQx2JEW24MVc4OuX4MMKko5bdHkTgC
 DAOeKPI5xdNgjWJB6gQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A locked device must refuse images nobody verified, unlocking needs the
user's consent given in Android, and every change of the lock state
must wipe the user's data. Enable FASTBOOT_CMD_FLASHING on sandbox and
test these rules through the fastboot command handler.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/sandbox_defconfig |   1 +
 test/dm/fastboot.c        | 146 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index e8b462e7c11..c38fd468a0b 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -214,6 +214,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_FLASHING=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_ALTERA=y
diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 5b51b6bf9dd..0b3eac2302b 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -3,16 +3,19 @@
  * Copyright (C) 2015 Google, Inc
  */
 
+#include <blk.h>
 #include <dm.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fb_mmc.h>
+#include <malloc.h>
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
 #include <dm/test.h>
 #include <test/ut.h>
 #include <linux/stringify.h>
+#include <u-boot/sha256.h>
 
 #define FB_ALIAS_PREFIX "fastboot_partition_alias_"
 
@@ -93,3 +96,146 @@ static int dm_test_fastboot_mmc_part(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fastboot_mmc_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Run a fastboot command, leaving its response in @response */
+static void fb_run(const char *cmd, char *response)
+{
+	char buf[FASTBOOT_COMMAND_LEN];
+
+	strlcpy(buf, cmd, sizeof(buf));
+	*response = '\0';
+	fastboot_handle_command(buf, response);
+}
+
+/*
+ * Write the frp partition the way Android's PersistentDataBlockService does:
+ * the "OEM unlocking" setting in the last byte and a SHA-256 digest of the
+ * partition, taken with the digest bytes as zero, in the first 32 bytes.
+ */
+static int fb_write_frp(struct unit_test_state *uts, struct blk_desc *desc,
+			struct disk_partition *info, u8 oem_unlock,
+			bool good_digest)
+{
+	size_t size = info->size * info->blksz;
+	u8 digest[SHA256_SUM_LEN];
+	u8 *buf = calloc(1, size);
+
+	ut_assertnonnull(buf);
+	buf[size - 1] = oem_unlock;
+	sha256_csum_wd(buf, size, digest, CHUNKSZ_SHA256);
+	memcpy(buf, digest, sizeof(digest));
+	if (!good_digest)
+		buf[0] ^= 0xff;
+	ut_asserteq(info->size, blk_dwrite(desc, info->start, info->size, buf));
+	free(buf);
+
+	return 0;
+}
+
+/* Fill a partition with a pattern, or check that it was erased */
+static int fb_part_fill(struct unit_test_state *uts, struct blk_desc *desc,
+			struct disk_partition *info, bool check_erased)
+{
+	size_t size = info->size * info->blksz;
+	u8 *buf = malloc(size);
+
+	ut_assertnonnull(buf);
+	if (check_erased) {
+		ut_asserteq(info->size,
+			    blk_dread(desc, info->start, info->size, buf));
+		ut_assert(!buf[0] && !memcmp(buf, buf + 1, size - 1));
+	} else {
+		memset(buf, 0xa5, size);
+		ut_asserteq(info->size,
+			    blk_dwrite(desc, info->start, info->size, buf));
+	}
+	free(buf);
+
+	return 0;
+}
+
+/*
+ * The flashing commands guard the AVB lock state: a locked device must not
+ * accept images that were not verified, unlocking needs the user's consent
+ * from Android, and every change of the state wipes the user's data.
+ */
+static int dm_test_fastboot_flashing(struct unit_test_state *uts)
+{
+	char response[FASTBOOT_RESPONSE_LEN];
+	char str_disk_guid[UUID_STR_LEN + 1];
+	struct disk_partition frp, userdata, metadata;
+	struct blk_desc *desc;
+	struct disk_partition parts[] = {
+		{ .start = 48, .size = 8, .name = "frp" },
+		{ .start = 56, .size = 8, .name = "userdata" },
+		{ .start = 64, .size = 8, .name = "metadata" },
+	};
+	int i;
+
+	if (!IS_ENABLED(CONFIG_FASTBOOT_CMD_FLASHING))
+		return -EAGAIN;
+
+	ut_assertok(blk_get_device_by_str("mmc", "0", &desc));
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		for (i = 0; i < ARRAY_SIZE(parts); i++)
+			gen_rand_uuid_str(parts[i].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(str_disk_guid, UUID_STR_FORMAT_STD);
+	}
+	ut_assertok(gpt_restore(desc, str_disk_guid, parts, ARRAY_SIZE(parts)));
+	ut_assert(part_get_info_by_name(desc, "frp", &frp) > 0);
+	ut_assert(part_get_info_by_name(desc, "userdata", &userdata) > 0);
+	ut_assert(part_get_info_by_name(desc, "metadata", &metadata) > 0);
+
+	/* The sandbox TA starts unlocked */
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYyes", response);
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("FAILdevice already unlocked", response);
+
+	/* Locking wipes userdata and metadata */
+	ut_assertok(fb_part_fill(uts, desc, &userdata, false));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, false));
+	fb_run("flashing lock", response);
+	ut_asserteq_str("OKAY", response);
+	ut_assertok(fb_part_fill(uts, desc, &userdata, true));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, true));
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYno", response);
+	fb_run("flashing lock", response);
+	ut_asserteq_str("FAILdevice already locked", response);
+
+	/* A locked device refuses to change its partitions */
+	fb_run("flash:userdata", response);
+	ut_asserteq_str("FAILdevice is locked", response);
+	fb_run("erase:userdata", response);
+	ut_asserteq_str("FAILdevice is locked", response);
+
+	/* Unlocking needs "OEM unlocking" in a valid frp partition */
+	ut_assertok(fb_write_frp(uts, desc, &frp, 0, true));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY0", response);
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("FAILunlocking is not allowed, enable OEM unlocking in Android",
+			response);
+
+	ut_assertok(fb_write_frp(uts, desc, &frp, 1, false));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY0", response);
+
+	ut_assertok(fb_write_frp(uts, desc, &frp, 1, true));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY1", response);
+
+	/* Unlocking wipes userdata and metadata too */
+	ut_assertok(fb_part_fill(uts, desc, &userdata, false));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, false));
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("OKAY", response);
+	ut_assertok(fb_part_fill(uts, desc, &userdata, true));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, true));
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYyes", response);
+
+	return 0;
+}
+DM_TEST(dm_test_fastboot_flashing, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.53.0

