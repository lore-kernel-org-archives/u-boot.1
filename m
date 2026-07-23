Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0121C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 07:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD14A6073F;
	Thu, 23 Jul 2026 07:11:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zk6qQGTA5RvQ; Thu, 23 Jul 2026 07:11:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5D1160715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784790690;
	bh=ef5uYKV+rzB5EX6iqhTwhcr/KL08/5qw/tpSE61NHhU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DctXBsRz3uAC3hTcssXE23V6338WydJoz4Ol1Xobd176apoePy/bEPqj4LvFsV2XG
	 CjXxbSodH0jO84Uf1s9xU42zxiHU8Fj9I4L9EBSyAlr6fLAvGWdgn6i77iE3xTz+S4
	 EQo+MhKnkaOJetQdzsUCjJqKlJAOBiGch5V06bERZgTTycyfn4QXnkWYah6kluHAv4
	 J2rT5GxX7grrGdrBQk59vwJYvI6HDDea1qhDtp8cXY8ZJIpBaQpmNCInHc1WvDYWb0
	 5TuZtxv82ISv+qqTwBNlLUPbAgRWPNjazgEsd3Z9bfaXxedBGogFVA6Wgl8ifk3ZU2
	 qp+XAX0Yumf8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5D1160715;
	Thu, 23 Jul 2026 07:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E92B39E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64FF360708
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mb8FxsuaPyVI for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 07:11:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 406F8606CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 406F8606CC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 406F8606CC
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:11:27 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6AdWa3115847
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:11:26 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vjv3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:11:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so7023625ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790686; x=1785395486;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ef5uYKV+rzB5EX6iqhTwhcr/KL08/5qw/tpSE61NHhU=;
 b=Is+YtU+a0pbiGLcI012WAjWotdoFUTKkKvLiHFxWs9SlwYArVzOb/4opnvIx26It/X
 456ndHrHAi5AbVujrOJkyLEgUA1+ZVYlr1clAfJvLm1pnxitZEoSHKjZNFSjJPko+tJA
 ywCK+5XnNRZluQfjXub48rtWyTSzILBYREM3iFzVZYnBNPPmxp6HZg7OMiUMOtbuzSEy
 ytrIrioMBIQZrmdEPlFL3ZxzAG+eAuUZvcpOt7ds3aB/GPf8Q9+z3ZbwkR146LKM0eZg
 blxodiLMwIN6p6ycXiIUkGDYkpScSnFfTWDf0/tZqNO0j3Z0to/fcgYGUYxy3cG8EAAh
 DJJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZV0xV0xw3UEr2PgSqhZUvW/t2b5rSKu9dESTuPGYMo/HvHGrZ3VFKIEEJ22KejV3J2oV+RwQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz/qeb61Nd6VFgwTtkzQPX1EPplJP3QKMytcq3KenxfcaWhZVPb
 +gWCHW693kA0CPpMwg0YNuUXITKI4UBkG8oi4Vw3veR2IbvefUS5935ZmieX8Nctcf1SMmCaif3
 xf6lA8YUuRv7DMfuECZUFqSoQcNfRfR5fyoVqu8CJ+E+nW8RSa55f74dEqRuQjE5W/wQ8+5U=
X-Gm-Gg: AR+sD120ussi9Jbl4vAeMCQ2mqQ2U2lFkxmfgeYZZ+3UqaB/vMyhzudMwUmx03nohjp
 ++pHcDJtSQVxs0VuCXjnWgp7rWixSN740KncFE6aM69YwD1QbzT6mXl7d7Arkt5Bb8gtFtOrjKj
 KssTgDEfXQRW1HIcnwVd984GzTp+tCzC9Tgo8pR/vms6LMJmvvAZkC/Wzfv+8Grn45FbYTVbJvN
 eIY2Ee9iDZG+pPG8w+D6awTvBoHSqBGys40qjir2jaBOaVCY/7yuTCIhndpOHonSIyJlcCAGZUZ
 P3R4XIUHHi7+uQJbBKC9m7lZg899WVq6FrT77Gbvv20WmNXSth+Xd0xbX93qsSPIQMTwPYEMdad
 6pSLUEByjpHMHqN/5YvoxxxGXp7S1JXzVbm6gAA==
X-Received: by 2002:a17:903:2449:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2cfa6bc1948mr23581555ad.20.1784790685759; 
 Thu, 23 Jul 2026 00:11:25 -0700 (PDT)
X-Received: by 2002:a17:903:2449:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2cfa6bc1948mr23581285ad.20.1784790685291; 
 Thu, 23 Jul 2026 00:11:25 -0700 (PDT)
Received: from [10.151.41.190] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e0818e4sm16566435eec.22.2026.07.23.00.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 00:11:24 -0700 (PDT)
Message-ID: <31f50fc4-ecfe-4e8c-89d8-7d7e90139e4f@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:41:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
To: Hari Prasath G E <gehariprasath@ti.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260722-lemans_emmc-v2-1-edc56ce7b768@oss.qualcomm.com>
 <c1278a52-9499-4a28-bd1a-6b9de603763a@ti.com>
Content-Language: en-US
In-Reply-To: <c1278a52-9499-4a28-bd1a-6b9de603763a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MCBTYWx0ZWRfXzSOBJZx9oFpA
 ZT5VJLzfnlb1P7hm9tuItQmNHp1u0FNav/8cSS4dFp+zAxqfy6ndd0mkBFtsDZm1c0TyfomReuP
 Tqe/Pl+b/z80Mm0z3Z3Mk9eIeRLO/jA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MCBTYWx0ZWRfX3gW1dy3vB2Rt
 Patkp4BRdKvNfR7Z56wLwmDUjw4SWAZlYWNqudaqoJqtnBDqg+yrshVcZrtdsBOEkMtX/WrRaMy
 t4+ZXr3FnZAvX/Vlu4uG8m6ArinzgqiFExQK5zYR2xTOAVEY2h8m9ORV4ncN+2EXV3QFjByY9lB
 ANp0ekC9Ke4JoMjx1xB8/VQLgPMsnwwuIht1naU6h0lsyZjhWSLmiLzy1bolTos6+t3aV5EuY1T
 gnn28HcXzKjVvCf3bIgqoDio1J4pEQHXGxHH9MdH7xD71cc2JRskFSticDsyUJHtg6B9HhupTj5
 ezsLO5Vasp1qqq9kcgkYE2mLSE6vHhJmNQ9NTLDEzRgNQSFLPetrKyMGYxKcTu0JnjMaga/rYgB
 RSPHRZQe9mXAffKZwxATnxAM+SSIrr0mhx4fBPobkdqqiB+Xb0zmJiDKyvRYSB6rmUVwUPb18I+
 giEmIymQ5OC21A5D3Rw==
X-Proofpoint-ORIG-GUID: g7uq1JycGsx6S97dKWELIXEkjv-ocY6U
X-Proofpoint-GUID: g7uq1JycGsx6S97dKWELIXEkjv-ocY6U
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a61be9e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=mJjq1tzzTSlCUViq0ssA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ef5uYKV+rzB5EX6iqhTwhcr/KL08/5qw/tpSE61NHhU=; b=M2nYNI/DbbqeC906
 TzKmIIpeOxS1sDOxEl08zxEeN8P9RyWACz2Mpxt08tx0jl+if95Fb7bpsSVQCY2X
 99jJo5Y23shh/8Fzm5Ovv0Z/GaII/ixA2n2W0TeSp4zgN41PE+lk8DTkaYdLZFAS
 fnW7HGMgFFB5PKAz4xgYHKQDJBN/GNZKMcU+sDEpZymYuU2Cu5U0O4GUFo4mn9mP
 DNj7iCHe+tYH/myMBDbrt2RRsTHMQCagWbgqNDA1bp5jSsnZTg5ZPs+q+bHrzEnb
 xQU3Outj6X7gTcLiXj9yq8bY7P9sc0I9/0qfjz7/+DeK6mYpTKPQHTZtgHmMYUj5
 Klb9ww==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784790686; x=1785395486;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ef5uYKV+rzB5EX6iqhTwhcr/KL08/5qw/tpSE61NHhU=;
 b=CHGtoOs8CdatiGqbt5O1DWA0KFOPqOZCFfi4KiJsdJxOcNPo9xw0ZpViZv+hvg/cgX
 BeMbGg8yp85e+i0ozsvyd8nTYvi5Gn9Mi1ecarJfa8xfiRX3eppgGM3Tmzy5/aOp6ASZ
 6SJaTaplWclbWJ5W2+n9HYoaTyuy07i0CdivBY5RI/jTsiG4gZav2t+eGuNS8ze/0SxN
 MmnKQ0ecAql92OCEXXvxSlb7Sons/xShHi1iOs//mZOO8IqpCThqfuejXm61/KlbKfIi
 3OjCUzJetNy/LhgW1gOfn89Sf3IJEDQAQKh11/7RVnEi5ah8rzcBveDMQoXuE1FR8Uxl
 BEiQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=M2nYNI/D; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CHGtoOs8
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

Hi Hari,

On 7/22/2026 10:26 AM, Hari Prasath G E wrote:
> On 7/22/2026 10:04 AM, Balaji Selvanathan via U-Boot wrote:
>> Add support for SDCC1 (eMMC) clock on SA8775P platform.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/clock-sa8775p.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clock-sa8775p.c 
>> b/drivers/clk/qcom/clock-sa8775p.c
>> index 7eec4aeae48..a5e84ffba7c 100644
>> --- a/drivers/clk/qcom/clock-sa8775p.c
>> +++ b/drivers/clk/qcom/clock-sa8775p.c
>> @@ -74,6 +74,22 @@ static const struct freq_tbl 
>> ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
>>       { }
>>   };
>>   +#define SDCC1_APPS_CLK_CMD_RCGR            0x20014
>> +
>> +/* SDCC1 APPS clock frequency table */
>> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
>> +    F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
>> +    F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>> +    F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>> +    F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
>> +    F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
>> +    F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
>> +    F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
>> +    F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
>> +    F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
>> +    { }
>> +};
>> +
>>   static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>>   {
>>       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>> @@ -94,6 +110,7 @@ static ulong sa8775p_set_rate(struct clk *clk, 
>> ulong rate)
>>                        5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>>           clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 
>> 0);
>>           return rate;
>> +
>>       case GCC_UFS_PHY_AXI_CLK:
>>           freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
>>           clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
>> @@ -112,6 +129,12 @@ static ulong sa8775p_set_rate(struct clk *clk, 
>> ulong rate)
>>       case GCC_UFS_PHY_PHY_AUX_CLK:
>>           clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 
>> 0, CFG_CLK_SRC_CXO);
>>           return 19200000;
>> +
>> +    case GCC_SDCC1_APPS_CLK:
>> +        freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
>> +        clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>> +                     freq->pre_div, freq->m, freq->n, freq->src, 8);
>> +        return freq->freq;
>>       default:
>>           return 0;
>>       }
>> @@ -169,6 +192,10 @@ static const struct gate_clk sa8775p_clks[] = {
>>         /* EDP reference clock (used by UFS PHY) */
>>       GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
>> +
>> +    /* SDCC1 clocks */
>> +    GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
>> +    GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),
>
> As per the header file at [1], GATE_CLK appears to be deprecated. Can 
> you verify once ?
>
> [1] 
> https://elixir.bootlin.com/u-boot/v2026.07-rc1/source/drivers/clk/qcom/clock-qcom.h

Thanks for the feedback. Corrected this here: 
https://patchwork.ozlabs.org/project/uboot/patch/20260723-lemans_emmc-v2-1-f6e679e58fe0@oss.qualcomm.com/

Regards,

Balaji

>
> Cheers,
> Hari Prasath G.E
>
>>   };
>>     static int sa8775p_enable(struct clk *clk)
>>
>> ---
>> base-commit: 042e45e026c77227319a426940577856ffe62e7b
>> change-id: 20260721-lemans_emmc-f2ccc04e89d0
>>
>> Best regards,
>
