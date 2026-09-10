Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053A2C88E40
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C286A81097;
	Thu, 10 Sep 2026 14:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6JnIo_jFUqp; Thu, 10 Sep 2026 14:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CED808107D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049198;
	b=SUIsvXp8+AesWh2IkORiJKLqpYKf02rmQ6IxOun2+HQgYCR/KWUbxs5P4+f7v14Hhwuq
	 T6wViHZbBAUKv5is+bQmyX/uC/rQDuiw2UuLxcjPVR31oDum7Le6CnwV0B/FdGFmuMuzu
	 Su3tKRdFYyWGmriMIqXm8z05ZZFrTWR8k6BuXHcvmi+w9pjzed5P9/YIE9Cc78mCBVQgW
	 UcYf3bZ1Fg5w5F88E5bQzEkkjPPUxwNJnlm3yuYmUXfcuE8nONOb/qJzcrs7du8K+vg2I
	 lSBS2ByGnLlxvIod7LuA4ETr4edP9E8FX6f4dhdo8wgvr4eMDlEOdUPiunQhoOfUFEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049198;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
	b=K2d2pAt4RIzQidIqgzjnWGDcgtSfbrmRLrgOX0hmnME7NEG97FitMZX7j3P3H4bIXdso
	 g/9mZzC9VyvGLofJXTKqOaopoBtm6pilXr6XEC0UtsyD8zCXA1wVeanqhw8lhWXwXZ1yf
	 OQhCPnwOB8d3m4/iDUUoUvRO3sAcufVQcJJXwBlMACmlgK/L9B1KQhO3fnD+RV1lF8oS1
	 Q+e94tyuytyPp2AU7GTCLONTbFKhpv8HHNc59daXKpv0iwcUMFWdyLXmfZYtbNPt+C3SE
	 5dvBNedJWrWoyeoq43SQodj+3sgKXDoiJaJBmOTWLdQU5TvSKaBbf0Gdb7y254zbwpQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="g6/r2dIG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049197;
	bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FiZZVbX7p8NPptGgLcEkxmogDfctTduDAZJPenkjgM5HdFeRJgXBehfpifVJZJrma
	 mN2SVNc/14J3inKgb/JcUT7YRM7Bj9f1dydFX3VFvXnCe5MNdPhsl3MS3G8mByzarT
	 wqW5jq/NWOeWyClgRmZzpMTneAc1RjkLH8xdQ7OHGKE5FnMVCor3dZsccJlm6co/PH
	 ItzzZgLbXsCVKZ9Q3Dyw7FKJMOH6k6YOHIKPC0VBlUIR4WW2Lzygnk5tv4gnQ0IGbo
	 saQyfOPL2fGMpD24n73iM9baA9xikXCeEEwwICBQbDGr3Wi5pa/tO8HXF0W158PpYM
	 WHyLp0TZfZUiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CED808107D;
	Thu, 10 Sep 2026 14:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD7A143F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA6968107D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJsp0p4PCJbb for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 550CC8104B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049195;
 b=lfAcLOl5zdr/+iLT/zaIw/kU+IPsmdzObg7v8raN6KT0gFkpnQeUsNXLsr3NhnP5Z4yA
 Jy4RFGRpUh2kBqpA+btOs2ncJMS4mWtZ8Da8ylT/17gd0ZCvoYjkLIrskjMjSbQU2fdyn
 f19xkxls5TyuWQNe7+lGyVqGeq4ECKbiFfQpsdSrQgX5sX5p0UnAq3TpqNMbQdBf9u5Q3
 RJYAKeFxgNWUwgWJmJR7rewVX/El8gVkRlZvcVTdnepo7cGBYo9HtTUeotZGIllpMkOZK
 0tVcy2Gzz+Mad7IR7XqjzZxmQa3Ga1TK1rwNduh0dpP0rjw0eCmyLYn80Z9u4wwEYDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049195;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
 b=pXYzjwpgztsZZPfRJJCXGWiBOjVLJ/UevNhVU8OZs61EK5Xzt2ztd1/D+O0WkhyE4t/P
 b3dKrju+MlHhnET5Y0BC8kDVMa3XzUoaf6Nu5kYDnK0o4h6x6sEl0OQeQwD4DTDOa6R4U
 DkIfmy3KdjEzOqmqRMefu01Yy0y5zRcKzCGVt6RGuvJDG1hGTq9t/V+w+Ssq0Zhgs1meX
 HIdrDjAmOTkuSp4/c6u4uFFHqO91qdl8+2X0vBKEbQWN9Oa0yixXNBsQ9DKziGs35jc6V
 ypRhGPKV1x522opzgRehhb/RCLihKrxCMkBbkPU1/vfRRIiki3SqJIz95vU7CsZXgWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="g6/r2dIG"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=g6/r2dIG
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 550CC8104B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:06:33 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a7f5655823so7711437a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049192; cv=none;
 d=google.com; s=arc-20260327;
 b=BHANAiJ3zzqy2CZohmQZK0nldmUfrSCqC+mM8ReJl5w4y7/+1mIj9WF4zKvnE9NSY4
 vpG+dGGM4PFG1oaDF29OLYbdbDQVl8+hBzN95TEh3JlVOjXcWxpOZ4v2TS/vpA6K+Ppg
 9IYtIt6BT5FDApwVoj1sNTLOAptIqqTe3GgyOWLurSn5ZYRKsMwwhSRn+46k6cgbXX4R
 3sa3DfuCu/MZdsOZZzJzPzyKPNfDDqHvuzAtHJCGNTh7h74a1wrg9/ErCgpzXPP6GBB9
 tPFYX4Qwlzv6u5lT+GyXr7ydJMcdpBq7c8YpjioVdKPvtEhlqmvSkb31RZpeOgDb5zZB
 9agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
 fh=iUW9C0YKtB4Kk5ljufEhz7FDh9wbE43jzsyOO+ARQdg=;
 b=lqWwe/OYzUihfEBCOoNrfU7jUmQ4/pTrdWo/x/qZoLnGJ511AQ/ebWhVNP5StyqyWN
 ctGH9rYMi2EfpB8LkdnR2Uns/HlKXkiK+9KhXfYE7kw6gPIMRGCvmvP5xxnFGDMP9qvA
 c2Y2BlhjRFBPkO7xD3ImRAGgZrYStZk9cFzWAsHo49kenayL76bra8ekzM9I22u+c9eH
 3gqaTIx6xHSOq859Q92tMljVBe5l8PlxXkT/HERcDHrjIfsYsU5bzeL92yvY8RS3dyI4
 YaAqpSvFRPMi3CzP0XzM3dJtvNBX3KD1h9pNtCn1ST7NCKnLwcUdZjMIR7nRxqFNa02B
 vOiw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789049192; x=1789653992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
 b=g6/r2dIGXm458t8j12YFsKcpcb+NrZUNS/AKR7ZznXH+7ECDl3UDOsGbhrJKcWLyPO
 qp9H7Vs58nnrPKgsyssINNmTHZha+vVGs4csEZVflBlOGW8J5DGeAbKA/KmyhXfK9ppx
 u/P0f+31K9a9KgPrscZzETh0GTvfBoiRcDeoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049192; x=1789653992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dn/NnZ1ZKabcmpn/fdHxeupnn9qsTqpcxwsbxSmeknc=;
 b=UF/uyWPtf2kPZKg7dEKbHWtD6LGoyhefOJPjZbgWOhvbK7D9MTYwA3uj6eSLHgMk+F
 MYBj3EF3x8d4iHNo9iydVGELLblMEnA4Zk0dyr6RsxhPPEToEInaoVAakg5qrHuTvdZm
 0vyRd8rvp9e+EOw0wDka/wUZV0/yHNbE+Kt++gCGFdABT3qal646sYOvXW79mOpPn0F4
 nzwhtCL03L+hUjMylgzA2q4TonblLHZLL1RCWr5Wk9Rk1o4XxE+ELtQocKQkh2kYrX3G
 sdSRezULHKbEfS2vyOKeRQSwYR/9L/6OdJhPxuA+WE4f9u4ZtYVLnrJ08X2DXoOzjY2X
 HYPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5gWP7kKOmjf33s7z9BPBZ5/tSsBF7/t1UlXpWFMLfyGPdc6L6QiWQuC1aIqvpr651PRhe1gU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k/rgc2Il2SvYc0SO7TXMaMzNeN5Ugo9U+4808241mZ4DN153vI
 zKooi26TgVp3QT7O1nKnJNgyoRE6U1BhXdNKPHrSZ2XbCqe5/ynK36ykkokIY9To8k3v4TP+3XM
 IxjDUGNiZReaeY1oxhzKEP5qCa5AOmgoDXkt4s8CL
X-Gm-Gg: AYBFou0IBSO/g3d1dXhJeEF2OooLMFz7u7VrbLMCJu0EBWSQo36PysbUUo82thM2nqE
 05f31xk3mEPcOrkROKdA3m8nCBO1qXWOq1knBuOi95x6lsjPR1TCckemli9LiWFs5tVaETHWFaV
 iF+JNpwxgDGXCjSp0wQHmBxBGxTdZSWKpeQ+53iA10dMeyvMsEMGWOQIrvDlduqAQzfRYyfm5nF
 lvzJ7wDpLGSqNJYTLQ9M+L56MKqUSSclhfpDrrNBK16ZoH5ZlN1tUWDgNgtEJsxvqv+enSD5ZUF
 buwJs7fO14V2tF82V6idr6oW7If6RyowDak48CxjNbJ5fv1dOViHgw==
X-Received: by 2002:a05:6402:20da:b0:6a9:ab34:cf67 with SMTP id
 4fb4d7f45d1cf-6a9ab34d133mr910282a12.36.1789049191902; Thu, 10 Sep 2026
 07:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
 <20260828105210.32664-2-mehmet.fide@gmail.com>
In-Reply-To: <20260828105210.32664-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:06:18 -0600
X-Gm-Features: AcwNN1X4QQzY-ZyLoLT78hu5DvBiyWlVvK84ZCRs_0V8OtrDUxQ1mkybL7LcgAw
Message-ID: <CAFLszTjApvPONDB9bdyuTA8dqbWvgmnavsQD=Xy2nit4FzjNHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: add a way to parse a GPIO now and request it
 later
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
> gpio: add a way to parse a GPIO now and request it later
>
> A driver's of_to_plat() method must only read the devicetree; probing
> other devices or claiming resources belongs in probe(). Several drivers
> nevertheless call gpio_request_by_name() from of_to_plat(), because it
> is the only way to pick a GPIO out of the devicetree: it resolves and
> probes the controller and claims the GPIO in one go. On boards where
> the consumer's pinctrl touches the same pad, the pinctrl state, applied
> between the two phases, then undoes the direction the early claim set.

I like this approach. BTW clocks and reset lines have the same problem
so we could deal with those late as needed.

>
> Split the two halves: gpio_parse_by_name() reads the phandle into a new
> struct gpio_dt_desc without touching any device, and can be stored in
> the platform data; gpio_request_parsed() resolves the controller,
> claims the GPIO and applies the direction flags, for use in probe().
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> drivers/gpio/gpio-uclass.c | 33 ++++++++++++++++++++++++++++++
>  include/asm-generic/gpio.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/dm/gpio.c             | 29 ++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)

> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> @@ -1219,6 +1219,39 @@ int gpio_request_by_name_nodev(ofnode node, const char *list_name, int index,
> +int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_desc *dt,
> +                     struct gpio_desc *desc)
> +{
> +     struct ofnode_phandle_args args;
> +
> +     if (!dt->present) {
> +             gpio_desc_init(desc, NULL, 0);
> +             return -ENOENT;
> +     }
> +
> +     args = dt->args;
> +     return gpio_request_tail(0, ofnode_get_name(dev_ofnode(dev)), &args,
> +                              dt->list_name, 0, desc, dt->flags, false,
> +                              NULL);
> +}

The original index is dropped: gpio_request_by_name() passes 'index >
0' to gpio_request_tail() so the request label gains an index suffix
when index != 0 - see the '%s.%s%d' branch in gpio_request_tail().
gpio_request_parsed() hardcodes index 0 and add_index=false, so a
caller that parsed at index 3 ends up with the label 'nodename.gpios'
instead of 'nodename.gpios3'. Please store the index in gpio_dt_desc
and pass it through so the two entry points produce identical labels.
Your own test uses index 1 for 'test2-gpios' and quietly exercises
this - worth an ut_asserteq_str on the request label to lock it down.

> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> @@ -574,6 +574,57 @@ int gpio_claim_vector(const int *gpio_num_array, const char *fmt);
> +struct gpio_dt_desc {
> +     struct ofnode_phandle_args args;
> +     const char *list_name;
> +     int flags;
> +     bool present;
> +};

Note that list_name is a pointer with an implicit 'must outlive the
desc' contract - current callers pass string literals. Can you please
mention this in the kernel-doc so people don't (later) put a
stack-allocated buffer in that field.

Also gpio_dt_desc reads as a peer of gpio_desc when it is really a
pending/parsed version of one. gpio_desc_parsed, or gpio_dt_spec,
would make the two-phase relationship clearer. What do you think?

> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> @@ -574,6 +574,57 @@ int gpio_claim_vector(const int *gpio_num_array, const char *fmt);
> + * @dev:     Device requesting the GPIO (used for the request label)
> + * @dt:              Description returned by gpio_parse_by_name()
> + * @desc:    Returns the GPIO description, ready for use
> + * Return: 0 if OK, -ENOENT if @dt holds no GPIO, other -ve on error
> + */
> +int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_desc *dt,
> +                     struct gpio_desc *desc);

Please note in the kernel-doc that the -ENOENT return for a
not-present @dt is deliberate, so a caller with an optional GPIO can
skip the 'if (dt->present)' check and just tolerate -ENOENT - right
now regulator_common_probe() checks 'present' first and never sees
that path, which makes the -ENOENT branch look like dead code.

> diff --git a/test/dm/gpio.c b/test/dm/gpio.c
> @@ -257,6 +257,35 @@ static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
> +     /* parsing alone must not claim the GPIO */
> +     ut_assertok(gpio_parse_by_name(dev, "test2-gpios", 1, GPIOD_IS_OUT,
> +                                    &dt));
> +     ut_asserteq(true, dt.present);

The comment says 'parsing alone must not claim the GPIO' but the test
never verifies that - it just checks dt.present and then goes on to
request. Please add a gpio_get_function() check between the parse and
the request, mirroring what patch 4 does for the regulator. That is
the invariant this whole series is defending, and it belongs in the
gpio-level test too.

Regards,
Simon
