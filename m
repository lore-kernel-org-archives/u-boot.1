Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RzGPtAjK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=UoGbEmBg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22BDB40A15;
	Wed, 11 Nov 2026 00:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vm8pRnrgaLnZ; Wed, 11 Nov 2026 00:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4694A40A04
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794357617;
	b=l3zP7gJwwr+XP7pO+dLL7xgnGmIsf90DqS7evhyltm9r7xlN8gHWV4KBsBUCjQYmpPaX
	 2EyfuxFEP2ihvJalymg8qQh9uZ2Fxd9tz576H6+1Kq4T4kf3SD7It/9qaIPgYXhBfOkQG
	 xDrXMHwCQqf264lbBx1m1UoyWzxk6kLcrmIWxfavP6Ic89ihH/zzh/dIfWN25I2gg/mqE
	 CGUjTbMfvBdTY1P8S5vHsL40LOuypL+YXXH0NWvOaJAJIkF5z6QMI1H/u/Wz3/WwpMrEh
	 1BbIY4XPJErP1UuA06oM7MwIMQCCzymtut2nGXxTvGtE+efAzy9e/mbgRu/+h8DbIiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794357617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yYNawdo8oPfLz4nGNG0yvOHKs36jdVLg9z3Xv20xyMk=;
	b=mhiN8k3v5TCr6iRSHLdfMNp0HNQrjMjT22e6QVv5yfG3k4FmupKhylKlG7xzVCfCchwG
	 CIKRWNtIeBFs1XPIpMm7+r5ZTRl8wZNW2WFMXlfklTp3AiouP0N3ZITUrQ8O0eud1KEUV
	 aqtm6kKlRGgprkAM00CcQ2NX6B7uuomROhnon0lGRiQHhibsAolJq34i0mBEPW4daQDSy
	 a2Vtknl9xM49+Q/k6pOsl5LUR3xMbXCE6jpLf5FK9d50b+OpekZKm9Wo2y9/scVSnQxKu
	 Ue0UJvob/+pBlFvSrTce8w7HI8i0LHtKlYnNfpOnd5VnsMm0wzWw01jcCZvXcOWKdIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794357617;
	bh=yYNawdo8oPfLz4nGNG0yvOHKs36jdVLg9z3Xv20xyMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RzGPtAjKcf7453vefgHCtyhJ9mWJZCdJ6ktwuoIgJUkaX/8iUVJl5g1t1VR8sIoD6
	 ALcVUNhEfuXtG1l4viTvdG9VIiuAkf8J5/6Z8R2YF/s8pP1j0EM37ZM9Ng4yK7KTWe
	 1bLCyWsAT4BHx/dxEb4Z1i+aNnhMEJWO0eJvNipVHhK/SxTYpNOsIRIGu9992+wUnF
	 WFwU0a75I6uAMsK5s3spqG6eSzDTQJhoxktrlOd3jw9yPbD/S4w6bqpJUx1lU3Eu9C
	 RkTRX4mthHqK6tYzhLK6K6+cpF3Pz1bvnPNHQp2bkrqQnbsYSww1R1wTesTNJjQwjZ
	 GobWuKIfWKFpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4694A40A04;
	Wed, 11 Nov 2026 00:40:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 586289D1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F0E76088D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:40:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhoS8SVJp8_R for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 00:40:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7835D608AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=UoGbEmBg
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7835D608AE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:40:12 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=UoGbEmBgfrSSGC1NYPzFLI4Mc+ukDrGIK8p9rPcQDPbBaepIjowm6xPl8LIHRLDtU200B0K4Nqw+cepDO03GSOfh0s5v2Wgm0oAp1giY6dujBnYImyRyh3yT2bcEKCIJekUvEbqxWlZf+xhMek9y9blwWT9Aw9rYb6llbKkj1V8=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=yYNawdo8oPfLz4nGNG0yvOHKs36jdVLg9z3Xv20xyMk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794357586124870.5444081029267;
 Wed, 11 Nov 2026 01:39:46 +0100 (CET)
Date: Wed, 11 Nov 2026 02:39:45 +0200
From: Igor Velkov <iav@iav.lv>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] clk: rockchip: rk356x: Set twice the SD/SDIO card clock
Message-ID: <20261111-re-jonas-rk356x-sdmmc-clk@iav.lv>
In-Reply-To: <672d8b9e-079e-4705-bbb3-e26a3983195f@kwiboo.se>
References: <20261110-rk3568-sdmmc-clk-v1-1-482eeb42f571@iav.lv>
 <672d8b9e-079e-4705-bbb3-e26a3983195f@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/10/2026 6:29 PM, Jonas Karlman wrote:
> Please instead fix the U-Boot rockchip dw_mmc driver to do something similar
> and move current 2x handling from rk3399 and rk3328 clock drivers.

The 2x is in 13 clock drivers: rk3066, rk3188, rk322x, rk3288, rk3328,
px30, rk3308, rk3399, rv1126, rk3036 and rv1108 (eMMC only), rk3128 and
rk3368 (dead: set_rate lacks the SCLK_* ids the DT passes). rk3506,
rk3528, rk3568, rk3576 and rk3588 don't double. rk3066/rk3188 are
rk2928-dw-mshc, which Linux does not halve. Moving the 2x into
rockchip_dw_mmc touches all 13 at once; I can test rk3328, rk3399 and
rk3568 only. Is one series on that basis acceptable, rest compile-tested?

Igor
