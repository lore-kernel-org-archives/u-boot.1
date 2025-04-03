Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298E5C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C668290A;
	Fri,  4 Apr 2025 00:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VR07KCgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24FF82385; Fri,  4 Apr 2025 00:41:42 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3248290A
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 00:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a70so188380166b.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743720100; x=1744324900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZWnWLrc6e1y+6OcPo94cZV4fWMrNnq8Q1xtbRIyZLQ=;
 b=VR07KCgQyyZnIzSINQYasEbHOUXXjTUjJgzVNcdUExQKe8SCR5ASDXw1/DmZrcP6YG
 3SXwpsrvgi2EmsVrFswl1p/k+oEUstCbgwQnKEPh5xD8p2m7yxj07xm+CRWMUWkIy5F3
 1hO5jZsj1tCAmFXJjuZyMti8ZeQmaeq/cAaNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743720100; x=1744324900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZWnWLrc6e1y+6OcPo94cZV4fWMrNnq8Q1xtbRIyZLQ=;
 b=edO6M/hIgy8gh8mrfbKdPe3PxuMoAu9YrG4D5w6/Rib0YtkNdOZ2ZJVXgXBiUpAtYv
 XZ36ZlYsWxjAdOFvv9bAB0+05qrTkX+mQ2f3NelLaLho0CbAWycTe9U1lcCoE00ytn+j
 N4OHMOlmpuRHkWXi0lUwCl0dCrK1a86W7rgmQAczxORL+lYTo8EaEq6dj9AO5Pf+iuH1
 BpxujF9XMIBvX/lfXjuusYOGiGIyFVJT78dPzyJP0/aD8bXwUobnErjuv+dXWy1gtI0Q
 cdY/Qi6eysGLwCBjWeFuIbNt9p9iubfDi9X1ytQeWenhE70cB24mEtJ1w1MtcyKVp2WW
 zHGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrFcQvB9Sv2Mlxx0MUbbCAWQ5fbsnraBFu8i0pf90QfmpjuQ4qnpsu4GlS5/qzQrDAgPZIdZ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+qUFn4+szfE4WCr4vMRGhqoZ9DkTnWyfIEoe0QFs/t4xX268m
 4BUgIJWNh01nnNgCqURdh9Qw3lPNYlDN6vyn+3Xbzw0sryvbrsYaxF4On+se432LBgq+m/a3dr3
 4fP+eCjzLl5qzXy7dNqrcD5HgEzDyDHp37id2
X-Gm-Gg: ASbGncuC4osnRQ5rpgmrM+3KaMS/izWFETwJPZCjRguk6PFilSF6TZDpBVB/xjq5aia
 4oOBtOUHpScBRwp+VZ9hD/YSN4kb6gFC7uzzhmMCzRxyPlJgIyKZI1TVaNO0ipe9RCPhgDqbpX7
 w9nrFeAZ7YgGZ4NSHfAHg+vg+T1rER
X-Google-Smtp-Source: AGHT+IEmLEZ8h9G/fcRvjpgyUDf5KnhnJUUqVPekOJ59VQ1qC4fq4WOFPdtEgFm7n4fEG/LZMWhQOdqvb5ZWs8SP8Oc=
X-Received: by 2002:a17:907:6e86:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-ac7d16bc07emr123638066b.10.1743720100195; Thu, 03 Apr 2025
 15:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
 <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
 <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
In-Reply-To: <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 11:41:24 +1300
X-Gm-Features: AQ5f1JqgmjOholUTusUysxX05mF32h2LLTgEaRyeeRGDne5hIfmIqOiRmyOXHwo
Message-ID: <CAFLszTiJR3La6dwE6k5QbKMmtVpbq+VK9AYhkmeQSEhgozh1AA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_U=2DBoot_interferes_with_initrd_binary_=E2=80=94_Revert_?=
 =?UTF-8?Q?=22efi=3A_Correct_smbios=2Dtable_installation=22_=3F?=
To: =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
Cc: trini@konsulko.com, Michael Brown <mcb30@ipxe.org>, u-boot@lists.denx.de
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

Hi Christian,

On Fri, 4 Apr 2025 at 08:18, Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> +Tom Rini (actually adding Tom to the conversation)
>
> > On 3. Apr 2025, at 19:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > +Tom Rini in case this affects the release
> >
> > Hi Christian,
> >
> > On Fri, 4 Apr 2025 at 01:46, Christian Kohlsch=C3=BCtter
> > <christian@kohlschutter.com> wrote:
> >>
> >> Hi Simon,
> >>
> >>> On 1. Apr 2025, at 17:51, Simon Glass <sjg@chromium.org> wrote:
> >>>>
> >>>> but I don't know precisely what these various functions are supposed=
 to
> >>>> do, and I can't find any path that leads from any of these to eth_ha=
lt().
> >>>>
> >>>> Is it possible that U-Boot is failing to call eth_halt() in response=
 to
> >>>> ExitBootServices(), and is therefore leaving the network device acti=
ve
> >>>> and performing DMA while the kernel starts up?
> >>>
> >>> The dm_remove_devices_active() is supposed to handle this, but it is
> >>> possible that one of the drivers lacks a remove() method.
> >>
> >> for what it's worth, this is happening on both ODROID N2+ (meson8b-dwm=
ac) as well as NanoPI R4S (rk_gmac-dwmac).
> >>
> >> I also don't understand why reverting 06ef8089f876b6dabf56caba31a05c00=
3f03c629 "fixes" this behavior. Does it mean that any memalign / malloc may=
 cause this?
> >> Also, how can this failure mode be detected and prevented in code?
> >>
> >> I really don't fancy the thought of remote code injection into Linux i=
nitrd by spoofing Ethernet packages, but it really looks like a possibility=
.
> >
> > Here's my idea of what might be going on based on Michael's observation=
s:
> >
> > 1. designware_eth_start() starts the interface and
> > designware_eth_stop() stops it
> >
> > 2. tx_descs_init() sets up the DMA and uses the device-private info
> > (struct dw_eth_dev)
> >
> > 3. When the device is removed, the struct is freed, meaning that a
> > future malloc() can use that same space.
>
> Yes, that sounds plausible. How can such allocations be prevented?

There is no need to prevent allocations. It is in the nature of
malloc() that any memory you free can then be used by a subsequent
malloc(). The bug here is that DMA needs to be disabled when the
device is removed.

>
> I assume U-Boot's malloc does not know anything about iPXE's or Linux's a=
llocation, and vice versa?
>
> >
> > 4. DMA traffic could then write over the malloc() region
> >
> > I'm not seeing where the Ethernet device's stop() is called. The
> > dwmac_meson8b driver does not have a remove() method, so presumably
> > DMA is still running after the device is removed. Probably the correct
> > fix would be to add a remove() method to that driver.
>
> Right. Of course this means that there's still a chance that some future =
driver would again fail to do this.
> How can we prevent this? Can some removal hook be added automatically upo=
n registration?

Visual inspection of each network driver should help.

I'm not sure if we want to 'stop' all the network devices before
booting Linux, but perhaps we could perhaps provide that feature as a
Kconfig option, e.g. in announce_and_cleanup(), which could really use
a cleanup to make it common across archs.

>
> >
> > Regards,
> > Simon
>
> Thanks for looking into this!

Thanks for the report!

> Christian
>

Regards,
Simon
