Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D47CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885848940F;
	Fri, 20 Sep 2024 09:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hMwzvKAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B118940B; Fri, 20 Sep 2024 09:25:55 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF9B89403
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c34dd6c21aso10839666d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817149; x=1727421949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HP31Kr48H5zcgx9WOQ+Ro5K7dDk//3uGUCKmnOsAcz0=;
 b=hMwzvKALyWtmfl2DzsbRTw/qcwSPoWigxtL9yz4Cza0qy0g3GpwYyH1woMzxjFB28j
 a8do/EoEZuOBykoyOHsrVQxLqQ1IVbsasWfK7mua7iLD+0HSsaIcw0ij8ZPH6CfuBrF5
 Bz2CNAzZcxuhJWiUS9ZcUkbvmDnJbl4PwnLSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817149; x=1727421949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HP31Kr48H5zcgx9WOQ+Ro5K7dDk//3uGUCKmnOsAcz0=;
 b=J9E1xvMOLvEQQDBxoRFGJ+J6aQBMIZeuE+oi11VY6kx+T0tgxCM1PFCvi2iHRfwmPU
 Q0zBxhB6PtA2kNw+bMi+Fglnk8juVwe2c1QDR/cwTLqxjSzjtKnM3wgOUM0SZtWErKvn
 8g+RDo8lNUKkTbQ5drhPcpMuAm8X7qKBw9Hau3FReHmBa6f7EA/A0fEOs+8Y/2AwbyKc
 URgbJiCdoyWFfDkud++SZBIGj45JQ35YdcXxftnRJTT0nusRIhUggYVg7zN9/L+BdEWP
 W4u5gmv7fBMfPOa0EXNRQbDs3x/b5TrrBPH2R1iib58FSFZnWU3EB4hOTS7OU1XotK8y
 yC0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMtemFRdfjm37OyNbsmwQBFPhj00ivJBuxdfkhtz0QqfrKbfY5L+XJ9jxD+eOe0sXk1BLaSJk=@lists.denx.de
X-Gm-Message-State: AOJu0YzDpzWO7EPB3seH91RgSjj2ZIOf2BgZp1vwdzrBvivn4jBHTMLY
 Qbkavhs1q2CYO7hqu4bgFyS0hqCys43LD779V5fkjVlU5YnIrfps1Bqe8mDIou1dd6lkcf7oZh/
 Quv10GVcW5HPnzxdf+S4YXlTWedTozS+3Mmki
X-Google-Smtp-Source: AGHT+IEadAdcWntUWDJgfKjYBTbnmh3tLWiDjhn58UjpnOBIlK6XcHGE4mUtXRuUdFB8kV0VmnpsTstsa89kzYqz69s=
X-Received: by 2002:a0c:f411:0:b0:6c5:1f00:502e with SMTP id
 6a1803df08f44-6c7bc7ec661mr25766816d6.36.1726817148875; Fri, 20 Sep 2024
 00:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
 <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
 <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
 <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
In-Reply-To: <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:37 +0200
Message-ID: <CAFLszTits7gXaCfCzwvOOwLcYOtHSPBTh8H+5o5jgZ2wh4eNuQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Thu, 19 Sept 2024 at 17:51, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > >>
> > > > >> On 19.09.24 17:00, Simon Glass wrote:
> > > > >> > Hi,
> > > > >> >
> > > > >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > > > >> > <ilias.apalodimas@linaro.org> wrote:
> > > > >> >>
> > > > >> >> Hi all,
> > > > >> >>
> > > > >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> > > > >> >> <heinrich.schuchardt@canonical.com> wrote:
> > > > >> >>>
> > > > >> >>> On 19.09.24 16:10, Simon Glass wrote:
> > > > >> >>>> Hi Heinrich,
> > > > >> >>>>
> > > > >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > > > >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> > > > >> >>>>>
> > > > >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> > > > >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > > > >> >>>>
> > > > >> >>>> Could you explain a bit why this is, and where this is checked?
> > > > >> >>>>>
> > > > >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> > > > >> >>>
> > > > >> >>> Measured boot relies on creating hashes of artifacts and writing these
> > > > >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> > > > >> >>> boot. The device-tree is one of the artifacts that are measured.
> > > > >> >>>
> > > > >> >>> If we have random values in /chosen, measured boot will fail.
> > > > >> >>>
> > > > >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> > > > >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> > > > >> >>
> > > > >> >> There's a comment on top of that function that explains what happens as well.
> > > > >> >> In short the EFI stub does not even look at the KASLR seed and never
> > > > >> >> randomizes the physical placement of the kernel. It only does that
> > > > >> >> when the EFI_RNG protocol is there.
> > > > >> >
> > > > >> > OK thank you. I suppose I am more just wondering why it got added in
> > > > >> > the first place?
> > > > >>
> > > > >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> > > > >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> > > > >
> > > > >
> > > > > Not the kernel physical placement. It randomizes only the virtual placement
> > > >
> > > > So, are you saying that U-Boot adds this field into the FDT and then removes it?
> > >
> > > Yes. As Heinrich said, the rng seed is still usable for some
> > > randomization. If we boot with EFI and have an RNG protocol, we dont
> > > need it and it also messes up the TPM measurements, so we remove it.
> > > But the code that injects it to u-boot, or the prior bootloader that
> > > handed you over a DT,  does not know if you plan to boot with EFI.
> >
> > I'm actually surprised that this works. Normally, removing a property
> > does not drop that property from the string table, so adding a
> > property and deleting it is not normally the same as never adding it.
> > But perhaps that has changed?
> >
> > Anyway, I think we should add the property when we know it is OK to do
> > so, which is just before we boot. If you agree I can take a look at
> > that.
>
> Sure, but we won't be able to remove this code. There are still
> first-stage boot loaders that might send you a DT over a bloblist,
> that has a kaslr-seed

But then I don't see what problem that causes...I'm just going to
leave this madness to you :-)

Regards,
Simon
