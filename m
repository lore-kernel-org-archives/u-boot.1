Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B0BC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0305A84B88;
	Wed,  1 Jul 2026 12:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="bAU5xvyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9819B84B9B; Wed,  1 Jul 2026 12:54:11 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE6884A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so795323a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 03:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782903248; cv=none;
 d=google.com; s=arc-20260327;
 b=DMaBsBNmhFut93YLsZXLm9eHQguldqWWYVQlwWkPf4MEOy7hRDTt99t9k6RHbzYyaW
 EAmBAZpng0CkgI59QqINKVezWT31HVXWVkfs+bRtB4S0v194alHb/do5JZk6Gd+5N2Eh
 suK4bKg+MmtLw0YHLgrQIZr1vTr5UUuddYkjnpfAE8534xCpXwTso9xIZbr1EiWr9WCc
 DcKaFy5rqrBH7Nf0PVO+edLwFTxAOpUYQILUslNcqiZrU3B1G+LC/YfqSi9na6zxPbbh
 BNY1DEzyZdKq9lkIsRj6UolUz9g52wYKt4VpiDamrEApughQYflLJSai8V/6pl8/95Xg
 Wxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HKgmOH1hOfFP0WDLvAzalS8zGANAUgY5PgFiC4mTX4M=;
 fh=HuFBfcOMX53v0n2+Ml+57IXm/iN63RatRzldD0FI8uw=;
 b=bL2ZUnJ+dtrJ93JGHxNIFo4SVqVuxXnwuZF3cfj7OPm9wozHoMl04qFlbH5Pdh20rx
 of/aX2FetrEygHixfcXsk8eUIThDXRmz1Qe+SbBgCE71t9VSChVPRlCHiMw9TPtAV/pJ
 gb8JQ1sHxcrMaDtuvuHLyGigkkK20EQhz4gB61UK0qTaoP1ljBLVTSCA5ZOG/GbKInHp
 XzQvK1Kfw/OoevaxLOOURUehMUqPQq7R1FxPoLl4/GdqKgUUhLc6owceIM0C22IZXpqG
 dg3bLY8K8uqU8+wwQS6SCOGxP5hncCM41SoICH/vcLGZYG/oWdQnFT0VR7tXSD0RRNZZ
 47pQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782903248; x=1783508048; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKgmOH1hOfFP0WDLvAzalS8zGANAUgY5PgFiC4mTX4M=;
 b=bAU5xvyNFelVuB4GSSw5k+dzq5x+rfoar+WpmdKwkVzOa0waMW5EpgKxjzoSWiXCgT
 28z8G0dTtZTj0nxNkFEWmKQz4LYghsfjTuajr+LuHzEvL/1rEXlQ/D0R5ZHPKXHtVEfz
 FfLALQpWRgdnLkqBKApQu7Cfpn+KkkaYL+iCfITiqhY3L9LZPh1diZ2lU8RzwKMu0dxz
 fSqdZ8a1Zev9MoPpRiRLu9FW3uWbkWPEUYZqJjetowalpMxUrJK8qyDKlC3tMwsxV/VL
 RPGwVY4dE/OzJlcfero2Hil8yMTnROGf3rTUA855C0qXnijWHYpdWcjFHP6wMZtbUOoq
 DNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782903248; x=1783508048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKgmOH1hOfFP0WDLvAzalS8zGANAUgY5PgFiC4mTX4M=;
 b=gKc050Be0dNVRAP6o9B9koWw6x9pZd3HqvRXT7VxEt6L812ZHbp3pWlUpW7Xpw0sBy
 VD5LQx4aNw0fB71YLl1u46cPDoikqyMlc+Yz0jrFzcouh9x5nf8xl+jCrWHmYn88QMjT
 AxGtbD5qbfi64MXU0FWw7VwPaglbx8DvZuoUFYS6dRScwMc31asCxXaY70Z6VKxCXQ+s
 NPSn4YzFnFDcmK2zr1H2IT8d2DKEEjjTmplxEB/8NQaAoGpHnzYLMHH8QuUppuunx1lI
 mSEjqtioztPDn8hozKRwobPEyZ2JMsFnntKmBPsRN3mJ+EJ6+QQcMP4y0VnMnXHSHpTu
 q6qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNAgDCLgrdgOyQZ6O0tbpqtsvK2klOVys4q4UH+2Qr9D7E452YOkN/0jFNwGiACQW8SpqC8NA=@lists.denx.de
X-Gm-Message-State: AOJu0YxLx7t09v/tMfOIyQEXcn2n/gAt/0XQaOiw6kmfnrPkcI+S0KT+
 1eiZ4q142ZyV6ttZUYTkU3k2F7IDSL9VPSBTNBtJjMgrjhS248U1lKzBcsspOi/7hrxQ4pfamWB
 K6GhBC+BvgBN4aZjte+gpaByS8wYvf72VxJS6SqoGzw==
X-Gm-Gg: AfdE7cnMG9ynNuUJEE1tcOLPID3GY0p8uT+DoAu4k5bw2A8P1Zf7ZDovrSA/rksAZOP
 llticuBhs8dAgUgkIO3TT5PoyKS3754esGIbVCqi5shcIaOmtzK610BV2ZlLk+v78LOfpehlU7R
 FfVQVuH8d6uSXTzmmwXC2dgCfwtq3puVpVZMBNy7ozOry3B+O8VCqQsu6WzeDJ+pvoEozpMowtE
 5VpbE+89TAGi4TIIOWvrqoCwEC78OOPw2fIJuVBPcO7LVzJxzOF/YC1u5TTNvEh81BM3gbJ+Js2
 vKGKGnlMqPt4MY4pHbrvLmACKL0=
X-Received: by 2002:a17:907:c244:b0:c12:34cd:8f57 with SMTP id
 a640c23a62f3a-c12aa31e6fbmr45911466b.65.1782903248406; Wed, 01 Jul 2026
 03:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-63-jens.wiklander@linaro.org>
 <7c32155b-8dc8-4d9b-afff-b6539164956c@nabladev.com>
In-Reply-To: <7c32155b-8dc8-4d9b-afff-b6539164956c@nabladev.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 1 Jul 2026 14:53:59 +0400
X-Gm-Features: AVVi8Cf8CdgVMkjRC7XeHfnaQe4jCfbrZ1_7kNklqcdiS4bbZSI7T7OKZVfwB2E
Message-ID: <CAKTNdwF4Wmfb=K00ZKKybPRZV8H-WtSnbcF9nnMjMPMbM64kGQ@mail.gmail.com>
Subject: Re: [PATCH v4 62/64] usb: gadget: re-import epautoconf.c from kernel
 v6.16
To: Marek Vasut <marex@nabladev.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 1, 2026 at 2:26=E2=80=AFAM Marek Vasut <marex@nabladev.com> wro=
te:
>
> On 6/29/26 10:44 AM, Jens Wiklander wrote:
> > From: Jerome Forissier <jerome.forissier@linaro.org>
> >
> > Replace drivers/usb/gadget/epautoconf.c with the one from the Linux
> > kernel. Fixes will come later.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Tested-by: Alexey Charkov <alchark@flipper.net>
> How was this tested ?

Hi Marek,

This was tested using v1 of this series after applying all patches to
the base commit referenced in that version's b4 metadata, see [1].

Tested on a Rockchip RK3576 based board with two DWC3 controllers as follow=
s:
- Set one controller to gadget mode, the other to host mode via DT
- Confirmed no crashes or warnings in U-Boot at boot
- Initialized the host mode controller via console commands with a USB
3.0 flash drive connected via a hub
- Initialized the gadget mode controller via `ums`, pointing it at the
flash drive connected to the other controller
- Connected the gadget mode port to a Windows computer
- Confirmed no crashes or warnings in U-boot
- Confirmed the device is recognized as USB mass storage by the Windows com=
puter
- Mounted the USB mass storage device on Windows
- Confirmed correct partitions and size
- Confirmed correct data
- Confirmed reading and writing works
- No crashes or warnings in U-boot
- Safely removed the device on Windows
- Stopped `ums` in U-boot, confirmed no crashes or warnings while stopping

This worked better than the then-current U-boot master branch, which
had trouble properly resetting the controller at boot, resulting in
non-functional gadget mode.

Best regards,
Alexey

[1] https://lore.kernel.org/u-boot/CAKTNdwE4ydoUt6i=3DcrNnibZV_MQ+BcwfnRbMX=
sEBtWGc8Myj9w@mail.gmail.com/
