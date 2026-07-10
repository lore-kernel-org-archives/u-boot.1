Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91993C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 03:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32A984994;
	Fri, 10 Jul 2026 05:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="m8PPRQAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7C5849F0; Fri, 10 Jul 2026 05:08:23 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE908498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 05:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=brainfault.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=anup@brainfault.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so232874f8f.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 20:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783652901; cv=none;
 d=google.com; s=arc-20260327;
 b=XeU2cqOS9K65vhDxpKyBlkOFSaWzg96a24XgzV8+cNFrq0JSKOl7WfcLKsXSM9Zwyf
 09F2NOP7f9DdPl7QHTtB4CxRcxajZMANd49ZxrRgjfh/C9Y4bJXZyqR8rggUoChed/wL
 NDvqwJuwxzEnIxfrUDiGWH0/py3BAJL0lC0QXVJwwf2b6CP5dqWdm5JofKPtx0PX6FNF
 dXINNXrtufZfQJiOE2fPSrdvd3rL9+fjdO9JzYOFzmJ6KO5UDgmKU/PKf8GKtd+jR6to
 LHS2XKXi/WvgP/5rUmgztbdg8eAwtLUKhsCAWGYDEkR/7x5LlZKvbt3eYshYkIPBJUzH
 FJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GNRvbfLicF2uTjSShIDUbKzDCPv6HVTcOhYbdoCQ1Dw=;
 fh=p28qcPzhd5JvabCt+I6KATDrrQwc/7WlU7gKzR2x+Bw=;
 b=XCCz3wCSUAo15fhr/EEMwJSN6n4uCtMtRB2NC/DHrNi48kONWPvhiWEt6Kouiufojr
 MfMri1aSNvD6uFZb9MRXrk925Iagfbihsp3Xs61lAtUZ31FkKDW15rqpVIW06pMt3dRR
 RIDJSbunzxYP9G8LhuRb0aq5CQUsRxn6zMcOrHGxWpt681DBuXUIk/oiBlpR7pPPBYEr
 iRAFfstjViH87X2GXYRkOvLb8yPl6EVkAt0Xiwju3nBn4+ljGyoJ+GU5zok2k0J8a1wC
 pvNQT1+DJYFsKGLsWWcUOST0/34jfPDWSPCjtLJj61eBdp1YdFtWguAdb6hV8ybRe6N9
 YrtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783652901; x=1784257701;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GNRvbfLicF2uTjSShIDUbKzDCPv6HVTcOhYbdoCQ1Dw=;
 b=m8PPRQADhj19KlM396+So3c4zGmXKLL04yp1eaJiJMS/gG641oSWFOPnLbY4gtLg7v
 GB2XW394e2DI0KDvSDSDCHmeSQcqXXMYFaIVd8a2WU7v+amWY9yAbPWQ6++6y0A4oUMr
 gj/880OcBznDRovsFxtYr+hUcCwn7Rhy5mKD12c0lEVmNwrvl0w7m29J3Cv36Y7bTy9E
 2fNlTmLXxlKrubkP0H7ncy1273lH/SMz8X0FxNZvq8mKCJ8qF7Bw79kUDVtEBYWdQBMF
 bv4FSIJu6Gl8mDV69zTMsIiUujVgHokWsld2CXLXGk6PGrp2n1uUvS+qWHjFuDf27cj+
 Z4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652901; x=1784257701;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GNRvbfLicF2uTjSShIDUbKzDCPv6HVTcOhYbdoCQ1Dw=;
 b=TWINSYzCt196vZQmaUQjPP7CUhlXBSr18BhG2u+CojYSAZQ2uEa+MO7DnZlAiVifBx
 UtNVdK76FNk31+uyncpJwN1e+/AnF+1ryMB3355ILHBxdGZK7xX13my84aPIsuK4DKUL
 MXa2DjWfRbhrJz0B/wFRUWhJeM7OOwrMah/oHkLpROgyfCsliH7jmC6b1sF6bvY2B4Fq
 7ILuOL/tPtdm8x0Kwo/5OFOv2OANWy/7ovYU8rGqB9eqIQtHDVB83Tx45oPTKf76Y1No
 F2tMCc/w8x2zGj0gjBkzRnOsEMmaf4GeW6dia5GSXxRuw3oWnNH1GH3KuD7wITXAcPx4
 Eymw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn+6jQ3QKOLwadp9I8a5UZI430K6rgo1BouJXieabQhcyJ4maNf2x5wkfa8TML4dUtstZm624=@lists.denx.de
X-Gm-Message-State: AOJu0YxwIgOGO7KiIjXnqVHRDeyttZ9pXjJZnlfGov8e4deXsArBPYY3
 EkfYxb0gdI1JPpyd4fAIzQyKUwRcMFfQMb1YosfiQlMRbIF+M25+kwAKEDsfNVk7ThO6TS6aNvQ
 WqhV+ioQrEPqMNUMx61bhtigkPmFrw22R+f/2L59hdQ==
X-Gm-Gg: AfdE7cko1R1fTP0VvZRs21xRKTdhNaM0RXNnFz400YjMaDVxx6yap06QIglwC5Nk87N
 E1IwTYZ4cwWNkG/VJkX/xMf5UOmOFnRmS3/bySR/IFRxmuVXTE7e7hymAbqhH50WF9NCF+81OtX
 msFzLu2TaxDj9KgPuw09km+0u/axHLbVecVxQNAk5qP+TH97xDjn5UfVkXH7tAILMht/37FUXx+
 W6Cq686Z8ggQRGoWQabJVt0OLXD0ypvlbtzANq6Zq0ow9DbfY+JtAmpKW7SjytpdXpipC3QejW/
 JChlc9JrpCw5JqQY2EExAhmeLaaqEEsx0se4a0wY9mOMJ43YTDDSdD9rvH52lJD+R7iSWCGAieK
 9XrUpusGi/5RWHzfc
X-Received: by 2002:a05:6000:310c:b0:475:f0c2:5afa with SMTP id
 ffacd0b85a97d-47df078be8dmr10000053f8f.48.1783652900543; Thu, 09 Jul 2026
 20:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
 <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
 <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
In-Reply-To: <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 10 Jul 2026 08:38:08 +0530
X-Gm-Features: AUfX_mzcGLzM1qprs-9HtzgqO7ZLXCa1uLNYP9qFpAlKD0_7be4wmHMC_lt-6oc
Message-ID: <CAAhSdy0U1tqNReK-ED1ofs2cqz2ed55O+QUS0235WEaSrQm1Qw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de, 
 Rahul Pathak <rahul@summations.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>
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

On Thu, Jul 9, 2026 at 8:50=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 7/9/26 16:54, Charles Perry wrote:
> > On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
> >>
> >>
> >> On 7/8/26 23:51, Charles Perry wrote:
> >>> Hello,
> >>>
> >>> This series adds support for RISC-V Platform Management Interface (RP=
MI) to
> >>> U-Boot. RPMI is an OS-agnostic protocol for communication between an
> >>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. =
The
> >>> goals and purpose of RPMI are similar to ARM's SCMI.
> >>
> >>  From the first look it looks like SCMI. Why do you introducing someth=
ing
> >> what can be replaced by SCMI?
> >> And SCMI has only specific ARM transport layer but the rest is arch in=
dependent.
> >
> > Yes, there are alot of similarities between RPMI and SCMI. I found some
> > justification for this in some Linux Plumbers slide deck on RISC-V powe=
r
> > management by Paul Walmsley [1]:
> >
> >   * The hardware is more sophisticated
> >   * The software is more sophisticated
> >   * Some stakeholders haven=E2=80=99t had input in the past
> >   * RISC-V =E2=80=9Cbig tent=E2=80=9D philosophy
> >
> > I think this is referring to the SBI spec of RISC-V vs arm's PSCI but t=
he
> > same arguments may as well apply to RPMI vs SCMI.
> >
> > Some other arguments:
> >
> >   * The microcontroller side is made easier with RPMI because of librpm=
i [2].
> >     SCMI has SCP-firmware [3] which is a quite complex project compared=
 to
> >     librpmi. Also SCP-firmware doesn't accept contribution anymore.
> >   * RPMI is already in Linux.
> >
> > For what I'm doing, RPMI is what gave me the first results (controlling
> > clocks) the quickest because all the pieces were present in Linux, Open=
SBI
> > and librpmi. There are however lots of missing service drivers in Linux=
 and
> > some other important OS like u-boot don't have support for RPMI at all.=
 So
> > even though I gave you a bunch of reason for saying yes to RPMI, I do h=
ave
> > some doubt about how long it will take to bring RPMI on par with SCMI,
> > making the SCMI-for-RISCV transport that you suggest more appealing.
> >
> > [1]: https://lpc.events/event/2/contributions/197/attachments/133/165/R=
ISC-V_Platform_Power_Management.pdf (slide 22)
> > [2]: https://github.com/riscv-software-src/librpmi
> > [3]: https://gitlab.arm.com/firmware/SCP-firmware
> >
> >>
> >> In our case where we have Microblaze V in programmable logic I can't s=
ee any
> >> reason to use RPMI for talking to the same server if I need to do it f=
rom
> >> ARM side too via SCMI.
> >>
> >> I pretty much think that there should be communication with ARM and in=
stead
> >> of creating another firmware interface talk to each other and have onl=
y one
> >> which can be used across multiple architectures.
>
> I have sent RFC patch to eliminate ARM from SCMI here
>
> https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783=
603600.git.michal.simek@amd.com/
>
> and feedback is quite positive. I think it is more or less question to Mi=
crochip
> if you want to take responsibility on another firmware interface (I under=
stand
> that it is approved, etc) or just use what it is around for longer time.
>

Simply renaming the Linux sources does not make the SCMI specification
to be open and community driven. The real problem is SCMI specification
development is not open and community driven with appropriate permissive
license.

Some of the note worthy highlights of RPMI ecosystem as compared to
SCMI are:

1) RPMI specification is an open an community driven specification licensed
under "Creative Commons Attribution 4.0".

2) The scope of RPMI specification is much bigger than SCMI specification w=
here
RPMI is trying to consolidate all required messaging protocols under one RP=
MI
specification. RPMI defines some unique service groups in-addition to
the service
groups providing SCMI-style functionality such as:
   2.1) Collaborative Processor Performance Control (CPPC)
   Allows application processor to abstract out CPPC support to a
   microcontroller. It also has fast-channels for hot-path CPPC registers
   such as desired performance and current performance level along
   with RISC-V specific fast-mechanism to access delivered and
   reference counter.
   2.2) System MSI
   Allows system-level events to be sent to application processors as MSIs.
   This is used for graceful shutdown/reboot request, hotplug events, etc
   2.3) Request Forward
   Enables one domain / world to receive messages forwarded from
   another domain.
   2.4) Managment Mode (MM)
   Allows UFEI / EDK2 firmware running on application processors to talk
   to managment mode (other domain / world / microcontroller) for secure
   variable updates and other MM services
   2.5) RAS Agent
   Allows UEFI / EDK2 firmware to discover error sources handled by
   firmware and generate RAS related ACPI tables at boot-time
   2.6) Truested Execution Environment (TEE) (Work-in-progress)
   Provides a rich and extensible TEE communication interface between
   non-secure world (Linux) and trusted world (OP-TEE and others).
   2.7) ... and more to come ...

3) The LibRPMI project which a open-source reference implementation of
RPMI is permissively licensed under BSD-2-clause which allows platform
vendors use any RTOS / baremetal-app as their microcontroller firmware.
This library is also shipped as a shared library allowing QEMU to use
LibRPMI for emulating RPMI services for TCG and KVM guests.

4) The following Linux RPMI drivers are already available in upstream:
MPXY mailbox controller, RPMI clock, and RPMI system MSI whereas
the CPPC, LPI and system suspend drivers already work as-is for RISC-V.
The upstreaming of RPMI performance driver is in-progress and should
be merged soon. The OpenSBI (M-mode firmware) already supports
almost all service groups defined by the RPMI v1.0 specification.

Based on the above facts, I would suggest AMD to consider using
RPMI over SCMI.

Regards,
Anup
