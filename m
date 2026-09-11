Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A41C79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 088D88086C;
	Fri, 11 Sep 2026 05:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHq-WVDQx5Wd; Fri, 11 Sep 2026 05:37:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3C64681168
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789105066;
	b=TtfMjjQZorW/dcTgg5ARJv3UMrBIH81WnZGYjrLFh3qIGCpVMa5qYpj0YtUZXunjLOs5
	 CmCa/G4/vRknaPn6vGHyoluvpw9QAtq9vXrDlbid+jYs7GN6yS+z3+9GsUr8nA5BpJeQT
	 PkhIlIdHEE/zVdjL7FAl29mG0DI05BmBwOi57MOGmNqsv7zqIO+AqZvWceQF6nyxOgayE
	 DjPhZu36FdiCc1eOQCFBUJ8GjN8ZXKvgy4S5X6JtaenLAWSDx357Mr0ZV2vpu4kowo2XI
	 C4ZAPUfF7CiyeZVCtkvjSe8FQUHRNI5+5X0HsrUNYcFxsxJy6D9wKUWAfaCFkRjSVow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789105066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=;
	b=i2M5HKT2VDD6FR2F/jjrCGjWekQkh2t5vA/v3SoK6wMUAs660SBKm0s8lV4Stgr5EoFl
	 ds11j5npNbpoaeMNi3kDqLjs0obBLfvOytP1VCVY3ZsytpmnZ2dsRtFCLpBfZVn/BS65j
	 lSoy/K5wMAOLvfdImAzLi88sN7UQ5gpboKVLWzCR5y0+mh7xmtXe7A8Slk5QmSCPZcID3
	 m1homSUb9/dll2RkXdWEuima8DV7mEWYODRoLijQeRp4CjYFvd61pAWkfvoIe76ix+SuD
	 M4vIiA+G5SjAhReQd3H0pLDDR8lEE6FggLN97N5E3t3nYjX+mhnh4zMVzFYCbOghdIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789105066;
	bh=7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kl1l5Wz4zT7zwM5Pk/VyPsMNKgIn5U3c8PF/rgL1VPkLn0VqKMLn5vctqLqyRvsdU
	 Aoivcioj4A8TthMf/UFGQBk9NzayNfLjx5m/tV8eOd3ilLl7R7w7l6tTqb3IkZkil7
	 roSJEpCmaNRtk6WEaK2BKqbSOxGznkKzhzDLruMqZvCfAME7xnIxoMDBXYncKwQoln
	 Jum3UGGO1kW6PeNd/+6mt5RbCxXn2M9RKJlUUxrhVBYSt1+VyoFydS9ZnH6k5l9dJR
	 21hO6nKvJPXzUv3fB9rDJsPKIokRgsXZWPTI8YsmxJpJ6deGpvpOtn/AV03046wVZb
	 zDqHKGgMuutmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C64681168;
	Fri, 11 Sep 2026 05:37:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0881A493
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEBF9607ED
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jeFV0WqqpBFg for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 05:37:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ED50E607E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789105063;
 b=AkYwds6gHI3ZiLEBYlSvASqtBS2uPtyPwzQa5VmQVlEOpXANXkN+BywN0nrv4E9gNlgm
 /dC1MGRzjQCGtwZbJvW3kufTijWQavP3NNYjr7O+0JdlW60jkQ4sm4YI0VYABMGPWaBhR
 QJgu8I46M/08jtDpJn3ksy23bP2m/JV/Ql5lgo4MyABLi7uM281RtuBfqvovQk3O2L6JT
 HaBkhi34bTDZOqS+fVtuglScAc+SdqCvjP3ryZlV/J/DPLPtoNX3zZXDLuWCANvPsYZSV
 yBUTVDVCV515cP7GD3XO9y54DDJRwdeDy5T8gtTcZ/SZXxgAzIRNr2vcuzYw6AuvKYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789105063;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=;
 b=J2a2kITJGRJK7qh+2jgb31K1WmahrFEr3x13hb78du3OS3vHwqxMfydApBvNt0dWtS40
 Zf3LDeEpUUMKeEZCHkD8M/JL29VBLYazL7dLcVOij2NZaHAyft+2EcOngP29TfopKAOFZ
 ulwBANcEFUNC92y68AkR0Ijy1ntzkZpjt7ZjkGHEzLcWUu7kZjZAMvsK25N4N377Maw5q
 DU6LBzne2p+f7XLeFzcuNA4UyDv424q7Z1wPeWeX/AjIOtZcF087TUssgr3RpNUaw5TKu
 HLy5kiLYBdC21jZYHSqE4GS1ZiNV4D1mG7JYM2MuQ6bQzfIJ06RoPHhUUYU4CJ64/BA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dxACnYVs; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Suffv/TU"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dxACnYVs; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Suffv/TU
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED50E607E8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:37:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B5Npt0099825
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=; b=dxACnYVsHzHSbYn8
 KpAbCpbYsHpVH3FdGtQvA9DtLiZl9B1rEjqDT+q/e5ziLmNIf9pbn9aGD814T4IK
 sWMnsEAyPEkYqBAUbm4ADkRhCOfkq3Q6Ye9zolF661kKGe3SNcxOT8oKkJ+CDP4B
 XW8FKJLB0Uo+FofVrrar9FOEDJEyoqpjC/TYBgbaEgsy5UIn/3FdjbAq657qKKi7
 SxxsHXN8GvA+ARWiEhqydhc5BhHZ+bWirOVSqeGgTHvP1S0g7n4MP0gNQoNiC2MY
 e++Vru12G4Hxtj0TXRqyvfzuzLRV6uq9b+WF4a0mm9LRtyFd91PIp6irthqF1tN+
 JEw7jg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8g1fp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 05:37:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso493582a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789105061; x=1789709861;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=;
 b=Suffv/TURXeoJUQ2OlDKJz9sEHr0Ejr1x1uU+qnD9llsBNH05zOo3ZoQqXm9gyb4fS
 VOvEKSvZhtMW1jP8MiR3Jas8SYjS8DYuI3WfJBlI7/bsqvQGaKSzp2LwQr0xLa8jG7aa
 Czx5RR7vnFUe3FLYNIKxJ7Z7eqfB0ObVX9/kwXULLczM0qcIm+vH4x9OI88i01Tb5fy4
 GCUD8IC+VAeT4oMnNfHnM4p4cPVA1GttrbnyZ1MRayoq2V45i2GigkE7rzj7Iz0tYlfF
 /yZ7pOlUnEhtytb41LiF1O+c043pmjiW8mxS474dm11JUvpYxiMBPsbXjZEf3fLrE/4O
 5//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789105061; x=1789709861;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7yd1oIEeGOnOYAXCe314Q/c+4oeAyVwQUXhIUeiioi4=;
 b=MZ0dBIAMVcfZygnGo72TtlBhA3mejjqmwkcIVbMHbwLtlFbf2O1OBCxLltu3Sy1zI/
 11eg8/Ff9z/6y80mzj8SHtfriKEfLQ5bO9HN5YQ0xK1n8Q80yK7Zcizkd3AKWndM1rIM
 kQdSi6W7IHc9gz2nK0AzGyh0nJvBcGpQu4m2Gi7tfeT71uuxtvjOqPV1JD+j9NdX6PQ7
 cn0HmWwGjVuWNDkxJY8/WDyPJbJKDqtebosL35UlAB+/g+R5YF7ypjPZrSYyMcLEShaR
 Z0lfxvCF0cifbSPdeO/uCskRM1syxXrfjj0qPhj42C8pNeVvSGIeOdK5eC/mWcIN0Ycx
 wnzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP5M9SgvGEO2QFza5k/8zM8UnpnuO/CIcVBQ8f6WpSMJJIb0WhxMZqOH7z+vCifVzeWoD9zR8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXDjBW+H8ISnR4+3Up9umHOLTTsmcc0+d5HIfNdlG0SaXsXkF8
 /SXZ75qkKRMY/Rav//5guTFLeLqYOUj03GvUqrYeP1l+n+c3//9NsPqtNdVUExO0yMdPBJcUlOy
 gSLLDEygYcXjozztd95AYsKijzPr7ScDGL+y3VNwLkSYgr3LoWvALEJb6UV4cR1KUkDjfaFI=
X-Gm-Gg: AYBFou0uA1wSI6OuutYtKyFZCkPZDbRQsx735dZIYHSTtuGx4F5Q0zu50IzvjLhtYnR
 H3i8Puiz/WKniyFH6h23oyvfdy7i8tV9sLr1wp0Kyux1oyzIiazvQp3Ge/TASmpVvTJ7h4j16D7
 JaJjMliUT2WJHOAlAeGgUH651oJC75x/dSyOLp7LW/iTLRFk4HGzblowIhdtob+8J+TXDFwUW0h
 zqgidVE/2OLgkCpNUbUzMz9QNPR7txJ2+cymNbP3OcWdgXpjmm1Jfflkw3g/0pr3fsV5J9wPEe6
 KFWWUcryzuGZtiHEUHzVE3ir8pq4njoYdqhyUbUkRrhrT6rtkGjOtHDoEwVVVPX4XyvME5++Do5
 aW36qXRoTsSGBKGrwCaA3xcpJTNy7oEdBZhMf
X-Received: by 2002:a17:90b:498c:b0:39b:2b10:d05c with SMTP id
 98e67ed59e1d1-39d9bbfa327mr4429914a91.5.1789105061024; 
 Thu, 10 Sep 2026 22:37:41 -0700 (PDT)
X-Received: by 2002:a17:90b:498c:b0:39b:2b10:d05c with SMTP id
 98e67ed59e1d1-39d9bbfa327mr4429821a91.5.1789105060443; 
 Thu, 10 Sep 2026 22:37:40 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm3505093c88.13.2026.09.10.22.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 22:37:39 -0700 (PDT)
Message-ID: <501c4835-7423-4895-adb7-0aa128cd467b@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 11:07:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tools: qcom: mkmbn: Add support to create multi-elf
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
 <20260910-ipq5210-v2-4-d209f7dc0fc5@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-4-d209f7dc0fc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BHOrlV_lag8e8lbsqCn6Gc_TgWkhERt4
X-Proofpoint-ORIG-GUID: BHOrlV_lag8e8lbsqCn6Gc_TgWkhERt4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA3NiBTYWx0ZWRfX6AoOpBVhx0dQ
 rF98T3a3+qKp+wQAm2I7nv9yp8viuqgf0ENZVAVxoM0f1thn+JxxNx3kqpSq/ZvAssied8gGlf8
 pm1HfvLapzU617EJewLBKsxb9JdJGjArrKg9aT7zPYo7bcWdEIf1p3eSt1qSOKVDbL79oEDqMMg
 ydY+chyPqmHrmY6CEQxBgTSzCNrchRrg5NnkrebjUoBfEA/VY3oBYBo5KOjBdywlbO6w2ikCy1V
 yp2rd29LCTBSzB4xlKhf2Fijpmhv0MnMK97qukDQbcPWXF0jsZNKVzpUe/469NR6+qCwNKhtFc8
 MVyPvDXX5ZSQbsloqpfqRupIojDXGlNS/tmoO8+wRbgRHuG0rh/ATttC5eIWCpBXM158Fna8Eo8
 iXdPHwLAL956LAlKiUi4WMB6D3PjpncW6sf0aUbYKUBvdvfji6LZoCJ4vYb5ae1Ko7TLHKucLwx
 1CKZAoAo7NeZ74F5Bqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA3NiBTYWx0ZWRfX26DITUcrfwke
 iTCJHuUD7HiiG+Ps9YAiPF68+pJ0N+LF3lUd8BLcGT+eOFBo8dqaJpsFXRze8MBrJTOHPyw/FiY
 zqcJHBvocp0YBqE3DsmU+Q8dcdUux24=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa393a5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1hkQQmAP4pSCfftMSLkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110076
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

Hi Varadarajan,

On 9/10/2026 3:59 PM, Varadarajan Narayanan wrote:
> Add a command line argument to take a list of files to be combined to create a
> multi-elf expected by the boot rom.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   tools/qcom/mkmbn/mkmbn.py | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
> index 6fe66fc4e55..6b0ea3a4239 100755
> --- a/tools/qcom/mkmbn/mkmbn.py
> +++ b/tools/qcom/mkmbn/mkmbn.py
> @@ -104,6 +104,9 @@ parser.register("type", "hex", lambda s: int(s, 16))
>   parser.add_argument(
>       "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
>   )
> +parser.add_argument(
> +    "-m", "--melfs", nargs='+', default=[], help="List of ELFs to include in multi-elf"
> +)
In cover letter, in v2 changelog its mentioned: "

Remove '--melfs' option and make them positional

",

but here we are adding it. Request to say if this correct.

Regards,

Balaji

>   parser.add_argument(
>       "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
>   )
> @@ -116,6 +119,18 @@ parser.add_argument(
>   args = parser.parse_args()
>   verbose = args.verbose
>   
> +if (len(args.melfs)):
> +    try:
> +        with open(args.output, "wb") as f:
> +            for path in args.melfs:
> +                with open(path, 'rb') as tmp:
> +                    f.write(tmp.read())
> +    except Exception as e:
> +        print(f"Error: {e}")
> +        sys.exit(1)
> +
> +    sys.exit(0)
> +
>   elf = Elf()
>   
>   data: bytes = args.bin.read()
>
