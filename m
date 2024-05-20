Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03BC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 16:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DEB881D9;
	Mon, 20 May 2024 18:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="G6TyiKrq";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzQuBjD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C888820B; Mon, 20 May 2024 18:00:23 +0200 (CEST)
Received: from wfhigh2-smtp.messagingengine.com
 (wfhigh2-smtp.messagingengine.com [64.147.123.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9262E881CE
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 18:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id DEB771800096;
 Mon, 20 May 2024 12:00:15 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 20 May 2024 12:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716220815;
 x=1716307215; bh=YtYTLre88FVVVZAbZ9cXkQTVNiEgkqbNDIvrDKQFpc0=; b=
 G6TyiKrqilwuWiWdMnloxqTGz9tD8aA8eI7TRbmlGFW9mqQait2C0Cw27jC5DxFX
 ueOBNGbvgQei879kSFffKJHMFH6etfPjl+0LqKzMnVmLJqoiFfj7Ao/ewwsbFjFJ
 rgWGS2ONTga7ASLTrd69uHZosBVmBlxAydJz7abZSa+MJQ0JLD2J9TQM1ys8rAHW
 mMWxhctbSjTpyS0mRby8h5Gb7ESzIzuFhNegG0BCQRO0alMTvyMJm6+plGTbyPJs
 Akd7J9mIZFPPiYugijZiJTgGpcwJoksuCQvVEvnsXAbOhg8mEZF+WO74ArtuS7SF
 hDOzAfiQvWWqQkzQn5gZIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716220815; x=
 1716307215; bh=YtYTLre88FVVVZAbZ9cXkQTVNiEgkqbNDIvrDKQFpc0=; b=L
 zQuBjD9pFjND3bQFA9UySOXXFFK+fwr50GALANc3fJ/Usvx0dbLlpPm5B9Cjb+6Y
 DJXhvMDqclp+luZmQqCtn1r7sTQw45eGJ3wvt94nEFZ0+EK8sPq6xNtemKkKso/g
 40Se+JCcT8D9X5y5hFr5FwC86cNNqyPN2DLBQksphQHehed3LGesobt2RyuGdTsC
 guB6QIQyiePhMxy0jGFqfg0/MgZUsE+vSxxnWx/ONB0ULuSKZY+kpt0s3J0oZNRV
 6kGu36XoRRmwAydfzaxUk2jrd5rkRhY1tSjLWGf3tedb0xVvrdwUUaRz4IGiZ+mC
 XVrJJtuOnG8TNYj8DG8vg==
X-ME-Sender: <xms:j3NLZl3IeJmHYg9_BQUyfm_4SrEEZjhWpvTLbNF7IqigeKJsWNOOSQ>
 <xme:j3NLZsH5IoCL0ZrYlGfoM7KaOntWt9_IFhweq6fEBd6V6UC1kn4uPAUsXK5RCpkgo
 Q-uZ7fSw6VbBFYi9HY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddgjedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpeelleekkedtteekleeffefggeevfffhtdefudeuiefg
 ueeiudevffeludejffdtffenucffohhmrghinhepohiilhgrsghsrdhorhhgnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdih
 rghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:j3NLZl4VlI4yXelyd8FN2naPxCVA8OhdNCGiQvQ5xz80OBm9qaB5iA>
 <xmx:j3NLZi35yjsfQV9BFhyLtxA9WPNETl2l7xknJEfi_bhmnGezmIdPBA>
 <xmx:j3NLZoFKCsnelC0u68IRvFsV1Yj8x9onU-oxBYNIo4EvQD1eHlJfFA>
 <xmx:j3NLZj87JOaR3Uyvno-CWWJHWxPT9HjexMU4be6DaUm1XDZc1hnIEQ>
 <xmx:j3NLZkjmRrCaZfiVOZSy7b6DH3zAt9yMDBk1DH1Z6hZAMi9QosqgqfH6>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 11DC836A0074; Mon, 20 May 2024 12:00:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
MIME-Version: 1.0
Message-Id: <74e04a5a-5b16-49a2-a5e9-d0f7ee97484d@app.fastmail.com>
In-Reply-To: <CAMo8Bf+JNR-QSECNhaCWKVkU1s+m6-eUrqePzF=7XyezxDWu0g@mail.gmail.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-4-8fff0cb11c19@flygoat.com>
 <CAMo8Bf+JNR-QSECNhaCWKVkU1s+m6-eUrqePzF=7XyezxDWu0g@mail.gmail.com>
Date: Mon, 20 May 2024 16:59:56 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Max Filippov" <jcmvbkbc@gmail.com>
Cc: u-boot@lists.denx.de, "Sean Anderson" <sean.anderson@seco.com>,
 "Tom Rini" <trini@konsulko.com>, "Sumit Garg" <sumit.garg@linaro.org>
Subject: Re: [PATCH 04/10] xtensa: Define PLATFORM_ELFFLAGS
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8820=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=884:18=EF=BC=8CMax Filippov=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, May 19, 2024 at 1:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
>>
>> u-boot.elf target requiures it to work.
>
> Typo.
>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  arch/xtensa/config.mk | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
>> index b0809999e403..3ec936272f25 100644
>> --- a/arch/xtensa/config.mk
>> +++ b/arch/xtensa/config.mk
>> @@ -7,3 +7,6 @@ PLATFORM_CPPFLAGS +=3D -D__XTENSA__ -mlongcalls -mfor=
ce-no-pic \
>>                      -ffunction-sections -fdata-sections
>>
>>  LDFLAGS_FINAL +=3D --gc-sections
>> +
>> +PLATFORM_ELFFLAGS +=3D -B xtensa -O elf32-xtensa-le
>> +
>
> This fixes endianness as little for the whole architecture, but xtensa=
 cores
> may be either little or big endian.

Hi Max,

Thanks for reviewing, I can just add a branch with ifdef CONFIG_SYS_BIG_=
EDNIAN
if you wish, but I think all CPUs U-Boot support are little endian only?

I have an ongoing series[1] fixing endian selection options, please let =
me know if
U-Boot do work with big endian Xtensa.

Thanks.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20240519-aarch64-b=
e-v1-11-75cc328eddfa@flygoat.com/

>
> --=20
> Thanks.
> -- Max

--=20
- Jiaxun
