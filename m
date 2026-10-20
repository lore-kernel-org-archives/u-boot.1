Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F091606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qWF1bHJg;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MN/qTUiq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NTkXUN8a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D32046081B;
	Tue, 20 Oct 2026 02:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRxBKuSrz-Xn; Tue, 20 Oct 2026 02:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14DE360837
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792463878;
	b=FDLQ7sTNnBm0CC5WXTQGJoKWCU7zGG1oUI20W5kxbyGciLKXaCfGuv51wFB7U96LfHia
	 VpGDMMZbhhB94XVUx6PfFZgB50xik+dJSuETdT1ZZ/5MLknXyxl2rblfjnRjv7krUFliS
	 rn+HBbAtT4MhPWIAEUSCma4wJkLStsB3pRMvSW+vLP396Md9oAlKavJdTv9vxw/TIrpgZ
	 g0Jr9SahKDD2WOZ5PrvmXBvpQZBaW2RNPY2n8xDCQsYE7Kk5q7oKNfzaJNpanY+p0v04n
	 hkpHtPrgKuulMC9Yk25dPCaIBsJQPtmeU7xzuvzLzALHX47zHUCC5voU5eHFL7Zxe1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792463878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=;
	b=REiseezKpOPvJ6ZDI4lEeR6ELubDatPJKXg+IGmqvvRAlDCgJif7KPR4olN2m4Pu81hi
	 BYEMI7Jxrx9oFMX5s5fhTmc6LFfmi/Rx4KypNdmF6OMcn8T1YZgMpHt/hYvblMsoPhH9e
	 1UHZbSinSS3VScipOdZRd/jd8flI/KWqekcgLX/ZDNsOMykJreB/4FaU1wTuysXL78y0o
	 8RUV+lcjInNQKgzgMkpW+ZhUzSxHZIVNRz+n+PcKvq18dVxr6ixmDxJI3XwMNZL9ufuMf
	 0gSoeVTqgWkEY6GfAIYCtHyj6y01k0CaTtQtiktxEmYD3sG7BSggSSqTl0M/KH0dcPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792463878;
	bh=GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWF1bHJgNUk23RB/a0Yxud4IzNxuil2z+dWen0XMZBNTDNIgjx0ltI/jTgodk7TG0
	 2TCwfzkKhxGSHjJFrZD6CAQm2Beoise5oIEr6HrdGtpSXsUc0V8CQo4WZrdTL0QNIr
	 7dQCitpLLPcCnRBeJfjgI19O4QX4uBx66TBbUg6j6gKt0XilEUH0tpy0qLM6X+XLVi
	 7tjsUcWmiJ4thDfLBg9oZgpvEa+pvQ4g6UT42DoL7vX/oK8sYeY4El7R9o8B9b+B+Z
	 NgeNIxFM73PqxUg91O9Od8VTrLJlKNuDaXkvXJwfOHMu61whptC0t5D1YD918C93zA
	 iXHijDJjXN91w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14DE360837;
	Tue, 20 Oct 2026 02:37:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B0C4F465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2BE4810AE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmYkvMSv-I8y for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1518B809C1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792463876;
 b=KXWRjUQJqYUBRVPduh3TosY+07NPBGmq4Gi8fHuC8JNukXrxrXDSDJErYl/fcd34qZhT
 QSXM25S/vy+cn7wAYISAMjYTjpLYd/MjCle0ZJI0QKYQZNWrsEytho8M0Hz6nH2IvRQjA
 3CZNrw4+BRB7kqNgPXuA3kyG0BY8HjxYtxmgVa5hiu8v6kmCxHmo6KJE8z/PhJDjxPKjh
 1usJcQ2VWBaPUjIoqkQvVO0uzeqlGTVT5hZm7T14Vfr/2jLjsVm2sA+y9SWKzoAcJjE7d
 1dNprrRT6uKA0fov3Ac9rIoOjFMr1DCyJrKDmTIhRWj2krSWKZ6utku5oOHulqFH9lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792463876;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=;
 b=ViTqs3rHVcVzWBOqRGcM9WjWqK172pp3Mr8MFPl98NYaCjLhoVA6P2SMgYlcmWhfQ6eR
 PQp3mDK7K+xrbEnw0p9/UBF6BW/ZAqnynKOgkTFqrmwrZb6e4e35MbVblyCYUBoYKqLud
 5RL+Sheq9GRlJLKGIcxCc/qTJ8is7qaxnUIK3iIILLJQrUpJKqGZNaL5dE9kzS78ninA6
 ul3woTHcVz0iY8xWnHnb10akHyWyXQSWkdxr35WRVTYEoHR5/6RxOk0b8zNEYsBcuWjAd
 rPLyUtwOjxbKH5mn+5Q2r/jEntfmWHy1gUnTim7iK4mXlWqroIXllmZSpkBmaez5A2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="MN/qTUiq"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NTkXUN8a; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MN/qTUiq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NTkXUN8a
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1518B809C1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tNSK3807209
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=; b=MN/qTUiqwnDLGobT
 roWH0+ttgYtZ3xJjO/aZDPi77ySaGWLgkx35LRXa+nm+MvQkt1hoPc8rnX9fkzwE
 qZXOgx0sUHYRurzfTL97/IQ1pij7EBte/UGI5Dn27eq7rBIMMieCXvcrKkyixH2G
 Ht9JKGx9wjM4A5orBKNSxc/K0BdYNFzyXjC6FlN74KJ8ysVBW6jhB3siYKLAPUvx
 SIFhydxxXzzEwG1tCELXlcfjvP4SM4KD2AhiXQgppdXi1SY0/uz50TYkV4WWIQTW
 thkkovygl1l6zZ2WN/yAWPurT2tnPcPUCqpyjTGmHec8aulQzot941xd9lRhhT3I
 I//1pA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p8gc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:37:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso5357303c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792463875; x=1793068675;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=;
 b=NTkXUN8aI+O1Bgwcs2bGPE/ccohx009H9W6j/uty+uSqsRVvAsWmixu0vwfqoa9jDa
 S89vRF4bsJEd7qIbjDGa18lEJkUsRrIGw0Le8Xgs9ssjYesOeT8amhySGb3XKJriLRxw
 VwZN6CXPnN5XBTVPWsU18m8Mu6KauPdcDUM+orq9hBj9QZrWJYRbJwxD5ADrU5gSbKS4
 iGuxFhavzPSqCAKesmT+fE8TUcV5QnSmsR5+M13zl4P0e+J+HFJVDxYvYjNL7FkJBHFQ
 KKRZlN2Ar0Qy3OLjkKz0lBOXWZOgxzQmhn61/PP7+d+smp6NPbKGeXtLH+thQ4DpUUaJ
 503A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792463875; x=1793068675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GpvMCOn9PlIhpbrK6O6eTaJqyd4oyvnQwfuYPaGiWfU=;
 b=gNJCdbQdbuTfNbJPKY1dPSDZfkcAcSoSTXLMa5u4JvQq5mBhRVWBQllYKiHsYV35Jb
 z5+uluMgDz2+sCZSuEgp0HY1FoyeqditiEF4nWd+sEcSalkgIEn7UDC4TDGWzSpd9Fh8
 t5yeu70jQfJhLvOIKzq5jLwgTcZYEeiB1OZ/qHNoAAvSkpegZSggir3rYQmkGQ/6TVEn
 Xvm2h2XlR3ehoaVMPXLG6M9jmC8phgZvi6egDa/Y6z3RQuV+fjz5bKa4j3UMIkBmOUVN
 4kJjWIdu5vM8OWN8EFSXn9v05BKwveb1CyS1l6A+N44m7uMQppTjpRpQx9DwBCEFiYHG
 UTtg==
X-Forwarded-Encrypted: i=1;
 AKwUvByge8qDL02vW+7tQPXF6EcRP5o4CXinii090Kb6+7Gf+YCmseMeYE0UkFXEyOmeLPBZ9NnZCzk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLuxDsESqyaAvvcvJoCSLgOBkeJboE6U+G7XGHWgDw1Jja0DqvZ
 XWBqO+0YNTY4S7XxWu+npXBjM49Ut4DfwEY6q5pXY1reJlSjRkFNXS3bb6vJhUrhhfRt53hCvsU
 fiW6eNKbLbaU95lsGV2tM7il6m7H6vWPAt8w4vuYyoxY69qFrjrOx2S4y1lm9WDrGdZAg+rE=
X-Gm-Gg: AYBFou0o2VIehWvObbl9iGD1ezJCDaNaHGCP1UnJocgPeYEv/IRPcnPYLeI6IKkSe2O
 +JJ9bRz4bjZ/eWYW9Ipx5y1G3P+RLq1XOnuhNiWWUjONdyhpH+pXprWaN9REehpZmE/kilHOB2b
 luDAS2LfZRwGAp4Ng1IbhUwuTijUVAA8ZtIBn+qFcCTGCWRjLwnobIoKy6MQW5TGh/PLiIzFhsL
 9Y2OKaz6vz9VNufbYIeRCr3cdPiiGxVREV/cQo5bW+p6LDiQYwRfHW/1igbGLARmbqgdqUlKJMR
 lj1+UHY8X17YcH5p97g8Uy54xMyCTUYgPzwtSk5XOp5amimzobrcjNE0rfgrbzAoP6vceyOm2cr
 XQ4lrcRLkfTXrvgiRJF0wJXkJ24aMl7J6gYtrV0RR8bSRecm+kxtvLx+X4Ku9/xuMUWaxoT+pTO
 m4u8OBGnFXC6RnmbC6oCQIgewvq9Lw
X-Received: by 2002:a05:701b:4502:10b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-185118edabamr13780605c88.13.1792463874600; 
 Mon, 19 Oct 2026 19:37:54 -0700 (PDT)
X-Received: by 2002:a05:701b:4502:10b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-185118edabamr13780582c88.13.1792463874030; 
 Mon, 19 Oct 2026 19:37:54 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082b8573dsm36349143eec.25.2026.10.19.19.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:37:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:07:39 +0530
Subject: [PATCH 3/3] configs: qcom_qcs8300: Enable Gunyah exit support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-gunyah-exit-boards-v1-3-39ec03d9e365@oss.qualcomm.com>
References: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
In-Reply-To: <20261020-gunyah-exit-boards-v1-0-39ec03d9e365@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792463859; l=711;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=jDAhIphU2NPo8pql2lA7lrYuwE3SEfaa+uaICr76JAA=;
 b=uagvuq8xEfPT4+gW1QBCB73MjwT0gdv6oWlPVgkD1W+i6biRXbb401a0ihgAfw5DmJWdTsr5U
 SHiTaPOESx9AIolsvOUNUomz3p+Ee0h7XD6agd179Q9Tq9kBX/QnptS
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: We08ipOJLBlZ1vfYUbcK5ftRgxoyVhuw
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad6d403 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=lOekWYY6OBiJGqNtzfwA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX21l4+GvuclD3
 1IWc0ka+vQOfSN/rSUkXHWiXjJp27zXGnY5v54mC3mndVaoutPJ+x6BMHTlLBAdRf5JRm4obduu
 f072V5/o4U7TlTx3Dr2oizCiIjAJaLnLCkMpPbKidovXeCOmEYPD3JKMEk9Lt1606YNho+zl48y
 pVB/ib+sd9Cgm8qa585auRnlf6V2W7BvAd4nvUtbZjqThhlGmalHe8rfbBaEIdQhaCQr2WabEaG
 Z2ItAWLqa+maxw8o529nTJpl/yKPHRLA92cvOz1g7EoA/YE+zyk6ZLOrzKWonPRyiNSfCiTjdU2
 nK7NmDeyf57HZDTVQLeYuN4VIY/lafqklja33HzklGMxDHC/mwPesV97uBslsUohyzwMiz+8GvZ
 X3fcNKHrRC3rkQgiZ7gH8pESw5Hz/tTm0HL8BwXoBtXhfTysvkP5V93xEHhNZ+Vml+zkFmo6Qfp
 arp2rA8eakerFuT4CUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAxMCBTYWx0ZWRfX+xrIigj/+15G
 Z3BsNRK3Gy7n9JxN2mfmr8Tp/GEsjEWMG7aj4UlY2n9L/PrknpCSKAIyeh3Ct6OYUvjCxxH35HR
 7bzN7nhdn8aHUm7U3io7EblG0W4yUsA=
X-Proofpoint-ORIG-GUID: We08ipOJLBlZ1vfYUbcK5ftRgxoyVhuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200010
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

Include exit-gunyah.config fragment to enable early hypervisor exit
on qcom_qcs8300 platform, allowing U-Boot to run at EL2.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs8300_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 8ff790f2889..5ab396faf29 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -4,6 +4,7 @@
 # a dedicated "uefi_a" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
+#include "board/qualcomm/exit-gunyah.config"
 
 # Otherwise buildman thinks this isn't an ARM platform
 CONFIG_ARM=y

-- 
2.34.1

