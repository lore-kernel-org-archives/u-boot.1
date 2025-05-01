Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C395C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF848210D;
	Thu,  1 May 2025 17:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oUtpsuJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA008081A; Thu,  1 May 2025 17:03:35 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B3681E72
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac7bd86f637so396607666b.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746111812; x=1746716612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MSvUYodv0OcM0rnG94QGSxNYhM+qMnDfnGlmz9vgF+c=;
 b=oUtpsuJsJB5kgQa0glbvI5ys08+y9C6L2U2fPv+RdN/UttkmE2IQjYWT+q/gzVKDdf
 tRRveKJ1Tnd0dUhnbCYXCmpPa56Nbxi5Mp40GTS+2ZeCg1pOGA7tCxLGggtM3c+oatjB
 bvmDkuQYffS02mAsE79oVQ+QuT+WB+nrdiwxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111812; x=1746716612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSvUYodv0OcM0rnG94QGSxNYhM+qMnDfnGlmz9vgF+c=;
 b=iuh9wM8PiZp7ByvWH72k+DKIWCILDx/Kj8JYuRkATnPT6F22sLb5F9LUCkCxPZPlja
 QorKMs+JJbztWtR8uDzSMKb+suhYSOTQqShdqAYtddoPynVisuFMVet4QlF7TdHTcmjl
 8lmBkZ943kStKaiBQAnXliSlFeUO8VaJv6WOnnbH8a1GLPnnCgfxFAlLedTRT194PHUw
 8Y/DR7TjGtgjdlEe3M9d2FulrewZ0bWAmGAtNSQgBSU/VFvT9KSErAOWbxc0cUlxDlUp
 pQGcPqBLbOz3Wer7nVKCHdvha2YSMAgomTmAGn5Ux6yniXPBteDGlqkyUPXnyrZGabaQ
 C2sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx04k1lA6DclgMwkvZbgIgXqRZeXBVqaHE/cA8dm3sKICkbawZ5gsVDrq6zCcbhxQ8mk15VZE=@lists.denx.de
X-Gm-Message-State: AOJu0YyvJ2Ql1VWNlJ1skGMYtIOFCGZHJPdNfeFeqSfdJBtZ39Z+6PEp
 etdnLd62nq4gLkma46Bi53hPcgFq+bZ2BKDnSTxFfPlqaqDZFdg3U12XS3QxKnBK2DZvP4ud+wT
 l8l8ctSdJpyo4R2bfOhKcYExyNFyQSXBZ2EBP6ZLFxBjeNHQ=
X-Gm-Gg: ASbGncsaS1EjeV6/d5JGroumtcBFQyP+5cmv8J0qmOefTgkVyTHj0aPGgHUNag4RKAw
 aRrrCCTUChgAHqTALz6+fPpnS3R2Hq9LNNnxZvsYYmbTRoYVtFdAoFnjezf1r31RUzjf6TGdPAo
 P7+mEVDOZuz3X12HRQZZ8eHE8=
X-Google-Smtp-Source: AGHT+IEg+Bei84MYWFX1kOJq7eUxoCo9I3RtRKnleyeCVQdkJe0tHjGi88AcBOGZahL6LeAK2lnzwAiOpWuupRo5Keg=
X-Received: by 2002:a17:906:9f85:b0:ace:d50f:8ee3 with SMTP id
 a640c23a62f3a-aceff024bf8mr214143766b.19.1746111812475; Thu, 01 May 2025
 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
 <CAFLszTgFfcd01rdwH_TM74xwt_Uiy+DGba=6bF=-CH3GPRj+sQ@mail.gmail.com>
 <20250501141743.GE1261075@bill-the-cat>
In-Reply-To: <20250501141743.GE1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 09:03:18 -0600
X-Gm-Features: ATxdqUEHtsgn4bJ8dP46rRDWPOoxhCn_lSs8rMg9C9oPh2vLrSMBxfXf_NkKkkg
Message-ID: <CAFLszTi2mHGGO+wXBfKc1j3c3Hh4kzoOdyOgbmySYow7LgZYXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Deal with exfat versus byteorder
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Thu, 1 May 2025 at 08:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 06:07:15AM -0600, Simon Glass wrote:
> > Hi Marek,
> >
> > On Wed, 30 Apr 2025 at 20:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 5/1/25 3:04 AM, Simon Glass wrote:
> > > > Since exfat has its own byteorder functions we need to be careful about
> > > > including the normal U-Boot byteorder headers in code included by exfat.
> > >
> > > ...
> > >
> > > >    net: Use a forward declaration for cmd_tbl in net-common.h
> > > >    congatec: Include env.h to permit reading the environment
> > > >    dhelectronics: Include env.h to permit reading the environment
> > > >    imx8ulp_evk: Include env.h to permit reading the environment
> > > >    venice: Include env.h to permit reading the environment
> > > >    phytec: Include env.h to permit reading the environment
> > > >    ronetix: Include env.h to permit reading the environment
> > > >    toradex: Include env.h to permit reading the environment
> > > >    advantech: Include env.h in imx8qm_dmsse20_a1
> > > >    tegra: Include env.h to permit reading the environment
> > > >    synology: Include env.h to permit reading the environment
> > > >    amlogic: Include env.h to permit reading the environment
> > > >    freescale: Include env.h to permit reading the environment
> > > >    google: Include env.h to permit reading the environment
> > > >    liebherr: Include env.h to permit reading the environment
> > > >    technexion: Include env.h to permit reading the environment
> > > >    elf: Only use network environment-variables if net enabled
> > > >    net: Include byteorder in net6.h
> > > >    net: Include string.h in net-legacy.h
> > > >    net: Include env.h in pcap.c
> > > >    net: dc2114x: Include env.h to permit reading the environment
> > > >    net: Move env_get_ip() out of the header file
> > > >
> > > >   arch/arm/mach-tegra/dt-setup.c                |  1 +
> > > >   board/Synology/ds414/ds414.c                  |  1 +
> > > >   .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
> > > >   board/amlogic/jethub-j100/jethub-j100.c       |  1 +
> > > >   board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
> > > >   board/dhelectronics/common/dh_common.c        |  1 +
> > > >   board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
> > > >   board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
> > > >   board/gateworks/venice/venice.c               |  1 +
> > > >   board/google/chameleonv3/board.c              |  2 +
> > > >   board/liebherr/xea/xea.c                      |  1 +
> > > >   .../common/phytec_som_detection_blocks.c      |  1 +
> > > >   board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
> > > >   board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
> > > >   board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
> > > >   board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
> > > >   cmd/elf.c                                     | 41 ++++++++++---------
> > > >   drivers/net/dc2114x.c                         |  1 +
> > > >   include/net-common.h                          |  9 ++--
> > > >   include/net-legacy.h                          |  1 +
> > > >   include/net6.h                                |  1 +
> > > >   net/net-common.c                              |  6 +++
> > > >   net/pcap.c                                    |  1 +
> > > >   23 files changed, 53 insertions(+), 27 deletions(-)
> > > There are no fs changes in this series , what does this series have to
> > > do with exfat ?
> >
> > I found that in some situations, the exfat code includes
> > linux/byteorder.h instead of its own local byteorder, which is
> > implemented differently. This then causes build errors in the exfat
> > code. One way to trigger it is by adding '#include net.h' to
> > include/efi.h
>
> Setting aside if it's a good idea to have efi.h include net.h, we should
> unwind what the heck is going on. The build error is on CLUSTER_INVALID
> somehow becoming weird. Looking harder at this, the problem I see is
> that include/fs.h includes <rtc.h> (which in turn pulls in many things)
> when it only needs <rtc_defs.h> for struct rtc_time. This however
> exposes some other implicit includes. I'll go and take a look at hunting
> these all down.

OK. I wonder if we could drop the special byteorder macros in exfat?

Regards,
SImon
