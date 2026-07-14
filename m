Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69670C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EA984D35;
	Tue, 14 Jul 2026 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iJ+J1j8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840AF84D02; Tue, 14 Jul 2026 13:57:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5FF2084CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68925497;
 Tue, 14 Jul 2026 04:57:01 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.28.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE763FAF5;
 Tue, 14 Jul 2026 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784030225; bh=FKnCdPQbFu6812US0DR01+kWhCuYl7P4aWi0rQOy7QE=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=iJ+J1j8Pl1FpzsdiS7qJmEvu8HgcJuTnwYWhlf85H9RE+smGyThU5nYrJuHrjPEnE
 MQztwwQijTEvdTmtbSPYAWGE/Jcln+lnnmIS8h5RFZcRA+VjId5V2Kmc7qNE+Iihzy
 XrREufIp7VDzd469zNr3YwbvDqouEh/AcxIYW/9c=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/10] arm-ffa: add FF-A bus runtime support
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>, 
 u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJ2yuqRSbktSAdaoGt_Tc66RguE_JMZ62X956H16qA5OQ@mail.gmail.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
 <CAC_iWjJ2yuqRSbktSAdaoGt_Tc66RguE_JMZ62X956H16qA5OQ@mail.gmail.com>
Date: Tue, 14 Jul 2026 12:56:58 +0100
Message-Id: <178403021866.3079243.6159644137213899108.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 14 Jul 2026 14:51:05 +0200
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

On 2026-07-01 16:59 +0300, Ilias Apalodimas wrote:
> [...]
> 
> > +
> > +/**
> > + * ffa_sync_send_receive_runtime() - Runtime implementation of
> > + *                              ffa_sync_send_receive()
> > + * @dst_part_id: destination partition ID
> > + * @msg: pointer to the message data preallocated by the client (in/out)
> > + * @is_smc64: select 64-bit or 32-bit FF-A ABI
> 
> [...]
> 
> Just out of curiocity. Why can't we use the runtime part in boot time
> as well and keep one function?
> 
> Thanks
> /Ilias
> 
Hi Ilias,

During boot, ffa_sync_send_receive() works through driver model. It uses
the FF-A device, the probed bus state, and the normal U-Boot services.

After ExitBootServices(), we cannot depend on driver model anymore. So
ffa_sync_send_receive_runtime() only uses the small FF-A state copied
into runtime memory and the runtime-safe SMC wrapper.

We could use the runtime function during boot after setting up that
state, but then boot-time users would bypass the normal FF-A driver
path. I kept them separate so the boot path continues to use driver
model, and only the runtime path uses the restricted runtime state.

Thanks
Harsimran Singh Tungal


