Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC94CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9C8860743;
	Mon, 12 Oct 2026 05:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEQjK8nrGi5z; Mon, 12 Oct 2026 05:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D4C176072D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783335;
	b=F1tZkwTfQDkq1VejMGZAoo71jar6VnytNVixImX3cDAueJRSdiZ+QOiIFuL+ROfdz59f
	 erV1m3M28SmKdHyJGH6z0VEeBN8pb6md+GpeWQ+wNqdMzU4FOViFLQj4Pq9OkixpJvcKy
	 U/hueLe0Yi4IQ66OTfW+wYlkrW+Nc6fUph2naZviukedylLl51FbEPq8xRDrwbxVUbq/4
	 I1YPkyi50KlxX60u2dXGQoYamKtfCGQbHTOAkeZEaryucNW/MdasYOkA+lGiK2cmwLS1b
	 ABiYfBgI+F0+T5c62fUlkXdYy3f/IsPHHJ3DKKj/Iw/MdJP6LBQHfLg+8P8ULmdXECA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	b=eHtVdphsltPlqfF4dqVk4MSp4nkOzRgmp+d9ZACRZZSFHisuUKOU7ed1TfhYJvO+3jU1
	 uFxQEDIP3YKpb5oN3CbDcLw7zXhOccDyhV+ztVCPAjTQHUKbktXRKYcjvVwpaufQqWYM8
	 knnV2EgMmVNt2al8Nn7ctgvIpqsglrTjCkesYQ41v1w+Xp83iwGjVNPphm62+9FTBLVJu
	 qxghPy2/6TFFemQEcmpgIomnPqLSxJDi5wyS+lgQIlF0svaDgosT4JUaBqi72LFtifLyn
	 W85rDWxp5QkTUzpuPE50aT2RGFCOT6eaAVaathRWiiILTtWx+bP1M688Jw5mkMsjWRw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783335;
	bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AEVqetorP0b/M+9WiuOieOkzDdRdPpjxAApvqAq5TUQC1jIH2dAQx2eNPI8e8N0RA
	 WH0DOlUhV7oUdB8HPFimAgFvoxE55QpDnL6PwqjsO7aqBGaNUrz83jThFb11l/BOKh
	 xyhU1n/DHNPSQ34cTGl1afM6lEKbUFgsR1VJOxEsiorY4O26SzpXML0HFWNuf1cPNf
	 yOxTT3S3jLEz30v0ZZN7bJcr/4SKdLuj31HSL72rB0wdF6XdTv4cfD97zIGSGXpOvi
	 k6S28k5aMEISW3CruNfvv10AxTcqm+j+Oa2XSl55NlIdyg6lbMEZUQaM166h55nprk
	 y38nuwO0SDnZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4C176072D;
	Mon, 12 Oct 2026 05:35:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9100A1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8192980D15
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eT602KW_W7A3 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C562980D09
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783313;
 b=mofy2DbhwVBsYkzDg7xDGBKQ+tLl8FVSLLToyeJw/Jgrs+gUnfQcAhQ7uytuDVfiXfoj
 UaNEWLJ/IEkwR42tOZTFhdftbzm4xZIsv+UBVswTAR0aMAV4xx+PnBolGIjJ41PlOch+K
 1Z8dQbZ/J/9Pbb/ruTn9y6NCqOXvs47ItvolJTiSUYwMesJdTRCZ8eAX2Y68T6h74Z3ed
 8Dy4UrHsJdrpE17hGxbRbCZ7IEOQ8hHTiBER6RrLyDqZuWb5tIAk9GFIKz6/2vBUuePbY
 eCrq5OFW7pSqlEjIQ1MFE9FrbMZ/tfJoX5Ny0c4Kkvn1VaD+GRoqRuCPPao1/JxFgzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783313;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=kPr8zQMf3Ey20i3nHtjjLfRRWEJZ5gso3W5k3gs/NUHm3YF3mE0g55ObzPhF1EMYsVoK
 NprwbB1V/2booXG2I7ctEzOO+ZJiKx9UbGvtaesIqUTldvGePh5xl5+PvGriXmv2eJFzz
 QNoXfg6mZGYgpPYzG2Ln4Q5oKlifcMQ1u9RJx0uuzCppF01czWJLm7B8g8jm4xR2v5b27
 C9Hcb4aKnecI6ERK+KueAsTX7r0XUII44JLDm70x7jobXVsbCpIKRM/y9MG4tXY7BT0Q2
 2Azlbgmyq8ArHTs/WkC4HCfdIOQN98u1DeSyUYCn3rkvQYJOgzKO5rquLuzfX8XcsYA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UVVIu1nW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IkZhbvdw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UVVIu1nW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=IkZhbvdw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C562980D09
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:12 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55r0t303044
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+0lxLpCVJYJ
 Jhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=; b=UVVIu1nWq5n9OgQ+1+W7Wvtxt0Z
 S80c39p1sbtUHYVSI7mBwEF4PCpF19OPoFSmoT4HkTS4C+eJEn1dVq54cWgIT5MB
 aXD/8+WVLyiZIA8eQW1cFSPY74anOPOvsr5PJ9abT7nFqdi99F9yproiw2Bz440v
 yu1fls7RshaQ4NHAaqzNOndF/zDMnajq9D4sjTfWFe2VpvvOmaGR5TjnxpPrfXnz
 AMWF+3gUnXBzgAlVVWTGmC4dEvWSIgKl1v2vHa/r5olvl7XYblnurFlo9IXcGT1t
 qK3bmxDgLLgaeuC7GTMZkka06lkfjerFh2u2DCRnn4BFu3vTIbuyEEVp9Pw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dh2wm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a04491c56so758069eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783310; x=1792388110;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=IkZhbvdwcWVQtDG/kAM03fDqdsGdZyvho9C3IjWgv0afxRLd4ApdsBNA43Jv2ArzO/
 NHYGJTMr/QuMoZhddVHKDxF80ccYCqzOvPWfB3GqW48g/VuG9YY5QgC/IvEZG/3FOQ8J
 5d7GdcfDiRKSd3InqxPpuCH4ZhWZribQxux7jBXLU+RxnViyI+egadvJo/W2WYDICbA8
 ieWPbK9dXhooAXffNdHxAQS7bJXlz2GSjTI+3pj1kapAeJD0ntKi6LGVYP57FzFYLfZj
 yH+/09yJF2f+nBznH/V3iQdtbHTcSeBYPPFFgtlVhv0R/JxfuMFSxRd3WCMC2MobzAyv
 CHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783310; x=1792388110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0lxLpCVJYJJhi0tn/ZKaHgAExPnkRUaPKR68E7J6GY=;
 b=P0HSvkLexH3wJ9gS0jS/F6E+3iNwQEpKZQpF/gyUYs0QpWNI1SxOoxMsbpOaoYM/Xe
 TdS6isJwz/fY/YCnbPHYjokscgiQmy7z52YC2GA7OFHp+ejPAKoFHU3bR9J+W4T6UMed
 uQ7n2uPa0sMSaTDyAW8rks/kfL246q0iC+KkTuy+9udZ+vhUuhNvB8Oq1ajdSJZXqO5y
 Okc96V8K+/GXfQqGsZSA6lxBAXVFv2OkQiICKGpcwQk2fpnM/7ugoqrnnVPJC2fddoXp
 CeAN3OL7Pdcf+fMFXQHp74Yh32yPVnnanhe03QnQQNT98sauTr4MPLZuP3pOnrmto4+z
 uQuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1vRO3vAIjbEpk/S2PGrYH4p4ZGw7w2OE+zmiGi56XLcrH326xqFJklW/9dqTEQfUMUP2PpmM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJrgFwx+K02FkF+WWrYWGeolET6gqIlZ45wSOX1ygr68JjlqIc6
 TzuuKN627/KNzyUkDT8zg2skdOZ2N5xsrOX+CN/fRMo1re2+ktXqYWLexbOZummUeHEbgBOH/mE
 Q3o0aRbAHYD/gn0jCMYCZ93dh4XSxto7B0GpuZEIbUm/plCu4tT8A1xxRSY3TUDoeM/T41VU=
X-Gm-Gg: AYBFou2dutEgWpoMRB49eZ0XlaKvKsPiXSsD2dXdZrBJoSrYG+hWj59SeMIcqT6sI5L
 E2mprXY7JimjUnxytBJkVdPPn4WUQV3agAWRj5FjVkyTnDl/mP+E9MiDPr0XfWoT0TYmdjh+zR5
 7TkS+IJ3UHTsKI3PeR82RUF4BB30mkfBVpyJaGDafhSc4l6Rx2M//LDAMAakkT/4PzzIj6ioYhz
 kgtpOw0y4GcB2Y6Hiv8Pz33h5VPf7W0QQyRmTvHIW+2yiGYGfF5AIzOxLfcsAHFRa082qCqnuc8
 XBDKflDUhBA61X6hgt5Z6fH2Vyp12TWNlYlENKOcAOqH16JgcbeKwB2y7eSkLMKnlfrdzC0aBxC
 vGK4MOF08Xn1ZzxIg6sIj+PFPQrZRNnF/Jt6x1J0upinQMVos
X-Received: by 2002:a05:693c:820e:b0:351:6665:c611 with SMTP id
 5a478bee46e88-3536c5350d3mr13149613eec.12.1791783310193; 
 Sun, 11 Oct 2026 22:35:10 -0700 (PDT)
X-Received: by 2002:a05:693c:820e:b0:351:6665:c611 with SMTP id
 5a478bee46e88-3536c5350d3mr13149519eec.12.1791783308705; 
 Sun, 11 Oct 2026 22:35:08 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:08 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 12/13] arm: dts: shikra: retain SPL dependencies in IQS
 overlay
Date: Sun, 11 Oct 2026 22:34:51 -0700
Message-Id: <20261012053452.1567885-13-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX/UR2lDgQklZ4
 nfFKyrJaSkcjD095MWkC483RL5UpHHWRdWenlRibNrYEBYdz7OTBcuM+bD594sVebntJxX+mhh1
 BJBzEF9+fTkQaxH4CZhAREU3pHP4ZCQ11QRhJ+P1aJyoSqUrf7Dsit+3Jd8ZSNxkfC3q0j5pPBZ
 t5W9BPDGAQUOIuQYfKuo/lrte1QHMceVnL9psEhbouxH/w2Zasgjaj9e7x3C85U7t1y9NFr0gOx
 8eWlBgIivMFovYFOtjkNo38pvBj8mWHOOrqj5Sc8DnoR/syvgv3rf/aCkSg05Wm3cF3kUzuDO3y
 /TzXgOXthWHX3CnQUJWNinXLJeFMXOAaf43lXBFqG0uY9CEwiBRcn8LvwIA941Ot/MmogiM5bfN
 0gRlOS3hiW1n9oLgRjGktpllm5zK0cw4hpRcICZopr2AUeMNwJ/FieCbN5HbEteXGouDUhskJyT
 bpCt16bsXPTQlzCtYBA==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acc718f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=qkSexMeQyOevtdx1QFIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: LkIAh968DpXfTCNUxSt-UVxBiLrvGpyX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfXy4Oygmjs64Hx
 4BGX9iiLJHQV9EBh6PLASp4n2IYWxNHpfaBIJfxahitfhZJb5AWDW8PCijudZD29pGpXcGkC190
 d0jjmQeh0bFvwm8uuhnHczoDhPLhhU8=
X-Proofpoint-ORIG-GUID: LkIAh968DpXfTCNUxSt-UVxBiLrvGpyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120022
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

U-Boot proper uses the IQS device tree on Shikra. Retain the SPL console,
QUP firmware storage, MMC, clock, pinctrl, and power dependencies in the
same overlay.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index e807b91ef1f..a1e506f7dff 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -20,3 +20,45 @@
 &usb_qmpphy {
 	status = "okay";
 };
+
+/* Keep the console and QUPFW storage paths in the SPL device tree. */
+&gcc {
+	bootph-all;
+};
+
+&tlmm {
+	bootph-all;
+};
+
+&qup_uart0_default {
+	bootph-all;
+};
+
+&sdc1_state_on {
+	bootph-all;
+};
+
+&sdc1_state_off {
+	bootph-all;
+};
+
+&sdhc_1 {
+	bootph-all;
+};
+
+&qupv3_0 {
+	bootph-all;
+};
+
+&uart0 {
+	bootph-all;
+};
+
+/* Retain the RPM clock and power-domain providers for boot consumers. */
+&rpmcc {
+	bootph-all;
+};
+
+&rpmpd {
+	bootph-all;
+};
-- 
2.34.1

