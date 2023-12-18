Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6CFC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 23:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44953870B4;
	Tue, 19 Dec 2023 00:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t/6Y6PlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790C5871B4; Tue, 19 Dec 2023 00:29:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867F287032
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 00:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702942161; x=1703546961; i=xypron.glpk@gmx.de;
 bh=waMVhpZHeMSeWYAw95qGhrZIIGFeV0g0NAsXzaSwZkY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=t/6Y6PlEP997tOSJi5A0ujs+FWAYeBCBfjMFkkPMfVKwzUCBOyzneR16WHCvOzpA
 N5J41lJEOGFk/ZxdmN6YD+wO0yKZdAe8YwPsvUZLBmd9zxLpEK2ykqJeYqaBg/xo8
 vvd9nu8dcqlCmBrB3MWljQoLMt9jApzQkSXhfhAyYxY5a0tjsi1bM7SlV5EsX2fHX
 zLAS+WOXfh3KWa4I9inUW20EIgMcVA8Y9Uaxry7Tx0em8yOC4TMqQ7CXncu75iEWU
 8BO87CJRK0kAHJZ4hCedZADia1WSedWggTWv6cJ2t+LwqHBU/DpEOXT/Toe3Mfj/D
 ITcDP3qEEzfaazPlfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1raTjp46xB-00LBoB; Tue, 19
 Dec 2023 00:29:21 +0100
Date: Tue, 19 Dec 2023 00:29:19 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231218231640.GO2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
Message-ID: <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PkdeQ7IlYkX1ibwpipSzGs0M4gt2ItryFFZwA5exui2Axo+SblS
 WZuuzgJs/kWxYRSCfk6P74MbHzQLBmsKGlpE1DEmn5QUAEJ8MhqC+kHxS7/NHPylpLqEa69
 KVyjIGQ9NoXCYn8OtwCdUcc43Qatbfbz2j8rIZ9PZI7LFnBzcZI07mjFXIsx9c+1v84+efO
 K0il7dt7ykx+VGEiX8O2A==
UI-OutboundReport: notjunk:1;M01:P0:Wj+S/yis8RU=;FJ8/KuUG65smTWALdnhDTd3Jkyc
 NuQA1fnpVTtDYll20cML2mB8lStKNsqyT2MWO+V0rrw8z2EjHIZxHztNtkvIv/DwNFCwLOcqe
 Q4NMhaD1qhc0SeJK/SySvb4ZStn+7oiN3LwcIrdWQC3vLy9dH2WTIJTP2H/b9AD5+NfTVZj8X
 11FqLCCuhvGAQzsnOf2rq2hHVajAY9q4BbnwxKcfLEmmXmP6jwtYgtyga9497CIOszVBwwUru
 VuLwuDLKWWhbNgNT2Shw8FSx6rLzI/ohWoRxk04xG6UQFeFucr7XuEiiuJtCMNr9/TAImk9vn
 +2LXPIda2w32YNjzM6SaMIQmVvxWNodCltwAtPz2RyyOUee8lh9yN7E8bVENE4ul+7sGLsx3M
 vzFFAPBQfvh4M8QX91zCqiott71jXy/tRAx11wXh7875E5YrjQCU1pa4T28P6iOxjUYfruy8w
 6ehqbGM9RXAHsmYkvj4o1p0UGFGeWn72f88i96SgO7HBKx38jnORT6xzKOQuMG7Sp3L94i60F
 NezRL8hHf6o6ltVqDSzmqo5fYiPwq9h+TC2zij4HfdGykPAxssCXQsuJeNXJIY+fQ6yuG33R5
 b6djKxiMuUEMNZQWySoMSM44i9fxij6eQ06MY7sf2gJLQbtQVVCCsn1Iv6HsJk3iIoa11MDkP
 ZH8caRBgJuTrjLFsizm9JIxK5dMN9lvtEN3NeCmt5VMyIXnZNc2L0355+CxYAfIAiRk/GRirE
 Pi9NDeIjCeYlbPoCx+13hPvaQ9GUzvS9Ygtf0VoHnEXZCpT910GBwxzSrzpx8pk84TAXU3FV6
 +dd7TT+n/p1cE5q4O2AhmGCdo4yopISdzaZRilwmvBvKdgwgVsUE6ieoedhIJx9Usdeel2U2s
 A3yT5J8oyUisgMFwHUvi2hUiFgh095yG11ERf13MfOLgg/OepPJfm+M9b6lwkSgPMa6pXspdn
 yozuvryvCkSAs7H137PclKmvZ4Y=
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



Am 19=2E Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote:
>>=20
>>=20
>> Am 18=2E Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko=2E=
com>:
>> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote:
>> >
>> >[snip]
>> >> Or take:
>> >>=20
>> >> load host 0:1 $c kernel=2Eefi
>> >> load host 0:1 $d initrd=2Eimg
>> >>=20
>> >> How could we ensure that initrd=2Eimg is not overwriting a part of k=
ernel=2Eefi without memory allocation?
>> >
>> >Today, invalid checksum as part of some part of the kernel fails=2E Bu=
t
>> >how do we do this tomorrow, are you suggesting that "load" perform
>> >malloc() in some predefined size? If $c is below $d and $c + kernel=2E=
efi
>> >is now above $d we can throw an error before trying to load, yes=2E Bu=
t
>> >what about:
>> >load host 0:1 $d initrd=2Eimg
>> >load host 0:1 $c kernel=2Eefi
>> >
>> >In that case (which is only marginally contrived, the more real case i=
s
>> >loading device tree in to unexpectedly large ramdisk because someone
>> >didn't understand the general advice on why device tree is lower than
>> >ramdisk address) I'm fine with an error that amounts to "you just
>> >corrupted another allocation" and then "fail, reset the board" or so=
=2E
>> >
>>=20
>> Our current malloc library cannot manage the complete memory=2E We need=
 a library like lmb which should also cover the memory management that we c=
urrently have in lib/efi/efi_memory=2Ec=2E This must include a memory type =
attribute for usage in the GetMemoryMap() service=2E A management on page l=
evel seems sufficient=2E
>>=20
>> The load command should permanently allocate memory in that lmb+ librar=
y=2E
>>=20
>> We need an unload command to free the memory if we want to reuse the me=
mory or we might let the load comand free the memory if exactly the same st=
art address is reused=2E
>
>Our current way of loading things in to memory does not handle the case
>I described, yes=2E How would what you're proposing handle it?

If the load command has to allocate memory for the image and that allocati=
on is kept, any attempt to allocate overlapping memory would fail=2E

Furthermore the EFI sub-system would be aware of such memory allocations a=
nd respect them=2E This would of course also hold true for allocations for =
SMBIOS or ACPI tables=2E

Best regards

Heinrich
