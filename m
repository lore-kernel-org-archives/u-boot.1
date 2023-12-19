Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B7BC35274
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 00:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFA98718F;
	Tue, 19 Dec 2023 01:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ea/B4Idz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425F98744F; Tue, 19 Dec 2023 01:01:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E3287005
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 01:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702944112; x=1703548912; i=xypron.glpk@gmx.de;
 bh=MuU4rkMgIBBIRsIvRozFXWSQQ3mCU6fgfJ9Bh1Eid7A=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=ea/B4IdzXBGm7ZmtDp65hIiVJS9KHA0w6V1AJJXcqe5KqitvhguYx8qdhQ1kArs8
 QV7CRQyk4fmcFF6BG9uulM08E5b26PDS/qi4us+rnL7o4rmyk8xlhqgy/DNeZdPAm
 q8ObYRJx/Jm7T2uapZNp4CvTTW4GehWvwESqe+HvNQRdOfoLMxpLs9DKnPBdYneeC
 UQL2u0ceugOXX0ZDvmyiX3sBEO20OrcgSCJtK2Bos2IbesSgCmzoAnXRuHj4hxUJo
 Y/3+j3LkdYBmgmXMptPKtWFIdUefRLjMArfc706v/WYzzwAnWWRmkldhQqpJ3Q/gB
 uX06HSjySJhaxqp9+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1qnAbq0lK6-00gXa9; Tue, 19
 Dec 2023 01:01:52 +0100
Date: Tue, 19 Dec 2023 01:01:51 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
User-Agent: K-9 Mail for Android
In-Reply-To: <20231218233130.GP2513409@bill-the-cat>
References: <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
Message-ID: <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BKFdmUVn5EdcbPEmNeElB2SrKQOtI8zZYXKmwtKE/zfmf66Whyi
 UraI0ibJxxP45mXp+h/ZKtAqRVmtFAPC5UJO//dVB+z6xHCFlCsFaP3fPz0jWE4YX8oj8KQ
 GPf/m42p0pw7CAulWy/LUBT2Gmr3BvaaxsCYeC7j5xx4cMUL+eRRqgoC8ye+xeWVre0RCsn
 h9nVj3ZkZhuYlic3AHZpA==
UI-OutboundReport: notjunk:1;M01:P0:gS6qLBulBAs=;WvojsTzhpHKGdL+1ruVLHb7/f8N
 9nZTGNfuxxsKD/ulv9rpS0ayvp2L9uvzlyekOUmqMkF0dvsMwP8Y/QYT5UlNDJ859PlK3nTCb
 DQFuZXG1yPYPHtKB1/aRLtRcL3ODSz0VzR2druJ8BWryrH6phnJTyR7HoTMyHmB+mO0DzRjVS
 h5cpZdLWyFUi3+VXjn3HveG7E+GT0LtrQnJ0NlBlm8DRdPnagRG2XV1axAZvSVjzFjTU/7Acp
 GW/MxsI4YvMDwtIyjF2tKZ+Ju1C6jQwDe2xXU8Var1YReiL7UGuoOKiJ9xcD3KohgZz3oQCY4
 ITeCYJ8+o0mh3dk9u4BbOavGdEeS87X8eEKto93MIXqpvO0FC9WoNTSCEY2zV/QLNOscbkCC8
 FasXVD0zN9YgvwFW85Nfx8Z6v2IWsa4Z3TfBWdoK02bYUNePQbXrWBNTB5mNnKWcpAp3Q2Q2B
 jpOC9oXTVM5UKslP0So7xBLUbW2YNFoS7kMhiVV5gysVFI79ciVWhAxhqeqHN034blE5dplm0
 EzO4IL3JXD/v38790a1XijZ2vVzxEGsdyETDtDpfh9msG4AJ0u9zt6+W1IMnGf4unqrZRKpsr
 F6kgi91dsJUaYXDz3byZXrawbE+7xceNyqTBWgvktYIRh/hEY9lQnrbm5BMOLPiA5nYSuwOgK
 PCpRFEbw9wYXB8kaSg6oIs2j9txPmprFgEQVrcK1bT8AqV0igPAscUaAdUPlBi1wIXo7x4PMk
 EVrnaaVrNbSnwP7o1WGGrTg7a/frMr6j5DAUAhKp5pUwMqT98A3HdnEbjAbj/BnuoyAnkALEP
 No2wkJV/esb2juow5c5sq63bLUZziRL0wegk6iBmrqjZXfCCDq1xxamZdjO+M3R/ti7+l1ep5
 1oFaOqGxxv3+zEVCF3aB70XAgqUYm1Rp5qtzAgzM73swy1+ibR81KmP6DB0PVjgvJniVoTvv2
 mEH2iQ==
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



Am 19=2E Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko=2Ecom=
>:
>On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote:
>>=20
>>=20
>> Am 19=2E Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko=2E=
com>:
>> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote:
>> >>=20
>> >>=20
>> >> Am 18=2E Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
>> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote=
:
>> >> >
>> >> >[snip]
>> >> >> Or take:
>> >> >>=20
>> >> >> load host 0:1 $c kernel=2Eefi
>> >> >> load host 0:1 $d initrd=2Eimg
>> >> >>=20
>> >> >> How could we ensure that initrd=2Eimg is not overwriting a part o=
f kernel=2Eefi without memory allocation?
>> >> >
>> >> >Today, invalid checksum as part of some part of the kernel fails=2E=
 But
>> >> >how do we do this tomorrow, are you suggesting that "load" perform
>> >> >malloc() in some predefined size? If $c is below $d and $c + kernel=
=2Eefi
>> >> >is now above $d we can throw an error before trying to load, yes=2E=
 But
>> >> >what about:
>> >> >load host 0:1 $d initrd=2Eimg
>> >> >load host 0:1 $c kernel=2Eefi
>> >> >
>> >> >In that case (which is only marginally contrived, the more real cas=
e is
>> >> >loading device tree in to unexpectedly large ramdisk because someon=
e
>> >> >didn't understand the general advice on why device tree is lower th=
an
>> >> >ramdisk address) I'm fine with an error that amounts to "you just
>> >> >corrupted another allocation" and then "fail, reset the board" or s=
o=2E
>> >> >
>> >>=20
>> >> Our current malloc library cannot manage the complete memory=2E We n=
eed a library like lmb which should also cover the memory management that w=
e currently have in lib/efi/efi_memory=2Ec=2E This must include a memory ty=
pe attribute for usage in the GetMemoryMap() service=2E A management on pag=
e level seems sufficient=2E
>> >>=20
>> >> The load command should permanently allocate memory in that lmb+ lib=
rary=2E
>> >>=20
>> >> We need an unload command to free the memory if we want to reuse the=
 memory or we might let the load comand free the memory if exactly the same=
 start address is reused=2E
>> >
>> >Our current way of loading things in to memory does not handle the cas=
e
>> >I described, yes=2E How would what you're proposing handle it?
>>=20
>> If the load command has to allocate memory for the image and that alloc=
ation is kept, any attempt to allocate overlapping memory would fail=2E
>
>So you're saying that the load command has to pre-allocate memory? Or as
>it goes? If the latter, in what size chunks? This starts to get at what
>Simon was talking about with respect to memory fragmentation=2E Which to
>be clear is a problem we have today, we just let things overlap and hope
>something later catches an incorrect checksum=2E
>

I don't want to replace the malloc library which handles large numbets of =
allocations=2E

Closing the eyes when the user loads multiple files does not solve the fra=
gmentation problem=2E

Fragmentation only happens if we have many concurrent allocations=2E  In E=
FI we are allocating top down=2E The number of concurrent allocations is lo=
w=2E Typically a few dozen at most=2E After terminating an application thes=
e should be freed again=2E

When loading a file from a file system we know the filesize beforehand=2E =
So allocation is trivial=2E

The loady command currently does not use the  offered size information but=
 could do so=2E

TFTP is problematic because it does not transfer the filesize=2E We would =
probably try to allocate a large chunk of memory and then downsize the allo=
cation after reading the whole file=2E

We will have to review each file load method individually=2E

Best regards

Heinrich
