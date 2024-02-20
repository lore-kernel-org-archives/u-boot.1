Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F4BC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D2287D99;
	Tue, 20 Feb 2024 12:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X42GU+fW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p9onTJi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94202879FE; Tue, 20 Feb 2024 12:27:08 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26EE87DAF
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TfHDm2XPCz9sQ6;
 Tue, 20 Feb 2024 12:27:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708428424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4w+nLeir8gfUjJOmfAWxDK73ORHlC6S75oroEDeWe0w=;
 b=X42GU+fWuWs/9UmLJHL80ud+3gPdkCAowjDkwqw9/N9Su9YL/mH4gy+WklwvSIKwmAWHrH
 qiGwVq8HQUJDe1CtV69Ti7I4Pf0kWM3THjcOvAS/567ls+aXoUZlVFRI0idhPlezXyRLsv
 K1q3UB2NOLkrNxeFWFD3sQRByZbxsQdQi59wKS0Er6VWyqfOKoXlQP6HVErzr7vNty9BYj
 S781ilK+44cIbV1xSiR9u1KsBVwAx+WoLrqafyKb8Atb3wYIKqlPf0yBG0FigbfwQk1rRw
 y8XDKxFkrbFz/+noY8ZmgV3+Ab7mDKQR16q/LqcySFTDpUMrbQ0RAW2i463jBQ==
Message-ID: <3d2b1c06-0841-4cb2-93cb-6f1ce245f2c1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708428422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4w+nLeir8gfUjJOmfAWxDK73ORHlC6S75oroEDeWe0w=;
 b=p9onTJi8TCiZlKSLIBLkv0PsOTJnBdS8I1nOX+FCPYzQSSEc3K/iv5XbIRnoMiR7iBF7WN
 D508OUKTWkRuX2FsSgT55nL4CTjYg84/+5gTLFtXVqYB+Jf1awxyU3/uZAhdXGzyhsaiPU
 B/mXqEWiMtCf1YxiklkQnu9pg7/uS4D2FP+PdsdkFGFIZJ0RM/ctCVqZwJkxGnNx8fg8vq
 /a6pOm3L3KQTlNPWtChJMZX2kkUjwJfl68w4yxoB4bhh5hmiAg1H2hMrgLNJ1mXRMpBm1y
 HrFrT9SFufKlCw5mVayw45ijxV2ELeWh03bTIm2pr+HD2mDGGm0zvJ5lt3YQhQ==
Date: Tue, 20 Feb 2024 12:26:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Drop unused mmc_send_tuning() cmd_error parameter
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20240220083642.34389-1-marek.vasut+renesas@mailbox.org>
 <69c9c403-2ac2-45b7-9e11-05db7b490a42@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <69c9c403-2ac2-45b7-9e11-05db7b490a42@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 14a8c1652c6f4248ddb
X-MBO-RS-META: 9wq49fqidta7razzmhq36gphk5qso98p
X-Rspamd-Queue-Id: 4TfHDm2XPCz9sQ6
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

On 2/20/24 11:50, Paul Barker wrote:
> On 20/02/2024 08:36, Marek Vasut wrote:
>> The cmd_error parameter is not used, remove it.
>>   [snip]
>>
>> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
>> index 5a0c61daed5..296aaee7331 100644
>> --- a/drivers/mmc/mtk-sd.c
>> +++ b/drivers/mmc/mtk-sd.c
>> @@ -1131,7 +1131,7 @@ static int hs400_tune_response(struct udevice *dev, u32 opcode)
>>   				i << PAD_CMD_TUNE_RX_DLY3_S);
>>   
>>   		for (j = 0; j < 3; j++) {
>> -			mmc_send_tuning(mmc, opcode, &cmd_err);
>> +			cmd_err = mmc_send_tuning(mmc, opcode);
>>   			if (!cmd_err) {
>>   				cmd_delay |= (1 << i);
>>   			} else {
>> @@ -1181,7 +1181,7 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
>>   				i << MSDC_PAD_TUNE_CMDRDLY_S);
>>   
>>   		for (j = 0; j < 3; j++) {
>> -			mmc_send_tuning(mmc, opcode, &cmd_err);
>> +			cmd_err = mmc_send_tuning(mmc, opcode);
>>   			if (!cmd_err) {
>>   				rise_delay |= (1 << i);
>>   			} else {
>> @@ -1203,7 +1203,7 @@ static int msdc_tune_response(struct udevice *dev, u32 opcode)
>>   				i << MSDC_PAD_TUNE_CMDRDLY_S);
>>   
>>   		for (j = 0; j < 3; j++) {
>> -			mmc_send_tuning(mmc, opcode, &cmd_err);
>> +			cmd_err = mmc_send_tuning(mmc, opcode);
>>   			if (!cmd_err) {
>>   				fall_delay |= (1 << i);
>>   			} else {
>> @@ -1238,7 +1238,7 @@ skip_fall:
>>   		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_CMDRRDLY_M,
>>   				i << MSDC_PAD_TUNE_CMDRRDLY_S);
>>   
>> -		mmc_send_tuning(mmc, opcode, &cmd_err);
>> +		cmd_err = mmc_send_tuning(mmc, opcode);
>>   		if (!cmd_err)
>>   			internal_delay |= (1 << i);
>>   	}
>> @@ -1264,7 +1264,6 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
>>   	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0, };
>>   	u8 final_delay, final_maxlen;
>>   	void __iomem *tune_reg = &host->base->pad_tune;
>> -	int cmd_err;
>>   	int i, ret;
>>   
>>   	if (host->dev_comp->pad_tune0)
>> @@ -1277,10 +1276,10 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
>>   		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
>>   				i << MSDC_PAD_TUNE_DATRRDLY_S);
>>   
>> -		ret = mmc_send_tuning(mmc, opcode, &cmd_err);
>> +		ret = mmc_send_tuning(mmc, opcode);
>>   		if (!ret) {
>>   			rise_delay |= (1 << i);
>> -		} else if (cmd_err) {
>> +		} else {
>>   			/* in this case, retune response is needed */
>>   			ret = msdc_tune_response(dev, opcode);
>>   			if (ret)
>> @@ -1300,10 +1299,10 @@ static int msdc_tune_data(struct udevice *dev, u32 opcode)
>>   		clrsetbits_le32(tune_reg, MSDC_PAD_TUNE_DATRRDLY_M,
>>   				i << MSDC_PAD_TUNE_DATRRDLY_S);
>>   
>> -		ret = mmc_send_tuning(mmc, opcode, &cmd_err);
>> +		ret = mmc_send_tuning(mmc, opcode);
>>   		if (!ret) {
>>   			fall_delay |= (1 << i);
>> -		} else if (cmd_err) {
>> +		} else {
>>   			/* in this case, retune response is needed */
>>   			ret = msdc_tune_response(dev, opcode);
>>   			if (ret)
> 
> This driver (mtk-sd.c) seems to be the only one that really uses the
> `cmd_error` parameter.
> 
> Looking at the implementation of mmc_send_tuning() in Linux, this
> parameter is used so that a caller can differentiate between a command
> error and a data error. I don't know enough details about MMC to
> understand the distinction, but I assume there is some reason for this.
> So I wonder if the mtk-sd driver will still work if those error paths
> are taken for data errors and not just command errors. Has this change
> been tested on some board which uses this driver?

Not by me, so far this driver used uninitialized error value and assumed 
it was initialized as far as I can tell, so it is likely already broken.
