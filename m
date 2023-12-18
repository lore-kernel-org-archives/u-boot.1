Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110C7C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 23:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C51487227;
	Tue, 19 Dec 2023 00:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ObkUz3J9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4760D87252; Tue, 19 Dec 2023 00:08:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D35870A4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 00:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702940912; x=1703545712; i=xypron.glpk@gmx.de;
 bh=A/wm9jTc59iVRx3X09sObPATwoyxuNyTQLP7WsfaKhk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=ObkUz3J9GX3rn+GvyT8WE36mXRHQhj3rBC1H6SEU4PTlEnFsgynV63iTfomvL1JD
 4dqskKRmxIb/P8jE/teZ73hhYr0RbRXdVf+bjj5XQrsgXRfULmGcPHa8cpqp1s0pu
 JHrWt7enlkyaL3zUtRejzoo67pDpXGPfyhowlaM9+sFjGUzmAOwAf3OmqyfLxG6b7
 J4ygoQLxUhw4k7NP/iKDzorMm0QdywbzRS2B4fKKshWOMS0j28nostK242RkqgXjC
 9UYLUKVWWKL8LOTPnPqcOAS4QNgm7KuHJ6ZiHTZyRc5XNTK4sKTqwNU1PMy2Jc7RP
 FG8r7eh0XOv8qXiu/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1r838g0yGM-011QA3; Tue, 19
 Dec 2023 00:08:32 +0100
Date: Tue, 19 Dec 2023 00:08:31 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231218224108.GN2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
Message-ID: <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C09KkR4sQ0jFQkNk194pMX2tRodaOXkW0JEn63OCdaJxxJK4YA5
 yKjxlWdkZTTJK6q9oi+Ff0E90Ud+KYIxnitZc2TpptAIYtmdT7Ahz7Ohi98f88trnNLBOJL
 bi2ZCkPD/rMBqYep+F9ERJ8i6RqQVMoaTuf86gYkWGT7MCcK9P2THLPVNz0vFfXqikh25HI
 Xa/hKGoaAEvvw32PX3gQA==
UI-OutboundReport: notjunk:1;M01:P0:XioKF09iCWs=;VcVXNFjrB6nDOqEuL6Rnt/QI0Cb
 usN9AT+29MswBA4ncwuutDNien6U2lXzCB69kkZrYXbSx3H0wO8Y0ID3ed1obiW8sBARHmHpd
 Olq0f1c1ApqOj1SaS6HY5/ZL7Ye1e9LW5EqG83nz5igPgBOyQWvVwU24RPIwaQ6BOOjv+gFt/
 NloFZD2Zp55NGfk/96EoNjYm7o5LoRQ8SNcf3AyBDURr81Tc+sQ+dDdjdPdCJEE5uFo1CMRFq
 EXv3JJdbk5gQLVf/dSaqHpUQiWsa8+zTPEKH1MPG8CzOUhTn5iMayHOeHWGnNlftt2nBu4Msy
 Y1kHcraSmb9nujCSb7z24Xad/VgNT0xej9hDUMj+r+IUAfMfvr+glchKBTiIS4OqX9d+o4RM2
 aVvmFi/gvSxtGZnCG/EXElWFRuVjb3LNW1ShMu4/eSR/G9cA7KgSHbJmEcF2uA6xgHz4mDWLL
 6zoCILRtUDdpP4+rOPmAgGNftfgms6Y6XxFKhA+e+ZPKbyrI5SxIPkrJ01MTjkQItb3Uv4k9T
 ThF6+ZDlONOOTBwki1oO28kGp3nD72FkcmJZVf7fKLXsczChFKWy5ubknM4txblxa6vvcenGI
 UlcpYFBgfXBy49gBvRhPIdh9Gg8GsHV+41ROK3XUdKOrPriTm3JIstLLm2HEtKjz6W9GbpDj6
 yfo6EgwYebrksAoFojDsKY/ozFACX4hQ4eevapsRrhqz5TFXK/hZ3qKfOmmP/URL1dRMrUgSz
 2KOQCbkUEPV77x9Tdiby5D+ZpVc93ug8HEMWaJwDo3QqZDVBtlU9xh3qGUAoR7p8Dm1gvVWr+
 H7bYSrawD64e5pFKOpI3rbn9V2SXRvkeBPJDCVwewucjvXocjYQHohOSwNqY8vxwtljs1bWKD
 q/RM5f6iU+70t6b9D7XHespMdFjGl9cuXMqM9xrDj9IkNvsWP2jsSC3IqZqXYT2fqT5noHSdO
 RoqmcP852BTfrxlYMqO0XDNmtV8=
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



Am 18=2E Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote:
>
>[snip]
>> Or take:
>>=20
>> load host 0:1 $c kernel=2Eefi
>> load host 0:1 $d initrd=2Eimg
>>=20
>> How could we ensure that initrd=2Eimg is not overwriting a part of kern=
el=2Eefi without memory allocation?
>
>Today, invalid checksum as part of some part of the kernel fails=2E But
>how do we do this tomorrow, are you suggesting that "load" perform
>malloc() in some predefined size? If $c is below $d and $c + kernel=2Eefi
>is now above $d we can throw an error before trying to load, yes=2E But
>what about:
>load host 0:1 $d initrd=2Eimg
>load host 0:1 $c kernel=2Eefi
>
>In that case (which is only marginally contrived, the more real case is
>loading device tree in to unexpectedly large ramdisk because someone
>didn't understand the general advice on why device tree is lower than
>ramdisk address) I'm fine with an error that amounts to "you just
>corrupted another allocation" and then "fail, reset the board" or so=2E
>

Our current malloc library cannot manage the complete memory=2E We need a =
library like lmb which should also cover the memory management that we curr=
ently have in lib/efi/efi_memory=2Ec=2E This must include a memory type att=
ribute for usage in the GetMemoryMap() service=2E A management on page leve=
l seems sufficient=2E

The load command should permanently allocate memory in that lmb+ library=
=2E

We need an unload command to free the memory if we want to reuse the memor=
y or we might let the load comand free the memory if exactly the same start=
 address is reused=2E

Best regards

Heinrich

