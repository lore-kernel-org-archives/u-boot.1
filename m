Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7728EF364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C7884142;
	Thu,  9 Apr 2026 20:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GQceI+QL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZB/g+ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E3C84099; Thu,  9 Apr 2026 18:04:21 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4B683D8A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639BtpT34107636
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 16:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KUG9XQMEBnpP39R2zd3i6Ct1z/spiDFYI82wiC+lj3c=; b=GQceI+QL4gNQi54e
 lfio1vG97O32XRuKJiLnRhiXXrNOJ+bFgTvNn8YpM9TxM9GfN0cv8uxu8AB3SZrL
 eghAvgLF0yq+dKZTSYO2R4eXJzZryjabWVYYC8EMDJLO5gt/1+nX4M8ZeIPCZWM2
 DZeFu5tt/RUtfXDRMBybn2GbKjWJ2V6UT+x+X93cKTtB/TGp0P3WlZFwVJTOLP8o
 0GnVW5Sbfd9yclY3DzjNzCQDg25FZDotqI1KQyKtrVsmro3hBJqsSn/r50fAcPAD
 I3ph1suVhM1AaIVpmAPwj7T8zyH2P52sLZOSSyc6AOW3RZdAlIZQNjsyJHWh/8ki
 hDV4YQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhakq5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 16:04:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso1229223a91.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775750656; x=1776355456; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KUG9XQMEBnpP39R2zd3i6Ct1z/spiDFYI82wiC+lj3c=;
 b=cZB/g+ft7YyAPKDwACfbmLxhC04qRZbNpU/yopfBKFwK3uL2ZOA1utdtjKbShpEbj2
 uxttzCqTFM6CO+ZX1sWTJzGdiTKEHsH0jRCiJuT2XAlOHuI7np/ww/VjfkSjDqS87xCh
 AHSJhPHlE24wEV5jiE4pOn4RxsruCKHPtZXs/0a5tze4YLiYgb2mTenzP4+qR6y3ukUu
 rHq6YATiBG/e0imu/4jW/A75lPYCiBz097rg4Pf09McrEMerLGZyvt/fhfXsy8IJqmUc
 j5hX+s0J+STbiFkNoFF1Cl2zdh9e/ydGMfmDW1Voev2Hff1Hk8wVGI8ACguLrQkCx6dC
 hZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750656; x=1776355456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KUG9XQMEBnpP39R2zd3i6Ct1z/spiDFYI82wiC+lj3c=;
 b=UydTkFv0rik+oDueL9spSZKbShGpQsw0afMigysFqAwCR6QagyrqUers6FwSF7YORl
 vRGaABaR8WD2FJLK8eulOjR9UoRh9j80QNP7eGxoYnji5z9qQQc9jrcalQ5MlD8RFOuY
 u2fatUIeJgsKAHqtcB7dUzNu4GBCE8AplXynQinmiHvIewM9ctQ5xMtXkdFRfaIRQC7A
 9kh2i9YcQOjRLnzlloU6s8qvrolJW9hXbTeidGFv4Ao9KIIe4yLMyciZ9KtJHXX9iLk8
 VxYNvvsbVU86tfct7/46NOnuSjCv2lpBoVNOVcgqcFAt8fuZ0dzFzIDsg2kKWLxFfBNV
 DHIQ==
X-Gm-Message-State: AOJu0Yzo6LuAzWNEOe8g99yAnuXzBw0Wu9VSgrToZ5RdTbeimH1Gpry6
 g+kpE2sveeZhvvjouN6C47TAIVYKI5KByMEQu39gIxShoug9xK7M8TU1/FmkCgmAnxO6DsFkhpl
 ST/UXXCrS7unaM1LPK6jnUpKcoEdgNDqyqBapWvprl1iPd0Vu0TuZLxn7
X-Gm-Gg: AeBDieuti86C45c+KE7XYRtKub+jMuHyfUFqU0VpK+MhQbNsLqURpbZnZ05dcq3KCIk
 WO33oWm+E9IgQ5B+xFEIUfo9XYnMyv+47FCCuHAfLIU6PkuJvo70SIjOzNKloN10O+klATgGGRW
 0PjAOsfStuLf5+WBn7nFK9MQ6ekP26TBkvCcdDUFTHGOBTr0QWudpYaH7psgqoXPb2/w8FIbIfw
 g10fWENdCdjxrOmyer0CHRMsKYn13/xAhLBEMy5naXIZWEceq9YtrMopJsopcLHE/lApWUg7bqp
 kqC9ZV+E+ydsyL+LsKjP9w5XixkHs89/uuTfYdevAecYGxMp94fC2mc/tIUgnCr4psEy7MeTsMh
 OrIkLvEAWzfw6cgJHROv/8wynSIH+/ym0w/hI+giiZ82zTDB7F6yJikM3KqQ=
X-Received: by 2002:a17:90b:52c7:b0:359:8dfd:64c8 with SMTP id
 98e67ed59e1d1-35de69702cdmr23316493a91.24.1775750655845; 
 Thu, 09 Apr 2026 09:04:15 -0700 (PDT)
X-Received: by 2002:a17:90b:52c7:b0:359:8dfd:64c8 with SMTP id
 98e67ed59e1d1-35de69702cdmr23316412a91.24.1775750654956; 
 Thu, 09 Apr 2026 09:04:14 -0700 (PDT)
Received: from [192.168.0.4] ([183.82.207.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm154334a91.8.2026.04.09.09.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 09:04:14 -0700 (PDT)
Message-ID: <7b42b6bd-8164-4f56-93f4-368d3b437507@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 21:34:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spl: ufs: Add partition support and flexible loading
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Tuyen Dang
 <tuyen.dang.xa@renesas.com>, Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
 <20260409-spl_ufs_only-v1-1-f7e0e243d805@oss.qualcomm.com>
 <CABjd4Yx3ckxysb20=vCL6xUADByOQA7bsRx1ZSCoRFp5MBE4FQ@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CABjd4Yx3ckxysb20=vCL6xUADByOQA7bsRx1ZSCoRFp5MBE4FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oVn9caXQTdG2IRssT8fRHZGqDNmq5BCl
X-Proofpoint-GUID: oVn9caXQTdG2IRssT8fRHZGqDNmq5BCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0NyBTYWx0ZWRfXwEqZk0mgIzfn
 UyO2oWdBBsMzhOvqA4UWp0mymKlGe15gGVxQhgGq070VRRtiQYwc7Vc/Ve9nehSqzz27lUVkMvP
 vuXeHuGaQVRUPpqpiYZHri1mRsAztUtiycqmc9WlFJH4GB7GltZh2ktiIpgSB7JTIFfF1qPT91O
 3w7ArFpEA+3Ank52J+rHH0C+jqXKJMY7fy3c1kGZ7+1QHniOXhhAZuqBsKSFUjfvZu+jBXLtSID
 c7VZBwMlny/ZKzbGWVIzrGW9sImQ28uya82/4AttkkPyHDB6tU1LHv1zxc+1iwfhqkCFeXVZgAH
 Zptt2ag1tRfK4yo9XPoN/P9U18je7KXA7LWLKUxi7yOfhQVkTzcMwuXrtnSQ4g5LB4SYcKPYZnB
 OD8gwy+8Kyt+rw0VJPpJrDBncBhHdYR0M3AGlrMgvDHuw8Kc51pN++54F4bu2dLWT5ZisdBs649
 ykUIUHuVQaf/c/6P8jA==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d7ce01 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=A13norTQGndBH59Ws6Bpcg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=PUyR3O8LRKCDiOPGNpMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090147
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:16 +0200
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

Hi Alexey,

Thanks for the feedbacks. Pls find replies below:

On 4/9/2026 9:09 PM, Alexey Charkov wrote:
> On Thu, Apr 9, 2026 at 6:43 PM Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Add partition-based loading support to SPL UFS, similar to the
>> existing implementation in spl_mmc.c. This allows loading from
>> named partitions or partition numbers instead of hardcoded sector
>> offsets.
>>
>> The loading strategy tries methods in order: absolute sector if
>> configured, partition by name, partition by number, then filesystem
>> mode (placeholder for future implementation).
>>
>> This brings UFS boot flexibility on par with MMC/SD boot.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   common/spl/Kconfig   |  40 ++++++++++-
>>   common/spl/spl_ufs.c | 188 +++++++++++++++++++++++++++++++++++++++++++++------
>>   include/part.h       |   3 +-
>>   include/spl.h        |   4 ++
>>   4 files changed, 214 insertions(+), 21 deletions(-)
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index a21b71ad5d1..b3c7a1d8aa3 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1637,9 +1637,47 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
>>          depends on SPL_UFS_SUPPORT
>>          default 0x800 if ARCH_ROCKCHIP
>>          help
>> -         Address on the block device to load U-Boot from.
>> +         Absolute sector offset on the UFS LUN to load U-Boot from.
>> +         This is tried first before partition-based loading.
>> +         Set to 0x0 to skip absolute sector loading and use partition mode.
>>            Units: UFS sectors (1 sector = 4096 bytes).
> Hi Balaji,
>
> What if I want to load the FIT image from the start of a dedicated LUN?
Yes, thats an issue, we can have sector as last step if partition name 
or number is not provided.
>
>> +config SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +       bool "Enable UFS partition support for raw mode"
>> +       depends on SPL_UFS_SUPPORT
>> +       select SPL_LIBDISK_SUPPORT
>> +       help
>> +         Enable support for loading from a specific partition on UFS
>> +         in raw mode. When enabled, you can specify either a partition
>> +         name or partition number to load from.
>> +
>> +config SPL_UFS_RAW_U_BOOT_PARTITION_NAME
>> +       string "Partition name to load U-Boot from"
>> +       depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +       help
>> +         Name of the partition to load U-Boot from in UFS raw mode.
>> +         This is tried before partition number lookup.
>> +         Leave empty to skip name-based lookup.
>> +         Example: "boot", "uefi", "dtb_a"
>> +
>> +config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
>> +       int "Partition number to load U-Boot from"
>> +       depends on SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +       help
>> +         Partition number to load U-Boot from when using UFS raw mode
>> +         with partition support. This is used if partition name is not
>> +         specified or not found.
>> +
>> +config SPL_UFS_FS
>> +       bool "Enable UFS filesystem boot mode"
>> +       depends on SPL_UFS_SUPPORT
>> +       help
>> +         Enable filesystem-based boot from UFS. This allows loading
>> +         U-Boot from FAT or EXT4 filesystems on UFS partitions.
>> +         This is tried as a fallback if raw mode loading fails.
>> +
>> +         Note: Filesystem support is not yet fully implemented.
> Maybe split those into separate commits for easier review?
Okay.
>
>>   config SPL_WATCHDOG
>>          bool "Support watchdog drivers"
>>          imply SPL_WDT if !HW_WATCHDOG
>> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
>> index cef1843f40f..c4e793bf701 100644
>> --- a/common/spl/spl_ufs.c
>> +++ b/common/spl/spl_ufs.c
>> @@ -3,15 +3,19 @@
>>    * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
>>    */
>>
>> +#include <dm.h>
>> +#include <log.h>
>>   #include <spl.h>
>>   #include <spl_load.h>
>>   #include <scsi.h>
>> -#include <errno.h>
>> -#include <image.h>
>> +#include <part.h>
>> +#include <blk.h>
>>   #include <linux/compiler.h>
>> -#include <log.h>
>> +#include <errno.h>
>>
>> -static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
>> +/* Block read callback for spl_load framework */
>> +static ulong h_spl_ufs_load_read(struct spl_load_info *load, ulong off,
>> +                                ulong size, void *buf)
>>   {
>>          struct blk_desc *bd = load->priv;
>>          lbaint_t sector = off >> bd->log2blksz;
>> @@ -20,30 +24,176 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
>>          return blk_dread(bd, sector, count, buf) << bd->log2blksz;
>>   }
>>
>> -static int spl_ufs_load_image(struct spl_image_info *spl_image,
>> -                             struct spl_boot_device *bootdev)
>> +/* Load image from raw sector */
>> +static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
>> +                                    struct spl_boot_device *bootdev,
>> +                                    struct blk_desc *bd,
>> +                                    unsigned long sector)
>>   {
>> -       unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
>> -       int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>>          struct spl_load_info load;
>> +       int ret;
>> +
>> +       debug("spl: ufs loading from sector 0x%lx\n", sector);
>> +
>> +       spl_load_init(&load, h_spl_ufs_load_read, bd, bd->blksz);
>> +       ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>> +
>> +       if (ret) {
>> +               debug("spl: ufs load failed: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       debug("spl: ufs load successful\n");
>> +       return 0;
>> +}
>> +
>> +u32 __weak spl_ufs_boot_mode(const u32 boot_device)
>> +{
>> +       return UFS_MODE_RAW;
>> +}
>> +
>> +int spl_ufs_load(struct spl_image_info *spl_image,
>> +                struct spl_boot_device *bootdev,
>> +                const char *filename)
>> +{
>> +       u32 boot_mode;
>> +       int ret = 0;
>> +       int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>>          struct blk_desc *bd;
>> -       int err;
>> +       unsigned long sector = 0;
>> +
>> +       log_debug("spl: ufs devnum=%d\n", devnum);
>> +
>> +       ret = scsi_scan(false);
>> +       if (ret) {
>> +               printf("spl: scsi scan failed: %d\n", ret);
>> +               return ret;
>> +       }
>>
>> -       /* try to recognize storage devices immediately */
>> -       scsi_scan(false);
>>          bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
>> -       if (!bd)
>> +       if (!bd) {
>> +               printf("spl: could not get UFS device %d\n", devnum);
>>                  return -ENODEV;
>> +       }
>>
>> -       spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
>> -       err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>> -       if (err) {
>> -               puts("spl_ufs_load_image: ufs block read error\n");
>> -               log_debug("(error=%d)\n", err);
>> -               return err;
>> +       boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
>> +
>> +       switch (boot_mode) {
>> +       case UFS_MODE_RAW:
>> +               debug("spl: ufs raw mode\n");
>> +
>> +               /* Step 1: Try absolute sector (if configured and non-zero) */
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR
> Perhaps if this and the below blocks are split out into helper
> functions which compile to a no-op when the respective Kconfig option
> is not set the code would be prettier :)
>
> Preprocessor defines really break the flow visually by going across
> the indentation of the surrounding code.
Got it, will implement this.
>
>> +               if (CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR != 0) {
>> +                       debug("spl: trying absolute sector 0x%x\n",
>> +                             CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
>> +
>> +                       ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
>> +                                                       CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
>> +
>> +                       if (!ret) {
>> +                               debug("spl: loaded from absolute sector\n");
>> +                               return 0;
>> +                       }
>> +                       debug("spl: absolute sector failed: %d\n", ret);
>> +               }
>> +#endif
>> +
>> +               /* Step 2-4: Try partition-based loading */
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION
>> +               {
>> +                       struct disk_partition part_info;
>> +                       int part_found = 0;
> ... especially since you want to use scoped blocks with local
> variables. These really ask to go into a helper function instead.
Okay.
>
>> +                       /* Step 2: Try partition name (if configured) */
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
>> +                       if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
>> +                               debug("spl: trying partition name '%s'\n",
>> +                                     CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
>> +
>> +                               ret = part_get_info_by_name(bd,
>> +                                                           CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
>> +                                       &part_info);
>> +
>> +                               if (ret >= 0) {
>> +                                       debug("spl: found partition '%s' at 0x%lx\n",
>> +                                             CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
>> +                                             (ulong)part_info.start);
>> +                                       sector = part_info.start;
>> +                                       part_found = 1;
>> +                               } else {
>> +                                       debug("spl: partition name not found: %d\n", ret);
>> +                               }
>> +                       }
>> +#endif
>> +
>> +                       /* Step 3: Try partition number (if name not found) */
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM
>> +                       if (!part_found) {
>> +                               debug("spl: trying partition number %d\n",
>> +                                     CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
>> +
>> +                               ret = part_get_info(bd,
>> +                                                   CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
>> +                                                   &part_info);
>> +
>> +                               if (ret >= 0) {
>> +                                       debug("spl: found partition %d at 0x%lx\n",
>> +                                             CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
>> +                                             (ulong)part_info.start);
>> +                                       sector = part_info.start;
>> +                                       part_found = 1;
>> +                               } else {
>> +                                       debug("spl: partition number not found: %d\n", ret);
>> +                               }
>> +                       }
>> +#endif
>> +
>> +                       /* Load from partition if found */
>> +                       if (part_found) {
>> +                               ret = ufs_load_image_raw_sector(spl_image, bootdev, bd, sector);
>> +
>> +                               if (!ret) {
>> +                                       debug("spl: loaded from partition\n");
>> +                                       return 0;
>> +                               }
>> +                               debug("spl: partition load failed: %d\n", ret);
>> +                       }
>> +               }
>> +#endif /* CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION */
>> +
>> +               /* Step 4: Fall through to FS mode if enabled */
> Wouldn't a raw offset be a more natural fallback, given that it has
> fewest dependencies out of all these options?
Yes, will do this.
>
>> +               debug("spl: raw mode failed, trying fs\n");
>> +               fallthrough;
>> +
>> +#ifdef CONFIG_SPL_UFS_FS
>> +       case UFS_MODE_FS:
>> +               debug("spl: ufs fs mode\n");
>> +
>> +               /* TODO: Implement filesystem support */
>> +               printf("spl: ufs filesystem boot not implemented\n");
>> +               ret = -ENOSYS;
>> +               break;
>> +#endif
>> +
>> +       default:
>> +               puts("spl: ufs: invalid boot mode\n");
>> +               ret = -EINVAL;
>>          }
>>
>> -       return 0;
>> +       return ret;
>> +}
>> +
>> +/* SPL load image entry point */
>> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
>> +                             struct spl_boot_device *bootdev)
>> +{
>> +       return spl_ufs_load(spl_image, bootdev,
>> +#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
>> +                           CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
>> +#else
>> +                           NULL);
>> +#endif
> How about config_enabled(...) instead? Gives fewer repetitions of the
> same symbol.
Okay.
>
> Best regards,
> Alexey
