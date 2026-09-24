Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC1FC98318
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 02:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D8AE81271;
	Fri, 25 Sep 2026 02:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hx1UBykdw7W5; Fri, 25 Sep 2026 02:41:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2F8A281258
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790304098;
	b=gEolB9r5EItwTzebkPXua++N35HEh0z6MQRT+UY7c775+zgLy/OQ23WS+ZS81VjMYtUP
	 IxpRHvRe3io1Bj2IFU0fNiNZB+G6WLPH+hXfg107Ag783jr6k50A0QhUNX/+6iKM57Co3
	 RW5JjlUaf6g5FtYxNB9Dhl7gUjCGkjlLn6zPLNX+jy3ZtWFVZOJs8vKA2KLvL/4udfkex
	 DonJDZTEEUPBW3tc/fZnHOnHMrY9Su5md3exyEs1p8sqcQFgpdnmDHgza3iHNelELYLaC
	 EblQ8aJ72Ob+SdJUjm/EUefWJXFgNnbK0Bh4dTOuiqMg9zEpOTs6JAYeufcnJ5XlFuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790304098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=;
	b=EJ5L3Y78l6trJS4lqZSAONlAbqgi1iQ07kLrxzJPu+I0VVKhBtrF411ZIuNqr1yuMBpz
	 E0SC2dwJAsjYqh+JRLJGPGjEMwObDz/8OXrQH5gRfZ0SDJTz7YbS2RIhtEVXkEuJb0Mcw
	 c7xD8wABgbfHHNBIJaFfTd124DvoyW6vdUXRXW6cKjkFxg2qMns1+nM/sqjXnPd3L65qn
	 tlVykr8S94vFORXShAnhHWTeOKV/SAP1dWlK59J+Ip179fcmJ0aBTSXyBIibalFb4c7u1
	 scAFmcby/60MR4DBGTTL6/EfogPJYD77iQ+QtcAOZX15VivEaDOedrQfuV6XztVgwFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790304098;
	bh=uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U5T1BJFZsOk1OVfiNnLmqMLH3PuzpbOhk2nTICuJtSukHlEljenSaJLrnnaqYgs3h
	 z2/J5Yp2TpDTcJGQDo2eV00YvhLgoDDFDKsxLq8dIigkb1gmrXEmaIxbI69BITTQvI
	 OuhpLszrrUNJJoRT/E0dehrBlCct8v5h4CTjVFwt9PpBqBY8nBWBu3XU9EuFwod1Yu
	 I5jLJyy1mSjnGXKP/GubLYMS35NiURHJv4TB9CKxMrqUEoIXIkdVrU1dqFt0bEkdLX
	 K2FgIo4v/mgK6r/b4PUt9S/s3NrnIwS56R5d/dvtMz3lSyWz86Rcn53vwql53Q/AeZ
	 T9sRZMa/ynjYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8A281258;
	Fri, 25 Sep 2026 02:41:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4C77355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6A254017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Br0N82ng73l for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 23:38:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 005AA40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790293088;
 b=chumiId1W+d7Z1T4OPgJNulSo09SWHUIfSAByCyeyHnMvzz5y2usA3CuUqXqQauukS6c
 MvhtkhGOTYFA5ZosQnDDmE6xj4+AaZ0js8/NbYQs+oSk5xXeyIuW5CZESfKfeGmzoUJfz
 4Q+JJJ6yqXK8/13sNU38wb0VI7kjbH8s5dcCqPlXTfYzLrNc5KPyBXU73kq2dx9a3Mt4K
 aUuYMSfICrUetKkISEgYBGHGpkB6HzUNzaMwRU9ryTIq+/RskipATvMEQw9/yTirdpBep
 yKmu05dSs0ZiLotCfiMZ60Klyhk/Wp5ePRNXY3moLPMaSKFbY9sBNOT5Y0XoCqvYxlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790293088;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=;
 b=A4Sbcgl6b/SAWrva5CcPn4WNdysfETBN11II9G1IBoj/WM9GKXnAAeEvA4zs2Jr+7WA+
 7f2By0sbqkUqnu4I2duZnhtrdbzp/jiKKRAvo2zIFufR2y5PF5oq7MNNNPNjWnvLy5dOG
 ghHgwAQyFiZEo8O+Lqt21gK66m/F7jXhe1Lfk1Dmh4L/t5DO2AQifKlPmmuYUzb7nxHRO
 tjpvM5j0gvwrOwQH4vGNEckkxjhDTSz018RAJWM54LCF4mj+AvVhKP/BVKucKPySr7kGP
 jYgGJuKQLwNcKzS6onaqMLGQKjLVm4NzdwHTVxdtL2NMJhGh6tlYsBuAFL1R2lxxMaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=nSSy735a; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AnJ4Y3zI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nSSy735a; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AnJ4Y3zI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 005AA40079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMOoCx2969294
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=; b=nSSy735a0QO+hIfq
 OkjEwzMZCS/5AqbCz5TV4FFlpgfqMsg6diYm2bGxd7CsTctYzhLQeqWZez1B6deh
 t1FO2H1BIDq8A3xHxJebhw4un/uZhvFCoNOtTDVqoq1ejlKkvbQpOTiEyS1JiX4n
 vM2Ca3t3vYQQJE/Ltn6/YjQgEdZX1lTuROl+rPLpAvn1l0z04yuOXz04jUIkVDlK
 8t+6pi+m/CKzFJFrZnqc+9cW0rUxX27SX/vov3TFL7NoXzDfPAZOdyy/HcTSGu7P
 lYl0k/oYgHRWggediAveAD29jjQNd4xp3ZIfTlm02PFO1pqvYxDZEIZRspv85Ru0
 KOdLDA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1wqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 23:38:06 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-893d2c627b4so5675157b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790293086; x=1790897886;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=;
 b=AnJ4Y3zIkDbC3NJtrsxhFCqn9FdvaECCc5SBrXMbrByHFUQjTXW27nh6+wvQha1Iv5
 chwZNpTrB6qb6Y/7vQXIVfNg8ypPlDG2EIi7DccPgy/q4gRGZjLPdnI2P8ikB89iEZKa
 UywMmwbQS2a6UVwDt++fSb7GvD52ne9Wk3oV4g5qYbgXzEKGsOh/VF5IVHaE88AXrxH/
 egYtW0bhsZ5x/8iQBM4YqwaeGXP02b2KSBZdbmzkK7KuljoGQBjqFpmhkJPYLUzBcl/8
 fDWrPzNU/G8ePrx/QxhDVqr1j2KdLBZVgJNfU7Fx7h6xkJFNlJJqoWJ6V2P8xS+AroqY
 wSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790293086; x=1790897886;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uvRgHiS7WdmQe0hIMPciuiAwFgu6ApZ42ODJLnoVfNI=;
 b=GUzISwxMkfRZS5nJSYKGw5wac0jzJWz59AH0iJNLOLu9CWlEy2IoFYQSO0mfoS51ls
 D8U2COMNermnkfTBJvUfuJVTes3OFIwf8qYH4B8yPr9v28JO3OaYzJoWRs7V3TF7y0f8
 NuG2xuAqiNh451z0brZPHUWGNIlH5gdIiAe6pdanqSEBU4kl6rILcA+zmnot6CngDLCP
 4DXxbHZ8okIZdD3zcD8cPgByHQtIxoiKAUgdJCTmwn9157wlpORz4EHYVx7S19UJkIQm
 sObhVhkvxXToJLJFWpYnxQvrZWMAehnGSRPBLr/cHvqLTWX8zgKqrxXviA/34J6bGtIZ
 V9wA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLpcS9QffnullcUCa6Sf8TyjT2M8hdSGapngNiTwE8f3tBAiyv+6AId5QiYTyWqWCgtDtmG4Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nekVLHxLV9pO99h/4M8dC2DsNplGQzql6nyzMZhh+YXUMqZEHn
 FtOo4wqKOg0kaXZlaX+GpeEg3Pu7wCri2P/dQLABKjT83SKi50T62T3OzYwjWlB/jqTtVFw3pyB
 6+D8H35Mj5cHrpQIFude5PtswIueTMDHxUSbEyK6sypJvTFOCN2er1frDvMYB/SfFKjfbFnU=
X-Gm-Gg: AYBFou1KrquYrlB5MGjpn/s6l28aGD1R4gdVuY6jc3+GufQ2oFSV482PvMapcWIlNos
 bPd2jUIgABiVHsnej2/7E78GJjWoXprB9fQVbL0AKnFMxpmVZ9TjTTTpgVFmERkdPZF556NaY0S
 N9rJ0UXbVxVyeVsSA86AZXpi26RQIRFc+OLHUr9oi99h+KbGV+dFA90i9H5PZy3kicuqR/UV02z
 4T4c3hg09nQgnsG0e98vtZ9CRlqDm+8KdYqG8tGd/Nz4vCIpJ9v6MT4MJI9An4vfTnI8QBrOnre
 WI09bVdtw/WP9qSuHpAdDMNpI37FJTFtcBcO2FJTNORCdO40acf94DnDn9jotK4O0DHEqom7Omj
 iGtrPOzm9wVV26gA0KJHuupLc+nUqMYnYMBTZ4DiczwYoxK6dsgLeRK3sIuWgDBvGhi7paksp
X-Received: by 2002:a05:690c:6e85:b0:8a6:cc47:f423 with SMTP id
 00721157ae682-8a6cc47f68bmr16803017b3.34.1790293086033; 
 Thu, 24 Sep 2026 16:38:06 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:8a6:cc47:f423 with SMTP id
 00721157ae682-8a6cc47f68bmr16802897b3.34.1790293085484; 
 Thu, 24 Sep 2026 16:38:05 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860325fbesm3025817b3.5.2026.09.24.16.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 16:38:04 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 19:38:02 -0400
Subject: [PATCH 1/7] clk: qcom: qcs8300: add SDCC1 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-monaco-ventuno-q-v1-1-290b6a4d10c0@oss.qualcomm.com>
References: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
In-Reply-To: <20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com>
To: Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX5OHLUb77FOLG
 ld+fnUcc2vUOOpuS3rEFkaj2q6EYHtHvVqcY08lH8XaOYsDoatGNbzpYjHZeTGPiGxlUDEfn8om
 nKRbil0hFz49X3fTdolvp/5y0FxCnb4NU9Lu9q1ooivkbCg8sVk/m4kmWYnxHw7wSd5vLVui44H
 a7f15GHLUn1gXbmrVUDpvO13ATSL6qjuV1zU+pHlnR2+xqJkXh8lmReylSto0UNCP5y4AoRrvRD
 nXjkGD8SKwbv4y3IAwde/0NO7IjXPZ6Q+0Sib8CvyGWiMQSJX5PZJglexEO6kYQv4OSjqt7D/Pd
 HYD2kMmqfIPACiNLtdf/tRICSS/x6cVXc5T49zo2cxWjVoQ2Clnbgf7ZeMYa/BzNXb5GFoOmLVH
 07Na5Opuiu9lVbB73JnFtWKvb5L3zcGNOmxksT+p4GeN1c1JxQkcbuwINTjG39/04UMNcDibUqt
 vHuI+ulp4NMZMEguwuw==
X-Proofpoint-GUID: VLywXnmZ945t3fI35jp79MvpCTRrhIih
X-Proofpoint-ORIG-GUID: VLywXnmZ945t3fI35jp79MvpCTRrhIih
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab5b45e cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vxs9k2ctamuecbXxhNUA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX6OJoqqc2I4eM
 GcxiCw/hZ6FMoVMqSwIE9MYu+x1RyQTHtJkagnCmCvgh9faQX2CMzlFYTDJY1OdKk/vy7SZ+w4R
 1/apwrqwpZAkn07kfF2qpCntMEPNzPM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240096
X-Mailman-Approved-At: Fri, 25 Sep 2026 02:41:35 +0000
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

The QCS8300 clock driver has no SDCC1 clocks, so the eMMC controller on
QCS8300 boards fails to probe. Add the SDCC1 AHB and APPS clock gates
and the APPS clock rate, from CXO and GPLL0_EVEN up to 100 MHz.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-qcs8300.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf78..ac5b28ae34 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -16,10 +16,20 @@
 
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define SDCC1_APPS_CLK_CMD_RCGR 0x20014
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	{ }
+};
 
 static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n",
@@ -36,6 +46,11 @@ static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
 				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
 		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
 		return rate;
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -53,6 +68,8 @@ static const struct gate_clk qcs8300_clks[] = {
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x83018, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x830d4, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x83064, BIT(0)),
+	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, BIT(0)),
+	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, BIT(0)),
 };
 
 static int qcs8300_enable(struct clk *clk)

-- 
2.47.3

