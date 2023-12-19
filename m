Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9406C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 20:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A67871A7;
	Tue, 19 Dec 2023 21:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDE77tIn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B6D875FE; Tue, 19 Dec 2023 21:23:06 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A76A786F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 21:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so6247074a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703017384; x=1703622184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f28ApKepDm98/1RtgJTxuJ1yG6eGIxswTeqs111lnbs=;
 b=MDE77tIntOKT3aV+JaJYmYDJBekdp1rdEZDxT7hILjHwba4Phj5jsiO5FIIO4HD+aC
 rTXjV0qtHaXVsbzkmb7xjKaOJGaVbXH40pM8XYQhPAW791P+QEZIn9LV1u76CgGttf3J
 1QgWKAS3eMznZ5IjzjdYBpGmyRI3XbhWFfvXf13mBXFSCPEjGqcTvHoXYe4jhdWbUzfU
 pyUZF6A4j2XaDg8qXgXTCEO0MVqHxg38FOCZfPHxDmN76s+aLXRM1tlwZrO2zf6RSRe7
 +VRwUohQXDKth0wUa/p2bUmbevibTghJCu5taoNFFEqyBghMjb37VxhHBABc12QkQdZ9
 /alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703017384; x=1703622184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f28ApKepDm98/1RtgJTxuJ1yG6eGIxswTeqs111lnbs=;
 b=sfuZRUJIyRLJALxEXZM0hoF14voUhlcV5IU8Dpnp7zLSWVzOF86PsYOS8jcAIeEK//
 lHWsQQ+w41uDgh1DUhCYwFf/nRT04PVV10pFRFgTlPuf/C6yW5lmJb0KybL+1aOiqYI/
 6lgiPzpxwgdHHOWuA2Y4ABCIKZd/CN1wzAue+nPKVgNy6U6v9lcXOShNqI2Wme1IM5lj
 MjOcjivONJ0b8NKPp/H61Jv+IAwuXMycE4UQRsnguBQsIDAdRBMrkjw+TJxoLF48bLQF
 6sjvuDCA+rrE3TU6164eguI+jVq61BHvLvuFkVGTJAYO4A66dxVeFTvZgdSsheYJiAK9
 4AuA==
X-Gm-Message-State: AOJu0YxwVzDByigLOtpjWCOG0AhJffcxlQj7H2YF2sWrUw0iQQY6O8ND
 rw+fq8Deb4vxfMvpkEnSs1uG037NRijn+f7gfLM=
X-Google-Smtp-Source: AGHT+IE/w07EwOyozMV4qSamO6iSMLIzvWS/0bbUubTGP+0mn2RVcxtwpz+PtRYp5ASA/YkCBomrdN5ERXRBLsmuXUg=
X-Received: by 2002:a50:a45c:0:b0:553:884b:4468 with SMTP id
 v28-20020a50a45c000000b00553884b4468mr631943edb.27.1703017383943; Tue, 19 Dec
 2023 12:23:03 -0800 (PST)
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
In-Reply-To: <CAPnjgZ1c5MM-51qpj6tBMV03ofwFyfv2Z230S=5aatLaGN5ziQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Dec 2023 20:22:53 +0000
Message-ID: <CALeDE9PRUhZ-cHhaU_0=3pUBET0sZ4iQ=A3yDxrtywoyWgvv3A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
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

> > > > What do you mean wrong, exactly?
> > >
> > > "raspberrypi" instead of "Raspberry Pi", for example, or "friendlyarm"
> > > instead of "FriendlyElec"
> >
> > Heh, well, even in the x86 world vendors can't even spell their own
> > name consistently.
> >
> > > I just wonder what this information is actually used for. If it is
> > > just for fun, that is fine, but I believe some tools do use dmidecode,
> > > at which point it needs to be accurate and should not change later,
> > > e.g. when someone decides to actually add the info.
> >
> > So the Linux kernel uses this information to apply quirks for specific
> > machines.  But I hope that on platforms that have a device tree folks
> > will just use the board compatible string for that purpose.
>
> Right.
>
> >
> > Otherwise I think this information is mostly used to populate system
> > information UIs and asset databases.
>
> So perhaps the devicetree should be used instead? How do these things
> work today? And what are they, exactly?

Device tree used for what? To populate the SMBIOS tables? Or to
populate "system information UIs and asset databases."

If you mean the later, that is not going to work. These platforms are
often proprietary, and are generally remote. They have local agents
that use dmidecode to populate things for support and management. It's
kind of in the name "System Management". To get all these platforms
updated to "just use devicetree" will take decades. No thanks!
