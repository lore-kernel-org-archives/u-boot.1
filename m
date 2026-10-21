Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF6606A325
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KQPaO/Ca;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mMnQiAqm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fWZiFBuv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10EA14081C;
	Wed, 21 Oct 2026 06:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nu1nGjXjl3n3; Wed, 21 Oct 2026 06:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 538064060C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565006;
	b=auVeHV7zGlZHJpzmPySclqpWoekZS1mQZy/tae1d8/SHAwRINMVKYi1by2fyQdJj4q9A
	 tzrQ2ed1vS8c/c3hZpE+nDUMj9X3CqhJ3tWpSNe2jfJiuFqkTlrHoX9olI4z/2kNT2o8g
	 ugiS3nb9p1vu7ZbNvU5J61ozkR21qTy5zPTD5elDB6s2SM0SVfgrrLZ4bbnkX0Sf+3aFD
	 Wz5c+vFZVSx3O5Mbc2z4vScUDQ6NFWwFN8UFq1MJrzln5/8csqhKJJaJMQMfR89bFKdK/
	 /03fFs6JBZdyy6x99c1o4UDQUbTM3JdPayg160M5KOaRcA7aHOTc3mmAiQ9pNjj4J/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+pWYqAtdamyqp1WmBN4NQsAF2Fh1YdtBLj/r4YJt1UQ=;
	b=hLTHWwtUAG1j1hKMkwUrd77AHOOfXIR2f1Fxu5UnBTsvsrI6CXJXo+roE7IT5ju+jaBr
	 3Mdb5IZ4ph4xyg2/pkwbg5Vw9ljThWj+Rigo3NJzqZ4M/WZh5ouGLpGab8tWltbVFhvUr
	 /0f9Nbvisj0m/RuVRizpq4H8WDrNxQ7LNxin4I5ook3mCyRlFty7TONvY6gnG0HaV3duf
	 FCNz2eVhboIOt+ysiDTNlr1NwjP1LCRTWfN4PTzXOH38RXEf8vQKYTjzCjMR6mKb0txVy
	 d1zMkjCKkaVjlx4bocav/tjK19bzkKt3mDqCO/V/W1Cq0jN4dlTk2PGmLtOqDU8VDvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565006;
	bh=+pWYqAtdamyqp1WmBN4NQsAF2Fh1YdtBLj/r4YJt1UQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KQPaO/CaDe7niXCs2iVqvV9f5gX9QBIgF9XhYOSmdxLK5JZVRATsPde/U6KA/D4hJ
	 ngtRdLprxsRXtoFN0OlnETvYo/qacgOyQw5BMapDgp1MtcFLyiPll8oLnZQHtI/1CF
	 KCJDibZ4hhZ4qIqm+Onzgv+r0HbV/XkBv/pjlULWfTOFyByX9pgM6SqRSQuA6dFg1K
	 UILCCn9v86ae9ixmf06sl2n5gyfwGdEbgqxPhc/9uKq5BO8ZeR1B7OykPz9U/rvPRw
	 1vadFAMelBIK0ppiwKkMk3R6KWHvwki5XQ1lnn7/MTrZQHzvGUnKwqjY3Fv35zVaqD
	 K/yx4Eex1aEpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 538064060C;
	Wed, 21 Oct 2026 06:43:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8C16995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E9336078A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWY_bdrP9l2O for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4F71606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565004;
 b=awtfgBfq+Y1NAKoeve2Hoti4hqX+tJIxmXMR0TZdGQbFeKkgruUD6Qt7pZpq2Y2D+OSj
 Aglrprub6u107xU5PFN0/KYXL6BqZIC1E/vdaMFwh3L7QAw2nEXk1WH1DWHujyq/h1Hev
 bKQPwrhoMocvDaBo7ev6ONvomdINn5o+pjRXS3B8y/ghlyr3k4h+F0WZO/hq3IGGvhXWF
 iEIvIeNROBJXorSsd5HrTai+FEdePQ+s/HxwF6MuEFK9JppGr+Gtix1Vu5+arpzhKzJpd
 GYwf7fk2bxa12uKiSurO3db76Qj2N2AuVwsSWTw7+REAT4Ydoy9tW6Bv8delu0os+Uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565004;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+pWYqAtdamyqp1WmBN4NQsAF2Fh1YdtBLj/r4YJt1UQ=;
 b=WOr+O7PafuRIrKiqVxSi3dZtyRDIuOa07bQcnVYvSOaU7DZFmAvaw/EcQSHMKwBQ/v2s
 64SLhI66L5f8EIEBLi2nc//gR2TkER7V74FWANfwHNZEW2lIYnaiMZXWTT7/MXduVKiL8
 EPevV765IwnoKwmQNEwg55KkHJ8m/TFvNbAp0MdKLqBJYDUhMDeoHU4aVAQvmiFq+R+1B
 Dd3M1y8BZ+QX8aqrRNEAyqXlpCghouMVjtvbbPPxwHz8aDaMPIJApUuSvXmiH/i/CcIuW
 15GGsjVSmFceixVW/gjfqHKXrFHhEpyBBG9Tg2anH2Iz99nw+q2aKUW4MLdY+cKZoGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mMnQiAqm; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fWZiFBuv; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mMnQiAqm; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fWZiFBuv
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4F71606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5iwER164993
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+pWYqAtdamyqp1WmBN4NQs
 AF2Fh1YdtBLj/r4YJt1UQ=; b=mMnQiAqmXL2cch4GVtNpzIIDi4EXEGop06UjWC
 r3TXhVRTviF7LjcFxWnkhyzTeyFMAyFBU0zJtlwvskQ3fT6oENJTAxrkkKApoZOV
 9qZ8KRswbGlVe+ppqNu5rQvVDJVV/5WFtkH8bQWB4IVHvtAyVzb739oT6iGnSu8K
 g6Q4L/iLsXgJOKBKzfBn1tCkrbvhC1dLJA2KeLuyXqk48raRUm/c5/sVAAkFgqFF
 wA1RXeiRkhU/j9u2Y2ZGVCO0S/Nm8/AmT/7Ea7nbKDNVhoBcFRhdHU+m48LOwFcB
 T9kq1YC2K67uRWVsNDnQ5UfgLAkUt5BeFn2OG9MXBnpwHyrQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs01ju5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-351788121cfso1547925eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792564999; x=1793169799;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+pWYqAtdamyqp1WmBN4NQsAF2Fh1YdtBLj/r4YJt1UQ=;
 b=fWZiFBuvZQLsDsOXEPdRF+U09agi53RppyJoCnQ45jLxfTh+XLjY0KoAWz1dYF/3GB
 lBhIZmnDpLWRuTv3VqlDKilibMg5ULym4pr/leWBM52+G+MDUJnQqRpVEU6C4oGn1XGw
 qhPijV3GtwGBWQL+Toaq1xMBrnZgQXW758MsJt3hoK0ZPURGdR0Iz7rtKZgOc6HUsZVB
 //zSju/3iqtDBnf/8sGrmkN4wmGO7Kg1ZW9BlGkdQ9PK2ME+g0lTi1eo2Jgc8ABz+AvH
 7mkHlN5jgEeR7gbwYWvr2/M4ST2qn+Rm7i7YLApGeb+zZMDxhBVGCPy00L0LMks2oKKC
 dfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792564999; x=1793169799;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+pWYqAtdamyqp1WmBN4NQsAF2Fh1YdtBLj/r4YJt1UQ=;
 b=uvZab6i9+SteWm1I8qVX8Rkfu28QCBSTXsRGVof9mS2dkf9C8RyQzM8ySrf/6l8Yls
 dwtLIx32sb76rKvebmZ39K+Bm6DOcofi4Ea5drGErzHUOb9GSHSvdWz+TchEjp8TT2hw
 i+yo7GiyHCZjnCtJv/07xdiHzZil03Xbeui3CNNjN4Ni540zVrwYcNT305CIuA60sjbq
 VvLNSNnzEfVazCan6pv2Q07uTNtkEQhZjYysQcn4OWnQGrPYwB+EY1e4ePhUIv81WG4h
 ID2jcDtuv/BQdsaMuDvSVQs92vhmAwT80Mh85/haqkEOVme7p5l/+zjUrJVEbyXYhylF
 UVfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpN8msDH8rjhYKpp47fOQUz4D63D6VU/4Q3huiMdzACSlpN/49ktneYTMRnD221QbawK5+47Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ1mrUIlgEMwAZZf8TYegQpwmE4rv1JNHIH6B9JYNrOv7CnLsIL
 9kiI9axl5UDYDbHO7S+V2JQMffIZD5fTS+hjivxBHnN9WqBKhR0ME3ymrkiPRpHr2kKG61BbYf0
 6OyfxzSMIoQX7emUuzdyeqEOBozAeXTwSZMk2tcKxTEyLiQ26GcRK5kubH7f+bdM/uUBg57+9ve
 IaoFA=
X-Gm-Gg: AYBFou2u0BEvVfztV6Ia295JF7wtkV+eGJ8NMpn3fCR1J8J/3Rq6fafvWju+uabvFoP
 0XZgJvtbLdNwy3JKBW0P1b3EKpjfPoNWGpEzH7fJ9IXwg9BpJw091eMcH2jaDL8OblGMGa3jxW4
 gWZ0QxBqcmLwb3F/0EgLKw5mkI0JO5nq4REXNIoydbI/slmhx4fYw0mmzRHlMmzM7tj4Hz5gzPY
 /wPltTHJve2NWSos1TRIXZ/0Z1swDtKBCrCJEnwEBZ00urFq5jwpmtX0NO635AS0rIdrou6CmdL
 tf88eJablJhlCYks1cbLNqhduEonKfpsTPOIv7Wg1sPiUKbXdCnDC7v/NndeAtd/L7bGkMqcqd8
 Cpg3mr0I7U91QB9I74SqRQlyDja89fWctmjQ3ATZ/upmRUKIYHrrKRqrkVioi5EVfDb3scfAbVM
 AAFMYZcpUBrhfSx6zNCgLbMNC0GUhx
X-Received: by 2002:a05:7300:f80a:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-367c9ad42d2mr644016eec.26.1792564998504; 
 Tue, 20 Oct 2026 23:43:18 -0700 (PDT)
X-Received: by 2002:a05:7300:f80a:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-367c9ad42d2mr643984eec.26.1792564997940; 
 Tue, 20 Oct 2026 23:43:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:17 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v4 0/5] qcom: qcs8300/monaco-evk: pinctrl and RPMH clock
 support
Date: Wed, 21 Oct 2026 12:13:09 +0530
Message-Id: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1e2GoC/3XMTQ7CIBCG4as0rKWBaUvBlfcwLig/lsQWBSWap
 neXNjF2oZtJ3smXZ0LRBGci2hcTCia56PyYo94VSPVyPBvsdG4EBBjhpMFdjQc/SuUxsIbQzra
 Kswrl/TUY656rdTzl7l28+/Ba6USX70dhGyVRTDDXbVcbsLU19OBjLG8PeVF+GMp80IIl2AAUt
 gAsAGs0cK5IZ9gfoPoCAvgWqDIgheWCAtOi4T+AeZ7fEWbZ5ysBAAA=
X-Change-ID: 20260805-b4-monaco-26501bf7c863
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=2511;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7bJcjV5d92t59y3DaRqADO3gXtY8ul3TPmTiA3mq/Is=;
 b=vHZQpEkafJLwIzhHyV9f2jhZCKG4QNOIQbvmFEkOyd91KjPFNLYUuvdMBo+wDNt/ganQ6uJPw
 4Z3UE09CkrGDwBCqXqNZ+3hMFGu8gIBMBBNURjHbyY7zNMKMgfc9V1R
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad85f07 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PJ_XK-O9SG8a4jHbcHQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX/Y16FTQA6jsg
 9J06r/3q0e4dwFvFVQ/9o9r0/tl7gfmgzmqTedTpSCZP6tQmlYbTbo4k501RdQuWot59lHJw1IV
 7XRFoaSRCnw9HsisHvf1Q9P97p1ADxUAnXfclQW8J2nxKL/K8Aw8UHY+qZ3HAhemj6qv21whpFn
 ynoUkf3Hbt5GAvUpYmiMIXL4PxMuE6fS9qJ7M+IrIOZN5UXH/oiEZQnv9haiY6hz75VoJSr6tB0
 O4SKKYEfyN++PpInFGpeQJoJ2t9FLx07lthlwjHDgJjCQIJrNdT0aLru7Y2RBIyV6uWNyATaher
 rfJb+j5ZIg5H4n/ZNaa/0PBhe/OHSg6e5zJCY0jZzYeH/o84M0gQifxOE/pqs5sDDXQrg78ZJiW
 vlSXEdE8XrLhLm1xXTvOKTEMjgN0X8JyZYlncmauA5dSDeBm0HS1UlMr+aKyNlBYGD5/4B+IFKL
 mPrC4N99dtSteR3D6Vg==
X-Proofpoint-ORIG-GUID: maalwKMgBZq-wcLRUM60kWygWGI0bj0m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX/CEw4GqxFykL
 EvKOyM3F9wNai0B+6IKnKlimnQ1oqlSEaqD7cMLB8B1gFiSgEc+ZUrCPdcY8gy3zYSv6mZQ5iAq
 Fzdt+4MmbP8OahD/U6OTLjGqFAuIOYU=
X-Proofpoint-GUID: maalwKMgBZq-wcLRUM60kWygWGI0bj0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026
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

This series brings up the Monaco (QCS8300) EVK target with a dedicated
pinctrl driver and a real sa8775p RPMH clock driver (replacing the
generic clk-stub no-op). qcom_qcs8300_defconfig is switched over to the
monaco-evk device tree and renamed to qcom_monaco_defconfig.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Drop the QCS8300 interconnect driver, already merged
- Drop the monaco-evk reboot-mode DTS patch, to be sent as a separate
  series
- Drop the vreg_l8a always-on DTS workaround;
- Drop CONFIG_WATCHDOG_AUTOSTART from the defconfig
- Rename qcom_qcs8300_defconfig to qcom_monaco_defconfig
- Pick up Reviewed-by tags from Neil Armstrong and Sumit Garg
- Link to v3: https://lore.kernel.org/r/20260928-b4-monaco-v3-0-a9f89126d958@oss.qualcomm.com

Changes in v3:
- No code changes, just a respin
- Added reviewed-by received for of the patches
- Link to v2: https://lore.kernel.org/r/20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com

Changes in v2:
- clk: qcom: split RPMH clock support into a new standalone
  clock-rpmh.c driver shared by SM8550/SM8650/SA8775P instead of
  embedding it in the sa8775p GCC driver
- Link to v1: https://lore.kernel.org/r/20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com

---
Balaji Selvanathan (5):
      clk: qcom: Add shared RPMH clock driver for SM8550/SM8650/SA8775P
      clk: qcom: qcs8300: Extend GCC clock driver to full gate/RCG coverage
      pinctrl: qcom: Add QCS8300 pinctrl driver
      configs: qcom_qcs8300: Switch to monaco-evk DT and enable new drivers
      configs: rename qcom_qcs8300_defconfig to qcom_monaco_defconfig

 ...com_qcs8300_defconfig => qcom_monaco_defconfig} |   4 +-
 drivers/clk/clk-stub.c                             |   3 -
 drivers/clk/qcom/Kconfig                           |  12 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clock-qcs8300.c                   | 545 ++++++++++++++++++++-
 drivers/clk/qcom/clock-rpmh.c                      |  61 +++
 drivers/pinctrl/qcom/Kconfig                       |   8 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             | 468 ++++++++++++++++++
 9 files changed, 1079 insertions(+), 24 deletions(-)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20260805-b4-monaco-26501bf7c863

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

