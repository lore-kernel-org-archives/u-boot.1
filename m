Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D58CA1008
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 20:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620D78658D;
	Tue,  5 Sep 2023 22:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tZmEnPHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0802A8659D; Tue,  5 Sep 2023 22:29:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E3886568
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 22:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so3851626a12.3
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693945778; x=1694550578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YCG3/nMx9aNvk7mbBSQEZpfSUpdUasP4W/7hmRA1m1c=;
 b=tZmEnPHC4zrFCGV7oM9LX/sTF/kaqo62BPIyzER7UuifgWugd0bM3VYC+abo3UvYbp
 mc2e3XuaTloHaptqJhQ79VFbwnsaCFbw8TPsPbRfX/WrqGyOltIyqTRheMGkcBS7GEOA
 +2PXlHS9TZPUaZBtwS6CaVLOJhOTjYQK6x2107G0V7KrtokGQ0lhK5QDiHNdbaTgMWsI
 2Uns9EI4bSbiaGvmAwL9avPmxCqFP7sqfZBVYKAMnCXVNFBN9mXDGb2aZBfg5ETEjo7g
 m7cozqBoqumXb0NlkUaSYQAQHRG5qgjTTogZ3OjuCZsJo066co1cN/m+RqtvauYse73d
 MEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693945778; x=1694550578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YCG3/nMx9aNvk7mbBSQEZpfSUpdUasP4W/7hmRA1m1c=;
 b=epEDGbe5BTmj6cMW9yII5zgfoAVU7MHpBMT/b9T3Cbq4SBgHvnJQ/8cLMX2WN2eJ5G
 PmoXg4JSE0vH4mfmLluv1t2lhK4ALeYqUVa/chRe1p8bEZtAHl4SLDGZrQUWSRrW91v1
 RMbdDR9bdnHMbwOLx1RBM65IXVk3SKekHGwxw9bcsDHx2eCGhg6mumWoJsVoVbTsUTFy
 lqHGpRTgPke4n67rKZuaPTX5186i772EVpiTegda+mtio7e69gQahOehKlIwpZY9eHQa
 Bmcp5K+hA66y7ABLIsPnFoFU141v3KrXfuer5WaW098JyE+AuSTbL/VdUWpe3801ga7I
 PWTQ==
X-Gm-Message-State: AOJu0YzmkjQ5lHG+NlziQYp3nYdhlNby/hx76s9zO/6zPFDtkVkO3THi
 jsD59AzjhrJYKv83qZRc7SiRC2LflIdPEMGRJDSlveW84gFnt4uicbc=
X-Google-Smtp-Source: AGHT+IECQPDsrUkL2leVHyaS4W0WfDgmbIegMKyi5OlZjaTRRxgt8/xOqVN8bT5OyQ3EFEPMaqYqAf7vYENhG6M/LRo=
X-Received: by 2002:a05:6402:710:b0:52b:c8d9:1d66 with SMTP id
 w16-20020a056402071000b0052bc8d91d66mr510480edx.42.1693945778282; Tue, 05 Sep
 2023 13:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9LrUHa5fZpRkgjYjDQft-L32Tzpa=FzOmMnLzM-q8RttqVeQ@mail.gmail.com>
 <CAPnjgZ33SiNPRdrMXmrwvRrKgi+mp+sJ+OBbu7=yDf19Gydd9Q@mail.gmail.com>
 <CA+9LrUEGqmsUL9xu0KzwgqhWptWOU1z4x3ncvXMYUJFomSv+ug@mail.gmail.com>
 <CAPnjgZ3458G_-+Nm-GzCbcVGV4uu7DNzYKd2cNQ=JFYZVS78dA@mail.gmail.com>
 <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
In-Reply-To: <CA+9LrUF0ZjeXpG9UC3s0BLssN03wmVG3NRHG3xuXcZ=9vGnmzQ@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 5 Sep 2023 14:29:23 -0600
Message-ID: <CAPnjgZ3sgh-b-f3WVu9aWh82A4GA-L7nRuuApas=q4xMVhST9A@mail.gmail.com>
Subject: Re: NVMe support on RPi CM4 board
To: Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Luis,


L
On Tue, Sep 5, 2023, 12:00 Luis Alfredo da Silva <luis.adasilvaf@gmail.com>
wrote:

> Hi Simon, it took me some time to come back to this issue, but I was able
> to enable the debug messages on drivers/nvme/nvme.c.
>
> This is what I got when running the nvme scan command
>
> U-Boot> pci
> BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
> _____________________________________________________________
> 00.00.00   0x14e4     0x2711     Bridge device           0x04
> 01.00.00   0x1c5c     0x174a     Mass storage controller 0x08
> U-Boot> nvme info
> U-Boot> nvme scan
> Cannot set queue count (err=3D-110)
> Unable to setup I/O queues(err=3D-110)
> Failed to probe 'nvme#0': err=3D-110
> U-Boot>
>
> I'm reporting as soon as I got the messages, but I'll continue
> investigating.
>

Can you check if the device has PCI bus master enabled?

Regards,
Simon


> Regards,
> Luis
>
>
> El mi=C3=A9, 9 ago 2023 a las 20:15, Simon Glass (<sjg@google.com>) escri=
bi=C3=B3:
>
>> Hi Luis,
>>
>> On Wed, 9 Aug 2023 at 10:43, Luis Alfredo da Silva
>> <luis.adasilvaf@gmail.com> wrote:
>> >
>> > Hi Simon, I enabled the next four variables
>> >
>> > CONFIG_NVME_PCI=3Dy
>> > CONFIG_NVME=3Dy
>> > CONFIG_CMD_NVME=3Dy
>> > CONFIG_PCI=3Dy
>> >
>> > how different is CONFIG_NVME_PCI from NVME_PCI, I took the latter valu=
e
>> from several configs files in u-boot repo and from [1]
>>
>> I just left off the CONFIG as they all have that. This looks right to
>> me. Assuming that the NVMe controller appears in 'dm tree' perhaps you
>> can enable debugging in the driver and see why it is not working?
>>
>> Regards,
>> Simon
>>
>>
>> >
>> >
>> > [1]
>> https://github.com/u-boot/u-boot/blob/ef8336e2705fce2502383f25d68188c6b1=
f94dd0/doc/develop/driver-model/nvme.rst#L44
>> >
>> > El mar, 8 ago 2023 a las 22:05, Simon Glass (<sjg@google.com>)
>> escribi=C3=B3:
>> >>
>> >> Hi Luis,
>> >>
>> >> On Tue, 8 Aug 2023 at 17:09, Luis Alfredo da Silva
>> >> <luis.adasilvaf@gmail.com> wrote:
>> >> >
>> >> > I compiled u-boot version 2023-07 and boot it on a RPi CM4 using a
>> PCIe M.2
>> >> > NVMe drive, but it doesn't appear to be working.
>> >> >
>> >> > Once u-boot has started and boot successfully it recognizes the PCI=
e
>> device
>> >> > giving me the next output
>> >> >
>> >> > U-Boot> pci
>> >> > BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
>> >> > _____________________________________________________________
>> >> > 00.00.00   0x14e4     0x2711     Bridge device           0x04
>> >> > 01.00.00   0x1c5c     0x174a     Mass storage controller 0x08
>> >> >
>> >> > but when trying to use the nvme scan and nvme info there is not
>> output.
>> >> >
>> >> > NVMe drive has two partitions 1st is a FAT partition, and 2nd is a
>> EXT4
>> >> > partition, the RPi firmware recognizes the FAT partition and u-boot
>> boot
>> >> > correctly.
>> >> >
>> >> > I don't know if this worked before, but I saw in the mailing list
>> that
>> >> > there could be already support for other ARM64 boards.
>> >>
>> >> Is NVME_PCI enabled?
>> >>
>> >> Regards,
>> >> SImon
>>
>
