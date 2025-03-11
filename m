Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F251C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 07:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51E98083E;
	Tue, 11 Mar 2025 08:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741679051;
	bh=niQgbXOWKlJIianvJyJlAqZna2GkuUik448exWCuxhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IjVCsyMuDdFK20hUumuM6B/M6dfh+UYWSZZ3LlW9zpA6EPro6DkELTszk0smBwAXt
	 uXiUJH1gc+2EK8mPRpHsfoSuBOnTs2OWnOVd2JfpDjSWr3UEovrfTLed7JR4DE2IIz
	 rHk3DgyRV/2mXQt+26fYU3iPrG8Td6RsrHzI1+Qf7Y+Fvq5Jq7H+bbdLGZ9l2o040z
	 ZkWhcG1lNtKVeeR1FD6TxnVd3F5/QGwCzTZLwUayFwYDyFgw2QfuJBzxXLmBfX3ZSl
	 g9JAn3JCYjOwmfxQ8OZ7IjGKhkZxh7Qj4uxHDekOIadC2/dVFESTmB3XY+c7a5HXmM
	 hjkt5+KgZ1w2w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C207280FB9; Tue, 11 Mar 2025 08:44:09 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0674807D9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZBm3n3xTPz9tXy;
 Tue, 11 Mar 2025 08:44:05 +0100 (CET)
Message-ID: <9fe72167-7747-4456-bd03-020686396d28@denx.de>
Date: Tue, 11 Mar 2025 08:44:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 07/14] cyclic: invoke uthread_schedule() from schedule()
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
 <20250304152510.2832340-8-jerome.forissier@linaro.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250304152510.2832340-8-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZBm3n3xTPz9tXy
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

On 04.03.25 16:24, Jerome Forissier wrote:
> Make the schedule() call from the CYCLIC framework a uthread scheduling
> point too. This makes sense since schedule() is called from a lot of
> places where uthread_schedule() needs to be called.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

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

