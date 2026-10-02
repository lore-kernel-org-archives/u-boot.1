Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C9CA5FD9
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFACD80E22;
	Fri,  2 Oct 2026 08:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcvRpOaodqLJ; Fri,  2 Oct 2026 08:52:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 43C2C8101F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790931170;
	b=HmMNZF/Jax6952/lexaH2rD6cjawLGttExGG8yJrTVOlWnkO1gYvuQwoH/eufGf1qtzU
	 Ub8urNp5Z2+DQTxgR7PnafUbFybyFKWFcC7UYCVgQ6wwFd6EXXSXxviZhBCSSxNhYQnia
	 TiWNO6Fvv2gANhRFFkYSyNW2wvsXgDsLqT7RgBaHCor9UmsJU1fsxycKMhGuO9w8ooZlp
	 oWypwLcmwE0M3tv6zquAQoGa/15nnE0333fR0N6p5KZEOFmKXMppdxDCEK15WlByQiyZ/
	 nRYuDLiXICkK71eC6/l3P9j1nDOc5fbCRrv9R7elNoAkJ36UYTLcGLLKHyraQgTQp2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790931170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
	b=CLmKNPnEIKGbrv6INriAW2DyOZQT2gRGn+sv4jq5niH5kSiGV4f/4fb8WmRmfzgs5Tro
	 DQQS3xTcSLyr2J4uV6hnFjg8VBFg1HlgFfa7Qimw9p7gOvfmOPaVOAgLmAr2oUVcS85oB
	 BgNdg3UWk3P9BmiH7TW9/e7M7rrAmKMMxTloFyYwVsgcCEuOfRHRXxVIUxtBJTwOHGDEd
	 q9iMFJccZVlXCgVYvV9UShbNX45SQqAMQYc+mf74zefxjKX4mfeIbWuguBSO+adlgWheG
	 H099x0SlGOFJhl8oIFShu+7mu2F+azZk6Da3+Wb6TA/iVeHpmY6B1kASFpJ13HCO4Aw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790931170;
	bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rnDeqOZKgCjCjdNnDwAWBj22Gk07E6Y8AW+1D6UZHcdhXEqHAYWWlbjGqreOa+Zj2
	 s4rFraiPW/KQZuu9vKVF53b0320TcV1nsY4ai0qZHYi5OptuFcq9ZHwWcSmwgl8ZAN
	 HAc3Q+30rRekfEU2QmHfJjZbxt2g57askKRbbRyAqFMLl0IIdGhHdzijd22YqVKe5p
	 eZ0UHxMk93n+JeIIBiH9wIo9jieESUr4CE+61o5n2WoUUdbRI0XTjHZgYYoMuPrNOp
	 tWaUsmubCzm6czJwfONme0csFpK59YHo1bADo2Hx3Jy/bqru/zCoZeStoe48rmTKUn
	 5hYVMvsyYwRRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43C2C8101F;
	Fri,  2 Oct 2026 08:52:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7CE322B
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C97B040382
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9a9LrY41PBz for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B7A56400B3
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790931168;
 b=N39KIAS5QcAIZ8HUelavq3EnV6xNjT4TEAXJxjav4g1OB/6oU7/+xVBnNnLumman6/8Q
 wA3XiELAAwtFg5rgIUu9egDrXK1woXqnaMffgZaMiJ5JpIM1eKDHAjmntZnkDEL9wrJnV
 JBtoQSTK/gndi30+PhoDeKUxMuUPc3sjbznNtubIIV/OE9AtyKJM6mn3rRl53T6O1UY4r
 0H2Be3W8om++3Pd0KGllJKrH1thLR8fzdIXcYNGuVgLb2LnPtwGGT4IJ2PugoMAnuF0Vn
 r6h7AXjiJiNUhlQk9hl1Dniig8z3y0NyW2ycfvRYoHb6Yn+kd8R3O157kfEntI6OZCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790931168;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
 b=L59+ZRTVom2WlziUkHZJqmgbsvOYfRuDYX3iLavd8cN6rqIYoSo69RtMnE47TPnSrj5J
 TBZegTtkTYW0YgtjgeZCI6w7oeE7xxqsvQZ81y1mn7lTYFMbiOlE0f8Fdat7sdAf7mwhA
 P2vJYulgoOeJE2DPulD0fp4U7iXyuA5jnSIrPROVKwupnzHwLxrszUGaEmQRW8AjO/iRo
 fPkXf88WRfL4WYdVE+ynPXL3h10ia9NpJlzuT9nS0bTsQj5Z/AcW2GdlSf4RljwvzbwqG
 +MQ8vu3+eNrb3iU1wHEoNAlH2iJlUvEGmuAaIcYaDq1n8ow0zTf/vaVSQLJixfxKsAQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="GRBD/3bC"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GRBD/3bC
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7A56400B3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:52:47 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e30a06b59so353345366b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 01:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790931165; cv=none;
 d=google.com; s=arc-20260327;
 b=CTytLQlPSdp+A52bMa0YYqRamGSEGGS9VCHKMQ1IpYznsy8vOz4+51RbJEam/TIIno
 AyUQSDQM1TWQ4rfj+D2OcHquDHD8KP2HnTB2cQdezM2Z7AbcUBKadDQu99wt6nYCewtW
 KIdAYh4d26+uf/zbeXYTOttUvuZpzNo5Ta2kLiuOIHOhCMpWWAvjzsZm/DUJCF31TGc9
 hy+Oie0t0M82upO5nxKVgVhwgb26IJT3b80BU4g1hVdhXH1owAq3n2LjVB2ZPG88wba/
 kySGXTJZU81YBQ4+MsdS4qoZ/eH1ttQ+UxmqMBWsx0cS5qiF+3hW0i24PZdF9bdL22EU
 0Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
 fh=nwLi0duRn6c/h3YYADDJDfzCARDpvaTA3G5JOfegPL4=;
 b=oLyGUAjUKce6v/3Hm/Gh4JpAmeoFDbEiWKcgOj8kHR53Mm2BgxSDmWj1eVc0GoB/HU
 hGfqCWNFoPmptm7oACI92eiNQOo1bKTgcTK89p2ACyB9G97Ej/gPbFKFKEnPKVS/Lfw0
 qZR2Yws6zrSSk00IA8/OHHrqR1YHWXJsSTruLXAKE63qgI/rOFNWVyBLagf69a8iKtY6
 BvVdx+d68wlNti9KCZwFSfV1K2BkiiPA/6cvjLJxq4kmL7mYIZrMsWJPBWaPTvqOpi1B
 0+lvfHLAzvS9lVZdtxd6101cgndMNJwFLrlzHuBk0AFTFJWs+Y1FeZ8EeCaUfte0++sw
 ejZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790931165; x=1791535965;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
 b=GRBD/3bCZ5tvFWbMkiGYkC2FpIfyw1EqgIcvM5NfYPrGqxlfP1GScN4GmA5KQzwSBm
 kGLjwGj7Mjl9+1zygHzPWAHn5uJ2XjlyLtEE+0xPgZPZMiFhQkrkVBq4HjC7sSGOCT8O
 +mIdFeXmSyWKCKu+XohajIdvkfOqZhHweh3JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790931165; x=1791535965;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SGI9FGQ8GDbl71fP0a4SaH6fRDLDeYKmPh64Nil3ETU=;
 b=HJT3qSofLzbqEkD/1xRbn94aL41Lys9FLnTVQFASn3T1WebKkcebPuQxAJYdJTlajP
 RXcnphwy+66cxTruM2BNDoYB5lvVrvcKuLNFbZ+NW6gtFno6Fa4oPsQgwTMsBC6AG2wH
 ErXeIaIFDxRXRHvnp8NTcln9qy2kxo3sNaeHEAYbgW9wiYovQNnAXEx7cpU/ACSzrXNv
 Jwm9FPG6XxNrZG+5YAWwOhKgLSXQwG2M8Wqesgo1Nh21GdYZeN6k52q4+J5iQzNanU2I
 gpmcjWg1/gotXsQ9bgv8BASkMtNVgVcqsbmIrLcwFoWdd1rO1hhWFbb8sqdnaMRk12Jw
 7hyA==
X-Gm-Message-State: AFq9FYKLZCmL/3k5bltK79QQZ2+wvlFCWxLCuqApFFEG6epJIzKoPuuF
 0sKNqHhG0jS0JfC4kEbnAqKTCUs4sp4Pz0/gUUJw/U72OcnUoOaaezLu8p0adZevs3z36cs25Yn
 okmq0P/qJtVhgYsA2AQKqt/m9r5r39OD7SrSTHrQk
X-Gm-Gg: AYBFou3sH6FENZSmTM0eRF3jCFc8y3W4Lg5IlK8Wky737v2ZV/ZQ2KSDgpt1HkOpTBm
 db2X/ru9Fe5QMoE2581If/ubnWZo96ncZG1H42LeuuHBLWKvTLeAuabaaVxQrgmVAOZL9MH2LG2
 NMb9TvKWlgm32lRXIS6+HPKTRTHBblpO3DDIpuD6TGPSY5FKrSlDfvSkqikHmqfXhTOMaj1G5Qy
 7iG/I4PjYOv+XRmKNX2r9Rg46LtvMOhPMudRRQUJ2RpbKQ1GOD22085aXWQSNxXoX0VXS8/kL8y
 kF79wtv89oVbBFysHvmsRRZpC78jir9fdIvcM/oGOMZssNXWaHWp+xs5
X-Received: by 2002:a17:907:9810:b0:c26:1648:a061 with SMTP id
 a640c23a62f3a-c2e4af53a2bmr168270666b.28.1790931165300; Fri, 02 Oct 2026
 01:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260920-udp-checksum-odd-v1-1-a99dbfaddbf9@email.szu.edu.cn>
In-Reply-To: <20260920-udp-checksum-odd-v1-1-a99dbfaddbf9@email.szu.edu.cn>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 Oct 2026 09:52:33 +0100
X-Gm-Features: AclHuK-H3Cba36cnohNXaDxQ4UiEAEhelDkXqeP-EAMLR-Mcx2tP9gJbvHFeW_w
Message-ID: <CAFLszTjbnUMDCfzVuV7SKUFxmGrmq1eRitoUPzuuCSGizqkkEw@mail.gmail.com>
Subject: Re: [PATCH] net: fix UDP checksum check for odd-length packets
To: limingtian@email.szu.edu.cn
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
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

On 2026-09-20T08:26:10, Mingtian Li <limingtian@email.szu.edu.cn> wrote:
> net: fix UDP checksum check for odd-length packets
>
> RFC 768 requires that when the UDP payload has an odd length, the last
> byte is padded with a zero low byte for the checksum calculation, i.e. it
> must be added as (byte << 8) only.
>
> Since commit 8524423da9af ("net: avoid address-of-packed-member error")
> the byte is added twice:
>
>     xsum += (sumptr[0] << 8) + sumptr[0];
>
> That commit replaced the correctly masked
>
>     sumdata = *(unsigned char *)sumptr;
>     sumdata = (sumdata << 8) & 0xff00;
>     xsum += sumdata;
>
> with the expression above, so with CONFIG_UDP_CHECKSUM enabled the
> resulting sum for a valid packet is 0xffff + last_byte instead of
> 0xffff, and every received UDP packet with an odd length whose last byte
> is non-zero is wrongly rejected with
>
>     UDP wrong checksum 000000bf 00009288
>
> and dropped. This breaks e.g. TFTP download of any file with an odd
> size whose final byte is not zero, because the last data block of such
> a file has an odd UDP length and is rejected on every retransmission.
>
> Fix the calculation to add the byte as the high half only.
>
> Fixes: 8524423da9af ("net: avoid address-of-packed-member error")
> Signed-off-by: Mingtian Li <limingtian@email.szu.edu.cn>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
>
> net/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
