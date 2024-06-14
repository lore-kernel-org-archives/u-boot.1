Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78D4C27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 04:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADEBD87C7F;
	Sat, 15 Jun 2024 06:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="KXG4o9P+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB1C87C7E; Fri, 14 Jun 2024 23:31:56 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE72D8780A
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 23:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EKv4iJ007862;
 Fri, 14 Jun 2024 21:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 2UPQJkmtqfAmJH5xG0Bp49TLJBJpfZNCMJNxC2Jg83s=; b=KXG4o9P+cmWx6NT6
 Qy0RWb2sbFNG4yMSWyPXrxsTMWUED5ac3jB/WnIiffviEHuX40Jzlshzj5Vjlhji
 A9QintbSIp37vAixHoQ2zdjYB1ssQ8QCXt+Ulvj3pYMZjaSB8NIe68Ym5vk9J0he
 s4NOjuC2YFKl7sIKrRzGOi+IZ/kC1KAkEhK2fuDHbgodHq/1ujFvhI9Qih1iyBKA
 IPJI87YVCiS4mVpy6fOrdDtJ/gjdP+VYM2uGZTs8QB8Oq1yoySC0rTtrr4g68gbL
 lZKev910oPz6GiHKFSWOP8u1VDgFRlJP16D4ufAPf+t5wWviVMEhrCzIirsaLLCG
 PLud/Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrvg7r605-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 21:31:49 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ELVmj3030871;
 Fri, 14 Jun 2024 21:31:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrvg7r604-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 21:31:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45EL02iF028651; Fri, 14 Jun 2024 21:31:47 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mv59ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 21:31:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45ELViNw14222064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2024 21:31:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 833C258057;
 Fri, 14 Jun 2024 21:31:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45A1858062;
 Fri, 14 Jun 2024 21:31:44 +0000 (GMT)
Received: from [9.61.43.162] (unknown [9.61.43.162])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2024 21:31:44 +0000 (GMT)
Message-ID: <8b18f131-4e9d-4706-9a43-9ceb35f14d51@linux.ibm.com>
Date: Fri, 14 Jun 2024 16:31:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: measure DTB in PCR1 instead of PCR0
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
References: <20240614120951.16158-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20240614120951.16158-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mhQGXjWQtH43W_JVtMsxprk41F6cmf0S
X-Proofpoint-GUID: uauplMCqToLu53AM8cTTHJ1j0pUgE7MI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_17,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406140149
X-Mailman-Approved-At: Sat, 15 Jun 2024 06:24:46 +0200
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


On 6/14/24 07:09, Ilias Apalodimas wrote:
> The PC client spec [0], doesn't describe measurements for DTBs. It does
> describe what do to for ACPI tables though.
>
> There is a description for ACPI in 3.3.4.1 PCR[0] – SRTM, POST BIOS,
> and Embedded Drivers and they explicitly mention ACPI in there. There's
> no mention of ACPI in 3.3.4.2 PCR[1] – Host Platform Configuration.
>
> However, in Figure 6 --  PCR Mapping of UEFI Components ACPI is shown
> in PCR1. The general description also mentions PCR0 is for code and PCR1
> is for data such as ACPI and SMBIOS.


Thanks, looks correct.

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> So let's switch over the DTB measurements to PCR1 which seems a better
> fit.
>
> [0] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification
>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   boot/bootm.c              | 2 +-
>   lib/efi_loader/efi_tcg2.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 6fa8edab021e..3de87eb185d7 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -963,7 +963,7 @@ int bootm_measure(struct bootm_headers *images)
>   			goto unmap_initrd;
>
>   		if (IS_ENABLED(CONFIG_MEASURE_DEVICETREE)) {
> -			ret = tcg2_measure_data(dev, &elog, 0, images->ft_len,
> +			ret = tcg2_measure_data(dev, &elog, 1, images->ft_len,
>   						(u8 *)images->ft_addr,
>   						EV_TABLE_OF_DEVICES,
>   						strlen("dts") + 1,
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 51264c1b998c..a8a54c9f131d 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1328,7 +1328,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
>   	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
>   	sha256_finish(&hash_ctx, blob->data + blob->blob_description_size);
>
> -	ret = measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blob);
> +	ret = measure_event(dev, 1, EV_POST_CODE, event_size, (u8 *)blob);
>
>   	free(blob);
>   	return ret;
> --
> 2.45.1
>
