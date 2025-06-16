Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E477CC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C03F82A0A;
	Mon, 16 Jun 2025 18:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="EoMkfP2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE45382B18; Mon, 16 Jun 2025 18:44:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D27F81E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750092269; x=1750697069; i=fiona.klute@gmx.de;
 bh=fI2RcJl9qd14hXIYYyqL4S9kZfeYyGUqra+vmTR0Gaw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EoMkfP2w0Ao4cvXC2o8VmI9j5A9KCk8UlCfOoGaquBvtNGFtvHlew+4LNThRAOJH
 DHhHwRLzHqcjzE7Ry+QYGpZt64KQ1skopQlSt7pDLvsFbnEHWT2vXjteB5KZQtlSo
 iysK/xt57gdOeahBf4bkLtXDADAMSGN/W6fidAjjVKzGCQCbHPNQs4h1lcNztNG0/
 eyc7GfYuFgvxrz+xNVfFNbITCZhlDE1sQoASS3dhX5drmKQirXVyoc0CosDTmDh5T
 q8btIJJuJE+3auDcFeFQ2vSO2OHgFB1PDITduRUZYgbsGip5LGur6hGn21qLAbEPr
 fEGyD51hlDFLwHd7ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.113.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1ulcNL0tGE-00znPF; Mon, 16
 Jun 2025 18:44:29 +0200
Message-ID: <35163bfb-2bb4-49a2-8d60-efe63fc9bbd2@gmx.de>
Date: Mon, 16 Jun 2025 18:44:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Raspberry Pi: copy /system/linux,{serial,revision} from
 firmware
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
 <CALeDE9Oumn2xO0MPq+L5rsv5NEAjL=XM8zRNA38uV+MbqkVrzw@mail.gmail.com>
 <8b8386f2-7a85-499d-956a-11a22b3cb10c@gmx.de>
 <CALeDE9ONxe=MUdt77eMxgEhj0SV1t8vMmQht4pQrc=_eMdfQGA@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CALeDE9ONxe=MUdt77eMxgEhj0SV1t8vMmQht4pQrc=_eMdfQGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vAW4uYYIGUttXQQznYsmCNzK6i1bNrXdK8UKnrId115OG64S+IO
 0g7ul3nDyN8ggiGcb9jVJJ1De6pwLjR/ZHuLmZhTyBKvyuae+B6ptsKfpCl90J6q4VPla8m
 Rtz0JXaoaYG/r4BldkGXB+l4KMHL4mwMx22yV26C+NSiQRqgehPJYGso5qYQCcKyxRC/09m
 7yZa2orD51SACwiNKKe1Q==
UI-OutboundReport: notjunk:1;M01:P0:h22C5ht24hA=;6wdHZVOVvgkDb7erPT6ZPw1kCDw
 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
 wpNCkgSRRR82PWWSNDc+v/Focs+s78aEeA0sdA==
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

Hi Peter!

Am 15.06.25 um 14:14 schrieb Peter Robinson:
>> do you have any comments? My main concern is if creating a temporary
>> overlay is the right approach here, or if there's better way to create
>> the /system node if needed.
>=20
> Apologies, I looked at this originally and my thought then was it
> needed more thought and then it slipped through the cracks.
>=20
> Off the top of my head I have a few concerns. I will have another look
> at this but to provide some initial feedback.

Thanks for your review!

> Firstly there's no bindings upstream [1] that I can see for a root
> system node so it's completely RPi specific and doesn't adhere to
> anything. I don't really want to be adding this to the kernel DT in
> this mode if it's not really verifiable.
>=20
> I also wonder what the value is if we end up copying large amounts of
> the FW DT into the other DT, why not just use the firmware DT instead?

Because that way the kernel and the DT it uses (no matter if upstream or=
=20
RPi downstream) can be updated together (e.g. in a FIT image), without=20
affecting how U-Boot runs (which uses the FW DT). For the system I'm=20
working on we have A/B boot implemented via U-Boot, so a broken update=20
to the DT loaded by the firmware could break the whole boot (requiring=20
manual intervention to fix), while a broken update to the kernel DT=20
would just revert to the previous boot slot.

> In the terms of the RPi kernel, again I think for that you'd be better
> of just passing through the FW DT as they should both match in that
> case, for the upstream kernel this won't make any difference. We
> already have the rev details in the model, we should look and see if
> there's a standard way way to pass HW rev/serial number through in
> device tree.

The /serial-number node already works just fine with U-Boot. :-)
I certainly agree it'd be better to have a standard (or at least=20
well-documented) way to pass the HW revision to userspace, but that's=20
not something I can make happen (at least not in the RPi firmware).

> In terms of userspace I think getting it that way in the example is
> broken, as it was in /proc/cpuinfo which was why it never made it to
> aarch64. but I'm not sure what details are being used there and why
> they matter for RGB LEDs.

To elaborate (mind I'm not saying all of this is necessarily good=20
design, just describing the reality I'm trying to deal with):

The connection to the LEDs is that they're LED strips driven using a=20
PWM-based protocol, and the rpi_ws281x code drives the PWM output of the=
=20
RPi board via the RPi Videocore to get the required timing precision. It=
=20
uses the revision to select Videocore version and memory addresses [1].

Rpi_ws281x gets the revision either directly from the device tree=20
/system/linux,revision node or from /proc/cpuinfo, but the difference=20
doesn't matter: The RPi downstream kernel is patched to add the revision=
=20
to /proc/cpuinfo from the same DT node [2], so if the revision node is=20
missing /proc/cpuinfo won't have the revision either. I'm not the first=20
person to bump into the issue [3]. Upon closer inspection using the=20
model might be sufficient for rpi_ws281x specifically. I left a comment=20
in [3] while considering your review and alternatives to this patch,=20
we'll see if they're open to it.

However, the Raspberry Pi documentation explicitly recommends using=20
revision codes [4] to identify boards because the "new style" codes=20
aren't just numbers but encode certain characteristics of the board=20
(e.g. model, revision, memory size). So people using other tools that=20
follow that recommendation in combination with U-Boot loading a device=20
tree will encounter the same problem even if rpi_ws281x adopts the=20
model-based detection.

Best regards,
Fiona


[1]=20
https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa=
388180da/rpihw.c#L42
[2]=20
https://github.com/raspberrypi/linux/blob/5aec9916361bc36455a4df34dfd37647=
2adeaaf6/arch/arm64/kernel/cpuinfo.c#L266
[3] https://github.com/jgarff/rpi_ws281x/pull/495
[4]=20
https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#rasp=
berry-pi-revision-codes

> Overall I am not currently convinced this is something we currently want=
.
>=20
> Peter
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings
>=20
>> Best regards,
>> Fiona
>>
>> Am 15.02.25 um 14:01 schrieb Peter Robinson:
>>> Hi Fiona,
>>>
>>> I'll review and test this the coming week and provide feedback.
>>>
>>> On Tue, 11 Feb 2025 at 13:58, Fiona Klute <fiona.klute@gmx.de> wrote:
>>>
>>>> Both the Raspberry Pi downstream kernel [1] and some userspace tools
>>>> [2] use the revision property to identify the board, and the latter
>>>> fails if it is absent. The firmware creates the /system node, so we
>>>> need to do the same.
>>>>
>>>> [1]
>>>> https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076=
895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
>>>> [2]
>>>> https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ed=
e5aaa388180da/rpihw.c#L579
>>>>
>>>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>>>> Cc: Matthias Brugger <mbrugger@suse.com>
>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> ---
>>>> I'm sending this as RFC because I'm not sure if creating a temporary
>>>> overlay is the best approach here, advice on a better way to create t=
he
>>>> /system node if needed is very much welcome. I know I'll need to add
>>>> more error checks, I'll do that after I know I have the right approac=
h.
>>>>
>>>>    board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++=
++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.=
c
>>>> index aa39afa338a..647716127c7 100644
>>>> --- a/board/raspberrypi/rpi/rpi.c
>>>> +++ b/board/raspberrypi/rpi/rpi.c
>>>> @@ -550,6 +550,41 @@ int copy_property(void *dst, void *src, char *pa=
th,
>>>> char *property)
>>>>           return fdt_setprop(dst, dst_offset, property, prop, len);
>>>>    }
>>>>
>>>> +int copy_system_node(void *fdt, void *fw_fdt)
>>>> +{
>>>> +       const fdt32_t *prop;
>>>> +       char fdto[2048];
>>>> +       int src_offset;
>>>> +       int len;
>>>> +
>>>> +       src_offset =3D fdt_path_offset(fw_fdt, "/system");
>>>> +       if (src_offset < 0)
>>>> +               return -1;
>>>> +
>>>> +       fdt_create(fdto, sizeof(fdto));
>>>> +       fdt_finish_reservemap(fdto);
>>>> +       fdt_begin_node(fdto, "");
>>>> +       fdt_begin_node(fdto, "fragment");
>>>> +       fdt_property_string(fdto, "target-path", "/");
>>>> +       fdt_begin_node(fdto, "__overlay__");
>>>> +       fdt_begin_node(fdto, "system");
>>>> +
>>>> +       prop =3D fdt_getprop(fw_fdt, src_offset, "linux,serial", &len=
);
>>>> +       if (prop)
>>>> +               fdt_property(fdto, "linux,serial", prop, len);
>>>> +       prop =3D fdt_getprop(fw_fdt, src_offset, "linux,revision", &l=
en);
>>>> +       if (prop)
>>>> +               fdt_property(fdto, "linux,revision", prop, len);
>>>> +
>>>> +       fdt_end_node(fdto);
>>>> +       fdt_end_node(fdto);
>>>> +       fdt_end_node(fdto);
>>>> +       fdt_end_node(fdto);
>>>> +       fdt_finish(fdto);
>>>> +
>>>> +       fdt_overlay_apply_verbose(fdt, fdto);
>>>> +}
>>>> +
>>>>    /* Copy tweaks from the firmware dtb to the loaded dtb */
>>>>    void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>>>    {
>>>> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>>>>           /* The firmware provides a more precise model; so copy that=
 */
>>>>           copy_property(fdt, fw_fdt, "/", "model");
>>>>
>>>> +       copy_system_node(fdt, fw_fdt);
>>>> +
>>>>           /* memory reserve as suggested by the firmware */
>>>>           copy_property(fdt, fw_fdt, "/", "memreserve");
>>>>
>>>> --
>>>> 2.47.2
>>>>
>>>>

