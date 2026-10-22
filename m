Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D207606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rHWJgy1N;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O6qjxBIq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e3PBIiRa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4576581287;
	Thu, 22 Oct 2026 19:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PgqM8Td_KuFG; Thu, 22 Oct 2026 19:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B17418129F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695905;
	b=hhM03SE1Vb9S2D+Ti5S7gAV60O2jFdepUxL7EJ1Uoa0AHUwgC5CZiQYNlqVpx4a3fDUT
	 yaATyepoXQ2VOsUcJp+A8o6eUai+HZ2c2Ov25f9rbRoXO58DuHZ9XWDLFxyb7c3tfeJ8Y
	 zWvjTDnBSi9xzv9b+sIVVshCCNxU87LSMaF3clQFKEnR1A+4QnV8ZVwbfktk+xitvfaip
	 P0bgkJkdSy2L0is4XYtoRU8+CZLj+OMRrWYmqlhG1bR3I6KcvYA17Kuu5z6ipLWWf8bqP
	 EcfWsPpgdtAxUpaGP64S52s8YJUM34qi+Ehb2uZ/VQ+zAkDUE+SBQJwUbRJANMJr5Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
	b=rw0zt2LKUfdToOuCr7BXBIlRZlblngMP8Jx7MM5TYEyRgfVuoOJdgkRm3k6uGiHuaI2T
	 YReOIsqiu2XKWa+k0sPDLBpa3qYjMH+AK4MVxEUQT2pKe+dtQetiX1/s9j6S9dwTxKaj8
	 qLY8gz7+E7vgk7HSvJN6iJkztMOZOvWv6CCwUxfiuUz38TGMRwHpyPpwCBIjjdQ7IKXrJ
	 RfvCS+PgEGhwLGEOF7sKbvPFIrQ0s8rnAK1LmPficmqKMEAiG7Z4cQF8vr3gtVKiN6QWL
	 /07UilcyVh0pE1isiSgP+ux1w5bbu2I9dt7avYf8hepybxVU/BRt/ImiDX+UW3ula+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695905;
	bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rHWJgy1Ng7ITx619TcpxPhqIC5rq5gJTkRFZxwHxQFsrXjakSK4N63/wZoHwmKjf6
	 jE600bQLxgDe1g5issu4hQpYaJ9fSMXhtDAKuVLdAg9FGaVsmlcJcVirLVD5woqxvn
	 SjI9nUZjayssmnlXpbbSurM7oCfc4L0Ghiu4yzJIJF+d4HrFJL/24vTUXOkbhsPZK/
	 fgWMwv9DLmU/RGa+LXMx1SN1KVhtU1uMAyfzR0AtGGR4OEcl0jPXABKfo6gS1aFAfz
	 iNo1utjlfUE0HOX9RunjdaDr3FfXLCm+osNHkgBwS5EYADX7Q/XmuJlzEVRLSFpkQ2
	 p6slT0Vtpayog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B17418129F;
	Thu, 22 Oct 2026 19:05:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AA4C3C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07DAB40176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljFAEdxUoREo for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0757A401A1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695902;
 b=IGXqCzX6OZoQHyE7uebjrJElNasmgzE5Z/iQ3YQa7r3z2tJd9+Lk4FEKkDDqTr+PPe5t
 5X5mGkH7BJNYfKBZMja2BGjQgZeT/PusWgPbZDdeV2kwviq0n/yzOHfEE79WTyQkRYIUf
 1xW9n0uI6F70awOynHu/SQk2RVtl+xLf0VnJifeVUw7QTgNtzddxCSyphETWMxEwlrbxM
 kLsbZVMSsoDLENswgYeD1B9GhjMc7qQSFny0sLJjzaMmykCP7UlLXQJfA+iDnSmu2Jh6G
 VnIqm3pHxFLhB7NfxBUJhyJOd9QH/UrBGe3NtE7a1ba10HRNcTjDyA6vJxrgxftH1mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695902;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=hUuc98LB5E9rSU/XqdGpKUF3N/mCjtrrYumtMa6W1701EqbJAMT+RPT45AJqemoPk+4w
 FbkDU2BWW4T12KSP+hnmDAJFdccQQq+Wte/yHMjPltykB0P4Ta5yUkr5Owf57byjOUaQt
 aYZwGhDt7x9m7T37j8N/qCRSzkOY2UQssXH7Xngu58MtPRGYT+WP4CiMxmrXxqrogO/cb
 DwsMMAoejTcgyB7pOc4pmzRMFKceX1cMNIZFqGD3DXIg0LshjYQLXS4Yc8wv9XUKLxg0P
 T7qkhDdRP48ZuoGb1dT008ubOBk2seUDf9YHN9qBpVwEpzOyVnacbICjPQnU2DQo7ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O6qjxBIq; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e3PBIiRa; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=O6qjxBIq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e3PBIiRa
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0757A401A1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtYHS409011
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=; b=O6qjxBIq16+lpQTN
 bsc2c/5vaVaByHpKECa9mNB4VXZQzxy6p8wLZ9OukAPREF8UbafxmdzrOzfjpi/5
 Xk45XtHBgf1Y5BFzMox3Etsny+nk0pckZg2dCcDC9HiUrZgoNPs9VgB4tniwQSgc
 wSFyn4ZytAw0NJskKKALtocCZRVWv+5Tk3u/svHG9uooxjQTriFZucilpPgwvvCM
 hAvjr87Ms1wAsxYHwwzKVH/e7oeyNOoQs+pw7IqKdyCLRKZrsDKYBtAciZ6XGIEc
 qrd82yPhFL46xHWuBVVMfZdnpLOvOFF0thuBksfQYwnpGNB4Htr9fcnkxU7P5oip
 AT2DOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a54sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f32050e72so31144485a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695898; x=1793300698;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=e3PBIiRaLnyy6q+e1qZeTec01RyP78JdnpDh0FIN9SortWel5fVpzKUDWcs6aHhtgf
 uhUP4TwiiymkeF1vuJq2zofNR2gDzfyiNwMKG+ZJ9KjUaY0kTFh3jeUwzNGz1+0D/MWJ
 Oa9yl/Fab2pcO+3RJEcihyUdVcRqF7KmwAjKLViCXnUhS+I8397uugify5nMJQsBM/JP
 ORNIkCZA0kxCansyWL2+Dx2L9HTbtMmutTcUNrLswsUhftjo0dkgqAvWJoB8AmAjQM0p
 XY6FO5udmnbdoEE77PhUDD03prgGVZh92CUVwyWpnrABzpMHS9aTJ4hluxc//koGEEoM
 eAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695898; x=1793300698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bE4WHxp53nhOFbiF5VWsVpw6FT1r3I+0W0pFtMnaYnw=;
 b=trboDFWc/xZdWVh27tJf7+7gqNP3n95O3IoHbPY+UYhiLRJ1oUspo5sNVBgzDEbZqX
 7VH1XfIe5imHDThDoJFRozAoOm44B4v7Zwv4jtQlzRiOAf/li+xjr1sv+RiF1ZX4ZR6/
 3g4kSLGfB0DS5BQEEHlnTSnDjr2rxlxzXvUo642+UsJ44qVc57sSoIedSbyNRd4+Wfph
 MJrKcZiH6FUdq/sAK1sdf+uRenH+P65MMdBWmv3v1q0kQa2S4Sr5E6U48K/3SW1y8ZmZ
 qTkDldwhimMfHUCP6Wty4hWANzK51ApYIe9i/r4ULA2i5wTuLrWh4pOMB1YtStxFJL5u
 vqZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCfuBezlQ3TsV7kTmJXOul5cXbtoHes/mGwPZkPZHizragBTxqkr5e/+kUqSIT0qMNKtWZiuI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLIzUmaPLjOXlyv58nFOwjMAeeCHSE0cBqbFRxJC1LTnTs2glmT
 ATIqFqaWyhA2zrzRQ6lpgNtFcxuzpyiArJm7MiW/Ucj0Tusy9dCR2x/pF7wH4qPI2sQ1MJAdO4S
 AOYt0eUgZC6p8FB0DohcHXH7GdCtoMwDc+MamU923+lyry6pGGcLSTgieZFQtKcL4QaRczo4=
X-Gm-Gg: AYBFou2gaVy50BQ4SbMxMCmmsKF927r73DGUY8Oe0fFvZKKP/6mOwYNVjjw+aQrrjYj
 ExYS9c0iSrSJ6OaGZqGIRRWQQboYbjs3OwXtEVNK1sKZ+zDVeBL7gKZoZ2xzafCI+O3axZCz6U1
 rnPNFsWMOcMDgJ2rbACcyXAU2KeNjPB1iGZn7xD5dN9gd73j1OllezztDXAYnkw5BtZcIp4xtWa
 RkU4I1lRGtsskeJPFbjRe5gMxNgkesP/AyM0xbdKSh5XaXlVMokm9zeQXR0WU4d+e0ckXoII4PL
 Eiw9MzKFel4FAIkRSyogEpOUvSEsFreUpUJ/urKsY8/B8SVRL+Y+a+ObHEEWcviiFz1s1qmBIjD
 fZ8BuGC2SzoG00zlZfKAmmzSC1udKcrDtsgZefHpqu6w9
X-Received: by 2002:a05:620a:1712:b0:93e:c12c:fbbd with SMTP id
 af79cd13be357-93f6fa01e20mr61645485a.74.1792695897937; 
 Thu, 22 Oct 2026 12:04:57 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:93e:c12c:fbbd with SMTP id
 af79cd13be357-93f6fa01e20mr61640185a.74.1792695897472; 
 Thu, 22 Oct 2026 12:04:57 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:56 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 21:04:46 +0200
Subject: [PATCH v4 5/5] doc: android/avb2: document the root key
 provisioning and lock state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-5-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX9Z0g/HiwUfe+
 4TxkVFdwKw24vh7feBQT3Uw9VZoJSjSL8dIkuqsEYvZzGTTsZ5RXftgMrRN+m4QA1Fl+w94IS2I
 jE3lGVU1taL0TFky304fxporLd8R1+UKXRC9VnqZbIBiid0OvzfdaJE+9muYifQDFpSReUwmwlg
 rpzdNHzwb5nfmGDaY/umVuUf0yWkwZwzncy3J/KvxWkz1Ah0PJq0Rrh8T6T4tiM9Z1ohYFXfH/k
 97WyBCPFKPj6r6tbL8aIKDws2LXq2bUo+P9NyhFfvhTmDVYGQs4Q/meVnUk1JRrqC4KYEqpvsY+
 fjbTASjJkmbzqHA26Cc169O8g7teiaXznbboLBod++tUE1StgPOJKEVWg3v+jB16ioR0YPpRnF7
 WMPHbMwS7AQ5a5lSYX696UWjFg3U+5JiGXvnL/+s66re/ZLbBWBlzYvQjpNkUI8tuE3aJXInAs1
 6y9BjA3XtJnWaVTyZrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX7A7+iKuOI1Hx
 25a9QMNX88AtdoOfSyrIzgZ2wKLxvg5fIjsqeSjOs0c9lY3RsF4GXGiaGUXA7FbwHnx71iW7kGt
 U2x/Iaa9NNsTac4oSjYgZ6mQ4HJgghs=
X-Proofpoint-GUID: Od84Wpw9mPtjf88HlBIYi1HGRvO7ex0w
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada5e5b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=DnaZGjYjaaDC2aZnHNgA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: Od84Wpw9mPtjf88HlBIYi1HGRvO7ex0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220076
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

Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
how to derive the SHA-256 digest of the vbmeta signing key with avbtool
and provision it into the TEE persistent value with "avb write_pvalue_hex",
the fail-closed behaviour when it is missing, and the device lock state as
seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
mandatory userdata erase).

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/android/avb2.rst | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 43d5600d2d7..b3c7617b0d3 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -85,6 +85,72 @@ Note that device lock state and rollback protection are only enforced when
 backed by OP-TEE (see `AVB using OP-TEE (optional)`_); without it,
 verification is advisory regardless of the root key source.
 
+Provisioning the root key digest in the TEE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+With ``AVB_ROOT_KEY_TEE`` the trusted digest is the SHA-256 of the public key
+in the AVB key format (the 1032-byte blob for a 4096-bit RSA key, the same
+encoding that vbmeta embeds), not of the PEM file. Compute it on the host from
+the private key used to sign vbmeta::
+
+   $ avbtool extract_public_key --key key.pem --output key.avbpubkey
+   $ sha256sum key.avbpubkey
+   7728e30f50bfa5cea165f473175a08803f6a8346642b5aa10913e9d9e6defef6  key.avbpubkey
+
+and store it from the U-Boot shell as the named persistent value, which the
+AVB TA keeps in RPMB-backed secure storage::
+
+   => avb init 0
+   => avb write_pvalue_hex avb.root_pub_digest 7728e30f...defef6
+   => avb read_pvalue_hex avb.root_pub_digest 32
+
+Until the value exists, ``avb verify`` and the Android bootmeth fail with
+"Public keys are not accepted"; a wrong digest is rejected the same way; the
+value persists across reboots. Provisioning is a one-time factory step and
+should happen before the device is locked; see the note above on protecting
+the value from normal-world writes.
+
+Device lock state
+-----------------
+
+The AVB TA stores the device lock state next to the rollback indexes. A
+locked device refuses to boot on any verification error and reports
+``androidboot.verifiedbootstate=green``; an unlocked device boots with
+verification errors tolerated (``orange``) and rollback protection off.
+Changing the state resets all rollback indexes in the TA.
+
+From the U-Boot shell::
+
+   => avb init 0
+   => avb lock
+   => avb unlock
+   => avb is_unlocked
+
+Over fastboot, with ``CONFIG_FASTBOOT_CMD_FLASHING``, using the standard
+Android commands::
+
+   $ fastboot flashing get_unlock_ability    # OKAY 1
+   $ fastboot flashing unlock                # erases userdata and metadata first
+   $ fastboot flashing lock                  # likewise
+   $ fastboot getvar unlocked                # yes / no
+
+As AVB requires, both transitions erase userdata (and metadata) before the
+state changes and are refused if userdata cannot be erased. On slow
+(emulated) storage the erase can take minutes; a TCP client may time out
+meanwhile, the device still completes the operation.
+
+While the device is locked, ``flash``, ``erase``, ``boot``, ``oem format``,
+``oem partconf``, ``oem bootbus``, ``oem run``, ``UCmd`` and ``ACmd`` are
+refused; ``flashing unlock`` is the only way to change its partitions.
+``get_unlock_ability`` reports Android's "OEM unlocking" developer setting
+the way PersistentDataBlockService stores it in the frp partition of the
+fastboot flash device: the SHA-256 digest in its first 32 bytes must match
+the rest of the partition and its last byte must be non-zero. ``flashing
+unlock`` is refused otherwise, so a device without an frp partition (or a
+flash back end without a partition table) can only be unlocked from the
+U-Boot shell with ``avb unlock``. Locking or unlocking a device that is
+already in that state is refused without erasing anything.
+
 AVB 2.0 U-Boot shell commands
 -----------------------------
 
@@ -105,6 +171,13 @@ different testing purposes::
         <partname> by <offset> using data from <addr>
     avb read_pvalue <name> <bytes> - read a persistent value <name>
     avb write_pvalue <name> <value> - write a persistent value <name>
+    avb read_pvalue_hex <name> <bytes> - read a persistent value <name>
+        and print it as hex
+    avb write_pvalue_hex <name> <hex> - write the bytes given as a hex
+        string to persistent value <name>
+    avb lock - lock the device (verification errors stop the boot);
+        resets all rollback indexes
+    avb unlock - unlock the device; resets all rollback indexes
     avb verify [slot_suffix] - run verification process using hash data
         from vbmeta structure
         [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)
@@ -146,6 +219,12 @@ OP-TEE::
    CONFIG_OPTEE_TA_AVB=y
    CONFIG_SUPPORT_EMMC_RPMB=y
 
+and, to take the root key digest from the TEE and to lock/unlock over
+fastboot::
+
+   CONFIG_AVB_ROOT_KEY_TEE=y
+   CONFIG_FASTBOOT_CMD_FLASHING=y
+
 Then add ``avb verify`` invocation to your android boot sequence of commands,
 e.g.::
 

-- 
2.53.0

