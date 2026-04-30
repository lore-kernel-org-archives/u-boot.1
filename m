Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF8ECCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C2284198;
	Fri,  1 May 2026 00:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H7s1Kt8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE8D842C7; Fri,  1 May 2026 00:00:24 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B2883693
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c9d03524cso191160166b.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777586421; cv=none;
 d=google.com; s=arc-20240605;
 b=VqlOhdWWPbJeFRa85P1b75WkLMxfFINGeubeo5BcV49jQqUl1L3XLW3VLSN0xnb7G2
 b9o97+BdPRYl5hP4gp3Gks9xvpVoMBehoIUL3JHF6hBBsLyuBtFH8H6EChMpZ+F9K5oT
 9uGWPqv6PxNcMAg9IQ5HUKwZyWkK+ZMM0KSpLAKJ6BI+vKrmIE2PTctUgcbtfAL/CSBv
 rOf1fUl9XqwzInS4i2ThYZ6N520PM1hUNA2q/OeWlTplMRv5oHQk7M2IvCkqn/eviPUH
 HZup5rvRa7rCeMEetw42MV+mb1Qald/oLed2ZIWNw2FU2wAKsermgOlRXxnSQbFtnV3k
 ZdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zQvLQyvIGvgj12WHXPTvHDI5PiQ0Wh31GY9IVkVqgSU=;
 fh=6J/MNr/sU5br7Y0Rao8dp8Fd7Z4c/OI3V2XIga8rWl8=;
 b=grVLgcLAHQQOBzCdGCrSS85VddILXDReJNI1r0hweFWtGFCI6vZc4Ce6W7AqMJ1Bzf
 tyAAPr5Joi0r+6UqAGPSFeeqbQP1DHkGUzwNe1sWgcLcGyeW2uhVE6qsnbyDotxMXtEH
 nxDAGRhKK49vdIsOSRl3rlPCz12oJHX5fUH5ZfSaRdPy1gsbYwcRzl+BZqL9GvmXBYqy
 3rIDbd9Ha84Upl5DYmhK4rGnf8d+YzcUIbdxRjzb/Ce8xiOaE0Fs/PueygXGbQFE7dYC
 fFnf6jRH2/03/tFP3jRHTVnR7+A0w8oSkTI/4fqDy2u3BmXCB+bq8lpcfnmYrn9tHcjN
 GZVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777586421; x=1778191221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zQvLQyvIGvgj12WHXPTvHDI5PiQ0Wh31GY9IVkVqgSU=;
 b=H7s1Kt8EACPbYw3K9IILIGMu2Tw7nkVCas1agLrszgRQKhCOQgMKESk/EBwiXSXblL
 zBI4LE7+CHD8TId69Gds6/tVsQY9YvS+3rxBq9p7UuvVr01itnrxpHgsb1P2ivKBedjB
 +k3Hn+t5OD3eiNNZ1hwcZUULll3ZstyvOIT6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777586421; x=1778191221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQvLQyvIGvgj12WHXPTvHDI5PiQ0Wh31GY9IVkVqgSU=;
 b=SDNzRE61cZkNvXOHt9SfsgjVTeErMOceu2ncIA4Trw+Q87NadCHb1YLeKy5IzZYjjq
 vj92ScnMkaXk+948n0yL6x++W4UWQO7L237C8ycMHLITjcZmDI0AqaOVo5pIMRCweaGx
 bHh4Ph63tfGikos9qQ7HCcOfKLtvn0bWMQVCqs6+syJ9fkUsJxv3+jRQuX14EwIvQ+DM
 5UQ2s1NJiZru9VfDc8l225Is5kzFlJHvrm68bnSsbRezH5RxCUAgjKBdrwi38Ou8njEL
 BdyTepyTaQJ6p8WjRAE6u2gEgUn8YXzHMmpnrsKLC0jwQc/6ztUfhw4OGpNd+z9uGnAK
 8jmw==
X-Gm-Message-State: AOJu0YwuLmSfO2Rq+1AYrVRjmAZVFip3N3vTLqyQKejVn2MDNrg4rQFk
 wkuqYdT+XemDMt2Qog1In3LVqIUuS1A36Kyg0UKbPrInZt6YghLAjp9ph4wiY7TlsKm5LAf1J1+
 zyOCSIhfotOB31OF9+8XpT+fO8uIjnIC+GAC901HPqpEncvUIhusLGw==
X-Gm-Gg: AeBDievicOL0q/EF3xqXQ+zDqXhdblhl6UqtTULTiqUBoAYku1fwxMWmpJ/1zSm7/mO
 aWs0esqkj5LANxheL7XOQvKZrlMydKSoTCpWceEI0H/q1EzGlshBanSYD4BXbsFMmrc/j6VCKlF
 HXLrBIUf9sP2efHiCUdJv3/AaBMtpcDXPxEm/A5GqlyUBQHtbL/9MEkBh8zmbsQwhB/tGbRtQS8
 3vmu4QG++ClVNrRoXCVERuLV06smBYy23+5UF0T1BVKs1e375nAOI3jxdY5e1IBB149+wkrfDYf
 QhEJHp+JVSGxsn7H
X-Received: by 2002:a17:907:980d:b0:ba6:be92:a58f with SMTP id
 a640c23a62f3a-bbac7c9223emr322927366b.44.1777586421012; Thu, 30 Apr 2026
 15:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260428133612.669105-1-ludwig.nussel@siemens.com>
 <CAFLszTjT691ZQudD_tJ-Os-pVnsLQjto2QeYv32tS5Us7wLWRA@mail.gmail.com>
 <ca01a914-2308-4274-b538-0359ecb29632@siemens.com>
In-Reply-To: <ca01a914-2308-4274-b538-0359ecb29632@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 16:00:06 -0600
X-Gm-Features: AVHnY4KKSllY6K8GYE1oC9gwaSJtOA8CY7ZbzgaqqEL2vjPr-5l_JPKLtPP5arQ
Message-ID: <CAFLszThMDg+w+rCOLHnFNQwsFHa18mVB2NkzqJwddSR=iv-VMA@mail.gmail.com>
Subject: Re: [PATCH] virtio: ignore ENODEV for boot device hunting
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Adam Lackorzynski <adam@l4re.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Thu, 30 Apr 2026 at 03:01, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 4/29/26 16:20, Simon Glass wrote:
> > [...]
> >> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> >> @@ -382,7 +382,7 @@ static int virtio_bootdev_hunt(struct bootdev_hunter *info, bool show)
> >>        ret = uclass_probe_all(UCLASS_VIRTIO);
> >> -     if (ret && ret != -ENOENT)
> >> +     if (ret && ret != -ENOENT && ret != -ENODEV)
> >>                return log_msg_ret('vir', ret);
> >
> > I don't think this is the right layer. uclass_probe_all() walks every
> > device in the uclass and returns whichever error came back last, so a
> > single bogus mmio slot poisons the result for every other working
> > virtio device. -ENXIO is also returned from virtio_mmio_probe() for an
> > unsupported version and would still bail out here, which is
> > inconsistent with what you are trying to achieve.
> >
> > As I understand it, the placeholder/empty mmio slots should not be
> > reaching probe at all, i.e. the bind step should reject them - or
> > virtio_mmio_probe() should keep returning 0 for the 'no device
> > present' case (wrong magic, ID 0) and let DM treat that as nothing to
> > probe. The unsupported-version case is the only real error.
> >
> > Could you take another look at 70101c3217ae and see whether the fix
> > belongs there (or in the bind path) instead?
>
> I don't know the first thing about that :) Naively changing the function
> to be called in bind() instead makes u-boot crash. It would be possible
> to change the return value in the probe function to ENOENT instead.
> The driver claims to be ported from Linux. In Linux the return value in
> question is ENODEV though.

U-Boot is a little different from Linux in that it has a 'bind' stage.
We use -ENODEV in driver model to indicate that there is no device.
Standard boot uses it to indicate there are no more devices (see
BF_NO_MORE_DEVICES).

Checking for -ENODEV in a device doesn't really make any sense since
there is clearly a device (you just called the probe() method!)

I think -ENOENT would work.

>
> Maybe it makes sense to make virtio_bootdev_hunt() ignore all errors
> instead?
>

I'm not sure about that, but I see it as a last resort, since we try
to report errors where possible.

Regards,
Simon
