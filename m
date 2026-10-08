Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F1CA600A
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ADCB40A4E;
	Thu,  8 Oct 2026 08:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HO_oKA_nKDs; Thu,  8 Oct 2026 08:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CDF7840A4A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448678;
	b=gf+y1ON0hWVBHLLwNl1oa7pzuHe3RIjy/PlDBuW5S6QCTHWEPdIzN37z4o7Tfwp/z8Fn
	 /rQqzK8b80OmqRHq+025Kfqe4STBDjuF0zFRFkUZpXp2zXSdFpiCOXn0ztKJX+8L9o0aO
	 9f2dhY8myRvxj5JPRjdfZSsvS88ifRAL6c/ILN1zcvQGwtJzbveJaWIceLdeRy2rZIHWE
	 Q76ObwhV4P6cF03MAibrOEQRQS1/Yz4qdEv2VYtOmKkZO4GWXSIAjR4gOuK8U/XH7/UuX
	 6dmxLmwXUS+CrefsAb5fe0uYa1Lj40UMByUQNpwO598Fl1a4louXfK7YdDWY/oYZ+Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XfA88//O5iyXUgtSLMdjw8s8v5joUcHBzm704hcSsNw=;
	b=lHiKqu5JisRR+fT9rqOZZBWXubXNXEA3o2ETAKyOrRoRwxuuE5ujk9sDxp4CAWnT5LbL
	 aSLBGTl/KWcn0Bmv5yHREuCL28iW6tBE84ufzLT/335/hel9BBi0XZ24FYVObaFZTFq08
	 ZWo/zTAUmK81SmtqKxV5CTnKeyeoOJTbWKKDRGvUcWxuuNqIKOfrCV4cDt5EuaIIMGpYb
	 FrhtKSSzuG1704/pgDHgBpGh0nnNvWKi4IlJLybEXOJcQuzfb7d94/umbkhoXJS8q14Nm
	 8PDFIJnG9RIt+2ihmHYjejEElyvdzwaWnKJdI8Snt8eoBseeoo3Hj4yexQ7GCNaSYIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448678;
	bh=XfA88//O5iyXUgtSLMdjw8s8v5joUcHBzm704hcSsNw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tSmxtb2Kvbf/mrdQUYA6O0YfM/TSHFyK0wEBwAk9kAmL/Ipb8KfyIdV43yqXKXJak
	 3Gcba54QOtQo6B5fiQXpUhm6UgT3WaI86D14w6xgdjKOSUEFw2VwcL/pvS4vk0mNWL
	 BDemj/shJqoD7q5CL3wb1DNRxj5YfAVoppdl8br9zuCfi8dgQYZ+0KoOLsg047Spd4
	 rnXFp+Ef8Dj0wi3POv5hjKJJGCZ7QQUV1bPfp6n7hQI6uPop3/K2oA28YEvev1LYXS
	 8KXDMzJsm/DWiynsJZkDdIJAF6cxB4Q2dVv5vIDigyb2CyFQMMaGNn5ijIS9x032SF
	 oxksHLmjad+wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDF7840A4A;
	Thu,  8 Oct 2026 08:37:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B08C1338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9381F606ED
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2niiACI-P5wV for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 08:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF6CD606F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791448356;
 b=sjV5I1FKRIns0rTfbxEjYdiwiw4oy7MKGX/HuWnrkZPRJ1hldc6Nrf6tPtMtG64N5xaH
 mYstJ49NCKYbsqdWeatm+tE89RnrAxb8kL2db/0BBDlailuSO3+DPw1mU6r5p0zM3or5u
 Jw4fOHPW6B8neaKGD2alpWK54TxTqGIiZ+dE54RtnnXbczLJrJzvQ1xESEqMJZXDFHoQY
 c39xNQ6Eg32858U2D5+/Ixgl9/2hRucEjJoyo4YRFWpGSmzeweb/02L8yYrqGbeqwcn26
 p3zMhfoZdIgYwkteMpNpD410S42FEMjuKMg/3xmfUTDbemKYzwJU9V8ICgJLnaQyEcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791448356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=XfA88//O5iyXUgtSLMdjw8s8v5joUcHBzm704hcSsNw=;
 b=i3tcRF9Gz/XhT3DBoZBXsYEpLTeQ8JnXiJ0vCuGy0vCdiAlfjI2gIVr47Y3zEZuKaVy4
 4zIp6+mGp2sDOSBSD8wWY8cX8xukgmEiOy4qVTrrN9SD3NouHSJHll1/D238XdbLd6RIn
 CfBUaWIpAlLmi29HMUpU1fKHrGH0NShJFO8HZdGA8a547MiGAw+gj82eTE+ir830k8vwO
 Wp/gpsIxvurZE8xFh7g8innaOqiIxnEikNz02AU7lPjIjoTQIYbxlTFSsXj8H2Hw5kBcz
 Oy4qLzEOfOvATKdMJT0t2s/PTZzyjMpyJanQp1DTwHxSbUb1Gg48+GllWAE4JlncIjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=INSaA7t3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=kilicyasirahmet@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=INSaA7t3
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF6CD606F3
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:32:33 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so48406805e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791448351; x=1792053151;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XfA88//O5iyXUgtSLMdjw8s8v5joUcHBzm704hcSsNw=;
 b=INSaA7t3Tx+Pz0l9p4OR1472fWFCORVQeIvog0jpTF69ZnsIoWiG3h9fcBba7K9JB1
 8aXXAhSQVe1z8LWeb+GcWkiQrB9/DgI1kiZhPG9QYYnB5kqneJ8fQdRTUErAHBlcP4Aw
 CUVedMjS0Njn2YoHlojBGg2fwOp4EjHRW24ItKz4MzVDRfmjn5BjMFwr+Ntz8yQI0pnl
 4W/Pay4ObLgv9+2ehjo5XMDUNEG6AntgQq+ZCEcXhuncpmtCho50PcFwF4es2KjGp8Np
 jj9cM+ToNSeUK9iEHzv7u6gk5w12Zf2VzkxafQFa6rork64yhKPWdtdTVyRbzcJZu0Ib
 FmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791448351; x=1792053151;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XfA88//O5iyXUgtSLMdjw8s8v5joUcHBzm704hcSsNw=;
 b=G0HqYH9mz2FY6Hjxc/a+JuS6DdZcsLkdToLTalQe0D2qHK/fJOWW5bJSwOyvtN+YRa
 QNoOcFNIIVfVu2mD00l6/dSLU1MRdTSN2/hLux9aJSgz9aoftclBN7bm5n+K9Rg6imty
 Uyi3O35Ft90WUPYqAAkpgK2/c6q87Owuizode3pq3qs6ti8FHEj2cRdSGYzympWBsXiq
 dotX3FcsqStXyNcSpfRdzA33ZVSywiugpyArloC1/qHUzZBrUZwIwxGUZH8ZN1WXvIHz
 VQt3ch13VH1n++4nSb38XU/iVL96gw2KL8RLPqXldd3rmNfr6WjpfMrH7s5OGp9xX2+g
 eiKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBziWI6ONvOJ6oQpErYpzGcF1grKGQ/hAFgZRLt3Zz+KdcDvkQivvKN8nHZv1eeedMsqtBX5AvM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmFFiPGhhQAu2ktAz+YI7w5Gl8YNbOWbynEF1N0lgsd2e1QuQO
 qZ+btvLghd3Z9XBU1LetFFcB59fALptwcB36FA/P8hhaedLxbkRZDa99
X-Gm-Gg: AYBFou022Dc3I6RD+VYM5N8cBunYevOptXElE93moSYsptKgdFtDCaf5PBL8/bGWZhz
 Nz/zTPGLDKGv5Tdp1LaJEcZ4Ew28oIfCM/MBPD3GA0NMcd7sHBmdjc2UXprG6OL9yP6hNfZF1K0
 zqhjPROnXIdzRNecO7DXV0Z2JwjKiHxBPdgc7lLh0gdcZzBr1HWQEyb5NzZOM/aUMXXrZokr3oh
 6moCFSWE3/+nOKbwAZIvKcOWk/9QYCBLHXQTI2+xjH9+3B+AMEHjEJG9RVdVTH0/oRSkC086QBt
 gE/syS9J5PhruBctsgL82XW18zac43UVsMtblN6Tdr7oV4eOjZHurRK+ps3ETTcwJsNDCmFjkwp
 HlefTMMN5b54+whQx4OJVyMf46RT21OJi0In0Z6vcRhCXiuJir+kKXXllQcJJmlGeEj1+vxG5l4
 xtNgFeCc/gOLOyMjJaut/bBGXOGng+cmf7bQ49nlWZh3tkHj9Gw5gJGqMDIxiLGJsQo3y2m473o
 UNX2Go=
X-Received: by 2002:a05:600c:470d:b0:4a1:714d:ef0 with SMTP id
 5b1f17b1804b1-4a18065e243mr81005205e9.26.1791448350653; 
 Thu, 08 Oct 2026 01:32:30 -0700 (PDT)
Received: from [10.40.144.67] ([193.140.87.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a3f55sm56309575e9.2.2026.10.08.01.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 01:32:30 -0700 (PDT)
From: Yasir Kilic <kilicyasirahmet@gmail.com>
Subject: [PATCH 0/2] This series add support for Everspin MR25H40 SPI MRAM
Date: Thu, 08 Oct 2026 11:29:54 +0300
Message-Id: <20261008-everspin_mr24h40_mram_support-v1-0-d8f14da1a997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJUx2oC/x3MQQqAIBBA0avErBNMI6irRITlVLPIZKYkiO6et
 Pq8zX9AkAkFuuIBxkRCR8ioygLmzYUVFflsMNo0urVaYUKWSGHc2dRbrXPdPsoV48GncrP31ts
 Kp6mB/IiMC93/vx/e9wPMn5/3bwAAAA==
X-Change-ID: 20260930-everspin_mr24h40_mram_support-acdd3d31ebb6
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ssunk <ssunkkan@gmail.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Yasir Kilic <kilicyasirahmet@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448202; l=606;
 i=kilicyasirahmet@gmail.com; s=20261008; h=from:subject:message-id;
 bh=5L9zB09VuNa/C3B3Lq63kXpb2z48lDwM2iwJwddG1go=;
 b=mlqNZ8yyC6gV78doyijksAX8U/ZoFBe4wNub1Iax7r9GGZXMycY+QlDRc0MNw6hMlXRMp7YHP
 1AEGVZ88h9sBzmJLbS2tRWp8IxjXKYTa4FnHOS2yn6tHiwD3WRATjFC
X-Developer-Key: i=kilicyasirahmet@gmail.com; a=ed25519;
 pk=FRG0XaJZhIxdUTCOJsdfP9Dy66fwq4axSdMGQ0leLqQ=
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

Signed-off-by: Yasir Kilic <kilicyasirahmet@gmail.com>
---
Yasir Kilic (2):
      spi_flash: honor MTD_NO_ERASE flag
      spi_flash: add support for Everspin MR25H40 SPI MRAM

 drivers/mtd/spi/Kconfig        |  6 ++++++
 drivers/mtd/spi/spi-nor-core.c | 10 +++++++++-
 drivers/mtd/spi/spi-nor-ids.c  |  4 ++++
 include/spi_flash.h            |  8 ++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)
---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260930-everspin_mr24h40_mram_support-acdd3d31ebb6

Best regards,
--  
Yasir Kilic <kilicyasirahmet@gmail.com>

