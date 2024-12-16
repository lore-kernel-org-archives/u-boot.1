Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9894E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CE698005B;
	Mon, 16 Dec 2024 09:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="E4p55qDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C144980104; Mon, 16 Dec 2024 09:06:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625DC8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734336347; x=1734941147; i=xypron.glpk@gmx.de;
 bh=e4euv0Tab//3dq8ppvmmGWWX3zPJro9gcRiE8g/XP20=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=E4p55qDYA0aLt9fVu+EdQekLGOn7Z6LOwsr7w28zB0U66GOkKeIDBlRbrDMnt304
 bQe7YLodK04Wv7jOUjEypWMf7EH+KMFxuX2qWiGAfHCgYY4PFMXlBbh4kqBL0gwuH
 jrFUkKzbNwF+OLy+Delr+EyTvy1rJi1cC9uYJlQjWZUjlpR6cyo3OqB6DnUMP2Yzs
 8rrc81xSaVwn5ihiFqpDR1Kc6KIkYwmRo+F+1JXtilY0LceGQwmUAMJd6YLB3JgvC
 9FUl8henDfm/lsQeBNRvKq5e5hsDxxpgtwR83zaPTxdVqgMQGnUGQpj477adx9WGp
 2vUKU9xWTRCOWnOgEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.196]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1tWlEM3UdA-014rmx; Mon, 16
 Dec 2024 09:05:47 +0100
Date: Mon, 16 Dec 2024 09:05:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Matthew Garrett <mgarrett@aurora.tech>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/8] doc: test: Add docs and test for part_find
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszThPgtngJM16oCcOD1oCJNzpdn7We0=OB6E41XRHokxDuA@mail.gmail.com>
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-4-sjg@chromium.org>
 <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
 <CAFLszTgDCAxiZBYkDVUUb4jWejry4wWKm4gyyNndLhBYQ+zfAg@mail.gmail.com>
 <20241210170856.GC2457179@bill-the-cat>
 <CAFLszThPgtngJM16oCcOD1oCJNzpdn7We0=OB6E41XRHokxDuA@mail.gmail.com>
Message-ID: <33FA4F32-AD4F-438C-BE53-F89DA5FCC86B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFOzXaIeLJuIMBXcXqjjO9CTX7Qr6bAmnzx2L0dJP7oIFURlhG1
 ErnnJSdYe/QhewixBnjhbWdykLgzbbqt7KY4s5Bw1iHwNGjyeoXj7xRGBA3xN0bieOMLBT3
 /56oS7OTQMzJ4lxSaURVJepakXnwel7xMhf1w1B+D/i24Jiz4Z/91hE5xNsOgBZNTpo3T4/
 976Vqr2H7l3MeFGqfpcqA==
UI-OutboundReport: notjunk:1;M01:P0:eemUSGEnZJo=;XXNogPUggMrIi2bpiswDZL1eIsN
 T6E/pvT90ScGwptyKh2MmeHIQ1KJBfQ1aB3fH+VVZ/qQXfIWJKU7Zb4/hFeSGcKM0Sl+uf/61
 1aZIVlV3bnPjiCGc4fGIhegyihXFea3K+7WsQ6P4ETyASkcd/Y84ayKp9yadmTAuam9/T8TnI
 8lX1uR0DyJiaD+xsQCBxaMvph4FDNN4rqzrhK9/M9CP1Vwut4rAnCcw7c8QydcVFsWD4OYE9q
 JlFwy2CbeTRfh/x1jQvPaSOws9a84nN+AdGQ8ciy5RHuO8O0OHIcO/HN48qw/1RZRC/LkrQpg
 BMd+cwYRdUjFJBkJQxa3F8UXwvDIgMlaXdeNl1zXrXhzmFqK5utXO/m4Vv9E4VUH0u0bh0CEf
 hXqOwH7pxrhijMkjeCYLsxFRAR6eFKVk2uWjcbA9KJU9aixJeqxXtX2kqtzUFv7x5vkEA1Rcv
 F/18mkjPWCDMuio1Sxblie1ZdeiqQ+vNLt6Wa4I43DgEXTGUq2ZmLfzdlhxHQGLmjI4hkhezB
 plZPqJCi/3VxnA8rmLJtWPEflOemCKjVOtD51Dw5LnIGS+zEh2z7uZBARXCufBF4ARwtXXy04
 dksLycPSDooLzlT5C1rjebhkQA2Oc6LklpUz+1yYQUIZWsroG3Agnq1s2wLNNaZcQTh467drq
 V8NZ5QJp4lzbkPPXr0eWfidqMGCb/q3pQwdw2RY8e652/BLHX1hJ+EYkoZjbbxKMOEe51PbUE
 gfKz/PT+3D0tOPOsyNmMkSGuVOfPBEaLFvze9k6NuYwT70E5dam9Hxyg67rRPwn0aUmNQjuBo
 kqfyJDTYua3OyBwrzP/3R7L+/i5wrahrexidE2WgW/9bEp/NuSlSz4g8eWsR8De2SWPHk2oN4
 WgV0Cv6irbeYcNPuLO2fFmfB+Um10UtedsA3OOZFS9+mybhky3LiuPuBH0JMU8H6SRYRND60R
 NIKiBowAm4cD/SUR/RnOU26lJ06fAvCm6d1QBLOmgSX6VC4HeZ5C6xgkkgL7OoAAJD/Aqn3Ss
 bFDj2mnBASTSbrym9cju8snl1IFN7TT438z9m1iPYz1KxHZJU9PfOmvoC5QxgbGquKjuDTf40
 jP85ShQ0ofiZOq6HMwRPWPXqohpqGg
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

Am 16=2E Dezember 2024 01:29:04 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Tom,
>
>On Tue, 10 Dec 2024 at 10:09, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Tue, Dec 10, 2024 at 09:16:57AM -0700, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Tue, 10 Dec 2024 at 01:16, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> > >
>> > > On 09=2E12=2E24 17:27, Simon Glass wrote:
>> > > > Add some documentation and a test for this new command=2E
>> > >
>> > > Shouldn't this be two patches?
>> >
>> > Often we put the new command, its docs and tests in the same commit,
>> > since the question I always ask when looking at a command is, where
>> > are the docs and tests!
>> >
>> > >
>> > > >
>> > > > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > > > ---
>> > > >
>> > > >   doc/usage/cmd/part_find=2Erst | 119 +++++++++++++++++++++++++++=
+++++++++
>> > > >   doc/usage/index=2Erst         |   1 +
>> > > >   test/cmd/Makefile           |   1 +
>> > > >   test/cmd/part_find=2Ec        |  42 +++++++++++++
>> > > >   4 files changed, 163 insertions(+)
>> > > >   create mode 100644 doc/usage/cmd/part_find=2Erst
>> > > >   create mode 100644 test/cmd/part_find=2Ec
>> > > >
>> > > > diff --git a/doc/usage/cmd/part_find=2Erst b/doc/usage/cmd/part_f=
ind=2Erst
>> > > > new file mode 100644
>> > > > index 00000000000=2E=2Efd5bd6578d5
>> > > > --- /dev/null
>> > > > +++ b/doc/usage/cmd/part_find=2Erst
>> > > > @@ -0,0 +1,119 @@
>> > > > +=2E=2E SPDX-License-Identifier: GPL-2=2E0+:
>> > >
>> > > This is not a valid SPDX identifier=2E
>> > > Cf=2E https://spdx=2Eorg/licenses/GPL-2=2E0-or-later=2Ehtml
>> >
>> > I have seen this point made a few times, but I'm afraid I still don't
>> > fully understand it:
>> >
>> > The Licenses/README lists the licenses and GPL-2=2E0+ appears in ther=
e=2E
>> > In the source tree:
>> >
>> > $ git grep GPL-2=2E0+ |wc -l
>> > 13406
>> > $ git grep GPL-2=2E0-or-later |wc -l
>> > 1847
>> >
>> > I have to say I much prefer GPL-2=2E0+ as it is easier to remember=2E
>> >
>> > But if we are planning to change, could you update checkpatch to thro=
w
>> > a warning?
>>
>> As I've said before too, GPL-2=2E0+ is deprecated by SPDX and
>> GPL-2=2E0-or-later is the correct tag=2E But we aren't, sadly, right no=
w a
>> best practices example for SPDX anyhow and so it's not a deal breaker t=
o
>> use the old tag, just something that should be avoided=2E
>
>OK, I will try to remember this=2E
>
>At minimum, if this is important, Licenses/README should be updated to
>drop the old license?
>
>Heinrich, please update checkpatch to warn about this=2E
>
>Regards,
>Simon

See
<https://lore=2Ekernel=2Eorg/u-boot/20241215023732=2E68902-1-heinrich=2Esc=
huchardt@canonical=2Ecom/>

