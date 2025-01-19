Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444FAC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 23:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F98801F5;
	Mon, 20 Jan 2025 00:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IGE3m7pL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF3B80586; Mon, 20 Jan 2025 00:35:46 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2C780085
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 00:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5378=UM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1737329742;
 bh=pvNVjwCLaNyqXn1Byng+IS4XtvFq3fGGSxg/+Alizrk=;
 b=IGE3m7pLJm/OTdCC5XwpRCG8pinp+ShgYlcqW4lIYAEgjC9X4HlclzJkvwoEGLhIanr/K3Erm
 1qI9UP3VTcTdaBod7ziCmnJxOFrDl8SkAPamPoepAk96JboxmY1M3mWLWCABTnC9N3vt/dh4uyK
 80covomUsEyuoctv5675V39sdIET9XkH8KT/+w7/r6BiFU5Rbl5O7jlYp1TH/ExBg2FphfcYZlX
 eBIKd6+kOVSCab6cJ+rHS2wXS1qwmheXfjHFfgmGaa5BJ8B+5VHrZfu5MTX3/xeOTzmONd8ep/d
 VwTvqecsNkyUE8XRAdbD2NVaASfzu1vveP8fdm8dL6bA==
X-Forward-Email-ID: 678d8c4367596a90a5561ed8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <33caeb3b-2945-49ee-8756-8cf8aec1c632@kwiboo.se>
Date: Mon, 20 Jan 2025 00:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ferass El Hafidi <funderscore@postmarketos.org>, u-boot@lists.denx.de
References: <20240127162922.284598-1-jonas@kwiboo.se>
 <CGME20240403000039epcas1p46afc0540b893679113e0683d87227ca8@epcas1p4.samsung.com>
 <d7a2b5ef-ceb5-4f8f-b2d0-fcd6f2d6df1c@samsung.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d7a2b5ef-ceb5-4f8f-b2d0-fcd6f2d6df1c@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 2024-04-03 02:00, Jaehoon Chung wrote:
> Hi,
> 
> On 1/28/24 01:29, Jonas Karlman wrote:
>> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
>> issues together with the peephole2 optimization on Amlogic SoCs.
>> Following was observed while working on SPL support for Amlogic SoCs.
>>
>> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
>> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
>> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
> 
> I read your RFC "https://patchwork.ozlabs.org/patch/1841495/
> 
> First, I will retry to reproduce your case with other compiler. 
> After that, I will inform again about this patch.

Gentle ping, this patch has been on list for almost a year now.

Have you had any time to reproduce this or can this be merged as-is?

For some reason only Amlogic seem to be affected by this issue.

Regards,
Jonas

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Code from the call site:
>>
>>   cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
>>   ...
>>   data.blocksize = 8;
>>   ...
>>   err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>>
>> Running the code with MMC_TRACE enabled shows:
>>
>> CMD_SEND:55
>>                 ARG                      0x50480000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>> CMD_SEND:8
>>                 ARG                      0x00000000
>>                 RET                      -110
>>
>> Removing the alignment hole by changing cmdidx from ushort to uint or
>> building with -fno-peephole2 flag seem to resolve this issue.
>>
>> CMD_SEND:55
>>                 ARG                      0x50480000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>> CMD_SEND:51
>>                 ARG                      0x00000000
>>                 MMC_RSP_R1,5,6,7         0x00000920
>>
>> Same issue was observed building U-Boot with gcc 8 - 13.
>>
>> Remove this alignment hole by changing cmdidx from ushort to uint.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - Drop use of -fno-peephole2 flag
>>
>> Link to RFC: https://patchwork.ozlabs.org/patch/1841495/
>> ---
>>  include/mmc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/mmc.h b/include/mmc.h
>> index 1022db3ffa7c..031ea0fb3545 100644
>> --- a/include/mmc.h
>> +++ b/include/mmc.h
>> @@ -413,7 +413,7 @@ struct mmc_cid {
>>  };
>>  
>>  struct mmc_cmd {
>> -	ushort cmdidx;
>> +	uint cmdidx;
>>  	uint resp_type;
>>  	uint cmdarg;
>>  	uint response[4];
> 

