Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B284E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D0580608;
	Fri, 10 Jan 2025 14:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="boUS8EGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36567806B7; Fri, 10 Jan 2025 14:39:09 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3FA80619
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so2758640a91.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736516345; x=1737121145; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9dVGM7J5eCxlndWX510+LkDvAe9KTh2dTl4VJJipMY=;
 b=boUS8EGpLiNfcRIjfQPLODR37EIoCFb9QXfnojaSm1exS0QE4BijP1Tq5xeCnwqu8G
 EcmkgLRl8jldN01f8zoxoWb575jK5HFSgzV3R+Cu0uwIoUqxUtnYt91Zmob0fLOWvrys
 cJkhthanJbQWmSisGcTo5lYUcb2hfIBP+AOKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736516345; x=1737121145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9dVGM7J5eCxlndWX510+LkDvAe9KTh2dTl4VJJipMY=;
 b=L8dAWXZ/IXFXCI6xMx/vfRhniUQhFU5MUheadiRfz22xRlT4RKITdeEYDMGhWJVGnk
 U28zbd2KGlBmMPQDFEqR4rYOleX4q4SwQSdFn0ghW2+KzvVJ5mLHimCt2YIC43FUWCly
 oR+ce5QEUI06XdJbdhypDst7Ea6/5q78LLSs0oVI/VGeLvvbdGWrfbxdKc441vG6sXdK
 7SSnruML0gC1CVzqpMjOr1onzpnhYrh0at93Yxj1ic5QhTsec8sFQtQapr3vrdQ01VMX
 6FYUPNxTf9QRi3qag6LY9NELaeLVRrjYkjPJQ99QwA9kaSj5nKFyyzpOS70zTrqKgd78
 Tm9Q==
X-Gm-Message-State: AOJu0YxA9D7tLHK4QvxG1oeRVdr8iGDQlrYJ4OUB/1AMH8ndfiAxG09e
 i5v+yuTbbbUPWJ8zLMsRInDLvqwca7AFI8VazQoaraB0u9XHyitrYHM+2Si5NoX5BmUMm3SW4KF
 zilhxnSHyBu8maEZORL1RL/BuHsZVQX8qbocB
X-Gm-Gg: ASbGnct8sg0G4pQAF5YpaeCqCWTKDQIhpq8e6sc4wR7pKU4PYm2E3vIyDffiCrq3kQL
 Pi17GXEqgYIJjGCUCcms8gY/35oN5F7wdiFrEedc=
X-Google-Smtp-Source: AGHT+IGyk5o8I1RJvCXDld3tXtpXyGDSGMbtJXVFnRb3/eVaAT5N6ksoGsOC6l09EMZSZ/WwhDQLIA8xs6dNMkXliVA=
X-Received: by 2002:a17:90b:1f85:b0:2f2:a796:26b with SMTP id
 98e67ed59e1d1-2f548f103d2mr14866830a91.1.1736516345066; Fri, 10 Jan 2025
 05:39:05 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR04MB55584A5EF725E8DF69629DF39A302@AM6PR04MB5558.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB55584A5EF725E8DF69629DF39A302@AM6PR04MB5558.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Jan 2025 06:38:44 -0700
X-Gm-Features: AbW1kvYLXQau4WOqdxO02b29oIwX9fwGlDIoxI6qK0-Hj0eDqmRLos9e-WS21fE
Message-ID: <CAFLszTg3D9C-XR7TwCqB6RAOvZH-TK7=CEN-WioSfEKWCVVGLg@mail.gmail.com>
Subject: Re: How would I do signature verification of standalone binary?
To: "Koch, Fabian" <Fabian.Koch@hima.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Fabian,

On Thu, 5 Dec 2024 at 06:09, Koch, Fabian <Fabian.Koch@hima.com> wrote:
>
> Hey all,
>
> I have a SoC which does secure boot in a multi staged process.
> (ROM loads a signed SPL to an aux core, which loads another signed SPL to=
 main core, which loads a signed u-boot.img)
>
> But the thing I want u-boot to load, verify signature and then run/boot i=
s a standalone binary app, not a Linux Kernel.
> (It does work fine when I load that and run it with the "go" command, but=
 no signature verification is done as of now)
>
> All the research I did pointed towards using signed FIT images and then "=
bootm" to do the verification and loading.
> But I cannot get "bootm" to load a FIT containing only my raw binary stan=
dalone app.
>
> Is that road a dead-end and I need to do something completely else?
>
> I would love to stay as close to vanilla u-boot (or at least the SDK vani=
lla version) and not implement a fully custom signature verification.
>
> Any pointers would be highly appreciated.

So long as you put your image in a configuration, it can be verified.
The question is whether you can load it.

bootm assumes it is booting an OS. It does not support
IH_TYPE_FIRMWARE as a type. You could write a new command to handle
that, perhaps. SPL does support loading firmware, but you are running
U-Boot proper so that isn't very useful.

For your command, you could call fit_config_verify() to verify the
config, then fit_image_load() to load the image you want.

Regards,
Simon

>
> kind regards
> Fabian
>
> Informationspflicht nach Art. 13 und 14 DS-GVO: https://www.hima.com/de/i=
nformationen-DSGVO Information obligation according to Art. 13 and 14 DS-GV=
O: https://www.hima.com/en/information-GDPR
>
> HIMA Paul Hildebrandt GmbH, Albert-Bassermann-Str. 28, 68782 Bruehl bei M=
annheim
> Gesellschaft mit beschraenkter Haftung, Sitz Bruehl, Deutschland - Regist=
ergericht Mannheim HRB 720409
> USt-ID: DE 144286400
> WEEE-Reg.-Nr.: DE87326515
>
> Geschaeftsfuehrender Gesellschafter: Steffen Philipp, Geschaeftsfuehrer: =
Joerg de la Motte (Vorsitz), Dr. Michael Loebig
>
> Diese Nachricht und saemtliche Anhaenge sind vertraulich und duerfen nich=
t an Dritte weitergeleitet oder sonst veroeffentlicht werden, soweit nicht =
ausdruecklich etwas anderes bestimmt ist. Falls Sie nicht der beabsichtigte=
 Empfaenger sind, bitten wir Sie, mit dem Absender Kontakt aufzunehmen und =
diese Nachricht und saemtliche Anhaenge von Ihrem System zu loeschen. Auch =
in diesem Fall sind Sie weder berechtigt, diese Nachricht oder etwaige Anha=
enge zu kopieren noch deren Inhalt einem Dritten zugaenglich zu machen.
>
> This message and its attachments are confidential and can contain privile=
ged information which may not be distributed or published, unless expressly=
 stated otherwise. If you are not the intended recipient, please notify us =
immediately and delete this email and its attachments. If you have received=
 this communication in error, you are hereby notified that any disseminatio=
n, distribution or copying of this communication is strictly prohibited.

[can you please drop this as it is not correct for a public mailing list?]
