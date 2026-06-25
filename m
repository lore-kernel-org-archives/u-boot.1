Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B2CCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F92846F4;
	Thu, 25 Jun 2026 14:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kMk9JZu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A45847C8; Thu, 25 Jun 2026 14:12:08 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD678460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c8deb37737dso802333a12.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 05:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782389524; cv=none;
 d=google.com; s=arc-20260327;
 b=ATPBKQibGa/y17xsFHjDYTaJ10MXU7mgzrhkX2InwVBHfr2ISHzlUhiPvNfyZWYCo3
 dZc2fYYWltyjkNNDRCS9ctykmtVBik0iIYcw6SSoIch4mXPev7rJdJTUVhpS1ZGSgvpS
 UJLfTdU4cylLYnRF38akeIZqCgXU1HtxzHcUys260zAiXA/uiSItVJsGI7vnbY1zRKHS
 7pmYtsOjeKHHXcU7oy1RbLIf0aLMWGHJSGmaNSOU5Xzn7vgGd8WpIg2mSyxYDiHnRsHv
 FFvKRDmhlH3bb4ibBbBTaOvLV6GK2TWx29/iXl/rZ8sOvO7eO5GKIUVYutyEZOBkrTy8
 pykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Q4wPNO+D+7OOhObgqpZj/FxlX0+wFqxrqJPR2q5+RE=;
 fh=3qSlUqf4T6N07J1kFFAyvtIlTLdPD9Hl/P02ibjqRDQ=;
 b=LpP4BMSi4utVlkRzYw0V9VWgnn7jM7Y6CiGfsblHDcIn2pKmH8Fy9K7V1XK58QKrZE
 7Flj4iEiNATntk5vhSI/vPlkdtM6pa+Jv42/PJ44jaXYwqOelMOOdt4TLYRIJFTTjaPm
 OENI87g1YfhV1Xla9D1nOmtDKXAnCOCwfvmLu2vLY3OdKIB/Sxfx2JhEbjLuizHx9hf9
 sa4Ql7ezfteu6ysQTUhlX6AdiipVjZ6IeQoj/SCUZDsh+fJ2Zh8ImfEu5ciJNY6RhvNN
 DJuxgvZz5UbNr4azEhUZPyBJhwxwGZ9CsC1QY+HYOHsHwUkrO8DrKyUOqHVkZmjQk9z3
 N13w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782389524; x=1782994324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q4wPNO+D+7OOhObgqpZj/FxlX0+wFqxrqJPR2q5+RE=;
 b=kMk9JZu5iuuTqpYBoxnDJMTIPOeWanvLj7aTLfB/7Tuwmm42VyIcJuQvLAdxR2JYeF
 NZRNRVV7g880y76hMSVro7kX4qY1FEmgxvAJzWxPYeHgi5AktzX8389l9n58Uqq9rLtl
 wd4DXOlJeBnbrJUO1Jnnu/q2Zl+1ltZ6iEJAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782389524; x=1782994324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q4wPNO+D+7OOhObgqpZj/FxlX0+wFqxrqJPR2q5+RE=;
 b=Aw/bPqAS4ek/6o7o3vnxrv2CKCvfGipxyMUPBSUiW+dZ+tUs5D8JihcXQ6q6ihnoqK
 wqYu9D/dcwrDLTFow/GURo8LuUPmRGa8XMA6vxbJISUSdUKqwxEfUn4cWA6RlPQO0DvL
 DymrMYZOmWPj/xhgbP3WvtWTizgTMzXTPMOmBALHZw8S1itGXR21MhZo9rjWz1ceDZUm
 vSq8qwziRkTbRygg8EUjcJFNTWTZZ/MbPaZSpipSaOiIZ9cVweXu+FPvMz0/lKAMMwTr
 Ie+3vTfcq+o22oy0FeqkmK3yITcFoRUWEeJ0Cr+q8gu0EPrKjPuh3XDa+M3Slzc/XbRM
 kQzg==
X-Gm-Message-State: AOJu0YwJdfwEdtFI3tJ4WcnWRLzYjVRFJx62jODYAj60m9THpdzPYnoe
 Je2Mv2i9GK/kGACXUOen30vKowoq+wQHd9eN7W5/utPgVycmCLEz7nKgUPSltE/k9KJNznCw7fW
 1GpX1E3oed2b216CiOji0v0N3Jbp3T5pExsF/EoGR
X-Gm-Gg: AfdE7cnplDCfVIH7H4WthuxP0mX+j810nEEIysc7h2vLCaZxwXjBEArRsR1L86fbEeI
 AlFVb4MsfTtTyANv/0TwBGYYcx6LlXv48IJzAK1OBF+wl0BOclN7Di2jaNa01nyb/exX4DSZ+pN
 83tkJo1LCAy1dQA+fuTaq0EGL9OWO81sjBJTBnqSxY+TnTN9nSjC9OOZBlz1zGkZpK4mXZT4HtK
 WzXEOfLR7N5eSHjVyvpFPup7g/R3Q1Noi+4fkVwyfz+2LFNe22GXSpKKGBg3LlhvlY6m+5sPA==
X-Received: by 2002:a17:902:fc47:b0:2bf:305a:310b with SMTP id
 d9443c01a7336-2c7fc75a02emr22547605ad.1.1782389524125; Thu, 25 Jun 2026
 05:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-fastboot-abort-keyed-v2-0-684e53949a42@samcday.com>
 <20260619-fastboot-abort-keyed-v2-1-684e53949a42@samcday.com>
In-Reply-To: <20260619-fastboot-abort-keyed-v2-1-684e53949a42@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 13:11:49 +0100
X-Gm-Features: AVVi8CdOfrza3PORfmN3Sl278QK4XlDRpTGzGCEGkVZk4wZJKHAmAuAcIKTHYIw
Message-ID: <CAFLszTjW_Q+9ZVyrtO+AVgyEw6uvkqqWnJ-xjPuC=pkXu5_kMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cmd: fastboot: Add keyed abort option
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>,
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
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

On 2026-06-18T23:55:00, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> cmd: fastboot: Add keyed abort option
>
> Works the same as CONFIG_CMD_UMS_ABORT_KEYED does: any keypress will
> abort fastboot mode (rather than only ctrl-c).
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Sam Day <me@samcday.com>
>
> cmd/Kconfig              | 7 +++++++
>  cmd/fastboot.c           | 9 ++++++++-
>  doc/android/fastboot.rst | 4 ++++
>  3 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
