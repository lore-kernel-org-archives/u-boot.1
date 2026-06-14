Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F62CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2721C83EEF;
	Sun, 14 Jun 2026 14:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bWhV1/U/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5968B84869; Sun, 14 Jun 2026 14:20:14 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC02800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8424b6792efso981456b3a.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781439610; cv=none;
 d=google.com; s=arc-20240605;
 b=R6AvdA57aWMEuzzSDko6JYpK3rHvT/TmrA7GW1horjPpQydO9mCoHvN6XdQB4Kw1TM
 wWohzNXmT2tnzTBaXwytvMqTEU6YE9HkYTmJR2AiSajIyyo5xTkTJ6lej28soQbRAaqa
 U0/2ZN29CbrtyYc9IK9DwmwuwfXEMnk+F9VmWEO043L/pKZ0vhiDHBJoSeSy7hI5fc9W
 gapnm3hytNJjsKN9G4e7PuKbr6ziUwIfdbTGgvmCTfavVlvWtBQrccAHaOzGXKIuwrZZ
 cIUCESsJYid15ARKwVdmPtiC/7CLLGIn8nkdMb6t7Ewe3ImcPBxTHJr1eED3Nhvu+/tl
 yRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BlOJcdNRKHLsqPhXS1ZpE8tHNInoqlZMzwurSV6M6XA=;
 fh=1s68Dlc4BDLSzoI0mHfwsqmbhOFfBZDaoiDm9bUcfL4=;
 b=CFaKuVMJQmMwb3E4EdoaIBajZDvosV4CqADeEqnLxaq7UBuxVHPiem53z5YMbu+SeG
 rHzoyxBZKYYtvBmnJXAU0pI8uGPdxphy6hoeSpGK5Nd/DrSkgAEJ+Kjyda3m3/amiJj0
 W8b1RiseyyBygn656HcBHj4z2cVM02pT04TAAtlHY3ON85cQ7yzE3flKazQEz9kdCAX4
 Iio5ucBmH0NnEGMKHTDWEWCdWNcEKECK40Xm5kJr8wbSF7I2LiUQ59yRAZAmOwLcboiO
 PHUKkAE+BurgFLNZKPiyMIg/lazvDRKkXK2TflM6f0K3hmOsgV3ShLZY91sHCX0nTx1a
 yMUg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781439610; x=1782044410; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BlOJcdNRKHLsqPhXS1ZpE8tHNInoqlZMzwurSV6M6XA=;
 b=bWhV1/U/m8bqIMYcWdmZjGbMMNETQKTV0DeW6QPVu7U4Uz9s+Z+X3CsmUErgIy4DXu
 txZkaF3GP7pl+Qs7vCh9Zr0VlHKnQVGyoBahgLEiBZISq4YtLGxhc+c0FhcIML+uEEOP
 3C7IsR5LUGdCaO7nQtsJcoO5jv69ECy3oL4T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781439610; x=1782044410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlOJcdNRKHLsqPhXS1ZpE8tHNInoqlZMzwurSV6M6XA=;
 b=CcXqNsiKSOzWZwSbRkoQ3K1PNWmYsBNEq2DsR5/M6UUdfMTDq76+arsAauhCUKFG5U
 C5G5QKg8BZ+Ga8PucTLN2Iizm0Q9HowZLJ45/OtVbXTh4Cee4Luj2w8/3CRsij7G9JhP
 fww2ZMMsmoB5gv/HlNE+/ICVOkecBYsircQb0U4S5m3YDM6wyXYhUptfKvgJ5mKWQgqn
 mh0yR6vCAvSPAEUIICxjJ5PeEZYStN0jYhCq9VJoCChtMcytwTdymZowUWelm/hXAoia
 CPHbnKaftH252JhzJDeRhqKjK6cpMz9wcpUgh0oJGTTQKSuYg1uSUtmQIB8YoO4Brxom
 Cifw==
X-Gm-Message-State: AOJu0Yy06J01tIU/foN+vQbc3hzKOdD9dForU5B/28SBVInQGfclfNx3
 INDXyA4DiwDDrB8WoI5xm8SAn77tr9BaljMDHGEReq33ZrZT0wqMljondWGt/viVnc85gC7tlzJ
 pMyyFhbwyLtHWcOF0OktCIVky6Vrcu/J7kP0lxGI2
X-Gm-Gg: Acq92OFVt6CBOUvkSzo+0/RX6mmUMhLJodLpWd8cqhvHMK4JcvdcwtTpB04dXJOxA38
 fwyM82lb6vDlSAE7M2I70CLlTUsXvO8Nz55DBImJ7+xSpmRxPua0EIUXhrIWOomYhYwK5/z+dGI
 yWRzDYmtNHrw4oEaMxNGzSYBcKtBy+Spl8SPnIuQati4D8R0N8W8P4dP49laxQriysbtD+//Tcw
 xAPpcguJ9ySg99idcQcgt/QNQbtBDgLR+ixBif/bQA4cpHCqe540J5MqqNBFZ7fAMZz7RA34Sn2
 YkatmQ==
X-Received: by 2002:a05:6a00:179a:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-844e1a69616mr6818231b3a.30.1781439610579; Sun, 14 Jun 2026
 05:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260610090125.99112-1-nora.schiffer@ew.tq-group.com>
 <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
In-Reply-To: <20260610090125.99112-2-nora.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:19:57 -0600
X-Gm-Features: AVVi8Cf4nk_QTxAawqqw6FbQ7Dx-Dj-2uHQUYuWaAn-JazbfgA7TY4R6yAJ2wdU
Message-ID: <CAFLszTiFPiRD4BT8gzGuw=fbL6zoXyD09-yREmYzfprH-3Z6Bw@mail.gmail.com>
Subject: Re: [PATCH 2/4] bootm: use CONFIG_SYS_BOOTM_LEN for
 IH_TYPE_KERNEL_NOLOAD decompression buffer
To: nora.schiffer@ew.tq-group.com
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Nora,

On 2026-06-10T09:01:22, Nora Schiffer <nora.schiffer@ew.tq-group.com> wrote:
> bootm: use CONFIG_SYS_BOOTM_LEN for IH_TYPE_KERNEL_NOLOAD decompression buffer
>
> CONFIG_SYS_BOOTM_LEN is passed to image_decomp(), so the same should be
> used for the buffer allocation. Deriving a buffer size from the
> compressed size if not possible, as the compression ratio may be
> arbitrarily high for data with many repititions (for example ranges of
> 0x00 or 0xff).
>
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/bootm.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Note typos: 'if not possible' should be 'is not possible'
and 'repititions' should be 'repetitions'.

Regards,
Simon
