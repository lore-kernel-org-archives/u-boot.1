Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PBxwJTkP;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E9SmAMwQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0C6F80F51;
	Sat, 31 Oct 2026 14:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wUg0FiT8HJFs; Sat, 31 Oct 2026 14:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7CF680F43
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455555;
	b=PcwlGgye4dOLXE7UkZQFQxXg3STjVYnOtHMinWa9LFnHlmyypPIi5Acey/KpBBnq/iN/
	 hWYel4MDdgbSIhFHkosIlMNRoFZOxpCovn9hoj4vS7nBExJSJuWNQ7R7U9WN6mhaPFzAY
	 Q8zRWg2GZPdrJixm6tg8G0RdGKvsKUF1HMv1iYbOXTcNvbwOzC2fbCcJVHQ1B7qpYEU6q
	 Zqs9JPgaAMsFkm/gByYjEjOdczf6wl7H+ALa/ZfOI1vBmS1ScNhEAXSjprp7xfUN1nD3Y
	 HOji/wcv1KwMJ/Lq25zEERw+CGWhOI9/dZuCR/i61N29SdMaUIT0+nwZ7ejHiZudr9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
	b=H8pVat7A1rNjhbvz913OJh40K94PgzQKNcu++JD2kPUAt9Stq7VeZPBalKXAkMVAHK5l
	 7v2dm3db34W0PRt01CE8xLzbM3HSJgc6nwiTeLhyidX2F4q6w7kNwel1ZvQSlbsA84V+M
	 RpYp2Aiz/hvJUS5weSVu1/0rbcXu+0wRSi3NKo/4CISbU1+m15JWBlN4Sm7rRalcNeb7o
	 xc2+7b+HKK8T97o8d1G4T+TA74e2aIPHJXClXwBJneoyiPHptBrC/ymI0tSltZPee/BIi
	 8zSmg8sjVonmxBW0P61VwO34BIm+CHlVYBza3jIfe/2vqkmv1gTapASy3QoOQpqVU+Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455555;
	bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PBxwJTkPDwEE3bBkOvC/deooS3cj2O+HdsdDocQb2tGzOJ+5U1hooXo7BmQIgKYaH
	 ThpmJ2+nTbft+6PxA7riEIkTvQjkgsC4X4CZGaH5Db64RQsOG1dkcz7hBwaw+2fYbL
	 DU+ZmEkg1uHlvEKC4Pwf74SKuNAaU8NDwziF4K3TT5GGR8097UJjz6FxUuK3AZEGtx
	 QNZNBPLYxEKzF2ZOUR0io+3zBgymiE8QOXtCQKMwe5cVKmw8aPemjV9yyiGRMVIlqj
	 6xXib8Dhh3jraqhpEgxO3cGUVu5+uEBQODJ/LcBf/T6W+JIyq/SB5i6Hxo4YHWYdjO
	 QmTynJ0izgULg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7CF680F43;
	Sat, 31 Oct 2026 14:05:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B54DA411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A68B06061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxXsyTUp_K0H for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A6F3360614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455553;
 b=M7nig9mntSBOvXFp9YMSr/E7splZr+iXEjxUnIislSoSQWAgPhJa+Y+4Jox5F3OYaci4
 ITKEKfGxTLiNkc5t/ty8S+3hEm3knArHY2Aj9ouwGyGHynf1tozLsfQu6vFOQas+HgAQ0
 Ezty3uHtjb1NCa2yZK9Rn6mNlZWg7GwGpRQYe757IeggZfcYZiheoJgfYfnegb0vVww1P
 x4rTcddWbqGOTseKmhCiMW4Z+igYWRIpuY0MihF51d5q/k6m5iRn0ICa50UiMggEUL2/H
 Qgx0x8/8SMjxpeKpqn20Sca91o74yeQxJgaw80JqkFG+CzbSqoyk92k4eB476ec3gNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455553;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
 b=VO1WuqGGld4klc8ODk4J098CHIW7Ms9RLkgSitEiKW3go5ZEzJF9LdSRcUPVGvxVQsgl
 OhSQ5dDICBPMY/H8mHxgB7Cr2zPqlF2ZKlOR6Kul3wrrJg/8GDekcIx232q9J88oU2SFS
 ohW0G73W2ckGxGpaV8YNQhWNFiIJflmcoN5bJh1SIw/VxeTydzmLahpKVzWeVAfDPnqku
 7vxG09646yHDWBGWXaL+X3fE+r04nwmJQyU+Jc+eMXLtYAd2cWsKsfIh5hSfcB1m2nu4J
 VJ0FVPUz2Le+JmiStdd5oN3fdzNmn2+LULj/C3CgDm5eVG3OCMmf3KtxEzdrFZlE4TA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E9SmAMwQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=E9SmAMwQ
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6F3360614
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:05:52 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b4a13789b0so2243143a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455550; cv=none;
 d=google.com; s=arc-20260327;
 b=IYixxvdVXQej35nykR4QIG4Yq3e5As0ClFM/lhxor0guxt0vmh76SR+l3yBBaQGVZE
 OBbUMuaPtdGqwMsIQzuWHl58X51bPXyqhb/G+IZBUkQbHx8uF4QZkI8/uq8M+Fj1g06R
 Bl4FkfgrYNbQPMLZxiAxaF9OTBlKybdt54l8cewf9VcsU8f6JesV7Y2y1gav4Al2NC8o
 cjPlqhhj7GRxxuR41Dzam1BBzRNOGieThCNJX1hy6Ip5fV/Von2IcS9A5ZY5FzHVZ8t7
 JJFaDToRi94l/Y7EZCQTDK1NCW3tyrgbVLwfaUU1bSskNW9Cf/rL/eCVG4fiSiI4eGKE
 Oe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
 fh=mR1OXvag+e13XHIRs6m+OZRekWh0TKdcuQMLvapp0So=;
 b=ePNfIgOKVBrCLtRc7EgSr1wVxpQV4E4/iVrE+HiiXofpjswj5p+na/wbu48wGyR7sY
 AI+EzaTtzXsh/9OlLCSH5HYF7ohJOP+bLN+8D1a5vHHjQ6BecNE8JwmglTKJLOIHxtXP
 S71mrSm0llsFitZp7iQtaFne5OjwJfA5E3cPWrRVayqpUUy243FPLjgjb5A2VQwjQzXE
 P98zyG/Gfyw3LzHSco03FxzXcdw3iGLNO9ga+gWJdaK/Zy30RETkQiH/bP0smgk+7ZqS
 8WbbYLcmKoKoK6XnEHfSjGML7zXCPxV9l6nfYimvX/pcC/fHpiIaileLKmhiFVdPvdne
 ZVHg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455550; x=1794060350;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
 b=E9SmAMwQAjVGuOeUIXKWJOP/hC0qIx2q8odBEh7TFcWGNGOIbDCNst0uo8LSIYjFFW
 e1hkDLrqhEskeeRAxg2eQmRYNM2YuNFvIifVACzH0oLGB2HB1gUgFolc6vrdXJ52BbXA
 UlOGSdekjH5jCBU3NVWm2H1Q+8W/JL4Jb+RjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455550; x=1794060350;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v9MI+9CndcSjoWbY/cmY+HaCgmiBOJAelxc+DftVmCU=;
 b=UHwTfMG3FJwAwHlIWmop5g0LTVT8weQsVKdPlJuopUlf4GmIShGQ2QV7FrcnGcRxYW
 5WHZaNgJ0DTodo+nbX1cmNa7C9XUMgdbFDAthhTj/4VDp8Tns62i2SjAaVKN9hXz27mV
 YUOLUtoDctARLJIR+3OTo4QM2w5ZwHyV0ovAYGRqDep39uwd2Kltlont+RmPpaAWvhhL
 RKzkQmJI5AJr+XgthjwpFljnlOkQFsDBaew+r3Q/9vHRZ0J3x5xh9GzUw+HtV0mQRjd8
 zS6ZDRy3Tg6vWPpgtbSOJr1f+TQZL6npS3Pg/lYIYqaYmsNPn53E80JFX43MbnrhtBuO
 vlTA==
X-Forwarded-Encrypted: i=1;
 AKwUvByeXRvXAMHholZavZ0lbTXRKn+wkL8kswzEeIIvpWxzzuRaeOHMvBT5syiJZbQ+xgTcvDxhyOY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxm7D8UDiiliyFzQ+waOMQBKvTxr2f3UP8ZVcDDRPgF37bquJR
 SVL3VPkSBnjA1Ai3bnq68SyLGO8tP7xiUN8K2gn0iCRJrZL9CqPwSCLbNgngsfiFpzkBY2tYdwJ
 tftqcnl/jBIqo3F5qTURWeXQEZH/fbHmkDBdQwtDx
X-Gm-Gg: AYBFou0OVJvd7xHk5uwZwzWNetpmLZGwU9xBsKPWTmK9Zo9wAz16jw+lBNn0SEGsBgQ
 GYsgy2GaxcmxPJ47rF2k7qqyuBLdie0BYY+sbhVtLz9NLF6FbwbMZ5c4gImBAnIfz+UUqK71x40
 XJhm9L5z7uBUvzEQsO8S6w3T8eK+nNPun68rzaGM9/OrZxvgh2z3BngFKRnkjC/TowYG2xhjYik
 e+me8yrZeunM1liTF+GnuSeZ14gutWebRnd/F4N5qmqx+ZkQ9RitmWt1u+xU5wCxOyT1Mg5OgMx
 X5ZBVNRjlGpcAOJa63M1oais6XpJepG4eA1HoDo/l7Jd0Ms0HwJ914TTlXXoG0yX9uSIWDyQl73
 fW6cd8ZinsikwzO7mrZhOVwPd3YiV/AbFdU/UtsdR8y3gOStjZoG0bBdrY6pld8UQO4dF5a8=
X-Received: by 2002:aa7:da45:0:b0:6b3:e89b:128f with SMTP id
 4fb4d7f45d1cf-6b4d4d6d938mr2724870a12.9.1793455550179; Sat, 31 Oct 2026
 07:05:50 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:05:48 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:14:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 10:05:48 -0400
X-Gm-Features: AclHuK9ZRSj2YP6UXQDiVerk-U0W8qbW-G3a6OikcoA0i73oZTruOi7grDXwHAs
Message-ID: <CAFLszTi4Yq+=pnrJ-th0BMZQ_RwsZ34JSef6NQL2Wa4uLbtK7g@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootstd: rauc: Fixes, partition name check and
 built-in boot command
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:

> Patches 8-10 add sandbox tests for both options. As partition names
> need GPT, patch 8 adds GPT support to DiskHelper in fs_helper.py, which
> the RAUC test image now uses.

One thing I'd like to check here. sandbox_defconfig is the only CI
build that enables BOOTMETH_RAUC, and after patches 9 and 10 it sets
both new options, so the default behaviour (no name check, MBR image,
boot script) is no longer built or tested anywhere. Patch 7 drops the
script-loading code from the build when BOOTCMD is set, so the fix in
patch 4 is not even compiled in CI, and the 'boot.scr' in the test
image is now unused. The cover letter says the options are empty by
default so that existing users see no change, so I think the default
path is the one that most needs coverage.

Also, the new tests only run if the defconfig string exactly matches
what the test expects, which is fragile. Please can you find a way to
cover both configurations? For example the test could override the
options at runtime (e.g. through a field in the bootmeth's private
data, defaulting to the Kconfig value), or you could keep a second
image that stays on MBR with a boot script. What do you think?

Regards,
Simon
