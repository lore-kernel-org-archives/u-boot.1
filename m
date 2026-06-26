Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8431C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 13:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29BDF84704;
	Fri, 26 Jun 2026 15:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="DhJ4qccb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5DF84894; Fri, 26 Jun 2026 15:48:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB808460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 15:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c122e4590aeso69651666b.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 06:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782481715; cv=none;
 d=google.com; s=arc-20260327;
 b=D3OQTlFCjANVf7iP58dUV0h8qGAe5HfR7odmAw8knBFLicZjMIwEm9bWvZBjcyi4jN
 eBuadrYstw4YMUfFcLClX5DiGjBh3h5L6DVxJNQd/8BIvn3It3t+WEb2Ap7w5I6jOsyL
 4lBicbKTseWt7zBiAEx+en5Sax2J80xTdEoupBhxoKOhaOqGPHY42vinzX8l1gu0gKrf
 RPspTWMKXUgbbylxWTJocxJk586eyJhjLOjoMnj67hsWotWkVWqoJSY7ebQwywG4Bs34
 6cd2G29pbKj8OtiVz0+yWpZF6GxKa6OOQmcMT31yXfyCgOuhrblrSx7yA9jfo9PtRsTl
 nf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kQcMr8m07S1pDT+bkf/NbOhm0uZv6TtCxFnVFhCN+k8=;
 fh=JZOJxzSCNRrQMrHui+Pl70OwB++3cRtKpZ0bp1uZz/M=;
 b=RkLM70FCzkPvBgWHT6IykZiZ5FTtCL5bNyerg3XzGiNvwypulXdbUu4QmIIbzEhCYc
 Fsy30JIkagDae7Olf0S8YpX2W2iHwiQ48qk8AtpGuBK8LWDPVuRi7LM1SZpoPrFxDosA
 9X8V0KT6V+5YiikNYZ+L7zZzWlZPBle1yXR9I0TeqKDG1SY3a6ZH7qf8ZvRSL2rzrmNK
 nACCWiIauAbZBOO70odmwChA4MdAiodPx8HmCGSjq/omgcyDrU3NVZYiUXZAUciz+O+h
 eMfogPnzfNpjrxJ7SiZ7MPOWMjOh3O6n3X6DIga95G8pu6Bvj+YhR98MAgSq6lHdY2DP
 Dlwg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782481715; x=1783086515; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQcMr8m07S1pDT+bkf/NbOhm0uZv6TtCxFnVFhCN+k8=;
 b=DhJ4qccbGlmmyoWnTNaM4NARs4FlSoO5J+OCjbMUC26qqrqDp3dk5CC91ye42cG9MC
 PHE0ipYxGGQ5O7PZrsK/zrFSHZvbR1E7wL/iXqxBeXw0bgfnIRgESLY5hDrF37Eih6je
 9QzuJ2Ync9Nn7e2TGv2m/tOqLB7v5jdamNPi6MAtO8Pjc+vT4KKkIFveTUAKzaRh5k1K
 +k2z0gQDzrwcSXM2P5eFvNWW+LPdmZtQs9ZNwfBgevn5TN44yU8YrN6puus5j5SLrpzK
 QoeNjirvlYSVOK0NgjD9NiPHdLJsDtHwRJ8+AouLKtjfrceb1hOVaVHRrvX2Ic2Us2h6
 WrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782481715; x=1783086515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kQcMr8m07S1pDT+bkf/NbOhm0uZv6TtCxFnVFhCN+k8=;
 b=TV+O/fo7oLLBWZNSseF745TvdZwn4RkTjX/YIyysKEzd8rygsnYeAgq3MxNDBlyScV
 bX5Slnks1qOumWrqHvy6cYmvYGd7nq8bmU46qFqNuDF0NsNlhJk+yTbulIuNGD0oyPDR
 BQ1IzwFj6oYTJ8WF98fpxjp+Ap/VgmPkyYhqKKRxJ3NMQwEOGw18BYw6k4JaNpIPeJvI
 UD6xLVIZ3wnGNp/TuAYf2yKGZAGwuZtAqgiw7z6Mj4To2EjjLrgKQ1Njdk64ZLX9vIui
 Y0KtrtSeCw3sgBN1N0nR6f609YN+xlLIIqnbIeceOEUEK9cDHZXOhcmRi6HPQt1VOMF6
 3cQQ==
X-Gm-Message-State: AOJu0YxOBFXuIOzidfR9GGA61AmmXfD46XlgIiwWyZc8uHdYz6DGi4CG
 Mmh5kgfpajI3XxUoYn015LFIOTjkOXbGaV3rHdyQLOTapBHX2G7NolynsTpvchJDFG4pnJj4If0
 PfjWBAMPuNPx82522yuwx8uXB7gsC3FbWF+sTH5ySiw==
X-Gm-Gg: AfdE7ck+8w254dEDAavqNaLA3iQ7lUhNJRuN9I6A5fxyY3yiQKVSXzkdJ3JSJbxGgpd
 S0GGmXKsqtDoeRj/OSlnXWvMmJf2/X9a+1CK5zXeay1kBKLh/MqQ21VFDywj3DhzwUipmlf++10
 1gu4f5rXASXbHYvLfIP1RWn341POcIfJxXB5a0xvZy1RSF0/3maqcmh+SBg6/in2WnlWQDHiNvx
 gDgLVBei/GWS/pQdebAk6UcWiXG+HB1TwQ6NycBWwCz8ZBNnK1jtCQtjG3QImVF/aoOB8V2ZqO8
 p78jE0FYH8nks3WkjbxfIZ6vDyaD5Q==
X-Received: by 2002:a17:906:fe0c:b0:c12:34f0:49b8 with SMTP id
 a640c23a62f3a-c1234f04a8bmr28120466b.59.1782481715466; Fri, 26 Jun 2026
 06:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
 <20719d8c-75ed-4c03-a542-5537e8e9be84@cherry.de>
In-Reply-To: <20719d8c-75ed-4c03-a542-5537e8e9be84@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 26 Jun 2026 17:48:24 +0400
X-Gm-Features: AVVi8CfbzpCvSz8QyDTZd1xkjpWGooOmdzqfZVTS-J1j9dyyDWxjrj7xax4zr_o
Message-ID: <CAKTNdwFXH_tSYT4y60GTTff1t9XQF50BUc8EDAiC0vVFCRV2hw@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Quentin,

On Fri, Jun 26, 2026 at 3:32=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 6/9/26 6:52 PM, Alexey Charkov wrote:
> > Modern Rockchip SoCs such as RK3576 require ATF to be running to provid=
e
> > firmware services to the OS. To enable booting Linux in Falcon mode on
> > such SoCs, add binman support for generation of FIT images containing
> > appropriately split ATF raw binaries (as is currently done by binman fo=
r
> > U-boot proper images), externally preprocessed DTB and a Linux kernel.
> >
>
> This is a bit misleading I believe. This is generating an image for
> falcon booting via USB download mode. The earlier patches support falcon
> boot when booting from standard storage media. We do not need this to do
> falcon boot in general (or maybe I misunderstood).

This patch creates both a USB download-able image (with SPL prepended)
and a "plain" FIT with Linux as the payload for booting via Falcon
mode, which can be written to persistent storage.

> I'm against this patch, specifically the part modifying
> rockchip-u-boot.dtsi. The only U-Boot part in the whole process is
> concatenating SPL with the new FIT image (which has the FDT optionally
> coming from it else externally), which you can do outside of U-Boot
> yourself. I don't see why U-Boot should accept this patch but maybe I'm
> missing something?

U-boot here (or rather its preconfigured binman instance) is mostly
parsing the TF-A ELF file and creating atf-SEQ entries in the image.
It also ensures consistency between what U-boot SPL expects (as it's
encoded in the current rockchip-u-boot.dtsi) and what lands in the
Falcon FIT image. It is possible to generate the Falcon FIT
independently of the U-boot tree, but doing so manually is a royal
pain. I believe in the end people would still use the U-boot codebase
as the image generator, but we'll just make their lives more miserable
if we can't include an entry in the existing template (with the
deduplication Jonas suggested).

> This implementation is also specific to Linux, will we have patches to
> support Zephyr, FreeBSD, etc... in the future? I see this as opening a
> door for things we don't want to have to deal with. How will you deal
> with multiple device trees? With device tree overlays? How will you deal
> with A/B update mechanism with falcon boot?

Currently U-boot SPL doesn't support direct boot into Zephyr, FreeBSD
etc, from what I can see, but it does support Linux images on other
platforms (those not needing TF-A) even without my patches. So other
OSes are out of scope, as are device tree overlays. Falcon by design
only supports a pre-patched DTB with all runtime detection already
baked in [1], so one would likely pre-apply any required overlay(s)
along with the /chosen node fixups before including the DTB into the
FIT image.

Multiple device trees should work once I implement Jonas' suggestion,
as long as they are runtime selectable by compatible strings via board
code. It's not a generic distro-boot mechanism though and will
probably never be one, because it's coupled to specific hardware by
design.

A/B updates should work (or not work) the same way as A/B updates of
the U-boot proper work (or don't work), respectively. I haven't yet
explored that avenue, but can't see a fundamental reason why it
couldn't be done.

[1] https://docs.u-boot.org/en/stable/develop/falcon.html#example-with-fdt-=
a3m071-board

> To be clear, I'm not saying what this allows is a bad idea, I'm saying
> U-Boot is not the right place for this.

Well the U-Boot repo historically hosts `mkimage`, which packs a Linux
kernel (or something else) into a format U-Boot understands. I see
substantial similarities between these cases.

Best regards,
Alexey
