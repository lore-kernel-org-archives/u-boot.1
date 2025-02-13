Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB70C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F7C80A55;
	Thu, 13 Feb 2025 14:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qcudEJpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E9A80C96; Thu, 13 Feb 2025 14:19:17 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A9D80756
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4395a06cf43so5568695e9.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739452754; x=1740057554;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sZ8Wtgy+BYtzJ85HPuep5QjPe+Q46KjbLVWjS0mkqtg=;
 b=qcudEJpMJqoKgppQuvkBT8aksGyU6qHxiXCcEx+xjmxvnGIYcJtNWJOrtUQrWxarlj
 cn6/L8tH7miNhUe0P2hRmYCZFYr4RtZAGn730WypTav6rBPfZYjmN8P3gxmkrsLpUab5
 RnXhzIk6MrkbCbPIRixnNTO520TwsCxxQICfwh00Ru8fRDSrncPxBo6UoF77M3RHjsid
 faeKXZXardNoJJaJE0P6S1/B8aWIddm5uPYSzJbecWvKbKVgse8+V1QUXOvbOCsUTJ94
 M28Kt4DkUtp2gSV8ymr7PQ3S7Kc54uB0+phWXtIzvhpHF7qr3hH9oFs0Qz9W093ckfMy
 UIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739452754; x=1740057554;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZ8Wtgy+BYtzJ85HPuep5QjPe+Q46KjbLVWjS0mkqtg=;
 b=Mdj1LwTdYsLuAKMmp4hbESgjNwlqh98bbS5UcaT2CBl6cxX9iB+Fu9Z2AoFi79agZJ
 udgs9/Tc2sedvpQuxYUEIT8pl5JXejlq9hdJuiXMAhxcky/yhsacoMbKjRh4/XnA/eeJ
 lCU3B7IJgGvxtC66SZtX33S2VLMJJvBXaRuDwuaS+usr3ahSeIQShgNQKNRwYmQ1vWpS
 ZZ1MwLmnHZ/ZuFQTDIBYerFkegyGRnLOS5qwTBJjNlaM/VwalFq3XR2nogPMCJRiZAK0
 9DjSRlSnoDHb01cAi2pTLMZDJhDk3eCYAllJDkoN420W53c8kfotB6PzXHKqwp/1VABU
 EACw==
X-Gm-Message-State: AOJu0YzgQ8MiUrpsDbZdv9DgLW40Tzj9nVX/vzeG42bgu1b8F4hnjXyH
 JiK1Q0A5ilznOHU5vSXFHvBnRyzwOzl/QH4mht1UsnSDUqIV1EtRb/pPJlgRexY=
X-Gm-Gg: ASbGnculkQlr4bJbIYhO+G7///b/qc79QeNtc+tnmFtqPHv6oTANV+qEkhgcBp0AgZ0
 Z60u7SGnAGSaJAAR9ACYkT083t/jzg4eE5X813xvBIHYFVQb0xUfXTTKu/PIpZxU5XSV1Vq2CK6
 WPvYEzWpqfi5ozFQhgvTKyJWbUFVV2kmSxNIp+tkHt01oIbblvvjYdNt9sd2YsDdoCbnkEAmL3m
 vDgu95L134qWmd0NAZBf91nWLYxmTcPq76Cn5OCNSWbWaJaXT3wlt8eXr6+xXpdpCBLeCVkPEtP
 DDWk0XqwiQ4/hjFGdys=
X-Google-Smtp-Source: AGHT+IGou0dnaxmqFwClyCVBGvHN8vfzpwbALOe2gYKIqa1VC71tYEtevRoJWTTaQX5mrA8To1tsHQ==
X-Received: by 2002:a05:600c:3485:b0:439:4a1f:cf8b with SMTP id
 5b1f17b1804b1-439600fd7dfmr46220665e9.0.1739452754380; 
 Thu, 13 Feb 2025 05:19:14 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a0558e2sm48888485e9.11.2025.02.13.05.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 05:19:13 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michal Simek <michal.simek@amd.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, Udit
 Kumar <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>, Devarsh Thakkar
 <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Daniel Schultz <d.schultz@phytec.de>, Viacheslav
 Bocharov <adeep@lexina.in>, Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Tom Rini
 <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>, Nishanth
 Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski <lukma@denx.de>,
 s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] efi_firmware: set EFI capsule dfu_alt_info env
 explicitly
In-Reply-To: <7eec57ad-a50a-456c-ab6f-fa2c349b524b@amd.com>
References: <20250206154719.3032322-1-j-humphreys@ti.com>
 <20250206154719.3032322-2-j-humphreys@ti.com>
 <7eec57ad-a50a-456c-ab6f-fa2c349b524b@amd.com>
Date: Thu, 13 Feb 2025 14:19:11 +0100
Message-ID: <87lduadltc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Michal,

Thank you for testing this.

On lun., f=C3=A9vr. 10, 2025 at 13:40, Michal Simek <michal.simek@amd.com> =
wrote:

> On 2/6/25 16:47, Jonathan Humphreys wrote:
>> The current implementation of EFI capsule update uses set_dfu_alt_info()=
 to
>> set the dfu_alt_info environment variable with the settings it requires.
>> However, set_dfu_alt_info() is doing this for all DFU operations, even
>> those unrelated to capsule update.
>>=20
>> Thus other uses of DFU, such as DFU boot which sets its own value for the
>> dfu_alt_info environment variable, will have that setting overwritten wi=
th
>> the capsule update setting. Similarly, any user defined value for the
>> dfu_alt_info environment variable would get overwritten when any DFU
>> operation was performed, including simply performing a "dfu 0 list"
>> command.
>>=20
>> The solution is stop using the set_dfu_alt_info() mechanism to set the
>> dfu_alt_info environment variable and instead explicitly set it to the
>> capsule update's setting just before performing the capsule update's DFU
>> operation, and then restore the environment variable back to its original
>> value.
>>=20
>> This patch implements the explicit setting and restoring of the
>> dfu_alt_info environment variable as part of the EFI capsule update
>> operation.
>>=20
>> The fix is fully implemented in a subsequent patch that removes the caps=
ule
>> update dfu_alt_info support in set_dfu_alt_info().
>>=20
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>   lib/efi_loader/efi_firmware.c | 39 ++++++++++++++++++++++++++++++++---
>>   1 file changed, 36 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
>> index 5a754c9cd03..1a1cf3b55e1 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -649,8 +649,10 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>>   	efi_status_t (*progress)(efi_uintn_t completion),
>>   	u16 **abort_reason)
>>   {
>> +	int ret;
>>   	efi_status_t status;
>>   	struct fmp_state state =3D { 0 };
>> +	char *orig_dfu_env;
>>=20=20=20
>>   	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
>>   		  image_size, vendor_code, progress, abort_reason);
>> @@ -663,7 +665,22 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>>   	if (status !=3D EFI_SUCCESS)
>>   		return EFI_EXIT(status);
>>=20=20=20
>> -	if (fit_update(image))
>> +	orig_dfu_env =3D strdup(env_get("dfu_alt_info"));
>> +	if (env_set("dfu_alt_info", update_info.dfu_string)) {
>
> This pretty much breaks all xilinx platforms because we actually are not=
=20
> configuring dfu_string.
>
> I have sent RFC. If you can squash it to your patch that would be the bes=
t.
> Pretty much the part of it should be in 1/2 and the part in 2/2.

For reference, the patch that has been send as RFC is:
http://lore.kernel.org/r/c8378bd1bbc7a96ecd802897ca72e26a02bf5a2b.173919050=
3.git.michal.simek@amd.com

>
> M
