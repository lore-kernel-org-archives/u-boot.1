Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BB2C28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 17:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6E6805D7;
	Thu,  6 Mar 2025 18:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RRjH6czL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696F9808A2; Thu,  6 Mar 2025 18:48:01 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1E88004F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 18:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 451C13F13F
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741283278;
 bh=0JCfVLwghhQ0nMmu/Hgx9KJ5UUkEmD8XTt8MIa0vpQY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=RRjH6czLwT0gr+RGuVtdGzKIl2cG/s6JNWlhW8YLYO2Wz7tpy/6VLINZhUd6ss2pV
 KrAiRNmYEM//93pLZMSJVc/JKhkO7A2jW2QgBudKzl32Ul8Pet8x7brm3+3mg/FdhI
 DGAxQcFSq5D9kppL/B7VRVRL7fcUaXmV/m9WrH/QPsT+OllWHTwrUlr+L4G4RPj7s6
 DccVn3MNGm20kFZ5Tr3IRQ5038Chg4djy7POnVY8CEXp405q+hA13KuSxpZXFIZzJh
 fAdrrGXC0a+Jh7ShOfYLlFISLmgRK2GCdJVU/XXju6/ZNJA62vO0tdJvc1KKyDiDgg
 OMwx1RPbOuUfg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so119834766b.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 09:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741283278; x=1741888078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JCfVLwghhQ0nMmu/Hgx9KJ5UUkEmD8XTt8MIa0vpQY=;
 b=jeqBKsM3wbq5bT9+yuIt0HTaDYrQDlO9Z15n7I0RjIWZagc7VNs4PW8Tj45C4zw3In
 N/N8ipjDTqiyPNYabq2yhU5eIZd0K0qfJujNbmBQ0Ift9qjrJaXDQ+GTNPNQ90njBGLv
 ltAV6OR4ECRwRQyvOKf9ZjPzjJP62xvYgRfIs02DLGR8QCEP970hJdEmGNM0tBPSiVm+
 215Gxvm1V7c9cpfC/uiwFTAzKCHCKjG2zfRPo2P26dZa0WmV2GU4qP4VJLL+EC8F7Klr
 TtY58KwtwRSGwbHtvUOow8zzlTnAIawICTW84i4y2Ugg3Sr6YldozfmPniKjRwXCmReT
 YWIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEqBeSBzEIeTepsXsPNcTswhW40k8Oruw4xOasBzp2EJxJpFf6Sd4fQkHNVU+wSjsAkbx4lUo=@lists.denx.de
X-Gm-Message-State: AOJu0YxB1jRIJs+ass8NLa2HHwc+Rg8gObBJ6LeyKXfmCCRh940eqbU2
 RoKpYwOCiOaury6YyO/x8Bx8c8mgcB4x96QLl5mnohCFapwZGYXHLCHjcoXqw1sFPtFq1muFIw2
 TgnXZPuS9wuBVcyhp1M+7Y2CWNvTKGKSb1mok+0tFpneYWVFDzAd7PEnc1T3PkcHlnjg=
X-Gm-Gg: ASbGncub1klOKPx+0ORE4IyZAwl2ovD0fwbIU4o6tfk7hl1EYYnmN61TzdqPXSn3us1
 LVD9cD+aRCG0oi84F/QRavx3ViGXHYskA+QZhr4SKcHol/cR6a441bETenMlZqAmZSZPaH3kMf3
 PIp+uUk2HVIBtU6nFm6ISjnUy6/hPW3SmXEpQErF7LQ2qWnC7wmTHujLxusdKjYciHQWSnahYj1
 B120rEy4Cbj554XCnUaxFtvdSMMc6y1CAOpXQyBnpmQLHuyWNXxk2g2OpE7FRSsEbYwT1G/XNtJ
 DT6XRTqt29FTJ+B6mf3f4hUkmTFjlRtUDFViA2cq8Rr7aRtFhx7pmJkbi7YECnck0od97csilE0
 jCv89jagEZ2F6EzG9EA==
X-Received: by 2002:a17:907:97d6:b0:abf:76d1:f0fd with SMTP id
 a640c23a62f3a-ac20d8bc996mr727475266b.19.1741283277796; 
 Thu, 06 Mar 2025 09:47:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELbX9Ylwo1auWmLwOEuVbq0+TCEKXFcz9BxWeUyy3062QsWLIJ/EoclBS2PkluXM7jh3snYg==
X-Received: by 2002:a17:907:97d6:b0:abf:76d1:f0fd with SMTP id
 a640c23a62f3a-ac20d8bc996mr727473766b.19.1741283277488; 
 Thu, 06 Mar 2025 09:47:57 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2398906bbsm126862066b.159.2025.03.06.09.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 09:47:56 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Richard Weinberger <richard@nod.at>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: use truncate in mk_fs()
Date: Thu,  6 Mar 2025 18:46:59 +0100
Message-ID: <20250306174659.904457-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While the dd command actually writes to the block device the truncate
command only updates the metadata (at least on ext4). This is faster and
reduces wear on the block device.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25013
---
 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ccfc0201a49..d85e2b98a24 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -54,7 +54,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
 
     try:
         check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'dd if=/dev/zero of={fs_img} bs={size_gran} count={count}',
+        check_call(f'truncate -s $(( {size_gran} * {count} )) {fs_img}',
                    shell=True)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True)
         if fs_type == 'ext4':
-- 
2.48.1

