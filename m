Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED860C3ABB9
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 21:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E8382102;
	Mon,  5 May 2025 23:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="spvgXBIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A7E8210A; Mon,  5 May 2025 23:15:36 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC1E820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-476a720e806so47612971cf.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746479732; x=1747084532; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgIhRZT4NxHWdH0XYnXkFxMrrClMZuOMZclDzPNIWy8=;
 b=spvgXBISrLeWHJNWA0x8a384X2/CfztTj8k6f+tpqPljj4sjhSXN5QhDbWeQX8KwDS
 n4eOg2J2pkEecUUZLvQ3DBPykALUbITv1et7x/GvzOof77xXqwbUtEn/fpCmc7yJbjv7
 lxlu5U7RD+M5SEdt/Tke7s1C9GF7eFmYraSSKWoPXAt5cmuNXD30pmU1lzZ3L0OIahMc
 6trjepIm3Yhg3COI4XUI3K5M80htHOvtqFdhk/7jEW4xtgsFfYZfLvKd3k6Qe5BO2Kbz
 ZXo7kE+KvODeHqodv8tlCMcF7Hgz2uRGzJOLAJWmYr1a1UQLef8Xll/i0cmzOQllW1Tb
 s+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746479732; x=1747084532;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WgIhRZT4NxHWdH0XYnXkFxMrrClMZuOMZclDzPNIWy8=;
 b=fNNV6g2XLnp0Om1tuNdYqzTXrhUKfV0yJggQq19nxGbzMNga2xU40vUssTLcPsFkrx
 YAsHq+nkwe5C5FmC4aZn/j1tT8DRbGOcRBmfeqafZyj5OOyHXhxy3njSWYQSHabgfAxx
 dAacbddfYGUnLVbDKZap5dIzgOd+nrye0Vs1xKAMWnIqdgt/JwS1/deeo+XY8LV7k0qB
 mj9xVrGo+zH9fWpVkGFnTe5Nc4IyxyzQ7xo+hLc2PiyrW08/TWmUdvqFf52/+jv+1kVQ
 Yfkr80H53DmxTSDXURcwBVy8gQJp2UVYK7b+uxG6ZyTZm2/wMvPcNZaiq31zSidUAHGV
 Fytw==
X-Gm-Message-State: AOJu0YxB7Pwxq6ter6DZGTPfmPuCcuB9likWxWKIoEyOeHlxBX9YIMdX
 k0V5uDiGk65oXmtdCYlLlnw39WHEIet0J/e4x4cxmcLYWvHpSjzdcCeH6NIbGEE=
X-Gm-Gg: ASbGncsfwPZBlIYTuSqSXQvb1K6AJeZ1Vdb3V1nEZYCkECzYqkhVwzEf93v/NPZlIBW
 zojBbQ/iGbocwIG2aBlcuTkuUihxZLOhF161q/PCnN6jeT+Yq1tcv41yzJfHrmgqsNzK4aOcPaJ
 gFK5Blam/vbadh2YXWimVh+XWmgieT2w9Tlt9N+hyasGiQoMp5hmG8VKKFo1rhw84NRkxSPUUvi
 2cLv2vmhYV/nWSv/S98odOvVE3dfJh4uTvqH9P2zV+8uD3UxXPwtjcZykWjqS92Db6cY5929vLs
 LqO58tz67Xx42F5+QMQlLzgKUZCwyY47oqYbIyANB/3OCpsW/cBZlaQ/xlws3y/dwODiXM+nOiH
 MHNYSN5u+l6/ndE7B7L3Wodlxi8AhLItSkwlcU4K6v+c=
X-Google-Smtp-Source: AGHT+IFSFM4JXr8stD7MOcOkVzK1wBolJjo69g5H7rKS9aqqlSNQHqoRFpTeInXBrKbaX1IKxttxjQ==
X-Received: by 2002:a05:622a:607:b0:48d:4e98:2a9 with SMTP id
 d75a77b69052e-48d4e9802f9mr132049021cf.12.1746479732469; 
 Mon, 05 May 2025 14:15:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b987229c1sm62091681cf.59.2025.05.05.14.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:15:32 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id AC4461200078;
 Mon,  5 May 2025 17:15:31 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
 by phl-compute-05.internal (MEProxy); Mon, 05 May 2025 17:15:31 -0400
X-ME-Sender: <xms:cyoZaD0ixI7eYlc7UdblRJQ-bh-MrOZCyrfZD2ppGZUk7MzWQg5L8Q>
 <xme:cyoZaCF-d77cuo4pjHSVTVn9CIjk0pCxkdFA5GjvRhzatljfiLYbiM8RaFSF-iTyy
 YYD263X0R9F3jZjV9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvudehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cyoZaD6y_k_ch23_TDi0gfT7zB2aaFnDUwQW9O_a6qDiMGoHirNzzA>
 <xmx:cyoZaI0EoT0oE0QguCFLo3B2FoiTPkxVJ9Su58Ih2Kr-nFq01Iw1sQ>
 <xmx:cyoZaGFi5Zu6LOI5vyn2sD6DrA1f5L56jToEK19L4gWBhgCFkztICw>
 <xmx:cyoZaJ-lYMcsSOUrIHL60L0Ykju4hw3cnedKIlzvyzHS3uopd0FXow>
 <xmx:cyoZaDnwJLyOwMb-S4EOi-tToMjQIPMTv6h84GiqpEz8DxwzvAkAt4oj>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 88772780069; Mon,  5 May 2025 17:15:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T559dd0f43c50e086
Date: Mon, 05 May 2025 15:14:13 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Message-Id: <10b358df-35fc-4d7a-802f-f38bbc9220ac@app.fastmail.com>
In-Reply-To: <20250505210817.GN5430@bill-the-cat>
References: <20250505205052.347616-1-javier.tia@linaro.org>
 <20250505210817.GN5430@bill-the-cat>
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

On Mon, May 5, 2025, at 3:08 PM, Tom Rini wrote:
> On Mon, May 05, 2025 at 02:50:51PM -0600, Javier Tia wrote:
>
>> It solves the following error:
>>=20
>> =E2=9D=AF ./test/py/test.py --bd sandbox --build
>> +make O=3D/u-boot/build-sandbox -s sandbox_defconfig
>> +make O=3D/u-boot/build-sandbox -s -j32
>> Traceback (most recent call last):
>>   File "/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line=
 23, in <module>
>>     from setuptools import setup, Extension
>> ModuleNotFoundError: No module named 'setuptools
>>=20
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> ---
>>  test/py/requirements.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> This is the wrong place. You can't build U-Boot without
> python3-setuptools being available, so it's part of the implicit or
> explicit dependencies in doc/build/gcc.rst. I believe for Ubuntu/etc
> it's implicit but should likely be explicit.

What about the use case where you just want to run the U-Boot CI tests?

I found this problem just following the documentation at https://docs.u-=
boot.org/en/latest/develop/py_testing.html.

$ cd /path/to/u-boot
$ python3 -m venv venv
$ . ./venv/bin/activate
$ pip install -r test/py/requirements.txt
$ make mrproper
$ ./test/py/test.py --bd sandbox --build

--=20
=C2=BB Javier Tia =E2=9C=8D
