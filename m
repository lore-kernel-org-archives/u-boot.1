Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA00CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5042480DBA;
	Mon, 12 Oct 2026 14:48:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tv9j2o4AcjEb; Mon, 12 Oct 2026 14:48:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92E5C80DE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791816530;
	b=MZ7KNbfWEkT+gm6jYnprEB56CHV+w0cBDLm63mvbo17vjbr7TrGmI2MP4qdDjgSKYmKJ
	 tgJOd9uPYES/7R1icp3F+AN55rkRvzsgnEvWp9vbu38/N6UVOhxH3xZAtJnZ1FviLwK6P
	 EP0zBFifFw30W4naUEx3QvCbaqhUe7NXm1hAs3FqwwbYS+ZCkr+lvccWF/QZFlNcu2eSR
	 V1AzLAiDQ4Rm3+2GtW0VFrG+EatkW8MYeKF/488LVlqElbCNr7mGrXYe7oiYDawHnaJhh
	 3M9DtefbU4IQl48bxs3V6UDM9OkuyHa2tPLM2tAUOyrbbXuDPSyIjcAtvMuEj50dJTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791816530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ui+B7PL35/QUqcdW3HxTsIPx5lZNeTdfZNylqvUVuuQ=;
	b=cFgBgaHuGi2XgbtPqEpHYSUnHeQ6MnuyppIykFiZ9N8ai3g3AkHIb0C0iUbQXV7vc/Dk
	 cq4dQOriXQyRoYE/cuegqMPQrJcVa7gJfCNEBOzBB9AL6bkRPuVlUTznZI272PircvJFT
	 EZoZQz7ks+ZpdTf99Cdguyp+2KSuHUQYVKqtaHDDSMMHqtxyxOHxLRTpBBByEMWoxAPK+
	 meSkEiX5avQ67bRZ+9Qqq8eOjwgP82GqUfgXkJaEFhGcpu0yMy3rINagNWC4IN+m3SU0m
	 BnVYD7ED2y3Qu5DfgymIYv2IrJeIdS4I87Hb55aDh373fQlkSMs90THaHwzWmQNGUXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jV3LwhVh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791816530;
	bh=ui+B7PL35/QUqcdW3HxTsIPx5lZNeTdfZNylqvUVuuQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WUHTh+TJ0R4TPE6PTSuJVjrC5HO2WXU9KUHPIX1TkQzqRNwTrU4DeKiTLnQtQrbtw
	 VpTKWQ1H/Kl2gUnPGPW35hg7ERt4WXJdgk2uslLV1qniBCiY+6LaKvUizGpPcn70v/
	 WKWVhMgnCJ2uwDk58joglyioQrvfKMWLWnptovMdzJ8i8/sHrDySFAuDRa+yqdObz0
	 yURT/AcAkNF2qCfb+PDHOPetde5PcVG2p6V0x1OgXhED+ouZ6TVVgDKkkOTaBPemep
	 +T9C3V9tw6JzFeQIYKouO8kDx9An+WM7golrn0TTsYtljrMKeoaD4X9i/WhYpIzG3d
	 QoolL/X4/yK0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92E5C80DE3;
	Mon, 12 Oct 2026 14:48:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7908156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7ACD80DE5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:48:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdCB0VebdmDb for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:48:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E10AE80D9D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791816529;
 b=g08kpSRyIu+ZxjRJIhu7ol4ocee2Q07XEBLm+rzCkt1Ugx+3t49DlAukk6Y5wycE32vX
 zxkvgZpcluUAgFtvMPhJGM885FM+kG0tgIyEHkmNwNCFtiHv53SYtEVVsJ7Y6LPUScpyF
 n3DXMgFDa411NX+PxLNcVCYD6yrwOUPDx+M79LMYK1SG+pKM73mQCWH/KUQURIMGyHKv+
 E/EDFLTDypmhg/xfT8Hhn8a8YfWJSKLpWXOB/sb4No+SJX2CiQSlUC/tuMjoBCAheAbdY
 YXy0G6h/PrnvF3RCbG51FGrbuH/wvYijqQgKAvXZgXQskxj37TT0rKJEmk8Y9mVxXmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791816529;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ui+B7PL35/QUqcdW3HxTsIPx5lZNeTdfZNylqvUVuuQ=;
 b=gHk3uIPWIShgBIxzAGo8qbUObLL3iek6cuN7RZJdBa7cSXOw3zF5psWYuc4vH5uVdJ/H
 zf5R/CVD85+kEBFv0EMTUFTCiv3MwjCnEQruFXSCT20r4A54wBDnxcKPW7t2caKU88VAm
 hhOofG9cvHBUfGl1G2aw/1I0BVanU1fz2BdxfF5cin8MlrjOrlNXSXqGzBqSC2kx5xBO+
 YQoO2H1eIHpZNrF1sGVvnZigVf9DboqSkFfl7zV6HxFwbJJd/GXn3uEa+arOJ3iliwM6e
 WgBLlUS18SxQZreOVfy58nur57YQqo4PP97N8ag9oqMcxmVpyvVKYW/OZUhW+Yw1dew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jV3LwhVh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jV3LwhVh
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E10AE80D9D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:48:46 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so1263747b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791816526; x=1792421326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ui+B7PL35/QUqcdW3HxTsIPx5lZNeTdfZNylqvUVuuQ=;
 b=jV3LwhVhyi7FzTzdWmr/xpj4YzyMWXVRczd99od5a9hwkHJOQVkSFZoiwDRBC5tWfs
 aqrSjN6NCJeORg13AOMMdpCtGy5tfWO+tgcCm4AEDfuwqG8NYSuq46NqL01S59SBC8f0
 kzpwr/LRATjSMRQ2bNcN/GLhVo+zhktwDRP0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816526; x=1792421326;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ui+B7PL35/QUqcdW3HxTsIPx5lZNeTdfZNylqvUVuuQ=;
 b=hfEnajP83CDuDPLbJ4SjMa8dqY4rUCKoKga8RtK/dEFz+pxLJ2MXIgDxdN1BU1R2kz
 bNmsmweUoA5P1uBcDmgv7egy/E8YOL8nGJgPcujjJFifnGFxcFSW1JwR98wWCiOd95f8
 qLkvqIkMq6LDnWAzc89mdXeVYU7xAZTJ1tLR9BjkEVGM+10HsoW24blBeWKWevo7QRCc
 q3eY+Zxg68Kw+YcAgGF0rRSIPt6iZYOdB8mNlHsg33fadoORNY7LemTlbOzlbQat+qCJ
 iYiHDvRBzUX6Ia0Y49u0VOd8h9HyZZAqSnd3C6CHjwbd8w4v6qs3/27B25Zh2Imw7Kyp
 x9uQ==
X-Gm-Message-State: AFq9FYJJ498vZdofev1loVY3XafXmgPkA2V7pTWpaLln3/iikET7DtJH
 PnhjpGQyUkFHIvjqNlLxlke/lj+Gk0Fs2FhPDhvBml/50wk9SMLkLhylac/TnV4JeG6NzWcfwR7
 RuL6BAnjsBtk+
X-Gm-Gg: AYBFou1G8R+ojjdDshk+Z4ujH7DE0dOtyBhjgZoJOGXk5Lqg5tzidadhtTN7Bej8jWS
 yIj4QcQZ3afj0RIeKFDiOt3KVUtsq7izjo3Xov57jIkU2cFVDQl/cas971eXG46IwxWpRcTHb5+
 l27hhpGz9oPTryfgWgTIqmSVaFaCA8KZXG6uhkviCKW/R0+dCtxKAkFE9fc/ricxqxOuvc6UcDO
 ljROTcfDKZqPoSgWIweqFxHfUcWDRG57M5R6PC72zfsEOQetTt2DYTxGuTM+VfjrYCru3Li0g6L
 DhylsD2+3u2pvu4rJaJxgnbjY/JPgRuWfeJDnDXtpDUeDtfA9WTJ03rQTfdDorF0AJmBvgtCqwm
 snxBcq0TGliXJD9+LldivtnCfAizmFBMhNR36JQhCOclyVQp41N33kUCPhSMR1KYfhzXtwOKcLb
 MCfOZTa5zSQsQDXeeS2X8ocNFv6Bn0oo+dyEqmddYkIahLukQVBc8xJCy52RRv5Zfkjo0tlST7w
 0N+7alvrBzsKMSnnz4jG5GKBa9anwL8ymmDolOOUObnrtU4TZv4oBH4DI/RUXAfg2I/LBOyt/+/
 vWmuVBXdfMaWtVwjqPiSQ2LIRD2r
X-Received: by 2002:a05:6808:308f:b0:4b9:a8ac:480 with SMTP id
 5614622812f47-50c50f29888mr10311508b6e.30.1791816525806; 
 Mon, 12 Oct 2026 07:48:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c16755440sm11641903b6e.6.2026.10.12.07.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:48:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261009171328.2627684-1-trini@konsulko.com>
References: <20261009171328.2627684-1-trini@konsulko.com>
Subject: Re: [PATCH] labgrid-trini: Update for labgrid 26.0 support
Message-Id: <179181652465.3730607.5836351299354796661.b4-ty@konsulko.com>
Date: Mon, 12 Oct 2026 08:48:44 -0600
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

On Fri, 09 Oct 2026 11:13:28 -0600, Tom Rini wrote:

> As part of the development for labgrid 26.0, the behavior was changed[1]
> such that if you specify an environment file, all resources in it will
> be locked on acquire, not just the named place. Given that power control
> in this lab is not available in a supported regular driver, we must have
> an environment file for that. So, change to having an environment file
> per hardware device, which also means the environment file says the
> location of the coordinator.
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/main, thanks!

[1/1] labgrid-trini: Update for labgrid 26.0 support
      commit: 59437fd1c7a6a84da05efe5cefde47264f78dcbe
-- 
Tom


