Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA0C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B0E877FD;
	Tue,  9 Jan 2024 15:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vXmOEfhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0863B877FA; Tue,  9 Jan 2024 15:31:36 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DDF87913
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e4d515c9aso12544295e9.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704810690; x=1705415490;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kker+PIiq+Nofl+8caWFJqri0zcbNyjYh1XiPmSjXUY=;
 b=vXmOEfhzUWoFY8yNxQaypDpdmOVQMypLASsFxHPSKtefipJabqDBzDZfxkZhtyhpFg
 MQ48Hal5iyLAivySnufknBB/Ko85gAq0nHBL9y3hr38471J1yAR5e0+6o4ye0Qtv0eaj
 d9xalBQ4jXcDtFhjRjGk0VNDEAGmtRkzjWM6dX0+GW5djNOxLK3wbVObkCqhlKuUdX96
 ycMpMfR8tL958bdNPV1+pdsTvLJ6QR8m+gX6SZa3BUUcXn3zp4SDjEWV9W5Nbsa4c/aC
 DT8dilb3UuCTo+E++youCIFBkTnD+td9LJe0amQwYlmaUqsliJsmErUrKERbde9Cm6me
 DgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810690; x=1705415490;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kker+PIiq+Nofl+8caWFJqri0zcbNyjYh1XiPmSjXUY=;
 b=er5i1lskJiqCP7Xaw4J0CxukftDSaGNPvxvJ2C/KmLGdAoOlICZQxGlzFq+hNbw69/
 Wj57t3BbWeiSLbAmV0qqgEzXPJrmbsNPYloISyIhyyMofa9lVRNROKK7i09VhJOIFRpm
 QvIA41JAzoLJ9Y7ng2vaCXy5OhlrKrqoKhKwvykDiq5bAoIadtqn1yaDYhaR3mcL/bZ3
 Gckvz6DEx+um63VHrseEi/R+OLHUcidEl81KIi5pG3Ltej8VCP5T75b46Pdqp+ZqHZ7u
 KVMsn3OC+tQCrGt2seupdvgYi5JQIdwzVKJEVVgF4FHXlVx20b5WKn+EgO0hKfwpYder
 gV6A==
X-Gm-Message-State: AOJu0Yx56/0clIxX9BmXRxVJ2IPqu/LO+ZThrRLQDarlBtKlY5zuUTXR
 v6ELJ8hFN25prmqK0NU13C9ewa4y/K8DtA==
X-Google-Smtp-Source: AGHT+IFjob2c9cSOxxHRhsd2j8Ho6CIbgNXLGIVA7YpK84az1XnUjKtL7q9e8/JbTqihgf64T+wFjA==
X-Received: by 2002:a05:600c:3781:b0:40e:4daf:b748 with SMTP id
 o1-20020a05600c378100b0040e4dafb748mr768529wmr.115.1704810690195; 
 Tue, 09 Jan 2024 06:31:30 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c511700b0040c6d559490sm3855975wms.3.2024.01.09.06.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:31:29 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Bin Meng
 <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, Sean Anderson
 <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>, Dmitrii Merkurev
 <dimorinny@google.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v7 7/7] test: hush: dollar: fix bagous behavior
In-Reply-To: <9C50D347-1560-4B8E-B2E3-63EBF243AE3C@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
 <20240105072212.6615-8-clamor95@gmail.com> <87le8ywr1j.fsf@baylibre.com>
 <9C50D347-1560-4B8E-B2E3-63EBF243AE3C@gmail.com>
Date: Tue, 09 Jan 2024 15:31:28 +0100
Message-ID: <87cyuawpbz.fsf@baylibre.com>
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

Hi Svyatoslav,

On mar., janv. 09, 2024 at 15:57, Svyatoslav <clamor95@gmail.com> wrote:

> 9 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 15:54:32 GMT+02:00,=
 Mattijs Korpershoek <mkorpershoek@baylibre.com> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>>Hi Svyatoslav,
>>
>>Thank you for the patch.
>>
>>On ven., janv. 05, 2024 at 09:22, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
>>
>>> From: Ion Agorria <ion@agorria.com>
>>>
>>> The dollar test was merged with bagous console behavior, and
>>> instead of fixing it, this behavior was just workarounded.
>>>
>>> It seems like without the fix the ut_assert_skipline(); didn't clear
>>> console and running ut_assert_skipline(); many times would give always
>>> OK. With
>>>
>>> lib: membuff: fix readline not returning line in case of overflow
>>>
>>> the line is cleared correctly and next assert fails because now there
>>> is nothing to clean which is correct if we look the this a bit above
>>> the failing assert:
>>>
>>>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>>          /*
>>>           * For some strange reasons, the console is not empty after
>>>           * running above command.
>>>           * So, we reset it to not have side effects for other tests.
>>>           */
>>>          console_record_reset_enable();
>>>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>>          ut_assert_console_end();
>>>     }
>>>
>>> Which further confirms that tests workaround the old problem and now
>>> that problem is fixed we can remove the whole if blocks and simply
>>> place ut_assert_console_end() right after ut_assert_skipline() without
>>> any conditional and will pass green.
>>>
>>> So this part of code goes from:
>>>     ut_assert_skipline();
>>>     ut_assert_skipline();
>>>
>>>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>>         /* See above comments. */
>>>         console_record_reset_enable();
>>>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>>         ut_assert_console_end();
>>>     }
>>>
>>> to become:
>>>     ut_assert_skipline();
>>>     ut_assert_console_end();
>>>
>>> Same thing should be done with the if block mentioned above that calls
>>> console_record_reset_enable().
>>>
>>> Signed-off-by: Ion Agorria <ion@agorria.com>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>
>>I confirm this fixes the problem reported in:
>>https://lore.kernel.org/all/87wmspm9e5.fsf@baylibre.com/
>>
>>Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>>The commit message is a bit long, but I don't mind it staying this way.
>>
>>Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>
> Thanks! Commit title might have a typo. Not "bagous" but "bugous" should =
be correct. May you adjust on pick if not too hard?

Yes, will update while picking up.

>
>>> ---
>>>  test/hush/dollar.c | 23 +++--------------------
>>>  1 file changed, 3 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/test/hush/dollar.c b/test/hush/dollar.c
>>> index 4caa07c192..68d0874d90 100644
>>> --- a/test/hush/dollar.c
>>> +++ b/test/hush/dollar.c
>>> @@ -53,29 +53,12 @@ static int hush_test_simple_dollar(struct unit_test=
_state *uts)
>>>  	ut_asserteq(1, run_command("dollar_foo=3D'bar quux", 0));
>>>  	/* Next line contains error message */
>>>  	ut_assert_skipline();
>>> -
>>> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>> -		/*
>>> -		 * For some strange reasons, the console is not empty after
>>> -		 * running above command.
>>> -		 * So, we reset it to not have side effects for other tests.
>>> -		 */
>>> -		console_record_reset_enable();
>>> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>> -		ut_assert_console_end();
>>> -	}
>>> +	ut_assert_console_end();
>>>=20=20
>>>  	ut_asserteq(1, run_command("dollar_foo=3Dbar quux\"", 0));
>>> -	/* Two next lines contain error message */
>>> -	ut_assert_skipline();
>>> +	/* Next line contains error message */
>>>  	ut_assert_skipline();
>>> -
>>> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>> -		/* See above comments. */
>>> -		console_record_reset_enable();
>>> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>> -		ut_assert_console_end();
>>> -	}
>>> +	ut_assert_console_end();
>>>=20=20
>>>  	ut_assertok(run_command("dollar_foo=3D'bar \"quux'", 0));
>>>=20=20
>>> --=20
>>> 2.40.1
