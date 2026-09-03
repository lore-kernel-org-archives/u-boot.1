Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121AFC624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D22EE40ADB;
	Thu,  3 Sep 2026 14:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIXsJAxSTeOE; Thu,  3 Sep 2026 14:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5A1740AC8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788444006;
	b=Zri2bnzCovoE8psw9sx7aoTUy5KjumJrlhVE30GBzGpb48i/hNEDhRNyKAibMExzs6EA
	 WZpeWdUOt+8GMw3vxyno8tBhi8UMLRWhZnTN4FEu2jz2WXo0MBoOhg8rJVXIMrHg0Rh7R
	 Fgxdzgig2qhbMjUn0ytjWlE9gAuylGeSu+5yKI8k5jB9pF8UH8lb+kK6OP0Op5SJRL4Th
	 aaJtu9qzySBOqz7AcxRoc3/JhwRCkeMES5Db70Hf4wUotS3FH0TCvbpJsQ3zUgqfnj+Q0
	 WzDlTJTpCEcATjiorNvEMd66iu1nHquns7WX7RUV+G6Xiz7vWDLup0j5/uxXdWQXXFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788444006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T/6GYNEHSbNFgjemPKu3S/DOOWGxGm1KzhZLfNlcj1g=;
	b=fP29K/xNRFpTUrZb7m4cCVgL5V77i9wKVIQ1XigFpScoRZyES4xGf9UfbRUPx0bQ728a
	 MHvi00zXOy8rIYi1TE3/RPpHaYIpBnHHQhktB3oY4jjeWUpMCzonXqTlinTaEwdkjU85C
	 RM6geIR3dGPFr3tasxXVmWAyOrW6rcsnN8cJP6Y+eMyak5CcHcw1TmfwmpLsFIaH2p0EY
	 QXL7UzzPv2xqw9UoTu0Cn5E2RRs+brSiHjiJOwRKCY5wzM5tkgAfX3FzH/T3GOGk7nfFK
	 TPIFCzi/uF8+6lz60VdeHUTA/QovV/WWzA3pKeOh0i3WC/xrmoCoDfvu4ButzKT3+Ow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EdzLMOCL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788444006;
	bh=T/6GYNEHSbNFgjemPKu3S/DOOWGxGm1KzhZLfNlcj1g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D3cHjG/dG6ZEK9kq58iDGq6SgaFYSao29m+3DhUwCH2TQQLLsg3spO5bW/DNcTIjj
	 cCiMoowZpGu47sEOgpv7Z6pwrSBLTP5tOHNiCGIHQcG6g7qU1hAFfChRJ+doPAtfXU
	 5AJ1nwPZxvjUyWzSnBICJj7KTtHz3Y7o+ODTIR3d+6eML6ZcE7DDf04ZfWLDW94JSX
	 UODiktiC6/5MxZEI0DuvFpQR/CR7NmO3hP2m0bnI50T4N8ACkD/hJ58ylp7RubE4UU
	 Tx/fIrJi2ZAVCepU6ZRwFREjvP9gMRUq3Wi51iQIONozcQK9iTX6i0SYKhW5I6Jhe0
	 q1nPic3tHBRWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5A1740AC8;
	Thu,  3 Sep 2026 14:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7931E22F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F8F640ACE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6EUId1wkEz8A for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:00:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 873A540A6F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788444000;
 b=oicETnHBff1OlAs+nUWfVfeb96Xsx2qXM+JgAcWurXFU1SK3AhSTsFQD8XMVA/Jb2i7w
 Z2X9tjr/47724h+1/tV8K3TZ2PqACIf+jQ/K5hyiaFAaW5WQvy2wNbpw2KHrBeQBBAAJD
 smeh8I3ys2SPzM3mSvIJ84VfIUBSanmGuNgi/hy5egxj02XXHLzMDyi7hLffzwt+VjayM
 JSnigQkUdv22GCAf/CNYMTBEv0ZXcs0Rgbrhw/imHCF1wHuxGPo28MC5eciTX9B43/QbG
 Soaw2BFuHhh7UJ98LG7Tjaw8oQkDchqK0Zj26K0l+3s1g25yEBG7yl8lTcXJiCmMYfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788444000;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=T/6GYNEHSbNFgjemPKu3S/DOOWGxGm1KzhZLfNlcj1g=;
 b=Gu2G3lB/Ve+TK8rlPF1dQwXA731jQCfnzub3t8woBuAEdgijykDNzz++0FB0gJcHtaZO
 PN9siG3Nhp2RCz7QO8rRqP+uaYejKFbg596xsA/go6Ldtq1GBjrziRMAJRFjEIK/ClGRf
 H9G7rQLrAHmgVGdErESI/bawAmrtS1DCTDP++2X3VsiHkk6rhlB/VC/w/k+XUyrmR0s+q
 QZFdoXNTcjqvBmP1daehBbvw0g2mkfBlf5jtRh1oDc5Sz/KoOwZ6ZD5fsROmHfYl5fISo
 XK/sfjdFdyaQz1JiAfvR7h8GAuqNFXftPok7M2tnAMkXcwSrjfb3w0me7Brj7lxPsUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EdzLMOCL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EdzLMOCL
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 873A540A6F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:59:57 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so15943365e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443995; x=1789048795;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T/6GYNEHSbNFgjemPKu3S/DOOWGxGm1KzhZLfNlcj1g=;
 b=EdzLMOCLgHDAK4NrksRZ2ZJNv3/2bKVyjlF9J5k/8AFXLBppH2UWiq233ot7ee1MeY
 BChJ5V5yvNI6djIzeNx/c5CY9/pUrPA/rW5KJzG/2uOAjLsjqS7gnUY/w+w1XgcDUaxS
 MJ2b/bEP0WGShhmzPWvZQeB3Kh7oLsO8zFqlujIS9YutgL9gc33GtJv3h2BHquBdc4+o
 ya82H5z10m5TJxAnKzOek/GAZmAjXqO/PqTezn34QGFjNOR5Ar3idfLezlNYc2MyQFjE
 gdhSUXzYLI2Td/CBl6t6pdhYnqntZsjBaqLvkEGYCy+BuuCEwsgCJPO/npLxhLRQeSHC
 RmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443995; x=1789048795;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T/6GYNEHSbNFgjemPKu3S/DOOWGxGm1KzhZLfNlcj1g=;
 b=djz+SwvebyHxud/eMKnuaI9wO1JOTVhSywv9sUmIiYEpYHSZYZyQXIj/+EbTNXdvS3
 LlXI25J9q+95LihAIvqTvX+J3Rezc10+OmMd/BXOCGeFITb9lqUymeIi+qKOalDsOzOB
 r9/G2EnpR4KR7+9aYqnXYgyYbEWuCuoK4uO8Fi2SFPv22F1Lee1/4pvR9f5GT0THegOF
 bKW+qApBv23Qlbmz5mBA+vNxwVSxrxdo3sNcL+5l7AMk7RXVHHAOagNW9kosXois3ZQq
 4jDSr9jUm5RXrVuMeo3B747A6NbwdgKzNEXS1e7620EXAflQMQu2wL4F819y9Po02cGQ
 +JoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD1PChj2SHTGONbpat8fOy/kHA6refTjY2xKkiQ8W4ngA375tL5ov+wh6a5x/wpT4zdM046jk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kfssw/p/a9oYtSvNRV6QRBswni9gdkEwkQIkmQQIkXm7t7+cVc
 yLppvfZqA1dY6FlsMqRs3u9CxLYAfzybC6UzKsQGTRjSlh0KG8uRvd4jaNlSh49C0AM=
X-Gm-Gg: AYBFou1YAUWosPRgeuy7RJZwslqLT5qwIQT45fQ7uXtAaRvSM/OP2vrLg6I3lD/a5wG
 2LVwotl3ibBcAzye9RgV9sxHCprawRyA53A7v4jFSY0//eYDR+ybCm0Z3yYYkOErND1BDSdHkj4
 wdEutPtusOtpXuBcsvqHL5kRp3gxw7+cH0+bWlgZByZWa9rDjh2/rUfhZmJfeZn66NhZ5NI9Zl5
 VXd/PNtn5htgSEEhwEwjeXyLYBEAptPiwF5bia9KnLcHbnLlSv/1KXipkfLKPr5ySfnM8rpkIb7
 FR6l72Ej84ZwiYI7ykxCC73kYwUhIS4d7NCM4XvLUlkQVt8UDbSIFPzxyYUVlAUbLUdnMk4MlqI
 k07qsxcJ+D2JQwXVzncVPOrtm8iTizPgVpQQAmMeVRpFmsELZR9mwMoKvbOTWUkbSly/MUwfqRS
 elkghI7oXtpooPrfgWqL6JC2wpT5gcw23zunW8WXc4C/n53hzD06WOz4qJMSk966imhdvnPtN8S
 GdK5UZ2G7cxMTO2BYRyIziV0tN1EJxsU79UD3+suFy+F+PGsQJSmkCfuUqm/rqI9TkZruX2mZ93
 sXNL4v+MiosrQ6r6qCfHhbJ5aEVPNNEfN/nB8pUrYaS0fnzmoVvKO1aY
X-Received: by 2002:a05:600c:1e0a:b0:49c:f518:252d with SMTP id
 5b1f17b1804b1-49cf5182689mr39859525e9.14.1788443972569; 
 Thu, 03 Sep 2026 06:59:32 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm74213505e9.4.2026.09.03.06.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:59:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] video: fix build with VIDEO && !VIDEO_LOGO
Date: Thu, 03 Sep 2026 15:59:33 +0200
Message-Id: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/62OQQ6CMBREr0K69puCWsSV9zAsaPsL3yA1bakSw
 t0tuHLv8k0m82ZmHh2hZ5dsZg4jebJDgmKXMdU1Q4tAOjEreCF4xXMw9AY5Uq/hRaEDZQdDLUT
 SaFMefoPethY0+Ub2qMGchDFGCXFEyZLg6TCtbfJb/WU/yjuqsBrXRkc+WDdt72K+9v5yJObAo
 dLqzPWBl2XFr7KZepIO98o+WL0syweApL9nGQEAAA==
X-Change-ID: 20260901-fix-build-with-config-video-but-config-video-logo-disabled-f56fffc664eb
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

While enabling a splash screen I enabled SPLASH_SCREEN which
automatically disable CONFIG_VIDEO_LOGO (while keeping CONFIG_VIDEO))
and hit a link failure:

  video-uclass.o: in function `video_get_u_boot_logo':
  video-uclass.c:593: undefined reference to `__splash_u_boot_logo_begin'

The __splash_u_boot_logo_begin/_end symbols come from u_boot_logo.bmp.o,
which is only built when CONFIG_VIDEO_LOGO is set, but
video_get_u_boot_logo() references them unconditionally.

Downstream just worked around this by unsetting EXPO, which is the only
caller of video_get_u_boot_logo, but that's not a real fix, so patch 2
guards video_get_u_boot_logo() (and adds a NULL-returning stub) so VIDEO
without VIDEO_LOGO builds.

While at it, patch 1 also fixes show_splash(), which computed the
video_bmp_display() return value but never propagated it. It is a single
video_bmp_display() call with a single caller, so patch 1 simply drops
the helper and inlines it into video_post_probe(), taking the logo from
video_get_u_boot_logo(). This has the nice side effect of leaving
video_get_u_boot_logo() as the only remaining user of the logo symbols.
Since the return value was discarded, failing to draw the logo never
aborted the boot: patch 1 keeps that behaviour and only adds a debug
message.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- patch 1: instead of propagating the video_bmp_display() return value,
  remove show_splash() altogether and call video_bmp_display() directly
  from video_post_probe(), keeping the previous behaviour on failure and
  only logging a debug message
- patch 2: only guard the splash symbol declaration and
  video_get_u_boot_logo(), and keep the runtime
  if (CONFIG_IS_ENABLED(VIDEO_LOGO)) check in video_post_probe() instead
  of turning it into a #if
- Link to v1: https://patch.msgid.link/20260901-fix-build-with-config-video-but-config-video-logo-disabled-v1-0-9dc80d307790@baylibre.com

To: u-boot@lists.u-boot-project.org
To: Simon Glass <sjg@chromium.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>

---
Julien Stephan (2):
      video: remove show_splash()
      video: fix build with CONFIG_VIDEO && !CONFIG_VIDEO_LOGO

 drivers/video/video-uclass.c | 22 +++++++---------------
 include/video.h              |  9 ++++++++-
 2 files changed, 15 insertions(+), 16 deletions(-)
---
base-commit: cd5bd0cb98ececd1e2eb69d0093e4940b25c9941
change-id: 20260901-fix-build-with-config-video-but-config-video-logo-disabled-f56fffc664eb

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

