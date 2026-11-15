Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24539606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yu8Tnf6e;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KrVTlr5z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNY9uPkz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71C57606F3;
	Sun, 15 Nov 2026 11:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gykIYT-K87xw; Sun, 15 Nov 2026 11:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D3EB6063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794741229;
	b=Ju9CMJVoGNerMxRBt7JF19lbhwJaXmCk6d9EV7oFuIsFfhcfEb9DtZTuKubr+OSFiKgO
	 cLUnzkirwL1C/Fkk7p+pR12lITvsgFBmakZkVSWkFVgYnPH97qArsImHeXnsGg0wrtPHE
	 xxNruyGiwouEEEr22RDni9/pkE+cDp8D+M/wm0Zv9vA9rY/1o5htKkSZxCKTyfAx9P62y
	 OVbCeERA0eAKoL7Q075+WofqrXTZOqADRKKHH1/81jVPglcLVym0Th2VLy8dK3uASCOkr
	 oQYLTxgEPziZE2YduAcdFopBrqPS6YMJpnbHP5MSJNR855luh0AhaBAxEPBVFT1oTKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794741229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yJZzyxkNb4LcFIAVhsnfKm/aiO/PB8iis4hCRh1E4R0=;
	b=GFjrbopPkb1bKzXO+f0em38aRuH/m4OcBQRUKEiiQI47xj2GtOT/6SJ9sPNV+OgUqGWo
	 iSQk29KPCwKyu2QpFCoy7LWGPLshntqYZMeF7F/2iN8JpB6NMh13aJ/S6kWm8wsNw0T6B
	 MAp73OUh4dsgG/VTSP9HMtr0QH9nPpvMA1UWNQU7rZ1z7swJa6hhrB+9UrHR4xkdKaGX5
	 cuINGRP11VDmW3FwazZaUaj9CVM0dizJCo1QuH4MYbSY8rOfO4o8gT3g+kOwJlicol7pl
	 aE2ttSnxj+w8NOVYrQq5Iiy31bAtaVUdBygK+JJtXwlFmgRbAXsHygcWqSrgc6h/eSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794741229;
	bh=yJZzyxkNb4LcFIAVhsnfKm/aiO/PB8iis4hCRh1E4R0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yu8Tnf6e5SpuVbvGLPn6X0nsfij15bO4LNp0T28IwSb/huaJvzuJuJsVNE74drSrG
	 cjEYokXeIv8zrlS511AD3BleIGHdtk9QWW6mT8FeDfaoxj+fstsXyjNgSoJ3TuC2D2
	 xU/8WNhXESJKQ0Crtd2LVApcQZ6vQEk9R9PK7zjOiAS3SgzEKQS7+4+ZBWDvfqZEwp
	 5av0bqpYrR6FSiV/GkEC3JffVWkL7TsdU51Jg+jYc56sb0B4I2w97pzJpllT2mNrLC
	 2nYVggxYq33YgPq9au93ilJwQNjX0rr5MvLJdUgylNubhE2cQ3TG8RGO7P0N+3Tb/g
	 G5inrCl4l7qEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D3EB6063E;
	Sun, 15 Nov 2026 11:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 424B470B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BD3B4073B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqNQ-c_CmvDV for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E95F8406D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KrVTlr5z; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UNY9uPkz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E95F8406D9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:13:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF7x2Hk1764892
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yJZzyxkNb4LcFIAVhsnfKm/aiO/PB8iis4hCRh1E4R0=; b=KrVTlr5zvhk55ySr
 cyR941f0twk4z7d0gDOaHLrR4Ji7BOhNX+L47uk/6p0pVmfXsnRDMucri9F82BLP
 JpaLCe81SeBWdQanWR06oIdJSeVUYhD0YC6A36jAOikHzLwFSHAKwQR/t5G8UR/T
 2EZ6F2/kQVtizZ2fae7lDHC7wFGbOTrWZTlpXIZOujuqWruGtx63bTvwszy2THVu
 vz3fk2jUNHTF/ghAoOg6wVslZYk5eWN3r3kXPIODXvjEwWgGzs6/8CHS+0CadTx4
 Oqvg1hPLWSh9HEimnD6PMN8qFaj4YX+qow0YA+vvCxJYxsRkl0cp6M6nK60VTbD1
 zI0WwA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqjx68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:13:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so3057774eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794741222; x=1795346022;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yJZzyxkNb4LcFIAVhsnfKm/aiO/PB8iis4hCRh1E4R0=;
 b=UNY9uPkzcz77tLViz9Cdco4fGd5Cj4ySJiy4stzRHMmMCmmj1+HqBEdnmVM0ZvfEzd
 8nsU4XatibQtxi0H+g5jMy7sO5vMfw9JmlgpBW1/TeSC66NnMKmyHoNn7C61SQmoXwii
 O6eyPhqc4Xgm8/cO4EMZadbG5vUkTphnHDNcxZ5xGjUNNCRTFvgMWzqCNrXDLNCaJd7F
 dmp3MbYLn0n2VBlxuZYqCeCg07op1WyawQSwZp3D5/Yc+7W+PWPFa/6uKhb4dP7ZBCyI
 CiAEimWO/tiLl48uqPHgFzfZLnRQ7xTUFhEpcfFpLdY29rfqu+iYTdhKoLMCQGMpVr9P
 FCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794741222; x=1795346022;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yJZzyxkNb4LcFIAVhsnfKm/aiO/PB8iis4hCRh1E4R0=;
 b=XvWHL+mPwnlWOVRemnJhuBgDy2wJvi5nIbLcYTGIAOv/zBylhwm+J1vPDuwQIILI72
 C1bXGv+HhR6Z8ms+yEE8y0gnD/BEIUmqRESJSJVtwXlpQJtlwXe/XL3OJAOtgWMdt0BG
 GcJ2UIU6HXgMfKAtac44YJxGkXVtMKsO192Twc7ks6BgaJpTrCvNFatcMY8CipkaNCGV
 mvFQITrWCuNDMKeP68B5xkDFG0Uz4AxqfnlbMkKc2jvy2ru6MYNfFP1dBB2OOtZT/jyp
 V8ORNwepX+zdn1xyqZUeor/PYmq1gwCjrkpb5HZs38Kxj9pZC8p6V5185hRiVBfXa6GK
 Xt8g==
X-Forwarded-Encrypted: i=1;
 AL+hErGDNFsyXqatcpCTLt1pCFnSj39YTuLYi38lsYDriS2fwTq1msTeJzIw+BtzIet2gIUBlgj6tUU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Iv5hGXOVgvujVkBY1tiToA+dGbJgFs9XT6xtO49Q6+xX44lMS
 QcGnHy9SOMqorEGpdnI/gpEzAZxC/OX4tTJxmTdDt+x+PDXpPYm/IAOLqgiUwehocMATYxt6KbT
 uXjvQ+68M5zqIaObXQbGqkyYYlIrCLog4kmi6OTCLc4i+CJgrHScmk3XgsE4vtABIPZIz8Fo=
X-Gm-Gg: AYBFou1DPqyEJgGcX8DFY3O5GRPsdc/RtztRebTC4UilRnB0pCC63CNbLp9U4SpdtqR
 zEVFjxA/PFiLbSh9iH5bfBW+gDLHPGEGQnDb4yPUei5Ni4uOzj/J3HPZTjEdLKVrWI3jNciY/iE
 fY95gMIpkYXyo8/7g5MEHk3RJtz3z+uR4EbbjAXNk3je4E6BFNxg5e7XPqtLwtjKwIEZZsQ75E9
 nU9wr7NNuuaaGuOXGjq+bU/OeVWNfNDXTiov9/+SCRJI2HddKWYiw5kWysmY16y71E1D/zxwUER
 c7X83BAaHt0koEqDKokIAEa9weES49KL9p6WswRArgwxXZxd8iXfJi4I+Nl6n1RwAfguEnGIHNF
 9ra4l241GVWEt419jXYbtYk7/4fXAsljCBXt2MwcxvaVZ12eisa5jVmqYA6mr0SBsSGz0mLz6YC
 kAyiGwKME=
X-Received: by 2002:a05:7300:168a:b0:36c:9fa4:dc5b with SMTP id
 5a478bee46e88-37966e3ad35mr7605771eec.23.1794741222086; 
 Sun, 15 Nov 2026 03:13:42 -0800 (PST)
X-Received: by 2002:a05:7300:168a:b0:36c:9fa4:dc5b with SMTP id
 5a478bee46e88-37966e3ad35mr7605750eec.23.1794741221480; 
 Sun, 15 Nov 2026 03:13:41 -0800 (PST)
Received: from [192.168.0.2] ([49.206.98.25]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316fdsm24743882eec.5.2026.11.15.03.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Nov 2026 03:13:40 -0800 (PST)
Message-ID: <9d87943c-8226-4c1e-bb20-1308a2d4b62b@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:43:36 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] efi_loader: firmware: track last attempt status for
 ESRT reporting
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Aristo Chen <aristo.chen@canonical.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
 <20260813-efi-esrt-last-attempt-v1-1-3be172f47d9d@oss.qualcomm.com>
 <7644192B-CE1B-437D-8D87-0F0D22D75EEA@gmx.de>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <7644192B-CE1B-437D-8D87-0F0D22D75EEA@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6af993e7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=B+jc5o7RI9DO8wW/BDIZNw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=R-zapx3Xcfi-8ACqDycA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX+tekdQZZd7pm
 vdESrEZwssKUlFcMJU1B9xKLL52I4Jlsq3YJ18d9Hu6Kwc3byHCw01S2xp/U6jBccdptjdl1ASO
 lOUHHUqIsKnjtFB8e4zediL4lm4SdWU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfXyxPmOIIexEFc
 HCI+Yprhxed19V4a7H70EFMIfI8IwLXztuR50Bs6S6UaDzLAVIiwd+5biyuUHTt3+qEdygNz+av
 YJGOwgyNERXg34VZH9a+f6ZEtHn7xAft7yztNe2Utn+gfWsY7bwtm4Lm2G/BSFn2d5OSlJ5BxDO
 X8ze36CSuqROe+lTBL+9Vn0XqexeFhuMU4WupWXksgVnP/2KBtlWcwwEffJVGccdM1+52ov6JJF
 FSyGdEEnIgfgQ4w1GWotO6M6L5bFcydux/JaZq8Ia/TSmz9xELqOi/29yvteeCQz+kNzLhHFWPv
 e+j6/U6ylnZPSNyF6m82/Q1CIG7eRTO6msWyzVJ+WuUWSD/cDQBIKrWuIVYUk1uLD0zdPqPYSJA
 RqcRKe7xT3QGkYdbjdd+fMCCiBUbwyD7YUUE3YKkQGDoKpCMCGXlLwEhczY1SbBSQE3fZTyDFD5
 cy444ib1cAP3i3wGiKQ==
X-Proofpoint-GUID: y1rISkE7AtTMAqoT7BIIDfoYhByBKPgZ
X-Proofpoint-ORIG-GUID: y1rISkE7AtTMAqoT7BIIDfoYhByBKPgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
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

On 8/13/2026 11:58 AM, Heinrich Schuchardt wrote:
> Am 13. August 2026 07:50:17 MESZ schrieb Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>:
>> The last_attempt_version and last_attempt_status fields in struct
>> fmp_state were carried but never populated, so the ESRT last-attempt
>> information exposed to the OS stayed at its boot-time defaults
>> regardless of what happened during an update.
>>
>> Add the plumbing to maintain them: a helper to record the attempted
>> version and status, a mapping from internal efi_status_t codes to the
>> UEFI LAST_ATTEMPT_STATUS_* values, and reads/writes of the two fields
>> in efi_firmware_fill_version_info() and efi_firmware_set_fmp_state_var().
>> fw_version is now only advanced on a successful update so a failed
>> attempt no longer overwrites the recorded good version.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> lib/efi_loader/efi_firmware.c | 74 +++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 68 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
>> index b41969c70fd..cbe8bcd7c64 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -52,9 +52,9 @@ struct fmp_payload_header {
>>   */
>> struct fmp_state {
>> 	u32 fw_version;
>> -	u32 lowest_supported_version; /* not used */
>> -	u32 last_attempt_version; /* not used */
>> -	u32 last_attempt_status; /* not used */
>> +	u32 lowest_supported_version; /* not used - read from DTB for security */
>> +	u32 last_attempt_version;     /* used for esrt tracking */
> Thank you for improving the ESRT reporting.
>
> Please, provide a description explaining which information is contained in the field.
>
>> +	u32 last_attempt_status;      /* used for esrt tracking */
> ditto
>
>
>> };
>>
>> /**
>> @@ -190,6 +190,49 @@ static void efi_firmware_get_lsv_from_dtb(u8 image_index,
>> 	}
>> }
>>
>> +/**
>> + * efi_firmware_set_last_attempt - set last attempt information
>> + * @state:		Pointer to fmp state
>> + * @attempt_version:	Version that was attempted
> version of what?
>
> How about:
>
> Firmware version of the last attempted capsule update.
>
>> + * @attempt_status:	Status of the attempt
> With type u32 and "Status" I would have no clue which values to expect and what they might mean.
>
> In the description you could refer to the enum containing LAST_ATTEMPT_STATUS_SUCCESS et al.
>
> Best regards
>
> Heinrich

Thanks for the feedback, have addressed these in v2: 
https://lore.kernel.org/u-boot/20261114-efi-esrt-last-attempt-v2-1-f47a430a6917@oss.qualcomm.com/

Regards,

Balaji

>
>> + *
>> + * Set the last attempt version and status in the fmp_state structure.
>> + */
>> +static void efi_firmware_set_last_attempt(struct fmp_state *state,
>> +					  u32 attempt_version,
>> +					  u32 attempt_status)
>> +{
>> +	state->last_attempt_version = attempt_version;
>> +	state->last_attempt_status = attempt_status;
>> +}
>> +
>> +/**
>> + * efi_firmware_map_error_to_status - map internal errors to UEFI status codes
>> + * @error:	Internal error code
>> + *
>> + * Map U-Boot internal error codes to UEFI-compliant last attempt status codes.
>> + *
>> + * Return: UEFI last attempt status code
>> + */
>> +static u32 efi_firmware_map_error_to_status(efi_status_t error)
>> +{
>> +	switch (error) {
>> +	case EFI_SUCCESS:
>> +		return LAST_ATTEMPT_STATUS_SUCCESS;
>> +	case EFI_OUT_OF_RESOURCES:
>> +		return LAST_ATTEMPT_STATUS_ERROR_INSUFFICIENT_RESOURCES;
>> +	case EFI_INVALID_PARAMETER:
>> +		return LAST_ATTEMPT_STATUS_ERROR_INCORRECT_VERSION;
>> +	case EFI_SECURITY_VIOLATION:
>> +		return LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR;
>> +	case EFI_UNSUPPORTED:
>> +		return LAST_ATTEMPT_STATUS_ERROR_INVALID_FORMAT;
>> +	case EFI_DEVICE_ERROR:
>> +	default:
>> +		return LAST_ATTEMPT_STATUS_ERROR_UNSUCCESSFUL;
>> +	}
>> +}
>> +
>> /**
>>   * efi_firmware_fill_version_info - fill the version information
>>   * @image_info:		Image information
>> @@ -237,8 +280,15 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>>
>> 	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
>> 				   NULL, &size, var_state, NULL);
>> -	if (ret == EFI_SUCCESS && expected_size == size)
>> +	if (ret == EFI_SUCCESS && expected_size == size) {
>> 		image_info->version = var_state[active_index].fw_version;
>> +		image_info->last_attempt_version = var_state[active_index].last_attempt_version;
>> +		image_info->last_attempt_status = var_state[active_index].last_attempt_status;
>> +	} else {
>> +		/* Default values if no previous state exists */
>> +		image_info->last_attempt_version = 0;
>> +		image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
>> +	}
>>
>> 	free(var_state);
>> }
>> @@ -427,6 +477,10 @@ efi_status_t efi_firmware_capsule_authenticate(const void **p_image,
>>   * @image_index:	image index
>>   *
>>   * Update the FmpStateXXXX variable with the firmware update state.
>> + * On successful update (last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS),
>> + * updates fw_version to the new version.
>> + * On failed update, preserves the old fw_version.
>> + * Always updates last_attempt_version and last_attempt_status.
>>   *
>>   * Return:		status code
>>   */
>> @@ -471,11 +525,19 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
>> 		memset(var_state, 0, num_banks * sizeof(*var_state));
>>
>> 	/*
>> -	 * Only the fw_version is set here.
>> +	 * Set fw_version and last attempt information.
>> 	 * lowest_supported_version in FmpState variable is ignored since
>> 	 * it can be tampered if the file based EFI variable storage is used.
>> +	 *
>> +	 * Only update fw_version if the update succeeded.
>> +	 * On failure, preserve the old fw_version to maintain accurate ESRT state.
>> 	 */
>> -	var_state[update_bank].fw_version = state->fw_version;
>> +	if (state->last_attempt_status == LAST_ATTEMPT_STATUS_SUCCESS)
>> +		var_state[update_bank].fw_version = state->fw_version;
>> +	/* else: keep existing fw_version (don't update on failure) */
>> +
>> +	var_state[update_bank].last_attempt_version = state->last_attempt_version;
>> +	var_state[update_bank].last_attempt_status = state->last_attempt_status;
>>
>> 	size = num_banks * sizeof(*var_state);
>> 	ret = efi_set_variable_int(varname, image_type_id,
>>
