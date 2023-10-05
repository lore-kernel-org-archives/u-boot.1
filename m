Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC4E936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 01:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC90875EC;
	Thu,  5 Oct 2023 03:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="doqke21k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37755875C7; Thu,  5 Oct 2023 03:23:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479AC875BE
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 03:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b2cee40de8so104242166b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696469037; x=1697073837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fl2zUFZOV2zhdKEBFP/1QrB/qqPJdjCsUmvSrSktI0Q=;
 b=doqke21kT8SHBnTRE8m+k+ozTOc3RFeH8B1Wo/z5pGVnikJ7At1NxSuQx+dAQPkyt4
 ix6jvql4wHlLD4kiIW8c/1MX5EGPPZAcBTZXR2tep/dEGnO47rED1PCv/In+qXVSvHIn
 9rMKrJ8m+K3vQCrl47nJH+s6Zno0ENlTzsfUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696469037; x=1697073837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fl2zUFZOV2zhdKEBFP/1QrB/qqPJdjCsUmvSrSktI0Q=;
 b=sfjrZ4BxuWkh6oUiLplghzQwleJM03D/UQYJV5V2dqcKcmN/O1AFBmVGTvf6cJ4hhk
 9N3aCiaMY4G3DIkckMv7Ez/7UPCT/J1gamI8/4tIAT32YYTnaIRG4aqr1Yqe0x0nk6BB
 6/Wz79hHzXlrQSYx7WaMfxLk83K7KOECkwemka5QwuTQEydzb7VNq1j1FhpIMN65emuM
 muIjuHr9AxwTmgBnERt3oqohYoEegAclqjhvufLsnvVr0ia+ZLxj8Vse1tr7qVGl9tak
 +Jknu3PKBeljim8d9YXKVtPyCeXV887l+FchPxJn6sl7N/rT9QunXcT5aKNBBBVMXRvv
 YQgw==
X-Gm-Message-State: AOJu0YyJk9+fdbqwQi6uRu5pd8iSWsk8v0wJEWGGhbipRRrKo/dNBu7B
 5Xf/fIw+GP/21Rh1ZQ+QnSje+HX9Fup4rllhHKaHHw==
X-Google-Smtp-Source: AGHT+IH0eDka9num51mAffdpXsD4oDViqpsOoHR/jr3gkP5+NyP9WWgX0HNl+SSH3apcIz8pe0Xv3z2mShUO0ioR+LQ=
X-Received: by 2002:a17:906:218:b0:9ae:614e:4560 with SMTP id
 24-20020a170906021800b009ae614e4560mr1088828ejd.29.1696469036561; Wed, 04 Oct
 2023 18:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2E7LgCovBqKv4eWrPcYPNS9JfYYfBpaQ+fLV1MFs+EWA@mail.gmail.com>
 <20231004124734.215105-1-artur@conclusive.pl>
In-Reply-To: <20231004124734.215105-1-artur@conclusive.pl>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 19:23:40 -0600
Message-ID: <CAPnjgZ1Ngm8dTZ2tC4pUJf6+Tc+LzSRnOi8eQYxYRqP=SNfw-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] common: Add generic function for reading serial
 number
To: Artur Rojek <artur@conclusive.pl>
Cc: eugen.hristev@collabora.com, jakub@conclusive.pl, marcin@conclusive.pl, 
 radoslaw.adamczyk@conclusive.pl, u-boot@lists.denx.de, wojciech@conclusive.pl
Content-Type: text/plain; charset="UTF-8"
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

Hi Artur,

On Wed, 4 Oct 2023 at 06:47, Artur Rojek <artur@conclusive.pl> wrote:
>
> >Hi Artur,
> >
> >On Mon, 2 Oct 2023 at 06:42, Artur Rojek <artur@conclusive.pl> wrote:
> >>
> >> Provide a generic way for boards to read their serial number from EEPROM
> >> at init.
> >>
> >> If CONFIG_ID_EEPROM is set, the new serial_read_from_eeprom() function
> >> will now be called during the post-relocation part of the board init.
> >>
> >> Provided is the tlv eeprom implementation of the above function, making
> >> use of the existing, yet never utilized, populate_serial_number().
> >> Boards which use custom logic for interaction with their EEPROMs need to
> >> supply their own implementation.
> >>
> >> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> >> ---
> >>
> >> v3: - restore original function name and make it static
> >>     - provide a generic function for reading EEPROM serial number and
> >>       wrap it around the existing tlv logic
> >>     - move the env var check out of populate_serial_number() and into
> >>       the new serial_read_from_eeprom() in order to stay consistent with
> >>       the documentation
> >>
> >> v2: - rename the function
> >>     - move function documentation from .c file to the prototype location
> >>
> >>  cmd/tlv_eeprom.c | 25 +++++++++----------------
> >>  common/board_r.c |  8 ++++++++
> >>  include/init.h   | 14 ++++++++++++++
> >>  3 files changed, 31 insertions(+), 16 deletions(-)
> >
> >Can you please use events for this? Something like EVT_SETTINGS_R ?
> >
> >See the one recently added for how to do this:
> >
> >INITCALL_EVENT(EVT_LAST_STAGE_INIT),
>
> I like this approach, but just to be clear with your intention - you
> want me to move both serial_read_from_eeprom AND mac_read_from_eeprom
> into a separate function, defined for each affected board? To do this
> for mac_read_from_eeprom becomes slightly cumbersome, because there are
> this many of them, depending on the current scheme:
>
> $ grep -r "ID_EEPROM" ./configs/ | wc -l
> 55
>
> If each of them needs to contain something like this:
>
> >static int settings_r(void)
> >{
> >#if defined(CONFIG_ID_EEPROM)
> >       mac_read_from_eeprom();
> >#endif
> >       return 0;
> >}
> >EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
>
> then this strays very far from the original intention of this series,
> which is to add support for a single board :)
> Unless you only care about serial_read_from_eeprom, then I don't need to
> modify any of the existing boards.

As per irc, you don't need to adjust the mac_read_from_eeprom(). Just
start your own thing (read_settings() or whatever) - i.e. don't make
it any worse. People do appreciate cleanup, but sometimes it can be a
big task

Regards,
Simon
