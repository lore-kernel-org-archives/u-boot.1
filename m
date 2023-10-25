Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C608C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 20:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1634887A5B;
	Wed, 25 Oct 2023 22:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nY5yksj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E744987A70; Wed, 25 Oct 2023 22:52:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B263787A39
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698267159; x=1698871959; i=xypron.glpk@gmx.de;
 bh=xlGlL/ZzXpeDi9jRtfB5Kyuj+/8ItT7e5Kh14v1T3CU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=nY5yksj3OHOudyu9TB8QsjspoXvZc0yuK5k/FsJ+VdectJ1aKjHtmjCExokIhWeh
 RJdt+vegnxP9HAfRQ+YYj6hj2kytAtzc5C0js9VGOhKfpD8FoLFv6d1x85UDV8DqY
 viF48QSS4pYzIC1zNyXUHgxTuz27RynUhq7+ZiGigjTpagT9MFyhxhvUZh0kGSkqU
 eVshZaIMB490DVBLqP0cmBvsOUvvw8Bg1oSiig6lnO7kXGMFT9pM0bKVefMvMQK6R
 2FpvLA9DlmpUHk7A8xrFN8oIzw0BzILjTrOKCpz53I6AD6jq66ABYNRPZTHUHSbTT
 5nwkT7H7358ERwV6bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1rGJ6w0J1p-00q8N1; Wed, 25
 Oct 2023 22:52:39 +0200
Message-ID: <e05c870f-5522-4194-92d5-82e5c9808169@gmx.de>
Date: Wed, 25 Oct 2023 22:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
 <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
 <20231025170956.GU496310@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231025170956.GU496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pNw4dHUYPG5U80oGHUnkLKsXqc0hVahDGMbFa/WX7Q9JygUaGk
 yG8pqO9J85ID+RNaTCuLt/hIH0HR6kETWf0EJUM26agAkUuWDuEfNLG9f9VSDHE1SH6/g3H
 C3NjkqmbNRMVrhwSjzmlZFUhM+AFTaElcFlxHJDjnnrRWZidNLRsrFGA4cTwcpojXkliqNB
 PiHSnV9VpF0sjzZwwHxqg==
UI-OutboundReport: notjunk:1;M01:P0:rpJH8oeRaDM=;RVNQDXNvyhCvHGgwcua76L/qH9i
 YqWM55vXVi7yxUSrw3GwKYbMJrvHbsvKQWgO9Rruzu/VU14crX2Q5uNXSGSw379aAC4e+fKwE
 16pxgSqPtn3y22c2ll3KjwbCD5zCaxUq/SUTTERy+scaJHHVmn7llJdgVno641gxY2IMPNJgM
 ut2eRmmlu6fMq2ZfdhzIvK6bZNtR1TJxSbOvEM1gJojoal9p8AFhRE76N4alqdjC4Q4k3tIPz
 JyUB2O55rT0lzFx0ZNj8NKnSp2U5HHGk31E3bhbq2dA/SbxO23qXhnRVO0nTtEVHGjNRjY1Qd
 /I4uPOAjCUhBvm8l1UTyPUb7zwmvcQgI/O+/8H48BQ2HXg4nufa4QsaQ1iUZheEkzGHfke3N9
 rbq0kC/YqL+zJn0R686I3gMSQpU0vXF0inp3NpO5ysOzc5dp0rQCjgujVj7Gorqt3Yka4baZs
 nukC9Hm8KgLYOSvnfT6oc4PrZhDvlSv8nOfwJ0CQxv3cojFFP1HPPQP9ziAp9B//9eMOXmN2u
 KH8WirBoIa9/8o6QQ/wVQhIJzMSuY5b9/HMgTiqKb+EJCwB2Yp9rD8hcAmdA9KZcbANLo4uSV
 itzhQNrZqJTEcTvs335tjHq0LdIYIh7dIPGtEldnTjHqvWA5mcTr97LKPuxDLNykV7ZxLaZ+N
 iymPeNLGB2ylEaypaqanr5lGa/4R4y+CFPK971cIWnUA6n+1yZDrDMM9Fr3F+yVdKavUIhe+Y
 yKo8LEvug4GDhTscLvK//ccOkcVx3bxaPiumYgriyAf6P+y6q+ReBB2bmCn9fU2tehIAbwOMh
 8mJS2kGp9/3j5gmPfWGauHKl0ZsC7sT0QN5WILdR5wBtIGqK07ntykaKaEVuMJnyeDn0jGNCC
 753zmcR7B8dk4aTAO+x+zl96zCGKaPUgpw/LPlmAAvkKxfn1mIP265juW9uWzNfRHxSV6shIe
 rynYQxpIaFmE0afAgIt8HvuG1cE=
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

On 10/25/23 19:09, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 05:28:10PM +0200, Heinrich Schuchardt wrote:
>> On 25.10.23 16:28, Tom Rini wrote:
>>> On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
>>>>> Date: Tue, 24 Oct 2023 18:34:05 -0400
>>>>> From: Tom Rini <trini@konsulko.com>
>>>>>
>>>>> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
>>>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>>> Date: Mon, 23 Oct 2023 00:04:14 -0700
>>>>>>>
>>>>>>> Hi Caleb,
>>>>>>>
>>>>>>> On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
>>>>>>>>
>>>>>>>> Hi Simon,
>>>>>>>>
>>>>>>>> On 21/10/2023 01:45, Simon Glass wrote:
>>>>>>>>> U-Boot typically sets up its malloc() pool near the top of memor=
y. On
>>>>>>>>> ARM64 systems this can result in an SMBIOS table above 4GB which=
 is
>>>>>>>>> not supported by SMBIOSv2.
>>>>> [snip]
>>>>>> There is absolutely no guarantee that arm64 machines have memory be=
low
>>>>>> 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opte=
ron
>>>>>> A1100 SoC and all the recent Apple SoCs.
>>>>>
>>>>> So one thing to resolve here is where does that requirement about th=
e
>>>>> SMBIOS table needing to be below 4GB come from (standards wise), and=
 in
>>>>> turn is that obeyed by consumers like say Linux or OpenBSD? Answerin=
g my
>>>>> own question, maybe in part, https://www.dmtf.org/standards/smbios r=
eads
>>>>> to me like there's a v3 and maybe we should be doing what we need to
>>>>> support / identify as that, if it doesn't have that restriction?
>>>>
>>>> Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete an=
d
>>>> uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So t=
o
>>>> fix this U-Boot needs support for SMBIOS 3.x.
>>>
>>> OK, thanks.  And for clarity / repeating my confusion, at least right
>>> now we also set the major/minor in the struct to 3.0.
>>>
>>>> Personally I don't see why we'd need SMBIOS support on non-x86
>>>> platforms, which is why implementing this isn't a high priority for
>>>> me.  I simply disabled SMBIOS support for M1 for now.
>>>
>>> This I think in turn (based on Heinrich's emails in v2 of this patch)
>>> EFI_LOADER wants to pass SMBIOS (probably 3) information along so that
>>> human user facing tools can see the kind of info that table provides.
>>>
>>
>> If you have to manage a fleet of devices, be it Apple laptops, small
>> servers or IoT devices, you want to be able to retrieve information
>> about these devices like installed firmware, serial numbers, etc. This
>> information should be presented by our SMBIOS implementation.
>>
>> Other EFI architectures (ARM and RISC-V) target the same markets as x86=
.
>> The customers expect that they can use the same tools irrespective of
>> architecture.
>
> Ah, we do have serial# being passed along that way (as well as other
> methods which is why I didn't think about them for SMBIOS). But this
> also doesn't answer my bigger concern which is that we're setting our
> version major to 3, our minor to 0 and then filling in a struct that's
> not the "smbios3" one that Simon's patch from another thread added. Is
> what we're filling out today semantically valid? I'm hoping someone who
> has already read over the spec / is familiar and I don't need to go do
> that right now.
>

First of all there is a field "Anchor String". For a 32bit structure it
contains the value '_SM_', for a 64bit structure it contains the value
'_SM3_'. The different EFI GUIDs relate to these two different
structures. In our mails we simply referred to them as SMBIOS2 and
SMBIOS3 structures.

Next there are the fields 'SMBIOS Major Version' and 'SMBIOS Minor
Version'. These should refer to the standard version 3.7 if U-Boot
adheres to the current version.

As RISC-V was only fully added in SMBIOS version 3.4 we should not use
any older version of the specification.

See
https://www.dmtf.org/content/dmtf-releases-smbios-37

Best regards

Heinrich
