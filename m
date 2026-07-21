Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2083C44532
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 15:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D21140939;
	Tue, 21 Jul 2026 15:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kVkdHEIbNtM; Tue, 21 Jul 2026 15:04:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 678A6406DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784646260;
	bh=ax6YO2cQv8sPspJQ1nffHAJ9yBPIsKtewFhF1YrehRs=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=U7+Rwwenv83bs/46mu0TBSESFs7I9wXo6uv2gZiUdgRJRZQa8f/c8Yp4mrFxcUJtd
	 +//O2XmDAzjF15BR+U0BKK9AOiA1IfvN1ALUgmeX0gGxSKVoTtIzsfO5yqKdDXO4o1
	 K4Ox7y1zfpqzKr+PB6UbacvhObrl9fu04dDBTo8sZ1PsVrVeynkfmLpS62vUoiM3Y7
	 3jZDazLo4+bdo3xewVgv/EQiLCXK5y9FICJClg3gATnvBu79ApQc9VanbApdq7soih
	 uwSrj6ZM0O9kAqRkxAqCYG8zpXgHR6RC8jfeZ4kMbJDSmf06Ih1Qh2ZJav7uYwNFXj
	 lMxViH/mLQkvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 678A6406DB;
	Tue, 21 Jul 2026 15:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20B401099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:04:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06E676084A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t80UdENj7FPs for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 15:04:18 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E187260843
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E187260843
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E187260843
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 15:04:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A0B846A4; Tue, 21 Jul 2026 17:04:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D23803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 17:04:13 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93AF5414B7;
 Tue, 21 Jul 2026 15:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C5E1F00ADE;
 Tue, 21 Jul 2026 15:04:10 +0000 (UTC)
To: Alexey Charkov <alchark@flipper.net>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Safae Ouajih <souajih@baylibre.com>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexey Charkov
 <alchark@flipper.net>
Subject: Re: [PATCH] boot: android: fix out-of-bounds access in bootconfig
 parsing
In-Reply-To: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
References: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
Date: Tue, 21 Jul 2026 17:04:09 +0200
Message-ID: <87se5cidue.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784646251;
 bh=ax6YO2cQv8sPspJQ1nffHAJ9yBPIsKtewFhF1YrehRs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=IR5WA8YbzCyQ+fJWXusf439gcg9/uoFjhGeu6n5eMzS9w5Kr6q1KAORl2lmpdho4r
 OrtMREoAWdZh9kawtXF4J2zZ6ahMC0WJyYg5j3Q5AiNxslzl/AOyLPFK4LyJ8Yxiaq
 FGIzdIXltnKnGR1MbY5sS9edd6+qR+uvFvHF2NCo3G97kAtR1SRpiJToRw+xxTbcI1
 M7bcMaFEZ+/u/W3y/eHnW5fk9lEI18JHkObDy+XPXRgwt5IitNGCfQJ5bZPfjd1V6k
 Txvdq0DiJTwGOMgJ6TkP46pimczq7zOuWh8O8xSd6GL7i9gB1IFJ1yUG8xgynDszXM
 0ODHdy/4g/Kzw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IR5WA8Yb
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="IR5WA8Yb"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

Thank you for the patch.

On Wed, Jul 08, 2026 at 21:32, Alexey Charkov <alchark@flipper.net> wrote:

> When android_image_get_vendor_bootimg_size is called, its buffer is only
> allocated with enough space for the bootconfig header, but the
> android_vendor_boot_image_v3_v4_parse_hdr helper attempts to append a
> bootconfig trailer to it, causing an out-of-bounds access and heap
> corruption in some cases (e.g. triggered in sandbox test builds when
> extra bootmeths are added, resulting in a segfault of the sandbox
> process).
>
> Skip the dangerous memcpy operations altogether when the
> android_vendor_boot_image_v3_v4_parse_hdr helper is only called for size
> calculation purposes, and only append the bootconfig trailer when called
> from the actual bootconfig parsing code path.
>
> Fixes: 57e405e1f474 ("android: boot: support bootconfig")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
