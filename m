Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FE5C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 10:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC88A82AA7;
	Wed,  4 Jun 2025 12:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zBF64kEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5449982CD5; Wed,  4 Jun 2025 12:04:14 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D84282977
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 12:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 554A44623781091;
 Wed, 4 Jun 2025 05:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749031444;
 bh=pvAEAhXaY0a6Lr1DlyftlhiqN4rYVhRAROSYwZEyq/k=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=zBF64kElH6BLPEGO2lpYuTQekMUhBAgiVCzHRXoUZzImhe9FmvlQqpHfrsZ2D2chC
 B7j4Mxdj3swXtZaI/IZTu1t5/sKZWKwj5S6LxGg4c0Xum5zUhaSupRsvU0jEsFnlNW
 qX8Wb+1zH9VPUN8h/+SjdRiv+hxPCS7SJtCxqqyE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 554A44RK1957243
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 4 Jun 2025 05:04:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Jun 2025 05:04:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Jun 2025 05:04:03 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 554A42q91872122;
 Wed, 4 Jun 2025 05:04:03 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 4 Jun 2025 15:33:31 +0530
Message-ID: <DADNW2131HYB.V2UGC24FOJJO@ti.com>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Adriano Cordova <adrianox@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>, Sam
 Edwards <cfsworks@gmail.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
From: Anshul Dalal <anshuld@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
 <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
In-Reply-To: <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Raymond,

On Wed Jun 4, 2025 at 2:30 AM IST, Raymond Mao wrote:
> Hi Tom,
>
> On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
>> > Hi Tom,
>> >
>> > On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
>> > >
>> > > On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
>> > >
>> > > > This patch is to solve the sandbox building error:
>> > > > $ make O=3Dbuild-sandbox -s sandbox_defconfig
>> > > > $ make O=3Dbuild-sandbox -s -j2
>> > > > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined refer=
ence to symbol 'pthread_kill@@GLIBC_2.2.5'
>> > > > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding s=
ymbols: DSO missing from command line
>> > > > collect2: error: ld returned 1 exit status
>> > > > [...]
>> > > >
>> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > > > ---
>> > > >  arch/sandbox/config.mk | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > OK, but how do you get this failure to start with? What host?
>> > It failed when I started any sandbox unit test like:
>> > ./test/py/test.py --bd sandbox --build -k <any_test>
>> > My local host: Ubuntu v20.04, x86_64
>>
>> We don't see that normally, is there something odd about your compilers?
>> This is the kind of thing which should be failing everywhere, but isn't.
>> Thanks.
>>
> This failure occured in my host since v2025.07-rc1, but with the same
> host, same setup and same instructions it worked fine in v2025.04-rc5.
> Seems that some impacts were introduced during v2025.04-rc5 ~
> v2025.07-rc1, which might be worth investigating.
>

I am unable to reproduce the issue on gcc 15.1.1 and glibc 2.41. I think
the issue is likely on your host end.  What compiler and libc are you
using for the build?

Regards,
Anshul
