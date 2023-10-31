Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDF0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 11:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D76987CA5;
	Tue, 31 Oct 2023 12:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698752024;
	bh=D2JG+Zgw5xTM3DnR7haQTAhiHl8zo6LlbTN+XOaqlUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=faMaz7gAtLo4RhyOLzPFecxpZc1JCUoNJp011FrOOG1bUtVJNaRmstSxuI37ZNuyl
	 whuaUewaS5w18ZHpSU8YPki+WFi/gSBtxbIezoSeH254PM+4APQgOfwrMihVqAVWK9
	 O02mBG/wEMDofY7qyEjWMLyWcdtMq4XLOZlUbyD5wvdW1Xs2QSQhiaFh6BFbLc9ESt
	 nEwqmP/MZD1JenB9WdwkS3eMjfrrICKLxXn5r6u30Wmx0vEx9rYIHaOgtGHrYGUCM9
	 D9si6Z3dfK5gNsq4xF3+fYGu60o8p5AJmUfPlYxKWMzPoILj6e/SUfSvCUsMJh9lmr
	 wyznhKoUcBqCQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 02D2987C99;
 Tue, 31 Oct 2023 12:33:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698752023;
 bh=D2JG+Zgw5xTM3DnR7haQTAhiHl8zo6LlbTN+XOaqlUY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qmrCcLBHpvWNnLqtJcwyc+PQ11o+xgASQC5E5FiCHa7klvHJUIEmdMzSWIexDcXOr
 OFN51jyfg4lwwjGxrMCkrDPaHjNsmHnlW2lc4WRoPeaNlqZffjtMJQFBukuY/1/8sN
 dQHTgGzsUq4lOoEoUrXmt8uNxFXN8Q2s9m93vjMEWfZ98eJ0J7H+4BEfxdzvfTVAqW
 QX4wTBVv+68rrs6ih2UfeLK+T+qRC2XE4nfn3zkzXwrHP9+dFXQ2H+02blFFt4KwRV
 uXNhedM0PVPNhyR+vR4Mx6Uw09po8vHu5lfRHx/0alcnSinwWUZWVMq15RJUFM4FMk
 kvilLPAt58EyQ==
Message-ID: <3b12d961-3077-4673-8076-1fc074a4c4d0@denx.de>
Date: Tue, 31 Oct 2023 12:33:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
References: <20231010124728.7930-1-marex@denx.de>
 <20231031092641.0675aee4@karo-electronics.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231031092641.0675aee4@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/31/23 09:26, Lothar Waßmann wrote:
> Hi,
> 
> On Tue, 10 Oct 2023 14:47:28 +0200 Marek Vasut wrote:
>> Add extension to the 'mmc' command to read out the card registers.
>> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
>> supported. A register value can either be displayed or read into
>> an environment variable.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Ramon Fried <rfried.dev@gmail.com>
>> Cc: Roger Knecht <rknecht@pm.me>
>> Cc: Sean Edmond <seanedmond@microsoft.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>> V2: - Update documentation
>> ---
>>   cmd/Kconfig           |  8 ++++
>>   cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
>>   doc/usage/cmd/mmc.rst | 26 ++++++++++++
>>   3 files changed, 130 insertions(+)
>>
> [...]
>> +	if (!strcmp(argv[2], "ocr")) {
>> +		printf("OCR: 0x%08x\n", mmc->ocr);
>> +		if (argv[4])
>> +			env_set_hex(argv[4], mmc->ocr);
>> +		return CMD_RET_SUCCESS;
>> +	}
>> +	if (!strcmp(argv[2], "rca")) {
>> +		printf("RCA: 0x%08x\n", mmc->rca);
>> +		if (argv[4])
>> +			env_set_hex(argv[4], mmc->rca);
>> +		return CMD_RET_SUCCESS;
>> +	}
>> +	if (!strcmp(argv[2], "extcsd") &&
>> +	    mmc->version >= MMC_VERSION_4_41) {
>> +		ret = mmc_send_ext_csd(mmc, ext_csd);
>> +		if (ret)
>> +			return ret;
> 			return CMD_RET_FAILURE;
> 

Fixed in V3, thanks .
