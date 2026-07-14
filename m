Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121A7C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606F884D60;
	Tue, 14 Jul 2026 19:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Xxq+QqBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15BB84D61; Tue, 14 Jul 2026 19:42:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2BF084D5F
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=64802a528=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784050961; x=1815586961;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GG7IJPkqb6VwjJx2dlco47BXzUJNOKifeqOfPJSGI8M=;
 b=Xxq+QqBYxc4YoGCz7OMpG7NMdXaEzW99wht4tj0ZuhMLkq/liMhmVOp5
 95r/3TXcPn+8+dPUwKc4tqw+VbCTvWRZYopVBWYaalNO4n593HidO5aLa
 CTjS4uiyLofdYzQ5ExTyMzEf+nzNuw42asIDnP11cBgGml3v12r4jMUh/
 IAylv65z2+L4fHatFiB34LXEcmvlZWoKUT6fB6+GGLbbFWyhju6zd3uGc
 +pcupYUUrGQeWalxp/59Niyk05GoyUUO03kwby4A6dSgvsD0oCwCuLr3W
 dTa+UwQh/wbk5QPsIAXBAq/riP1KUpVp05gb1tyxqbUXb91qiD7NkBdUk Q==;
X-CSE-ConnectionGUID: R27O07oERV+f9xUXXb4VZw==
X-CSE-MsgGUID: NQe5ymGfRUWLSHFvVC9vmA==
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="59734994"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 10:42:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 14 Jul 2026 10:42:24 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 14 Jul 2026 10:42:23 -0700
Date: Tue, 14 Jul 2026 10:42:22 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, <anup.patel@oss.qualcomm.com>,
 <charles.perry@microchip.com>
Subject: Re: [PATCH 2/3] cmd: Add mpxy command and add RISC-V RPMI driver
Message-ID: <alZ0/jx7H6RTDXeA@bby-cbu-swbuild03.eng.microchip.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <20260709175605.1070755-3-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709175605.1070755-3-rahul.pathak@oss.qualcomm.com>
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

On Thu, Jul 09, 2026 at 11:26:03PM +0530, Rahul Pathak wrote:
> The mpxy command is an interactive command which uses
> SBI MPXY interface to interact with supported message
> protocol through available MPXY channels.
> 
> The command helps if there is a custom RPMI service
> group or any other such message protocol implementation
> and that can be tested in some manner without requiring
> the S-Mode OS driver support.

Does that mean the "mpxy" command would also work without the driver from
patch #1 ? If yes, how?

Thanks,
Charles
