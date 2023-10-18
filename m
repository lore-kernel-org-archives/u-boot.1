Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52F3CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB2F86F56;
	Wed, 18 Oct 2023 05:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k44VD8Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DABB86F4D; Wed, 18 Oct 2023 05:33:23 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D2586F08
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a936f4a9so4162507e87.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697600001; x=1698204801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cbwJY29RdC5nI26iqYaKxdEkU6rpxN3ZDZUOj+opYGA=;
 b=k44VD8HzuYHHNr0AUwnCa6l2RfUG9/lAE/cxw+grdlFFAU/DjkKC8auAK3O2fgy16p
 A63/s5HvaQmAvuoZvU+mYTkAOseuAmDQanpu9K+bTaEq0PjPFya1wiJsaPwuwTZ2Rp93
 QJBkrwoCwOUUfpzj7FuRwRxvW3qVuhR03jZn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697600001; x=1698204801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbwJY29RdC5nI26iqYaKxdEkU6rpxN3ZDZUOj+opYGA=;
 b=rAkm68NH9qiIl98YEjGebwLO4AkEjFthXf2F8wUgtsBB61jv6ZIRhjZTuZ/sQzmBqe
 WL9xeFHkssRrzR8pZLWWTzdVxzlHcrtzf+NZmUd36a/6aR8879L8KJ9/MfUCgvvF9iXc
 IM9WWlCTAhT7sl0QW5+vHrCS3LJLL2LupFsTU8Rbtt4IHSRESb+mDRu0nv+ggLSgxPnm
 swG1e4UPryOKgxaiodOW9h+YKwGLHqqeA5S+r1S3c9p8rhuLhv+oqPhGRmSya/xeJ8Pn
 nXwe8TydYiJ+n3L80Uo6qTa4YzgmB4RIlh5XlMGumJ5ZbjsK/Zi/QzxFf8rHv6iin1IG
 3i0g==
X-Gm-Message-State: AOJu0YyJO2YQneaxi04DanzwtMicHCU7mCcfl87fFP2rV5ELi522GQOK
 2r0mHIVnEqWqhYpgu0wL8eGkPPnGFIlvHYQ5R98Jgw==
X-Google-Smtp-Source: AGHT+IEkqyXKpEYoOAB2s0xy1+fB33V+J+tjdOZ7XfIRjWbkcUeoTCReKi/2+6RBIBZhfSj4uzsU9evwiS5jzq+GMTM=
X-Received: by 2002:ac2:5a43:0:b0:500:90d1:90a6 with SMTP id
 r3-20020ac25a43000000b0050090d190a6mr2792358lfn.63.1697600000649; Tue, 17 Oct
 2023 20:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home>
 <ZS6ET7ExtDSCfsNN@eryximachos.home>
In-Reply-To: <ZS6ET7ExtDSCfsNN@eryximachos.home>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:33:06 -0600
Message-ID: <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>, trini@konsulko.com
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

Hi Philip,

On Tue, 17 Oct 2023 at 06:57, Philip Oberfichtner <pro@denx.de> wrote:
>
> Hi Simon,
>
> maybe you can give me a hint on how to implement this cleanly in driver
> model?
>
> To sum it up, I'd like to have a phandle pointing to *any* I2C device,
> not knowing which UCLASS actually fits. Then the device and the parent
> bus should be probed/prepared such that dm_i2c_read() can be used.
>
> Any ideas on this?

I suggest a phandle to the i2c device.

You can use oftree_get_by_phandle() to get the node and then
device_find_global_by_ofnode() to get the device.

This is expensive, although eventually I suspect we will fix that with
OF_LIVE. I think it should be implemented as a new function in i2c.h
so we can change the impl later easily.

If you want to be more efficient you could do something like:

int phandle = ??

struct uclass *uc;
struct udevice *bus;

uclass_id_foreach_dev(UCLASS_I2C, bus, uc) {
   struct udevice *dev;

   device_foreach_child(dev, bus) {
      if (!dev_read_u32(dev, "phandle", &val) && val == phandle)
         return dev;
   }
}

but honestly now I look at it, that is awful. We try to avoid exposing
the internals of phandle because it allows us to (one day) maintain a
list of them.

[..]

Regards,
Simon
