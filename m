Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0998FC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEC0E607A6;
	Tue,  4 Aug 2026 13:11:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zPA0MEX5HB9Q; Tue,  4 Aug 2026 13:11:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E20CF607BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849080;
	bh=n84wq/aSk+B03CRPcI5ai1xrVe98xFf8DD0Q2KfAf+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjmtSqv7K+qo4CQaYrq3wMk50Y7PfK2lD+4B7dL8hd97A05R1I/Wi9n+diPbP4uwh
	 ZnVnkLGeuO9TOVZYUdLrvbFE7hNh8Lb/NwrExlx5WybF5I+xlhycaF8P4FOIx62uI5
	 BkG3Rz3wdSxnny6bkyShUhFvWtqj2Khpb/NJZzfpqmUgQx8Z1z6eToElOWVR0OeoFM
	 6s0p0GqbCO7NbQ+WxMZdis4BIVDCutCwSLqe83gDPxLX7wuKPednnhD5gmoihQnyEt
	 +Bh/0zahcwklWOjqS+x7Q63ckOj74IA8rGD+q/ZMo1YROEotu2PyibU7P6n+yc+AGh
	 cFJaPFm0eqKWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E20CF607BD;
	Tue,  4 Aug 2026 13:11:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC81A2BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C34A9405C0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QqRpgHCGzEzH for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 902044053E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 902044053E
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 902044053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:44 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so6935982a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848623; cv=none;
 d=google.com; s=arc-20260327;
 b=EbRPeCwWffubE1h8sxasfMms+OY1EnrFwACosiMA3+MEw2Crw1oC1znVa8J6c7+cvC
 BtvDG6NE5DmWBZYZR06eK9d2Xo5VdgjLjVTTw72dVT1Q3R0DGHCbi3m2XF1GDRJboBqP
 3qLeckeEtU4a0ZO+Bz5SD+JxibPAu8jlm/aIItz9Yh7aX6j7yw2XwCmKTaZ/tr7d/L5T
 a3aSG85antzZXyhZ5Xgg3nBPD+WeWM4Xu26a163oTKnkh57geuDeWhM8Yq1/yhRZh9X5
 Zr2YXjpGkigozo4zxXw2TnysoAQgL1titZd9uZnYimOf5q1HcezKhRUrHf+dnaQrAjsn
 j5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n84wq/aSk+B03CRPcI5ai1xrVe98xFf8DD0Q2KfAf+s=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=gdwWyhWz0kFuCbppKHkciVPL/kK3uYOj0nd/max5WaoSTfGRE+lN/0mlaHiw4AT70p
 TY8o0phm637dPq0VpT0eAW2t8+zxZaTjAMv6IpK2I0/BaC9bAIGFFTsw/9+aksLThaSc
 St78zA+oNu90v64GU1T1x4Y6QPW3YL1lQw/mbt/VD2njJLi6f06p2Nrhg1ahxXATWsyk
 aejyb+0rbbfoZWYClb1nVilz43YhsY29wXuNMMoyBBlwIq9/sWQRflWSalxCNFH51LDD
 ulx+3VL3ph/Ic/5okjXReUxMkpP45glgRdrEm4fAjf33VxyccoXn3pifRqWAM5ino4Or
 h7Sw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848623; x=1786453423;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n84wq/aSk+B03CRPcI5ai1xrVe98xFf8DD0Q2KfAf+s=;
 b=DSme1wJKVclpqCrnJ4vnZngYco4qMe3t6ZBL0O/cX+uCflccZdqmrRUlEtcDuVwF9g
 YguJ+VSI/XcCXY/ohV0lDYbb9Oda9SBdt/KPyQpwUzp9+2ujRJvnxMe21y/ShrCNGTvR
 4ARoTw9BTB+HuKvowYLbFtfFyGssE74k4FW0O4bE65c0yTnf++xbvoBvhs6/9D1okCus
 HB/cIR135UJ0O13lbo61RAYtCjhehM2RTp6e2ZmdYDU3vsJqD4H/nf0scu0hOw/peQMB
 eLZclbTcDSaT+7k5h4VZuwjNkbEqhw2f+Kt0ZhKYKUaRVLJK1Nllcn1VifTTcOjYwFIz
 gQ6A==
X-Gm-Message-State: AOJu0YxMcYHM7ME9uKd/avpgwsT/U8xXENbUtXsy2pFuTc3Bh/vjwQGp
 OucVcBTsEs9ttqXKppLU2oQKc9JRBrsPWL7feHqgkeJjU21vnh4/11IVZ36LpCe2ZFUJZdpVKoj
 1QKIK/xYxwF3GPh1VlHqY9A/EdfbCqV29J+IX+Q/c
X-Gm-Gg: AR+sD10UIfTTzXBHGk7aawHmWTUJ6vP4eJTTkzLvhAeLpmjKHlQeAkmB1Tb0CN4kY/Q
 XGgytK7D6y525HIwEHKZF5uQL7/LL8jjnYaKc8SNVhRWEYxUlxzrHN3a4LfmrBNXaXpp9g/3fF7
 V5JL30Rpdqq1wmUtHUsWoC1DagMKTrHXlWOOLwbK5awQZNzVtbU+6nOMKO9jVnN8Ap5PZiqp+B8
 mxSa5Nz7LyvEidIWEXtDiCSVBaOT2xbk7NRibkDr6V7L1DQOPGyE2s/XOSFSEebeC6ADBVvN7U9
 kNG2Ex27ZyzGmYGWiqpsxsJEGxLcWmSxcgWjBw1n6LY=
X-Received: by 2002:a05:6402:274a:b0:6a1:28d8:2306 with SMTP id
 4fb4d7f45d1cf-6a128d83c03mr2708511a12.1.1785848622609; Tue, 04 Aug 2026
 06:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-8-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:03:28 -0600
X-Gm-Features: AUfX_mybM9tOl4ofdjCtd1AerYGV0KnV96reIC53Ahgt3k3o_mVwX9ZeDGi8GbY
Message-ID: <CAFLszTg=G0Y-qNRP-smy6CGyXhm=fW7fkaiD60f4duMhBr3=bQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] rockchip: spl: default to Falcon mode boot in
 SPL if enabled
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848623; x=1786453423;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n84wq/aSk+B03CRPcI5ai1xrVe98xFf8DD0Q2KfAf+s=;
 b=jh8EjWsg4mRhWEkRP68SrKUWBR+yQeoqrVSlHw3EHsG4MnRg5dxyRcqx/H7nA/YtXb
 NxgG97B8WYMJseF8q7F7lFwuNe16NhsLMno7m4iS1lyqsc0Pm16Qs+E45adzUNt0YI2t
 2UDZOBg1MkmfErw1xN8pNWeEQjFlQPfHNDrjc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=jh8EjWsg
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
> rockchip: spl: default to Falcon mode boot in SPL if enabled
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
>
> arch/arm/mach-rockchip/spl.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
> +/*
> + * This overrides the weak default in common/spl/spl.c, so it must not i=
tself
> + * be weak: two weak definitions of the same symbol would leave the choi=
ce
> + * between them up to archive link order.
> + */
> +int spl_start_uboot(void)
> +{
> +     return board_spl_start_uboot();
> +}
> +#endif

You've already seen the vyasa-rk3288 problem here.

> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> @@ -153,6 +153,35 @@ void spl_board_prepare_for_boot(void)
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

Introducing a Rockchip-only board_spl_start_uboot() alongside the
existing standard spl_start_uboot() hook is awkward - a board author
has to know that on Rockchip the hook to override is the new one, not
the documented one. Would it not be cleaner to leave spl_start_uboot()
weak in the common code, drop this wrapper, and just have the
mach-rockchip default live behind the existing weak symbol? The
link-order concern applies equally to every other arch that provides a
non-weak default (arm-k3, layerscape, zynqmp=E2=80=A6), and none of them ad=
d a
second indirection.

Regards,
Simon
