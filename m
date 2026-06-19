Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EADCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E445584A0A;
	Fri, 19 Jun 2026 18:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CP7W74/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D300184A3C; Fri, 19 Jun 2026 16:46:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02DE4849BF
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E13B3FAEA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781880378;
 bh=S8gUAICdVno8FrVBjBJDEdkkpFX4GaSvDFshUeFqkdk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CP7W74/W2BlNQE0z9vijhWkBYJhxekOIDzD8IqRZ4i/3MGiHJJb9CUixfdOomEaEw
 r2LViL4KpwM1Mn+lyTy9QNKxqFrIJnlehPNGwcDBc+ZUhi/wrK+wyv34IUCSV0o5Jh
 NMhoYIIQB0Ao7cEgitDdCaJKwyrVHv4NkdTRLnWbDTDBnoouI+II2kxfSBiDzRFVdj
 Z0BkWYNRrn+WPpjVsejJpfWN0FcYaH4McSEP+LCaReyLTSjEFoP7m7vkW0uPzKOckF
 zagPhoeudGl7vx2xXcZfMdpNw+2B01raDyEQK1vH81DEAQ8YrMFcpZBhmWiJi3u1Wb
 7D99B3JRdr73IQg6R09NPFJj9EiVZV06Mfid30bBgS/f2U+BwhuTGIli4T9GcrcR7p
 v54lb5IcI3tF+AmY+vJQ7RbTtJRxuKUGXgEbZ8AoBRNr0uy22E2Rc7CYrBURHZw9rL
 FX+glpY+2dBru4bGe2TgVwWVTw+KJkF1fr+xooNZMDUduSNLeLChN2645rvLne81ou
 NVRJqQqx5nTvybZcSfGuUf/OHTv0GQcznsq68JA5cUN5t/nfISDZ3dm56FB2ixFlcz
 WzUkag8h6nk2brErx5ECJsUP1AnBKEPTPu/MoFaFH7kXkodGjNpQ68XRxRBzeG3w4Z
 CqhxbHE/Qcxxm4ZpFr2xulv0=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1639385a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 07:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781880377; x=1782485177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8gUAICdVno8FrVBjBJDEdkkpFX4GaSvDFshUeFqkdk=;
 b=GBGALbGCBM6IFQnagbnvg0QVue7/V8D+A/oA78+65HAgxq+G8jrb6CpciFLVlvjZhz
 IgZyfnOq1y7FKcbcISNYzUnr/QPYLpeHpAU4SjrcAEy5k0owuXcBTzCu9XDncFASMqeb
 WlUVYDhFWFgG83k8xm34hI+zVpZcGyg6lIe91uiR5N7yN49CGiG9GfseJh3lCTc2wwVM
 rE59NZVtoxKWRapRGF170gMJ0E2X+qLqwkpD2Bw9zipBG82tPglfs2wgm99S7J0KtpTW
 0WvwyN6tef0h3JtaSmByIROTKRp4H3udxOaqJtTKJ6KTn/wIQl6ETWmmpls0EET/y0CM
 Q/yg==
X-Gm-Message-State: AOJu0YzXUd8919CwG2zk+9e5YqiABQHBexObCqTFtnJ/hw3a7xH4/KFO
 sAriK8rtfM8KPOHuzjoKnT1oD9ie3Ctfo41GRaQgSR5l+FGPlKap9J1fPtEeTwBF3p1fn8ArKR3
 bU6Cc6hSKMORmyPWsUDITBmOXShKCknVBgb2plvqnzBlLXzA0svPJfW8JX0dnMXtwvRBjQMOwn5
 vGaXlwXw==
X-Gm-Gg: AfdE7ckzjhyYj9EN+pv42RsQgcd7Ssvtx3eN+wBUkSaHjMTgEv1z2gnCoK3SsqKrG0K
 m42j9VCQlqlEjk2lusKb4k3XhWziXuYV0M7pQW6mSPk3EQbG72OMbk850W86ibQRr8SYw9SA/nb
 5EiKiVCaa4JPXH6QhYkAejJfX7lZprgIfbVaJBz5fay16JT6BM5iuZ7m0DpKZYsFNWI5PajYl67
 +R53QZZcoAwWZXeHm5CbQJs0ygA2SyEBE4eEGGXXQ/xLr+McKeyTZ57aC/J8wuISyese6ZrAxFx
 LtaYk9GGDNOothHtiF+kwRSIZXxDAmV+PnIXI6phZpqqStxsrY8RDhtzI9zjFEjjGyJ0SBHwHx0
 Do0RIwsho8OpkLI7KmRaMjIeVunoS+9zSCPobGZ3dANXUsUSchL9Lk4op4REbNg==
X-Received: by 2002:a05:6a20:734b:b0:3b4:774f:d18e with SMTP id
 adf61e73a8af0-3bb3476459cmr4168677637.36.1781880376953; 
 Fri, 19 Jun 2026 07:46:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:3b4:774f:d18e with SMTP id
 adf61e73a8af0-3bb3476459cmr4168647637.36.1781880376454; 
 Fri, 19 Jun 2026 07:46:16 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc5d04858sm10151a12.28.2026.06.19.07.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 07:46:15 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v1 1/1] bootm: move OS index bound check into the legacy path
Date: Fri, 19 Jun 2026 14:45:51 +0000
Message-ID: <20260619144554.5963-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

Commit 103b1e7ce8cc ("bootm: bound-check OS index in
bootm_os_get_boot_func()") added a range check to the shared accessor so
an out-of-range OS id can no longer drive an out-of-bounds read of
boot_os[]. That accessor is reached by every image format, but only a
legacy uImage can deliver an unchecked value. bootm_find_os() takes the
raw 8-bit ih_os byte straight from image_get_os() for legacy images,
whereas the FIT path reaches the accessor only after fit_image_load()
has rejected any image whose os is not one of the supported types, and
the Android path hardcodes IH_OS_LINUX. The check can therefore never
fail for FIT, where it only adds confusion and code.

Move the test to the legacy branch of bootm_find_os(), rejecting an
out-of-range OS where the untrusted byte enters. This keeps the FIT path
clear and lets the check be compiled out when CONFIG_LEGACY_IMAGE_FORMAT
is disabled. A valid OS id that has no handler is still reported by the
existing NULL return path in bootm_run_states().

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c    | 4 ++++
 boot/bootm_os.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 4c260a5f5ce..f9f0b2e918a 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -330,6 +330,10 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
 		images.os.type = image_get_type(os_hdr);
 		images.os.comp = image_get_comp(os_hdr);
 		images.os.os = image_get_os(os_hdr);
+		if (images.os.os >= IH_OS_COUNT) {
+			printf("Unsupported OS type %d\n", images.os.os);
+			return 1;
+		}
 
 		images.os.end = image_get_image_end(os_hdr);
 		images.os.load = image_get_load(os_hdr);
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 69aa577a2fc..ae20b555f5c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -599,7 +599,5 @@ int boot_selected_os(int state, struct bootm_info *bmi, boot_os_fn *boot_fn)
 
 boot_os_fn *bootm_os_get_boot_func(int os)
 {
-	if (os < 0 || os >= ARRAY_SIZE(boot_os))
-		return NULL;
 	return boot_os[os];
 }
-- 
2.43.0

