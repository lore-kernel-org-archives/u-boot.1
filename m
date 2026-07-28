Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3823C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0120A40A30;
	Tue, 28 Jul 2026 18:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 556CKXMTZ_KL; Tue, 28 Jul 2026 18:41:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A4240A19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264104;
	bh=m2CqG/YOiQ68IEbP/4cImo1xDth/5b8ODsVJSAHDA/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D5W+yvd68LJn7HRlanYGxckjjUL86YIWumOmrWX3pP3fI7703hudi8jdoGgeXsJAE
	 fGGQOvaoX5OeTMiJkX0Xa+eJKUni8/I8aKs8HnwYddOdR6qcSjwGCx7RzeD4Ft+HOW
	 2rkIebekAUg8ew3gEAJReP5KlrPMq8pBF/x9/zks7am3I5iSm2g5YU31aQ2IkyQHjV
	 5Q9g4FEWYIgfxkyUJjzCCiqq21HoMPtduqDwLjLR8LLdlzqCaMA2X0mwyp6Z3MS3Ug
	 qQhaeD05bOsQrCO3FSjdKWBfQ22r2w01rbAalPFEKijerl2IOwKzfdO+yvIz7WnfLL
	 2kAYuEGc5F7uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A4240A19;
	Tue, 28 Jul 2026 18:41:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C814BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:41:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40B640A19
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OaInR2NkD4zQ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:41:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1EE34408D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EE34408D2
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EE34408D2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:41:41 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a02aedabadso110026a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264100; cv=none;
 d=google.com; s=arc-20260327;
 b=HoFQMqmxKAG4PQP+m6JJTS42hPV1oacr1TAF7hC+qF11/jKAwhSFXQy/y8kSrfcqLB
 gZK8LXJI15pkkO0/ttQscvV1t7S4KMzZIoK/DeL9YcdIVySvC7l9vXreebOZotO2sptK
 IvCzwJEPZa/torg7U0VZZi+2hKQ64X6Cfj4BK4S3XkiyFAqBU5rRZhjDhP1EhKGmkVdF
 Qzq0biX4vTd2J0aX6VyzUlgP+pmCx7q+UlX9eRqThmgckyOMz6BsZBjX4KnVvbXqlBMg
 gonVjo/57kDIG3ZNF/QvTJf1ZvI71fP72n5+ANvEQplPhzNntOVJoXJPmtKg1/H7Aw0x
 m+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m2CqG/YOiQ68IEbP/4cImo1xDth/5b8ODsVJSAHDA/A=;
 fh=1sJY6HnY4R4oHTO5tCWkmbpubr7BE1lyMmOuiyCO0PY=;
 b=lD3KjqNW7/9FI+4rbpA6qInFlHxUIjF1o/+dFUJMkHdvPgPNou8h1+IogRcw+PDcIO
 eqodjtnpBwUHuYHcr1s9pkWG6/K9brYu22M3A1CFZ0Ucs45LrAAperUWj2uquyT7tpz0
 mLCJapozK6lcvH167chuFV1TGliCKjCZsU1crgOSXn9qhl+HdxtnN2fMmguSmgBIwICS
 Y011ok55mUq1Dfm69lHMrlYu2gSsXUIlLQJlmvWY1xapNDI3GcrH5Xlh0mcX5tCiOU2B
 CdR9A3DZNJfS9J8iVpoX/R3uoc2MwMI9FRcn+q3uFVviGTiA5xruNJxNgk5QOY089Taf
 Js6w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264100; x=1785868900;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m2CqG/YOiQ68IEbP/4cImo1xDth/5b8ODsVJSAHDA/A=;
 b=JWMNWEK9YuLXEwQy9hIKHAqdQkiWSPEAJS344xmVGeVUO1k0pjT5SvyeHWjtSgAVW5
 SU9JzCnPMaHB/DZIHZ3RkL4XxK4qnXWmA1YHZQijrpHB3DC5wvDGbXLRgacdSXrSoIo5
 igLPrUgAUQ4z3qLrmIgvFrXCC7iHlEynfi2vOX7rAdhdU62HB9wPln+atSHDCdBQE+B3
 Adxm7Dw39ffm6IY+4JGgrrpO0UaYDlSinsSH4kDfEQUsyN8MkhdWhs/pwLPurq4/pYwn
 TaGrQFNIIC4UmihMP7DLeVsGltkGyxIazWWxJNXwnxkKpgqTdeC19xaTD3cdospd3vnu
 2kUA==
X-Gm-Message-State: AOJu0Yxl+JcZOonr+GUfQPOL40vWgIDbyOePxpP/qMU3H6EBzCKIjQA2
 xfr9BzRk2quV1w04rEcNqOhNbcjzsAutu6eGVm6WdgE4ob6ehzH+2VD4j5ZEvfkCMFq4FasDPUH
 so1a4qdTEgjzgN8dUWeRgF7xkaowxWR1emffHlYrB
X-Gm-Gg: AR+sD11QqRgZ5uvhy1USB2RH/7cCe3uUtbATK6M0feDjnOL9L6AyBkOB5eRSdQTHpvN
 UWdFZFtR700hcvrYIZBZ9fsCY8GeosI6EhtPnHy3T0McvoVmaA6OjAH4UD6NV0koj8icaWcJEl+
 oTMN8pfHBLvhlfoOIjn7j1qyE29h58yMxT6awcoR6/BJzUu/tZvSKsMA6wk/vdvl2Nr9ygFa9Uv
 pruUh7N3yWZHyA839t0+yYSzwxlpSLdQW5e8tyJC22OpZj/bZlEYtNdynaE5rtOyM0Is8s=
X-Received: by 2002:a05:6402:1e8e:b0:69f:d41c:fef with SMTP id
 4fb4d7f45d1cf-6a034a0861dmr1829530a12.6.1785264100139; Tue, 28 Jul 2026
 11:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
In-Reply-To: <20260724-tpm-trunc-resp-v2-1-381857e959f6@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:41:28 -0600
X-Gm-Features: AUfX_mzzOCPVUXBpiQ_PbdmuaC4wObgbVEq8kh6InDJP3PpzQKnTaUqjqecGjYU
Message-ID: <CAFLszTjxT3gfjQ2Gx4OuNEc9BLzHj3jKP8irNfgCrLvJWq7bKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tpm: bounds-check the device-controlled response
 length
To: shahriyar@byteray.co.uk
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>, 
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>, 
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264100; x=1785868900;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2CqG/YOiQ68IEbP/4cImo1xDth/5b8ODsVJSAHDA/A=;
 b=KQWaeKNFDn6Yk4LDLE3xfKjOo/uucl+bgAqGqB/EWCYioaERXf20hHwtnagDawQowh
 aQZC35USkUWeU1093cPRtsmJ0hX2W9649L6i1v8fDO0xMHl8yVffCBbYa951kk2vU7Y/
 tQTtkcWsJb03FYlDMLjX+dvMVK82Q3aTuRpck=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KQWaeKNF
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

Hi Shahriyar,

On 2026-07-24T10:34:14, shj <shahriyar@byteray.co.uk> wrote:
> tpm: bounds-check the device-controlled response length
>
> The length of a TPM reply is set by the device: tpm_sendrecv_command()
> stores the number of bytes received, caps it only at the command buffer
> size, and reports success whenever the reply's return code is 0. Callers
> then use that length without checking it:
>
> tpm2_get_capability() copies response_len - 15 bytes into the caller's
> buffer. A reply shorter than 15 bytes underflows the subtraction into a
> huge memcpy; a reply longer than the buffer (sized for prop_count
> properties) overruns it.
>
> tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap() pass response_length
> - 41 to verify_response_auth(), which a reply shorter than 41 bytes
> underflows.
>
> A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
> a reply this malformed is reachable by a bus interposer or a faulty part;
> on the TPM2 path this parsing runs during measured boot.
>
> [...]
>
> lib/tpm-v1.c | 6 ++++++
>  lib/tpm-v2.c | 8 ++++++++
>  2 files changed, 14 insertions(+)

> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> @@ -519,6 +519,14 @@ u32 tpm2_get_capability(struct udevice *dev, u32 capability, u32 property,
> +     if (capability == TPM2_CAP_TPM_PROPERTIES &&
> +         response_len - properties_off >
> +         sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property))
> +             return TPM_LIB_ERROR;
> +
>       memcpy(buf, &response[properties_off], response_len - properties_off);

This bounds the copy against a size derived from prop_count, not against
the real size of buf, which the function is never told. It is safe today
only because every caller happens to pass a buffer of at least
sizeof(u32) + prop_count * sizeof(struct tpms_tagged_property) bytes. The
kerneldoc does not spell that out - it describes @prop_count only as
'Size of output buffer', which reads as a byte count rather than a
property count:

    @prop_count Size of output buffer

So the memcpy() safety rests on an undocumented contract. Since you are
hardening this path, please can you pass the caller's actual buffer
length and bound the copy against that, and document what @prop_count
means? That also sidesteps what the bound should be for capabilities
other than TPM2_CAP_TPM_PROPERTIES, where the copy is still unbounded.
What do you think?

Regards,
Simon
