Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74487CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 14:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62CA83EF9;
	Wed,  3 Jun 2026 16:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cY3EUvzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C493983FF5; Wed,  3 Jun 2026 16:05:35 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6A7839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so543966066b.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780495532; x=1781100332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ndlcCQ1cJbzirkTazt8OSUL+4dJL0qmOqpvvTAfhLSg=;
 b=cY3EUvzz5zv1kfFFfMrwxu4a4Z5O2L4EtJqMXtJI/OyA0e1qFe7o+7pomj+AN0gOgr
 DD4yWIKOx3p8j6SOQLKoyZQwTkXo+pguUjIvG8NRjNsUqh/V5GV72ljdyFSXpIv/CTi6
 3PBSYqgHvBdRD3aGbN7LPdzsrHQYb8E/u/sX24b+7tWcNSY9NQ+xQtwYgYAFAVY6PsqT
 5oaZy/vtJ9/03vXZubN3YtOJGkN1ZPhNxCT8lkPtz0oujfCCToSjFBPKP1P6VNtW86kW
 Nvb7r+9fRi22xVhtGBmet9XKXcml+0snk3dam5mnJmb2JTMyubNY+4gPd1Hmh1jX+TKY
 B5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780495532; x=1781100332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndlcCQ1cJbzirkTazt8OSUL+4dJL0qmOqpvvTAfhLSg=;
 b=s9M3fL6g0FgR9sa1dOAQ0aQQWRjV+B5ovCnmMhT+wKhSMWHD/MzwezLV0V8FXhIT0O
 mZQz9ZF4AHRyFLeeSmgModYJ6pVfoqUnYuKmqIN3jYwPZhZi6vH4NK6SdEGtHsVVSjmu
 TN/m5Ilw0OkUXqsnQPSHG8QmZZau/GlXU1Ghrg5py9zcPl/9s+GKc6vGDkC0VRjXNh4k
 Wosaz0KUZopexyMkNS2ppNvoIBlAzVltTZpa6hStuVMe5KBK0nPfaDl2s/zrm0edA880
 Xspm53v1gvBvyAg3ri7qgxh2nGp5JceZb4UgQXHaAq4KD7LDvUx5KgrkvECCN98uh2iy
 V3Jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pZFWgNzkTfmsr9T3TfByRYu8+lzUAb9vqUi0V93HfVIfS0spfUT6R0Sn3JKb0kYrnt4D7+30=@lists.denx.de
X-Gm-Message-State: AOJu0YzVGX4ZlUBicu0lpvofjH0FY9jFmA4XH94OgHOyeKMZ2SKnMwO8
 y/41a0N9pZuoZksBqLro+lEkH4irdYWJ2fHLy8+UUbXZuBfzsZ9LUvi5Jwb/Mr5F6XQ=
X-Gm-Gg: Acq92OGk7gEUQhQTFjUDyzVwZor3IyF0CsDwW6jQXnVjORtX52HQv/QhE9AzKVAE8QJ
 zK7zJvKlEVSw8X+3HZl49eOZv6A0bwrDj9BA252d0LO06Dgk7pnJ/rarFPlOb+CKOmPdPAlJ2ot
 fVLny4BTN5IcAaqn2Ban3vMnQGK6X+gjoxJ6l212nWkY8xnp6+BUGJMY+/Vy/Tn4rSipn5nerJc
 H6bP2CfkvcyEceOThCRlYYsTBsaVh+giyvF2klKiId8HL2EzepY18kgZ0GNlZrkJ3OhVdh9dBow
 iTTnBv09GACJyjq1WkxrpzeSpnPBcJ9LPv19CcYj8OXs9ETvLTjz2mjye2tTn7diDL52+hPs8zl
 2EW57oM1yuum+pCk5F1jcr0756kL/2k50WEqGsDhP5Etud8ZCtBLEoRi1Wc2N5Dzd3/3vYuK/ld
 +jr7vIGuhdBCdCVWu7xPXxYw8qvXP5u+oMOs0IYnZ6VonvqA==
X-Received: by 2002:a17:907:1998:b0:bed:d329:1ed9 with SMTP id
 a640c23a62f3a-bf0ae9fa460mr198628266b.33.1780495532208; 
 Wed, 03 Jun 2026 07:05:32 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff23:4410:d5ad:2604:b045:5b80])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm168400566b.26.2026.06.03.07.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:05:31 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:05:26 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: me@samcday.com
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 4/6] mach-snapdragon: fixup CPUs with PSCI enable-method
Message-ID: <aiA0pq_ty1RVwZ6N@linaro.org>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
 <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-msm8916-smp-support-v2-4-792e53dac374@samcday.com>
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

On Tue, Jun 02, 2026 at 05:19:00PM +1000, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> If there's no PSCI implementation, then change the enable-method of all
> CPUs from "psci" to "spin-table". Later, when spin_table_update_dt runs,
> it will further patch the CPU nodes with the necessary cpu-release-addr.
> 
> This new fixup is only applied when CONFIG_ARMV8_SPIN_TABLE is enabled,
> since that also determines whether spin_table_update_dt runs.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..3b08069af98 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -183,7 +183,9 @@ static void show_psci_version(void)
>  static void qcom_psci_fixup(void *fdt)
>  {
>  	int offset, ret;
> +	uint reg;
>  	struct arm_smccc_res res;
> +	const char *prop;
>  
>  	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>  
> @@ -198,6 +200,45 @@ static void qcom_psci_fixup(void *fdt)
>  	ret = fdt_del_node(fdt, offset);
>  	if (ret)
>  		log_err("Failed to delete /psci node: %d\n", ret);
> +
> +	if (!CONFIG_IS_ENABLED(ARMV8_SPIN_TABLE))
> +		return;
> +
> +	/* If spin-table support is enabled, make sure any CPU nodes with a
> +	 * PSCI enable-method are updated to spin-table. Further, any PSCI
> +	 * power-domains properties are removed.
> +	 */
> +
> +	offset = fdt_path_offset(fdt, "/cpus");
> +	if (offset < 0)
> +		return;
> +
> +	for (offset = fdt_first_subnode(fdt, offset);
> +	     offset >= 0;
> +	     offset = fdt_next_subnode(fdt, offset)) {

fdt_for_each_subnode()?

> +		prop = fdt_getprop(fdt, offset, "device_type", NULL);
> +		if (!prop || strcmp(prop, "cpu"))
> +			continue;
> +
> +		prop = fdt_getprop(fdt, offset, "enable-method", NULL);
> +		if (!prop || strcmp(prop, "psci"))
> +			continue;
> +
> +		reg = fdtdec_get_uint(fdt, offset, "reg", 0);
> +		ret = fdt_setprop_string(fdt, offset,
> +					 "enable-method", "spin-table");
> +		if (ret)
> +			log_err("Failed to set CPU%d enable-method to 'spin-table', this CPU will not be available to booted OS! %d\n",
> +				reg, ret);
> +
> +		log_info("Patched CPU%d enable-method to 'spin-table'\n", reg);
> +
> +		prop = fdt_getprop(fdt, offset, "power-domain-names", NULL);
> +		if (prop && !strcmp(prop, "psci")) {
> +			fdt_delprop(fdt, offset, "power-domains");
> +			fdt_delprop(fdt, offset, "power-domain-names");
> +		}

So what if there is more than one power domains assigned and only one of
them is "psci"? (I had this at some point in a draft for full cpufreq
support for MSM8916)

I guess it makes sense deleting the "psci" power domain, since the
"idle-states" modification lk2nd does depends on some non-upstream
functionality in the msm8916-mainline/linux fork. But then it should
ideally look at the names more carefully somehow.

Thanks,
Stephan
