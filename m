Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E36C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 09:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CB580086;
	Thu, 22 Jan 2026 10:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QE1FF2Oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A002783A1E; Thu, 22 Jan 2026 10:29:35 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADC380077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-648ff033fb2so860230d50.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769074172; x=1769678972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7QE30ewXCKuEnIUv1J58L8pWHbw+QdsLg2W7g+IhNCI=;
 b=QE1FF2OqtRKO6oPdRC4u+sLO2rARfZvQHV/yuTWNiSv7aV8nnlshHSZ1uQ2vJIOEGS
 DuKIpfbbA7NSSgZt9G24GuFTs03mU1sp+6pdI/O+iqMnGHvcjrXqvtJGlEG6q7EBfw2w
 J91yKZ7bHcT4Og42d5thHbHfBjWJoNrFFGZIKqBZS/AdaPnIx4LnLtxz3R6UkwURLDSV
 fxzSKZrwGrHfO4H1Vv3xOlqNrrFTlhLH2dy0jcNLkwtsUIJiGKxIwnk0mFF0fQL3sVqc
 sm43eK+F+Q45MFhtbSllsBRVyhy9kgrhL5mF1eyNTa/KrB6RjzZI2Hf1xC9I537VEiTc
 nLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769074172; x=1769678972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QE30ewXCKuEnIUv1J58L8pWHbw+QdsLg2W7g+IhNCI=;
 b=Rq4YLWKz5CVFKXQ470MwGj1pBCAHwra/GFC69FtM1NP+PFHpQH3db0HpM8dphLJSSD
 FyNkymuQfOW5kfTSSZ78e/LbzTIpeTCdrYNRvBLHB/Df4q6FZNpR9JIS8Exo5FJ6cqbF
 8MglkS4zNZA7qLVImEroinculm/7gTGhy5XvPP7kNfq1JfoBJ/kRpeqPTvZrAjDGjSy8
 9ckvQfKi8gRf4HnyaRRSWLYe9IBLCdltJ3AxQhtukJsr1mt/FYs3D73vCuDMwkFmukOc
 8+AjzwLXlt3cri1uXbMmoXMId1cQaLgw3qaVAEWAJJ0AKrL9N2Scj5LN5/V8+MS+Exw9
 iZjQ==
X-Gm-Message-State: AOJu0YyxxEQ1MXh6o3e3u5jGj4SpE7cMKt5jRZzq14UzD9P5+IU5UQIN
 1RQ3tINzfUstOZbHxjpMQi53Gewi3RAR2dKYFdBjXfXMaN0OlwTTkZXqPoBf
X-Gm-Gg: AZuq6aJhFPs2Za2DJQME/JKE1XwLiA7Zi7wgUV4CJ9LH3rRFAqcFA/oPJvprSZGmdo7
 wdxggMaQr9QMkmrLy67B9KxmecylkvVQ03KHOSkZDFM9oiuMi7L6+1tsGSZPNovNZxBhP7mUF+W
 WNA1y1gts0ZiEQjhxaknQTY9+08ayNLqVhE7PxNu+o2vcJujlDdobMvJ26ZLWpKJdfC8McTuTeU
 J+C9SXlGOGak8+UkPEZJNbHlB5NBZX1XntCYb4SGyyiJxVBGul7PEJc4Z8Irg+Si3w8PjZFNVx7
 1DUo+uOU4FbOYqbvGGs/v0p2whgww/LHb1ulaMM6CudY8odpMmQBf5gN8xjLqDCGpdpfLFw7L7u
 mcTHFldljK21Ebx8nEmbxuTjejtVbmtDx9u7iyMwHVH6xZdDqr1ZYWGhxhWl5hQuVZ4CCBIwkKq
 qvh1/rKP6CaSoKx8coCP9ur5x53A==
X-Received: by 2002:a05:690e:1405:b0:649:38f0:ae7f with SMTP id
 956f58d0204a3-64938f0b13bmr7803034d50.22.1769074171767; 
 Thu, 22 Jan 2026 01:29:31 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6494830d0a0sm2149126d50.18.2026.01.22.01.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 01:29:31 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] scripts/dtc: Fix pkg-config behavior under sysroot
Date: Thu, 22 Jan 2026 04:28:53 -0500
Message-ID: <20260122092901.11771-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
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

When building with a toolchain that uses a modified sysroot (such as a
Yocto-generated SDK) that does not include libyaml, on a host that does
have libyaml, building dtc will fail with errors like:

  HOSTLD  scripts/dtc/dtc
/usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
scripts/dtc/yamltree.o: in function `yaml_propval_int':
yamltree.c:(.text+0x167): undefined reference to
`yaml_sequence_start_event_initialize'
/usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
yamltree.c:(.text+0x172): undefined reference to `yaml_emitter_emit'
/usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
yamltree.c:(.text+0x1e8): undefined reference to
`yaml_scalar_event_initialize'
/usr/lib/gcc/x86_64-pc-linux-gnu/14/../../../../x86_64-pc-linux-gnu/bin/ld:
yamltree.c:(.text+0x1f5): undefined reference to `yaml_emitter_emit'

(... rest of errors truncated ...)

This happens because the test looks for the file in the default path but
uses pkg-config, which is affected by changing sysroot, to determine the
correct linker arguments. This does not happen when building entirely
within yocto, as pseudo will intercept and rewrite the file path when
trying to test for /usr/include/yaml.h to match the sysroot and thus
generate consistent behavior.

This commit adds the PKG_CONFIG_SYSROOT_DIR prefix to the file path
in order to test against the same conditions that are used to resolve
the build flags for libyaml.

In linux commit ef8795f3f1c ("dt-bindings: kbuild: Use DTB files for
validation"), including yaml is disabled again anyway because of other
problems that it causes, so this problem can also be addressed by
partially backporting that commit instead and simply disabling the yaml
support.

Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

 scripts/dtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 53f94e5a48d..6f309b37e08 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -17,7 +17,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS := -I$(srctree)/$(src)/libfdt
 
-ifeq ($(wildcard /usr/include/yaml.h),)
+ifeq ($(wildcard $(PKG_CONFIG_SYSROOT_DIR)/usr/include/yaml.h),)
 HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs	+= yamltree.o
-- 
2.49.1

base-commit: 04b37257c034f5d7ad877f72e03b12a806114ac9
branch: dev/sc5xx-boards-v4
