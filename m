Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC48CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C72587710;
	Mon, 11 Dec 2023 20:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c8WG5RrW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lNmOQHfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23AA87754; Mon, 11 Dec 2023 20:24:46 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 440B9876E2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SpsBg5Z7qz9t4h;
 Mon, 11 Dec 2023 20:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702322683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pZid7wf5Z64ho4xzG6XcGscaqtNi99cQbJuk3sgfVM=;
 b=c8WG5RrWfWCULuY3VBeOt/oUuGP7anvPRnyv6yAf7ia6m+Z09riK288BzZP4VWwK6SLKxh
 ev6HkmMe1+P61UO39SsIf4zRkmzko4yAh3TZBPzxGJAgHdhRhFOowk2Phzn+HG4RCBgaeX
 sKCFEwvUsluV16R2lp8EzSy4+qdi9vZ3lD4uiHS2oYts/UzIEj6Vr4uR8KvLV+jItoxejc
 tbD1CR901EmPoJ4NCUsXD9aDLNVZjWItXcG4YDCVgzXtF7MzwGEWsDe6DtN+mpum/BRG45
 g2nqptZ3LfhxeGeFMszVfoUKzGsbyfpKyPdlJtV/IfZtQm1lU29EndmZezVH6g==
Message-ID: <6b56dc6f-f753-4da3-b371-4a8146d3f4e9@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1702322682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pZid7wf5Z64ho4xzG6XcGscaqtNi99cQbJuk3sgfVM=;
 b=lNmOQHfVPo/1cwcthcsYdj6VUcFhifCgrwDnVUn8hicUT7VRd0EhbHCK80RFrGzeuqCz61
 4iUAcIb56H1e4ooR5OAk4g2dFm+qHGl9LmH9vSl6Nth5wO9dWEwUtnDt4qisjpS2dFolh0
 ZGV29N4UYBi9xajIdfDF/vYzLQsnUyQzq9nW1rJ70lU3u3+oNFJv/AJYnaI4rPhmbIcXqn
 LoSX2lr4DglrD7kHugMzH/1/+v3gqk8+jGv2XY+p2H1fY9B7RXhvMnN5OWvQEa/8oMN5ke
 WUzlxGEnRePOS4FULjnHeSnMozoRGR0Z1NnGzrrlSNH2lVIj8FN6u/hgiHjO7Q==
Date: Mon, 11 Dec 2023 20:24:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mmc: Poll CD in case cyclic framework is enabled
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20231210150304.124458-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPnjgZ10dpyK3qyoogTaabyH0sNsXRZReCGdvVhdO=0LG2DJWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 320f899350480a62675
X-MBO-RS-META: gkhed8nrmxkasx5cxdf9bb5iqr9zf8az
X-Rspamd-Queue-Id: 4SpsBg5Z7qz9t4h
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

On 12/11/23 18:52, Simon Glass wrote:
> Hi Marek,
> 
> On Sun, 10 Dec 2023 at 08:03, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> In case the cyclic framework is enabled, poll the card detect of already
>> initialized cards and deinitialize them in case they are removed. Since
>> the card initialization is a longer process and card initialization is
>> done on first access to an uninitialized card anyway, avoid initializing
>> newly detected uninitialized cards in the cyclic callback.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> ---
>> V2: Move the cyclic registration/unregistration into mmc init/deinit
>> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>>      does not work with structure members
>> ---
>>   drivers/mmc/mmc.c | 36 ++++++++++++++++++++++++++++++++++++
>>   include/mmc.h     |  5 +++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>> index eb5010c1465..a5686dbc12e 100644
>> --- a/drivers/mmc/mmc.c
>> +++ b/drivers/mmc/mmc.c
>> @@ -2985,6 +2985,22 @@ static int mmc_complete_init(struct mmc *mmc)
>>          return err;
>>   }
>>
>> +#if CONFIG_IS_ENABLED(CYCLIC)
>> +static void mmc_cyclic_cd_poll(void *ctx)
>> +{
>> +       struct mmc *m = ctx;
>> +
>> +       if (!m->has_init)
>> +               return;
>> +
>> +       if (mmc_getcd(m))
>> +               return;
>> +
>> +       mmc_deinit(m);
>> +       m->has_init = 0;
>> +}
>> +#endif
>> +
>>   int mmc_init(struct mmc *mmc)
>>   {
>>          int err = 0;
>> @@ -3007,6 +3023,19 @@ int mmc_init(struct mmc *mmc)
>>          if (err)
>>                  pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
>>
>> +#if CONFIG_IS_ENABLED(CYCLIC)
> 
> We really shouldn't be adding new #ifdefs to the code.
> 
> If you really want to make put ->cyclic behind an #ifdef then how
> about creating an accessor as is done in global_data.h ?

That's really just working around the underlying issue, which is that 
this does not compile:

struct foo {
#if CONFIG_IS_ENABLED(STUFF)
   type member;
#endif
...
};

type fn() {
...
if (CONFIG_IS_ENABLED(STUFF))
   access struct->member;
...
}

Accessor won't make it any better, would it ? It would only attempt to 
hide the error and make the code more fragile, i.e. this:

accessor(struct)
{
type fn() {
if (CONFIG_IS_ENABLED(STUFF))
   return access struct->member;
else
   return 0;
}

}

type fn() {
...
   accessor(struct);
...
}

I suspect it also won't compile for one thing, and for the other, it 
really just hides the issue.
