Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE31FED2DD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1348A83F9A;
	Thu, 12 Mar 2026 08:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VUIrCJmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499B483F9A; Thu, 12 Mar 2026 08:48:59 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108BF83F8A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CDA0443C4;
 Thu, 12 Mar 2026 07:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F65BC4CEF7;
 Thu, 12 Mar 2026 07:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773301735;
 bh=89qc0wP6tlBz9nzzArt0XTidQJdfWoRBtkJIFe5vfLU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VUIrCJmDnsRwsa8fGQIvqdRV4rzcWwJpSNeNtBIruOd1rCm9YKAFDQfpiQgMzz4hr
 +KjvlJMs6B5yXat4hh+KC1Qy2e4+zGgT03zNqzzRaQx7rD6axmZWcM0GDe96n6fZsn
 m4jOM4mqPLQicMli9uRu4xUMTRxGgOREhRB+wlxPuGDk02qyBTP44/m/ZLJokasnzP
 qPm/CGr3/K7KZtXiH5EKLIsXvraXd1CLoGyhRddczxVAmO95gFO7cRw/bHD7PDpOQS
 EWLApY8njxgNyYuXiN5OAg33LaehlfiZ9UGl0Cmaw2pvYtrVygSAiYOODWSBAwqR+K
 nyGrFvdrXzuUA==
Date: Thu, 12 Mar 2026 13:18:46 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>
Subject: Re: [PATCH 4/7] regulator: qcom-rpmh-regulator: add support for
 PM7550 regulators
Message-ID: <abJv3hHkspjvsplW@sumit-xelite>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
 <20260311-milos-bringup-v1-4-eb905c467f10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-milos-bringup-v1-4-eb905c467f10@fairphone.com>
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

On Wed, Mar 11, 2026 at 03:20:44PM +0100, Luca Weiss wrote:
> Add the PM7550 regulator data found on Qualcomm Milos devices.
> The tables are imported from the Linux driver. The SMPS regulators were
> not added now.

Extend commit message with Linux tag/commit for the imported tables,
with that:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/power/regulator/qcom-rpmh-regulator.c | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 3f0f1845469..4d65aae1690 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -640,6 +640,35 @@ static const struct rpmh_vreg_init_data pm6150l_vreg_data[] = {
>  	{}
>  };
>  
> +static const struct rpmh_vreg_init_data pm7550_vreg_data[] = {
> +	/* smps1 - smps6 are not added to u-boot yet */
> +	RPMH_VREG("ldo1",  "ldo%s1",  &pmic5_nldo515,      "vdd-l1"),
> +	RPMH_VREG("ldo2",  "ldo%s2",  &pmic5_nldo515,      "vdd-l2-l3"),
> +	RPMH_VREG("ldo3",  "ldo%s3",  &pmic5_nldo515,      "vdd-l2-l3"),
> +	RPMH_VREG("ldo4",  "ldo%s4",  &pmic5_nldo515,      "vdd-l4-l5"),
> +	RPMH_VREG("ldo5",  "ldo%s5",  &pmic5_nldo515,      "vdd-l4-l5"),
> +	RPMH_VREG("ldo6",  "ldo%s6",  &pmic5_nldo515,      "vdd-l6"),
> +	RPMH_VREG("ldo7",  "ldo%s7",  &pmic5_nldo515,      "vdd-l7"),
> +	RPMH_VREG("ldo8",  "ldo%s8",  &pmic5_nldo515,      "vdd-l8"),
> +	RPMH_VREG("ldo9",  "ldo%s9",  &pmic5_nldo515,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo10", "ldo%s10", &pmic5_nldo515,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo11", "ldo%s11", &pmic5_nldo515,      "vdd-l11"),
> +	RPMH_VREG("ldo12", "ldo%s12", &pmic5_pldo515_mv,   "vdd-l12-l14"),
> +	RPMH_VREG("ldo13", "ldo%s13", &pmic5_pldo515_mv,   "vdd-l13-l16"),
> +	RPMH_VREG("ldo14", "ldo%s14", &pmic5_pldo,         "vdd-l12-l14"),
> +	RPMH_VREG("ldo15", "ldo%s15", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo16", "ldo%s16", &pmic5_pldo,         "vdd-l13-l16"),
> +	RPMH_VREG("ldo17", "ldo%s17", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo18", "ldo%s18", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo19", "ldo%s19", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo20", "ldo%s20", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo21", "ldo%s21", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo22", "ldo%s22", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("ldo23", "ldo%s23", &pmic5_pldo,         "vdd-l15-l17-l18-l19-l20-l21-l22-l23"),
> +	RPMH_VREG("bob",   "bob%s1",  &pmic5_bob,          "vdd-bob"),
> +	{}
> +};
> +
>  static const struct rpmh_vreg_init_data pm8150_vreg_data[] = {
>  	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
>  	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> @@ -946,6 +975,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>  		.compatible = "qcom,pm7325-rpmh-regulators",
>  		.data = (ulong)pm7325_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pm7550-rpmh-regulators",
> +		.data = (ulong)pm7550_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pm8150-rpmh-regulators",
>  		.data = (ulong)pm8150_vreg_data,
> 
> -- 
> 2.53.0
> 
