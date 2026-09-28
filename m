Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB56BCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62FD180E0A;
	Mon, 28 Sep 2026 18:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JTfqz-yKLprr; Mon, 28 Sep 2026 18:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D3FA680E07
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790618828;
	b=FGnkHaJQDmiRJe80xlXilmhgbeLCEm4RJGzHmjETrlCr/Znefat2FrI2fB+6dot76h8T
	 N9k4SQRiT4Q2wIAQp65I6LBaYGUz/7rt+tfeXoZsENsysu5RhlbKal9cF1GBVhsxqmn4s
	 vPr2w/UocsVSlgBHQpoFdjCpDADMI2m0k1Bp7nHNwfRE8RHQhBJeobUL/4ivTxYrUgvMM
	 Lk3TPGYHtIE4EeRawuuY4QKOxIsXV+r2pi8f2rJP7TPybMrwoLpSgDDIwfFuLj9Eqm95d
	 clIOcPlvyGh14itN3rtuXoEPwHBoIjfh3GeBHOv3+O2n4TDxYJHBz/HKUGetS6oYfYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790618828;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=;
	b=aAel8Zfrhbo5wQDmv30EzoVA+wY2zcW9hmH5DILokuxzBesXBuzbVutqkX0sxyQlRYMQ
	 ptQYO+12slY6MQtCVzrom8BZWUaDPIRdR4mYwbvLav0OnM9YT6tnfpIdbJUITVrP7cWhw
	 j0IPB/kWPIUuvXALoRhVJmKtX0kunVa/oKL/rIKcUvR+69Adx8f5mu4r/VRN/FkNy171b
	 jWbylM5jp41AiUZNu8upAJMp+GDhiPeGOxMRq9BknxyA7FQtwH+k0Fqkk7qiqDJzMtorl
	 qQBa3e/189TjQ6nZFYOCuFEZ8hK7edU/Gaip60AW4zpI/VssU6uN4kRwpwPAKMtMQjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790618828;
	bh=IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAKFly8B3UoIIsPLIn5rlZXCD7D1CPlrgV0tfziMDsMttfNWLJfGzfRyenZrY02g4
	 95pYPGHsMULI1cFdWXBZb8GTzQj4z4dVsMVpI+uToBwXrWhn1apuY7CCpuWY8OjGOn
	 vYVa/9fLtnuH5aLGNHa0S3ERmjJT4DDSXnqzyTbwzRZB5jHcFUWGlSaSavnJUnNo8O
	 Tz1Ab/Hr8CqnspgtXmOoldFNznMlghdofb82E86BweyR9hRFntgEWZmjHHnLhrN2tk
	 WmqXcqH6mfkmFjXQRfNY53JaDl20w1ybMyAizMUrj58tcLlaJUceX+IvYVVtTNDLki
	 7be6mcECYaC0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3FA680E07;
	Mon, 28 Sep 2026 18:07:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC42572
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE1BF606EA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GA4_f-SPceOn for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B31CD60614
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790618821;
 b=TWl2grgVeHjfBe5ICkiC+Ozi8qsWJRcfloc7QelCaoweNI3IizffqSZHq39IC6pBwPrB
 W3lAWc9yOgzzIVWgh0fVb3wN+7yMQ/HwcNdz90IXfGqzSicGULqds0UcanK9ynhJtDOm1
 INi/x6byI9guCfFLOgqQIJm0y8CKnEEAGjLZJDyX1J6l8iYXwQFw1VRwEQEqTB5DSDPpp
 5SwXghHGEdZv07VK778xcaKFccajThKLvZi7H94MeeZnvH7ogkZgW3C2UYQYoq0no0YvS
 Ccf8xhEgBFQ5QpXI0JrNntz0kLo+VKHxUagS7hYTfzmmSbBEzs+gvpohuwW5nt8AR8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790618821;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=;
 b=WDvIuqhDKD9lwz/j8FeLMuaHNAbAiW2fQQqT7DWbBFd4hu7Wi4R/NgS0X4HTPTlNzeX9
 jK07ktqcFGgMjzempHcQh0bjbGCzOgbf6kjdDSvzIxfTYgtxDKaVQv5+AChhBq3WGPZ6X
 fInWcL65VCfkitoqaq2rCZE8sWGlYe2H7q+hdyFfTupERbnPggBDepkeopsAWdqx9uqwW
 B6HcBcPVd01tyH1qFzXrLOkyFz4qpXUGyDQ0M1tVqv+ZFFfwrbrxOmVBUpqOaZkWYtO9L
 w84xvddB5c1UgWEQm+7kNXFZPwJ5Vg+Y4cqlkES2UFdg8LeJw1AsXKt1rqKSA36z1Ww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=puU96IKl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FrG37SgW; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=puU96IKl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FrG37SgW
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B31CD60614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHw91v2348442
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=; b=puU96IKlCCTrzrNc
 Qv+/Zk19kkZwrGArRsecxl6ysRT6rV0dsmCOkdij+vmJkOTqKnAsCAxSzd6d8dlZ
 dDLQkw7YJpvHntdy0Pz8AyOOHyAl8gxtZvvxs5MIV5VJz522DKMDKKcI/zQCsoe3
 4tSprmpr1hBW4Ekuoe0y6KygdGhvnznBdfivDvqo4yf4/ypAeG1PSQMoWBw9mSKz
 C7EYS3KJ7c82JvPRnTCLSI0y32YSSQmohlvQ7Nvhf3vqyqJXOqWRYuU1sMuWBYcG
 UrtAehRVC/OBsFBYvyY9mYcFE7U/FizSr3M98qLTgJ1MudvvZ0IcE6B0V5XQ+kNq
 /WmVyA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxjvs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:57 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-892be308686so43349887b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790618817; x=1791223617;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=;
 b=FrG37SgWHhnMj3Aa+zg0PRH8/muWQGh+Oo9TIOmQEffb7RXXZmkmdIfbleUNOk/BmI
 MvQ3T5iAAFXSffHHwT042Dn/qLPLjiaHx209hO1HlWidRqtI3KIuQ7h6su54wa+bzS6g
 U52W7EcxAIT9xOJA26NEei/VvsaDNC2T/XhcmKDIC1ly4/vu9fAJZSmi2jxTzZXtaABz
 uLd7XJXOS1aBg3IH0CZOlVlqNlgx7Mv90eIFMZxvXWQL1iX76xCdCR3wvPUezSkoNB0R
 qDwROKPTFdDZM4fjtGltYi+xkstxsBaN3n0IDXm4FgiCCdae14pNxflbjeZvMVk7fuQd
 RqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618817; x=1791223617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVCcNPavmty5V8C8MRgIPlif4soGR0ysp53Rh6tOx6k=;
 b=ffk63uHLdNe3K4UToypKX/ZA+6HRFdKFbicy9gME3m0w0vHFX/eHxguYTRMDpmXjjj
 vgMKpWUuCOff56AMn6S7BPbtCszE3PSaXD3zHeHikyhMJDERY/2EG6wLipPzyyx2vn78
 /9RRVslL15V+wqCRGSzt7wYvQBwADXuXYUYZYUyK2dapMipblaz+xi04DwgbosDcLiNQ
 0zJxoE7S+rGJur9Wu/5pu2G7fZdLUUjBEipslQjG8PaGJv8y9wPTOm3XlalyZSgM/KMn
 pk/ErMfYI2t6jdwU/gGwHCc8w8IB7PCppw6S9q6JDIpF/BOwmXA92ahzYyqDvyRtM26p
 olNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcbkmJ2ZOQsD0Li7BAVEBrXYAg8/CxM4FpdGH4s7Cjkn3fPNc9gdgNxgpJGPALobytcJW2EEI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJdOvaPSunl372WW1ToNYpRJKtnMyl1mQ6n4EtKDWFcau9Hagc9
 9HLmJLvLW4Gifi7Sh46pM5QiSm9KUEn1RuNyj4UWO2nenbE1g7qbA6RcpoFT1ljWewCeSlNGa56
 GKhskviUxHf8ymcXb9ESXZuSw3wFzOFAlNlRF9RwhYiKdmRaX+7TzB2krxLRP7wbnMukfwFUcbd
 o75EI=
X-Gm-Gg: AYBFou0a6hHE38xnt5PNVhXULbTKRr6ZUXZa5dKzqVyfwtCkYYM/uK+pn/RxG9BN8I4
 66k5ky3KxpYy2y4tKENrLZhV3/LjfcttTYo3ireoUHhRdvdZl2VeVFmQU4sFf2nm+GtP+BbyC6q
 yfaOBBxd7z4VuBbSd6EmDqSQAEgA2SsddBJv+Q0g1Gtsaz5xRBHqGEjaarRXQa4bmd/2M88teA5
 F2INU87TynXxF6F4zPhjhaFeAblLNspg1kw+FGryrqh7lpaJ+jORTpZdToJMHVVPgb4QHs3yD/d
 IJSXgX/lJxHtNQFapKM5EtZq5PrfBHfwEBYVhgqksmP6A+RJG16OiJk+XEETK4U4ajnAJ8C/2D0
 rR5x1ibVgQCxZ+viqZwjRKFiAC7GQ58Kile9N1N90oOOakf/Tr2xLUBsF3J1SC/wAd8OMwdRC
X-Received: by 2002:a05:690c:3482:b0:8aa:357d:e41e with SMTP id
 00721157ae682-8aa357deab1mr23677007b3.51.1790618817213; 
 Mon, 28 Sep 2026 11:06:57 -0700 (PDT)
X-Received: by 2002:a05:690c:3482:b0:8aa:357d:e41e with SMTP id
 00721157ae682-8aa357deab1mr23676817b3.51.1790618816738; 
 Mon, 28 Sep 2026 11:06:56 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm49390177b3.11.2026.09.28.11.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:55 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:06:54 -0400
Subject: [PATCH v2 4/4] doc: board: qualcomm: document Arduino VENTUNO Q
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-monaco-ventuno-q-v2-4-0e046c8242be@oss.qualcomm.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
In-Reply-To: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-GUID: Uf6KuF-eK-3sYipskCw8Ab4bpRGzvRAc
X-Proofpoint-ORIG-GUID: Uf6KuF-eK-3sYipskCw8Ab4bpRGzvRAc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX2WSqqNdMnphj
 rRI/sCqnlap4yBfGYh94pS7nnZathfAfyf+OSlBy3yyZV6K0pVmNBcS9p6QL/aZbqhHfqKrjkaH
 dZNABS5WUaSpEHKam4F4NSX4LJf9ejA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX6USSPGFE1su5
 Snp102YCF43vcVBaPuybR+Wk3CoR067gVGH/bHTGmyztqyLHaE/Ajx2iUu1JkE1UxBm7QNYtm2+
 vR/FBDokN4WqlP4Vo7H/2zEgUt8sjtENf6/Vt5E9pWmaWcyR/gQtx0Lx/k8h4W24vCT0VnOzxgF
 MoZrogqH8yuGQsv9yLliEz9f1vtyFl+/aCgDuOcPjHzBdkh/fnK++7KmT7uKY2UTmxceBvWUSpC
 0ucH81mKm1yQ1dqncLDwy3dWpL0GoPgIIb4DOOYmDa1DgKeBJcSzhEKHW8o1OSZvLAV8+tENoJR
 uMoezjPc8zjNKjB1s3g5imsMVNHTpy3nqpg4kC5jXJiUEOUhOLFXxCfrseOILeJAS1XcFVg6iUr
 /N5UI5d3M+QvCukV04q0mhOrIikRm+LXI7eLvRU2haFNK0k977OInKY5i2+7cNDWP8mdTpTV+xD
 /P1ojIB8r7fwhUVyMkw==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6abaacc2 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UXIAUNObAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=wc1G-8gzH6XItzunGAkA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280072
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

Add build and installation instructions for the Arduino VENTUNO Q.
Add a MAINTAINERS entry for the board.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Changes in v2:
- Reworded the commit message and shortened the document.
---
 board/qualcomm/MAINTAINERS       |  7 ++++++
 doc/board/qualcomm/index.rst     |  1 +
 doc/board/qualcomm/ventuno-q.rst | 48 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a794..85c92f4007 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -1,6 +1,13 @@
 # This MAINTAINERS file is for folks with an interest in a particular platform
 # or board under ARM SNAPDRAGON
 
+ARDUINO VENTUNO Q
+M:	Tyler Baker <tyler.baker@oss.qualcomm.com>
+S:	Maintained
+F:	arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
+F:	board/qualcomm/arduino-ventuno-q.config
+F:	doc/board/qualcomm/ventuno-q.rst
+
 QUALCOMM DRAGONWING QCS615
 M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2..85b01f7bf6 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -13,6 +13,7 @@ Qualcomm
    rb3gen2
    rubikpi3
    iq8
+   ventuno-q
    phones
    rdp
    signing
diff --git a/doc/board/qualcomm/ventuno-q.rst b/doc/board/qualcomm/ventuno-q.rst
new file mode 100644
index 0000000000..fd02f9aa40
--- /dev/null
+++ b/doc/board/qualcomm/ventuno-q.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Tyler Baker <tyler.baker@oss.qualcomm.com>
+
+Arduino VENTUNO Q
+=================
+
+The Arduino VENTUNO Q is based on the Qualcomm QCS8275 SoC, with four
+Cortex-A78C and four Cortex-A55 cores, and boots from eMMC.
+
+U-Boot runs as BL33 after TF-A and OP-TEE. XBL loads TF-A BL2 from the ``tz``
+partition and the FIP from the ``uefi`` partition. TF-A BL2 must already be
+installed as described in the `TF-A Qualcomm platform documentation`_.
+
+.. _TF-A Qualcomm platform documentation:
+   https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/index.html
+
+Boot CPU
+--------
+
+The boot firmware enters U-Boot on a Cortex-A78C. A kernel with pointer
+authentication enabled cannot bring up the Cortex-A55 cores when booted on a
+Cortex-A78C, so U-Boot moves to the first Cortex-A55 (MPIDR ``0x10000``) with
+``CONFIG_BOOT0_QCOM_BOOT_CPU``.
+
+Memory
+------
+
+``monaco-arduino-monza-u-boot.dtsi`` leaves memory reserved by the boot
+firmware out of the RAM map.
+
+Installation
+------------
+
+Build U-Boot with the TF-A/OP-TEE and board configuration fragments::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcom_defconfig tfa-optee.config arduino-ventuno-q.config
+  $ make -j8
+
+Pass ``u-boot.bin`` to the TF-A build as ``BL33`` and build ``fip.elf`` as
+described in the TF-A documentation.
+
+Put the board in EDL mode and write ``fip.elf`` to both ``uefi`` slots with
+`qdl <https://github.com/linux-msm/qdl>`_ and the board's eMMC firehose
+programmer::
+
+  $ qdl --storage emmc prog_firehose_ddr.elf \
+      write uefi_a fip.elf write uefi_b fip.elf

-- 
2.47.3

