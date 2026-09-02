Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D10C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 09:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D140980DCF;
	Wed,  2 Sep 2026 09:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtLmKhQj6vM3; Wed,  2 Sep 2026 09:56:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788343009;
	bh=QiMmeAMU6r3PQafiw4wF1IjYtDo5ykUydqgb2h+ySps=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TaK+lRiWkbIZw5pZFLuk2E8ptpmRZzvl3j7w99VB9kWNi/i/SV/IRxi/nhgpKk/nt
	 6g/ofSNPo2pJpW12hoa3WfXZIepHobFYHzmjQRkCMWoQIqbEylAqXnACTpxasC0fRQ
	 W/YA6EGzzidEhZ6vNL2zThmODgMd/312lY0BLEpKuxXiOgRmP4InYIsRRATC6fiLFt
	 DSM33L4xghnsGc5xSzPs+I0hx7SQDLA9+nPDGSkl90AR5wiflJk8mKWYfJRdJVsSod
	 DFFbregEIVsPlxV7ZuKwknHxzvHpyn+nwAu2RyVhz6fEYRJSY25eICjAmaEAx/HE9l
	 c4nCL2E6AtW3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49EEA80E1C;
	Wed,  2 Sep 2026 09:56:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71D3A363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F4AC40A2D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_nHZX026anT for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 09:56:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=tim609@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95D1040A2C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:56:40 +0000 (UTC)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 6829tX54074367
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 17:55:33 +0800 (+08)
 (envelope-from tim609@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 2 Sep
 2026 17:55:33 +0800
Received: from swlinux01 (10.0.15.55) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Sep
 2026 17:55:32 +0800
Date: Wed, 2 Sep 2026 17:55:24 +0800
From: Tim Ouyang <tim609@andestech.com>
To: Yixun Lan <dlan@kernel.org>
CC: <u-boot@lists.u-boot-project.org>, <spacemit@lists.linux.dev>,
 <u-boot-spacemit@groups.io>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>, Raymond Mao
 <raymond.mao@riscstar.com>, Guodong Xu <guodong.xu@oss.qualcomm.com>, "Peng
 Fan" <peng.fan@nxp.com>, Torsten Duwe <duwe@suse.de>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov
 <alchark@flipper.net>, <oyst.lnx@gmail.com>
Subject: Re: [PATCH 6/8] clk: spacemit: k3: reduce clock tree for SPL build
Message-ID: <shthcaz5wjcp2vwd2c2i74axiayf4zhlgsoq5fbswofld5poq4@znfx5b2yby2t>
User-Agent: Mutt/2.2.12 (2023-09-09)
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
 <20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org>
X-Originating-IP: [10.0.15.55]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 6829tX54074367
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

On Tue, Aug 25, 2026 at 04:24:16AM +0000, Yixun Lan wrote:
> Due to SPL image running in a memory space constraint SRAM environment,
> so reduce the whole clock tree a bit to make it fit for final runtime
> requirement, only a subset clock tree is registered, which includes UART,
> SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
> full clock tree is retained in non-SPL build.
>
> Where surviving SPL CCU definitions reference parent clocks outside
> that subset tree, it will use "clock-dummy" as name of clock parent to
> ensure the framework still successfully resolves the parent clock lookup.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---

[...]

>  /* APMU clocks start */
> +#if IS_ENABLED(CONFIG_SPL_BUILD)
> +static const char * const axi_clk_parents[] = {
> +       "pll1_d8_307p2", "pll1_d6_409p6",
> +};
> +CCU_MUX_DIV_FC_DEFINE(CLK_APMU_AXICLK, axi_clk, axi_clk,
> +                     axi_clk_parents, ARRAY_SIZE(axi_clk_parents),
> +                     APMU_ACLK_CLK_CTRL, APMU_ACLK_CLK_CTRL, 1, 2,
> +                     BIT(4), 0, 1, 0);
> +#else
>  static const char * const axi_clk_parents[] = {
>         "pll1_d8_307p2", "pll1_d6_409p6",
>  };

The SPL clock subset does not seem to include all the clocks described
in the commit message. For example, the SDH0/1/2 clocks are excluded
from the SPL build.

Is this intentional?
--
Best regards,
Tim Ouyang
