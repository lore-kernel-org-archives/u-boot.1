Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77538C87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 13:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8787D83F58;
	Mon,  4 Aug 2025 15:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HqPJy/7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8BA83ED7; Mon,  4 Aug 2025 11:15:49 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8F483DF7
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 195C1205AF;
 Mon,  4 Aug 2025 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1754298945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAdl+ossrQXx6X2gUss35K4IbBGmL6WgyXYDQr4lGeA=;
 b=HqPJy/7Ks9cHWRlvC6/nwWEDg8UMr4NyKVrx1qYdr+cysm00NGpmSipOIfNj+VX5KgE7VG
 ocaDVF1uLeaWo4cQG+HsceFHFBcYmy45Y5N9VNz/CKV6nayC8qfMPQgXv5w3iYpPgUEecv
 HTzFw9uK4/7jkOYDHIK4LlK8V6L1yGirXSQ9j7t85onUDEtLfMs4t+WkU2sHPoTtBvOj4d
 gfHzzJMuY4KlPxaKGbQr0EKJaHztNWO/k/mfaTpNMK2kxCGl9XjEkSTL0atLI6Q1kMlpA9
 LiK+4+N/p4R1CqpZuEOHLofMc0+4ZnVfuei9Q5ls5VYTLweUIMPjn2hnPfedjQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,  Christian Marangi
 <ansuelsmth@gmail.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de,  Steam Lin <stlin2@winbond.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] cmd: mtd: Enable speed benchmarking
In-Reply-To: <CAOf5uwnju+Z4bY0Cx0fy05TOLtaQqikq3z51zqDf2nDgCzQyWw@mail.gmail.com>
 (Michael Nazzareno Trimarchi's message of "Thu, 3 Jul 2025 19:19:45
 +0200")
References: <20250703165841.1230515-1-miquel.raynal@bootlin.com>
 <CAOf5uwnju+Z4bY0Cx0fy05TOLtaQqikq3z51zqDf2nDgCzQyWw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 04 Aug 2025 11:15:44 +0200
Message-ID: <87wm7jjvlr.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepmhhitghhrggvlhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtoheprghnshhuvghlshhmthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgiihphhrohhnrdhglhhpkhesghhmgidruggvpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhto
 hepshhtlhhinhdvseifihhnsghonhgurdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Mon, 04 Aug 2025 15:06:58 +0200
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

Hello Michael,

>> MA35D1> mtd read nor0 0x81000000 0 0x10000
>> Reading 65536 byte(s) at offset 0x00000000
>> MA35D1> mtd read.benchmark nor0 0x81000000 0 0x10000
>> Reading 65536 byte(s) at offset 0x00000000
>> Read speed: 3752kiB/s
>>
>
> I was using time and reading but this looked much nicer. I will give it a=
 try
> and review.

Thanks! It turned out very useful for development purposes :-)

>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---

[...]

>> -       bool dump, read, raw, woob, write_empty_pages, has_pages =3D fal=
se;
>> +       bool dump, read, raw, woob, benchmark, write_empty_pages, has_pa=
ges =3D false;
>>         u64 start_off, off, len, remaining, default_len;
>>         struct mtd_oob_ops io_op =3D {};
>>         uint user_addr =3D 0, npages;
>> +       u32 bench_start, bench_end;
>
> unsigned long

Okay.

>>         const char *cmd =3D argv[0];
>>         struct mtd_info *mtd;
>>         u32 oob_len;
>> @@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>>         read =3D dump || !strncmp(cmd, "read", 4);
>>         raw =3D strstr(cmd, ".raw");
>>         woob =3D strstr(cmd, ".oob");
>> +       benchmark =3D strstr(cmd, ".benchmark");
>>         write_empty_pages =3D !has_pages || strstr(cmd, ".dontskipff");
>>
>>         argc -=3D 2;
>> @@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>>
>>         led_activity_blink();
>>
>> +       if (benchmark)
>> +               bench_start =3D timer_get_us();
>> +
>>         /* Loop over the pages to do the actual read/write */
>>         while (remaining) {
>>                 /* Skip the block if it is bad */
>> @@ -586,6 +592,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>>                 io_op.oobbuf +=3D io_op.oobretlen;
>>         }
>>
>> +       if (benchmark && bench_start) {
>> +               bench_end =3D timer_get_us();
>> +               printf("%s speed: %lukiB/s\n",
>> +                      read ? "Read" : "Write",
>> +                      ((io_op.len * 1000000) / (bench_end - bench_start=
)) / 1024);
>
> Did you check if it can not wrap?

That is a good question, if my calculations are correct, time capture
may wrap if one spends more than 1h12 in the Bootloader. So yes it is
'doable' to make the time overlap.

But is this relevant? It really is a development feature at the moment
(developers comparing speeds would notice the overlap) and Bootloaders
in general are not supposed to run for that long anyway. So I would
argue that it is acceptable like that.

Thanks,
Miqu=C3=A8l
