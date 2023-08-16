Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACDEC04FE1
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 18:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5472286A09;
	Wed, 16 Aug 2023 20:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TEVxNoCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2835869F1; Wed, 16 Aug 2023 20:16:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207618691A
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 20:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692209768; x=1692814568; i=xypron.glpk@gmx.de;
 bh=kprieVu4G9VK6qEnFXlT/Bi2b9QMsfRkXD+hIgPMbTI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=TEVxNoCbShrDC/g8imosoFR/iCKpM1XJ13KcbVlqU+Ax9MYtYR/lY81w0mtS7Z/uIVHQThb
 +0i/mk6aT0eySq4/zvmIJNJwFg/eMWFRLhd9cTIctNtt5Bv9FFvgw0aUH6XiEI56lz6jFhf7w
 bp1+NRkBWUm4tLXgFGwUs0EdK9JT2tIvIhzfxkCXoXue/f2+e2u38aM5FhNHwH7nskUuki/gp
 u+aqeVxZBH/gENardkU+Nx5N5ZniiybO7HucVwfDjHbV9N9qklJfuiSu4u3XNsGzaubd04XQF
 0jp90ITZqIcartwxv3AoaPdqfGswHQsIjVlFhRm5jv1OrE2GPFpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1qReEj0zfl-004h7g; Wed, 16
 Aug 2023 20:16:08 +0200
Message-ID: <cc75c35f-6e7a-734c-20cc-4775531321bc@gmx.de>
Date: Wed, 16 Aug 2023 20:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Booting Windows 11
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAPnjgZ2a6S_Hh_=Gb=_Cz2zr9DG7TPEJxJD9z_PU9E6LiiMPHg@mail.gmail.com>
 <de4b9edb-1d17-9ca8-1871-e25b280733e3@gmx.de>
 <8c605f6f-ad36-27da-83ac-54932e6b1226@gmx.de>
 <CAPnjgZ1CVSFptm7h6_sYD0Rk7xXyYz6LJOVs5DyJDcyzxtTjYg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ1CVSFptm7h6_sYD0Rk7xXyYz6LJOVs5DyJDcyzxtTjYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YK6vDj09uxIuCwHPTkGsrAZ9M1sd54kPeiLnj1afmRnB5GzaA9H
 xA8a0WcLr1jlmZu+0BpXzm+ON4bFN9wesIXXXGI3+gaU1O7ocAkJz78Zf4iGU0EFOWfZHWF
 qa49lxBsfBz0750iE7mCalE3bZ4Uy7A4M+95LoK5sfvue+w+Y6BvUMYdxD3cLLNeqQdFh9b
 FSkLcbkdtW3WGuCiAK4eA==
UI-OutboundReport: notjunk:1;M01:P0:6MJm1LN5Sc8=;AFfMrHQX+qifofSKddf5QzLynxR
 6TOvGZWTEG0ngxCMq4KT6wAhLk+UMwpxz8tr948WOSPM0/N8FRQ9Ne4Ah3W8o680XI8DMFT4e
 RNoxJlTEodx2XC2B/90+8LP3PAQrw5nb8EweNagdqjy4oA8JBgS4HLIsSkZT8o1h54v8DDr60
 YL0v9YmdN1Q0eUZFHy0OKOnByo1HaxrckBRyb8ZEGcAZGXVezgg/4h5GXKPS1hnloI1lwxlLp
 wndZ0KPzpmckjHx7M5EPx6Q0ip5lBFdpRWbEYLkhprQapQb7B6wTNjn2caERypaa72xM0sIi+
 igoMF3ZIlatyXOpIIWirCd7sXl03kWxU9+fYbsEmFe3kPES3YCKHhHLmlTDRKY9b2UEQF/f/S
 VWVdbz8JVJj6PI9HQcwE3mGkWfU/Gaon6trSfHE6MlZqmeUZfMDiRY+5XXIgHFcr2aaAX/tvY
 HLRlf0Fs3HMSGrkDbnCE+8J0N1oyHLdij/lG4u6+lGC9TSxumqd9c0c20jkcYp97kCWVjDhsw
 CGHm0lH5dM6kUIE8Cru7j3KFUz5sTh7HvlblSOjm3NsMsVMml5QoiB9yupkSyzTTGXBPFFOi/
 vkwBzd+yirU1pvN2wUXmXOZbowkqjtgGX7TOsJvsTn81JR1Me9gyEs/RgyPJ3sOUzT1nEAboA
 S6OF/YXQLw/3bEEtz29Yv956DsFqUOiil3QRCEv/yATGQtGDMxQVPyzkh6fNGg407lotKRftQ
 NIf8B43sg2rOhp+haTG1/pW/Ib+KEb4btOR4rZM6sAEu9/8r5IwQd5BOnEbfSmedaGjoA/rP/
 qt5LHcgnSEXHdjB/sCpNwyaQpUD0N0EuygQYlqGgDFbThFSeoBMHker2ZR/gcnyF7HfBoN30Y
 eRaRrb4K7IFeoqm0myZI3K5igKyzvFEHoy57GsW+sFkXjH/eDs+r12j23j/XmIg+rUWRt4KJY
 Sa4dyWAB1Jrue5SAcHjkQTUgPHA=
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

Hello Simon,

these are the EFI configuration tables that EDK II is publishing:

Configuration tables:
   ee4e5898-3914-4259-9d6e-dc7bd79403cf
   05ad34ba-6f02-4214-952e-4da0398e2bb9
   7739f24c-93d7-11d4-9a3a-0090273fc14d
   4c19049f-4137-4dd3-9c10-8b97a83ffdfa
   49152e77-1ada-4764-b7a2-7afefed95e8b
   060cc026-4c0d-4dda-8f41-595fef00a502
   SMBIOS
   eb9d2d30-2d88-11d3-9a16-0090273fc14d
   ACPI 2.0
   dcfa911d-26eb-469f-a220-38b7dc461220
   d719b2cb-3d3a-4596-a3bc-dad00e67656f

Here is the translation for the GUIDs:

Configuration tables:
   EFI_LZMA_COMPRESSED (not standardized)
   EFI_DXE_SERVICES (not standardized)
   EFI_HOB_LIST (PI specification)
   EFI_MEMORY_TYPE (not standardized)
   EfiDebugImageInfoTable (UEFI specification)
   EFI_MEM_STATUS_CODE_REC (not standardized)
   SMBIOS (UEFI specification)
   EFI_GUID_EFI_ACPI1 (UEFI specification, deprecated)
   ACPI 2.0 (UEFI specification)
   EfiMemoryAttributesTable  (UEFI specification)
   EFI_IMAGE_SECURITY_DATABASE (not defined as table in UEFI spec)

At least the Memory Attributes Table is used with some security profiles
of Windows. The lack of one of the tables might be stopping the
installation progress.

The EFI_DEBUG_IMAGE_INFO_TABLE points to SMM images and I needed smm=3Don
to run the Windows installer on EDK II.

The Windows 11 installer does not comprise a virtio block device driver.
Some Fedora people have packages a driver that you could load into the
installer but I guess it is easier to supply an emulated NVMe or SCSI
driver as installation target.

Best regards

Heinrich
