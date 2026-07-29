Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33579C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B4C80B78;
	Wed, 29 Jul 2026 13:44:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSAzXq7XtuF1; Wed, 29 Jul 2026 13:44:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 191DC811B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332649;
	bh=p6X0k+UXgfNdBI061bQZGBGwL+bqEfHjVJbTqIZugiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jIoV3ZH3BPyjV0SO6MZdqhhsivo2SygqukrUg2J69WjZFw5RWgVLkfEuIhNdiv5Lm
	 zTesWrZvpEL+jHnA98dts1KRpbAMyUi/BluEfpXkOIOlZdGtn559oKQqpElGXL8UGf
	 r1mEo69xpGbzoDRBDiHTcAEeNBc4DI4EAAxvin1lfJX9lPY/nLOeZP0ufSOtlrMsQF
	 puGylYiUtuCslkGeJ+jTpgKLk+Y3r+2vePTddfqVbwfUw9VYgASZGZz6t+KSjAq2UG
	 Em9ochYy1f97PPSoncjtTV5p4qW+gq+jN/dKqVsyLViDehFkBGb8uNHyzzGNGwU2XD
	 HdigbuuGnIAbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 191DC811B3;
	Wed, 29 Jul 2026 13:44:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 669D526C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CA2160B0F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEAgP81Z6Blw for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:44:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E05DF60882
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E05DF60882
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E05DF60882
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:44:06 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69ff40d9cbcso1485669a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332645; cv=none;
 d=google.com; s=arc-20260327;
 b=IId3YkNHxcLB47ilCqBMA4oO2jVscYLjaLf6wN5F0ke143XVvddW/V/Vp7WUV5AujI
 /YitaE991EsyrZBrbk4IKqVScwmmFTRZwQ8s55Uh2M0Sv3onp/hxD/572pGe6iQs/b9s
 xB+PaRZlbR8Bcyz9JK8hzOxDUPAU/FXcWSWoAC3gJzTsUSq+rF9FKEmTUxUcH6pvMF17
 opRQFEUzWK3NMVjHF3EYHzLT0rcSYWVT6apwvZpIqm29NTDATjZNqLz3GbefplV2pA1b
 5zRsHk9c3wHGtXO0xSUWFhEqu6o+uEyqzHbozWa/nipBIeeHQQeSvw6jPpuCW2E6FStF
 0/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p6X0k+UXgfNdBI061bQZGBGwL+bqEfHjVJbTqIZugiw=;
 fh=3UkBnkTAzBE2e5T6V0cV8JLQ2s+HD+Kv0CuxS8Ev6mo=;
 b=bmRKKFKSVoKfeWbBkiQ3lPAJe2K3LGcFdvd3RHCejFY5EXRPeo9Euu+cwvFaseJKG5
 RU71KIWFwlJJ+xjwfo+jLbpIpe0jWL3/sGS4P+/1UDy/k+/0d3iWHWeLDIT3qsEZ6Z9a
 uEjLCQDL3cDYgZtVZ1IR5XagC5VEpAGS48iqGgodK2Z5ZCd/fDvDUw1S4vyOwGZ30njB
 d96FhI8xwB4BHir3ZAdtlXY+9pGXm+e0s+mnJ4WnLhBwXPXaeUQWIdR05sLJlk8i5T4z
 ykWCYvaIpE9zFvXdgHmD+Wxa39SAVWrJe7os6VmfypDtp57s29W+L1bknQIv2B+mPyyR
 HF3Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332645; x=1785937445;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p6X0k+UXgfNdBI061bQZGBGwL+bqEfHjVJbTqIZugiw=;
 b=YODEsf2OTiLWLkc5LemCQGgy0EAc1eHAjLsADqkadFRYKbMEqIqaTBDEnkdxOKoGVL
 CR3w4yebkJN4nhshhUbgm4DTawfOyWXvm0czfrRhYouUAPXP0Wr9paKgDYe3SDxH8qr2
 fBeL1tN/CNHJ8fn2vlPFgk9hQWdIlV0l9KBHz/44l9TGpPvOOyeIn4Atic0AvIDq+aLt
 FJdUEAtbdyvwPz4592t2OcNBxCrjBKJC7vTPCvAoJi5qugzzMRImqEVIrLRJTrhOB4F3
 SHv6IqgdDItky9p4gSKvKcZDXGTL7r/VJ0Y9S9cow00ek3JN5kRVXXrgkAccJFpkjl2o
 ELtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsTd5qHWchzfWm03RdZjWBRFjgBdlyjGf/XuTmAKBrkp9f5p6WTvwTPfyInLua3Rrn4D9TIDU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YypEnpvy6Wb2i7xSjFODMs9niLYmnnyrEam1F018gYAiKSOun6H
 3AmfUmg/SQWt3twBE0XftmvzQTMsi7P1qITuSR1xXq2YE+cXal3XTU1tVF0LuwrCQhsKXtuKKWr
 HFc/fiMu3IYNu9xBFETKctcYoNsbVH6/RF2zdejPz
X-Gm-Gg: AR+sD13U9Fr2rWbvTW9kuLgZVMOcPH4xVgVXj+0gx+p75ogkkEMgvvaE0Pt1efSl8Hh
 JndzAQulTNEkWtoQV/gVcZZ86DZVccuz6BCJu4WV2EDn16qxK9kaY16YPzLyVGtma2D3VrkydJe
 BXrItifxezhFGB76mOOE7xGfneiq+74a0fSxGMkgtk8vp0xpZIjpEJCC1TFTX95Y5HmPXOi3f1S
 Wi9yyYoKJeDXFHwMhWKrjI6jkxfVZFSVspkrpb+8B9VZ8SUBqrkJSqkirsTaX2e6hogYa6Hz6FJ
 XerD9V5XCOkeMlHoIv9x9bdGtVl7JhZ7ZBamS9fFVxU=
X-Received: by 2002:a05:6402:2b92:b0:6a0:eb:ae41 with SMTP id
 4fb4d7f45d1cf-6a0349fcd30mr3598655a12.10.1785332644810; Wed, 29 Jul 2026
 06:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <d6565f70-c6dd-44d8-8b87-13b381ef6da5@gmail.com>
In-Reply-To: <d6565f70-c6dd-44d8-8b87-13b381ef6da5@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:43:53 -0600
X-Gm-Features: AUfX_mw9xfo_G31Xpopp4-gAFo5gPpmJr6om5oOt99C6IBG1C3yZNphqVivHHvk
Message-ID: <CAFLszThaodJJSsJ6tV0DVPd2uHR7b-YL9yhm7EB5jjXqRP-7Fg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] rockchip: doc: remove README.rockchip
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332645; x=1785937445;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p6X0k+UXgfNdBI061bQZGBGwL+bqEfHjVJbTqIZugiw=;
 b=fcBquefO7pLkO8W8bqw9ApGgfRVJV/U8LcIRqmJJuujh6wtWlwh+h53gg4MXe19eoG
 EffpfTWL8NVifRgXqOQNyi3mpIk0z/BiJwLhM86jW1KsA29eMJcVdIT5dwT19Bpapr3l
 u1WfiLkNX5yzgG62XMU99ZNhj8mpN29POMHOA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fcBquefO
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

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: remove README.rockchip
>
> Remove README.rockchip for info that's already in
> rockchip.rst or no longer applicable.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/README.rockchip | 677 ----------------------------------------------------
>  1 file changed, 677 deletions(-)

> diff --git a/doc/README.rockchip b/doc/README.rockchip
> deleted file mode 100644
> @@ -1,677 +0,0 @@
> -rkimage
> --------
> -
> -rkimage.c produces an SPL image suitable for sending directly to the boot ROM
> -over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
> -followed by u-boot-spl-dtb.bin.

Patches 9 and 10 moved the rksd and rkspi sections into rksd.c and
rkspi.c, but the rkimage section here has no equivalent home, so this
information is lost. tools/rkimage.c still says:

    * See README.rockchip for details of the rkimage format

so that reference becomes dangling. Please move this section into
rkimage.c to match the other two.

> diff --git a/doc/README.rockchip b/doc/README.rockchip
> deleted file mode 100644
> @@ -1,677 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+

BTW doc/README.rockusb line 41 also refers here:

    see doc/README.rockchip for more detail about how to get U-Boot binary.

That should be repointed at doc/board/rockchip/rockchip.rst (or dropped).

Regards,
Simon
