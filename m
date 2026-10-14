Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB992CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 17:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ABD240790;
	Wed, 14 Oct 2026 17:00:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KhD89qmX5lb9; Wed, 14 Oct 2026 17:00:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA49E407B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791997255;
	b=RrSYJQzLUvkmdvwPMeVzYO8D59/CTlgcHf/wmq5Fq8jjQ3DQOWsjMwtvEZ5E/B/nBquN
	 gA+2XpzYqY+ctyF6FG6aTbCewkOYV3/D04eLGqPE1hIcdziUpMhvyMRR3ZXkiOK/p5POP
	 HIfi1dA5z59dlmMSVo41mfH4TvGWT7bcypgj1w1Ny0IH2GKGuCj/hkgx2ZcWLKZda7vP1
	 Es+GvQfKvEF3wCn1hu7ozAMHmpoZH89vFYp1UsJAWafJSLZpn3jtPVeA4tF+P3DJOoAWs
	 xuwlGcnKdSJ7HWotgDw6SF57T5rfec7UCfES+v/UD3Pw5Bl96lSEgmdkIQ576xWeuYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791997255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=;
	b=rqeZq+oipCkmOHH12G5kgdgESfj9Zejpr2JF6mIYDiZIRAEKZur3XNXQrSjfn8L9SM8D
	 JjLP43bwa93L38r6AWXRdGGww7wdYvATIaBpEQkqqwtOUXEdlsM6MWYawxGsPD1GqMspD
	 sGuxI63qKKahAQM8I/pSFtTjaicq0WdiJXQG5BWa69kFNW900d+pybhPgpu9S/LHPvPs2
	 yKmO95QIHiDnj8vc4ZU2e9GBpEk0tl01P9F06lPMckW/KXqaUmPHpkok2ht73+sTY/+/0
	 pAmA9paQ9ENFUvPW1D/KGKoaxzvyLFCb8PI3slYByDELDOxdUdWs27rK0TtGS4VQCkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791997255;
	bh=GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdpAamQnApEtr8ErpnCQefdwo3rIn9gat9/WrYRaxx4BwLc/mDvAF8gtwXND5CFxs
	 OzJcHzPNBk62QdzAmhSJjmEZP5zHUj4ZoYMfz2ro90m7mWR+ze5SPg3A4+zDnEYTGe
	 xYbcO7ICzpMnEM8XJdMYJ9D0T2seDXSqqlmvV74lRZqWwayqFsnlQoRT7sBHkSPG+V
	 RWE96pBYiZRTbYP9T98nRDV0uojCcIRxMJpVoH9UEXfz4UIQh2rACSuLlkDw5wZK9l
	 cP5Bzu1APQnzeosUony9e2FwCLSd/xH1q6SEG4NxshwvF2RBxI1aJCMkcFxEox0UrY
	 mHhEPImhQbbLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA49E407B2;
	Wed, 14 Oct 2026 17:00:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A23C62AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88CC9607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZDuqSamlu27A for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 17:00:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E327607CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791997251;
 b=DEhfv1MAKxTHEIrsWGeIVLv0J91EuC79qF9qHf4drEWzcPbiViFQJwF0deM/IaR/Vtom
 /SF1O3B2dOvkAX/v6wHipxFpWbeD6AjE5jtzS/QceBy6MxASrIco9VhUL5lhx5andQUFq
 l/8QiABOOnSa1sCkYx3K02vBhFUt7MeHH/1Gu+SbwU6Cjo5W2Jm8ZARAe1OMe63zgsyjc
 G5lieY2dyMaNwMNcEt0ae/zdX8AFyRE7X2cU3T7AHA5NvkAvoHZkUXoihTE+j7OYrLUJt
 huoa+ngmaU8zR64NB0ctD2OhhITo6KK0bVGJErWDw58f4Xj4ANE7pHD4ngHSogfOxQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791997251;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=;
 b=DQODvwSPy6wSZrfMDEoxiEPAKxukyThpyU5P6vtoe+gCopFjvwkPX1T3Qo9Q8GPVCFks
 QAsurtqDqZBjPBKKcg8HvK2tqmiQxAY73Q5RQmk5HSixiOQqZtbEYhUG4TQDKZjB5l7Vh
 cHpGj5sB//LxqytH3V9l7HukUdfcs2QMi+7+BIX6fzlgX7drdnjPqvhUMFqgHbmPbmQIU
 IxrGM5COthGykvaiTjvk9Zgv29ICJztYE0k9QHipghvX4D0ej2JoFf/Bnb9tdNjrKvIv3
 2OxaXiWCRm8ATRYnBJSj2HSTD6qUHtyV2pauxQBgSMX+4vmGDPbNkhmwif4YfQ7NQ/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HVuiUC1S; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cqoLdDDQ; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HVuiUC1S; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cqoLdDDQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E327607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:00:49 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJKa3642822
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=; b=HVuiUC1SaHpn2fxS
 koeNoLnlj0XpqMk3C9QGr8E7nwCa67VAH3LJhtbanbDWecg1fSqxtY2zde8To0vU
 7yG/WX2tiRciJemGr3jYzo0SaAVDPyZ+xS2FuQ+oimWENfgSx/6cEeZh+qTANCEw
 KJZHyIhg03ceIxbwFKdLjfA7vIl1RGGYX0Dr3FLbrEkpXa20RaERrPS9clYj0wD4
 9PKM0yOBUsf3on+h//wwCe6x/JLaVnqWTlgI/R9t2vmOmnUf3h/Q6E8tb441Nyz1
 b/ITh2vsbWQ3saUPTI6eTUcXZjAq1oPAbhVXXzG2G94KhoexzdDE03Rmno3ga7g+
 5lHHmQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470amcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:00:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so12079233eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997248; x=1792602048;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=;
 b=cqoLdDDQ4AaHeF4asUck1kX5CBOkY6Nh8K5dJdj+61vzg7lYmu21PuBoaYhiTUCufr
 f+7Vo6gmnbEozMAjuEAYQ/UI3Ubx6+dmY4TdKfEz1PtLezmcr6xtGoGgGAs664WMFOP8
 hQrKEW3uPt+nJbuuWFyd7hahtwpol2Kbleoy4sVyEI/aQOBx1MkBXonQKcNhc0rN6shU
 NCS8kOtirXr42zzGJPEL4otP7dfP7hNuM6lK8lKeP5foYQ8GO1tbGp7XmMy+HXv1OHYn
 9DbooGEJMAWIBBiOiwwCSaun3R1N3wVOL1UK3Xln/oB3T2Yp7S+CJb45hTGHv6mwF3CV
 X5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997248; x=1792602048;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GAA7djzA2JluB9M+fKUdPHkbfkBT9sjGNIMojgCNzFM=;
 b=teEixUB1fU3kwQYmtfhXPYpsjILUcrU3Qg5K1xM8uEU0men0pmdXgXhmguV40cA1mJ
 Jh+NA+sNNXFXZPHOZj4PGBUzn2V1qY9eUpDiE/lrI8AhPY9rCSxDl5Wqm6P44YKdElge
 jaEuBPQ7MgiiE0MHPGXhZkzspqMjVlsGwUR4hVzsdP97dPzEWIIwBDSggtq4IfkM4GFx
 Ez62dlNeI5qGcccBv1mwp2a9BXpah4ffutjVaQ1kHYrzhyW3s+Hzr41PoECiSyweIHuS
 nMFztkahLOhHGY+ovr7jkGsydB9NTf7KCDZsv4si/TcCd9yfs0AXd5fRs6IfxdJTSmjN
 f6Mw==
X-Gm-Message-State: AFq9FYL/IuD+OR9nuj4QTcGfHQaGsq0L5L361UcPLhbZPRBkXq8fG1Np
 N8ykt8GjUXsgk/6r1fQBhP8OZ9iMm6yrbh7RvE3HSecEV3/VgasslYZS4f/4bvkXQNdFQeK3MVI
 g43FhySG/1jUsojC6TYKNBHYaXpni4LXKuOHBHCR4wd0hm1yC//CZM5NH3mQnlmFB6guUxGI=
X-Gm-Gg: AYBFou0Oow262LHG4t1iLOEjXEEozlAGRdm3QbEXYbfLlNQPFKaz/qsgG+qVfe+S0Sd
 9qM8ohcG4I1e2ZcIDkfm66cJVhzH+kyYDN8D6noAVfy6SpC0kFST1IH0/0X61UHgAb5cOCA8H9R
 pxF1QIJQ+EBlzGql3ftmKQ6X1j6hh0uSG40kCbqjmfU33DEC5nCfJ8r2twGd17JVmscD08yzgUp
 aFPzdFqR6nqTyPRhHjgWEc8rXQ/WYxkrWSkM81fYN1Jr+hHre2RxbVjMQPFPYYUCL+aDxyiK8Ji
 oIdhL+UKCPdZYcnEDpkHeEZvGhp215SUb8LMMcsHYEIh+JLgNRq1ipafVYMS8PYCLpv30PGMC6F
 xvNuurMdo05lmcnyfAbJ6VvF9daWclhHGyGhz
X-Received: by 2002:a05:7022:3a86:b0:151:2e62:fe8a with SMTP id
 a92af1059eb24-16a611bf1dbmr23242154c88.40.1791997246664; 
 Wed, 14 Oct 2026 10:00:46 -0700 (PDT)
X-Received: by 2002:a05:7022:3a86:b0:151:2e62:fe8a with SMTP id
 a92af1059eb24-16a611bf1dbmr23241554c88.40.1791997237592; 
 Wed, 14 Oct 2026 10:00:37 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.204.175])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1746482c978sm28274742c88.13.2026.10.14.10.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 10:00:25 -0700 (PDT)
Message-ID: <53ef99dc-cfbd-4d76-9a3f-3dde5ac5d88a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 22:30:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] doc: qualcomm: Add snagboot mode documentation
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261013-snagboot-v7-0-fc296a32836a@oss.qualcomm.com>
 <20261013-snagboot-v7-8-fc296a32836a@oss.qualcomm.com>
 <CAPzfCAb8nVn0XSufjg+zZqp3j6ueWMXJDXZu46KxJqNLzB_GmA@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAPzfCAb8nVn0XSufjg+zZqp3j6ueWMXJDXZu46KxJqNLzB_GmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX9lkfLMf0ZAc2
 8VV9S856R4gUVUOPFILQb2z+ZxiRO5xAQ2Gazd/DO+HaHEtJ4LWOu2fcY0Pe1h2jLBur/myTcpv
 flGTXqlQmyKBlsDkkHsnlMTdI3reO0tYXUg+gw5lY7RLV/RIx+Z/7ps0wNQ3KGR6DuzvfyYNVGZ
 Kpb6npCnZNRMbfUxtG80offsIOeu4LcGA2jFzob5SmxtzZsSoQNm3yy+5Y/phZzYNPYJi+xyalk
 92zB1dpRZQoJBV7VT1M5xcXSHDxEmi/XLzUYpCvRL3/rrBGh9ow1tpoLwIAVv/paR2+DGMzecek
 n7/Aug57rq8fFsC3w48sdAd7EOKLKCZEFPQuJk4nO1fwDJMuxbgTSRZo2M+rpW2xZRKFZudyL7s
 hqHJPYu1hnS+2VGLg+ZJe03rl2kLJGbZTl6UBH7MD2sOSftwsqF0J4D/uKNXCwvap5dNGC9Kn3k
 4Cd5PDO+r7uH1BmQ7yA==
X-Proofpoint-GUID: f7ZculgmOA9c2NR08GWfU8trhAT4RP3p
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfb540 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=W16dESUZREjBzS9ijiA/Gw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=cSziVDP4AAAA:20 a=EUspDBNiAAAA:8 a=1N6bBq8Zmelz02OXVmYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: f7ZculgmOA9c2NR08GWfU8trhAT4RP3p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX68h7FRx+Uk9m
 uLJkpBnyUy5xgP4gVRwk80vMMfmBAqedA5S0i89KRz5zfw/LkQfuqh2hzE/nRp2T7OkkgOFt8q4
 M1UoWTv8ti7byqggzw52AbLPTGKiyxs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

Hi Igor,

On 10/13/2026 6:37 PM, Igor Opaniuk wrote:
> Hi Balaji,
>
> On Tue, Oct 13, 2026 at 3:54 AM Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Add documentation for snagboot mode support on Qualcomm platforms.
>> This covers build steps to compile U-Boot for Snagboot mode for
>> Lemans-EVK along with the architecture, execution flow, and Snagboot
>> enablement requirements.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v7:
>> - Rebased on top of latest file
>>
>> Changes in v5:
>> - Added build steps for U-Boot in Snagboot mode
>>
>> Changes in v4:
>> - Newly added in v4
>> ---
>>   doc/board/qualcomm/index.rst    |   1 +
>>   doc/board/qualcomm/snagboot.rst | 224 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 225 insertions(+)
>>
>> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
>> index 56b8d894c2a..b8bc37bb384 100644
>> --- a/doc/board/qualcomm/index.rst
>> +++ b/doc/board/qualcomm/index.rst
>> @@ -17,3 +17,4 @@ Qualcomm
>>      rdp
>>      signing
>>      spl
>> +   snagboot
>> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
>> new file mode 100644
>> index 00000000000..0cbde61253d
>> --- /dev/null
>> +++ b/doc/board/qualcomm/snagboot.rst
>> @@ -0,0 +1,224 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Snagboot Mode for Qualcomm Platforms
>> +=====================================
>> +
>> +Overview
>> +--------
>> +
>> +Snagboot is an open-source, scriptable flashing framework that provides
>> +an alternative to the proprietary Firehose protocol for device
> a bit off-topic and just a note that this should change soon: there is
> an ongoing effort
> to make the Firehose spec open and community-driven, and eventually to upstream
> support for the protocol in both U-Boot and EDK2.
> On the host side, QDL [1] is already a completely open-source tool
> that implements almost
> all Firehose features. I currently work on and maintain it.
Good to know about the Firehose efforts.
>
> Also my two cents here: I personally find fastboot a much weaker flashing
> protocol than Firehose. For example, it lacks UFS provisioning,
> device/LUN selection and
> storage identity, whole-device erase, raw sector writes, on-device
> digests, validated image
> programming, and device control (e.g. rebooting back to EDL). That
> said, I agree that it
> does its job and is more widely adopted than other protocols.
>
> [1] https://github.com/linux-msm/qdl

Yes, fastboot has its limitations. Snagboot mode is an extra option for 
users who already use it in other SoCs and want the same flow in 
Qualcomm boards.

Regards,

Balaji

>
>> +provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>> +Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>> +and execute bootloaders. However, instead of using the proprietary
>> +Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>> +standard fastboot protocol for device flashing.
>> +
>> +The framework consists of three modular components:
>> +
>> +* **snagrecover**: Downloads XBL/QCLib to initialize DDR and load U-Boot into RAM
>> +* **snagflash**: Communicates with U-Boot over USB using fastboot to flash system images
>> +* **snagfactory**: Orchestrates parallel factory flashing tasks
>> +
>> +Why Snagboot?
>> +-------------
>> +
>> +* EDL + Firehose remains the default and supported factory provisioning flow
>> +* Customers are requesting support for Snagboot, an open, scriptable flashing framework,
>> +  as an alternative option
>> +* Snagboot reuses Qualcomm recovery primitives and standard flashing protocols,
>> +  minimizing platform disruption
>> +* Provides an open-source alternative to proprietary flashing tools
>> +
>> +Architecture
>> +------------
>> +
>> +Snagboot Execution Flow on Qualcomm SoCs
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The snagboot execution flow consists of two main phases:
>> +
>> +**Phase 1 - snagrecover**:
>> +
>> +1. ROM code enters recovery mode (EDL)
>> +2. Snagrecover uses Sahara protocol to download XBL/QCLib to internal memory
>> +3. XBL executes and initializes DDR
>> +4. Snagrecover downloads U-Boot into DDR
>> +5. Control transfers to U-Boot
>> +
>> +**Phase 2 - snagflash**:
>> +
>> +1. U-Boot runs in DDR and enters fastboot mode
>> +2. Snagflash communicates with U-Boot over USB using fastboot protocol
>> +3. System images are flashed to non-volatile memory (UFS, eMMC)
>> +
>> +Boot Environment Considerations
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +In the snagboot execution flow, ROM code in recovery mode loads
>> +snagrecover, which downloads XBL to internal memory. XBL executes
>> +and initializes DDR, then snagrecover downloads U-Boot into DDR and
>> +transfers control to it. At this point, XBL has left the MMU enabled
>> +with its own page tables and has not initialized PSCI firmware or
>> +populated the Command DB. U-Boot must handle this non-standard boot
>> +environment to enter fastboot mode for device flashing.
>> +
>> +This is why several standard U-Boot features must be disabled in snagboot mode.
>> +
>> +Comparison with Traditional EDL+Firehose
>> +-----------------------------------------
>> +
>> +**Standard Device Provisioning Path Using EDL and Firehose**:
>> +
>> +* **Emergency Download Mode (EDL)**:
>> +
>> +  * EDL is a special boot mode built into Qualcomm SoCs Primary Bootloader (PBL) in ROM
>> +  * Triggered via hardware strap, software command, or recovery from boot failure
>> +
>> +* **Sahara Protocol (Stage 1)**:
>> +
>> +  * Host PC uses Sahara protocol to communicate with the SoC's PBL
>> +  * Transfers Device programmer (Firehose) into RAM
>> +
>> +* **Firehose Protocol (Stage 2)**:
>> +
>> +  * Once the Firehose Programmer is running on the device, it establishes a Firehose
>> +    protocol session with the host
>> +  * Host sends XML-based commands to flash firmware images to specific partitions,
>> +    erase or read flash memory and manage partition tables
>> +  * Integrated into tools like QFIL and PCAT
>> +
>> +**Snagboot Alternative**:
>> +
>> +Instead of loading a proprietary Firehose programmer, Snagboot loads U-Boot into DDR
>> +and uses the standard, open-source fastboot protocol for flashing operations.
>> +
>> +Supported Platforms
>> +-------------------
>> +
>> +Currently supported platforms:
>> +
>> +* **Lemans-EVK **: Initial platform with snagboot support
>> +
>> +Additional platforms can be enabled by following the board enablement guide below.
>> +
>> +Board Enablement
>> +----------------
>> +
>> +To enable snagboot mode on a new platform, follow these steps:
>> +
>> +Using the Config Fragment
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +A reusable config fragment is provided at ``configs/qcom-snagboot.config`` that contains
>> +all common snagboot settings. Include it in your platform-specific defconfig::
>> +
>> +    # Configuration for building U-Boot for snagboot/recovery mode
>> +    # on <Your Platform> boards.
>> +    #
>> +    # For normal production boot, use <platform>_defconfig instead.
>> +
>> +    #include "qcom_defconfig"
>> +    #include "qcom-snagboot.config"
>> +
>> +    # Platform-specific settings for <Your Platform>
>> +
>> +    # Address where U-Boot will be loaded
>> +    CONFIG_TEXT_BASE=0x1c100000
>> +    CONFIG_REMAKE_ELF=y
>> +    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
>> +    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
>> +
>> +    # Timer frequency for your platform
>> +    CONFIG_COUNTER_FREQUENCY=19200000
>> +
>> +Enabling ``CONFIG_QCOM_SNAGBOOT_MODE`` (via the fragment) automatically selects:
>> +
>> +* ``CONFIG_QCOM_BOOT0_SNAGBOOT_MODE``: Early boot initialization
>> +* ``CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK``: Enable boot0 hooks
>> +* ``CONFIG_SKIP_RELOCATE``: Skip relocation (U-Boot runs from load address)
>> +* ``CONFIG_ENV_IS_NOWHERE``: Ensure recovery works even with corrupted environment
>> +  storage, since a recovery mechanism should not load a potentially broken or
>> +  untrusted environment from the board
>> +
>> +It also enforces the following at the Kconfig level via ``depends on !X``, so these
>> +configs cannot be enabled together with snagboot mode:
>> +
>> +* ``CONFIG_PSCI_RESET``: Not available in Snagboot mode (XBL doesn't initialize PSCI firmware)
>> +* ``CONFIG_IOMMU``: Not initialized by XBL in Snagboot mode
>> +* ``CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR``: Previous bootloader context is not preserved
>> +  in snagboot mode
>> +* ``CONFIG_ENV_IS_IN_SCSI``: Not available in Snagboot mode
>> +
>> +``CONFIG_QCOM_SNAGBOOT_MODE`` also requires ``CONFIG_COUNTER_FREQUENCY`` and
>> +``CONFIG_TEXT_BASE`` to be set to a non-zero value.
>> +
>> +You still need to set the following platform-specific values in your defconfig:
>> +
>> +* ``CONFIG_COUNTER_FREQUENCY``: Set to your platform's timer frequency (e.g., 19200000 for Lemans)
>> +* ``CONFIG_TEXT_BASE``: Set to the address where XBL will load U-Boot (e.g., 0x1c100000 for Lemans)
>> +* ``CONFIG_FASTBOOT_BUF_ADDR``: Set fastboot buffer address for your platform
>> +
>> +Example: Lemans-EVK
>> +^^^^^^^^^^^^^^^^^^^
>> +
>> +See ``configs/qcom_lemans_snagboot_defconfig`` for a complete example of a
>> +platform-specific snagboot defconfig.
>> +
>> +Building U-Boot for Snagboot
>> +-----------------------------
>> +
>> +Build Steps
>> +^^^^^^^^^^^
>> +
>> +First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
>> +the Lemans EVK platform::
>> +
>> +    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
>> +    $ make O=.output qcom_lemans_snagboot_defconfig
>> +    $ make -j8 O=.output
>> +
>> +Expected result: the build completes without errors and ``u-boot.elf`` is
>> +available in the ``.output`` directory.
>> +
>> +Signing Prerequisites
>> +^^^^^^^^^^^^^^^^^^^^^
>> +
>> +* ``u-boot.elf`` (generated from build, located in ``.output/``)
>> +* ``swiv_build_utility.py`` — download from:
>> +  https://github.com/qualcomm-linux/boot-firmware-ci/blob/main/tools/swiv_build_utility.py
>> +* ``qtestsign`` — clone from ``msm8916-mainline/qtestsign``::
>> +
>> +    git clone https://github.com/msm8916-mainline/qtestsign
>> +
>> +Step 1: Generate SWIV ELF
>> +""""""""""""""""""""""""""
>> +
>> +Add the SWIV segment required for TZ-based signing::
>> +
>> +    python3 swiv_build_utility.py \
>> +     .output/u-boot-swiv.elf \
>> +     .output/u-boot.elf \
>> +     lemans
>> +
>> +Output::
>> +
>> +    .output/u-boot-swiv.elf
>> +
>> +Step 2: Sign Image Using Qtestsign
>> +""""""""""""""""""""""""""""""""""
>> +
>> +Sign the SWIV-enabled ELF using qtestsign (test-key signing)::
>> +
>> +    <path_to_qtestsign>/qtestsign -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
>> +
>> +Output::
>> +
>> +    .output/u-boot.mbn -> Final Binary to be flashed
>> +
>> +References
>> +----------
>> +
>> +* Snagboot project: https://github.com/bootlin/snagboot
>> +* Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
>> +* Qualcomm EDL mode: See your platform's technical documentation
>>
>> --
>> 2.34.1
>>
