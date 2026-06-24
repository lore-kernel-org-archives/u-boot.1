Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C9CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC5884A04;
	Wed, 24 Jun 2026 22:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LLSHl81m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BCC849C5; Wed, 24 Jun 2026 22:49:28 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC21D8460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-491f5e6d564so8227b6e.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782334164; x=1782938964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKSoO8IPmm57aUpQeQjheGJqh6uQMODlMRC7iFXURxY=;
 b=LLSHl81m3wrVNd5R82AeBMEiQUmeryaNhWI92Nh4fpxIm9N+k+Q9svGjFNxG3ocoq+
 G1x63BOtr7cQoTxSDiOyUwaTKbs0QAdPXtrbVvNyXfwra089gQ46QDowqCQTZTg+dYm0
 kqWRxsivaE+99HOdv9H8Ll+3gFeEwRy3E1jug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782334164; x=1782938964;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uKSoO8IPmm57aUpQeQjheGJqh6uQMODlMRC7iFXURxY=;
 b=C/8YDadtTmCv/Wou7DgUkUyT5i0GQsMlTff//ZgbfHhEJqituEsTozQZiWxQ+OdO6o
 W6EVT3v7iQ2BdosW2t36cna6bStwXl8ChJm4itJ5ZhgJJD4GDRJIfZGp3PfJCiaJwZXt
 099uqce9mEUR0q+2TRHq5AkrGupmY9hjxkRqgEnVPy8TFl/wlhp06jnQnbie2QhMVoo4
 POHTx16IWi/qEffcquumv8nu5tglZ/ax3vy97VQ3GcWucS14fbjxa9p3MAzhdARiOrxw
 z9tAPYGdiUxVBabWtQW2elc3ggyIJEwpYJHQYZ4xgl1Tojhz2nwT5TE9zRTZwyHg7fMB
 U37Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8et5Tx1aAkgmIA9a2SlncCuY1FoXUR24BWp5rJHcsrYDUvAF+0/PTR1eNdVKiSIDQaieM8z+g=@lists.denx.de
X-Gm-Message-State: AOJu0YzDyq1mzVhrxGU+KdPfhwN30NnxPxxNQ9F2FHVVPAAwlYBIvrqK
 Mj+nNHVF0Bk53zU+ueiRBcpdKI987lK49GCuNYEEckRk+DhnNnw9F6vSGm27MDYGDMsP5Xgu/T1
 mLhBkWHE=
X-Gm-Gg: AfdE7cneMpuGH8ucM7aTH51e6EXm/+WkDyr5iqbjB3jr4wTNLzphMCgPcByWRkE4xXF
 bLSCKcGRxLMMsBA4UPGBb0+h45IekfTPfPiygR46gqME6zVeuXS8+Ku+KyLtDxziiPRDkWORZHP
 LYe1LEvlfHrH0N5b8a09LoW4D9/YiTPaKyX12rTeGXwtil1WobMVSteztWlfAxE6qH/1GZiojpi
 8r5H6LGf2HqBXCTDaZXNTgTyDnsqEssO3v0ilfqMi4QuFFEnc+emCwAsED+suJqbDOnmSsKR8Pg
 UV0ansKX9nAuWmoOfRfHWFI91xtxwa2BzPK3r70J3HhS+TccdClW5M8PCBcgDejTzBEgJM43lBg
 BpCtB7HKFDeZsQpB++76XciV0uzRcwNcU2sVBg7TGxehUCfBywVy0F8saA/XqBWXV9HknuI3ncQ
 uiBS5+8FhyORp+KMt+jSWOn7511fsNWTSEo2a5edi3VPYSiwnTXQMr9Eqc8slBJsWFfDouD14=
X-Received: by 2002:a05:6808:3a0e:b0:48f:c907:7a40 with SMTP id
 5614622812f47-4907719fc19mr3710986b6e.11.1782334164710; 
 Wed, 24 Jun 2026 13:49:24 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0e5e53sm9020733b6e.8.2026.06.24.13.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 13:49:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: naveen.osdev@gmail.com, u-boot@lists.denx.de, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com
In-Reply-To: <20260608154749.1190658-1-visitorckw@gmail.com>
References: <20260608154749.1190658-1-visitorckw@gmail.com>
Subject: Re: [PATCH 0/2] goldfish: Return error when device address is invalid
Message-Id: <178233416378.3662130.13824679323566573224.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 14:49:23 -0600
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

On Mon, 08 Jun 2026 15:47:47 +0000, Kuan-Wei Chiu wrote:

> A patch was submitted by Naveen for the goldfish serial driver to
> return an error immediately in of_to_plat() when dev_read_addr() fails,
> rather than deferring the failure to the probe() stage.
> 
> To maintain consistency across the goldfish driver family and better
> align with the driver model's fail fast design, this series applies the
> exact same logic to the goldfish timer and rtc drivers.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] timer: goldfish: Return error when device address is invalid
      commit: 2bc9c58e7f09e5c5383ad63f85f35b686d63c0bf
[2/2] rtc: goldfish: Return error when device address is invalid
      commit: 47e9c542ee032e89f556adc73c2aeff3acb0e5a9
-- 
Tom


