Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9927EC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4486F40B9C;
	Wed, 29 Jul 2026 12:05:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BD2dSApEZpSt; Wed, 29 Jul 2026 12:05:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F5BE40B7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785326746;
	bh=EYML5y+eL6h1GIq3MF4RWH4yfB0Kv31v0x1kDd33T8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=obghUNjXthHA7tOs5edAYBSkH/fWK5e4J5whVpIvhDxPUvAf/aopQY6FGWSjoEymI
	 B6z0WTvnAdoYcqVD9P4Vy6PcV5gW2O5g6RG8VsENywLULC2ljOJFVOvdbCe0tLtxIf
	 SL0gp6q0XUvFt40/3IgxapzDhmjX8RjZhHuWin4Qwd1RxXDTOFL/9UCEJZKrk21qmy
	 mkDgymFCaUsR2pb4akN2DEkJw62T99GhsxucLflbAcYUjrq0lgqGjII2hwGbMganCB
	 7CG2Ygq6V0TF08WMyTKZhNAp96Bw2a7wGqtCKQvNx+GGFXWHznW5xuskoJH/y2XSDM
	 CoD2w5JFrDymg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F5BE40B7C;
	Wed, 29 Jul 2026 12:05:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62A5A350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5437040B7C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9yC-gpxGzbu for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:05:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6B90A40B78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B90A40B78
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B90A40B78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:05:44 +0000 (UTC)
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6689f36ae56so872095d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785326743; cv=none;
 d=google.com; s=arc-20260327;
 b=B6bKuuzNfArDQvnm/Wp5mgHB17/rZcVkFOAgX85oQiCXqRW/ijJq7sgIjZ5NfQs890
 zo/Q/QePy7lO4GQDgWOJc+QfEG3zaLkK1O2eLeiZM7v4tTWacJOBaw+Zoa5p3XCoQ5tY
 Tw4bRxacwnTbMjp9P7walEnWwcrbuokWu5fXMhKDFAmYqGUb37d6fZt+6H9E/WVVGHwd
 f1P31kL32W2d5/Wd2Qkn48B8nGhsfDbEZqXw9z6/TXzmPZ+AF0IgcTG0tS+1kHdmxkzR
 Zq9SsqXF/G3l8GbJMnxvc+zU0GjySWXG+/VWq57whOTmmVoqrV9lWUbtidX6B0qj6uHB
 7OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EYML5y+eL6h1GIq3MF4RWH4yfB0Kv31v0x1kDd33T8s=;
 fh=pIZ8No7NIl9Bt7mv8pFOokKWsk/dKDWA+ZW3PLfGcVE=;
 b=c65BIaEd3r6QydTq+3gdMXhS2RBfjlkXc3ow4alxLsGFl68DkJsGHg2a3fAzamldsf
 YVbM2y1GGZzFg086oKtF5CxXimYnCdWBbWYfM7yeA6gFGphU8xJxWyZCNh7nGawPPwYm
 +N4xcJHruIAMh4+ksyEcZxnbrG3MmVx4DqomQF+CVKqntg+khgLEhCGclex6icF5AEjT
 r8En1ycQbhOcyzidIFFQ/OokGyze7BOp5xTTHWYIxcE7f5gz+txujKiKy/OHpXt1OxmP
 BFaA5yJzIMLjzC/jjpx/R7iYKNhcjfLGhIv2mxjmMhsKlhEyTwYpgJPLhYfkaCT6ZiNb
 doYg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326743; x=1785931543;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EYML5y+eL6h1GIq3MF4RWH4yfB0Kv31v0x1kDd33T8s=;
 b=P7g/yyGC28Dil6pIwAf67/X2i0sl1ahDc0lsRoYp3ObFx2jhqBMeVU1RD5L9xN72rc
 pQC2YUTmBqDk4eweEPZOrMMk3QKHrf6fREwHa4JgzcIQRYtTXGgHQYbOauJ872M7PzHl
 w/fi4koTLj8+DPQt+EPj/m0ZD8hFPAO83/g5IlHtmkFnTKvLCVhxX8Eo31okR8XLPrIL
 Nnyna+WFHNbKNxJwKh+rzP5we9Y7Sf6aIKcB4C6V2g7v9gYlsAppZZ3b8+WBUQPgukII
 ZvT0UhzyldvOVG0HrhGNgPD4MpWomEbQSWbqXPUcrilMs4qml1YwKHgq05gaL82XKLFA
 DoGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQFMKQHotDIJy3YtbyOaaHrws7qbKOs3r9+bs4dCisyM0eoQnt/unL2OtW1dn52yq7VZQVSGY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwTLr1D7ivIpl36LGtNqwLqtn9+e63JJmYoA0b2fxn7qRAbsk6v
 v/Y4FXOCnDY0phQ7SDVboq+s4nGi3PtPQMjDE9actlANp4OEUNAb0rUdZwvi+hYyz85l9KAe1uz
 4MGUudRA0FPYmx0O56kRkPo2jxlcJJ/GLU+w7MXG51w==
X-Gm-Gg: AR+sD13BnfTfq3EzBmt38UaaaebBRl4aXYB2wOA9pf0bdfrR/e6RhdQl1wVDOnbEkGL
 upRrPaSIgRYIDKAvjoDgV+6mQud4A7+m6MhJUcPWgOy7lOPi0NXfHY5m537CVYBCR92CdNL6usW
 6TerWJHUxGeN0L0KO7ROCrxeuphIxS2gEYXSRSd5JLYzFyqqUm5PpCeaSKecCRjxMuQ0aZrYlfi
 3/yPz6qa9/q/CKakWBotOVWCY2X9Wx740/60pT2ZwYji6tTVlBEcdKCpOOgPfu+r4fxwnJA+swu
 /Hfybc0U7XURw3xWVLNBPnlKQI+YyqccBCNOFfIl2KxPjHtiSEXtxsbq2vyA1KrubI3xKBsxYLZ
 mh4/YMiFO2bHCeohV79awXU/zsZYr2c+cUb28wBfxV0uZQtqUA8jz4+71IWuAGc6jkQ27Gv1qyj
 KubcyUBHprc1xC2/ho35RKPuhcR14jYfgKXRpfT/zba7oz8loQH24jc+YwVa2ChlN0Tds5Q8Raa
 M8F4EW5qVXK5m9hb6Ac9AoARM8SRuFHjs2Sp9P77jdGKptKETYDRuzTT9soHmDoDRdcfxEwYre/
 mf8O5B5WvI0tQ+ZrA7O4+g8U2T5i7/4e/NCCdm5t6G9Ko7cZQqrsOuAeOlKz0+m0/K4Nyok5Nlb
 T/NcQ5tIqHIi3ci1D4VM7JoKzmLt9vwvWs5aJel0H0zIJWg==
X-Received: by 2002:a05:690e:150d:b0:667:db0d:dd5a with SMTP id
 956f58d0204a3-669056fb5abmr2500306d50.44.1785326742746; Wed, 29 Jul 2026
 05:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
 <CAFLszTjxT3gfjQ2Gx4OuNEc9BLzHj3jKP8irNfgCrLvJWq7bKw@mail.gmail.com>
In-Reply-To: <CAFLszTjxT3gfjQ2Gx4OuNEc9BLzHj3jKP8irNfgCrLvJWq7bKw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Jul 2026 15:05:06 +0300
X-Gm-Features: AUfX_mx06ShMaNVM9YHq_VvfcnyGrDahNlmUe3vV7PaZibQGs6ha7NXVPgz556w
Message-ID: <CAC_iWj+JoMfdYiF-1YL7yTZnOSUio9V3W=Y2tAcbLZ3D_S8Q9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: bounds-check the device-controlled response
 length
To: Simon Glass <sjg@chromium.org>
Cc: shahriyar@byteray.co.uk, u-boot@lists.u-boot-project.org, 
 u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>,
 Dirk Eibach <dirk.eibach@gdsys.cc>, 
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785326743; x=1785931543;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EYML5y+eL6h1GIq3MF4RWH4yfB0Kv31v0x1kDd33T8s=;
 b=rm3J/xPfjhW2qXjL0Ri+k7Lw3TwZ6tryUV0/V8Qku+X0SubJGHVPvDX2Q3WAzvJaDK
 sQisx48XzrlBVl9BwxEhpbM6W3QpBh5kHql8uUsO3kEslc4vP6vkKAtb05yy6I3ZxrZd
 4dJr5QH3A5LVJ5H9y4eGi6lVcydxZy+jcedjXqlt/x7DPVmcDayu1Gonwt/WkVVuKzjr
 3jL5wnwsmysg3wTrwKzy2Lfn4IDXdgyFIcMWAH1ONnst904bgXi567zWKuJIz5V+hX87
 FLB+c486r1B5s/ODiJ4VKKpZ0C34xBUadGJr60dNzrPDDkwUo8ukFIEEO70TEkIUFO3h
 MfsA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rm3J/xPf
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,


There's a v3 instead. If you have time, take a look at that, since it
changes the logic

On Tue, 28 Jul 2026 at 21:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Shahriyar,
>
> On 2026-07-24T10:34:14, shj <shahriyar@byteray.co.uk> wrote:
> > tpm: bounds-check the device-controlled response length
> >
> > The length of a TPM reply is set by the device: tpm_sendrecv_command()
> > stores the number of bytes received, caps it only at the command buffer
> > size, and reports success whenever the reply's return code is 0. Callers
> > then use that length without checking it:
> >
> > tpm2_get_capability() copies response_len - 15 bytes into the caller's
> > buffer. A reply shorter than 15 bytes underflows the subtraction into a
> > huge memcpy; a reply longer than the buffer (sized for prop_count
> > properties) overruns it.
> >
> > tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap() pass response_length
> > - 41 to verify_response_auth(), which a reply shorter than 41 bytes
> > underflows.
> >
> > A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
> > a reply this malformed is reachable by a bus interposer or a faulty part;
> > on the TPM2 path this parsing runs during measured boot.
> >
> > [...]
> >
> > lib/tpm-v1.c | 6 ++++++
> >  lib/tpm-v2.c | 8 ++++++++
> >  2 files changed, 14 insertions(+)
>
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > @@ -519,6 +519,14 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
> > +     if (capability == TPM2_CAP_TPM_PROPERTIES &&
> > +         response_len - properties_off >
> > +         sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property))
> > +             return TPM_LIB_ERROR;
> > +
> >       memcpy(buf, &response[properties_off], response_len - properties_off);
>
> This bounds the copy against a size derived from prop_count, not against
> the real size of buf, which the function is never told. It is safe today
> only because every caller happens to pass a buffer of at least
> sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property) bytes. The
> kerneldoc does not spell that out - it describes @prop_count only as
> 'Size of output buffer', which reads as a byte count rather than a
> property count:
>
>     @prop_count Size of output buffer
>
> So the memcpy() safety rests on an undocumented contract. Since you are
> hardening this path, please can you pass the caller's actual buffer
> length and bound the copy against that, and document what @prop_count
> means? That also sidesteps what the bound should be for capabilities
> other than TPM2_CAP_TPM_PROPERTIES, where the copy is still unbounded.
> What do you think?
>
> Regards,
> Simon
