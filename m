Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEB5C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A3D82BCD;
	Tue, 29 Jul 2025 17:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MZcJ0NRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A1182F14; Tue, 29 Jul 2025 17:52:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12F4829F5
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-454f428038eso50028065e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804332; x=1754409132; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=MZcJ0NRBJni5IdYWpVzR56p13p6fL5VIACzxv5JNGeGznBB7bz525uipXWDoqrYM3e
 8xvvYIQ8TB1pJT12ke3Ze4/ih7oIKRZ2ZCgW4OXDdsyT+MWnSE2BUkZ6ae/YUkmGE1U2
 myOn2/9DMDPKcAEdigSKvIuThz1YYYNqUhmUAkd6XQtPuL3EIAY3ugVr+zvH6OYQ0pho
 OgL0Ay+LyaR0EZussUI37Ktc8naK2TUIJ6qbZVdjj1W3fV5SDoJXMQ6Dh7lMBF4XASmp
 cN8NBQBXD7icOwzbaRJ5djWGTYB207k3rvODe+VvmMy7IlbLpLt54QycGd6ppKxYUG5y
 UchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804332; x=1754409132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eG215o2L6dTF5UVmOvDhoEeJt/2JGwDj8B519N713YU=;
 b=ssBPk4r1ErRUCrhZtr1i4UsdRzyUyO+KQaH3GnbNWUxpTdCJTQUSBrNCegkMnkN+eJ
 onku5vFebQ2u8sj5ikaxu2kMlHS9Jdv+3bVSW6LZ6K6D72j3k8XnTcfnrwE/FoZspKim
 eREZ3qtvcYncXygAenriLmX4DSQhSYDMGJY40NqS6qxQgBSyF30msUeMhpmQ5tH1YwiZ
 A2Hk3q34YrEIfIqNcu1pvVxCccDdQc+6o1b4KperYwZ+IjpXkA7rvN45JsZg6HJi6Q6e
 J1Hrmq04xldWD+o2fNzF5wRMFw2uyTED6yYeoVQhtiS5q4+6emlwyNKTYhVihBxrXrcf
 7wnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqLKgbseDKSgYP9C2uV5HY+e+LMTf1LFM0/kCMWkroSxFAs3WQwMW/amxqAREarqPxApxXvsY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywe5XKlebMrDfut8iNELcPVv9PfRhsyfD17DChlOrGq+RaDtbls
 jcx3KnBzKIzziX/NVgNZzMtHWbZ3oVQErfVArDwlKag2D1qnpRAK1bXCaubuSG6QsP+y3asdcFZ
 b/x76
X-Gm-Gg: ASbGncvS93Di6vUkiyBlitmPXzxFnywjg+6qkZ73pbTgVQ3bT8FaQ+7LqZpYXXiG0n1
 FKtNT9gaem3oxSl662P/fUyELxL89Lo6d90quw8ObphNHpAL6zvf8Izoph5V2nLvmJsUTnkSiQJ
 LhPNJAqPpYzc1fWwLBudpkdZDdlHh02lhkRJtWrwkWji6iaSezAOk8TzyaPxvxNuc+E5u54PgQE
 Wb9iCsOK9az3OXMiPxRpY9Jn3Dwc0xGZ9W/Nrl4qKYnxXP2WCnLW5WDwmsUuDaHA8EMkNlmLmRw
 0U71GToyRE5kD7CZb4q+DEP+/eLO5/rBXdkHiO7OxoETxhvYurOqv9g71XpmT0FrHUfJ/VYIEBr
 TVg7xKGIhV1VsuCZA0ji1Ml+LmVTUXaBN88mkgpoqFSx/EQ/caG5w6rqcPoAmJ5jUIMPfybot3y
 1f/c2L4P5on/fr+xiCrDtt
X-Google-Smtp-Source: AGHT+IHOhuTutwbpo3zgVCEcNtIOB33xXTygs+jJ+ZWnhmuZzDqsdOcBC1dZDxOcP4K0YQwHBF1Xvw==
X-Received: by 2002:a05:600c:c4a2:b0:450:d4a6:799d with SMTP id
 5b1f17b1804b1-45892b90f65mr3017555e9.7.1753804331757; 
 Tue, 29 Jul 2025 08:52:11 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:11 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:51:59 +0200
Subject: [PATCH v4 01/10] cmd/exception: missing include string.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-1-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ht0PVAG/UPdWKeozeEuxksuwC/pt0UiZIujECKi0GJI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4jU03e+8h5HSvbP9xsewcExsItjCzPxsNNK
 ak+AD53ikGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuIwAKCRAFgzErGV9k
 tojFD/0XvRpAnV9+odweaDKLJSLU3Kc1kFS+MIvl4fUxdDtURP8KvAkgOupVLAwINvekkLk3ZWB
 Y72GeK0GttqxZUFwbSoVgIqx4DXFoz/4C/CiDAQalEAAhh4guVOVbKin43ifb1SwVZmyyXrIVBk
 bNYO6Qw6yBzqfvblZNKPt52UYXat8AaBz4ST0D/XL/0oT9uiC3yXX0Tn4z47/+6dOTfhUuLIvex
 Itm1HxM05qsuo7O2ScbNw53qDS63d61KyH+64KZghgtMYatVu8fGKwyZunYM+5PX172S2TtPaKl
 +Not7Khg4mtoCnFO+lxGl4C3hdW8DIw6LqinEQjfaydvDqV8OUujEf+zxhk2XgzT5KvRzb7y2iG
 4IgSJdhudPzUp5KOyW6NpdgyYG0pOFdPQ3BrdYEWsXJa6tL9Lcljx2CGMuSWFGlZ8Afezf+aB4V
 70lbdMGh/1LJk8405blnfNlNdEli2+kM3w4ACavGcL3KQM10qb9eh2WIoz7tcXYZmUwSYRFvCsw
 Z3wtY1iiKgNZbVaHq4vrMMy6Kj0gjDgUkYk5jPquS7blOIPKcAAj4tkigM9Rbucn76Lu+rJAEWs
 yufVofF0l4PpKkuv5kENf7w/t76T66jTO+Hqzr+WZKjg7ciYQEk91/q7j48qR3ykqUmkJDAjsb3
 tiLVGANBXi5v5kg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occurs:

    In file included from cmd/arm/exception64.c:87:
    include/exception.h: In function ‘exception_complete’:
    include/exception.h:41:23: error: implicit declaration of
    function ‘strlen’ [-Wimplicit-function-declaration]
       41 |                 len = strlen(argv[1]);
          |                       ^~~~~~

Add the missing include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d7530972eefb3255d799ed45de30c82f..0d4dff49954ba1445a16c151ab480d9859a7bea8 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -5,8 +5,9 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {

-- 
2.50.0

