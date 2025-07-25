Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245AC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E7F83965;
	Fri, 25 Jul 2025 14:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="fVwVHK5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5623483968; Fri, 25 Jul 2025 14:30:27 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B598391C
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2247E14846E2; Fri, 25 Jul 2025 14:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1753446623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UJZ8JSB8NlDZx4OGLYAkuzXNygKbetlhJqyVTlLMhxM=;
 b=fVwVHK5m9PMEM9IxDOm2n66zDZ3sRpMs5QdgTo04TFBkOfXJxjXdiJwK+yby/1eZV7AriA
 R03BbV0sO8Sw1vVz7UySHZN8EqzuNUwrhTDCOS1B4zKVZeae+EOCHCoVarHyFBbjQ+geoP
 HVTtMNuhvUpIzNSVvGUyldxNvsz1+79thlkXteXnHwnsrAsByk8NInEKTt75ksFqUh/IXg
 l4ukUxaIY9eihi1nO2b93uxHKdb/qE/dQCU1vf3aBekMSaN0YSwIJE+ewyG9h0Zi5QCb30
 zJgjwM6ghStX6xhXvv1Zw9tuVdavNJfldX1XrAyF42IoKTL4wbEyE9LLu4WFJw==
Date: Fri, 25 Jul 2025 14:30:18 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] fpga: Remove ancient ACEX1K support
Message-ID: <20250725-manicure-snowfield-983318ffcadf@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753442748.git.michal.simek@amd.com>
 <36c875d63ce340a56b71873460d56bb54675b42e.1753442748.git.michal.simek@amd.com>
 <20250725-doorknob-remodeler-a09f1a056ae7@thorsis.com>
 <5ccb25f1-c659-4511-953e-261ce32cfa74@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ccb25f1-c659-4511-953e-261ce32cfa74@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Michal,

Am Fri, Jul 25, 2025 at 02:17:53PM +0200 schrieb Michal Simek:
> 
> 
> On 7/25/25 14:10, Alexander Dahl wrote:
> > Hello Michal,
> > 
> > Am Fri, Jul 25, 2025 at 01:25:53PM +0200 schrieb Michal Simek:
> > > Coverity (CID 583149) reports issue on code which is not enabled by any
> > > real platform that's why remove it completely.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > >   configs/sandbox_defconfig |   1 -
> > >   drivers/fpga/ACEX1K.c     | 245 --------------------------------------
> > >   drivers/fpga/Kconfig      |   6 -
> > >   drivers/fpga/Makefile     |   1 -
> > >   drivers/fpga/altera.c     |   5 +-
> > >   include/ACEX1K.h          |  49 --------
> > >   6 files changed, 1 insertion(+), 306 deletions(-)
> > >   delete mode 100644 drivers/fpga/ACEX1K.c

[…]

> > > diff --git a/include/ACEX1K.h b/include/ACEX1K.h
> > > index 7c5253c66cca..44d1b9765657 100644
> > > --- a/include/ACEX1K.h
> > > +++ b/include/ACEX1K.h
> > > @@ -12,26 +12,10 @@
> > >   #include <altera.h>
> > > -extern int ACEX1K_load(Altera_desc *desc, const void *image, size_t size);
> > > -extern int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize);
> > > -extern int ACEX1K_info(Altera_desc *desc);
> > > -
> > >   extern int CYC2_load(Altera_desc *desc, const void *image, size_t size);
> > >   extern int CYC2_dump(Altera_desc *desc, const void *buf, size_t bsize);
> > >   extern int CYC2_info(Altera_desc *desc);
> > 
> > Maybe CYC2_load() etc. can be moved to a different header file like
> > altera.h for example?
> > 
> > > -/* Slave Serial Implementation function table */
> > > -typedef struct {
> > > -	Altera_pre_fn		pre;
> > > -	Altera_config_fn	config;
> > > -	Altera_clk_fn		clk;
> > > -	Altera_status_fn	status;
> > > -	Altera_done_fn		done;
> > > -	Altera_data_fn		data;
> > > -	Altera_abort_fn		abort;
> > > -	Altera_post_fn		post;
> > > -} Altera_ACEX1K_Passive_Serial_fns;
> > > -
> > >   /* Slave Serial Implementation function table */
> > >   typedef struct {
> > >   	Altera_pre_fn		pre;
> > > @@ -43,37 +27,4 @@ typedef struct {
> > >   	Altera_post_fn		post;
> > >   } Altera_CYC2_Passive_Serial_fns;
> > > -/* Device Image Sizes
> > > - *********************************************************************/
> > > -/* ACEX1K */
> > > -/* FIXME: Which size do we mean?
> > > - * Datasheet says 1337000/8=167125Bytes,
> > > - * Filesize of an *.rbf file is 166965 Bytes
> > > - */
> > > -#if 0
> > > -#define Altera_EP1K100_SIZE	1337000/8	/* 167125 Bytes */
> > > -#endif
> > > -#define Altera_EP1K100_SIZE	(166965*8)
> > > -
> > > -#define Altera_EP2C8_SIZE	247942
> > > -#define Altera_EP2C20_SIZE	586562
> > > -#define Altera_EP2C35_SIZE	883905
> > > -#define Altera_EP3C5_SIZE	368011		/* .rbf size in bytes */
> > > -
> > > -#define ALTERA_EP4CE6_SIZE	368011		/* 2944088 Bits */
> > > -#define ALTERA_EP4CE10_SIZE	368011		/* 2944088 Bits */
> > > -#define ALTERA_EP4CE15_SIZE	510856		/* 4086848 Bits */
> > > -#define ALTERA_EP4CE22_SIZE	718569		/* 5748552 Bits */
> > > -#define ALTERA_EP4CE30_SIZE	1191788		/* 9534304 Bits */
> > > -#define ALTERA_EP4CE40_SIZE	1191788		/* 9534304 Bits */
> > > -#define ALTERA_EP4CE55_SIZE	1861195		/* 14889560 Bits */
> > > -#define ALTERA_EP4CE75_SIZE	2495719		/* 19965752 Bits */
> > > -#define ALTERA_EP4CE115_SIZE	3571462		/* 28571696 Bits */
> > 
> > Can we move these definitions for device image sizes to altera.h
> > instead removing them?  I added some of those with commit 3b2a595fc659
> > ("fpga: altera: Add some more device sizes") back in 2019, and I'm
> > using some of them in downstream code/dts.
> 
> I expect you are also saying that these are Cyclone 2 related right?

Yes.  Only EP1K* is related to ACEX-1K.  EP2C* is Cyclone II, EP3C*
relates to Cyclone III, EP4C* to Cyclone IV.

These are the maximum bitstream sizes of different chip variants, and
can directly be compared to .rbf file sizes (in octets).  Not sure why
the cyclone sizes are in that acex header, but maybe because there was
no dedicated cyclone header? I would just move them to a cyclone
header or to the generic altera header.

> No issue from my side.

:-)

Alex

