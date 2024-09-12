Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0568FEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7470B88E0E;
	Thu, 12 Sep 2024 08:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="IPPsZFzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F6988E29; Thu, 12 Sep 2024 08:31:28 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB41388DBC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6d9f65f9e3eso5280317b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726122685; x=1726727485; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLqRk9xs0Z8USD34uHyus8ov3Zx+G/NGqLFegF19mAE=;
 b=IPPsZFzB1xbCw2r/UZ8x0B90+yPI/KlDaqNrvznp7t109NkpcCM19lbUZYZ9RnRj30
 p1pPYEWEmXvHbZx/BuEE412dSwtatFAeIM3vSlOcRdpnIhTyXR/vFO8hCH1bAh0uP/Zc
 cGkxsL+EXOwi8+5eH7+jcKJDVB/OfwmvK8Dzo+ZvqoDgKWSatNXK19vwMoAsdNCXfGMQ
 X5856txUfXvgUzWfUuPdTF8hZ77KIQRilgteefNwAP4U0lpWse/PgnhqY6+/DlP3h2xz
 2JEyHWLI3WvmewDcTI7KsXJQySX+U3AEn9rZxur2TbpPPiz7JA2R9RGgSsqxjqwCGZ0P
 04sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726122685; x=1726727485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLqRk9xs0Z8USD34uHyus8ov3Zx+G/NGqLFegF19mAE=;
 b=LwizrrEB/VLUQmRpcbSSM8Vfaey7uu846cye7nFyQvuhU0kVTU65JktCxAKUKVpc96
 KWcNbdKDRLpJLhQ+B/iGg/5S4jpGuacyBMoEbJ9zzHMMzV8KeYZJUxKXrujoclLlU5e1
 2XBYjQR+Q6+Z2T1Tp09iLaTPWeLsJTFOoSsseS1CJhLAoaLLn1Z1ZAfzbq1+8HQFXF5G
 273fWcLUx5mnOoS9TSyRwL+rjjJSGadWJrmgZebnGn8Ky3lzcUnjc4zPho+R7aUQywYT
 dOTdi84axduC/yIfyzDVOD5ok7a3eqeCn96iOgNQy+30eC6cfnRV9x8tAsJbQzAgwfBn
 lkOw==
X-Gm-Message-State: AOJu0Yzotj/2LVJqtEPLWC5LKOfT1cE3HKWBdl9EpyAHZ8v9qB79XLXi
 ykTC+mjROpbHJ9okfnlxsDa6kguEVvL8gUWyK2Q1blvu+2e3D6TJne8nDzVmObvE8EEB25zSUCa
 4m2QIZEUW40aaGo4w5uMwy0WvDusyR6mGLqjyVw==
X-Google-Smtp-Source: AGHT+IH4kBB8JN2cgcgO3jywYmXVWr3Ng49Lv24oVaKiZ9IuWZORUke+o0pxGQVji/XNXO5oMFwy9ZkLUHYHtIhC4S4=
X-Received: by 2002:a05:690c:f0f:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6dbb69c3024mr19417697b3.0.1726122685709; Wed, 11 Sep 2024
 23:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-21-patrick.rudolph@9elements.com>
 <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
In-Reply-To: <CAFLszTgYrEk=UBd6zgesphC+rLPtkOG4fjBOYaGRQXYLNUomyA@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Thu, 12 Sep 2024 08:31:14 +0200
Message-ID: <CALNFmy3cDCTzppfr5y=sAjKn0eBKsHPq9LD4zGg0KC9HT3qNMA@mail.gmail.com>
Subject: Re: [PATCH v3 20/30] drivers/arm: Implement acpi_fill_madt
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Thu, Sep 12, 2024 at 2:58=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Patrick,
>
> On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Fill the MADT table in the GIC driver and armv8 CPU driver to
> > drop SoC specific code. While the GIC only needs devicetree
> > data, the CPU driver needs additional information stored in
> > the cpu_plat struct.
> >
> > While on it update the only board making use of the existing
> > drivers and writing ACPI MADT in mainboard code.
> >
> > TEST: Booted on QEMU sbsa using driver model generated MADT.
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  arch/arm/lib/acpi_table.c |  1 +
> >  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
> >  drivers/cpu/armv8_cpu.c   | 27 ++++++++++++
> >  include/cpu.h             | 27 +++++++++++-
> >  4 files changed, 141 insertions(+), 3 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Are the GIC values available by probing, or are they just 'known', and
> dependent on the compatible string?
Sorry I don't get that question.

The "arm_gic_v3_its" and "arm_gic_v3" driver uses existing DT
properties and should work with all existing boards.

The madt_gicc entries are board specific. Besides the mpidr all of
them can be 0.
Those entries currently do not have matching DT properties in the CPU
node that could be used.
Some of those entries are present in the GIC node, but there's no
direct association between CPU nodes and GIC nodes.

>
> Regards,
> Simon
