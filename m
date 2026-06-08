Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C88CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EE783EEF;
	Mon,  8 Jun 2026 11:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWvGq44C";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXSQMtdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBD9807C4; Mon,  8 Jun 2026 11:07:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ADA846D3
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Ot4Q2832922
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J5/4Xm9v+3gsGRRue1lVqK96Ft2W16SO2RYj/trVU0s=; b=LWvGq44CZVXAoZG3
 8lxNkGiFSUUfgGvTaWMjqsEK1dUTT4346+9GgU/W/KEpB4jwajuS28xy03lC6dAr
 7Uo7B24nvhS6UAkkMfHoqdM1qlOI86c+xPKLR9yO0F9ZXAhZnvpjYqAP43GQ4cfU
 yxni4cCQeylvEVR/XX2Z/TxqQSuQO8Hu8HuLxm/2RBgVQv6sD921aQJSWpqxlLAG
 fDG2s4hZob7vdeSOYWm/+cYTqZo/2VVKODM275mlTbsD5UhTXeWXaHJRZ0OZ5KZQ
 sbn1CTuMbGpW4ql9J/BIUb9hAruf7FnqyoLjpsl8Yq4EG7v5oGZ7Bd6k3tJf/l5q
 swkC0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrf1tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:07:53 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d979441eeso3588240a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909672; x=1781514472; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5/4Xm9v+3gsGRRue1lVqK96Ft2W16SO2RYj/trVU0s=;
 b=NXSQMtdWbl6KltAGA8IFnWavsyKJqoiBEv3F01Wx7fgmn/MS450+Hm+/7gsaR5h+tu
 dXO0DnKwYVxMnwWgGMF7ZHY/PSkYJRZYABWTcGGTgQvMn7ijRIPYlGgJb0UPNDLlk3rp
 qf2YkL2bgwhJlmxWN/EVsAWI6y5YJPXkMLo443Cih/e90eQ8FQfeClj6Dyu2C9RLpqu9
 qeMhbnJUiIP3x9zuXY2IgrkFAsxIqLcvS3EAO+W9K25P+cB14/WY0qhTY/OFyoxCVnpW
 NJ0hl/xdwGykRDn0mOpJHNa8/NX1zbzCPIIpynqr/4AIGr/l4fPrn8NAYcUKKLJyyhlf
 m5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909672; x=1781514472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5/4Xm9v+3gsGRRue1lVqK96Ft2W16SO2RYj/trVU0s=;
 b=RH2xgp1lSCKglmHZz3ISqnsEzUug2Ld5OqUWBrqi7etzCRus2QOmUO4MZqkT3nhqng
 4Ozyh8QG3/cUoob/VAYKqigxzclOGj6JITFDYt0PrZI2LMGniEHfBSZ6mwav7/4u/MfL
 25oSXYJ+ipaEkDIa3O/mT+lVJZJLiSMceh13Osu6maXbk6NTtbBZYV/n4CaI4Q1A2Sq9
 oQVYGTDL9cuUsIoMjSHWTyrR9l5TQlEy7PDSusqjWhszKd0dsWwvJ4gpbFBWJ2NHhGQm
 jUjDSUuYcBY4tDWcLQAt0QQVfKjSIV6NKPOTlSRyr1Ya14iu/SbPaXtqQcUNGltl+C5b
 hEUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mN83Y6kC7omm+R+rXqsY6LrlPNI85kEjUOMHBjXPahMDfQgSb/bdnm7ltVDzH3NVbUap8YeY=@lists.denx.de
X-Gm-Message-State: AOJu0YwXzpQjfCN3o6q2wR3CISlxslnKNqiewiL5SKCLvd4dr0LHggRz
 jVw9cNpeAHwdmtaoDy+LUJ75rEJg7M0Cj33Q2mRZCPYs6owV3mRqawSLYQdhf5GhkRrsbDBl6Iv
 GuNw8Q5RbQq3k3sQarSlMX2GLcwvUVnI0FJ5UpTEAyVFtHX+kkgLM/2sz
X-Gm-Gg: Acq92OHtBLx09Ieo+nisxDBtMWfG0PJayx0Dy5H2ST2cwAFEmrxGelHefUMU+HXlK0e
 YEfq0cyQ5/9C7/TzsKS/lsz4naWeY2VlTlctkpfCkbl/gvJL4Mf7pMMGVdiTFC7jPNG5G/xaCrO
 N1QWnDta5MDCmoNlTHJaRxwkivbYLUIFDLidAd26lfPJIfC1PF2fnHHMiMtCUKMucPNt9Yx1vML
 IL58Kgb92a53KuPSZx0w4qyVD7XL5GaLE1K4pQRJHP/j99D2w3GrzuZ6RinoF/AeZtB6O3WbuWo
 c4hZS9TRlWu6FcJZGYBJI1htZx2e888Ll7S+yEs4ilJAgtZgVkWGaYLcUHz7OJFjcKkyXhpfnvl
 3ACcEJ14iISCmN2/jlKultT+uov1m1fPKi9bYeV/AgIIceQ8ogPIrk3fAvYJbmUN1mRuXnA==
X-Received: by 2002:a17:90b:38cc:b0:368:f179:ba07 with SMTP id
 98e67ed59e1d1-370eec125f1mr16433719a91.9.1780909672493; 
 Mon, 08 Jun 2026 02:07:52 -0700 (PDT)
X-Received: by 2002:a17:90b:38cc:b0:368:f179:ba07 with SMTP id
 98e67ed59e1d1-370eec125f1mr16433695a91.9.1780909672044; 
 Mon, 08 Jun 2026 02:07:52 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a4afdsm17491008a12.19.2026.06.08.02.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:07:51 -0700 (PDT)
Message-ID: <970452b7-8d1f-40fa-b477-63aa0e94930d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 14:37:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dwc3: Fix fastboot re-run failure with flat DTS
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260529-usb-v1-1-be5bcb911f40@oss.qualcomm.com>
 <a6c838a3-f795-4a29-bb0e-89a8b8fb098b@mailbox.org>
 <87mrx5zeny.fsf@kernel.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <87mrx5zeny.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX8Mv/HMeIIV4Z
 rX2IiLX1tfiJDRUJKI5r7vFeJOE9L7O+MgE8OgWUU8VTtpbL2t8duGz8a9mRpjdyOZPTXpbdu0L
 HsDHYQgsDmbPfQjqRWc6jUdx++U2Rnw+5T5xnzKAjDo6+XQWVye7LN2igcMuYjsgpfBmLPj7URC
 KRlo2Gh17kTU9boDX4AJOeXO5z11L/gIkgGqKt6yZxjYgsX1uzfE2UIRuXZ2fOF6j7Ku63dQeO8
 E2zrz9A2B3XpJ3l/WOo6ZqTLq9nELRjR0e5hxQGSUeDcIr8OsbJxl94f5sU5vbeqZpPv61vbSW+
 M+clmsktmGgDzJ0jdQ/xRmayFJ5LDJ9UgRpKjQlTR53HEuQyipAy0Wbij3I4KWmqO9iBXrihKiJ
 2m8RmPqnCnEc89EAR/sfOOzzZVH8Ocio4V6DTpYYXsjSMty6uqma54mmvMpUZLc5aU+qShW0NV2
 g6c7jLAA7GzbBDKrAfA==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a268669 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=b3CbU_ItAAAA:8 a=E0YeHN7ZY1C9dG6Ux28A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-GUID: JymRjxIMOwv7UiikawsPQbhHQ35600Rx
X-Proofpoint-ORIG-GUID: JymRjxIMOwv7UiikawsPQbhHQ35600Rx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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

Hi Mattijs,

On 6/8/2026 12:45 PM, Mattijs Korpershoek wrote:
> Hi,
>
> On Sat, May 30, 2026 at 12:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
>> On 5/29/26 2:22 PM, Balaji Selvanathan wrote:
>>> Problem: The first "run fastboot" works and enumerates on the host.
>>> Subsequent runs fail, with no USB enumeration observed.
>>>
>>> With flat DTS configurations, the peripheral device inherits
>>> power-domains from its parent (glue) node, as both reference the
>>> same DT node. During teardown after "fastboot continue",
>>> device_remove() of peripheral device invokes dev_power_domain_off(),
>>> which powers off the shared USB GDSC.
>>>
>>> As a result, the next "run fastboot" fails because the power
>>> domain is left in an uninitialized state.
>>>
>>> Add DM_FLAG_LEAVE_PD_ON to dwc3_generic_peripheral to prevent
>>> power domain shutdown during peripheral removal.
>> It seems the driver does not handle its power domains correctly,
>> inhibiting PD control is not a fix, sorry.
> I agree with Marek here. Especially since this is a generic driver.
>
> I had a somewhat similar problem on amlogic devices where I could only
> run fastboot once.
>
> I've solved this via
> https://lore.kernel.org/all/20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com/
>
> Maybe you can explore something similar instead?

Thanks, will look into this patch.

Regards,

Balaji

