Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405CD12D66
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 13:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F18D891FD;
	Wed, 13 Nov 2024 14:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="XUmyisNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4F689274; Wed, 13 Nov 2024 14:15:32 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0322688A3C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 14:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1731503729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2giLaU0PcJDGXxDdzORVMHiUvTZB0pXD4bAxmmp2kM=;
 b=XUmyisNCATMz9SlGFJRrvRnjCkpvnLPDplwvmJ0q+Hja8roDnZWs1yXRxhos6Sbcwj6I+B
 laDlihjVJaNphV2aYoR3y2H/JJtNGd+7Q5WI6GvV1/OMPawiph1MXH/6g2EsdMPxZjvm0J
 aYrwhXDLEFAAMb2OERolFfnXw6hCBp9ljHSZUAHVgT0jUpNg7gZ7jSKzj4BL1JQV0VmQcm
 /tSR4cINQQcvCCAzfpysWmijcOyYYd24bocLFFE4r8UkyFu4wKKZQ9zYhy5M1b0h4IHSrV
 c+bPeRse4eg8pb8gcI+uHAvcrOe+B9qLhREnDfABqMhRKl7I8idmYi3MPZnKFA==
Date: Wed, 13 Nov 2024 14:15:28 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman
 <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
In-Reply-To: <19f15ca1-5354-4ee5-9ea1-dc94d6905afc@linaro.org>
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
 <50f69678f0fbb74aecc2e2aeb5f4dc6b@manjaro.org>
 <19f15ca1-5354-4ee5-9ea1-dc94d6905afc@linaro.org>
Message-ID: <62c6fef53c7819bdd56ab51b571731a4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Caleb,

On 2024-11-13 14:08, Caleb Connolly wrote:
> On 13/11/2024 10:48, Dragan Simic wrote:
>> Thanks for the patch.  Please, see a comment below.
>> 
>> On 2024-11-13 06:30, Caleb Connolly wrote:
>>> It may be the case that MMC support is enabled even though the board
>>> we're booting on doesn't have any MMC devices. Move the print over to
>>> the print_mmc_devices() function where we can only print it if we
>>> actually have MMC devices.
>>> 
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  common/board_r.c         | 1 -
>>>  drivers/mmc/mmc-uclass.c | 4 +++-
>>>  drivers/mmc/mmc_legacy.c | 5 +++++
>>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/common/board_r.c b/common/board_r.c
>>> index 62228a723e12..232a8fd19f03 100644
>>> --- a/common/board_r.c
>>> +++ b/common/board_r.c
>>> @@ -384,9 +384,8 @@ static int initr_onenand(void)
>>> 
>>>  #ifdef CONFIG_MMC
>>>  static int initr_mmc(void)
>>>  {
>>> -    puts("MMC:   ");
>>>      mmc_initialize(gd->bd);
>>>      return 0;
>>>  }
>>>  #endif
>>> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
>>> index c8db4f811c2f..56fe29249c36 100644
>>> --- a/drivers/mmc/mmc-uclass.c
>>> +++ b/drivers/mmc/mmc-uclass.c
>>> @@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
>>>           dev;
>>>           uclass_next_device(&dev), first = false) {
>>>          struct mmc *m = mmc_get_mmc_dev(dev);
>>> 
>>> -        if (!first) {
>>> +        if (first) {
>>> +            printf("MMC:  ");
>>> +        } else {
>>>              printf("%c", separator);
>>>              if (separator != '\n')
>>>                  puts(" ");
>>>          }
>>> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
>>> index 8f8ba34be717..f4a049a4a4d4 100644
>>> --- a/drivers/mmc/mmc_legacy.c
>>> +++ b/drivers/mmc/mmc_legacy.c
>>> @@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
>>>  {
>>>      struct mmc *m;
>>>      struct list_head *entry;
>>>      char *mmc_type;
>>> +    bool first = true;
>>> 
>>>      list_for_each(entry, &mmc_devices) {
>>>          m = list_entry(entry, struct mmc, link);
>>> 
>>> @@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
>>>              mmc_type = IS_SD(m) ? "SD" : "eMMC";
>>>          else
>>>              mmc_type = NULL;
>>> 
>>> +        if (first) {
>>> +            printf("MMC:  ");
>>> +            first = false;
>>> +        }
>> 
>> Can't we simply check for "entry == &mmc_devices->next" here and
>> avoid the introduction of "first"?
> 
> That would be clever, yeah I can do this in v2.

Thanks, please make sure to Cc me in the v2 submission.

> I hvaen't found a way to test mmc_legacy thus far, does anyone know how
> I could?
> 
>>>          printf("%s: %d", m->cfg->name, m->block_dev.devnum);
>>>          if (mmc_type)
>>>              printf(" (%s)", mmc_type);
