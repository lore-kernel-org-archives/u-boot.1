Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F186C71135
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 09:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAF788BC0;
	Thu, 29 Aug 2024 11:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g9Qb64zE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F52E88BD2; Thu, 29 Aug 2024 11:44:48 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157FA88966
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 11:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5bed72ff2f2so413791a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724924685; x=1725529485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBEl66sNHSxEINneGlbem9/aUY4jwCxM3TJTnH3AcAE=;
 b=g9Qb64zEaxZFDBhtCXH+ol/hBGaCJQAFanoFrxjR6EZov0RR2WOUi5vW3QC0f2EWwO
 IKzUeWjos4YC5KfDaDqj6iRf4wQ9rRRYaap9ltgAnaGz295uUMwcGzXfb0E7IJfFtEhi
 ndhSDHslZh3Xp3RZanoPs1Tz4xPxBPHYtMmQM43AgU85oUHiX9nb0q/sNQcExs+8F1rg
 VoKyrfc2pElC1aMi+1lFGgWe5N2BRp86TWJG+siazRP5tkRImrcjPO4O+af9dVDXDpn6
 yHRTlFV1HXJ892yX7t40spY2jh0HQbwXs2bCJbGRrUfZEoPcJSZzUAFwSAIv5bsm7Qj5
 lfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724924685; x=1725529485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBEl66sNHSxEINneGlbem9/aUY4jwCxM3TJTnH3AcAE=;
 b=reCYEK4HYK6+hhhrcXHbMO/R5Maue72rFNpQWZtSJb+Qhf7iXnqeZXrvTQ3FoGC6Q1
 ATo1l//AxpISUlxRbE/98PJQiWmftLRTMOeftS64eAPMzu7VZFgT5SwEaXj2tGYjcBQj
 TkW9tgVoyyUTio8I7Gld0WE6j+jXyA0Om3yOwu7KsI7ZvJfZ4odQoIgRjaGqk2bnl0aF
 X06g5IJG9BF+4k5SdShYZ2OMga7AxVD7hMqsJCZEZXnXu4SeEtN/ZwbrgAehPDIrIAvC
 vTG8cLKFynoymxxQAALBoWfssxVKRnfmvkkI/xZSS5dWR++KHDXoLdbhGJwZWmjTRUEZ
 WzXw==
X-Gm-Message-State: AOJu0YyNkN/lFgu534MKmm8n17ZTzQDll2Y0Tl3wgh2A01BIbu1oLUGB
 ei8H/eX5IB48DPMS48wDPvY7StgamXcNt2DNI1CxQksfj1WY4EqMxNM73gm5X92AsWjbQeNgNDu
 5RnbQmgqyr9Pqhhhed/guUt1s+vc70NrX
X-Google-Smtp-Source: AGHT+IHL/Hrj3S64e5Pm7PAXIKjo7GShXy9EAVkvR8rVKnx+4BBeBJCi94xm08U76Rw8JaUzA4UuISg3YuciPCvg+6E=
X-Received: by 2002:a05:6402:1d48:b0:5b8:34a9:7fd9 with SMTP id
 4fb4d7f45d1cf-5c21ed86b5amr1613059a12.27.1724924684820; Thu, 29 Aug 2024
 02:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <7f33e3d7-e5ab-4c1d-a69a-153a50a6b0c2@Spark>
 <7cbce75d-51fe-4c87-9c90-01e86a06f0fe@Spark>
 <CALeDE9PEMh14rp8paEvhN6pRebxzXonCqidvaTaByHHG2MLgZw@mail.gmail.com>
 <69306a5c-90cf-4526-b2c0-483996910a88@Spark>
 <CALeDE9OXK_Wm-KbPC5Qs2C7L0OfQtFXtU2Y6_g-gK6euGMJsqw@mail.gmail.com>
 <7056f770-e3c9-42e5-a654-f52c29edf616@Spark>
In-Reply-To: <7056f770-e3c9-42e5-a654-f52c29edf616@Spark>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Aug 2024 10:44:33 +0100
Message-ID: <CALeDE9MnhYve3vrVUsJ=LKOR9B8vo2UizeYktAcYsPdpO4nHOg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Grub_doesn=E2=80=99t_load_devicetree?=
To: =?UTF-8?B?VG9tYcW+IFphbWFu?= <tomaz@mono.si>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: multipart/related; boundary="0000000000001ad2a00620cf533c"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--0000000000001ad2a00620cf533c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 10:40, Toma=C5=BE Zaman <tomaz@mono.si> wrote:

> I get this:
>
> No UEFI binary known at 0x81000000
>

Are you building the kernel with all the appropriate UEFI shim bits?
Installing the EFI kernel pieces etc?

Sorry, I can't help with kernel build process bits, you'll need to google
that.


> *Toma=C5=BE Zaman, *CEO
> Mono Technologies Inc.
> +386 30 651 645
>
>
>
> On 29 Aug 2024 at 11:38 +0200, Peter Robinson <pbrobinson@gmail.com>,
> wrote:
>
>
>
> On Thu, 29 Aug 2024 at 10:31, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
>
>> Doesn=E2=80=99t work - at least not correctly:
>>
>> =3D> fatload mmc 0:1 $fdt_addr_r /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
>> 31793 bytes read in 4 ms (7.6 MiB/s)
>> =3D> fatload mmc 0:1 $kernel_addr_r /EFI/boot/grubaa64.efi
>> 3978688 bytes read in 168 ms (22.6 MiB/s)
>> =3D> setenv fman_ucode
>> =3D> bootefi $kernel_addr_r $fdt_addr_r
>> Failed to load EFI variables
>> WARNING failed to get smmu node: FDT_ERR_NOTFOUND
>> WARNING failed to get smmu node: FDT_ERR_NOTFOUND
>> Booting /\EFI\boot\grubaa64.efi
>> Welcome to GRUB!
>>
>> Because of those FDT_ERR_NOTFOUND kernel reports a bunch of errors and
>> doesn=E2=80=99t boot with all the hardware support I need it to.
>>
>> On the other hand, if I run the same kernel/devicetree/initramfs with
>> booti, bypassing the Grub completely, it works fine. The problem is, I n=
eed
>> Grub2 for his project.
>>
>
> What if you boot the kernel directly using bootefi rather than booti?
>
>
>> *Toma=C5=BE Zaman, *CEO
>> Mono Technologies Inc.
>> +386 30 651 645
>>
>>
>>
>> On 29 Aug 2024 at 10:02 +0200, Peter Robinson <pbrobinson@gmail.com>,
>> wrote:
>>
>> On Thu, 29 Aug 2024 at 05:14, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
>>
>>
>> I=E2=80=99m working on an arm64 board with an NXP LS1046A CPU and I simp=
ly cannot
>> get Grub to load a different device tree than the one that=E2=80=99s pro=
vided to it
>> by the EFI Stub.
>>
>> =3D> fatload mmc 0:1 $kernel_addr_r /EFI/boot/grubaa64.efi
>> =3D> fatload mmc 0:1 $fdt_addr_r /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
>> =3D> bootefi $kernel_addr_r $fdt_addr_r
>>
>> At his point, I get a couple of errors like =E2=80=9Csmmu node not found=
=E2=80=9D.
>>
>> However, if I, instead of "fsl-ls1046a-rdb-sdk.dtb=E2=80=9D use
>> "fsl-ls1046a-rdb.dtb=E2=80=9D, then I get to Grub without any errors.
>>
>> And this is where I encounter the issue. Because I would like to use a
>> different DTB for booting Linux than the one that=E2=80=99s provided by =
the EFI
>> configuration table, I set
>>
>> devicetree /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
>> linux /boot/vmlinuz-6.6.3-arm64
>> initrd /boot/initrd.img-6.6.3-arm64
>>
>> In this case, the devicetree instruction gets ignored completely, and
>> before I see kernel loading, the message =E2=80=9CUsing FDT from the EFI
>> configuration table"
>>
>> Is there a way for me to override/replace the device tree that u-boot
>> passed to Grub? I tried passing the =E2=80=9Cdtb=3D=E2=80=9C parameter t=
o the kernel boot
>> command, but in that case, I get "EFI stub: ERROR: Failed to handle
>> fs_proto=E2=80=9D because kernel when booting doesn=E2=80=99t appear to =
have access to the
>> same filesystem that Grub does.
>>
>>
>> Why don't you load a new one into memory with u-boot and then grub
>> will already have the one you want to use and grun doesn't need to do
>> anything. Something like this on the U-Boot command line would load
>> the DT and grub and start to boot:
>>
>> load mmc 0:1 ${kernel_addr_r} EFI/BOOT/BOOTAA64.EFI
>> load mmc 0:1 ${fdt_addr_r} dtb/${fdtfile}
>> bootefi ${kernel_addr_r} ${fdt_addr_r}
>>
>> You'll need to adjust for storage, partitions, file paths etc.
>>
>> Thank you!
>>
>>
>> (this is my first time using *any* mailing list, so apologies if this is
>> the wrong address to send this question to)
>>
>> Toma=C5=BE Zaman, CEO
>> Mono Technologies Inc.
>> +386 30 651 645
>>
>> [cid:18EB2FEE485A4DD7A1CE716CE14FCBC7]
>>
>>

--0000000000001ad2a00620cf533c
Content-Type: image/png; name="C1D504EAD21B41379FD3EEB7B3129E94.png"
Content-Disposition: inline; filename="C1D504EAD21B41379FD3EEB7B3129E94.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_1919d84802f123364e41>
X-Attachment-Id: ii_1919d84802f123364e41

iVBORw0KGgoAAAANSUhEUgAAAJYAAAAmCAYAAAAmy2KXAAAAAXNSR0IArs4c6QAAAKRlWElmTU0A
KgAAAAgABgESAAMAAAABAAEAAAEaAAUAAAABAAAAVgEbAAUAAAABAAAAXgEoAAMAAAABAAIAAAEy
AAIAAAAUAAAAZodpAAQAAAABAAAAegAAAAAAAABIAAAAAQAAAEgAAAABMjAyMzowMzozMSAxOTo0
MTo1MQAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAlqADAAQAAAABAAAAJgAAAABJtZgxAAAACXBI
WXMAAAsTAAALEwEAmpwYAAAGrmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4
bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRm
OlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1u
cyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxu
czpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6
dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnht
cE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4bWxuczpz
dEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgog
ICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAg
ICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4w
LyI+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAg
ICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+MTA5MzwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAg
ICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4yNzY8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAg
ICAgICA8dGlmZjpJbWFnZVdpZHRoPjEwOTM8L3RpZmY6SW1hZ2VXaWR0aD4KICAgICAgICAgPHRp
ZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6
SW1hZ2VMZW5ndGg+Mjc2PC90aWZmOkltYWdlTGVuZ3RoPgogICAgICAgICA8dGlmZjpPcmllbnRh
dGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj43Mjwv
dGlmZjpYUmVzb2x1dGlvbj4KICAgICAgICAgPHRpZmY6WVJlc29sdXRpb24+NzI8L3RpZmY6WVJl
c29sdXRpb24+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4K
ICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFmZmluaXR5IFBob3RvIDIgMi4wLjQ8L3N0
RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+cHJvZHVj
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAyMy0wMy0z
MVQxOTo0MTo1MSswMjowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAg
ICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8
eG1wOk1vZGlmeURhdGU+MjAyMy0wMy0zMVQxOTo0MTo1MSswMjowMDwveG1wOk1vZGlmeURhdGU+
CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMjMtMDMtMzFUMTk6NDE6NTErMDI6MDA8L3ht
cDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxwaG90b3Nob3A6SUNDUHJvZmlsZT5zUkdCIElFQzYx
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
--0000000000001ad2a00620cf533c
Content-Type: image/png; name="98510E94234546F0B7D19E62D33FDFCC.png"
Content-Disposition: inline; filename="98510E94234546F0B7D19E62D33FDFCC.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_1919d84802fad8457222>
X-Attachment-Id: ii_1919d84802fad8457222

iVBORw0KGgoAAAANSUhEUgAAAJYAAAAmCAYAAAAmy2KXAAAAAXNSR0IArs4c6QAAAKRlWElmTU0A
KgAAAAgABgESAAMAAAABAAEAAAEaAAUAAAABAAAAVgEbAAUAAAABAAAAXgEoAAMAAAABAAIAAAEy
AAIAAAAUAAAAZodpAAQAAAABAAAAegAAAAAAAABIAAAAAQAAAEgAAAABMjAyMzowMzozMSAxOTo0
MTo1MQAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAlqADAAQAAAABAAAAJgAAAABJtZgxAAAACXBI
WXMAAAsTAAALEwEAmpwYAAAGrmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4
bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRm
OlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1u
cyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxu
czpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6
dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnht
cE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4bWxuczpz
dEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIgog
ICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAg
ICAgICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4w
LyI+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAg
ICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+MTA5MzwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAg
ICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4yNzY8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAg
ICAgICA8dGlmZjpJbWFnZVdpZHRoPjEwOTM8L3RpZmY6SW1hZ2VXaWR0aD4KICAgICAgICAgPHRp
ZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6
SW1hZ2VMZW5ndGg+Mjc2PC90aWZmOkltYWdlTGVuZ3RoPgogICAgICAgICA8dGlmZjpPcmllbnRh
dGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj43Mjwv
dGlmZjpYUmVzb2x1dGlvbj4KICAgICAgICAgPHRpZmY6WVJlc29sdXRpb24+NzI8L3RpZmY6WVJl
c29sdXRpb24+CiAgICAgICAgIDx4bXBNTTpIaXN0b3J5PgogICAgICAgICAgICA8cmRmOlNlcT4K
ICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFmZmluaXR5IFBob3RvIDIgMi4wLjQ8L3N0
RXZ0OnNvZnR3YXJlQWdlbnQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+cHJvZHVj
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAyMy0wMy0z
MVQxOTo0MTo1MSswMjowMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAg
ICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8
eG1wOk1vZGlmeURhdGU+MjAyMy0wMy0zMVQxOTo0MTo1MSswMjowMDwveG1wOk1vZGlmeURhdGU+
CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMjMtMDMtMzFUMTk6NDE6NTErMDI6MDA8L3ht
cDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxwaG90b3Nob3A6SUNDUHJvZmlsZT5zUkdCIElFQzYx
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
--0000000000001ad2a00620cf533c--
