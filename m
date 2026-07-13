Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2CC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289F284852;
	Mon, 13 Jul 2026 02:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XYgExYeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4716D8490A; Mon, 13 Jul 2026 02:18:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666ED82991
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso1975288a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901918; cv=none;
 d=google.com; s=arc-20260327;
 b=JLOS7j0G4Ds/frXVAgaaLaOhliiWHixF0z2d0vrXKCl0STw6vFJx6r7KKLjXZ4PkN3
 RecLuNMa9jHNHaERLqKN5XXXF6Yo8fLtY4QZYFZPmUSMSZO3xPrnle43x1r4Fnk4Ppye
 eQf1CYzQ+Qzcm2vcqylc/qErrPtmVVjce47DEvznREzuREq12wchUFNnDdeEYttW6kRj
 mcgTf6OPpVtjgjPUiH5pxF4OPVOf+ebQ9PM9zoyMYQAKp0stzuERxfOkZ68wC18yEnGD
 /lutoZS/BKl+9no/sCzeSI282CivDmezEA7GvLlOloWARs0iB48goFvkc/HxkJgk/3zM
 tJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4mdhAale3JlHxqwa8929HRo2JzVJtsBuWRySKgff0uw=;
 fh=jSYivEfN0I8J5riRSZde1XX2HOw0bO79/mvTlpTZjqk=;
 b=a6dj5yTjlvoUUYis+b79/rrfzLDpGWjdWjHLmzgFV2hx7wovP3MNSBN14hfI+iGJ5c
 glmWwnrE/Al21a69OCqNxxTTRQxVfQbcuM9qrQaVWeKuD2m3FKYXj5xo2HC35t3clLoM
 hr94MdcoF8qXa4H0SsuXDclvrT28s1CWb5vF+Sg5rswia+pmwizVaLWqVNcIAvJ3Ot3Z
 MJTg5xXsJmLUanb2d7hAHJLTCYLsUhtfEXiOzyX7Pfq1ddFNTRWzOgVn6aYJC+aLauCg
 EIGCR1cL11Pv41exzlSctwZ6R6NnMm7SWeDMZyKOsBGgWismAb5LjvhPxwv2gXuR/hty
 jmnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901918; x=1784506718; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4mdhAale3JlHxqwa8929HRo2JzVJtsBuWRySKgff0uw=;
 b=XYgExYeBmDWf4eNvoAHYjH4W8BMUbkNe1TF77nv245RUi9alcUrW6/WRqUhSfw9jl0
 IkRuJpG3ZbjuZqWZtX6nzcYUt/LhpRBhfTXHy2G4Sf3eDiGjucVtzOeFYWjuCXCSsIIZ
 8gUMHkTK83MWInoK7tRmnzQSkY9LrmVT4fqc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901918; x=1784506718;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4mdhAale3JlHxqwa8929HRo2JzVJtsBuWRySKgff0uw=;
 b=EFx57cgZIctfQ6BTZoonvh/t+3aIxX2ZEln+0EJNVAImZtBT30y+YVp1J6Ak/lVVHK
 ldud6eOp6bCjIcJX/62Cugi5yKUcMqKAAyQUmoj2NLns89wPz7GXr9nVxWnOJaXfu17n
 4E2dnFPZRhccP21eWnO8SnwsuNW///I/fWpzoR2JuimJed8elVLYvAMQjYuYaI9bdadM
 Zz1tpTLoU7IZ7Y6RR71Me4+eD4Zt5h2bGoHs42WHRnNsm8PD974OtG/GpzFw2eIQpWsS
 /m8F8+btO1iIc3PjNR4Eagx/BAqOeEjYoFzhCURv3sUjzwF+GPtGz0dByXqRwghZ+8YM
 dLNw==
X-Gm-Message-State: AOJu0YxbTOrYVzvNieK2cPOj91ig1X5qx2TuxDkkuatKqeBBFd7pUzFy
 RmfkEcDPHrOE6DBLTanaQb27p7cFlVlqy9REHQKSb0tM9ghEyci8t4YPU01Uv9xzJIWiQfX9VkH
 XGsDwOBr3P1eMiTBSzhlWONE4D9QhzbqShnjxFFsr
X-Gm-Gg: AfdE7cl8cWsKeS/c7S/P3qACmyWYpF4xUwFu+hWqLCG6T5V97kmW3w6hfMQwpen4SAY
 jLFmK7ZSFzq1Ew6qUzovpqdjyLSUC4VIqySYMBV+p2Zee8lhkv9dfj+1sRPrG742vtl3AQp0apS
 nvJD1NLgzPmhIgK0VKmdLBpvhMRqHcnHgO2zF8/Dw2k6Ls/1MDtYyS/g96XLuvJJ59nr200tR0h
 ea9P5tHtJz/nyZmZCVYVugFdUEunscjIaQ5T7b1sBNKBSe+Hb61zVvU2W0aSg5/Kv0bECA=
X-Received: by 2002:a05:6402:ea8:b0:69a:a9a6:61e4 with SMTP id
 4fb4d7f45d1cf-69c5f24c98bmr2519795a12.39.1783901917915; Sun, 12 Jul 2026
 17:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
 <20260708203711.849489-10-rv@rasmusvillemoes.dk>
In-Reply-To: <20260708203711.849489-10-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:18:24 -0600
X-Gm-Features: AUfX_mwd2g9ScWojKdKgatypV2hobFwAfVrr7yE3HV-HHQPo9DvFwla74BGxJv8
Message-ID: <CAFLszTgwbAn7Muqx3tf2dZLMK=5R+UF9q+F_XJiAaMJRjLKV-w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] doc: document 'config' command
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-07-08T20:37:01, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> doc: document 'config' command
>
> Add a little documentation for the config command and its new ability
> to filter the output.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> doc/usage/cmd/config.rst | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
