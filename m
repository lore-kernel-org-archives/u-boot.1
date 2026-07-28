Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAA4C54F52
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CA1381457;
	Tue, 28 Jul 2026 13:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0M-e4BFTCFF; Tue, 28 Jul 2026 13:00:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F284813C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243641;
	bh=VKcyz8/hN71ZK4mAvVe5np9w/1n3oBjuj7GiGcUBRrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bVyQ0Ds3OAyONSINmNEmc9Yf3PthnePf+Z3Yfn6OJSsE8VTmwuXbHJ7t+lJTg2EEr
	 Fbo4fYntoWu4xIRHRdfbeGCsqsD+fVrod8zjZM6hUjApPjYW1DyybwStxgNOQrSq1N
	 hbESrpQSGjhsTbZR0k9Zfqb8aBiscqcmt0Nc0WV+xGnHS17DLypXmc5M/Td3t6fBWK
	 yxhK/mp5iGtFEGaXDvJOg5ng89xBZAAHK1AxFPyjoTeZ5yCcfWy04AwUjCQRMJqg8K
	 gnV9FOMuY5rT0mPcWCeCzS55lIBlK9cJtSswZsvy9F1TnGGDFJGhHqrBZhK4/9igLW
	 SARrUZ5bs7vfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F284813C3;
	Tue, 28 Jul 2026 13:00:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A4D2A350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A78481304
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIcfoS0txZRx for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:50:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9312D81302
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9312D81302
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9312D81302
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:50:54 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so4530849a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239452; cv=none;
 d=google.com; s=arc-20260327;
 b=ESYlGX3GKxUw0fSSQwYEkZV6P3FT6TRJunTc6lQkqQCEPfrwwOwZQOPPLVDIEu1Btl
 Fysq2vXc0lzCFIL7FNpKNfRAe7BWKkCqjxtwuyX6MhlBMrsBA5Hggnm2X47lud1zWrgo
 6GoTvnVn0XIaziLN6ATFUYX6+5KRc8+AS5OVc5EAtEYy0qQy+hiKmBv1tNzGafw0EuHl
 vaPtVEzhkjxXW5NrxiMVlAI9niIFdBnz0zdY8O/Cc7+T0zYNZKZmF50jSvvZeWMRpcT5
 0eFAbU4nr8phNlNqXbXbGFv5j/fXkB/DjbnbpfVUADtPaSf4wz5Vtnvu8bmBKuENRQQU
 hhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VKcyz8/hN71ZK4mAvVe5np9w/1n3oBjuj7GiGcUBRrc=;
 fh=koAyXj+onvmfeXQ1wFlTwDlogBvRv5p6koAKOoCi9yc=;
 b=q/AEjua2BKvVUp6Dcgj62HZZQFS8V1RJNFVGPdkJLpDhsLRD686HBikFcd4opRPsdu
 ivLLopkoqgYUasDnDyQS4gvodkIzO0lnLki4V7Bjl1ofdNJu+vx3+5cltG5vRucFwukc
 UsTzH2onuVC60HYKYeV5UeLwEUAj9Dv7cdqoWU4lmegK6TLUpKxH6XGN5rftdOmxxV+D
 HFCBTW+7UmfqX/Lv6fBIV2vwoel876H7g6qyI9pqDBKz5wIN6WgMI2I5G6oQ37ZGtOm3
 loKrN0TvS/soNTpZL0yoRQd8f25hptgUIHBj2NKxL7+WHfvzKOWXH/4VEfmAF64cob1i
 7nKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239452; x=1785844252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VKcyz8/hN71ZK4mAvVe5np9w/1n3oBjuj7GiGcUBRrc=;
 b=X0vBW2qwM7Wk/3z5wQ+5q43rWfpRdH3syzqXeF7IzsAuIf/HTWZYxROUWGFAIpPkGI
 GtMv3G14FcbDxDL0LDGDnDoc3lcN+i3cYIXQET90binSFOrSlPgF+H0uqUSMPwf9kW9F
 X8tDJdyNkU3ZNC+4B7u1VpM7hcQt4K6rC/u2ezOyU4A8ibszeYrqbh6DHOneAMPflRYQ
 7Jer45S3+DslVe28ToC+xvO7BJXDWrpK22vx3ZiNuYaKY8Y/f9MQF/52yLzpItsLy11r
 ar5+IRrJHVoVsVP5ZOzxEfAxwT2YYlsVOBqwFmIVRluA5pJMHy35v/WgSDYVOwh0Z3rN
 AXVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjWww3XIsGFv8gUo5mRScBalKLiqQbkw01L92KKDcR2+F4sFOd1EYCenurGcGr1m1IXc090rc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxtOdfQ5VFEaJnDXPDGYfmY4QLukwEZzssf1nbJN5hiVvz0Z0qz
 JeuLXPheXO1dYP3jYNDuEAmn++PUNNzX7WrbCVYE9G0CI4UPzsiShX1HPM0nhg5fnGJrH/hLL1r
 GZz4noq5Z4jqe6luZ9/2R/jl8f1gw44LzysocZVac
X-Gm-Gg: AR+sD12/LSFRKkNpT5k7Wcubx89q0vcODuHdo2bwboIF4u5JJB4SPKwR76e74y63qLh
 73VLLfPLYxsY4ArS5eRjRESqywcc24FNyxniCdK9q5xYk58bz7ReRK87F2eFDdCgItF6fJKeyRF
 1qkuOTGdIUkMU7+UdVs/VV2ZefF0v7OYyNCUV+UTYgzboBWV+jXInkCa7yvRHgvVpFRgkBC/85u
 uOQg8DAg1RYhxDeI8FhiH9RZW47dWUUmHpFLeM5m3N+qlOGP1IuBzG5Upw/
X-Received: by 2002:a05:6402:3585:b0:6a0:33f6:13d5 with SMTP id
 4fb4d7f45d1cf-6a034a9ed6amr1072036a12.23.1785239452380; Tue, 28 Jul 2026
 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:50:39 -0600
X-Gm-Features: AUfX_my9IE5djt8lpSRmqzuwwnpeMnHVw7nrJC438AN8jIUl9y5pgQMH_0oEucE
Message-ID: <CAFLszTgwL7XFLonf1xeY7TkaW2rBJSyTSO+v+DCEdAfyXJBtGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: Switch from setenv to env set
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>, 
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Michal Simek <michal.simek@amd.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@ew.tq-group.com, uboot-stm32@st-md-mailman.stormreply.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785239452; x=1785844252;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VKcyz8/hN71ZK4mAvVe5np9w/1n3oBjuj7GiGcUBRrc=;
 b=WELPxXV4Io7dsvoLkLIRr0WaqbfK6Fraw1GL+ZqTlR3Wfy1PQ5YUrKpAJH6a1GK/6S
 igxQ7hPRvFqpilxte9mNQd2CnrxithQhKeRflUmzUg2/TjflIT6TfypbKE3qY+s+iQkJ
 mLwTbVULY+qZ0JnBit0WiDlzX0/762EFBMEOo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WELPxXV4
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

Hi Marek,

On 2026-07-18T23:45:48, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> doc: Switch from setenv to env set
>
> The "env" command is the recommended environment management command,
> its "set" subcommand is the equivalent replacement for legacy "setenv"
> command. Update the documentation to use the contemporary "env set"
> command instead of legacy "setenv" command.
>
> Note that the "setenv" command is unlikely to be removed from U-Boot
> in the near future due to it being integral part of the command line
> ABI.
>
> Implemented using:
> $ sed -i 's@\<setenv\>@env set@g' $(git grep -li '\<setenv\>' doc/) README
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
> @@ -119,10 +119,10 @@ Sets the bootable flag for all partitions in the table. If the partition name
> -gpt setenv
> +gpt env set
>  ~~~~~~~~~~
>
> -The 'gpt setenv' command will set a series of environment variables with
> +The 'gpt env set' command will set a series of environment variables with

Not quite. 'gpt setenv' is a subcommand of gpt, not the standalone
setenv command, so it must not be rewritten. There is no 'gpt env set'
- cmd/gpt.c dispatches on argv[1] == 'setenv' (see gpt_setenv()), so
this documents a command that doesn't exist. The word-boundary sed has
caught it here and in the examples below:

    => gpt env set mmc 0 rootfs
    => gpt env set mmc 0 boot

Please revert these to 'gpt setenv'. It's worth grepping for other
command-prefixed uses (e.g. fdt, i2c) before resending, since the sed
can't tell a subcommand from the standalone command.

Regards,
Simon
