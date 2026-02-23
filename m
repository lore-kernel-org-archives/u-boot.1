Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA492EC1136
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 20:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3935083DEA;
	Mon, 23 Feb 2026 21:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J9Hyv/Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E594783DEB; Mon, 23 Feb 2026 21:44:57 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC0B83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 21:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45effa36240so3017477b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771879494; x=1772484294;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nWl/MeM2uynCNXyJPKrDoxGEggP7+8rplzNbFPV4ft0=;
 b=J9Hyv/DyiM33LEL1lWcX53HcWOKdyFMfSV0uMM84C5xoeksGjID0W9wZPFi5/1mNfy
 wZPgqSW8YXMmM61zf7hOLDudFY4rg8Y7d7/+wGUUmgjwReSOWftSyYZzncnliZOdjuBp
 NX048uM5nGlEK1DJKGQs5PcNrh+qVJ+CejxxvB40mvYVAsbxQ9lA7Bit4s3oZpFl3R4s
 th9ZrGJopC2le1nfzEPGCM77sbEr8ds/OWD0tkB/genPpWFuL6Rfy1mNZrzAADwRJduT
 SZBlSAYG2PW3A0upGBuQmvQHTCc1LM0VCSZOUROuIh2Q+8mp4VFe0WEru+z0A6CAKOWx
 fnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771879494; x=1772484294;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWl/MeM2uynCNXyJPKrDoxGEggP7+8rplzNbFPV4ft0=;
 b=hjKcwAVANEz6g/lxmdNGas5YKnKKs+dCe/nZ2IHs1ZoBucl1sm5zufcZhsXKabB30S
 Azr2QMVMSN3PoRx/VH/JvOVwNYwKZiaxbZV4HFkzOhR1ovyGAYbe2Sa7BKyEHJuU/y1N
 +CuBCGVRZbiBxlhNvdkMPpRQCjXG1z0/8gFA/QYJeDPPIWELRetjl+1BYDyMGU5GKFPH
 jahIRAzylxNeJTOm9GsO1c4sUmS2dkD+sOlF5087HHkIspfg6G34mvWs9xS3y3OWTQ3P
 jSpAnHZ7xT1Iek6pzzV1LQfQgSk0iTdmXiKzXk5VQ1ASVoCgp+Iy+FPyUMrDVJTZzB69
 xUUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXax6OrpgNInR7u7UXH100WQaUtjLIZTLC33vuHjaQJzg6xmN8aogpFdUkf/oE6zllc4H8AYe4=@lists.denx.de
X-Gm-Message-State: AOJu0YxOpwJwx5Q8tCYVukNbGJUPPOjkpDor5XbmCc3aOX1QhKsnGkcY
 nLUSsAUprfyzu++qZc//g21PYGtWgr6dEQ545KLNLSw2jyfbeCJHHPkt/qvdE/djYlw=
X-Gm-Gg: AZuq6aLU1t/Fz7EEWAez9ZSN0vgdpdTqnqu3DwI25B8U4dVdK6HLoviZHytTCT5Z9ZH
 UwwgiEzSAI5sXqmKAhC+S9uDhLMplMF+WAIi/cCsnJx4QP/5ooSFJyM7olvbpNePoNpDJPE3Eez
 FmifTrn0mx2k2rlnpZmG3uBSWUjNErunYusa8lgyZ9y9oDK8phra078WWDmCuVDGwfljfI0AWTe
 XcfEgsa15O+hOBVSbjMDQ/Y43fFaN2ReCnO6bxBe/kcCSgDvWX/htYbkmiUR1bC5xWfp6FvrMbX
 +V5co6h6Kg+mTV48QDP9lUcUJqEE6VCsLNQ/TYmkZTJndPUj3WkNTgeWLXKZDtUfFpMI6W0DOCE
 SRfSFELTLMdbgx4v4w+0HILdeiiRDX6BD22Yav3Z7VugrL08SJo/LeopbdReTsycoooK27dr87i
 2bEZJcmT3YXSdg9X2gbGhyGccj/mg=
X-Received: by 2002:a05:6808:1824:b0:45e:e1f1:4af0 with SMTP id
 5614622812f47-46446444efamr6266118b6e.63.1771879494020; 
 Mon, 23 Feb 2026 12:44:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e37:2309:3937:4469])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-46460661eeesm3199833b6e.13.2026.02.23.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:44:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Feb 2026 14:44:38 -0600
Subject: [PATCH] Makefile: fix duplicate dtbs recipe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-makefile-fix-duplicate-dtbs-recipe-v1-1-4132c3496f98@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NzQqDMBAGX0X27EK6YpW+SvGQn892qdqQ2CKI7
 27wOIeZ2SkjKTI9qp0S/pr1uxS41RX5t11eYA2FSYzcjUjDs/1g1Ak86sbhFyf1dgWH1WVO8Br
 BxoXOt9Ib2zkqoZiKsV2T53AcJ7qQ/XV0AAAA
X-Change-ID: 20260223-makefile-fix-duplicate-dtbs-recipe-0bd7c5280a7b
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=MgLWgWJQq0MStjPu4jRcp+hSBAcXoEr31PeLQ84Qwhs=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGmcvD2jKrKlDNjjtfgznZqi7/kgHF8jjUX6KQy+P2lldXgtu
 okBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJpnLw9FhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8CsiQf9FaPb4E6/SkuME5oySzZJWUNxOVLBBXyPdRagIblLO+zkKbH
 dmsNo8SqyU084ygDeQau6TbDanNKTBpQLUUho2LG4MIiuTcEiXifJlUbjbZTa88sJCVIhcHmnDY
 X5M7YnA7PuZth5zuDe2bHMVTSrAeJ7baHVYeSoFNjli9M2baCVqiwno9y3UsWwRd7cR85pwrla2
 rqK9jvN9/dSe7tE5ASOqzSQFPcouezCdrupo22mSbdf8C236ikq+9H8h1L2ieYlexiVVmxuWPaG
 2JjKV3YtwoUJLFpiVYVlnkDso5/Qt3omw5alA55ALk+nYOUn70A2jzT/ARk6uk2QWYIAYg==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Convert a duplicate dtbs recipe into a dependency in the main Makefile.

Another recipe is already defined on line 2369, so we are getting
spurious warnings like:

    Makefile:2369: warning: overriding recipe for target 'dtbs'
    Makefile:1425: warning: ignoring old recipe for target 'dtbs'

The removed recipe was a no-op anyway so can be safely removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index d38fa5d6aca..7c81467cfb5 100644
--- a/Makefile
+++ b/Makefile
@@ -1422,7 +1422,6 @@ endif
 
 PHONY += dtbs dtbs_check
 dtbs: dts/dt.dtb
-	@:
 dts/dt.dtb: dtbs_prepare u-boot
 	$(Q)$(MAKE) $(build)=dts dtbs
 

---
base-commit: ef65b15383c99f4562539a635fe166fb4d75c0e3
change-id: 20260223-makefile-fix-duplicate-dtbs-recipe-0bd7c5280a7b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

