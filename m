Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971B6CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F84484704;
	Mon, 15 Jun 2026 14:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EPr35PWk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrElgXtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F35484869; Mon, 15 Jun 2026 10:54:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1635783FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6L1As3888523
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lrUHA65LHQDPxWaEaAy9pe/0HVWSSQMC/r2hyuSWj7I=; b=EPr35PWkBmuY1fF+
 7jvrF+ldq4s96Ybz+zbwsP2iu7j7KBm416pT9A+NfjUecUbyB1/SResjpP4WkCDK
 8L69Cg3b87wBwLNkLvmtC3QMeVNhkA/H67+RR5t3/P/8V75GmdDAfAQUdia82Y9L
 mjSSY9YL5No3M0Xmq6XDuGtHkwU/vunFyraxpekpMEaH5pw4nHf41BPbuUtHOlFU
 CM1/TjtE60w2l+ai7qkmlSunMTturkV5LEpNwalJGHRX2TSJkekCEFOHDJf+TIWH
 QubYkrdN7W6VjCeBQsms1bO+88XSq/rIJxOcHaG6cPxeG0bxo4UlpbB6jMGDU/1Z
 DDgB4g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wxhfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:54:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85edbb10dfso1710523a12.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513643; x=1782118443; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lrUHA65LHQDPxWaEaAy9pe/0HVWSSQMC/r2hyuSWj7I=;
 b=YrElgXtGxlRqfbOhHYJKtDMaSrrX80SFfNjA+xRhd2hFQ+ygBjLpJ3IZP7+OQjKXEb
 1q0VqGcq5+jXlwoqLAonRULs2QMOVcO3YTcQAxZhUOT76Z+jq5/n4BeoB1YZqjipWaHX
 ea62rWzp/E9Nqh7wiiKEJrsSQDhAN4DWplFrQhOco3OHGKdTBYjgnwWa8MX46tPbxjMo
 AVwiB10nUQVmrPpijSUduuhaQCEwqX/NUc5bnPjXJDdsUZnryvU/SVTkgDp0IVEYdezi
 Y69rFDlNTPuLIrF4w3n9NZZ/ZYLJl3auPzeO0qqO3OLlPdTlZ6URJhUMKNb0OZ0ACX1N
 6/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513643; x=1782118443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrUHA65LHQDPxWaEaAy9pe/0HVWSSQMC/r2hyuSWj7I=;
 b=avGuA/02nOowFrbZ5pLtsw3odEKpRqHw3z8j09ws+3OqTo4YI8LGIcYkdekaKSsZwt
 QeXd4yIo13j1vV298OAA+29FI3mzZa8iG27Bkyx9l6Aqd7aTQMqZzpQ4cbDanLbnjiwG
 5uukBgXbRwdKqp8yKKAz1qzF2KcGdjYAX+FUx20nZL42xjSgRiqMpAtOKvfhhh0UF9ML
 hMBgqkBKCbuUrrWy1IP/sAtI9Xy6k3Xtr2nrA8+gw9EGu14boag/7rZ3nO2unvnZYJjU
 fmxbsn+T9cwiW6DVWO1z2g9PY0OmJoJeKC5pIM44P63sawURspsJ5nmI8TansX0X9LPJ
 wbjQ==
X-Gm-Message-State: AOJu0YyFe8o880WrbZRaTj0/xkmui9WabJ7BHKfbB4sUjEdb5W9PgFxy
 TLkV+Gu0RP7VdwCGqY33Ll66Z5OefA95xWXyMoWj2whsoDIWEOY0l1sc8AtyYFGUV+8rwcwCMgc
 oZl5wpS3r6MGO4ha9EoF2wJiweiBEbosLCQuXtNDbyKO4jd/P1VYZn/a4
X-Gm-Gg: Acq92OEDT+SkvMNG7RMwlIbsKwXD81vqKFfXwd42Oo/IkVcKUzPfQ6O7snrKAAzBxED
 Pe0g/VVdht1MxmM39onRGRp6Q5CkzOq9nM3eqA+/r1tyagM4kFcu8xC70bDeT2RmDjLFCMSYJF5
 Y8O1umTETuxCtd5Zee3MwCqnWz5KpbIc05sUepIDgD3Ahy3OEHyfXNMYSGmLNY/JmSIbnGmuASu
 p3iEnFpit2ryjSxCnRLPTOtqQ988OM54mslECp9evGLjA35ZrMXvD7khNxUxJM0dnv7kZrjELC4
 zDpJWleKsxR0JANqllk2q/m7ttWSvwf/ZHo8lSGUqcI98WXa/7Q3+COm6Zrj7Y+hpvq3EQtdgRn
 oWoSojPwOo1InP7GpfQD8YAqwwwhg9xiH61klnjlChXJr5icYuMmhn/rKBiM=
X-Received: by 2002:a05:6a20:4321:b0:3b3:23b4:6950 with SMTP id
 adf61e73a8af0-3b78583188fmr11507389637.18.1781513643309; 
 Mon, 15 Jun 2026 01:54:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:3b3:23b4:6950 with SMTP id
 adf61e73a8af0-3b78583188fmr11507325637.18.1781513642766; 
 Mon, 15 Jun 2026 01:54:02 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm8065850a12.22.2026.06.15.01.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:54:02 -0700 (PDT)
Message-ID: <ee6a3796-f96d-4857-868d-a8aef05db200@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:23:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-1-72fed24ef01b@oss.qualcomm.com>
 <aiqUmUNyCQ8/wN/m@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aiqUmUNyCQ8/wN/m@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9bZ4ABx26UrIR7W0SF68L6OCd7FhI6a-
X-Proofpoint-GUID: 9bZ4ABx26UrIR7W0SF68L6OCd7FhI6a-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MyBTYWx0ZWRfX9izZoYdWIyLz
 D5bNv6Zw476w60v727DaE396bx/3YqUNlcrNWiG9JzI+EVAZpSEfdsz16jm1C6bL7HHz0jaz0Wd
 RsFN6Q/FDI65rg5hmMWQyES1XRw1clw=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fbdac cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B5HPGUzY3tQohz7EFZYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MyBTYWx0ZWRfX4NMIl4fzURap
 IBwHnGkCi1tWXVIRbdL0c8CHGc1dEDU0/qCcTnRUqD5AFWTFYNtKj+7gVytIIaVNLucydMMl1l7
 mLpFBt6PkHpe5xeahr8a/61U6eV4vSLW/t0QjjGJo6L5Xx/y4lDZ506zsG2OOUr3TIvhkRIuWjw
 lEdsuFg239A8Ki4CX0UwRTz+Qc36tWe/QzcfeeqXuxUQsi0Jvl4lAYtKBpDHfSdhKypXClyGeQq
 fM0+JjF1aHLR6k7GcsdR8+pG+hSXWFEBbmtPSFtv2Gfi73oFyY6UmZOWLLLBnptaDGyOtw1NtLf
 lxz4fFk/vYvKvUu7CzgV4PuIDH3iIGLZEYKdZUqgsMxR+/TLpkMeJCN1jLNcl/vVnTPRl8/R+aZ
 m6pqimW33bHIp8mqJYS2ua1rVpm3IRSSxBZd01eV6K/AVWmeN5BjfSV12mtwJ8MVxu58E1nDhS2
 zND9mvdo3YxQNyUVxCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150093
X-Mailman-Approved-At: Mon, 15 Jun 2026 14:45:05 +0200
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

Hi Varada,

On 6/11/2026 4:27 PM, Varadarajan Narayanan wrote:
> On Sat, Jun 06, 2026 at 03:48:32PM +0530, Balaji Selvanathan wrote:
>> Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
>> the naming convention used by other SPL storage drivers (e.g.,
>> SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
>> $(PHASE_) prefix macro in Makefiles, allowing uniform use of
>> CONFIG_$(PHASE_)UFS across SPL and TPL build rules.
>>
>> Drop the redundant `depends on UFS` from the SPL_UFS entry since it is
>> already implied by the driver selection.
> How?
Since CONFIG_SPL_UFS and CONFIG_UFS are meant to be for SPL and Proper 
respectively, CONFIG_SPL_UFS is not dependent on CONFIG_UFS.
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - newly added in v2
>> ---
>>   common/spl/Kconfig    | 7 +++----
>>   common/spl/Makefile   | 2 +-
>>   drivers/Makefile      | 2 +-
>>   drivers/scsi/Makefile | 2 +-
>>   drivers/ufs/Kconfig   | 4 ++--
>>   5 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 5fa94098e49..10dcb7b2f87 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1613,9 +1613,8 @@ config SPL_THERMAL
>>   	  automatic power-off when the temperature gets too high or low. Other
>>   	  devices may be discrete but connected on a suitable bus.
>>
>> -config SPL_UFS_SUPPORT
>> +config SPL_UFS
>>   	bool "Support loading from UFS"
>> -	depends on UFS
>>   	select SPL_LOAD_BLOCK
>>   	help
>>   	  Enable support for UFS in SPL. This allows
>> @@ -1624,7 +1623,7 @@ config SPL_UFS_SUPPORT
>>
>>   config SPL_UFS_RAW_U_BOOT_DEVNUM
>>   	int "SCSI device number of the UFS device to load U-Boot from"
>> -	depends on SPL_UFS_SUPPORT
>> +	depends on SPL_UFS
>>   	default 0
>>   	help
>>   	  UFS devices are usually configured with multiple LUNs, which present
>> @@ -1637,7 +1636,7 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
>>
>>   config SPL_UFS_RAW_U_BOOT_SECTOR
>>   	hex "Address on the UFS to load U-Boot from"
>> -	depends on SPL_UFS_SUPPORT
>> +	depends on SPL_UFS
>>   	default 0x800 if ARCH_ROCKCHIP
>>   	help
>>   	  Address on the block device to load U-Boot from.
>> diff --git a/common/spl/Makefile b/common/spl/Makefile
>> index 9c94e8f143e..9714ada59f4 100644
>> --- a/common/spl/Makefile
>> +++ b/common/spl/Makefile
>> @@ -38,7 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
>>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
>> -obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
>> +obj-$(CONFIG_$(PHASE_)UFS) += spl_ufs.o
>>   endif
>>
>>   obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 43d0ba33281..86a54b5f332 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
>>   obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>>   obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>>   obj-$(CONFIG_SPL_THERMAL) += thermal/
>> -obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
>> +obj-$(CONFIG_SPL_UFS) += scsi/ ufs/
>>
>>   endif
>>   endif
>> diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
>> index c9af60d5d03..6d1f57bf101 100644
>> --- a/drivers/scsi/Makefile
>> +++ b/drivers/scsi/Makefile
>> @@ -16,7 +16,7 @@ ifdef CONFIG_XPL_BUILD
>>   ifdef CONFIG_SPL_SATA
>>   obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
>>   endif
>> -ifdef CONFIG_SPL_UFS_SUPPORT
>> +ifdef CONFIG_SPL_UFS
>>   obj-$(CONFIG_SCSI) += scsi.o scsi-uclass.o
>>   endif
>>   endif
>> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
>> index 49472933de3..64172454bc6 100644
>> --- a/drivers/ufs/Kconfig
>> +++ b/drivers/ufs/Kconfig
>> @@ -78,8 +78,8 @@ config UFS_ROCKCHIP
>>   	depends on UFS
>>   	depends on DM_GPIO
>>   	depends on RESET_ROCKCHIP
>> -	depends on SPL_DM_GPIO || !SPL_UFS_SUPPORT
>> -	depends on SPL_RESET_ROCKCHIP || !SPL_UFS_SUPPORT
>> +	depends on SPL_DM_GPIO || !SPL_UFS
>> +	depends on SPL_RESET_ROCKCHIP || !SPL_UFS
>>   	help
>>   	  This selects the Rockchip specific additions to UFSHCD platform driver.
> Additionally defconfig files that might use CONFIG_SPL_UFS_SUPPORT should be
> updated.

Added this in v2: 
https://lore.kernel.org/u-boot/20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com/

Thanks,

Balaji

>
> -Varada
