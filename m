Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A067C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E95B87119;
	Sat,  4 Nov 2023 20:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jJJBsvyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0397687119; Sat,  4 Nov 2023 20:43:44 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F7886EEE
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a55302e0so4263921e87.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127018; x=1699731818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pVF+qoLpNEMYIwrQNY+fUKyheLehPqoQZ4ldYIqeOiI=;
 b=jJJBsvyW1u0x0Rbb4JKsW3Oahr002fo0gxBKtKae8nYjaUDVajQtl/hBrwJgPYe7FR
 vbDyf0SANPfahN/m93gk18muRIAr7AKSobk03w+kgUwcD+g2bwhRx1aI6XdeO4R4Do6R
 XxCPU5tvwlTF4bCnUpBxYJciIxolMDKj56wqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127018; x=1699731818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVF+qoLpNEMYIwrQNY+fUKyheLehPqoQZ4ldYIqeOiI=;
 b=fBh2z0pLqIDH0ltDP9nGkM+umB47f1+lkNw7/H/TZfUX9iFz44x1LnDfSZmqY9Ddoz
 ji3jzzo+VriCbmnB7B2Dajyhpd/6TEqEeSz0jc1aoXOx5MbiFPfCH+o8Yayz9KNexHcs
 rqBEk2mNHrnXzGYW17cRR1V6b3Rxtuqu2xLJZJ8PKPx7raa5Ft9cuZPfHOrzw2EYCM7U
 9Mw0dgpJDA1XNROF8kQ9yAkA/YlqRiZUCt+/rdryox19sF7MVGBV5x6GVMUmW0i7+43U
 61px/cq8TmCEm0SW32mmvx20Z7Ve+R5mZXLaE6ezSkDT6iYPZ4iFB7fVW5re0LORn9ZI
 cvqw==
X-Gm-Message-State: AOJu0Yw5UNgLLBSvevYN3ScQ9KCurGxinms3fSQ4obyUjRaVFRjm3KUk
 7rz94aUQkFDkqOFNBkmvMOhWoVsTm3KBJyA0uB266g==
X-Google-Smtp-Source: AGHT+IHIExAodVjN1+s5jOXCNnKHZ4c5uawggLMU8Y6bi+6DIMp1wUkMCfBWsZUaoaRe0vWCI5rkaUsMbeTXhH6+9wM=
X-Received: by 2002:a05:6512:491:b0:507:b0a1:6088 with SMTP id
 v17-20020a056512049100b00507b0a16088mr19319707lfq.46.1699127017514; Sat, 04
 Nov 2023 12:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
 <df7c8647-abfe-43a8-869d-6a570a109f9c@linaro.org>
 <CAPnjgZ3HM-f_Af0uKEz+4vDT0f4-6AWhOOEaDNqYWko70f6rvA@mail.gmail.com>
 <87cyx2re5k.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87cyx2re5k.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:43:25 +0000
Message-ID: <CAPnjgZ1h_Fss3_98EDZPtDYBUaFnUtXnP5Q3E32UPq_5yKRXrQ@mail.gmail.com>
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: caleb.connolly@linaro.org, dsankouski@gmail.com, 
 vladimir.zapolskiy@linaro.org, rfried.dev@gmail.com, xypron.glpk@gmx.de, 
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

Hi Mark,

On Wed, 25 Oct 2023 at 08:05, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Tue, 24 Oct 2023 12:34:39 -0700
> >
> > > This mechanism of retrieving the DTB is also used on the apple M1 I
> > > think, and any other board where we're booting U-Boot as a drop-in for
> > > the kernel on arm64.
> >
> > I believe M1 is an open source project so perhaps they could adopt
> > firmware handoff when it is finalised.
>
> Hi Simon,
>
> I'll repeat what I've said before; handoff for M1 is deliberately 100%
> compatible with handoff to the Linux kernel such that it is possible
> to bypass U-Boot and directly boot a Linux kernel.  This is a feature
> the Asahi Linux developers depend on.
>
> If you want us to make changes here, you need to convince the Linux
> kernel developers to adjust Documentation/arch/arm64/bootig.rst to
> allow for the firmware handoff convention.

I don't have an infinite memory. In fact it does not extend all that
far back, so I appreciate you mentioning this again.

What is U-Boot for, if Asahi boots Linux directly?

In any case, firmware handoff needs to be treated separately from
Linux handoff. If you are trying to push the Linux approach into
firmware, it will cause all sorts of things to become impossible,
including universal payload. We can handle this with magic values in
the registers, if needed.

Of course, I have to mention that if we used a sensible format with
metadata for Linux (like FIT) programs would *know* what they are
booting, and be able to set things up correctly accordingly. It is
high time we started thinking about this a bit more holistically,
instead of going for the lower common denominator.

Regards,
Simon
