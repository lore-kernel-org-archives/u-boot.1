Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EDBC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA51A40592;
	Tue, 25 Aug 2026 12:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nx0oRn23NbIR; Tue, 25 Aug 2026 12:25:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787660711;
	bh=80xLsHsjQPYsvkI33brKsojlXpSbMjW5cTPceEWG5EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q/9vSvs6DDeprF6EzuePElexX4BKKJMnagOr3fAFm/qSPi0HRHFNmWgDnclXgylYX
	 OIbo3i4u4QV1vgJ6rUDh1B8Co6ekVAQv0I9LFpOIqcjBNmk9zkEvGfd3R0rhurDqqD
	 Z7chx0yaYCDuIprxYV4fiSygSO+pcjm4xoD1NSdvU5b6w17s7MEXFhmEZ85J3ppqDj
	 8o7m6ywZcUFeR85u05EWhmp4KHD7iugHmvjbYyCcjyHszakDXhwN51TFzN2YYVcIHG
	 F2EWatoO8AvPtZiAXk3Soyn9itsR1xf2T/URn3cokIWvi7GcJXsiLU0FsF8P9RwwKh
	 kX993sdeHSRCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16ED440343;
	Tue, 25 Aug 2026 12:25:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C2D129B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E0A440343
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:25:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8l6eI6kXF8RR for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:25:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WXJOrKkt
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB649402EC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:25:04 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5c2c96286f0so2082722e0c.3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787660703; x=1788265503;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=80xLsHsjQPYsvkI33brKsojlXpSbMjW5cTPceEWG5EY=;
 b=WXJOrKktROm+PRo+VqZe8IDrwC36oLDXmR7Bx0+p5g9RX2YMRPpP7qsDPzDahoOo3m
 +dseBelTGrOY+XxlSjfA2SUQKXsq0wAk7XVbZeDeenZhnsY24hm7xB6eTiMQp9QJf2pP
 Jl8CQgpqe+1rvWEpv4D8xmNwXJqaLKwc5AhR/mVuSfktsQrjGe0mOg/kn1vWlp+mRM5P
 fVUhhfXGSraZa+E0ct1uRC+EmNKoTTU6Xf+0NjbDV3MiFgJUe/t3QsTpLuLSp0X33cRb
 SnAmS2PXFnQxT2QoupCX8i7IjHc6/2SrZGBNjChuo6uPJ/VBEBiG1wDcqAC/G8WfUJ/u
 ouQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660703; x=1788265503;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=80xLsHsjQPYsvkI33brKsojlXpSbMjW5cTPceEWG5EY=;
 b=Aq0XM4iJEe+jjX5b6w8LAvW29k7Jz2eM+lqYwii6SnafL4r36a0vpPsm5eT7RrIlUk
 Qxje+1zTJjnR3feIpDPpfkrM8eA9Qoq1zO+1UWIk+FE17aWvkTjRNHjZWIpI4uKAuxiY
 Fl/bgP7zZtDAzFb+XK5ykJ75o7vwPyb0YZAdf0CHKEWygFhkyup+Qrb5xHiqagGhos3U
 PCXaRVQFGp0ietJeD5kDBxPakDryFKWgSowjT+zG2VrVB/QhQbGPJgUWgDPPD49LNbp7
 AIsvkCWy7jwmKK7IJ6qyWNjUIa0ovXJwLHh7wjnSUi2u2mbyLaV62fvhGl1Fi24MfMYi
 NrdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwOzceL+NVlxlIHBW7erUmfwqA6lKh3achv7IiEEF7m7Hyglua1P1tREY5U71pCKUUWHwW2E4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lLgxBfSo8ATCN5hs+l5iK7o88fBEojXfue6LSBgkrwBe2UJUHU
 TD7xM0KV5kBz054+iDu5+cgBNCaQm/9lcCbIXMA+xDtR0htKeNuBRFz3R13p3s3yXbI=
X-Gm-Gg: AR+sD13zm2amBk352oj3+9zmjmfnTr2ENND7VXgjMtSLm9GSIXycdPsqeY8OOHMER4X
 4bfZuBxmiMBuiMiFaOWYNRjA12faVGd+BGgdFlWgFmPHCEZARGia6uRQ4bPX40qo9MeqAUy/1pu
 vuuiwuOKA60Y+i/40pYqVd7JhCPxZ69c2RY4M8ZDKa70+Z0yjxop74B49tsvJNZ18kTkMYMWeWp
 bDcI+0IwFoWMvrscJLRbfAQJp5f1Hu9dB3Le+JQpESo191IDoHfYTzf2TSQUgGrcvSCCIOVpofa
 tdriS0YVrVs1il2/rQ7WGX37giSyD10qTl7X4Oi+C5s3WdQa2SQoRiZL3R+P0Y4NI7a0MOmQTG9
 9rHCFxRPIW4SnSY1p3DPH3dygYGAPV24+NHTNvYoe+S3jN+p32Ws2jQO9n0sLt2cGLRtshrdx0w
 wDigm7/f0UVAw+JeMwuIBdeLAz4nrA3LH2+yCr36HFAqypevifthr4O7sK6cbUzqmObZ6MzmguY
 VKdTpqqvLNXSnTFsC/XJcxV
X-Received: by 2002:a05:6102:f85:b0:781:4b6c:2d1f with SMTP id
 ada2fe7eead31-7814b6c33f1mr465754137.3.1787660702882; 
 Tue, 25 Aug 2026 05:25:02 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::f35c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-77d82f70b83sm5130546137.2.2026.08.25.05.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:25:02 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:24:59 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Message-ID: <ao2Iqsq-Xp4dQK4c@hiagonb>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822091510.3253162-1-andrey.lalaev@gmail.com>
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

Hi Andrei,

On Sat, Aug 22, 2026 at 11:15:10AM +0200, Andrei Lalaev wrote:
> Hi Hiago,
> 
> Thank you for the patches.
> 
> From your cover letter I understood that SD card is supported.
> However whatever I try, I always get the following error:
> 
>     U-Boot 2026.07-00002-gbd5e3de2ed6a (Aug 22 2026 - 10:27:48 +0200)milkv_duo_256m
> 
>     DRAM:  256 MiB
>     Core:  20 devices, 13 uclasses, devicetree: separate
>     MMC:   mmc@4310000: 0
>     Loading Environment from nowhere... OK
>     In:    serial@4140000
>     Out:   serial@4140000
>     Err:   serial@4140000
>     Net:
>     Warning: ethernet@4070000 (eth0) using random MAC address - 16:21:8c:10:cd:96
>     eth0: ethernet@4070000
>     Hit any key to stop autoboot: 0
>     milkv_duo_256m# mmc info
>     Card did not respond to voltage select! : -110
>     milkv_duo_256m# mmc rescan
>     Card did not respond to voltage select! : -110
> 
> 
> I tried 2 different SD cards and got the same result.
> 
> Am I doing something wrong, or is there something else I need to configure?

You are most likely missing this patch:

https://lore.kernel.org/all/20260507234836.284918-1-hfranco@baylibre.com/

This is needed in order to make the SD card work. This patch is already
merged on main branch, as commit 3a4a8963aace ("mmc: cv1800b_sdhci:
honor 'no-1-8-v' DT property").

Check this patch and let me know if it works now ;)

> 
> 
> Best regards,
> Andrei Lalaev

Regards,
Hiago.
