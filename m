Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B55C369B2
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 00:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D8881273;
	Tue, 15 Apr 2025 02:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wzWELXQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305F381DE3; Tue, 15 Apr 2025 02:33:05 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFBB80F9C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 02:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af579e46b5dso3598394a12.3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 17:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744677180; x=1745281980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R0dT0597HWSxzJ0ICDgWUaCgkwhZIeP7Zu9BauhjJzo=;
 b=wzWELXQFl0Bgx7YeKTKx1ulSNxxll15PNaZ5EIT2+pTT/B/Y6B7jPu4EDRpGaKJ6YB
 dJgvBPr2Q/dkct19lrOKRrIrH5OyWRZ6Jpy148insz84G135NlFIkFZ3i8v6/NkP8ezb
 AGcDMQSZtN/f31Oq0EIcADQjZzhhsp/GgwJ9Fqq0efFNmjSyx6IJtqhG5g9HyWyp2p4U
 a/3m66lrK5ruf4izlttVXvhRHN5Ix5lMbxjg5rxJVluyDn5mb/QYuKVx+hkSItCaiejS
 6ImpHvGHx8lRRifukugHhP3k0socPzy+O2isCeMTYnWsTc9tyS82e0JeJbbhT/3THyCr
 rwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744677180; x=1745281980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0dT0597HWSxzJ0ICDgWUaCgkwhZIeP7Zu9BauhjJzo=;
 b=dh2UWWc9lJCA0X1wrXT/upOBMYQy3UnXs9PQOMDq6+yEng5TmkBQeOLhhvTIELz9De
 ose1Sg2oPOx24zi+prsFt8o/KjmiPmxnCexNYaX8G9H6IUF0BmZj264yQON1RdCKyNze
 0ti54iMnnm2Clnp9/fVlsUmep2vIGm96KhROc5HH3lB8kgJJm6A2Yh0ohNM5Ttabguy3
 lK59FlhwPKt4RjnqCODpWB9XqsqHIbHShMxIeViNCCKE++U9WOaFLi3gNULE0uBZLXL0
 7ndck6UavfXsIVKlzhYxC2G0obNnDnwaKgZfsBGKS8Tt8p2DrsZb/JtJ8WCUjMi+tCcZ
 FLvw==
X-Gm-Message-State: AOJu0Yzjku40IN9ha4QrEkqzzPCbgYNHQk0SfV+XjLDgQpPqB3gclRe5
 GFrZEuSAQoK5vfuBQ15Dni1ygUCw25WPjnUJ/nJ19Rro1jIiCfV4o2FwQrZ6Jsbl3XW9uIaIruq
 IPKzMZQdhecDgRrQBM4SZ1+YaK1gU5tcFCROOHuy+RGmUeYg3
X-Gm-Gg: ASbGnctg6Prdh5FxUCHCuOnwa7xW1KzT92uaf0JSv+XrQwM4Q+2iB82Ry/adMS+udmv
 dBuZ+6fGcutWW/DXYYLZc2Tfg4eMTj6GscKDQmez5Qu+SasmsaNQBh7o0pyMouJwo7TdYosxNMQ
 +vuS3DGBpTb5I11+5tcKeg2uQ=
X-Google-Smtp-Source: AGHT+IGvYqpXptlgKcIayzpXltD5W1hnq7WonHJ379M0U2cWgjnrWjtv0iqrQVGbovlwiVUO2WC6AKkzMScwAdAZJbI=
X-Received: by 2002:a17:90b:520a:b0:2ff:618c:a1e0 with SMTP id
 98e67ed59e1d1-3082377eb08mr21222501a91.29.1744677179661; Mon, 14 Apr 2025
 17:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
 <CAEfUkUJNUhoyRY6S9-eYV5i9RT_GgYLRs+HRWocch8jYfVj2Lw@mail.gmail.com>
 <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
 <CAEfUkULcgK9jY902Ccf_mNNCHf5m1BU=ecLK7cuviv7TdABukQ@mail.gmail.com>
 <CAFLszTi7CmWL7pxAp08gy5euD8vKs1qN5DOzi-J=9c2dZ7hFMw@mail.gmail.com>
 <CAEfUkULOyojCztUzuG5Li2i8Bd1bK0rwPk7L8A8h4LxiCjW_JA@mail.gmail.com>
 <CAFLszTiGSY4OmjJ7Yjz=Q6Y+_L65RNzQ2mEUP7JR2=swR-Zoag@mail.gmail.com>
 <CAEfUkUKpn7FYAFH-XVd-rLUHQQ2LeeMm-Wg-3xJU=pS_96ZPdw@mail.gmail.com>
 <CAFLszThxQN5JWLvUBBp1nAQpP4WwesdUH6pxZYTVc0YCQZ7VKg@mail.gmail.com>
 <CAEfUkU+cPiiFQZ=7g6zrYPPsDUm=nN8do2GYHM0MrGkabFM9bg@mail.gmail.com>
 <CAFLszTjM0uUjqe59iooU-kn3UZ=LxGp0u6+CQUSf-qa9ez4-gw@mail.gmail.com>
 <CAFLszTgvUeRTR_2U3oVQ4Bx4XAkmWgeqsjsRAJUQAE9cw7PW0w@mail.gmail.com>
In-Reply-To: <CAFLszTgvUeRTR_2U3oVQ4Bx4XAkmWgeqsjsRAJUQAE9cw7PW0w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 14 Apr 2025 20:32:48 -0400
X-Gm-Features: ATxdqUE-NvQHm8lwLB-OKn6LmBS_PjMW706A4O3_zxGKAggeypYT6OkW2B06Wkk
Message-ID: <CAEfUkU+3=0eF2MRbV=H_q1FfCVXBt+ad+OnOcfuJ0ugrQVFUEA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Mon, 14 Apr 2025 at 16:47, Simon Glass <sjg@chromium.org> wrote:
>
> Hi again Raymond,
>
> On Mon, 14 Apr 2025 at 14:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Mon, 14 Apr 2025 at 14:16, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, 14 Apr 2025 at 16:06, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > (trimming cc)
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Mon, 14 Apr 2025 at 13:43, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, 14 Apr 2025 at 15:35, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Raymond,
> > > > > >
> > > > > > On Mon, 14 Apr 2025 at 07:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Sun, 13 Apr 2025 at 17:13, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Raymond,
> > > > > > > >
> > > > > > > > On Mon, 7 Apr 2025 at 08:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Sun, 6 Apr 2025 at 18:06, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Raymond,
> > > > > > > > > >
> > > > > > > > > > On Sat, 5 Apr 2025 at 07:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Simon,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Tom and Simon,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Tom and Simon,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > > > > > > > > > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > > > > > > > > > > > > > be resurrected to give some coverage.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Based on how it's documented to be run in
> > > > > > > > > > > > > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > > > > > > > > > > > > > that platforms using the handoff spec still work?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > > > > > > > > > > > > > may be able to test this series on QEMU?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I was pointing you at the docs so that you would have access to testing
> > > > > > > > > > > > > > > it. That's part of the docs, running the emulator.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I can help to test the firmware handoff on qemu.
> > > > > > > > > > > > > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > > > > > > > > > > > > qemu v8 build to test this.
> > > > > > > > > > > > > > I will try to find some time early next week to review and test this
> > > > > > > > > > > > > > series before turning back to you.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Just a follow-up on the testing with TF-A and OP-TEE.
> > > > > > > > > > > > > Unfortunately, the patch series breaks the transfer list handoff to
> > > > > > > > > > > > > U-Boot completely and just end up with below error when U-Boot boots:
> > > > > > > > > > > > > ```
> > > > > > > > > > > > > No valid device tree binary found at 0000000000000000
> > > > > > > > > > > > > initcall failed at call 0000000060097bcc (err=-2)
> > > > > > > > > > > > > ### ERROR ### Please RESET the board ###
> > > > > > > > > > > > > ```
> > > > > > > > > > > > >
> > > > > > > > > > > > > U-Boot test version:
> > > > > > > > > > > > > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
> > > > > > > > > > > >
> > > > > > > > > > > > I suppose the FDT address in the register is not being read correctly.
> > > > > > > > > > > >
> > > > > > > > > > > > Do you have a test case for this, e.g. in QEMU? Even if it is just
> > > > > > > > > > > > binary blobs for now, not suitable for CI, I'd like to get it in my
> > > > > > > > > > > > lab.
> > > > > > > > > > > >
> > > > > > > > > > > > I did create a test back when I did standard passage, but that series
> > > > > > > > > > > > seems to have not been applied. I'll see if I can resurrect it.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
> > > > > > > > > > > need my patch [2] for enabling transfer_ist in all components.
> > > > > > > > > > >
> > > > > > > > > > > [1] https://github.com/OP-TEE
> > > > > > > > > > > [2] https://github.com/OP-TEE/build/pull/821
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Tom's email seems easier to follow. I got as far as building:
> > > > > > > > > >
> > > > > > > > > > build/fvp/release/fip.bin
> > > > > > > > > >
> > > > > > > > > > But I'm not sure how to run that in QEMU. The docs mention some sort
> > > > > > > > > > of FVP thing and running FVP_Base_RevC-2xAEMvA -C which I don't seem
> > > > > > > > > > to have.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > If you want to test with QEMU v8, just simply:
> > > > > > > > > $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> > > > > > > > > $ repo sync
> > > > > > > > > $ cd build
> > > > > > > > > Apply my patch https://github.com/OP-TEE/build/pull/821
> > > > > > > > > In kconfigs/u-boot_tl.conf, remove 'CONFIG_BLOBLIST_SIZE=0' and add
> > > > > > > > > 'OF_BLOBLIST=y'
> > > > > > > > > $ make toolchains
> > > > > > > > > $ make run
> > > > > > > >
> > > > > > > > Thanks for the steps. It seemed to complete OK. I also found this:
> > > > > > > >
> > > > > > > > https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> > > > > > > >
> > > > > > > > But I'm not sure how to actually run it, or even what was actually
> > > > > > > > built. Do you have the QEMU cmdline I should use to make it start,
> > > > > > > > please?
> > > > > > > >
> > > > > > >
> > > > > > > Besides the steps I mentioned in the previous reply, you will need to
> > > > > > > checkout your U-Boot test branch after "repo sync", since by default
> > > > > > > the manifest is pointing to an old release.
> > > > > > > "make run" will start the QEMU automatically.
> > > > > > > If you are not sure it is built properly or not, you can use "make
> > > > > > > all" to build and "make run-only" for running.
> > > > > >
> > > > > > Well it turns out that it wasn't really building, but the build
> > > > > > produced so many MB of output that this fact was lost in the noise! It
> > > > > > turned out to be some LD_LIBRARY issue.
> > > > > >
> > > > > > My ideal build would look like this:
> > > > > >
> > > > > > $ make [-s]
> > > > > > <actionable warnings and errors here>
> > > > > > $
> > > > > >
> > > > > > Anyway, now that I have it running, it's a nice environment, thank you. I see:
> > > > > >
> > > > > > NOTICE:  BL31: Built : 15:06:52, Apr 13 2025
> > > > > > from_boot_arg 1
> > > > > > regs 0 0 0 0
> > > > > > Bloblist at 0 not found (err=-2)
> > > > > >
> > > > > >
> > > > > > U-Boot 2025.04-rc5-00662-gcc30c7943060-dirty (Apr 14 2025 - 13:25:06 -0600)
> > > > > >
> > > > > > DRAM:  1 GiB
> > > > > > Core:  51 devices, 14 uclasses, devicetree: board
> > > > > > ...
> > > > > >
> > > > > > My code is this:
> > > > > >
> > > > > > int xferlist_from_boot_arg(ulong *addrp, ulong *fdtp)
> > > > > > {
> > > > > > int ret;
> > > > > >
> > > > > > printf("regs %lx %lx %lx %lx\n", saved_args[0], saved_args[2],
> > > > > >       saved_args[1], saved_args[3]);
> > > > > > ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
> > > > > >       saved_args[1], saved_args[3]);
> > > > > > if (ret)
> > > > > > return ret;
> > > > > >
> > > > > > *addrp = saved_args[3];
> > > > > > if (fdtp)
> > > > > > *fdtp = saved_args[0];
> > > > > >
> > > > > > return 0;
> > > > > > }
> > > > > >
> > > > > > on this tree:
> > > > > >
> > > > > > 37802ca2381 (HEAD) wip
> > > > > > cc30c794306 (el/blob) fdt: Obtain the FDT from bloblist without parsing it
> > > > > > 4494e4adae0 bloblist: Provide access to the FDT address
> > > > > > ef7193a9f07 fdt: Introduce OF_BLOBLIST
> > > > > > 9e6b2e9c53b bloblist: Simplify bloblist init
> > > > > > 4adbf64ff8d (tag: tmp-patman) Merge branch 'staging' of
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-tegra into next
> > > > > >
> > > > > > which I have pushed to:
> > > > > > source.denx.de:u-boot/custodians/u-boot-dm.git
> > > > > >
> > > > > > in branch 'blob'
> > > > > >
> > > > > > and the build/kconfigs/u-boot_tl.conf file contains:
> > > > > >
> > > > > > CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
> > > > > > CONFIG_OF_BLOBLIST=y
> > > > > >
> > > > > > I don't expect those registers to all be zero. I suppose I am missing
> > > > > > a config somewhere?
> > > > > >
> > > > >
> > > > > If you already got my changes at:
> > > > > https://github.com/OP-TEE/build/pull/821, and make changes on
> > > > > u-boot_tl.conf on top of it, the only missing thing might be to change
> > > > > "ARM_FIRMWARE_HANDOFF ?= n" to "ARM_FIRMWARE_HANDOFF ?= y" in
> > > > > build/qemu_v8.mk.
> > > >
> > > > OK thanks. But when I do that:
> > > >
> > > > $ make run -j30 -s
> > > > mk/config.mk:520: *** CFG_MAP_EXT_DT_SECURE is set to 'n' (from file)
> > > > but its value must be 'y'.  Stop.
> > > > make: *** [common.mk:590: optee-os-devkit] Error 2
> > > >
> > > > I can see that value in the same build/qemu_v8.mk file.
> > > >
> > > > OPTEE_OS_COMMON_EXTRA_FLAGS     += CFG_DT=y CFG_MAP_EXT_DT_SECURE=y
> > > >
> > >
> > > One dependence is at here:
> > > https://github.com/OP-TEE/optee_os/pull/7352/files#diff-6301a2703b709daa4d84ead1c30bf67cdaf088abed68753a8f9c740f1e58b54a
> >
> > Thanks, I changed it to n but I still don't see anything in the registers:
> >
> > NOTICE:  BL31: Built : 15:06:52, Apr 13 2025
> > from_boot_arg 1
> > regs 0 0 0 0
> > Bloblist at 0 not found (err=-2)
> >
> >
> > U-Boot 2025.04-rc5-00663-g37802ca2381a (Apr 14 2025 - 14:37:38 -0600)
> >
> > I think I need to rebuild BL31. So I'm doing 'make clean' and we'll see.
>
> OK that fixed it. So I'll be able to take a look one of these
> mornings. Thanks for your help. Please get this into CI soon.
>

No worries, please take your time and feel free to let me know if
there are any questions.

Raymond

> Regards,
> Simon
