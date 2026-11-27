Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1F606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dfSrpY4r;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8sxIgAC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4432940899;
	Fri, 27 Nov 2026 05:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-E7LAzEmRaY; Fri, 27 Nov 2026 05:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 717F740854
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795758587;
	b=aH1VTWm1YoeXIBV6KuUwMDThypYkaLg9fOhTWcdCwGKkcvPZ5+INs87iXmVeF5KqVjs6
	 EnKulUezmwONrbpDRlodo7MTEM7IYUrMh1fRIPOxvzxARL4UfXA5/xC94Ui+XRDFrgwBQ
	 AiNBDSYiQsN3eXYtNd3Kb00zzLRYJU/P+Lksb1RQa1MPouCYP6f7myCxK7zUCOT7IiXQD
	 NLbIRYiWYGiDX2QdyjFBIp44suR68h75KmF5fNj6NhZ5S5/Ny3v1QLtAtx97rCob6aQls
	 ZmWjdO2JeXFyrFglUSQAVuOQyInpDSFSjM03WZ1y7XwMoSf/5GcnQP7hnxB/gnTsotQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795758587;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0VuyKDaPe5IaE9+pLdFlnkknP4fxvqGv/JIwlmt6HWQ=;
	b=I2DrW81xfwlQ69rYqN6az4T7+LdcepPsnGMHhHC4GRs7ftBNBrigsI4w1vdBI7dCSeW9
	 GBHjJ7T9tOJxTGPbl056oWLLizmT+LIFRdXVCDPZANh/gwWNvraGE4qqjHTBOjJqfQl9e
	 OdWwXueCgEvgSYMs4ukTnvPuqe+17jKwVg4kXT7OA6JlPADmHc7yHzK7aDZI2DJR6f9wz
	 LHnG2abESsEPjGSh1pLeh/I3O4PjOxBtMmtUi1l55cj7dKZRmAmBzIiIOPz0gNSmXOdaJ
	 wrGeF7fM6Ub0HihzxGxEC8suFTfZ9tGTENPfHysgrrNYr+46S0nJRgfJ++8TRk6rdMw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795758587;
	bh=0VuyKDaPe5IaE9+pLdFlnkknP4fxvqGv/JIwlmt6HWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dfSrpY4r9t3yUWizuDvr867CMG5XMpJxE1/w+RkM0V0aYNxRGnXq2VpWY20CPu8rq
	 /Du7lMohSw0/yx1H2AlmnSKyYzZlnmTT6DtmWJOo5P9YDle36iLhHjgG1YIXO7gMAU
	 LQO+yy4FKm/vnMbUSAPTBH4T7cKqT0+z24BMx3Ll8G8W4YZMDTZ5ETluP77hhPiCbU
	 ghBT3m8U0/+1UexGDKXbMHF89GPS1VPN8FJNoat5bmwO715k789/8Nd41AfHH3nKwJ
	 PgKnGMMP9xALJf9fUQQOVldyfcsOeLN/u/x2A2oTCoi9CLAIkgxHczsbxMRCKOATbx
	 GOfpNS0vgxF4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 717F740854;
	Fri, 27 Nov 2026 05:49:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3CA62BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 05:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B58B060698
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 05:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d8B2G9PllzTB for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 05:49:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3DA860622
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=C8sxIgAC
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3DA860622
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 05:49:44 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cdece95eca4so160069a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 21:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795758584; x=1796363384;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0VuyKDaPe5IaE9+pLdFlnkknP4fxvqGv/JIwlmt6HWQ=;
 b=C8sxIgACF/A4236gg14rYThzfT/bNbD+XKmTm5ZAoxBXHj7Zz9RFGHiW6ZYSgDp6qs
 qFX9/K2o8hMJyRRblVYtlM5WjF6vEjATs9dbcjIrGio1KoizVr5/R/z6/01pyelUqi77
 vF64X9bQA9xroHNhLg4uNQCMtjjTI0q8CYqDnXUAA6WRFXrQgpI5yhl0+z6A6y2E09OC
 swbz5ESSke5sYqMZnKcmgdEahHmgF24zzIcdtMnGeY+3c5fB8mQUID9Qjvul2ZVb9Xl2
 3etIa9H/gu0+vMKvLHdKQNx7nTVglr4k4K/AOPAavy9SanfJA52fs3DRxAnsT42OShDq
 xb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795758584; x=1796363384;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0VuyKDaPe5IaE9+pLdFlnkknP4fxvqGv/JIwlmt6HWQ=;
 b=KN0Zhp8HOJdMo1r9YZsMdLBuCwljE2bsiUatnIrCZRS6WszuCINapycn3DpgIpTcjw
 QWSGlkZBvHa8aZoBRYapHdHX/VL0zYHvKDlQ+x1ap+NQEf17Kqlry5+NtpBo6cuN+N+F
 UM/PsIhx0Nlpshc3DOASSZ01thhBfyWpWdPCirzmkk499SteMjGWIa4BwCUrStfUwzL2
 TcbT6By7z/6tuHhU1LWGDJhEiR7jKCTrmnP1KeQEDN5K3nBK4EJnia2OhYXuG12IxcYW
 RFgD+6H8Pua4OSEi5/a/AuSYtzimpGR4zgva2n9X5JngskKYyH5qXoDzZECUtSvhhC33
 xxtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH07/B0o4zTlfGfhWBb6vxnJNJOPVa4GmLE77zmNXb5JRAvnDK8QKO8oTnFwZAaIEx7stIoxPo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/4VMQy1rW27kB9XNEhU4u3OeRfV4huLVRs+6QzcWN0IoHC1lVI
 n5/tebCcPbjV+TeoyE9UydZttvBrxTkJ6Ry6EtTkk6CWFnUdAe6G7RZ/
X-Gm-Gg: AZFdTZdR/jbsWGotbdFAOaiZxmgsTvwPIdXMgy2j9jpj/Cusm/SodnXuJZGhvKE+XA0
 TH2m59VvVYUmn5OxIcWiNLQU2PCEmy8FEMv0+11/2NboQY2MQWlgj1T0QuVfUs7SrM6nUNXVg7R
 Y5nJzm6AebAbKS54map3QJ/8+aQeJLNjMGT/0Lhtz5ZEB5IMvYfq/Uk0pud36Zta5z6B2i1igA9
 BkU6cL1l6hS26npZQDhhu2FtW3ygJCwE5d4XcMTIWEPVV5oCaChaQtB67Yzj7FpalkvTCsBIrtb
 oAnr0daykTFVbvzLUQXl/5IeOolzqLeAaeLrU0zc5Pl/k9vZfH0vM4hB5S98oy2r7V1mSh37K49
 ovDwqOUp1qTvuD9BtPvAAzW3nH3GtR8yO2IV7RC7ycPvfT/uHWV4kuXu9KfyaEODEsewz52kwXK
 jgirU3zwpH2SbB0sHHBDcfF/J4uf7Oa/CiqpLNcsJXsW0glSHkPCfGHNl3Vtcqx7bkf+zX/hsMf
 BTcSPzVsM2954wXGfeOYBhByLG2QsSwJSymWW4SHzXKRtU2Xajs0RCCFdr2yC93s+Bq3Iz+Tdfi
 kbckbKcGiJXkbUX/63KfXDKubF8SCSEayvONOHHVgaZoEGf1g8BZclE3Sazvo9E3LqCpYRiQqOd
 AsRrITae3TQ==
X-Received: by 2002:a17:90b:3bc5:b0:3ad:1b31:92d8 with SMTP id
 98e67ed59e1d1-3b41cb3e213mr21049051a91.60.1795758583826; 
 Thu, 26 Nov 2026 21:49:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2039:4:54cf:d5b2:8f45:3598])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdec1168866sm2329860a12.25.2026.11.26.21.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 21:49:43 -0800 (PST)
Date: Fri, 27 Nov 2026 13:49:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/4] board: google: Add Google Tensor G5 board support
Message-ID: <awkZ9GzPbbDBxp3v@google.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-3-visitorckw@gmail.com>
 <CAFLszTj7zprFA34rZfsnqyPFNMUco6udWU=vZcwb4w29cuf0yQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj7zprFA34rZfsnqyPFNMUco6udWU=vZcwb4w29cuf0yQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Just realized that my previous email didn't seem to go through.
Sorry about that.

On Mon, Oct 19, 2026 at 06:27:39AM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > board: google: Add Google Tensor G5 board support
> >
> > Add initial board support for Google Tensor G5 SoC boards. U-Boot
> > runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
> > bounds, and disable the APC watchdog left running by earlier
> > bootloader stages.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> >  MAINTAINERS                  |  2 ++
> >  arch/arm/mach-google/Kconfig | 11 ++++++++
> >  board/google/lga/Kconfig     | 14 ++++++++++
> >  board/google/lga/MAINTAINERS |  5 ++++
> >  board/google/lga/Makefile    |  3 ++
> >  board/google/lga/lga.c       | 65 ++++++++++++++++++++++++++++++++++++++++++++
> >  include/configs/lga.h        |  9 ++++++
> >  7 files changed, 109 insertions(+)
> 
> > U-Boot 2026.10-00821-g86c1a8698ac2 (Oct 14 2026 - 21:47:47 +0000)
> 
> >
> > Model: Frankel
> > DRAM:  2 GiB
> > ERROR: reserving fdt memory region failed (addr=be000000 size=1000000 flags=2): -17
> 
> Just to check, is this -EEXIST because the DT already carries a
> reserved-memory entry covering the BL33 load region, or something
> U-Boot adds itself twice ? Worth tracking down before the series lands
> rather than leaving a visible ERROR on every boot.

Yes, upstream lga.dtsi reserves 0xbe000000..0xbf000000 as no-map.
With LGA_BL33_RAM_TOP at 0xc0000000, the 16 MiB stack reservation
below relocated U-Boot overlaps with it. Lowering LGA_BL33_RAM_TOP
to 0xbe000000 fixes this, and I'll update it in v2.

> 
> > diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
> > @@ -0,0 +1,65 @@
> > +#define LGA_SDRAM_BASE		0x80000000UL
> > +#define LGA_SDRAM_SIZE		0x80000000UL
> > +#define LGA_BL33_RAM_TOP	0xc0000000UL
> 
> The Kconfig help text lists Frankel, Blazer and Mustang, which ship
> with different DRAM sizes (Pixel 10 Pro / Pro XL have well over 2
> GiB). Hard-coding 2 GiB means those variants will only ever see the
> first bank and the mem_map will not cover the rest. Please can you
> pick the base/size up from the device tree
> (fdtdec_setup_mem_size_base() or similar) so the same board directory
> works for all three.

The upstream DT for Frankel, Blazer, and Mustang don't have a
/memory node, and earlier boot stages don't pass a DTB to BL33, so
fdtdec_setup_mem_size_base() would fail with -EINVAL. All three
boardphones actually ship with 12 GiB or more of DRAM, and they all
share the same first 2 GiB low DRAM window at 0x80000000 with the rest
mapped above 4 GiB, which is plenty for U-Boot across all three.

> 
> > diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
> > @@ -0,0 +1,65 @@
> > +int board_init(void)
> > +{
> > +	writel(LGA_WDT_KEY_UNLOCK, LGA_WDT1_BASE + LGA_WDT_KEY);
> > +	clrbits_le32(LGA_WDT1_BASE + LGA_WDT_CONTROL, LGA_WDT_CONTROL_ENABLE);
> > +	writel(0, LGA_WDT1_BASE + LGA_WDT_KEY);
> > +
> > +	return 0;
> > +}
> 
> The APC watchdog is a SoC-level block, so this would sit more
> naturally under arch/arm/mach-google/ and be shared by any future lga
> board. What do you think?
> 
I put it in board/google/lga/lga.c mostly because the hook is named
board_init() and other arm64 ports like axiado/scm3005 do something
similar. Also, arch/arm/mach-google/ is meant for multiple
generations where register layouts may differ, while board/google/lga/
already covers all LGA boards and we are unlikely to add another LGA
board directory. Keeping these few lines in lga.c seems simpler until
we have a proper driver under drivers/watchdog/.

Regards,
Kuan-Wei
