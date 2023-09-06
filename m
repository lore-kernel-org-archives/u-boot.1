Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBECEE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 00:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06097865A5;
	Thu,  7 Sep 2023 02:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gPo9yCYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB6086682; Thu,  7 Sep 2023 02:12:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2323186308
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 02:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694045517; x=1694650317; i=xypron.glpk@gmx.de;
 bh=gEJZYggeyRimXwvEe9uvmeQijqH3/iYEs/dt+yHDqB4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gPo9yCYR8SOQzOwEVhAt1zxRRO3bslm7xyo34wXthVycbFFZ0iCRXNcTgJVSpVm81JNBm/+
 vCOHSRNiExH9j6GlCdwG/lmCK4aSIkkkE7dKkHrUl1h2PzNFRg99LzmbKH2WsTsCsuE5jhQem
 I6XCRbnYjTRN9+HBusjycHSCnFdeJh9nhswxMa+c7B0O5NK52Ut5UFuikQ7MAsiMx+rAY9mn/
 rG06znV46cWEs2dDzXl5tDp8CFqgzVM6QhXkmZguJ35DMBJCLdtGyniD7jwQrqEuRC/MV3k0n
 /AMRClCvlQ6Sx7ZrCdXxXLoh7Qt0xUyHPiHF+JU7s2GreVbTUTew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1puXqb3qWo-00kuBR; Thu, 07
 Sep 2023 01:29:00 +0200
Message-ID: <e7a3a0f4-7cd6-40e3-8c1f-84ad3304d3b7@gmx.de>
Date: Thu, 7 Sep 2023 01:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
 <20230906220416.GK305624@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230906220416.GK305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CaKVOJ3ab94XljpnZFV1f7bMAKc8ZMZ5OiI0xfm1wk2BciDd0dP
 MLGb6qPvAtiD+rcdzIh6pvzDqEZx+D+GiX0B5bd6LZP7lizIPliC/Z3KYBHYsEuLGjz63lQ
 YSYOx2pqRVYAhquuIALOQclzPw0CkmJfxXgeU9Onk/v3DrExlzRCivD2Pr6lroFhriEGVkD
 WuhcavdiVZDmh8GtUr40w==
UI-OutboundReport: notjunk:1;M01:P0:OSDPl18IGuA=;Ayky+3exgbznC+c+PeWkiI1PKlx
 EL83Yo63AG2gNtZ3fRKWRpm6uj0Y89qZb2OZ2V3dEdsmNybNUfnBStaP5u33n0Zqz61PaBsOL
 HAJ42MNLtNclYUaEQqB/w3t67QeaDsNZ7PqrhAulzQf7COoB6qdE0eg8N+LQ7iRZkCPWSLdPG
 /grD9ripkSQ+LAI50/py0Hmx436IsFw2LQzWReUU/7Hzv3FkwJoKksZ9MaA56hxUf2riowEE+
 CC6gCxdLlfE4q8mqYp65zG2uYOm8hRn3z6EMYl5r43r7R1IsJEDlpqUNimJg4uFJ8bmanxcsI
 aGjlLHSjp5j6UUo3HWartlZKDKN6KSIxpItkQQOFtJ6DM7AUQ/hEVzSwgQAJpAwAK9MdDCGwa
 MHB0War/hTmYt6G8abblhoaGMWHV3nE579f9j17r6v/v6vTWh3ktlEbK4B81vkY3pU+yv5Esv
 rk+7P/KXd4+GpKKbd5BrwUMZdj42jiWPAx3xLjjF3Siw0UGOFzPqXSVV0NPOGMzPK5K6pzl3G
 GXipEwbBTjUjwMBOjs6T80Oq0lcF3bvqiGVKrR6VrbhXHoGGrXk2Xkg0AFMiWALX/yDZvMVlz
 0ecq5xJSaD9Dhp/a22pWSZxgvZxFM9OiCaCnJvoAg/SGVdTuyXlIOTH7ZZTDU5udKYncNSTxF
 M77Hv9/M3I5fzya69G0SJAMCArHnwDAIIZ231GjLMY9Hy1zB3X0frz42txS/iO4fcHsUqBg3y
 XllZSlX9aIkSFByYxzDHPnzRL6PT+sD3+xA6dIeVKoo3qLwejZymgzyaFh+uzI9ltKtbKs9PO
 IqtZgbaaLXmhSDVjIA3K1mRG3bHS9ayP2zxxUuo3lU6AWHIDhtWDwJil05jQFIo2KcAROpslY
 QXo08a5icWxtca6EzTFrqJKFYbHbiNJVlKOzNQnSb9ahlBbQGiuyJPhaB2eIFt8L8j/OOuUgY
 iGICqlVRceEJ067b/7CrtgvnYFM=
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

On 9/7/23 00:04, Tom Rini wrote:
> On Wed, Sep 06, 2023 at 09:21:39AM -0500, Rob Herring wrote:
>> On Mon, Aug 28, 2023 at 04:09:29PM -0600, Simon Glass wrote:
>>> Hi Peter,
>>>
>>> On Mon, 28 Aug 2023 at 14:29, Peter Robinson <pbrobinson@gmail.com> wr=
ote:
>>>>
>>>> On Mon, Aug 28, 2023 at 6:54=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com> =
wrote:
>>>>>>
>>>>>> On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.or=
g> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Provide a way for removing certain devicetree nodes and/or proper=
ties
>>>>>>>> from the devicetree. This is needed to purge certain nodes and
>>>>>>>> properties which may be relevant only in U-Boot. Such nodes and
>>>>>>>> properties are then removed from the devicetree before it is pass=
ed to
>>>>>>>> the kernel. This ensures that the devicetree passed to the OS doe=
s not
>>>>>>>> contain any non-compliant nodes and properties.
>>>>>>>>
>>>>>>>> The removal of the nodes and properties is being done through an
>>>>>>>> EVT_FT_FIXUP handler. I am not sure if the removal code needs to =
be
>>>>>>>> behind any Kconfig symbol.
>>>>>>>>
>>>>>>>> I have only build tested this on sandbox, and tested on qemu arm6=
4
>>>>>>>> virt platform. This being a RFC, I have not put this through a CI=
 run.
>>>>>>>>
>>>>>>>> Sughosh Ganu (5):
>>>>>>>>    dt: Provide a way to remove non-compliant nodes and properties
>>>>>>>>    fwu: Add the fwu-mdata node for removal from devicetree
>>>>>>>>    capsule: Add the capsule-key property for removal from devicet=
ree
>>>>>>>>    bootefi: Call the EVT_FT_FIXUP event handler
>>>>>>>>    doc: Add a document for non-compliant DT node/property removal
>>>>>>>>
>>>>>>>>   cmd/bootefi.c                                 | 18 +++++
>>>>>>>>   .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++=
++++
>>>>>>>>   drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
>>>>>>>>   include/dt-structs.h                          | 11 +++
>>>>>>>>   lib/Makefile                                  |  1 +
>>>>>>>>   lib/dt_purge.c                                | 73 ++++++++++++=
+++++++
>>>>>>>>   lib/efi_loader/efi_capsule.c                  |  7 ++
>>>>>>>>   7 files changed, 179 insertions(+)
>>>>>>>>   create mode 100644 doc/develop/devicetree/dt_non_compliant_purg=
e.rst
>>>>>>>>   create mode 100644 lib/dt_purge.c
>>>>>>>
>>>>>>> What is the point of removing them? Instead, we should make sure t=
hat
>>>>>>> we upstream the bindings and encourage SoC vendors to sync them. I=
f we
>>>>>>> remove them, no one will bother and U-Boot just becomes a dumping
>>>>>>> ground.
>>>>>>
>>>>>> Well things like the binman entries in DT are U-Boot specific and n=
ot
>>>>>> useful for HW related descriptions or for Linux or another OS being
>>>>>> able to deal with HW so arguably we're already a dumping ground to
>>>>>> some degree for not defining hardware.
>>>>>
>>>>> I have started the process to upstream the binman bindings.
>>>>
>>>> I don't think they should be in DT at all, they don't describe
>>>> anything to do with hardware, or generally even the runtime of a
>>>> device, they don't even describe the boot/runtime state of the
>>>> firmware, they describe build time, so I don't see what that has to d=
o
>>>> with device tree? Can you explain that? To me those sorts of things
>>>> should live in a build time style config file.
>>
>> For the record, I tend to agree.
>>
>>> I beg to differ. Devicetree is more than just hardware and always has
>>> been. See, for example the /chosen and /options nodes.
>>
>> There are exceptions...
>>
>>> We need run-time configuration here, since we cannot know at build
>>> time what we will be asked to do by a previous firmware phase.
>>
>> Really, I don't want to have to care about the binman binding. If it is
>> u-boot specific, then it should stay in u-boot. I took /options/u-boot/=
,
>> but now I'm starting to have second thoughts on that being in dtschema
>> if it is going to be continually and frequently extended. Validating it
>> in SR does little. If a vendor is abusing /options/u-boot/ in some way
>> they could just as easily remove the node in their u-boot fork to pass.
>> SR is certainly not going to require the node be there.

The missing piece is validation of the U-Boot internal device-trees
against a schema in the U-Boot CI. This should be possible even if some
of the schema yaml files are maintained inside the U-Boot repo.

Best regards

Heinrich

>
> It's going to continue to be a "fun" tight-rope to walk. No one wants an
> easy way for vendors to cheat the requirements which is why in some
> other parts of this thread (you may or may not have been on, I don't
> recall, sorry) I've been trying to make it clear that the removal
> mechanism should be both a slight pain to add to, and at least wrt
> upstream, clear that effort was made to upstream things.  Cheaters are
> going to cheat and they could just chain a bunch of "fdt rm" together to
> do it today.
>

