Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62597C04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F59988437;
	Tue, 16 Apr 2024 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YrsxA1ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F7E88447; Tue, 16 Apr 2024 21:01:56 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E5388434
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b6d36b71cso11256076d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294102; x=1713898902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08baIruLCg+wjYbzeSKNAY5yF6/K/c6kvIVoM99mKEo=;
 b=YrsxA1raXnZ3fOQ0W0c0JG3AndyPeVGSxOl+g2D9KyQ0QyhfKx6OpCH6g189We04Cu
 5jGiPL49OtgpS9IoOTwRsHg1PjfqYaLZ24JvaXTJFShJxqWs6SgjvZH5nNh+4CwQ8Cfo
 /8euoWEbDuRz3XTZrRvGgXSjOAv14lWzokKBvwowPmrjLoC5nraiEORzXlDz7kKV6eUA
 l5LpRtRHqHLD9urOJp58S2f7aOU2y8bbeQ7pR6l5b1vSpIbsdB+gPxp0hp9t5YSGbpQd
 jZly3C5gQq238ZcdU8o5NYsXgIxDQ4HLuYI1VbhmXvMSs3C+Z0JVS2LvGps47/fgGrVh
 vwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294102; x=1713898902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08baIruLCg+wjYbzeSKNAY5yF6/K/c6kvIVoM99mKEo=;
 b=wnLYP+dVG3t5Ovqz4zNbCKNd9ue8GrEAdIYGLuW9csUZevjbgYcjBA9jKz0fb5WELv
 J9EY8eu8QvQbq06+8jXl0ZuL1UD4MB4XCjAU4I6KKN9m11bg0jhe0ak03LfOIR6VBEFF
 WXRx+vKnxy9M7QnnqhNJP3fpxHu4eqixPq37NeouKWwBQU0csWKPSp7AAoxggLlOqSkO
 A+bUqvvRiSdTfiBr4J2LUCQDANwUlNhlRWCWe3KY8hT+9dG+qTWR591tIFjBuvWDN1mD
 34wT6aQiRueSHgfO/2YZ/92/bkdf37SHUgaqBD7Z3MMTAh5pUMaacRZL1L3TZHIoe755
 t8fg==
X-Gm-Message-State: AOJu0YzXNhdUA/Zyki22j7QTk8VhZtYx2LbJTboxtuSM9dhfCHTL3v6U
 25E90m7YvluTYm9RNFIffaSTd0JMnkETjHQIn7Jc2kQLptx+ig7UVU6UVjXyLq4uVCYDepKgOMT
 A
X-Google-Smtp-Source: AGHT+IHFaxHgqJxoyPUsseJw+WSqHzDRv6i4jGxX9xEAiS9vCnuE6i71AMfLAU2NU1xMCmkFyFfsvQ==
X-Received: by 2002:a0c:e1ce:0:b0:699:2db7:f5de with SMTP id
 v14-20020a0ce1ce000000b006992db7f5demr13400635qvl.2.1713294102444; 
 Tue, 16 Apr 2024 12:01:42 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:42 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 05/23] test: py: add sudo for virt-make-fs
Date: Tue, 16 Apr 2024 12:00:01 -0700
Message-Id: <20240416190019.81016-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Fix a permission issue when running virt-make-fs

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 test/py/tests/test_efi_secboot/conftest.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index ff7ac7c810..30357913f0 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -113,7 +113,7 @@ def efi_boot_env(request, u_boot_config):
                    % (mnt_point, EFITOOLS_PATH),
                    shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(
+        check_call('sudo virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(
             mnt_point, image_path), shell=True)
         check_call('rm -rf {}'.format(mnt_point), shell=True)
 
@@ -232,7 +232,7 @@ def efi_boot_env_intca(request, u_boot_config):
         check_call('cd %s; cat TestSub.crt TestRoot.crt > TestSubRoot.crt; %ssbsign --key TestCert.key --cert TestCert.crt --addcert TestSubRoot.crt --out helloworld.efi.signed_abc helloworld.efi'
                    % (mnt_point, SBSIGN_PATH), shell=True)
 
-        check_call('virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(mnt_point, image_path), shell=True)
+        check_call('sudo virt-make-fs --partition=gpt --size=+1M --type=vfat {} {}'.format(mnt_point, image_path), shell=True)
         check_call('rm -rf {}'.format(mnt_point), shell=True)
 
     except CalledProcessError as e:
-- 
2.25.1

