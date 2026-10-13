Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C439680D1B;
	Tue, 13 Oct 2026 08:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4C3iRN813Ds7; Tue, 13 Oct 2026 08:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E093A80BB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881124;
	b=GzGGUkmCkXWMDewkOz6l1Mw+K5UtoqJuIFAnr4FqnQhVKD1CtAXQy0Ya0rMHIpTXADxm
	 39k4J3BZej292FXNdpSQzOKOOQ3vM5VM3gW/zhieLu/UFdkCNnhvb7eieVzylCZPq9WYt
	 mjPtz/qNXD/QFLDuoluOCNIA/I3Kq9o/KD3B+jybJpM3rKGD7tMBQMVWfnGobA64GxFbR
	 F7EILj1MKJER+F5o7ZaRNqhDTYBMncSQQLUBGZpPkQFwOyYywRlvAuDUjsGNbXUWodFUj
	 R4+WUjpWlyBCtnz7Wc/rsx7LTuSeD8DQfVSp+qpttx9Xm8oTrqlF0uVWgOUGPpiMtJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HlWri7AEUl4ShGkTU03XLOeSLJjfve9KH8MI83m+Iss=;
	b=QKD+UUCGUUTeH9iqV7duNclaY/aLo2b+PRa6A4C8nfTbIU1on8/KHp5JSHAfpvCt6XOd
	 rNp5otYUcrSDkQG8dE/0lAJj6XfBN629p1JD8lwbdtF6lpGn5wRD0xtE6GQfwRj4WRwbr
	 ehyb+l8LCanmNITYt7qovaQYt9SA0j90ffJbiXQfqbxcslJIBqf9o6+EiNCdDTIUk1EV1
	 aRXTQXLCQgClofQQ/Ce3pjzoxG2+PVs7m1rJnozPqrKk7ZSBwe9Cad/GYGSmMC46FFGrg
	 MmF4HVgNBvlq/cateqX1hz2OVaD2YNe5maduddwH+jLX58vej9ULkzy6RXeVphXYvFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881124;
	bh=HlWri7AEUl4ShGkTU03XLOeSLJjfve9KH8MI83m+Iss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dZleGaA6hov3c4+qrbyizdo7zYN0ZkDYKZJjVoonV5mCwKVM2N/W38ijN114PBtof
	 cnxD7RGid3wcuqrlZR6wdC0wFItex9TNuD8i4GXgtiAjIwtvkllUZa2yPHO1ul+J15
	 qLJ0uW7hIEP9w9SxfFPAGO/zJc79tBG0Qy/5zfHOevVY7nHOMSSksCoVHRGhZjXocK
	 0ywHiD0BWfI/6ZkNan/nRqVGX45HpmaaIRiiBD/ZnSeHBC8qyanM+ZPUfblW1HplO3
	 mRqvITLqVY4sZLyTivVvNlyhbKweJUYMhED89o0Ihpqq26OQ/NC8NJjJ25LYZxKfQW
	 nMj9eMcVLrsDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E093A80BB6;
	Tue, 13 Oct 2026 08:45:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF225788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEB9B40274
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnvZX6q_h181 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 657184026F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881121;
 b=m8h9hxv/8BuVM4+OGU09EarE6eGeToW7LUmgxDCGGV/S1WXg4OmS7+rBb5zkuunSIQti
 FpDYr1DUu6wIGZF4oHBgEUo1sy/gIeAor6thYaAmI8Qgia2QehWQKdcO7b0nt2i3ChYir
 Nq2G2j78Arfz68FOQXkGZ3It6Peg6SgwwITQaR67I760LtVL7+UgEvLPDqRQQzyCdXfLz
 Qo3HYLzeYZyWiMnWmMC1+0mzAUC2gPdTp3Q+OdCEdhnenURCOOLYqSh2cg+ZL7mBzJo3E
 gGRAo86h6BbTk7xkEV5F7Szq3RKMfqa4QPHERzGo3LOOYKvHltVrPDjEzjpthFa8nOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881121;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
 bh=HlWri7AEUl4ShGkTU03XLOeSLJjfve9KH8MI83m+Iss=;
 b=diYEDMED9rbh8rWfpMDwvOCV0jr+cpuRi1UAID3T/TPJIPwZylrt/tjwLlTdbuprC+QG
 KjicL3XBG7fV8yLmGUzQATDxQDbAqvJbgjo/glvfZ2rr2PcLlumRs6ADU1MePEtLb2ZvK
 GzfW1HeLiQ1p2ChwGLzq6NsyBpErWPqLfg8sd2PpWCQzUNvWl7S4c671WwuMj/NW1HQ1k
 aGZUL574IlJjh5you4HMNmJzWVAucRELN0zfM7WdF+TVOVDTuIUtofWRA5MGtmh+bDW/e
 r1QL7wTkGkzGJzyyJCYoV9gHhkmbWSBqF8sRTpRHIKVAd4Wul4MBwcciOnydI+7fBUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="Ev/t7AaE"; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Ev/t7AaE
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 657184026F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BCE89C653E6;
 Tue, 13 Oct 2026 08:46:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4B85860362;
 Tue, 13 Oct 2026 08:45:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8B5DB11D70D46; 
 Tue, 13 Oct 2026 10:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791881116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HlWri7AEUl4ShGkTU03XLOeSLJjfve9KH8MI83m+Iss=;
 b=Ev/t7AaE/IuNS078gbfDahWk/bgOuPhbaEfGfQuorkzL+8rWqGenytncK3qu2mV/EFH4bh
 E8c0RRwqbSDhkX12LlmKrhEo+X3hRdTgg0R+oTOb4KhYlGoQG/dgNtRTTiE+QJTO8eJBsb
 gFjjqgE3OUnGPcckeuNU95aGs6eb7tuhv8P7/Saudpz0cq0RNXp2EoLBr7gYhT3DbIXCZT
 CbAp0aOwW2vjPEMz64c5rbPVFxHOOZCD20hqJX4BCHjzzUisa+4L5toqEKLHK1MN0Vaamp
 HJY5DbkTDfDvv8FE12HDI8oLy9r5efkdhtYPJQEBIzrKv/ECRjKOEw0HWeI3ZA==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 06/10] mmc: metanoia_sdhci: Add SDHCI driver for Metanoia
 MT2824 SoC
Date: Tue, 13 Oct 2026 10:45:09 +0200
Message-ID: <EDoKM1LoTYiVJ09AAx_ihg@bootlin.com>
In-Reply-To: <20261002152935.GV858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-6-bc44cf0e0289@bootlin.com>
 <20261002152935.GV858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

On Friday, 2 October 2026 at 17:29:35 CEST, Tom Rini wrote:
> On Fri, Oct 02, 2026 at 03:02:24PM +0200, Beno=C3=AEt Monin wrote:
>=20
> > Add an SDHCI driver for the DesignWare Mobile Storage Host Controller
> > (DWC MSHC) integrated in the Metanoia MT2824 SoC. It supports eMMC up to
> > HS400/HS400ES and SD cards, and implements the MMC driver model.
> >=20
> > The controller is a DWC MSHC instance, but its PHY programming,
> > voltage/speed-mode handling and tuning model are silicon-specific
> > and differ from the existing DWC MSHC drivers.
> >=20
> > The PHY pad drive strength, receiver select and weak-pull settings
> > depend on the card type (eMMC vs SD) and are re-applied on every ios,
> > whereas snps_sdhci.c uses fixed pad values.
> >=20
> > High-speed modes force 1.8V signalling and HS400 uses an explicit PHY
> > DLL lock sequence (set_control_reg()/set_ios_post()), which snps_sdhci.c
> > does not implement.
> >=20
> > Tuning relies on the generic SDHCI core tuner, whereas snps_sdhci.c uses
> > the hardware auto-tuning block.
> >=20
> > Keeping a dedicated driver avoids per-variant branches in the shared
> > DWC MSHC drivers, matching how snps_sdhci.c, adi_sdhci.c and
> > cv1800b_sdhci.c are already split in U-Boot.
> >=20
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> [snip]
> > +static const struct udevice_id metanoia_sdhci_ids[] =3D {
> > +	{ .compatible =3D "metanoia,mt2824-dwcmshc" },
> > +	{ /* sentinel */ }
> > +};
>=20
> I don't see this compatible in Linus' tree currently, so what's the
> status on upstreaming all of the device tree parts? Thanks.
>=20
We are currently preparing a first patch series for Linux, but it has not
been posted yet.

=2D-=20
Beno=C3=AEt



