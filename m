Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F738C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 17:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9D0780C8E;
	Tue,  8 Sep 2026 17:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4xRkw6cghWi; Tue,  8 Sep 2026 17:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1BF5C80C84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788887108;
	b=puOOQB05vDWrs9EDcelbb133SEmATraczNmEv6ENWBc9GzD30nqQX/GF26v1NsaSSmXb
	 fy8J45EIhgy+RrRQkqsekWrSabYFHbVjekKm1CV3oxRS2vIH5D7S9YOuP9kzc6BPoY7AL
	 +AKz8kJL3ltmJHJdtLhCbf4p2MZDjiRgNLa5d/rZRjowiHuodeCoNfxAnAULVDWXlQmoh
	 pAWZfx8jApqOAMGqaN82XoCw/0KPTyfuOaG7L7Q3cTuzaFbE0d/dk5fVpkfBbAyh7DBUT
	 Y201qAGl99k+FF/+7SWG7QNW/SxQ4zTi3Tfk+MVJwcXFoeXaIhgklgv02mjmsbmk7jA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788887108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Db9/Adl3FO5V6XvMeaLlrCbHy2t4oou/liDyY9/QYqw=;
	b=IF7yv7Gf5zdFiAq9rpCqnxf70dSnR0UN6tJm73djYn0fGztQCq1wUSDUUbs97CmXqSmU
	 ZIeTA1KjldzDOnfOQXiIJzwHcH2bL1+V7klVaSgKv+TGKTqAqSBsCF+t5QX/BYIjkRMNA
	 rO/GzcYTm2gUKbSIng/yK+2df2r+ZLLLr9V0kFZcj7LwjFfRA+N07ghOna4AY41HrBG8r
	 N9pWQiLeuPhqLMAr6xYncxAzPitkUQqqmqxNGTmAB3jHuNRw+62hPQQFcwxU2D4rYiCp1
	 BpG7UQ2EecOdsPOXhR0vjXQg+xpTfx4lJMcWAC4G3E1X6BLZsBu87sr5Lrugv/b/XSA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788887108;
	bh=Db9/Adl3FO5V6XvMeaLlrCbHy2t4oou/liDyY9/QYqw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rbc0z7VN3bKv4Xn9TXItzpkLTgMUjbOZpt2QZVho9KS/sGGMbvLulj9CB8jzE0sQd
	 Qf4TTjxQWFSFnyN9Chl62WvF+V9Fh/WMgLQLJlqz+7uKgeJ206eXx7v1N3b7rxFYaK
	 tJWtn9tZoE7+mvk4Yx/yoWgb2tvE1V9ti/kVsYcIbvFcj2ngxoYdkNCBKRMfm7eRty
	 mohWC6KI9O6eY7PH04AYKiT3U4jsYnXK/BKEmiv1XBBwEs+UcRbLxhPL9gpQtZxPNw
	 VqY+eN87V+7euTKlLrqDGpWBi2T7Tf+pIg49Cr4I5Jmtjs7CjzGvzXVaY9Kd5nTrS+
	 Y0jhrFktC8d2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BF5C80C84;
	Tue,  8 Sep 2026 17:05:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29D874CC
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F8396072D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHALBcNT63dh for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 17:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 316C860724
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788887105;
 b=b2HJVf/BN6Tvoy0YI+FuP1k6vVzl8BDU1mbA8y6WdBVhJsYlZbCwuEjmSz7vIl5ltgis
 Pso7hB5zmwadiG0Pl4yrfpvq91gbTlFRz0qMyq7zYeUo0w+Kpu+7PavFTWcrE71DYKaNf
 PQMadn8e8FiESemlNhHWz7f7Mf3DSsTSvNiV6Hbd/5gzdllPnIDsjkiynWoycwbtFSUmF
 c9GehwEs6PrYkv7OYIvl9q5cmLXZ/ChuacmUBQTy+hEo+89bXOEY3UNfh/fukCoynq8mL
 n+iIr35xHEHiycggegHcG5k4uC37vkmCuz6mGtIWUh24YFXWDov7rcKGn2vTn1e8CRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788887105;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Db9/Adl3FO5V6XvMeaLlrCbHy2t4oou/liDyY9/QYqw=;
 b=XKpnL/CYh4TVaUZVQ75CEYqAtvpgnLDuDWk0iXhMff/fdTrbcI7arD3Af34yWL5o1TTU
 f+5Z/8fBbBB+ojQbPd5tCS65HElBiq8rZ8GsmxC4cWTt6lzVORjQcM8rj2PtICkLVCmXT
 1nFsHUbEWu6Ohr63KkrN+V7Ddb1QczeCxZHhH8XV1ttXGbyKFkltkl4D7aIakDDh+0Q6M
 RhZuj5xORd5SIfmHxsk1kL1VgEXkznFmXVak1zMs4vTfZ8/yeNpz0QZOAK6/GV0Wx1tLW
 +5s6G1e1Ve1sVSWroGcO9+z4ono8TwkLkpdNlnEYdCX6FXxHutVFoA4YLUGFCgIuqHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Idk/VNuJ"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Idk/VNuJ
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 316C860724
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:04 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso48215465e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788887103; x=1789491903;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Db9/Adl3FO5V6XvMeaLlrCbHy2t4oou/liDyY9/QYqw=;
 b=Idk/VNuJDsy/1m8iGpu2vyNrPjO1ZWCbEGUe8DMDiJWqrpDgKxwrbHVx8pZKPmRESj
 uII9XbM1bBkOTjGADiJCo+6Q/BEMEUEKLzORkrjyLP/vDRJZ+etKex2a/20GG+wWBZ/D
 i+VHJlXnwT69qqVwNebbvorjTMt1omykyuBgarH2Poi2eNtHWhqskPXD/VlPps2cQrKf
 UDFKiag5FfY8v1xo0RUhatFk917WNnmRE4S5FhpHqt5U3upUSFcuhUyepsusbSD6rdGL
 NbX6WHh4BLZJyP5THteHfHSuu7qzQ4+GrkoXQXPyIH3O6Rrbnf2NOaRUszVZNEu1fg2O
 qQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788887103; x=1789491903;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Db9/Adl3FO5V6XvMeaLlrCbHy2t4oou/liDyY9/QYqw=;
 b=l8yBaDKGXki4ladryB4isKNuXJ16u0+pPvy1//BzHKMNQa1fHG2xwCEYmxL5MfL4rt
 HDQznqnTo5okAeZ4FnOk2/a5MldhToUa9YzYWspYFZkO6ZbOUtGiCKNXSceAIuJ61Mj4
 rMN/ilZcQMKWD6ucmYmdhTB9z6xUhinqheu+Q43qLkHbnb2rR6QmAcaibY3VFQ/b+B9D
 5eiZNMlE712cdazr3ueWFh8ygIRMH1HrC8/6fHTD77pItSncwRQrkw9lcA6aObfGD9qi
 b1cwuY04XSt0OLMNW5Z6ZzZp73/j+h84C5YQIBcqB2BPK6cthBVb4JKMMWyR2MraLx75
 yzQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj3In/JN8Hj1UOQAAiZW3d4Kt0oYzLD1PKcfhdBnVi7OMfTmpn18nDBn52cKCALom9m1j3D1U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kX7SLWjxUKLQPp5iMYh7sA4BKPRqSn2rcfBCsJ0RcrBqVZBGab
 kWF5LoQ5kjZcR2i/c4nCLWFszTVmmMTD07w817GPZa04MyzMjNOvkDey
X-Gm-Gg: AYBFou1wsPhnqUrMVbjb/WmbI3jPtHpWbix6bZ/ggaCLXahlU4kewpd/2OuvVlWUFr3
 e2/gBY7pYgSmn8PFe+/q7mn9D900LGGb36S1bIFt+pvmbBZEkoqgiU6UJvLfgTGzNZSDCLhPld3
 hWO7XjOZeBFw6C0RkgUCMGUJmRKupM51rJZwOVfmvQL2oGkQvqg4FgaEHzBfMuOY9r6HLl36cj0
 SY5Lfy7MtrTv94VLvE7PZEMuQ/igIyu3LXbSsDqdkDdUl9YNv0m2FN1ga2mcaIyeFo0FivOo1wr
 dEnADFPj8pCbriKyv8AGiECfAYCTg6LsncK6PzI8mWFUKlAMOcndyYXguZH9/0VG7jybMaKWC8Q
 Ig1zgDVLvmH2GsyrYnan7a09F+yLnptbtwTUNN3Jcx66bgg+SRnbFNBX7hUV5tfUcw6FSHZMwJH
 PuCDGAvNl9hLnbeq6/kSqmjJG6twbP870eVxzFRRiw3HJUFK4KNVHj+Xaepk3lUAbEX1MH95A=
X-Received: by 2002:a05:600c:5247:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-49cf81dadcamr282883965e9.2.1788887102606; 
 Tue, 08 Sep 2026 10:05:02 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.150.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm306863755e9.0.2026.09.08.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:05:02 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/2] Avoid needless CONFIG_TPL_BUILD checks for U-Boot
 proper build
Date: Tue, 08 Sep 2026 19:04:58 +0200
Message-Id: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpAoGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwML3YqCHF2LZOPUVMM0Y1MTy1QloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AV2quuGcAAAA=
X-Change-ID: 20260908-xpl-8c3ee1f3549e
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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

Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
that CONFIG_TPL_BUILD is not set either, making its check needless.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (2):
      arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD check
      drivers: Skip needless CONFIG_TPL_BUILD check

 arch/arm/mach-rockchip/Makefile | 2 +-
 drivers/Makefile                | 2 +-
 drivers/bus/Makefile            | 2 +-
 drivers/mtd/Makefile            | 2 +-
 drivers/mtd/nand/Makefile       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
change-id: 20260908-xpl-8c3ee1f3549e

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

