Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF4CC55175
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 06:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E00080B3A;
	Mon,  3 Aug 2026 06:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-we_Ui5YfvK; Mon,  3 Aug 2026 06:44:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A7FF80BB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785739454;
	bh=C+2GG340fDHLQmnEx/KtusVvmwQZBzJk8Wh+v50RPvc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DoA0jvkhGques7c8950b/sTJzmq4m0rZ8dAc1AwoNA692BazfXHbXqyWULQrffLu6
	 4ixj+WEacD6QzNQIH785OeUdCxDPFPB34MzWQAHQYyNsskbPDeRvq0PuwbZTVjQOoq
	 T7N8lwpsWCF3nVHJuvRqgvNBR2VtMjcCmpZNz+FL493QWEyYOjsH4o6/7zgtIBUreZ
	 zLoebXbGRHn47nYSX00PcP5VHHJHSjPjH9Hic9yNfEF+GgU+yAfZS7IBF/mj2YhQNl
	 k+SpObn2USgCSPAYJ9KHSWj/OaDLENc17Pd3eiwoakHqSnKSPXVlJueY3pY23aSC16
	 3lMISfMvwZouw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A7FF80BB4;
	Mon,  3 Aug 2026 06:44:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B231E36E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97C624012B
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:44:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tAGsYWw4lFSz for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 06:44:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B11A340096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B11A340096
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B11A340096
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 06:44:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736S9kk250043
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 06:44:11 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrd81xw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:44:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso2276448a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 02 Aug 2026 23:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785739445; x=1786344245;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+2GG340fDHLQmnEx/KtusVvmwQZBzJk8Wh+v50RPvc=;
 b=ecqLJqX+uNlq4cmCowk1qOrWmUxnW0ZiaKs9XPa1t9bA4c6CFaAWD/3GHDo6sYzAm/
 lvqXQxmoBx03OKvqcD7CAV4QRiIbun5E/jC3D+9IGcElgEy6QB3UL7q1v1I0KUGolvUn
 MAj1YdhgKtVP46leUu1lqyvhLH9mh94HF3t30VP7ISipW30xQBCbqMc8HSQp0SWIb6m7
 dzKX5IROx3K5RvOOBt4xn86Dc8FBJxDpDvz7vWlRUiKy/WFg29aurXFS55wiK+4/YMBG
 YlS4UfN7CYni/A6YEJnom0g+n0bZExn6OYMRhxbgenG3kCBYfaCXmCk6aemrFQEaeFJl
 5fmw==
X-Gm-Message-State: AOJu0YwWoHKkUN4Wf80/8HkZPGqyxfaEz1k6L/wb1lwm+DaBK4hdZ/Ft
 uHfozG0MRt6+6k7aUbEdwkmDOuOYgV2+8s3gmypq4gyK/IYNzhKhpy2MJ5bpkUNwq7o5DAYQzg+
 KVbSnXhz7obX1Tb2QBcBfG1xvUB3D3a9Prqg2CJBRZRk5YK0sGfYlGFXg8z/IzlTJYWo6a4kcHA
 tgflc=
X-Gm-Gg: AR+sD11ekfpuxgYYkGFGifuB+13z3y6BoIsbfSzfJbCxuwbuqfVNQHcjjMD5gLyEj61
 OnS0Mn5f0XB90bSLHfSMFgkGye+rDqJPVP/5EfnkcSk9IEO3XNFFFNOinqivZdAWJR5iu5Z+B9N
 PAfi5BTFGI25zWU3kiNd+ymRnwLcQvlGGAcE5z0MvFkM/lT2Mh8xqSOpNx3tcaMW2oPT5zYd2oi
 T+nHUsah7MORh2ZPUISreEWz7/QU1SlI3YsilCeFHlR8UUgAXs9eF+xOElmpd/oYeyHUAdeuID1
 nuuoQUYL9EoZ7qjFtpKzWY7U71mSGhB2Z1WCnNKdlNrUFE8K60FbcxFttDzkeicsr8Ug9QQezbh
 9h5QH2M5PREkxVZfYwUQTigvAqfkVtYJA6YJhAQ==
X-Received: by 2002:a05:6a20:d809:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3c92a5a12ebmr8308819637.2.1785739444934; 
 Sun, 02 Aug 2026 23:44:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:d809:b0:3c8:d3a4:7b40 with SMTP id
 adf61e73a8af0-3c92a5a12ebmr8308797637.2.1785739444545; 
 Sun, 02 Aug 2026 23:44:04 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e29a126sm36559242eec.31.2026.08.02.23.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 23:44:04 -0700 (PDT)
Message-ID: <f432e39e-3dd3-4cc4-9bed-81c02908944f@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 12:13:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mkeficapsule: Support multi-payload capsules
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
References: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727-mkeficapsule-v1-0-5b162866b092@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfX7r+zdGIdIvFK
 lYhTknzMcU9qo+E5TFse0zExY/6zocvDMTf8uRrFuNiypUSpN2pG5j/cUP+B+NsFAGmAJsoR2f/
 WuHBO+2e1L+yKzDTezRLSKBchJTLTmo=
X-Authority-Analysis: v=2.4 cv=f/94wuyM c=1 sm=1 tr=0 ts=6a7038ba cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=1VxDqnHFAAAA:8 a=k-42gJp3AAAA:8
 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=02EIq6OHAAAA:8 a=cm27Pg_UAAAA:8
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=Zh8g0XQTMlZCoNULkJMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=aZ5uHUMKh6B-zo3GvD48:22
 a=uCSXFHLys93vLW5PjgO_:22 a=d3PnA9EDa4IxuAV0gXij:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=vbqWBO59iwVkzqU4rnh-:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: mtiOl5WWxlceMgQqUC4JVVT4Jo-0wSyv
X-Proofpoint-ORIG-GUID: mtiOl5WWxlceMgQqUC4JVVT4Jo-0wSyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1NyBTYWx0ZWRfX+6X6F6rIbBGt
 AaQxTPE+vEGHZbajhNoMzUvG91Sb5xs2+sqDup08yEnnROfnd0WVrwR3ZN0EtJJiy+XuEX1jZE5
 wcVYcUDLbs4TE1GFPQu8DtfhEX+XynY9dSgnxAti3zN/SBNYGZDmPnR9SJK3kXzPc9UrtQpWM+B
 ALTLZffUqemPA14tvzVuE2SRWBN6jaMPr6+gl0d+nZzbW1d4hd/jkmipDP+Ryk7wI3L7QxiIbVU
 pnKiu8/ygcAc5OZr/KAMCLTfEFi2Qb5jRmAP1SPja11xH0yVZR/f2jhWKDs4iwn7Srr5IY8m4/B
 cGEUAgm8AZ8Pwf6SZ0cQP+t71PNuJ2yAIK2KdCdelS6DjsC8BQvSdvuwhzOqDEChPQgpUYtgEG1
 uaO7aQGR7Xip9/aEI4DKGCnNXe6vC3C/lJrZJ9jMjfgRPJ2Z9GJK1KcV2yXkOEPhnz0TgbCMNpR
 75vtqeowP/oulPDm74A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030057
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C+2GG340fDHLQmnEx/KtusVvmwQZBzJk8Wh+v50RPvc=; b=MPtvY+xXKMfBoRtW
 dx2G+iIh7DbpsSsM4wWGlmCmqz5WaVpG32lgCo/0cv1mFZZQt5Kkz4pbraj0Ta5q
 o+TnkDfcTpm3ndM7CH8J0lfkaedfsATPYJ1KR8SsRzjGKr8I5vGICRW8FEBMoloP
 7RSXj/LUpeZWyeEinUc60tslWmU6LlPfWUg8puByX8sNPJ3VSpucKRddTXT7NhEo
 K/96barqCvrVqbrVMFEWyCA/Bkk8DSeu2KASei1ACc+GIpriS1rYrYHINaxSz7UH
 H8/IJPtz9htKMAsmk0x9IJTTgL8hcPUPU1n09rCU7VhHfDqvZWpP6U/gMfaD6ph7
 4tA0IA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785739445; x=1786344245;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+2GG340fDHLQmnEx/KtusVvmwQZBzJk8Wh+v50RPvc=;
 b=RsBYCq4yEWVORxmya72Ai6/zYxB9B9eDM/gZC7IM5qWntCd7Shl/GnfJ6nogex/Hju
 IUS9cpzh9pqN+jX3dbk2YarTNMLJZwCjKjz6bbaPnRuC9ZQWlC1iCKmnpVV3C0aWpv5a
 50UQz3mzDtNAZxQvFuhCkdpdqF7zJ+upeDHbAVxqvauben4PfXP7SzNSgmlfjK9DPt64
 F1VEUt7HGeyDKSPLyPfHOcf4v3f8L4gTpSDdNBZ7jLJJ3+rBqWUZEvZ1DPO5NqPWeUiM
 nma6HHfN30p0/AP4eHuyblTHlZtYpnh641qgBIrddFXqnHQhQ9LNr01gVtmDSsL/0XFv
 LBDA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=MPtvY+xX; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RsBYCq4y
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ilias, Casey,

On 7/27/2026 9:25 PM, Balaji Selvanathan wrote:
> This series adds support for bundling multiple firmware images into a
> single UEFI capsule, driven through mkeficapsule's config file.
>
> It builds on Sughosh Ganu's earlier work adding config-file-driven
> capsule generation to mkeficapsule[1]. That series produced one
> payload per capsule; this one extends the parser to group payloads
> that share the same output capsule file into a single multi-payload
> capsule, adds a new API to build that capsule, and extends signing so
> each payload in a multi-payload capsule can be signed independently.
>
> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@linaro.org/
>
> ---
> - This series is part of work to bring multi-payload single capsule
>    based capsule update to Qualcomm boards.
> - However, this series applies to all boards, not just Qualcomm
>
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Kory Maincent <kory.maincent@bootlin.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> ---
> Balaji Selvanathan (6):
>        tools: mkeficapsule: Add multi-payload capsule creation API
>        tools: mkeficapsule: Enable multi-payload grouping in config parser
>        tools: mkeficapsule: Support signing in multi-payload capsules
>        doc: Document capsule generation through a config file
>        sandbox: capsule: Add a config file for generating capsules
>        test: capsule: Add functional test for multi-payload capsule update
>
> Sughosh Ganu (2):
>        tools: mkeficapsule: Add support for parsing capsule params from config file
>        test: capsule: Generate capsules through config file
>
>   configs/sandbox_defconfig                          |   8 +
>   doc/develop/uefi/uefi.rst                          | 112 +++++
>   .../tests/test_efi_capsule/capsule_gen_binman.dts  |   2 +
>   test/py/tests/test_efi_capsule/conftest.py         |  11 +
>   .../tests/test_efi_capsule/sandbox_capsule_cfg.txt | 118 ++++++
>   .../test_efi_capsule/test_capsule_firmware_raw.py  |  36 ++
>   .../test_capsule_firmware_signed_raw.py            |  33 ++
>   tools/Kconfig                                      |  15 +
>   tools/Makefile                                     |  10 +-
>   tools/eficapsule.h                                 | 128 ++++++
>   tools/mkeficapsule.c                               | 305 ++++++++++++--
>   tools/mkeficapsule_parse.c                         | 464 +++++++++++++++++++++
>   12 files changed, 1206 insertions(+), 36 deletions(-)
> ---
> base-commit: 574b1adad70a19d95c65e0f37f9c36d94fb5418f
> change-id: 20260725-mkeficapsule-9c1dd6c05b48
>
> Best regards,

Request your opinion on this series.

Regards,

Balaji

