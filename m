Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E92AC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0C0878E1;
	Tue,  9 Jan 2024 14:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6XveI0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07D7878CF; Tue,  9 Jan 2024 14:58:00 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88665878E3
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50eabd1c701so3585133e87.3
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704808678; x=1705413478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rOMEQ7eRFZL/tkmu1Ud5XAeie8DMfMAsbZTeSyF4Bu0=;
 b=b6XveI0eTArAL+XZKbia3SFB5rYwjAfPs3J48YTOCoHv7Zvw8yU99UmHvAyeVQn9Fb
 b/E2oxYvuhwfa+6qzGhjkQQNJyIQ6E1cJVRkp3JDgrB6j3g/cHiI4OzXkiu/nB8hRYGy
 S9IFJtUDw03YyFvkU+IM1O5nWGYvv1P9LoRlUoX5Rx23cNcCLy32qsTSe4TmQihXWlJ+
 WUc5igEpHH0ovnS7EJ2C7hlcU0MeYhFxexgBb0WIAvjr8FKqUMg+7vsGQjfog6qgqvnX
 sI0w5SclFDYv0r8ZuYuZ1g7ZlxQkEkZ+9a7ePGQuIggY61vwRlU3pZjSkp3gmRDh8sXx
 IU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704808678; x=1705413478;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rOMEQ7eRFZL/tkmu1Ud5XAeie8DMfMAsbZTeSyF4Bu0=;
 b=Q3f9G4/7WlY75kOmyXC+iPSxYWsbCylMWTJ+aCldlgHJGGa7jOVoyq66lg3JHsVwa1
 5mzrmgtNs0vUycLbo0emY9wZdGFniU2OBT93b8mUG6WpECHZ1LvTi6G0WYPJFF8/Szj6
 Iy9UCP2RIzeIc46I3BICOOO3ltNObHVK1/fveUqxSXjVfEpjlsAysD7MwVwpq/5ryi3R
 HzNvhmPcqHm3xlYsIeiZ4Oi3ig8vcmp1QnVunqLjL4KEkkf4NiSM2f+mjITRmZnE4rPI
 LaGdGkFsYWr1MNP4lFzEY3lfeKMZmspfAOW00lLD54WfG3Thy8tWLzJWpONYyuHqQ5ew
 Igtw==
X-Gm-Message-State: AOJu0YwPDGLa9zir4Jqfnkr+WebR3YLdEA7OjPsDjQRbZtKjJN1ypvng
 WA9RiqbHoWXY/cYVg7QCUYc=
X-Google-Smtp-Source: AGHT+IGbA2i0ZuJJgK7NnlQFPwtWICTiTZqSIDYgdHSdkivgpueznkz9r6yy3vYWiBelXt8w1grxhg==
X-Received: by 2002:ac2:4839:0:b0:50e:5a6a:a6cb with SMTP id
 25-20020ac24839000000b0050e5a6aa6cbmr2193492lft.122.1704808677445; 
 Tue, 09 Jan 2024 05:57:57 -0800 (PST)
Received: from [127.0.0.1] ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a23-20020a17090640d700b00a2a9dddb308sm1053590ejk.121.2024.01.09.05.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 05:57:57 -0800 (PST)
Date: Tue, 09 Jan 2024 15:57:57 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v7 7/7] test: hush: dollar: fix bagous behavior
User-Agent: K-9 Mail for Android
In-Reply-To: <87le8ywr1j.fsf@baylibre.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
 <20240105072212.6615-8-clamor95@gmail.com> <87le8ywr1j.fsf@baylibre.com>
Message-ID: <9C50D347-1560-4B8E-B2E3-63EBF243AE3C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



9 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 15:54:32 GMT+02:00=
, Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom> =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>Hi Svyatoslav,
>
>Thank you for the patch=2E
>
>On ven=2E, janv=2E 05, 2024 at 09:22, Svyatoslav Ryhel <clamor95@gmail=2E=
com> wrote:
>
>> From: Ion Agorria <ion@agorria=2Ecom>
>>
>> The dollar test was merged with bagous console behavior, and
>> instead of fixing it, this behavior was just workarounded=2E
>>
>> It seems like without the fix the ut_assert_skipline(); didn't clear
>> console and running ut_assert_skipline(); many times would give always
>> OK=2E With
>>
>> lib: membuff: fix readline not returning line in case of overflow
>>
>> the line is cleared correctly and next assert fails because now there
>> is nothing to clean which is correct if we look the this a bit above
>> the failing assert:
>>
>>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>          /*
>>           * For some strange reasons, the console is not empty after
>>           * running above command=2E
>>           * So, we reset it to not have side effects for other tests=2E
>>           */
>>          console_record_reset_enable();
>>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>          ut_assert_console_end();
>>     }
>>
>> Which further confirms that tests workaround the old problem and now
>> that problem is fixed we can remove the whole if blocks and simply
>> place ut_assert_console_end() right after ut_assert_skipline() without
>> any conditional and will pass green=2E
>>
>> So this part of code goes from:
>>     ut_assert_skipline();
>>     ut_assert_skipline();
>>
>>     if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>>         /* See above comments=2E */
>>         console_record_reset_enable();
>>     } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>>         ut_assert_console_end();
>>     }
>>
>> to become:
>>     ut_assert_skipline();
>>     ut_assert_console_end();
>>
>> Same thing should be done with the if block mentioned above that calls
>> console_record_reset_enable()=2E
>>
>> Signed-off-by: Ion Agorria <ion@agorria=2Ecom>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>
>I confirm this fixes the problem reported in:
>https://lore=2Ekernel=2Eorg/all/87wmspm9e5=2Efsf@baylibre=2Ecom/
>
>Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom>
>
>The commit message is a bit long, but I don't mind it staying this way=2E
>
>Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre=2Ecom>
>

Thanks! Commit title might have a typo=2E Not "bagous" but "bugous" should=
 be correct=2E May you adjust on pick if not too hard?

>> ---
>>  test/hush/dollar=2Ec | 23 +++--------------------
>>  1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/test/hush/dollar=2Ec b/test/hush/dollar=2Ec
>> index 4caa07c192=2E=2E68d0874d90 100644
>> --- a/test/hush/dollar=2Ec
>> +++ b/test/hush/dollar=2Ec
>> @@ -53,29 +53,12 @@ static int hush_test_simple_dollar(struct unit_test=
_state *uts)
>>  	ut_asserteq(1, run_command("dollar_foo=3D'bar quux", 0));
>>  	/* Next line contains error message */
>>  	ut_assert_skipline();
>> -
>> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>> -		/*
>> -		 * For some strange reasons, the console is not empty after
>> -		 * running above command=2E
>> -		 * So, we reset it to not have side effects for other tests=2E
>> -		 */
>> -		console_record_reset_enable();
>> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>> -		ut_assert_console_end();
>> -	}
>> +	ut_assert_console_end();
>> =20
>>  	ut_asserteq(1, run_command("dollar_foo=3Dbar quux\"", 0));
>> -	/* Two next lines contain error message */
>> -	ut_assert_skipline();
>> +	/* Next line contains error message */
>>  	ut_assert_skipline();
>> -
>> -	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
>> -		/* See above comments=2E */
>> -		console_record_reset_enable();
>> -	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
>> -		ut_assert_console_end();
>> -	}
>> +	ut_assert_console_end();
>> =20
>>  	ut_assertok(run_command("dollar_foo=3D'bar \"quux'", 0));
>> =20
>> --=20
>> 2=2E40=2E1
