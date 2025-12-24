Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893FDE74903
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 05:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D571C841C8;
	Wed, 24 Dec 2025 06:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cOeefXpy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ehWsJpCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4B1841C9; Wed, 24 Dec 2025 06:56:26 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED2684198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 06:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BNJre7V721901
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 05:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zhoElWWa8+Uevr5X3Xb1e65vi2BYvld0rW6SokVjVmc=; b=cOeefXpy5+WqyW0m
 Pq6c78tfVuH9vZA/3ORsa1aveJXM5o21BAfGo3uvssZDkeXd8Cl14Fl3zmm4eXHG
 4eF5Y2Ib21tJREQYUls4rtwYhvrKyPWio7baW9ATOWhe0axs4Js2jcuG646nxRh8
 STWOOS84OpjVl9EuFPK5a+uXXHLoQ0p1Wn8lbx9PrJkYUE5BYtqQBwkhze6VAQR0
 uwai4GVFyt5im5iPNjGLB2T2UB2tJBmG+PlrhDLO9Z7BOsuHTAMXHIpwX5Tfh+oA
 AcPDDfS64xiZFBgX1eiEmzyu9mE7yLGyYm7E4BhK3fvybaVR0am8ZYlbj1qWEiRz
 FIMOSA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b81mt997b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 05:56:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7b6b194cf71so10609133b3a.3
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766555781; x=1767160581; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zhoElWWa8+Uevr5X3Xb1e65vi2BYvld0rW6SokVjVmc=;
 b=ehWsJpCEmcJ9XfiRwuLWesaZGeYU6pXiR+3DmBkoycsAp2UV0p//yhZVv60tynG9gl
 u+r7QwzmXIF0xdYWW+aYuHwRkEjxNG4fpD9UIlhiYJM5GGUSxQ/QLJs9i/3kJ3bdP22c
 GREfsAjeyiLPBtTTDd2CtcdOnDr/EQBBnY0Dl6Jn5RDW1mGfKCiMhQxBUfVnZgnzzt25
 DwN5MOvN455Vti90FKLCZIW3ZAAkUft/GOsvZY3aJTyzWUlpzJwV5MCUCV3A5QobLNoh
 ne+LGe5LD7fdSxiec1qfejfue6Rzx+pYwxtrP27+kINNjsCoSN1e8imvht/N4PBxLgjf
 iOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766555781; x=1767160581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zhoElWWa8+Uevr5X3Xb1e65vi2BYvld0rW6SokVjVmc=;
 b=tThHp2iy8LAGg6JLdqWHJscBhAEnEppRPTIMP/NcdkQClrpDlsMiewTvS7kZ4bpE8p
 qjmxzZQd+5VEgr+T6UwdDuRW6/5eiucL1792O/jBcAvMguxO+TnnspGJuDXRi3wBSkoG
 3QS98QXN03BiqfU4M/Dtxuo+b4XfomZhGyOLCPCD3jCVJ3JRnA/lmsLbs2Qtufn+cpgd
 2NO6t1/87q7JhGHwatoLwA692GEACT2xDjiDbAeoMWwM/kIa+p4hSV4a7un3bz9AEGrM
 +C93Raj3mxCZkK9iBNRfe8XDCS1RtwYzXAbtxwvE9TSnT+AmeffK5dGaTFUJnZLT8mhW
 PoTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJUCj2kovwe0xGJfEzGjCmp2u2j1ClkC+5AzEEIdlf7xvpviw3MW07VNb7xVOUpZkyt0yo6a4=@lists.denx.de
X-Gm-Message-State: AOJu0YyggrZxV7e5Tzn9V5VHoFgyAFhBNyD2U659MCvacHHMdG8+l+Tz
 yl5hGsh1WESQQ75sJwzyBuXR5uwubtjJ3VEblPlmRbasnRke6MRZGP8msaetdqHv8lJq3rZ742o
 c5+EBtKMd3MUg5nvLY9P0q4542b+ldq2mCHJS7/TWXNWL+C5gsPrR2PJ4
X-Gm-Gg: AY/fxX7fqlbPl5VHvta0SueGlgUZupubNO9CRFaT4b70h0W8FQVYQNANmgBBnvbAsKn
 rJkXk8QAqMHkZvpi/U6d3MoWEnX81ZoTAhQdkABlkTJj0Qg2xqCZEUOFUSx/bGV2m2ztsZbQR3l
 QUF5D0MA1bwyhx0FPi1kIywEsFVAFediTmebdFMGTDRZCvGWO2bbARnE4yrCGeJ9NCrfInnpTVS
 RMpL4lbiYx0UMRPHiNwYdf2k0EUCySF0a7MMUSckUQqc8WV6mLW/mLp/j44oLck/FN0e0JZk+da
 BV4YAEanMRdk4Wzovv98XR74VeuPMChwZpLmxNurc8U7T2zLtbDjvYGyugIo6x3UpupbIJf+0cd
 oeq2CM3CvuS2Jq1O9FStPj6v+za6SoEZkCYufrsZW3kzA
X-Received: by 2002:a05:6a00:3489:b0:7ef:3f4e:9182 with SMTP id
 d2e1a72fcca58-7ff67965e2amr14304203b3a.47.1766555780941; 
 Tue, 23 Dec 2025 21:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeN3bhVs3HzZPU/W9jpg8b6siP9pWF7tINvk9wdjMvogKMinbOBF/A6EJF+M4E+s3TQQSPdw==
X-Received: by 2002:a05:6a00:3489:b0:7ef:3f4e:9182 with SMTP id
 d2e1a72fcca58-7ff67965e2amr14304184b3a.47.1766555780472; 
 Tue, 23 Dec 2025 21:56:20 -0800 (PST)
Received: from [192.168.0.4] ([49.206.97.85]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e792b65sm15705026b3a.58.2025.12.23.21.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 21:56:20 -0800 (PST)
Message-ID: <bfba5df8-9694-4ae4-b378-1a9bd81d11fa@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 11:26:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drivers: usb: dwc3: Add delay after core soft reset
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com>
 <aUpbSgCIdKgtoSyT@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aUpbSgCIdKgtoSyT@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e/ILiKp/ c=1 sm=1 tr=0 ts=694b8086 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JW2Lu2jpSntHb7XTMG7kdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uG6YFZaCsW4n1m2m4s0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: _uJI2aHZ79WnfLQUPirKdrNoswNYML0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA0NyBTYWx0ZWRfX+U5sSwjmJl2b
 37PTj5zrzxA954q8dHcr2CP3nVheDNjhKHpvxmW5qNiI9mTuqQjds21Oo09EvYIrV20DVOOhKpx
 mzKuJCurogbOulDJ4iRcxlAbj01xoxfw8nHQNNB8rdniRXu1bArdE3Ggt+QWfYE0VQccGu5JHAn
 490S3IhlXX5HyNA9xo7j/wosZE0wqaX2nJem1W+I+TUfgLsHWTfrYcgP9LRh+kvYLEvaGtLgZSy
 8677iiygYEHFVdPluP66I1//k8eTTStZXbvNXijc57iUkiRfRe6o9z2PU9yryEhLRdWkckhQO35
 j9F0Io97ynRw1h9sgaig28a2uohI1P0PS1sRLGoYPrFnUFGktZUC37EK4n4yghTkfEWSFHieOfr
 WkzJ9k1NmbtzUYulMbsifKuNzGolzBvo5vmuyXhn2mDO6INqCtG+FqGLKylvc02aJiNQF3a8XkG
 jaki5r6XgYKZ8z2e17A==
X-Proofpoint-ORIG-GUID: _uJI2aHZ79WnfLQUPirKdrNoswNYML0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_01,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512240047
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


On 12/23/2025 2:35 PM, Sumit Garg wrote:
> On Mon, Nov 24, 2025 at 09:24:58PM +0530, Balaji Selvanathan wrote:
>> Add a 100 ms delay after clearing the core soft reset bit to ensure
>> the DWC3 controller has sufficient time to complete its reset
>> sequence before subsequent register accesses.
>>
>> Without this delay, USB initialization can fail on some Qualcomm
>> platforms, particularly when using super-speed capable PHYs like
>> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
>>
>> The change is taken from following upstream Linux implementation:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0e8209ab7d6620085f3441d9
> If I understand correctly the kernel change here especially following
> comment:
>
> 	/*
> 	 * Wait for internal clocks to synchronized. DWC_usb31 and
> 	 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
> 	 * keep it consistent across different IPs, let's wait up to
> 	 * 100ms before clearing GCTL.CORESOFTRESET.
> 	 */
>
> the delay is required before clearing GCTL.CORESOFTRESET and not after
> which your change seems to do. Also, here we aren't doing any role
> switch too, right?

Hi Sumit,

You're correct about the Linux implementation. However, in U-Boot's 
case, the context is different:

1. Linux: The delay is during role switching in dwc3_set_mode(), where 
only GCTL.CORESOFTRESET is toggled.

2. U-Boot: The delay is in dwc3_core_soft_reset() during initial boot, 
which has a more complex sequence:

    - Sets GCTL.CORESOFTRESET
    - Asserts PHY resets (USB2/USB3)
    - Waits 100ms
    - Clears PHY resets
    - Waits 100ms (for PHY stabilization)
    - Clears GCTL.CORESOFTRESET
The additional delay after clearing the reset bit is needed in U-Boot to 
ensure the controller is fully operational before subsequent register 
accesses, particularly for super-speed PHYs on QCM6490/SC7280. 
Otherwise, fastboot mode is not working sometimes (stability issue).

Would you be okay with adding this delay after clearing GCTL.CORESOFTRESET?

Regards,

Balaji

>
> -Sumit
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> v2:
>> - Gave correct commit id for linux implementation
>> ---
>>   drivers/usb/dwc3/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 847fa1f82c3..ff0bca0dd8e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>>   	reg &= ~DWC3_GCTL_CORESOFTRESET;
>>   	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>>   
>> +	mdelay(100);
>> +
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
