Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6EDF3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947E18419C;
	Sat, 11 Apr 2026 15:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BaF7Ney9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DBD8416F; Sat, 11 Apr 2026 15:43:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6135084118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775915017; x=1776519817; i=xypron.glpk@gmx.de;
 bh=xawueAux5RKOOjJv5pCpy3oNJVxJgZ0vnycAcAvi9PE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BaF7Ney9v4SBSCZz/1T6oqE5EYv9qQq+dXFAtUuoDMpUtD8pMqacLuaVC9CJz8+r
 WqdsIDb5v2cz1ni775y2STeFzUCSUp9WtGReo9aaEUyOivlC+IEgVnv0N79glM8cJ
 vku6aP00IzUIceHrEnpozQ/uqH9gKBtbyicbykhq8/U3A9jqVIZYXyQB/0IXnBGXo
 VqHRs9Z7IAAwJfbNyhesCAvMGA6iH6zevsg5qIjwdPfJtx6Kz6BGv8Gc4P/jw3ZSB
 TK+4v+nzXUV6vgaeHBX7oqKZb+gYrP6RGXn4CQWyHNwOvUqg0DzoxVgBBTts+dBM9
 Cqi6zD+6Xf/H+welsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqaxU-1vgumP0ElM-00kBRu; Sat, 11
 Apr 2026 15:43:37 +0200
Date: Sat, 11 Apr 2026 15:43:32 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Gary Guo <gary@garyguo.net>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Javier Tia <javier.tia@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTiLZamF1ySMhtGOqJdzCrYdTRyUvFKu2s0h+ms+EgOZFg@mail.gmail.com>
References: <20260331191853.44549-1-gary@garyguo.net>
 <CAFLszTj-QRQBCZHNCyM6YR7n5M4+myr8ztDo6Xn9CfDb6=ppSA@mail.gmail.com>
 <DHJMTRNSOX3S.2LQPF5ATDP78S@garyguo.net>
 <CAFLszTiLZamF1ySMhtGOqJdzCrYdTRyUvFKu2s0h+ms+EgOZFg@mail.gmail.com>
Message-ID: <1B3F85B0-08DC-4157-88FD-D69566AF045A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KGr/Yn9pMB/nDLqVEoOkPu9sRwBT+Uja7Kbq+0J4JizdseQgdFG
 QHUI6x7nBVDlKpjOpi3nSxcRR85JLFtOK/E39WwKDm/39a7ogs6WIgED7+UoLsq4KI3NqoM
 b1YJUGuRd440R3W6I+hSblWwhGkUjCmXylsbHCwvotiJdF4JCJ53Gyd5+Y7fwEZnfLERC5e
 J5kfGf4V5UD/PzZ0rZTJA==
UI-OutboundReport: notjunk:1;M01:P0:5J+8JB8EUcY=;19+vSRPm1gTHTdQA9UV6c9D/INO
 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
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

Am 3=2E April 2026 18:31:14 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Gary,
>
>On Fri, 3 Apr 2026 at 09:41, Gary Guo <gary@garyguo=2Enet> wrote:
>>
>> On Fri Apr 3, 2026 at 2:22 PM BST, Simon Glass wrote:
>> > Hi Gary,
>> >
>> > On 2026-03-31T19:18:51, Gary Guo <gary@garyguo=2Enet> wrote:
>> >> efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
>> >>
>> >> EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_=
UI
>> >> indicating that the OS (or next stage bootloader) requests booting i=
nto
>> >> firmware UI instead of continuing autoboot process=2E
>> >>
>> >> Support it by having autoboot=2Ec asking EFI bootmgr if boot should =
continue,
>> >> which checks and clear the bit (so the next boot continue as normal)=
=2E
>> >>
>> >> With this change, systemd-boot will show a "Reboot Into Firmware Int=
erface"
>> >> option which will be able to drop back to u-boot=2E This can be usef=
ul if
>> >> bootdelay is configured to be -2=2E
>> >>
>> >> Signed-off-by: Gary Guo <gary@garyguo=2Enet>
>> >
>> >> diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_boo=
tmgr=2Ec
>> >> @@ -1290,6 +1290,51 @@ out:
>> >> +bool efi_should_abort_autoboot(void)
>> >> +{
>> >> +     efi_status_t ret;
>> >> +     u64 os_indications =3D 0x0;
>> >> +     efi_uintn_t size;
>> >> +     efi_status_t r;
>> >
>> > (I'm leaving the proper review to Ilias & Heinrich, this is just a fe=
w
>> > nits and a though)
>> >
>> > Please can you use a single variable name for both efi_status_t varia=
bles=2E
>>
>> Ah, I think I copied the init part from somewhere else and forget to me=
rge the
>> variable names=2E
>>
>> I'll adjust the variable name in the next version after receiving more =
reviews=2E
>>
>> >
>> >> +     ret =3D efi_init_obj_list();
>> >> +     if (ret !=3D EFI_SUCCESS) {
>> >> +             log_err("Error: Cannot initialize UEFI sub-system, r =
=3D %lu\n",
>> >> +                     ret &

The return value does not help anybody to understand what went wrong as th=
ere are a lot of different failure modes=2E

We should write specific messages inside the routine and not a message in =
the caller=2E

It might make sense to have a generic translation of EFI return codes to a=
 string message in vsprintf=2Ec=2E Which end user would know what error 14 =
is?

Best regards

Heinrich

 ~EFI_ERROR_MASK);
>> >
>> > The log message says "r =3D " but prints ret=2E The similar message i=
n
>> > efi_bootmgr_run() just prints the value without a prefix=2E
>>
>> Sorry, what do you mean by "without a prefix"? I think the code is iden=
tical to
>> the one in `efi_bootmgr_run`?
>
>I mean you don't need r =3D in the message=2E You could say (err %lu) per=
haps?
>
>>
>> >
>> > I would also like to see the code which adjusts the variable placed i=
n
>> > a function=2E
>>
>> You mean the bit clearing part? What benefit does that provide, conside=
ring that
>> this is just a single function call?
>
>There is reading and write=2E Being able to control that could end up in
>a command at some point=2E It is a useful feature=2E Up to you though=2E
>
>Regards,
>Simon

