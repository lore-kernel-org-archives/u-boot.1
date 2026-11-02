Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016B606D837
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XdSTlynp;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=Sps0bw4f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB6B38108A;
	Mon,  2 Nov 2026 15:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVDMXmVGGawQ; Mon,  2 Nov 2026 15:12:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06F7F8107E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793632329;
	b=VuUzxY4ZIHidsb4Yrb+KDv2sKFRfTB9nF7u0HAWJz+KqauZJagY/UHLCkUnkxAN81EzZ
	 QzE1Ds246U9gAYHqjukNuPz3NaSVpuCRP6vgfnK4elhNn8Upw7Vtpfa14csCFTvGx43TT
	 tgjUPqtJ/tX9LMB4UJSt4odE9hYrHfOje7+Qs0SNIp6xUfUqvEVDy9U7vDRg4xDNmuqsU
	 QhKHmJFr/hlpza+Nl1MjLXZsNdZMxnXBv/3RzybpBJ19vDDl+hbEgnppSMWkdGy6y6Gnf
	 CZoJSgsuBEDKNyKZ6tk5cV/xyWRfvN5tpeRTQOr59ESnAdw/jWwydgUQ/9QTp8mdbJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793632329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v8EITG/gbMhTwbJrL23z+U7no34Fdogq6kQMWWoHEFs=;
	b=ncmwcq/oit5QXzGz3Ekpqlphrz1YMu99D+THKqbSV16o177JmCI+DmCKaGekoJA6K/y8
	 n1bD610yIKRZCXoswLzIUf4BZ6Vi3BhXOSVU+lgBXdmpgk5VqzkOk7Tg0lxsQmq41VEnp
	 6ryYD1bzFT8pgdVskO+j89LzaPTnD9kNAyWbkMipJeaeZL18hthjxVX3K4XZoThzIPlP5
	 RIUIefOd/lkNnd2B2/SpmOagKOPnFkbjzqr0s3IPN3RXRvhrg3kBsrAbP/xybnampOPDW
	 vJF7OkZIBOzOwWWN3gOQfRJ969OW5WnMm6xI7195WAfqWc5iH4Ue9njsf7fVkGlg+bA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793632329;
	bh=v8EITG/gbMhTwbJrL23z+U7no34Fdogq6kQMWWoHEFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XdSTlynpssGIfyNH4TsVnuJtKheAO5uK9NcOxryddHgAUz8/saJfrZ9oXmRVbn7bl
	 2NmWQilKftUeLjvGBOL/biPvj5miiyuU0AgBByyho6bu4o3UnxJeaSiP2eCPlGGKpV
	 RWWAk0irPM4oy5GASJHSW0+fUR/3zptGTmZDte8vobZtY/54y4mxbJWNus+vrf3QVt
	 qPLyYCh+Y93ac+7QMGWMVsygWvxxBPXIdzJcIa1I4ZJHfC72qHp6aRhB/BJgeuY3YB
	 RUurE2NIN1IOTZfnEIgxFY+RB31i0kWcyMiI+RAKQ/3VPp3Mndl8Ngw7KOiqM+MHXW
	 GK5AOUThNqPSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F7F8107E;
	Mon,  2 Nov 2026 15:12:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76291411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67864406D4
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dcj18a2RZJht for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46986406C2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793632326;
 b=erFosYu6bTr9HVmUoLjsxMsUTAlrIHdFAMHXI5Cf5UWMeoCH4zVCOwLcALDUUGWz9JWZ
 PmOgix0flnVZZOE5n5qu8ihwBC092osZODQ65BFuqWBzeVJ9tERTVc5Oi4yTX663duIN+
 ByOOluxCOroqsEOP45CEZa0a/SYALSbYajv4dnixRJ9rJuluejDtkxMR+kxUVyEs6TDgz
 cSIoGzLWGQGMIeOvDw9A8sUQUmhxIP/kW+vblPoTB7rqliKxq+MCAU5rBg4h3oYPGom14
 4sDQ4Ei7+m5FDKyOX0bSIIMmmR6IcsM+ivKLDRBKnsgLKPqMmTrFgdoqfls9RWEUTJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793632326;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=v8EITG/gbMhTwbJrL23z+U7no34Fdogq6kQMWWoHEFs=;
 b=Xtdqnht0gvnLDLk76Ojhic0bX1eNSU7qWCk9Zl/Usf5Ea2LLM4eI3mCKVchnUO/Z6V+f
 bt2Ol0yqNZ2kgKOcgDqa4w2C0YCzp+qvNWQc4XN2lKKDRsCpHj3SjCb+ObnIfjsutXmS2
 ahl3RVODoDomhBcxeYDPXjkmcNe3SfwNRsMPXkEPrNSQXQuGTw7P6l6ZXmO2Z8KF4aneb
 ozluZ5jbJenbhNIsRywqcVoGKOrcsrABRdtmTJwPtXBRrQSTZJPTGVvCIkxOcZKKyFKHR
 oE9qvhGwHaCgwyVLssTuFfxbtS6Kn3VAzgUoXWRJ36LfqxxFBMjJdz7swVL8SDmZimw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sifive.com;
 dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Sps0bw4f; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=Sps0bw4f
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46986406C2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:12:05 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ac6794fe45so2305134a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793632325; x=1794237125;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v8EITG/gbMhTwbJrL23z+U7no34Fdogq6kQMWWoHEFs=;
 b=Sps0bw4fH6klxa8Hch2sjmGfoSYVBg0Krdi6JhVsKt41Sj8lDT0tjzqXYD+q2REZN1
 rliK7ya/VjvPddmrgpDUF8evJcOtOv8VvfU+OGWHomdkyxtf0fzV+GqoT+F4V7+t2Sjw
 Trnv4Gh7O/jHr7Hm5vdljQJk7qehWbvzutdtGlDpgxYdJzlj5ThXP2LMU88o5HND1sA8
 /pc/+UcrclUg0svpjnvdRwOI37Ti+xgYXllTREExE4Cy4AMJW8BQe9cBLTARuyp4pVwd
 /OH0GGvLIfZG0xYPi7jHKQpNS79h0S8Y43mTZrmiInGI/At1/tFeZF0hRuTutv3pxFPh
 BnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793632325; x=1794237125;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v8EITG/gbMhTwbJrL23z+U7no34Fdogq6kQMWWoHEFs=;
 b=yfOY9JiNO6I+iCxbVCenOkbp5VmZGoqdbEcxIdgKkYcg3FEHZZaA4uj8N1v6aqrHgP
 hlboYcypWjMvt06sZ06s1tUVN1IpddhIJZLvb7KOVUSTm8Qr6C0NTg32hTUTC0QpB4JL
 oU04oKDonuLgt0zYtXIcpHVrzPCbYGl29msOa0AXdhBNwhPif2O/PfYv8Pw6FAPmqc/8
 6qxXvtPJ+QMjSTXUaYRPnHIaIgRszygmkUIKIrdjpvgJRokknTg9JgKROknHi18JSTbp
 ilADRNcJ7pPiUCLcw8xtX10krrquWkRpuA57oiSz/zq6kmJUzYXdzmTAgGUFZ/sndQ+t
 JIXQ==
X-Gm-Message-State: APuU4Z96G0/av6zIBeR9X9jpAGE0/oJidMp8No6NSlpX0J5kq1ciurcm
 SUwCvo6DgFhgw5K1JmR13yTcvbVVleBr9uHqyg6R02RoHftBztacOjfYokha5HnWKQeKWO7f3Xk
 DclXqC9w=
X-Gm-Gg: AYBFou0+bbIalZUNkU/1WkblLd9HdgbIevqcLlc2s02a6gacbewKjwdMFxhL4eg+9sE
 91rK63q6RxiyRYl0usoFAJ66t9r30QQaqo427ohhvZxLdnVF6KC2csrmqE24OWNm3MXinCzxrsu
 rQnV9ld+wYxwNVOA62GCOVOSfnN6nsgVp4YNi4w+KzDg0s7yGcbZ/FDqN+axwSyROiPQM3XwbyR
 l8lWQzlSHdJurpQFty4lfKl/mRybB/MNJH849SA4Jz1AFe2am01muUfCvwl1PY9KnbhEgFUOT+J
 50+r1mXdMbtw84q/BrySYTC9NrZrp3lmNfmGII7HQtFZfWe/vZbmS6K24uQgFMXjZmPl9uSVEDT
 DurAIcGycUm51eZyfj2v5KuPNCwcBzXeXj2xf99m0oEG2jcFHyfKaBftEAlahSmJ/RpHTFkPDNX
 cOQt1sak+rJD7GDG0p1PAwzWtVAZ3qbwjG86jizWU3lopaByRDhJ3KDsVwXcCMUMtwNcKONmPra
 7DPufN6HZbdsRi9GeijIcZk1ESDSeA6Dv5MZ44lsbiTxQHQPYRdyRSDrqvkOUuemDYpm9Yu5R2X
 CogkooBo4I9cxY5y9zEvBqoNH10qylXWT30HC3kzTDzb
X-Received: by 2002:a17:90b:53ce:b0:3ad:6090:a190 with SMTP id
 98e67ed59e1d1-3ae89817b01mr8621576a91.41.1793632324816; 
 Mon, 02 Nov 2026 07:12:04 -0800 (PST)
Received: from lliang-1876.localdomain ([136.226.240.173])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85e4ff4csm9294864a91.1.2026.11.02.07.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:12:03 -0800 (PST)
Date: Mon, 2 Nov 2026 23:11:57 +0800
From: Leo Liang <leo.liang@sifive.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Conor Dooley <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 4/8] drivers: clk: add support for RPMI clocks
Message-ID: <auioPabD3tEPCMQV@lliang-1876.localdomain>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-4-d53d34a49780@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-rpmi_v4-v4-4-d53d34a49780@microchip.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 10:17:08AM -0400, Charles Perry wrote:
> The RISC-V Platform Management Interface (RPMI) defines a service group
> for control and monitoring of clocks [1]. This can be exposed as a
> UCLASS_CLK driver.
> 
> [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v4: None
> Changes in v3: None
> 
> Changes in v2: (from Yao Zi review)
>  - Reorder headers
>  - Don't null check pointers before free()
>  - Remove transition_latency from struct rpmi_clk_def as its unused
>  - Simplify last return path of _rpmi_clk_enable_disable()
>  - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
>    rpmi_clk_set_rate()
> ---
>  MAINTAINERS            |   1 +
>  drivers/clk/Kconfig    |   7 +
>  drivers/clk/Makefile   |   1 +
>  drivers/clk/clk_rpmi.c | 344 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/rpmi_proto.h   |  39 ++++++
>  5 files changed, 392 insertions(+)
> 
> ...
>
> +config CLK_RPMI
> +	bool "Enable RPMI clock driver"
> +	depends on CLK && RPMI_FIRMWARE
> +	help
> +	  Enable this option if you want to support clock devices exposed
> +	  by RISC-V Platform Management Interface (RPMI).
> +
>  config SANDBOX_CLK_CCF
>  	bool "Sandbox Common Clock Framework [CCF] support"
>  	depends on SANDBOX
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 4b241a9240ac..9e19e6f6d845 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
>  obj-$(CONFIG_CLK_QCOM) += qcom/
>  obj-$(CONFIG_CLK_RENESAS) += renesas/
>  obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
> +obj-$(CONFIG_CLK_RPMI) += clk_rpmi.o

Should we add $(PHASE_) as well, otherwise, the platform that uses
SPL and CLK_RPMI could fail to link with the rpmi_uclass.c API.

>  obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
>  obj-$(CONFIG_CLK_SIFIVE) += sifive/
>  obj-$(CONFIG_CLK_SOPHGO) += sophgo/
>
> ...
>

Best regards,
Leo
