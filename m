Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD1C3ABA0
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 17:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C112E8852A;
	Sun, 15 Sep 2024 19:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KwZHEmmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C303588E18; Sun, 15 Sep 2024 19:57:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B4D8843A
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 19:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726423043; x=1727027843; i=xypron.glpk@gmx.de;
 bh=uhKzKesWHGwJIOiL3SqibzT2TRz09vefvmz5VUEU918=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KwZHEmmKkV77gHdfxi46Gd/k3e4J6U4aoQI6KCpBhkf+KRd0P1Or6bftP0GsskmZ
 AbPNapJBCa/M14JNgPCbTaBuSj8StufuVm48qPwYieW92GsaoPoMXBS8GA3qnVlEo
 s0CfSol1phEejLJAKlliGrjfF8Q1R7FN5KJsjJdY3lI6dyYbCO4uGIDCkfFaHTUgn
 Jnow/6+pLG3KlwnwUZCfgoRe+WT+n2QIwbQXr2QjEWD/vi1n7Dc1P/wVxsA/Uy9dv
 O67H/MVYZjUPUcUTMAYgNiMb9ANuEnjX6iRimulz7ZZBkbZj74S8/T+Dcfu5zjVl+
 1feONKeXR9LqwEFiXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1sS1w544AR-00Pt68; Sun, 15
 Sep 2024 19:57:23 +0200
Message-ID: <93c2ab53-aa9a-4403-80da-7bd6d8872b3c@gmx.de>
Date: Sun, 15 Sep 2024 19:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
 <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
 <20240826195924.GM2479150@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240826195924.GM2479150@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bw4ONsTCzMvPtOhz55glRTMPx0I9cvDWj/yet7aOz9Cryhvf8Hb
 wcPqfmLm+KhV7V2lxNWGOV4I5dTf4+dcL6Fly0n68GF9XWZUeLgawcGUcWxHyQJu9KwFZFN
 Yrw2DIO7qHywj2t44yF0Tie3x1CdRHgYTkcBW0iYJMXEXIIodo1ne2wiNYXer7Hu/L8pN+9
 k/ld38B9e/kNxMfc8CZ4g==
UI-OutboundReport: notjunk:1;M01:P0:DVcemOt1wOI=;maqBOPwMBQJcoxarIjIlSo9ItaZ
 eGoYzt6cfMx+C8Gw0GRQEIj6XpSM/Vug68eRzc3DUqGs62SWnvXsJF3iqNewUC8RJcX/X2lS+
 TZY4oeq5yFDLGuK/BQ3zD/VCROHDq0L4zDof0EJLSsVThsSQyyUbKNeDafmT+zvIN8jSYyErT
 QudG40PCuyfld50dTQRb2n1DoqCOErKe9w04ejXx9DO2XALZUxPoJrc9QGywakE4zy4HTBUkV
 o4BQTFn0AwByzfCfOjqZ7UweTrwCXGOAM89n0aZJxxF6HExD0wzI4bSPpWQwqWmneppffWFrk
 n/LNo0F+PVLrsMLzGjzI7zKa+tn01HDP1dSr+O0xhU2/QjDEFANt3lm3LKrjEYX0a2/VDiWM/
 6kLTNQVKwD2y9FsPSf2dytvNFYBU9joJcpM2qoW8uJX4QvcHSygssEIRfsD76pgzdhPzHebMz
 0lG6N2gdfLh0COyrWP8gNkvAFrZ5AHJvFJMF+8zpk8jrfWyzNwN6SKrj8wFDpIoD4+hZnyRcQ
 mkZR1/kK9Uh2xl22Q7AzEPT7NhhN6XODMN4eOItu5dj8dQ97YZVmPZMve5a7bvBOCN6UzteFw
 Djeyf6p+88sz2CpLNjNZwU5wV1sUx+k1DOPhB95Csyzwh25qp9vUpKtt6IaxzgZSsGeYmK9yu
 L+jbMZpOgDzEc7O3pwu9KCZUyN3kmwaN7cVw6ca5nyPtdIEIxV32Wa/bqMHU/SGNZ8lU5yXCh
 YMwfmfGc37AuZkgz9/vVABeZ4LLnxbG3zi+r8yQQh2ULa9ORwcAaJnfMqpcVucKm26GcWF4xX
 vbsY3gZljqJ+5KRwwNUZNZhQ==
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

On 8/26/24 21:59, Tom Rini wrote:
> On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
>> Hi Tom,
>>
>> On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
>>>> Hi Caleb,
>>>>
>>>> On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.o=
rg> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>>> As a general comment, this is adding a load of code which is used b=
y a
>>>>>> lot of platforms. As more and more aarch64 platforms are created, t=
his
>>>>>> data grows. Why not use the devicetree for this hardware informatio=
n?
>>>>>> That is what it is for.
>>>>>
>>>>> This data does not belong in devicetree, the various system register=
s
>>>>> exist to describe this information... Putting it in DT would be
>>>>> duplicating it.
>>>>
>>>> I am not wanting to duplicate info which can be read from system regi=
sters.
>>>>
>>>>>
>>>>> Using DT for this would additionally require having bindings accepte=
d
>>>>> upstream and for all SoCs to add them. To what end?
>>>>
>>>> To get the correct information in there. How are boards supposed to
>>>> add SMBIOS info? Do we end up creating a whole infra in U-Boot just
>>>> for the driver to read it out? It just doesn't make any sense to me..=
.
>>>>
>>>> Let's put hardware info in the DT where it belongs.
>>>
>>> I'm a little confused here because of some older threads on this overa=
ll
>>> topic. Part of the issue here is that in user space, "everyone" has
>>> SMBIOS-based tooling today, and wants to have that work, rather than
>>> inventing new tooling or modify existing tooling. And you were concern=
ed
>>> I thought that we had tied SMBIOS too much to EFI being present when
>>> indeed it should be possible to pass the location along to the OS
>>> without EFI, but at the time Linux at least only supported that notion
>>> on MIPS I think?
>>
>> That is a whole other concern I have, that we are perpetuating this
>> legacy format which is a real pain to work with, when we already have
>> devicetree. Let's leave that issue aside as I have not detected any
>> interest in solving that problem, or even any agreement that it is a
>> problem.
>
> OK, yes, lets set that aside.
>
>> But for this particular series, I am just wanting to get the correct
>> info in there. Having the CPU-detection code provide an opinion about
>> what type of chassis is in use (just to take an example, the patch
>> pieces I highlighted have been dropped from the email I am replying
>> to) just seems a bit daft to me. Only the board vendor would know that
>> info.
>
> Yes, I agree the detection should be reworked a good bit as some
> information will be board design specific while others SoC specific. And
> we should avoid adding many unused at run time strings to all platforms
> that enable this too (looking at all the CPU vendor related stuff).
>

I doubt on productive machines there will be much use of U-Boot's smbios
command use. It is more a developer tool.

For reading all the details we currently have
lib/efi_loader/smbiosdump.efi which can dump the SMBIOS table to a file
that dmidecode can read.

Maybe instead of adding more and more decoding logic into the U-Boot
smbios command we should add an smbios sub-command to dump to a file.
This would be less of a hassle than running an EFI program for the same
purpose.

Best regards

Heinrich
