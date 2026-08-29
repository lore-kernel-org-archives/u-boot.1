Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24C3C61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 12:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF1BC4073D;
	Sat, 29 Aug 2026 12:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vcgTP6VF06_o; Sat, 29 Aug 2026 12:10:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788005436;
	bh=uBgVTdRw5FzWnEk3g5x2IrNxPU/d/w5Z3mfpMK5SoG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijk9atzj/s+fONbjCznhorhde0UTcQ1+p8IUkxRYREY2KFL+hNwO6QU4mOSADyHcV
	 qMegm6VS543LexERI+CplHfCvNPF9mzTIxcq/jgQTvCMWic9AG+09uHV2NNKikbR11
	 E6F9xIW+osI2TRsQM3UH2TulAWzLiGEB4027riUmk/vOWPyOBuitgENiYKEipCrOn1
	 JaHGrnL7lXWdWv4htM6RmahHMebt1G8zKbZrSrIV6fXnlWI+RprO2trsO79mjy0Cbu
	 0aLM56rAglyYIlvSamod9I+ltebDNbO66WlNr6fuHG27Zu4DHHVgnKRGIs2MVkou6v
	 Cyc8pG4obxbYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB46640743;
	Sat, 29 Aug 2026 12:10:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC4102FD
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA04840730
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RiAwTmV5yuS for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 12:10:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=IG70rnk+
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F38474072F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:10:30 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hXDbl5w0Bz11X6;
 Sat, 29 Aug 2026 14:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1788005427;
 bh=uBgVTdRw5FzWnEk3g5x2IrNxPU/d/w5Z3mfpMK5SoG0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=IG70rnk+rbZAuI9jJSXIC+XqFEpiSDXW6XTEfHQ/sZSNtR62ZKuAjmQ7yUxsaWOQv
 46uf9IlnPgtRruK7A2Z3HJqhwC7RCyV97dANXcInyUC17JWVghO1TXhvWubYYwrOLW
 ZE6On58qAy1Z5k8Fs6wp3178uncMOQQF+ySJn0iE+l5fG9Hks/TQrOqvgSj98tCsXO
 vuclXaBOeGcvnPnmua3neGelibPu40tRao/s/vWnuvaGpKqLXoa0Zuy6O6qH3Tc50G
 WWtJOCzJBJ6b5l1BYT5Dh1aJSuoCr1EdaiWtWJIq391YaOfNitM8hasAYesymEIBg6
 Vhj8gO7bfFEVw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hXDbk4cp6zRpr; Sat, 29 Aug 2026 14:10:26 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@0leil.net, Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org, 
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
In-Reply-To: <20260813170246.110899-1-festevam@gmail.com>
References: <20260813170246.110899-1-festevam@gmail.com>
Subject: Re: [PATCH v6 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Message-Id: <178800542635.831438.14945912818502459713.b4-ty@b4>
Date: Sat, 29 Aug 2026 14:10:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

On Thu, 13 Aug 2026 14:02:43 -0300, Fabio Estevam wrote:
> Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.
> 
> This is a 128Mbit device using 64KiB sectors and supporting 4KiB
> erase, dual read and quad read, matching the other XM25QH128 variants.
> 
> Link: https://www.xmcwh.com/uploads/435/XM25QH128C.pdf
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/5c7449b185a58fe8e9e290a31401908adefc2f2a
[2/4] rockchip: rk3399: Remove ROC-PC regulator overrides
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/042b5d91747405f6d15bf32f8aa9432acc37b355
[3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/66ecacc5e4a3afa547244ce9c68937023188340a
[4/4] rockchip: roc-pc-rk3399: Enable redundant environment
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/bd9fe520badd5314558084d86e01afba34e4ef31

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

