Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB46E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 13:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6688911A;
	Sat,  7 Dec 2024 14:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="WI+cvCDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1FD389170; Sat,  7 Dec 2024 02:02:45 +0100 (CET)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com
 [IPv6:2001:41d0:203:375::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4408089124
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 02:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <84f80eb4-9ed4-4fef-8565-80bf0ac0de51@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1733533362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKU5jPRY3gNKMykyx8F3F6elxI0ZIOF5jqf7p4NGOQQ=;
 b=WI+cvCDDIA4l0WjQheK6OulvUZmAM6sBOfxR/sVB7hCsOSwqvOo6/DDwhYXCpTyLx3yQhq
 I0x8qUXTkCrc1X8BxAL+YEFR5K2ptjGpPC6UETpKviyDK1NYaYTc9z9MrtDOsKk3sKCbUy
 mfOejBK2Z9zmN4nFl4arQC1hpdPS2RUkWVPfwjJqwiJj+eONZ1+68uaeOe6dIEjqezD1sB
 b5diMFSfnKWMaUmW7xedf37lmp6fetXK8AbZc4ZgvkQ9KrwfLC/IppGDWLL0I3mKgq+/yB
 qxh2333ABuRkw050QGbanr4IDkCASnSw6kyTOYQdTZPPt/0HZxuUgXrrL2wIAQ==
Date: Sat, 7 Dec 2024 04:02:37 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] board/qualcomm: introduce phone config
To: u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
 <20241004-qcom-phones-v2-1-c7ab67ac3043@linaro.org>
 <d8546140-414d-4dff-ae8b-9ecc9452c17c@devpi.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <d8546140-414d-4dff-ae8b-9ecc9452c17c@devpi.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 07 Dec 2024 14:25:33 +0100
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

On 12/6/24 19:50, Julius Lehmann wrote:
> On 04.10.24 14:46, Caleb Connolly wrote:
>> Phones don't have keyboards! Introduce a phone-specific config fragment
>> and associated environment file to make U-Boot more useful on these
>> devices. This allows for navigating via the buttons and enabling
>> various USB gadget modes or displaying info about U-Boot.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   board/qualcomm/qcom-phone.config | 12 ++++++++++
>>   board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom- 
>> phone.config
>> new file mode 100644
>> index 000000000000..388d4c3e7398
>> --- /dev/null
>> +++ b/board/qualcomm/qcom-phone.config
>> @@ -0,0 +1,12 @@
>> +# Settings for phones
>> +CONFIG_USE_DEFAULT_ENV_FILE=y
>> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
>> +CONFIG_PANIC_HANG=y
>> +CONFIG_CMD_PAUSE=y
>> +CONFIG_BOOTSTD=y
>> +CONFIG_BOOT_RETRY=y
>> +CONFIG_BOOT_RETRY_TIME=1
>> +CONFIG_BUTTON_REMAP_PHONE_KEYS=y
> 
> should also include fastboot, serial gadget and 
> CONFIG_CMD_USB_MASS_STORAGE. otherwise some menu options wouldn't work.

+1, should probably include CONFIG_USB_FUNCTION_ACM to enable output to 
usbacm?
