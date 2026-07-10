Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3AEC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 03:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8E0849D2;
	Fri, 10 Jul 2026 05:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="QB1btQ6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E8D849F3; Fri, 10 Jul 2026 05:15:14 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F84684994
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 05:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=brainfault.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=anup@brainfault.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso457719f8f.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 20:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783653311; cv=none;
 d=google.com; s=arc-20260327;
 b=MssI9rPd5S41dF2WWOGOpA+xh16YrHvXcjW1a7tjo9/2t5foGaJrWJn11PjLaVU4gp
 EmecZCf/fN0vxxjC5DQlyh3o9A0HFb+MjByLPunzWrOeUrPzFiL7Z1PAWX6G1utlNluo
 Rm+nHxZ9DsuXzwfoimgHfHbP2zsKtar0mNFTRO4+S2oZweURMe6BF6zQczKSm4MdYm8P
 oB/TX5CiZ18CWulXPeHRGFwVYDrlBDgAyKqZNYygmdq5Sv4ygjVrVODPPK0c0+DyVmFK
 yVcfMIFYtyuCdaL/W5tEdihQDpwKFJ1El1CsYHxQSQ5gytk9f+ephbAqecbqV/cXF8hI
 EojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VMyoHtx/CRKfFHO3FnN4Kb91eNwwKNwVsrS4b3vnyOw=;
 fh=nxAIzTn4HoGbkQehYo1v1kwE1CmjoHunnc0Crm/mi9E=;
 b=Yz/+d/bSPmO6sPugS3ILN2hD7GsHTbjOkC0InucgafzfXUyX0ljSFb8hQIq6/iTx8B
 z6dsWX0A98Ih16YO4K2KcN+8eFUrgmZErnkh2F8DKtpJaXjw73XjXR5mlsUKluKjP2U+
 PL7DjhIqh+NKvZdvaHRTPzyRtwLGPxsDnSflSytGIlma52y60ulKp5JjqVNMllOl1DKL
 el/fIAeKXC0c/ofvkksL3docZCf0vJfEmP7WrSDWQxjT1QTrhTqp5/vcHd8rLI9B5OWZ
 RHAKD0VT+XHXLwILZnotmppUZpmv41yC7MLQD01eNwgJLMduk1o8DYEPPPcq6WYgq5vc
 LLVw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1783653311; x=1784258111;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VMyoHtx/CRKfFHO3FnN4Kb91eNwwKNwVsrS4b3vnyOw=;
 b=QB1btQ6ggGxeuLZrTrFNoOtFbURekOGZhJUGWDtgcwWyMt6K01qnlYBLTuoJv26+nl
 EISgf5YEn70pZyC9eq2RtvmL9/qlcY0WHX4qo5ddq17eEV/Kb+WQSBh6EPSfIFhfvU+g
 3T9tH+B4q25Zi+fELLtxlbAoSVVQjO07g7xEuWIeKb65CjzvY7WosSFHKRWIrzdw6JA3
 0zPFxfC23fxWlurmdE4j68MWgEP6mwLx2Z9ODjISs6YcqV6utr6hJredCSfh3GImwHZ4
 CtdbRewqnWdPkDmTllLPAMP9l3uz9H1bICeEuVxmd4VZ9Zf7mW+Zlv4vdJPLThjxNk0v
 Jbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783653311; x=1784258111;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VMyoHtx/CRKfFHO3FnN4Kb91eNwwKNwVsrS4b3vnyOw=;
 b=TqKg/Yq4TSeP71Z7RvEcZccJ7oC8u8YYePwOrWViFjQlGDgdS8fkt/XKZewpNVguvd
 T6s55HC5Y8YdyUsHuiuvnfNafZ+GcpcwanQ82kU4V4XtJFr7ALafRN0xo6zz+vMNeHP2
 zkd87TGj0pbgWcypuYEEWyzpQCdybXzRpuMhwFMiuZUoei1bkwY0HdWut1uBlRmOjlDk
 w75Mr6zmMGJL1LFedijCiAZV+Mw9C62/Bccj3zt6U+OXHRDjzFEUa3MOAohFgP0R3aK0
 cETQOcHe7B9qh5WEi0EUkE+Kf0XpqTsnA8pUh31JBpytI6Wn+1Ouw9hvomGbKXy/+c9U
 WRSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2P30Key355slUKWigbOG25uwLKnLfsn1Quhhfu/SGsbCsZMo6W1JKED/vl1k3u03xK9sDQTc=@lists.denx.de
X-Gm-Message-State: AOJu0YxX55ZYUPUmPCvUhVuSx3+feWOnD5wwCgtmOOWlSQnFH/ptRY73
 LNjtt6hb68k7IpEI7jT7fq0aPypbuuQgRV9XYfMw98XXUrGuWxh6BQ0fVvx37Mif+S7ccLIN9ef
 CR6IBQK5LutyPSrU1dEr3PDjKGxOdTC73M3qC3cuyvhTIcyK0E+6C
X-Gm-Gg: AfdE7ckLKcRnfsumriUh1a9TSW+ihDU0IugaH5K0M77r5sIT8NhraaZ3cHHg0DIk7cb
 33NGT+uuqAcNx7Tog70D8PiNbMg12glO/cc+fGw1E3aS6wmsUhpsvWP6qwlvHG/aF3BErweQ+1x
 qvLQHd08asQgozMQCglvhyrhkHyEKh/Qx9aFf9X7Ee8Vq+RF2NG8/pwkTWSUEdmsKxsLVo6Ywd5
 dLEqy0xzXkH+enXfRpJquf757rk7bOozqvTESDigAKKqKqrnv8NZfnYkBr6blSSZ1pj+mk6ZTVy
 7S6di4191BX/xD9fDfC8vCFXJFtAvgzAEi8yVbkF+uXDT+zC8Wjga3OA5tcXC53538j2wlLekRk
 ghlRPMT/OWm6ONt1j
X-Received: by 2002:a05:6000:178c:b0:44a:be4:d0e4 with SMTP id
 ffacd0b85a97d-47df0765a2fmr10236899f8f.25.1783653310459; Thu, 09 Jul 2026
 20:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
 <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
 <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
 <20260709-rounding-gala-841f8043edfc@spud>
In-Reply-To: <20260709-rounding-gala-841f8043edfc@spud>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 10 Jul 2026 08:44:58 +0530
X-Gm-Features: AUfX_mwxBa95b0pMM3PjvDTEsLD8TzQ_zY8S9GvAUiqC_KLX8aHLS27_B1KL1Pk
Message-ID: <CAAhSdy3iRDguX3tq7b6rxWcJkW9y51r5ML8TdtKJbqCKpnW4oQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
To: Conor Dooley <conor@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Charles Perry <charles.perry@microchip.com>, 
 u-boot@lists.denx.de, Rahul Pathak <rahul@summations.net>,
 Paul Walmsley <pjw@kernel.org>, 
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

On Thu, Jul 9, 2026 at 10:27=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jul 09, 2026 at 05:20:31PM +0200, Michal Simek wrote:
> >
> >
> > On 7/9/26 16:54, Charles Perry wrote:
> > > On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
> > > >
> > > >
> > > > On 7/8/26 23:51, Charles Perry wrote:
> > > > > Hello,
> > > > >
> > > > > This series adds support for RISC-V Platform Management Interface=
 (RPMI) to
> > > > > U-Boot. RPMI is an OS-agnostic protocol for communication between=
 an
> > > > > Application Processor (AP) and a Platform Microcontroller (PuC) [=
1]. The
> > > > > goals and purpose of RPMI are similar to ARM's SCMI.
> > > >
> > > >  From the first look it looks like SCMI. Why do you introducing som=
ething
> > > > what can be replaced by SCMI?
> > > > And SCMI has only specific ARM transport layer but the rest is arch=
 independent.
> > >
> > > Yes, there are alot of similarities between RPMI and SCMI. I found so=
me
> > > justification for this in some Linux Plumbers slide deck on RISC-V po=
wer
> > > management by Paul Walmsley [1]:
> > >
> > >   * The hardware is more sophisticated
> > >   * The software is more sophisticated
> > >   * Some stakeholders haven=E2=80=99t had input in the past
> > >   * RISC-V =E2=80=9Cbig tent=E2=80=9D philosophy
> > >
> > > I think this is referring to the SBI spec of RISC-V vs arm's PSCI but=
 the
> > > same arguments may as well apply to RPMI vs SCMI.
> > >
> > > Some other arguments:
> > >
> > >   * The microcontroller side is made easier with RPMI because of libr=
pmi [2].
> > >     SCMI has SCP-firmware [3] which is a quite complex project compar=
ed to
> > >     librpmi. Also SCP-firmware doesn't accept contribution anymore.
> > >   * RPMI is already in Linux.
> > >
> > > For what I'm doing, RPMI is what gave me the first results (controlli=
ng
> > > clocks) the quickest because all the pieces were present in Linux, Op=
enSBI
> > > and librpmi. There are however lots of missing service drivers in Lin=
ux and
> > > some other important OS like u-boot don't have support for RPMI at al=
l. So
> > > even though I gave you a bunch of reason for saying yes to RPMI, I do=
 have
> > > some doubt about how long it will take to bring RPMI on par with SCMI=
,
> > > making the SCMI-for-RISCV transport that you suggest more appealing.
> > >
> > > [1]: https://lpc.events/event/2/contributions/197/attachments/133/165=
/RISC-V_Platform_Power_Management.pdf (slide 22)
> > > [2]: https://github.com/riscv-software-src/librpmi
> > > [3]: https://gitlab.arm.com/firmware/SCP-firmware
> > >
> > > >
> > > > In our case where we have Microblaze V in programmable logic I can'=
t see any
> > > > reason to use RPMI for talking to the same server if I need to do i=
t from
> > > > ARM side too via SCMI.
> > > >
> > > > I pretty much think that there should be communication with ARM and=
 instead
> > > > of creating another firmware interface talk to each other and have =
only one
> > > > which can be used across multiple architectures.
> >
> > I have sent RFC patch to eliminate ARM from SCMI here
> >
> > https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.17=
83603600.git.michal.simek@amd.com/
> >
> > and feedback is quite positive. I think it is more or less question to
> > Microchip if you want to take responsibility on another firmware interf=
ace
> > (I understand that it is approved, etc) or just use what it is around f=
or
> > longer time.
>
> I don't think it is a question to just Microchip, it's a question to be a=
sked
> to all the various companies and projects using RISC-V. For example will
> upstream OpenSBI accept support for SCMI, or will they say "we have RPMI,
> use that"?

For upstream OpenSBI, the preference is RVI specifications and open
standards (such as UEFI, ACPI, Device Tree, etc).

Regards,
Anup
