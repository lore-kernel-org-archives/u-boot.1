Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F74C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CFAC80A92;
	Thu, 17 Sep 2026 07:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioBPSHHD7Xyi; Thu, 17 Sep 2026 07:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 178938085D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631242;
	b=Zoe784O00lkPWW8uIZMRm0Ficsfw1/QJUDkRWBEhktuMCOKIx+t+VbeUx86BIqZ1vWgQ
	 qK2xZ4QTeT5j1OTIBjdCGeNHqTf3Hatrm6ZmTvnlcAB+vi+3IIxpd2elSP5uNQoB7IplJ
	 EKF92Pv6leLI11pA0FLLDDjSLOqBmfIolqDC0E3wfgNPfoCt44Db+vOUPMUHLvr3TQV/l
	 HpR88bLP3g8NC1TzBQo3FJ4eYmeUhdFjUyig5bcVBjYDq0eBDQZflpUcq0eK62Freh8JR
	 N4sssnF2dApZRSIdwZsLhtiVbmaRNyYlst7NRcpHrAez0EJJ2YER9eNJXWXErRF65dQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	b=D4ytVKBuQYRxN0XZF4YrqXlL5JtRiyDOyV0kbqNcDDSZQwxRFulcMyxkW9lMVOaluRSF
	 JX4SPZA2CkP+fRvpbOoQRDMRp4u8pjFDHnVDoVJrJDOBI63FbhQRUMv5gLo7E9MPHLI18
	 /c2/6EBLdLT9r9qpZunbgdhtz4icxi7+bJti5msVaKthdmE4WdbUhOPJOAea/bEHiiMtw
	 yPPiGJZg3VpFUIb6hEu4C0bYX4OhtByxw3Lhl4/txWtvFPsafatsWirHWKArFSvHZ7i7+
	 K3Gz5OoRn7XGL4ED0owAcpPHYgZsw0LyHNe0bJUlS8Ej+IwvqqMGDPmX5RVHDDM+6FQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631242;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JgWuXW1hPiaRQAYZU3jVRDzI4uoCejLe8SucMb56qKyxfuU8U+KhgpAH29fG5RqI8
	 tdwtOHjqJVQ6R03u90o49Ep4S53VCh3gckfwe72dD9gsPIyYWQZ+PadEhCiiAOGU1x
	 SomR/X1IQxwISwXi/i3XH1a/SvbFXWGYz5z90anSsnWB2LI79yENhos4nNRz9Tv7ah
	 14AZZfgle7LtDd46IyQXxA+en0x70GSu8g0yVOyU0BU0zf7Ce1QaFxoG43huMorykW
	 ilLgCUpypSUZxZSgVUlBgTx1gaWMFVeZ4z597of4XJlwE3iE9oBLMXcpNuhDKgDHTB
	 XM9jDX8mmPWYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 178938085D;
	Thu, 17 Sep 2026 07:47:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 27790422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 250BF60807
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y439dp8rmgtC for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A1B260659
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631240;
 b=bjmuhaHmogzsTc2fTO9ZeoZpvAHUBAJ2qpVF8WERg02Ymgk1DRHPJ6kodxjaUDCVvB4F
 Wwb3DbRzN1AqI1/lbfbFxpGNJ32GmRTkgCLH7oqb0fQFlpXdoOl5GEB1EiZtLD/LI12op
 x+En5UsM4gUdf9Lum/5LeR+iKbfUhRTkDttd8M6MnVR5Q2nBZSX4I2WBr4REJGaVFO+o9
 liYgtTNX9XvffilcLm2UrP2Tn03prDICTWah9tpp/0FeF5FtX8CHj1PzyTAo/HcBGM1Ly
 7eC0JFDZN3MbTmrtIoHhctCz+lT6p1nmijrk9n+OVoGhAnuf7EX5baHt5NzbQc/1DuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631240;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=lF6nFdTc6DCfJPv1ArHwuVMcyMyBYUKkQ+e7r5rQLgWFDGgWRyQHpURShShOea7JwPnQ
 rma0/H+DTetS3vj5ELV/xJjW3nKbJwL8w5L5DhzBdQFwWBYNRd7qgELFdbQOjm7MxvtUK
 cyoqVdu13oYtjd/kbPV45s5aQP4OBbry/aaIMvqD2sWVotB9i7rQPrPfBjOXKK/KuYUq6
 YXUMLk6sYV9d4Bd6bU5srFuRVsrAT50/nw0+cWVLeV2e+QjadeWsG0DuGdXJ6b9etEhdm
 rCXIoeMniNUXBFwxrEoDJ7gsjSieQMU5Zxd5giskj49ia4PVorMb8oPlntIWbloXzQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=D90w3sKu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OIlkJw1g; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=D90w3sKu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OIlkJw1g
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A1B260659
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60sLo1031517
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=; b=D90w3sKuKgiBdHGU
 0s6tSq9kgBKu2JekR0kcidsVUhtpKF7uAS1uO+eY0Pz+1/Nlg2+CkVZqPwmhy2l5
 38mY7bHsR1FE/wxWNuNTRBOQQUL1Vw+OzbmySpqE02S8PC3Li3TyNLVajtU/xPd3
 Quo16qRO44gEwnc8VHnw0McMpTLb3l/YzI9tmqDI5FHjSJEKZ3iRUXcXsy47yt7z
 Ss5/TY1tdoxarGL0oC7L4lrvrS94qfzpqrXkQBDN22dIzce5LHveS/8JOm7pTrsM
 8DS1oq7b51ooj8CtUcHnoCVA9x0L0+IDNjya6dN1G/bZReqU/jHbogRNAPlIhG3X
 r2fuDw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7hb444-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so1049063a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631237; x=1790236037;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=OIlkJw1g++JdqG/lla+N0MPNjcjcKAU0vrqyLDrVrKWns8FH00RoUvD0Ow5gJw/Qnk
 xn5O0LYOSXJ6D2MA261zScwH9W55FBv393tKTBB2u65Lzymj/O5KFu+ubBR8n1roP5f4
 li/HHbjitSiR2SLmP0PBVwP/vnMMjrrhAv+Q/Gdum5J6HrImPyOb8rufxuGscD6mP9N9
 6wrt35Ef7gJlo1jWrmL+3HXBIrAmJrxshB5pKgbWl74dUo6rJw4c4Mo8NnLZ5q9/HwSs
 fzd/f1Pt300TYANZo/sPKaWr2fN5/tTTai3DJIlrPVK79UM/DhZMVrJq2FayxTPphLcG
 1QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631237; x=1790236037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=KbctenTI2JbW/z1c/x/6i8IS+2+NZLeI7SytVlfcQogT3QbI9EYP9plxTvSTEaKDZf
 3Y5B+SGVdAlBU/WTCuY5A6Tjoc67apJUDKYrB5QLdD70e4jc2iNc/JcDRuVEnaX/mR9L
 x6bapmeFba1i64EIEQypSISnZhV1MNL5J/jPfId/lxFzSO8nvOwZD0siPn/D2ke1yq0F
 hgvSVjDCAZIwIfIgPQ6rgmfc4p/oQ54g0nDD7z7oVnmzFqFd3gMToade6Akj2xM89eN/
 LWNKYM67/2J2YBei6+BYJo0zwEHJOJ1MHDTawQICzgHhrCFrl1stOOOPBLK2H7vP75Xo
 5lHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTCfOAm05nFEtP1Bhq2VZ+Y8kRu7/z1h0MxDSmmzHLzxwhFDHb7l97n5UBVLyBfHSQICRSkUY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kwoaHUvtqrz//wYFNOrkASsRJQS8ejy7eUIstQ6FY2dRP5MG7c
 Xdstr1sdI1BEOJnPGDe6P7F7FGWdTY6wlU7L7tMxNS13Ob8vxE2YhE1DrS+CNnc2tOP5e2YQajR
 3xRRoNH2qgAlK+8KE7Hq2jBxHqyvjft7qu2KpowL+cHpiib8hs37N+2KFuIro+uY/MBuP24s=
X-Gm-Gg: AYBFou07GK4TYOrlG83O/yvud/5kDTdEDm4xPdPM0Sw6hAPEVcFwCNse6GXklamcfy6
 WNqOIYbMHqVe607bd/IfOHooWlesVZPXe53chz3zze1t7AaFYQxN+Re2VGGsJqbjBgQ3/ejTd/G
 a+tZO2n/MCWJ38fwlKMmKA13onRpT9V5djWqCbbTUAujUp5OB2v9kQaMMmh6ii4RZPuq7O0CPyg
 0r1OOHrm0i5mY8J8RS+HArhXoRuLIHTlN4Cj83QG56Zgcae/MPrpUtnerNHG88CI4iE983tZocm
 23nl/5JPVLKtB1FGB28PgVd55d9udzETXeCh3ltK3B3KlVbE6cQD/hgMKIqIoC6gS2BJwWrVdFQ
 0dCDSGqQ4hJaBUVTsS/OocuNsoipXKIzVRgexQEFnRdXFf7Okrzt6KIVCMxT0hpyB3SNVcWQFIJ
 l7LDdWZi0WhG19gQ45vhnQuOGFvx9TWg==
X-Received: by 2002:a17:90b:560e:b0:39e:3bd2:8998 with SMTP id
 98e67ed59e1d1-39e3bd28b84mr7162279a91.22.1789631236462; 
 Thu, 17 Sep 2026 00:47:16 -0700 (PDT)
X-Received: by 2002:a17:90b:560e:b0:39e:3bd2:8998 with SMTP id
 98e67ed59e1d1-39e3bd28b84mr7162099a91.22.1789631235640; 
 Thu, 17 Sep 2026 00:47:15 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:15 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:38 +0530
Subject: [PATCH v10 09/15] mach-snapdragon: Add Qclib handling support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-spl-v10-9-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX5fWzCSOJiGoL
 IjCE1E8ZR0Y4Z7uK3DixAZAZpPg8zfplXAmhBP974uEKQt9kgD3JpmrhhgenBcVGRUk86Y6nmNr
 7L2xtzPMe/o8HRy4ucR6tlH/MRGMBIDrw+gmjASuXHNArY22U/UzWMfihAjZPpcqmBnvwYBqWR8
 ThQReNFSdO5SJxIYnYgLf1jQLpqM9ru9FaykqnOAXLbQxbComZEuXDxCExaFlHi0GP9ya81oRtw
 l1f/k4ugaMAYPiRCWtwo3vLheJTXCUIStQKK46RDRpJDN6O17u8f9+PGkLcJH2zsi/EKoNEHSNG
 hZlXxkcu41TVAj43Z27OnrdbHowpFWE81f5wk8JeCAbwLy/G/wdyU8W8vo1Lguepqthc5lkpNd6
 biJo9KP4A7fS9tUDuTy55cmO8EWvVuEYMEi6GGNy+0rrIW4StMPhstFq45C3h2hbaGYxbb39WIA
 yo8S50VC6PnMyJ53INQ==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aab9b06 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HzPM5V0Xy-isX-7IJPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: wmVqrk5AN-WhjzlGtY4QBEin1565Lho1
X-Proofpoint-ORIG-GUID: wmVqrk5AN-WhjzlGtY4QBEin1565Lho1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX69SuU2p+CK1p
 8xauV604J8SaiKfucOjYTFahMA9jdE9Q6Vl+iei2p7eSxi13bvw3WRGWZiKZK8K6hdrROHMwtxj
 U6iM65T/fLxJiyfV9IYM7cl2qjAEERI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

Add functions that handle loading the FIT image nodes having the Qclib
executable and executing it. Also provides 'weak' hooks that can be
overridden by SoC specific implementations.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile             |   1 +
 arch/arm/mach-snapdragon/include/mach/qclib.h |  82 +++++++++++++
 arch/arm/mach-snapdragon/qclib.c              | 160 ++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2701f7c6fb1..fc39f7381b3 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -9,6 +9,7 @@ ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
 obj-y += fit-handler.o
 obj-y += pbl-shared-data.o
+obj-y += qclib.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
new file mode 100644
index 00000000000..b44874c514e
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCLIB_H__
+#define __QCLIB_H__
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+#define MAGIC_KEY			"QCLIB_CB"
+#define MAX_ENTRIES			0xF
+#define IF_TABLE_VERSION		0x1
+#define QCSDI				"qcsdi"
+#define QCLIB_LOG_BUFFER		"qclib_log_buffer"
+
+/* interface_table.global_attributes bits */
+#define QCLIB_GA_ENABLE_UART_LOGGING	BIT(0)
+
+/**
+ * struct interface_table_entry - Meta data for blobs in QCLIB interface
+ * @entry_name:	Name of the data blob (e.g., "dcb_settings").
+ * @address:	Address of the data blob.
+ * @size:	Size of the data blob.
+ * @attributes:	Attributes for the blob (e.g., save to storage).
+ */
+struct interface_table_entry {
+	char entry_name[24];
+	u64 address;
+	u32 size;
+	u32 attributes;
+};
+
+/**
+ * struct interface_table - QCLIB Interface table header
+ * @magic_key:		Magic key for validation ("QCLIB_CB").
+ * @version:		Interface table version.
+ * @num_entries:	Number of valid entries.
+ * @max_entries:	Maximum allowable entries.
+ * @global_attributes:	Flags for global attributes (e.g., SDI path).
+ * @reserved1:		Reserved for future use.
+ * @reserved2:		Reserved for future use.
+ * @if_table_entries:	Array of interface table entries.
+ */
+struct interface_table {
+	char magic_key[8];
+	u32 version;
+	u32 num_entries;
+	u32 max_entries;
+	u32 global_attributes;
+	u32 reserved1;
+	u32 reserved2;
+	struct interface_table_entry if_table_entries[MAX_ENTRIES];
+};
+
+/* Exported by fit-handler.c */
+int qcom_spl_get_fit_img_entry_point(void *fit, int node, u64 *entry_point);
+int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+				     char *name,
+				     struct interface_table_entry *entry);
+
+/* QCSDI address accessors, populated post-QCLIB, consumed by fit-handler.c */
+u64 qclib_get_qcsdi_address(void);
+void qclib_set_qcsdi_address(u64 address);
+
+/* qclib_log_buffer address accessors, populated post-QCLIB */
+u64 qclib_get_log_buffer_entry(void);
+void qclib_set_log_buffer_entry(u64 address);
+
+/*
+ * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
+ * override for any of these; the defaults in qclib.c are all no-ops.
+ */
+bool qcom_spl_soc_check_dload_mode(void);
+int qcom_spl_soc_pre_qclib_routine(void);
+int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
+				int images_node);
+int qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl);
+
+int qclib_populate_interface_table(struct interface_table *if_tbl,
+				   const void *fit, int images_node);
+int qcom_spl_invoke_qclib(void);
+
+#endif /* __QCLIB_H__ */
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
new file mode 100644
index 00000000000..7f25f37b5d9
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
+ * hand-off to the QCLIB firmware image, plus __weak extension points a
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ */
+
+#include <cpu_func.h>
+#include <errno.h>
+#include <fdt_support.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <mach/qclib.h>
+
+static u64 g_qcsdi_address __section(".data");
+static u64 g_log_buffer_entry __section(".data");
+
+u64 qclib_get_qcsdi_address(void)
+{
+	return g_qcsdi_address;
+}
+
+void qclib_set_qcsdi_address(u64 addr)
+{
+	g_qcsdi_address = addr;
+}
+
+u64 qclib_get_log_buffer_entry(void)
+{
+	return g_log_buffer_entry;
+}
+
+void qclib_set_log_buffer_entry(u64 address)
+{
+	g_log_buffer_entry = address;
+}
+
+bool __weak qcom_spl_soc_check_dload_mode(void)
+{
+	return false;
+}
+
+int __weak qcom_spl_soc_pre_qclib_routine(void)
+{
+	return 0;
+}
+
+int __weak qcom_spl_soc_qclib_override(struct interface_table *table,
+				       const void *fit, int images_node)
+{
+	return 0;
+}
+
+int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
+{
+	return 0;
+}
+
+int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
+					  const void *fit, int images_node)
+{
+	struct interface_table_entry *log_buffer_entry;
+
+	memset(if_tbl, 0, sizeof(struct interface_table));
+	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
+	if_tbl->version = IF_TABLE_VERSION;
+	if_tbl->num_entries = 0;
+	if_tbl->max_entries = MAX_ENTRIES;
+
+	/*
+	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
+	 * QCLIB fills in the address itself; SPL just allocates the entry.
+	 */
+	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
+	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
+	       strlen(QCLIB_LOG_BUFFER));
+	log_buffer_entry->address = 0;
+	log_buffer_entry->size = 0;
+	log_buffer_entry->attributes = 0;
+	if_tbl->num_entries++;
+
+	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
+}
+
+static int qclib_find_fit_nodes(const void *fit, int *images_node,
+				int *qclib_node)
+{
+	*images_node = fdt_subnode_offset(fit, 0, "images");
+	if (*images_node < 0) {
+		pr_err("Failed to find images node in FIT\n");
+		return -ENOENT;
+	}
+
+	*qclib_node = fdt_subnode_offset(fit, *images_node, "qclib_1");
+	if (*qclib_node < 0) {
+		pr_err("Failed to find qclib_1 node in FIT\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+int qcom_spl_invoke_qclib(void)
+{
+	int ret;
+	int images_node;
+	int qclib_node;
+	const void *fit;
+	struct interface_table if_tbl;
+	u64 entry_point;
+
+	/* Get FIT image from SPL load address */
+	fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+
+	pr_debug("QCLIB invoke: fit=%p\n", fit);
+
+	ret = qclib_find_fit_nodes(fit, &images_node, &qclib_node);
+	if (ret)
+		return ret;
+
+	ret = qcom_spl_soc_pre_qclib_routine();
+	if (ret)
+		return ret;
+
+	ret = qclib_populate_interface_table(&if_tbl, fit, images_node);
+	if (ret)
+		return ret;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, qclib_node, &entry_point);
+	if (ret) {
+		pr_err("Failed to get qcom-lib-1 entry point (%d)\n", ret);
+		return ret;
+	}
+
+	pr_info("Jumping to qcom-lib-1 at 0x%llx\n", entry_point);
+
+	/*
+	 * QCLIB is a separately-linked firmware image, not an AAPCS64
+	 * callee - a plain C function-pointer call risks the compiler
+	 * caching a live value in a callee-saved register across the jump.
+	 * Pin the args/target to fixed registers and clobber everything the
+	 * ABI doesn't guarantee QCLIB will preserve.
+	 */
+	{
+		register void *x0 asm("x0") = &if_tbl;
+		register void *x1 asm("x1") = NULL;
+		register u64 x8 asm("x8") = entry_point;
+
+		asm volatile ("blr x8"
+			      : "+r" (x0)
+			      : "r" (x1), "r" (x8)
+			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
+				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
+				"x19", "x20", "x21", "x22", "x23", "x24", "x25",
+				"x26", "x27", "x28", "x30", "cc", "memory");
+	}
+
+	return qcom_spl_soc_post_qclib_routine(&if_tbl);
+}

-- 
2.34.1

