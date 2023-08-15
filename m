Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6693C04A94
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCAA6869A0;
	Tue, 15 Aug 2023 23:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PXTUMI8X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T6knZ9I2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C330869A4; Tue, 15 Aug 2023 23:01:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620A386852
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RQNx62Tctz9sWv;
 Tue, 15 Aug 2023 23:01:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chafz/xxVamTINAZWqRtnLuL/iXkF+N6g0Xq95Dvmhg=;
 b=PXTUMI8XYYKFRferS55YES+JW+78zdkh2ZoqC/R8X2kmvekQMWaEBmgvUdADSb1VNSMiw1
 ebMIkw2/jtPNWkyHZ5rVe5L4TuWshUaF9nlJ6ZeCb4mMr9FZIiK9cICrcalM7gdemsVJL3
 7Aoz1H25zxeo3rxrv+BsnPnGu8cWHcBsLe46n+i3i9TpvhNQmUOc2pMuv+MXK57e/sqIZ8
 4vUJJupGDTg6aafJMZalMY82mksREyQAXPist1CIJE4s/6wsb7JKzaEb2HcFVTjuHAiFoB
 PJzNWbEAzCe7cO7j3yxDmd4Ibe4hqjr0pMqarPS9gCch61Jp3SNgaV2tBCFlug==
Message-ID: <4ca740dc-de83-0f5e-f9c4-ad2cac6be3dd@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chafz/xxVamTINAZWqRtnLuL/iXkF+N6g0Xq95Dvmhg=;
 b=T6knZ9I2ihUov28EGa+NDFFSaq7axRDuUel6Mml8mF25HjdArWGELen6eOIdXV27lBFxck
 YYD8jwd4iR54GSW66rx797W+9I79MEPLxmur+G1jmGIseU4PZOClADP5Q4HXuEZ5tsDB5W
 +WlTJwrO9Vu0pq/K0RVbwpWlk05dN6LVIne+ALWCFZRMM4me5vOkCyTsfheeI6oUPbyXpY
 4rKeku4rMdKqZnuU35PppwQt+oCGsIfxQ2AVV3eQ1fgt+zxlA1bi+MLQ5afqRNaQNf13Wq
 vGwfrX8FvFIgtT90sZdUlhje3kiEDLz/8VzqTTTvlqJo6YKr46avnQ5QnOVOlg==
Date: Tue, 15 Aug 2023 22:56:10 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 4/6] ufs: Pass hba pointer to ufshcd_prepare_req_desc_hdr()
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-4-marek.vasut+renesas@mailbox.org>
 <d2e3f423-0110-6980-baa9-d3a4ea1391af@linaro.org>
Content-Language: en-US
In-Reply-To: <d2e3f423-0110-6980-baa9-d3a4ea1391af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0d58c08d7c5ab9ea372
X-MBO-RS-META: uowp7swjykfpi6quo4f8ybiem9yecsdf
X-Rspamd-Queue-Id: 4RQNx62Tctz9sWv
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

On 8/15/23 21:57, Bhupesh Sharma wrote:
> On 8/14/23 5:22 AM, Marek Vasut wrote:
>> Pass the hba pointer itself to ufshcd_prepare_req_desc_hdr()
>> instead of duplicating utp_transfer_req_desc access at each
>> call site. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   drivers/ufs/ufs.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 58830c8ddca..da1009e2c14 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -696,10 +696,11 @@ static inline u8 ufshcd_get_upmcrs(struct 
>> ufs_hba *hba)
>>    * ufshcd_prepare_req_desc_hdr() - Fills the requests header
>>    * descriptor according to request
>>    */
>> -static void ufshcd_prepare_req_desc_hdr(struct utp_transfer_req_desc 
>> *req_desc,
>> +static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
>>                       u32 *upiu_flags,
>>                       enum dma_data_direction cmd_dir)
>>   {
>> +    struct utp_transfer_req_desc *req_desc = hba->utrdl;
>>       u32 data_direction;
>>       u32 dword_0;
>> @@ -793,11 +794,10 @@ static int ufshcd_comp_devman_upiu(struct 
>> ufs_hba *hba,
>>   {
>>       u32 upiu_flags;
>>       int ret = 0;
>> -    struct utp_transfer_req_desc *req_desc = hba->utrdl;
>>       hba->dev_cmd.type = cmd_type;
>> -    ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, DMA_NONE);
>> +    ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, DMA_NONE);
>>       switch (cmd_type) {
>>       case DEV_CMD_TYPE_QUERY:
>>           ufshcd_prepare_utp_query_req_upiu(hba, upiu_flags);
>> @@ -1449,12 +1449,11 @@ static void prepare_prdt_table(struct ufs_hba 
>> *hba, struct scsi_cmd *pccb)
>>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd 
>> *pccb)
>>   {
>>       struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>> -    struct utp_transfer_req_desc *req_desc = hba->utrdl;
>>       u32 upiu_flags;
>>       int ocs, result = 0;
>>       u8 scsi_status;
>> -    ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, pccb->dma_dir);
>> +    ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>>       ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>>       prepare_prdt_table(hba, pccb);
> 
> Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Please use Reviewed-by: and Tested-by: tags separately, else patchwork 
won't pick those tags up.
