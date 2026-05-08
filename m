Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1830CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EAF884D6D;
	Fri,  8 May 2026 19:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oYD0jHdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759A284DA0; Fri,  8 May 2026 19:01:27 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35D184D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso3710671a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778259684; cv=none;
 d=google.com; s=arc-20240605;
 b=lFURisdCYoy5eEe4dUFFCAwnBk55OYGiCwGTmH+cgtft8J1y9Wl2mESFdM9oUbdWM7
 ZnIWuCiR09vuE2vAabW15Q44T7gjEqOdjAQ8OQN/Vm1puheGeF9TWKjlW61ZYoaSk16c
 kVUEk/zuqKo0nx5VZ0LNoYaDPRvZ4yDnunAdmM+S4Il2yKZC3FnPeUkptN+iCd7j8Ywo
 1SIZ8d2GaA72IWWEeMmvrXGqvJVh1Z5URFNINWaML8kZ/Of/kUZClXFS7/eSfzifeCvk
 /zL/js31Ed3E91blQKoJaSMlMbWcZQ22L8afMDNSm32scf0MRonJtKz+TdgkCk4QhOMo
 j4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jnKpt78NlpnJkB6FCKFRrnKjmeRFXT2G+ngQEWgHCHI=;
 fh=kSTLPb+Yh5doh/bRjNYTOFhAFvDM9JCnaqpznS9LmwY=;
 b=Xi5D086CP+VojqCXntXp7yhYWWgAfGHqtb8v3RMPwIVV7Em8YC0FZqLuLXhlRF8yme
 dbkIwygyJhL6xZ9AD3yrpfXXtF0HW6HdzcAtWXQYYtbFugw19q+hIUr3CSf1EmNep5PV
 nhoMjj7MT+fH6L5B1NWgugt1hEuAOUF7nSj+VoA1xKqMnem+/ffgVsniDdW9tABSPi0/
 P1vHhAJw39g89655HhMX2+oyS185HPgh6qMpq4VEMeWeQv0SHofy5/EQcb8s5p+ARaDP
 6JiNxh/pp2seDKA1k1agho+H0qlyOFMhFBOEOPqNW/LyL9leJNTZvjWlhqK0zNsRcJyT
 xk9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778259684; x=1778864484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jnKpt78NlpnJkB6FCKFRrnKjmeRFXT2G+ngQEWgHCHI=;
 b=oYD0jHdfum6wvUqi6t1ceRH5ErJGw76lOCoMDBs8E9vp8fx02e2VoNPqLRgUUsNcF9
 x4AOTOFo/dEsW5Bzuyga848Vh29EFBj49dPiQWhHi9WcxTTlTYgNfIDT9AT0VEutUnhW
 WGaXn4wEAuBmV+54UHXOvQ6HZJ3puiKd2zFcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778259684; x=1778864484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnKpt78NlpnJkB6FCKFRrnKjmeRFXT2G+ngQEWgHCHI=;
 b=LXzMP8nm2R/6uD+nXCHpHHp2TU9huGoGMa7wLq+bZUB+OfXRXsBF46vg3tv8FN7wWp
 4VF9/DBT+fmm++f0tfqGgVvYjpRdBjkBODzLjAFzuXxjgiT/SyT7FD6pyHJoTqC7eyXy
 Vuy0IXttF+hmVn4ffINnPrU7twdX2FqMg+ktNcQlz6r037mw65VmcM31MGVZYxfrh0+H
 M2UXyxYwqfi8rufIWpr+zvPZecxfT6nDtnWAopv5Dz3QCLLkLE3tYcFawm/6Ric9ovBJ
 U4IrjDSgde/MR8uI2N2APVVDakWJd8LiiSn1rUZ1+aln48/uM2g/ABALjQTz7XXDjudW
 U2Mg==
X-Gm-Message-State: AOJu0Ywc7WvW51H9bbElx9NlmV8J49GWd52tQ8VkoW9Ewgn7qxLdBdmq
 ag+tcBrIzexu4guSBpySrITb26QN7Wekmf3WZKRMGdi16I4TStZzpdqREc4pMDAyMTLOsX+W6lm
 CXbRvGhj6OVQuGzdVMXXK0VE/ZLufRFlft6ZiCo49
X-Gm-Gg: Acq92OGHsU4CRdtnWlcobJZKYr0pBOfDGE9A58sL1rqLla1xo0bWX5pOuLaLrC8NGrk
 KD07Zt15dfg8SqzxLVwenWY6Hb4soyA5hAD6LS3ZZRivosLCmOonEg2aKBeI/svE+QE84klTCqQ
 b/Fw6TsER5cWbhgQO4v64OvnLpJC2UVWtfs65OiHMAvqUqwecigqvAepnnOHkgrRrny9iriTpoC
 jEnynIGG4g9ILYs+kpDffiNLs4/qvXRN1OrDakPypKEhuUD8tbv3o4i/qdZDC7fv2OzruvAY3r0
 z+iSgA==
X-Received: by 2002:a17:907:9341:b0:b98:3b5d:e147 with SMTP id
 a640c23a62f3a-bc56a6498b8mr810004766b.3.1778259683665; Fri, 08 May 2026
 10:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:01:08 -0600
X-Gm-Features: AVHnY4Lg4MtOhIX7s5igHj8KptCE3vXef9ZHh3ofEjphJb1K5lKfrXQG5ZaZy_E
Message-ID: <CAFLszTiRWmZaGW7ntiN1nBOyJ+PKSobT8kHg-3CRVaf7jpc5Bg@mail.gmail.com>
Subject: Re: [PATCH 1/3] misc: cros_ec: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On 2026-05-07T22:07:14, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> misc: cros_ec: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> drivers/misc/cros_ec_sandbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
> @@ -726,7 +726,7 @@ int cros_ec_probe(struct udevice *dev)
>       return cros_ec_register(dev);
>  }
>
> -struct dm_cros_ec_ops cros_ec_ops = {
> +static const struct dm_cros_ec_ops cros_ec_ops = {
>       .packet = cros_ec_sandbox_packet,
>       .get_switches = cros_ec_sandbox_get_switches,
>  };

Only the sandbox driver is touched - you could do cros_ec_i2c.c,
cros_ec_lpc.c and cros_ec_spi.c as well if you like.

BTW dm_cros_ec_get_ops() in include/cros_ec.h casts the ops pointer
back to non-const!

Regards,
Simon
