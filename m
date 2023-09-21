Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264AE71096
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 16:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63999869F1;
	Thu, 21 Sep 2023 18:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="suPKJcuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89308642C; Thu, 21 Sep 2023 18:29:23 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A319A865ED
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 18:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-502b0d23f28so1992982e87.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695313761; x=1695918561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AsASyNbOgImo6M87qOUhDuLsemPJEcJCgi+MAIX4b14=;
 b=suPKJcuZNiSmoQqtyQ9rLdt0OgSE4fWAJ/0YEzzbTuBNVif/YjcMQeJzPcHpVNzKKo
 RBp8H/NEcSRe3t108CnCMyA7HRrJUl1yX6Jq+PA2NHkNaIXBOiyiLQdUQ2hPWs6WKaej
 SBSyD4LORVxBkhtS+20pj/krKAPuWtu6X1G8RzSK7VHPuYwIqImjIFdoCnq2fQnr2mOa
 5AGcSMwaNy/zCJA+53lYBtxSoMPoOIYe/c/ucph+hZE3bm6xf+dMblYwM0q9H4L3Zdvj
 x2PK0rCb3HFrba1rN1CMjk4yEOfRulrIm0d3BjKVqpzs+5nDQiL5et4OiQ5rOkm6zfTR
 +FtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695313761; x=1695918561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsASyNbOgImo6M87qOUhDuLsemPJEcJCgi+MAIX4b14=;
 b=TScaGpDZviod8M6W0CNZUjPImPa8/UxnSlVj80bruQfAi7XtqTm5pin+lADFdbgu29
 Qpw5HjcSIODe6Dd0m9/z39+9ArTDU8pUqInIlJ/cgzd4T45ByRp+dXu1EAKhZslrzmLq
 bqjsScX28D3oBIrFS+xLM0jj1oPqEj2vrYaHrBENDQ+7zQAdpWhws8UrRVhJgN4E3kA5
 a3bbwpjEs+YyId0xdHkz8mW3b2cgNslwJeXm9CiNea1nqXRYbNpbqkOfMdT7ZBKVhhD5
 akh9L/I/oqDrEWxvRubiztcuTrOl4g6b3RUo8QvAJAsQ5mTNOB5mOGl5sWXcdkliUh+F
 7WZA==
X-Gm-Message-State: AOJu0YyEBViNmyE1jtoRgicq/mi/u7QryVZcJXY6ecHCPgR8I1Fw7ejo
 zS1cEk4lRlUCDSlBd9HKCDx2yVzShBBbF1Vj7EhTGQ==
X-Google-Smtp-Source: AGHT+IGXIK8uPIce+Y1qvOJvVl4gAeTePTcWdUN5vDD7iS75mdXdH9f0NSydfZnAYptIMSATBjpFb88l82YPUOm0Bf4=
X-Received: by 2002:a05:6512:7a:b0:503:3ac:8457 with SMTP id
 i26-20020a056512007a00b0050303ac8457mr5039194lfo.45.1695313760664; Thu, 21
 Sep 2023 09:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
 <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
 <20230913131423.GI305624@bill-the-cat>
 <CAD8XO3aq9+KDOUXKtURaL8UwX96RLqqwAhDz=U2924BfUdz9+g@mail.gmail.com>
In-Reply-To: <CAD8XO3aq9+KDOUXKtURaL8UwX96RLqqwAhDz=U2924BfUdz9+g@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 21 Sep 2023 10:29:07 -0600
Message-ID: <CAPnjgZ0frgZ=i7ED71ifpvWAtv0PG9DbwbKQ3Hzf6PHkfgnraQ@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Goldschmidt <goldsimon@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 joe.hershberger@ni.com, rfried.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Wed, 13 Sept 2023 at 07:35, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Wed, 13 Sept 2023 at 19:14, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Sep 13, 2023 at 11:06:13AM +0100, Peter Robinson wrote:
>> > > >> Then if for development you need  to pull he history of lwip, you can do it with:
>> > > >> git pull -s subtree lwip  master --allow-unrelated-histories
>> > > >> (but I think nobody will need this.)
>> > > >>
>> > > >> New update of the lwip net/lwip/lwip-external dir will be done with:
>> > > >> git pull -s subtree lwip  master --allow-unrelated-histories --squash
>> > > >> Squash commit also has to be git format-patch friendly.
>> > > >>
>> > > >> If you are ok with that proposal I will send v9 with the first patch created with steps above.
>> > > >
>> > > > We've gone through this before.  The whole purpose of this is not
>> > > > having to maintain patches.
>> > > > Simon, instead of "I had problems in the past", can you elaborate a bit more?
>> > > >
>> > > > Tom said he is fine with subtrees instead of submodules and I know for
>> > > > a fact EDK2 doesn't have too many issues with submodules.
>> > > > Their documentation is pretty clear on building and requires
>> > > >
>> > > > git clone https://github.com/tianocore/edk2.git
>> > > > cd edk2
>> > > > git submodule update --init
>> > > >
>> > > > Perhaps the situation has improved since you had issues?

Nope.

>> > >
>> > > While I don't really care how you solve this technically, I'd *strongly*
>> > > be interested for U-Boot to use *unmodified* lwIP sources where an
>> > > explicit reference to an lwIP commit is used. I'd rather integrate
>> > > bugfixes for U-Boot into lwIP than having the sources drift apart.
>> >
>> > Strongly agree here, we want to use upstream and all the combined
>> > development and reviews etc rather than forking off and ending up with
>> > yet another slightly different IP stack. The whole advantage of
>> > adopting LWIP is the advantage of combined security, features and bugs
>> > from a wide range of projects :-)
>>
>> Yes, this is what I want as well, and why I'm perhaps more agreeable
>> with the approaches where it's a lot harder for us to start forking
>> things unintentionally.  I gather submodule rather than subtree would be
>> better for that case?
>>
>> --
>> Tom
>
>
> Yes, submodule will be a much better solution for us. And I also don't think that today
> there are any issues with submodules. It works well of OE, RPM and DEB builds,
> distributions should not have problems with it.

My particular experience is with coreboot. Some problems I have:

1. Updating the modules doesn't work and I need to reset, try the
--init thing, fetch things manually, etc. etc.
2. In ChromiumOS coreboot we can't use submodules internally since
each package has its own build script. E.g. we need to build coreboot
separately from its blobs, fsp, external libraries, etc. At least
there we can do this, but if U-Boot adopts a submodule for a core
feature, this is going to create no end of problems.
3. It makes it impossible to patch lwip for any fix we need for a release
4. We still have to 'fast forward' to a new commit every now and then,
which really is no easier than doing a merge commit for the changes
since the last sync, is it?

Really, we need a maintainer for the lwip piece, if we are to adopt
it. Using submodules is not a substitute for that.

Regards,
Simon
