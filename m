Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71590C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 193CF606C1;
	Tue, 25 Aug 2026 12:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlicRThML8vP; Tue, 25 Aug 2026 12:56:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787662584;
	bh=L8P93sit8uaJ7c4ns09OL8+9XmlHFbSmpNPNpeiqPKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NnnkWvpLSfgkQX10L6dMP3XMaKOwS7p+FGfH43uVrc+NvqdhU9Z0qY/UaqjXTnO48
	 vvkNrYcOL7Djc6klUucjSMhuAraUjWaqjGr+PF/GaZzrjHj2zjMgdsUBZ7kyLy1msx
	 FL1QRDf8nJpKGd5tXEAqYuESwBXDi4SFgEBSGq9d1zykx0ILnO9MlH9e2BXrzfGShc
	 QkgsZZt53UuIPVI/bt8WbxPQR4F3y3/G//MWC9ri74yYGPz1FcxEisihwt/Zai62Yy
	 ehqwff/LxymFG0qNbnK1YuF8Xs80sns/G+mB2snsFqgsF4e8PRneJRc1UskXIhVR/t
	 W+z05IuEtHREA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13895606B3;
	Tue, 25 Aug 2026 12:56:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51ABE3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33F9E4011C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:56:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqb6X0CAjIdq for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:56:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Gy0x/NjV
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA9F9400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:56:17 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1677c91969so573590866b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662576; cv=none;
 d=google.com; s=arc-20260327;
 b=RWngSHZAtz6hhrCOlpFnIVQm3k3D31QgMWQQWMW2Vpk4E5QsHS/f3AbN4R17HLZ+Ty
 97PcwkMQqOQK9hczw/meKzuq9VdGZGpqHE7Nf4Ery46tQLIlGPFwnFiYGN5dqWWz91QY
 8/o5LTkPU4dxXyo271is3A2zsgujsKa/OjCy2m8GQjDKYCcvpHfDJJMZjw5NGedI7slW
 1gzvBpOaofWkn951paJhxJxVUiy/ODvVnCepQuzjxYtClCTnWhl5Fh7a3lcxg38tVpeo
 YOLHDVdXN+seCJrAzhGQcFj4RUNTFFc4i1jdwC7kQNHXkHZas9DlGKmHsfxyQ3RYub5M
 4YIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L8P93sit8uaJ7c4ns09OL8+9XmlHFbSmpNPNpeiqPKQ=;
 fh=G2t+C+Nky53HEvzEbaXcc7n/qV54JvhyookssTA0Qlw=;
 b=LR1U19sZI3MzopKsc2Uz08jXFIktY9d6JR5RgryBUod70lvO/4hM0MsIeawr4+wq6Y
 fHJrn/iZ1Mv9HPdzWXRlqQ38WAxiG6VjjvJlCKRm/kGZriFUpIBB7NCSyRAkU6aLU2hn
 y5D453QXQ2jSsEWFQqI7WWB7tfCOJPNSXYOuyd1QK9dprWr9PySBVDrSQj7MIws0XD+M
 AcQuaAn8zFzhacADqqP2fo2TJhaCV50VCy36ioqn1eWTIV4/OL9XxEaXMAWiH6JWCzgc
 gIdq7J1uewbcQQJPSnZQwt5Z5qBz1WZmSU4CpypJq/5cKvmNPWLHx7Z0S3NyFlP/TRYv
 ZArw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787662576; x=1788267376;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L8P93sit8uaJ7c4ns09OL8+9XmlHFbSmpNPNpeiqPKQ=;
 b=Gy0x/NjVoBHiDlZs3lp/cJRPP6PhkKbGNHwAVHV6REl8+K9gIjWy3JW+rnW48ezPWE
 qZwyvuxHWxHl7W6/Rw6pXO12/LfWND4nW2MjaKfxYfEs0IUjP00ARTc7U5S0l8lmBbE4
 Dcx2+Vb7ndm/NUYn/bKkzbEDTPqWXiJ6C5WVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787662576; x=1788267376;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L8P93sit8uaJ7c4ns09OL8+9XmlHFbSmpNPNpeiqPKQ=;
 b=WoUuZEdg+ek/P/GUx+sCJiLKuz1Luxcnxh39Kt1q0cpO6CB1Bt5yWNFzw+ZZ1j+CIi
 1QFF3u1QeybEpw+h3KrBXUFuVg9On0ER73sXXuIx9t9AyEvYDVxXnNicMdDAL5csNFnM
 Nc49KsaNjf9EKj0F4C/QReSbAYW8kcQvCB5QogmlMF7pmFFnmGuoPS5BMX541mxGQJl6
 8UOm67T4s1gCEzLqHQfmopVDHoEubnVJEjpcnf8qtTNVY7IvfPvWnvZAZxl4ozSSnlUr
 bWXZ8R8dcnmfQ8Tqpz0YwlCKHkX6w33hXh6FJPgcJWz2QkcHcOmh/fD86iazZfcSKajG
 TA3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/cmE/onj6t1Amw6Rnomi16/CHkYBPVYo1hoOzP5b1yp+8m1idc7CJZRm8rlFjyPi1Xcw76k4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kvbqWnuUhzuSDB9q7UV0WNiH7U0S0apa1DyyFCnOPVkCBubnZC
 vY1HCHRf4w/K4mg51Fa6XpO3wOsj9FIRpDxJf8KHHDG614R0/cfZYKxIji5O4ZYwTjL5rD8iOqo
 SwGYcByhXVP+bUsSjpPOlUXrE3T04CRufAFN9D+AT
X-Gm-Gg: AR+sD114YhSmx3hMvVTekPgfCRgNfcuyaq+p7pgkCcx6Gmh3xXP4Map3hHw4aQgIGOU
 7Xmd3APjzouXxlwfFGb8ZluYKhSL+KUbcwmPAH09VKMB/hMfL3e9DvcspWBHxXVxKU5+wg+f5tm
 Xe7joQTgPbYFz98G0ZA3Xwe9hcHnq1H/inOX5mxOKZ+c4JnviZDgXwKjRriJ5ZYSEzgXFfe15dQ
 PnvIjKOa9RqXfTsAvDv3AkHz8AikT4r1sBj+EXUKqQk+4ckE8FTdFM3r0d968k8zoLTZN2b+Usv
 19yuYgI6qpYuw7QeGEkX5gjJyC+PsBgT9xPrlzHog6uI/KHB+n8XwQ==
X-Received: by 2002:a17:906:ba88:b0:c24:670c:b8da with SMTP id
 a640c23a62f3a-c24926a1b7amr3323890366b.11.1787662575780; Tue, 25 Aug 2026
 05:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260819143543.427396-1-mehmet.fide@gmail.com>
 <20260819143543.427396-2-mehmet.fide@gmail.com>
In-Reply-To: <20260819143543.427396-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:56:02 -0600
X-Gm-Features: AcwNN1X9A8HikdtVj4mvupQ8a2Dxm6c7xfaUUhLJEzhiPIuPmhziCO2ExOF4s-4
Message-ID: <CAFLszTh924Zt-a7bJAQaSXHhi+MGrT6-0UTsyt-P7s5DD3bw4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: core: read the device tree into plat data after
 pinctrl
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
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

Hi Mehmet,

On Wed, 19 Aug 2026 at 08:35, Mehmet Fide <mehmet.fide@gmail.com> wrote:
>
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> device_probe() calls device_of_to_plat() before it applies the "default"
> pinctrl state of the device, so a driver that acquires resources there
> sees them undone by the pinctrl state that follows.
>
> It has not always been that way. When the pinctrl uclass arrived in
> commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
> state was selected before ->ofdata_to_platdata() was called, and it
> stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
> ofdata_to_platdata() call earlier") then moved the call up so that the
> platform data would be read before the device is probed, which is
> reasonable in itself, but it also moved it above the pinctrl state,
> which nothing asked for.
>
> GPIOs are where this hurts. On most SoCs the direction of a pin lives in
> the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
> output buffer enable is a bit of the pad register that pinctrl writes as
> well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
> pin is configured as an output and the pinctrl state of the same device
> then turns it back into an input. The USB host VBUS regulator of a
> Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
> has been probed, the value from the device tree, output buffer disabled,
> and no USB device is ever powered.
>
> Move the call back below the pinctrl step. That is also the order Linux
> uses, and the order the board code of these boards used before the
> driver model: set the pin muxing up first, then take the pin. The
> pinctrl step itself cannot move up instead, because it relies on
> DM_FLAG_ACTIVATED having been set to break the recursion described above
> it.
>
> Nothing between the two positions needs plat data: the parent probe, the
> power domain and the pinctrl call all work off the device tree.
>
> Tested with test/py on sandbox, before and after: 11 failed, 414 passed,
> 210 skipped, 1 xfailed, 20 errors, the same failures both times, all of
> them from tools and images missing in my environment.
>
> Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
> NAND: the pad of the VBUS pin reads 0x22ef after "usb start" instead of
> 0x22ed, a USB stick in the host port enumerates, and Linux still boots
> with Ethernet, SD card and USB working.
>
> Fixes: 29f7d05a347a ("dm: core: Move ofdata_to_platdata() call earlier")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
>  drivers/core/device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 6024534ff93..ccdf0ab9220 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -500,10 +500,6 @@ int device_probe(struct udevice *dev)
>         drv = dev->driver;
>         assert(drv);
>
> -       ret = device_of_to_plat(dev);
> -       if (ret)
> -               goto fail;
> -
>         /* Ensure all parents are probed */
>         if (dev->parent) {
>                 ret = device_probe(dev->parent);
> @@ -552,6 +548,10 @@ int device_probe(struct udevice *dev)
>                                   dev->name, ret, errno_str(ret));
>         }
>
> +       ret = device_of_to_plat(dev);
> +       if (ret)
> +               goto fail;
> +
>         if (CONFIG_IS_ENABLED(IOMMU) && dev->parent &&
>             (device_get_uclass_id(dev) != UCLASS_IOMMU)) {
>                 ret = dev_iommu_enable(dev);
> --
> 2.54.0
>

Firstly, we are going to need a sandbox test for this, preferably one
that gets a GPIO in the regulator, as you mention here (i.e. calls
regulator_common_of_to_plat()).

The problem is the grey area of what is supposed to be done in
of_to_plat(). The doc section is at [1] and perhaps it should be more
explicit. We really should not be probing devices in of_to_plat(). The
idea is to read from the device tree and store that information in the
plat data. Then it gets used during probe().

As to substance, I believe the 2019 change is correct - of_plat is a
phase separate to and before probe. There should be no need to probe a
parent in order to read a child's platdata.

So perhaps what is needed here is clearly documentation about what
should and should not be done in of_to_plat() and in particular a
function to read the GPIO info without actually requesting the GPIO,
so generic functions like regulator_common_of_to_plat() can do the
right thing.

Regards,
Simon

[1] https://docs.u-boot-project.org/en/latest/develop/driver-model/design.html#reading-ofdata
