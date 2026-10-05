Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AC8CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE62860614;
	Mon,  5 Oct 2026 07:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZbKh9vgtx3dz; Mon,  5 Oct 2026 07:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CF7D460606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183934;
	b=gpxn+EY+QBcEGf6vQ1yJU20KwfvyQOK8I2ksWPXuzJ/cVVlJribQmNV4Pmq/Cv5ujrvB
	 W8z42vv0+CiOaFaTm3wIL63IkKa1KxQYV6iO6ljFbqsZXnxECK/mM1uDD+gqLNn9upzw4
	 bRSK3ga1lR+OCiLzpcWDR9C526zyu5H1oIi3PR+pjjLyaSBJ+pxuZ7VZi5Ivk8HQJLp1x
	 bBUQaEgHUuZ9/Kt3TKDjC6gq9l/YvbdwqFRecaUT7/PvazPtuqJk4nehHoS4YwOkBbEUQ
	 /ddoF5XM6TGQdVtazuIY6GJwmJAhikl9sf3ZTyxZc2qDbRLwa2/y4PURySdPHJd1ENw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	b=JAFO9i/HsINi8fM1d4q/8R0NJkEFg/WQa/qDFAkxA1Y0KfKHfNXD4XCbWB3fHt1r+1r4
	 ZsoGt628Rt1DpmseFh+VxcxWwZIikRNdwcw+Y7kRMpOS5oTrw2wuk+Sbih7DoLLMASX0v
	 wbd4fRl2BTOoKET7GBbNOiATrrJRFDgMTZpjvNKRUJAYiZwvnzxp2S9LWTokjS6F5AFYW
	 cjL0jXRm5IzIqe4nS7ejh1rdkL9+O0J/FR3Hv3RsYB2zYv2oSiBfW95Q/4qv/7MviJUqU
	 +kiUEu3pYIAm+pKlZkmc/9/gSkK8Vpr5TeIFfncnEPOQ148emepQ1Zfnr4+bKFKqzSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183933;
	bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XkF00vGdO+lQLnSUa6JEU4aluLw5nF9N+dF/5KCNoWgcQO0db7NUt7UniSGmqptca
	 gqpK7fTW9aGKjpXsLjEEfr07fG5EmibM4+qN4wv+IkwLdjdiIvNYnyj0j8XadRIIzU
	 j7y6aYI4gwmvxgbXJltEddwNOGrn9REfwZ4uChA5wTcaPj9/5G6tFDlaD8VR6BTHUF
	 jIWPT44WYub2C1P/upxhU/oeuuiReaFwXKGsEqbqOPnqCoR0b8/8P6eaabUEnY7Mut
	 PVQ9cjSUFp8IOPVJ+jAa85UizlmeDPkentLdzO1LH/yTVLomfYxg4cB1V8NmmQtFa4
	 yPeaNZoaCNd8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF7D460606;
	Mon,  5 Oct 2026 07:05:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D94AE1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB8D5400AF
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jr5YkAs3rMi7 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:03:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF9D4400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183839;
 b=K2l3iAZfmTF2FzhVlkT//uycTqfvo77ZACg6ZR+k9okWNJGgaet4+LMjfmjrb9XKQJYD
 +bQYabUJuI8R0ebEaQX4ttcwm/vLitp5kvVcZklwCNY5IZScMCsBwkI8toH2pdupSUNmu
 Axo0oTzeXgp+m9kSxXh6YIp/Xv0rYTm0aE7IdAJgziCku4izuycmK+p8j9BjNdtzlzCPN
 sDaYaMsHqa4WFOrn5/FR1ykcHbgyMrKjyRvE6SsBDZNqX/kDou3SUIEt+f3WxEIpgtgzz
 bO2wOvqhCPFxI9hkoL2o52NpCtRT/HjziZwYB6Nmb4nrdHYJxZ+20YmlO1109NuhlCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183839;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=hqdVmA5rDT+CDnzMCyB7IvShsT2Y7Q+2qS6s4YXRLVUWc38CtemlrQeJzdCFdmY+tP7/
 betb54JCraGY1okcO8lvYWAyfAie0GaBgFGm/SEvbExkczVCssEnm1zUp8fFi0Qb3qlIg
 Lc8pDiN/VZn5g/rvosKT41FsznUCmJb61cAS9uUBX/NKnt2Ksg4iTgME6KTZN0NOnoJn/
 JXrwcPOLtitFGiG8536fRjscOFnsP5R/Yatb+slkWuntw++NIBWz+HLQf+MloeIpfWPIy
 DBhbfvkG8eIIx7/rcefBfrOlo+wDApfTqefLJX6f8mfkWjjMpXii5zEzTSoLCTpvscA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hv+6gVs6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WlXxgccP; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hv+6gVs6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WlXxgccP
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF9D4400AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:03:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510XUV093934
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=; b=hv+6gVs6GtM8Vx4e
 m6SvUwMNY8Kqx30Mjjp5L9EZdcSG94mCPy1bdgv+1SzWeNhOXeIXmnJ8smWbl5BP
 ebKEuq1iMCtTo7hJFG3TsW3HVyz7aargHAM6K7nbJxccG2csIt74J6A8tnaYm6F6
 XIxt84kf6U5M1Zb7FLqhhTNCmZ9ecNZIlXX+c9Xn2pxqM3MLLXax5KPaxGl5LGw8
 YKryR/BIp9JxATB+plTR09G71bKs/sy04yjGL8IAlX6oikpO535l6yUGjAAwKlNv
 dsU5QeRt7eF0wfxSWeDGWDMBPSRNzPJyBMBCGuF3Hq9skGP3RSmemCFWqjQAtnMC
 dst0ZQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssu4t87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:03:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510a481ae9so2738398eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183836; x=1791788636;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=WlXxgccP5NguMWii1Eqami7A3qDahIZu7xHcqGCp1btaxwhRw1wENCc0cxzTcZoB/j
 aUZW+DG+x9gfz9BUuKCLe1jc7GygUFBYSWb+NFBMVuRlE4Ii4puQCqBfBbTOFug3Ujs5
 c1DWAI4h9DD8efDIozwoNsKbhKu4Stjgjt87C8Ss5xDfjM0BGhKv0+ObKP4j1m0Jv0Ds
 it3RPytzgVwomD1S14e2US1vcbiowZ37/QD3MDif9i3dEmEf8niHwQMv+gZxiVCZQozH
 RyYLCmfjczizMSy91pMb8swsg+egsBjhFX7fwHDqI8X2sh04spsff9bh7p4pVrjeLEFb
 gzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183836; x=1791788636;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIdQDYVf3Tzq/6tRTwqFEC1umVrkbu4wRbqLWXojJbc=;
 b=GZaUzlPKpcQjXgjhaA2R4O5vWHKVvWZj0suqRSlm1lDwz6SCncy3+E6BwzW3Fwk2F3
 GMrisyfINFNp2pMLAHlx1i3ywB9AgdXqblJNaiQY6tvMhQoFgbpLK72+fXpt0x+Rpkkb
 wN4nwQdYIb9gS17eANJMtrJZdljhDH3ZNyUAff1erI05kbYb70f/VknEqD8/f1qgFVRr
 HhFfqE/0v4r//SLJxZv2/lnq1SQzb1MZj7q6m468v4t8YTXIJtOf4lJjhMM0W4KAeed+
 zINqmJarHwHDANAipOanh2H2vWe8Qvh7hUNZ3pSx+FC7aIScT6QaDdqucVYNiExEQrAU
 LSHA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhqzLbvP7NZh0Cfv/h8YdC1qtq6VIwq7cLcLqbhYQfKIjfo9IWEaGIqGDKHkzVs/TV+P8u32Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mUXnYVESGBhsnHQ+cj1TyWPw6+y1M/qdD9BBiBudb9HRuTQ809
 dqpXfCMA2Ot6Hv7l1zJYKDO2CnKlEMs0lHR/zgVFBOQdv2SS8Iruy8UnocnSS4lWzVx8Xy7jfSa
 kMqy3hyhWasLVgzIOpCc0iboshUcKRWBItUW1XVuDhvAzlTLIIlADv+7Mv0Uai/yGPuODT6U=
X-Gm-Gg: AYBFou2SPe8X5GHRB3c7Uu06rK2i80Xm6j8sfdqMUz6lTTli6wOsS38Mud7kgADFr0I
 4gQmk1CfvapMC2eBv/BkM1WSKyAjvyIso1PIVrOPvweT5iGnbXGEiDPwt+jpjFz+rLyGE9bPhuQ
 H+sTJmztqZyLlXVMYd42GGJzZhbDKCCaEgwcAMkAbxJdCOgFnLpY1dMBUx2O1Ct5/J2ROmSXZnv
 hcroEl8QIf/h7l46GxQRYm9HJHxCaLZ8SaDWFn1QP3b8q/vQKTJump8tNtZsUaDmP25GqcgARuY
 NBx45jYFxyiLwuKFW0KbKJTvdi+VqJmB/iJ0VGd4Jy8ivb+V9/Gss9tUg2U8yfMZh95c891mkY3
 spMt+7KCxbetiiIZbu94mVLs02UkUknD1BBqmfdXYeG0RWMzZKTKdxf2TOcsZrLs8U0zMsVmC5J
 b2w024lBddokBChxbGHbWRAy2DP/GI
X-Received: by 2002:a05:7301:1441:b0:351:27bb:271f with SMTP id
 5a478bee46e88-35127bb27fbmr4092241eec.11.1791183835877; 
 Mon, 05 Oct 2026 00:03:55 -0700 (PDT)
X-Received: by 2002:a05:7301:1441:b0:351:27bb:271f with SMTP id
 5a478bee46e88-35127bb27fbmr4092194eec.11.1791183835274; 
 Mon, 05 Oct 2026 00:03:55 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:03:54 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:25 +0530
Subject: [PATCH RESEND v10 09/15] mach-snapdragon: Add Qclib handling support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261005-spl-v10-9-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXxapt3yeS7ebv
 jn5VxFV6SqeAedJferdhPMS/TDZE/1XlTRbjWqG6qQBZjZpEjDUVSfFmj+JjkycXewYtu0Y//C+
 KjI7fBaA4JRrvHhGERK3j865hRaNbNfJW7LGs+T+cxqEHcgJxckLauVTZMqKKUAWnOC30cQp9qJ
 PAUuHMYzT2dvooECO6bPWFaYCHutrVhhgoWY6gtwinW1Shp5ofOVJFMiq/SUOyLbS9rhWA6i6ZI
 +U61fz3QCzSG1r7Yz+coDpqtiin+guqPOpGYdtIaify3lGFSFh+HMf9fyhoCZhNSHi+oGXoF9+7
 U9rQvrUgjBVL+ZkpmKIP9DOlTVMH5IeFpPTLAkHwVmXMMILRJsefPZPhVqCl4xKeHiEUSQWACTX
 E/jnnij7hUF8UdRGSGLmejxZluAzp1HKJABxOrrlbf21f8w7Vg2o5U2SmoCS4NVK3d0Z8y//9T5
 tak+et2ehJ47HDoTbJA==
X-Proofpoint-ORIG-GUID: DMUftOSDiVMG8qJ4cRTy9eDqtvLWydRV
X-Proofpoint-GUID: DMUftOSDiVMG8qJ4cRTy9eDqtvLWydRV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfXyVGtmr3ObczD
 E1P6beV3+Lv5MrXEnN86dtk0F/zdti8dBXGinbATWPoH3d4qDvCeLRulvs580kxqTHTHsXOa6m3
 ZzjvRfE1KELpksfX/VVaORliID4gzLI=
X-Authority-Analysis: v=2.4 cv=XPSl2ghE c=1 sm=1 tr=0 ts=6ac34bdd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=HzPM5V0Xy-isX-7IJPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050027
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

