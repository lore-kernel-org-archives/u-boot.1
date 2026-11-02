Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F9606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zrLtBKv6;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JXkxBv/z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZN+JQFob
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A6F360681;
	Mon,  2 Nov 2026 05:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZP0KJgODWiZ; Mon,  2 Nov 2026 05:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0C51606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793598764;
	b=CM7ify4hxYzQ4rr9L+6F+C8bkSDbko486i4POw+/RaNKIM2X1cvpSwfRLPS9n4LZTy7k
	 yvPG8N+ftEosW0koTpDM2W0ChhptWShsaEwZZCOAiIdrprrXRdARN/v7i058qV6aJdzV0
	 uT8A8Mv/M8HCpp4NWMXeoK7mdYcx/Z9bZuBwJdWhiLddVeh1GKZyEepIjS6K+9IZq4z1n
	 o5t/YMD76tG2WhbGfXukg7+TU4bpwfGxoZuvTHwU4nWTuiSOkgbqZfR9exbAdLEScwyht
	 5L7a/DGUDYipgQ1rloICS2FjG0P7X7dILqjg0tHZlYrf0VLMkBotEsSaboRUkZ8mxZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793598764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	b=Qms1lbygEw7Wzbkb1LycItezAQMDskMm6gYZwr2XhzAQyv8MfEHANIGYICpAm7RW55yD
	 XSPG8gzOwkIBkbfpa+dVA70ZojXgqIfXbPSihZ9rdXqql46APLIJi7v6d6J9LRijB9mSs
	 fzC0tEBhJDmVZOaNGsrXcOdszdwyQto9FXSRS74ydn3p28iFELjx8Ek37O/zqkM9I9yFV
	 CDWiDOZ8XjrMerMc4ib2D7b7UgqlDAwQjAyRIjBajEZR9/ZICULNslXufD5FGTrpyVTwD
	 zW3ydEAUVd2tOTPnkv7UzITDecKlyYWhyqP1/0+j2du20cjTKvNCOKiXrLa84w7cLCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793598764;
	bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zrLtBKv6RRQ/3JqcRfXo06YdFqu5hy6FTObghKQK1roJ4sNMqOknE5o2HoLYi29wB
	 8oagZ773kL7q5qfDqdtBVtlQ7CDDbpJI0x01MvFrrss1ulLq2pbkup1FNfVAeZyY2f
	 ieMHY3aQ+C5DCcsAtoG6R2ZNiPGMwV34zRAyeLE5nj1QcV+mxP/Zaf/C6r/ctz9W+c
	 eD3tCZYWMBIn2B8uKmFieWqqbcP2tq7YFNRlJXOSn+UyzmTB5F0VMT24UGVWu7pV6w
	 FxwX3GeNGHn6B30lrZpzDc+E/eYR/LuapeDk2EQXNtRdkTJZPvUq/HMLu1mYQN6DGW
	 mz+EJWV2SNMNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0C51606B6;
	Mon,  2 Nov 2026 05:52:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D14EB4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6FF3406EB
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x87U08AK_XxY for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 05:52:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D3879406C2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793598761;
 b=VOlRfv2kCogne6Fx+CU+e8H5YN6SubpB7EjNctthgjlMqH0j9vITqVUT3IJHtXVOf6yq
 55LOzi08FqNCQRw0WyLSnq+Whrl2epRza9K+ftd0uGz4RI4KOVi5NsNuPT94g+VG+Z/AI
 6wsKNhmjYP4mXr3G1RGok+6cWGbyfgmG1ZJ+SYTh8vtyIU7h1skyBWbKC7q313zeBKJFr
 dtBCT86LC/FZwYc5WlMn1QnXwc/DjyV5Dj6LYQqzmoJpmzYrz5LiVpdxACSXHKzHpZaDg
 vdLEpAXliOWWLlHlDkbcjfVEWJ3eFIzWLZP5rCFUPjDQ09XeJiZtxDH75b9hltyclzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793598761;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=eLBXGbF4AL6er8gvRagWcvYAhyB3pa80M0ZSCxMsz9YM9HP+jSbUfd/ed7+59e1A7E0G
 kjETpFQdciA0lfy3Rp4nOQy+myScjSTekOydF6KZG+qzH7Gni/G7GqOCvcIC88WVMn4tI
 CDaKcCsWO0l28agq4EIQ0ecDFUUiapXaj9cckl89/OUd6aNkfxqohcMn4MTqH2rJ25OWM
 hlXjwPQ9/T8NepdTGRUBVx4U9vhnixlQdRJ/4Q+4fteCRy7NTcUEeScXMO+RKp0ernN0m
 jPsoSRMQ7B9odzhvrE+8Vls1s4AgOJ0r1l7q4qo2AW2mTd/wFCnafixywcHR+ckjbhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="JXkxBv/z"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZN+JQFob; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=JXkxBv/z; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZN+JQFob
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3879406C2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 05:52:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24w5Vb1262130
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 05:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=; b=JXkxBv/zh5VVFdCz
 O+7WJ8CT8SrqIAu3anOrUeBKSurG6R3+JE8RVMZ/dryJhGRJ33TY3q2AfUdOAZMu
 4As7GtjLGN+Ms3hxaHdNc0usJlnOCehNlEB//P6UpX0pwof1fPXfQfRgcpJEN8j5
 iijarYAxsQOH+wk88IEuNrs75ERCJhNIbpS90EuYlOfWNFjWA1cmVNu3FHrUEjl6
 4yLdFgNG7zKPfOtWJ5TWOik+/49KaEK7h5aLSvdtrgJ1qxx0OOxupaLsj0y8vnvk
 ySDXQ7ZAtnjj+CMRLgjV7WthXhPJ6x0lWZBMMNH8ZlvMCl9BTHLLKm1J8xiHoEnF
 OoyszQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4g4y1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 05:52:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so5288723eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793598760; x=1794203560;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=ZN+JQFobfL7cVwQx+X+Q/s9uNeMs1qk//0yWZYflcMxUo6WORZDufLdKiOr1HXolSG
 5umnlN+F8o6iLDC6SSJ+uvuWOqGmZ6HdMDnbVJJNH3qWJ2BqdZAdoAhAeoL53R5YjSkT
 Hk27BLV07C1O07FpIr6Kl/YySOQGD2ANxZyP7Bt1hcXhaxjj5p4BaXBy1A7sp149HpXl
 SG0KgHuCvo2tWbikJO7GRCF31NxEaaOjyaIYfr3WO7cvPG2WoM9Ci1aNhaFWsu98Rcf+
 NyHN5evGb7LXx4QSL5/s2rD+8WKMiSq4Kvj00PNvNe190WjjUWsIAgpLkN3nO4LPezSx
 AQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793598760; x=1794203560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/CxMe3FLd1MlIv2hiMrf+2/PYB4/69CCihs/sm2Jsk=;
 b=TuyJKoFE0ZSiVdr5F4bljNs0O+WXEdEmo9UT7h3e9KAfKALkMd/sCkSvF2yetP5/5y
 sjP6KYJbkQrnXdSXFLhI5DEKEqgi8N1T0ODWqM97aNKBFWxnGS4OltzMq4OtHiaM2AHI
 WNoNzEQnV9zkMIh+Q/cpN32Mm7aooLpqL1xyzI1d9+6LeR1VJVaM8bC8QO5jGk88OFC+
 4toikPXEP/tdNk8GT8Rnq1nyprYR7L5OEKv/U+qvpMwbqM+Y4IygUguzQGvyhUJcoJil
 nObpXv1QIAZuPg/WGebNYOcDiydEFnltPI5cxGrXl6t+QZjzy4F3oRjvubYJ5DmkWl1r
 dlVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHwJ++FNeL4W4ma9lnun3i3Y3umlU5jTCFpP6y+ezyvhNrn/KJSbEgaewj7RPJNaNpJ2p7sr4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/KNX67sK9QCo6M2jI2H46Lhwqzoh6qzF/CsYd8+FVN0jZNATZG
 +uAc9UM5b52hNfkDSHZLqS3hVy7WjaLayXv5tz8NnBSmswIcMIi7ruOWaTpwoLzwH7X0GVNsuZS
 Q5SFCfxIYIFOFoDpmVfeKv46ZcZZtjKkAvuc5pX4QNy4gRaCpEoUOMKuvmYmheP6rRP+Cx58edo
 EvfLA=
X-Gm-Gg: AYBFou3cR50H/RD8n4d9Fk2n4nu7YMw3MzpLpUhhXvXcUYc9I3tdvqRwyP3PUwRYWlD
 k/WCwshIlTLfBX2aCMIBliPrvwMtdqUorBlMLlTGunZuL2kXGrGQ79hyZaeMcFP9rAilVtHwJQe
 l8zmfOYjvZWiWhqH8gQMF2OEOWPgNNM/GNZz7BEQypkTq+jR8Iofq82E3Q5gqstyfJxTvvPT00z
 EadzhyEDm4Y5WHLs/05vX8yL+PgSqu0Kha+sMHFwf62zK7SCj0wtjpNrwBeRM2DgmKZ+gPznnGH
 UZ/Yq+D4FdBC3GXDGex/20Ka5ZeTsKH60H8uZ4JKvs60piBZ08OCbZawTF2VZ49hSJi30PjiBHn
 MD44izEkWeQzLJbKitCBiEe4UD2dbodfJJ6P96rInGl+QANPBkauNKfIRs9kXHqOXfKtFMYJROC
 tvHSvaas7QcDZLgRR4VY0qCCh7HlFtkGO3u0efYuXetPyfAMo9AcMbpd+YqUtaRlfC+iLfUScZU
 O7sCw==
X-Received: by 2002:a05:7301:f8c:b0:36a:18a:e02f with SMTP id
 5a478bee46e88-36a423c5c8cmr13465147eec.28.1793598759399; 
 Sun, 01 Nov 2026 21:52:39 -0800 (PST)
X-Received: by 2002:a05:7301:f8c:b0:36a:18a:e02f with SMTP id
 5a478bee46e88-36a423c5c8cmr13465116eec.28.1793598758839; 
 Sun, 01 Nov 2026 21:52:38 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm35456366eec.7.2026.11.01.21.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 21:52:38 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 11:22:27 +0530
Subject: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and debug
 fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
In-Reply-To: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Ay8pC6A1vV8mlR9rJWCi0QjR8wZI-sJk
X-Proofpoint-GUID: Ay8pC6A1vV8mlR9rJWCi0QjR8wZI-sJk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX/lFxka6WEmX3
 CQv6uKPusZrg8il9PXjL/3zrK0w3WZ6QkIdr7Y/6IwQVBtiQFEI+m7UyYKDWNZduuOxr/zHMFTg
 JsD1YAkd7WSlp78hvzKcL3u7ROg9LSg=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae82528 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=unZPNS3TcTlehdJ43tMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyMyBTYWx0ZWRfX5X05juyiNz3A
 K9nG97LMrpeV5TkyLLBkc6sbAUY5Y506IROFRjT7ZLblboF3qaH2KXnxbUQtEmD9fmbkgD974vi
 PyNM/eFNvZd2nheFWXgAe3+Wf0afelibGXCEYvJiCdTvdh96pOdDwO9+QOVGHp8wirF/w6QJrxN
 Loc3rYJyV4C5aohuS4ClZJ1qxZQyS0UN97CVRLYXo53DfSZdgLcoIqnANutL+qIX5/cfY2HBUs1
 Acqqvb4z1lmAy6sowrHN0pWqjXLXAUIAWqNDecFxMg7l1dEKzzCjtHUo1rq3aEOFhXpJJ+J3dqV
 K2ectdmz+Zs+D1WCl8Ss4orJqPBKXghD4OxtKwcwt9UOp2z05Whcd9NQgHXRuyDz+5PrGbKWPab
 iRtnFZ6iPH6hDCXumFB3FXcFZPwEwMGknRv0Z8LgptxXp+sTm0+IBfOTPBXKRA/TyZ4KKhyTCzZ
 clr1kpdxFOoz6JHSwXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020023
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

Add a defconfig for running on sm8550 as the first stage bootloader and
associated debug config fragment.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..40f7c857007
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,16 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCM6490 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xa7000000
+CONFIG_REMAKE_ELF=y
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_QCOM_GENERATE_MBN=y

-- 
2.34.1

