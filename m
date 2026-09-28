Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27068CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 23:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4EEC40508;
	Mon, 28 Sep 2026 23:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kFIzNtHKWf3; Mon, 28 Sep 2026 23:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0A3BE40509
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790636496;
	b=mg6p4U+lTX6+bUnFKIKDSzlDeQcJGVKKyifKvSWjJQU7GsReIyUt3RpmviQqasVCdceb
	 TFo3Jpp+HzrqHr2SGmBcTfBDCUNdNPwmdcUwj93tKpZnXH/WI91RBoilXIsGMzWv6p/Lj
	 Vgcy87W0hwPjCn5B6PuADE0aJKFJ1KZ4/2t12PIimmgFZvZmiz+h1MmioXsKlOWldOfa9
	 ZBXxLNppgJJPVy/11R7FVg5Cd5kVoOtiHfBWsrynMbxZjh+SWMe2GwcdMACcTsWAJ152I
	 xa92GqpeM405OKkn/34kRqJ2DfPhSB8p+wdwKmwcrdpV88snjEB/PIZ0uCKWXNZATVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790636496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5RD+TmI+9ZiBZRH3wBgwMgsFYNc1SHYPrm4T6UNUuCo=;
	b=RLACKiF3d3qNojw1TzpZNc/VEIRMPJlcKHu+T6Lgb4Mr+yEIU2roOl2GDKLw+RJiS1LM
	 OqXyHsLQ+XBE55CBSBrzKAlrRAq6gMuwaXYB7nGpSvCWO0IZytZ4dCDGOU9WVIUBv+91m
	 OG+nzwbkMlGNiqzl/FDcAsvHwHOkIVfY2vVyCpGYsYP+z+2K7Ta8rbRn0MfLq2at5faLH
	 i1mMCKuUJL6/lFh6+NUyi1rCkTBxK3NT72mEDvkAOIOyTVUypTzaxlchA1qWDpVL+eynT
	 FFr1CM+whG1G6kcoNBKCqreJ/CMV+P7AQsQxaLBM749pWJ55ZoIlTCsMVR6WRzM3b4A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790636496;
	bh=5RD+TmI+9ZiBZRH3wBgwMgsFYNc1SHYPrm4T6UNUuCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UkPY6VKTS72W4ZwRAYNnBpZDAC23Ds+p0mOycXgaTHJRLWsWzxitbhzRqUoIMr+iM
	 i8s62VtAz/ZlCjf0VkqOertfSSNQVaHDsNtbaxIDnyOauMlayVPieFxJQgjyCLNJcX
	 M+V8jB6AQ8zAuxoh9DKxsk2oeAoFR1ZHBdkYfm01LbryLSh8bq4rIPlyW+/VG/ST/K
	 yF0klEfsh/lsIc7EAh1sQ+MAG8vjuzyIUFw2gQq+VuiVuTRtK+AOruPvQhxpkldf3B
	 Yn45eHZz5l/1ndAQE8RnH3tOuxzEu6B/k0ZOY59NX5+DTnoxR5SrodcspH42fCfsHI
	 IMcGei3iEKU9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A3BE40509;
	Mon, 28 Sep 2026 23:01:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB348335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBCB580AB2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRY6E6Tpt3FF for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DDA7980A84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635731;
 b=K/3iatrN+nz85/sk+v4+q450BLQy82GQ+AbFl9vRUxRqUVGZKpvRj4Kqy/l0BPsHfJTr
 r1qf45PtRs7GQ3luRguOjXm43RHsoNg543enqyEQ6pKquRVz65SvsNHj7Dzj/jOA2SWNU
 gQ4uEGHy9Gncz4BHAXBun01ZkVl23H5KEoItWhaeqic4ZbV5WKp9r2UXDpTKBBxCr1l4m
 AiLMoSqNGJ7UFCxHJAyxRYIPiXs0y5V981bZqzFo1ANRe82ZCmRUMj3gUrFL1RSFRm+Q3
 6Qo50PymU+RXreKdjYu8xY9qw6e8EvYEPRdJCXD7TaivvKx15zh4W/hEJgetZvv3Ukw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635731;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=5RD+TmI+9ZiBZRH3wBgwMgsFYNc1SHYPrm4T6UNUuCo=;
 b=nE5IcqMq6F1kO5vx1u0gX1C46vTFOlkDGbnemW5dT5L0bvV2mMHN2ypdsTAXXnsKYRpu
 hsclHXNsuD3VF87kHwiqDgXVxD9OaJ60R2SZTgnEkv6i11h8ETZtYIjws/q8NU5lCvPaO
 jArIZyoKKbmNohZ2G5YK233S+p/g8VygO8bnKSyO6eps8w5MawTTI+LNeIoEBg6TvUFUa
 xLq14d6CuSK+9ct6O6JGeAe+xsRT7inXU0nbcSuqk/4GDt09Rh+tZOzUDz6J7onGGR1v7
 NtU/UoCMmmGaoenbcN8GGxjHgCqUMttTdcy2kCO61cMS3v4DIVe0PAKPS8kCcZ4HXLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bdqtFk9c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=bdqtFk9c
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDA7980A84
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790635672; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N4/8t9ut9+74A360daXWa6UEnOH3MmgFtKeGyDJUBZpXHcXcIVLbpfL0OmM1ZQ3LXv4Sgc9/jejlTZIa+SvRpNhx607yp49MAKaSk8vt3ECP0l/iP169/4oKlW66rcRufG2phkmKNKgaB6AvyC13Rp/ekQWY72dYcBf6cVoJP1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790635672;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5RD+TmI+9ZiBZRH3wBgwMgsFYNc1SHYPrm4T6UNUuCo=; 
 b=f/g7FQZUZJl0v/cn0YjEww4tadDNuO1hfHa6IsOPvCa7h9YdFww1G4vvMIi9v/w2LMM+0uXVZlpIFCWrzvU5X+9kuHyTskLfjpsSHyMpl04+6Fqy9YOQFoF9f2B5oi9oECZNxQfPllzzl8JtRR7E5kzE4YrmrnWK//LWVmUvhgg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790635672; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=5RD+TmI+9ZiBZRH3wBgwMgsFYNc1SHYPrm4T6UNUuCo=;
 b=bdqtFk9cVcdFapvJif8oc7TtyWYblfYzbM6Vqyv57xjPYbhs7Z9+9kLGgPHjNbZo
 9WDnBOb3HkodfUvI8RqOouYOvwkiL2KMgWroeuW9YdzcVcUqHZeFJgNT8txzCllIVsg
 sxpaQjffOS4eLuX8vV+DYbcEKPdA8IDsHHRHmwCw=
Received: by smtp.zohomail.com with SMTPS id 179063567029596.004197775541;
 Mon, 28 Sep 2026 15:47:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 22:47:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>, u-boot@lists.u-boot-project.org,
 Chao Wei <chao.wei@sophgo.com>,
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>,
 Inochi Amaoto <inochiama@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH v5 00/10] riscv: sophgo: Use upstream devicetrees for
 CV18xx boards
Message-ID: <arrui6gzqAuzk0qC@pie>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.626.26
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 28 Sep 2026 23:01:33 +0000
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

On Sun, Sep 27, 2026 at 08:08:55PM +0800, Zhuxu Ran wrote:
> Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano currently use local
> devicetrees under arch/riscv/dts. Equivalent descriptions are available
> upstream, but Milk-V Duo 256M support has not yet reached U-Boot's
> dts/upstream tree.
> 
> Import the upstream changes required for Milk-V Duo 256M and enable
> CONFIG_OF_UPSTREAM for all three boards. Add the clock and SDHCI
> compatible strings needed by the upstream devicetrees.
> 
> U-Boot-specific overrides retain Ethernet and SPI NOR support on Milk-V
> Duo, and Ethernet support on Milk-V Duo 256M with its optional IO board.
> Enable the MDIO mux support required by the Duo 256M Ethernet topology.
> 
> With all local users converted, remove the local CV18xx devicetrees and
> the legacy "sophgo,cv1800-clk" clock compatible string.
> 
> Tested on Milk-V Duo, Milk-V Duo 256M, and LicheeRV Nano. Build-tested
> for all three boards with the riscv64-linux-gnu cross compiler.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>

For the series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
