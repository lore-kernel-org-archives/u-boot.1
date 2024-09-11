Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AFBEE499C
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 19:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F63892D0;
	Wed, 11 Sep 2024 21:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WtfHu36n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B589892D0; Wed, 11 Sep 2024 21:15:27 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA43089316
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 21:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso159993a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726082123; x=1726686923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6SSvthqviDDlb/94kDcThxyrqB0ihIcXMqgrGZnKqqQ=;
 b=WtfHu36n8AHAKfk7TEvaIWlkZ38MgIR1PuC0CXuS2EG87MftFVJgPprXvtsMSLh9ac
 /q6dK3mmxNotlU8XWlD2p+JkT/06vhbGS65qB7a9CDrUGqIxyirlgzxdU2TrhD+TPY19
 Q0lKpx6vw706ab0HfcW+48uIHDZi/MNP1ayi3woWIdSBJCbzDbmWOv7Ko/EQoEY6QLwQ
 X/DsQUAoLD9D8flxkgbIhMWejCMCNAPuAJJddSVupianw7jzMyP3ZdXfHXxBVMmuY2Zh
 w9D09/zLf3OjGByReNccb2o6t43hLM9eNs2fRNv/t543He0Rk90bwQx8iCbK929WtmRD
 W8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726082123; x=1726686923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6SSvthqviDDlb/94kDcThxyrqB0ihIcXMqgrGZnKqqQ=;
 b=Aseza1B3EBWe7DrfHVyOHb2PBcFbficOdruG5U6d/qaVttEihxuR37+lLpf/KCo0ih
 WmQzz0au/uGYISYjmKqsR0wVDqFk225EpldgGz3DFLb6A9NnQx1UIKQPgYarj2bBVWh4
 iI9oMdX6Vo7dlY9c6ihKvyPNZ8Vq2gChutCaZiTzQdJ1b3sjqCiSYWPOrMKIqGdBAX3G
 jjnbts6ZrdhltPEtkfdtiMTdUyBdjYWRej+e4MzM1q7qm7SYY/gIR+V7bn1CN2dfMW0H
 MwPqxZ3C88kbk9L6Vdj5HzyjEtD0sVbod+fnaxBk93UpoY70sSRxnJpJ3Iv+n4/h+6li
 1t8Q==
X-Gm-Message-State: AOJu0YwUdG0MDTW9B4oA1kVMiFdok6ft2KmT1nB6EM7td4AgL4IK9frD
 uwK7TiuGIrK1xeb6mVGMCKfVjrvK71Rwm5xiGLDXFVZxJn2AexiDEsVZ2YsfLSHrgrvvyibpIQJ
 BIx2alV6PIf/jziC/JguCvoK/VVOPEuFpOd4QkQ==
X-Google-Smtp-Source: AGHT+IHdqIXwMY+YCk7Gg2f6Pr5UpNQvj1kFNcZlXuPFFAWfwhi3nU2KpFE7xesubCNw1FYPGRQpBtwACs7scBYEP3Y=
X-Received: by 2002:a05:6a20:c888:b0:1cf:4102:9762 with SMTP id
 adf61e73a8af0-1cf76244cbemr294847637.42.1726082123073; Wed, 11 Sep 2024
 12:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240819210437.GH1626301@bill-the-cat>
 <CAEfUkU+SDHcAb5sJe5ccRzQ9NjNq3g7MGsr15WWtX16sfxY-uw@mail.gmail.com>
In-Reply-To: <CAEfUkU+SDHcAb5sJe5ccRzQ9NjNq3g7MGsr15WWtX16sfxY-uw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 11 Sep 2024 15:15:10 -0400
Message-ID: <CAEfUkU+Drzwqo_w1CFrQB+iepmvvJuZT=DPKdJp8AFdWJPTaeg@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Integrate MbedTLS v3.6 LTS with U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 3 Sept 2024 at 11:03, Raymond Mao <raymond.mao@linaro.org> wrote:

> Hi Tom,
>
> On Mon, 19 Aug 2024 at 17:04, Tom Rini <trini@konsulko.com> wrote:
>
>> On Fri, Aug 16, 2024 at 02:43:49PM -0700, Raymond Mao wrote:
>>
>> > Integrate MbedTLS v3.6 LTS (currently v3.6.0) with U-Boot.
>> >
>> > Motivations:
>> > ------------
>> >
>> > 1. MbedTLS is well maintained with LTS versions.
>> > 2. LWIP is integrated with MbedTLS and easily to enable HTTPS.
>> > 3. MbedTLS recently switched license back to GPLv2.
>>
>> Whereas I think v5 did well with global build with mbedTLS being the
>> default option, v6 blows up so many places.
>>
>
> I didn't enable it except qemu_arm64, sandbox and nanopi_a64, I will run
> it on more platforms via CI.
>
> Just a follow-up:
I made a few changes to fix the kconfig dependency issues which only can be
reproduced by a few of the world build platforms.
My latest PR passed all CI world builds with MbedTLS enabled at:
https://github.com/u-boot/u-boot/pull/642

I will include all the fixes in v7.

Regards,
Raymond

>
