Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAD5CD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9BE8487C;
	Fri, 22 May 2026 01:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2Q6ZoW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75F084878; Fri, 22 May 2026 01:28:11 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D325784878
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bda62f13d90so496108266b.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406089; cv=none;
 d=google.com; s=arc-20240605;
 b=NAVCRNxszrr753JMG1p00q3slbBXGsDNZAbNq7oe/eQXvGuS51l/pfhKmNhXZ1LAns
 zRFFKrgjI2rYHCmQh4Bn2CH9s2Xobbt/hHMfLJQu9axd34kPzD8OcX3J7X0RZDb8s/dt
 Q47FcjozgyXCHGEbBH8zzExWNhc4csvGXCe3M8Xww2nC4Uwxu4F+hvJPR+M+oZnujELf
 3D3VDhq9cLz2lZoQpJdTrYoig5JFvr5G+mVcnvwmGPLaWBBGpbYqVBB72bDzeY86GmFt
 BsqUK9R9Ic+kP70r9FiqLoJku6pzQUGuDAsX2p8Un/tgB2C14AOo76TDRToI/Mo1dtHV
 AY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1iF5h/C1hwPL6pYkqeq+Hs3iYs/s0TqNZ5HdS5uMCqg=;
 fh=UkYpimHuii4GqZdH6RdYCPYjv6GSF2hCxymjSk0mzuY=;
 b=eBlQGWTs7mmPeeyv5gLR7MSgN9bWSP4FjidpgbQb02DVb7Wj9FZKQnShoEHbrtBbWc
 2MJjGlctwBOeVZyEsoTuqMxyOD4EF9+yMJGZPVI17p5HW5gB+3KYpPoMmnRHhN/Fs3pJ
 F6136z9Vie6sqvtHCOrXczX1BbQXEY/MRr74iyKTFsbHU/UzFRLDxESPBwMNfpQR+yIN
 0elvc39Hn+Z96rHcSfrZan/1aNnRlmDkC40Y/qBTVQ61KTjtMdfXIR0JTuH+k2zNFVfk
 Ba78UawJT6kEphjk65vNw9dU6sfazQEBYg3zcIQwYF73oUDRE2DfrSVV5U/+hhAPr0/K
 s/bw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406089; x=1780010889; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1iF5h/C1hwPL6pYkqeq+Hs3iYs/s0TqNZ5HdS5uMCqg=;
 b=l2Q6ZoW/LK8E7AtD0OU6MWhKHhq5rq/x9Q+LtS7pDZckhhjVzpVirmTD5xEZqdlZad
 YNeOpcA9dhLPWkiBZkv/fE3+8yCcJv5K+uEzIWDbrXWaATldLHUClVeiJ9SV0z37yVDL
 61Ju4g87xW5DzmjqWBxLjRlqag04E14ne5zIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406089; x=1780010889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iF5h/C1hwPL6pYkqeq+Hs3iYs/s0TqNZ5HdS5uMCqg=;
 b=r405+ZdTfsvBefo7kjuKqmQX7DKqVadJtnJXNUj4fYdAi/hXIh7tirPPgnNyck9keP
 3KoZdItgBNSyvApwm14L1cM3PkkoDUD2cXzkrgMN7eZkg5vzuLFmXPLdKFUXn1+6JO3a
 Jbu1WRpmF1MttsWbedbxlr1wXjiyGO5r0adw96py5f04ZyJMwCUAHsI9mb33uoLWvFfw
 sxVyeMvnIo89ZsG2dLK9I+/vdsVodqck9T8PP7CJL+qcSBVC/5icT/lOVn1UoI6kho2x
 Ajek6hb4Jn5n5nXaQdGN8g/A8j+EeZudhHTJFtPCZpMx9Bsnf6E0B1wlNDoK6Jeqftxi
 jN0w==
X-Gm-Message-State: AOJu0YxLgYnj+zjf6RuT00CNBPDTkQslwuPZg/Gd5PNCMjBaqVGJAfPt
 kMTMXQnQ3b/SRDv52OKDbH4nMzrLjjzLcugHJJZTyz2FJIL2fRX03PHN7z5HzbIf7p6gjv0OuCH
 zqZZrtpOduq1XjEQaiF23+yu2LQr1PQ3vqang/shO
X-Gm-Gg: Acq92OFZf8OixwmqZZX/bG0Xl1rBYIl5qu1Cbe3vco2hOsDd6YVnP8ZWtOFFfaiS7hz
 C8rTdoinwM0ypjzT73Z2D0fyAicvdSECFLS10XZ4JHiWArSatnvY1a4BPk9Nc7ihF/pZ7cEFw5r
 ccE+1PbHIYHLEGra8V5ZMjqp1LQDGeKTH6q77xZT/oI9ceHbJ3jT1N5uwllkNKmWl+ztc5/xViC
 +fNheWs5a82rPfederxenKsebQ34NHbed6RSGMQq/EEOLpg/6NdsoLym0yAd5WW0jfJtrapmRu2
 wfD/8g==
X-Received: by 2002:a17:907:3e02:b0:bd6:5288:58cf with SMTP id
 a640c23a62f3a-bdd268c0229mr91683366b.42.1779406089222; Thu, 21 May 2026
 16:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-4-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:27:49 -0600
X-Gm-Features: AVHnY4IIJO9izr_42i5i71-xt_lmP_JNMWZBp6JKUWrx4HxD6dUuYgTgsFiY4C8
Message-ID: <CAFLszTjeKt--V5Es3TfxmO_EQrzCPP4NvZYMB2yOZ-Cz0qv4Ew@mail.gmail.com>
Subject: Re: [PATCH 3/5] ata: sata: Drop empty bootdev_ops structure
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> ata: sata: Drop empty bootdev_ops structure
>
> We don't need to provide an empty struct here now that the caller can
> handle this being empty.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
> drivers/ata/sata_bootdev.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
