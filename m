Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597B3C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40D0C60773;
	Tue,  4 Aug 2026 13:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJRjzOkqIXA2; Tue,  4 Aug 2026 13:11:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 308D160716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849068;
	bh=MEG4MlegMJW9X0kD5zdPBkvSc6ucIKBcM5EIRxHpTY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aKL+aU6t3Qi2bjVfa7rrVVkaZZLW4WIiO4debaEey/I3BTdIwnnEBkf3ed92YU55U
	 DHHcvon7vbla7b9OSGtto+DejbLwah4ufyWeqcVf7E4qIHRWIjX3aVGi/22wZjFUn8
	 ACy8LX8ISwtD28x78AmQGWb4oF/F7qBPMWCeq6Ty3FEOFLkBslo4EEgyyY/EohWjsD
	 dH6MiC1PqA/RiOziy8ShSldwyvAf+qZs5Sg0HRs3rrRlwO6VL1Nm7EYaDdLqtw6E+k
	 mmEQzgpnCYc7bKKNEW7U6v1SKb7PtQRIV3HNG0tOdupSzA3LYz3zqsD6Qt3uyO7fF6
	 KurXj3rvp9pMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 308D160716;
	Tue,  4 Aug 2026 13:11:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2D70296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B93BD80ADE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKm4Jcq8ooQm for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:02:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C7B2980ADC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7B2980ADC
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7B2980ADC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:26 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso6556481a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848544; cv=none;
 d=google.com; s=arc-20260327;
 b=D3hqMsw67VY58WXY7e9CxW7b0CcXpwQIKdhg51ahaH4C3LllXb+6MWCb3zVpmylz+e
 DllrQBo2eBsZM1hoPYPE4qskNh0ZCv9sF8gLFWh3A9bzcgLqGJO3jiIg4f1B5N48VgTu
 0f1hgc0txs3cQSW48HAFwMqeuX8Qff2mXp/THMDO+En7NIkCm5LP9iKRWX8/kz29/rSo
 qiwRNd4XEqRrw7z/XQrj+MJihd/ib7CFlgq4qNJ4HKeXQVt7Yv8leyJ2piEkbwNCh2Kc
 8dQg6PVfwJh2ICf9XYZl2XXMKsN9iDQOrxgy/P1nE8vFmsyi1I+EBV4ogvCUFMF7yB56
 LzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MEG4MlegMJW9X0kD5zdPBkvSc6ucIKBcM5EIRxHpTY4=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=G/mBRdCC5FZUpgd+ch28FDQXXRIYMeiF/IQnDNSM/PnbaDy+qr+2wL4w0fsZMiBzn7
 vhLo6b993bDy0gA4ERc7l6wRtzcvPQRhw0I5i62u9+JR0aikKy+H6U/N4CXrI3O75vbe
 1l80t1IY3lye4G2QJP4f07jnNpS1o8yOZb5oeB/s7AxbFNrAc1hkKOZiSIJJBgSspi2S
 pYfhaLUg2ekXuDnV9Zi/wezOelJapMSjLKwJyS3QzvRG9Rt0QGlswzIle+RzezqM5kSi
 faR3gK/H+onQLpEso8b/R4q87B2N6n+gpSAOX9VKtGUITO1jYjWl1eH8aB576sio1Ixv
 YHNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848544; x=1786453344;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MEG4MlegMJW9X0kD5zdPBkvSc6ucIKBcM5EIRxHpTY4=;
 b=KFz1ihU+hmhVCl+NN6O4Wh8ZLRgEqFbKeocIAhpJbJE+wrVK0fvEl3eDpjCcrQgvIr
 7V79O4u18RLxJGvN6jwCqzPVSlvCX3vim18P6TlPU4qJtWIuAnwQkPwipyUSOb/TrobJ
 OJNiPcIBuBTWEy5ebHwTIgvwu+tBGG8Ovc7E5e+P/YkfN6KroZDFyEcyPLVsE427Tgac
 GkQOY2b8tKpMCyDLjEXr10+UdJM9Zlm659NEFTHR0gqQLGuD27I0h+H+SSPOiIkhbnpb
 Bn6YoA/LWXor4/PnZdHkD0nrC3x9PzDCJQfunhqA4+XMbHdLTq7sCTDQAJQK3nGubq9X
 0UnQ==
X-Gm-Message-State: AOJu0Yz0/+g9tduXmEuBWd1cKAhn8cg777gNClwFMOlNrpjHJB9o9w40
 4M8SZHviW5XBvdZlmkbeXkY0/a0Tn6uo5aEiLcR8f2Aipn3Eag5zHoFP78ZeXKAy6AQpkHfaCKs
 d+GZn4vwJvY3At3FbSodPHFKlC5PX9ajeR7zs0AYV
X-Gm-Gg: AR+sD107DSOjQWqB0cm/FBgVHYLQJuQ2oX9u3EtbgirDCOT2OTQVnXd+ZHotIEs7mZ0
 d4ArKwEYRZT98UhUyNP67fSiNKKrWAFLA5g1P8GMLUDFnYE8TqChXYNTTZqvBHcpqxUh1XqUJhr
 IB9oIFbkXmPLpH+Nnp6xY1N+2R2x9WfvjsiUIKmOcSqSBpUwmEbkvT8t8hSa7XwiSCV2bmFjv9r
 bezajjdVwSr+DVaH+PwMCs82T+IFXoDQDgGxLeSyGOGHHw0B5bebRKpJaFrZ9zfU9ZC5pClP8cO
 0tpkAOutrRS27lIVMU5oxQax0fvUSj4kA0ZugifNDPY=
X-Received: by 2002:a05:6402:378a:b0:69a:928:9405 with SMTP id
 4fb4d7f45d1cf-6a0a7c60e9bmr11885119a12.1.1785848542334; Tue, 04 Aug 2026
 06:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:02:09 -0600
X-Gm-Features: AUfX_my7srKn70i_q4wVmvl5QTCU6JcP6MxAHhiSJub2ggwBWd88r9q7UO1eFlw
Message-ID: <CAFLszTiAP1Bib=Xpg-OK=x=pJCuG=N8f_bnxE7dv=YdM4x2ZOQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848544; x=1786453344;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MEG4MlegMJW9X0kD5zdPBkvSc6ucIKBcM5EIRxHpTY4=;
 b=Gg0gr23VrmPWL+stn2oik66wgpFzi5pv0QxZsuYdjqfwnWjIJYShnNd7YfnkjL26eN
 yMA1mmkjGz3B8qMhjjIQ9fAnluYup19FEZB4f2YdT4NwimZdZB03/qGO5JIQeDPiRHoq
 0nnvkjl5YkAJXp4iq6fHzjE3mkDNS2sYKTlls=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Gg0gr23V
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> spl: Decide about Falcon mode boot only once
>
> Board implementations of spl_start_uboot() are not required to be
> idempotent - the documented examples sample a GPIO or read a character
> from the SPL console - so calling it more than once can yield different
> answers.
>
> Add spl_falcon_boot(), which calls spl_start_uboot() at most once and
> caches the result.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> common/spl/spl.c | 18 ++++++++++++++++++
>  include/spl.h    | 11 +++++++++++
>  2 files changed, 29 insertions(+)

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> +bool spl_falcon_boot(void)
> +{
> +     static int falcon = -1;
> +
> +     if (falcon < 0)
> +             falcon = !spl_start_uboot();
> +
> +     return falcon;
> +}

Every existing loader (spl_mmc.c, spl_nand.c, etc.) still calls
spl_start_uboot() directly, so the mismatch you describe is still
possible on any of those paths when combined with spl_invoke_atf() - a
button released between the loader's call and spl_falcon_boot() in
spl_atf.c will produce exactly the disagreement this helper is meant
to prevent. Please convert the existing call sites as part of this
patch (or at least the ones on the ATF path), so the caching actually
delivers the guarantee.

> diff --git a/common/spl/spl.c b/common/spl/spl.c
> @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> +bool spl_falcon_boot(void)
> +{
> +     static int falcon = -1;

Minor - since the return type is bool, I'd find it cleaner to use two
bools (result and 'decided'), or an enum, rather than overloading an
int with a -1 sentinel. It also keeps the value out of .data, which
matters a little in SPL.

Regards,
Simon
