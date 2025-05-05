Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFF2C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 21:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D9282102;
	Mon,  5 May 2025 23:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gmmCUf5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B76D48210D; Mon,  5 May 2025 23:40:49 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 281BC820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e8f7019422so51218946d6.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746481246; x=1747086046; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgkgVl2ff1xknt26gzWgPkxJaAId9t+D2dsJ5oeqQow=;
 b=gmmCUf5NjHDOfLz0e6suhSPEzJT+C4awEnTT4H+BvVjTzPVJXD74i8+Nw+V+i36k5S
 ssXAjlguh/4ypWbvtpFGZY1KKZyHDxlLe0llYBqAmZT3KV9Mot4ZDE3GW5fy2FNrFbob
 htssWBx9gKnXVz8wCmBrfVmN0cMxXBc6p5Xbqwd0FuqnqZa6lqXgZL1/ZGNrwuJ7lANM
 pdVbto34k/Pp27X5/gUsjjbwzoqmbqjUXK7pb81J5zY5Trjp4FWs7MnqRl/a2dxk7RPj
 /VAcOb3dtCW2bVbZiPKIAPaTDlBJm9dCvMiWuC/lJH+u5ZASUEJ8S8aq1Ve0H7urjJ4c
 YLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746481246; x=1747086046;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kgkgVl2ff1xknt26gzWgPkxJaAId9t+D2dsJ5oeqQow=;
 b=IW92rQOosmfPSyfGy6LCRAYIC6OFywyxCctQ64dmqtc+vcx7RJV+keXH9BFBuvQIYy
 eRt0r2h1PHx9GL4eb4ncrOhjH8RNxfUqnRcXQ4IFcsiLkQfCn4yVKOkcMwph/jzVlY8i
 +xIOw6wccqfxJdMS8LI8MHVISpzJEqLLimwoWKmHmqHmVsqAf+DBSxvC+nLiuTFcp4bW
 l3+h5MndGlyrI+zmj9hl82p2TDwcyoSL12rasJ8iYdzlJvSH/6sNKtG9Nktr6+MdqYlb
 LYNeQrCK54qsPc5FXoKgsLTdK7XjxUKorSgbWQANRZvt/cHpVF4V5e8JV191sVTt7LeL
 D1Zw==
X-Gm-Message-State: AOJu0YxiEjgwKmd/IwYtLYiPXBoKeYB1IYNg9VkIVJ17gww3lGic/eoL
 uhLD/UvpBXOclDMh+Ny30svvTa4RzsJv++Wn6lDkGzJfz1jN69xIcVtCQJH3zqkNYjkZx8mQ4UQ
 V
X-Gm-Gg: ASbGncvwstw/qDsgp8vhppR5nDTwleb+cILQhtWG7AFrP9ctjUTCkEP3uN9uOvhsPcx
 8boacRi+bgdukGAqCXGwGa7vc9U6P0BZ5xl/1h9EdCCUHIhcwdeM0xYTFmwi4PeiQQ81Qr8urXn
 G8qCFfVEVuZjXLdRok/s2qUVyNHBKWaCpY+oLdBT3Njgux/ZEBlojAvUQleBRbLZn89GnpVhsVg
 mUbPquouJV/OOMTjLqWHNkapRK8WRAa8X/OAjRmG+Wr+nNt/wyM5U0CXbz+mGZ9/Zwspxm/tN1o
 W8p0YDHnA8Wugp6JB4fi9Gi9wcPDiKFdbeDctwpb+CLkM5/i6LeAqFUFnv5redjZhBYRIrPAnxK
 mSGpHvcnZPNzkKaoFXjmD6sIr9pAOqjes
X-Google-Smtp-Source: AGHT+IHwZYZ4ga2RWFF1RYBQ/pdpsHngwIedXOumBegbDoGCJ1FGBkCdDtazG4JCYiDRbHYnKASS9g==
X-Received: by 2002:a05:6214:f6e:b0:6f4:b757:d45f with SMTP id
 6a1803df08f44-6f5353ed1admr14875136d6.20.1746481246029; 
 Mon, 05 May 2025 14:40:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f50f3b070asm60886686d6.10.2025.05.05.14.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:40:45 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfauth.phl.internal (Postfix) with ESMTP id 68D3A120006A;
 Mon,  5 May 2025 17:40:45 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-03.internal (MEProxy); Mon, 05 May 2025 17:40:45 -0400
X-ME-Sender: <xms:XTAZaLssOedjCETQYhprXz9rQAOCsc5HcbadwghRHJwWzBF-m2tZDQ>
 <xme:XTAZaMcp4n-xDF3jPhoo-BgeA688zt0T2oCAYjBQH9UyTiz1v3Lk5KmkggEJQ9k0g
 kvCz9SOlUg6izPz-FM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
 tdejnecuhfhrohhmpedflfgrvhhivghrucfvihgrfdcuoehjrghvihgvrhdrthhirgeslh
 hinhgrrhhordhorhhgqeenucggtffrrghtthgvrhhnpeegtdevtedvffethefhgfegueev
 udeiieevffetkedvgfejueelheffhfegkefggfenucffohhmrghinhepuhdqsghoohhtrd
 horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 jhgrvhhivghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduhedvkeekle
 ehkeefqdefudefieegvdeliedqjhgrvhhivghrrdhtihgrpeeplhhinhgrrhhordhorhhg
 sehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehilhhi
 rghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhdqsg
 hoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:XTAZaOzrqLEawrd5bKIlP7PEq9EB2XIcDgRt3j5a_IIazfreSWOVfw>
 <xmx:XTAZaKPnVdPqTaDSNlny87cW5tUYwfZ_tJ-in8ghx7fLJdAHYzq-zw>
 <xmx:XTAZaL_WN0rvC6ktYr4_1oc70kvv2aIIcdi70W_k1IEufgM7LwJ_2Q>
 <xmx:XTAZaKWlsN-S6iLJeSmXwtN_S5xEie3lDMmtdBjeFLDhSbooen2I9g>
 <xmx:XTAZaMdWwi_-dwsdchlmq8BpqjHgGkLuvzILLqwXd1fErCO5smM8o0om>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 43993780069; Mon,  5 May 2025 17:40:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T559dd0f43c50e086
Date: Mon, 05 May 2025 15:40:11 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <d6893e00-1dff-440b-9bc6-d0ad956e9bd8@app.fastmail.com>
In-Reply-To: <20250505212700.GO5430@bill-the-cat>
References: <20250505205052.347616-1-javier.tia@linaro.org>
 <20250505210817.GN5430@bill-the-cat>
 <10b358df-35fc-4d7a-802f-f38bbc9220ac@app.fastmail.com>
 <20250505212700.GO5430@bill-the-cat>
Subject: Re: [PATCH] test: Add setuptools to test requirements.txt
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

Hi Tom,

On Mon, May 5, 2025, at 3:27 PM, Tom Rini wrote:
> On Mon, May 05, 2025 at 03:14:13PM -0600, Javier Tia wrote:
>> Hi Tom,
>>=20
>> On Mon, May 5, 2025, at 3:08 PM, Tom Rini wrote:
>> > On Mon, May 05, 2025 at 02:50:51PM -0600, Javier Tia wrote:
>> >
>> >> It solves the following error:
>> >>=20
>> >> =E2=9D=AF ./test/py/test.py --bd sandbox --build
>> >> +make O=3D/u-boot/build-sandbox -s sandbox_defconfig
>> >> +make O=3D/u-boot/build-sandbox -s -j32
>> >> Traceback (most recent call last):
>> >>   File "/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", l=
ine 23, in <module>
>> >>     from setuptools import setup, Extension
>> >> ModuleNotFoundError: No module named 'setuptools
>> >>=20
>> >> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> >> ---
>> >>  test/py/requirements.txt | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >
>> > This is the wrong place. You can't build U-Boot without
>> > python3-setuptools being available, so it's part of the implicit or
>> > explicit dependencies in doc/build/gcc.rst. I believe for Ubuntu/etc
>> > it's implicit but should likely be explicit.
>>=20
>> What about the use case where you just want to run the U-Boot CI test=
s?
>
> You still have to have built U-Boot.
>
>> I found this problem just following the documentation at https://docs=
.u-boot.org/en/latest/develop/py_testing.html.
>>=20
>> $ cd /path/to/u-boot
>> $ python3 -m venv venv
>> $ . ./venv/bin/activate
>> $ pip install -r test/py/requirements.txt
>> $ make mrproper
>> $ ./test/py/test.py --bd sandbox --build
>
> Right, and the failure comes from not being able to build U-Boot. Part
> of commit 859621b47f9e ("python: Recreate test/py and tools/buildman
> requirements.txt files") was to remove the parts of
> test/py/requirements.txt that are not from the test/py suite, as it had
> become the location for any python module required, not the test suite.

Makes sense now. Thanks!

--=20
=C2=BB Javier Tia =E2=9C=8D
