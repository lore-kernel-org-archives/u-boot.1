Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D59606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sfrIyj0E;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=oaC22Zow
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1444480DDF;
	Mon, 26 Oct 2026 18:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5IkxF2S7qtu; Mon, 26 Oct 2026 18:36:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7442E80D7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793039795;
	b=IkKuvNaPR9XOvXtth19s7Jdcdo/POxBP9jcADi9jPS9NOnoEnfA4wZ3dQNufFngLAHIr
	 H1f22OOFfZ2hO6tBhV38x7d10lcA2GfuGXwmCIKIursNtV4BNv4L4TwqwlAdCRIDtIF7l
	 +VbXqnsq65fWBuj0CMS+OzwHGEYEYBPAbl+DzJxumOLSs8CdlsL7eI75wr0/gL0mF48NN
	 7uchtcqiGLmrmSGTzSYEEyzKYs4Ge45Nad1L/qUMAsfH5QPAS5ap3z0+BZQo/Iq33ql5D
	 NEq2rH+S8AdvhF82nX+9NiNomI1pOwrW4qOR6Qg0d42lwj5eHEnyjJZI8Qn+XrbaXOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793039795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q4uVk2QRnplouttOH4rASQ4+xatn/zBgU8F7xj3lks0=;
	b=efT9GqfDPx+nPjR4ayZ/wOEWbaB6c4rL0u0JqGgmGegHIf/9sQ/LR/JjzexO78yhF7MF
	 HQu87PsgmUla9NoLt1vR6kvN1B7LEreDPAGsCBTwW5j2D3SutbJdxBDNW+7WDZIrGGaoh
	 5xt50VdAfHDx9V4iq5pSUN3pwEIPfZ0t95eS69BwqfuAlVf8zHj/iagqjCUpy1yVyfywu
	 /8n9jyfM/uT1L8Ra/+4dQBnY1yxnw2MBQt/xEucQgNThLBfanhoQB/1AkZqrxxgNsyoXo
	 iScbHbxFRZUsr1XYNtIxp+FRk0bmHyMPBN9+nFUQr4twRx4InKwsT4sIxFuFsdc6BIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793039795;
	bh=q4uVk2QRnplouttOH4rASQ4+xatn/zBgU8F7xj3lks0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfrIyj0Eaf0cwhVAjrPwXz71hL6VOsmu6lwZlbBZKxriwnpULLlT7IpaRy1E43lPv
	 wxaYtMRSGjHe/yhE7ulalzpnx8tpGPf4GqkeiAzxApUuwv4f34aBkzn2BTCuqqiWLU
	 ZJRt256r+GXL/eQdxyvtaHJ2Fz7K/X2UlSQeUwP1oxcuPsjbUuj3gqAvbsoq5TaMEp
	 N5hV+u6hAgkzh8bQ6EYCArKIz3/D3rg80/SDjZ1PefXtisY9297VRwHbxrkpcpYXn4
	 FQzTjHlSBzaDzSbv6sAWm2WLan+VVCViqzrS4Sm08VEC6K05KrLFcMaHegW0yw45km
	 VkHUzj7iRKfxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7442E80D7C;
	Mon, 26 Oct 2026 18:36:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5B2E235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D71384006F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1M0bSYY1dsR for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB80240062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793039792;
 b=j1LFk7I4F7yuENr8D6+15qNaxAGynoYjTeQnjuEY9XxWf4yW4v8orwVjlDtw2ul69dNw
 K03sI+HHebsba4bGMk13FUwKVRXNdPBsCQ1suBh6KZ9plN4baDRtlSBDK9ycEMQdK4fNx
 ZygPBv5sAVLDAKICnvMIRJVS79QlPx4xxzkU2tkhe4vEbHBy75k/GfFrDPhYz/KmmkcEM
 Hm7pSc1zLLZynJa5LdZU5lwr48kUzfeuAXKjOnS2ledql1skOOJ99B0ol1RvfBmT68jWR
 qns6fa0OabfnVvICk3jXKy9LgbMFqxPgkGXUTZzqQKa6xzDwo97+etF2PVObBdZey6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793039792;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=q4uVk2QRnplouttOH4rASQ4+xatn/zBgU8F7xj3lks0=;
 b=ZOCaE16Kos8Wx2HNTEhcejCvwjXqC9jd+VOLn12xTQJucsCFgAGAA33tbgwxiCRQXzL9
 LiVTBYoHYWmwk4EmRQeterrWugTQAf5Zr1siMEpPaJrER+SEBuoMMmvOIA/6yO5JDV/vY
 0RPHeQYVXRWMchoKpVwB2o1fKUkJvDUCMlSPMtWCrhXF7QczsjjzFdtMxffkqFOlo1JCP
 tI1zuresov7y0S+zJDve26Jx4jYAGFzDg1Oilay2khzeF7vE+H7QbvNTJA6fCcgbfSTtA
 M3MrpUuULCn6dj1dQZXMbP+90WNLpaX0N+Vw9ChgQQhtKfkEC8QN1QXEjavkS12Y0ew==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=oaC22Zow; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=752c32f41=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=oaC22Zow
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB80240062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793039791; x=1824575791;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UHuvsg2FRSqOgqUY7Q9OFsjQkTT9Tmt6BXtPG+IS3ig=;
 b=oaC22ZowK5hsubaLlVNDqkRd5f/z8vwtMYDv8NTdZpqXE333to/ttDVG
 ei5h3ZC4Yq0UJa6ZKUTj8pEwL/Aco6sxTlaco6EOTiGqHi6Exxsxb3rNn
 kwFHujSlRluLEUe8wHHllVJiZjAPMUVFhfTHB9ojY84cd37IQ4pP+ei+H
 H4iTvC+TIK5QQGl2S955qumXupwsO5e7ryCUrj9RUss8wlBjYZYk4Euck
 7Vt1rL1FkTBP6vSB+nBo3FJheYhy4r4ASAHWQd1ivjvx8IvOMjLMXnleR
 UVKJemItM1u080qFDzlLNRfi3KOdRrEd+E05QhJNbM1EgCBe3j2Gtpg5f w==;
X-CSE-ConnectionGUID: TRj8DJXDSZe+S84uV7mVuw==
X-CSE-MsgGUID: W8huOn87QWKp3vPKCJ8Mkw==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; d="scan'208";a="232650048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 11:36:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 11:36:29 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 11:36:27 -0700
Date: Mon, 26 Oct 2026 14:36:26 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Peng Fan
 <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 3/8] firmware: rpmi: add support for shared memory
 transport
Message-ID: <at-dqpf4wtGXenYL@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-3-d53d34a49780@microchip.com>
 <CAPxK-6fPNdwf7ZKhB0JjDGb-mqpZDuey9j0+AA6jk=6+G2wCrw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPxK-6fPNdwf7ZKhB0JjDGb-mqpZDuey9j0+AA6jk=6+G2wCrw@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:46:31PM +0530, Subrahmanya Lingappa wrote:
> Charles,
> 
> On Wed, Oct 14, 2026 at 7:47 PM Charles Perry
> <charles.perry@microchip.com> wrote:
> >
> > Add support for transport of RPMI messages over shared memory as
> > described in the RPMI spec [1]. This uses two or four ring buffers
> > composed of a fixed number of "slots" to pass messages between the AP
> > and the PuC. U-Boot is the Application processor (AP) and sends messages
> > through the a2p-req queue and receives response though the p2a-ack
> > queue. There is no support for platform microcontroller (PuC) initiated
> > requests nor notifications.
> >
> > This transport can be used in M or S mode U-Boot, but in the S-mode
> > case, one must make sure that the supervisor software isn't already
> > using the AP side of the shared memory.
> >
> > [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 2)
> >
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> > Changes in v4:
> >  - Fix the default value of the doorbell from 0 to 1
> >
> > Changes in v3: None
> >
> > Changes in v2: (from Yao Zi review)
> >  - Reorder headers
> >  - Don't null check pointers before free()
> > ---
> >  drivers/firmware/rpmi/Kconfig      |   8 +
> >  drivers/firmware/rpmi/Makefile     |   1 +
> >  drivers/firmware/rpmi/rpmi-shmem.c | 473 +++++++++++++++++++++++++++++++++++++
> >  include/rpmi_proto.h               |  23 ++
> >  4 files changed, 505 insertions(+)
> >
> > diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
> > index 708d931263ff..421a1fa9deba 100644
> > --- a/drivers/firmware/rpmi/Kconfig
> > +++ b/drivers/firmware/rpmi/Kconfig
> > @@ -16,3 +16,11 @@ config RPMI_SBI_MPXY
> >           (MPXY) extension of the supervisor binary interface (SBI). The
> >           specification for the MPXY extension is available at:
> >           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> > +
> > +config RPMI_SHMEM
> > +       bool "RPMI over shared memory transport"
> > +       depends on RPMI_FIRMWARE
> > +       help
> > +         Enable support for transport of RPMI messages over shared memory as
> > +         described in chapter 2 of the RPMI specification, available at:
> > +         https://github.com/riscv-non-isa/riscv-rpmi
> > diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
> > index 71c4aeaed910..4f4bcb929db4 100644
> > --- a/drivers/firmware/rpmi/Makefile
> > +++ b/drivers/firmware/rpmi/Makefile
> > @@ -1,2 +1,3 @@
> >  obj-y  += rpmi-uclass.o
> >  obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
> > +obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
> > diff --git a/drivers/firmware/rpmi/rpmi-shmem.c b/drivers/firmware/rpmi/rpmi-shmem.c
> > new file mode 100644
> > index 000000000000..db9949e39c7e
> > --- /dev/null
> > +++ b/drivers/firmware/rpmi/rpmi-shmem.c
> > @@ -0,0 +1,473 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_RPMI
> > +
> > +#include <asm/barrier.h>
> > +#include <asm/io.h>
> > +#include <asm/types.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <linux/delay.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <rpmi-uclass.h>
> > +
> > +#define RPMI_SLOT_SIZE_MIN 64
> > +
> > +enum rpmi_queue_idx {
> > +       RPMI_QUEUE_IDX_A2P_REQ = 0,
> > +       RPMI_QUEUE_IDX_P2A_ACK = 1,
> > +       RPMI_QUEUE_IDX_P2A_REQ = 2,
> > +       RPMI_QUEUE_IDX_A2P_ACK = 3,
> > +       RPMI_QUEUE_IDX_MAX_COUNT = 4,
> > +       RPMI_A2P_DOORBELL = 5,
> > +};
> > +
> > +struct shmem_queue {
> > +       u32 num_slot;
> > +       __le32 *headptr;
> > +       __le32 *tailptr;
> > +       void *buffer;
> > +};
> > +
> > +struct rpmi_shmem {
> > +       struct udevice *dev;
> > +       struct shmem_queue a2p_req;
> > +       struct shmem_queue p2a_ack;
> > +       int slot_size;
> > +       int rx_timeout_ms;
> > +       u32 token;
> > +       void *doorbell;
> > +       u32 doorbell_value;
> > +       u32 spec_version;
> > +       u32 impl_version;
> > +       u32 impl_id;
> > +};
> > +
> > +struct rpmi_shmem_chan_priv {
> > +       struct rpmi_shmem *priv;
> > +       u32 servicegroup_id;
> > +       u32 servicegroup_version;
> > +};
> > +
> > +static int rpmi_shmem_queue_idx(const char *name)
> > +{
> > +       static const struct {
> > +               int id;
> > +               const char *name;
> > +       } id_names[] = {
> > +               { RPMI_QUEUE_IDX_A2P_REQ, "a2p-req" },
> > +               { RPMI_QUEUE_IDX_P2A_ACK, "p2a-ack" },
> > +               { RPMI_QUEUE_IDX_P2A_REQ, "p2a-req" },
> > +               { RPMI_QUEUE_IDX_A2P_ACK, "a2p-ack" },
> > +               { RPMI_A2P_DOORBELL, "a2p-doorbell" },
> > +       };
> > +
> > +       for (int i = 0; i < ARRAY_SIZE(id_names); i++) {
> > +               if (strcmp(name, id_names[i].name) == 0)
> > +                       return id_names[i].id;
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +
> > +static bool rpmi_smq_queue_full(struct shmem_queue *qctx)
> > +{
> > +       return ((le32_to_cpu(*qctx->tailptr) + 1) % qctx->num_slot ==
> > +               le32_to_cpu(*qctx->headptr));
> > +}
> > +
> > +/* 31                                            0
> > + * +---------------------+-----------------------+
> > + * | FLAGS | SERVICE_ID  |   SERVICEGROUP_ID     |
> > + * +---------------------+-----------------------+
> > + * |        TOKEN        |     DATA LENGTH       |
> > + * +---------------------+-----------------------+
> > + * |                 DATA/PAYLOAD                |
> > + * +---------------------------------------------+
> > + */
> > +struct rpmi_message_header {
> > +       __le16 servicegroup_id;
> > +       u8 service_id;
> > +       u8 flags;
> > +       __le16 datalen;
> > +       __le16 token;
> > +} __packed;
> > +
> > +static int rpmi_smq_rx(struct rpmi_shmem *priv, struct shmem_queue *qctx,
> > +                      u32 service_group_id, u32 service_id, u16 token,
> > +                      void *response, unsigned long max_response_len,
> > +                      unsigned long *out_response_len)
> > +{
> > +       struct rpmi_message_header *msg;
> > +       u32 dlen, headidx, tailidx;
> > +       int rxretry = 0;
> > +       void *src;
> > +
> > +       headidx = le32_to_cpu(*qctx->headptr);
> > +
> > +       /* Wait for the Rx message with matching token, discard any other
> > +        * messages received in the mean time
> > +        */
> > +       while (true) {
> > +               tailidx = le32_to_cpu(*qctx->tailptr);
> > +
> > +               if (headidx != tailidx) {
> > +                       msg = (void *)qctx->buffer +
> > +                             (headidx * priv->slot_size);
> 
>  The transmit path uses `wmb()` before publishing the tail, but this receive
>  path consumes the slot immediately after observing the tail. Please add the
>  platform-appropriate acquire/read barrier before reading `msg` and document
>  the ordering requirement for this shared-memory mapping.

I'll remove the wmb().

There's no point in adding memory barriers since U-Boot is always running
on a single processor. volatile* should be enough to ensure that
reads/writes happen in order. However, I am missing volatile* from headptr
and tailptr since I'm accessing those directly without going through
readl/writel. I'll fix this one by adding the volatile*.

> 
> > +                       if (le16_to_cpu(msg->token) == token)
> > +                               break;
> 
>  The response is accepted using only the token. This function already receives
>  `service_group_id` and `service_id`; please compare those fields with the
>  response header as well. The token counter starts again for a new driver
>  instance, while old replies can remain in the shared queue across a firmware
>  transition. An old reply for a different service carrying the same token could
>  otherwise satisfy this request.

Ok, good point.

> 
> > +
> > +                       headidx = (headidx + 1) % qctx->num_slot;
> > +               }
> > +
> > +               mdelay(1);
> > +               rxretry += 1;
> > +               if (rxretry > priv->rx_timeout_ms)
> > +                       return -ETIMEDOUT;
> > +       }
> > +
> > +       /* Extract data from the message */
> > +       if (response) {
> > +               dlen = le16_to_cpu(msg->datalen);
> > +               if (dlen > max_response_len)
> > +                       dlen = max_response_len;
> > +               if (out_response_len)
> > +                       *out_response_len = dlen;
> > +               src = (void *)msg + sizeof(struct rpmi_message_header);
> > +               memcpy(response, src, dlen);
>  `dlen` is bounded only by the caller's response buffer, not by the current
>  shared-memory slot. The current clock callers use response buffers smaller
>  than the slot payload, but this generic transport accepts arbitrary response
>  sizes. Please reject a `dlen` greater than
>  `slot_size - sizeof(struct rpmi_message_header)` before copying, so a malformed
>  response or future caller cannot make the read cross the slot boundary.

Ok

> 
> > +       }
> > +
> > +       /* Update the head index */
> > +       headidx = (headidx + 1) % qctx->num_slot;
> > +       *qctx->headptr = cpu_to_le32(headidx);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_smq_tx(struct rpmi_shmem *priv, struct shmem_queue *qctx,
> > +                      u32 service_group_id, u32 service_id,
> > +                      enum rpmi_message_type type, u16 token,
> > +                      const void *request, unsigned long request_len)
> > +{
> > +       struct rpmi_message_header header = { 0 };
> > +       u32 tailidx;
> > +       void *dst;
> > +
> > +       /* Tx sanity checks */
> > +       if (request_len >
> > +           (priv->slot_size - sizeof(struct rpmi_message_header)))
> > +               return -EINVAL;
> > +
> > +       if (rpmi_smq_queue_full(qctx))
> > +               return -ENOMEM;
> > +
> > +       tailidx = le32_to_cpu(*qctx->tailptr);
> > +
> > +       /* Prepare the header to be written into the slot */
> > +       header.servicegroup_id = cpu_to_le16(service_group_id);
> > +       header.service_id = service_id;
> > +       header.flags = type;
> > +       header.datalen = cpu_to_le16(request_len);
> > +       header.token = cpu_to_le16(token);
> > +
> > +       /* Write header into the slot */
> > +       dst = (char *)qctx->buffer + (tailidx * priv->slot_size);
> > +       memcpy(dst, &header, sizeof(header));
> > +       dst += sizeof(header);
> > +
> > +       /* Write data into the slot */
> > +       if (request)
> > +               memcpy(dst, request, request_len);
> > +
> > +       /* Make sure queue chanages are visible to PuC before updating tail */
> > +       wmb();
> > +
> > +       /* Update the tail/write index */
> > +       tailidx = (tailidx + 1) % qctx->num_slot;
> > +       *qctx->tailptr = cpu_to_le32(tailidx);
> > +
> > +       /* Ring the RPMI doorbell if present */
> > +       if (priv->doorbell)
> > +               writel(priv->doorbell_value, priv->doorbell);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_shmem_request_priv(struct rpmi_shmem *priv, u32 servicegroup_id,
> > +                                  u32 service_id, const void *request,
> > +                                  unsigned long request_len, void *response,
> > +                                  unsigned long max_response_len,
> > +                                  unsigned long *out_response_len)
> > +{
> > +       enum rpmi_message_type type = response ? RPMI_MSG_NORMAL_REQUEST :
> > +                                                RPMI_MSG_POSTED_REQUEST;
> > +       int err;
> > +
> > +       if (!request && request_len)
> > +               return -EINVAL;
> > +
> > +       err = rpmi_smq_tx(priv, &priv->a2p_req, servicegroup_id, service_id,
> > +                         type, priv->token, request, request_len);
> > +       if (err) {
> > +               dev_err(priv->dev, "tx failed %i\n", err);
> > +               goto out;
> > +       }
> > +
> > +       if (response) {
> > +               err = rpmi_smq_rx(priv, &priv->p2a_ack, servicegroup_id,
> > +                                 service_id, priv->token, response,
> > +                                 max_response_len, out_response_len);
> > +               if (err) {
> > +                       dev_err(priv->dev, "rx failed %i\n", err);
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +out:
> > +       priv->token++;
> > +       return err;
> > +}
> > +
> > +static int rpmi_shmem_request(struct rpmi_chan *chan, u32 service_id,
> > +                             const void *request, unsigned long request_len,
> > +                             void *response, unsigned long max_response_len,
> > +                             unsigned long *out_response_len)
> > +{
> > +       struct rpmi_shmem *priv = dev_get_priv(chan->dev);
> > +       struct rpmi_shmem_chan_priv *chan_priv = chan->con_priv;
> > +
> > +       return rpmi_shmem_request_priv(priv, chan_priv->servicegroup_id,
> > +                                      service_id, request, request_len,
> > +                                      response, max_response_len,
> > +                                      out_response_len);
> > +}
> > +
> > +static int rpmi_shmem_get_attr(struct rpmi_chan *chan,
> > +                              enum rpmi_attribute_id id, u32 *data)
> > +{
> > +       struct rpmi_shmem *priv = dev_get_priv(chan->dev);
> > +       struct rpmi_shmem_chan_priv *chan_priv = chan->con_priv;
> > +
> > +       switch (id) {
> > +       case RPMI_ATTR_SPEC_VERSION:
> > +               *data = priv->spec_version;
> > +               break;
> > +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> > +               *data = priv->slot_size - sizeof(struct rpmi_message_header);
> > +               break;
> > +       case RPMI_ATTR_SERVICEGROUP_ID:
> > +               *data = chan_priv->servicegroup_id;
> > +               break;
> > +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> > +               *data = chan_priv->servicegroup_version;
> > +               break;
> > +       case RPMI_ATTR_IMPL_ID:
> > +               *data = priv->impl_id;
> > +               break;
> > +       case RPMI_ATTR_IMPL_VERSION:
> > +               *data = priv->impl_version;
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_shmem_base_service_req(struct rpmi_shmem *priv, u32 service_id,
> > +                                      const u32 *arg_in, u32 *arg_out)
> > +{
> > +       int len = 0;
> > +       u32 rx[2];
> > +       u32 tx[1];
> > +       int ret;
> > +
> > +       if (arg_in) {
> > +               tx[0] = cpu_to_le32(*arg_in);
> > +               len = sizeof(*arg_in);
> > +       }
> > +
> > +       ret = rpmi_shmem_request_priv(priv, RPMI_SRVGRP_BASE, service_id, tx,
> > +                                     len, rx, sizeof(rx), NULL);
> > +       if (ret) {
> > +               dev_err(priv->dev, "BASE service %i failed (%i)\n", service_id,
> > +                       ret);
> > +               return ret;
> > +       }
> > +
> > +       if (rx[0]) {
> > +               ret = rpmi_to_linux_error(le32_to_cpu(rx[0]));
> > +               dev_err(priv->dev, "BASE service %i returned code %i\n",
> > +                       service_id, ret);
> > +               return ret;
> > +       }
> > +
> > +       if (arg_out)
> > +               *arg_out = le32_to_cpu(rx[1]);
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_shmem_of_xlate(struct rpmi_chan *chan,
> > +                              struct ofnode_phandle_args *args)
> > +{
> > +       if (args->args_count != 1)
> > +               return -EINVAL;
> > +
> > +       // args[0] is the servicegroup id.
> > +       chan->id = args->args[0];
> > +
> > +       return 0;
> > +}
> > +
> > +static int rpmi_shmem_open(struct rpmi_chan *chan)
> > +{
> > +       struct rpmi_shmem *priv = dev_get_priv(chan->dev);
> > +       u32 servicegroup_id, servicegroup_version;
> > +       struct rpmi_shmem_chan_priv *chan_priv;
> > +       int ret;
> > +
> > +       servicegroup_id = chan->id;
> > +
> > +       ret = rpmi_shmem_base_service_req(priv,
> > +                                         RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
> > +                                         &servicegroup_id,
> > +                                         &servicegroup_version);
> > +       if (ret)
> > +               return ret;
> > +
> > +       chan_priv = malloc(sizeof(*chan_priv));
> > +       if (!chan_priv)
> > +               return -ENOMEM;
> > +
> > +       chan->con_priv = chan_priv;
> > +
> > +       chan_priv->priv = priv;
> > +       chan_priv->servicegroup_id = servicegroup_id;
> > +       chan_priv->servicegroup_version = servicegroup_version;
> > +
> > +       return 0;
> > +}
> > +
> > +static void rpmi_shmem_close(struct rpmi_chan *chan)
> > +{
> > +       free(chan->con_priv);
> > +}
> > +
> > +static int rpmi_shmem_probe(struct udevice *dev)
> > +{
> > +       struct rpmi_shmem *priv = dev_get_priv(dev);
> > +       int i, ret, qidx, qcount, qslotcnt;
> > +       struct shmem_queue *queue;
> > +       u32 arg_in, arg_out;
> > +       const char *qname;
> > +       fdt_size_t qsize;
> > +       void *start;
> > +
> > +       priv->dev = dev;
> > +       priv->rx_timeout_ms = 20;
> > +
> > +       priv->slot_size = dev_read_u32_default(dev, "riscv,slot-size", 0);
> > +       if (priv->slot_size < RPMI_SLOT_SIZE_MIN)
> > +               return -EINVAL;
>  The probe enforces only the minimum slot size. RPMI also requires a power-of-
>  two slot size; validate that property before deriving queue pointers and slot
>  counts.

Ok

Thanks,
Charles

> 
> regards,
> Subrahmanya
