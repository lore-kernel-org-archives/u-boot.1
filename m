Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC87CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7241680D18;
	Mon, 12 Oct 2026 05:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KafKa8bd4CGR; Mon, 12 Oct 2026 05:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ACD3380CEB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783324;
	b=E6vK9yrv61VUx5kMy0qd+cfWhIlO1LP7rBZb0mqfXBh9dSQV/bq0Xs51MADwzYpl4Ufd
	 +kEAP7H0Dd0N1ra6rOjaVZovGcnv5tcnOmECsEZC36B1SgOK7Tqa8e9wLqhYThkJNLgm/
	 bHlozfRUwgRafnS0yCe1BgyWvk/2aRQpcXmynvi8WG47JYoHCpYbfZdNdTGF6LI6nLox5
	 H+DSzid17huzTicd9ZWShmhESVgzZxGB8C/HvY1axkgjCgREEZZVTYatGD97CKssm1Yvp
	 MLFrU3pg8380CFZ3nRQJdwl17jmWQbbAFMwiSZKj6DgHjwvjk3Nao2XdQHeVgxumxLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	b=e9gtYvSixrmESaY5mQ2PBllZbJSJFyssQ0tWi3tQtsU8V53u//9oGnPpq5VwxRfG7Rr4
	 XvXVAXzp9doR8qxeFJgZG2qY81gIKnRCH05Aq2QZUWOKJNw9j1rqvxKPdjBBzc5l9pptB
	 OKcQ5YGbDVo0I00A2amo81CRJYUO4Uc/O0muhngOJ3PeR/NGqsZxA2+d7gBdKSxF6fOAE
	 T08LwvVF9BZjrs8UDcyb8y+Nxav7pw11eFx4K9O61a9Dje2gvmSmFfdV7TiFZR9VSlIRV
	 NLVRtBGAbONxKhIrkN0GF8+NZyE+4gGcqFo+3TELOVWhZx7UyFYpPkujavPBSK9Ulkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783324;
	bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZwyGyVZmjX3hcFtlNcMsCXfPqN2ZmYMOZmNXRAZ+lJHsJ3v8Z7WrkRX6DSWcQgNK
	 d78AwtnXMo0/LZAgajPMhyHn4YQkiXcnES3HIcx3fv+KKPtlrQHLnFM+JgrhBDxKnl
	 smExzOiLol3MUtAdYG211S4f7Zv8v7vvl98oWsutkehTAvsFE500dXJd0jYbUykiJz
	 C5TTwXen7g6/sTd1m/Jlm1XujhC/ZIXCG+CvM2hZskU7Mxn6Ho3y3fxL1yK0gVNiK/
	 UaitwZqUt/EQZfGd1DaZ8X2GcJlHd9nC7HstB0UBgaZdJNgD89vXTm9T/k0pgqbIVF
	 AzWEYhLS21dIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACD3380CEB;
	Mon, 12 Oct 2026 05:35:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3C25D5E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5382400A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJ0WPw1182Aq for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 05:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F0A424002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791783308;
 b=iWzUnJikwx66ijKLC1chDTa2vldofxhF8vB6on/KZBVZhx64NZGK84zjjhhHVYQwVZxO
 MY9wSY84UKCA9s201K7vyT0d+m4KKDsOO5KsbXb9mHfp7XnLUHkN6T+IkB53P9K6XlLnH
 sE7uQI4qeQ9k77HNCc10NhHinM9VKDwae//qiQoBTz03pJJ6peTq9UNsTkly9HxcKzf00
 kVft9qDEbFHE+2FrtYy+63DrSYh5j3uuJa5j1Wv6/w6siHHoGCRSIQYDwq86VPoSp46Mv
 oZeIY+3Xtht35+yz5l+22rRfCiq0e0tM/NAWhBwsWhFX+fPnJmUWKbavUrSyLVtERoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791783308;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=lFkCtH8VpyedpSrvGuFdRtBpzH7TF+BWZtWVOP2IvbTglvDuo2HB/6L2OYfC5IEbC0Kh
 RZJJ+rvoQinY4SNphblFxyRu63rZPXZfppoAoPer3upo+OB/ZhnwF7IoNoW3oNbZiLmpr
 meBKQJnDKkRr19myfh1UHIfJPFKxN+ZI0hpBizIaSRlTU7qqHb9SIiwR03xrlO9u7B8XO
 LBGw3jsGi0+T9sEhIYn55f3HRZCBMZevvOOwN562SYYPmhe6wqZ53mLLZRJ+iKzT8Eb+F
 upyvl6+hcby8HsDJdfbDzRw8OQ4pv+9XwfEzkQ/YRTHax5pdf31qVla5scgJ9nkDiZQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Cx/VSR+N"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NbJPg+Rg; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cx/VSR+N; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NbJPg+Rg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0A424002B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C55rtE1857505
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MKOaeljaoXm
 S4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=; b=Cx/VSR+N8XjoLNn3c5wfqvwviFA
 F6Ws5ngBtlRz9UUvUBiuH10nmZ9xb5Wk3/xOIdI1Ar0U637ZXqcEidxJkpmd1maV
 H8Z68P0wycb0Le//YhGourt2G0D0/fnQrgc/fOOKyBoLu2zYcokQKBjZXX12zJmy
 gKT9jSKP1VS/NtIKbkufs99DnzlZ2PXzsC+SVeZ0clWNOmdMaUVRitrqd/Cml866
 tiEj1tlq52g2ZzazCb4aDBl5Bmby9XdSH8byvU7N6Jw/NSTH6wM4ZV1Syrz5DvqW
 sJ2MRtmkmY+gMO/eYSP37JLQxopfvDRp5u2X3g1a207nKLfP8sSzxqxtePg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxn0ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 05:35:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso1912304eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791783305; x=1792388105;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=NbJPg+Rg64QsTi7A3zVKSj8k4oFbqFlwvF6gaW04lHGa0WrwlgZi4jM0DDhVASzaAY
 xYOAMo+vQt46H8q22nKpHsRsyiwIBdnxzMk+VL5XDg99+CpB7uJJFMd1HrqT3kafmDAn
 +hhiBA8sXq7g63xRqgj2IFVdxT4DrodXI8WSt+ykzV8B5XIjYbbVpcvQjrHsADU/m0z5
 K4Q5j1W/CJ9QPCokpOmZAWUOn6cyYAI1HbFUjUSpIRhVgFPIFyjR1ar6FOv5b1HKs870
 HAqK+Yzi1Lhe33MtLMd0z4JrTf4HeSamKCJT65my8tVfNJYLW0Q1SI7zBGmqCzw7LWPw
 knPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783305; x=1792388105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MKOaeljaoXmS4+6WcNZT1Lk6VCc5zkFiNCOexH8Y4K0=;
 b=sLwtr0dQxiANuG6ovuCECSvb9nkBT5r6d+riU8dnZkiwx0mPy220UAN3lw1vpNLVje
 xnJVQfRfJMixXS1fG984b++IpFE5EqpYsZDH0xKpPReJ9JiIs3DWhZjeioKlKIWK11mO
 qjDufq8g6yminDpdXAEbp5Vy/+PYfTO266wDBWLM/n6MWSm7M2p10dcd1GugdE6f1XR8
 TmfnEbiYrKfMFebk76KDVfFkywGtfbUzFg/m3i/+oxCx8M3DvTiG6670/3lYq6zOyZ17
 eDCyM3sa/d0xC/E5h2iKIYM+disB2qPn1XHXzRUj2A7D6dOpQmwiz+RJayXRmXK6aaYC
 KMJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2QWdBQBpE2MMyHqYnBelenkfJ0MOk0KyQFq/HTb4rwzEcHcOrBZMjCDSwFP70jz5SwvXDZGU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLp8QRK9f1FDkVVil2Mtx3xu1s3QvwQP6h8u+epiPQg+YBx0gde
 DbhouhNeKguHvwun2ejfr1eQoVVyz5LyJkiHS7FeRmAKqm8BQv8JfFeWqu0Hod7lGYkkLEXfp12
 HBRLUUbjxjHhJ9k4IvdMV4HCUFmCZQxUNDPiSHQGc9z8068u8AtOzzzNfzm7x6Pa3p8otLyk=
X-Gm-Gg: AYBFou2UsniV0WrcR9aWX3IpBFG1+eiKotZPU4C1kCYtXLVhc6YBluGefC4cSKJcuKM
 z7L2BZXZZ8nNoCHvGTJtl4Cuuoff3S2dMe5f2vIdxLNpUipBvWfPaHRGlOSQe2YtxqOGV2TaTBu
 UzS53eWouRAK8zWv8o+yT6ZOk6z/3BY+LAS8Ou7dIVnUwx32xqHkzYW/H5SDQae/CsGHGfq0dsH
 VDaVP95Ap0pD1Agr67W2HcaWre6hwE39FlDlsjgLM+X7f1bp+YQ/2E90cdBudNYqpKzrfpvxqAL
 STymN4Qo9oXshmnN6xG0tQxC9YJ9l3jxPgMd9u0jRjSjI8/pWIJgINEaf6TBJ3tq+/kYeE57zFY
 Rt3hyl/pgRmOMsX11WfYokYedXqC/55xjqMu9ScYPuz1in4Eg
X-Received: by 2002:a05:693c:41cb:10b0:351:679e:ba2a with SMTP id
 5a478bee46e88-3537e0065cemr12240007eec.23.1791783305453; 
 Sun, 11 Oct 2026 22:35:05 -0700 (PDT)
X-Received: by 2002:a05:693c:41cb:10b0:351:679e:ba2a with SMTP id
 5a478bee46e88-3537e0065cemr12239958eec.23.1791783304806; 
 Sun, 11 Oct 2026 22:35:04 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm33446935eec.17.2026.10.11.22.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:35:04 -0700 (PDT)
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
Subject: [PATCH v1 08/13] mmc: msm_sdhci: make tuning callbacks optional
Date: Sun, 11 Oct 2026 22:34:47 -0700
Message-Id: <20261012053452.1567885-9-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
References: <20261012053452.1567885-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fgoCS5mIPZ01zG2xCkyWjrFsKs3KXEyY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX/mKdfaxYcEsS
 L9srBS6OMtOZayTgVG5cGwaB/FZMs6tM/GZOlHongVsSj/CM9QDehFqmtTSb2DYWmsDnMN487Jp
 N1x0yetq0ZUk8szhU/dgKzkg2aT5Sl0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAyMiBTYWx0ZWRfX5P/jFn29j4j+
 00upO5CW6EonFXe1GsxgXzAl4QVFCudbVn1SclpOM0fjCXjyUoUZjpZZKf8YZH2H+cwDCLND6HC
 2O1E6HaIbc1rcf7Dwc8+QN7MNVCOOySPEgZEXZODlz9mCQE/NBbAlOVnkiR4WS/ZZ16OzFSqPuH
 OyJl+Bug95AJ6JCHfTpjmtf2OQGNZf4/ltpjZH630E8qVp5ZmnXtK/KhmbFjq7AAz9nyj7SK7WY
 V594k/awzDJ48O7ZKPxneSsbdgb1FO64yNnTCJBGbTzn8/ElEzDvpeiMjRuM6nr3nDTh27gX/ye
 U3H29/sl0HKmt5mJ7QIRV6WHBTfy5gFF4d7QlaPbFbYZ0rkMkTnjoEZnxrLkWIEeCt0TQbeLW1K
 EoNhYbEsmWzgtdHM0EnUG0YXpUIPRpLemjh/HfUAZ/YctQcI4xrD72+Bixk4FFXYCKzN/MMeS2y
 RjuXTDKlYNboa2EGUQw==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acc718a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=ybWPJh-q2Zyr6sHLyusA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: fgoCS5mIPZ01zG2xCkyWjrFsKs3KXEyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
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

Build the tuning implementation and callback only when the
active configuration supports MMC tuning. This lets Shikra
SPL use MSM SDHCI without unused tuning support.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 503ebf0c5ee..40e2ee15801 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -558,6 +558,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	return sdhci_msm_cm_dll_sdc4_calibration(host);
 }
 
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 					   u8 *phase_table,
 					   u8 total_phases)
@@ -711,6 +712,7 @@ retry:
 
 	return rc;
 }
+#endif
 
 /*
  * Configure HC mode selection. Runs from set_control_reg(), which the
@@ -907,7 +909,9 @@ static int msm_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enable)
 struct sdhci_ops msm_sdhci_ops = {
 	.config_dll = &msm_sdhci_config_dll,
 	.set_control_reg = &sdhci_msm_set_control_reg,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = &sdhci_msm_execute_tuning,
+#endif
 };
 
 static int msm_sdc_probe(struct udevice *dev)
-- 
2.34.1

