Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688DECD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1C1849CE;
	Tue, 23 Jun 2026 10:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ULbXvZjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E5B849D2; Tue, 23 Jun 2026 10:50:46 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8005849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-662ccb916c5so5710259d50.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204643; cv=none;
 d=google.com; s=arc-20240605;
 b=PkagI99RGyNPnVEXXNshhf1Se8LJvSaOrv3KyHI/ZaRJU9fXOy9chl+9YQgO3Jposo
 RdzpO7evALPKRKQcNxGWGsSQf4KutWRM0vYCaMvtCbTcqcnuLNMzVglSd3cTuxlKx+Ra
 A15GGAM2QrKjZSjckra1SmJyvBrqnYiLOzzcuRTjGiYR8h9H0Nhz0GYO+sNhHPsi+YxC
 thUovwvdhoQZ5uywkvxjT7RO5yMqykD7K+fOz/v6ZIrJRy24IMfjAHuCf3qFazdoSE3L
 YzaFzv6lCTQB3yr+Hb4B76soKAncwmO/96jEBK5/e+4sb1kzbAgdqQDWUB7CH1IESifL
 7l1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zCoQj38uF+jBvEOWDnlc9XH4jXMDumj0ONnFbsC690I=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=cWnrndKle3R9OENYFLQ5pumXkVtR1BuvXOWfdjAV8IsJ2SVqTiPLO9PswbRprNhD8Z
 aOrszPv8ygmxGyFR79RI3lsAOJJdnVYLV4lR21BAcjHOkQ1v4FimhydwuQFCqqtin9dT
 nb1b5qvsMBn4JUcNkM5JzmbtR1IuPP8EoU6BFN8tmLMPH8wJy8fgytQM3id2fWzrN+gj
 AdFWg2xnyxIRnheAlcRa6injuenpn+ipEcrWYjfZTzYic8GqI3RMhlpiLzzQZ+nBP8Qm
 fNqg/QGPVgCsoj5DUUnOEgMVX+V3YWzcalq4QW3dF2GN5+C/u2VUGTr6vpXhVrkK52rP
 gEaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204643; x=1782809443; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zCoQj38uF+jBvEOWDnlc9XH4jXMDumj0ONnFbsC690I=;
 b=ULbXvZjJSFvxIvjwpOl2Ns+u/KdmRUoIXutYhdXkStzNhomA3oXhnPNhJsHbhlDBRd
 y2iXZHbrvy0sSetq4s/WZhXRIwp6M47SSpx2YaOTPvSyNBRfPtNn+pRMAy6iDaSftYrR
 ju3HYD/y5Qx/8TEGamVAQNn/MF+4Jfy59ERS/3/OCFZOenOodWOhzPfWG24+4jDz3oZs
 gt4QOIwHZY4XNsOPAUDrmlF6inqOPfhvLZymx+4AolvrTsiIOX+uafZCZUnKX047HCBD
 QWksSMctSYrgmPxzyrAId7KGbI2s/B3/hKdIjhEUCVV3EQUkP8JjghhDVN4ILyy9k1Io
 QvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204643; x=1782809443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCoQj38uF+jBvEOWDnlc9XH4jXMDumj0ONnFbsC690I=;
 b=guGOZge8k7yHIZaZ/baXIPWkIQiCpiaFrq9xcefjw5W0QkvRDT0Rr/aClO+EbaYafT
 Kd8vhxxjyE6eWqll1m30EdgypSPqZpfKvgXRjHw4RBrHG/M9S6AQqIKbfj6a5hyD4P6W
 OpC9WUkMIsT6VlhUPbAEH+taNCkFINWEseqeVwnSDd/jRGOoBC237Po2VDkVWLY3VOAv
 d7ggkyMf/0fXhAXFyL8p2rOtMgFJ8gFjwqciklePxB6Imx5CuC1MQMbUzcUzFgxCnNPr
 eeog2BnX91SktlX8e8AbdmOxxTzzYjuFq9YlXv1agqTiL9Fb32Vl0B29CISgHz4G6AZ9
 6yfw==
X-Gm-Message-State: AOJu0Yz+A2M6sNTl0nyAPZP+VPcI1PBa/1G+mBYlmv0sx6VVqa0gua4k
 FS0WLvVF3Uj9bVQH6rauPMhZFmuIVsi6akRNVkChkexq0eSywbANuaDFg7aMbQGSFMYrzR6Qt67
 n54hU3WJko1g+I2x1aS7iN/y+FFEcEW67b8xvnjBxog==
X-Gm-Gg: AfdE7cmfE/Qxshd8i3wCj7oQuuCdekehTAjOQEAX7vccvRuUqCad4boniQgXE1X1bj8
 i5QQfqCJl6x1aHdCfk7Mu8ab6sdzkIMJaYjlbOZKewbkOsK97//zzIEZ4EHCFPC4H/DlatCPnys
 9wvJxOJLJKUVrCSaWOnwcg9b5Ggpt1siQzmFloaooTzNVxj+ws8HscdyO3QVwdJWHzZHGn6u2Hp
 3vb97y9FJ0vX+48TMdSWIaJ7rYiX2tXrDhGEve4Io3L3YOqy5PRInhlJaaOOJqmhiRVsFsYaIyk
 cKfUEL0ZTXllsnAHIDb9OziTm2lM4i/BeVVXzg0XFbmmHOGAVgXVJlRBYUY3i/HGpVs6YyZfWz5
 +EySnQv4mP9oXescicA4emP2Atx16BKNehOzYGwEOHqLbCzrcqaPIXchvVvtO0jryiKpfaiRbpj
 VWJYFsJ1n4vsE6T7y94OC88RZlg21B8mCAU9Vw5ieIMDGz/glSyEg2P4QM1RaVOQNt1bpMbfC2E
 CTGsacVlJRtMPLtV5p3uTCiW9qXEBd9nrquhL9oCX+tMw8xOqGXCpZbUEIEda6DU5JC4QIW725t
 a6kHbaWgMfSlWQky31kDslPYXb9MTovK/nUpkM03KdAT+NZu4eHceYuLDAUIcW9hSKr9Qk4=
X-Received: by 2002:a05:690e:138b:b0:660:78f9:7e7d with SMTP id
 956f58d0204a3-6635d71f97amr1072493d50.27.1782204642608; Tue, 23 Jun 2026
 01:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
 <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
 <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
 <6e83756f-5ed4-4f89-85b2-1a65419e9ac4@siemens.com>
 <CAC_iWjL9yrSycty6=+JGqpE1ed7oNb34txDmKsE9sMp4zZCOeg@mail.gmail.com>
In-Reply-To: <CAC_iWjL9yrSycty6=+JGqpE1ed7oNb34txDmKsE9sMp4zZCOeg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 11:50:04 +0300
X-Gm-Features: AVVi8CexEU9O4oe6smvakImh_cp-HIzEu_K5Q5oUqstpicQnoX_Bnlnp72HIby0
Message-ID: <CAC_iWjLgqpk=mdz76JHD75s5t2F7R2kzAEomd0=E3=x+kcmZrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On Tue, 23 Jun 2026 at 11:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Ludwig,
>
> On Thu, 18 Jun 2026 at 12:16, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> >
> > On 6/16/26 13:46, Ilias Apalodimas wrote:
> > >> [...]
> > >> Anyway, do you want me to submit your two patches as part of the series
> > >> or you want to follow up yourself?
> > >
> > > Carry them over imho, they were rotting in my branches for 1+ years,
> > > but I never had the chance to send them. Your patches were a good
> > > reason to rebase and revive them and they fit right in as can only
> > > rely on tcg2_measurement_init now.  I'll test/check the v4. I haven't
> > > gone through your changes in depth but they seemed reasonable, so I
> > > think this is fairly close on getting in
> >
> > With the patches on top the testsuite weirdly fails in platforms
> > xilinx_versal_virt:
> > https://github.com/u-boot/u-boot/pull/987
> >
> > Works without:
> > https://github.com/u-boot/u-boot/pull/989
> >
> > I can't figure out why though. While investigating I noticed that I need
> > to re-introduce the elog parameter to the measurement functions so the
> > integration actually has a chance for now, short of using dev->priv->log
> > always.
>
> Ok i'll have a look and see if I can figure out why

Ok I had a quick look. The reason is that
if (tcg2_platform_get_tpm2(&dev)) {
log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
return EFI_SUCCESS;
}

Has been removed from the EFI init of the subsystem, but the tests run
without a TPM. The init now fails and the entire EFI subsystem fails
to initalize.

Thanks
/Ilias
>
> Thanks
> /Ilias
> >
> > cu
> > Ludwig
> >
> > --
> > Ludwig Nussel
> > Siemens AG
> > www.siemens.com
