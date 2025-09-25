Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8DCCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E145682A9E;
	Fri, 26 Sep 2025 00:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Om7LVTrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096DB82AE1; Fri, 26 Sep 2025 00:51:39 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3FA2802C1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-85d02580a07so78024185a.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758840695; x=1759445495; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlFF5T0wJuWbKLI/nzf0Wm0TlqdP8SZMrIi8a5WJuDQ=;
 b=Om7LVTrBgwSiq/uwm+b/wIDz7MNuTn5CN1OZ5d+wngzFG71GuTcmNeygQb2nz1i7Ak
 0KOzmIHI0PJnLj3AIPNP3SsXOOvOkC7ORJxVqeV4KlI2fgNYVfN5wCfgmMVQkdi6y71u
 DNn2b86zl+KhrIYnSpytL8IfDHujqiB5R0GHvyPVIF7Pp6HLZboI8dp0qzleRa5WDaPo
 zPwWh+WiDgZ9CafIBDFaWv2Pj/ews6KTv8elg50Lg9TO6qxVu5rsno+qVHBG+5e6foNj
 /MXzJ/2uVGOsO9S3rl31UZPue5H6LAQ+WD/wiy5kPilZQLhMdzTJEpZvBTrbTxEfdDKC
 PRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758840695; x=1759445495;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TlFF5T0wJuWbKLI/nzf0Wm0TlqdP8SZMrIi8a5WJuDQ=;
 b=FUEcoBDGsGAGI3EgVQ0sImqrif6EpdZ2aDE8TKoKOoGLb88AaOzEAoqqpeytVKjuJq
 zaKZe9gm9cmFcXOD6m/p+DGrRPKuI7FOE833I9AkIke/vRbTf1W+DqCHl3KR0hwkmREn
 IuE8G/Ab63jrc6l6Ql1yNGijRUEHT+r1zr2LlGSwAsxTCM+EAJnHsilKFfGwB1IY70og
 UXzCyl5xMLL3xe220OsiWvLXagQmcPEY15k/CNmlsT3PA25IMswiHsk2mr5b3+2W+VAo
 JKYBm2fyQuGZsw2JI8v080gA7rlHAKw2s+eL6+msHTri6mttW4v13rIjpgp/9ECRz2vv
 hu2w==
X-Gm-Message-State: AOJu0Yx3d/DqAfgpC/HPw4oBttUtoTGIktOrFp2kzFhEO+TJYhNimJns
 vlNJsrBC3Fb93fbwgIvOeWZHhMEM+XRXyCaVXRLdZtMPbY5RhYDulnKxBdDxDcBlrqNtrAVA9qP
 RXWBe
X-Gm-Gg: ASbGncsFUKhie1e0x1SrnVZsDhslw1QkG1RzLrRsXoSRkJO8Fx53a1r/8CAb98D7gSi
 cgMcIoBW2TiD4nimHuSaZGz3MMN1JNmCpWvwpHV6eBhG8lyZell2gAoa3x5G044XcGrht/7WhLQ
 iMCgaJUopuo8OR6jWCkq0PjJ1C8XCMzdPM6UY30rCUSxUy/XRSmuwMXf0vaOJOQGiQreg/exPMo
 cctQ9FLk5uUmMsxFUYP1EYCn1QeauIkrx3WulX+Xf2Bq5VjULaPgxqN+xUSnugmp3tyFLtf9PqL
 TP1fzrlGuoECn59e6RSIyCE4BDMlCGDAjI13kWshlNlZdoJ+D29X9X2Cd7PODjNvkaPO7v1FGx0
 q34gFZrk4ah1Da9j3MNIpIrKCQOeDuhL7hx38XI8PxB/SCNyii6a2cfDkMse8YP6+lDeWZxlHis
 HoVRlPy6ZXQDXXLw==
X-Google-Smtp-Source: AGHT+IHothsm64p9/aqeWTdz599DQoQ0hOGR+idNLLM/AfZ0FtheOAt1d2nwJMf4gD5Cdn7hlzEZPw==
X-Received: by 2002:a05:620a:8009:b0:85f:61d2:7989 with SMTP id
 af79cd13be357-85f61d27a21mr343465285a.14.1758840695572; 
 Thu, 25 Sep 2025 15:51:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c3218e75csm186062185a.49.2025.09.25.15.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 15:51:33 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 24398F40066;
 Thu, 25 Sep 2025 18:51:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 18:51:32 -0400
X-ME-Sender: <xms:dMfVaH1v6TEQtpVZtxCYqxBjeTXqg0JXudpSrILW8qmr35f1RvWm7A>
 <xme:dMfVaA6aWQN6EpndNm1aGIUiSCaIsbyYGkuc6tz4dVKfLZrSRxLGgcBlHoKy94boO
 nBoxXO5MYkqsNyuE67bC1rtjDSKJc3xXY0NJRpYQpck_wBflDadsyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeejfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflrghvihgv
 rhcuvfhirgdfuceojhgrvhhivghrrdhtihgrsehlihhnrghrohdrohhrgheqnecuggftrf
 grthhtvghrnhepledukeevvdfgkeegffeiieeikefhkedvteejtdehffdvhffgjeevieev
 jeffleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epfhgrshhtmhgrihhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduhedv
 keekleehkeefqdefudefieegvdeliedqjhgrvhhivghrrdhtihgrpeeplhhinhgrrhhord
 horhhgsehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
 thdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhope
 hilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
 uhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:dMfVaCx4i5coq4EWNfZdx_VnBYpdoYpMllIhz_kUmd4_SQXiwVNvXA>
 <xmx:dMfVaGA2tK2Fj2cGZTFdFacU9xuvlHDuEIsMWdojl6oULYfVRQosQw>
 <xmx:dMfVaHbidqkibWS4N99b4XI7qnPJEiMdyxqWUd2EycE-_tEz7Yg9Xg>
 <xmx:dMfVaGjxbRrECclkv0V9DkISd0QrH8HtWW_SOPVnvvtr7o9iiknJYA>
 <xmx:dMfVaB5DZjGphwbv5Mbe68pGSObOI3qX_lKpLiNPPZgcuIT7ot3xz1Wl>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E9BF01EA0068; Thu, 25 Sep 2025 18:51:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A_MkewDl2oIw
Date: Thu, 25 Sep 2025 16:51:11 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Message-Id: <6007da67-28f9-4c6c-8e4b-9200c0a3d134@app.fastmail.com>
In-Reply-To: <20250925163541.GR197373@bill-the-cat>
References: <20250924233120.454116-1-javier.tia@linaro.org>
 <20250924233120.454116-2-javier.tia@linaro.org>
 <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
 <20250925163541.GR197373@bill-the-cat>
Subject: Re: [PATCH v6 1/2] part: Export part_driver_lookup_type for external
 use
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

On Thu, Sep 25, 2025, at 10:35 AM, Tom Rini wrote:
> On Thu, Sep 25, 2025 at 09:20:53AM +0300, Ilias Apalodimas wrote:
>> Hi Javier,
>>=20
>> On Thu, 25 Sept 2025 at 02:31, Javier Tia <javier.tia@linaro.org> wro=
te:
>> >
>> > Make part_driver_lookup_type non-static so it can be used outside
>> > part.c. This allows external callers to determine the appropriate
>> > partition driver for a block device, enabling more flexible handlin=
g of
>> > partition types.
>> >
>> > Add a prototype and kernel-doc comment in part.h to document the
>> > function contract. Provide a stub inline implementation returning N=
ULL
>> > when partition support is disabled, ensuring build consistency acro=
ss
>> > configurations.
>> >
>> > Signed-off-by: Javier Tia <javier.tia@linaro.org>
>> > ---
>> >  disk/part.c    |  2 +-
>> >  include/part.h | 21 +++++++++++++++++++++
>> >  2 files changed, 22 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/disk/part.c b/disk/part.c
>> > index 66e2b3a7219..f0c6866e210 100644
>> > --- a/disk/part.c
>> > +++ b/disk/part.c
>> > @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(i=
nt part_type)
>> >   * @dev_desc: Device descriptor
>> >   * Return: Driver found, or NULL if none
>> >   */
>> > -static struct part_driver *part_driver_lookup_type(struct blk_desc=
 *desc)
>> > +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>
> Since Ilias has a comment, I'll also note that with the kerneldoc movi=
ng
> to the header, the version in the C file should be removed (this means
> they won't get out of sync).

I have removed the duplicate kerneldocs as you mentioned; it's already i=
n the header. Thanks.

Sent patch series v7.

> --=20
> Tom
>
> Attachments:
> * signature.asc

--=20
=C2=BB Javier Tia =E2=9C=8D
