Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1485CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77F3C80ED9;
	Mon, 19 Oct 2026 13:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mOP3qZ8yCiwH; Mon, 19 Oct 2026 13:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD9A180E86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792418058;
	b=Y8MvN/fA5/w5TzUahIC/XQJ0ATrtg2j7hRiywYu3b9rpiX1t5PNeC2IOeLXzUPDCjIRz
	 xQohsBOWP1efuTdsXzsdsHF79wx5RxAtjSOa7I+KB5tBHMJ7y7wJE/3Czw0VC7iXhawWC
	 YipkTFjPORr34OfVTGLAEUQOKN4zt/2ZhROev3S93Pb0AoC8M2VRtisHea6BQTKwESamX
	 FZWHn7Kqqv2N/BEsoDQXEg8dlxiY9u628QyP/eypp5kTrtQrH31rHwj6nqNarRNuGgd9C
	 fP21PSeNaVAmTGjHd4OuWwX74iI5/oC89HLXxBz/PoBafzjIGVqAfeAkB8VxA0q98pw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792418058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
	b=gqSyTue/iyfiIR4yQuvU+vkAk4V36cM4iekehbSF133TVJrpWjJS/ZELQIrGcJdJ1zqq
	 +7jP0g+huaQpq6k90U/slJl+NSl7/Lrivvc9iMkskV7d3iNdl3djkPWbEioFl3hEXCRh6
	 fgQ3uCduw09uc6hGLXc9QEV6MU9xIh0iK3lnrMxwMFkA5Ca1HmTfRpybObTjJ6XAf1szB
	 RyasALgdwU9ppJ0Hxn9H/VaARC1jIrDE1bhi/Fm2MLrGqS3BhKO4jlkt3S9qi6JcccAHX
	 GX0Gl+w4MZyxbnio49EbQaCMrQ+OWB16viTdCplp5p86e334ggA0rwTib8ZN1doexCg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D1mpzIHn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792418058;
	bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nk30jY7qRPY58OPFPSrVSJQEkCDX6P0j2Sa2bzsVNcYaBATsHl/5yi5CTNzB+UzII
	 UyVtzHYACrDImDQc5ZlHCB3z4SpX7RF36OQHBLmhjJZB24geAN+hNCYpCTex4/QD6A
	 neJ9UloHRpBoQNGCB3d/iIhtgVaSTcJHNdSHFRw3Rhtxp5A+lTe1yPWX2OQzgFlPn6
	 jHJ+9jzRLZr0DsnExkgd8nbx3Ve/gnP8fxslU5CU1LNh6sE7dYI2RKrEhyOiloxC5l
	 MMM8bnFz4fz3ZDChu9T1F3jlfWDs31XsPj7bTFezMYZdDLbeoxxwJo8IlnPN9CpB9X
	 /4u0LU7PfWD9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD9A180E86;
	Mon, 19 Oct 2026 13:54:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC6CE263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D250380E8E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T97ZiU62T55e for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E86F880E6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792418056;
 b=Oew6hjHWQ3eOwxFsR+HxXuEgWdR/iq0RMVLfr0TUk60RvQoL6XD3kDdotDgF7/is1OHg
 OQtXFpfftybGeD7lMENTudxNa00Z8RsPMKhkPjlXGnhZIYMQggVEEvY8XaP2uSJqwE3ha
 65WqKcjbgKI8I/ScxZerPauwAu094W7xNJkVC6fOW51nAZERUW7nt76d+JRuO5DzcpxaF
 /Cgqi8vxhnTwoEpgqcwf5CzbDe1x9ouWfo3Lbyt9BPd/+HD65jvqIxwvv+gKVFTYXA6Hq
 CYx82AL7NUvd1x1s5JeXW+8aYbTi72nFzPkaSccRvFr0Jd3zZlSb6PPUKI2/u90Hngg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792418056;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
 b=UUkpSZBhHZBBWvnW7puP5/JQJHwZz1dNHq730h05DSuZvrv3xeWvywq9yaKrOs5C6dzN
 AKOJ2AC4JzXkMKb8EMeXsks4hdBiBR+qDQvFxFHE1qLXcHKIoj1G0uQckEsJ3xcQzqphR
 Q69d7PahuMXGoYZ4kN+88zVHr8X2fTBmoQH+opQafru6PBZj06dAVXBusdNfV/bhvL0h1
 bOGHdIjgyJyXt2coQwAgXJE3rc46PvlK9PU2+iG4HRci1v7p0DpkSfzzud6BkTpcImeoK
 QHNd47H0AkSzHM2P+UIwPgBpfGuhp5FTDfTGW7BcMksV0Zygt+s6lH5o0NP4VA1Is9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D1mpzIHn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=D1mpzIHn
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E86F880E6B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:54:15 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa27963eso4649299a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418053; cv=none;
 d=google.com; s=arc-20260327;
 b=PHAOANQ15e8inBgw2fJ3Qn7dpdCXN0AG/vSduUFed7gkIhl7OB3N8mGpyOvEAHAnxF
 F4SR2QfOuaaiUQKyDobNva4XmX47eisasEeogYuiq4K/Qax50V9Qs0BHVEVNdGH0ffvh
 IEYxsCz6MvjXP4bsrRJH+9I7UGGPY+OIVy3pSxv/vVzjUpdUnYEl8WvLK72FGIitZCnC
 VgrcMJHSUa7jvd/KdHSWOGWj3Bc2oa+E3Y3uub3MvC5GYE0yhywmdpbDB4jVC32f9x/m
 gOGUYWBs+dlVcdQwCs5m/0Eqt8M7KK3ez26J1cwPmBwOunMEbQo8fW+JTMqBj+ryseSC
 h/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=MRFaLre3vWwOyWO+QighHefEmuHTTtJcACt9VTcn6SrvAJ0exGYSZwrQt0G6t1Blte
 VZATSF6Sco96911Y35L9FB8Why+wNXXhEp3fa4vKA25NO0uWXQaJSEEVRLgN4ETYDu6Y
 2y65aUO4m+mjHFq95D9+13IF8DIrkQsAzILFZodQ9la41uRTnmjTGL0EXj2VU4Qo3e6s
 4D7s7fKuROdm7v4bmi3LF24nd50VSzFkBOD1xxCqMEKAKpitZWclxhu+jj+peIA2UQAw
 D5RiBEottE0JacOqP+w5xI2Jc3E7VOc3+L6MnTRqebwqWhOzCiQxPKmpj3LDpsfKjlbC
 HN9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792418053; x=1793022853;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
 b=D1mpzIHnh7l6oQUC9CRDfsFSUDQYwFkMChidYV/2nI+/keQKs8KfFlRECxw4PKfh7q
 xC9zhILJqKCV1dHqmEaIkmIiwxbCKvVtWC0zyDp7j9nqNOZiBh5C08r07gpdLqIAs6vI
 9KOShjpS24XEOe7WK1czhfYiCUGVuHQmFUoNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792418053; x=1793022853;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1WSd40pMyV+ZX/Wng6WYsaRPTcjeESDNYSwKt34QEP4=;
 b=vxCuGf4kW70IXZoZEnuG7HkUQY4jNx5c4XLxPwFF8Hq45UMUA+hzbnRLndbNuOBVEy
 XEZjtjLU+DRZsHKn3r5X9ighDqTRHRzaXEYR7OI4isTWAsnLba8LPCqC2VfSuGAcl0ti
 H47/3PxVlezCMMCk4nudUHDlaRTSOHQWvCY7If3MOchl++CM+2upg9lHWkqN7ZjPic58
 jy40rXFrTE5P6cojMUNFHhP50a6KPnuPmL5kyBNw0npBhm01GzrXDlbLi4hiBmvSP659
 YZ1r/gGcdWcjTICUCVOpEkDWb7VjDyAJlP7qoVy+8RScwH/oB13cIei8QRXD1rLwpFgo
 k+Lg==
X-Gm-Message-State: AFq9FYLf0OBvH/YzPgccLoqNO0YdkNG00IWU3isdmn9JnNnI8gDZpdr4
 qpmfxkFeMk+scLpWWnAZ4zHsnXzyxyikfiqdoMUAiz+kz44HS5xw8i3X+FAqSJpYhUDHHMOAezT
 BvJiM2g9Zfz715vNChB7Zxg+J1OUw8gmIcs77BW9H
X-Gm-Gg: AYBFou0vLHScUzNLj0mh7j+keJGm8qxLEClJhoK/vBi1H3ncmHpGaiF7gPK2znv2VBg
 9/dSJP9pyG8dy0+EovOWeK4+PeeKvtEAk7eheiND+J87jsK5HLoDCrCgR2mfEnqpjKMZBZ3p9Q7
 7qAH6nw1MBmlC9Pml6aHORCkH39cSS5RHCAUG5qnl8eKKF3mDjbUbTiWIB34MSwZTgVfW98m5cw
 IfAv8nUB/MDCwljd+iYHfOn9xWZpItwP1lcWCKkKG8vDNa0KTZzxs3x3nsW6NawgRYL/xcsy7RY
 IssQphyXnBaX95sbqbweEGVP9Z9v8yC78vOXgz8S6qTsGA1Xk1Xnkw==
X-Received: by 2002:a05:6402:3216:b0:6b1:ee83:19a7 with SMTP id
 4fb4d7f45d1cf-6b3a8162278mr4814530a12.5.1792418052021; Mon, 19 Oct 2026
 06:54:12 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:54:10 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:38:02 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-5-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
 <20261016-ccaione-upstream-fdt-fit-v1-5-f6286ef82364@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:54:10 -0700
X-Gm-Features: AclHuK-jmRt_Oo1c_-9BsqADTe2eIPCr6EHhIE9Oc3KfzGkrgxv87lKwC3XzafE
Message-ID: <CAFLszThe_hJkYC_Yk61K4SG-anrBOEF-THmSPPOcCVP6b0qi9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] test: py: cover fdt fit preparation and failure
 handling
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

On 2026-10-16T08:36:59, Carlo Caione <ccaione@baylibre.com> wrote:
> test: py: cover fdt fit preparation and failure handling
>
> Boot scripts rely on fdt fit either returning a complete, verified
> devicetree or failing without touching the destination. Regressions
> could otherwise leave a script with an incomplete tree or overwrite
> memory before an error is reported.
>
> Add sandbox coverage for successful preparation and failure cases,
> including overlay order, compression and FIT load addresses. Check
> that verify=no cannot bypass required signatures and that
> individually signed configurations cannot be chained into a new
> combination.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  configs/sandbox_defconfig     |   1 +
>  test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 372 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
