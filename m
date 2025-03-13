Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A9FC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ABE80F9C;
	Thu, 13 Mar 2025 12:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GroNEoVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE5280FF7; Thu, 13 Mar 2025 12:46:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC1980756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so141836566b.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741866408; x=1742471208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SpE3VrqJGTvKR7R8eJFBE0UU5sxQHMunuA6xfkX+0Lw=;
 b=GroNEoVT/IWEd2OnsqXzoc0k3AjGJSpU1X1FigtR35cB33Z90e6PvHFh54CqGzORb1
 cUmLBtsuBaO7iGnaUZZIwzTfNQPKAt+SGjphODiM8IsMiIxdMnQZ7/BTBnN1UaFI1TBh
 8h28odaRBmI5ozuxfYNi4rLk6Dobf7atBnSBnXr7la4GnyHmayGuC3zP0bf50dAB3YSq
 QvGwwFdA1eWv7FYid8mjf2rYTnMSA1sGriZZ+UP8vMUWp+tTUqQ4QdW2AYo6yb87fjO1
 S6+lxhZkOPKkxvdieu0TLLMSIhQjjXLTPIWWKaBCxDRfkKb2uFuXFIc1dSXD+J44cNLK
 RmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741866408; x=1742471208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SpE3VrqJGTvKR7R8eJFBE0UU5sxQHMunuA6xfkX+0Lw=;
 b=Oulpc4yGyZw11XcMpzrufqPxwiUsIAicssixez6dkQdbWAMVVJWvD7dt7C9SlW31ui
 o46VftveC2t+BFPc+PUgjIV49wF1+HEzt9hoewTRytExl7UtPg0viziRNj7n7C92/ggu
 6c6Gy0lPNR4bIlWibqqGnQQFuqNqeTiJo7S7ZIlWypAo8ydEHFa2SCLEyAZpSwmvpEFf
 MZOEAwZElPjlcizkKJ+dskNLPtwmANeUtnt5hNTKEcNbwbx1qrXA7puqD9HcFahrJ5nl
 rvHf7PCHlddFur8nEv/+BjO5Zh8xI7S23rAae1bW9slH1Li3jgUxKEva/qaYrP2Hfskb
 kbyA==
X-Gm-Message-State: AOJu0YxOlbADiL+hjeHvKCMPsOIHJ2640wY4Dr7MasZB6Ttv9aKrj6yN
 wccXndMwKWZBLhaCmzDLFs7DORSp5+Kr9UQTcUpjo4/pGb4vqtIuy1lL9cUxywi9ZvDep0fa3Up
 qsyZiphQbujZQFuHlvHG00k6oJAc=
X-Gm-Gg: ASbGncs9YPy5h6AAOqVbpp3oB9I1+Jw/4IqzVhPlBXQ090X3n310PGQUy+oM39eQYhe
 D2LDWyrQVJotw7mkWx46bi2pd/AWJ4Ttm++ER8qDd6krkGWjvkY2z1F930dQVIjGQp2v3qxsjp+
 m66Dk0H0CNSoXs9HeBsRdki+WzyeqTwnNUqkDzh2BWaBjJCcdrt9oyb6eibho=
X-Google-Smtp-Source: AGHT+IFiq+6wvCrToc6vSD6YS2bQQiPskMQEUITtB523Ho3j6sy6MVdFe+GF79+tGKSmyl4rPbcWbcyvv1QdGwq/FbQ=
X-Received: by 2002:a05:6402:3547:b0:5e4:c026:2d7a with SMTP id
 4fb4d7f45d1cf-5e5e22d8c92mr31001598a12.16.1741866408170; Thu, 13 Mar 2025
 04:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALeDE9NNZGOvYQNv=XtHryfebDwjULbm30XmzjE_bAXDuz2w9Q@mail.gmail.com>
 <335a650a-1401-40ea-9ce1-fa86a66b3906@suse.com>
In-Reply-To: <335a650a-1401-40ea-9ce1-fa86a66b3906@suse.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 13 Mar 2025 11:46:34 +0000
X-Gm-Features: AQ5f1JqOGVwvE1D7vJXp7kjLzcYlrjqhgyXJCAAnMFOJzy9JFW5jLMeDTBm4HY0
Message-ID: <CALeDE9PCJoaLNDCcnc2GZin=bSct-QBd+3mDbEgso3J_SNagpg@mail.gmail.com>
Subject: Re: Pull request: rpi-2025.04
To: Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 13 Mar 2025 at 11:45, Matthias Brugger <mbrugger@suse.com> wrote:

> Hi Peter,
>
> On 13/03/2025 12:18, Peter Robinson wrote:
> > Hi Tom,
> >
> > Please pull the updates for the Raspberry Pi.
> >
> > Updates for RPi for 2025.04:
> > - Copy Bluetooth device address in DT
> > - Keep warnings from firmware in DT, if any
> > - Only add frame buffer node if CONFIG_FDT_SIMPLEFB is set
> > - Add identifiers for the new RPi 5 series
> >
> > The following changes since commit
> a383b9bd4d7e430fe7c254297540bae596649dba
> >
> > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> <https://
> > source.denx.de/u-boot/custodians/u-boot-raspberrypi.git>
> > tags/rpi-2025.04-rc4
>
> Thanks for taking care.
>
> I wasn't able to find that tag but I think all the commits are in branch
> rpi-2025.04-rc3 [1]. Maybe you forgot to push your tag?
>

Correct! Should be there now :)


> Regards,
> Matthias
>
> [1]
>
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/commits/rpi-2025.04-rc3
>
> >
> > Apologies for the later requirest. I was out for a medical reason, so
> I've
> > limited it to simple fixes/bugs because it's later than I'd hoped.
> >
> > I'll do the remainder for the next release.
> >
> > Cheers,
> > Peter
>
>
