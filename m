Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681DCA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8783C607E8;
	Wed,  7 Oct 2026 19:07:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0dG16yk4joG; Wed,  7 Oct 2026 19:07:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DB404605CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791400058;
	b=jzdWbQRk6HxsHDwH0PSY6we8FoQ4EduJS5BUfFOGM9yO+d9QyNQUTkaltttds3qjTGj6
	 ifqNyvLIsvfqZbL4wseOEEPfDo3t63bixk1ddgxxYn4Io3ulNLjPQVq0Y6vj446/sovhz
	 d7OWaBfhASdf8KPbPS1zIfwD31It+7FJmo/Xau9iWxaZO1zUaC7HO2CKpUsoqN6cM8UIs
	 2vzgZuFokNVzijiAYEy7QWWU5Kf/FVFYZRPDd4oZfjFJJFztJE+b4JKH3nR3tu8ytd6Y2
	 u9D7ViTK6TcexJBVi+1CjgXCeKEO9i9tmu5BXULWSrHIXaR59rf/3fYr5I0l8Jx0a9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791400058;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KTv+wVmaca1b4yXOQ1MIcPlssM48sdbEhBfyLvCyEwc=;
	b=neru6gNT2guld9AJQVYv7UpgWwXun/TnABUdkcvtxIDXNdyFdYbms8JTfeqCbzlRdtmT
	 bNn9/Ra5OLWLOmUAlrLQe5QiX0dfiuzQCUsnIBGGWJxnNpCr/fY46oSc6kWyDAIpe6nj3
	 pnQXN3XjQRBK/5TprzSOODm9nynQktLmgjBkMEszZi4Wc/Z2sG3LfrcoLLhCJXK0dcAme
	 zqGZnWZiPeQTJu322hWgbqldvBs/6EH8hlFaQxlsgshYL8T/vVBiYU2yw/GEn2vrMItaE
	 dtjfyvN+3NHqxp+zissox3O1wwxxD9+gJtXflTbnt4vn73MuaBgWiVgHumZTAvIMD2A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=G5wC941n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791400058;
	bh=KTv+wVmaca1b4yXOQ1MIcPlssM48sdbEhBfyLvCyEwc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyxIr/DkM1YL2l1MmRYFbhyyQOWWXFirrUH7q+9JQeHfcxfSIu7nIElGz0i+j6n2n
	 zFnQIfRN3RWbQGXZ+YKGPMM4L0tiLNsB7+GeUA5KXc+nF1II8XZT2ID9Hnj/0p5zfR
	 IIkOeTMksA+q1Pq7yuMd6GSRfT79TE+px7lz9PWUDyXo9c+wW9Htane35ibQTXV4Zb
	 hQ5WxC4R6P5Yx/RvZ0D5iJYDCpOrtw0MzgaKZwuzdQtxbgi8ncnc22+2+7sFxODt/D
	 7ESVn1w5sptXnOTFW9MgC8c5iaM8zjkCs8M30K4Zz9oeGe2s95cUUG8wRZLRrV5MiQ
	 11F6RlvZiA1Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB404605CC;
	Wed,  7 Oct 2026 19:07:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 813A01D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72D276083C
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Giz3G0FSFeU for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 18:42:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B804D60658
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791398525;
 b=p+IDCOmUh2UkRSSpzldRqum1h86r7YrZ9QiwcNzNV3kJxLz8S3JAvlSSUQBLNwPbZVnn
 X3c9nhu8HM2Nh05GLm0/JfbUntEDb3eH7hRKuxIHWt0+dA+qgUe/sDA40n5fzp7IseD+X
 9mtIgfYfk/P2rpCnFCmTLBRSE7gVpyEGd5ksdqFwwjXmiya3i2sakfAe7ECotCkZbggOs
 yuc04p3DyV4HWza2NgFT5cvIClbYUk6T1CBLuivwxhba2HAa7fL5QbRLWq8LCmSr/dyXY
 dy9iUb1PPF/kGvJorbw9ZETXulDpVHWnEqn899qXXCv968Ahl5RLik7I/Q/CV+6Wu4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791398525;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=KTv+wVmaca1b4yXOQ1MIcPlssM48sdbEhBfyLvCyEwc=;
 b=rwl5qS8f7uP+NFrA3tiuOhh3otohHUupq/cwTDJhpZ5tAG76cYpP2pc4cFKk0vdEoFZn
 dijaz7D8bDF3uN6gU5HsfZ/S52me7CJktGZesEK7Bih78leREaH2Mi7NwBhFKengnzjPm
 i3yD5hoY4Uvg9jrAv5eUvKiBYXDikMulDNDwB5nYnLBlu9WgZin9XL9J7OLTJtAkDIz93
 TrFahzbDq4GC5naxKpxiyuOPryYyVz7R/e8x+mkB8anNz11Su5kCmIdSfvScd/U1qD99r
 ZZoHO5ZMXe9+mjFT7rXQ2eAZ6CYJy8TSjlGHRntu7uSXZK9DWe/Ej77VTAdTdJSGDGQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G5wC941n; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=G5wC941n
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B804D60658
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:42:05 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6d7e06dbcccso1508075eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791398524; x=1792003324;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTv+wVmaca1b4yXOQ1MIcPlssM48sdbEhBfyLvCyEwc=;
 b=G5wC941nzS1Hnpb9uMa6tDk+6o3Vyfm+abwDOHDIvMLZxrtxTlBRhN/7vwkQg/C5L3
 dH0lQqM9605JPVuIL1xHTkw6szkojxz1dj3XDzDZDG977ly/NWDlCP06cyKAno+BznrN
 L7Ge2pGHlCS9x9zWy9pkzsGEUDV21yFOv68Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791398524; x=1792003324;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTv+wVmaca1b4yXOQ1MIcPlssM48sdbEhBfyLvCyEwc=;
 b=gb6MLrokXEpJHXjW5lq6ldYdiO2J9P6onQDhEX2ULFSS8VpTTrFyF094E9XdMV5mJM
 HN9HAZt7eH3tTNwjgDfO7YLabKxpmrv6SI4rZKZwlQ5f6js9lTVuGUlQGq8O6D2a9Y/T
 Rcscof7eKCCCVQBfKSrVKhyCrWTs5ID3DOPqHiWvu2xGLCNJodqidbp74CHWaCZZAvI3
 +SFPJv3jO2bczD0OdjnvvvAsptiy8tP8EVLyDPZkg9ZQU6iuFGWFe2YwIKFMJ5Z7qMnH
 Z36lwHGvhsshWdQ3URDVSogxdz3yZe1vSOhSu8WMi2T+eSUBwKfyZT/1ToLVU4BFdUpM
 JrKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrh5y/muYscWkesNTw72DxN35ghtgQXsSVn84l7CO6wRCV35gnZLTEwYoN1s7oe1VWbOmCZN8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ksAIA4q2eFLzSPQfGYH6A6glQirnrLhGr90Aerj6gHQDLDaAue
 21YSOr/xeW/OaD1pbp4RoMrtmB/frcpYMdW/qCZC8HRIgwNGiTFxIlIZ8sBs0UaF+ps=
X-Gm-Gg: AYBFou1Biwc5tLY0ocmqZeIUGJOiUpIjdjZuIhHRkmOaUobUdYzCOlG/ZqAZknlJW9y
 i0+5NSzos/Px3VwYAlt9Ty0W5XXI/Y/YStTY6GdCaS5+WBzWq/oKE035E06Vzq+CH+5hnkjvSdd
 yVqEjRPeLMQCueqk09bxs/5P18OXFDWX7QRp1Hn5Oq9tB59ngxcLAHKXH5wi4ri6laZhdxHPHPe
 xOHDoYR0AVbDC3SSfQ84e+PLil5lggx3cRFzUCl5nqwDOu7oWmB5qjUYva+wkKgBi3vcGbBTjRX
 xhwPmzOaRyWJnq1WZWiWL1j+lCOioz8ivNHioNwL2P2AiwWSWNv7CTorrhmuzHZjawElqjY/fy6
 FkzAwKfvvvpGJHBGflsN+PquzW5j+NFTRgbrnbamxRM0UI6GDn5RQ5mF5XTKZh2DB8572dEzyn0
 mqN9EW2UFJh17I3xMnzdx5OhBNNIlks/OHw8RFdKgOtV5i5LbjW4uYbjk36sUZz+VjjGVyqnOMh
 ct3B5Pc0+6ULFRlNhau7EiO/GYhJhPMTsV5Ut+NdqnRZJXgDb4w0ovDopfN6+fHqFwnKGuUhFB4
 yOceG+z+AExXtdtDoQ==
X-Received: by 2002:a4a:e84a:0:b0:6d8:57bf:57d4 with SMTP id
 006d021491bc7-6e7a77c5044mr3248954eaf.14.1791398524019; 
 Wed, 07 Oct 2026 11:42:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82adcf0fcc5sm3570072a34.26.2026.10.07.11.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:42:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org, 
 jerome.forissier@arm.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
Subject: Re: [PATCH v3 0/6] fs: Add 9P filesystem support over virtio
Message-Id: <179139852309.3398671.7231524378185570223.b4-ty@konsulko.com>
Date: Wed, 07 Oct 2026 12:42:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 23 Sep 2026 21:29:56 +0000, Kuan-Wei Chiu wrote:

> Add 9P network filesystem support to U-Boot.
> 
> It allows U-Boot to directly mount host directories in virtualization
> environments via virtio. This is useful for loading kernel and
> initramfs images directly from the host into the VM during development
> and testing without having to rebuild disk images or set up a TFTP
> server.
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] net: 9p: Add 9P2000.L protocol support
      commit: 48bb83195682d189273bdba813fa67f7f2760d59
[2/6] fs: 9p: Add 9P filesystem support
      commit: 9e14f904f8f12cd9df07e99a679453c8782e523b
[3/6] virtio: 9p: Add 9P transport driver
      commit: 09e668e32b4c14ce5c929d6cebfac75d2aefb90d
[4/6] doc: 9p: Add 9P filesystem documentation
      commit: 7d963df1bc38f5ae070ea8b96e03afc1ef7e23ed
[5/6] test: 9p: Add test for 9P filesystem
      commit: d446ef40b87d53ef7ac59ac9b1d79a16f0a065b0
[6/6] MAINTAINERS: Add entry for 9PFS
      commit: f6002d5e8018714ca80dcf1835c230c99c5090b3
-- 
Tom


