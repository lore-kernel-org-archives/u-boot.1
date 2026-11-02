Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6D606AEBF
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X8SfwXur;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=XXiyWr6A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E703481089;
	Mon,  2 Nov 2026 15:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PfETeRDw-JHj; Mon,  2 Nov 2026 15:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5A2280F3A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793633453;
	b=rCvFSYvJvaQNkzhgMdBd0Tb4PHhblJTQBMJmNW48a+9l3ui13tPENlbV81i39grZzA6p
	 u9pF9RU0/HbeP5lywwfoXYW3zgSZ0aneE4M4MiMET/6rLi2voghYsBoDY0gkIE2d2rByt
	 BPN8eqpnUCxZff/tOsRH0nkQGsCte4ClFpwc0IvOLg5hs4LDR1fwUt9ynEYAyBbk56wDy
	 s4/hzL2bn8ckM6JmX8l9RRG8BITq7oJyjmtCAbHxZY6aNfr0M1BwYGwGISXOM1l8XhGNt
	 tMQRKX0e5uP+2NWjVq8crbbcwJon8d2Bd0cT25ThdiOtKyVgeLfFhPSAbGKyclVdZ4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793633453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Eqx79+YPCa5zi/wsBctXeRYuAq/JrztdPkz5evQuwBM=;
	b=QvBkQkpnNoEAgp9FqTAtM7w4QezW7civeCWtG99K6y7Z/U/20YIjrossdIR5Nbgv8KCH
	 rdRJQR5+0+LmRUNS1lwpcZgGaNWx9RhlIo4bpAZDE60YfYms+kASmtRhuAzi8Kb8/DuH+
	 GPD76r+muDEYL0RsQRjUR6Gmj4qdBQgxm6zBD2GcB5Yu2w361M0ksZNGP5mgput8RGOJM
	 JG5bNSpiG84kFREgp8/R28hWjztb081rjNgkTS+MSM4znJirArEV068KjruvMxAOINrcm
	 mdCoJj4x20UiDlq10x15sxcweWiexbP/WXJvHTPxaOFcL9vBFkVsUf5c7bQrKX1N8Ig==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793633453;
	bh=Eqx79+YPCa5zi/wsBctXeRYuAq/JrztdPkz5evQuwBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8SfwXur0icGZkyb57+iGZ/vgGGZh9VnM96T1l7wMl8C3l/WpruVkZWsKaSHzJl+2
	 +7tmg3lRHesqL69Dtb2EF4uqZllK3E6x1ESlnrMYk4TXbOB3NKB9MBmtVjAcZJxKLZ
	 HuKLacTMOYmRp47U5FJXuJ8Iv5kjKTOYb7GheTW/sydwMQtwutw7jxGAQYP5d072N0
	 /Fb10jG+HVIKq9Oz85mtzYH25wvLG06T175aXNWM8D0/YjVOt8p9Mund6S3/6eWuOy
	 HnNlBLpFAtu3Nid858QuA1VcReN6qGY8dlWnS+ATK5Uh14fh1v0HHR/pkFhma1tuCy
	 KjbKEEu2sJ/SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5A2280F3A;
	Mon,  2 Nov 2026 15:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B1AC2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 986BC40695
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9drMSb4V_yH for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:30:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 780E140687
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793633450;
 b=iJIj9jbTVx7o45JqBp1vP1ZQlaLHpUkFlQHaGHdBBQxXBC6i6fC3E2hdeiNI19+SREoL
 g5P1NNyA3VWcO85xY3Jtr1e/NorelEn3kNnvImNLzZJOmiQktmX01e/L/6pXM8LSGDieo
 uf/mlVuLrPcqrmjqZ4K8XgO8lPFbrwme2nJRgzwPSHGjNPR7W2AmiF5mwZYuzqgRN2nUd
 ao5uncBmvI7LAQ3hWe2mjSDccquJNFZZYq4x1AxQHeob3Lv5VhTm3QBfyrTP9AxzlxdiH
 xoyd1DhX67uZ5JlsZGbCE7+hYqmFkx4uBJj5GsCnc2nCKYNySNQC05EVvuluV6Ah/tQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793633450;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Eqx79+YPCa5zi/wsBctXeRYuAq/JrztdPkz5evQuwBM=;
 b=QuViB/onMfYRjNZz5JB7btAqZKIZKjGjakNW7gczrBsu4urV3vZ1Lzee1C8BP3fLGx6Q
 A0fmsH6C77G0DUyg2TODevLPTRF0JMK4U9pkAODcwQgZjnuU53E6kRbIvOYh9tH1mpt2T
 vbQv80QJAfuAyv0SKR+O8/GNRML5540ms91BzLwOiBOYl1EVng3PGwusu6sGKKsV+d5E5
 kjErf3lyd8Glt0SOWzEjDJUlegAEg2mhASNqD+aVrWU1cCIdqZTdhM74Za2hvTwvog3XL
 cGmEpW8qYcbj/G66e/m7gVAAfB/UKVUIpytMxhGN4oBbQ8g2wc+ySmvWePXnk2xXwyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=XXiyWr6A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122d; helo=mail-dl1-x122d.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=XXiyWr6A
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 780E140687
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:30:49 +0000 (UTC)
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-170135e43c7so1066380c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793633449; x=1794238249;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eqx79+YPCa5zi/wsBctXeRYuAq/JrztdPkz5evQuwBM=;
 b=XXiyWr6AI9tOSl/nO36YdrYx75RsDgfuanzcDZQbKXx+7tajufUPqUCDWRdx4UTKlC
 VJ4Xp77YexBeIQHEsFvEo/53Oi61eM8/KfNAuQMU2YHtngaEWyUEdVlo4arUD33d+kSa
 vyXLBGlXbiL9iYmxP7rul3cfME8OA6xsSnN2fMz+qO6a/dBJzB+Y/0XmqnZ8m8Po3HiA
 7v3Br4kDksoHXIdG72zfxznFAE7Kwq8644ar+0qdq15RSfRzc5Mau4H9Yg++7gplEqrq
 6+S/W32+YjDPthJQoPgp0ydG+BwxO7Rf9WncTZtYsojN4BjiYQge7NUkda0130Xj91c+
 jlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793633449; x=1794238249;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eqx79+YPCa5zi/wsBctXeRYuAq/JrztdPkz5evQuwBM=;
 b=H7YvtyaDUpwTLDelkZZ/3XZzstxO8PIitmJZ1sJ9Dv7jgcvFO+wji5kDfvGT/XyA51
 LQOLg/bD/MVghwntKl+OYTS8RX1f9IOXvgx2I6ahdoXt2x5z3al3DPhAr6i8sy4Rwcql
 IIB/dQ/41cOZr7WKnrXlHoW2GaD03w5x6AcUjsKHrJVdRl1aH5fD7IVZuOuENHIdLl2G
 vlpbRGd9QnIZt0r4f1dhSFv5n3BGd6V7dV9VeTH1QNbIhf+nWKoum9QxdUbTbijc3kc/
 4EVD3ez80wH6KzIPnYU8JmBW3qpUxcKLVD9JFWfJr4YG3N0+U3tQBSd+dAhrlDHJPWcJ
 3bfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVqNXlxfXlZ4mHpyAZqgr8iMOlUeC2qyyVWw6sPQd3S8Bvqw0ea+o0D6IJW01NuVrPGqGG4IM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0VvAHMsWbaYCTpluGdcqar6wNt06uVWusznwiqS+2ffBWz8Pe
 P/KraWilSl3YJJAQrwBptqNXSmapJajbX96ohhH5CW6cvxw53O7GZ7eQkWcEZY+08pM=
X-Gm-Gg: AYBFou1sDNp7oX8fdeMb9VOjB2L5Oc16ep3YE6F8Gflg6hRYKeULJXFNLvwD77Jnr8G
 nwHL9dQduU63OpFOS756wjjr1cxI708eR5YK6f8kt8tYP21JhFaKf5nmanoaEIpT4q91HC6XCiC
 V/+SFaAQ3vm2kHzckWTXymu8Z0PuWfP4AaK1tvZ9oJEE3zRsP3Zs1mro78AWWTqFmw7mtqHsl8e
 VkUI3L9iDaRgVLcyv6Q4k+48Eo8RNuHeWUfY8FhArXKKMuNmVX2tVBbVsK8F7lISE8Q4b+vbrDI
 nZjKH4BLm0NoXXEwZFclaWccb6MD8/IyOTa3YsAn4/7lgroGmv4SxCBH/05to9mfpTendFfCGYm
 zpW7jIhext2C0SCJdPkS5b+YCOdAqSJiQo5wpg8lCq0I7kHG8KjnfQzVRkQ/ReafpOSWgVFPRRo
 X6HYQqRv3ywIErtgEhRGOcquknUtmf9J2eg81t0d30K7aZfXB7PsPK3qhScTnEr0LlYM+emSfsu
 MbZFZBlxSZZ3dqPFyQPJWxW97wISKf8rLJBBt4p5VOLmhtKYMcLdEcOymgZimk0AP37b2hSOiDY
 j6zALyuqyKd4ZR5r0qQYzc8PMpOiluDtQYmNRZ7MjEqFlhQMXVKorlha14XOrD9Zhg==
X-Received: by 2002:a05:701b:464d:b0:150:c9c5:1ca1 with SMTP id
 a92af1059eb24-1ac5c64c61dmr15478192c88.18.1793633448694; 
 Mon, 02 Nov 2026 07:30:48 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac0e738445sm35282603c88.0.2026.11.02.07.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:30:47 -0800 (PST)
Date: Mon, 2 Nov 2026 23:30:44 +0800
From: Leo Liang <leo.liang@sifive.com>
To: E Shattow <e@freeshell.de>
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org,
 tim609@andestech.com, zhuxu_ran@zohomail.com, nwhitehorn@pa.msu.edu,
 nikita.shubin@maquefel.me, pengpeng@iscas.ac.cn, me@ziyao.cc,
 jamie.gibbons@microchip.com, gaohan@iscas.ac.cn
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-ID: <auispJr4NSDm9bch@lliang-1876.localdomain>
References: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
 <9a9f37da-2aaf-4770-8a3e-3d946ca4e275@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9f37da-2aaf-4770-8a3e-3d946ca4e275@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E and Tom,

On Mon, Nov 02, 2026 at 07:09:29AM -0800, E Shattow wrote:
> Hi Leo, and Tom,
> 
> On 11/2/26 00:40, Leo Liang wrote:
> > Hi Tom,
> > 
> > The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b:
> > 
> >   cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main
> > 
> > for you to fetch changes up to 22c3818159190cfd6dd378b7a628c0b339ab1c3b:
> > 
> >   clk: sophgo: cv1800b: Drop legacy compatible string (2026-11-01 19:16:36 -0800)
> > 
> > Ci result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/1815
> > ----------------------------------------------------------------
> > - riscv: sophgo: Use upstream devicetrees for CV18xx boards
> > - riscv: mpfs: move system controller configs to CPU Kconfig
> > - arch/riscv: Allow booting from NET
> > - riscv: mpfs: Read and store FPGA design information on MPFS hardware
> > - MAINTAINERS: Make RISC-V entry cover all paths containing the keyword
> > - Fixes:
> >   - riscv: timer: Fix M-mode early timer support
> >   - riscv: thead: fix D-cache flushing
> >   - doc: board: starfive: update jh7110 build output description
> >   - riscv: mpfs: imply the CoreQSPI driver
> 
> There's one more patch I'd like to see in this late PR:
> 
> "[PATCH v2] configs: starfive: enable mtdparts on visionfive2"
> https://lore.kernel.org/u-boot/20261022110913.1415753-1-e@freeshell.de/
> 
> We reviewed a similar patch for SpacemiT K3 and with the benefit of that
> discussion I improved on this patch for starfive from v1 to v2 based on
> what we discovered, so I am confident it is ready to apply.
> 
> Thanks,
> 
> -E

If that is OK with you, I will include this patch and some of the reviewed patchsets
and send out another PR tomorrow or the day after.
There are too many on the list, so sorry for not merging them soon enough.

Best regards,
Leo
