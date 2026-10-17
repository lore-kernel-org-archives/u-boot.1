Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA77CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 19:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D6196064C;
	Sat, 17 Oct 2026 19:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1Et0vP7GQr0; Sat, 17 Oct 2026 19:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 296B560639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792265585;
	b=rahvdJZNDBK8UjDG07wQm3oaIYBg01/gl/38ygosCGdCVFit+IgcWmFLs7yxI+WXRZbd
	 nL1blSGcoaX0VPvMPGmOJQ0AqMHC/dYkRTaug1bLTREFgqR7AE6wo6T1Iadx6YdIr2sPo
	 549KSHyhIaw7Mwd4jjwiZ9qLmpgvLSo6VnqDTgz4MXme+2hxD69Ismznz24V4bxs8fg5p
	 243xOG7pEntLMWEb++ki/EU+IJYmTDDRj3Ql4OwFm/FA5Jnl3Xicva+7uf8dPPNOslhX9
	 1B/922FHxa93aQ6Hi0VY4U7GHjP60QVkFGBJuVfkQMutZ2pRE643tAvhLxgsfBFwATg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792265585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d3VzF4Xf5Tl4K+gvEv6543rQSEqvO//SQYy+kV+AsHs=;
	b=PNpQTIgL+TNAbdZtg5EuKDZ55G1FD5yr50rSDb5BlWlBkFdcPQA4UAadMVXzwMA5F2Nk
	 qa0s2KQTbJHBEdEA8svZNuPcAJUbaMPIfV1k0KMfDihcztOvtXjet6q1mx7ImcKewLMgu
	 ObuD3LX5Z6QmqGeaT3ALicrDFWntiNPtnJCbsGZzJpCedMKjUEeN0F3SilJgqnCqzQ0tC
	 LbNJlQf5h9nGXAvQz5S1bUSY/cqpWdK8eKocPcagyHG2TnxqlZGSZk8d3CtaBigbUeFYd
	 exERx4UnjVA6Bi8Tm6xIlNueMhXH5wgH6LgiLvCUe4/NAzCRfdBQP0L7HrR1xWa6xMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792265585;
	bh=d3VzF4Xf5Tl4K+gvEv6543rQSEqvO//SQYy+kV+AsHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qajJCzVYJM8gdS6XrnhFSEIwJgV17R8Do9zyxwUWG19lUtv6fDxehJtBvVVixlofA
	 uM4vDWr76fwCGCST1cQTId1GL94AaTVy83nzsXLM8TLq89syJIlgwmTy1+W4wVxg9m
	 FCecUaS6/KuNLceDEFW97t1zzarVqPOkWgTvt1sAafXN982Z+JfRrZWyCU221G7UJo
	 cJ1vv/fr7trWQ9E3a3dVNQ6dnl8Gv4ztEGHpKk5en5uUBxJ8nvYMlN757er+o5+qOa
	 RDvpX1bhvKCJPUs7plYqqKpcmOT8kE9zGNxTZBPhZAw7I52Jx+8YpvkSz47YhJ5cTo
	 6PWAjJ1Rk2nZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 296B560639;
	Sat, 17 Oct 2026 19:33:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 502D879D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36781812B8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pY1zzPbkUXHr for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 19:33:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB99A81270
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792265583;
 b=pFzaHuYUF645zo7hN37oMs4Pan5wxtCkCxb5/2UrqvTDSxBexRYlcCm+bqyakguFhow6
 f+zEw/j5p+4Psdc0armpccJ0sUtH7PGrcIEqTdxw8KrwB8Anhel1IyAFO8SmKkqdxxKbY
 Bf7artvNkCmU0aMz+zXigRc0YxTdhmOxacDVsJDrxN2U6sUam0egAuGA23eNpX33UVzHb
 hnhGfB6picK1TO2UveraZqJxc2zSKvN7ff9RXTBubu7kHnH1ufnHGTTO51RJUlAG8qLH0
 a208Bf6VBhC1yWz4HAa6v2Q5pEuel244wEdmz64WlVviI8ZP+2xqR3ELTGxTBu4f2GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792265583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=d3VzF4Xf5Tl4K+gvEv6543rQSEqvO//SQYy+kV+AsHs=;
 b=VAl75vIy+GbYsi6xOkHWMmPe3kyjqZeZYj1KE6tqUM4mP0vl8HccJ5rBbC0zoe80xIKv
 CvjuBfybjyQ3JfEkhoF9P/RuXLNcDLeCgEMFtMcs3DosMuyunarDykvXOSGvBrNY2nR5/
 gwluOkMqcW155WvZ7j5g/Kz7TyEGysQI+QRWxb6eU+7hH/ycHtOgJzy4TDRnugOQfR/kZ
 QRfn2pvQF5aW+MfIgBjgF7Hb756Uy2PGzK5kdpRnOxU66kZPw9XnfwJ1AqObljJoyYN1U
 Ayf5JimYzInCVAJQ1HnJ4A5mt2T3DlKob5yAzUDkqGb6ZiJl45BKP2g/Ev4emCFpBZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dYNVRtob; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1229; helo=mail-dl1-x1229.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dYNVRtob
Received: from mail-dl1-x1229.google.com (mail-dl1-x1229.google.com
 [IPv6:2607:f8b0:4864:20::1229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB99A81270
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 19:33:02 +0000 (UTC)
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-15354aa70e8so76642c88.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792265581; x=1792870381;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d3VzF4Xf5Tl4K+gvEv6543rQSEqvO//SQYy+kV+AsHs=;
 b=dYNVRtobEsR+R6Y77vs1Y0C1j1UwY4mTlTqam2rixDwmrgcw+G1Zj97THn5Z11z+KX
 lwpbrxS0s6Qrs8Zf536rd0PMFASioC19WVAZnQLl/WTIoGzqnkDe88BUN/YAaRkrR+IV
 ttICZMUJkCaZrML5zujzYmQJ/icsORz+N6OJWMCcZjC+w/CWPs8NCWKTQIFIjEjzCf+l
 /r0m9WVi5lj5B1mfcuFvditHkOpPyh1YFvCVb4go0Cft/LnhfS72Ms+5Teyc/cXYM7VX
 6eLQrX0j1LvEqMn2LvJ1tYfei6ncl4Yz/Ho6rLHWPujwPG0rG9uKq9mZ9+lryv3GQ6l3
 nAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792265581; x=1792870381;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d3VzF4Xf5Tl4K+gvEv6543rQSEqvO//SQYy+kV+AsHs=;
 b=ZXBudsbKObqaurykOyC7UOLpZb8cGdj9JbOEmqorgREN+QuzOBvQJe5RdsSMXhojRG
 z50xajKSWzcHU021dHMcC43I5BRcBuKyubZxuYPJY40Z6vcTal6bePwTZVd7yMhhuJav
 UYkA9NAxB3WdCYjMULw4ORatPdRqBxhXq+9F8LCfnl/PEnk/KagLxJB+s7ydadrZ3VRL
 FJrpE7XQxYmgpYQje2Pg+U2SV0qZMbU2Q7g0nNnRubJPeBEvByUKjDKhWuDtxLBIaEL8
 LkjVn8m2M0lVfHfZ35Y96Kz5DJsyC3A21juduOMraRsEfYZ7AIEOlPgbxFaTCDo6xKWf
 aFkA==
X-Gm-Message-State: AFq9FYIK2+6IPls0lYlgP0H+/GbnyhWAlJaHx7t3o5p00IgzLSxzXDHM
 bCFndAV/RaOfdY9MaS5/XyPv4LDyGx48EPzVoxL9dA1M5mviFNX/gqhN
X-Gm-Gg: AYBFou2MizeCz+Z7bWTpB+AHq3gey8HhhFeTEK9ToKjiO500QJXZauSROS92DKSF/4M
 BGmUX4M69lzQ+uoSyEtuTnK6Pjuetedjpy8ua7VbWGjN5tmqOqY5MJgkYeitpL8N7xCEwGMH3IY
 r8h961ozjSkVY/TuEusb9mVQFgA2U07PticD1TmzAl6pvDTxXdrEcKZmtWzbVKPaFhMlGZaiU8j
 Ipj1H+AF07m2XEgIpe9wCxr2RGZXJwPLEwlXldxjoYEjtVkZX02qDrq4AEz59eyBNBsN9XkIYNa
 zKaKTKfUegakNDn1ZAb4eodit4eTJuG5RZayjjliJH76JcONhcisQvxukuAhIeTLBeRe2tGVL08
 CJxlJT8sUf63KAMuGMIT1bnyt6hN96wuPJ62350ieZhTT/goGiVFE6lwhvzNzo2RocrwDSOHyKq
 1f+hbOFcOX1u+NbqWUvlPQVRFM/jPpAUuV+9pBVYttfWzKG1jZqm+HSQqhbcfkv06iuisWSWult
 1fl7W/7h2HGT9AqDfqqx3qvFH2PIpVkRQ==
X-Received: by 2002:a05:701b:424d:10b0:13b:4ab5:41d7 with SMTP id
 a92af1059eb24-1850c9cf427mr5660740c88.3.1792265581298; 
 Sat, 17 Oct 2026 12:33:01 -0700 (PDT)
Received: from google.com (61-230-12-185.dynamic-ip.hinet.net. [61.230.12.185])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm16161870c88.15.2026.10.17.12.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:33:00 -0700 (PDT)
Date: Sun, 18 Oct 2026 03:32:57 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Message-ID: <atPNaYnkwQ_aSEWK@google.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
 <atPI5SKH7ZaiytQ3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atPI5SKH7ZaiytQ3@google.com>
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

On Sun, Oct 18, 2026 at 03:13:46AM +0800, Kuan-Wei Chiu wrote:
> On Sun, Oct 18, 2026 at 02:46:18AM +0800, Hung-Chun Tseng wrote:
> > Add a driver for the virtio RTC device (virtio device ID 17), which
> > QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
> > 
> > The device exposes its clocks through a request virtqueue. As the
> > virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> > which happens after probe(), the first read looks for the clock: it
> > asks for the number of clocks with VIRTIO_RTC_REQ_CFG and queries the
> > type of each with VIRTIO_RTC_REQ_CLOCK_CAP. Reading the time sends a
> > VIRTIO_RTC_REQ_READ for the chosen clock and converts the nanoseconds
> > since the epoch with rtc_to_tm(). Each request gives up with
> > -ETIMEDOUT if the device does not answer within a second, as virtio_9p
> > does. The clocks are read-only, so there is no set operation, and the
> > optional alarm feature is not negotiated.
> 
> This is a bit subjective, but my feeling is that this has become
> somewhat too verbose. Ideally, a commit message should explain the
> "why" rather than just stating what was done. What was done can
> basically be seen directly from the code changes themselves.
> 
> Regards,
> Kuan-Wei
> 
> > 
> > Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock.
> > Linux registers an RTC class device only for such a clock and skips
> > VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
> > step on leap seconds. QEMU, however, exposes a single clock of type
> > VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot
> > without an RTC there. If no clock smears leap seconds, the driver
> > therefore falls back to the first UTC or maybe-smeared UTC clock. A
> > leap second step matters little to U-Boot, which only reads the time.
> > 
> > Like Linux, the driver stops looking for a clock as soon as a request
> > fails. After a timeout the request is still on the virtqueue, so its
> > late response could be taken for that of a later request.
> > 
> > VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> > VIRTIO_RNG does for DM_RNG.
> > 
> > If none of the clocks is UTC, the driver remembers it and fails later
> > reads with -ENODEV at once, as the set of clocks never changes.
> > 
> > Tested with QEMU v11.1.2 on qemu-riscv64 over both PCI and MMIO.
> > Sandbox tests, which emulate the device, follow later in this series.
> > 
> > Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> > ---
> > Changes in v3:
> > - Give up on a request after one second instead of polling forever
> >   (Kuan-Wei)
> > - Remember that no clock is UTC, so that later reads fail at once
> >   (Simon)
> > - Expand the VIRTIO_RTC help text (Simon)
> > - Drop __packed from the message structs, which are naturally aligned
> >   (Kuan-Wei)
> > - Prefer a VIRTIO_RTC_CLOCK_UTC_SMEARED clock as Linux does, fall back
> >   to the first other UTC clock, and explain why in the commit message
> >   (Kuan-Wei)
> > - Stop looking for a clock as soon as a request fails, as Linux does
> >   (Kuan-Wei)
> > - Mention in the commit message that sandbox tests follow (Simon)
> > 
> > Changes in v2:
> > - Look for the UTC clock on the first virtio_rtc_get() instead of in
> >   probe(), as the virtqueue must not be used before DRIVER_OK (Bin)
> > 
> >  drivers/virtio/Kconfig         |  11 ++
> >  drivers/virtio/Makefile        |   1 +
> >  drivers/virtio/virtio-uclass.c |   1 +
> >  drivers/virtio/virtio_rtc.c    | 249 +++++++++++++++++++++++++++++++++
> >  include/virtio.h               |   4 +-
> >  5 files changed, 265 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/virtio/virtio_rtc.c
> > 
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index 55b444280..48ab669f3 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -84,4 +84,15 @@ config VIRTIO_9P
> >  	help
> >  	  This enables the 9P transport driver over virtio.
> >  	  It can be used with QEMU based targets.
> > +
> > +config VIRTIO_RTC
> > +	bool "virtio RTC driver"
> > +	depends on DM_RTC
> > +	depends on VIRTIO
> > +	default y
> > +	help
> > +	  This enables the virtio RTC driver, which reads the UTC clock
> > +	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
> > +	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
> > +	  read-only, so the time cannot be set.
> >  endmenu
> > diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> > index 6e7bcfc8e..ddb5ce4eb 100644
> > --- a/drivers/virtio/Makefile
> > +++ b/drivers/virtio/Makefile
> > @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> >  obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
> >  obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
> >  obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
> > +obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
> > diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> > index c163b2fd7..c6cf55922 100644
> > --- a/drivers/virtio/virtio-uclass.c
> > +++ b/drivers/virtio/virtio-uclass.c
> > @@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
> >  	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
> >  	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
> >  	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
> > +	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
> >  };
> >  
> >  int virtio_get_config(struct udevice *vdev, unsigned int offset,
> > diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
> > new file mode 100644
> > index 000000000..806abe237
> > --- /dev/null
> > +++ b/drivers/virtio/virtio_rtc.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> > + *
> > + * Driver for the virtio RTC device (virtio device ID 17). The device
> > + * exposes one or more read-only clocks through a request virtqueue; this
> > + * driver reads a UTC clock, preferring one which smears leap seconds, and
> > + * reports it through the RTC uclass.
> > + */
> > +
> > +#include <div64.h>
> > +#include <dm.h>
> > +#include <log.h>
> > +#include <rtc.h>
> > +#include <time.h>
> > +#include <virtio_types.h>
> > +#include <virtio.h>
> > +#include <virtio_ring.h>
> > +#include <linux/types.h>
> > +
> > +#define VIRTIO_RTC_TIMEOUT_MS		1000
> > +
> > +#define VIRTIO_RTC_REQ_READ		0x0001
> > +#define VIRTIO_RTC_REQ_CFG		0x1000
> > +#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
> > +
> > +#define VIRTIO_RTC_S_OK			0
> > +
> > +#define VIRTIO_RTC_CLOCK_UTC			0
> > +#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
> > +#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
> > +
> > +struct virtio_rtc_req_head {
> > +	__le16 msg_type;
> > +	u8 reserved[6];
> > +};
> > +
> > +struct virtio_rtc_resp_head {
> > +	u8 status;
> > +	u8 reserved[7];
> > +};
> > +
> > +/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
> > +struct virtio_rtc_req_clock {
> > +	struct virtio_rtc_req_head head;
> > +	__le16 clock_id;
> > +	u8 reserved[6];
> > +};
> > +
> > +struct virtio_rtc_resp_read {
> > +	struct virtio_rtc_resp_head head;
> > +	__le64 clock_reading;
> > +};
> > +
> > +struct virtio_rtc_resp_cfg {
> > +	struct virtio_rtc_resp_head head;
> > +	__le16 num_clocks;
> > +	u8 reserved[6];
> > +};
> > +
> > +struct virtio_rtc_resp_clock_cap {
> > +	struct virtio_rtc_resp_head head;
> > +	u8 type;
> > +	u8 leap_second_smearing;
> > +	u8 flags;
> > +	u8 reserved[5];
> > +};
> > +
> > +struct virtio_rtc_priv {
> > +	struct virtqueue *vq;
> > +	u16 clock_id;
> > +	bool clock_found;
> > +	bool no_utc_clock;
> > +};
> > +
> > +static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
> > +			   void *resp, size_t resp_len)
> > +{
> > +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> > +	struct virtio_rtc_resp_head *head = resp;
> > +	struct virtio_sg req_sg = { req, req_len };
> > +	struct virtio_sg resp_sg = { resp, resp_len };
> > +	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
> > +	unsigned int len;
> > +	ulong start;
> > +	int ret;
> > +
> > +	ret = virtqueue_add(priv->vq, sgs, 1, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	virtqueue_kick(priv->vq);
> > +
> > +	start = get_timer(0);
> > +	while (!virtqueue_get_buf(priv->vq, &len)) {
> > +		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
> > +			return -ETIMEDOUT;
> > +	}
> > +
> > +	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
> > +		return -EIO;
> > +
> > +	if (len < resp_len)
> > +		return -EPROTO;
> > +
> > +	return 0;
> > +}
> > +
> > +static bool virtio_rtc_is_utc(u8 type)
> > +{
> > +	return type == VIRTIO_RTC_CLOCK_UTC ||
> > +	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
> > +	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
> > +}
> > +
> > +static int virtio_rtc_find_utc_clock(struct udevice *dev)
> > +{
> > +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> > +	struct virtio_rtc_req_head cfg_req = {
> > +		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
> > +	};
> > +	struct virtio_rtc_resp_cfg cfg = {};
> > +	u16 num_clocks, id, utc_id = 0;
> > +	bool utc_found = false;
> > +	int ret;
> > +
> > +	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	num_clocks = le16_to_cpu(cfg.num_clocks);
> > +	for (id = 0; id < num_clocks; id++) {
> > +		struct virtio_rtc_req_clock req = {
> > +			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
> > +			.clock_id = cpu_to_le16(id),
> > +		};
> > +		struct virtio_rtc_resp_clock_cap cap = {};
> > +
> > +		/*
> > +		 * Give up on any error: after a timeout the request is still
> > +		 * on the virtqueue, so a later response could be mismatched.
> > +		 */

I guess your LLM added this comment while fixing my review comment?
I don't really see why we need a comment here. Even if we ignore the
virtqueue timeout mismatch issue, we already abort immediately on any
other error anyway. It looks like a standard and normal error handling
to me, so why is it special to need a comment here?

Regards,
Kuan-Wei

> > +		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * Like Linux, prefer a clock which smears leap seconds. Unlike
> > +		 * Linux, fall back to the first other UTC clock, since that is
> > +		 * the only kind of clock that QEMU provides.
> > +		 */
> > +		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
> > +			utc_id = id;
> > +			utc_found = true;
> > +			break;
> > +		}
> > +
> > +		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
> > +			utc_id = id;
> > +			utc_found = true;
> > +		}
> > +	}
> > +
> > +	/* The set of clocks is fixed, so remember that none of them is UTC */
> > +	if (!utc_found) {
> > +		priv->no_utc_clock = true;
> > +		return -ENODEV;
> > +	}
> > +
> > +	priv->clock_id = utc_id;
> > +	priv->clock_found = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
> > +{
> > +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> > +	struct virtio_rtc_req_clock req = {
> > +		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
> > +	};
> > +	struct virtio_rtc_resp_read resp = {};
> > +	u64 now;
> > +	int ret;
> > +
> > +	/*
> > +	 * The virtqueue must not be used before DRIVER_OK, which the virtio
> > +	 * uclass sets only after probe(), so look for the clock on first use.
> > +	 */
> > +	if (priv->no_utc_clock)
> > +		return -ENODEV;
> > +
> > +	if (!priv->clock_found) {
> > +		ret = virtio_rtc_find_utc_clock(dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	req.clock_id = cpu_to_le16(priv->clock_id);
> > +
> > +	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
> > +	if (ret)
> > +		return ret;
> > +
> > +	now = le64_to_cpu(resp.clock_reading);
> > +	do_div(now, 1000000000U);
> > +	rtc_to_tm(now, time);
> > +
> > +	return 0;
> > +}
> > +
> > +static int virtio_rtc_bind(struct udevice *dev)
> > +{
> > +	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
> > +
> > +	/* The alarm feature is not supported */
> > +	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int virtio_rtc_probe(struct udevice *dev)
> > +{
> > +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> > +	int ret;
> > +
> > +	ret = virtio_find_vqs(dev, 1, &priv->vq);
> > +	if (ret < 0) {
> > +		debug("%s: virtio_find_vqs failed\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct rtc_ops virtio_rtc_ops = {
> > +	.get	= virtio_rtc_get,
> > +};
> > +
> > +U_BOOT_DRIVER(virtio_rtc) = {
> > +	.name	= VIRTIO_RTC_DRV_NAME,
> > +	.id	= UCLASS_RTC,
> > +	.bind	= virtio_rtc_bind,
> > +	.probe	= virtio_rtc_probe,
> > +	.remove	= virtio_reset,
> > +	.ops	= &virtio_rtc_ops,
> > +	.priv_auto	= sizeof(struct virtio_rtc_priv),
> > +	.flags	= DM_FLAG_ACTIVE_DMA,
> > +};
> > diff --git a/include/virtio.h b/include/virtio.h
> > index b981eead5..95069a2de 100644
> > --- a/include/virtio.h
> > +++ b/include/virtio.h
> > @@ -32,12 +32,14 @@
> >  #define VIRTIO_ID_BLOCK		2 /* virtio block */
> >  #define VIRTIO_ID_RNG		4 /* virtio rng */
> >  #define VIRTIO_ID_9P		9 /* virtio 9p */
> > -#define VIRTIO_ID_MAX_NUM	10
> > +#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
> > +#define VIRTIO_ID_MAX_NUM	18
> >  
> >  #define VIRTIO_NET_DRV_NAME	"virtio-net"
> >  #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
> >  #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
> >  #define VIRTIO_9P_DRV_NAME	"virtio-9p"
> > +#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
> >  
> >  /* Feature bits for virtio 9P */
> >  #define VIRTIO_9P_MOUNT_TAG	0
> > -- 
> > 2.43.0
> > 
