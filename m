Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF94FC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66DB3810BA;
	Thu, 30 Jul 2026 13:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGEQiDZmVWdb; Thu, 30 Jul 2026 13:38:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A61081097
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418730;
	bh=8E3m3CYqZeKPD2UtiCHWp6qqezSeTmMpQrwCcD8yNwA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJS86wcXFMZEgmFFBmmyMk0nz8ie3nnzEuXZCXhxxWgdxhdlVncjIbipYvXkNcR9Y
	 UZsFjpfnWxS0rLt57nifUjRLGv13Zpi0JAsnO/hE0iVdByC0MiGqlzDs6g6bcX8hwx
	 8Z4z4k4vjxuptA4CF+l4BFSk97MlnxIqIII0T1y19DwLjmO9+MyoDrn8b3pmxi8k/S
	 kWybwg9OhdV55s5jwCgb/tUokjBfXqQ1FMawBaLZIT98ZcGNBs2lwRHEXQzN7S8KvJ
	 1SPuZhiADkYVLpwVTgoxh5XHX6dlvwZlb6zrmvuwegYV9SV8DTpzHK8T3eyDcE6tQc
	 RIQDwMI+7TcNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A61081097;
	Thu, 30 Jul 2026 13:38:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1B3E197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 936B240224
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5LH4w8ZNacc for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 885F7401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 885F7401A3
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 885F7401A3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:42 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6aae11ddd13so1447577eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418721; x=1786023521;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8E3m3CYqZeKPD2UtiCHWp6qqezSeTmMpQrwCcD8yNwA=;
 b=sGV4hm4q7y9/3BFAsbqL5XBIgE8ZiHwF3I+/oNFhwPacic3Vcg4AA5qPLC/4Rxq7TA
 tLamzo9EwI4g6HCX3w1TbzRERXLd/dXXnkk1BG88s866JyD5ieDVOk6AQ/GzWNSjN+Xc
 PYKXkHi2JMbqehxGi9Zoo+Id/TJ1lhdbzNdgEALVJgjDymI728Mskk0gnqHH0YO2Ji06
 tKhbqDf8RA6Z+51cvdCfknqFK5zVdlvlTVml4SwMH9iBguY5qSlNsf2LTn0hUrw/YReP
 B2ebcSvO7oXLG1Os+Wl3MFVb+X48FpLyYk1PmT0336PStPJWznZjWu3OxC0fSwuKXLyX
 TE1w==
X-Gm-Message-State: AOJu0YxwGSHItUf/HDeHDoflvQc9tPzq5Xwdy6ewN7G4pCAQStdH32s2
 J7I9cA6d7pr9k+5HUoJ0gvXuUXvDJ+aDf8ybBWAzWA1OXg1sfq+BInF5NzNV+PAPuFCRgBwfVEK
 9AWRDn8w=
X-Gm-Gg: AR+sD121PLt92TBDPOMWylA6Zu2tUBtvq7j6OQ3mL9PBvYx7RKWmM8CAW6dTKS83Pvv
 ymHqoga6khqZFUDZV1PJj+s8WKImR2tUJlYp6N3DukjLO42mW6aUpAuju9UP93BJbYugPyeEeYd
 48JVi46jQeYNwl3NwQ6nNE8HG3qqBz0jotdkRoGQVmBlA/AMHU98gVeGOpGXQAkdsq8fBuNiZNz
 Hy1/X+WJDhEI44uC0jsilVkyzwfQdsdBRW0bp4QGnfp4bDiLOqzMqI1YAxV//b2gknzhYx5rP1G
 Z5cMt7KH+GTJENJswmvpPnLJWDI3A4N4m7aPs80XoAhTHM1kBkJ83wxWdHaeQIS9/OuVX7Rvzkt
 aw1VPgP+5brxQSNaK7f7titjKTiMUpTkSKuVzqklN3mlT5PKrusty/PwOXA11k25EdpqqvgXjBA
 LQ2BsaThoHzfxIPJV/aIHggWhM6EwcOzFw6nLtkapga1JeoircNjbAiM/c1wnnKKg48K7aoff7e
 tweat3O2W+Wt41m5MxWUtSHWtkZ3XNso9v9wAxpaF0GmrCybZ3u5NzsSPFmdEF78HcJFr/slm/m
 RhmpPD+m
X-Received: by 2002:a05:6820:2914:b0:6aa:e13e:ba20 with SMTP id
 006d021491bc7-6ad024ba9c8mr51136eaf.50.1785418721570; 
 Thu, 30 Jul 2026 06:38:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <9f1c99806be7c7c07ec473eb67aa8c8fb13ea9cf.1784423836.git.daniel@makrotopia.org>
References: <9f1c99806be7c7c07ec473eb67aa8c8fb13ea9cf.1784423836.git.daniel@makrotopia.org>
Subject: Re: [PATCH] spl: atf: fix BL32 entry point for multi-segment TEE
 images
Message-Id: <178541871999.2173019.18331560823782862080.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418721; x=1786023521;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E3m3CYqZeKPD2UtiCHWp6qqezSeTmMpQrwCcD8yNwA=;
 b=e7y+9NUEeyXN1kdSEBjLSTm5qCEJYsOZIRbAAV8dKlCLSYfqj0zfYvXATM7fHCtTWk
 9ZK0SgTbP+7GsKy4LifYV78tWs5enF2gr/gOYA9MMWSiSD5QH0JQiCOyC5+pTTOQgelv
 +jDCiLPBIRAAPtHfH6oo/L7hlf2+XLW6giGYE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=e7y+9NUE
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

On Sun, 19 Jul 2026 02:51:17 +0100, Daniel Golle wrote:

> binman's split-elf operation records one FIT image node per ELF
> segment, all with os = "tee", and only the segment containing the ELF
> entry point carries an entry property. Since fdt_add_subnode() inserts
> new subnodes in front of existing ones, the /fit-images nodes end up in
> reverse recording order, so spl_fit_images_find() would return the
> *last* TEE segment and its load address was passed to BL31 as the BL32
> entry point.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] spl: atf: fix BL32 entry point for multi-segment TEE images
      commit: de61c59164e0aa1735d37db6ba0db1276e62ac61
-- 
Tom


