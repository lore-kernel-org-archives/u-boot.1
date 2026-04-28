Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5989FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5248A845E9;
	Tue, 28 Apr 2026 11:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LwBaZQKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1F884653; Tue, 28 Apr 2026 11:44:14 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B245845C8
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so8663525d50.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 02:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777369449; cv=none;
 d=google.com; s=arc-20240605;
 b=GWV5OjN+9hOI7l4aO3k+R2LkeFvhKRh0HG1/aT+sFAn9I0J/nIoryabQG+w0bpNAxb
 Xnwqo87ODeIvq9E4k3S0yPvUe7+3Cahhe/BoFIHTlb+ggEZRHVKDq/NV3EWLNjmDegfm
 2mxRcrHaLFC1fzeUmvljGsuc25/Ju+b0dVjHN3HG+Rkmg0nTlxAbRgbOY455/jUcUPs3
 5+Y3+OLqkQRAxtTosz4m1m4KifpfDWuL94pP5+WOfiBVy+L3MpxgIslJ5LjF7SRdHVs2
 S08zDkwfaU4DQnKLvvMCpucPIH4fCgdM6dgoKAf/tBxUmqmV7+/DysGUjiPRxk22Htcm
 JEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P8MzFZCIjoNdzx66Fl+iYajWSLqC3oB+5C7AuOE31lg=;
 fh=S5R2qK86rA3JgGC+O5wp3hk54bjXyw3ib9t9Uil79uY=;
 b=KSepH4XWA4yJf52LiRJaK/pZQ373/QX6EFiUoGpcsig1+UrsJ5EmSp44kwpeXDtLha
 Al8l0wIbA1dwAFslCWLTuXmi67U6xjawNTB90r0YCySHNZrFnmU2yolfbQs9yKbUsR1d
 exxxMRJNlCxc1g/OXiKXPr+FtbWk/Xopt93ZmWm80C/rYgvFSD2E0cIApZarBZqNvEBC
 VWjQCNy0EF9t7E0duMzOtHjFuKkoWk5yaeffqcgtCwYfbShUGOHwcGiqxV2lashAJvJg
 JMksPYZ7SItnIbDHwOa9y06rUVUn5lkoNpOmmdCrxGUHVdgZzBk8BjPRbDSXJTZyXlfk
 Q5wA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777369449; x=1777974249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P8MzFZCIjoNdzx66Fl+iYajWSLqC3oB+5C7AuOE31lg=;
 b=LwBaZQKNRxXgRqKtZoyBBgK6Q1Qmo0tbnUO4xpz69+Bp0ts8X2fZZP3Q8OD4sdJdD9
 I+2dd1JYxLbnUuw0JppkIOVPb3VI54rJffwr3PbJhyBCqswQkUsX20AqZhnFeVg+fDPB
 h8bVK5YRrSaxOHxd2fNUXa+EcAwg0onD67p5UxvvxM4+N9X9swJq9MoECez/5UrlLiK6
 lRFu21vI9ZYyTe5xQCjFCMFsZAOZIJVQ6wrvtod1Eq4gavFL7hJG2+BHBUFuNZaKUKRA
 G9eQFp2zXqFuxWFDhKTSA2BKdfIlsCXg79ydJ+ubJMkTyT+MAqctoyLiHtP+qfQajKcz
 1LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777369449; x=1777974249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8MzFZCIjoNdzx66Fl+iYajWSLqC3oB+5C7AuOE31lg=;
 b=H0VjgfuF0Q4lB0hjJ4oEoG535XIbW2oA6yQObq8qbotMAtPAr1lbMJWUcHiJkBKuWo
 PAUWnaWShVwhTE7Gz320N694+fC0CZ0TZ7mnlErNrqWcYpHIQIfIK7y6z+8GEahJJ72j
 rSk1s/4DHmfA0bqOIEPr8CxiwbofTtfPJ0pJDy5s9Jolq1B/gXgACGpWUnn7sky8faAX
 jXMg4uP25Spdi1q0tISnpAaf+PhJBWFvjj8TXRAJfhsiXFNZsak2lj5IbAOhVWymrIAj
 x2J1aQraCa0OSUcWZ7BuCfH34tJPozNSCCif5JH/W59of1ESMxK9bKGOnUOX3hhZWHuo
 B42A==
X-Gm-Message-State: AOJu0YwICXGhtXonuB8CsnwApoqfeFwiqSzPVfbOd1vL+TLw9iQLMx9H
 HL8ZEW1XP0EwhQxYd0hdNtfnfWc48yrWElfNzBHh4/M58YmLQOm4oadl1Mdqrwr301NkUyZ9GZP
 Ts4qvzFNkz2hoWoZN1Fh+kV7SwImS3Crj7MGseQbmPQ==
X-Gm-Gg: AeBDievi7ZXqZWxqjHSRPjsZkj6oL+i2JNqR3AOaiGdMRlIneUpXZ4YASrM/OVp5f+u
 r3OUJg7T6fPZLhoh5OiPxrGlMZSv3Akx9KeB3DSytyIFVyl08pEJtGQbctiNON0S3YAWxwQSrUy
 7RAcaCquADXS/gGL1+/IDhcV46reecir+4KqodhzM7qwIa8XHxntdqIzKvWNu3VazckGtOwabZH
 kwVcGFvlZClj2HSIMXPiry3L+SskTA6wTExuPhC78D4PI4NJnhpsC4Te/gLioyak7SiXz3Jse0S
 sjKAW8sARttZLasgkjrzYUjUApPW/zN3ybx/Ljm4oX03uCKAYcvlAb2S25OxyRJ8dUN39qGo25G
 vGQxIinNwuT/a+mR1p8Meqpv3nBDzLZAvBjnAVB0NVGs24c1zm39rUZiPh7W/pMOfQdmVmUVP92
 Ind+k0DlKeHgrbtvKts9BIorvxpDzz9S3bhls5FF9KJePlcAmy2K8bnpqDVflm317f5IfX6Itqi
 pGe7l8psIsS6w4UlBTROAZDG+oZyO8py+qaJXlxMV4/Q8M/J5S7+1VGI2+WtFiLdxuhMEU8O4mx
 9Jo2GsjZDGT9QPsUbpMFv40R3WRfx73OyPEJSH2y6M64QSsGlnbA+Q7Extx13+GDsChHhPx4x1p
 wJVrpjiAqWHd82YCo
X-Received: by 2002:a05:690e:258a:b0:651:b73f:2046 with SMTP id
 956f58d0204a3-65beeec76a1mr1407438d50.59.1777369449099; Tue, 28 Apr 2026
 02:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260407123438.48582-1-kory.maincent@bootlin.com>
In-Reply-To: <20260407123438.48582-1-kory.maincent@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 Apr 2026 12:43:33 +0300
X-Gm-Features: AVHnY4InI9mMtBO8C7-DQPHhA_SbuEYKmfzX9J2We1TR9vsrVbASwomMzGhkSLo
Message-ID: <CAC_iWj+SuTD4OM5FrfneXGiyez-KWUqeNEX+ANAUrwbjwtOoSg@mail.gmail.com>
Subject: Re: [PATCH] tools: fwumdata: Fix use-after-free in parse_config()
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 thomas.petazzoni@bootlin.com, Sughosh Ganu <sughosh.ganu@arm.com>
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

Hi Kory

On Tue, 7 Apr 2026 at 15:34, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> In parse_config(), devname is dynamically allocated by sscanf().
> When sscanf() fails to fill enough fields (rc < 3), devname is freed and
> the loop continues to the next line. However, if the next call to sscanf()
> fails to match (rc == 0), devname is not written and still holds the stale
> freed pointer. The subsequent free(devname) then operates on
> already-freed memory.
>
> Fix this by resetting devname to NULL before each sscanf() call, so
> that a non-matching call leaves a NULL pointer and the subsequent
> free() becomes a harmless no-op.
>
> Reported-by: Coverity Scan
> Link: https://lists.denx.de/pipermail/u-boot/2026-April/614161.html
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  tools/fwumdata_src/fwumdata.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/fwumdata_src/fwumdata.c b/tools/fwumdata_src/fwumdata.c
> index c5b0f56842d..44195ce2bf2 100644
> --- a/tools/fwumdata_src/fwumdata.c
> +++ b/tools/fwumdata_src/fwumdata.c
> @@ -84,6 +84,7 @@ static int parse_config(const char *fname)
>                 if (line[0] == '#' || line[0] == '\n')
>                         continue;
>
> +               devname = NULL;
>                 rc = sscanf(line, "%ms %lli %lx %lx",
>                             &devname,
>                             &devices[i].devoff,
> --
> 2.43.0
>
