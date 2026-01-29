Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3C4D3569F
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB09983BB1;
	Thu, 29 Jan 2026 06:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVUPdqlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9281A83BC4; Thu, 29 Jan 2026 06:00:49 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4429683B97
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d18dd2adf7so302452a34.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769662846; cv=none;
 d=google.com; s=arc-20240605;
 b=IkPjC4XopIEM2yvKxlLxAWSXFZs/MMnehdrxne77A8aupItuEKXVAJGPhs8vNmWqhq
 VIn0eJvCh2n1mNLvWIESmolTLtIcEAGEwFRDA+8LaWp8vbEMTLHr9+yxv9UhjxxTxJMk
 f7rLVrs+XRJPAGY9D2/I4Q/ktylQgGuOEAhp/mWLVXD+3yHwK0+b+KIK/wET866K0bWe
 6Y1254ej0ViU+awpYTwzBaE7arwYqsZaTPvP8RVj+C6vRbnEsHVAiJrTezH2TtOo5xtt
 G7VYPb93bvjJg/I7DEx/0xPM2z0Oj628Rmo5QW/Y8wztX2RwlEIWkL4wOHsXdKvqQi0z
 2XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xmWZvMETf1t6Vr0+4FwAHWcgkeHA0NxPDs+vYEKUwS8=;
 fh=Qm3buBFhowXJ8bhVYr8tOWKj1dvTaw6qhjxliUC6caM=;
 b=OVuMnyrJ2aIBDfr9F07/R3enqHkJUxguqZykkcRWYgO8KFRevxbvAW6eaVWlsooNfX
 eCYrqWfhFfGP2vCy8Jr78ZyZOxOwsdAE4mCdum6+HZjsOitmmSZyjidmIZWuZnqczW75
 RDi42TgNaGVrY7BfTy2wRho5j+QHZmFOHb0GkSVM0cEqbAWtb6TJ0unXlVqjQmoSPD1K
 b0yWClkk6tm3Xm6miZpxz8C3jIRJMQGa9/15zi41tUCwqzqX/gvoYzJYCdgDA/CpDzL+
 gEJ4lmGMJzDI0XrKxsYJzJ81qT9Ato1bEjFIlidNEUyg/tr0S0qCqCqyOODU1izp35nq
 H1+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769662846; x=1770267646; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmWZvMETf1t6Vr0+4FwAHWcgkeHA0NxPDs+vYEKUwS8=;
 b=ZVUPdqltDq81uOk6nkC4Jmeq9eYHe74seJIbCQ3re421QSdPtbBEnx/L6I3qGjNv6E
 slpbjSRw0DhGsCkWohZBHbDv1psngLtJa64hCSsHFt5cAtovULHCaOFWFZV7og755vEm
 bLOqtcXNI+5a46OE6J4YS/yCNPKyHBbcb5IH7CjmrXje9L8G7jOutl6SZURTS6aiBxsb
 FQlUW2c5nPTJmXkVtoKnS0utn4eLRLORzgjgaNLy65v+zQpdUENhu16fcKUBeVrdLqpd
 umphyZDjBJGvgBG75oe67iyDkMSXgnlut6ESfcUZXumvdnmWpTPLm0FYBdYY36kTAZ5J
 QoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769662846; x=1770267646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmWZvMETf1t6Vr0+4FwAHWcgkeHA0NxPDs+vYEKUwS8=;
 b=cjuwhwSUQEWOFDtpHp6BAoHtDrYBTbbbtlHKzHsVOP8WtIkHbt2cBhdwig7JeauIFQ
 4VdEH4ff4CIWBkADAi2CJzqQ28K7PL1Mz/u+J3LLyngWuvMGkTJhXjjMEbX5+3mROxrt
 cDc/aikQurDjRdGm0/gxHork9Okbq33uoerkcjcr79QwklyxBPnlaKKY/PYrWyvjVDBl
 yN9umqPuZBarioxQHwGzJEuR789kkNcMbDmpSd/gyK1c1VWFoHwPv70xOvmvRFlaAL44
 q37QqQxizx1xb7KwHidm+RP+Pphj60qWJDz17cIsV5qHFpU7DK0W7O8X+AnGRkfn9b0p
 IRZQ==
X-Gm-Message-State: AOJu0Yz23rPNvQ7fdNi4s3NhMhLnNy2QbjS5diJwqFWWdDL3zlZpph6p
 NRYU1/wYzY/xj9kS0zUD19smjNOeJpts+nFtUb4/zT8LYZc3CQ1KeZFVADSFnlenX3qYEQ/o+e2
 QhaN5OPCQiqzIdRZ4+dnMw/Lr3b2VGmJJzEXO9KU=
X-Gm-Gg: AZuq6aKHUeqbp2SedCvTHCLUSsn1E5d8Ue1rMM1RlaMQin6HGgUugugePh+F3kaULg1
 KHR7ru7+2UOhBqg/iBa5/YGtC0osKp992aO4ApXBICcaUi3zYAW1M4yJwJE8wBbrgKY49cWy0lQ
 z2FkNwvkHJ4RhHILr7JPI6z12uRTaK5plLrpsz1/hjk/I2TpDs3LCJcSWtwNWqOy/b9MLAgfEm2
 HFZV4Tp/1Ks4spdk56kzVjPhuiEDl6EEh6NMfetgwT3jXc4KOneP61SnD1TUn+bmHUiX1LX
X-Received: by 2002:a05:6830:82d4:b0:7c6:cd24:6392 with SMTP id
 46e09a7af769-7d18511dc11mr5176789a34.34.1769662845834; Wed, 28 Jan 2026
 21:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20251223123910.4639-1-briansune@gmail.com>
 <CAN7C2SDx4KG=yKD1YhK7AXOYHDM9XDQhkpHzVPvgAcUdFFYRsg@mail.gmail.com>
In-Reply-To: <CAN7C2SDx4KG=yKD1YhK7AXOYHDM9XDQhkpHzVPvgAcUdFFYRsg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 29 Jan 2026 13:00:34 +0800
X-Gm-Features: AZwV_QhfOMnhKx6dNIbGpgh816-SedsMA25TdpA0RHPV73Awffiwh8hU6-bhdsI
Message-ID: <CAN7C2SA3HFA8qZAtczuR47yhaLQiGiADY9mXZDTHd3nJofHy4w@mail.gmail.com>
Subject: Re: [PATCH v2] Replace TARGET namespace and cleanup properly
To: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
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

Hi T.F.,

This patch is a bit troublesome but the earlier the better.

Any idea of the entry point you suggested?

Thanks,
Brian

On Tue, Jan 13, 2026 at 2:37=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
>
> Hi T.F.,
>
> Any issue on the new board patches?
> Please review and push to the mainstream if possible.
>
> Thanks,
> Brian
>
> On Tue, Dec 23, 2025 at 8:39=E2=80=AFPM Brian Sune <briansune@gmail.com> =
wrote:
> >
> > TARGET namespace is for machines / boards / what-have-you that
> > building U-Boot for. Simply replace from TARGET to ARCH
> > make things more clear and proper for ALL SoCFPGA.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  Kconfig                                       |   4 +-
> >  arch/arm/Kconfig                              |  30 +++---
> >  arch/arm/dts/socfpga_agilex-u-boot.dtsi       |   2 +-
> >  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   4 +-
> >  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   6 +-
> >  arch/arm/mach-socfpga/Kconfig                 | 102 +++++++++---------
> >  arch/arm/mach-socfpga/Makefile                |  32 +++---
> >  arch/arm/mach-socfpga/board.c                 |   6 +-
> >  arch/arm/mach-socfpga/clock_manager.c         |   8 +-
> >  arch/arm/mach-socfpga/config.mk               |   4 +-
> >  .../include/mach/base_addr_soc64.h            |  10 +-
> >  .../mach-socfpga/include/mach/clock_manager.h |  14 +--
> >  arch/arm/mach-socfpga/include/mach/firewall.h |   2 +-
> >  .../mach-socfpga/include/mach/fpga_manager.h  |   4 +-
> >  .../mach-socfpga/include/mach/handoff_soc64.h |  24 ++---
> >  arch/arm/mach-socfpga/include/mach/misc.h     |  10 +-
> >  .../mach-socfpga/include/mach/reset_manager.h |   6 +-
> >  .../include/mach/reset_manager_soc64.h        |   2 +-
> >  arch/arm/mach-socfpga/include/mach/sdram.h    |   4 +-
> >  .../include/mach/system_manager.h             |   6 +-
> >  .../include/mach/system_manager_soc64.h       |   8 +-
> >  arch/arm/mach-socfpga/misc.c                  |  18 ++--
> >  arch/arm/mach-socfpga/misc_soc64.c            |   2 +-
> >  arch/arm/mach-socfpga/mmu-arm64_s10.c         |   2 +-
> >  arch/arm/mach-socfpga/reset_manager_s10.c     |   2 +-
> >  arch/arm/mach-socfpga/system_manager_soc64.c  |   4 +-
> >  arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   4 +-
> >  common/Kconfig                                |   2 +-
> >  common/spl/Kconfig                            |   4 +-
> >  drivers/clk/altera/Makefile                   |  12 +--
> >  drivers/ddr/altera/Kconfig                    |   6 +-
> >  drivers/ddr/altera/Makefile                   |  14 +--
> >  drivers/ddr/altera/sdram_soc64.c              |  14 +--
> >  drivers/ddr/altera/sdram_soc64.h              |   4 +-
> >  drivers/fpga/Kconfig                          |   2 +-
> >  drivers/fpga/Makefile                         |   4 +-
> >  drivers/fpga/altera.c                         |   8 +-
> >  drivers/mmc/socfpga_dw_mmc.c                  |   8 +-
> >  drivers/mtd/nand/raw/Kconfig                  |   2 +-
> >  drivers/net/Kconfig                           |   2 +-
> >  drivers/power/domain/Kconfig                  |   2 +-
> >  drivers/reset/reset-socfpga.c                 |   2 +-
> >  drivers/sysreset/Kconfig                      |   4 +-
> >  env/Kconfig                                   |   2 +-
> >  include/configs/socfpga_common.h              |   4 +-
> >  include/configs/socfpga_soc64_common.h        |  10 +-
> >  scripts/Makefile.xpl                          |   6 +-
> >  47 files changed, 216 insertions(+), 216 deletions(-)
>
>
> same~
