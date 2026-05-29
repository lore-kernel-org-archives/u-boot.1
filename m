Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F329CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F58846FA;
	Sat, 30 May 2026 00:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rlVZQ9ib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B84846FA; Sat, 30 May 2026 00:46:55 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C9B80087
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69de16f5e80so1807055eaf.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094811; x=1780699611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bhWo/4yfDVKfn7G79ZTHGc0I2UuCGjxUnktFrSnN9Q=;
 b=rlVZQ9ibrbK9DJ96zpmKWmnaXR+xuXwYa9l+6MFzGd5mSxgAGxrdYO5rDTuRxGAc3A
 ARTbkcQ/cDbDaFuILCe7P81EkFGBxvg7U6yruviFT9kmzq2jDlj864DbQWBc8kO4DIaw
 o/zP2Q1vATh5xwZuyAneRh4lnnDmykgl41igY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094811; x=1780699611;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5bhWo/4yfDVKfn7G79ZTHGc0I2UuCGjxUnktFrSnN9Q=;
 b=mXJPXGRtnZ8iD9k5MucQ8yvEe/Pbt2CDxlxjCLGvKbrsLRbGYaiKWnQVesGtkGEdyC
 JNAfZo/Atz6d5z7gaxn2Z7XvEpFvJkPDekQRS1GNDjZWh4D+kM0RXQFFBWP4gcEytXiU
 YfY9d5/jRJHt7YhHSuAQSxkY0wzRdRwRYMyjTRtJW2bvlyt6xhPLyPmJClsGS5PVdQJq
 PciawPz32gSXPMlwrhpbEBn1w90dJZ0X1pcpGcPEXrhfTgMzx/cisZOMXmKj81pUxJEr
 k7S7OXr1LmU0nm4XujIdlgAvFu0LE1PbeuFjItdQ3DkRxkj3FcfmLKrfJV4KEVDlsxgu
 VEvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XzKanIHSD5eR7OpswZpJyOW7FaBGGABV11TGBPBFUwcxbh0uS4Vr2i7yN+LVjJ37RW3rUpSk=@lists.denx.de
X-Gm-Message-State: AOJu0YxMY3yQRzmG8uw+6GfkNjEyOwnS+6Txlpk7Sv6YFimTKMkBGM2P
 KEQNEGAVeOEj5+CymoqLVlL7MQSWBJKBJu0IdFgPPJxq/X9KE7OzwH6p0JAAazhUxwsYS8JdoBD
 2N5vT5NY=
X-Gm-Gg: Acq92OG9aV4yb1GSaYdmh3pOGnlxmTFzru03j64wxCdiNG63eHhjudijDjVwAMRKj3Q
 hDdxKnRmiWkL5ZkNvvNguxQdQW1jH81W11Mnt8iiXYytKEzYDs4D2dg714EK2PCbKl+2ObNUSLX
 IwCNffYHInXHszruM7Fphloqrj8jY7OFf6iliF6YRvuS/TuoIgc6WhC4JYS8MMIITtP7+wKGemo
 vvHmbCgrmeGUKAoc0Q1hgVhew9iJqq9bF2xTjRkidxOizWmeYxntDdi80mMV3ufXzZggp67Dv8h
 LBv/XyhMpxZ4A7m+x38wayrAb4vPsDaGJGer64mzgXsAqgvuVHJqckDsLjFto96sKk1VzVUyO4+
 h2c0AoyA9wXh6gfUoxaA8nruTWED9omaFJOhDHMhDCvCBwJBV5PY+HrE7khFbnEoJEJrqPiBfne
 hro9aB430yc5vC3Q1n3y3cv10AXbTIdGFluWq3rxTtnhVEeP8WfbS/Yjy6mgHLi6+J1c8fA0WMI
 h+0wACyPCX9F+Lv71C38aKiqe7Vz93EEoU3lW2y+9pRDWUtI+5Kt2E=
X-Received: by 2002:a05:6820:208c:b0:69d:84c9:ae70 with SMTP id
 006d021491bc7-69e103c81f5mr628313eaf.40.1780094811090; 
 Fri, 29 May 2026 15:46:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de
In-Reply-To: <20260516183700.7037-1-heinrich.schuchardt@canonical.com>
References: <20260516183700.7037-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fs: fat: fix seconds in timestamp
Message-Id: <178009481019.728062.10650610147971965763.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 16 May 2026 20:37:00 +0200, Heinrich Schuchardt wrote:

> The FAT time format stores seconds/2 in bits 4:0. The expression
> 'tm.tm_sec > 1' is a boolean comparison (yields 0 or 1) where a
> right-shift 'tm.tm_sec >> 1' was intended.  As a result every
> file timestamp written by U-Boot has its seconds field set to
> either 0 or 1, depending on whether tm_sec is greater than 1.
> 
> Also fix the indentation of the tm_hour line.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fs: fat: fix seconds in timestamp
      commit: 7af4196d9e9beaae6a69586cd87bd861b7fc2cda
-- 
Tom


