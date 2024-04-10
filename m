Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0186ACD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1432487519;
	Wed, 10 Apr 2024 14:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HpKSCbf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13D988120; Wed, 10 Apr 2024 14:56:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8EC87519
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-416b5f6813cso15454385e9.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712753784; x=1713358584;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpyKhBhH1uLlvjCNpWTpfda9gKCHQIZdQv3KcVnCgzw=;
 b=HpKSCbf8D1ZdgJqeE7POaPDsQkUwA67Qy74NZvOOMRAOptcY7VjcFqV5jt3sYL4g50
 SUh0vVsC4NSm16Z43c3gAqHsa4/DmAghmcZlzkbnUj2AFZMZ00Ho09ZW+3kcmb80EDET
 HrbPXCTTjwQMygAn9GeMGrfwYItwYnrmb4fLrFCHVpN8A6Eu+Na/cIQNWRm5FoIeAD2o
 CvCsMJiojwS6PD4kez6AScQJ+zZPbxD1Sqm4YNDIKrDzlg4nFm7gsN2E9L+eSeOKV/tj
 ydoeYoAsnFKPdKeRb92Rtkd2d9RP18tVvDlF01vSwufx36iEYr5qolB6BbFSMvPzZtRg
 naaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712753784; x=1713358584;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpyKhBhH1uLlvjCNpWTpfda9gKCHQIZdQv3KcVnCgzw=;
 b=V6GFHrVvW9uUJ5kTzZQ1ZDbUsTOAurGOHShq2z04ZqW5ET0+kOy9f6zC5m88pY+kj9
 hH0LL0D11M19mnfFMCNEgWUE2l2BAEXXHa0KpnSmUi5gg173oghuuCA7j/6lPyj3vGST
 DiTySMuqlxz8DNRSxUqlbx6y0HfTO+COpjUpLzVxjNgxo69hesewIXU7HVwqyejUnVUb
 iwNHlQ/LEVWlJYui0dhJfn43ok0ugfG0Zni6WCYbSj98qAn8G202QJgbnfnFoNknqthc
 31MGAN5rQiWgmXa4IJy5mnxMz3HZZEkRQmAk0fxenIMm5Wcb281gW/vfqXdNLh1HpYDR
 F0ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNKD1BSeSCQp/8UIWS7723Y5PFmdsMxmFXwGIHwNtjluzSpIeFXGe7DA05HPjlZf++NP3nol3eXns8piuy8bqU239SRg==
X-Gm-Message-State: AOJu0YwymuKCao+Cx6WS6phpw40/YWlbcEuMIX85MFePWBJhWnG7GoSh
 AzmuFDaj67/rnrN88PuRHJcyd1KXrt7mT6riUC1V5Xhs9ZCv4yDF29sBCNZ5PbQ=
X-Google-Smtp-Source: AGHT+IHZJnrFHDLt5w8oN9y92QlwqiWsJwKPZIAXWAH5gbqPsA9p5kiazEh5l8etAy1obsZOQJRWUA==
X-Received: by 2002:a05:600c:4e4a:b0:416:3217:15be with SMTP id
 e10-20020a05600c4e4a00b00416321715bemr2691558wmq.35.1712753784156; 
 Wed, 10 Apr 2024 05:56:24 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a05600c34c200b004155387c08esm2212148wmq.27.2024.04.10.05.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 05:56:23 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Alexey Romanov <avromanov@salutedevices.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
In-Reply-To: <20240410124257.3zc673n2jb3msiep@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240410105804.22757-1-avromanov@salutedevices.com>
 <20240410105804.22757-2-avromanov@salutedevices.com>
 <20917bf6-2be2-4a1f-8c87-a69a2241d1fc@theobroma-systems.com>
 <20240410124257.3zc673n2jb3msiep@cab-wsm-0029881.sigma.sbrf.ru>
Date: Wed, 10 Apr 2024 14:56:22 +0200
Message-ID: <874jc9js09.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alexey,

On mer., avril 10, 2024 at 12:43, Alexey Romanov <avromanov@salutedevices.com> wrote:

> Hi guys,
>
> On Wed, Apr 10, 2024 at 02:02:21PM +0200, Quentin Schulz wrote:
>> Hi Alexey,
>> 
>> On 4/10/24 12:58, Alexey Romanov wrote:
>> > Currently, fastboot protocol in U-Boot has no opportunity
>> > to execute vendor custom code with verifed boot. This patch
>> > introduce new fastboot subcommand fastboot oem board:<cmd>,
>> > which allow to run custom oem_board function.
>> > 
>> > Default implementation is __weak. Vendor must redefine it in
>> > board/ folder with his own logic.
>> > 
>> > For example, some vendors have their custom nand/emmc partition
>> > flashing or erasing. Here some typical command for such use cases:
>> > 
>> > - flashing:
>> > 
>> >    $ fastboot stage bootloader.img
>> >    $ fastboot oem board:write_bootloader
>> > 
>> > - erasing:
>> > 
>> >    $ fastboot oem board:erase_env
>> > 
>> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
>> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> > ---
>> >   doc/android/fastboot.rst      | 18 ++++++++++++++++++
>> >   drivers/fastboot/Kconfig      |  7 +++++++
>> >   drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
>> >   include/fastboot.h            |  1 +
>> >   4 files changed, 56 insertions(+)
>> > 
>> > diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
>> > index 1ad8a897c8..2a627f9890 100644
>> > --- a/doc/android/fastboot.rst
>> > +++ b/doc/android/fastboot.rst
>> > @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled):
>> >     with <arg> = boot_ack boot_partition
>> >   - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure eMMC
>> >   - ``oem run`` - this executes an arbitrary U-Boot command
>> > +- ``oem board`` - this executes a custom board function which is defined by the vendor
>> >   Support for both eMMC and NAND devices is included.
>> > @@ -245,6 +246,23 @@ including multiple commands (using e.g. ``;`` or ``&&``) and control structures
>> >   (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect the exit
>> >   code of the command you ran.
>> > +Running Custom Vendor Code
>> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > +
>> > +U-Boot allows you to execute custom fastboot logic, which can be defined
>> > +in board/ files. It can still be used for production devices with verified
>> > +boot, because the vendor define logic at compile time by implementing
>> 
>> I think it should be "defines" here?
>
> Yep. If there are no more comments, maybe Mattijs will correct this when
> he picks up a patch? So that I don't send a new series with typo fix :)

Yes, if there are no other review comments, I will fix this up locally
when picking this up.

>
>> 
>> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> 
>> Thanks,
>> Quentin
>
> -- 
> Thank you,
> Alexey
