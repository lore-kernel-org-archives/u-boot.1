Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA5FC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D770843B6;
	Fri, 10 Jul 2026 06:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kaGhXR4c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R62EXc4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A37C847AF; Fri, 10 Jul 2026 06:38:45 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870DF8407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mh8x3721088
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 04:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rBBBqc7WwvBvQThKkPwQFem9yhJC3942CX9u+vJeMkA=; b=kaGhXR4cLEvZjFcP
 6EV4zZn2O7RnIje8msWFymAePdzqvoXCJ35j08SVzTdI3RsbuByJ0h1OCAchc45H
 uFNQUy+8WRPg3Jl5NLSYn9/K2Qe/IyLNyjkM3UDy4R5IaRR/1zTbtGKC5sk80RoZ
 PTY/IdVcRvczB48mhY83WO/iJ3E0U7IsEkQ6of9MXOEGGTKa7jJ18FKuW4IDA4KQ
 vyK/UVoLVAzm6kHzxpD+C4GfZoVxkb9hv4YsLCpqXHw4ZSRwLKRTw9NWqU4gUC/s
 uPFy/x3D8OPaDfZLAWHApDDZbtkplAh6lRS1qa9pq/dFCMIVAk/0d1kHBEH+ECSa
 an1saw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt98th-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 04:38:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so1118509a91.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783658320; x=1784263120; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rBBBqc7WwvBvQThKkPwQFem9yhJC3942CX9u+vJeMkA=;
 b=R62EXc4tCblZzLbbVxRuAm3XoBHr+cxzx/ODLDCBBlmGUUoByfeVq7p980fHNuW0L0
 h6/c/2P3RzSgpaRKDPtZRlVPnO56Xc3P5Y/xFGcjw2CGj19X8qt5psM5buBqdBugPvfp
 hBnonvqPwMovOKqOzZwQSt5Ma1tur4M+RvTX0YAjYacedHxnQKhItWXpNOFIV7hJQEOG
 oqYJDX5B5IzgRjgklvhAl+JVyBJ7JrKoDR9mpH40z4NCZieYO3kPTk3jp731/boagn4F
 +WGc6rTZluBaQ7hRHA2p/Y0vQQJ5WXy3i+1g+5NNqCX11BYnYHfGOnd6Jv0uMSviHMzF
 gszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783658320; x=1784263120;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rBBBqc7WwvBvQThKkPwQFem9yhJC3942CX9u+vJeMkA=;
 b=C5UZd0qWrvvTW8BBsg+g2T1ItsqUP2mlsqiZucxqBpk7YLP3EHa7IJfYkN+dALR4Ab
 aOmhzeSzsCtdZ821xjClGy8KrRiTlQBZPIu3T3O+WKCzGeWNG20ud3YpsPwOiXYjpx2Y
 yyWNN/3S3PZH+bXIyT/u2ljuRkwW9uxH/wTsXxUMRQ6bTLDp54e7xTViQOa3nLoi5L3A
 ioYCkIPY84CSEtLWb+1Rskb/9b6c3A5l+JH3cXj34eIESw7NEJVIrirjYqp/PRMdFJwM
 c0ijaGaUxdwbjWXWab0YVlOEZCguDJg8Z5x+DlKVqK9j64qVI0C3nXMxyywO/nlRYmMG
 Sdyg==
X-Gm-Message-State: AOJu0Yzq8q9fI0LvbloBxLgjl2o9I0iWdsP0KF2IO1K80Qum9lgZSI+a
 cjOt0jzCCXgq7sji5aqYGKLdRgOx3p3GLVI1+Fth7DVd/OvXUHyjtVdB7REt1S+MquiwxRo992k
 avl8mHPfAtBb623RRJW3BL6+ukRCtmSCxX2PEoxwrrIiPyDcJYiJo3ocy1v3atVL2
X-Gm-Gg: AfdE7clay0167gNqLBItwQzHuTFBhGe7zq5aE+3TXgwD7Ov296ybbVS03nLFUmce/HZ
 plSSc+FPRBvI4Sn2gvVfmtqy1tMu+l4lmIrVGreV4ioSvUQ/P9Zmvrp3DcHqtGk+lfpLKEi7bPU
 lJfMh9ra0Pcp6wI5jxf+c9B/LIXaRNc6z8n4gGBX6sjBbUCoboo9dZUXPwp4VG2LdWENwt0byV/
 o+KuFW/to8OsIymh824cofUNAIfL07asH4jmsCFVSNGpi/dbVV7QWEaPesjZY56xUh6bEr8r1Xy
 ymp42ba00Ft9x+8Cp4m87VujavYJayVWVd9AdeXyTuhJh2FG7BaTRjoF6NeT7RSWOL3h9cK5jVh
 SQxqcmZg7VCKKiOFvpeSq5ENK3Q6W3FJnGdBRR8wolgPX0AM=
X-Received: by 2002:a17:90b:3c81:b0:384:d509:7274 with SMTP id
 98e67ed59e1d1-389415eed53mr10311433a91.15.1783658319891; 
 Thu, 09 Jul 2026 21:38:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3c81:b0:384:d509:7274 with SMTP id
 98e67ed59e1d1-389415eed53mr10311400a91.15.1783658319297; 
 Thu, 09 Jul 2026 21:38:39 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117462f5c7sm39788165eec.0.2026.07.09.21.38.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 21:38:39 -0700 (PDT)
Message-ID: <3646e43d-9bd0-43a1-a60c-6c5be128b718@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 10:08:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh-regulator: add support for PM8998
To: u-boot@lists.denx.de
References: <20260709-b4-pm8998_rpmh_regulators-v1-1-dd8efec64afd@gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260709-b4-pm8998_rpmh_regulators-v1-1-dd8efec64afd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a507750 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=wHiSyvJpv7uWxe3ZMKoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Kk56ogqysXo0lRytLgNli8sudRyPD2lu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0MCBTYWx0ZWRfX0T4/ex1S3Ndt
 YzO52Fn/V5hI+3/WoOd9yjEbwqQK8KLxa+jEdm5/AJMOY5rq9e10te/1+e32R4p5r9QS/y9RL/Z
 UL2CCWTOstONksb3nP6Tl5YfCeD3tn0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0MCBTYWx0ZWRfX+Ubs9NgHFLFD
 3pDhjc6Bo/mtzHw7EqD3o30aag8xD/XjUkiJHpr36nF17wWcH+wTHczFi5l2NIm8M2213um3oC0
 qoGZbJ7lUDylCpQTCY27vNWbLftI3c1UmnlSYynNDRXeX+xBncuYKWRJAhoDh7drGa0pQsgqim7
 1wV9i1AiVJbM5B+zG55oQhKu+KIsC32LEMyyeK5zvZLh/xygryZZL8S+LUF7wzeTpbYnls9HGw+
 gq5ESKzX1lMqsUJcQiQ3IDwAGz/VbbaqaogC1LW2UG/2HYUSFLkSFGWSq29aHayfi0rlcwpCumC
 JYhNq4DkfsfG5mz6hWNW+jybb78gAhWmnSQi5AjQq9diFdIcjWyKE0b59i8LDaGAV0k4QJd7KDD
 8FEhLdeqtxprGR2F0SoEX21+dt30DiOi6VpMWJqnMgW+yC16M/tP0b1h54W64vAVNY9NoiV7Afv
 eCvXt/t3iDitHT7q+wQ==
X-Proofpoint-ORIG-GUID: Kk56ogqysXo0lRytLgNli8sudRyPD2lu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100040
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Dzmitry,

Thanks for the patch.

On 7/10/2026 12:40 AM, Dzmitry Sankouski wrote:
> Add the PM8998 regulator data found on Qualcomm platforms.
> These regulator tables are imported from the Linux driver

Can you please mention the Linux commit from which you ported in this 
format:

Taken from Linux commit <short_sha> ("<kernel_commit_summary>")

you can do git log --pretty="%h (\"%s\")" COMMIT_SHA to get in above format.

Remaining looks good.

Thanks,

Balaji

> to enable support for these PMICs in U-Boot.
>
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Add the PM8998 regulator data found on Qualcomm platforms.
> These regulator tables are imported from the Linux driver
> to enable support for these PMICs in U-Boot.
>
> This is used by starqltechn sdcard.
> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 133 ++++++++++++++++++++++++++
>   1 file changed, 133 insertions(+)
>
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index c458f227bed..caeba4c8ee6 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -464,6 +464,26 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_bob[] = {
>   	},
>   };
>   
> +static struct dm_regulator_mode pmic_mode_map_pmic4_smps[] = {
> +	{
> +		.id = REGULATOR_MODE_RETENTION,
> +		.register_value = PMIC4_SMPS_MODE_RETENTION,
> +		.name = "PMIC4_SMPS_MODE_RETENTION"
> +	}, {
> +		.id = REGULATOR_MODE_LPM,
> +		.register_value = PMIC4_SMPS_MODE_PFM,
> +		.name = "PMIC4_SMPS_MODE_PFM"
> +	}, {
> +		.id = REGULATOR_MODE_AUTO,
> +		.register_value = PMIC4_SMPS_MODE_AUTO,
> +		.name = "PMIC4_SMPS_MODE_AUTO"
> +	}, {
> +		.id = REGULATOR_MODE_HPM,
> +		.register_value = PMIC4_SMPS_MODE_PWM,
> +		.name = "PMIC4_SMPS_MODE_PWM"
> +	},
> +};
> +
>   static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
>   	{
>   		.id = REGULATOR_MODE_RETENTION,
> @@ -484,6 +504,24 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
>   	},
>   };
>   
> +static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.n_voltages = 216,
> +	.pmic_mode_map = pmic_mode_map_pmic4_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
> +	.n_voltages = 259,
> +	.pmic_mode_map = pmic_mode_map_pmic4_smps,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
> +};
> +
>   static const struct rpmh_vreg_hw_data pmic5_bob = {
>   	.regulator_type = VRM,
>   	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -563,6 +601,52 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
>   	},
>   };
>   
> +static struct dm_regulator_mode pmic_mode_map_pmic4_ldo[] = {
> +	{
> +		.id = REGULATOR_MODE_RETENTION,
> +		.register_value = PMIC4_LDO_MODE_RETENTION,
> +		.name = "PMIC4_LDO_MODE_RETENTION"
> +	}, {
> +		.id = REGULATOR_MODE_LPM,
> +		.register_value = PMIC4_LDO_MODE_LPM,
> +		.name = "PMIC4_LDO_MODE_LPM"
> +	}, {
> +		.id = REGULATOR_MODE_HPM,
> +		.register_value = PMIC4_LDO_MODE_HPM,
> +		.name = "PMIC4_LDO_MODE_HPM"
> +	},
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_pldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
> +	.n_voltages = 256,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
> +	.n_voltages = 128,
> +	.hpm_min_load_uA = 10000,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_nldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_drms_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
> +	.n_voltages = 128,
> +	.hpm_min_load_uA = 30000,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
> +};
> +
>   static const struct rpmh_vreg_hw_data pmic5_pldo = {
>   	.regulator_type = VRM,
>   	.ops = &rpmh_regulator_vrm_drms_ops,
> @@ -837,6 +921,51 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
>   	{}
>   };
>   
> +static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd-s9"),
> +	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd-s10"),
> +	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd-s11"),
> +	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd-s12"),
> +	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd-s13"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l27"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l8-l17"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l3-l11"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd-l4-l5"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l4-l5"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd-l2-l8-l17"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd-l9"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd-l10-l23-l25"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd-l3-l11"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd-l13-l19-l21"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l16-l28"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd-l2-l8-l17"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l18-l22"),
> +	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l13-l19-l21"),
> +	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd-l20-l24"),
> +	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd-l13-l19-l21"),
> +	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd-l18-l22"),
> +	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd-l10-l23-l25"),
> +	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd-l20-l24"),
> +	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd-l10-l23-l25"),
> +	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd-l26"),
> +	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd-l1-l27"),
> +	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
> +	{}
> +};
> +
>   static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
>   	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
>   	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
> @@ -1010,6 +1139,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>   		.compatible = "qcom,pm8550vs-rpmh-regulators",
>   		.data = (ulong)pm8550vs_vreg_data,
>   	},
> +	{
> +		.compatible = "qcom,pm8998-rpmh-regulators",
> +		.data = (ulong)pm8998_vreg_data,
> +	},
>   	{
>   		.compatible = "qcom,pmc8380-rpmh-regulators",
>   		.data = (ulong)pmc8380_vreg_data,
>
> ---
> base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
> change-id: 20260709-b4-pm8998_rpmh_regulators-d167b8d9cb2d
>
> Best regards,
> --
> Dzmitry Sankouski <dsankouski@gmail.com>
>
