Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1B3C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 18:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D1488A2A;
	Wed, 31 Jul 2024 20:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B9E88996; Wed, 31 Jul 2024 20:15:02 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id 1D2FE8881B
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.64.133] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sZDqb-0004yK-04; Wed, 31 Jul 2024 19:14:49 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <CAFLszThj6=XKSUiBdfFK-1n5VeovJHf7UcjE+dORK7r68xQNag@mail.gmail.com>
Date: Wed, 31 Jul 2024 19:14:57 +0100
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Transfer-Encoding: 7bit
Message-Id: <F14855F1-283C-44D4-A917-B804DFBBF8A9@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
 <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
 <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
 <CAFLszThCz2NL+6svYMRD7qAHHNN8frWzrM4tyhDbuS77M3jUHg@mail.gmail.com>
 <E1381CA1-72D5-42D5-BB22-2B9B458B29C7@arachsys.com>
 <CAFLszThj6=XKSUiBdfFK-1n5VeovJHf7UcjE+dORK7r68xQNag@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
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

Hi Simon,

Simon Glass <sjg@chromium.org> wrote:

> On Wed, 31 Jul 2024 at 04:14, Chris Webb <chris@arachsys.com> wrote:
>> Alas I don't have any boards to test on for either of these platforms.
>
> If you have the inclination it is still worth sending a patch. The
> maintainer can check it. These sorts of counter-examples can be copied
> and soon everyone is making the same mistake!

Makes sense! If the Mediatek patch is okay, I'll write the equivalents for  
the other two platforms and put a comment after the --- to warn the  
maintainers that I haven't been able to test on real hardware. I can do a  
compile test of them both at least, and they're simple, easy to verify  
changes.

Best wishes,

Chris.
