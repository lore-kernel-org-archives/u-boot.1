Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE92BC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 15:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265EA8144F;
	Mon, 10 Mar 2025 16:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Kd9+wxyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CC981671; Mon, 10 Mar 2025 16:44:42 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE840811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso7753285a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741621478; x=1742226278; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSzyRqq+I7XQ1pBppVnA5hN24/dqRL+4KnslHoFnqIA=;
 b=Kd9+wxykBsutdoIgAFF5b2kS0CGdDh2uTnnzUMbqDCX7OReK0OQlhZ5/+hXIDbHjHw
 qoS0SFjyagIhw5muuPk2UjvNOV6CWSQbK+J4MKKxCjTybyIr9Aa1hSZnsX/Yiq6Jwysd
 LQC5PsuE/5NxWDg94tL5EiioJ63Ma/pX5bzrZNws/Bgp243nOhanym8AZvv80y1FrMuq
 pZRaeCah3DLSfbOhu3eP4uL9P+YOMxKOQNOjKF4kDHt3h+hjp3ujYrS16w4lKKXIJArg
 wkOLSY5LURbYAbS4A4D0VDAwZyC56Naztxa/YRU21yZ1zLnQ7jr5bSSvt7TvU43QTBMZ
 6Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741621478; x=1742226278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSzyRqq+I7XQ1pBppVnA5hN24/dqRL+4KnslHoFnqIA=;
 b=mJLnrKRbTdtpptmFZ7mw081vBn3aAXiBp6oYyKum9hcH3Lo9R2qWgkv3ySz9XI7kBX
 pGKIUww9nElALkA6c4yEroDyYBQOuwYnJS930nvWJHV95IDHMtiwgZZQF1iIsEFs02eY
 tv5QXhmybE6W3oBNiKbw6TSdPeUdauN2CxGR6jahgQww2n+4qfEnAitsL/KlLCsvh2co
 P69Mtnzv48UwsuKyLAz5Ndt8ePCBCZALNlNemJeCBv9U0iCJrPyRSnbu5PBIDdcYqaf3
 LTvT48m+IBKSbka0pQtfp74tPCVPcu7IfeWmWBjoEAshxvB11srtnwYjMCJVAKzEg/UU
 20AA==
X-Gm-Message-State: AOJu0YyW4AL6NErUupaymdnXxYEG1GVjTvB8jScN5oP6uU9V7e0KbcVd
 KZy39vPNOiaOeSrzQSx524RCWeaoVGf0r0zI19GORh0zA+u75qku3WJj2WmGM4k6n4RVTERJz4u
 YEDgy+bqiaJVBJ6CamBuph2IGYHx62tOZkpLcXNlqgajGy+I0/1j5Og==
X-Gm-Gg: ASbGnctMOMJQst/hr2kNwfGEJTICfx+oyvI6rtx9KHN3E/M0ouDeOpzgx69lzF89WlR
 V3ziGM+g9eVAsT8OurahFjAKunYQRYLzJ74L04TxUihyTbUlRZCoAerVnh8JNGPOXyxF0T90eRv
 5ZBaWam7EeuanRq5yuANkxbcdOHv7w1DFLSBk=
X-Google-Smtp-Source: AGHT+IH0+A2e4rZ1W1booHwovuRNqlbN9lVPTLYwOt6WOndzpzjNnHLF183qAvaklk2aljLT7YwOa8DeVxtdMUE+kNk=
X-Received: by 2002:a17:90a:c888:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-2ffbc16fc25mr14945320a91.9.1741621478188; Mon, 10 Mar 2025
 08:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
 <20250310143037.GB2640854@bill-the-cat>
In-Reply-To: <20250310143037.GB2640854@bill-the-cat>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 10 Mar 2025 16:44:27 +0100
X-Gm-Features: AQ5f1Jq3f3WFq6ma0UWj9AoYT_zfNOK7OGpuHO7mETOLo8gX0phujKsY1hbIAm0
Message-ID: <CALNFmy2Za0PfEOogFoCXLJcqWhDXzdxVPDzLK_6vPukxmoCczw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] pci_auto: Downgrade prefetch if necessary
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,
On Mon, Mar 10, 2025 at 3:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Mar 10, 2025 at 10:01:32AM +0100, Patrick Rudolph wrote:
>
> > Legacy PCI devices, like qemu's Bochs VGA device, are allowed to have
> > prefetchable 32-bit BARs, while PCIe devices are not allowed to have
> > 32-bit prefetchable BARs. Typically prefetchable BARs are 64-bit and
> > typically the prefetch MMIO window is also 64-bit and placed above
> > 4GiB, as it's the case on qemu sbsa-ref.
> >
> > Currently the U-Boot code assumes that prefetchable BARs are
> > 64-bit BARs and always tries to assign them into the prefetch
> > MMIO window.
> >
> > When a 32-bit BAR is marked as prefetch, but the prefetch area is
> > not within the first 4GiB of the address space, then downgrade the
> > BAR and place it in the non-prefetch MMIO window.
> >
> > For prefetch BARs there's no downside on being placed in non prefetch
> > MMIO areas, besides the possible slower performance when a driver tries
> > to map it Write-Combine.
> >
> > TEST: Fixes pci_auto on QEMU sbsa-ref fails to autoconfigure BAR0.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Do we need this series for v2025.04 or v2025.07? Thanks!
since this series only gets pre OS graphics working I'd say it's a
cosmetic fix for v2025.07.

Regards,
Patrick

>
> --
> Tom
