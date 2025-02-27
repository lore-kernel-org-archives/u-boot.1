Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CF8C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A18081026;
	Thu, 27 Feb 2025 13:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740659412;
	bh=aRG0J7Jg+ioeRaI7Cn+gmcrr3fO3VR/mtyYE0pnsKxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O5/1gZCVrdos7hfhlWnISTmHYOtTuSHm2xQkfdxQRiU6SP4sO1EZ4/NN2kyvfCjEY
	 cMQYJlhqs8XGXPTgV75rq74ekEhPK3sBue7VnBWbPO/yZFMSobu9u3Q+YcLrlJXQRk
	 +QuOC8LxWLrn/sSnWCnMYDKR65yxN+GyUTpL/VpIdICPqVKbQDTmXW9LUsH7TGHqL/
	 aSx0IvI9v2Et9sA+skzpFt6+lnpo8xphTMC5+DZBjkCNyrZIlrusxCz8V0qA1mRGJ6
	 hgeoYQS3lN2Kqjsk4mxck6tzlIyZ16T4NWh+A3kJgPmGmjNyv/VUBSn99xpBNqCg0X
	 /AurPIR0KdNYQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D637810E6; Thu, 27 Feb 2025 13:30:11 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A1AF80FF0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Z3VzL1V1wz9tjY;
 Thu, 27 Feb 2025 13:30:06 +0100 (CET)
Message-ID: <25a26671-78aa-4d24-8457-aaa7008addf1@denx.de>
Date: Thu, 27 Feb 2025 13:30:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/14] cyclic: invoke uthread_schedule() from schedule()
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Z3VzL1V1wz9tjY
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

Hi Jerome,

On 25.02.25 17:34, Jerome Forissier wrote:
> Make the schedule() call from the CYCLIC framework a uthread scheduling
> point too. This makes sense since schedule() is called from a lot of
> places where uthread_schedule() needs to be called.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Frankly, at first I was wondering a bit, if and why another framework
for "multitasking" is needed in U-Boot, additionally to the cyclic
framework that I introduced a few years ago. Which was greatly enhanced
by Rasmus over the time. But looking at your "uthread" implementation
it makes sense to add such a probably more intuitive interface as well.

In general I'm really happy seeing activity in this "multitaking" area
in U-Boot. As it brings a lot of new possibilities and, as you've also
shown in your patchset, may greatly help reducing boot time in the
USB example. :)

One question though:
Do you have some means in your uthread framework, measuring and
perhaps limiting the time spent in these uthreads? If and how is a
preemption of a uthread possible? So that it does not consume too
much time resulting in e.g. things like dropping input chars on
the prompt? Sorry, I did not thoroughly go through all your code
to get the internals from there. It would be great if you could
elaborate a bit on this.

For this patch:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c           | 3 +++
>   include/u-boot/schedule.h | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index fad071a39c6..b695f092f52 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -16,6 +16,7 @@
>   #include <linux/list.h>
>   #include <asm/global_data.h>
>   #include <u-boot/schedule.h>
> +#include <uthread.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -100,6 +101,8 @@ void schedule(void)
>   	 */
>   	if (gd)
>   		cyclic_run();
> +
> +	uthread_schedule();
>   }
>   
>   int cyclic_unregister_all(void)
> diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
> index 4fd34c41229..4605971fdcb 100644
> --- a/include/u-boot/schedule.h
> +++ b/include/u-boot/schedule.h
> @@ -3,6 +3,8 @@
>   #ifndef _U_BOOT_SCHEDULE_H
>   #define _U_BOOT_SCHEDULE_H
>   
> +#include <uthread.h>
> +
>   #if CONFIG_IS_ENABLED(CYCLIC)
>   /**
>    * schedule() - Schedule all potentially waiting tasks
> @@ -17,6 +19,7 @@ void schedule(void);
>   
>   static inline void schedule(void)
>   {
> +	uthread_schedule();
>   }
>   
>   #endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

