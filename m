Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F11CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE19836A3;
	Fri, 24 Oct 2025 19:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cmzXSx7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD03B83835; Fri, 24 Oct 2025 19:22:14 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE9983677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c288d3f249so552774a34.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761326531; x=1761931331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ukN/cB5uSnXUtUKJ99r4ntx8G+dXEKzdwO3rrF9MOls=;
 b=cmzXSx7YUGD6mCBrFW5Jktgy+5T9j6UwG7riFo0Xt67UPTcKJ2PpUIohomo4xLZBgU
 75eI6xNiMsBwPliuL0hEJJKWFKXMM+ZY+Qpdo0rnckdFP+WgzP4upkp/zNHqNzYS2hii
 UH+wRJuc/+1kyGVmkuWmQVyZ2YEzGWKBfxmIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326531; x=1761931331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukN/cB5uSnXUtUKJ99r4ntx8G+dXEKzdwO3rrF9MOls=;
 b=UFijdg2XW1BrR8n2YKkCZ73FWW2cMiTJhwWe1hpWqEBNNNxaROvb59BDFsd2wONL0g
 AQSc9JVRgpJMoSCvn0gVbz+g/oTslW5RwMcRAMwbfcKk7AL3PO5MMrmHYLdoObn5Oito
 /ZuhNXuZ87GRaKlQYUPEynSb/vzHWgH9FSifUZQ9Yp9UNiUWC5x8nlYkBmo4yknjvu8Y
 uqfFTTEurlKfBLxycKT5mq581EMDiHfyOp9YshXwutNtSULXeQyZx/jcrzgDu4nzik+B
 lHhOy/C/XIW+uGC0P6SJqBmBMrj/0g1/V8lohMY8idyB0yuTpeSGBL3Bl1Jrz7MLGqkL
 uYhg==
X-Gm-Message-State: AOJu0YwcXPsqirNsGREtA3xBU6Q3YMkwbmDUdxqgz3LsM58L9XltGywl
 EzejXkiOHxhj9Z5eSFw0A4ODnME6b8uGIin7ldhCJQCLuVdaszhvJTbMaKFYDAkL+AX1TXIQkd6
 XUuE84gb+6Q==
X-Gm-Gg: ASbGncvULqj3Rq187a8X/rh933Gt1GPOiH5+eT1SXIdPlFP5n5+pwcVslmXuEWWM1vU
 TYU3OM8piJysDgOehAYCR0UYUpLupgzpaWXSm7tVxalyBGVAHyu56wQf10JNC+FpVvMGPH2bHX3
 PLjASqaIdmz6NrDq1I0gqiUE3ebKwXMvWlXOaG8WlixxeYXC5yiWajP+TUv8QCSFe7wFqR2AcRy
 Oc/P12AafCoX57+P9UFXr0AsJ0DtN5OBf6Z1OEoweKDthQCpZkQxq5p+/QlOpn92qxdXrKuSZ1i
 2q0rKQYGpDH/UC8Y7WDqh0fd5ErNhWIuTyLE6Y8c/TRpqWVqTH93ClMial/iF3SjnKeHfzlH0Gl
 a22pFytal04NgvWJAd8KRNuPOPhncXRmyFOKNXsuQdrDt8Zjn+vUR3hsSefxBoY6KuBoiRh3hAn
 i/4av9smqkefp21ILS+MmrsF//wR51xWjNEiW5mR8J4g==
X-Google-Smtp-Source: AGHT+IEkAN6/s8PKoThTetuJd+dDqeqKiT8BrKh24JgnByp23WLwiFMceQ5cNzHzbHk/LBBmwOU/QA==
X-Received: by 2002:a05:6830:6690:b0:7bb:385:5da8 with SMTP id
 46e09a7af769-7c51aff2d80mr5072451a34.9.1761326531015; 
 Fri, 24 Oct 2025 10:22:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c51b03d784sm1675208a34.16.2025.10.24.10.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:22:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/2] doc: usage: Use glob for all commands
Date: Fri, 24 Oct 2025 11:22:08 -0600
Message-ID: <20251024172209.2418554-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Make use of the glob syntax to automatically include all command
documents.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/index.rst | 117 +-------------------------------------------
 1 file changed, 2 insertions(+), 115 deletions(-)

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 14daa08ca18c..5dbc0fc49107 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -23,122 +23,9 @@ Shell commands
 
 .. toctree::
    :maxdepth: 1
+   :glob:
 
-   cmd/acpi
-   cmd/addrmap
-   cmd/armffa
-   cmd/askenv
-   cmd/base
-   cmd/bdinfo
-   cmd/bind
-   cmd/blkcache
-   cmd/bootd
-   cmd/bootdev
-   cmd/bootefi
-   cmd/bootelf
-   cmd/bootflow
-   cmd/booti
-   cmd/bootm
-   cmd/bootmenu
-   cmd/bootmeth
-   cmd/bootstd
-   cmd/bootz
-   cmd/button
-   cmd/cat
-   cmd/cbcmos
-   cmd/cbsysinfo
-   cmd/cedit
-   cmd/cli
-   cmd/cls
-   cmd/cmp
-   cmd/coninfo
-   cmd/conitrace
-   cmd/cp
-   cmd/cpu
-   cmd/cpuid
-   cmd/cyclic
-   cmd/dmareset
-   cmd/dm
-   cmd/ebtupdate
-   cmd/echo
-   cmd/efi
-   cmd/eficonfig
-   cmd/env
-   cmd/event
-   cmd/exception
-   cmd/exit
-   cmd/extension
-   cmd/false
-   cmd/fatinfo
-   cmd/fatload
-   cmd/fdt
-   cmd/font
-   cmd/for
-   cmd/fuse
-   cmd/fwu_mdata
-   cmd/gpio
-   cmd/gpt
-   cmd/history
-   cmd/host
-   cmd/if
-   cmd/itest
-   cmd/imxtract
-   cmd/i3c
-   cmd/load
-   cmd/loadb
-   cmd/loadm
-   cmd/loads
-   cmd/loadx
-   cmd/loady
-   cmd/meminfo
-   cmd/mbr
-   cmd/md
-   cmd/mmc
-   cmd/msr
-   cmd/mtest
-   cmd/mtrr
-   cmd/mv
-   cmd/optee
-   cmd/panic
-   cmd/part
-   cmd/pause
-   cmd/pinmux
-   cmd/printenv
-   cmd/pstore
-   cmd/pwm
-   cmd/qfw
-   cmd/read
-   cmd/reset
-   cmd/rng
-   cmd/saves
-   cmd/sb
-   cmd/sbi
-   cmd/scmi
-   cmd/scp03
-   cmd/seama
-   cmd/setexpr
-   cmd/sf
-   cmd/size
-   cmd/sleep
-   cmd/sm
-   cmd/smbios
-   cmd/sntp
-   cmd/sound
-   cmd/source
-   cmd/tcpm
-   cmd/temperature
-   cmd/test
-   cmd/tftpput
-   cmd/trace
-   cmd/true
-   cmd/upl
-   cmd/ums
-   cmd/unbind
-   cmd/ut
-   cmd/wdt
-   cmd/wget
-   cmd/write
-   cmd/xxd
+   cmd/*
 
 Booting OS
 ----------
-- 
2.43.0

