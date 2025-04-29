Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C66CC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 07:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA7B80EFB;
	Tue, 29 Apr 2025 09:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="c8uRtLhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D83580FDE; Tue, 29 Apr 2025 09:07:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490A480BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 09:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745910450; x=1746515250; i=xypron.glpk@gmx.de;
 bh=4TMbm/mpzFfnV0RHldYPiZoulcbrAQrlBujVZdBbelk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=c8uRtLhczZxHRGNzdKl6nslbciPjuFKYYrMVATb9wHxRvC/+S49cNPUT3sKka9rC
 l8KTNYaCfnaOxXzdbIhxJHc52zu2GAUG3yd5SKYqYJSa0ZnsLPw5ProuVFVPYdQy0
 7KzyrjDkl6avnXgCLqF1jWgO1a7lvvDk69yJdDmxMF359803AweHNoLpUfRltVAZs
 3JxeOvgs6z3F0CSbuvM+j1KkQzAEezaQaIYzeqaf8XgPrD3swmH58lFxSaYhpBJqc
 3cdP9dhojIct4fNXskuvm/bLe1ALt3yo03BLR12RvesYdTpvQzupwq2WDjjeZte3Q
 753Yp0yZu1qCwEU1LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1uGkSe08fi-00Cxjt; Tue, 29
 Apr 2025 09:07:30 +0200
Message-ID: <24787b46-69b4-405a-9f88-79fb8ab1d638@gmx.de>
Date: Tue, 29 Apr 2025 09:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] efi_loader: fix typo initd_sz to initrd_sz
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
 <20250428145341.2091400-3-adriano.cordova@canonical.com>
 <CAC_iWjKDqCWaOQcjOF5j_NvhxByKJhciv0LWxXLsBXyXdTLcMQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKDqCWaOQcjOF5j_NvhxByKJhciv0LWxXLsBXyXdTLcMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lAhaWjmz+2ZYdReOrHDxmym66ZqqwCn+/z8/4/sLbj45GEonMCV
 sil+kt1sKmFqob186JApqojub8avod4TNJvGyePcK+DENovqch75COWDWw7GbwJDF+MQ/CW
 phqRccxAKl0UoYSkJ7tFaDq9o7m1nB8B4MwKccNIkBBC9YtILtBIiLMoAcOtMbIKHg0pVe7
 YfLaFWcE+oDY/PZsKBenw==
UI-OutboundReport: notjunk:1;M01:P0:Q1YutAONCH8=;N9zFX0d9HA3/Dwh9QO+tL1+31bT
 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
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

On 4/29/25 08:25, Ilias Apalodimas wrote:
> On Mon, 28 Apr 2025 at 17:53, Adriano Cordova <adrianox@gmail.com> wrote:
>>
>> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
>> ---
>>   lib/efi_loader/efi_bootbin.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
>> index 6a189c31ffa..94ba7c5589b 100644
>> --- a/lib/efi_loader/efi_bootbin.c
>> +++ b/lib/efi_loader/efi_bootbin.c
>> @@ -215,7 +215,7 @@ out:
>>    * Return:     status code
>>    */
>>   static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>> -                                     void *initrd, size_t initd_sz,
>> +                                     void *initrd, size_t initrd_sz,
>>                                        struct efi_device_path *dp_dev,
>>                                        struct efi_device_path *dp_img)
>>   {
>> @@ -233,7 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>>          if (ret != EFI_SUCCESS)
>>                  return ret;
>>
>> -       ret = efi_install_initrd(initrd, initd_sz);
>> +       ret = efi_install_initrd(initrd, initrd_sz);
>>          if (ret != EFI_SUCCESS)
>>                  return ret;
>>
>> --
>> 2.48.1
>>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
