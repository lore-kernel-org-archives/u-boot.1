Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A14C001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74FA786940;
	Tue, 15 Aug 2023 23:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="myFl5Zxs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="x6/LsY+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A628699C; Tue, 15 Aug 2023 23:01:49 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016E18697E
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RQNx56XbLz9sqs;
 Tue, 15 Aug 2023 23:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4/qpZ1ro+3WJ86El0j6h+HwEITDDKG3lh2Ojg4EfoE=;
 b=myFl5Zxs+6sQZWgJOU3Uk6g//pwjYE1RJem0zGf2WRicOWHySd2RjKnpxNg6JY3bKwAboe
 YYthbwU5rcI0fyTZb4Cu81FbCHFkRVsVWNuB8WvTWdotWu86kwhifNamiM8dTo+kJEpbff
 4xMmUKgVrmH7d9aTjW6EK/5woIScRAP8W4H5/8FxgsV0r3eP1x3iCP4uxasEtY19UnCQrm
 s8JNgPG0BrblPe3AjZZ2meINCDCaxeTwViY1biOgknPcl8MkhEKQCcxDx+JHM02+6TRiwL
 3F0sPRmCajvncuVqwTkxgUlB4IfzLGssKy1ZFFHlsqLRQ249Cfr1kMZPu1ic8A==
Message-ID: <2f97ee68-65e4-fcf2-773e-411936c8227d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4/qpZ1ro+3WJ86El0j6h+HwEITDDKG3lh2Ojg4EfoE=;
 b=x6/LsY+Br8EYzRltBB4N2Iijrj126NVqAzmQlTP9c5EGkgljDA64Ux+JAO751JnVVIb6E1
 ZPxGFm243V1g1pRa1Y46ZgvOc6XsllEiEZZrx84XUh/eThqPQ22h+tu1XibNY+yvG3fDO8
 HQ8eTZhxDGC4gUZeOz3hxG2PE0/dTeNCBw/LbH0wMOykdd5LoJXC4Ajaa3uXdd5ldFEF5J
 JVJCtRLKnMn3yRiwL5N4pzuYpYizwXNgghu/1QSKKSQs4r4sgMroRO/IOJcyp5Hm+/rq22
 TWyyEKP3uBv6B3fbb9+nLhPRomovckgjWgBqjkrpBtEmlrhBRmKNKBviNvr5cA==
Date: Tue, 15 Aug 2023 22:54:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] ufs: Handle UFS 3.0 controllers
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Faiz Abbas <faiz_abbas@ti.com>
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-3-marek.vasut+renesas@mailbox.org>
 <CAH=2NtyeiRyN1pwJ8ukXXbMiD6Yv2bUgYdoVkd4D4mM2f3Dw_g@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH=2NtyeiRyN1pwJ8ukXXbMiD6Yv2bUgYdoVkd4D4mM2f3Dw_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 94834aad28e3cf1c77c
X-MBO-RS-META: qcmetydn49fqz5a776mgiz9o9uyfn99d
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

On 8/15/23 19:14, Bhupesh Sharma wrote:
> On Mon, 14 Aug 2023 at 05:23, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Extend the version check to handle UFS 3.0 controllers as well.
>> Tested on R-Car S4 UFS 3.0 controller.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   drivers/ufs/ufs.c | 3 ++-
>>   drivers/ufs/ufs.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 261ae2843c2..58830c8ddca 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>>          if (hba->version != UFSHCI_VERSION_10 &&
>>              hba->version != UFSHCI_VERSION_11 &&
>>              hba->version != UFSHCI_VERSION_20 &&
>> -           hba->version != UFSHCI_VERSION_21)
>> +           hba->version != UFSHCI_VERSION_21 &&
>> +           hba->version != UFSHCI_VERSION_30)
>>                  dev_err(hba->dev, "invalid UFS version 0x%x\n",
>>                          hba->version);
>>
>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>> index 33ca5f29812..ef7728fc39e 100644
>> --- a/drivers/ufs/ufs.h
>> +++ b/drivers/ufs/ufs.h
>> @@ -781,6 +781,7 @@ enum {
>>          UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
>>          UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>>          UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
>> +       UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
>>   };
>>
>>   /* Interrupt disable masks */
>> --
>> 2.40.1
> 
> SInce the Qualcomm UFS HC controllers are even newer / greater version
> values, we can drop this patch in favour of my UFS patch here:
> https://lists.denx.de/pipermail/u-boot/2023-August/527215.html

Why not keep validating the version ?
