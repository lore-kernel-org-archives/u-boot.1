Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D66DC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 13:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B708588047;
	Wed, 21 Feb 2024 14:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FQxrIhXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616EB88047; Wed, 21 Feb 2024 14:16:06 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D1488039
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 14:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d42e7ab8a9so4703370a12.3
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708521358; x=1709126158; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJYQppY0pU5Sk8NU2uZ03OWNlpnTpJvEE1lCv/t7dYk=;
 b=FQxrIhXMeCXwl1RMr5GdGEnbx9E9y+JXQgwaS+OeebLjSMVZoERZ4EXDvA1cTemf/W
 iA8CWmtC2KTGy8AotR/79p/WMLbygtkZiBUcUgIA26cBuEvzyh2uBVtsD67PniXeaNIg
 8Uj+rkMcabK1mSZTYaXM3UmRcIzIP73+NsVjI/TSoMcpBqROb1Yzv9rM+aODOCombGKO
 bIl20w99W13qpmQMANSAuX0Gh/lyQ3Njli5ymwd23kSPcCqk2X34PiBnedYGyq7nrs/R
 th+itmu3PH0v8Xcu9yqEmps4gpMt2JvEubPxBWCy00U6/7MoNaPxoulj3k8wM5i8V2Kw
 wgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708521358; x=1709126158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJYQppY0pU5Sk8NU2uZ03OWNlpnTpJvEE1lCv/t7dYk=;
 b=cYLK0hF+SJlwFz/VPuH5cE584JWAnNu8WU2/qBcTpAKkJ5Qr4LsGjqhx1C6/qyLSDA
 0o4zgjgHSyyKCYK2y5BXuWCapejJ2fmuh9/4OmKuPkv3+BYv2glbEXcQuBFNdK4aaaf5
 sEbO8ZwU2KjNtSq8FZ1hU6Z9mdMU6Y/9pAc9iW+qVRYpP19ZIJG4gKrGwB8C/CkGbQsW
 svZDyr5QdEPbfim7ew25PlTv53PSxf3iaIsc+MXzKAcQtelLRpnGKNz0eB4p0SPfiXO5
 R829A6kjiVzRcFsmGX8vGvfcZPg6wgMZSlRNT4bAKCVIXK36PpZhdbgDhAXRB+ynLKlt
 fv7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ7lTZJ2fkGSTQ0+zAX+RaYIXn1kR0V3l/gMGYAJ1zY5TijJJ4CIkiuKBI8oqHyXgEupwDw47ZzN9YnbGzUYFGnct5YQ==
X-Gm-Message-State: AOJu0YyFdcAojH11S3LqBhd1vVAIACtr08c0St7ZPjEWC77CWYfkd9SX
 8CiqHDTCFG5kdgTEy4K2MywDvmQNyjm7cgkaW49WkP0SQzAwVomUeMr9Ip7PqhCKX1Mfm3TXz6N
 hxAQoXVa1L4l9hoqX/eyi3VlSgbg=
X-Google-Smtp-Source: AGHT+IFaI6/daNK6yF+G+3eCcDjoGz4Y66MRSEXkpXlsLbPXVjWUBGvT+fXFASj17Nlcn2MFqkOGin0wod0MiChSQh0=
X-Received: by 2002:a05:6a21:1583:b0:19e:a19f:f4de with SMTP id
 nr3-20020a056a21158300b0019ea19ff4demr16899811pzb.41.1708521358253; Wed, 21
 Feb 2024 05:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
 <42f24803-8e56-46b2-a3c5-0c09dba69778@denx.de>
 <CAFA6WYOErpAFC4eqjtyFiMgwjsh0Wc2R3j94XEh1NoBn85hbhQ@mail.gmail.com>
 <a74a468a-8255-4379-9430-41b794499d3e@denx.de>
In-Reply-To: <a74a468a-8255-4379-9430-41b794499d3e@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 21 Feb 2024 07:15:46 -0600
Message-ID: <CAHCN7xJ-q7rp5Vx85b7sm0eqRNWw_LJ-mx2fNWBZTdHdaZD2og@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Marek Vasut <marex@denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, 
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 "lukma@denx.de" <lukma@denx.de>, 
 "seanga2@gmail.com" <seanga2@gmail.com>, "festevam@denx.de" <festevam@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "fathi.boudra@linaro.org" <fathi.boudra@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 21, 2024 at 6:27=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 2/21/24 13:12, Sumit Garg wrote:
> > On Wed, 21 Feb 2024 at 16:11, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/21/24 10:18, Marcel Ziswiler wrote:
> >>> Hi Sumit
> >>>
> >>> On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
> >>>> Hello Sumit,
> >>>>
> >>>> On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> >>>>> Also, enable reset driver which is a prerequisite for PCIe support.
> >>>>>
> >>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>>>> ---
> >>>>>    configs/verdin-imx8mp_defconfig | 9 +++++++++
> >>>>>    1 file changed, 9 insertions(+)
> >>>>>
> >>>>> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8m=
p_defconfig
> >>>>> index 22b8a334dfa..d8bd644322b 100644
> >>>>> --- a/configs/verdin-imx8mp_defconfig
> >>>>> +++ b/configs/verdin-imx8mp_defconfig
> >>>>> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=3D0x1b67
> >>>>>    CONFIG_USB_GADGET_PRODUCT_NUM=3D0x4000
> >>>>>    CONFIG_IMX_WATCHDOG=3Dy
> >>>>>    CONFIG_HEXDUMP=3Dy
> >>>>> +CONFIG_DM_RESET=3Dy
> >>>>> +CONFIG_RESET_IMX=3Dy
> >>>>> +CONFIG_PCI=3Dy
> >>>>> +CONFIG_PCIE_DW_IMX8=3Dy
> >>>>> +CONFIG_PHY_IMX8M_PCIE=3Dy
> >>>>> +CONFIG_CMD_PCI=3Dy
> >>>>> +CONFIG_NVME=3Dy
> >>>>> +CONFIG_NVME_PCI=3Dy
> >>>>> +CONFIG_CMD_NVME=3Dy
> >>>>
> >>>> This will increase the u-boot proper size
> >>>
> >>> Yes, I checked and it is actually slightly more than 32 K.
> >>>
> >>>> and marginally increase the
> >>>> boot time (because of a bigger binary to be read from the eMMC).
> >>>
> >>> That was also my concern.
> >>>
> >>>> Apart of that do you expect any other impact on those changes? SPL
> >>>> binary size should not be affected, correct?
> >>>>
> >>>> Asking this out loudly to confirm that nothing unexpected is going t=
o
> >>>> happen because of these changes.
> >>>
> >>> Other than that I actually gave it a quick try and PCIe/NVMe does ind=
eed work and the regular boot is not
> >>> affected (other than the slight size and boot time increase, of cours=
e).
> >>>
> >>>> For my curiosity, care to share what's the use case? Do you plan to =
have
> >>>> the OS stored into an NVME device?
> >>>
> >>> For us the question is basically whether that use case does mandate e=
nforcing such changes for each and every
> >>> customer. Plus the regular expected maintenance effort any such chang=
e brings with it, of course.
> >>
> >> You can always enable this support on MX8MP EVK, it has M2 slot and th=
is
> >> would add build coverage of this code too, without impacting Verdin.
> >
> > I would have chosen that as the base platform to enable but
> > unfortunately I don't have that at my desk. However, if someone is
> > willing to test this patch-set on MX8MP EVK then I am happy to extend
> > corresponding defconfig too.
>
> I think we can surely find a platform on which this can be enabled by
> default and tested by people.

My development machine crashed (my fault for running a pre-release
OS),but I have an i.MX8M Plus and an NVMe drive that I can test once I
get my machine running again.

adam
