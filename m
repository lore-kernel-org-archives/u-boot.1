Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78611606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DuMOP/S2;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=V4eyGF4P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49DCE80D05;
	Mon, 26 Oct 2026 18:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJWKE5MBanSs; Mon, 26 Oct 2026 18:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE04780D34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793041079;
	b=FPcFNorT56nXeuRmVL3HR2okBdDtpIvmTmdiO5VTn358h2dCx1VmIaMl9IBsRwCgAg3o
	 I77E9IkpnASWMwv8EQtj+thtU8kSf+RAGy3NSFD1uJBYgw8pAwy1/2SFxYm2HWlgEpYbL
	 VhpPtTO5FjT+WMMUOHBUWAREoORN+Q22oDlNu2FwgIhLG5LSurBdHRJZlL+Zv8QBErzQp
	 /gG+DHm7rqvx8ZZTYLKJXYqcjasYToxsOAcFBIECCHdMlll2yQvMeRhY37mZyGLH8Q+Y/
	 QhiLCSO+EXH9wPxostlvX7jDRKhsiGejZBPe+8qEAx6luWN+Pa0WJTARr44xtvRZt/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793041079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=50g7f8XgONDBgnBXoAk1kGGDr0kscvi3OsJjC1bIqVs=;
	b=XmT/r9g8R5ux6BGy5EP3ttAIC7QQHngdTijN5x40Pz79ccRoSV8FHjApmol409VCmzAh
	 GywqWG2fOOh6flPptAVzPPwNyP/JR6FCJhEAx+f6poqLheUn93A/eao0u06J7hQIjkNKJ
	 CT7S1pIg/qq7d5b0z74cCOwvagzvpebKFSFjAJBb4Yp0ilaaRl21VroYbtTyd4HFJ+NqP
	 fZ1U1t5znqVLx4hjvOJa3/LbT0F/7QbjlfvH+nXQccgUVqcQtCIymODMT3zX03q3rvMaZ
	 MjtwCmRhxIQP70OjuL2LWX2yUC/ygNjDJXPxe+8Tebz0zyD3hon46nJijHFr5BcIYng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793041078;
	bh=50g7f8XgONDBgnBXoAk1kGGDr0kscvi3OsJjC1bIqVs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DuMOP/S2JbcaS6RM2YwlN3FvN9xRewYVCXqT9DN/Ej5OHrpr9xFxhMurC+qSS7gu8
	 q+nRiqQYLrF5mulRLbSyaEmeY2vtaYHEsWr9HMAacdiWmXHLG8t6u1hjcQVxeKS3/K
	 qqwNts3SwTvyY3mIHTE3+1eS0x/k77B4F5F5SdsjbLtejR5EwSCTDNJ+93N3kKOZbB
	 aM3YifLbOAw0zy8uSp2OnB7Y1Bdw8WG5l/cnxjx1rYXfGSTvOl7w8VWBViPFeuUPwW
	 owgyBhZuZo9dSXKazv+gR2sQUD5s+E8fBDOYh2/4F3qaLCy9uHqeTOe7DK2KteUTc1
	 z6f3Uzx9Ddl2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE04780D34;
	Mon, 26 Oct 2026 18:57:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 122BC235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0381C400D2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id js7GMdiyNcrJ for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:57:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4B05B40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793041076;
 b=VsPEtq8uU+yFH1OchosKC5LEr1lhtKYG1O3yS3XT7qz3tkpUeVIpQJbkCjNpX48SRMhP
 Pe4E6D3kmxkG1mUA5sI1a+Zzu9E+6mEw+80oHvhbieUqpqOYZ0USI+1SwRnANm7VtWE5u
 oUlfTY26uBMx01Y/rcHmwaHEVY8pVGixl5Ix75K68+u62obdJssIksZ+UeSp9VZhXEWZP
 UiiNr1+hEbd6ff0ZiOVYJLFCEEvWjMQV0i1yd9/MJZuo8O7zmXdF0V+VpQLlGTwcpqU6+
 fxD89Sy/HK2Fk9VCBCXVVBBN9SZxOTibZ8WZV3ht9IgH0kSURtZzsbKi99tZv/AlJ5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793041076;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=50g7f8XgONDBgnBXoAk1kGGDr0kscvi3OsJjC1bIqVs=;
 b=OxP6+VgWyUtXeXMtlXY8f1GE6lbHfKvlctFxT0M/RKCmUIWadRKgtMlI2jUFgsnNLDy/
 tXCxtRn2V/m3FolyRMXlof+whp4MAUH4rso0sB9UdesIhIWemfNYuaQiNk3ZH6sRXujAb
 zEgA284q+texfmFNlH5Gmg6wRxRZ2WObW3/Bjy5oKgTN9CxexYFsnAnNBOPk9EvLIwG8W
 DpxjcykRPNguYvn7YavRvvFpkFHATiKXyZTW/9CAqROAefB5GAJPls6vvwOsm30N3eh+a
 HknZ02io0kG9PNiS1IT0aryZQ6jl5W9SNJSG+h86+KzTioaykkBO4Zhl1byAAwe3Y4g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=V4eyGF4P; 
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=752c32f41=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=V4eyGF4P
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B05B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793041075; x=1824577075;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=F1WvaycIzucbz4uWi8EUIqg19Cn3KJW1JBXYyQIeb7g=;
 b=V4eyGF4PqUx8/kPZwP0xctAy02IRN1twNzmedNzAvMuvoeWMSh3tnFz1
 s55WyD5VwSL/4vrx79Ghw+xpOCm0YfIKG2evbF3fzwteqUMJc7N493pGQ
 COXqJs959HuV6wV/hJAndtudqfuF9r2Q11WlQvjZIp2KplecDEsByU549
 q25TiTsEDCXvKIXqeVIa15rCIxE5dD19nVU3u8LTqwOxWYHIxAsLz31Qd
 +jok2h5bqZDxSi2eXDUk+4EE503wirp3gWNA9uD83u4Q2zRRrBN2BMoC0
 EaogIcczmO72mYeWd3GnNCFEz5QBa/RCKv6O0RnW/G/ttAL8qimA7UD6N Q==;
X-CSE-ConnectionGUID: ux4G4qxXSKaBedDWjAPYcA==
X-CSE-MsgGUID: qvVKrKLFS7iR7eUKk/LCrA==
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; d="scan'208";a="232650801"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 11:57:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 26 Oct 2026 11:57:53 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 11:57:52 -0700
Date: Mon, 26 Oct 2026 14:57:50 -0400
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
 <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Rahul
 Pathak" <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] drivers: firmware: rpmi: Add the mpxy command
Message-ID: <at-irnxTzMNkwka_@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-6-d53d34a49780@microchip.com>
 <CAPxK-6frZ8xx5xzh-GVdd8drzjaEmH+HNew0mWNc4zY3kCBb4A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPxK-6frZ8xx5xzh-GVdd8drzjaEmH+HNew0mWNc4zY3kCBb4A@mail.gmail.com>
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

On Mon, Oct 26, 2026 at 12:51:37PM +0530, Subrahmanya Lingappa wrote:
> Charles,
> 
> On Wed, Oct 14, 2026 at 7:47 PM Charles Perry
> <charles.perry@microchip.com> wrote:
> >
> > From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> >
> > Add the mpxy command which allows listing MPXY channels, reading/writing
> > arbitrary channel attributes and sending raw messages.
> >
> > The mpxy command is useful for interacting with custom RPMI service groups
> > that have no associated driver. It can also be useful for debugging and
> > testing SBI proxy drivers as well as the PuC firmware.
> >
> > Signed-off-by: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> > Changes in v4:
> >  - Force a device_probe() of all UCLASS_RPMI devices if g_mpxy is NULL
> >  - Remove the unnecessary edit to "cmd/riscv/Makefile"
> >  - Fix a printf placeholder for 32 bits %ld -> %zu
> >
> > Changes in v3:
> >  - Add this patch
> > ---
> >  drivers/firmware/rpmi/Kconfig         |   7 +
> >  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 404 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 407 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfig
> > index b462d3693987..c6a6b6fe61de 100644
> > --- a/drivers/firmware/rpmi/Kconfig
> > +++ b/drivers/firmware/rpmi/Kconfig
> > @@ -18,6 +18,13 @@ config RPMI_SBI_MPXY
> >           specification for the MPXY extension is available at:
> >           https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> >
> > +config CMD_MPXY
> > +       bool "mpxy command"
> > +       depends on RPMI_SBI_MPXY
> > +       help
> > +         Enable the 'mpxy' U-Boot command for listing MPXY channels,
> > +         reading/writing arbitrary channel attributes and sending raw messages.
> > +
> >  config RPMI_SHMEM
> >         bool "RPMI over shared memory transport"
> >         depends on RPMI_FIRMWARE
> > diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > index 9ccca0eb59b2..5f01a6303323 100644
> > --- a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> > + * Copyright (c) 2026, Rahul Pathak <rahul.pathak@oss.qualcomm.com>
> >   */
> >
> >  #define LOG_CATEGORY UCLASS_RPMI
> > @@ -16,6 +17,7 @@
> >  #include <malloc.h>
> >  #include <rpmi-uclass.h>
> >  #include <string.h>
> > +#include <dm/device-internal.h>
> >
> >  /* SBI MPXY channel IDs data in shared memory */
> >  struct sbi_mpxy_channel_ids_data {
> > @@ -60,10 +62,10 @@ enum sbi_mpxy_attribute_id {
> >
> >  /* RPMI message protocol specific MPXY attributes */
> >  enum sbi_mpxy_rpmi_attribute_id {
> > -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> > -       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> > -       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> > -       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> > +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID = 0x00,
> > +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION = 0x01,
> > +       SBI_MPXY_RPMI_ATTR_IMPL_ID = 0x02,
> > +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION = 0x03,
> >         SBI_MPXY_RPMI_ATTR_MAX_ID
> >  };
> >
> > @@ -87,6 +89,24 @@ struct rpmi_sbi_mpxy {
> >         struct sbi_mpxy_chan_desc *channel_descs;
> >  };
> >
> > +static struct rpmi_sbi_mpxy *g_mpxy;
> > +
> > +static __maybe_unused struct rpmi_sbi_mpxy *mpxy_get_global(void)
> > +{
> > +       struct udevice *dev;
> > +       struct uclass *uc;
> > +
> > +       if (!g_mpxy) {
> > +               uclass_get(UCLASS_RPMI, &uc);
> > +               uclass_foreach_dev(dev, uc)
> > +               {
> > +                       device_probe(dev);
> > +               }
> > +       }
> > +
> > +       return g_mpxy;
> > +}
> > +
> >  static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> >                                     u32 base_attrid, u32 attr_count,
> >                                     u32 *attrs_buf)
> > @@ -105,6 +125,24 @@ static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> >         return 0;
> >  }
> >
> > +static __maybe_unused int
> > +rpmi_sbi_mpxy_write_attrs(struct rpmi_sbi_mpxy *mpxy, u32 channel_id,
> > +                         u32 base_attrid, u32 attr_count, u32 *attrs_buf)
> > +{
> > +       struct sbiret sret;
> > +       int i;
> > +
> > +       for (i = 0; i < attr_count; i++)
> > +               ((__le32 *)mpxy->shmem)[i] = cpu_to_le32(attrs_buf[i]);
> > +
> > +       sret = sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_WRITE_ATTRS, channel_id,
> > +                        base_attrid, attr_count, 0, 0, 0);
> > +       if (sret.error)
> > +               return sbi_to_linux_error(sret.error);
> > +
> > +       return 0;
> > +}
> > +
> >  static int rpmi_sbi_mpxy_send_message(void *shmem, u32 mpxy_fid, u32 channel_id,
> >                                       u32 msg_id, const void *tx,
> >                                       unsigned long tx_len, void *rx,
> > @@ -368,6 +406,8 @@ static int rpmi_sbi_mpxy_probe(struct udevice *dev)
> >                             desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
> >         }
> >
> > +       g_mpxy = mpxy;
> > +
> >         return 0;
> >
> >  err:
> > @@ -408,3 +448,359 @@ U_BOOT_DRIVER(rpmi_sbi_mpxy) = {
> >         .ops = &rpmi_sbi_mpxy_ops,
> >         .flags = DM_FLAG_PRE_RELOC,
> >  };
> > +
> > +#if CONFIG_IS_ENABLED(CMD_MPXY) && !CONFIG_IS_ENABLED(XPL_BUILD)
> > +
> > +#include <command.h>
> > +#include <hexdump.h>
> > +
> > +static const char *mpxy_proto_to_str(u32 proto_id)
> > +{
> > +       switch (proto_id) {
> > +       case SBI_MPXY_MSGPROTO_RPMI_ID:
> > +               return "RPMI";
> > +       default:
> > +               return "Unknown";
> > +       }
> > +}
> > +
> > +/**
> > + * mpxy list
> > + *
> > + * List the mpxy channels
> > + */
> > +static int do_mpxy_list(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                       char *const argv[])
> > +{
> > +       struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
> > +       struct sbi_mpxy_chan_desc *chan;
> > +       u32 proto;
> > +       int i;
> > +
> > +       if (!mpxy)
> > +               return CMD_RET_FAILURE;
> > +
> > +       for (i = 0; i < mpxy->channel_count; i++) {
> > +               chan = &mpxy->channel_descs[i];
> > +               proto = chan->attrs[SBI_MPXY_ATTR_MSG_PROT_ID];
> > +               printf("Channel 0x%x: proto_id=0x%x (%s), ver=0x%x\n", chan->id,
> > +                      proto, mpxy_proto_to_str(proto),
> > +                      chan->attrs[SBI_MPXY_ATTR_MSG_PROT_VER]);
> > +       }
> > +
> > +       printf("sbi_mpxy: found %d channels\n", mpxy->channel_count);
> > +       return CMD_RET_SUCCESS;
> > +}
> > +
> > +static void mpxy_print_capability(u32 val)
> > +{
> > +       static const struct {
> > +               u32 bit;
> > +               const char *name;
> > +       } caps[] = {
> > +               { SBI_MPXY_CHAN_CAP_MSI, "MSI" },
> > +               { SBI_MPXY_CHAN_CAP_SSE, "SSE_EVENT" },
> > +               { SBI_MPXY_CHAN_CAP_EVENTS_STATE, "EVENTS_STATE" },
> > +               { SBI_MPXY_CHAN_CAP_SEND_WITH_RESP, "SEND_WITH_RESP" },
> > +               { SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP, "SEND_WITHOUT_RESP" },
> > +               { SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS, "GET_NOTIFICATIONS" },
> > +       };
> > +
> > +       bool any = false;
> > +       int i;
> > +
> > +       printf(" (");
> > +
> > +       if (!val) {
> > +               printf("none)\n");
> > +               return;
> > +       }
> > +
> > +       for (i = 0; i < ARRAY_SIZE(caps); i++) {
> > +               if (val & caps[i].bit) {
> > +                       if (any)
> > +                               printf("|");
> > +                       printf("%s", caps[i].name);
> > +                       any = true;
> > +               }
> > +       }
> > +       printf(")\n");
> > +}
> > +
> > +/* Decode well-known field values for selected standard attributes */
> > +static void mpxy_print_std_attr(u32 attr_id, u32 val)
> > +{
> > +       /* Standard MPXY attribute names, indexed by attr_id */
> > +       static const char *const mpxy_std_attr_names[] = {
> > +               [SBI_MPXY_ATTR_MSG_PROT_ID] = "MSG_PROT_ID",
> > +               [SBI_MPXY_ATTR_MSG_PROT_VER] = "MSG_PROT_VER",
> > +               [SBI_MPXY_ATTR_MSG_MAX_LEN] = "MSG_MAX_LEN",
> > +               [SBI_MPXY_ATTR_MSG_SEND_TIMEOUT] = "MSG_SEND_TIMEOUT",
> > +               [SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT] =
> > +                       "MSG_COMPLETION_TIMEOUT",
> > +               [SBI_MPXY_ATTR_CHANNEL_CAPABILITY] = "CHANNEL_CAPABILITY",
> > +               [SBI_MPXY_ATTR_SSE_EVENT_ID] = "SSE_EVENT_ID",
> > +               [SBI_MPXY_ATTR_MSI_CONTROL] = "MSI_CONTROL",
> > +               [SBI_MPXY_ATTR_MSI_ADDR_LO] = "MSI_ADDR_LO",
> > +               [SBI_MPXY_ATTR_MSI_ADDR_HI] = "MSI_ADDR_HI",
> > +               [SBI_MPXY_ATTR_MSI_DATA] = "MSI_DATA",
> > +               [SBI_MPXY_ATTR_EVENTS_STATE_CONTROL] = "EVENTS_STATE_CONTROL",
> > +       };
> > +
> > +       printf("  [0x%02x] %-28s: 0x%08x", attr_id,
> > +              mpxy_std_attr_names[attr_id], val);
> > +
> > +       switch (attr_id) {
> > +       case SBI_MPXY_ATTR_MSG_PROT_ID:
> > +               printf(" (%s)\n", mpxy_proto_to_str(val));
> > +               break;
> > +       case SBI_MPXY_ATTR_MSG_PROT_VER:
> > +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff);
> > +               break;
> > +       case SBI_MPXY_ATTR_MSG_MAX_LEN:
> > +               printf(" (%u bytes)\n", val);
> > +               break;
> > +       case SBI_MPXY_ATTR_MSG_SEND_TIMEOUT:
> > +       case SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT:
> > +               printf(" (%u ms)\n", val);
> > +               break;
> > +       case SBI_MPXY_ATTR_CHANNEL_CAPABILITY:
> > +               mpxy_print_capability(val);
> > +               break;
> > +       default:
> > +               printf("\n");
> > +               break;
> > +       }
> > +}
> > +
> > +static const char *mpxy_rpmi_proto_attr_name(u32 attr_id)
> > +{
> > +       switch (attr_id) {
> > +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID:
> > +               return "SERVICEGROUP_ID";
> > +       case SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION:
> > +               return "SERVICEGROUP_VERSION";
> > +       case SBI_MPXY_RPMI_ATTR_IMPL_ID:
> > +               return "IMPLEMENTATION_ID";
> > +       case SBI_MPXY_RPMI_ATTR_IMPL_VERSION:
> > +               return "IMPLEMENTATION_VER";
> > +       default:
> > +               return "UNKNOWN";
> > +       };
> > +}
> > +
> > +static void mpxy_print_proto_attr(u32 attr_id, u32 val, bool is_rpmi)
> > +{
> > +       u32 rpmi_attr_id = attr_id - SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> > +       const char *name = is_rpmi ? mpxy_rpmi_proto_attr_name(rpmi_attr_id) :
> > +                                    "UNKNOWN";
> > +
> > +       printf("  [0x%08x] %-24s: 0x%08x", attr_id, name, val);
> > +
> > +       if (is_rpmi &&
> > +           (rpmi_attr_id == SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION ||
> > +            rpmi_attr_id == SBI_MPXY_RPMI_ATTR_IMPL_VERSION)) {
> > +               printf(" (v%u.%u)\n", (val >> 16) & 0xffff, val & 0xffff);
> > +       } else {
> > +               printf("\n");
> > +       }
> > +}
> > +
> > +/**
> > + * mpxy readattr <channel_id> <attr_id>
> > + *
> > + * Read the attribute on a channel
> > + */
> > +static int do_mpxy_readattr(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                           char *const argv[])
> > +{
> > +       struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
> > +       u32 chan_id, attr_id, attr_val;
> > +       int ret;
> > +
> > +       if (argc < 3)
> > +               return CMD_RET_USAGE;
> > +
> > +       if (!mpxy)
> > +               return CMD_RET_FAILURE;
> > +
> > +       chan_id = simple_strtoul(argv[1], NULL, 0);
> > +       attr_id = simple_strtoul(argv[2], NULL, 0);
> > +
> > +       ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, attr_id, 1, &attr_val);
> > +       if (ret) {
> > +               printf("Read attr 0x%x on channel 0x%x failed (%d)\n", attr_id,
> > +                      chan_id, ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       printf("Channel 0x%x: attr[0x%x] = 0x%x\n", chan_id, attr_id, attr_val);
> > +       return CMD_RET_SUCCESS;
> > +}
> > +
> > +/**
> > + * mpxy readattrall <channel_id>
> > + */
> > +static int do_mpxy_readattr_all(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                               char *const argv[])
> > +{
> > +       struct rpmi_sbi_mpxy *mpxy = mpxy_get_global();
> > +       u32 chan_id, attr_val[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> > +       bool is_rpmi;
> > +       int i, ret;
> > +
> > +       if (argc < 2)
> > +               return CMD_RET_USAGE;
> > +
> > +       if (!mpxy)
> > +               return CMD_RET_FAILURE;
> > +
> > +       chan_id = simple_strtoul(argv[1], NULL, 0);
> > +
> > +       ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, SBI_MPXY_ATTR_MSG_PROT_ID,
> > +                                      SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> > +                                      attr_val);
> > +       if (ret) {
> > +               printf("Read attr on channel 0x%x failed (%d)\n", chan_id, ret);
> > +               return CMD_RET_FAILURE;
> > +       }
> > +
> > +       /* Standard attributes */
> > +       printf("Channel 0x%x standard attributes:\n", chan_id);
> > +       for (i = 0; i < SBI_MPXY_ATTR_STD_ATTR_MAX_IDX; i++)
> > +               mpxy_print_std_attr(i, attr_val[i]);
> > +
> > +       /* Protocol-specific attributes */
> > +       printf("Channel 0x%x protocol attributes:\n", chan_id);
> > +
> > +       for (i = SBI_MPXY_ATTR_MSGPROTO_ATTR_START;
> > +            i < SBI_MPXY_ATTR_MSGPROTO_ATTR_END; i++) {
> > +               ret = rpmi_sbi_mpxy_read_attrs(mpxy, chan_id, i, 1,
> > +                                              &attr_val[0]);
> > +               if (ret)
> > +                       break;
> > +
> > +               is_rpmi = mpxy->channel_descs[chan_id]
> > +                                 .attrs[SBI_MPXY_ATTR_MSG_PROT_ID] ==
> > +                         SBI_MPXY_MSGPROTO_RPMI_ID;
>  `chan_id` is an external MPXY channel ID, not necessarily the descriptor
>  array index. The descriptors are stored by discovery position, so a valid
>  non-contiguous channel ID can cause an out-of-bounds read here. Please resolve
>  the channel ID to its descriptor index before accessing `channel_descs`.

Oops! I guess that one worked because MSGPROTO_RPMI_ID is zero and I
happened to access zeroed memory here.

I'll change this to use "attr_val" that was read in this function instead
of using the cached channel attributes.

Thanks,
Charles

> 
>  Regards,
>  Subrahmanya
