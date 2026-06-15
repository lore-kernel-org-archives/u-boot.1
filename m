Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C36FCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCB1848A2;
	Mon, 15 Jun 2026 14:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jPl8w7cN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRHOarI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A04F84869; Mon, 15 Jun 2026 10:58:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C218A83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J8vE3250401
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rWlvUuHnWI3zVh9hB6IPH+fc5L/scSuXkboIceiRLEs=; b=jPl8w7cNZJ8F2CIf
 4E8Ysm341OdIeS5rK2K2xzOmZjfAV8B2vM/hNy6XpyyM3s9dQL9woPzHBJ3Ow1NN
 7fsne9QnGCwe3mE1/7sIerrpGR1xwBRx3a9IhDNacg/6rO2rQY5QTrw8eau6Rs5Q
 prHuhmYzM4XB/s3batN97mGszjS1FZVQ0KKva9s3Z7WVMzOsGOK8Yb6/tOYBC9Xc
 m/6wmtwFzli3Hs2LKbCZ1Eg4qyydjyMZHpftxJMG0/uxutVXOvZnMc2YiMyBnd6V
 G8hFPHqhh+TmPz0Wq9WS3DNYcgcx+Q3yhJM2iYCN9Ht0dEMDRj9RU59+rDCpAP1/
 CeGLSw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryybxeqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:58:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36db995d083so2179262a91.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513916; x=1782118716; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWlvUuHnWI3zVh9hB6IPH+fc5L/scSuXkboIceiRLEs=;
 b=WRHOarI+mCA6cnWzihdyuE+0wWZN6nG5qj4ACc5y6SPfFDUc+uILX/gXh00zXQLtZ/
 Y8WysLu5dhIl+JK9rBm51MABz0RWbXmENRiWRfPDajGOriEflNhErKbSG7vKGHabau+o
 K9GLu7nmioLymoQVccX+RixYd9U0Y11Gek4KrIEEYBY3rFv66VATa1qmnHQnHpiBTVnM
 jfypVrPN/YG2WTEUp3WACaPvDOMyaI/syHvQ4OzK4iXHpKBcSbV3BW4J/f6nk4ZrQsm2
 0in/WMGgad98FmOl+Gjmzcg3K0TZM+SkeTpejiwLxXNoxNtPbMTzATn/dFeWSZgMUQUE
 8kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513916; x=1782118716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWlvUuHnWI3zVh9hB6IPH+fc5L/scSuXkboIceiRLEs=;
 b=A3CrSdxB9TrCH5x/qielrOymc+6hq8aR4arqqk/xDM285eUJq6K7zFA7lwWcx9yttB
 cq8n7eDfaEFQMzwnNPmKEgmhsMCGg3yWENTWiq751YJtot+JbaW1RyTyn/L3z388yvic
 MZqgmmULOxcxABkmtXY9+zGoD88r4lhKEbLSSiKu+eh9jsvJ5nptgzOCYR1BT0oxdz9M
 /saHO57fVeQifFoPv6Hn09v8C5t0MCf03GiNP+ClI72ZRRwrITTYCq2N3wB8GhMCxGcF
 OXV1cM9/z6BI5VyViFiJ5swMfY9+/eNasHRAoDM+BSLyiB0mWJHX2if/7BIVxEKx1T6h
 j9NA==
X-Gm-Message-State: AOJu0YxQlhgTo/Ok7UIvsZar/WQ9uANpIOYvjf6N5S/hNSnHHSa3kDGD
 xizr8NFmW2tF/LswQzxLL6VMKTenPcYiHu4J2G/eOymmO9sEk5yc8FoHffeYJn7SqPIyjJK4iIV
 E7n51a3jOqW7Ee0cLvIc26oFu/yqCcPpbDyICrR4/pbWBAofyeWND2h7+
X-Gm-Gg: Acq92OFU7mv3xW6PcoDqDdGl0FJuG+BmXvItj5qgGcTMqInGJPuplPVpKD/PIug2tUY
 9A7Nqw+nyzSvCN1MZU4jof7trxJIHuJ9i5xQOA4Z2ZfTPm8LmC+k7oKkwwzMnWlxbW8JyV7nzRL
 12E+PR6nOnnS2ZxhagTP1SAuA+S0UQLmFE7k65eIOxJnb5XBPa6rDg6EjBbg2lDyrUglezxDQWX
 CrmG2yqHyd+Xe3LILVcoo+jAPfS55de2PyYfQ0EfwQcYstzqoIJDG4Dmg9PpRSMRNv7Bxnk/KXd
 FytP6nHBeUquQ/wkvkeiSu4pDhu45lS+DPBIQ8rRRgqTtGNHZ3xyGrU3sqQtQ3haVF5Lqiq7fXX
 YfXxYcBSQdDO3F6JHtwY+ugn3riXNY3pHW3gisRDt/KzdP+I475VUJQ/oguQ=
X-Received: by 2002:a17:90a:e7c4:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-37a04493d9bmr14700606a91.19.1781513916032; 
 Mon, 15 Jun 2026 01:58:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c4:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-37a04493d9bmr14700558a91.19.1781513915514; 
 Mon, 15 Jun 2026 01:58:35 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37a1eba8e9asm9791317a91.2.2026.06.15.01.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:58:35 -0700 (PDT)
Message-ID: <d1f3004f-b5f9-47dc-9eae-663338ff9918@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:28:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] spl: ufs: add partition-based U-Boot loading
 support
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
 <20260606-spl_ufs-v2-3-72fed24ef01b@oss.qualcomm.com>
 <aiqbfGNQM+MHBNx5@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aiqbfGNQM+MHBNx5@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zB_dZ0JjAAM9qqkOA4hY3lW3lAWhFCpJ
X-Proofpoint-ORIG-GUID: zB_dZ0JjAAM9qqkOA4hY3lW3lAWhFCpJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfXxgEXuG+VD2NQ
 1ytTNTDc4FyGDJazYEdUj1WDuCcH0L55SPRkPDh2D7CO9W/Zjw102U2dM8grCeV1q1M/K5+YgB1
 bjvM8f8SAAyMtAXwDUNc1/siKQwi2Cs=
X-Authority-Analysis: v=2.4 cv=JLYLdcKb c=1 sm=1 tr=0 ts=6a2fbebc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=RYG-cPq9DC31K0o2w08A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfX6EEZAP3E/mBJ
 qe53dkt4C+jzFTidrFXI4PMy58ziWMufsRBNloDFYlTnMES9xHRfK/be/yXTJhatmgtXAjtHAWK
 CT48CzrwFqsLyGUUTw9E8qBKtQdmvfVu14H7OveTBGf+JnDxy2oXiLoXRfy/vdz/Hwf+G7o0x2l
 hU1+SBEbSytt3AeUMAEWBZk9RHVXxI/xfnZkogoOWLQi8zc/2namxZu6QS5MrJHoAqhyo94kONN
 Phd2QSqL6qQLvX2MtSSoWkLdL/+BbZ5zWazQo5rU+IXqmVllhGXwVm0az52OdikVSPjZULb66DN
 laFfGMPQ2AejqJCXiolIsKzG7ydcJw6JcNbOpIWohLDpge3a9T9/iKsVTh/wMSxuWbp3DLdqioB
 2FFfYwq8mj69j8oZFolcgmc2OeptlRCk27Drgf72BzfTTVI4z0u7Rea/HfwuOJ4LDCIVNUyB0ZA
 5sYYTIc47vCHf5wjArg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150094
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

On 6/11/2026 4:56 PM, Varadarajan Narayanan wrote:
> On Sat, Jun 06, 2026 at 03:48:34PM +0530, Balaji Selvanathan wrote:
>> Refactor spl_ufs.c to support loading U-Boot either from a raw
>> sector offset or from a named/numbered partition, controlled by
>> the Kconfig choice introduced in the previous commit.
>>
>> The monolithic spl_ufs_load_image() is split into helper functions:
>> ufs_load_image_raw_sector() handles sector-based loading, and
>> ufs_load_image_raw_partition() resolves the target sector by looking
>> up a partition name first, falling back to partition number. A new
>> exported spl_ufs_load() function drives the boot-mode switch and
>> can be reused by other callers. A weak spl_ufs_boot_mode() hook
>> allows board code to override the default raw boot mode.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Refactored the codes in common/spl/spl_ufs.c to use helper functions
>>    to make the codes readable and clear
>> ---
>> ---
>>   common/spl/spl_ufs.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 134 insertions(+), 19 deletions(-)
>>
>> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
>> index cef1843f40f..0590b796267 100644
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
>> +static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
>> +			     ulong size, void *buf)
> Not sure why the 'spl_ufs' prefix has changed. I assume these are SPL specific
> since this is in spl_ufs.c.
Changed to spl_ufs_load_read in v3: 
https://lore.kernel.org/u-boot/20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com/ 

>
>>   {
>>   	struct blk_desc *bd = load->priv;
>>   	lbaint_t sector = off >> bd->log2blksz;
>> @@ -20,30 +24,141 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
>>   	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
>>   }
>>   
>> -static int spl_ufs_load_image(struct spl_image_info *spl_image,
>> -			      struct spl_boot_device *bootdev)
>> +/* Load image from raw sector */
>> +static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
>> +				     struct spl_boot_device *bootdev,
>> +				     struct blk_desc *bd,
>> +				     unsigned long sector)
>>   {
>> -	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
>> -	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>>   	struct spl_load_info load;
>> +	int ret;
>> +
>> +	debug("spl: ufs: loading from sector 0x%lx\n", sector);
>> +
>> +	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
>> +	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>> +
>> +	if (ret) {
>> +		printf("%s: ufs block read error\n", __func__);
>> +		log_debug("(error=%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Find and load from partition */
>> +static int ufs_load_image_raw_partition(struct spl_image_info *spl_image,
>> +					struct spl_boot_device *bootdev,
>> +					struct blk_desc *bd)
>> +{
>> +	struct disk_partition part_info;
>> +	int ret;
>> +
>> +	/* Try partition name first if configured */
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
>> +	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
>> +		debug("spl: ufs: trying partition name '%s'\n",
>> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
>> +
>> +		ret = part_get_info_by_name(bd,
>> +					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
>> +					    &part_info);
>> +		if (ret >= 0) {
>> +			debug("spl: ufs: found partition '%s' at 0x%lx\n",
>> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
>> +			      (ulong)part_info.start);
>> +			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
>> +							 part_info.start);
>> +		}
>> +		debug("spl: ufs: partition name not found: %d\n", ret);
>> +	}
>> +#endif
>> +
>> +	/* Try partition number if configured */
>> +	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
>> +		debug("spl: ufs: trying partition number %d\n",
>> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
>> +
>> +		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
>> +				    &part_info);
>> +		if (ret >= 0) {
>> +			debug("spl: ufs: found partition %d at 0x%lx\n",
>> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
>> +			      (ulong)part_info.start);
>> +			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
>> +							 part_info.start);
>> +		}
>> +		debug("spl: ufs: partition number not found: %d\n", ret);
>> +	}
> The debug() is not considered, both the above if blocks are same except for
> part_get_info_by_name & part_get_info.
>
> 	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0)
> 		ret = part_get_info_by_name(bd, ...);
>
> 	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM))
> 		ret = part_get_info(bd, ...);
>
> 	if (ret >= 0)
> 		return ufs_load_image_raw_sector(...);

Implemented above in v3: 
https://lore.kernel.org/u-boot/20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com/

Thanks,

Balaji

>
> -Varada
>
>> +
>> +	puts("spl: ufs: partition error\n");
>> +	return -ENOENT;
>> +}
>> +
>> +u32 __weak spl_ufs_boot_mode(const u32 boot_device)
>> +{
>> +	return UFS_MODE_RAW;
>> +}
>> +
>> +int spl_ufs_load(struct spl_image_info *spl_image,
>> +		 struct spl_boot_device *bootdev,
>> +		 const char *filename)
>> +{
>> +	u32 boot_mode;
>> +	int ret = 0;
>> +	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>>   	struct blk_desc *bd;
>> -	int err;
>>   
>> -	/* try to recognize storage devices immediately */
>> -	scsi_scan(false);
>> +	log_debug("spl: ufs: devnum=%d\n", devnum);
>> +
>> +	ret = scsi_scan(false);
>> +	if (ret) {
>> +		printf("spl: ufs: scsi scan failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
>> -	if (!bd)
>> +	if (!bd) {
>> +		printf("spl: ufs: could not get device %d\n", devnum);
>>   		return -ENODEV;
>> +	}
>> +
>> +	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
>> +	ret = -EINVAL;
>>   
>> -	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
>> -	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
>> -	if (err) {
>> -		puts("spl_ufs_load_image: ufs block read error\n");
>> -		log_debug("(error=%d)\n", err);
>> -		return err;
>> +	switch (boot_mode) {
>> +	case UFS_MODE_RAW:
>> +		debug("spl: ufs: boot mode: raw\n");
>> +
>> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_SECTOR
>> +		ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
>> +						CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
>> +		if (!ret)
>> +			return 0;
>> +#elif defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
>> +		ret = ufs_load_image_raw_partition(spl_image, bootdev, bd);
>> +		if (!ret)
>> +			return 0;
>> +#endif
>> +		break;
>> +	default:
>> +		puts("spl: ufs: wrong boot mode\n");
>>   	}
>>   
>> -	return 0;
>> +	return ret;
>> +}
>> +
>> +/* SPL load image entry point */
>> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
>> +			      struct spl_boot_device *bootdev)
>> +{
>> +	return spl_ufs_load(spl_image, bootdev,
>> +#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
>> +			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
>> +#else
>> +			    NULL);
>> +#endif
>>   }
>>   
>>   SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
>>
>> -- 
>> 2.34.1
>>
