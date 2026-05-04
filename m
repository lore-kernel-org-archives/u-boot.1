Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427ADFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8C38394E;
	Mon,  4 May 2026 14:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kbFiugGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE80845E3; Mon,  4 May 2026 14:07:55 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F50680F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bc356898256so53919866b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896473; cv=none;
 d=google.com; s=arc-20240605;
 b=OE4cS69RPPT2bFiTzuuIjZ9bW99WcgOfU2kiI4kBWAj2fE9lzmgghyat3k1iIBjeO3
 f8IiDYzhJkWShA/dB26bU03EAueOLjLWOHzxE+ifiZZgL8WIawmJJPh3QFPjedGC0Fho
 oQioljgZThsV/nq2x0KoknOMv4HoE3xQqMGBIAlmrUM3LhoTX0aWv++0eU4Tu/160cBk
 hwj3NcnPwyl1hfAAeqV5VcID+439bw8eYBq0g9WnUiGEqigXwAFsDJCMSy6fYfrqN8+c
 rkkuMqbeJb6/f0U456x/Dj82uwl5kRKl5wbX97n9+EuSZiQcT0RmI6sUGl15kMTIiXKu
 Cjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CL6H2+P4wCHqZGB3nx/HW2pd0wiksuGFME2GYntHs+0=;
 fh=adUGbpDfIlKqNaAG0UO7b8dZMhhUWRdrAUYoSKoPOKE=;
 b=DY3hgA3j+DRmGbQyaaVisw3Qe2w85MJ6+zk3SSvWc77Sv0F+PKOHxn0Wr5Uk/TU5P6
 QWbwJVPSi1XG+klzhVYuIIG5xIX2FrRYeut2dh54xIYpKVz0oypK74XCpT2cg6UK3Yg4
 D/zx6bomb+Ekw5k4o69z8/xOjtrSlB4fBaLhNz3I2W2Q0HnGr3cmd6KRPtlkRYyLI71H
 p1+Cw4oRBTDP5rGM52hV5C2rbmOjkgF7Bn2uTPqFfg1nXL4ZstI4nYBqTuxLXyQgb0HT
 svRsfwZTIl5vnaT00/V/MPmEQwBdD30tg9GxrA1ytJCVtGXUfYHb6Z64ATEePSL1+iUd
 ziZg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896473; x=1778501273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CL6H2+P4wCHqZGB3nx/HW2pd0wiksuGFME2GYntHs+0=;
 b=kbFiugGTNwId1m5mHOIQjBv0KtoHulGXyAo6heDt8FFFgr3c3l+yOinSI+aaKQEr5l
 lKfcxJxFDbKijAVlFSWXxt5Q+sl0R9pOtLeMHk7jhrQqOCFcVHW7NgrEtwvt3hBpADbR
 tpy/HcC6PBHqabaMWD+KpVmrbRa3gngyO2pPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896473; x=1778501273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CL6H2+P4wCHqZGB3nx/HW2pd0wiksuGFME2GYntHs+0=;
 b=dferm6o1QKnIrbaEEbxlESK4U5ap7dIqfIb2SJerkjfOihXWTODgjelazs5EyL0/E7
 jrGK7xfbjDm0Zj4MWjkXTKlk1lyWnx/+3CyMEPz7tvO9ozdjoV7L2VAGgMCnJk5Zsmjb
 E1F9o7gSbWQVESy8EKTxz+i0k/5ddyPKQyJ71y8+d95DvrJTl+H2K+fDCIBYgzc9VY4H
 SGh2ap1rhyUsfs6PtV+2VupYislmeGGcCRsOscU8zEA89cqj9otUojiP2KlcM6vCijfc
 TtklbstjGmdHtN0xqHxVim/9DKW4Zh5EdkiZ28oewIdGqaqFGNE7MsKRmOCkTjuIn3wo
 xfEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hrGejQnhuRB/Devp1R9OE7fgYdhAVIoFN6XE59k7hDSDnIqJDYSTGtnKXLGzame8UY+f6H9s=@lists.denx.de
X-Gm-Message-State: AOJu0YwgsZpSucv7IaSCc2HIb8dfmec6dWYe7IyOp4s0XQ7XTpnCE8co
 iBjhJ6ooWsaeJuOsbeoA8rwzdtYgP/59X+YRZu4PQzI8Q+Z1EqVLxJRisvYgOc44lM9w0TQW32w
 lhFUh3ah5h+ZrzXbj9pJViksaPl4D7yy5tJrIZy/nxNQGeguXWJ4=
X-Gm-Gg: AeBDietoy5sm/NLDowQBdgrT/tO2TFQKKIiqciHEedTDEJgy41+5nvZUX1WXQ+npfpO
 zx3qzchUCvb1bBhzQ03bvFpo9KfJJU3Yxx97WkJL72T3sarnZPuE8zr/Vvm9Pb0xxNBR5GWKuAM
 od6tcKBpdVM/xzOJpgSqddPzGVQh8Uxz1X5aPH73ZtxK/9zQtC9i1O5wp6nQnr28Wo5QRflsrsB
 M6xu9lbZiFd0H3K3w23A6SBDMhvK37VwLmTuaOGES23QRS0luv5GBsNQdzFgXBrwi/L3SNLFlvz
 SlHRf2LQFrDYMTve
X-Received: by 2002:a17:907:ea5:b0:ba7:3578:f627 with SMTP id
 a640c23a62f3a-bbffbf77a93mr488612566b.37.1777896472836; Mon, 04 May 2026
 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260225211332.1896252-1-han.xu@nxp.com>
 <177424051904.2364563.14330681912708686610.b4-ty@nxp.com>
In-Reply-To: <177424051904.2364563.14330681912708686610.b4-ty@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:07:40 -0600
X-Gm-Features: AVHnY4ILwvW6happZVcSYjaFSHlL0AI-kGgVQc7UQTnsVoniRJEMAlP7RYcK0-0
Message-ID: <CAFLszTj-M9GFBEm+VkWh9SbncZsvnGi65fF_=dnDAH0puPXAyA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Add support for eMMC 5.1B specification
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Han Xu <han.xu@nxp.com>, Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
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

Hi,

On Sun, 22 Mar 2026 at 21:20, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
>
> On Wed, 25 Feb 2026 15:13:32 -0600, Han Xu wrote:
> > Add support for eMMC specification version 5.1B by defining
> > MMC_VERSION_5_1B and including it in the version array.
> >
> > eMMC 5.1B (JESD84-B51B) is a minor revision of the 5.1 specification
> > that primarily addresses MDT (Manufacturing Date) adjustment for dates
> > beyond 2025. This aligns with the Linux kernel commit 9996707822f82
> > ("mmc: core: Adjust MDT beyond 2025").
> >
> > [...]
>
> Applied to mmc-next-2026-03-23, thanks!
>
> [1/1] mmc: Add support for eMMC 5.1B specification
>       commit: 67fc505228558efa19380542d801807fa9eee054
>

Oddly this commit (which looks fine to me) breaks beagleplay in my
lab. There is no console output from SPL at all.

If I disable LTO it seems to work OK. So perhaps this is a 14.2
toolchain bug. I'm just posting here in case anyone else hits the same
thing.

Regards,
Simon
