Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A47CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 11:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAE6A41028;
	Sat,  3 Oct 2026 11:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lE_H3UPa9rXu; Sat,  3 Oct 2026 11:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D56541049
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791025707;
	b=fjK5kNajYS0dNi1sqCsCUhBvY8q/iHKbCXX3SrWpqMkmddEXicKuhsetkHPtjuHXcJv1
	 YxEBu2dOMa9qTf4A9FGqmv5MzLLSlp48Gdydss71x0af98W67CRSZzvvEFwQ/we8x0CP3
	 38NnIHZqlIbREkLiRR0pDymh/RyfbsNqFYqWuYxvY2uZqpxSzpG7vbzm/wwrde6P5TlkZ
	 baqUbTiVc7yxXHRvMnVsMh4IZiNNwQNJlOAb6oA11AXxvLGa7uINj/LEK1MqgjYgwCEiE
	 W7Ywhe2SHCBTDz6fnPxLTBEAV1kCrtE3eBd13IklJYNk6rbiCwoFwSKQIUdxuekeiQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791025707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AEnErtWh7sZlHZdJsgofaVLAib2bAtC9sMrxaPxiuik=;
	b=GSUu+BSwc0pbo+g39TZ9XcSNZ64yXmfIHMTBYRd2QK7ZZrR0t2yFP6f/RQ5tvjYW8KzF
	 rvvUBH2likyMhemgwIoTP1D6QpqCjBs0hOQzObITmZG30iGehx9e8avkXYEq3QEBm8rke
	 x8pwzbgU79nJS77MO7yA8h0DHvlYbMyWTU1Nwg5ynVBvPIusdOGxHJ0bzthxfPrmSIU7D
	 iZOROk28Xy0YvaGt1UdpaNtQEYNLklt/EsNfZLyXHE3vdrWNY5fIaT/JswHt/Y+fExXGV
	 G3ajaEQ6MG7o1qJ32KpWFGvvXpAWs6jX2dZl2DvX+HGyh1XFbcOF32gNDBGJvOQXSXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Qh9FFoi/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791025707;
	bh=AEnErtWh7sZlHZdJsgofaVLAib2bAtC9sMrxaPxiuik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDTTq0khZMViRguwb8uV7hNUFzCtQDwCI3BlYTPL1U7YjcQ2XQ9CAE8sBATOvOPFF
	 mUJvCnQusC940hjTu+y2C8rCU3+BbRr7WSDp4nZCrSuwJdJyplQ2l+XL5L0kubKM4o
	 ij+n1F1PL5oQzTtqJGV+hAlV1qJ8V+J9uOczQ6+gU6oo9nGZhwq8DjvPRJ7sLLJ4ja
	 BpykKKiDnwx2Zi8t7zZSm1kJgIRgks10MzxbOZ2ZbvXNGaLf3wzxYBDQOd31UjeEts
	 oJ5sl1ho91OPmZqLR7aBv7f6gGjcbv4OBG98jPKkMkLpoSw2kY6fXKkh+EfFRIxdmP
	 YBRRUfp/CW7Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D56541049;
	Sat,  3 Oct 2026 11:08:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9FB222B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B9F340FFB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Htq9NnVyWP9a for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D22C740FE4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791025687;
 b=OCptBQYZdlAiNn+X3iblNuaK+smX3wD+CPQuM3ftGXy6nMtripzblFRLTqhgLOC4sngH
 lxa69xpHR+bLlNlUwuspLTxu/wPioT8IAobxgnHZ2nTjHYwdD0K5Gn6YWarP553uuaHN8
 HTNqa5mVA5quOVfNeElRU/ymggzCks20CHAdT4ghWXC0zcayC/VaC9DJEOpwJ4C2F/XKI
 OwAHSakgSWdImmYgUgDjygH6eqvv+kxmWBl3fUw7G0ZKnymjUOxeb/edxuhRlA+LHPQLS
 GC/Hn9kplZ0XqHxYCnJzhbL4Ocrlh8BYg8ARb8A8P3QPFVUCTkPTxf0VCUlzlgvkJCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791025687;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=AEnErtWh7sZlHZdJsgofaVLAib2bAtC9sMrxaPxiuik=;
 b=stqAL938GJvGRwkGV0/BrjbkhSbI1hHeqYcqUvCCSvzL/gxap1V8TZ5s/dA65iaXXvIC
 UpeSJZL4nPIraPh6BuDfAqJjHjGf4HXUK2NqPOXuj5R3HHH9WD9I+6l9Ek7HNDD5VDAzF
 XFZGNxmfo3yJ0NRdGl5U+qK+3UP4ndEyUpY8FgeMQiWs7cVMpr60hmSnKAHnG00wEqwi1
 w5S1vc+xltkz92zi+YWeLGb6MyrukhGkoAvygqwFf5bi3kT4y1dyThOGzUWe+F/CTsWMd
 gJpUEmSwpJVnAzzR64nvFaqBD8uQAjVVuku6TM53cbdhC1HopI3wifwquOwBR2exi8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Qh9FFoi/"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qh9FFoi/
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D22C740FE4
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:08:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A959D60A56;
 Sat,  3 Oct 2026 11:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2DB1F0089B;
 Sat,  3 Oct 2026 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791025684;
 bh=AEnErtWh7sZlHZdJsgofaVLAib2bAtC9sMrxaPxiuik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qh9FFoi/7YBEr0Xtb4NAAvo6A8SzJyn2+fWuFMo1hVsjlZ7mVRJROIQbJss8fTaE7
 EMp5/Vao6YLH7p4GeYAk1rarmJhZnEflnyQNgJ9Jsa25U2yb06N5ptCBsvSQ+VmxeF
 FR/q49T2NwSUFUJCIVe8gyCQt5HhvRy69JyUiRZ1+yNIbcVLf0ahVctKhCmW8yOX1I
 ymJY0nMRbhJuVLB55IwQP3BjpTId8vQ20EVnuiofz22jyOOCxuSJ1PP49hJ2110H5V
 17xC9Pg8z5Tku7Fov4l/c/iWbRheOV5tQ8W7MxGXEWIpjtKx9gNDn6r8EaGM93Sg8X
 dipp1UthcUm2Q==
Date: Sat, 3 Oct 2026 11:08:02 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v3 1/4] board: spacemit: add SpacemiT K3 Pico-ITX
Message-ID: <20261003110802-GKB68132@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-1-dea68cd1bd7d@kernel.org>
 <b8a9bb83-7839-4833-8750-1ca55e318f03@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8a9bb83-7839-4833-8750-1ca55e318f03@freeshell.de>
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

Hi E Shattow, 

On 03:02 Sat 03 Oct     , E Shattow wrote:
> Hi Yixun,
> 
..
> > diff --git a/board/spacemit/k3/Kconfig b/board/spacemit/k3/Kconfig
> > new file mode 100644
> > index 00000000000..1a63c73b6bb
> > --- /dev/null
> > +++ b/board/spacemit/k3/Kconfig
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > +
> > +if TARGET_SPACEMIT_K3
> > +
> 
> > +config SYS_BOARD
> > +	default "k3"
> 
> Let's arbitrarily change user-facing SYS_BOARD to "spacemit_k3" stem of
> u-boot config filename "spacemit_k3_defconfig":
> 
> +config SYS_BOARD
> -	default "k3"
> +	default "spacemit_k3"
> 
> The use of SYS_BOARD is compiled-in as various runtime outputs e.g.
> SMBIOS data structure. 
Could you iterate a bit more on this? I've not seen K3 used SMBIOS or will

> I think "spacemit_k3" is not a very interesting
> or descriptive name to communicate all the boards that may be supported,
> but it is better for a user to see this defconfig filename stem than
> simply "k3" as the board name. I do not have any better suggestion
> because it is a compile-time substitution and board selection is likely
> to be at runtime.
> 
I incline to simply keep it as "k3", I've checked all places refer to SYS_BOARD
which all will be used under SYS_VENDOR realm or somehow has connection with it,
so there should be no conflicts, to me, it's kind of redudant to change to
'spacemit_k3', for reference to arch/Kconfig

config SYS_BOARD
        string
        help
          This option should contain the name of the target board.
          If it is set, either board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
          or board/<CONFIG_SYS_BOARD> directory is compiled depending on
          whether CONFIG_SYS_VENDOR is set or not.

          This is optional.  For those targets without the board directory,
          leave this option empty.


On the other hand, I do not see SYS_BOARD should strictly follow
the name of defconfig, various board did so

some other source code I checked

cmd/pxe.c:20:   "default-" CONFIG_SYS_ARCH "-" CONFIG_SYS_SOC "-" CONFIG_SYS_BOARD,
config.mk:29:BOARD := $(CONFIG_SYS_BOARD:"%"=%)
env/Kconfig:20:   the file board/<vendor>/<board>/<SYS_BOARD>.env exists. Otherwise the
include/env_default.h:93:#ifdef CONFIG_SYS_BOARD
tools/buildman/boards.py:194:        'board' : 'SYS_BOARD',

> > +
> > +config SYS_VENDOR
> > +	default "spacemit"
> > +

-- 
Yixun Lan (dlan)
