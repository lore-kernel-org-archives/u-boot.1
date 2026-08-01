Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CBC5516F
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 05:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABD0B80E3B;
	Sat,  1 Aug 2026 05:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5mpLCH_nJPx; Sat,  1 Aug 2026 05:50:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B100C80E18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785563443;
	bh=9Xc9fcUg4mTf7aj34p2435ZPtIyoU7kscGJX5N4NIAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lpxh8IrKpHZsTPesLY4sMl8I2tGBFmm/TLPKRsofh3Z+Et4vDEt0JMx7I0KKvbpDY
	 o8tkCZsT/3mVZvgauCL6JHg5x5wlPkogvWOTCQmVn7c3QZg63VJ9E0LEDkti/bdAWW
	 8Y6Ac0CqGuelDSX8M2jZgzgN1HbPCEZkXy9MFWDgGfqPKcrX8KbLTZdFnBAou9XMTw
	 j+/LW0eBzap3rkA3W/izA8gnExL2Pr8WH64le7lPLAzeNc367e6Eq4QwmDc3n5HuMK
	 wcPBej/VpX93iuUktlt+Lmtikh/iJqfsxt3OwlnTRNhCT7UdVFo5GlMQwREvOuNaaz
	 jzHMpJ0FCwNNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B100C80E18;
	Sat,  1 Aug 2026 05:50:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5AE52CE
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 05:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A74EB40128
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 05:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXrSzqtTWSoU for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 05:37:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1E3404004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E3404004E
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E3404004E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 05:37:48 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so293823666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 22:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785562667; cv=none;
 d=google.com; s=arc-20260327;
 b=soYYiR7zTuvq9KOG4HWBB8wJOcXYRlLNBKcXraFRDGbRpkzplCY295sS62mhxG2yl8
 WfICuyUsF66g/tMzi1mTiCzGDjDFlkZuoZK2M1z9n2giSCuHdt32+mgLldA7pN2rKZk+
 atRw3L5cs+RrsRFHgjpx6vXgg5mMaFakRSimCopfjj2QNoQ23whlvv81hDrxnSk5bdcu
 DgVtJrQ7hBRzjrYOR10RZ6U9dYarjQBjJoF1mxpYxJNdIPIluvwlw4HIKHoS2wCxMEnh
 ib8NPLHETto/7fkEQn2XJgqNQOh7MhDBXKMr6GO7H3augD4xK7tyW+T2A3DoGD46ejhw
 CLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Xc9fcUg4mTf7aj34p2435ZPtIyoU7kscGJX5N4NIAU=;
 fh=oXeOG4KFI46h1vCR+dMkM2xFbEtLShY7xps1MgkikYI=;
 b=QCD+TNUQma6RHC5kDCoiLN7xxguI7b/1Awtfd7nZRN6Z/hhqyV1qTKnk94LYuPWmkg
 xRHuvSJL0d5XLQTEnfvPBpzpHe3NLER3H24g5gG+UQlY1dIAjoDdCDF0hmUkUzLYY5EU
 zPNoGuHGH/7F9ZBlHglMmRxJhY10bWxZqsRCCklyQE3r10kPG3WnioUu/jGMsG4OxBcE
 DRZQ37sM85XGlY5RiXDei3nxRleQytYt3vMu6Q3zgGqwn3j+HOoLzqkAWrmbhMPjI9L3
 mzQ3mCTlQHYdcf4zMPjWzfW30SXJB2Ivg3TlHAZXM9D/zw1aYjK96BzzggxjcXtpRHnX
 WHEg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785562667; x=1786167467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Xc9fcUg4mTf7aj34p2435ZPtIyoU7kscGJX5N4NIAU=;
 b=JDEsacaoHULbMeLsRODOy9DKjTIoDOjQEfMpmXrgDU3WJiTS+weohwNnBIhs7P8A9R
 WYS94dnNUwxwnLdJUH3HstKa/4jvc+MJ9TFDfiSRev6p183N8oUTmUWADA6Zd9yCz0fH
 ubtT6iy3ZqbEzb+a42hl+HwLFmbjnsxpi2eHI1/Ab065L729kWm3mUEFl0bn5NsBpg+r
 9l1crcd0FMByt0OvJph1O/24nKZZ1QCmtOYGxL3RAvCKV3Y/hd/iFmZ92jGeWaz1L/jp
 Iv0VykA1rKUnr1ok3r5p0gMYy3uwxdPdtXQ3tMK0g9EzH5aNXSdSjeUMnmBXm0T41tY8
 /Z0A==
X-Gm-Message-State: AOJu0YyGk3mnHI8HiZMq8H7rUITQSJPQyT5r7PEYsMi1RP6U/6fEu+/J
 8QTfbaycTuem/sm0bj46548bt1q4cN/RuH2Iulz10rPDoVrsCD+kDsUC60VJab5LazWd9H32SJC
 4f4+FoIua8ZcR96aQqTKWlvXLPFpebGkgRSQmtJqt34oDSw+ZIXpSpSQ=
X-Gm-Gg: AR+sD12fdb2cV82d0PlcwCIbHXV0WTsvhZDEgah0Qq1J/8G/R5m4MLc9OiaZbJuuHhF
 ALCtEPvmbAOtJuGRp+X/oSsyyfJ8y72YKzFxyGdoK1thA3g0gqj96LF0IX7uya3VlwVc/n/yJ4y
 IG0mgFh5HBiDlKP4Yqsvj92XWJSwP4cQS6T6QJnwoJDQv1YnDUC7ycdepGI/aoYI2eW30UYtG2r
 7hlfuVtRKbD3uXIdIHte14/7sie2lC8Q+sIgP6Q7Qz+79r3tjW/3klnEvyFuqd2+XuOWG2arEd9
 fjQm/IdZGTxjpC2+CYXSNS7BkFhacHDXGT1MDP8f3yu6u5I3fxAUShSINCf1hAZ1/DV8YmDUBzc
 =
X-Received: by 2002:a17:906:c00a:b0:c1f:e09d:12 with SMTP id
 a640c23a62f3a-c1fe7f23ea8mr114106066b.25.1785562666764; Fri, 31 Jul 2026
 22:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 1 Aug 2026 09:37:35 +0400
X-Gm-Features: AUfX_mxHiU_IwhcJJvdfjLffKM7zax6R0zU-u0BHWN0QewXFO0-qfJxcUnspMno
Message-ID: <CAKTNdwF7AhHtgT3ySbyb+brkZ52NkzLyXvfOy1XBsfXYXqAuKg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in
 SPL if enabled
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Aug 2026 05:50:42 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785562667; x=1786167467;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Xc9fcUg4mTf7aj34p2435ZPtIyoU7kscGJX5N4NIAU=;
 b=ADDE7sLYBDvvBqZJlUETLoK9CDGUuKMCsdnh0QNeYxSVsxEZMPuo/k0mygM08ADRFF
 rYKwkSmt9euvFkBoMCRZeAUIOeipjWhjLOCI8wRZvyhPE8OLKuIM+xIEWC0BzAgJMyym
 /JiD4+qkgQ4vBZm6C83gx25WoHF47HFi+vnb6ilk1JAyPJnFzHsnw3rj/aUrY4mZdmDT
 v9/0rYYKWkbgohRv8o3RgVRU2x8ZwqhQ91cgDhH0FGXBRXxjUn+cLVSBQ5CUaW2u5yVw
 r1yiY7AzL5bc6zeAooMSFft2cQlezCEMWqLOctruePj7nKAljpD4QegPek7tqH6URcnn
 a0CQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ADDE7sLY
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

On Fri, Jul 31, 2026 at 9:11=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> Common code calls into a platform specific function to determine whether
> to attempt OS boot in Falcon mode.
>
> There is currently no platform logic to drive that decision on Rockchip,
> so attempt Falcon mode boot whenever it is enabled in the configuration.
>
> This can be overridden by board code if needed with appropriate logic, su=
ch
> as checking for a button state to skip Falcon mode boot when pressed.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079a..54dec06737e1 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
>         cleanup_before_linux();
>  }
>
> +#if CONFIG_IS_ENABLED(OS_BOOT)
> +/**
> + * board_spl_start_uboot() - decides whether to boot the OS or U-Boot pr=
oper
> + *
> + * If Falcon mode (direct Linux boot via TF-A from SPL) is selected via =
config,
> + * try booting to Linux first, with automatic fallback to U-Boot if it f=
ails to
> + * load. Boards that want to implement conditional U-Boot/Linux selectio=
n logic
> + * override this, for instance to look at a button.
> + *
> + * Returns
> + *   0 to boot the OS directly
> + *   1 to boot U-Boot proper
> + */
> +__weak int board_spl_start_uboot(void)
> +{
> +       return 0;
> +}
> +
> +/*
> + * This overrides the weak default in common/spl/spl.c, so it must not i=
tself
> + * be weak: two weak definitions of the same symbol would leave the choi=
ce
> + * between them up to archive link order.
> + */
> +int spl_start_uboot(void)
> +{
> +       return board_spl_start_uboot();
> +}
> +#endif

CI world build highlighted [1] that some older Rockchip boards such as
amarula/vyasa-rk3288 already define this function [2] for their
"classic" Falcon (non-TF-A), causing double definition and failing
link.

I will fix it up in v3. Review of the other parts of this series would
still be appreciated.

[1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/job=
s/57280
[2] https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/amarula/=
vyasa-rk3288/vyasa-rk3288.c?ref_type=3Dheads#L10

Best regards,
Alexey
