Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221F3CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FA884884;
	Mon, 15 Jun 2026 14:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7MVXPt3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScLIkBRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C85084869; Mon, 15 Jun 2026 10:57:26 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B982383FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IuNL3346571
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p+OJ45OotG+ZQ/zc+WDa0N4WxgVJaHbx9uNoPrppgbo=; b=P7MVXPt3DndH1LVn
 WpwGMccu+BTA7AsAamJfBEGbLg7s2xP2WLEZiiNGJ/9UaEXW2dLdV/F5mBqYlIwi
 F9ks9VxL3MhMhYAAtUMBDgOZDhvZE2GWpE9vJDY3P93XsZYiFtvTiwrCbwhPEYvY
 ryfubVz/a8/k/SQMgxxxDZLxKGQllK2GBRGR10gAD71SsseL1bdu12amv3xLPzrR
 88A9CB2EAxsFnT4ihdBL3kCMYWUKvVNy1YcA+kbYG/t2RdFXa/ZULzDsmWaHaQFC
 pJ21d5p3s0wL21+P97pOLvpak8pvoX5BFGPXjd8E2BQRr4QZpgu9hQfgeYtZBsbT
 pR/wRw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0g86j3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:57:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-842211d6e48so3923408b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513841; x=1782118641; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p+OJ45OotG+ZQ/zc+WDa0N4WxgVJaHbx9uNoPrppgbo=;
 b=ScLIkBRH3hYdiSMCDGAlZUhYMy2ixNIz6v3q864HuGJGuOqnge8ffS5t65z0ATB4Gp
 vDufgwBJtRW80RiawQEhN1jisWHvHbBxxuzb8joNlgKtItevpDrFfeJ8A7hh2LRo+arN
 0OgJqBrVxepn77eGlBLE1PrYAkHarUac+VkwMxOeYTChciL0R6zBKjCs3IxVq6zpyPfa
 +stk+tLY6h/NIDPHZdzV58CySdBsgL9xtLSE451knW2y9s7c32YrngFKy40n/BDCHQTw
 3XPwa4JqwbPxhF1J5kD1MlLZ7ae5UyDgBctzDm3OvprY6xBqiG9i5V467mY4SfkEhxTI
 abWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513841; x=1782118641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+OJ45OotG+ZQ/zc+WDa0N4WxgVJaHbx9uNoPrppgbo=;
 b=JsZiP6Lat6C/FtryRwbiGRvuLginCiyfDI/6Bw8rFixlfCl30OUWstDxCHPDcCOKw9
 migVGSorpMkue1mQWYGYDifLkjCCOktoOudzTpApuRlyVqbiwgDFt6DEqOjqL//5Co+2
 D/81xrUgarZanTjr9zMZZy3LNFKctQZnouGv36CDfEkVkzYZWe29DWOzkPxgf2oVeQlU
 fNMQ4Xi6+QT5tNFkS/4dWLyv7NFe8qYtEw00m9TEWgh22CyaRF65/U+Vj1XjsdSYR6gm
 w+6+74hf/a1MYqzYBmat5G9EHeB86kWtkxiiTJjdIeCKvXB3cqA+7n9Yg0XHDLkL9eHv
 Ujlg==
X-Gm-Message-State: AOJu0YzVFVt7jf/aL/yDPVhp3uFo8v6CjBMkLDTrHHoeoz9ktLuohzr2
 Rr8k0fS0ly64fzJkpcQ6vDdU+lj1YF6UKvRcegelDblq4KhSf5zPKjYdVsZQRKuni2YkM9GeXqd
 Tx0bzALwJYFb8fKmV17Z1yIJs1V/fDec4+1OdE0IMoCLJyPCJ6t7OLwFS
X-Gm-Gg: Acq92OGgafn6p3C31PQ29OQQ0csBCPDB9Vk+nBdjJeLpgLm9B/3hnKGkpz/m2duptUz
 j2sbCien+7JQtV8H0vmCYYU/fR4+PJQNM+OwfYIaZwv8SqJiRHEjZa/xwQLKOvvLpSgEy7lAnoO
 9r8prkMed8RsakthbCBHoRmp+OfaNzfeeArYbFcniDf1cqtqc8FKE3tzB/jx1efLDl/7d5UYUdO
 7I5bU5GclntGWZ4fTwjPQZdQrWrmY5dnjApk/Dun3xHwW4mIquN0nBVwutXTuxcR+HfdU6PAFED
 UELcg2K6KoXwrrSpi2joZbRRbGUFUD7XhZUBCcR8HQgqQWdKkJxWLszqSdPGVMkaNK/ShwaoVyJ
 R0FxfCaq1/FGl9cB84KHGvMnMJ7u5Ob6KV3UgSqME2mrGw0tHAM7fsj0BEnM=
X-Received: by 2002:a05:6a21:3282:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3b7840a7595mr14859974637.44.1781513841010; 
 Mon, 15 Jun 2026 01:57:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:3282:b0:3b4:84de:aa79 with SMTP id
 adf61e73a8af0-3b7840a7595mr14859906637.44.1781513840534; 
 Mon, 15 Jun 2026 01:57:20 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f88bsm8140904a12.27.2026.06.15.01.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:57:20 -0700 (PDT)
Message-ID: <60f59965-409d-41ee-8096-2608f7ca0c86@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:27:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] spl: ufs: add Kconfig choice for U-Boot location
 method
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
 <20260606-spl_ufs-v2-2-72fed24ef01b@oss.qualcomm.com>
 <aiqXFoZu3OHn7WzV@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aiqXFoZu3OHn7WzV@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OOoXGyaB c=1 sm=1 tr=0 ts=6a2fbe71 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=oIZtpUbAcPav1KIK6esA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 6on_pl6bqlkXU_2rBUD3pHeHrUbDf3yk
X-Proofpoint-ORIG-GUID: 6on_pl6bqlkXU_2rBUD3pHeHrUbDf3yk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MyBTYWx0ZWRfXyTxpUWQ2Uq55
 dO9qM3LWhqh2/AlEM/9Ff9v71JQ1rc19Li7OPt8G3yiSr0pZJeOo+EOU3fef8rh1vgc2UqekFXJ
 e2ie/Jr82koyQt4WvD97jWSaLX5dyE335izTd+6fCHXfzPZlJ+qvKJKYoE9eZIub+9G/9lowJyl
 Atv/bzMK0u5R6ulMQz8YTjE1/wumUT/qjJ8VZfcYCpsmpU3/5urNbzQcnaaLbcuEUzgs7J/UeSy
 FYwF1HEABN9VX8N6x5r8wtLKEV9oxyIGwhIqn7MPmzBbz5FxFQZjyesIWcQyIwBzC1Y3zpRZBKi
 H0nRhlKxn9oGxpHSfb5w1Nq9/IC3KF+gDOHUiwX/1I/8/cCds558/wcxaJIwaseaF13iAG4Aeka
 zBqdl59Mk/yszQ+OdyA5PQdnQNH/a9e+oPl0jlVc1chb0jgMz4DTTHLZBpPBAxOEOoKCKRhQ8xE
 +sy9lLdSJ9x+f2yluZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MyBTYWx0ZWRfXxV8eNQ55dzHn
 +HRs4KSfc+j8ArdTyu0aHs8Gf6ZqQ+24nGQLcA49bNyz3QZrgc0cW01wuJTHPxSDikNQPYm/NFK
 j2ZPxUsfjSgYXdVjdWTZr9K+WHlOW4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
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

On 6/11/2026 4:38 PM, Varadarajan Narayanan wrote:
> On Sat, Jun 06, 2026 at 03:48:33PM +0530, Balaji Selvanathan wrote:
>> Replace the single SPL_UFS_RAW_U_BOOT_SECTOR config with a Kconfig
>> choice that lets the user select how U-Boot is located on the UFS
>> LUN: by absolute sector offset or by partition.
>>
>> The sector-based path (SPL_UFS_RAW_U_BOOT_USE_SECTOR) retains the
>> existing SPL_UFS_RAW_U_BOOT_SECTOR option with an explicit default
>> of 0x0.
>>
>> The partition-based path (SPL_UFS_RAW_U_BOOT_USE_PARTITION) adds
>> SPL_UFS_RAW_U_BOOT_PARTITION_NAME and
>> SPL_UFS_RAW_U_BOOT_PARTITION_NUM, allowing U-Boot to be loaded by
>> partition name (tried first) or partition number as a fallback.
>> SPL_LIBDISK_SUPPORT is automatically selected when this path is
>> chosen.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Introduce SPL_UFS_RAW_U_BOOT_USE_SECTOR to clearly select between
>>    sector based or partition based lookup
>> ---
>>   common/spl/Kconfig | 46 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 10dcb7b2f87..82b757d1efa 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1634,13 +1634,53 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
>>   	  SCSI device number, which might differ from the UFS LUN if you have
>>   	  multiple SCSI devices attached and recognized by the SPL.
>>
>> -config SPL_UFS_RAW_U_BOOT_SECTOR
>> -	hex "Address on the UFS to load U-Boot from"
>> +choice
>> +	prompt "Method for locating U-Boot on UFS"
>>   	depends on SPL_UFS
>> +	default SPL_UFS_RAW_U_BOOT_USE_SECTOR
>> +
>> +config SPL_UFS_RAW_U_BOOT_USE_SECTOR
>> +	bool "UFS raw mode: by sector"
>> +	help
>> +	  Use absolute sector number for specifying U-Boot location on UFS LUN.
>> +	  When selected, SPL_UFS_RAW_U_BOOT_SECTOR specifies the sector offset.
>> +
>> +config SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +	bool "UFS raw mode: by partition"
>> +	select SPL_LIBDISK_SUPPORT
>> +	help
>> +	  Use a partition for loading U-Boot when using UFS in raw mode.
>> +	  You can specify either a partition name or partition number.
>> +
>> +endchoice
>> +
>> +config SPL_UFS_RAW_U_BOOT_SECTOR
>> +	hex "Sector offset to load U-Boot from in UFS raw mode"
>> +	depends on SPL_UFS_RAW_U_BOOT_USE_SECTOR
>>   	default 0x800 if ARCH_ROCKCHIP
>> +	default 0x0
>>   	help
>> -	  Address on the block device to load U-Boot from.
>> +	  Absolute sector offset on the UFS LUN to load U-Boot from.
>>   	  Units: UFS sectors (1 sector = 4096 bytes).
>> +	  Note: Setting this to 0x0 will load from the start of the LUN.
>> +
>> +config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
>> +	string "Partition name to load U-Boot from"
>> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +	help
>> +	  Name of the partition to load U-Boot from in UFS raw mode.
>> +	  This is tried before partition number lookup.
>> +	  Leave empty to skip name-based lookup.
>> +	  Example: "boot", "uefi", "dtb_a"
>> +
>> +config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
>> +	int "Partition number to load U-Boot from"
>> +	depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +	default 1
>> +	help
>> +	  Partition number to load U-Boot from when using UFS raw mode
>> +	  with partition support. This is used if partition name is not
>> +	  specified or not found.
> Should PARTITION_NAME and PARTITION_NUM be mutually exclusive, or both are
> allowed?
Both are allowed.
>
>>   config SPL_WATCHDOG
>>   	bool "Support watchdog drivers"
> Can this be simplified?
>
> config SPL_UFS_RAW_U_BOOT_USE_PARTITION
> 	bool "..."
> 	...
>
> config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> 	...
>
> config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
> 	...
>
> config SPL_UFS_RAW_U_BOOT_SECTOR
> 	hex "Address on the UFS to load U-Boot from"
> 	depends on SPL_UFS_SUPPORT && !SPL_UFS_RAW_U_BOOT_USE_PARTITION
>
> -Varada

spl_mmc.c uses SPL_UFS_RAW_U_BOOT_SECTOR for sector and 
SPL_UFS_RAW_U_BOOT_USE_PARTITION for partition. So following same way 
for UFS.

Thanks,

Balaji

