Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C23C41513
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F361D86EDD;
	Mon, 16 Oct 2023 16:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697467506;
	bh=d3AhVgRWTsvjgmsW6VRivCNbl9kXED4tTdMEovKNyZE=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q0lRv7G6CjEBAqroobcZ7FZqsIue5oO3H8tyHH24MFiKhucjZI02NoErJm8HAcvZu
	 LEdXBb+SVbFcf8M7OMmB96UzzFdva4h72ta133vh6Tglhtk5WNn7Bd4jeTLLeF0lmH
	 +a2ekMQLe7XZDdGawB/blw6hqjkq1OD1lsy5lyhaSen7nuYnu0+s7GRuzi3XW0O131
	 dDcujPblkE7LuaNFkS4XeonIhUchCGAohmW1zllHb0ZHKeAedhX8DJrlVCB7lrTgNM
	 UN83IKNRybHCWr2RN2QovH5Ex2U/A+Sjwv1agn4NjlMvx/3WY6zkOrq8tAkFXE6KGA
	 VK0PGfiYLXPTQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0962C86EF3; Mon, 16 Oct 2023 16:45:05 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FFCB863FD
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8Kdn31xYz9sV6;
 Mon, 16 Oct 2023 16:45:01 +0200 (CEST)
Message-ID: <a2961598-6405-4b00-82a5-11d94e744fdd@denx.de>
Date: Mon, 16 Oct 2023 16:45:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] arm: mvebu: clearfog: support 512MB memory size from
 tlv eeprom
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
References: <20231008145804.25567-1-josua@solid-run.com>
 <20231008145804.25567-3-josua@solid-run.com>
 <24e09940-1cad-44c3-aaa1-89b9a4286357@denx.de>
In-Reply-To: <24e09940-1cad-44c3-aaa1-89b9a4286357@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S8Kdn31xYz9sV6
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

On 10/16/23 11:01, Stefan Roese wrote:
> On 10/8/23 16:58, Josua Mayer wrote:
>> Handle 2GBit memory size value "2" from tlv eeprom on ddr
>> initialisation, to support SoMs with 512MB ddr memory.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>>   board/solidrun/clearfog/clearfog.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/board/solidrun/clearfog/clearfog.c 
>> b/board/solidrun/clearfog/clearfog.c
>> index 4f4532b537e..6fa2fe5fe3e 100644
>> --- a/board/solidrun/clearfog/clearfog.c
>> +++ b/board/solidrun/clearfog/clearfog.c
>> @@ -159,6 +159,9 @@ struct mv_ddr_topology_map 
>> *mv_ddr_topology_map_get(void)
>>       cf_read_tlv_data();
>>       switch (cf_tlv_data.ram_size) {
>> +    case 2:
>> +        ifp->memory_size = MV_DDR_DIE_CAP_2GBIT;
>> +        break;
>>       case 4:
>>       default:
>>           ifp->memory_size = MV_DDR_DIE_CAP_4GBIT;
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
