Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A9606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qNUbEKIC;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IY6Z8AF9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DGoJC6Wi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E22B40674;
	Sun, 15 Nov 2026 11:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsPgZnaDL-Vh; Sun, 15 Nov 2026 11:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9BD840620
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794741304;
	b=qAIvw7+B/K3rbeRXVdUyK4IQd3LglnRIdEg3Mw4cA9oJk+WmGBnSgbP+ObZi31r9XRCE
	 T/dexQisuSTKvZEqUBSoSCryFxO56Ftkn0u7p32QXs+hXW/M6MxWs/N1uvatwgeXnZWJD
	 20a4xak7dFdJ1MSmn9mPQN5WtU4JALT79PytgbGYAnXIUk/2izNPMGxDAQuj9LaFtPtqR
	 PJi0nHJzkL68X8PVbAXaXJIcl/OK4eRvY7xDlKlks30HiL8wNyxvPtUdR+jTIDHdNali6
	 833/GIRYv1Um+Nl0UhUtr9cb3exlsIC7a/qE6YtNaOCFA6CCDJ6dIbiYs7GriZSeeUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794741304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fn33tiLbRhRkWG1srQiA84F6KYYgUngMBxkukN7KDpg=;
	b=UV4PMKXOmcXD3IvfXH8RHXpvgzxhpx5O9mfk8R4Ob08sAp44BMuJi2gofwfMkXJg9mej
	 oAfw4pD9v9Tn+KFCHvaAWIg8b3eX7CF3+dLwHmu48315az2e8G8ykiaD3+xa8D//+4NEo
	 jt6N65ZZaMgw+DapIB1Gz5lqmhL0tlYrUu6ZwtAIQ68DMHK0wRwkgbx9UgJCVPBhMq9Tv
	 8LJXFaOfdVwZNfJMF3zUBoSrD7HTsmKM2eIQKyNd00RLePsFcWagD1Webkk9jIGTRB9Yf
	 SMICU8U8Jwhiz6d/Kko1ZdgpvcE9DaUbvz8rqtC3rtPaSrH8GJTNTX6bgoTIQQ8vHrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794741304;
	bh=fn33tiLbRhRkWG1srQiA84F6KYYgUngMBxkukN7KDpg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNUbEKICfWQ2fMvqSZPkgT40Y0sXGyG5p7KICAUUwZnajanMEgMuA3h1G5W8Ez/XU
	 T+dn/Tn6ltgm0y7YLKhyAKgzShNOX1alG+1wCP30WPjmzfzl2LnuUxkyn5gv0Kw8lT
	 PfTPJg8m1EeZUvalcivWj7j36T0xxZNIXC+LvfhPlXju3GuqPzQMcY+Rq3DXod6341
	 qPrB8G5cHzlKr1IJTo8F5bUBrU6h7bHJ821GHGU6AqfvtuhnCt88t/rAL5ekqy8NuM
	 houdsx9aBTb7u2c7U4bcanMCYrED8QmwiE0w1FXDqlrgLS8tQTguWvwYkM1pPaGEC3
	 szZf16CntxiLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9BD840620;
	Sun, 15 Nov 2026 11:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C6A2FB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F26BE40068
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIeI20ST1z_g for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98FC540061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=IY6Z8AF9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DGoJC6Wi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98FC540061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:15:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7w3sh535855
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fn33tiLbRhRkWG1srQiA84F6KYYgUngMBxkukN7KDpg=; b=IY6Z8AF9dwTsrZRz
 9teXYXMOycWvcKofQ+Yuq6XDPIHUrSfX4bs4+EPUKxYyx6PDcipBIRQbta2vBCci
 dc8R1rEIMpKPCMKoCRs+VsE3Pef/PD1NqVGI2zE1xtTnsgUsL+f3LhWe/vtwd+cT
 4HT8VV9bwu/vbrxNSMiFsOs4W5wKOYuFEPX70DPSnW8ADzQIwQMGq9HJB3dCACgQ
 fqMgsJMAc3YtQbpU2o2imdB0Rje8n6xlc0na1tGZGFImZUBwpioA/7sb47Srfjsa
 hXh4OwNimqsxRjsPt5mli7uXDN4gH0I6XoeXrKs60enPq0qtJeg7Mb7S3Q4lQq7M
 aMRumA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcase9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:15:00 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b3b45597c7so5621094c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794741300; x=1795346100;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fn33tiLbRhRkWG1srQiA84F6KYYgUngMBxkukN7KDpg=;
 b=DGoJC6Wis59n9AuLdnoomqW/N8PBQDi+j2k2tAbh7JVmStLBPdCvy+gj1TNL8SveiB
 QUr/cN1l2igMY1T0nvCU0ZEmVQEX66OfOjYQPohiVTeWXbjZuHEUrsY6TMtTMGoi4Mkg
 UPEO2qZX7rZlEKkaMeR0h7I37UwDeAvQbmE3XGh6nWYLspc6cXZR2+wfwKArdBVQjEAz
 y2aanl3uGVTj9SDDN8Rdjj60VaSNLw4zUv03Ww1E0ou7Nh0+PwnWfmhD/dAYqcr+VgbX
 beKWPuXWC4bkDYpy/kEGez3RyofWOdZYhidL6NfSLCVRjVnRmAqO90Md2aMNwtUlhYeK
 yeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741300; x=1795346100;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fn33tiLbRhRkWG1srQiA84F6KYYgUngMBxkukN7KDpg=;
 b=FfCz76ppXaQ31FkNG/PmJVNhfAXzrEdip97v1jOC/XX41scJgApGxc7KCXzqSDIAuv
 pXylOywdp5+IeGY7/9Kh/Scnr5cRrTJTH5a71Y5ZLU0um3390vzEY9tWab/SfdH/b3tg
 g18CpXFB+MEKyPxy4er4AKUpzygndHhp4H0Neo6m/TpDd9soptg773sV8TNonLZLf31F
 T51UMlTzQ751vyoOviQTQd7fgQvJi/bNJy4PXD7zcFL2n0vQIQGYafqxqfiT/N7cMODF
 8GjEk3ASA7rAGbmUCKJR0nkK7mU3Gz9uFS6IuriCEAYUpNCsnfXylgYm2DGD5tp+qJuu
 lb9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErETlcNoa/AzGdSy6164Db6PQ7yCR2lXwQWRMi+WqmbL3zME5cdCh6u/w91UkoJ4zyD2lj3GTGo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+MPlKm5rFSTmCXqxDONmOacv3JIGTQMQ5/Jb4cuM5Tg5U3/nWe
 TexWpYqPBp0oS4FkdQwTwwcQJw0xozu8dMBI350lR3xsWcRbGqVJALKt9P7A9Jbn033Y3gqbEGz
 2gG3q6lpyt9Mz5MnRv9LgZupvbhMsjT6SPYxfFRdgojbfcNgAucQCQOFtJ0hueD2HjAK1sKIhbY
 s5pmA=
X-Gm-Gg: AYBFou3TW1AlcQ1k3CTZuYffDaOVmBUYkUv22jCCeqj9o3e0yZkLHz80j/eWLbULaZp
 xo55kmZcpDdzFyUIbcKsI3J6TA2uZP0jUJrasxeNOfpLh0vRXcV/8jYl5q1VACBigJt1Ppphw5w
 mE8iY/j2f/eMxJcdxubqXbFsBwBiT1ELC4457o0F1k+PCjnpb+EJxYiN2tmZ5iuMxAd+W+d6Sii
 3ENZKcc94J4VzB73A+Fmg8etI/BVRB6Duj+svPEmCyVO5bkok/MQjxgV2+s8kWAcVmK9UrTiv1v
 RKYkt9phnqQaS/giSAc6nbCuJoBb7QL8IFqAlmunBdPZcUEpJ0bvROZvAc/5nStFmqzWTqCvFFE
 IZqy2iE+enQRB5hHYJNDdzsaGfvWwWex6WhYCjqJ4V4RCzEYPf1kb5yeri18h/SheF5BOQqC0Ho
 YOmSvauxM=
X-Received: by 2002:a05:7022:3a83:b0:149:50cb:2175 with SMTP id
 a92af1059eb24-1b503124835mr8026961c88.33.1794741299576; 
 Sun, 15 Nov 2026 03:14:59 -0800 (PST)
X-Received: by 2002:a05:7022:3a83:b0:149:50cb:2175 with SMTP id
 a92af1059eb24-1b503124835mr8026928c88.33.1794741298838; 
 Sun, 15 Nov 2026 03:14:58 -0800 (PST)
Received: from [192.168.0.2] ([49.206.98.25]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm20471391c88.13.2026.11.15.03.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 03:14:58 -0800 (PST)
Message-ID: <0abd716f-5378-47b2-8e67-59fb7dc33fc6@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:44:54 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efidebug: capsule: add a command to list updatable
 firmware images
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Aristo Chen <aristo.chen@canonical.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
 <20260813-efi-esrt-last-attempt-v1-4-3be172f47d9d@oss.qualcomm.com>
 <9A49653C-9CF5-40D3-96E0-DC8273640213@gmx.de>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <9A49653C-9CF5-40D3-96E0-DC8273640213@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX9pxWsDw1pXG8
 ZG+j479bw6fRrxiJY5VfPqL11iPFGmYUS5iRdgtdaoSvu9TvINRyj2aRmr6DU0EjayL0ggK2mQ0
 s6CeKKzU30f1iX2OdGS/izRrjMMpKmA=
X-Proofpoint-ORIG-GUID: T1yuRxIdxWXHFDUruf_WA7PG9tAmDSxy
X-Proofpoint-GUID: T1yuRxIdxWXHFDUruf_WA7PG9tAmDSxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfXyQVRDD5/lm6Y
 x1N2isbqnRi93LYGhY3CcfJd4mrEMsTlMwG1mPRPCmap9teiFfYYM+nTvtcdKH/xljowu2972gW
 sf4qu5rLMELkzFb8hOMwDVbqHEt2e4I8rSUTNSHS9px3uE9XGTS1/Z/FO0qXcZCycIA2hGds9oJ
 f+AWtsNdLyh7CaY9LPvdzhjeo3h2uJWZA1uBWYGWzzfCvDk7Yi5opoTcsHgmeYKgWRvilwQpgP8
 9zwSALqDV4DAIKVuKyqtgmacBmk1e01bgtDB+89tyPRVAxxnQA9Yd6omkU81o3NKIIuWvb8abxa
 d++FKpnYXqtCeL9AvwcMgHqAJLwn1K9BpwEKKc5ZH8wi3Zpruk6RZ6AxaJDEbNbX5cwOBlEqv/h
 /ZikL65uXIomj7oAkWdx+4U3UoaY7wSbgkOvsl6/JweC3Hk+iY97AUgQiYUW01ty7BZbS94Sht8
 Myo473bPszW+DS/dB4A==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6af99434 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=B+jc5o7RI9DO8wW/BDIZNw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JVMcHblXzJD57q7Xr18A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150044
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 8/13/2026 12:04 PM, Heinrich Schuchardt wrote:
> Am 13. August 2026 07:50:20 MESZ schrieb Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>:
>> There is no easy way to see which firmware images a capsule can actually
>> target on a given board. On platforms that build their fw_images[] table
>> at runtime this is worse, since the set of images vary per board.
>>
>> Add "efidebug capsule images", which walks the installed Firmware
>> Management Protocol handles and prints the image descriptors each one
>> reports, along with the image index, name and type GUID. This is the
>> same information capsule matching looks at, so it doubles as a quick way
>> to check the GUIDs in a capsule line up with what the board expects
>> before attempting an update.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> cmd/efidebug.c                                     | 102 +++++++++++++++++++++
>> .../test_efi_capsule/test_capsule_firmware_raw.py  |  22 +++++
> The documentation update is missing.
>
> Best regards
>
> Heinrich

Documentation is added in v2: 
https://lore.kernel.org/u-boot/20261114-efidebug-capsule-images-v2-1-f66f0513d3d2@oss.qualcomm.com/

Regards,

Balaji

>
>> 2 files changed, 124 insertions(+)
>>
>> diff --git a/cmd/efidebug.c b/cmd/efidebug.c
>> index e55de04c699..a9e445d03fa 100644
>> --- a/cmd/efidebug.c
>> +++ b/cmd/efidebug.c
>> @@ -294,6 +294,104 @@ static int do_efi_capsule_res(struct cmd_tbl *cmdtp, int flag,
>> 	return CMD_RET_SUCCESS;
>> }
>>
>> +/**
>> + * do_efi_capsule_images() - list firmware images updatable by capsule
>> + *
>> + * @cmdtp:	Command table
>> + * @flag:	Command flag
>> + * @argc:	Number of arguments
>> + * @argv:	Argument array
>> + * Return:	CMD_RET_SUCCESS on success, CMD_RET_FAILURE on failure
>> + *
>> + * Implement efidebug "capsule images" sub-command.
>> + * Walk every Firmware Management Protocol instance and print the image
>> + * descriptors it reports, i.e. the firmware images a capsule can target
>> + * on this board along with their name, index and type GUID.
>> + *
>> + *     efidebug capsule images
>> + */
>> +static int do_efi_capsule_images(struct cmd_tbl *cmdtp, int flag,
>> +				 int argc, char * const argv[])
>> +{
>> +	struct efi_firmware_management_protocol *fmp;
>> +	struct efi_firmware_image_descriptor *image_info, *desc;
>> +	efi_uintn_t info_size, descriptor_size, no_handles;
>> +	u32 descriptor_version, package_version;
>> +	u16 *package_version_name;
>> +	u8 descriptor_count;
>> +	efi_handle_t *handles;
>> +	efi_status_t ret;
>> +	int i, j;
>> +
>> +	if (argc != 1)
>> +		return CMD_RET_USAGE;
>> +
>> +	ret = EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
>> +						&efi_guid_firmware_management_protocol,
>> +						NULL, &no_handles, &handles));
>> +	if (ret != EFI_SUCCESS || no_handles == 0) {
>> +		printf("No firmware images found\n");
>> +		return CMD_RET_SUCCESS;
>> +	}
>> +
>> +	printf("Image Index    Firmware Name         Image Type GUID\n");
>> +	printf("===========    ===================== ====================================\n");
>> +
>> +	for (i = 0; i < no_handles; i++) {
>> +		struct efi_handler *handler;
>> +
>> +		ret = efi_search_protocol(handles[i],
>> +					  &efi_guid_firmware_management_protocol,
>> +					  &handler);
>> +		if (ret != EFI_SUCCESS)
>> +			continue;
>> +		fmp = handler->protocol_interface;
>> +
>> +		info_size = 0;
>> +		image_info = NULL;
>> +		descriptor_version = 0;
>> +		descriptor_count = 0;
>> +		descriptor_size = 0;
>> +		package_version = 0;
>> +		package_version_name = NULL;
>> +		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
>> +						   &descriptor_version,
>> +						   &descriptor_count,
>> +						   &descriptor_size,
>> +						   &package_version,
>> +						   &package_version_name));
>> +		if (ret != EFI_BUFFER_TOO_SMALL)
>> +			continue;
>> +
>> +		image_info = malloc(info_size);
>> +		if (!image_info)
>> +			continue;
>> +
>> +		ret = EFI_CALL(fmp->get_image_info(fmp, &info_size, image_info,
>> +						   &descriptor_version,
>> +						   &descriptor_count,
>> +						   &descriptor_size,
>> +						   &package_version,
>> +						   &package_version_name));
>> +		if (ret == EFI_SUCCESS &&
>> +		    descriptor_version == EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
>> +			for (j = 0, desc = image_info; j < descriptor_count;
>> +			     j++, desc = (void *)desc + descriptor_size)
>> +				printf("%11d    %-21ls %pUl\n",
>> +				       desc->image_index,
>> +				       desc->image_id_name ? desc->image_id_name : u"",
>> +				       &desc->image_type_id);
>> +		}
>> +
>> +		efi_free_pool(package_version_name);
>> +		free(image_info);
>> +	}
>> +
>> +	efi_free_pool(handles);
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
>> +
>> static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
>> 	U_BOOT_CMD_MKENT(update, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_update,
>> 			 "", ""),
>> @@ -309,6 +407,8 @@ static struct cmd_tbl cmd_efidebug_capsule_sub[] = {
>> #endif
>> 	U_BOOT_CMD_MKENT(result, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_res,
>> 			 "", ""),
>> +	U_BOOT_CMD_MKENT(images, CONFIG_SYS_MAXARGS, 1, do_efi_capsule_images,
>> +			 "", ""),
>> };
>>
>> /**
>> @@ -1618,6 +1718,8 @@ U_BOOT_LONGHELP(efidebug,
>> 	"  - show capsule information\n"
>> 	"efidebug capsule result [<capsule result var>]\n"
>> 	"  - show a capsule update result\n"
>> +	"efidebug capsule images\n"
>> +	"  - list firmware images updatable by capsule\n"
>> #ifdef CONFIG_EFI_ESRT
>> 	"efidebug capsule esrt\n"
>> 	"  - print the ESRT\n"
>> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
>> index b8cb483b380..e6246a83ff0 100644
>> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
>> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
>> @@ -238,3 +238,25 @@ class TestEfiCapsuleFirmwareRaw:
>>              check_file_removed(ubman, disk_img, capsule_files)
>>
>>              verify_content(ubman, '100000', 'u-boot:Old')
>> +
>> +    def test_efi_capsule_fw6(
>> +            self, u_boot_config, ubman, efi_capsule_data):
>> +        """ Test Case 6
>> +        List the firmware images updatable by capsule with
>> +        'efidebug capsule images' and check the images sandbox exposes
>> +        for raw capsule updates
>> +        """
>> +        ubman.restart_uboot()
>> +
>> +        output = ubman.run_command('efidebug capsule images')
>> +
>> +        # ensure that SANDBOX-UBOOT and SANDBOX-UBOOT-ENV are both listed,
>> +        # along with the image index each one is exposed at.
>> +        assert '1' in output and 'SANDBOX-UBOOT' in output
>> +        assert '2' in output and 'SANDBOX-UBOOT-ENV' in output
>> +
>> +        # ensure that SANDBOX_UBOOT_IMAGE_GUID is reported.
>> +        assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in output
>> +
>> +        # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is reported.
>> +        assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in output
>>
