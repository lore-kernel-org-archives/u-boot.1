Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32218C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 09:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A985981FEE;
	Mon, 19 May 2025 11:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MfmCDsiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D786081E72; Mon, 19 May 2025 11:24:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7122782A36
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 11:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7234638148=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9Krc2006605;
 Mon, 19 May 2025 11:24:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 yxkEdVoYU65Ose8PMONpbP7pitTr5uu7aXbfPUDtDC4=; b=MfmCDsiAEJcVgsT8
 e9V2AbwKLt/K/aEVAgxO7Xv3+txAMqfyghTPPGLLjVECYXKd9FESX6NDjn1029dl
 dpZh/mkspu0SebuLAprWE4+k4R4VmmLEgMHCliZ4MyLDT1IsL0c3GwR2rBC0coKC
 GqtcqMf8nC6+tvAu63G8tDBXnTNprjxXoxaLq945d/sb7rLsN4nLHZJXYT8nOfhi
 RhaE04wAQ91vgN7D9Z7cmHLKR6xe7jsSEgOtvy9AMKo2wTs6geVsK5YvGpfrgz0y
 J2yc8OBvLXV30nejX+oBTaKPNRZst/YluV1PMy5K5ZapB/7TlxyW7vRunGxkmOdv
 dRS9Lg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46phbge2yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 11:24:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EF86440047;
 Mon, 19 May 2025 11:22:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD005A7C76D;
 Mon, 19 May 2025 11:22:07 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 11:22:07 +0200
Message-ID: <d0fff381-a939-4810-9d46-18ea2b7e0633@foss.st.com>
Date: Mon, 19 May 2025 11:22:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH v3 1/2] lib/uuid.c: use unique name for
 PARTITION_SYSTEM_GUID
To: Jerome Forissier <jerome.forissier@linaro.org>, Tom Rini
 <trini@konsulko.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Adriano Cordova
 <adrianox@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Raymond Mao
 <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
 <20250416074839.1267396-2-jerome.forissier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250416074839.1267396-2-jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
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

Hi Jerome,


Sorry for my late review of your patch,

but I see a side effect exist for this patch

the modified string in list_guid[] is used in uuid_guid_get_bin()

called by uuid_str_to_bin() with CONFIG_PARTITION_TYPE_GUID activated

to support shortname for knwon GUID partition in gpt command with 
type=<UUID>

see doc/README.gpt

I add this behavior in

------------------------------------------------------------------------------------------------------------------------------ 


commit bcb41dcaefacdd4cf0f679b34224cb3d997ee8b4 Author: Patrick Delaunay 
<patrick.delaunay73@gmail.com> Tue Oct 27 11:00:28 2015 Committer: Tom 
Rini <trini@konsulko.com> Thu Nov 12 21:58:58 2015 uuid: add selection 
by string for known partition type GUID short strings can be used in 
type parameter of gpt command to replace the guid string for the types 
known by u-boot partitions = name=boot,size=0x6bc00,type=data; \ 
name=root,size=0x7538ba00,type=linux; gpt write mmc 0 $partitions and 
they are also used to display the type of partition in "part list" 
command Partition Map for MMC device 0 -- Partition Type: EFI Part Start 
LBA End LBA Name Attributes Type GUID Partition GUID 1 0x00000022 
0x0000037f "boot" attrs: 0x0000000000000000 type: 
ebd0a0a2-b9e5-4433-87c0-68b6b72699c7 type: data guid: 
d117f98e-6f2c-d04b-a5b2-331a19f91cb2 2 0x00000380 0x003a9fdc "root" 
attrs: 0x0000000000000000 type: 0fc63daf-8483-4772-8e79-3d69d8477de4 
type: linux guid: 25718777-d0ad-7443-9e60-02cb591c9737 Signed-off-by: 
Patrick Delaunay <patrick.delaunay73@gmail.com>

--------------------------------------------------------------------------------------------------

I found at least 2 usage of this string "system" in master branch.

1- board/samsung/e850-96/e850-96.env:10:

partitions=name=esp,start=512K,size=128M,bootable,type=system; 
partitions+=name=rootfs,size=-,bootable,type=linux

2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151
  
			case PART_ESP:
				/* EFI System Partition */
				type_str = "system"
....
			offset += snprintf(buf + offset,
					   buflen - offset,
					   ",type=%s", type_str);


With your patch the short name for ESP UUID change from "system" to "EFI System Partition"
so we have with space in the part UUID name and the old short name "system" for CONFIG_PARTITION_TYPE_GUID is no more supported

the SPACE in GPT partition could cause issue for gpt command if we try to use this name

cmd/gpt.c:535:

		/* guid */
		val = extract_val(tok, "type");
		if (val) {

and  extract_val() use space as token separator....


we can keep the backward compatibility for the exist shortname "system" with:


#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
	defined(CONFIG_EFI)
+	{"EFI System Partition", PARTITION_SYSTEM_GUID},
	{"system",	PARTITION_SYSTEM_GUID},
#endif

with this simple modification
- first occurrence is used to display information (long name = uuid_guid_get_str)
- second occurence i used for gpt command parameter 'type=system'  with ( uuid_str_to_bin => uuid_guid_get_bin)



But I prefer manage short name for gpt command and long name for description (printf with the '%pUs' format)
firectly in the array  (interdependently of CONFIG_PARTITION_TYPE_GUID)and change the functions uuid_guid_get_bin() / uuid_guid_get_str() to 
use correctly the field .string OR .description

Moreover, as the function are uuid_str_to_bin() / uuid_guid_get_str()
are no more under CONFIG_PARTITION_TYPE_GUID,  since commit 31ce367cd100 ("lib/uuid.c: change prototype of uuid_guid_get_str()")
and commit c1528f324c60 ("lib: compile uuid_guid_get_str if CONFIG_LIB_UUID=y")


I don't see any reason to continue to use this compilation flag for list_guid[]
and the array be be removed by linker if it is not used...
I propose this modification in the serie 
https://patchwork.ozlabs.org/project/uboot/list/?series=457430 with the 
fix in 
https://patchwork.ozlabs.org/project/uboot/patch/20250519110417.1.Ie741b1ca358414a1d718dca0667ac44eefc9227b@changeid/ 
"[1/3] lib/uuid.c: restore support of system partition type for ESP" All 
feedbacks are welcome....

PS: we can also assume to break the backward compatibility for "system" short name and use a better short name as "ESP" for "EFI system partition" if you prefer.


Regards


Patrick

On 4/16/25 09:48, Jerome Forissier wrote:
> The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
> configuration options. It is "system" if CONFIG_PARTITION_TYPE_GUID is
> enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
> enabled. In addition, the unit test in test/common/print.c is incorrect
> because it expects only "system" (or a hex GUID).
>
> Make things more consistent by using a clear and unique name: "EFI
> System Partition" whatever the configuration, and update the unit test
> accordingly.
>
> Signed-off-by: Jerome Forissier<jerome.forissier@linaro.org>
> Suggested-by: Heinrich Schuchardt<xypron.glpk@gmx.de>
> ---
>
> Changes in v3:
> - Use a single entry in list_guid for PARTITION_SYSTEM_GUID
>
> Changes in v2:
> - Remove useless braces in if expression
> - Change partition name and make it the same for all configs. Update the
>    commit subject.
>
>   lib/uuid.c          | 9 ++++-----
>   test/common/print.c | 8 ++++----
>   2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 75658778044..6abbcf27b1f 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -67,8 +67,11 @@ static const struct {
>   	efi_guid_t guid;
>   } list_guid[] = {
>   #ifndef USE_HOSTCC
> +#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
> +	defined(CONFIG_EFI)
> +	{"EFI System Partition", PARTITION_SYSTEM_GUID},
> +#endif
>   #ifdef CONFIG_PARTITION_TYPE_GUID
> -	{"system",	PARTITION_SYSTEM_GUID},
>   	{"mbr",		LEGACY_MBR_PARTITION_GUID},
>   	{"msft",	PARTITION_MSFT_RESERVED_GUID},
>   	{"data",	PARTITION_BASIC_DATA_GUID},
> @@ -182,10 +185,6 @@ static const struct {
>   	{
>   		"TCG2",
>   		EFI_TCG2_PROTOCOL_GUID,
> -		},
> -	{
> -		"System Partition",
> -		PARTITION_SYSTEM_GUID
>   	},
>   	{
>   		"Firmware Management",
> diff --git a/test/common/print.c b/test/common/print.c
> index e3711b10809..c48efc2783f 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
>   	sprintf(str, "%pUL", guid);
>   	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
>   	sprintf(str, "%pUs", guid_esp);
> -	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
> -		ut_asserteq_str("system", str);
> -	} else {
> +	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
> +	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
> +		ut_asserteq_str("EFI System Partition", str);
> +	else
>   		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
> -	}
>   	ret = snprintf(str, 4, "%pUL", guid);
>   	ut_asserteq(0, str[3]);
>   	ut_asserteq(36, ret);
