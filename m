Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8748CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF30960B26;
	Thu,  1 Oct 2026 16:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZWGicrn6QkAI; Thu,  1 Oct 2026 16:02:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DB53C607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870566;
	b=TqSEQn2irSngbodtJoH3dA+7ZH/4c8zQymydSZKkaCQd2qWtbwdq9tXH/lq9ijDFimCv
	 EyaKAHqfvvQtitbqJm8R9T6YwEfFTSo/63rtojiWtpYW/m1gA3yESI87x15smjwJICzhq
	 YI0XSvGvylqcqQBbCZfQG02Ov30I2Ab02jx+Vo9BE8kZf9cW/4ZkFBjiGX05LbQ1ST2ZN
	 Z86UccW3ovhzKIZpOFbqU3j/cQjqaTBIgt/XBNcTJ6JGqL+L23ZDlz6iUOIPfA1I5UpwO
	 nwWBUOsaE6PDfoUNA33GBlUCAThy+rY7gTKlJCh+yCZ6WpU+Qz7L05de1LV+hkrankw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
	b=XL4gA126mx+7/WbVl3qJ2mVQyTh4Os++rnGq9oG3fwcDAjtpf3p1r7LxEdzwtFGFPqWK
	 M558VATE4LZkNHAqBWl5nhbw5/3XjDAJxRqZfWO9ZrebY19OoJmIvrLHrej2CEkz8Mpjd
	 0N8XP69iuwf8LFlgMgjEf0eRondKtrkQ/I6R8H0ooQ9Cq8y4oh/RF4lIw2Q3lrTUL+Wzq
	 fJskHA1Y9RXP7qaiVcxUC1gB3sjIMJwQdt1ylqm4SNL6cCrcPVSxNUIz0Ka4LuCgCrGb7
	 pGDaLH3xwiUf+4yrTAYzzD1YWUxjmuzYkMi2EUb/XlWCxFrhYItciAexDU2EICSiULQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870566;
	bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8l5pbQT/cTRBKopz5/8NgXXdrukT1zXeRiMVfCiBeEEW8FilhyccLi3An7MHoutX
	 G1BELLXmhJDVNVkZqbBRhMGmzoZ3NMWxjq98P42KdzuDOnTDqA1PMtr/wL722TsXBL
	 mPQlDy2bPHf4BkHKeWFaUexkpvpMqtjlKJ1goZeBlBWTH+pL96g2UFwjtyIp9ay+qZ
	 qqQTY/Ymp8R6mzMhan1FWmIxt6oksL6dmqIhEkhKJFxciYkGxK4Mtmn7CRcoZffm7k
	 ODvA9CpMFHSWg4s2OopMn/72MLCGiq79fefx7ZgJQl7/LV9uYoaYyrbZlFdAt+8B8W
	 eTtHT0tISqGGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB53C607F2;
	Thu,  1 Oct 2026 16:02:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 445EE33B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36A52405CB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbGe4XN9CzVJ for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3B3134051F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870564;
 b=nUk7id6Hk+5ik8zKE+pLIhacw+OFfJDpKN+tbhIyDfOxI4123rxGE2vua5In0fqCubWA
 EJ0RzWjQzXSMfitbEyNyaMAGkGL7rExaDRJ5uPbEaxBWVBuPj1r8BzEr13Nupa6usx6s3
 46nGAcuwr/C970wfSRVU/cOqk+bB2ECGL+T5IMH7jvyIQbxcHGSEhmOU1kP3u1qmINCEb
 Ez6muqvW07egnq4W6L/yHxCNXnlKcLk1hjnCa9HpeJHmQcl951cuwQAcdKggeLKLax47X
 k3sx+pcFf4WlxWOsQDTfD89ZNhYSWHMKyU9gwXtY8usyx+1vVocOy8LB6oJppQZGjXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870564;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
 b=ak9lN+GbrMyNr86hZ84vExa+jhrMUzEh0GEjIPgV1HVnpjvzXkbZ0iAUFPevVV0UYJXj
 5g/he5dwlPhtxBjZ6H052ppheKx6jZWxkPSEiC40m25YvtUxdztfOXSE/PLLKbxa3Jxlc
 /MFHYijrKJ6iKo+ghNAo0J3Xdppy3clBgaaPm5/+zNE57h5yOGd3o9HHl1OqJHjxc8zQq
 2P+e7m9GzpavoUfQvDXs1eX/Z4cbbw9FBmK6sCF6gnsP3smEoFeM1ocARMgbYSodd22HE
 HuagavJxmWXfin0U5N0h3DdPoUoJLv+MjGZ2uVGbjLqOLY4c254RzeoJIZCDxNTpOuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TCqIqLoo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TCqIqLoo
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B3134051F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:02:43 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac768bda6aso8079878a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870561; cv=none;
 d=google.com; s=arc-20260327;
 b=nIrZkoUYJcfK644cMvJ9KNE2cA1VR5IOnxwJ2ZH3oPwrFa17qrft44SU13r5n6i9Nw
 CvrTcUeYWVZpxf/QfrFhAAtqg6rUKBk9ikejf/iu3987MaBedI4qemEA5tpfVh2U89IX
 j/h3IgLV/ZTTWEgUV7l7sQ6/A0/b0QmU13GRsCZCXcuSEApcvfkg2tgEFmSsxKTjArZw
 L3G8AqSO/JT/5ilZJ9phcztP7fDhuBrbwMjKh9ofe7yJN++V+K2OXG5e5KxV8eHtiHaz
 GsWwsTcF6gsrTcFG3YNNmuWIBSv2PzxE8VETfV29Xsc8GZY8irkNSZIVEYWafqEacC3p
 A/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
 fh=RYTCF2AGwV4dDwD8igCQ02AvB20EBqYyfpyIMcmUa/Y=;
 b=a0kO3gGEyD6OLWvxrXAUtXuJQ+qV11+87Xdh1hZXTwyfVK+ZpUHwjES3CdpT03/qKy
 nxOdrQb7DZWo+NUygfvUQ+b/Gv21KYbZ5whdcuB5Rxo5dFtN7J++dUH8WFDTQTB9B60b
 KhYj8r4Ehg8AP0L438NrbXoGf9688EC7pgiKKDKdgJc+JSC7q4djSqsSBwCQ0y7NOhOK
 e7FH6wCLhFxPeLsWLAj4bdU0MQ7E1X++DbeFfcrFxrk29QGbSlkZsrgbuArHxFLbZxKD
 iVGDnZI9H7Jo1IO+jIXv49t+wp8gl+8IQOb1/zragwA294BJJ83FbM9KNmo1ieuEDwB1
 i68A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870561; x=1791475361;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
 b=TCqIqLoo73Au47zMHH+kqXpzFeW/EhxKdRM1WgrDm3xWm5g1Z4oNbfIVwCV+R3yip8
 YsEv0jkW3ZmgYSrl4EMS3n+zrdC+QE3FG0ZKb9FVoCH8n/2tnG31A0GwvT8xageHqde7
 Ygxr5AinB1wRedbeEo7qgMqAZwmYZCax2xeTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870561; x=1791475361;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MQ9GWSSy44YVPN8Y8Lz2JmOrhS8WSM+YQO7cRK5TVWw=;
 b=BSbT+7Z1dzxyPC9mtOSDA0EcV7bnwv+s4SHXXUx4tl7Uq0CEmpak/MLaVVO1vgO57L
 6KwVvthFDei44JN3hh9z2yWLeI95g6Q+DXqZTc8v1k99pzVNKWJOQvFvYrLpcg/VQHTG
 +qfMCe/ma5tIujADsuzH4jgapAUpHO7QV7jsuAFeFZ09BcnLf0ylOPRzWmAT/jzmA1hJ
 qIcy+hAZr5gy02Xc4UMjLyymI8ciRsiSesWULO4mSU4zYP/PSjdDzKaY+cIk8CUYWLyi
 TeL2qg+wBwFKEHATPdn1TIZCE2qZq+uxfZ/+0RR0QQTl1GWfIjyFI/AxqtgtuvcTU8CC
 my+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp1DAaDijisNnNodUm7DZ7zdKh13JwFlSUVFl/hFmx/bVrgqTVGJ2pk+yMFgTKAMmo+VpCKso=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYInfX//u/b1VN+b6GpvwhWkERzoGASpR2XLoxPk4XmXPrAmCsxI
 rQL2Bb/kDMxcP7/+/XSfPy7kLy3RijZtAc8GU/EMBmSjTAm+I6z1JIEl5grl07zEJUJDXivHY9O
 AYycJUA5yjNUJn9zDoPeJG69KtSS0ubNDFzEGC66j
X-Gm-Gg: AYBFou1T2p3Rxi2VO6GKyhydZu3RIINXLU+eFn9GjZESWH7k0pXSUX9GiEIsAzjavSN
 xoQTXQ3FZMYblrRRnIM+ycxKbOFbpjCmFgWIxW2rt45cwJy7FGoUE6zUvV515aVoYW2b3Ck2cLf
 1yVF9BucsbtxIJDadKoikjnq1BVxiqku7Psgx73iiZZptW9nCyulRh66zkc/lTOUHECEM2aBC74
 4P6gFn1a18fvb1OGkAg0QeTMY9c/uP0P7Roila34esUL8FSvCkaJn0msGX40haksqqKLJ/W+Dhb
 wXLllliizs/YmpkP1N2xigLouE1KvLg/7PJqn9ZgPpybL9Hh/gDLP2f7
X-Received: by 2002:a05:6402:324e:b0:6aa:7d3:7cb0 with SMTP id
 4fb4d7f45d1cf-6ae1990d1cdmr3320804a12.19.1790870561604; Thu, 01 Oct 2026
 09:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <9ecd2cb0a242f1dd110422e8554df8bcd091b655.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <9ecd2cb0a242f1dd110422e8554df8bcd091b655.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:02:27 +0100
X-Gm-Features: AclHuK8fyukVrAKIjb6pAU8QMOudeBY609y-b9re3DIDIeATSkeDaCxaTUJflyM
Message-ID: <CAFLszTgY65ZYf=kF6B0RwJKKCcnuyYx1dpspHejeXnzd1Swdbg@mail.gmail.com>
Subject: Re: [PATCH 07/11] boot: fit: unmap the load address after a storage
 read
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: unmap the load address after a storage read
>
> fit_image_load_storage() maps the load address to get a destination for
> imagemap_map_to() and never unmaps it. The mapping is a no-op on most
> architectures but not on sandbox, which is where the unit tests run.
>
> Pair the map_sysmem() with an unmap_sysmem() once the read is done.
>
> Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/image-fit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> The mapping is a no-op on most architectures but not on sandbox, which is where the unit tests run.

Just FYI, on sandbox, unmap_physmem() returns early for anything
inside emulated RAM (is_in_sandbox_mem()), and a FIT load address is
always in emulated RAM, so in practice it is a no-op there too. I'm
fine with adding the unmap for consistency (this is definitely an
arcane part of sandbox!), but please can you reword this so it doesn't
suggest the tests were leaking something? The Fixes: tag also feels a
bit strong, but OK if you want it.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2222,10 +2223,11 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
>               mapped = imagemap_map_to(images->imagemap, data_off, data_sz,
>                                        dst);
> +             unmap_sysmem(dst);

imagemap_map_to() saves dst in the region list through
imagemap_record(), and fit_image_get_data() later hands that same
pointer back through imagemap_lookup(). So this unmaps a pointer the
imagemap still holds and keeps giving to callers, which only works
because unmap_sysmem() does nothing here. If the unmap is meant to be
correct, it should happen when the record is released (e.g. in
imagemap_cleanup() for regions where lmb_reserved is false), or the
region should store a physical address and map it on lookup. Otherwise
I'd suggest leaving the code alone and adding a comment that the
mapping lives as long as the imagemap record. What do you think?

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2190,6 +2190,7 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
>       void *mapped;
> +     void *dst;

There's no need to move this to function scope; it is only used inside
the if() block. Sorry if I got that wrong in the previous review.

Regards,
Simon
