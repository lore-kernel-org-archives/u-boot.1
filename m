Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC6DC83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 02:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F5286439;
	Sat, 26 Aug 2023 04:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PYAP8Bmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A4A86AB1; Sat, 26 Aug 2023 04:04:45 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F9086430
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 04:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52683da3f5cso2079413a12.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693015482; x=1693620282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W9c0Kl7gWQbcOGucrQaSuzkRpzKEyh2VsyXfQc04TZQ=;
 b=PYAP8BmyVnLbDs17skQvhzJrSisHfeqk4agOE3RBumqFcn5kI4cuVBZre5WZN7kS5q
 j/JUR7KOVOWCKrPpAle1OYtE+YhhQAuJPqKMizTy0+FrXQ4GXqPkngXtUiM7HD7KeDmw
 JzJMFo1erlUcJB3gTs28ehglKoUOzNwnz+1PKGg5pA4wyNwTUOydM12F98qz+k9m8b/O
 wXevGhIZfGNOLxybMk2TN7yjLypZYt6ceIsW5m1UOCyARfp0hyEv6eF9yMkbx8eMDFrS
 Xssci3sQqsilK0l+6bA+IL1XVleOFW/Sg9QzV+se735rcUrfk/265YDQQM08rXQQNib+
 Novg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693015482; x=1693620282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9c0Kl7gWQbcOGucrQaSuzkRpzKEyh2VsyXfQc04TZQ=;
 b=Za8cQANVChpVK76omuVA0INTUrs57xoDboKhqP9XrxeNDoum6Cs7tj4o0m+tmSdNsY
 rIqKoGV+Dmo8CQraatcbylGMAGoFMo3/627dzbn++cehbTHckxrNAv0NcLmi706It/20
 1zsCzkscpKzYF2THSBpqMuyMRZ6uQJBnwA8MAy2tVNJ8JCBhXR57rfs8wMMPDcc2yPB8
 XZj4FDdklmCLjohH28IAOlCJTtoh/T/6gj9yitNMkXxmEiXuLLt3Hj7dtkj7tT7veBom
 SEO/W+f+7ckZtEO+IvAeiFIU1J2tRVdVDnIl4cUd8E5s8+YY2bXpYDL2B/3bRU7T5Uyr
 vmjw==
X-Gm-Message-State: AOJu0Yy9cUpd7SSkIlYOqJdOFrxmwXTwbHN02zuOy1lY+onsNVH1B5u2
 T9RX3YuI5JZmumTjXpMa84Hf0baGhuQ0WQ695lBriw==
X-Google-Smtp-Source: AGHT+IF/MdA+3+DWGsxKs61vMseBd2yE5p9DB0bxJGtHo/BP0f8qKXqIw15JkdQFSo6Vd6yOLaLFFCqgf0UIDqWVphA=
X-Received: by 2002:aa7:c391:0:b0:523:2911:950 with SMTP id
 k17-20020aa7c391000000b0052329110950mr12721012edq.18.1693015481627; Fri, 25
 Aug 2023 19:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
 <20230825012224.ydk4332yb4qodrdb@unfazed>
 <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
 <20230825015931.fkx7jx4sqxdr7cqe@directly>
 <CAPnjgZ1uzjhTPNhfE1NR2Boq-M_kABTrA=19xy0s9nSsXWWU0A@mail.gmail.com>
 <CAOCHtYgObufq4YKNFbn50Xk1VUmF4+_mFid9M9=JHVLwrmvBFw@mail.gmail.com>
In-Reply-To: <CAOCHtYgObufq4YKNFbn50Xk1VUmF4+_mFid9M9=JHVLwrmvBFw@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 25 Aug 2023 20:04:29 -0600
Message-ID: <CAPnjgZ3gnFaSTNnQOaKyVq4THqF+xtraYxDE8wwoYPdCnzhKAQ@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Vignesh <vigneshr@ti.com>, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Hi Robert,

On Fri, 25 Aug 2023 at 19:06, Robert Nelson <robertcnelson@gmail.com> wrote:
>
> > > Just https://etcher.balena.io/ and flash an SD card with the official
> > > image here: https://www.beagleboard.org/distros/beagleplay-debian-11-flasher
> > >
> > > https://files.beagle.cc/file/beagleboard-public-2021/images/am625x-emmc-flasher-debian-11.6-xfce-arm64-2023-02-04-10gb.img.xz
> >
> > OK I tried that on an SD card, but it is still bricked.
> >
>
> Hi Simon,
>
> I've found the bootrom can be a little too quick and you'll get stuck
> on a failed eMMC bootloader.
>
> I find it best, with power applied, if you hold both the USR and RESET
> buttons down, then lift off the RESET button.. This will ensure the
> bootrom/sysboot will actually load the microSD's version of u-boot.
>
> If it's still failing, please grab this newer small August release:
>
> That's posted here:
> https://forum.beagleboard.org/t/arm64-debian-11-x-bullseye-monthly-snapshots-2023-08-05/32318
>  (updated monthly)
>
> Specifically this flasher file:
> https://rcn-ee.com/rootfs/release/2023-08-05/bullseye-minimal-arm64/beagleplay-emmc-flasher-debian-11.7-minimal-arm64-2023-08-05-4gb.img.xz
>
> Use Balena Etcher to write it directly to a microSD.
>
> Insert microSD in
> Apply Power (leds should turn on, if not hit the PWR button to wake up
> the TPS...)
> Next, hold both USR and RESET buttons
> Now, Lift off only the RESET button
> When even more leds turn on, lift up on the USR button.
>
> At this point the serial should be loading/booting linux, and then
> running the eMMC flasher in single user mode.  Within 5 minutes or so,
> it should shutdown with a new image in the eMMC..

Thank you, that worked!

Regards,
Simon
