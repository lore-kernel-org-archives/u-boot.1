Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CEBE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B8C80391;
	Wed,  1 Jan 2025 23:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDmY0/+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C1980317; Wed,  1 Jan 2025 23:12:41 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7767D8039B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21631789fcdso109580585ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769557; x=1736374357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Cw32dVgevOWWqQW7EUhhq2WCqWx20fh07f7eV5p0Pc=;
 b=VDmY0/+dG4HXDz5PP9Q1pgZ7E3Dmga8y3TYUSoKH1u80O1YlLr6E/JMoMs0BXHCClJ
 AjuCucCnMcayHVvHnqYdVKAlgTKEH9I52cgVAfqmLHfs/W0hp4B2d1Lr3mCSQdh5UWno
 pw52zvztR5IVcAoDY4hFVuZd9MwslJ29P7P3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769557; x=1736374357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Cw32dVgevOWWqQW7EUhhq2WCqWx20fh07f7eV5p0Pc=;
 b=KCUqoTthA3+gjMkS+86eDcqcdfHx+5dzmkMmG4HmufPLP2IKsFdm+QXQEDw8Ern3qi
 Fz+9JjptG2dqKzJznm8xZ/liEcuFk3alITqGov1LKxSC+CX2fAB58O5mhUmhTNz6neFM
 whHvImkurjZA0hnVdnDsxPNRBj912Z29QSppTqfMw8MdutXGaY4rCd7jwn4sB4gBfx85
 dzJB0KyyF5iirGR6OgGk3iFs8Uym+BZDbfwXqYdaT3CRCEJodG/MR+4RL5LKaPUoF0kk
 +7Y4oX82K3VsgP1DPvf8YD2WHbB/5Iaip7mjlm45GWViciQv2bd7eAYlZMdCuR91rEIe
 K8OA==
X-Gm-Message-State: AOJu0YyBM1lQjHs01fMhu1DqksqU7Jg1d7YIwYBeHZPGWU+NhsTUbvNu
 E1Ci/yf3oP3qMeoSwpiaC2n2+PfG5tymcp2UbJgQcNg/bWHOHaKUR0J+5fl3Qvvpbj0v6vPJdug
 =
X-Gm-Gg: ASbGncsRLbH7hNxc/7WQ5ATiNfMNTVNHyBWju14SwJ4paSAeC0uqFGhsNRDcVTNFKN5
 4jf8jx5TgOPjuyFvJQe3FJUqqoHC1zDJqAoLri2xiaQGH8wbr/plW99OXi24jXYhnF5Dc9ba54f
 h3IDBs5BfEL0jb5EtzdQ7cEitiGuI0pmj88wb/+S422Mxv5kUgyVwZhNXaX8TvbPX2mmH5+u7W0
 x2xxl9gUlqbwVkCiq8GQNJr2+4lCc/ZHO6msMi8x8A4tNHN78jhELk=
X-Google-Smtp-Source: AGHT+IElXbcS3jgZ3HQlSXdW8SO2mSDmDgkgOBpS/njd5SG2Oqu+FCzN3OmsUsGSc+lGiABgLuBUhQ==
X-Received: by 2002:a05:6a20:6a08:b0:1e0:d0b9:9a90 with SMTP id
 adf61e73a8af0-1e5c6f15f19mr76909075637.13.1735769557436; 
 Wed, 01 Jan 2025 14:12:37 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/67] test: Fix inpected typo in upl test
Date: Thu,  2 Jan 2025 11:09:04 +1300
Message-ID: <20250101221003.1944600-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Fix a typo in the test comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_upl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 3164bda6b71..90125c4dc1b 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -17,7 +17,7 @@ def test_upl_handoff(u_boot_console):
     proper and runs a test to check that the parameters are correct.
 
     The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
-    that it can be inpected in upl_test_info_norun
+    that it can be inspected in upl_test_info_norun
     """
     cons = u_boot_console
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
-- 
2.43.0

