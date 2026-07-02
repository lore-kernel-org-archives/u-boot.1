Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE07C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B5C84A27;
	Thu,  2 Jul 2026 16:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="LZxUwPNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDF984A29; Thu,  2 Jul 2026 16:04:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C700D849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso1790650f8f.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783001073; x=1783605873; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gCf2cU78PaeOSUEjPjTdw8yrG+xWjfLZxe8hcd/gDw0=;
 b=LZxUwPNsz9eeJUEMkInILfiu4HXemG/HoAgw3ESR9MirzSQHVpPdh+kmY7LBXTt3qf
 zuMv38Vdt2dFrELx7qZ2PDcgogcJ9RKesgprOD2g8ljsnfYHdXKJk6KEOsl2SCcyZCfl
 ah112Z3Xbl9u15h3m1IVbXCswlR+NZotrZsYhbFjh5tuuIs9fto7UpyBjoWxi8EMisdm
 ySaGlI4mEDAi7S/SNkvegFRauB11NT9akutJ8+etaLjvVIlxC987Is4tS61Ka+S/IufO
 SJPUdr4UwI7xkRsO2/iAWWHEnx+qrH99IkHx/XrtMnLWTNti5e7d3YrC38aHoX+zpTAm
 X2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783001073; x=1783605873;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCf2cU78PaeOSUEjPjTdw8yrG+xWjfLZxe8hcd/gDw0=;
 b=tN4wxpc70loschFQCcUdvxf2C+ChfGpuUS26pBoIeB2Rk5SLMq/SFn+4Lh07xRAIkG
 w0g9W74Rf7Smrf0tKptdRfgyWXCTOLmZTfFzKCF1Z+vfhZPsBNudyoBT0bqQoKS2XG0h
 LF3Ved0eBvBWDfvhYQ3Dsz23IEzvCuGrW0s3lg82p2oQrkoH1+YgzPuJ6Uq3UZfNiF49
 HqkjLs35s7rUggzyd6pG/1VWf+GL2pq8983CDUuTSyMn9SYsvfSJk6iW6nodyOGM56aY
 K/UNm49WwSMKYgBGLxh6DnBKLjlgP18OD8W0ae0jA+/ygU1tnVsY8p69tujFf6geMQWj
 jFeg==
X-Gm-Message-State: AOJu0YxeaiCvImQJts3GjZuy5xMMxxkabHtbqXy6ccIGzkuSRlhwJqD4
 EHXcVSYqKLiQ8wEat8QB3cr4h33mXS2d+7Yxt7S+hDG0H4ipFw6Sa7vM6nZ1H8Cwf6s=
X-Gm-Gg: AfdE7clnlywz4CxmAZ3x5Ke47t1HVBn2Ayno81V/tdfgQnv0MrjjeUt6OpfbrQkVu4r
 onmD2FLdEzy9xm9zBKmH6J7uTF/MbR1bx18Bf6ALh1eInMltrimvhjndKEYwIrOkXPoGi8B1dT8
 0VcSZtjVLBYWVMqGjJmEwtaP2bzZuRlAvy77GceVwK9TBmbXhjpcjdbfU18NkWRFDmwDcYqhW7s
 AHRauxtqscYJybb4x7nf++cfiesYf6Mn2ZtullvGE2cjjpdr0g31t9bzgMIrtrklxsVUTmWqBY6
 NcMIBkU/ja2AMXTMbqMeN3QpuJ+StqFSuGANRgzJ9gP9ZCQPL8Cx4P0Ex+ER1ZQL/HdsunUVfyA
 WAIezMeUay4moqADBjnMjHujtM+GAIwWAmNTOp8Lk8GAL0f6urpYFubm2VMxTq2/SlkEUiDzN7u
 Stk1syFF1DYoPWYKg72urVtqSYAmWnRQ7w0U4lCkq3Y83/T76FZatTITFWIEcc43kb5B7u3JQA4
 7B1l8MD8tTOwwAecK850/Zg1s2bDfzl7SuaR62RoLFRyURlT/MKceuiT1DsaQwnD1chFPs=
X-Received: by 2002:a05:6000:2406:b0:45e:f684:7347 with SMTP id
 ffacd0b85a97d-47757e577f6mr10712284f8f.12.1783001073099; 
 Thu, 02 Jul 2026 07:04:33 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde19fd3sm9577619f8f.25.2026.07.02.07.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:04:32 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] tools: qconfig: print a proper error when database is
 missing
Date: Thu, 02 Jul 2026 16:04:40 +0200
Message-Id: <20260702-qconfig-check-for-db-v1-0-f0b96bf8fa44@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTswCWjFq4gLM/nTjkKiiYpQe
 nejLr/Fews1VEOjw7BQxcualdzhNgPpfM4T2GI3efE7GcXzXUtONrHO0CunUjkG3sdRXXAQ2YJ
 6eqtI9v5tj6e/2zNcoI/vi9b1A4d7J1Z4AAAA
X-Change-ID: 20260702-qconfig-check-for-db-8d7c1b1e005e
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Hi all,

When I first ran ./tools/qconfig.py, it immediately crashed with a
Python traceback because the configuration database had not yet been
generated.

This series adds a simple pre-check that detects this condition and
prints a clear error message instructing the user to generate the
database first using the -b option, instead of failing with an unhandled
exception.

While looking at the script, I also noticed that the help text still
references the obsolete moveconfig.rst document. This series updates
that reference as well.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      tools: qconfig: print a proper error when database is missing
      qconfig: Rename the doc link in help text

 tools/qconfig.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 23a4f1e22076855df9c8dd93992edd9bd42d7ea2
change-id: 20260702-qconfig-check-for-db-8d7c1b1e005e

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

