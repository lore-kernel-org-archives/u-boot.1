Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21727CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F6E849BF;
	Fri, 19 Jun 2026 13:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzEQ0FFM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PHmxLxsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6090A849BF; Fri, 19 Jun 2026 13:16:01 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07A9847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7QHhm4185261
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zyke9T1L6PcHm0wGvPtdhSieDDaAVRVGcTY4SmxWoUg=; b=GzEQ0FFMVif/OfJA
 icmi8fsJCzE7dUCq5vTEBBNumbV3cxgJwwano6js9bJx5mjCiDqmTyU8hqLflKeM
 347yUxt/j2FJCjpbXbV2tRXwx9mtt+dX0n1zdPXlhmNrJZN0mBVD5QvvlWlkzx/F
 w1+qFc1cWELCPSiUgJcWKwEYwUJzDaKoptla4m768+JVXOkJndC3lgSLlmNXPCbO
 2BG31QhTIWr6tY7u3mUw56ZpTwzTIl4HFwK/Pz0SddcMa8qzn7dtOWQdhax7lBCL
 rAnld7ACuynolhBnlFq13w55PySs35xBI9jvYainiEXnOJU4hoz198sb3bHghb+M
 jsJ7uA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6sb2ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:15:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0532a6588so18650745ad.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867756; x=1782472556; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zyke9T1L6PcHm0wGvPtdhSieDDaAVRVGcTY4SmxWoUg=;
 b=PHmxLxsELuL6qKmhhc3KEejBbK2jpzo+Bw/I4oXOhJFbayw0BjuRFNVj0U1LfXz4/I
 py2nwIFwTLwMEowbkPjY9atCinsd06JTNvt6SzzZfG1mHlolbTozC5hlrFDjyci6LZDf
 XrHMgRRfZIqJ3Ijhr1Nr4I0RZuWCvqPooYEnNIJLkq9yG2dzMyQEi5hnorGtKYZi/O+J
 0rvpbBZ85VIr1Ah9I1uQ53YEBGWxw3q8x8IgyrCYHBMLJ8gts+oiEiu90KS1zkZ0Ak6j
 mRL/MQJWvraCWLPs14y5EAU1sb2DdBmjzX1x4NJ2mjNIP8Kz0FgRFekvbI2Wq/Xsv3B/
 gR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867756; x=1782472556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zyke9T1L6PcHm0wGvPtdhSieDDaAVRVGcTY4SmxWoUg=;
 b=d6Jpi/g9Q6U4bpgZZ7M6aDJk3y6ZGEq+O8V5WP/Weg/UGIFoIUBcazaO22G3+F4dYy
 ZLfJua8LtPua/uUxH/SF1TNaakPJ5aFIurt9f0L8cprfS6xsmYFzTxV+pQXzeFW2s4eH
 rA/miSOIVRafJzrq6c6NW6ltpVidaBiRbXNbWlREvOIXNDsaBHyf8MCU7Bpv7wGsUKvO
 Xfgij0l3/flCXLxZUZRWQMo7GwQgYajDVo5k0iWTh9ZdZkW8ZqX+Ub70mhdADyGmCdGy
 OlpMo35QDw1w3RWg46HUXkflLXdiHesovYwRWaYFrZOTo92UvDsQf0uW7lqtAyFcJMe+
 3Ynw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WoowXpn0QWKxZe/Ifw4CNwmqyFKq5h6ShYcXsBWLMv+1Akno+Rqkg7BfiEQbmXagmIIkQgMg=@lists.denx.de
X-Gm-Message-State: AOJu0YzyF6Tt52RfAcVTGqIo70coKLhc7x8Bz1WHDL5a1SfXaMght0+/
 vMQ5rirdIgtYbTtr+9QEFD5CTCUP4YEJQn3iHGl7QuEYlVWtACYxcuaK7I0ukzeKQiBYNycDVU5
 trFCubp2Ccd2TIK3YxDaI7EqqngLjOTwbfpautHkRWhwrcylwOx0Novo0
X-Gm-Gg: AfdE7cmsRHnQxdxL5WWmeIfwKZT4NcKRPI1iWMvJwvjw528gwRdHCJDUwpGIVcEuNE4
 3i47EG9eY+BLbOQXqeZFh6QplP1/kLW/+xVT6BX9WFxixBaEN3pKdXVglcP26YeflPe+FvOoOAF
 18MBvAQft5w8IjF2zKnbkXJx3ffp+/wSVpkJnZ3tzPaAuyWJY1ZZtGx3DxrOjKw4nKDr0whILQS
 A0mHTEuPp+pIeUtvNv16LelFY23oZAgzo2XENayQtkOOj5iH8LfG3BW74M4uSXr07kZHQSkErlm
 4yrKvux2Kbi/75G9+oYzPo/RKp5uiL7owSzk1Q4chKht7L/BiZuOjjC/uzmy9ofsdSNiWjs8wWe
 INtEnrvUm/9PPV2/Z8YEVk7lRVteBfV2XTwX9getGdEqP5QVq
X-Received: by 2002:a17:902:d50b:b0:2be:fda1:42d9 with SMTP id
 d9443c01a7336-2c718a62bd3mr35054035ad.0.1781867756013; 
 Fri, 19 Jun 2026 04:15:56 -0700 (PDT)
X-Received: by 2002:a17:902:d50b:b0:2be:fda1:42d9 with SMTP id
 d9443c01a7336-2c718a62bd3mr35053605ad.0.1781867755538; 
 Fri, 19 Jun 2026 04:15:55 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c720c0d7e8sm22815115ad.73.2026.06.19.04.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 04:15:55 -0700 (PDT)
Message-ID: <e7776ac4-e4a4-41aa-884c-87af4137d5aa@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:45:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
 <tgqh8m.i5334p2b63jo@postmarketos.org>
 <095e2faf-1f06-4139-bd9b-1d278b60ddff@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <095e2faf-1f06-4139-bd9b-1d278b60ddff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b0r56Ai6NANcAjcP7QYdqJjRTnIAnVbI
X-Proofpoint-ORIG-GUID: b0r56Ai6NANcAjcP7QYdqJjRTnIAnVbI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX8/6MqAXLifHI
 DAjibjlQ2Pw3qRrFrynkIA1DQydtJZ6PMULs2oYmZIJwi8l1e9RH09aq5vpJwpf40a+Niz6EsPM
 Ds2cyuyM3BtxL1tOF0X/Eusz853Podbjntva/a3HgY5frqA9w90IM71bbfLtltJMGKq6CMrhDA1
 NqZyDZQDhjhFEKKd6VCbdZxhlltY/+0KPRJ9V5ndaibu2D1PTbN2DnBsMQb6r+MTgbeYhcGhmcA
 X/szenxiXyxZ28/DBmrMH+EYsWGpDTKiaQ8E3vDUa9/NOC3Ffy9mlGKVkNG4E8ky0SRqJC7XMQ5
 CtfYmbESAepQFqbfW2IMULxrr1QsAjDH+MRGVLZO/SWUNxOLPiEgFdBzqdAYOKse+hHP2qYaAjP
 4hRGzyO6hbtYgW7MD26ylXOKgpitDEmaey5hzFcQTmQHyiYNik+Cfn4Fy1dKvUipOxBbH4xAL9A
 umyaR6vXkqwB8MdYVvw==
X-Authority-Analysis: v=2.4 cv=H6LrBeYi c=1 sm=1 tr=0 ts=6a3524ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xjGz-wBMAAAA:8
 a=KKAkSRfTAAAA:8 a=vLTgU25daypPW6Nt0ckA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=dmbvPvuLAiAwK5y7oBu2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNSBTYWx0ZWRfX9oTIp6qbw4ro
 p1O4c2p762+jCghr9dMIkkgC+niyG5cTL0lZX5xyl/OID6MItEgNigkiqLi6iQrbHEXfu/215t6
 uo3i7cTPYD7sGQSkXEOBIfW9DOBF1lY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190105
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

On 6/17/2026 8:37 PM, Casey Connolly wrote:
>
> On 16/06/2026 18:42, Ferass El Hafidi via groups.io wrote:
>> Hi,
>>
>> On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io"
>> <casey.connolly=linaro.org@groups.io> wrote:
>>> Hi Balaji,
>>>
>>> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>>>> This series adds support for running U-Boot in snagboot mode on
>>>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>> You didn't respond to my reply on v2 of this series.
>>>> Snagboot is an open-source, scriptable flashing framework that provides
>>>> an alternative to the proprietary Firehose protocol for device
>>>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>>>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>>>> and execute bootloaders. However, instead of using the proprietary
>>>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>>>> standard fastboot protocol for device flashing.
>>> Glad to have some more info here. Please also add a doc page with this
>>> information as well as a list of supported platforms.
>>>
>> I suppose they are talking about this snagboot: https://github.com/
>> bootlin/snagboot
>>
>> But what's confusing me is there is no mention of any Qualcomm board,
>> nor any PR to add support for it. Is that in some downstream tree
>> somewhere? (to be clear I'm just someone interested in understanding
>> this better, snagboot is a very cool project that already supports
>> plenty of SoCs and it's great if it has or will have qcom support)
> ah yep, there's a fork here
> https://github.com/qualcomm-linux/snagboot/tree/qcom-next
>
> Balaji: it would be great if you would include context like this in the
> cover letter.

Please find v4 here: 
https://lore.kernel.org/u-boot/20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com/

Regards,

Balaji

>
> Kind regards,
>
>> Best regards,
>> Ferass
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#3922): https://groups.io/g/u-boot-qcom/message/3922
>> Mute This Topic: https://groups.io/mt/119832159/8413174
>> Group Owner: u-boot-qcom+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-qcom/
>> leave/13197796/8413174/1557304080/xyzzy [casey.connolly@linaro.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>
