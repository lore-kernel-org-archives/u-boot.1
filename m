Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A515CC79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 106BE8098C;
	Tue,  8 Sep 2026 11:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wHBECrpvyz9o; Tue,  8 Sep 2026 11:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32D2E809B3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788866787;
	b=QNjNnkl7VyQzBF8HH3u6vz0qK0D0poD3QOh5U5xe1GkyCdR4VZ83viB8kAMskxOlfEb4
	 XGnuUoELP01qZyVsvZp1BAO6I1wrB7xU6kl1WzPgQxS6pBUcnjigcktQ5cBo7pyM89Jo5
	 R8H0O+6snunBXzw0DjYiHk/l7NouwsP6CAcktOsD4CUGp1LRxZv7E09YiaWYvoYieOFtZ
	 +9CY+Uund8ja4dduHjFbztVQx6M4EfPUSddBofho/kQuSQFdWPgWnz6d8HNv0qRm5B7UU
	 qiHZWJ0ts8UBJfnKPUuKii33JZPSSjXE7STiuRn74rSYzEOuIcQ1GO2wBskDppIXI8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788866787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UcFiAH25U5QmaP/5qG3ub+a8Nrirwlh8fzqB1OOEuh8=;
	b=nWpKVt0ByXD6v9/lxZvfiKEUkFuObp7DwwNYKPNYPjAtODHUC398kG6WqLAayDfIssL+
	 GnqGSu9EnEJwjj49SUFJv2d/KKK5x+DOZNr0wrW5RPFBNpaU1qch4BGxSi0gSVX5lNEOe
	 jLINhPwM0s0tFHnAqSwOH9MQlK9+Y2VJS1LFOTkEEHrYwcwSq2zHxmhz9LfyXVgxyR3K/
	 310v4Aph8FK4Cn8Fnlai/UF5KlcGRHNPEtcmUQEqUUVReBDf0TrAX5mW0dXqG3Z8CSdW4
	 fnkAHoN0CxkxCHYbM8sgSvPwVkSOlPXJhWdgatJ+UbgDiDsluOtxpYx6VEMYWSgaLRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788866787;
	bh=UcFiAH25U5QmaP/5qG3ub+a8Nrirwlh8fzqB1OOEuh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tHUB/ofaZC2YqFbSlrwB1sTIBmY+Qqy4jhB39LV5SYqM3K0c2L1g/ItFk60QvdIEg
	 yzp3d43hRXzKyY5BY8N9AAXc4iAOq6mVTkYK3Pfed+sVa5I2wyMpF2OfHj1rbLV2Jb
	 l8qUwMQ41OObto/M09iKsya1+Byw/180Fab2GnEn3b2Ysh0VULP3y6TXZ/60wnyDtF
	 cNUpB6fEDcwcTlyxlQdd2eVe1+uPgGQgIyQtrmwep3y13bgWF1NvWapq/MhCg2TDZp
	 wpmSEF3MX4nFYJ0G+iAIXQ/14VZwaF6+jJ7R4H0LLK/E4+If0xjJUsItnazSTjsc0j
	 Pd4IUgTGK1dLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32D2E809B3;
	Tue,  8 Sep 2026 11:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A6B372C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BFFE606D3
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJpvljM2OzPs for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 23EBA6067E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788866783;
 b=gRgcBegrCD5fir2qy4Vteho12jObnDMmSHj3dmKrzVEgoUybWt/4+SrAqcf9FMTfsJYT
 jbjDXhnd0ddsWUWH1D/KLt9nRKtuPsWaHt1WFMy0dcLh0khi3W60QBzU/R/FP5ppM0poH
 BbBC3jZl+UWl99ItSVa8tbzlZHSduvGqZDfFj3iFG0NF/LpeepljCgX6I2ZVg5Mrw55Qv
 Ly+wMLn6K7lo/2aW3mZl0swhCjVU+duCWburHDQehjBCeuuQy/qIewOilVZYU9kdZh63u
 9kJWPivZ3BAR01teHHK9VZateszhOSfxi8Fn7B/JTOPrTh9DT0yT7yxHt7pWQMt7F+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788866783;
 h=X-Greylist:Received-SPF:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 bh=UcFiAH25U5QmaP/5qG3ub+a8Nrirwlh8fzqB1OOEuh8=;
 b=RlKTj3rff6AcaKjThkD4NDCuPaoC7zfr/MLrN+24Xeq0TQXFevluuAmb+eFn6SP1KUWI
 vtJ/TURA2P1Dd3i9FHQlrcDqaaWj+gjZXGedXjHUPsMgKPw78oWeAhir3xFCbh76i16Rz
 PELYI2Cy8rhGD5h6HQn+MUn2+CvWFCM4DPHZEAJDGimI+kO5JSjgXKHfw3gPnFtBAR7AD
 e4hXPVxzWO3BwmqrU4psErZq2hhn6Av2FTwPPycUqFjZNJcLPC+EWzCPCo7kAHUU7Lp5i
 tBNXvQJ7Bvif5hFfNu3mQoUV03umEZi3amWeOhPyo7gxH1XsxjDyEMQI9hcNH76KPZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=sntech.de; 
 dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256
 header.s=gloria202408 header.b=axGI377A; 
 arc=none smtp.remote-ip=185.11.138.130
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 11:26:23 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=sntech.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256
 header.s=gloria202408 header.b=axGI377A
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.11.138.130;
 helo=gloria.sntech.de; envelope-from=heiko@sntech.de; receiver=<UNKNOWN> 
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23EBA6067E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=UcFiAH25U5QmaP/5qG3ub+a8Nrirwlh8fzqB1OOEuh8=; b=axGI377A5VX08pIvsZCX2d78jd
 nf6F8HzQdi+/36N2ldK+78pBGCRR2oQ/CaqGTzOBWoCY3cZs3UMYWF+CvseRFBZ73MS03emX/6GBQ
 VaKUCPLppQsCPIPkrNleLoM5FcBcYTklFoBgjZnTaIu8z04ADv+9K2ohqek0zO7bVAVCDEHFhYTlE
 GAdU6tFCAQHVif7ASLEwKQ4w1qnBsCUPihwTDGXnjPkL7GVJAeUOY9BwomZxwzF+tNKa2EKSlhjh1
 q4oNwYQP43dk2UOGom9heNHlpx+lCAIRHdreLbmyyG7bUEsXrGgw6n4Mta8Rdin7jzWwPl2NBgw6P
 7retM00Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 0/4] rockchip: Always init clocks in SPL build for RK35xx
Date: Tue, 08 Sep 2026 13:26:06 +0200
Message-ID: <3099454.C4sosBPzcN@diego>
In-Reply-To: <20260804002643.2308515-1-jonas@kwiboo.se>
References: <20260804002643.2308515-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Dienstag, 4. August 2026, 02:26:38 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Jonas Karlman:
> This series flag clock drivers for probe after bind in SPL builds for
> a few RK35xx SoCs that require core PLLs and clocks to be initialized at
> an early phase.
>=20
> This should help e.g. ensure SPLL is initialized correctly on RK3588 and
> CPU core rate is initialized on RK3576 when booting from RAM/USB.
>=20
> The series may possible depend on the series "rockchip: Miscellaneous
> RK35xx clock fixes" [1] for a clean apply.
>=20
> [1] https://patchwork.ozlabs.org/cover/2278934/

Tested-by: Heiko Stuebner <heiko@sntech.de>

This and the misc fixes series together make my DSI panel work again,
which seemingly broke somewhere in between.

Thanks
Heiko


