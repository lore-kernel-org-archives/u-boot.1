Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A1DD0E6C1
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 10:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DCC183FDB;
	Tue, 25 Nov 2025 11:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXyxvqpo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOfP/wrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D270383FDC; Tue, 25 Nov 2025 11:33:22 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CAF583FD6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 11:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AP9wNuu2659054
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 65tFglqRL57RNDVhTWXbOG1bJSZAxb2ClDBZuE9vOpI=; b=XXyxvqpo0VJRqsTx
 FbVAvWRWJZ6yiETmIwMwVEGBfuFwjaSqU1ob/JcOPVW5gw3iCMziYjp/06v10BmS
 lap3k+59g0etXIiZcaa+hrxjGB+lVLfVRY7OedLnZ15smLYijEL/3w71vg75Dh+a
 +pd61GFlt9WNnuA8lhWlEb06jZzJ3iw0PWlUtMvY1w0VcfYFutOBjzflhi9rDdcb
 lq4Z+IcMrtNRpd89ftxWHGmY53PyZWMWVXKv+eyNU89m3Oh7Qq9hF5BToL36ZVnm
 nEm6x8oASvmsP87zfER3Zu5oftVymcpXHhSUEtJRHb9K7biUdXKuwgS8OzqHNBTW
 OiWR1A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ana9x839a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:33:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3437b43eec4so8557700a91.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 02:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764066796; x=1764671596; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=65tFglqRL57RNDVhTWXbOG1bJSZAxb2ClDBZuE9vOpI=;
 b=OOfP/wrRLY/qlAh8ojgRQtV9waHhKud1s8QPAlZZG6ttXWB5ZEjGYQPVTusiFP063F
 jLEO9W0XNWJpmWIEB0QIvVVy9aF0m+YqYmG1blKMYcQp0XHA08f2e2ebbJJ9E4Mo33ym
 hOjoh0eoU7xMpqoOa4LPEsCIIl5/B/X+iPRhhuQKboTCYXhnBTnLDua18V5vJCFJZ+O4
 irPs3S4ZR8ggKxoWSxN88+fCgvsLN3UwUYq0ZOxuC3/EtRrYVCMxfpZYvA3tSwOmUk/I
 nOTuGGaX8lG8egIy9XGLkA8CyWMeCrFHDs4fzsqsbcve5/qr15gGVEYy/AaC0iBnxXJ9
 eMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066796; x=1764671596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65tFglqRL57RNDVhTWXbOG1bJSZAxb2ClDBZuE9vOpI=;
 b=a5TAxfu2N/zlJU2DwA3qEYd8kdx+1IiwGCmCc5YOWL+9rV7ArwqO9OnI1J6fW4nINr
 J55OKdUA5F+QY+sCAaTm0qH8EAzVCsIfuPlreIT3m8uhd2K5YHKFeMZ97Ocdfgg62kPF
 Fq3V26+7z6TYMl9Cyqh6YULzf4KO2noNn2z4GtDoxjcOwERqBqeGaXi/W2dEiwzLKqQy
 W1u15MgGPJJjg7ZEt6T2PU8mVvBJkcLdK2T9vDsiCMUAXFJVc36x16IBakLAYOCHJu1w
 1FduBfsL1BXpmi8qauMA/NmebQmMBh/N6AkAdXhG2wf0mq9ZAa0kwJBqN5or5DypOCnA
 OvwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbyu3LlVSNHA2OI2c4YyyAhiku8N8J/9Frn5NejM2h0Rk45zPKlPIFcYgk1u8L61UO08IaTzw=@lists.denx.de
X-Gm-Message-State: AOJu0YwClBqJxdnGm0SyqvOXgWGwJDge3ra3Idmhl0ZBTs2EcETAMnCJ
 wMeADlT2wo48d67I7Dh6IPHX1Cg8NWYqObGqGxV6KI11mRdwSbqkkNzv7VLFJUe1UGlrxsPVTEy
 g3mZe5ZWAyW035XcBN0h/Wv0q/IspSY7DpchI4CHLYr8wS2DNiJ7nr/Wx
X-Gm-Gg: ASbGncuejflvT33p/qrxZuwa7qjUmUIIFLvhCVrVi6PBVL/w2Ccgn6PbbpN7UHArQQo
 xZ9eNa0oyDDkiB3WN8wfDPquxp4f6SQsq2mpjBj8IpT8dWyEOwNdTn9lKj3KBkH+/7z90GVpbO+
 XzXhOS2svLSN8PW2DNP8pdnh/Vab/WS6hVefzGHgnhGg86bQPkVHZcp3zWys7TIK0klj3sUZsDq
 57slmxhooMXbhZUGd++iRVnf7Db4KGzHq+l65Xg/m+rojFz0QJNWsTadyIWcEUCJI/wr8oYIY3h
 b/VmvHPoHTGf3b5QCxSwEtieM3T5cY+/FmTKBUWBlUAHhfZeqemnB0FqKvhqorAlkT9XSkehF1s
 ZOSUyb2p6KeHvlBuoqH9nDO70yLCRh7c=
X-Received: by 2002:a17:90b:3fc3:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34733f14df2mr17996680a91.17.1764066796375; 
 Tue, 25 Nov 2025 02:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnhb/y8rh+ZpclI/ATc1fDg0xtWFnDdFub6ooDmwkRW1RLWLYdXco85j9BLNn5xVIraNQfwQ==
X-Received: by 2002:a17:90b:3fc3:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34733f14df2mr17996618a91.17.1764066795746; 
 Tue, 25 Nov 2025 02:33:15 -0800 (PST)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34727d5208csm16411458a91.15.2025.11.25.02.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:33:15 -0800 (PST)
Message-ID: <acae301f-3e16-4f4e-a2b2-fb1cd786c11a@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 16:03:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
 <20251124195108.GN2125796@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251124195108.GN2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: t5omtOPdecXJdeUF1zdTwGuxmvNfalw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4NiBTYWx0ZWRfX8KKKnYNqhXcq
 Kex+svYBz9pfOOt6FZBcWLhwOxvV+CeV+DeWtY7PISiVREuAeSB0eiwk7fR/QPWpLV+NvvHAO0O
 o/hhh2UZaBknOU+XBTnyJa6IvOIcP2AxbRxDIvrVrHJUkKQHKpTQEkveQSrQ7BMEfWXThdzUfMq
 HDFWDDbbnGrdnl/YlUINMYHnNSb9CpIefo7UmYJcG5GbvWeFvOq71Oz9URdXzXGatT9jA00mmil
 ZrsHMPlnO8TB1BB2gIY5SphttYQrQqxnN+m5IvD3OUwzQBNixwVq2+rX070PdU+34rB/vY9EQLC
 AFoxJpx39gYo6MUpgdO34zfGUBhVmBY8SQTAIG0Cwfg8wzsdSbmA0tgHSOvvp8YUzIKUpfqyJum
 9X1+fVJHZz3zhZBlgtXy3gZ7dq7sng==
X-Authority-Analysis: v=2.4 cv=Sfj6t/Ru c=1 sm=1 tr=0 ts=692585ed cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OiyNyS6jHDBp4_hPUT0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: t5omtOPdecXJdeUF1zdTwGuxmvNfalw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250086
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


On 11/25/2025 1:21 AM, Tom Rini wrote:
> On Mon, Nov 24, 2025 at 09:24:59PM +0530, Balaji Selvanathan wrote:
>
>> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
>> SC7280 and QCM6490 platforms. This driver currently implements
>> USB3 super-speed functionality of the combo PHY.
>>
>> The QMP Combo PHY is a dual-mode PHY
>> that can operate in either USB3 mode or DisplayPort mode. This
>> initial implementation focuses on USB3 mode to enable Super-Speed
>> USB support.
>>
>> This is a port of the upstream Linux files to U-Boot:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0
>>
>> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> [snip]
>> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
>> index 0dd69f7ffd0..49f830abf01 100644
>> --- a/drivers/phy/qcom/Kconfig
>> +++ b/drivers/phy/qcom/Kconfig
>> @@ -12,6 +12,14 @@ config PHY_QCOM_IPQ4019_USB
>>   	help
>>   	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
>>   
>> +config PHY_QCOM_QMP_COMBO
>> +	bool "Qualcomm QMP USB3-DP Combo PHY driver"
>> +	depends on PHY && ARCH_SNAPDRAGON
>> +	help
>> +	  Enable this to support the USB3-DP Combo QMP PHY on various Qualcomm
>> +	  chipsets. This driver supports the USB3 PHY functionality of the combo
>> +	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
>> +
>>   config PHY_QCOM_QMP_PCIE
>>   	tristate "Qualcomm QMP PCIe PHY driver"
> Can you please do a follow-up to fix this tristate (and any other in
> qualcomm specific Kconfig files) ? Thanks!

Sure Tom, will create a seperate patch to fix the tristates.

Thanks,

Balaji

>
