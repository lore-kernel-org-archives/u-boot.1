Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15DCC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 06:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62C428091A;
	Thu,  5 Jun 2025 08:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LusTm5vR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D469081E25; Thu,  5 Jun 2025 08:23:39 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE1D8003E
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 08:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5556NYpD4005980;
 Thu, 5 Jun 2025 01:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749104614;
 bh=VM7DtMG2eOoBrSWB4Q0NgM8dYqjWfbNxQTPwqnAwQo0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LusTm5vRIpBV2kLP+wvVziooPlYVBCUzXqePUuXdg0Qo2wIRFmpe/O3ELaWl9y3FA
 5aUsBPrwqo6tO03tnqh9Uftcxja6dQKAlYpMH/I4L3FqouGRiuMBLCygVMPWNplnNQ
 /uYB5cQPF0lPF7l6FRA9rvaBGsLlJRQh/yqS3nb8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5556NYu42568880
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 5 Jun 2025 01:23:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Jun 2025 01:23:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Jun 2025 01:23:34 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5556NVuM3254301;
 Thu, 5 Jun 2025 01:23:31 -0500
Message-ID: <eddac537-c723-4a29-9ac9-fb2b804fd024@ti.com>
Date: Thu, 5 Jun 2025 11:53:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ti_sci_* : Add capability to access DM firmware's
 metadata
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-3-m-shah@ti.com>
 <d64404e9-bb12-4c85-b547-13631b5c21b8@ti.com>
 <f7a6cdaa-c224-40d3-9f2d-d658690b5298@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <f7a6cdaa-c224-40d3-9f2d-d658690b5298@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 05/06/25 11:43, Moteen Shah wrote:
> Hey Neha,
> 
> On 03/06/25 11:43, Neha Malcom Francis wrote:
>> On 28/05/25 13:35, Moteen Shah wrote:
>>> Introduce response and request structs to receive and request
>>> information regarding DM version, etc from TI SCI.
>>>
>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>> ---
>>>   drivers/firmware/ti_sci.h              | 29 ++++++++++++++++++++++++++
>>>   include/linux/soc/ti/ti_sci_protocol.h | 26 +++++++++++++++++++++++
>>>   2 files changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
>>> index f3d9eb453b4..6ef77d83114 100644
>>> --- a/drivers/firmware/ti_sci.h
>>> +++ b/drivers/firmware/ti_sci.h
>>> @@ -19,6 +19,7 @@
>>>   #define TI_SCI_MSG_ENABLE_WDT        0x0000
>>>   #define TI_SCI_MSG_WAKE_RESET        0x0001
>>>   #define TI_SCI_MSG_VERSION        0x0002
>>> +#define TI_SCI_MSG_DM_VERSION        0x000F
>>>   #define TI_SCI_MSG_WAKE_REASON        0x0003
>>>   #define TI_SCI_MSG_GOODBYE        0x0004
>>>   #define TI_SCI_MSG_SYS_RESET        0x0005
>>> @@ -135,6 +136,34 @@ struct ti_sci_msg_resp_version {
>>>       u8 abi_minor;
>>>   } __packed;
>>>   +/**
>>> + * struct ti_sci_msg_dm_resp_version - Response for a message
>>> + * @hdr:        Generic header
>>> + * @version:        Version number of the firmware
>>> + * @sub_version:    Sub-version number of the firmware
>>> + * @patch_version:    Patch version number of the firmware
>>> + * @abi_major:        Major version of the ABI that firmware supports
>>> + * @abi_minor:        Minor version of the ABI that firmware supports
>>> + * @sci_server_version:    String describing the SCI server version
>>> + * @rm_pm_hal_version:    String describing the RM PM HAL version
>>> + *
>>> + * In general, ABI version changes follow the rule that minor
>>> version increments
>>> + * are backward compatible. Major revision changes in ABI may not be
>>> + * backward compatible.
>>> + *
>>> + * Response to a message with message type TI_SCI_MSG_DM_VERSION
>>> + */
>>> +struct ti_sci_msg_dm_resp_version {
>>> +    struct ti_sci_msg_hdr hdr;
>>> +    u16    version;
>>> +    u8    sub_version;
>>> +    u8    patch_version;
>>> +    u8    abi_major;
>>> +    u8    abi_minor;
>>> +    char rm_pm_hal_version[12];
>>> +    char sci_server_version[26];
>>> +} __packed;
>>> +
>>>   /**
>>>    * struct ti_sci_query_fw_caps_resp - Response for a message
>>>    * @hdr:    Generic header
>>> diff --git a/include/linux/soc/ti/ti_sci_protocol.h
>>> b/include/linux/soc/ti/ti_sci_protocol.h
>>> index 05a19a8d86c..3f13a980433 100644
>>> --- a/include/linux/soc/ti/ti_sci_protocol.h
>>> +++ b/include/linux/soc/ti/ti_sci_protocol.h
>>> @@ -30,6 +30,28 @@ struct ti_sci_version_info {
>>>       char firmware_description[32];
>>>   };
>>>   +/**
>>> + * struct ti_sci_dm_version_info - version information structure
>>> + * @abi_major:        Major ABI version. Change here implies risk of
>>> backward
>>> + *            compatibility break.
>>> + * @abi_minor:        Minor ABI version. Change here implies new
>>> feature addition,
>>> + *            or compatible change in ABI.
>>> + * @patch_ver:        Patch version of the firmware.
>>> + * @sub_ver:        Sub-version of the firmware.
>>> + * @dm_ver:        DM version.
>>> + * @sci_server_version:    Version string of the SCI server.
>>> + * @rm_pm_hal_version:    Version string of the RM PM HAL.
>>> + */
>>> +struct ti_sci_dm_version_info {
>>> +    u8 abi_major;
>>> +    u8 abi_minor;
>>> +    u8 patch_ver;
>>> +    u8 sub_ver;
>>> +    u16 dm_ver;
>>> +    char rm_pm_hal_version[12];
>>> +    char sci_server_version[26];
>>> +};
>>> +
>>>   struct ti_sci_handle;
>>>     /**
>>> @@ -264,10 +286,14 @@ struct ti_sci_core_ops {
>>>   /**
>>>    * struct ti_sci_firmware_ops - DM firmware operations
>>>    * @query_dm_cap: Query the DM capabilities
>>> + * @get_dm_version: Get the DM version.
>>> + *            Return 0 for successful query else appropriate error
>>> value.
>> nitpick: Alignment?
> 
> The checkpatch didn't raise an alarm, I'll recheck once and fix it if
> required in the revision.

I don't think checkpatch looks for alignment in comments, just a nitpick
as it looks way more intended to the right.

> 
> Regards,
> Moteen
> 
>>
>>>    */
>>>   struct ti_sci_firmware_ops {
>>>       int (*query_dm_cap)(struct ti_sci_handle *handle,
>>>                   u64 *dm_cap);
>>> +    int (*get_dm_version)(struct ti_sci_handle *handle,
>>> +                  struct ti_sci_dm_version_info *get_dm_version);
>>>   };
>>>     #define TI_SCI_MSG_FLAG_FW_CAP_DM    0x100
>> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
>>

-- 
Thanking You
Neha Malcom Francis
