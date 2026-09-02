Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2FDC624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1817B40E33;
	Wed,  2 Sep 2026 17:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LVAF_6udenbo; Wed,  2 Sep 2026 17:22:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788369753;
	bh=Vsc6yAccQRd1t8+e1IgjWSJ2bJWOljCaYqv1XxQ7io4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAJyYg7s6JFsr9fOsVMO0zgUKEnfXg0AV8UzsoiUZWvcprMkYYjewYjL1G095cFM3
	 eWPpmQ38eNj5rt5HhL9Gmoozdp/iWzlp8NCfgp3QRpoLsh0ENtHln40X9gb5eCesEP
	 Dsaoherq2kvF/sqBUmYwezd1/ejaSCBxN9KeOVZrC0hORxic9GILb3hw96JzgN9f8f
	 I4GSkfpNVVEOnAJM7splnu2x2EZnIunTBcScJD1z1Ru+4j2++f0Rvp6hzw7rYELD3s
	 qoFvzTTeniQi3iYyD24f4gd9GmXq/qgk785SHktsabQSIF4KmwBsH3jmvilvPVyVhl
	 QfO5mDo6D52GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58C9C40ADB;
	Wed,  2 Sep 2026 17:22:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0284498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDE2C608B8
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:22:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGpPo5SORUM3 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:22:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=l6f6wr0R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Gm3ndRRQ
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF76160738
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:22:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HA2982389477
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vsc6yAccQRd1t8+e1IgjWSJ2bJWOljCaYqv1XxQ7io4=; b=l6f6wr0RbXyrywgl
 WVaX2S9MKCPUcZWD2U90AXz1mF5SQ4wmSHU4uh1j++5CuSypnXbnd+u2aXPipBlP
 628OnkCY2YQrFF4cp1Al8qU+BeTIEy7KMhsJEw7MKSONrbO3JfgVo1x9EODelWME
 FZ6fiQMNe91RnngUu7j4jW05oTU2jlxc7rZy8nEUCHj5pAT1uI8/MqdnO948PUD8
 xah8G4Bbp9C1SCKlXPSjCMkaR6kSbSwvd6C8cIEGtKRdwkQlI/l5Uo0sx2ksghBN
 nK1t3zykGkCcox7AuPNHG7+eUl/pvp5WNK1exY7YdkjeyN5BIEGVcJSGx4FtOhN0
 LHbhMQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh8yaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:22:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so1769204a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788369748; x=1788974548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vsc6yAccQRd1t8+e1IgjWSJ2bJWOljCaYqv1XxQ7io4=;
 b=Gm3ndRRQ9qKIq2TBA3Qeu+AaoUm87fYa074rqnfGgaJi0LNiWXUwkBbe5nb7ZaE7co
 Fm7RIRNiBhyAlHTYjw0b51pCt9I65zo0aXntJpNJURhq6DRuoXoB9u6rXICrWZ4hiX6t
 g+qx+xs6nJ9AdN7JD/gHMvbz2VsZQJVu8wfU3rJVss2w4qlJ534sw824Ur1hGTYv8Hsx
 OcVVHS4GaPoBkJ82JfxUXJreqm9aH2HJdpk1oEgRqOxSMJ9m55Zt8o00HxmbOERbH0Lf
 pb9rMn1rkt3EFw09RmlKtJ5xiyFyhbNaOMTgkuDHzriW1j+hru8P2wDzazl0OT3A+Cox
 tLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788369748; x=1788974548;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vsc6yAccQRd1t8+e1IgjWSJ2bJWOljCaYqv1XxQ7io4=;
 b=mwo3QMWEzWor6aKODlBr8e/opuLhu0phAEtN8YJ79Cjfdpe9E2tdudP71urzKpeSDq
 YUP1X22Gw1whrkgf+5zTMCScu59uwrWZBxi4/XpcYqvSdjvLcLZmvfc+3ZzoLeLp3j7D
 vnphiEPXVOrJIyKRHwBROQIdYs3yAQhuMp2WpzLmK5NvIyaKAUC7rvfcELVUdyg95jNc
 khXk9tQE3spZMznFUCHM6E+T+z1l8FQDOz1VO3+/kVROKEpqriy/ugEf+M0Fy61HzJDK
 jLaCc4Kd8qpMMnUuy8hPKOA1cttYSusws3VPdggBnXq31GJQ9wwaj5yi4zWmnrDoSIGY
 Dk4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBywZGEve7X78b8a0kwXxnyDouoGMT5INZW3fDjAoGZdX1jHvW1a1ERCw99I6Bb4UpCrrAqo2mk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mPiJ4CCxMC4xAHpoJvtDlk8pQFcUh09GDuqgCNRH8KtfvfCKEa
 bLaAtvXRg+Pf4zIY/L8EZ0zxpfstTcRcDHiH70oboZnqJNSkfQaQ1LmUpFHEwAHIVb3EIl97jwS
 3G1NqMQEPOXgkUEO+BQiai8RSaZQMwSdvW5xr9nv1rPXrv2tj4HKckbdM1b32eRd45EwTfVHvPr
 rhWFA=
X-Gm-Gg: AYBFou1uwK7ypqlvaGF52u3xN7I8Y1mk56zCqFz1eB/swI/7p3ElrttT7Gn7gbyojfc
 V1MlF35MlIEK+pqXlH2FuUSo2YIPGPI8tXTlp0oD3RB+FpHiV12uGBPTmlL6OpElOzeoFk98pEu
 y/IQk8WlR2xaQQMmaAxtqGc/GYDZwdKQVedtYaWixyu6eKNXP8vJidT7/tMlXhjFPVQbXq2OrhC
 Oz+GVnTqpM4wVRI3NpDTlVTLUGnRKJt6v6K3RF8iSVuUykkWJoOyfO7FCu0c3LtINpy5xFp0CfA
 feR6fkXGa2Y+Tr73nC6HOra3JioF1to1vqYUB9TdypDKDo/VAMQWUkqYJXeH7rp549zwrtuAflS
 HBJEfBew2KfhiWMinEP9S2ZCPbWTwNu67+BancQ==
X-Received: by 2002:a17:90b:268d:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39aee023191mr10719177a91.10.1788369748539; 
 Wed, 02 Sep 2026 10:22:28 -0700 (PDT)
X-Received: by 2002:a17:90b:268d:b0:398:ab03:95b2 with SMTP id
 98e67ed59e1d1-39aee023191mr10719092a91.10.1788369748031; 
 Wed, 02 Sep 2026 10:22:28 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.206.202])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c0530sm7786239eec.3.2026.09.02.10.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:22:27 -0700 (PDT)
Message-ID: <e52ea60b-193d-402c-a03a-62aac8df5b55@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 22:52:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Remove duplicate declarations
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260831204253.1382974-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260831204253.1382974-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1m1vqy68s5qaMcQmc0Yk7L2wu4_DUjfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MiBTYWx0ZWRfX5zrHy6olyMZa
 8K/6PTuslqOoWTas3yz/Eo8DoTE9oiWlFWu9lqWMuxQ5IT+bvL7j3qfQWnFoW2aeRe+W5Aot3sD
 3+YlmqvqsAWNdNDXV4ijTAoqZ60YzJYyn6bV74r46hBGM0kGbzbePxwjVOEoVE/OC4Gg7z0ls/z
 Zycyt5fwlUEEZ2iVKNVZsK58/HdNqoBzyP8YavYB5Rxqmb/zV/cvL1Otzi+pT4v/pf8EITcHwCB
 HJJmyzfqBShB+UYL6duXnly+m4ikQzwQDPVa+C3fbf4zX+BTRhxh4H2jCh0i+fY83UN5licN3OI
 KJmfjHvpQv/H07gQ2ISjOu2khON0zyCs9zGmILWUCARHY2DEwesV7/U+lqoTZzOK2wPpg8y7shl
 YuI4cZwla0UuIIFC/P2BH9wbXipXNBMuSIEt/yL/OaPc9wF9SNrbwq9WRE68EE4CMqE7sDL2oUy
 by1rKCfHEPpx9yiA8Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MiBTYWx0ZWRfX4bT3MOyvVN/g
 uxH/3bLeBWv+2at1h1xUPlaylN4hVbrUertnXUDl6T5N2h4aGffsWIKn8T1ZTHmijR/zCkw5t25
 3h3A8kBdby4RLYT2Hw9w4ZGxc6IuT1Y=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a985b55 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=yprIirTdMnYkynrOz0ik/g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=n6TqUeAhkInX3lDgiREA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1m1vqy68s5qaMcQmc0Yk7L2wu4_DUjfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020152
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

Hi Ilias,

On 9/1/2026 2:12 AM, Ilias Apalodimas wrote:
> commit f4bbd7b9faa4 ("efi_loader: Separate device path into its own header")
> split some function declarations to their own header file. Remove two
> remaining duplicates efi_dp_from_lo() and efi_dp_concat()
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   include/efi_loader.h | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3a4d502631c5..ef25124fd84b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1026,11 +1026,6 @@ struct efi_load_option {
>   	const u8 *optional_data;
>   };
>
> -struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> -				       const efi_guid_t *guid);
> -struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> -				      const struct efi_device_path *dp2,
> -				      size_t split_end_node);
>   struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
>   efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
>   					 efi_uintn_t *size);
> --
> 2.43.0
