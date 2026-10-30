Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA99606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mwi6TscO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMbYgzRD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R/ah+/wl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16F1A80FB3;
	Fri, 30 Oct 2026 08:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMLJI_SjV_k9; Fri, 30 Oct 2026 08:49:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 159BE80DDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350162;
	b=mQCRgbzoEbgI4D4gTXhirP7gymP+oKAJBQJQ4AjMqQOOeIXmsxVUW5pjqT69mKudwRLJ
	 suxGGS482EFMiq6DfUdXrLXY/kDOA8pfjz/ksbHXnWMm4MgDgflP3wY0vdill0MnTx300
	 B+JYOMPZqK0pR/YLjNLmGpTx7gC4jQVOhriC3pkqQwfFiMVs1RJrPvQNg9/K0Kk2QBDxW
	 FTJzaENIZP+9cQyGyHYK2ZWOMJZ6g1OieRzoyfmSPwVB7fOt5HMx4RQizILVyuRR0ojgc
	 IKIAw7mhIMB8BfMRfF2kV4MviP/xrNRhjLwqoZOZ8xfWNE1BcilTNSKqNxZkiroIMJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=;
	b=CAE4PZO1sQuY9eVvXZYha0VBBnib7aYtBa0H/TA6wnOdcL0xLoZIR6OF+d9i0KqJvx72
	 aRK2Jzky4j1R8aE/ra1iSChz0de3Bg8Uq2rLVi+N0kHswM3UUoMsFwxkFFxKFuW9k2lD8
	 f1mX8QxvDl7irL2qeFEOAMGrkRtYRh+8Knyj6n4h5pa2e7VoXeVS012eCj8NOOse3eWA9
	 Tcv/ewm9m1B6TvtsHTA4efG4j/22yVsEiwa8+d3JpFa+Ds1qrpKt2qv4yY4dbWP2vrpXl
	 QiPS0hptpTXc8fimmOXoL4WIF5ionyGbjYiigX/Gldz88zv1KbD1WYLjt+eOmzgNIuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793350162;
	bh=t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mwi6TscOveuei3QsPdpr6QYo5NO5eDTWmMbEYhJV2gWnztjwQw8SPbbbu6CBmNkyJ
	 hx838U34fy3LEZvhxXvu/mkDpeOTq8MgovcOqa/tSfxOuMhe+8KWhhFmcIjPZwBCio
	 5gt8zai3TCcmXxNYT8H10UzEABE8M04g4UplTFl+bO4qUCszqLwwavhhvsZh2y5tE9
	 GezXdOgl5QVp7PxOJ0A4jjcw8Nh4w4HcH+nPDh4lJMW18BmhQ/7j1vibUP+es+WS2a
	 O5Ne2HXDMky6fMI86Mf8hb+A5hO5qHK0877Td5WiCsJog03RfLAESnlW3JOwKt6VxM
	 dm/4LHWaCIXCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 159BE80DDB;
	Fri, 30 Oct 2026 08:49:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D902E473
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEF7D4010C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6MoiIHMW8287 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A340E400EF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350160;
 b=cUn6muXbt8KAPlwXH4X5tAzXaWXIfrDINHcjQ6UChCjlilu5GiSG4fzwh74GupiZG7gJ
 uvMKPPz8VSpx3kMxYXpZBccNOF298bhHH8EjOPJTGYv/f62NlmNUJxQBgHvPQFYDSNqay
 8NGP0iNyI+OHP1DtEBVJcHLqLgsTvKL449eXPXjLUt+ennW9tCECbQKbmgXa70ceQ9p12
 MLAvxJKLFOWMWOBPGCn+Vs4bgPq7a0eINRpT/iXLIg3InqkYhHy0tQkduosuHY01f9NEp
 Qw+sy9DjPSxlGp84cdB9hijOKA2Xh7cPxWX4U9W+AmoJ6fCJ0SKLjeNEfX9hSMWKbfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350160;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=;
 b=R/+uz3wuKnWhrzV/YP1+MHez3+eP3Cg4jF64Bkv9hpatxojg0Vytb/tpcQTlEPECaDQe
 9LKKU0wmsasgHlvA+HtmORsiD+P+UxywQ8TFNKbP/eRsPY0nSK3bDIPSKozViaEnnESkE
 OOx3OjWhRyBvcG7oPhfWTNFtFAdUAUzFa/aKodUcJxSJ7cFQzuOkP/7AhcvreP9kuU/1Z
 cYSe4tHW484qNmaWKjtCf+B7KJdirF7ykKMGX4Y/khhKcg6vvWQf4ZLmeb846a9x/hcIf
 sMFS9mKIGRDk849to3EIzgsr+5QZPaJFaeXeYhnpM+5y/eFNC5ctjrSdQ7m260VUsJQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=NMbYgzRD; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="R/ah+/wl"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NMbYgzRD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=R/ah+/wl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A340E400EF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:49:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F9MK2374147
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=; b=NMbYgzRD91PKvItu
 5eGkV/GSgI+xhxjnayCAhYmmbf2SNQw9whWw5BGGy+kKq+srCMSFpWfPq+O3S2MJ
 DMJfne0sWEJ1jbjtFXVG4EnkqZyMV1/y2Pq1DMK0TcSBoS2R8jhzGUY0BzBSzaTe
 X6WLLMzYdympeA1KNFVIkmijCKzvhRqt/xDwK7yToty6Hcqf0DXJADRHUbIuacsP
 yIYUR99jlQyUxPYUNWbT4jrIf0e5pRjbz7GVxEeMTzi379W7Cox0i7XmCA5xlST0
 1O7kU/cov2uFrIGYLidA3dtz5MlxrXL7pQkQDzJDmvL1bvb6pc3bhdc0szADlhHP
 XVPTmQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj2e8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:49:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so2327304eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793350156; x=1793954956;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=;
 b=R/ah+/wluxSMWS8iel8vvUz4f97GgWaOTdblNBiMYlBCnX3MdluT3hHLO6f9GZycdL
 KlyD6aIgT8QQawDV+sKN4ZHgKb90VsWHTVxXlLpYckvidEZYJ7U1XxB6Viu/pfY4op2K
 UW6xGnYpGd/SCyVlbc+bDuyOgItvwXBp7pW6AcTRyIq/7Oa4oG5q1L64tcQrBM0rYb9p
 dMPAjla8onjB99g9qX8323HKzJdqmYIwOcPDMaz4c0OTXgiSbOnE+d0bXoUfXdqCo8Dt
 Lf9EXwKsxCE63odeB0UyLz7FB2/Fz7J8/gU2VGzFMW6smWhw0dgyDJ/LFPMpL2odA8ze
 6Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350156; x=1793954956;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4ABKnywtHtrNmsxhGfo6T/769anJBv70ZFmtFHIZvc=;
 b=lxLmzCyYwVfRKUKyCCsL0iKakOTjR+z27LL4wTiC9istmcTyJHSVe/kWiucfQVQUiS
 pTP+egIXMmUX8E1PNHpqpzoq8IKtADWVib6mSM17SbJ2ChEBc9hzsiH5NThy8cbNk6uR
 F4LjatHvNY0zgnWafxHgtSrTWKK3hQwvuXJoaGvSZyNSuGRrOGSYyrVkIXidbn0uZPiB
 zLYelsMWRLEBPDTPjd3mCVik/LVv79/z3VT0Btgzc6hcUR5ZdFSgkao9pK4nf5zTjYYB
 O5NzY3W/x++1EvV0/WLieSpDRNESIRG8rZ1QWxuqovCCMHMnNOtQByeMxYIBbScmWASg
 1K/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl53/o3HkNGxLHQZcUZiAfo8V7WC43fEqp1cer5a0cIUio5j0CvOocHGfulSXmEJcfJjwB7PM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGCC5+vIGnrbxgU3q2hwwLGWCSvy0rroEJzaVJYyDBDoqOYM1J
 S9nYjPRjUkyVh5TyNYYpsEUf9gRkdkjbH5F8Yy9mLNz2GUhnLAqRl8TfKZsgUhha5yFSZw0XAym
 yUemDvaDb7dDZaLPWaobagZfj0YWBSrC0n4wDP+yH0Yeu1VaSwSsQFFdGXT8VEc5JjVhN0Pg=
X-Gm-Gg: AYBFou2GNZPHdBh4lXl7CVQxzdQm5KjoQtXD6c+OGg6RbnO6k8XqxH/bV1UM+UF8lEb
 jNLJQMlenYTzfS8NXI0Qv5wjjejaMUz7hcVAc8ThITJ3UrcfEHY2fOnfI4FVmvdVnWqnvlSvmTg
 cnXw58rKMMGus8PGd4JXn9fKW+VObAW/rIOnwwsHuaEroBV80/A4ibZM/wAFAhBNJyxLoOrCGp0
 M8Y5XuI5OvznBuuKDjsuYB1nFBHiyROKE0beeiLrsHiKt/LgIpTfRqEyfTucJfOa7ryVWuiIf5X
 Nq9YO1PsiJMt4ERGk5CiGBjbz+uWBM6JEOGWF/CjQ4r07OAjUNXhlep0SJcOCTdIHulHjt5/dSp
 1OGLLYgCFnJNaORGS0KFFIknn8jMSJkyz29KJ9+siRmpMpKtFaZ3/JfRch0U9+oVGVR7pPzhPfa
 HpPg==
X-Received: by 2002:a05:693c:8392:10b0:361:39c0:c393 with SMTP id
 5a478bee46e88-36a42340afemr3026336eec.13.1793350155879; 
 Fri, 30 Oct 2026 01:49:15 -0700 (PDT)
X-Received: by 2002:a05:693c:8392:10b0:361:39c0:c393 with SMTP id
 5a478bee46e88-36a42340afemr3026296eec.13.1793350155173; 
 Fri, 30 Oct 2026 01:49:15 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm5270833eec.28.2026.10.30.01.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:49:14 -0700 (PDT)
Message-ID: <2a35658f-5083-43ef-85dc-56636a7daa9f@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:19:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] qcom: spl: enable CDT for shikra Add support for
 loading the Config/Chip Data Table (CDT) from eMMC during the Shikra SPL boot
 flow and registering it with QCLIB via the interface table.
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
 <atBa0CC5IBWk9CLN@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <atBa0CC5IBWk9CLN@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae45a0d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=9U8HI1bZefmV58vc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xQMrXgkcguEf2VlY3fYA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: L-yOgLuIV_gUqZ_dDI_t1S9kBSL2HiXL
X-Proofpoint-GUID: L-yOgLuIV_gUqZ_dDI_t1S9kBSL2HiXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX5hueujQKRb+C
 m3Xb+NEAoHGt37f01wQ4xLv3BJTpqrWfmaKBYYfXmvZMrCG7MCeD0FOSi3WbzWkMUwWKpwp4o9K
 JMoQ+L/VEYgbR3ImKLenXtNgSD1bfDZnt6gNBSOjq+5u9+eMOIZB2G3vq7iMBTOifekKiUkU/e2
 guw68uhK4oISMobVgttwGZ10wQLL1OAn82XNOMe367Gi8WehZK9sBxd8xAoBz39SMkU8F9QePNa
 XIwSMmI0PVJW+R7ByLyUS3/hw1rwLuIpNRNhEtUFzusVpIRs/NkolTaVOVN7SdiY8C3Yr1Dv3+A
 qSE1Cp/3Vy99HIVapft7X8XlAns5r3pUgBlfnc0F4bGqpwHJ4wLsiZXzkrotuSYBHQtufjnBO0r
 XSTs41X0Ila5U9T0vG/ucHOMA0wDggytmFGDCxwbs9k12ff+63CyPMPIbkw/hUNXghXFQGXSSGC
 zkjDUwLbpPByR6ps22Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfXz3EMPCs8VXB1
 3nWe5F4CQbLBDe8bMcExRjQl07E6Ff8Bx1RkWN2zdS/xovI9HyOEFReK/YGhEdFPkfAPqPazK+U
 rr7CqrTI8OmTXjRMpBwQwSrtK0CSVNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Varada,

On 10/15/2026 10:17 AM, Varadarajan Narayanan wrote:
> On Wed, Oct 14, 2026 at 05:51:23AM -0700, Abhilash V wrote:
>
> Commit text and subject combined into one long subject line...
>
> -Varada
>
>> Depends on:
>>
>>   - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/
>>
>> KR Sowmiya (2):
>>    cdt: enable CDT for Shikra SPL
>>    mach-snapdragon: Kconfig: add CDT configs
>>
>>   arch/arm/mach-snapdragon/Kconfig            | 72 ++++++++++++++++
>>   arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>>   arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>>   arch/arm/mach-snapdragon/qclib.c            |  8 ++
>>   board/qualcomm/shikra/spl-shikra.c          | 15 ++++
>>   5 files changed, 192 insertions(+)
>>
>> --
>> 2.34.1

Addressed this comment in v3:
https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/ 

Regards,
Abhilash V

