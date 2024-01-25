Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D966C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 06:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE7987480;
	Thu, 25 Jan 2024 07:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KWH3O/sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CC3871D7; Thu, 25 Jan 2024 07:51:14 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8DAF87536
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55cec718c30so668487a12.1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706165472; x=1706770272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=meqpnQTf1NElwfudNlP81TMsU4diDS0jGPRafGIj9ng=;
 b=KWH3O/sU0qL7NYjxU1eUYu3jSX8g+QGI69Yu60GmE6ACfYYAjBKU82RXH7fWol9/Gx
 9h1atngCXCniEQiWEQ2UvKJrk829RD38W06X38TgOD3+y+gl0JU7e3nIqDhtIuShoj6X
 He/waWHJ5vhDRMfwCTv4nZd5jm73gkcpUXDSVvCAGWcmf/NRqKTRH1aH5kN4wgngsBJ6
 41IYq65mtqVqGVOAwzMEPVuV2RWhviWiubWwGc0ZM5iHoVo2vf9p7V+525NGQCrTgk6y
 eVbFra7tgOOc+d0fCIAv/wccauljNTwF6kF9UUkxx/INi3VNde+vbajWuuFJfgWAJXNx
 MOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706165472; x=1706770272;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=meqpnQTf1NElwfudNlP81TMsU4diDS0jGPRafGIj9ng=;
 b=PEQGnpJuaN5g75CKGaRCxd6cfc4Guzi48EhRwg+U24+iy7j9QKA24kOqjeyHF1DfYr
 uFKVtf393T8XXgt6NucvVvevwtrn+dOqEzbQe5pla+/RWioU4wzelbPh0kqgfeF5mdEG
 BxGACJWKkHuOezsV7uX4ShPTeyZ04tTSBEKphuSQNV0lwXsxqPzfcLwoyWoaV1+3r5k3
 ycF8UlPI36H/ugVXUU8MXTmdfi/iP9r9j068nhFLnUtwiDZFnKTIBj7jb5+wOKfrjbWc
 AkP1d5Xi8iKVdzxTIvkEEDA68u4GxmQ2DQOvOv6KXDpiFJFqJDT73gB928Rh/EiiFF1m
 F1Ww==
X-Gm-Message-State: AOJu0YzIw44O5DO4BZoOy2iI6/D4cUFmY4dB7qGbk55KorJ3aH/hOIBF
 W7GHcHX4IPkZeEKCWc/2cNGiaNDwO0sD9ttFY6eZaddPq1ZhkQnm
X-Google-Smtp-Source: AGHT+IGk6UmjqiCSS91w3R0mgS4UUDD5NibHWD6qpRWtJUtMy9SZPz7f6ODctDMCy4GZKmJrX+4qog==
X-Received: by 2002:a17:906:329a:b0:a30:e8de:7317 with SMTP id
 26-20020a170906329a00b00a30e8de7317mr247178ejw.39.1706165471934; 
 Wed, 24 Jan 2024 22:51:11 -0800 (PST)
Received: from [127.0.0.1] ([46.211.116.76]) by smtp.gmail.com with ESMTPSA id
 s9-20020a1709066c8900b00a2c70ec1533sm684733ejr.66.2024.01.24.22.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 22:51:11 -0800 (PST)
Date: Thu, 25 Jan 2024 08:51:09 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 =?ISO-8859-1?Q?Jonas_Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
User-Agent: K-9 Mail for Android
In-Reply-To: <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
Message-ID: <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
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



25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 08:29:54 GMT+02:0=
0, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
>> Currently, if boot with extlinux=2Econf and do not set the fdt
>> U-Boot will provide its own device tree=2E This behavior is
>> beneficial if the U-Boot device tree is in sync with Linux,
>> but it totally halts the booting of pre-dtb kernels (3=2E4 for
>> example) since it uses ATAGs=2E To fix this, pass `-` in the
>> fdt extlinux field as a signal that no tree should be used=2E
>
>Passing - doesn't seem like the most intuitive thing=2E=2E=2E  Is there a
>different argument we could use?
>

I agree that `-` is not the most intuitive argument,
but this is a way to implement a fix with the least
code posssible=2E To make this less obscure I have
adjusted documentation=2E=20

Currently if no fdt is specified u-boot will pass its
own device tree and if leave fdt field blank u-boot
will fail with the wrong name for the device tree=2E
So there is NO way to boot ATAGs based kernel
if u-boot has an appended tree and fdt support=20
built in=2E

>regards,
>dan carpenter
>
