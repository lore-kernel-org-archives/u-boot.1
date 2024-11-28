Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0A3D65553
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 06:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF3A588E50;
	Thu, 28 Nov 2024 07:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Wd5vpyUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F8688E50; Thu, 28 Nov 2024 07:09:56 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C7388D13
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS69g54704560
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 00:09:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732774182;
 bh=+iovdcXziP8Ul1hSTKfgpBeH3n0muV+KstUebgrwibg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=Wd5vpyUiFLYmcxcYOMV2AFxfKcMg0YpTNfW2W1F9pcYA0+t1n7YlkbV1zvd8MPoAi
 XFJjNtFg+nFuhMFVchJh4vXCudHaBort2d2sECAZAcnN9gStTTsRf4vjZ2eiV1eWmE
 hK7J4J/mlMtX0iK8LwI0gnEoBLH2mxrxYvM39qnY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS69guh013954
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Nov 2024 00:09:42 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 00:09:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 00:09:41 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS69fMN091264;
 Thu, 28 Nov 2024 00:09:41 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <m-chawdhry@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <sjg@chromium.org>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 0/5] EFI Capsule "dfu_alt_info" fixes for TI Boards
In-Reply-To: <ytjx5tv4f2ykgakmjmodfi24r7vg6blfrjaxj4dmk3usa6pnbh@w6rwxbdsxwt5>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <86ed2y69tx.fsf@udb0321960.dhcp.ti.com>
 <ytjx5tv4f2ykgakmjmodfi24r7vg6blfrjaxj4dmk3usa6pnbh@w6rwxbdsxwt5>
Date: Thu, 28 Nov 2024 00:09:41 -0600
Message-ID: <86bjxz6g9m.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Siddharth Vadapalli <s-vadapalli@ti.com> writes:

> On Mon, Nov 25, 2024 at 07:51:54PM -0600, Jon Humphreys wrote:
>
> Hello Jon,
>
> [...]
>
>> 
>> Hi Siddharth, this is an issue that I also discovered while working on a
>> separate issue with Collabora, but haven't posted a patch yet.  The issue
>> is that when DFU booting, spl_dfu_cmd() will setup it's own value for
>> dfu_alt_info before calling run_dfu().  In our existing code, however, this
>> will get overridden by set_dfu_alt_info().  This issue isn't specific to TI
>> boards.
>> 
>> Can you try this patch to drivers/dfu/dfu.c to see if it solves the
>> problems you are seeing:
>> 
>> @@ -153,10 +153,11 @@ int dfu_init_env_entities(char *interface, char
>> *devstr)
>> 
>>   dfu_reinit_needed = false;
>> 
>> + str_env = env_get("dfu_alt_info");
>>  #ifdef CONFIG_SET_DFU_ALT_INFO
>> - set_dfu_alt_info(interface, devstr);
>> + if (!str_env) {
>> + set_dfu_alt_info(interface, devstr);
>> + str_env = env_get("dfu_alt_info");
>> + }
>> #endif
>> - str_env = env_get("dfu_alt_info");
>>   if (!str_env) {
>>   pr_err("\"dfu_alt_info\" env variable not defined!\n");
>>   return -EINVAL;
>
> Yes, this patch fixes the issue. Do you plan to post this patch? Or has
> it already been posted and is under discussion? Please let me know.
>

no patch posted yet, but I will do that next week.

Jon

> Regards,
> Siddharth.
