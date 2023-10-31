Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9098DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB84D874F4;
	Tue, 31 Oct 2023 08:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738779;
	bh=5mQnVLPD3qCwhMXUp8NNZFlHwCIrve+SQqc3CFC96Hk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfdAj6nIMgNKqrrksuVkXfmCic1biZ1gdbjez11d62cwYlhFKS3JuI1NFJzKorkDE
	 4m1IPPZPxfajqgjjeE9FLJCXkByLZO8QVorEjmMozMOhya6qNrz8cOjizLopQM4Jrc
	 bI0LUFE/DkAOR0dkW0eUMa2+GJCaFQEm0qTQKB9/Yu+PKQpy+GYktKySMAJeW/7dej
	 BuQ2VV55S1RBC1nUVGn8TsUOy6Fs4zc78mgDxW0zMd9Uga5LbtNw4HiXThrJOgYLEL
	 o9FI196uiPvS0RVQEkKqzNvBtIhDWh/Sb89dNZGZ2aSqSTJUGAYnHFyuWkcqXr1EBY
	 Dr2DTpmHpLF/w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1DBAE870EF;
 Tue, 31 Oct 2023 08:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738777;
 bh=5mQnVLPD3qCwhMXUp8NNZFlHwCIrve+SQqc3CFC96Hk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yHbvi5RZlICEtRRHa2tQwpt2hb7RnAQ3ESy63Ge9/EnQ+wwlsmsAACpYTZS2BA2Fd
 pcOPqzNxGH4/04MdZLGKW9/OsbktxWlGggcKn3mGkv7BZ12EIqH3DjgWrBEJz5GWz9
 TWYBht/vnPax2gbsyKydIAHxapnoNqzb9FMOon6gMHMJq0gM5P/ss73jrVoPqaNsQt
 vFr9MYSeBRfrMppiQ3QA7s6qdjT+jFnjLX40Q2M9IxCYJlve8MT/4XrgDcN4hxdT2o
 kGUqC3RfxkZHZmpGtmZ9ViIAKhiskjJCnUf0bGeYamY9hvim3vPyoJyH0ae4u+F1CA
 CznOVzmnHPWyQ==
Message-ID: <81e81485-763c-49f8-85ca-a698188aae77@denx.de>
Date: Tue, 31 Oct 2023 08:52:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
To: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Cc: 'Abdellatif El Khlifi' <abdellatif.elkhlifi@arm.com>,
 'Heinrich Schuchardt' <xypron.glpk@gmx.de>,
 'Ilias Apalodimas' <ilias.apalodimas@linaro.org>,
 'Ramon Fried' <rfried.dev@gmail.com>, 'Roger Knecht' <rknecht@pm.me>,
 'Sean Edmond' <seanedmond@microsoft.com>, 'Simon Glass' <sjg@chromium.org>,
 'Tobias Waldekranz' <tobias@waldekranz.com>
References: <20231010124728.7930-1-marex@denx.de>
 <CGME20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd@epcas1p4.samsung.com>
 <554256c3-9fed-4795-b408-2036959745e8@samsung.com>
 <004401da0bc3$93f6e350$bbe4a9f0$@samsung.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <004401da0bc3$93f6e350$bbe4a9f0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/31/23 07:29, Jaehoon Chung wrote:
> Hi,
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
>> Sent: Tuesday, October 31, 2023 3:08 PM
>> To: Marek Vasut <marex@denx.de>; u-boot@lists.denx.de
>> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
>> Ilias Apalodimas <ilias.apalodimas@linaro.org>; Ramon Fried <rfried.dev@gmail.com>; Roger Knecht
>> <rknecht@pm.me>; Sean Edmond <seanedmond@microsoft.com>; Simon Glass <sjg@chromium.org>; Tobias
>> Waldekranz <tobias@waldekranz.com>
>> Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card registers
>>
>> Hi Marek,
>>
>> On 10/10/23 21:47, Marek Vasut wrote:
>>> Add extension to the 'mmc' command to read out the card registers.
>>> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
>>> supported. A register value can either be displayed or read into
>>> an environment variable.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>> Cc: Ramon Fried <rfried.dev@gmail.com>
>>> Cc: Roger Knecht <rknecht@pm.me>
>>> Cc: Sean Edmond <seanedmond@microsoft.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tobias Waldekranz <tobias@waldekranz.com>
>>
>> Looks good to me. I have tested with your patch on my target.
>>
>> mmc reg read cid all
>> CID[0]: 0x15010042
>> => mmc reg read extcsd all
>> EXT_CSD:
>> 000:  00 00 00 00 00 00 00 00 00 00
>> 010:  00 00 00 00 00 00 39 00 00 00
>> ..[snip]..
>>
>> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>> ---
>>> V2: - Update documentation
>>> ---
>>>   cmd/Kconfig           |  8 ++++
>>>   cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
>>>   doc/usage/cmd/mmc.rst | 26 ++++++++++++
>>>   3 files changed, 130 insertions(+)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index 6470b138d2f..dcd99757a1e 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -1307,6 +1307,14 @@ config CMD_BKOPS_ENABLE
>>>   	  on a eMMC device. The feature is optionally available on eMMC devices
>>>   	  conforming to standard >= 4.41.
>>>
>>> +config CMD_MMC_REG
>>> +	bool "Enable support for reading card registers in the mmc command"
>>> +	depends on CMD_MMC
>>> +	default n
>>> +	help
>>> +	  Enable the commands for reading card registers. This is useful
>>> +	  mostly for debugging or extracting details from the card.
>>> +
>>>   config CMD_MMC_RPMB
>>>   	bool "Enable support for RPMB in the mmc command"
>>>   	depends on SUPPORT_EMMC_RPMB
>>> diff --git a/cmd/mmc.c b/cmd/mmc.c
>>> index c6bd81cebbc..c29f44b7a18 100644
>>> --- a/cmd/mmc.c
>>> +++ b/cmd/mmc.c
>>> @@ -1110,6 +1110,93 @@ static int do_mmc_boot_wp(struct cmd_tbl *cmdtp, int flag,
>>>   	return CMD_RET_SUCCESS;
>>>   }
>>>
>>> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>>> +static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
>>> +		      int argc, char *const argv[])
>>> +{
>>> +	ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
>>> +	struct mmc *mmc;
>>> +	int i, ret;
>>> +	u32 off;
>>> +
>>> +	if (argc < 3 || argc > 5)
>>> +		return CMD_RET_USAGE;
>>> +
>>> +	mmc = find_mmc_device(curr_device);
>>> +	if (!mmc) {
>>> +		printf("no mmc device at slot %x\n", curr_device);
>>> +		return CMD_RET_FAILURE;
>>> +	}
>>> +
>>> +	if (IS_SD(mmc)) {
>>> +		printf("SD registers are not supported\n");
>>> +		return CMD_RET_FAILURE;
>>> +	}
>>> +
>>> +	off = simple_strtoul(argv[3], NULL, 10);
>>> +	if (!strcmp(argv[2], "cid")) {
>>> +		if (off > 3)
>>> +			return CMD_RET_USAGE;
>>> +		printf("CID[%i]: 0x%08x\n", off, mmc->cid[off]);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], mmc->cid[off]);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +	if (!strcmp(argv[2], "csd")) {
>>> +		if (off > 3)
>>> +			return CMD_RET_USAGE;
>>> +		printf("CSD[%i]: 0x%08x\n", off, mmc->csd[off]);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], mmc->csd[off]);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +	if (!strcmp(argv[2], "dsr")) {
>>> +		printf("DSR: 0x%08x\n", mmc->dsr);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], mmc->dsr);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +	if (!strcmp(argv[2], "ocr")) {
>>> +		printf("OCR: 0x%08x\n", mmc->ocr);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], mmc->ocr);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +	if (!strcmp(argv[2], "rca")) {
>>> +		printf("RCA: 0x%08x\n", mmc->rca);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], mmc->rca);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +	if (!strcmp(argv[2], "extcsd") &&
>>> +	    mmc->version >= MMC_VERSION_4_41) {
>>> +		ret = mmc_send_ext_csd(mmc, ext_csd);
>>> +		if (ret)
>>> +			return ret;
>>> +		if (!strcmp(argv[3], "all")) {
>>> +			/* Dump the entire register */
>>> +			printf("EXT_CSD:");
>>> +			for (i = 0; i < MMC_MAX_BLOCK_LEN; i++) {
>>> +				if (!(i % 10))
>>> +					printf("\n%03i: ", i);
>>> +				printf(" %02x", ext_csd[i]);
>>> +			}
>>> +			printf("\n");
>>> +			return CMD_RET_SUCCESS;
>>> +		}
>>> +		off = simple_strtoul(argv[3], NULL, 10);
>>> +		if (off > 512)
>>> +			return CMD_RET_USAGE;
>>> +		printf("EXT_CSD[%i]: 0x%02x\n", off, ext_csd[off]);
>>> +		if (argv[4])
>>> +			env_set_hex(argv[4], ext_csd[off]);
>>> +		return CMD_RET_SUCCESS;
>>> +	}
>>> +
>>> +	return CMD_RET_FAILURE;
>>> +}
>>> +#endif
>>> +
>>>   static struct cmd_tbl cmd_mmc[] = {
>>>   	U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
>>>   	U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
>>> @@ -1142,6 +1229,9 @@ static struct cmd_tbl cmd_mmc[] = {
>>>   	U_BOOT_CMD_MKENT(bkops-enable, 2, 0, do_mmc_bkops_enable, "", ""),
>>>   	U_BOOT_CMD_MKENT(bkops, 4, 0, do_mmc_bkops, "", ""),
>>>   #endif
>>> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>>> +	U_BOOT_CMD_MKENT(reg, 5, 0, do_mmc_reg, "", ""),
>>> +#endif
>>>   };
>>>
>>>   static int do_mmcops(struct cmd_tbl *cmdtp, int flag, int argc,
>>> @@ -1229,6 +1319,12 @@ U_BOOT_CMD(
>>>   	"   WARNING: This is a write-once setting.\n"
>>>   	"mmc bkops <dev> [auto|manual] [enable|disable]\n"
>>>   	" - configure background operations handshake on device\n"
>>> +#endif
>>> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>>> +	"mmc reg read <reg> <offset> [env] - read card register <reg> offset <offset>\n"
>>> +	"                                    (optionally into [env] variable)\n"
>>> +	" - reg: cid/csd/dsr/ocr/rca/extcsd\n"
>>> +	" - offset: for cid/csd [0..3], for extcsd [0..511,all]\n"
> 
> Is there any reason to add "all" option for cid/csd?

CID/CSD are simple and the "all" loop can be easily implemented on 
command line even without setexpr. With extcsd I often want to get the 
whole dump for debug purposes and it is not so easy for the whole block, 
hence the 'all' .
