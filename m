Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FBDE77184
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 01:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9341F801FB;
	Wed, 18 Dec 2024 02:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LKcXsMR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C98B80214; Wed, 18 Dec 2024 02:47:03 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823D5801CE
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso1059526366b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734486415; x=1735091215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95afWgmCsvpEUp04PZtLntALxM7vo5dXYx1YDF2I5+U=;
 b=LKcXsMR008DOcngg1uKURwNdaAH9c3RyaFLE2PrTPdshTktKYLNR6vllUz9pwVItRG
 oovfFS7Uae50w/PpX9udmxbPpuzmjBl+92uSDjInZ27EvQ5iPywX6JCsR0uoBHuNYTVn
 rnTKOpAqNuixgqud8R/jqr3f/7dh1HAr2Ymm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734486415; x=1735091215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95afWgmCsvpEUp04PZtLntALxM7vo5dXYx1YDF2I5+U=;
 b=T6ICyQiYTLpcKdhhyMYOd+LkWc+W3TVgkcFWXVd/i3XgJdDX1wvozvV6J2dg0omKL4
 JHUGP/HkulSPMBmGdfM8/RHZjA4QBJRBtBTlpeY7kKDTSJkI5gx+pW5Ks2q1Xg7Tuj8g
 pNNEs9fF79h0uzOLWRBHhdxGwVgOSo4tlPdMFyKlnT+JGJ7s5j28+UzCjbsAq+jPe41D
 3Md8QhXFcwOOn8v1hYXDg+neGsU9bsQViaHgxUOn5nZuT4gTDJ62w5IZyi2hemkDKiCF
 Wb6XvIkgm7w8IY3lrL8um5ygseCm8Luidn85GijJvhUn6exuY3HIrpQiQ7GhmP+uRmD8
 DAfA==
X-Gm-Message-State: AOJu0YxKdU0HRvrPkbuxp0MMMZ9oIZWgpWIzQokrjtkLpNOhIaRHw5P9
 jYNZ9mCiKDUR3zaEBgL8iFlPiEu4OWxxnnG48Wqd5VYZ/53fIq3LUW1fKDtO54um4rVuDVAqEPs
 4dIo77QfWaTRhpvlrQYLwaQxuQmqFKT842EuxRlhFCvBctkA=
X-Gm-Gg: ASbGnctD6DLyK12yNTxtwyfybzVH2z6vffNsGOe7sY1Sl/Vf+ZL6ZD5Sms2rdo20khW
 g8SzJ2J7wLNHyzafy3lqY7+RukD0ZxrwkvM7SzHU=
X-Google-Smtp-Source: AGHT+IFx8dbRleuWvyiZvIqxa6Z3gXgZZycyF66i3v17h/8CEXDnae1aaqkkL0taEmTqf4EtN2XkylA7oIRFtXIS3y8=
X-Received: by 2002:a17:907:1c14:b0:aa6:b473:8500 with SMTP id
 a640c23a62f3a-aabf48d4c53mr60921066b.42.1734486414958; Tue, 17 Dec 2024
 17:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20241211004640.3778457-1-sjg@chromium.org>
In-Reply-To: <20241211004640.3778457-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 18:46:43 -0700
Message-ID: <CAFLszTjAKvvR+mr9VFc3v4axzukCcfqWmACVsBkkqs8NGcur4Q@mail.gmail.com>
Subject: Re: [PATCH] RFC: efi: Attempt to support automatically running SCT
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi,

On Tue, 10 Dec 2024 at 17:46, Simon Glass <sjg@chromium.org> wrote:
>
> This is a feeble attempt to update the qemu script to run a selection of
> UEFI tests. It copies a .seq file into the disk so it can be read by
> SCT.
>
> It doesn't seem to work and I am not sure why. I am posting it in case
> someone else has ideas or wants to pic it up.
>
> Once Ilias' CI solution is in place, I can perhaps come back to this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  scripts/build-qemu.sh | 56 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 10 deletions(-)

I'm pulling this in as the base script was rejected for Tom's tree anyway.

Applied to sjg/master, thanks!
