Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CCDFF886F
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 02:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5849839D5;
	Fri,  1 May 2026 04:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bNWrM6pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B806783A91; Fri,  1 May 2026 04:10:20 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C88803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 04:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bba0dde4f43so230187466b.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777601417; cv=none;
 d=google.com; s=arc-20240605;
 b=KWpraQRk+VhuV2OGN2vkv5R4lBSLsU05zCxnYKstDSZr88PvRSDCjKznHEb66LnJSv
 J8tkR6BycgNBZtN04p1LF7vPr9of5wGAU3MXTnN6178zgOUSCO7hoz2W73lWtXJA8Fts
 16qJrCG4JdtVipvcC0Yf2LC9NrCBacKb5uRpfnXU/pqRT6IVVzsgqu7U5sDZfbPu3ynb
 mLVWq9kgrxKnQzPPwIc12+yz/44trO7K6ctlo2dxyGMppcztZndzH8w0tGJIVBndWfJm
 pCRfJRP41BL0fAZW2maBVZv6D+Y2lTyLEK/yKnhpzA5Dyg6FfkjPswTU1ZJYSlRDg4ne
 4kaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hr6PqkjodZUo/Kpx6fFyi4zc2VPVxvpXbqf60RmrZ9E=;
 fh=Ex+UjVdmp8EUah9YaFeOUBIKBBH1Wfq7kqn9NtJ8a0k=;
 b=JufuUZvTaYVMeLkjrY9XpKvmi1mWvY1XxuG/eUPa3qoWOzCOrQJUqFkD6EJ7Lymkkt
 7oTc3T6lsHnlfKwAwnggnRvcoreBzyoIFdnb5rsuZmpEmmDHx9CjnTtfO9eLVSS+88gH
 Wnu5SLAWJBLcNEForVpnRdgcs7nn9YMsd0ydets6OlVLB4iv0okEc/N964g6DYvDYC3m
 fpN1aWClagO9+NmHxNTr8F19wZ1p7uw9NXerLVZALu3InCdHNWM9m+SNpZh+BufziRLe
 KdMdaNojsLraFekA098BQHp+JGfVDav+7mar44Vg13lw7MDsMqjoY13xPcyA+JDvY4m1
 r6vg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777601417; x=1778206217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hr6PqkjodZUo/Kpx6fFyi4zc2VPVxvpXbqf60RmrZ9E=;
 b=bNWrM6pUyXQpodzYDpntASkha5J7Mp+hYtVSTzDyAyIuXBQeQVKwdZ1YvPuvQ/lgCx
 e2dnoYWepMGIdpz8ydYOirGdibHgRge/Hve0O+/dKuSrrKuFKHFsnSR4+ctZcrRtxxVP
 YQwIlOZUu+OJhOm5vScWsjFVxFKYluZfBQibo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777601417; x=1778206217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hr6PqkjodZUo/Kpx6fFyi4zc2VPVxvpXbqf60RmrZ9E=;
 b=sN5dkRbLascwVcgysiu60IpXZZRa7SS1Cr6PvDXkMTNBA+feQ6MX3mGhC4qiAVXsTU
 L8VtD5UN4Lq+aZZpW9mWIEBxgKDdnl+NvUYmw4qNsfSC8nyhgt11G9Co9MZLupj9P0Oc
 UKNLKzo6+AuYNB7093avCZCtrAmfuXzsv3HtBXR5gGtgTMWqf8UfMvXe7+4bliO319Oc
 S8vBlWKZfAtNPEqUHICThyN3ceOftCfo0QCdLxciGu8T1qKwEZopQxdSFDiNBnCYCyGU
 SddCwiiOb5Mf+PI4u7ALbLeJP97CYVnBAYJ15AnGGoXTVF8Guqkt8bgpTT7mcJ7NK/9a
 KVLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NInBH04a7FOo4mg3gPNiI1emOfwXQa1ORq3jpeMbJOO/gUpaEQifw4fvzRTqZykSyDthVfOY=@lists.denx.de
X-Gm-Message-State: AOJu0YwwyMXosh3JtTCw6/VSEQ0zkZxlNs+FyiFhQHCuVTZ1HYSsGuLT
 OrAWf6kJhUg0JjvzJ6MjtFO9V3Wq9Xw1Gt79/xQo3/bAB9r2iy5ahP/6EmH2nrT2aXQ0KqTaOMC
 Y86xUo6X2v3Sf8qJLToYg8LHOiZlVpnJiDtxKxFwE
X-Gm-Gg: AeBDiev9PExHLLPRDKpdyu7xb5w6D9PJp4Ax+FyCj5dTmg2MwIkkiPFuWNV4K32XB0l
 t2AdcYVMneCtNEzTRWfT0+NK2OgkZlDEyfrTUqFVTbQHsetxQ8dxGLarwdTBy6zYByJwqtM5Mes
 NPyW+X44jkuaOPKJ8HTMQ6tECfM4EYXekXiHwm6KEDatNYfsYVp/ySCnsiDMPBl2U2YOIlgQ7xj
 zC8xnsTCDIW8LlbLUNxlbJvsJGycQqDfhQ26rIVjNgmAiUCWT7oPN4W5+iOT+mctcVm8FCXgSmV
 ihbmrhoAo51ww3oo
X-Received: by 2002:a17:907:7b8d:b0:ba7:cc67:488b with SMTP id
 a640c23a62f3a-bbb68d11d42mr304769366b.5.1777601417544; Thu, 30 Apr 2026
 19:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
In-Reply-To: <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 20:10:05 -0600
X-Gm-Features: AVHnY4J1_TdfrHfMLqE-MJDsfQ3xPXo5Zlac-bmK6dX8-txvPkI3b3UJ9_js4v8
Message-ID: <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, Wojciech.Dubowik@mt.com
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

Hi Quentin,

On Mon, 27 Apr 2026 at 03:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Sergio,
>
> On 4/23/26 5:45 PM, Sergio Prado wrote:
> > [You don't often get email from sergio.prado@e-labworks.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Add an optional extra_env dict parameter to run_cmd() and
> > run_cmd_result(). When provided, the key/value pairs are merged into
> > the subprocess environment for that invocation only, leaving the parent
> > process environment unchanged.
> >
> > This might be needed by bintools that must inject environment variables
> > into specific tool calls without polluting the global environment.
> >
>
> Yeah, I'm not convinced this is useful.
>
> We would need to propagate this new variable to whatever calls those
> methods as well. And it quickly balloons.
>
> Just mock the environment with
>
> with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in
> testFitSignPKCS11Object for example?

While we can mock the environment, it becomes confusing as the mocks
pile up. The code path in the test effectively differs from the actual
code path, since the mock is overriding something that it assumes the
underlying code does, so any changes can cause strange errors.

The normal approach with binman tests is to pass through the settings
they want. See for example _DoTestFile()

If you look through the tests, there is almost no mocking despite the
large amount of functionality provided by Binman.

>
> I'm also very skeptical of the need for binman to *set* environment
> variables to setup openssl.
>
> Look at what's been done for testFitSignPKCS11Object, we externally
> configure openssl and softhsm so that binman doesn't have to know about
> it. This avoids having to play smart and adding a bunch of new
> variables. Is it possible to implement something like that for the x509
> certificates? For FIT, we do use fit,engine,
> fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11,
> custom openssl engines, etc..
>
> Also, I don't think we should decide for the user whether they are
> forced to use a provider or an engine based on the presence of the
> provider? just let them configure openssl to use the one they want
> externally?

Fair enough. I wonder how the tests deal with something which is
externally configured, though?

Regards,
Simon
