Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08268C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9F2F80C04;
	Tue, 15 Sep 2026 20:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyHYFesZbOVI; Tue, 15 Sep 2026 20:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1BD0C80ADA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504540;
	b=sh0qH4tLQ5g9NcJWHtqXbsQN+cOY4AEJAqKZWZaXxqmJk7MEdVy9N/YC2jEt2Srut4zg
	 wJ9R4Cn0glZ5JWeHxM+HUSuuCvqn7SVeFKdbNIgYLzTVYuM5eHoWKTET9aUltUMNH9du0
	 QVAsmYks2Npqmm9Tsa9ETltrMkDGphGkQl5mGwKJ1V4Yj6fgNmxa3m2bhfvnbCHYKRQfj
	 A3eBAFuEjcIgU8+0I76Be50EclWSsOFi+2rLrjr8VRTXfFAK+JVN2CKLoANJNk57LXgLK
	 h/6OIu9rW7OL6f2VrKTQmy0x1KBVRHymTXb3OrhN4baaK+NeKeAA7hbJNroU1l3J8+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504540;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YpWZUaudei7Xnesc1Fm8/s7STaGXxljcn59ExktqrR0=;
	b=bMcxGPF67K21tg1BXL9TdE3BN1gbZqunXnNpk/6EAYWCQIrVlvrEB90K2qk/V2QlOcFr
	 CD8l6dQddd/pIA7hFwq3QOq2gj5719eoqsUyVDJqldoyFyEnQbOmeB3Iwj98jn710Fk5+
	 cDmjVZB1LvgviwmC2eF2+bl1J38/ter5oMwCDDgG7IsbX95uhp+2uahaj1mB/BP05ESEb
	 0eHLt9mgm12AYQZtXSlYyghix0GSpg3/x+r/AQVl3iKB4GxhOrr7VmdF/wtj4Sx3X3zL+
	 cGz9W2c+CHpaCTddTdgk3sdnFmY4+8eI+y5A5cQ4xCoSI3Mi3nRkeWARpwfIH0ObR4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504540;
	bh=YpWZUaudei7Xnesc1Fm8/s7STaGXxljcn59ExktqrR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RhzHYcEClMqyrtMqh0keqo1zTnIRebM26qVACn+HEsl2N9Us6usOmMQzV7IhG9FIG
	 qt3Cvk3fc/J8uIBHl615RlggGklvec9srrfBFe/2AqEu5C8Ro0gHf0i16L7RGs8f/l
	 jrnzATp7a9GIbtKt3a7+4OImGFZaY4DDpfW1SyYkBY/cpTrmJ7Ulmg6oP0SmK5k6xr
	 2rPmqOPjGt9QjPXKaTC9rh4ePNPHkF95vnVRivpMjUaAnZ4+QPCKRjK9frgph/8G2n
	 7aUA/5bEJbd4ybGDux7vfWTw+huKudh2oDYJndfZviqQRq3Cyqi6mml10yO7LqQ3KJ
	 X07FnducCfdAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BD0C80ADA;
	Tue, 15 Sep 2026 20:35:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A9E02E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0134E6060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Eutk66zCQet for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6235A6061B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504528;
 b=mOdBfR175i5YnYdq+VI6AHw9uwqGA37GmIo/qfJxP6brkNIfhQURYl/zMqQaJPAi8wT0
 z+OQfZSeUMdVl0iUnwNfxEGyHKJb+76R3YcK9TyJVWJwFumeQkdNGIoypMoX4YCkOLCQJ
 3DZOl5n/yo5EejKGkqzBB6dfvYfVEeB+R5PXcwXDPzEf6bR3y3NCHKC5a54wAg5YX6PSz
 Prm2gQVaenqE3CE0U4cOj6/Mxqpu5CSDxry2kN45KPfp7GSfi7aeAZ1C70qREirDv0S8Z
 PEX/DaJk7wiSwaBU6AmZNuyy+LASTrLk/8zizC3H5sd+uAMefG/sltujuR/d2FM5qTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=YpWZUaudei7Xnesc1Fm8/s7STaGXxljcn59ExktqrR0=;
 b=llIztywGWLTKnykAiImw3JCwxe+/yfp9jMTqTQysquM89KfCw9X5ZCvH5cQvziYtPLdn
 PJZqTnSNqI+18yNhv3S0qjwdTCdun3qy0OiPcHf7H1HelEbmLMZZi8CPa0MLyKCtgHAEM
 u65U8L0M7ry2+ynZxnYoa0B1IU/4VA3qzO7maSR6WNpeljRXC8TioB0vyP7V9BqrJ6Ibn
 Sv0trrWYM0Fl60LNkpH1aguXfbtFcJP2gAPHI0Hd4N3xRaozryLhCgnD190l1Kn0l+eHB
 v+XVn/uMzIocRw4ItK/F+lZ0EYZQdDroBZg4igP5LOub8/rfC8Kx/hTaFlyXbJ41Vuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=B7Ier14y; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=B7Ier14y
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6235A6061B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a3688a2so228812b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504527; x=1790109327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YpWZUaudei7Xnesc1Fm8/s7STaGXxljcn59ExktqrR0=;
 b=B7Ier14y0OOPnBCVbOi9Jk8Ui+0FIstuIiSifizWCvfHSBSKIx2v3Ir5hj58HeoNLq
 wncUEI/4bN4d0oW96RyxymXYT9Cb9d+yvr0iZ3ZGE8Blvns1s4/m4iO9QX3a4TcV7Br+
 +XcwVAYWzrigEwh+WaPbZTb7DrRKhmLXoZYGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504527; x=1790109327;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YpWZUaudei7Xnesc1Fm8/s7STaGXxljcn59ExktqrR0=;
 b=J6p1BATJYMLNaz10QyKKFz7ZnUCfe/D2gcZac7rmoKiS4HY+1SPVbzdVaNRBISRzeh
 AEdD3ATrS0cmgWoE2Sww1UxwZtyrukYbJDnliND1CgA0bn96S8sESqA0E+HGFQRDR6vo
 pczAAxsOyxhkwy0R0flUcW395Jjkjiv6hkg2pdshs+s09BmUyCVUJFimjhlQljM+YHVF
 R/iGTzY1XoNapjawpMpRNSsTZk7UlXB2xL0MNC7tqyRVaG2VW3mo1RUnnIrkUKDbegcf
 UI94Xcqo/LKpMYA4RWGtYFuLLdS4w3BaL76g2EbbcO7w0Dbgs7UlPqsGRTdLA/AnWX/F
 yOlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxZzaxVFRc4rwbI5u31ISLwV+ZPKQExvTeOfgmZU6v1AWSIBaEjYe38le1y+/2FboeV46lenw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lW5cu6hV/4ZwKzqh9AfBLkMkbUU164RjbAUuBBHPCnOp2d0FKx
 hzfmiduxdr7F9Qja4dx7NHhzaljDBEkOeI17I99ORuSATJT/PkozpDQ6H+U2Ylb03SMMUBxw8f5
 oYFYjJqr2FfT/
X-Gm-Gg: AYBFou0yz9Dob0r8xq2gO7tpry2UHSad1ovKnXy7aG6tokJyI5Fl7G/tqGQh1VKM/Cg
 sEWJmhtze1nsIUIB+E+HxyTXgzVAcz3pA6HVP2/M9M6tr0r4MAZaBNnTKcjnP8jYTgh6XQIRRXW
 ruxzohBIg7e8/lkfo54IrdLEU5TjuY/9hgi4fOXBzADK5D/eF49ugjbjU8A9TTxi8CUvLExGJWi
 fFt5U6sBYn0U8cJbd5tjHqPdDVzLbNv9o4gfEVehLO1sON1mwZuvN72vfeGqK7IebtxqNS5l/AV
 CCCHLeqmekziKNib5JO6r7MmHcehT8TF88dZKrCqlTFB2VKni3rWDTt9ba8FC+nITv0DS0ro0Fm
 5eCLDzWXHbWlp+8QPaC0YNFZ0vQjOsUe2HTePiymPQvG1MywWs+IM8K6ddt+0S9aLHvCLZpI3kb
 Qra1ChZ3/kS+up/nRJvEYFw4lTfw527KtqrJUa/lKc+dzxQfihYrUrYx4NXGxUgR4RfAAWUOGVI
 GvoUYmMFye7itUJviODiykLzsyBZRMOntmfEkevWWcARLfZAU0P0cYQ+JHTnr+/V5dAXSpg7ai9
 iuXMS8TQAeBGTP8cpVw=
X-Received: by 2002:a05:6808:1706:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4ca4a6f0233mr41556b6e.16.1789504527485; 
 Tue, 15 Sep 2026 13:35:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 dlechner@baylibre.com
In-Reply-To: <20260901-stdio-splash-fix-bmp-guard-v1-1-78e2e75ae441@baylibre.com>
References: <20260901-stdio-splash-fix-bmp-guard-v1-1-78e2e75ae441@baylibre.com>
Subject: Re: [PATCH] stdio: gate splash_display() on CONFIG_BMP instead of
 CONFIG_CMD_BMP
Message-Id: <178950452636.931545.14628231053886686795.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:26 -0600
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

On Tue, 01 Sep 2026 17:24:51 +0200, Julien Stephan wrote:

> stdio_add_devices() calls splash_display() only when CONFIG_CMD_BMP is
> enabled. However splash_display() depends on the BMP display support
> selected by CONFIG_BMP, not on the "bmp" command (CONFIG_CMD_BMP).
> 
> As a result the boot splash is not shown when BMP display support is
> enabled without the bmp command. Gate the call on CONFIG_BMP instead.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] stdio: gate splash_display() on CONFIG_BMP instead of CONFIG_CMD_BMP
      commit: 1fa5c98b4adff76ab3f68ceafaf4825497342f34
-- 
Tom


