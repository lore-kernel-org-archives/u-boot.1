Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF3DC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 05:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 456C740694;
	Wed, 19 Aug 2026 05:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNner3GQpSpW; Wed, 19 Aug 2026 05:28:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787117320;
	bh=a7I8TqZBm7rZ373LsrihQ/58FYlByoO07At/qpfsdDM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yg4JPyxrs2NC+SM3tPcUgg7lNMxRSy2UhQ6pIn7amsEEDOjSWbC/Amf1UENmipfzV
	 Mu9SGHTJiLbmi9E9v3KWPw3iQuoGJ8soxsNeZKMFGFwHmc/OEBFJwB4qtqko5LyOk7
	 2L5WYSh8icTwnjCdBgOSZwAD+6XJBwk1Sr9qHfwsHXme5wFpHQdJCffaZlTlaNY51d
	 s7oUk6N/v+NPxck3e3zBkE+QeNGLTWLCevICEr2HueqrX/Vpx/DbiLoatJd5YUtphD
	 Nm7sMWnfgjIKRqZJpuLKey7uawv2HVrhfTUIIgaMfWFyyape9tWPS+LImv2VTXXXUG
	 m6ABLMbMl6G4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A72D40674;
	Wed, 19 Aug 2026 05:28:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C64D282
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 05:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E65DF6061F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 05:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfk6ncQJZ8f4 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 05:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=tim609@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A36D06061C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 05:28:29 +0000 (UTC)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 67J5S72c091875
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 13:28:07 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 19 Aug
 2026 13:28:07 +0800
Received: from swlinux01 (10.0.15.55) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Aug
 2026 13:28:07 +0800
Date: Wed, 19 Aug 2026 13:27:46 +0800
From: Tim Ouyang <tim609@andestech.com>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
CC: Yao Zi <me@ziyao.cc>, <u-boot@lists.u-boot-project.org>, Tom Rini
 <trini@konsulko.com>, Leo Liang <leo.liang@sifive.com>, Quentin Schulz
 <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, <oyst.lnx@gmail.com>
Subject: Re: [PATCH] iommu: Add RISC-V IOMMU driver
Message-ID: <3q2w5dsgdii7eeeq5mq5jxempshgw4hagagikmvpigxnnounxd@d5rnytl4gkbu>
User-Agent: Mutt/2.2.12 (2023-09-09)
References: <20260803-riscv_iommu-v1-1-793cfa421ab2@oss.tenstorrent.com>
 <rxsu6crqaqxylns2vw5trz4fzsis5w4j36ovh5u2fp3ajj3k2o@oolpt5ilpoxc>
 <CAEev2e_=TojrBbrfD0ZTEGJvGS7XUA44ZruOL5NfUPmSHE054A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEev2e_=TojrBbrfD0ZTEGJvGS7XUA44ZruOL5NfUPmSHE054A@mail.gmail.com>
X-Originating-IP: [10.0.15.55]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 67J5S72c091875
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 17, 2026 at 09:18:23AM -0500, Anirudh Srinivasan wrote:
>
> Hi Tim,
>
> On Sun, Aug 16, 2026 at 7:20 AM Tim Ouyang <tim609@andestech.com> wrote:
> >
> > On Mon, Aug 03, 2026 at 03:06:12PM -0500, Anirudh Srinivasan wrote:
> > > Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> > > specification. This driver sets up the IOMMU in bare mode so that
> > > peripherals requiring DMA in U-Boot can function.
> >
> > Would you consider adding support for SPL?
>
> I don't have an easy way to test this. This will have to be done later.

OK, let’s just move forward with the U-Boot proper part for now.

> > > +#define RISCV_IOMMU_DDTP_TIMEOUT          10000000
> >
> > Although the timeout aligns with Linux’s, it may still be too lengthy
> > for the bootloader stage.
>
> What value do you suggest? Seems like none of the other iommu drivers
> use timeouts, so I'm not sure what to pick.

I think a one-second timeout should be sufficient on real SoCs, while
three seconds should accommodate slower FPGA implementations.
--
Best regards,
Tim Ouyang
