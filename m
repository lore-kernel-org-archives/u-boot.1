Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D09AC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 03:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541E08798C;
	Tue, 23 Jan 2024 04:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="GpJIb1gZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B724D8798C; Tue, 23 Jan 2024 04:07:14 +0100 (CET)
Received: from mail-m49215.qiye.163.com (mail-m49215.qiye.163.com
 [45.254.49.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F278793F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 04:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=GpJIb1gZz0xE90eyYL6KXNpzQrDJpZPWLJQvelP0jnTTEapuCINO5dc1A9A1Ccea0Qys2medrWHDEzivb4upn8BthevVkYezZr1Pde+DGCxTJKo8E69Ez6i/d8ORh2R6kL7om5kXFQjyeBwJZfNQbR6mKMapYqE+ynNPKJWqAeU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=6xLCCmPc+sbY1i3pTiKWE4dr825e+bKprnznPsJSDhY=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11874.qiye.163.com (Hmail) with ESMTPA id B6F0B3C0195;
 Tue, 23 Jan 2024 11:07:03 +0800 (CST)
Message-ID: <f062df17-972c-46e8-ae7d-e8e58de733a5@rock-chips.com>
Date: Tue, 23 Jan 2024 11:07:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: sdram: fix LPDDR5 bank info for sys_reg version
 3
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, YouMin Chen <cym@rock-chips.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240122074633.654726-1-kever.yang@rock-chips.com>
 <3739f50b-faa7-42ab-856e-44eee3709957@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <3739f50b-faa7-42ab-856e-44eee3709957@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhISFZKSR5PSU1OQ05DT0xVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d34491f7f2eb0kusnb6f0b3c0195
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDY6Ajo4IzwfFA1JAR04PDcX
 HQNPCw9VSlVKTEtOQkxCSUlPT01CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPQklNNwY+
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

Hi Jonas,

On 2024/1/23 01:55, Jonas Karlman wrote:
> Hi,
>
> On 2024-01-22 08:46, Kever Yang wrote:
>> From: YouMin Chen <cym@rock-chips.com>
>>
>> This patch add support for additional bank info used by LPDDR5.
>>
>> Signed-off-by: YouMin Chen <cym@rock-chips.com>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>>   arch/arm/mach-rockchip/sdram.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
>> index 99ecbdc3412..d65c48bf515 100644
>> --- a/arch/arm/mach-rockchip/sdram.c
>> +++ b/arch/arm/mach-rockchip/sdram.c
>> @@ -110,6 +110,13 @@ size_t rockchip_sdram_size(phys_addr_t reg)
>>   			  SYS_REG_COL_MASK);
>>   		cs1_col = cs0_col;
>>   		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
>> +		/*
>> +		 * SYS_REG_BK(Version 3):
>> +		 * 1) Except LPDDR5 0:8bank(bk=3), 1:4bank(bk=2)
>> +		 * 2) LPDDR5 0:8bank(bk=3), 1:16bank(bk=4)
>> +		 */
>> +		if (version == 3 && dram_type == LPDDR5 && bk == 2)
>> +			bk = 4;
> The version == 3 test is not really needed because dram_type cannot be
> assigned to LPDDR5 (9) since the dram_type high bits is only read for
> version >= 3.
>
> Also not sure I fully like the if bk==2 then bk=4 override code style
> here because the code comment do not fully match the code flow. I had to
> stop and think twice on why the test was for bk==2 when it is bk bit = 1
> that should result in bk=4.
>
> Maybe we can make the code closer match the comment with something like
> the following:
>
>
> @@ -109,7 +109,14 @@ size_t rockchip_sdram_size(phys_addr_t reg)
>   		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
>   			  SYS_REG_COL_MASK);
>   		cs1_col = cs0_col;
> -		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
> +		if (dram_type == LPDDR5)
> +			/* LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4) */
> +			bk = 3 + ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
> +				  SYS_REG_BK_MASK);
> +		else
> +			/* Other: 0:8bank(bk=3), 1:4bank(bk=2) */
> +			bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
> +				  SYS_REG_BK_MASK);

This is better to understand, LPDDR5 has different bank definition with 
other type dram.

Thanks,

- Kever

>   		if (version >= 2) {
>   			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
>   				  SYS_REG_CS1_COL_MASK);
>
>
> or possible use of a conditional operator:
>
>
> @@ -109,7 +109,13 @@ size_t rockchip_sdram_size(phys_addr_t reg)
>   		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
>   			  SYS_REG_COL_MASK);
>   		cs1_col = cs0_col;
> -		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
> +		/*
> +		 * SYS_REG_BK:
> +		 * LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4)
> +		 * Other: 0:8bank(bk=3), 1:4bank(bk=2)
> +		 */
> +		bk = (sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK;
> +		bk = (dram_type == LPDDR5) ? 3 + bk : 3 - bk;
>   		if (version >= 2) {
>   			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
>   				  SYS_REG_CS1_COL_MASK);
>
>
> Not sure any of the above suggestions makes the code any easier to
> understand.
>
> Regards,
> Jonas
>
>>   		if (version >= 2) {
>>   			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
>>   				  SYS_REG_CS1_COL_MASK);
