Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CCDC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2123F80F56;
	Thu, 10 Sep 2026 14:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjxAmINtCvVw; Thu, 10 Sep 2026 14:09:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A78A80F70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049358;
	b=qvFdmzmW2vXtgnp3IH+9Idq4DKD1Sv0EEs2G18CmCBIaUV+V3V9iWCnFzxEJOVhGuzHv
	 l8XAFkDIyY3/fB8Yh8fIlDMZwhPKQ2fMQw9d0qoz1L6tVFzWUo0awMzsp8xpXTQi+/3/0
	 /f9W5Afw+llnXaFGrJQUelak2664rFjj0SB6cqbpia/rYSTfDCeBTZHAyHzDESwj0q8jh
	 8236J201xu4pA03Hsom72FmYxt7NxgoOaOGIh56hmOLGDr8Dcnxi4W0VLJt2rSrANV5Or
	 yxty25DtHOmDl8OBj3z4LuJ35qU9IGynFsj7mnsqaUJ3MyUnkixBOqu24l2TLpzCC5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789049358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
	b=JgH+S2t6KigFreOjmxgcFgs999zFHwA8A3rWZcl4ouIRBRo4RDdUQyycm3+ZSz0YsuEW
	 o1QlmmLBtZKNqMnxnW5i+cXr3ap7XQbjF5sFhwzOdOOpZnmrbKQoKOjUD0zhXECWxj1Wf
	 BgiqKX+Km9p+At96SB+eRM6gb4NbUF/6lXMxeHCFaRQffUCcYGf8q4l0jDfRQVdPm422P
	 Rp5ydzZNwXNHybQpKfC1Fbru7xf/+rjosSmZe5Lu7P/14ht0IPiytjZgw2slNJwcP2ttV
	 UEeRwFtAMc/iGptl9AgxHXYlFXAUd+5umcR1R14cg4ZmXXubSNdypjbRaOyyDKD6oFQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789049358;
	bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jW0tSO7fY4TehA9d3qqu8ZRSBysPZkFII18zVbHwttl8xKqeBtVMgQ9HYKq54W+YU
	 yHc45w4Vm+XgSbpNKI39UNZAAJDBQjPpat1Wix4+N3WiD6VuiEM85cqzhjgsm7MaIf
	 twVT+2nnach2bqIxBLGhKToK7KdILj+EeYuTInvMWMh5H6x6b0S3vPpccZUWo+8TkC
	 ko2o5dmBU0IscBGbObJXBf/eAmIbUNT3r5+0AVXD2NVZf/w9Oj2tco6irACFS5P/Qo
	 VlrVSyYhCsjVWzHlKYrzWY4w5Oh52f9JpHncS/Y24l+jcO/oS7a+jwM/5d9XaRgvzB
	 JIPxbYy1rUQyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A78A80F70;
	Thu, 10 Sep 2026 14:09:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2622268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 934E960874
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lrytDEgJfmy2 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:09:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 084D6605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789049353;
 b=fvvIq63P2+sM48oF5ESx7fHFSOyNYavla7hxh9htwplAvQ74G4rPghvR1I1jbikqQsFM
 gtJjWLsYf4i7GD/SiID9dzDaS36oZlYgOa9ofervDzoZ55BIgavJ3kNNBmPdrxcIo7s+w
 P1OaGQ/i48SgNcOGm/ArJMAR85fCdyRMdy1uDRLDZou4AjgwwwSap9jsS/mraxBSeu5lF
 mhxoPM5PJinW82CXX3aCtJOJLgKGfnPI30RKU2TgPzDraNNvZhrfhvsYULZOswNVGQuVu
 3Si0sMGA7q7PFl2f/+7AXni8tDzCnlHnqRxT/D9cd424+r3avGpFFnOLlrFYOWeIrUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789049353;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
 b=WW9ENBWqMXtSrKxjtuL2E/4kvyQRMFZgD5JT4DB4SdGf+L1IE2Spfm3wpFX0f5XuzEbF
 nRNbCcfCcRXrxr1sLNKuTaTG75LdEdw8YE9cPLNnvabatXWze44BnvwTyo+EmCDFKoftI
 Vrv7nEKSbzsRku/2G49Euhfc59yGqqYOnat/CQfGSmng7XV3mTkarO8T98BVkGzFfGmqk
 zdNXPp5oTYG2/TK/5998PPaO8lKGihfh8omBMYnEYzldnyB2t5ZzSiShDzp4UTob6glLF
 FZPzdUZxx7vNgTXK3JFfzELe4j2GwUUhUPXJf/iykO/1ZZ2k+cq0ObskIIGolZcM0Rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NSZI99tM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NSZI99tM
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 084D6605F5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:09:12 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a7ea0046deso9108833a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789049350; cv=none;
 d=google.com; s=arc-20260327;
 b=iACwq9bsyVthTZ0leeufU8lkIgxX5yq+dVZ4kYww0b73bBCUH2sE6dljw8AauFfOGP
 SuirGhFEkP7t9znFdJYwXTQ2MatXkyD5VqYlBY96t9SORSaVpylormYriX34M2zWDlFJ
 kZYV6dpvi32N5c9clVN6pVxophZ45FtsJKQHI2OMvMaQ8TGD2595OaQ/VlS99Ptwc8JO
 2mLHg7q5gGZ6jCkmSE9a0LXXoFexJ2EXwhZMyKhUn7rZjc7W9WQn5I9UMGlhG4tMTwhl
 6O4p37LNrmKxzbK5bhkB4LXB+qDss0HbnpFNkX5Ah148u6dVQudeC+E1tSWeLodNRfAN
 PnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
 fh=wMMVPNuq1YmcuhA4JaRWGXxXexXKxp7ZbhoIGNGLZm8=;
 b=lU4czWqP76L8PejtagLS056dehKNiiKEsVIOGNrd69Dy8063q0oXVC9byXK8XKernH
 rweahe/L9hN/LgKYq8Cl54/cLQGFj5ATGgJuDQIfkC9IAF8r819QkQhssobUZLN7OaY2
 q1VtBni6p6tKlMJ/QdIf0YVszwJ/BcKk8wkGtvoUP8VyNAyyJc7PTJc+PNnqXBvm2aoi
 01Y9du3i7fVltomCEo7gWInv1pPbvIpwHv2HIhhfA7wKhPKsho64WQmTwzttIA0kpN3s
 6YlPmmVrahV8dJuTsrCmtky1rfPe1a7HtnlqgoAtsijaN1Py6cesawWaT/u523FhGk+a
 0/CQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789049350; x=1789654150;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
 b=NSZI99tMOSqQxU3OWGP/2kYQugCLUREIMlOSQVtVpwDWgSuJUVquZg+3B6AqOuBM0C
 KmRMSrLYr27+IJkV/YFJaUBN20OIyTLhV4tCHkiNMSlwKRXq4AqYDar8QkhKo1lnBSms
 XOS2v5p5SBZ6NoeYIcVtKDslOvdXUWmW2zPUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789049350; x=1789654150;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zeP61puSvm1KBiaB8NgeBZGLea8lJpmFy57aI2dtkqo=;
 b=BfWD40OO71g5f79YTOv/KjXOVPNlL7wncemQgDi+5eO5ECGTHaQW0UtLA+sJxPdLNd
 jPekND9oIejjsBLiEQ2aOnJO8gCjPdoQS25G9pKNxDvhY5VMmSPl6GisJa42xbGCEDY7
 EG9KzeCod9n4LMV0k70HEFQ7DcalH58iW/SPSernWpsAztNMbIkkp/NP7JXZkKjLwFBD
 ktxfMUjomg/Z3nwtBFohEyLhuJ31l+Pl2QZnAV9PqATawOWwi/RxWBvTKhvnU1A3MYGq
 XdNEevMx/dGuvaqFT2AKY6Vd5Pl0R8Ec5hJXF4WYNIFqfEE687UkAza3PUjypt0wO30H
 1AYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAbO4DQacIoUXt18qTSXWqJxVwJILdYdUe3QVBcaDe/vW9xMpaJFPKXMMLZhz7kW/JQbmj49s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kLBpFMOJiD2rzr/QMKkIiIPPlJ9jJfV3BQKxrdcJqSop6y28gw
 /QqW4J5OwXLh1VIszCf9l4fr2Fhgwem0Z34agFQxnQ2h29otAKiIwEsh+ccu6TmblEeQ2Z004lC
 9flpZtj+BbMzcN143dTo3oytmf7bMgmk6nlysEeD2
X-Gm-Gg: AYBFou3kvz5uB5rqrIGmaBEmz/Ew9XzwuOMkOjhZORmr3xsLee6dN+6oz7z4mXw8kWr
 0E4DQpwHm630mHRf4zQd9mw7EePQYR1ec0X0DxPk8e6DfTjAySlfpEvBK624LUxF90rhib/0dxg
 tda/0EEU9L/wQY532pbrIOnsiOBo0cRTu3bNMSWEvGu988r51xpcehAq8R506eyeR/Zqz7Isb9U
 MtwR89cQNeVdrMQrqi2cakbvXShw8PAD1Bv/gMYq7vtvD660bUCoghuBJ4XPbMaqicEVgdB4joo
 vX5nwznJGdAKbqjwUg5oei7erZB2DguSIThCQYE+xIGPet9gt9vFaQ==
X-Received: by 2002:a05:6402:3546:b0:6a7:ee56:8158 with SMTP id
 4fb4d7f45d1cf-6a7ee56823emr14567895a12.38.1789049350523; Thu, 10 Sep 2026
 07:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
 <20260828105210.32664-3-mehmet.fide@gmail.com>
In-Reply-To: <20260828105210.32664-3-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:08:58 -0600
X-Gm-Features: AcwNN1VVyinwHCC0_X01HMM2E95QcH3SaGhazCZ5qWrxlhR3QKQapPfry_V89t4
Message-ID: <CAFLszTgNV3_vOO4o6rzVabU7+amqLR2NSek3xU-05kb_jvpv9w@mail.gmail.com>
Subject: Re: [PATCH 2/4] regulator: claim the enable GPIO at probe time, not
 in of_to_plat()
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
> regulator: claim the enable GPIO at probe time, not in of_to_plat()
>
> regulator_common_of_to_plat() requests the enable GPIO, which probes
> the GPIO controller and claims the pin while the consumer's platform
> data is still being read. of_to_plat() must not do either: it runs
> before the device's pinctrl state is applied, so on SoCs where the
> direction lives in the pad register - the output enable on Vybrid is
> one - the pinctrl undoes the direction the early claim just set, and a
> fixed regulator configured as always-on powers nothing.
>
> Parse the GPIO into the platform data in of_to_plat() and request it in
> the new regulator_common_probe(), called from the fixed and fixed-clock
> regulator probe methods. The gpio regulator's voltage-control GPIO has
> the same problem and moves the same way.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> drivers/power/regulator/fixed.c            | 11 +++++++++++
>  drivers/power/regulator/gpio-regulator.c   | 21 ++++++++++++++++++---
>  drivers/power/regulator/regulator_common.c | 25 +++++++++++++++++++++----
>  drivers/power/regulator/regulator_common.h |  3 +++
>  4 files changed, 53 insertions(+), 7 deletions(-)

> diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
> @@ -28,7 +29,6 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
> -     gpio = &plat->gpio;
> -     ret = gpio_request_by_name(dev, "gpios", 0, gpio, GPIOD_IS_OUT);
> +     ret = gpio_parse_by_name(dev, "gpios", 0, GPIOD_IS_OUT,
> +                              &plat->gpio_dt);
>       if (ret)
>               debug("regulator gpio - not found! Error: %d", ret);

The debug message is stale once the request moves to probe() - a parse
failure no longer means the GPIO controller could not give us the pin,
only that the phandle could not be read. Please reword (something like
'gpio-regulator: cannot parse voltage GPIO') and add the missing '\n'.

> diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
> @@ -76,6 +76,20 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
> +static int gpio_regulator_probe(struct udevice *dev)
> +{
> +     struct gpio_regulator_plat *plat = dev_get_plat(dev);
> +     int ret;
> +
> +     if (plat->gpio_dt.present) {
> +             ret = gpio_request_parsed(dev, &plat->gpio_dt, &plat->gpio);
> +             if (ret)
> +                     return ret;
> +     }
> +
> +     return regulator_common_probe(dev, &plat->common);
> +}

This quietly changes behaviour: the old of_to_plat() only
debug()-logged a failure from gpio_request_by_name() and carried on,
whereas probe() now aborts the device for any non-ENOENT error. That
may be right, but please call it out in the commit message so anyone
bisecting a regulator that used to 'work' knows where to look.

Also the 'if (plat->gpio_dt.present)' guard duplicates the check that
gpio_request_parsed() already does - the whole point of the -ENOENT
return in patch 1 is that the caller does not need to guard.
regulator_common_probe() below takes the other approach and reads
better; please pick one and use it in both places.

> diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
> @@ -115,6 +120,11 @@ static int fixed_clock_regulator_set_enable(struct udevice *dev, bool enable)
>  static int fixed_clock_regulator_probe(struct udevice *dev)
>  {
>       struct fixed_clock_regulator_priv *priv = dev_get_priv(dev);
> +     int ret;
> +
> +     ret = regulator_common_probe(dev, dev_get_plat(dev));
> +     if (ret)
> +             return ret;

Does fixed-clock ever actually carry an enable GPIO in the wild? It
shares of_to_plat() with the plain fixed regulator so the parse
happens, but set_enable() only pokes the clock, so the GPIO would be
claimed and never used. If the answer is 'no', I would rather not add
the call here at all; if 'sometimes', a line in the commit message
explaining why fixed-clock needs it too would help.

> diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
> @@ -10,6 +10,7 @@
>  struct regulator_common_plat {
> +     struct gpio_dt_desc gpio_dt; /* parsed enable GPIO, requested in probe */
>       struct gpio_desc gpio; /* GPIO for regulator enable control */

Once the device is probed, gpio_dt is dead weight in plat - the
phandle args, list_name pointer and flags are all baked into gpio. Not
critical, but on boards with a lot of regulators this doubles the
per-device plat footprint for no runtime benefit. Worth a note in the
commit message that this is a deliberate trade for keeping the
two-phase split simple.

Regards,
Simon
