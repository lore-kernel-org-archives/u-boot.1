Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E7CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7611487B04;
	Wed, 10 Jan 2024 11:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NGkpDy7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353DA87AFB; Wed, 10 Jan 2024 11:37:26 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B96C87AC5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3e2972f65so14996785ad.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704883040; x=1705487840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/j3oePBQR84as2zQnDxAbAdq5Q8yrkNIOyW+4r44PA=;
 b=NGkpDy7B/IJs5PspGXBkb0YaiG5lklNt68IMVTOgow4Y5mQBnqMcn7FD2tU5w3m+To
 X7HMI9bHbq6WjBMwgGcUsZazlTuSmXSUxq4Zqx4CAkOWQey2hBHWRKDpKhNseiFQ5ML5
 V8u8yq2kp/BXpYWmbKgnv3sj/gWD/UCWgYNSKKqBw6rKlXDuX04nT9nqNY149EB2h07w
 wDav2iSHQlCr4hjNesr5pheIwPeUaj8lJniMH4uFxiXHSv0fkiGRMK+nUfnwvqyKlC6g
 60XnjBTlzpZpAW4/ihNocJO6Q5pKCe7LIp+aEQuG2q5TPt6dY6GLyJ9OhRpvng7qN+Iw
 jXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704883040; x=1705487840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/j3oePBQR84as2zQnDxAbAdq5Q8yrkNIOyW+4r44PA=;
 b=swtlzidJsWzsLZ37J/Oo0QlzkXDP0aXM0wkTxA0I/AJM1EFGX4JzXLh5c56nba0NW+
 RFwgyFMEJ86FQO+ap0geL2o8zsCVv8ErVKYFZeaGwxGv0IzR3FnG4xlUhvBJTM67pWYs
 RsD/3c2ZQPS6qQvjevpTyCXy0bO20wQe3as8KgZOhdtw0w777NEj1BuLzlbEVuy+RT2U
 g8R6EkgEOA3MnLd8+87XzqCzWAob5rn36e26emLJfv7Zx0nY6JgMdmek3cPhi2rPgfGp
 ieXW8zBvbyplBl+LoKR298wRFyc+PEY9IwhncLe+aL/t6+uPwIXRcHwxGxD/yCvwYyf6
 vikg==
X-Gm-Message-State: AOJu0YxeuUa+yHlLombSCsSoOFfz8Z1yW1NzriLTG8bewSZwrL2ov622
 zJ+SdSEc21V8vdg6LH44cu9+CxMWspINDkAbHclM6gJi9fs=
X-Google-Smtp-Source: AGHT+IFiObXCVrHD2z5lNvrlGWOJo/TLVnEZxQPPWj2/OgQVfNjHSDUV6NniK4OijjLPgOBUWiZXTQ==
X-Received: by 2002:a17:902:e888:b0:1d4:faae:885d with SMTP id
 w8-20020a170902e88800b001d4faae885dmr657350plg.123.1704883040701; 
 Wed, 10 Jan 2024 02:37:20 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:37:20 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 09/11] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
Date: Wed, 10 Jan 2024 16:05:45 +0530
Message-Id: <20240110103547.719757-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added commit description.

Changes in v3:
- Picked up review tags

Changes in v2:
- Picked up review tags

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fec063a242..39b5c01a5e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -957,6 +957,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	dts/upstream/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1

