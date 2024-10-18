Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5F2D3F281
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E26188D5B;
	Fri, 18 Oct 2024 22:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HWxDsdfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DAA88D5B; Fri, 18 Oct 2024 22:17:51 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7D2488DC6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so13787226d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729282667; x=1729887467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvArZyr+7b7xXs/z9Pm4+AxUZShCZde9qCIo4F3lD2s=;
 b=HWxDsdfcVk9QVWifZOdvJKnW8mq23MHeYL/DLL/F8xJs8Ejf59VFKOng0e9H3HrWRd
 aJb5H0ZGoeWgoLMZEHrqrR32qT0i56NvN6RaCqfWW3eoScGxOdRYQCOQoCo/6eh9wt3m
 Jo/dhswwzm1pYwRQD8ZwgaVWoFDwZX8V3CEMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729282667; x=1729887467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvArZyr+7b7xXs/z9Pm4+AxUZShCZde9qCIo4F3lD2s=;
 b=jzJUdY6AII8OpP25Va/RBAMFVpCKMWbpZ31rI9ykJ6ZIXotHX0Z+ZGU1Xuwaa5kQWD
 Whdx1eXs0MUXJ6RS7GSjhtxB8Z+GgPzdR12a2kDxwSIST5kOQGhNm3u5Y8GgVBdFm4Qh
 Cw2lCtPEzU569aXDMc6N2t1PYKKTLjGAt4uvcyhV4SkL3lSNPKIOLjKhpwYS37ngnvfK
 Jw71KlymNyPNo6vqZq69D+0+nR2eHjhfcgFWDz3i8I570iQklnx+VTnwG9KwQO+FXoMf
 NenXesesEj2mmvRPrDV1A/qsmJq5ad3jgwuS4hiK6+cX8nBZ+uQs5yDR8Jm2O3xwPw1+
 hxqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIQpnGfePfdx2BFlotmes1yTfhIhIhZxvIpOM8FjXZfjEuJdk2sEuoPwy9Z6KUzIiaLzACotc=@lists.denx.de
X-Gm-Message-State: AOJu0YyK2seZ2CJtk8/176A61yXkkzhEZ34hNC9xwMyvHzGbEITkYR/T
 49L2Rso1L5/fQUv8GihSxlQmI81kwhcHXLbt2MLgCo1vQEm5tBMJ0Y5NzqCMiunvSs6RBEk8DzC
 Sv7xj4YM3h+29kdvhSCq2ihtpxS7U0lY5Pugn
X-Google-Smtp-Source: AGHT+IE9+Szutyyx/RI3lP/iqqweqb/PpflNIC174jwwW4ouH7j9L6s0p/lx5K/YREqjhOtcNkESU8UjwLUGblyT4pk=
X-Received: by 2002:a05:6214:4608:b0:6cb:ebfa:c478 with SMTP id
 6a1803df08f44-6cde1548cf8mr51712486d6.28.1729282667226; Fri, 18 Oct 2024
 13:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
In-Reply-To: <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 14:17:36 -0600
Message-ID: <CAFLszThZ-s1Kwhv0DBoEG2uKE=MFdb_CmOY5hn0O5dVuFUP=Vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 18 Oct 2024 at 11:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/18/24 19:21, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The EFI boot-manager is the default method to boot EFI binaries.
> >> We should be able to use it on the Sandbox.
> >>
> >> * Enable EFI boot-manager bootmethod on the sandbox.
> >> * Adjust unit tests to reflect the additional boot method.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> ---
> >> v2:
> >>          no changes
> >> ---
> >>   arch/sandbox/dts/test.dts |  4 ++++
> >>   test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
> >>   2 files changed, 21 insertions(+), 11 deletions(-)
> >
> > This is better, but I still see this.
> >
> > => bootflow scan
> >       efi_var_to_file() Cannot persist EFI variables without system partition
> >
> > Please find a way to get rid of it. I can give some suggestions if you like.
> >
>
> Would you, please, mind providing a rationale why you want this correct
> message not to be written.
>
> I expect the sandbox to behave as any other board and provide warnings
> when they are adequate.

Well, what I am supposed to do to fix this warning? I just don't want
unactionable messages coming up in bootstd.

If it happens all the time and cannot be fixed, you could add an
option to the driver to ignore it, which can be controlled from the
devicetree node.

Regards,
Simon
