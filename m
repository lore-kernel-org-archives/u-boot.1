Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A95CA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC6C860708;
	Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20l6UmRpkYS3; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2C9C607D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452970;
	b=TKDbfw1bQTdEOGJGsWcLOEd3exj9EOTOelQ4XwvUHsF4lmf5NMlv4GQEx2xUWH8/FL06
	 J+qA3OdSJBokCqEyQbQKuvW/DKm+Z7eij+5Sv5Fz80aGt0KuW4pRRzJ4wMS2I+Skv6Ke3
	 hpJtSzBVr+lz1h5HufzteoZCAImd6bz4RnnbItOBYXA5AoeVSuMAcfM3SuPnXpZpGe+0Q
	 s7C4nLRbQxEZ0iBKuxR1tWPeeolcSqTDeLdiNJRNgI730jG+3bdzTBCDlFw+K+bckw/8k
	 kqbNWxcO/bDJpZHfDvZepY7l5CY0DuUXqyTTx8ULcH3HlwD5/1iWjGcle7zz1zu90pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	b=TCLoWRTKwA4I74slsIB+nYZLjigwtEO+FrTd9vVuRq9kBvJGn9GKt4HnGcjRfNnk7O1+
	 ihG2HqA3q1g6U7MHZ5poK22N9oIG3fgdt4RVGzIDYirraqNABS+HzR13VmvxzPuwNSzvA
	 qVBnpTGGpIRYP4t720tAlEtkasT1zieYVA1bWHvKqD75NL++2/xWcqnzM43GkwSgJS1af
	 IoPFfY7auDusrhheVQGT5gTRd0+UzNIeI7gWcDKctmRV6nJLbYxsZqw1BOn2/RKJzAtPd
	 weLTzl+cVetMFPRBVm6i9/kDQX++gQh6M+oYg2LcDbIqzB2JwEfQEBwV8/IPWLuJ+ZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452970;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yk3DHK1gnhFBAmdXLnnXnn8uY4pdG+FF9l2U9PR+CMk+KFf7OfhUK+qWDvleMvpkz
	 OmlfYtGL72sG2C54kYguBVH9CEynuc+LTNz2MJM8JCLSEpWgjB16P272NWUxqntCSH
	 ToMMjlAPaDxvNCScHqAcMFgQ+1CkeOjKgl+0AwYuzbMJnsr2dzccm+dCRCykXdn4Zz
	 EfGVN4AX2W0X50pVwAWouQUkeED2iOfE4+4ySTjd5GOgMfi769/EWpeyvyILqjW8q3
	 u/XwaSbMMhtY8DgaQdux1BOy+H5TaVY0GjO1mbJlRbJLu5XfMgey4uz4NW+vcjHGAB
	 ndujV67FkaV/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2C9C607D7;
	Thu,  8 Oct 2026 09:49:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC9592AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B31AD40944
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyRpANyDUwiE for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D1ADC4091E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452965;
 b=VzBbXQVgyY9gmIq8d+qhGTcDuEY6Ywb+InIXItFroTYzkqFvRChMX1X+eEWfeJQ6Rnw8
 +x+69OFPXHaHEoRNVjQVWYKrh2//YD5WF8ra1OcXenaVEpxu1aAVJc5vjFDJbkcPG63lZ
 T+uoRmvkiZ8o+BkRpZKwCHei7ZuKa4UJ5lCWMDlU99d8JP+zQ21Ua1H/og6ghBQzrbwqL
 R8SPUnaifaprR2OpH9PI46NLMBfXJfUmZQQMpJ2HCLlNtLM1EhwR5YGw4QYFeg/fEmOZx
 8hcxmtIYU0ckaDiIlItRKMq62C1GU2pAsiorxEUtORacfWTuNNALyxY20EqiHUMeU2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452965;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=iS8yJMsf2dhC65kwXyYjqEfGMLOUT10uW2USM0w2ClIBNomTVG8tFHFdCSGTMr6Y93fQ
 Ttnloj0FejlX2cfktFJ69+afNp5dXAVlzupeJpEj2n5qXiOvyN68COxDm21MEjJUkldAf
 wDCNGRq5A54mIffG9F6LpakSsn0IqM/OzxGMwtmnu2+4M9T9LDJcvcNkBqYynJ1SXhDF5
 eImGL6862C/tg6b5c+R6X82iHwBkFaiWeBLnKkTcVqd5PYSfNcwcVN6pOCe7XrKU6lfjZ
 ghdQ5Zy4chIG+iCXeg/l5ri52hkdjDbUAOtcnEkoAoQK2DkGZJ825VUTA/D+kiYBzQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FKQ5xUO3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QjTYc4hb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FKQ5xUO3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QjTYc4hb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1ADC4091E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K1M21341629
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=; b=FKQ5xUO3HFF1oz0O
 pMqqV4ovEXIn4iwyPf9OeAXrLz+tAJkF2vfZer+Man1RBCqV5ud8B6zfN4AjEGml
 v6QfEinlzkNSwQwIlAn31gKdsjROrny0e6327cbj+wZ4qT2puo1dlSK8KkHgavkT
 Lcb3r+GQZak6Et9YjoKwJbhulwC4Y0HpDwvM/PhRDAb/hnEjRuxnv8fUqC8XKfK7
 QciCwwkHfy7JXqmM6JyO6IeTabJhWqUtgCby6JBIqKuDzhT7ovZqUXHfwExGxMHH
 88ZzEfBqGyNvik5LIOx/qmAQWFluLszrQPR+/CQnS1mGxFtN7gUGINtSrkZb5Frk
 pfNBpQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2t9x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-147be78cd56so18330708c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452962; x=1792057762;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=QjTYc4hbI36+eytYxDBbtUKqyl1ksmmNjcD0yH8Ko0DIWoWmQ8qsnzE/XCvB5BeAUJ
 /B8fOK67GKW4XNRcQJ9pUj+/uKUT0RAN4QpsU2091Nb39chX+unS9ycfGxH8w24H+tF7
 YiAk6la9EXgEXwzZ6VoyaPD+YoC8BWAbxcZWlEWMeKzDlNgeX8K6vLBb9vJv0H8Y6cGW
 nhcdOp5gGrdIdnCjh9kzAer9s3x3dXMUlSH8J3W65f3fgOCb1kciNEgdllCdJqWZpCpy
 6ijJYpZJVxA4qr5JP3kx9twDxEZwVQ3XVmDCwbtwAf7l1HVPOtws/M6OJuo9Aexs/6UD
 3qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452962; x=1792057762;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=JcuIT7OafFmsh1+Pmov6GQRgjY1GBBETIUfS++g0QXTQ6Ds+yeosr919rJi2z/YAHo
 HmZ15KiZkD/FmofogebD+KRVxZkNy//SnrbKpdiMbMwZ06eCRlaJ+YBgpSUQtL7HH6p5
 x10ih3FnCFAk8HsQPVIqyNdnhzSoiaRpJ48nUrkIS7kZyO9G8euqgSxgn5Jaj7VlQx3r
 6XH78evd9fafRuvPT9zlSBYMwhPvytlRMHOxcCXjvu/US8Mk/lZmI8kQcztzIfnX4iSS
 h2X19ItRdJyhMq9AWTMObuPbUaXnM8IzX898TwkKanTQUrpCy2FyLCzf1GIN/8MyDtQo
 hj1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe5TQSiRlAuCbGsBYzTg/o53Ty0PJb02UAoTLXtIEpBG3Uyn8dnYxKJN2XzzKlf3wkoqXqI/o=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++np4mmsQ4vJVGc5u4zVB8QpwkYkggD1V1Gk836GA02pqp7BGoov
 tpimek2svJYXlb7lh/0BBYgv7i7cSStMGx4D+ZQHYMcb74EGI2LFrMLCV6r3TwwAEqP0yORzXPF
 IlAT5zQWu04IHoLbFgIPL86yWC7LfxvlKrWWSYYrr2ST1MX9ntKoIGot+KafKWHocWMXyaxs=
X-Gm-Gg: AYBFou0C46LDdqeNTL+8uewAAib+SP1jWD91ORf9tvkCVQOzH0Ta7PogDYqDR6O9QCI
 Ty2exosobB2LCmwHB4Bu0vnVDyVUzdclQclJwdRLvf45B+LdaYTFuhrxldMLzYnALFEmNbpdeNv
 WXiBp+YIa4+igsbJtz32l+5L1AbvPeZjp3mStDSAkui5anw3qaFtdjsWWD8paJPSW2fqv1cfXMu
 yGF+6cRmBppyF6TOkbTfJISTYtlPwdSYEpNSbcBRYxC1Bbjml3zPjx+bN7sYf9qtX9DzteM2UVs
 gS3gjyhWemQ3urF37sCGyxJb/U1STzUFl+NF6X3WxSrEJ9TgyIjinnlrz84905X3NzgBS/Rb9b3
 HKV0vKRFaXv6aXtdRWeqM1HK7fVpEiYl8OdE4BCh24+jwTQY=
X-Received: by 2002:a05:701b:2096:20b0:15a:9834:73c9 with SMTP id
 a92af1059eb24-162089f4544mr5655734c88.40.1791452961779; 
 Thu, 08 Oct 2026 02:49:21 -0700 (PDT)
X-Received: by 2002:a05:701b:2096:20b0:15a:9834:73c9 with SMTP id
 a92af1059eb24-162089f4544mr5655678c88.40.1791452960969; 
 Thu, 08 Oct 2026 02:49:20 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:20 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 01/13] arm: qcom: add common QCLIB SPL extension helpers
Date: Thu,  8 Oct 2026 02:49:00 -0700
Message-Id: <20261008094912.419090-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX3RFDDPo9zK8e
 joW/GSYeOaL3OaU2IyzPcgX3h6HLMSTA7IanAjJxUPUxMa9y7v9qD8O3ILLJzdsli/ip4+6Rs3J
 9TKJBdBjyurja+r2fE9ykpcUKeSJ/84=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfXxyMkJJR3DI31
 emFsbIt9G84mMNaY5aI94N3qtl8uutBObPrDv18Rfk0WUsmsOlNr5gRgPCCTTKJTEMzcqij9SHH
 CDh3ZUu/blcPVNJj5dQTdyioP3XyIohpVbhHaQWJSMAjKuAkdpa3jIyrEsNKcDh+VXYNYjygqpC
 M1OLIbWvJYBRT1wyGVCUBC79O2gMpxNP/xK/BuVlmDOX2MfAumDJsielOU1VAd4dzVYcMPoaiJQ
 XxsH0GQZzgDTgyN7Gy6b5w5HLlL1TjZdIWFghiiaF/uB7DzLoNwtt8iM7cB+G4gytBZkF5mvcMJ
 cy59ZIjxCVlKMj6jlUCdj2kLrqwLLUSgqR+pV6UH+I+UxvVKsPaqNWbieMqHS/MN/gYGERbTzmR
 Qo7MeWlAGN5ffdaNgifebn/NjdqKpKHxHyZIf+PMH/qILYpEQFbpDg60l+ncveJB7yVoBX7m7JP
 LVMIIxHL/jXJaeDv9aw==
X-Proofpoint-ORIG-GUID: s98ImmwejoWcpbMpKv1CE9hftvKBEtRN
X-Proofpoint-GUID: s98ImmwejoWcpbMpKv1CE9hftvKBEtRN
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac76722 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2F8QJI7O2KTJmeVboGYA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |  8 ++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..5aa84a3a6d1 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -27,6 +27,14 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

