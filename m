Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2247DC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5F187A4B;
	Thu, 25 Jan 2024 15:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UeBqpT4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F1A87A80; Thu, 25 Jan 2024 15:50:30 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6B387A2A
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a33c91ca179so18957666b.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706194228; x=1706799028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SwRBxJPKU9Jqm2HiHuHM/swMv/INuvQ/CYWGMjjlnsw=;
 b=UeBqpT4+aZDHRCFwVVDVh7jErBbuhBlRmWJfU9RSBnHy6QkNDRe//SRvczvU6PbcEB
 3F4SszT/482cm5vMldc+aSvXkdmIpWhQ7KjhezXN8EWgLbDJbv6Hy9WbfQ1+LVD8BTCS
 txHywBrV2MajXzHE/CbVX03l0vrte9mcCO+wSoi/3Ztc/cLwlcFx8mU7b8UmWlC+TDs5
 lodhee1AG/XeKkZyNMvukedHZDjIJehgKn6knZAY9wN54YG6kmmipPaPQnkICQ/ATQcY
 wcJAMcQbE/UrC5sWptnB0pqlHVm3s/HpDqoPnlvULeejh87pW73xucqy4Or8DfDrHTnM
 aXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706194228; x=1706799028;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SwRBxJPKU9Jqm2HiHuHM/swMv/INuvQ/CYWGMjjlnsw=;
 b=SlihAkI2LHvCo+NQqGZ+h2/JE5TF6/G2axJsz7onYwH9+Qk5plOSaJKLJw20txm7dz
 qk83roSzgC9/oEpAajO+Ej+bAttK4ndfZY00YhmyhMzd5jon1VSOQ7n1rSRMVTf9XqSK
 47yqOjmUXDLzwlAhb60ZF9DfMF+3UBpXEQddNz4moona0ucq4Ij93jOlvsxwOcNfDUVx
 WE6zqqo63R1MOAp99lg66A4ucy9Mxhfw6apYVjZ+B24SLilDcKaEywYBh5pz2OEUzPuA
 FtQS6KTpoSSuHWDdxYf9HCYhEI+UCJboNUZ60Mj8NXLdDRgrcTdFzMhP37rsvdC5lXJG
 5x4w==
X-Gm-Message-State: AOJu0YzfCAej4Jv8gXqtGqHTWhKlNBIOtw2x/XoSQdLGga+F+10Zb9Yc
 WdcLnWYkLnsU836utUoYiW7P4pMLd/vrIKYVbM1pSvDFmtUEibl8
X-Google-Smtp-Source: AGHT+IHL4XjQGIVZUeBpHODqlvfGV05xj6+QuMTzeMRNYiolMnV16LvZ4c0ptj8mtfrLQHX46E+YuQ==
X-Received: by 2002:a17:907:168a:b0:a26:8f35:8bfd with SMTP id
 cx10-20020a170907168a00b00a268f358bfdmr737733ejd.50.1706194227839; 
 Thu, 25 Jan 2024 06:50:27 -0800 (PST)
Received: from [127.0.0.1] ([46.211.247.89]) by smtp.gmail.com with ESMTPSA id
 ub26-20020a170907c81a00b00a338fedb9ebsm176697ejc.54.2024.01.25.06.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 06:50:27 -0800 (PST)
Date: Thu, 25 Jan 2024 16:50:25 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
User-Agent: K-9 Mail for Android
In-Reply-To: <20240125144748.GL3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
 <20240125141236.GI3652023@bill-the-cat>
 <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
 <20240125141734.GK3652023@bill-the-cat>
 <F6B6FBCE-59E3-4334-8E24-4BF5C3C4D9B7@gmail.com>
 <20240125144748.GL3652023@bill-the-cat>
Message-ID: <F7CDF849-A0C3-489D-BF3C-875EC6F70216@gmail.com>
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



25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:47:48 GMT+02:0=
0, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>On Thu, Jan 25, 2024 at 04:34:41PM +0200, Svyatoslav wrote:
>>=20
>>=20
>> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:17:34 GMT+0=
2:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>> >On Thu, Jan 25, 2024 at 04:16:11PM +0200, Svyatoslav wrote:
>> >>=20
>> >>=20
>> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 16:12:36 GM=
T+02:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>> >> >On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
>> >> >>=20
>> >> >>=20
>> >> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 08:29:54=
 GMT+02:00, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg> =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >> >> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote=
:
>> >> >> >> Currently, if boot with extlinux=2Econf and do not set the fdt
>> >> >> >> U-Boot will provide its own device tree=2E This behavior is
>> >> >> >> beneficial if the U-Boot device tree is in sync with Linux,
>> >> >> >> but it totally halts the booting of pre-dtb kernels (3=2E4 for
>> >> >> >> example) since it uses ATAGs=2E To fix this, pass `-` in the
>> >> >> >> fdt extlinux field as a signal that no tree should be used=2E
>> >> >> >
>> >> >> >Passing - doesn't seem like the most intuitive thing=2E=2E=2E  I=
s there a
>> >> >> >different argument we could use?
>> >> >> >
>> >> >>=20
>> >> >> I agree that `-` is not the most intuitive argument,
>> >> >> but this is a way to implement a fix with the least
>> >> >> code posssible=2E To make this less obscure I have
>> >> >> adjusted documentation=2E=20
>> >> >
>> >> >It's also how historically we do similar things=2E eg, "bootm
>> >> >$kernel_addr_r - $fdt_addr_r"=2E My question is can we re-work this=
,
>> >> >cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase s=
ize
>> >> >anywhere that doesn't need this legacy case=2E
>> >> >
>> >>=20
>> >> Which behavior you propose?
>> >
>> >Well, using the IS_ENABLED macro with the new tests around "-"=2E
>> >
>>=20
>> So using "-" for booting with extlinux with ATAGs is fine for you?
>> Guards, sure, I will handle this=2E Which tests you are interested in?
>> Maybe you can point to an example? Thanks=2E
>
>Sorry, I meant tests in terms of writing the code, not unit tests as no,
>we don't have enough unit tests around booting a kernel as it stands and
>I don't see how to just add a test for extlinux + legacy kernel=2E
>

Alright then, thanks!
