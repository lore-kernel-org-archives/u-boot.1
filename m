Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99870CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0CD83F2B;
	Fri, 10 Oct 2025 18:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IqmQroNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C7183F4B; Fri, 10 Oct 2025 18:57:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B73783F17
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-mcarthur@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59AGvEhp809888;
 Fri, 10 Oct 2025 11:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760115434;
 bh=Zt6bnkQg2AqZBmwMNgNnfjjZPo+Xuq5VvMIuHsSb9Ks=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=IqmQroNqIptlNsoOtntjT9VQO5WTJsTZCzvqQFwQxoQR3eyioQqIzNqvozfPg8qhV
 jQj+Ruwnrze5mYE1eAZVsVaCM1WOiexDKjDmdipYIE2oIZOVnOIO6ZAs4POKxxhhDN
 2XKByOYDJ1KCP18m1jFrJ9ORqU0fTF9q/5Hh0Zjc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59AGvEW11815164
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 10 Oct 2025 11:57:14 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 11:57:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 11:57:13 -0500
Received: from [128.247.81.24] (uda0499903.dhcp.ti.com [128.247.81.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59AGvDoZ1946323;
 Fri, 10 Oct 2025 11:57:13 -0500
Message-ID: <6f908eb6-06b5-46ca-8dfd-a7d0961b7577@ti.com>
Date: Fri, 10 Oct 2025 11:57:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ufs: Add bRefClkFreq attribute setting
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250827185056.954640-1-j-mcarthur@ti.com>
 <20250827185056.954640-3-j-mcarthur@ti.com>
 <61aa6b3f-9ee8-41a8-a5f2-79c19fbfaea8@ti.com>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <61aa6b3f-9ee8-41a8-a5f2-79c19fbfaea8@ti.com>
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

On 10/9/25 10:57, Kumar, Udit wrote:
> 
> On 8/28/2025 12:20 AM, Jared McArthur wrote:
>> A UFS device needs its bRefClkFreq attribute set to the correct value
>> before switching to high speed. If bRefClkFreq is set to the wrong
>> value, all transactions after the power mode change will fail.
>>
>> The bRefClkFreq depends on the host controller and the device.
>> Query the device's current bRefClkFreq and compare with the ref_clk
>> specified in the device-tree. If the two differ, set the bRefClkFreq
>> to the device-tree's ref_clk frequency.
>>
>> Taken from Linux kernel v6.17 (drivers/ufs/core/ufshcd.c and
>> include/ufs/ufs.h) and ported to U-Boot.
> 
>> This patch depends on the previous patch: "ufs: Add support for
>> sending UFS attribute requests"
> 
> Since this is same series, you can drop above from commit message
> 

Will do.

> 
>> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
>> ---
>>   drivers/ufs/ufs.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ufs/ufs.h | 10 ++++++
>>   2 files changed, 99 insertions(+)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 9e67dd86232..4bffbf87749 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -10,6 +10,7 @@
>>     #include <bouncebuf.h>
>>   #include <charset.h>
>> +#include <clk.h>
>>   #include <dm.h>
>>   #include <log.h>
>>   #include <dm/device_compat.h>
>> @@ -1773,6 +1774,92 @@ out:
>>       return err;
>>   }
>>   +struct ufs_ref_clk {
>> +    unsigned long freq_hz;
>> +    enum ufs_ref_clk_freq val;
>> +};
>> +
>> +static const struct ufs_ref_clk ufs_ref_clk_freqs[] = {
>> +    {19200000, REF_CLK_FREQ_19_2_MHZ},
>> +    {26000000, REF_CLK_FREQ_26_MHZ},
>> +    {38400000, REF_CLK_FREQ_38_4_MHZ},
>> +    {52000000, REF_CLK_FREQ_52_MHZ},
>> +    {0, REF_CLK_FREQ_INVAL},
>> +};
>> +
>> +static enum ufs_ref_clk_freq
>> +ufs_get_bref_clk_from_hz(unsigned long freq)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; ufs_ref_clk_freqs[i].freq_hz; i++)
>> +        if (ufs_ref_clk_freqs[i].freq_hz == freq)
>> +            return ufs_ref_clk_freqs[i].val;
>> +
>> +    return REF_CLK_FREQ_INVAL;
>> +}
>> +
>> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk)
>> +{
>> +    unsigned long freq;
>> +
>> +    freq = clk_get_rate(refclk);
>> +
>> +    hba->dev_ref_clk_freq =
>> +        ufs_get_bref_clk_from_hz(freq);
> 
> I understand this is backport but  I don't see real use of dev_ref_clk_freq variable ,
> 
> I suggest to drop dev_ref_clk_freq varaible and return freq index from this function instead of void.
> 

Noted.

> 
>> +
>> +    if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
>> +        dev_err(hba->dev,
>> +            "invalid ref_clk setting = %ld\n", freq);
>> +}
>> +
>> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>> +{
>> +    int err;
>> +    struct clk *ref_clk;
>> +    u32 host_ref_clk_freq;
>> +    u32 dev_ref_clk_freq;
>> +
>> +    /* get ref_clk */
>> +    ref_clk = devm_clk_get(hba->dev, "ref_clk");
>> +    if (IS_ERR((const void *)ref_clk)) {
>> +        err = PTR_ERR(ref_clk);
>> +        goto out;
>> +    }
>> +
>> +    ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
>> +    host_ref_clk_freq = hba->dev_ref_clk_freq;
> 
> host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
> 
> and check for error code here
> 
> If you agree with above change, then please use
> 
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>  in next version
> 
> 

I think the two edits (one change) are reasonable.

>> +
>> +    if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>> +        goto out;
>> +
>> +    err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>> +                      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &dev_ref_clk_freq);
>> +
>> +    if (err) {
>> +        dev_err(hba->dev, "failed reading bRefClkFreq. err = %d\n", err);
>> +        goto out;
>> +    }
>> +
>> +    if (dev_ref_clk_freq == host_ref_clk_freq)
>> +        goto out; /* nothing to update */
>> +
>> +    err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
>> +                      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &host_ref_clk_freq);
>> +
>> +    if (err) {
>> +        dev_err(hba->dev, "bRefClkFreq setting to %lu Hz failed\n",
>> +            ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
>> +        goto out;
>> +    }
>> +
>> +    dev_dbg(hba->dev, "bRefClkFreq setting to %lu Hz succeeded\n",
>> +        ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
>> +
>> +out:
>> +    return err;
>> +}
>> +
>>   /**
>>    * ufshcd_get_max_pwr_mode - reads the max power mode negotiated with device
>>    */
>> @@ -2000,6 +2087,8 @@ static int ufs_start(struct ufs_hba *hba)
>>           return ret;
>>       }
>>   +    ufshcd_set_dev_ref_clk(hba);
>> +
>>       if (ufshcd_get_max_pwr_mode(hba)) {
>>           dev_err(hba->dev,
>>               "%s: Failed getting max supported power mode\n",
>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>> index 53137fae3a8..def39d4ad24 100644
>> --- a/drivers/ufs/ufs.h
>> +++ b/drivers/ufs/ufs.h
>> @@ -172,6 +172,15 @@ enum query_opcode {
>>       UPIU_QUERY_OPCODE_TOGGLE_FLAG    = 0x8,
>>   };
>>   +/* bRefClkFreq attribute values */
>> +enum ufs_ref_clk_freq {
>> +    REF_CLK_FREQ_19_2_MHZ    = 0,
>> +    REF_CLK_FREQ_26_MHZ    = 1,
>> +    REF_CLK_FREQ_38_4_MHZ    = 2,
>> +    REF_CLK_FREQ_52_MHZ    = 3,
>> +    REF_CLK_FREQ_INVAL    = -1,
>> +};
>> +
>>   /* Query response result code */
>>   enum {
>>       QUERY_RESULT_SUCCESS                    = 0x00,
>> @@ -684,6 +693,7 @@ struct ufs_hba {
>>       u32            capabilities;
>>       u32            version;
>>       u32            intr_mask;
>> +    enum ufs_ref_clk_freq dev_ref_clk_freq;
> 
>>       enum ufshcd_quirks    quirks;
>>         /* Virtual memory reference */

-- 
Best,
Jared McArthur

