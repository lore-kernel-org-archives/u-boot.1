Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ACBC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE9C87EDD;
	Fri,  8 Mar 2024 18:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uj0KJPyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56F787EDD; Fri,  8 Mar 2024 18:54:53 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2A787F02
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5a17a739935so1332193eaf.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709920489; x=1710525289; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d8wsx1cYPIH/Cr7/iH8KileGFMAZMjGCYhrtf2esdk=;
 b=uj0KJPyAd7Dwd/aUwIxgovYY/I2SIv8MSXR9SX39PBCcc/A9iSmkpVdZkco4kUUkki
 PrS8Orh64NGG+AF+2RdLhL/F6Q/gEXln7+3qk8yJSOIQ/kFea1T5UTFDKeLFknvVbyQZ
 1gdFOqGcunrhoXOJJyUSm0NYtVuacrbLzww2nNrR0HLZx9/+vJtAtJnmhhqdXsywTFmi
 BiFZn4zLN71+4xvJWmu/sQNu1gILbpi04qnd4ZIhnZweIZ1n9jN3x3Nze4lrEtHGVKf8
 H+XPVKOSlxK56lu7giF4AKtnO74FQZwW65A4loTBjYmbIuMiT7g7Wxte2ANwXAVfRyAn
 BukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709920489; x=1710525289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+d8wsx1cYPIH/Cr7/iH8KileGFMAZMjGCYhrtf2esdk=;
 b=ofhP67qtfl8bxDDo1X11L8g2YrapEptzkLc5X7RBIlyltmukzhZE+f/FPNr5S1V2rV
 3bAzBQx9eTFdxVBjBfdDRFh5XdcsUVhivPIFLUBbofoPZx7CeGc+SRZVlsHZwPwwY12J
 vn/8aOgezgQNYG9I3SvZeGMlFxmtteYOaY/h+rgMfNo0Vkop25xkZfIu6+uUTSMl/sCB
 nha+hfmdddeDqUjqKTCuk6Lstn4m9ClU4Foyr3CrjFWDW08XV7k6PK9eVzIzMQXAEHaY
 dzwzAovlvNG6XD4DIUVREq2Fgmc6om8J9VLkICJ9O0QIrJSm7HiSAoXaLpk6VUF2Suxi
 9tQA==
X-Gm-Message-State: AOJu0Yxpdc+ePgnMbdwVKMaKqWXo+MX2j9D9EJAup3SafRt0A9shwf61
 cDEwqaMwtKCzhQw5pwTVkT9m6yDmHyv4Mbw33PT/i8Fh39OoNUpEGZTRDRYjZXD7SexnmNvxPBn
 2+j+ytoVRvPPyZ8mSGNRrTCe7bA2AfBczLEWKvqHLb0DxDQo9wkE=
X-Google-Smtp-Source: AGHT+IEj7Ol69WBbIzs1I7wXaj4KJIXmwakJOOxqkackqTiH13+NsqvSm3GhsXlLh7X4NRyRCUjNjfBbjckU5ec5qYs=
X-Received: by 2002:a25:f30f:0:b0:dcd:6dea:5d34 with SMTP id
 c15-20020a25f30f000000b00dcd6dea5d34mr20179215ybs.36.1709920468195; Fri, 08
 Mar 2024 09:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
In-Reply-To: <20240308165937.270499-1-colin.mcallister@garmin.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 8 Mar 2024 11:54:17 -0600
Message-ID: <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup
To: Colin McAllister <colin.mcallister@garmin.com>
Cc: u-boot@lists.denx.de, JPEWhacker@gmail.com, sjg@chromium.org, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Mar 8, 2024 at 11:00=E2=80=AFAM Colin McAllister
<colin.mcallister@garmin.com> wrote:
>
> - Addresses compiler error due to missing semicolon
> - Removes use of preprocessor macros with ANDROID_AB_BACKUP_OFFSET
>
> Bug was found by noticing a semicolon was missing and not causing a
> compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
> a patch to fix the semicolon before fixing the #if's. Testing the latter
> patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
> compiler error.
>
> What's changed in V2?
> ---------------------
>
> The second verison of changes removes the #if preprocessor macros to use
> C conditionals instead. There was some minor refactoring required to get
> this to work, so I did more thourough testing to ensure the backup data
> works as expected.
>
> I also realized that CONFIG_VAL is not needed because there's no reason
> for the SPL or TPL to have different values for the backup address. I
> opted to just use CONFIG_ANDROID_AB_BACKUP_OFFSET directly.
>
> What's changed in V3?
> ---------------------
>
> Added "Fixes:" tag to patches. Performed additonal testing as described
> in the second paragraph in the testing notes below.
>
> I opted to not use CONFIG_IS_ENABLED because that macro appears to only
> be intended for y/n configurations. See note at top of linux/kconfig.h:
>
> "Note that these only work with boolean and tristate options."

Ah, ok, I see you replied to my comment here. So when that config
option is not defined at all, the build still works, right? One way to
test that would be to use buildman tool for all boards. Although I
have to say it might be very time consuming (I usually run it
overnight), so I'm not asking you to do it in this case, it's just
FYI.

>
> How was this patch series tested?
> ---------------------------------
>
> I built for my target with CONFIG_ANDROID_AB_BACKUP_OFFSET set to
> 0x1000. I first verified that the device can normally boot. I then ran
> dd before rebooting to corrupt the primary data. I confirmed that the
> backup was used to properly restore the primary. I then corrupted both
> the primary and backup data and confirmed that the primary and backup
> were both reinitialized to default values. Lastly, I corrupted the
> backup data and not the primary data and confirmed that the backup was
> restored the primary data.
>
> Addtionally, I disabled CONFIG_ANDROID_AB_BACKUP_OFFSET for my device
> and confirmed that after I corrupt the primary data, no backup is used.
> When the primary data is not corrupt, the device boots normally. This is
> what I would expect, because CONFIG_ANDROID_AB_BACKUP_OFFSET's default
> value is 0x0, which would evaluate to false for all C if conditions.
>
> Colin McAllister (2):
>   android_ab: Add missing semicolon
>   android_ab: Fix ANDROID_AB_BACKUP_OFFSET
>
>  boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 52 deletions(-)
>
> --
> 2.43.2
>
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.
