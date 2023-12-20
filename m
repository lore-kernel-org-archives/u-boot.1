Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4807C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 17:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2E5877CB;
	Wed, 20 Dec 2023 18:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFQswA+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B8987650; Wed, 20 Dec 2023 18:32:08 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67E7877E2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 18:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2331e7058aso561561466b.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703093525; x=1703698325; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EmTm+r/G9p1kHFK87W/9CETMSXU4LhYF7/BpFaRzZ9o=;
 b=MFQswA+SSI0P3MvLaOgMvXQuquncS66aznhcr+nqdEp6JgGPSrjVaszwEu58Rlh6aj
 q5q/utLxRaHx0TEE0A/PiI4Uxl2L0XbB84U3InNz6y9xzQz+GuCkkaiENG6x4C7sESrJ
 RTdvymNIQqyT9Hjnem2DMWKnutQ+GKx1HeOUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703093525; x=1703698325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EmTm+r/G9p1kHFK87W/9CETMSXU4LhYF7/BpFaRzZ9o=;
 b=f34K85EEDl3zKfumQbG1/8Dq1Drs4WZqcv02KuL+seeV91OwJrsNivgTUD3fuPqycx
 Wkwf3XettGE8u0NyEEt5AwLvSLbCEn40X36WAOqdaNNyS1AemcFsbkzok26Ly5LNb/rI
 ziWb6kLXjFvuXWTke4CROoQrFIQC5pMc5Zc+hxKndGzVcJoQQmhWmHJxmPeIxgCOK3g3
 RmQmZOkrYBPwg3FRgbSFetavgGz4zFsqzLLhssohRRHqpqBuh0Zz6X0eGUHZRoO6ivWz
 8q34WqJ3yVVL7tm5fMXC/HkH27f4qMo3iBKc77MNb8n3xBdYE0Qv/WhudRCcQXzPw7EM
 qJKw==
X-Gm-Message-State: AOJu0YzrodgLFxFd0FA1DMECNEw1YLUt9wpC9sl3shGx/5J595iSXHgS
 hZptSEdXhDWUgXxw/3ddyUnEw7C2zNqByuxUE5hUZQ==
X-Google-Smtp-Source: AGHT+IENm+OxMMa5cLx7FZveFDvTbXgpTurTqxlmAE8zAa2/U0cGxecqaeW9trZfSyh/suYpFIzTxsoHQ4gpkjRRR0I=
X-Received: by 2002:a17:907:1394:b0:a23:453d:95d2 with SMTP id
 vs20-20020a170907139400b00a23453d95d2mr1348961ejb.309.1703093525151; Wed, 20
 Dec 2023 09:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
 <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
 <20231213201909.GG2513409@bill-the-cat>
 <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
 <87y1dx6cnd.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ1c5MM-51qpj6tBMV03ofwFyfv2Z230S=5aatLaGN5ziQ@mail.gmail.com>
 <CALeDE9PRUhZ-cHhaU_0=3pUBET0sZ4iQ=A3yDxrtywoyWgvv3A@mail.gmail.com>
In-Reply-To: <CALeDE9PRUhZ-cHhaU_0=3pUBET0sZ4iQ=A3yDxrtywoyWgvv3A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Dec 2023 10:31:47 -0700
Message-ID: <CAPnjgZ1gJt4YUsRv65=UVz4teB0-LW83XTwKMLyBnWhjYqn3jw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 u-boot@lists.denx.de
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

Hi Peter,

On Tue, 19 Dec 2023 at 13:23, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > > > What do you mean wrong, exactly?
> > > >
> > > > "raspberrypi" instead of "Raspberry Pi", for example, or "friendlyarm"
> > > > instead of "FriendlyElec"
> > >
> > > Heh, well, even in the x86 world vendors can't even spell their own
> > > name consistently.
> > >
> > > > I just wonder what this information is actually used for. If it is
> > > > just for fun, that is fine, but I believe some tools do use dmidecode,
> > > > at which point it needs to be accurate and should not change later,
> > > > e.g. when someone decides to actually add the info.
> > >
> > > So the Linux kernel uses this information to apply quirks for specific
> > > machines.  But I hope that on platforms that have a device tree folks
> > > will just use the board compatible string for that purpose.
> >
> > Right.
> >
> > >
> > > Otherwise I think this information is mostly used to populate system
> > > information UIs and asset databases.
> >
> > So perhaps the devicetree should be used instead? How do these things
> > work today? And what are they, exactly?
>
> Device tree used for what? To populate the SMBIOS tables? Or to
> populate "system information UIs and asset databases."
>
> If you mean the later, that is not going to work. These platforms are
> often proprietary, and are generally remote. They have local agents
> that use dmidecode to populate things for support and management. It's
> kind of in the name "System Management". To get all these platforms
> updated to "just use devicetree" will take decades. No thanks!

Do we care about these platforms? Do we even know what they are? Do
they even run on ARM?

I found a thing called 'sos' and it does actually use the devicetree,
which is actually the correct thing to do, on platforms which use
device tree.

At this point I'm wondering what problem is being solved here? We know
we cannot pass the SMBIOS table without EFI in any case. A huge
argument in Linux with hundreds of emails results in 'no patch
applied', so far as I am aware. At the very least, that seems odd.

Just to restate my suggestions:
- Put this feature behind an #ifdef
- Allow people to add the authoritative info if they want to
- Add something to the SMBIOS info that indicates it is provisional /
auto-generated
- Figure out how to handle this when booting without EFI (or decide
that SMBIOS is not used then?)
- minor: simplify the code to just handle the two pieces of info
currently decoded; add tests

Do you agree with any or all of those?

Regards,
Simon
