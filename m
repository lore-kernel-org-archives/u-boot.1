Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD428D32D8B
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B2C88F4D;
	Tue, 12 Nov 2024 11:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KAHSBdnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CF689032; Tue, 12 Nov 2024 11:53:53 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A7F88A3C
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8oV6f014563;
 Tue, 12 Nov 2024 11:53:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PVWN/5+v0yktad1zTdFAHdAvCdA328HXC2YEmXgqfrI=; b=KAHSBdnB0UpaxBhT
 WC7sudaSAFZRf38k0IKwhtk8uORZgci9ApTUOD/MUxkoJecWVMvjX5ARFlM9i4+w
 XROyvMThgnG1Rn3QjOqGvL7LhuLujqiZBeBvNEDjW3Kvs1q1qizM1ymiUmpbJvml
 h4MfznonecC/SiBgl67nX+6S8D5KKX2nZxDijd/zhT96k2yBjnM63Eip2TQm26Uc
 /wG2/sqQy8XleKgFjaUI4LrjZtB8i0c0SiFzlar//ZIjvYZNzGi85FvcOf20Lkhm
 W8TcT50doTJ4a0K0fSXFkTHyNQ76iA4M8jJx6067JufkGpd1R+h2omJGv/fZ+LN4
 iu0o3Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tj641bgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 11:53:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0251440047;
 Tue, 12 Nov 2024 11:52:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B5CB29A4A1;
 Tue, 12 Nov 2024 11:51:14 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 11:51:13 +0100
Message-ID: <84d36071-5086-42c4-8193-5f4ea0b22eab@foss.st.com>
Date: Tue, 12 Nov 2024 11:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Raymond Mao
 <raymond.mao@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi,

On 11/3/24 23:42, Heinrich Schuchardt wrote:
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>
> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	no change
> ---
>   lib/uuid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d044..19f33dd1477 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -35,6 +35,7 @@
>   #ifdef USE_HOSTCC
>   /* polyfill hextoul to avoid pulling in strto.c */
>   #define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#define hextoull(cp, endp) strtoull(cp, endp, 16)
>   #endif
>
>   int uuid_str_valid(const char *uuid)
> @@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>   	tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>   	memcpy(uuid_bin + 8, &tmp16, 2);
>   
> -	tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
> +	tmp64 = cpu_to_le64(hextoull(uuid_str + 24, NULL));
>   	memcpy(uuid_bin + 10, &tmp64, 6);
>   
>   	return 0;


Tested-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>


Thanks.
Patrick


With the series the regression is solved on STM32MP15 board.


tested  on STM32MP15C-DK2 / 2025.01-rc2


the GPT partitions create with GPT common, create with stm32prog 
command,  are

limited a first bytes, after the patch we have the correct UUID 
(partition or type):


before the patch:


STM32MP>partlistmmc0
PartitionMapformmcdevice0--PartitionType:EFI
PartStartLBAEndLBAName
Attributes
TypeGUID
PartitionGUID
10x000000220x00000221"fsbl1"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-0000c8230908
(8da63339-0007-60c0-c436-0000c8230908)
guid:4a75790f-e291-441b-9637-0000165411b2
20x000002220x00000421"fsbl2"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-0000c8230908
(8da63339-0007-60c0-c436-0000c8230908)
guid:7a1e006d-bd4a-42b7-a725-000012451e59
30x000004220x00000621"metadata1"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-0000c8230908
(8da63339-0007-60c0-c436-0000c8230908)
guid:2ead27e5-8fc8-4e00-a0c8-00005d7a437c
40x000006220x00000821"metadata2"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-0000c8230908
(8da63339-0007-60c0-c436-0000c8230908)
guid:2d2536b7-6420-4401-90b0-0000831b3a72
50x000008220x00002821"fip-a"
attrs:0x0000000000000000
type:19d5df83-11b0-457b-be2c-0000c13142a5
(19d5df83-11b0-457b-be2c-0000c13142a5)
guid:4fd84c93-54ef-463f-a7ef-0000ff887087
60x000028220x00004821"fip-b"
attrs:0x0000000000000000
type:19d5df83-11b0-457b-be2c-0000c13142a5
(19d5df83-11b0-457b-be2c-0000c13142a5)
guid:09c54952-d5bf-45af-acee-000003766fb3
70x000048220x00004c21"u-boot-env"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-0000c8230908
(8da63339-0007-60c0-c436-0000c8230908)
guid:514446c6-d705-40d7-aa4b-0000a95a0379
80x00004c220x00024c21"bootfs"
attrs:0x0000000000000004
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:22e8efa0-375c-4be0-99ce-00000172479f
90x00024c220x0002cc21"vendorfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:e1e3f6f9-a4f5-4094-9622-000042c3bcd7
100x0002cc220x0019cc21"rootfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:e91c4e10-16e6-4c0e-bd0e-0000cf4a3582
110x0019cc220x0ee2afdc"userfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:3d14d2bf-7798-4c57-865a-00007ac4cd0c
==================
after the series :
==================
STM32MP>partlistmmc0
PartitionMapformmcdevice0--PartitionType:EFI
PartStartLBAEndLBAName
Attributes
TypeGUID
PartitionGUID
10x000000220x00000221"fsbl1"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-083ac8230908
(8da63339-0007-60c0-c436-083ac8230908)
guid:bcf89b85-baba-4cab-b776-27b7e3eade64
20x000002220x00000421"fsbl2"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-083ac8230908
(8da63339-0007-60c0-c436-083ac8230908)
guid:0b5c4320-aa24-4133-a08b-99f59ec2405b
30x000004220x00000621"metadata1"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-083ac8230908
(8da63339-0007-60c0-c436-083ac8230908)
guid:264a01cf-84d9-4a2e-810f-86cc3617aba0
40x000006220x00000821"metadata2"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-083ac8230908
(8da63339-0007-60c0-c436-083ac8230908)
guid:187a929a-f00e-436f-a635-8ccbf2a532e8
50x000008220x00002821"fip-a"
attrs:0x0000000000000000
type:19d5df83-11b0-457b-be2c-7559c13142a5
(19d5df83-11b0-457b-be2c-7559c13142a5)
guid:4fd84c93-54ef-463f-a7ef-ae25ff887087
60x000028220x00004821"fip-b"
attrs:0x0000000000000000
type:19d5df83-11b0-457b-be2c-7559c13142a5
(19d5df83-11b0-457b-be2c-7559c13142a5)
guid:09c54952-d5bf-45af-acee-335303766fb3
70x000048220x00004c21"u-boot-env"
attrs:0x0000000000000000
type:8da63339-0007-60c0-c436-083ac8230908
(8da63339-0007-60c0-c436-083ac8230908)
guid:2667f0f0-acfc-4f7e-81b8-5da24fc7efbe
80x00004c220x00024c21"bootfs"
attrs:0x0000000000000004
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:9fedf49a-bcc9-46ef-b40c-bbe42e138c23
90x00024c220x0002cc21"vendorfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:d0633872-d1c2-49b6-b81a-2744c4617148
100x0002cc220x0019cc21"rootfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:e91c4e10-16e6-4c0e-bd0e-77becf4a3582
110x0019cc220x0ee2afdc"userfs"
attrs:0x0000000000000000
type:0fc63daf-8483-4772-8e79-3d69d8477de4
(linux)
guid:8e049511-8c1d-4791-bf37-f2365101a073


