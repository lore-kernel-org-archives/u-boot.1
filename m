Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6311061B37
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 12:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC18983DA6;
	Tue, 31 Mar 2026 14:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRYVSug3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Riz1lZrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F2983DBF; Tue, 31 Mar 2026 14:20:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5031683A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 14:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62V9h0nW4053882
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5TTOHn4MEpCaN4mx4a7o8oNlL7AAGjOFBdk+dreqjB0=; b=aRYVSug3Y6faPFII
 fgEfZgtq0riksYu1nlgh8O6kPtzX7swTqvS2Vl+zuYq1PlYGxGjTlWZ0guX+dTRk
 /F0dzpZwQ6vJMjh2KdRLZOOxptJ/3eytNxNxWxvg64jIBbKd6gwx0iSsv02gz6iv
 pCx3mWApM3bXHc8x8cO6FQ6W9pfVJ8jwJKCmfON7iF26aYdLm4cLD0Ashn6mZ1zC
 yd5VeBedjsIXwQju1J9LKDf5xOGnkQfNE/Mdz/9OilwGAOUn7G4qPbc7KoepHGcE
 HHYw0GBQaeM54FMSyx0DJYj/wW4mtYMovUhAgcoKjLuFxZ/b99xc+717l930bOjG
 3/bRpQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx3bh5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:20:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b0be75dfd4so72178665ad.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774959639; x=1775564439; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5TTOHn4MEpCaN4mx4a7o8oNlL7AAGjOFBdk+dreqjB0=;
 b=Riz1lZrVrO3pe1FuoQQZPpKJsy2IcI6i9XIU0LAA+R/JqMqopdzVtiQIia46eIKa2f
 4h9HumkZbeRsLcRSn8NGXkCY777ZBN44YzzkrPZZxYUZF0Bvy5Iuf9+KL6F4Jy/8Dfo/
 Y1KmKLqkZ2cA9G+O/kHwJHBrb5QXXBVJRlxVqLYPqkWEzrRx0aWpZJyMo/P01VgmBQFZ
 DbMgX16rQjjdfZTIMW99RHBJPW8+CCP+i7zHn/Mx1lJaU36Zgeztq8BDchrb6ZulsBgD
 PBX1BfcxwtugOv9WX2uPuH9XSS682sqjCNeIKaWZh4eb62o3QZdyLbgyxmcBNy2c978J
 gYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774959639; x=1775564439;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5TTOHn4MEpCaN4mx4a7o8oNlL7AAGjOFBdk+dreqjB0=;
 b=Fa5VAzSTJZ3AriJ/o+NGopc+H4zh3k0EuPt0xaf4VlJK2nW11+2rUJW5jeadRzibYN
 spS3g/F4AJ6lurbsaiTkNU3KBmQHXDEUxeavwWL+y9Bw4yH01pDYNXe6jXZrLZt7nDeP
 c5LCQFy2Cb/f/YxykonDVPBHVa3hCuEowXXxiJC4EyY6JyuYjZGOXxz3gqkS7rn2mNkk
 +SgvujXadaO41BfD4YAJwDYiJyDcQkD6QRRGFfkhJUuAF7p61JfFM/2yUenJ0hGk4NtM
 HrN1WdUZNYd8i/J2lLWEdeDr5Q1rQY+fMWluM3AjfRamkGjnv5D1vFOPDZ3QKjXKwzP7
 +sSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOTmnfWIQSpwI0+6r+zaksN3Qq53Qo5um0z76GypnRe9a8wsdH4L6DONwzJbZcczvnD8vsnhw=@lists.denx.de
X-Gm-Message-State: AOJu0YzZBhyNzpKZCou51LNDKLcIWjm/6ruDLlTHhci1qgDcJOOXY3mi
 IPNnjR4JvS4q8s8h++tkzHwKhiN7yIMJ5rQWLRzMDKbWh8Ve3xH3BtuPTDNGPGsme5tKAxjYcAD
 /uNd2amz2Xppcug9V7bJ2SPCqJ32hq/Q874eIv//m9DHjTkzRxPWooD+s
X-Gm-Gg: ATEYQzzP/4oUMRpK/Fn53xfikqndB44r3wurqIoZIAR3LICoqeGVRfDU/qY7W1QRDEg
 5Ksp62n6zsvm7ReA9RzqvWoSmTc0h56ssIsxTQtVZW518HQU7PMItYuap9Xwg7pnWoJOczWhTpO
 P6fdJXykfspoUquMrNB0IPc06rSXA0SIrWwoxtwoCvM3rt1lo53W19AJL1mgJYUAEMAAp4VGADz
 X6fpcbBaqWcNA47jVI7q7zephte6DxVJJb5kbk83SNtLvMi6grfiWMpzUS8YHOIacQ/wsoNl1OG
 5xJAFvEhzTiaGSv0YinGsGZnRp2rFOr6hKnbcSr8SwnhAXkrS1ERbIwSS5PkMDnGN89M++G9fUc
 7n7aHBpnlE4MRLxERwYf1MBNBW8IORq/QAbM1Xhy/QB9a09OI9MJYww==
X-Received: by 2002:a17:902:ce06:b0:2b2:58b6:3dae with SMTP id
 d9443c01a7336-2b258b644f5mr51954205ad.46.1774959638542; 
 Tue, 31 Mar 2026 05:20:38 -0700 (PDT)
X-Received: by 2002:a17:902:ce06:b0:2b2:58b6:3dae with SMTP id
 d9443c01a7336-2b258b644f5mr51953725ad.46.1774959637859; 
 Tue, 31 Mar 2026 05:20:37 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242765c7bsm113671955ad.49.2026.03.31.05.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 05:20:37 -0700 (PDT)
Message-ID: <f76ba324-a207-40c3-a66f-cc485ac923ff@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 17:50:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v3_0/7=5D_qcom=3A_Add_NVMEM_bitfield_suppo?=
 =?UTF-8?Q?rt_and_reboot=E2=80=91mode_integration?=
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <D0D68612-F412-46C8-90DF-D33A6C655401@gmx.de>
Content-Language: en-US
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 peng.fan@nxp.com, dinesh.maniyam@altera.com, sumit.garg@kernel.org,
 sjg@chromium.org, seanga2@gmail.com, sughosh.ganu@arm.com,
 ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, msp@baylibre.com, quentin.schulz@cherry.de,
 jamie.gibbons@microchip.com, kever.yang@rock-chips.com,
 justin@tidylabs.net, n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <D0D68612-F412-46C8-90DF-D33A6C655401@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cbbc17 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hliXG8A0FrnRB4laLs0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Q6MSsDS9zjZN9Bc_YRrCMUsz_2O-_XTh
X-Proofpoint-GUID: Q6MSsDS9zjZN9Bc_YRrCMUsz_2O-_XTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEyMCBTYWx0ZWRfXzJP2o60K7gh4
 YFJ9t9c/FsYF0+IazLdJDWi7JHqTwNexe6+uzfZXUisyecvWv8SQHAN9dDdPjYSqfngzUUZ5pQ4
 KgOek5zX/12TO8ljgmvKEHg8Tyzo1F46BV1TC6qYuYHKZ8nhjTtP5N1kkoFKJmfhtFXVkxtMRff
 P8llQbWH8pbL6X+60wYPkzhe5T7D7Gutuexfq37OgkBWc4Viz7rwcflW7XDWp0xsduBGsibLBIm
 t+THT0CXPwzbwspl2sFh2zEZiu5Xg3DRBBdaN20qfw+0db2rHtoFVE+U8etsBoU9ICXWdAOkufM
 zQVLsNN6sYC/VFc+cRO2UVafiVgALT9jwjjd2P2ddwajIbqepFvNZha8Ixd1ExgiumCgF3hD+IM
 FEQlVeE0T+n0xhJU1jrm15q7YO8PMXVubOZJNRrIAfoWdkLkQGEqJBmFxCeq5gJeIVWhTxjcV21
 3S77cEKSONol6F5mEJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310120
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


On 3/31/2026 12:44 AM, Heinrich Schuchardt wrote:
> Am 30. März 2026 19:14:12 MESZ schrieb Aswin Murugan <aswin.murugan@oss.qualcomm.com>:
>> This patch series introduces bit-level granularity to NVMEM cells and
>> adds complete reboot-mode support for Qualcomm platforms that store
>> reboot reasons in PMIC registers.
>>
>> Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
>> features like "reboot bootloader" for entering fastboot mode. However,
>> these PMIC registers often pack multiple fields into a single byte,
>> requiring fine-grained bit access that the current NVMEM subsystem does
>> not support.
>>
>> In addition, PMIC generations differ in how reboot-related data is
>> stored: older PMICs use PON (Power On) registers, while newer ones
>> provide SDAM regions. This series introduces a unified, NVMEM-based
>> approach that works seamlessly across both architectures.
>>
>> This version also integrates reboot-mode handling into Qualcomm board
>> initialization, enabling automatic fastboot entry when the reboot reason
>> indicates bootloader mode.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> It is unclear to me how endianness is handled in bitfields. Do you assume low-endianness or do you consider the system endianness? Please, ensure that the tests are executed on both low- and big-endian systems.
>
> Best regards
>
> Heinrich
>
>
>> ---
>> Changes in v3:
>> 1. Simplified bit field handling to maximum u32 size (32 bits).
>> 2. Enforced strict size matching (size == cell->size) when nbits == 0.
>> 3. Enhanced test function for NVMEM read & write
>> 4. Updated NVMEM API documentation
>>
>> Link to V2:
>> https://lore.kernel.org/all/20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com/
>>
>> Changes in v2:
>> 1. Replaced custom reboot reason handling with the standard U-Boot
>>    reboot-mode subsystem, per review feedback.
>> 2. Added bit-field support to the NVMEM core using the new "bits"
>>    property.
>> 3. Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
>>    access.
>> 4. Updated the reboot-mode driver to support variable-sized NVMEM cells.
>> 5. Added device tree configuration for the QCS615 RIDE board.
>> 6. Enabled reboot-mode in qcom_defconfig.
>> 7. Integrated reboot-mode detection into Snapdragon board
>>    initialization:
>>    - Added qcom_handle_reboot_mode() in board_late_init() to enable
>>      automatic fastboot entry on "reboot bootloader".
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com/
>> ---
>>
>>
>> Aswin Murugan (7):
>>   misc: Add support for bit fields in NVMEM cells
>>   misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
>>   mach-snapdragon: Integrate reboot-mode handling
>>   dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
>>   qcom_defconfig: Enable reboot-mode support in qcom_defconfig
>>   test: dm: add comprehensive tests for NVMEM bit field operations
>>   misc: update API documentation for bit field support in NVMEM
>>
>> arch/arm/dts/qcs615-ride-u-boot.dtsi |  26 ++++
>> arch/arm/mach-snapdragon/board.c     |  56 ++++++--
>> arch/sandbox/dts/test.dts            |  12 ++
>> configs/qcom_defconfig               |   3 +
>> drivers/misc/Kconfig                 |   8 ++
>> drivers/misc/Makefile                |   1 +
>> drivers/misc/nvmem.c                 | 159 ++++++++++++++++++---
>> drivers/misc/qcom-spmi-sdam.c        | 200 +++++++++++++++++++++++++++
>> include/nvmem.h                      |  28 +++-
>> test/dm/reboot-mode.c                | 137 ++++++++++++++++++
>> 10 files changed, 595 insertions(+), 35 deletions(-)
>> create mode 100644 drivers/misc/qcom-spmi-sdam.c
>>
Hi Heinrich,

Thank you for raising this concern.
The proposed change explicitly interprets hardware bytes as 
little‑endian when nbits is set, ensuring consistent and
predictable behavior across architectures.


On the read path, hardware data is treated as little‑endian, converted to
CPU‑native endianness for bitfield extraction, and the final value is 
returned
in CPU‑native format:


/* *Read: Hardware LE → CPU native → bit ops → return CPU native* */
/* Interpret hardware bytes as little-endian for consistent bit field 
operations */
value = le32_to_cpu(*((__le32 *)buf));
value >>= cell->bit_offset;
/* Handle nbits == 32 specially to avoid undefined behavior */
if (cell->nbits < 32)
     value &= (1U << cell->nbits) - 1;
/* Return value in CPU native endianness for caller */
*(u32 *)buf = value;


On the write path, both the existing hardware value and the caller‑provided
value are handled in CPU‑native endianness during bit manipulation, and the
final result is converted back to little‑endian before being written to
hardware:

*
/* Write: HW(LE) → le32_to_cpu() → CPU native → bit ops → cpu_to_le32() 
→ HW */*
current = le32_to_cpu(*((__le32 *)&current));
/* Caller provides value in CPU native endianness */
value = *(u32 *)buf;
value &= (1U << cell->nbits) - 1;
value <<= cell->bit_offset;
mask = ((1U << cell->nbits) - 1) << cell->bit_offset;
*((__le32 *)buf) = cpu_to_le32((current & ~mask) | value);


Hope this approach addresses the concern raised.

Regards,

Aswin

