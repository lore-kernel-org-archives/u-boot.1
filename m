Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29D3E7B60D
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE7087535;
	Wed,  4 Oct 2023 14:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="IxGilPak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA4B87533; Wed,  4 Oct 2023 14:47:43 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336628750A
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50567477b29so2478957e87.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696423660; x=1697028460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Faz3Z+9or5KCxHY8WyDA5sEpJHKc6ATNyg06AnOVF6A=;
 b=IxGilPakS2kwQDs7lo3L3IXZ4LW5W6VkpLvuZYxsTl9o9jvXTyYPMjmdo2FdKNuMBR
 yuasAnTn9Is/VSh9ZwQsZPdMQ3VmsBDxyflkY6YxHMZLXukIizvtM3l4omhiqDtQMNO2
 ooTuNfcIdNT2JqBlNE4VmO5Q3H3t/kFIDpLtyStFhB26FS65yL1tdePRrs0iP/pnEDSn
 wCpndI5g2cGtq4cmex4+AEYiNtpXjny3b1pBc6kLiAheoJDLaKMH03TV2MY3erKkBRZO
 h93FWfeLQ1EWGND9hF6F49iNf3VDLpOAS+6aSa/4WGxj11kMVO7Xf/b7FddmiHaVJzoH
 S0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696423660; x=1697028460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Faz3Z+9or5KCxHY8WyDA5sEpJHKc6ATNyg06AnOVF6A=;
 b=ry9g8HYDm8xSfqR6oDNt4TAT9HJO8/5YKJbRvLgtv0jDWAvUCM8zukkQ2paL3LoqMy
 HqdR+/sgBSa2tQ7VcjUTgkZPT3oxM65tKYHvwYnhgLJ+vPozB4+FDR1zszNJQ1oEXqvx
 10WtJQHMZueI/W4yM0qkIcMmuulvoyACX4LKC0slTkI01rnAaTLa8x7nJAJ+dtXYwZQ8
 MyOFtc5rgoqMNmcYSCsczYhLKVFE3txM8RNWjpPyAlbxsSLpwEUKuYausWfTtP8TJj08
 PTAluEp0LLXi7VTQ5j7X03w3nigFLcGRk21rv3n+FDPdmXgAPS21vNxLgPgrRIFktsAT
 pE7Q==
X-Gm-Message-State: AOJu0Ywt877NZM+yrS1CGnBjEfBoNFA4OVyiyokPUF3l8qBz6x6Nd7UR
 knq138iBbl43ExCjpE7ypDAokw==
X-Google-Smtp-Source: AGHT+IHXa7fisBTIO305gSez+qIvzcLV63TyH03bXnOB4IloyAeYrVDkb4ZxtyTelAkFYcCSxexprQ==
X-Received: by 2002:a05:6512:68a:b0:502:d743:9fc4 with SMTP id
 t10-20020a056512068a00b00502d7439fc4mr2064205lfe.37.1696423660071; 
 Wed, 04 Oct 2023 05:47:40 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 t9-20020a19ad09000000b005047bf13b67sm586102lfc.153.2023.10.04.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:47:39 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: sjg@chromium.org
Cc: artur@conclusive.pl, eugen.hristev@collabora.com, jakub@conclusive.pl,
 marcin@conclusive.pl, radoslaw.adamczyk@conclusive.pl,
 u-boot@lists.denx.de, wojciech@conclusive.pl
Subject: Re: [PATCH v3 1/4] common: Add generic function for reading serial
 number
Date: Wed,  4 Oct 2023 14:47:34 +0200
Message-ID: <20231004124734.215105-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAPnjgZ2E7LgCovBqKv4eWrPcYPNS9JfYYfBpaQ+fLV1MFs+EWA@mail.gmail.com>
References: <CAPnjgZ2E7LgCovBqKv4eWrPcYPNS9JfYYfBpaQ+fLV1MFs+EWA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

>Hi Artur,
>
>On Mon, 2 Oct 2023 at 06:42, Artur Rojek <artur@conclusive.pl> wrote:
>>
>> Provide a generic way for boards to read their serial number from EEPROM
>> at init.
>>
>> If CONFIG_ID_EEPROM is set, the new serial_read_from_eeprom() function
>> will now be called during the post-relocation part of the board init.
>>
>> Provided is the tlv eeprom implementation of the above function, making
>> use of the existing, yet never utilized, populate_serial_number().
>> Boards which use custom logic for interaction with their EEPROMs need to
>> supply their own implementation.
>>
>> Signed-off-by: Artur Rojek <artur@conclusive.pl>
>> ---
>>
>> v3: - restore original function name and make it static
>>     - provide a generic function for reading EEPROM serial number and
>>       wrap it around the existing tlv logic
>>     - move the env var check out of populate_serial_number() and into
>>       the new serial_read_from_eeprom() in order to stay consistent with
>>       the documentation
>>
>> v2: - rename the function
>>     - move function documentation from .c file to the prototype location
>>
>>  cmd/tlv_eeprom.c | 25 +++++++++----------------
>>  common/board_r.c |  8 ++++++++
>>  include/init.h   | 14 ++++++++++++++
>>  3 files changed, 31 insertions(+), 16 deletions(-)
>
>Can you please use events for this? Something like EVT_SETTINGS_R ?
>
>See the one recently added for how to do this:
>
>INITCALL_EVENT(EVT_LAST_STAGE_INIT),

I like this approach, but just to be clear with your intention - you
want me to move both serial_read_from_eeprom AND mac_read_from_eeprom
into a separate function, defined for each affected board? To do this
for mac_read_from_eeprom becomes slightly cumbersome, because there are
this many of them, depending on the current scheme:

$ grep -r "ID_EEPROM" ./configs/ | wc -l
55

If each of them needs to contain something like this:

>static int settings_r(void)
>{
>#if defined(CONFIG_ID_EEPROM)
>       mac_read_from_eeprom();
>#endif
>       return 0;
>}
>EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);

then this strays very far from the original intention of this series,
which is to add support for a single board :)
Unless you only care about serial_read_from_eeprom, then I don't need to
modify any of the existing boards.

Cheers,
Artur

>
>Regards,
>Simon
