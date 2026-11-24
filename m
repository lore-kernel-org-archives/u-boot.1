Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A996606A331
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b4n+xxoK;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LM7Ky5rW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y9SFQxD/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8FE6405A4;
	Tue, 24 Nov 2026 16:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mekk37K1xEA9; Tue, 24 Nov 2026 16:30:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EBDE405AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537804;
	b=qcaX1QZPLXbVx3QZt0vtVltZoTe257sB9ru7NliVagBOZHt+fS5jGavL4oK6zkaTMrOC
	 9AityM/yQhnLc2FP/XvgkDMjQYl+gWLydMu3baTK6SnvxIEDb5XlYEf0l2tJQ37XHyU+8
	 cxNF6SBaBhewgYhliq68S1JS99AdPLo4k48hkxGrEVj3fv9s3p2ENlaQBXCZX9j1E59m0
	 v3npPWNfqiuLW6Lr8jOKxFD0HT5ldQ9LinC9cFZujuKd+B+BobLEU3EEBiipZPDATUr5s
	 +u84EBoStzMPcumBZx+Ujx6GJQNcujVmnC72VfabcC6M9dHZr1oq7oZqtjIFYN5UeAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rizMPeB7poDtArVvRCfddvafeIM2VFESxVC7T027dMo=;
	b=Fm+1eBsnhW30A7XaP2qUMsaRKu7hoJfjEJ2eiwJcDe2Vo7jWcNiI+fzmQ/23VcpdoUzN
	 2OojdH87mCPM+rFqRhpsyd0ybOn/qOlUGLISpeVCxO3B2OwMjE0Iw3SVYccQmw/PPm8xc
	 3z6ebMWyay2PJAgXjR15hD61jWVhoXCrJV1EobckZHoENOQwfxQHzwqcpWkUq/HAC6fN1
	 rQh7z4vZuqahKpH8THuUcQqHWBIGAfvMNAL9civNcx3ja1GPvNI0td8hn/YesuhcjY5xb
	 Vy9acgkZ0NqVpi08MNtV+iHiNxW9OIyTIBqh9Vdow17giH24/FrgUNQlg/uMRm2moFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537804;
	bh=rizMPeB7poDtArVvRCfddvafeIM2VFESxVC7T027dMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4n+xxoKE+VMst6Sla38QKJeh6lkoAuc915XcE+7mPSyyQ3tZtWwOiJ8J+oPNa2e9
	 u/z09CwMte6VQzvYgoBt89sFF1fzjrcWqKbttUymXTtKmNgQcIUrbYihaFsL0xVqj7
	 3Ab26Kf7KByvP4XcXegGKKPFFBEWJkQ8rfCiezaK9O5bYTz98f0T1zJqLlVSMBo2Bi
	 FGE4CkTuSvtcpA/gbxZHJklt7o/+qSZewNTC/2Shtk344rfP8LNeQHSuxr/gXzrXmG
	 ouyepHHvjOpr2dPJ8YTEN4uoKlVlAjLuxx4yGNamv2wEf3sneICE0WY2inKbIiykJE
	 24+oB19iB6PYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EBDE405AD;
	Tue, 24 Nov 2026 16:30:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B9C22371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FDD0607DA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiH1hioNm1OA for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D642605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LM7Ky5rW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Y9SFQxD/
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D642605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL9Wb1215356
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rizMPeB7poDtArVvRCfddvafeIM2VFESxVC7T027dMo=; b=LM7Ky5rWQqaUiQBH
 BN8iy3JATxjtE8p7MqvNOzsW3XFUtUnJ7MiYV2d/WUfNW0O+NuOLKKEdzmJeGtX7
 8zVunQNqB6lsEcBD6UCsIva9g3HNl+S0mTdwsH3vGzxLCmlYDc5mj0laCV+UyJE8
 NFBBpwsZYGZpTU0hhROzJk/T3vlhv2qWO4bpQ8vsBsKrsW1/ki4X567n1vymIGgN
 2byNjVz6i6znZet45Fp5BPyWeMELdbNqopl3ImLFta7OO6zbVprymB05l1pl64xm
 quaC63uNdZ04ESKTtDC4/P8NJnEBuln37CFv35FfrgPHjsaY0Lj0C9llmGtQir+l
 FubGBg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpjsb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:56 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98a9c848bf0so594334241.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537796; x=1796142596;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rizMPeB7poDtArVvRCfddvafeIM2VFESxVC7T027dMo=;
 b=Y9SFQxD/uZ/M5sBkaz4zUeGzMTgF5i6/jkn+PF5MurINW5JW7CIxq+GlWxZy+BYMg2
 CI4DjK8qKG5CvpaE+LMOmoQEWn/Jn6pf5Rx8jGSi2vuO4lfJqzzKEMcTws/OSCS94bX4
 ZmT+xW3xzFLg6osH1h1KcKeGo4e/r+ZrsppPMnAn3uiZ2B/H/HWK8xaY+7ov+H5bcZRb
 iCLgqxxJH6m+Cpdy8Qxubk8X8sgOQ1wPfUd/OK9UHgeE/DQt6LDTzZKQtgetTxnEPuC6
 H8Vg9R5VKCYQJpGUngVfVy9GcsmWPFjFeEKtddlRJU6kgexvtTxZ2phEXm3Nnef52Gdh
 v11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537796; x=1796142596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rizMPeB7poDtArVvRCfddvafeIM2VFESxVC7T027dMo=;
 b=wVndJCp0/ODV8F9TYCfQSMlFLX3A5S0m6byubOlDgNbrIFMXatomW2ejr5r34s6Y6M
 GVgKJk6UPDcdXc4P4dEqJeloOq3SHWfCPegnkMyQeLQ30z8NSGbE8laxlgjrgRzy9hol
 RU5SsDCZwsdnlnZMAJE7quMyin3+hNnzimzhiSf3Zl9y4IVdCgW14VJjYQjQ/4mKwKby
 a9ov+gfexbwy/TivMObzkqj9myWYVbbfWOk36owhfoFbzqrnXvVvxpI379zx5/nJQnjY
 P0E00kzeYnXuejThAA+4wEw0rUn26vt+Te6X+GxyLBr1W9xXRZN47kp04/UInjSotUBo
 O+yw==
X-Forwarded-Encrypted: i=1;
 AL+hErFeN5+yVGbFixj5+vWN8ypXXAjWI2X/Xr4tPTGqIa0fHuZmB+08PCfiVyWiI5oiOt11GnU6JiU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8qxWn82ucdUtP3anJSnvxzdbfXMgB06fVtTkNKWzlocd5tCA5W
 Awy8pdGZKPsvOZ/ALTy6s4X9zQBtPAXEgLIFZ2vpdvF9BYmtEsRtQbwb2pFsvUQsVvEEmxC8qTf
 tiQ8LemxFo+KQdJU/sam6lVTT2E81CfvorXkpztwxn55C5KdnWZZ7M93wTKReEU5qSgkSnK0=
X-Gm-Gg: AZFdTZcCMnOf3+UjBEY25W1CZZ+p+B0N+rbNwngChzxWOVpK0SpsbWwbGd7snF9/4rA
 VUIt7Hn5H8piI2wACGV8C2cRirZW307XLcW1ybZFneaAb2UDXeWt+zvGurt5zlehKR9bO5ByxlF
 y+gs+FZzne+mJmob/GBiKhL47pUUA/sUZs2rpeuLynEQju8z4+PwcyZfG+iwzZzC3shnhf1cPyt
 1vqmTbAQC1hStK7cgyW+mX3cRJ9DGMlGZHHQjelPbopL0XzK/MG7tlFC1sVWWE84BeXvdnanI2w
 cVpcfeobjKkiwRIUOdX7Zk0yRusMgSjFvYZNYUV4v3VBXadJRv11upY7BYPxM3LL0em8LRqlXme
 oxPFd1459v1rB8B9hIA5JT8xSbeMZVP8EKpo+vhu/lUTA+XCftjYBnQuAF8pwxt6ag+z55YQ7Z0
 oRdGjzDSH05pp2
X-Received: by 2002:a05:6122:e44b:b0:5ea:98fb:e9de with SMTP id
 71dfb90a1353d-5ee8adf3d10mr7397203e0c.3.1795537796141; 
 Tue, 24 Nov 2026 08:29:56 -0800 (PST)
X-Received: by 2002:a05:6122:e44b:b0:5ea:98fb:e9de with SMTP id
 71dfb90a1353d-5ee8adf3d10mr7397158e0c.3.1795537795686; 
 Tue, 24 Nov 2026 08:29:55 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:54 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:24:59 +0100
Subject: [PATCH v2 2/7] test: avb: test the hex persistent value commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-2-ed7136c3767c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX09JhPz/m1O+C
 vrWxqoCl4x6mhIjQ7SRjRnZGxZuaQY7m+eF1hIp2xQ9PO9sqhGnyJC89SNnoYMxtx7nrAM8KSZF
 oC6Q4YgSeCqtWVvOy1f7A3xBjOREITnpuASFD1hE5i68GU8NxDNELWGFEphsKGaL4tbbsNneY9R
 AOVLXNqhjzGALb1Q6LNI/yjgSCcXfG27TA6KIitEYAHzFWQK0PskDplI+BL30rVvAUtYChUqglN
 crY0a1XaEBzVCgiqQ7QuEHIZ0GoQXv58M/hVxwbFRgTpHJ+r/cn9Le5mTR9KiyM1umDoxDzgpLf
 t4Wj9/FkcO8YXmO2eDbzq2E2eEF8ObuhKSvDgeGzfwVd662vhzCTdvGFT8+1V9bWoRtyP+79Ds+
 f0x24nFDZzP5VtDo18q01izJj+h8Z3QkOQ3oyR2PisyiwVZhwpkxSjZvPMMhnIeAFLzaaWtAr6J
 dj29JDfcIfZT4uJQfoQ==
X-Proofpoint-GUID: pNhMYjnJNuySiNhhDAyn12Qi2Wya578D
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b05bb84 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=a8p-q2BOvgTI9nRn-vcA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXxU42gqZxGV7E
 U0VxYxSJYoVPLWee8POXViaoCl2hnfb1Tpm9zaxKIs0xk4Sz7m96KGcWWxeaa6jc4WjAjvEX6jp
 7Q1xetW+Ja+Myw/d8v4goooAbAPqPVc=
X-Proofpoint-ORIG-GUID: pNhMYjnJNuySiNhhDAyn12Qi2Wya578D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Persistent values such as the digest of a user-provisioned root key are
binary and may contain zero bytes, so they are written with
write_pvalue_hex. Test the round trip, that string values read back with
their terminating zero, and that malformed input leaves the stored value
alone.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
---
 test/py/tests/test_android/test_avb.py | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 8d7814c06a8..f48db30a30d 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -170,6 +170,46 @@ def test_avb_persistent_values(ubman, avb_device_id):
     assert response == 'Read 12 bytes, value = value_value'
 
 
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('optee_ta_avb')
+def test_avb_persistent_values_hex(ubman, avb_device_id):
+    """Test reading/writing binary persistent values as hex
+
+    Values such as the digest of a user-provisioned root key are binary and
+    may contain zero bytes, which the string commands cannot handle.
+    """
+
+    response = ubman.run_command('avb init %x' % avb_device_id)
+    assert response == ''
+
+    response = ubman.run_command('avb write_pvalue_hex test_hex 00ff0010')
+    assert response == 'Wrote 4 bytes'
+
+    response = ubman.run_command('avb read_pvalue_hex test_hex 4')
+    assert response == 'Read 4 bytes, value = 00ff0010'
+
+    # The length read is the stored one, not the size of the buffer
+    response = ubman.run_command('avb read_pvalue_hex test_hex 8')
+    assert response == 'Read 4 bytes, value = 00ff0010'
+
+    # A string value reads back with its terminating zero byte
+    response = ubman.run_command('avb write_pvalue test_str ab')
+    assert response == 'Wrote 3 bytes'
+
+    response = ubman.run_command('avb read_pvalue_hex test_str 3')
+    assert response == 'Read 3 bytes, value = 616200'
+
+    # Malformed values are rejected and leave the stored value alone
+    response = ubman.run_command('avb write_pvalue_hex test_hex 0')
+    assert 'Value must be an even number of hex digits' in response
+
+    response = ubman.run_command('avb write_pvalue_hex test_hex zz')
+    assert 'Value is not a valid hex string' in response
+
+    response = ubman.run_command('avb read_pvalue_hex test_hex 4')
+    assert response == 'Read 4 bytes, value = 00ff0010'
+
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_avb_init_interface(ubman):

-- 
2.53.0

