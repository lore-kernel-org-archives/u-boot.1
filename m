Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5298AC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C2A81FEE;
	Tue,  1 Jul 2025 08:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rc+ILkD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903FE82ADA; Tue,  1 Jul 2025 08:46:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6DE8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5612rwcI007345
 for <u-boot@lists.denx.de>; Tue, 1 Jul 2025 06:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ruY67JCAiI9jVlz9AJhRMV2xIIxOLNqVWDuyApmoOtY=; b=Rc+ILkD3WYxsHrqd
 B/0cAYvhYpVHXVfcsnNpwGZEKqDDjw8c8aEmNOsEYge4h4qm6N4Fh0aDmgN7RMrF
 x9/Feq9VtnU05hVk94lqsywe+B1ykfN0J7Z7p3tKO2oVrzJFbOx+3LTZiKiP4gO6
 BjplCQrqm5pigtWGWofEVilVxezHKk1e1I+qp3jYWDsixgXb7llbiR2FKDmkKLUS
 BuLmbRk6sygs38gdIOqLuAExYfK2JMx/lnE8mIWcU6LA0cBvDU245uBvrbze1uEM
 elJE1F215n05gDnyJoCT+JJ9L/X1dN2zP9wdKqCr9A1un9kC2Cysj5ikufzNpw/2
 XwvH7Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jbu75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313d6d671ffso4890085a91.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 23:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751352357; x=1751957157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ruY67JCAiI9jVlz9AJhRMV2xIIxOLNqVWDuyApmoOtY=;
 b=HxZT45t2Jkdd5eVxAWgLAwnfESyhdFuKX5Fon1TdVmAx9wvZoKRygHFPrDKdRakUc0
 aEvw9hzPCV3uvwNzM0fhKR7sCBCXPBIaewjYQyBoFhgv9wVjXa+b+ByQ1TXaggHhZzPa
 WwddiJ4wpmUcvh84ls5iPeAhDbZfZ3m1KXCf68Y2ItnzE8yvkOTxokmfrOZO2QB1qkdT
 6ChkS8FV+FC3UtNJkDtdteIGvVYzwcoqtRTKbPZrh2NPiqiyEMie/E3CAh7vpcyrdr47
 pLRNd2UPnM2SbZ2HC1+zB7jDpxyDbKrKXWKZHvfs6jNVmvkK0K/ifK5QBtzo5cXaStf1
 DExg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEwWgxNztUOXJv/WyqpRonfeBG9KTxnazodhjr5pztxRIwB3cfq/AES5M2OOUJek5td9QPm9M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+U7TxOghQ0aLwVWp4hHJ1FSPLAOzS8IWQ8g7Jnb8cvAIrgIAd
 ahCGU1cw7YGEWFtBw85bmGSPF4Bqk1NynqXukArUh+GMuQBMQKvSV9vRPuPc2kY5cRgUTrU7LLO
 4g/Q9IicNaLlbZruh1L2H2UcGy+uO0xwfP/F7oQ81SykXNVy8b/ykvGn275a8ZPGm
X-Gm-Gg: ASbGncvWb10YTvAN9Yx9T6oEEDPe4pyLgpIpA6AAAPZaroPhnIgOKNfrxrkXp6juVuM
 FsfIpMECaOp/KcVXDpAK9MWtZcTFwdw/Ex7Vx4Y1d1kQ0lB51pveLv77J3ROXlgDOODd/C6QtBc
 Wuv/BaIioi06OjBY9Y1thwYlYvfrtpPYthvGiQUAivgeRo4mJYhJdnkuBaldYU6mujt8EJqug66
 +SkwSV3O1kZWQgCRAMv5/HPhBdVx0NruZqX20ezGNvIEyPICPtq6viFqigcTYSwyXQh0iaUXHV8
 PNkH+eGap7dfq7WB0KsqtWKfVvElbgu18uzy6DZ6uKMjtEXIW914gdOI
X-Received: by 2002:a17:90b:47:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-318c9256c7emr22369961a91.28.1751352357588; 
 Mon, 30 Jun 2025 23:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbHX2fKVKjH/53LKpMoTFwTlLv4ztb1c5ujSkrV6ThmSevgBGG+gzohQmUobC5cSo7WJtfw==
X-Received: by 2002:a17:90b:47:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-318c9256c7emr22369929a91.28.1751352357139; 
 Mon, 30 Jun 2025 23:45:57 -0700 (PDT)
Received: from [10.152.199.49] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318c15233d0sm11110460a91.46.2025.06.30.23.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 23:45:56 -0700 (PDT)
Message-ID: <9b43ff3f-f675-4438-bad0-84d002b1a9cb@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 12:15:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] configs: qcom_qcs9100: Fix fastboot buffer address
 for QCS9100 board
To: Casey Connolly <casey.connolly@linaro.org>, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
 <20250630070040.734486-3-balaji.selvanathan@oss.qualcomm.com>
 <537cb674-3ba4-4b89-9ef5-86e430bd32c9@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <537cb674-3ba4-4b89-9ef5-86e430bd32c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68638426 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=U3gpzu9_dvxQk06Wa3cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Cb83iyJhwyHS4A4_mzGtfKe1VpdwzdkY
X-Proofpoint-GUID: Cb83iyJhwyHS4A4_mzGtfKe1VpdwzdkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzNiBTYWx0ZWRfX49AGyblO3IGB
 JxqhnFaTmsbhi2XL9us2P7bvyVyMZpIbZCKLXJzSHmvbPUFgOJJldxC8SrdItP/aFnFvij9N2Z+
 iKrTFflmOSbvghdj3aInoOoSPz6NngEfU8OEJIaKgz9HqjaTW+ogJjJ0q17lY7ufBIsotxD4qFc
 9btzErSR2MKUhl+34Jd/tZyQHUgwRV2EJNdu4vCtzK7d406c/X01ZAg8UUAGgJIFGlVt2QdELOt
 WLI/nUPSOwcooP8n6aJkyUCdFXXwI4/8Nv7dbJzOfVM+WsozvZW70fWv6TkNLyaCb9O7W3eVGkO
 hWglh8Gsl/YICyK7YUUkD2k7rgpDDF2PbrONMmo26RMk2LfiOu7zIccD7dL0x01KLDieSKNYef5
 +jWuxslCnnFoICrOxcXVfnxA7WPwO674pEgbsMNceeJrb7elPnt2KQJuPOQmx6igX1j8zuRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=972 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010036
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

Hi Casey,

Thanks for the detailed review and context.

You're right — I had overlooked the fact that the default environment 
already defines a fastboot alias using $fastboot_addr_r, which is a 
safer and more flexible approach. I agree that relying on a hardcoded 
address like CONFIG_FASTBOOT_BUF_ADDR isn't ideal, especially 
considering potential overlap with LMB-managed regions.

The crash I encountered was due to the default value being 0, and this 
patch was intended as a quick fix to unblock fastboot functionality on 
QCS9100.  That said, I’d be happy to look into improving fastboot to 
prioritize the runtime address if it's set, as you suggested. It sounds 
like a cleaner and more robust solution.

Best regards,
Balaji

On 6/30/2025 9:26 PM, Casey Connolly wrote:
> fwiw since you're using the default environment
> (board/qualcomm/default.env) it defines an alias for the fastboot
> command to use a region allocated at runtime (which is tracked by U-Boot
> and guarunteed not to overlap with anything else). At the U-Boot prompt
> just do "run fastboot" to execute the alias (which expands to "fastboot
> -l $fastboot_addr_r usb 0")
>
> Ideally we would get rid of this workaround and instead teach fastboot
> to prioritise the runtime address from that variable if it's set.
>
> Hard-coding the address like this could cause issues if it happens to
> overlap with some LMB allocated region.
>
> If you have the cycles free to fix it properly I would be very greatful,
> but I'm happy to take this in the meantime.
