Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48910C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 01:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526698460E;
	Sat, 27 Jun 2026 03:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="KYoPX+FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A32846DF; Sat, 27 Jun 2026 03:47:37 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D9584105
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 03:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1782524849; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PS2Gn+RaTMmlChGh24vdwhTHhAw5MKdEFUduhrhLNpCqM3joiVUGAu32SZrE9Nqhw4UyyAhxwnaupnAgsDBDtB4H3SHjw0H1sBMgCW9FcwUeL8MYXOA+KFHjWOeoZM/407JhEE1NhWQ8RUAtMGe7WCZM7UOtMv3JUA5KINhkLNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782524849;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bpKQuTrPzYCZsIsL2CqfNIKH4SFeFcXQEmfcwtOAmBQ=; 
 b=NEj73Akv1RQv3nqExq7gmxSqvXRHqw0UoTcOwwOG8t8z69cF4YSvtCWlzCJI/j9258OKGFBrENAfQ7PbGrVYm3E0BGuexxGb/ifnG3bfG5BvmTvO9YZvWgnbJpPlZ6nxW9s5b49wGuSYB5eMFIb/STee8bkumQ2AgIo/RDZ8qoQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782524849; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=bpKQuTrPzYCZsIsL2CqfNIKH4SFeFcXQEmfcwtOAmBQ=;
 b=KYoPX+FMZE/AKX7aHIZa/f90tv5z0sabMT0M2126wQmCrCARZzUJr93gT0z0PWJL
 5BKFmgCgPn+/uCM5bl1+ePYcH1uRexgQphS+h9K4S0i5em+u1U9KKp/CemmFgYqXi2x
 tuJjTiCKrkUKK3hAvnWi9y4iL2tHYifT81USwm8g=
Received: by mx.zohomail.com with SMTPS id 1782524847644613.9085092702866;
 Fri, 26 Jun 2026 18:47:27 -0700 (PDT)
Date: Sat, 27 Jun 2026 01:47:17 +0000
From: Yao Zi <me@ziyao.cc>
To: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>
Cc: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Raymond Mao" <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 4/7] drivers: clk: add support for RPMI clocks
Message-ID: <aj8rpdOireFjteeA@pie>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-5-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626201613.1035208-5-charles.perry@microchip.com>
X-ZohoMailClient: External
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

On Fri, Jun 26, 2026 at 01:15:45PM -0700, Charles Perry wrote:
> The RISC-V Platform Management Interface (RPMI) defines a service group
> for control and monitoring of clocks [1]. This can be exposed as a
> UCLASS_CLK driver.
> 
> [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/clk/Kconfig    |   7 +
>  drivers/clk/Makefile   |   1 +
>  drivers/clk/clk_rpmi.c | 346 +++++++++++++++++++++++++++++++++++++++++
>  include/rpmi_proto.h   |  39 +++++
>  5 files changed, 394 insertions(+)
>  create mode 100644 drivers/clk/clk_rpmi.c

...

> diff --git a/drivers/clk/clk_rpmi.c b/drivers/clk/clk_rpmi.c
> new file mode 100644
> index 000000000000..d2efb057600b
> --- /dev/null
> +++ b/drivers/clk/clk_rpmi.c
> @@ -0,0 +1,346 @@

...

> +struct rpmi_clk_def {
> +	u32 num_rates;
> +	u32 transition_latency;

rpmi_clk_def.transition_latency only gets assigned in
rpmi_clk_get_attrs() and never used. Since U-Boot's clock infrastructure
doesn't care about it at all, maybe we could drop the field?

> +	enum rpmi_clock_type type;
> +	char name[RPMI_CLK_NAME_LEN + 1];
> +};

...

> +static int _rpmi_clk_enable_disable(struct rpmi_clk_priv *priv, u32 clkid,
> +				    bool ena)
> +{
> +	struct rpmi_set_config_tx tx = {
> +		.clkid = cpu_to_le32(clkid),
> +		.config = cpu_to_le32(ena ? RPMI_CLK_STATE_ENABLED :
> +					    RPMI_CLK_STATE_DISABLED),
> +	};
> +	__le32 rx;
> +	int ret, status;
> +
> +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_CONFIG, &tx,
> +				  sizeof(tx), &rx, sizeof(rx), NULL);
> +	if (ret)
> +		return ret;
> +
> +	status = le32_to_cpu(rx);
> +	if (status)
> +		return rpmi_to_linux_error(status);
> +
> +	return 0;

Please return rpmi_to_linux_error(status) and drop the if above.

> +}
> +
> +static ulong _rpmi_clk_get_rate(struct rpmi_clk_priv *priv, u32 clkid)
> +{
> +	__le32 tx = cpu_to_le32(clkid);
> +	struct rpmi_get_rate_rx rx;
> +	int ret, status;
> +
> +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_GET_RATE, &tx,
> +				  sizeof(tx), &rx, sizeof(rx), NULL);
> +	if (ret)
> +		return ret;
> +
> +	status = le32_to_cpu(rx.status);
> +	if (status)
> +		return rpmi_to_linux_error(status);
> +
> +	return (((u64)(le32_to_cpu(rx.hi)) << 32) | (u32)(le32_to_cpu(rx.lo)));
> +}

...

> +static int _rpmi_clk_set_rate(struct rpmi_clk_priv *priv, u32 clkid,
> +			      unsigned long rate)

This function is declared to return int, but...

> +{
> +	struct rpmi_set_rate_tx tx = {
> +		.clkid = cpu_to_le32(clkid),
> +		.flags = 0,
> +		.lo = cpu_to_le32(lower_32_bits(rate)),
> +		.hi = cpu_to_le32(upper_32_bits(rate)),
> +	};
> +	__le32 rx;
> +	int ret, status;
> +
> +	ret = rpmi_send_with_resp(&priv->chan, RPMI_CLK_SRV_SET_RATE, &tx,
> +				  sizeof(tx), &rx, sizeof(rx), NULL);
> +	if (ret)
> +		return ret;
> +
> +	status = le32_to_cpu(rx);
> +	if (status)
> +		return rpmi_to_linux_error(status);
> +
> +	return _rpmi_clk_get_rate(priv, clkid);

_rpmi_clk_get_rate() returns ulong. This unnecessarily truncates the
rate on 64bit platform when it's above approximately 2.1GHz.

> +}

Regards,
Yao Zi
