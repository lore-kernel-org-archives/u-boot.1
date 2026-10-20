Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94671606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UDXP3U77;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lNLpQawF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6144089D;
	Tue, 20 Oct 2026 16:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iyp4DmSIxs7g; Tue, 20 Oct 2026 16:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7AB1240669
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515518;
	b=N4FmX2KTLWQUc3xvTNYRzBrL9M6KyxuINz5vKmvQI8z0W6PaElF1F+2/3XExasS9OgX+
	 HGrlc1yRsM0qDZsEcNfie1w0RuOGmwUEVrlxwo+4XZDMyWKshybkyPx0uR8udDwRYiM3f
	 LsOjKMStFrtPc4nH8gCN6LZys191qQJXT/umsi48VY9YhXojMMHOSv5E5iaiS1sB7m/a3
	 0vC9wk+w9L6qskieGd73y3BtDdJ/gWkPtfSaC0nNOn3KqyLfcMn9+nBTDIOcDicfYi4dP
	 MnFNqk9HZhBix0cmmTbir8OtXzgx2TDLY30w0okNR+wZQtK/pYaLaM07yCLvM6PIU5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jBq5rKeyco12xiVlgNK0x36trUbPGdq9dcythNFMt10=;
	b=QUeMxoiFQqc6I+RiUiQzjb7vXnyOAivT47U5lAyVewXenIFjPDxyLXCQ+JEUuZ1nsg/K
	 ZGztAaUDt2ntiOQvtjUAUI3ZfkUS7ZxALEh9y4E76yzh4QTImHdCCuxdNBIpHCLd62Dnv
	 zFac7os2ELhREMGjeCnvaJQ0OaEkglS3siwwo270B4+9ph2nrRAlH/Iwf1SLRj7Kcn15H
	 4uDH2oeVsfvxsnhNKeiPP14BLaAf0Xl6PjJQf0ydKrF27+u30fwTtm04w5HTR9kt9W4gN
	 CfDKqFfQLcSQx1IB5BACoSJe+KDWWUAhOuOQVkX2Ihz6nFpcaLmRjDQFsc7Ddup2BRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lNLpQawF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515518;
	bh=jBq5rKeyco12xiVlgNK0x36trUbPGdq9dcythNFMt10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDXP3U77nxgBzKxi5WF9wLkaevcrn3vMVlB4XQE2JdYqkR96A6B6QQa3rdHWzbvOQ
	 5Dz44KrcyjZdy/wI6kSN64xJG81ct6AHbPcKr7z2nwn1KFCUQPOhYedsuYJyvd4yCL
	 wPkHuSTNghq8hilVb+G3Qd1nIJ4C2sXLnJdNfCOmbc4trMU6SQQ5BY1QHVJS/v0Xn6
	 H/OyHQgjGs+c7zodhS2xipicmP+LOW0wucpvXtsffF6SXepaGsSj52kVrP/H1vvn6x
	 AoRMrIPhvgX/VWRS+3Jv9hOK5xU+p9GGdtsqCQSBTTGfdlVlY8lfWlT96JxijsKOkd
	 Mb4b2bPuEHRTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AB1240669;
	Tue, 20 Oct 2026 16:58:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01EC23A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3BA840669
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpPoGM3QxzFM for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:58:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40AC540636
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792515516;
 b=mm0ztGjHaNT2cLXAilTxEppNeZMFOVPzSWkFhVa8TKGxoXREUXIwtmsKpbohznpwpdlj
 3E9HN+JQu21YoItcwtp1msOLnJ0Bg2Lyy64TAUHUW7TFCPxsXQM3Bc9C0z7PJtgcacBSX
 wA6JvCM0mL1QytDwL8B/AV7/q5v2GDGebJoiPR6ik9pNjbcOIpenIGZHLhRvqIrckKKTF
 0ejuLw7V8Uk6U5MLUbuGtdGh7Qpzqa+EwVIf4vOGh3QD2CTXH7S7kkduwJdOFQeoblrUx
 xo7iPko81Qi3u+Cx96RUqlbCni3YtyiTBBxAoAOnEYXFs07gwZS7c+//s4QywwOI1FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515516;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=jBq5rKeyco12xiVlgNK0x36trUbPGdq9dcythNFMt10=;
 b=fOTN1wrgzUGVwR+7BMa5h4X5XBEUpQ5C3cElAe7lvYV0YOd5OHXcPmND8hSWLmXmZCas
 8mVPoecRuT3NFQe4+JYbtxr+rloLLOM31FhfEeqqlVThj1ZlK5Vw8Fn1LXOaVtElaswhR
 IxxeJNGIuj6XcAcyozV8GuppMZo1qdNlT/5nB+yXcuVfm/USNCYglVEhcdCPYoQSi6sii
 S5TEmfgc/eYbsQxvtANX+VseCj2DwyDQJ3NI8qvOqJv4o/0MmUcK1RSjVo3rZpqA1X/wL
 YTZwWQBA1iFcJ17yHWc8nUC7qFGfBj46F1opmZcgZWhUlTk6PM6x5EeFzR8V/ehoIlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lNLpQawF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lNLpQawF
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40AC540636
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:58:34 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-7cc0892f92cso997371137.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792515513; x=1793120313;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jBq5rKeyco12xiVlgNK0x36trUbPGdq9dcythNFMt10=;
 b=lNLpQawF3b+Fp6qpHY158c359Tf20D0hSp46E3V7SgqYMwbknTitVlGEFIZMCDXsKa
 CY/dx4e9YyurfywbfXQa+xnEOpX3H/g4vCJLL5PLRavpuLxOdausO+6ACVS8p4PGQaXl
 95eTDjk5zsczMoAZgiCwz8AMF7EGLHHFT5faAblXiYjCoJIbdHLTbXmbXTlH3zLuhG5M
 2CsPQbN1uSkhFls/UC6wT1w/rGrxQNP90weQiGiE6mdOsDmJI0pK1vIylPsKfkxzseTj
 2AOSr2S5dKqfYrAoSO3xphcl6WxeTSgGGfEF5xLZM1Wq99NdebbdWuoMEhdawG21jAoL
 QUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515513; x=1793120313;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jBq5rKeyco12xiVlgNK0x36trUbPGdq9dcythNFMt10=;
 b=o1lA4kKrbhZVDWhbUifuPFF8Tp6IHDGwt+yvpGcoznFegkCyLulX/Q2vawqe6n9B/L
 QP1brUELJEU47fC5iB2Zqf50kIXVJzO2Ov9kJIyYbIPop2J5NnTkoft1Psw24S7Zzp29
 T+xXUJWdfWKCu/rsF60Ou/ukvwp9d2+CHbJE4nxdLsv/hCuzvg4y6qF84hBtscrNphl4
 8P4rXmMNj0BJhUl0As1FovK8VMmmbMMf3qb+wpnb0VuyedAnLc60x6VIcchQWy/xCs9D
 ib5GLzg31w25dD2r639NymGylbaU+BzxgWE7F3usVD2qqVvrRFrvFF6ZqJWftwl+eBmB
 MqSQ==
X-Gm-Message-State: AFq9FYKEN6ztXr3IvwR4+zztkbZyt/Apn3ac21uod1q4+qjpDWjKa7ua
 7iBdHC2p2bdyV+cdZeEuFclehcO4zhPG/qCtvzV/+KgY+QFKWyvIMLHpoW1FZgkZpDQ=
X-Gm-Gg: AYBFou04uHm3AuADgRc8D7dox9LCl1RbrNip1VbyOmF7S8CPId+JSVYnhK3SOhEL8nM
 +8PXt8pvS/PHaIz8sQDAEoSbzFwtG2vAxczivDWLgBKVLfHiNhF9eQ6LjudDeyxlzzC0n6lzBbj
 GethzG4f+9vJys2lBa+CAqVFb2Cs1vlwBQyiDT0sXWRswN0sh1/9k+QV8FXHWUCpDzoIe9lW/Il
 0DIPibbDjGtrA+PWIhD7IYDMX4ghLJ8geUgTKSM8R/Y2/fsqQ841TYph0DmnQtrMP8F0vrvfElc
 kY3porRkZyIItrP1VZ/E4yDion2easz4qlHqtakbFLPQ4+QKbgwVKWJVPlLJ5B43ckp6/31SSnP
 xOxChaMof1A6GsUeeWaguSSSBiW/kHLVC3TJVFdclYiBblG1I+5cfQLwP9A7m3gfeaK1Fn2aK7L
 9Ui35Tm7V35SkmkHFIZezrurQ31/P0x3z3L7d6Qh0dLEMBgosmb1EKlIOhyguBnQWWSn3b9UfTn
 RDT/qvnUrD8+RaccgAUfpW2TWio2vz6mfS1dLYFUSc=
X-Received: by 2002:a05:6102:5488:b0:7cc:2086:34cc with SMTP id
 ada2fe7eead31-7cc369c0cd8mr2606800137.16.1792515513008; 
 Tue, 20 Oct 2026 09:58:33 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc772ca218sm3309836137.11.2026.10.20.09.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:58:32 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:26 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, 
 Kongyang Liu <seashell11234455@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
Subject: Re: [PATCH v2 0/3] board: sophgo: milkv_duo: enable standard boot
Message-ID: <ateddYHCWl-XK3vL@hiagonb>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
 <atPXMIVNYWOKWJPm@hiagonb> <atXP4EoaPk6ydwCa@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atXP4EoaPk6ydwCa@pie>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 08:08:00AM +0000, Yao Zi wrote:
> On Sat, Oct 17, 2026 at 05:17:11PM -0300, Hiago De Franco wrote:
> > Hi Yao Zi,
> > 
> > On Fri, Oct 09, 2026 at 11:58:21AM -0300, Hiago De Franco wrote:
> > > The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
> > > and has no environment file, so U-Boot has no bootcmd and none of the
> > > kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
> > > the extlinux bootmeth.
> > > 
> > > Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
> > > layout that fits into the 64MB of DRAM:
> > > 
> > >   0x80200000  kernel_addr_r       (16MB)
> > >   0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
> > >   0x82200000  fdt_addr_r
> > >   0x82300000  scriptaddr
> > >   0x82400000  pxefile_addr_r
> > >   0x82500000  ramdisk_addr_r
> > > 
> > > Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
> > > below the relocated stack pointer, and the default 16MB left only about
> > > 1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
> > > 16MB are available for an initrd.
> > > 
> > > This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
> > > devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
> > > to sophgo/<board>, so that fdtfile matches the Linux devicetree install
> > > path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).
> > > 
> > > Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/
> > > 
> > > Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
> > > extlinux.conf on the SD card.
> > > 
> > > Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> > 
> > just a ping about this patch, I do not know if it was picked
> > yet or If I should wait and rebase on v2027.01-rc1. Can you help please?
> 
> I'm only reviewer of the RISC-V architecture, and don't help with picking
> patches etc :)
> 
> And I think the series (Zhuxu's one) on which it depends hasn't been merged
> yet?

That is correct. So I will wait for the other patch to be picked up
first. Thanks again and sorry to bother you :)

> 
> Best regards,
> Yao Zi

Best regards,
-- 
Hiago
