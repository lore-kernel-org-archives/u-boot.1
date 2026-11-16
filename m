Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D055606A8B9
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gXZ7Rav/;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HEmL6AHA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZcYpSEb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 217F44064C;
	Mon, 16 Nov 2026 06:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Di59CudrjdoY; Mon, 16 Nov 2026 06:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E60094064E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794810603;
	b=dxNJSaTWU1/geqqS+/fQNA1EYTydtQQsFZcLdKdnUVEEo3QC7iLBBSJ+4WgObASgVnNm
	 Z4bTDU2OIlY5MvCxRdFmTWS0FnxQqgCuPoJNFMk9GTruOqzVxq+uT5EgfeCmK81IuPKTK
	 WAY3dtWNpztStubwhglUAYdfPdM9EjJAKAxNP63djoBo6qUnqCzJ8T6ghmMPjtQETTH7q
	 3pjfOAg7CN4vgsJ9EAuKKP/Rm4sog3Zc71Ka3CaD1gCQc/VSPy0aAqUEiUb0xyf3WSPJD
	 jW7jhS4GMJE9oxulgSQTmTGRJ6ckFcIJc4rgqNfQhu08aQGg+zV80s05C0Nbc91Qw0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BySVNqLUY8/szsV9KwA/XrAa86Z3D1Xu/ZM2SwocICo=;
	b=KKScjE/XvN1NW8x6nkZsZOluZOR3hIiMPvRDTlI6efJkDzkSy47NYRgoPM8qHQkc3HN9
	 YrEKIzb2Gf1Y5sAbL3bjZBquMbMypWl2QG1sb5v68Sa7xwjvOa3w6/257IuJ7Meb5lH20
	 sJjHFHn+DN/pddY/CE5mVgmoqrYsbMwr3vXhJ5/nGHT6/z+uD70eh/aUCdQAF8hFBjWRc
	 X7gXOsGictsWpILnJ8cO0IQ9vUA8otsJHFcVaj7yqdrjp3I24T2Cli4QrHSsQhYD7fYyV
	 uVNHvS2WzqZjprL1ARc0tKBgoImHe/c2VMaeBlu4YGyR2y2ZS3P04YrVTFNJWxdW7EA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HEmL6AHA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZcYpSEb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794810603;
	bh=BySVNqLUY8/szsV9KwA/XrAa86Z3D1Xu/ZM2SwocICo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXZ7Rav/SjcTtsJ9WtdZvVCahodVnxfmvIr4G0YxaSJAk0i8bXkmmTqvqlQNowTit
	 hzscSy8OGJrlnW1IbI92+SUPQPFJbw8Jcyc6YnglWYqKd+43Qa6059jbYfKZy4WkVG
	 XQ1+cxQNiQagjaMDVdd/EVNS8A6dX3RAxNx4PUQ5pUoX3k/GWLFDLosGFV23WldlHK
	 sS8D6uyem+g/2ha7hJ2ke0Op+nHwy8UDNw1YE1SCebFouVO+gXlUXefQtB7PeeR3OI
	 8d6LkRPOMnLVEYL8+YWg6fjtuQeUuE+TW/hI9LYaU5e9fWl5Gc7rw2Tz0FWYpSMav9
	 hkoN2Ej0/xXCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E60094064E;
	Mon, 16 Nov 2026 06:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9982328C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FB8A4064C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1h2iz5jZq44 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 06:30:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 369674062A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HEmL6AHA; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KZcYpSEb
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 369674062A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG5LaR11321014
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BySVNqLUY8/
 szsV9KwA/XrAa86Z3D1Xu/ZM2SwocICo=; b=HEmL6AHA3B9280a+DZ5YJOkBhuU
 TidJ7NEaB2BGHerQ/6Rtzl45Q8eA0y4CbR+Afp6aApvIMk+Z5KGkrw6AxA1BvDKv
 9Dyy6XcCj2UOUQ8Z4eCFjPXYIc4VZvGYAlypsDGMKKAo++NpCfYT/CAiO5VWQORU
 tHBugq9H8+kY0HTBSsD21FoNyFXsVApCdEMKxtxnqG04R+hAECuVpxC24FWfWKrQ
 Pxm9FOJqL2Odd8l0W5OBlXhB4Qn4rJO8HgZBKzxrbpe7RfWRrNKFypnS117s+4Ey
 hHXDYX6NcMh7FRo3w7Aq8Dbf/qhCeQ5xCSWswsb69r068Zxkw+xtC7Bb8pg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhman2cp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:29:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so4934193eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 22:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794810597; x=1795415397;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BySVNqLUY8/szsV9KwA/XrAa86Z3D1Xu/ZM2SwocICo=;
 b=KZcYpSEbU3tY2jsBBE9uMLmHvDHul+woR9/kgK4BlNiFnBuPEz6GROd8WRPClmI625
 AuULEbm7E8hxlKQmcxIsu+j+kfjV8VeIiHbgQZd3L0JyKmfaZ0YWmj24B+/HNLt3Gari
 PsJ8nnM1plhRomJGEVTKbAP2qKeqOeXr4km+wWEv7EK1tjzKpa+5W+vmZp9Fiyxcceuc
 tcn8ovlnjQV9k7hXlRl5WuXVZCQOp7lG9hyL1wjCdkFUz1DoXRqKo86e+Ybm6wKMvh60
 nchqAHaB2DRGFWZ//BbuJc7XoQ7OlTbZeM0gZJGMOgeLmXv1f60BD6dmb5Iwyaxshl4Q
 C/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794810597; x=1795415397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BySVNqLUY8/szsV9KwA/XrAa86Z3D1Xu/ZM2SwocICo=;
 b=JjmazX0c6xb37Ki65UQZUbJtjipNxw0PWOKm/olCNvNVD7Kt8kLCjSNreYQCibb6ik
 W5GYjKc20IhdJlsg04gEPW0yNPDN17c30/8bLR1rEaOQ7G/zjcgExdq9dWCGA4pWBMwp
 M/e5UpWVDBB8TMmHN6zSaQfycgEda+h2obIgc7CN/YlQ8TweSb2QsAV53L31Ubqaa0NZ
 LPz1WcBmetdLMHsZ4hzD4iTjUMMmuwyA1JFe1VYJKjlMHodfHssDaOP+w56IShb78Cum
 LW6+yCQdymUk2n9Ow5e2xUJA4PgHg3tGArSDkNuoISa33oI/kDERG1bRYSEG5f7wJPF+
 cSWA==
X-Forwarded-Encrypted: i=1;
 AL+hErE8fTxINjSjNhqt9dXFFaCW69dOr1btKNX0ZZwFrPLPMCXueo44E+ZCsW32FlvNFVULQWGz0kc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8YrIpGntlrKRW4goY3IgUt9PfGGZif3Vo4IhvgL34oxXDdVlGe
 4Yy3fZesG4ontSmsfyF6kJpn5hjlwkWtHImKh6fT1jytEYE5vxUxGt+OsH6txIC56xLsDKT5ujf
 ytM51b/d7sKO/5MC4TDQHIwLQv3z9GJzFcKqeA69VaXOQ1PrOrCQd1GhKBJd4y3nXZQnyCJ0=
X-Gm-Gg: AYBFou2SJkaVFXnvRMMhLxsabEurjn7X7dg88kYSjnnYhkVQPcCGT1rroxZhdVMYeCX
 OquYH84Py8ZjOVgEASLkJNAoG6sZoO5UE+RDXxxsPI7jswmBEffW/J/z6Z9ePsPb8RLC8sc/fv/
 doALo20gnq3pixTowNjuF6Px+zM0ETDkxG9wmBKcM6jui0Qhpy5AB02pAnYw24OAgMVkV+UqLu4
 2xlu8r2Ik4fVSXWcO51mgSyGRu1KCHi9TTWAlybPhqRuJTH0ND4GmCHkYSJgd8i5uyNuwHagowr
 gawRb+xXXWf3cJJaIrPH3ELt+EI8E4nppPkrLfrHBkahv8qV57Sy1avSBjGYTSp+ZHSh21PEcSM
 eouLfuqcxmdFtTpNrZjDwJ/fvUXPPjwC4FhbGYq4EACfXZ9K6RonWaC2k/JpuyGeqtSHia7cfhd
 OrfQw0vygFNY8G9QN0Y9SyCb9KpYfx8vsue6tKSykEgEmkwPxYEiT7R/a4rBNWrCD7AtQ=
X-Received: by 2002:a05:7300:d0a2:b0:36e:ff7e:e57f with SMTP id
 5a478bee46e88-3796628f98fmr9603630eec.19.1794810597331; 
 Sun, 15 Nov 2026 22:29:57 -0800 (PST)
X-Received: by 2002:a05:7300:d0a2:b0:36e:ff7e:e57f with SMTP id
 5a478bee46e88-3796628f98fmr9603605eec.19.1794810596705; 
 Sun, 15 Nov 2026 22:29:56 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f01d68sm30283963eec.17.2026.11.15.22.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 22:29:56 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 hongyang.zhao@thundersoft.com, sjg@chromium.org, visitorckw@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 2/2] doc: usage: add EFI Secure Boot guide
Date: Mon, 16 Nov 2026 11:59:41 +0530
Message-Id: <20261116062941.2829602-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116062941.2829602-1-aswin.murugan@oss.qualcomm.com>
References: <20261116062941.2829602-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wvUMLVoFlxyWQA07e94KFYfg0A4w20lx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfX+HIKnnhho7R5
 9NaBIxzqqVqWSYlwhl/ZWtH7FGT4cBpApqLHb9BqE+Yw7CRtMaA578mUPmBuhwi4BKHbrdVTvPO
 hLF+n7yRncWOBaH1RC+R3NTjndn2vvpSxnQXnxXa5V1g6MsbXRzYbY/XetwM6XiVuPv5LohzMzs
 wPm0728XrWKDlSYIBcOuzG8RR21EpAW0C/sL49OtRML0uufurOY9v9OTB1Mvox+fPT3z1VWOMwm
 jQsrSRgFlFKJyuvK5n6/fAWrAqf00geOJIVaZ0DMYkAfzgXTMc1ZtCLkKt14K4FGInxM7WqQJtC
 tlypeFEJaKC2+c9ZsUqAAP8YZIPb9H4wgS9tH/7RJ9VTbAcgGUY+kVg+YRON9SGSmkekeP9Rk8Y
 RuCb34R1BB8ucIeqVS4UzbNIVd1Iv3kn4Z5uJwdAgy/+9Q36uu+CL424ErY1xEmfjUf8nANh6Mh
 9nCar16pkZDzlBq5Aaw==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6afaa2e6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9GzSz7_nYVRf7ZKFdXEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: wvUMLVoFlxyWQA07e94KFYfg0A4w20lx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNSBTYWx0ZWRfXxevMgPYYf3sm
 uJsufv/mYt77YbI3ciqrTEhKxfhkNbYwDaX6bbDlDxN7R1cfcBHEE+D55ZH7PU82x2E5wKXMODP
 abesgAt3gFcwnybbbQlAv1UUkaF+8lg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160025
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

Add doc/usage/efi_secureboot.rst describing how to enable and use
UEFI Secure Boot in U-Boot.

Link the new document from doc/usage/index.rst, and add a "See also"
pointer from doc/board/qualcomm/index.rst so Qualcomm-board readers
can still discover it easily.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 doc/board/qualcomm/index.rst |   6 ++
 doc/usage/efi_secureboot.rst | 174 +++++++++++++++++++++++++++++++++++
 doc/usage/index.rst          |   1 +
 3 files changed, 181 insertions(+)
 create mode 100644 doc/usage/efi_secureboot.rst

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..092084f4c69 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,9 @@ Qualcomm
    rdp
    signing
    spl
+
+See also
+--------
+
+For enabling and using UEFI Secure Boot, see the :doc:`../../usage/efi_secureboot`
+guide.
diff --git a/doc/usage/efi_secureboot.rst b/doc/usage/efi_secureboot.rst
new file mode 100644
index 00000000000..f7e96f2527c
--- /dev/null
+++ b/doc/usage/efi_secureboot.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+EFI Secure Boot
+================
+
+About this
+-----------
+This document describes how to enable and use UEFI Secure Boot in U-Boot,
+and how to generate and enroll the keys required to authenticate EFI images
+(such as GRUB, the Linux EFI stub kernel, or a Unified Kernel Image) before
+they are executed.
+
+This guide uses the variable preseeding method, where the PK/KEK/db keys
+are generated on a build host and embedded into the U-Boot image at build
+time via ``CONFIG_EFI_VARIABLES_PRESEED``, so that they are already
+enrolled the first time the board boots. This is different from
+interactively enrolling keys at runtime.
+
+Secure Boot trust model
+------------------------
+UEFI Secure Boot relies on a hierarchy of keys and signature databases:
+
+- **PK (Platform Key)** - the root authority. The PK owner controls updates
+  to the KEK database.
+- **KEK (Key Exchange Key)** - authorizes updates to the ``db``/``dbx``
+  signature databases.
+- **db (Signature Database)** - contains the certificates/hashes that are
+  allowed to sign EFI images which U-Boot will execute.
+- **dbx (Forbidden Signature Database)** - contains revoked certificates or
+  hashes.
+
+At boot, U-Boot validates the signature of an EFI image against ``db`` and
+rejects images that are untrusted or that have been revoked via ``dbx``.
+
+Preseeded variable store
+^^^^^^^^^^^^^^^^^^^^^^^^^
+The authenticated variables (``PK``, ``KEK``, ``db``, ``dbx``) are normally
+enrolled at runtime through the platform firmware. For an embedded boot
+flow, U-Boot instead supports *preseeding* these variables at build time.
+
+A file named ``ubootefi.var`` is generated on the build host and embedded
+into the U-Boot image when ``CONFIG_EFI_VARIABLES_PRESEED`` is enabled, so
+that the PK/KEK/db are already enrolled the first time the board boots.
+
+Required build configuration
+-----------------------------
+To enable EFI Secure Boot support, the following options must be enabled in
+the U-Boot configuration. A ready-made config fragment is provided at
+``configs/efi_secureboot.config``::
+
+    CONFIG_EFI_VARIABLES_PRESEED=y
+    CONFIG_EFI_SECURE_BOOT=y
+    CONFIG_FIT_SIGNATURE=y
+    CONFIG_SHA512=y
+    CONFIG_SHA384=y
+
+To enable Secure Boot for a given board, pass the ``efi_secureboot.config``
+fragment together with the board defconfig to the same ``make`` invocation::
+
+    make CROSS_COMPILE=<toolchain-prefix> <your_board>_defconfig efi_secureboot.config
+
+Generating keys and enrolling them
+-----------------------------------
+The following steps are performed once, on a controlled Linux signing host,
+to generate the PK/KEK/db key pairs and certificates, and to produce the
+preseeded variable store that gets embedded into U-Boot. The examples use
+RSA-2048 and SHA-256.
+
+Step 1: Generate PK, KEK, and db credentials
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Generate a random GUID to identify the owner, then generate the three
+self-signed certificates::
+
+    uuidgen --random > GUID.txt
+
+    # PK | Platform Key
+    openssl req -new -x509 -newkey rsa:2048 -subj "/CN=Custom PK/" \
+      -keyout PK.key -out PK.crt -days 3650 -nodes -sha256
+
+    # KEK | Key Exchange Key
+    openssl req -new -x509 -newkey rsa:2048 -subj "/CN=Custom KEK/" \
+      -keyout KEK.key -out KEK.crt -days 3650 -nodes -sha256
+
+    # db | Image signing key
+    openssl req -new -x509 -newkey rsa:2048 -subj "/CN=Custom DB Signing Key 1/" \
+      -keyout db.key -out db.crt -days 3650 -nodes -sha256
+
+This produces the following outputs: ``PK.key``/``PK.crt``,
+``KEK.key``/``KEK.crt`` and ``db.key``/``db.crt``.
+
+Step 2: Create EFI Signature Lists
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Using the ``efitools`` package, convert each certificate into an EFI
+Signature List (``.esl``)::
+
+    cert-to-efi-sig-list -g "$(< GUID.txt)" PK.crt  PK.esl
+    cert-to-efi-sig-list -g "$(< GUID.txt)" KEK.crt KEK.esl
+    cert-to-efi-sig-list -g "$(< GUID.txt)" db.crt  db.esl
+
+Step 3: Preseed ubootefi.var
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+From the U-Boot source tree, use ``tools/efivar.py`` (matching the branch
+being built) to populate the preseeded variable store with the ``.esl``
+files generated above.
+
+The global (platform) GUID ``8be4df61-93ca-11d2-aa0d-00e098032b8c`` is used
+for ``PK`` and ``KEK``, while the image security GUID
+``d719b2cb-3d3a-4596-a3bc-dad00e67656f`` is used for ``db`` and ``dbx``::
+
+    tools/efivar.py set --infile ubootefi.var --name PK \
+      --attrs nv,bs,rt,at --guid 8be4df61-93ca-11d2-aa0d-00e098032b8c \
+      --type file --data PK.esl
+
+    tools/efivar.py set --infile ubootefi.var --name KEK \
+      --attrs nv,bs,rt,at --guid 8be4df61-93ca-11d2-aa0d-00e098032b8c \
+      --type file --data KEK.esl
+
+    tools/efivar.py set --infile ubootefi.var --name db \
+      --attrs nv,bs,rt,at --guid d719b2cb-3d3a-4596-a3bc-dad00e67656f \
+      --type file --data db.esl
+
+The resulting ``ubootefi.var`` file is picked up by the build when
+``CONFIG_EFI_VARIABLES_PRESEED`` is enabled, and gets embedded into the
+U-Boot image so the keys are enrolled from first boot.
+
+Step 4: Sign the EFI images that will be booted
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Every EFI PE/COFF executable that U-Boot will load directly (bootloader
+stub, GRUB, EFI stub kernel or UKI, etc.) must be signed with the ``db`` key
+so that it validates against the enrolled signature database. Using
+``sbsign`` (from ``sbsigntool``), mount the EFI System Partition image,
+sign the executables, and replace the originals::
+
+    mkdir -p efimountedbin
+    sudo mount -o loop efi.bin efimountedbin
+
+    cp efimountedbin/EFI/BOOT/bootaa64.efi ./bootaa64.efi
+    # Copy the EFI-stub kernel or UKI only if it is directly loaded as an EFI executable
+    cp efimountedbin/EFI/Linux/<linux-image>.efi ./<linux-image>.efi
+
+    sbsign --key db.key --cert db.crt --output bootaa64.efi.signed bootaa64.efi
+    sbsign --key db.key --cert db.crt --output <linux-image>.efi.signed <linux-image>.efi
+
+    sudo cp bootaa64.efi.signed efimountedbin/EFI/BOOT/bootaa64.efi
+    sudo cp <linux-image>.efi.signed efimountedbin/EFI/Linux/<linux-image>.efi
+
+    sync && sudo umount efimountedbin
+
+.. note::
+   ``<linux-image>.efi`` refers to the EFI-stub kernel image name used on
+   the target. Replace it with the actual kernel/UKI file name being
+   signed.
+
+Step 5: Build U-Boot with Secure Boot enabled
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+With the configuration above merged into ``.config``, build U-Boot as
+usual::
+
+    make CROSS_COMPILE=<toolchain-prefix> -j$(nproc)
+
+Using Secure Boot
+------------------
+Once U-Boot boots with the preseeded PK/KEK/db enrolled:
+
+- Only EFI images signed with a key present in ``db`` (and not present in
+  ``dbx``) will be allowed to execute via the ``bootefi``/``bootmgr``
+  commands.
+- Unsigned images, or images signed by a key that is not enrolled, will be
+  rejected, and U-Boot will print ``Image not authenticated`` on the
+  console.
+- ``dbx`` can be updated (via a properly signed authenticated variable
+  update, following the same process as Steps 1-3 above) to revoke a
+  previously trusted signing key, for example if a signing key is
+  compromised.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 6d7ca6b9aec..948cee9a2e4 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -16,6 +16,7 @@ Use U-Boot
    cmdline
    semihosting
    measured_boot
+   efi_secureboot
    upl
 
 Shell commands
-- 
2.34.1

