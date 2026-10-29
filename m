Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381FE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGDkqQiz;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hnfNu2sG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eq7oXAla
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04BD5606E1;
	Thu, 29 Oct 2026 11:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-WlRrCtmW44; Thu, 29 Oct 2026 11:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 048C56069F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793272667;
	b=D+WyR9MCvASORFS2eikJPJf9cb2ZjhH9PHNI+TM+CD5pv8bqmKxEZ5Y3g/7YQmsQQ/+S
	 ACA8VLTWqO5rNG6d6qHpPxgPZLQNA98shYcKe2NxOjN2h0TBb83I8eDOeuWEZjm1KIPGP
	 YvliYSRPBpY9sOf6kkAsM5qrXXdZXQWNamBhNzwKPM3b44eF5m3vsT5n9lzzULMK/Stbv
	 JOzgmNOrNg6HNc6o752M21FXuPIN7NSdpm6lY3MLF5kb99h5NcZhoBKUCnAr9lYMYUybZ
	 2XEYbixhcfGlOCzg7WIKZsZ1sTT1xCowJ0sW58Hd4e/MVhpmyLjy1ms5hQMr6lVxjjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793272667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns5egg6huQ=;
	b=nqgyzt/OWxAyEO01X6czsUJsYW8IFtThJq7JDqpWT44tyjSwlj72aIKhFncoJnJBgSPD
	 3S54xe++GMAcEFTQ9ZWxqUjKJBoXID5Z+HlM6N4E70fZqr1oVXd+rozsl7PfW/CxpHBAZ
	 hBxjsGnMNUvA/xq1TwpwDKNkarFGap1dyhdd7PfdilPUUg5zpMDHvc7A13EzcjsntCzOj
	 T9X1POtysCv4KxRg2YrYsU6n44D+ZVRJYrtnCqQzr70K0k9kej9OYNQfllRrBKwgntB0V
	 8nAI0tAVSZCnUQJNZCAKEu/q7u8xBTaOR27XAJPDG6Q/vWh29SaWjacg/xGai60ftfA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hnfNu2sG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eq7oXAla;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793272667;
	bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns5egg6huQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FGDkqQizjwStfyYojF82wfNpujxECWpKVPDgTnXPFxuaINwwGDcOBl3OUCIa+1qTy
	 L8YWaDMIjZKOuicROxSyTaAJ6L1hRsMsWH8r9P0sfzs2KQ9efBEh7aG/U00VIVsjRn
	 0njNx3mP1D3T+LFV9ekU7CpQXXNnpl7PoFqgtMpm8MEzFaTQNYHOgLsYhEvg8/SyHq
	 VjNQlip5JzrKtAoy8v3N1Qbab6KZ2s21llzNg69wcMZKi5k2HpYxfzrA23USUERhSN
	 2X3/p7Fq5TwbwhGB++TeZwEyE0L3nnSsQDNcrpk26l6CXtmoLoeMqzOiT7Gpza8d76
	 OtLxca6+dOrzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 048C56069F;
	Thu, 29 Oct 2026 11:17:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B267CE89
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 963756069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4X4OjoWDGLi for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C436660675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793272664;
 b=CRuZK7Qt8wYo6kjJmpVt2GQak9mzjVRhEPmndMIXsCrXsjBzuQ56tdB7MLGVPPm3QyZc
 Wff3z0LPCJ2jKnRCngezcHh06OIiafimSshzz7ybqBF197t1WNmqgBms7R5HxG/jXgUdN
 FVLsv9UxY+HH7tz3lLQufSXbofmTzR3+Rx05zBVURiKrXkeHLjXPfhTImTeb9YXAOMWsw
 F91JTjmZFooIrX/s2FwC6TBNJBCQaIhhxRGsQBtCqK9umfl4gg9ZGy30Sjk6cVOsduHyF
 qmhD95MfzmPNguxpvfoznHzzCID26gcrjyemVXPc7l7ZpYEcFdV8T3sd2yaxTWvEwAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793272664;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns5egg6huQ=;
 b=hKjdFPwG9Itm4lgn2xuyLqCV3Sil9CWpcc5lW7vQD4/VbpOH8z1AOZ12FH+aFqx5VaoQ
 2qnX2kXbBwTQKGw44sVROz72TVmRK36r2jm0W62bVr+4LsZZ+sstsPrP/4mivz2E/k4tL
 61bq79ZCRWqwZ6bDMSH/cdEOX9zb6fKHG6FhVqf94q9ZUCa+QiB0yaFN3YR4C8W9ZaGx0
 cxrnoq6+l+Br6vkDKvqrZTTRdGGLdhKDNWC5CdoS2IZoX6F1TL2A/s+TxYSEyfmt6eexw
 eMAd6nft11USlE1dak3myAro1l7YsSmYzxEugDm/auyCd/b1qidkiu9IYhpavy9mwjw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hnfNu2sG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eq7oXAla; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hnfNu2sG; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eq7oXAla
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C436660675
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8v9492273148
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns
 5egg6huQ=; b=hnfNu2sGh+N/+rMzGmegLaspPIe72qPoHj36JN+pAnTvicPXV6S
 3mCWHUr9mPbAXZOvqjTbEv9mFzX+I56CTHJSzzDMcUxRLfJNcLXoQW36eqRviHxE
 EAfJSX8P/29oMIg42AyYWvAog/uTGI5vnLbthkynSyu+IVb0CocfNvt4MJH8cnb4
 l0LaBAWIAIJteazvkJ+E3sdC9/4KjRUycogPPvk5YN1U3bhfEDUF07SaB42DE/nH
 nzOE/wkotapT+nPnEBQdCtrfde8hS8PLKO4smXWmCDDMK3PYy11WNkE4OJ+LrZr4
 2z9qvRGUPJgclXVZgrfo/Rkw7dMqA1wQCAQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b0htt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:44 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso3483195c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793272664; x=1793877464;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns5egg6huQ=;
 b=eq7oXAlaOh72nb6iatXVggBncio1rSlvagV1jddHa48VY55cAQYYAYZBVC3ScrumPS
 +u8kiYHXbRbCHzB1Knwnaqrr7yJQQfroIzlw2RdNJOLw7uYceWzgt0PPAK235y00b8Qj
 TRkBsFjgGcPz35Lp9cy1O4AVvfzJt4F1zP6EGr2PPOYHwvsjVBYeOTbX78e6qqhGSvwU
 mqYXMMA9X+UiOvAUfY5Ayl/qb08LSX/4sz3i0e3Bu6r50y6flPRAwqHxIr6wEhoq/xXi
 /Fh42VKqHk4KXKS+OAO84pYuaBzRM6iDS+rDf0QwSxO9BSnNyb09R8KaSlkkbZnfB2Ic
 xSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793272664; x=1793877464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ztT3qBUgwIJIzbL7XcufaK/IsJ85X9/Epns5egg6huQ=;
 b=bYKJaWNqsfzF+uUfi6gq9K/kzhYoHFphY8a0tiODPwLIZXd+tqh9GPmpM8TGVi49/4
 I6TjHo1keKCM506ggmNsLZ/N78owehn48X2mkBv2EdOifqKmMnxhJJa1HpgAqq/8abcy
 XBoA5ZZF2zUc8AYwL+1w087WLCntj5YN0uRPOk8Iql4cItd3o2fMgp8Vyty/nGMmsTVk
 UKkyYSUN71eicAzLe4AfwJ0rHIEP0ZrRr0W4KW4cJ47Dp+siKIiB6erQMWSm/OTRbl78
 MsPDIf8B/fNed0MGOf2piNBn7gqFizBkUbRlHs3djuPz+NKu8PMiRXcdNZVgMZXvVloI
 LcQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYBcN4kMR08EfIv3fNllpAQJHgoslj/aNXoCSzhGFmle4J+u30cLyj7uPNBc6XoOuvU+qExTU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIb78H2coZ/HT8Z4TC/+wIGFvSiBxhTTvU39kVRaxAOHeymQiES
 7kBOOkVSlsjXllO/8mrbk+Jh830aDIEIptsnsT0xGwHwSLCFQYlJXqfya+Swi+4uZ5jkLkZNp+D
 HTuOHVj7dj2gQScEgTQYsTNJmfCDii7XQOnWOiBolZNHosNTM4Y9dQVqHYJ72ymeJydXVPSE=
X-Gm-Gg: AYBFou1OOW12KVtI0nUzKIj0ID7n2OJTGbaMukyCbRzIJAB0su+c4V5qHlzpv+s0dzD
 FBoMecSGSSVVeSrXNcLNB4Ct3gGW4ntvigQd9bcGU3+H46ZohFkWhnLQQ7a6b8+Yk49dYJdMuW1
 /fZcOva+eHK2/WR1G511+Q/biki0+QG6tWQX3SUzonujZt10bdkAJywqIVmZ4JREhdWu2icJtPK
 KXVplIcFYY9YG0quxJw/uraJ3gHB9Z5yGqa5t8TPbu0XcpwSmZAF0i4gAgAjyWWaCQFsruS+mGj
 uY89nMvONxqoU80LggndpF8XWdHjGAuel4Wb6TlpSLl8fbYdrq3esQqVTtOEGL9r+XWqYXvKcSK
 WiWLcI5kDlkJYr2Aq6B3NGDUefY6DIfFV0R9SattVjPGkh7aaejiZCP1P2kuAn+wYNdanCmsM9i
 FunZTOyYn8ZacFpM+RqytL
X-Received: by 2002:a05:701b:2903:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-1a6ce9bba85mr5610791c88.26.1793272663243; 
 Thu, 29 Oct 2026 04:17:43 -0700 (PDT)
X-Received: by 2002:a05:701b:2903:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-1a6ce9bba85mr5610759c88.26.1793272662451; 
 Thu, 29 Oct 2026 04:17:42 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm19281449c88.2.2026.10.29.04.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:17:41 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 0/2] arm: qcom: shikra: add SPL SD-card boot support
Date: Thu, 29 Oct 2026 04:17:30 -0700
Message-Id: <20261029111732.3518237-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX/Wl8vqaAOW5o
 kOXq/WXKaJSJWGUVcOTm+oKt6X9JsE28i30iaOoypnETYnt178Bnooc2cTQ0XXTJw6gN73LblMp
 ju2ZvlOfyZ+E94hE88Gy+kWbJqZXjt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX8Q2NBmxY9J0Q
 Ye3YNXt+u8ux+2LMl8CuNeewTlh/Z11DiRVBQAhJuhgbAQKuIL0tin1++LE44O1OXJrN9DivH7z
 5JWpVbH0Ghe07YkjASMu0gyOB5C97B8yrO9juCnCfG91XexQZJXN6fIi2Y5Jej3G6RpIQVftUrT
 15BtFQfUqHxWSNTDBSe297nlJSh7+JMMf2mhHTYp9YnyRYiuEIEKWNO7EF4mGJAUQAgBj8gaB04
 Szs0c/VvYJh2foCL7E+1TjzedLxfunlFi4oAPbVME7RGqtcnAdO8HsLqZu459nqn0QXSzKQO+n4
 eFVHRWQy3RVHMgfhytcOLPBjU/rVYQUz1JrU0Cu8VRjwhNiU/1+Gwzh+k2kt7ltyi5cm6gsm69x
 y/t1XAoR+bHRFseKvNpmXEPlLEKSwS3ve4T07nWsbgxeYyL0y3cdqaVTO0gwpmkMCL1JFFuffm5
 NF3TazwhtI2OoiuelXQ==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae32b58 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Eb_wI7Y4CCbTFMIFobYA:9 a=zgiPjhLxNE0A:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: Bl3mCId38x2IfBAzDbutWa4dKjrqdWcc
X-Proofpoint-ORIG-GUID: Bl3mCId38x2IfBAzDbutWa4dKjrqdWcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290043
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

Enable booting the Shikra IQS EVK from a removable SD card in SPL.

Add the required SDHC2 device-tree support and select the eMMC or SD
boot device. Update clock handling so only the PLLs required by the 
selected clock source are enabled during early boot.

Depends on:
 - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/

Changes in v3:
 - Moved support from cqs to iqs DT

Changes in v2:
 - Rebased on top of the updated Shikra SPL series.
 - Dropped the standalone MMC boot-source patch, now included in the base series.


Abhilash V (2):
  clk: qcom: shikra: gate PLLs by clock source
  arm: dts: shikra: enable IQS SPL SD boot

 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-iqs-evk.dts         |  3 ++-
 drivers/clk/qcom/clock-shikra.c         |  3 ++-
 drivers/gpio/msm_gpio.c                 |  3 +--
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1

