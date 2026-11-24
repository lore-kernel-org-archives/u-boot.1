Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4079606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mrAKQbLb;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dgATCAbR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C753780D48;
	Tue, 24 Nov 2026 08:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a8RRouyvf_S9; Tue, 24 Nov 2026 08:02:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09ED880DC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795507327;
	b=bvYXCs1qWdufMmtDwrSVM3bt74KzDA8n6jLTBEoTWyGXq24gexDT2q2wq9YqSfPBNeLN
	 TdUEadaY2V5Fgd8Hj+MpBymrxCB/y3C5XV6UiLL0luQBzMn+9b0NIs+WJrBqiB+zTXt9b
	 hscdxZ+7owTbYcAB+TPTVjGMEl0KsbcIV4+rdrfN+f2tjI8tyg2eA5qEYJs1qJjb51G3P
	 Uwm26uJYezEwbAUwNLUID8pezNlEJa8MlB0+waw8qD7tOsYLj85oovfph1tv/X18rtFwU
	 YiCjc1A7aSJ/9CF8Jnqm74ZS2BekeNCa5g7ZN0dSIrg8fyesEDV7glr/mq1RATFWdQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795507327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=X5bgr6Tkz3X0Ryk8NCz07cPsFxilaOsqeV6dkYqRnqU=;
	b=Y8qISibaNrYX3DVrvwicLQ9VR8pn4ofXqod7PHbHYk19UV44gcH6L+xpf2VK20ZPUtf4
	 oCYzg1433/In85hnr2nOaGc8qZzdVGOd4hEznHqeddTBZbybVCLeJwWR1VjKlh7TX6ZY/
	 V2GstMOjYaHES7wyQjN9yYLS7CjQykPnKOFtcDRBYIh0hNiuO1qZgLJYV5AYOyC0T6MH6
	 9DKEJQNvI5ZmJd7XcPbv7Z7hPLJhZRPIQCnrXPYXQKPA1wQkkQJLn7ecME/oTueWIv5m5
	 NpzoWKzZbTClZoysW6CtTxNL9hUQMzGtGLwlV6nlQ/G4w6yx/W/xu5EYj1C4EayuSmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=dolcini.it;
	dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=dgATCAbR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795507327;
	bh=X5bgr6Tkz3X0Ryk8NCz07cPsFxilaOsqeV6dkYqRnqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mrAKQbLb9FTtuNExUdgOO38oK/4MqmQ4uEaKWFdT7yFW/7ovhuLhrvO7LMdCtqGAW
	 61+yzXOdq3ZOXRFHugf0PXBZXHvwuRhH3nx1DVRygMguUAhR1aij/5l9f1Kuh/SuxW
	 GpX1HzvjBuR5X6zwsPfGSZ0LQy1TaekZxJNAiXLEPzbs1x3qWTNrL7EtBZE/Ly5lIq
	 02nVxn+lOKOsbjLMysxBEAm3tdmqoEn2Tgxmk0DPMx/2TgtPwMU8N0k7h2vHvk2HV3
	 gQZ52TBctaSRyt18Es6OWeUD/O5U/61yZoZ+/hwIHN1Z2TI3BBz/bsPn4jKr2QG9MZ
	 XXVeTiERnpQxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09ED880DC5;
	Tue, 24 Nov 2026 08:02:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41FEA1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F11580DC5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hu6jz6pl7WUt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9791C80D48
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=dgATCAbR
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9791C80D48
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:02:03 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 879B62355D;
 Tue, 24 Nov 2026 09:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795507321;
 bh=X5bgr6Tkz3X0Ryk8NCz07cPsFxilaOsqeV6dkYqRnqU=; h=From:To:Subject;
 b=dgATCAbRE39uyEhD9z+q1I/w+TBrZTaLrZ+lJ3BvIKn/08o7PixQF4gn8jRiE4mOF
 VwQOx9ktImFhSHri7YC/Z+GM3wDLnv4gHk6giqqAWKNwIpTOWJ5OGSjKlsw1uIJX7n
 GDN0wpmNbMHl10fUmbNQPJCYtkU9Rtq2wuwt8mU/qgnCsSpQn6lyz+9nh9Y85JWS9Z
 bn9T7k668+JlA2UJHVi66vlmpGYZOPou2EQCVWhGf/18pA8ht6b0VQ7UNIh4wk48u/
 QICSGrlAd3U6nXaQGf9f2bzDEZv03+9sqXRJ1IRBqGePA1ffypMK8SBKW4p+i/FWGb
 wQ7sfvSxBie7g==
Date: Tue, 24 Nov 2026 09:01:56 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Joy Zou <joy.zou@nxp.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
Message-ID: <20261124080156.GA80059@francesco-nb>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
 <20261124063622.GA5917@francesco-nb>
 <8edb588e-5bba-4808-b50a-2831afa42978@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edb588e-5bba-4808-b50a-2831afa42978@ti.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 01:10:13PM +0530, Kumar, Udit wrote:
> 
> 
> On 11/24/2026 12:06 PM, Francesco Dolcini wrote:
> > On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
> >> Hi Francesco,
> >>
> >> On 11/23/2026 3:41 AM, Francesco Valla wrote:
> >>> The TPS65219 is a family of fixed-function PMICs for which the output
> >>> configuration is determined by the part number. For this reason, usage
> >>> during the SPL phase is unlikely.
> >>>
> >>> Add a SPL-specific option for the drivers of the TPS65219 itself and its
> >>> regulators, to allow its exclusion during the SPL build. Since none of
> >>> the supported platforms that have this PMIC onboard modifies its
> >>> configuration during SPL, default it to N.
> >>>
> >>> This fixes boot hangs on the boards compiling this driver but that don't
> >>> have the regulators sub-node marked as bootph-all; since commit
> >>> 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> >>> this absence was leading to a silent boot failure.
> >>>
> >>> Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
> >>> the same configs, so it's affected as well.
> >>>
> >>> Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> >>
> >> Thanks for update,
> >>
> >> I see this PMIC is enabled for below boards,
> >>
> >> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
> >>
> >>
> >> I am wondering, if PMIC is really needed here,
> >> Do you see possibility to mark PMIC as N in respective board ?
> > 
> > Verdin AM62 and AM62P are booting fine with
> > U-Boot 2027.01-rc2+git.eb7af371cb8c (Nov 23 2026 - 15:22:38 +0000)
> > 
> > No bootph properties on the PMIC node, and I guess also not used on the
> > SPL. We could save a little SPL size disabling it.
> > 
> 
> For normal boot purpose, you don't need PMIC in SPL or A core u-boot,
> unless there is specific need.

not even for the sdcard voltage switch?

on verdin am62 we have the following

```
        reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
                compatible = "regulator-gpio";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_vsel_sd>;
                /* PMIC_VSEL_SD */
                gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
                regulator-name = "LDO1-VSEL-SD (PMIC)";
                regulator-min-microvolt = <1800000>;
                regulator-max-microvolt = <3300000>;
                states = <1800000 0x0>,
                         <3300000 0x1>;
                vin-supply = <&reg_sd_3v3_1v8>;
        };

```

and

```
                        reg_sd_3v3_1v8: ldo1 {
                                regulator-allow-bypass;
                                regulator-always-on;
                                regulator-boot-on;
                                regulator-max-microvolt = <3300000>;
                                regulator-min-microvolt = <3300000>;
                                regulator-name = "+V3.3_1.8_SD (PMIC LDO1)";
                        };

```

the vin-supply is from the PMIC. Will regulator-gpio probe without
the PMIC driver that provides reg_sd_3v3_1v8?

Francesco

