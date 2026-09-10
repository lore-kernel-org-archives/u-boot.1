Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951B5C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59A28810B1;
	Thu, 10 Sep 2026 14:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyNs8d99hCNy; Thu, 10 Sep 2026 14:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E02381097
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049392;
	b=Xslvy3kFed1kVkQprgNxuHz8jnbgWToeGFnLbpyiUk54bUIhMBadCmIqw+x7xITAyNdN
	 ykTamSafCnXME4se3rqFH8rxXILB0j3/IyxVvgzIYm/mfLMUQp8Lw0Bt8EdrxMmP8nnjw
	 j1FClnZ4WNJnbs3dPAI0I9JyyALKMj9RK5IZ+65wOKRVVpxO32FkU49xJ/YxF8nAxS7D+
	 5wtQzpeRDoG1bgsmVNM3Gh4v05hHiaL9+IhMzDbIHSfaAVbXVtoA2nX5uQ41MU6Ut5gxa
	 Of6pj495FXFXCgNnR2QS14d9uNwIyOdgU28gUQ901dgnSyVcA0qna+TR7U3QEDW+uyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
	b=akcruXcS+/iOhflS80q7CS3w+WnhHbDJRTzZ6C/oHTvprrFMbsLP8U0W6SBVqMvJIbgp
	 6A16qnleffgW3aLfFSryCG9wk46ReVE+7/XlU5n73ETexuK6FWqAD/LwaztGBZsk910OM
	 rfS/FSG75pNWcIPG5tj757I8WBnmJssRVvBoYMylzlSrvvqqkEPOryVpqg/f03KUGjdNI
	 q7VxJUJJWVOIlerEo58syTsfb6zGJmlv73IJK+EvIGkg5lxzxufYB1GVJtTHqfbnvQV/d
	 Dv+EgQAg0CTDF7qeF2xsi+ZWYpHCoYg9CcDabVYch52MAjYRnL9470LRZjRqqIfRnpA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049392;
	bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQ17ZbQ5jeMFuYh+A1qin9ngRlRplq7xOyvD3hcKekKGspzPTUjItlbloaK7zXZvd
	 Wqh70es0ki64/p3NxoLPrIheb0HDJlateurrwtegYHSgVqrocLFZmj10F8v8gyQDjT
	 MVyonfg6rV+QgNs3XCk1dvFha2aLp2YNN7tKrpbQ5QhM6L04IE3edp2KBimVmslFfV
	 q0nyEI0vp+n7vFercpcMSl9mI7w3LhCqnQ9GdMy9WC1m9LFAgRLYLxHj5Vv1ZgOrfr
	 JwSiAq/ymsl7C7MUcofSk05XGtLPDl/WEGKo7GMZtVKfAiznl4aejuvbmqFfIfT61p
	 jIzEYTzJlrGXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E02381097;
	Thu, 10 Sep 2026 14:09:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54FE0E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46F3B400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0IY_eU9JVP2 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:09:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4D3DE40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049389;
 b=gfjyQqdt4t6qZs82PKz8wUdCnvVAud1x1kfZlfy8VTMIMlJ3sKisR7oBAR3Prosbd7oX
 Z8ya27Jl/umH64P/7AtgHddr899WlsmwQ81vFNcNLNPZfufvTh2AbtIAYBRGXygWS5kY7
 EI/1g3rx4vsLhLGiK11jcAmVG0DXwicVNKATUmsStZmfJbit3IXU2SfJouo/lfiaIR7pm
 dDHDUwFhP8MdNM0WtXOZ606RyrTRu4yQc1OEHYLEafTFepfeNsg+Nb2U01L1mX3yYEUky
 vgwZ3YylLjtdc6LmAINE+MysyNDtba0Kyzd6rWWNyyIXPbyOsLrS6eYYvLWqVIRtBAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
 b=XFj7+Ut1f7mn/Cq4htx6+n8jo4bBr777RvlF/YNEG5ZcMIF9vJQT60PhbA7981O3yUKp
 /VcUcW21gY1KMHmQPkReQulvVO2H0ntaanCC0nQcs7z3GQF2wMvAQM/jfnPfJsuu9V0jl
 F15gdMzIQZB7cNDu+k6sQYjyrlylB+p5G0ef4rKjxQF+E3N8MR949oUedU18yp3ofBJ08
 Bx8bBIhLGxfWP1bt5cQZQM5j25f4iNuJb4ETWCLNyRiZbjPMvWSn1C8OLpP8/qyTwz8a9
 Hj9ZGP4YiQqcDet0FHda5VrkDQ6IkMEn8o3URMTp9MxvIUr9kp61NN5ad237ERmNpSQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Zc1SwbrS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Zc1SwbrS
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D3DE40024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:47 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99c5de614so1907731a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049385; cv=none;
 d=google.com; s=arc-20260327;
 b=hL9P/kYbqRHFlg4k4DPIAbqLaNZHv9RsDKZNGeGAPAZSrV55SI0hLvWGK4bQvj2L+F
 1FVDH+i/jp559ZMGH/5dnUrcVf83EdqQMvb7X0TRShXQpfeBELS/ltQh2nh0V2FeylCW
 7G1C6v02365R7bAIjIuz1G/oSy6LkEN0pf6GoOXkiRUVkzlT83P5zuOc5A9IocXqU5NH
 v70O0n0CLg7EfXOTLx/WFCT5AJ3OmnzhPSvpFFL6QiNK3qgOk+zjRPHwGcyIkpsLQuxd
 WzBV2cgp6WXGwQtO1UlhrswwWwAWETaJTAzs47QGljcqrRN2mMwKlx37/cmui0lJmsqS
 GGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
 fh=3KOOef1gdCWIC8spsCNnXXgJE7J7JIADLol2RiNUR/8=;
 b=GBbtGLocopfCTXwnLFP82bS+ggKWDZd46uRyvIXTXvGgpcdJWaMgPgA/RsonNh+QSE
 m6ntz6IEazxJsLf0tfz9rZ/kLvZe1PWzLQYGsOMKBK5uzxeqWKT07/Xtoixf72VOWUQa
 C7muoGjczKNh/eeGpaeUOcLOjutiG4nKTWo9ZZY3U+um9ReGOuzjtmBuQfMWODl9DqBr
 lnhghJHUUdairW5IArsJHN7GPOSMB0BOxhiRSo3Ovqb3Wl/ErtP9md/hebNUDJyVqwlG
 klBX0n2OYdu5OVR5TwgFFPunC19Lvs6+ieoGj3rXYEuiIDmEqP24H+FOFQ/rphIHBAo8
 8FvQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789049385; x=1789654185;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
 b=Zc1SwbrS++3F248kMdBpUdrgUdyGiG08lJxIwHWrs0qfnOYaa5JU6T1UGodIN97tJ7
 1pKVB1K7FUmL7QWBPhHL88cRh5Pb1nLRWaQCX/cGnW/ONCTOVkGFi99ThIdmgS5e9RhM
 OMKVzg+sJtJC7+f85PadbVZdBdIAn4zbVqY1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049385; x=1789654185;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w9uqBaG//LejRaHp+g7V6xev85HzU5s370svLRI+VHI=;
 b=FNqQdIU1X06xsbjPEI28TpNpHzCf7oSFryLSam8+vWQgbVnZU6wyZKEnWgdSoAztj1
 TXfbAoxZNF77ELKAcO3ZW8KuJicBP9tPibkXJWAGVfp6L9La9OSgQavqhSDqChaZplTU
 AGF9I1nJSKMdegkzpabiEuzpbhur+i1dectc6pCArsFYKNPfigtNjDDP1rqLXVf6/AVt
 Uo0VWKsggtHJ4ADjxVDxAbb41wZ8Ap1eh4Nkes2mDZF2f2ZDkM0qJUal3OiZGxM66kI8
 DOQt45ERGa0WqJIbAWMr5p+rMvTGDGdqfM2lMZOFHe2hvfde+KXfdmY+DfE9MWb5+SSD
 ZnBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiKXjQhQLrbYkEarvQtjhXKQlrC57/5Zw3eZXZ7MM8L68hJz5ix0peqshinRCj/4fUqg4wk14=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m0Jb4N1V1+PMmWewX5Mu3GmvfZxR1wQfDuFbeohCOau0YUU0vw
 yUDj02rFW2WqqOBGoovHg9XlIvfDgYJy9M8K5Yw4P5q1dhp4f2hsgs4P+B347AXHw1EqG4ObUVE
 deS8oB8d2yb0T9MM4O+sjpTt1FKftadSI9goGMU5I
X-Gm-Gg: AYBFou3kpHwdt9+eN/0FNkSEr2g91GUhPn9bPKYeJdzbweYgNQ+jNB/ZT+/MIMdgV3g
 4I4pS3TzRbBWNvkjgI8QseaYlKd34XzFh8VZ0EEKmg3Nb6vJSuBWhTfx/TlYvg/PlkG8pgsILfe
 MfsVKRGv1AK3A6jMDrz3FjXlg7yylKjJlavgBGyROfPIlbTQ2AvkBNVW1sgovAArjOP0oGQT0uB
 R2WjzNenc7sGBbZyI/r90f/MnaPoWNte6/To3imTiUsN3q//WQiS0WLzrzKqVOy70mAMlfUdpGr
 6NiRga5qh44o6kftu2ogyf7szHuuy85dz5JVAFYDWpRMOdRH4/L5qg==
X-Received: by 2002:a05:6402:c44:b0:6a6:7fa6:f0ac with SMTP id
 4fb4d7f45d1cf-6a99cd2a2a9mr6580345a12.22.1789049385417; Thu, 10 Sep 2026
 07:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
 <20260828105210.32664-5-mehmet.fide@gmail.com>
In-Reply-To: <20260828105210.32664-5-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:09:34 -0600
X-Gm-Features: AcwNN1VZKuo0h17E7xOfhvtKCoJ00AkiWDFDe2bAqofDryJS6My9Ldq3kJG4EAk
Message-ID: <CAFLszTgX_s5OB7dXP_FY933yBMRNN79wCQGpXC6wzhFw80U=QA@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: dm: check the fixed regulator claims its GPIO
 at probe time
To: mehmet.fide@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Ye Li <ye.li@nxp.com>,
 Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mehmet,

On 2026-08-28T10:52:07, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> test: dm: check the fixed regulator claims its GPIO at probe time
>
> Give sandbox a fixed regulator with an enable GPIO and check the two
> phases explicitly: after of_to_plat() the GPIO is still unclaimed, and
> only probe() requests it and sets the direction; enabling and disabling
> the regulator then moves the pin.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> arch/sandbox/dts/test.dts |  9 +++++++++
>  test/dm/regulator.c       | 29 +++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -883,6 +883,15 @@
> +     fixed_gpio_reg: regulator-fixed {
> +             compatible = "regulator-fixed";
> +             regulator-name = "fixed-gpio-enabled";
> +             regulator-min-microvolt = <3300000>;
> +             regulator-max-microvolt = <3300000>;
> +             enable-active-high;
> +             gpio = <&gpio_a 10>;
> +     };

Pin a10 is already used by hog_input_active_low further down in this
file. It happens to work because the test framework binds but does not
auto-probe DM_FLAG_PROBE_AFTER_BIND devices, so the hog never claims
the pin - but that is a subtle dependency a reader cannot see. Please
pick a pin not otherwise referenced in test.dts (a15-a18 look free),
or extend the bank and use a fresh offset.

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -883,6 +883,15 @@
> +     fixed_gpio_reg: regulator-fixed {
> +             compatible = "regulator-fixed";

The node name regulator-fixed matches the compatible and is what
uclass_find_device_by_name() then keys on. If anyone adds a second
fixed regulator to test.dts the lookup becomes ambiguous. Please give
the node a distinctive name (e.g. fixed-gpio-reg matching the label)
so the test is not accidentally tied to being the only regulator-fixed
instance.

> diff --git a/test/dm/regulator.c b/test/dm/regulator.c
> @@ -195,6 +196,34 @@ static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
> +/* The fixed regulator must claim its enable GPIO in probe, not before */
> +static int dm_test_power_regulator_fixed_enable_gpio(struct unit_test_state *uts)

Patch 2 moves the same claim-in-probe pattern into gpio-regulator and
fixed-clock, but only fixed-regulator is covered here. Please add
analogous cases (or parametrise this one) so a future regression in
either of the other two drivers is caught.

> diff --git a/test/dm/regulator.c b/test/dm/regulator.c
> @@ -195,6 +196,34 @@ static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
> +     ut_assertok(uclass_find_device_by_name(UCLASS_REGULATOR,
> +                                            "regulator-fixed", &dev));
> +     ut_assertok(device_of_to_plat(dev));
> +     ut_assertok(dm_gpio_lookup_name("a10", &chk));
> +
> +     /* reading the platform data must not have claimed the GPIO */
> +     ut_asserteq(GPIOF_UNUSED, gpio_get_function(chk.dev, chk.offset,
> +                                                 NULL));

gpio_get_function() returns GPIOF_UNUSED whenever the pin is not
claimed via the DM name table, regardless of the sandbox pad state. So
this assertion only proves 'no dm_gpio_request() ran', not that the
direction was untouched. Would it be worth checking that on sandbox
the pad-level value/direction is what pinctrl (or the reset default)
set?

Regards,
Simon
