Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7257E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F7980234;
	Wed, 11 Dec 2024 03:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pdG5o93A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F18B08021F; Wed, 11 Dec 2024 03:17:11 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2123380210
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71decc7de4eso805105a34.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883426; x=1734488226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/V6Slifq/SZc9zepx0sUboIXo723LgvGKKgmbOvzOI=;
 b=pdG5o93AUTfGDIJSTkiYmiZsrok2yGpCcCeoHXCb3Fd80hCV5/r0PRoiZxHwZiD+im
 M3nFJgkdCRRyYcgXCLAcjwznY8otOLJVRSTOYh9itdUzIZKFqpYKAWeDhhPM/wgoZc7r
 1Nn4ggWNpyshrzMttV/1IVvKiT/mOIKrMW1obdDUmDg+CUU1FUeqQvtgDwv6qDJs+Yuo
 a8FAaYQp/PL1RO9nO6RLy2f3aaL8H8+md57ZnJEtllc1JZrz1/MrOpWT0CXVCCbbt5oV
 kyZJH066XCYuI1sCG5o6mfijVeldnJMupbvoCNjTfd6vP6+1/lNY1JD+hGEhrnqmmLwR
 rNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883426; x=1734488226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/V6Slifq/SZc9zepx0sUboIXo723LgvGKKgmbOvzOI=;
 b=WP94GwqCrqn1nxtHypEZiVWbne8XDXIc788raYOSyg1n2WEgxErF0DaL9EkT7Kv75u
 ZysGGredi+p5VgUy0lPVT74aZm5jkDFDThFtx10dAFqOXLyaiZWrT9QBbohfu94zajt7
 RtBO8TiywnzsUlB37TIUSi1aYtAuAOVQhIb3xH1juNCO17bDJelyZZYVzBeoATS9wP98
 NDEJdv/wffSV0kYWoVwiEG3DACazwT/w/DELLZBioX6MEPiGvc5szGxv+4e/fc64QtnV
 6WZfTanqxT1Hy8Z13k/D/4XnUfxSOIu9y8f4m2dvE/heVDYYFOAF0YRkfTULYrfqwGCs
 rxNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXCXMrPP0tElbgl7ON3E6WIqAF8tqc4BvFkfB4DD8mJd0kmP5qfpqR5Wui1Z4SZWb4rrUbbt4=@lists.denx.de
X-Gm-Message-State: AOJu0YxO7W+0LSngmbErfrqEcJBgbuM3qTguTZHSulBU+xRZzOU/Jy+x
 lbTRzvMMcgbkSJxzWLpAo9ZpHXrtX330U8oSm8AheF5CmBN+2cx6ZzyvAbpDFN8=
X-Gm-Gg: ASbGncuSG3S1FSIgVbBxyUjd0YNEysq5M+Q+/IrMBqu0YzaSi/yYVIvZch2oZhPWASX
 4zZ4PQTKDUSkPOhHDh6zt7YXCrW/nxK5kX/lGVXNR2QlNMTQUvUi30Hf/loy/XmLke/mt9NuZXK
 +B12vs6tMiczbDbgiMOjhEFnvstJm3A4xJgTLO4mZ6hepWJwVq/F6ohuY8Lr2TyNlOyt/uw9Ulf
 k7jZqBZXFDKSboBxfEpkIg4SzuFc30pdOgWrM0VuCurHqcHQvUODUzRbFc=
X-Google-Smtp-Source: AGHT+IHyiAkN31X5DHXvIclLmG17l/Kv3G+wXY38p8sPE/KLW9g02UyruSwi06iHm5R5/7o5X1umlQ==
X-Received: by 2002:a05:6830:6d89:b0:718:6da0:72b with SMTP id
 46e09a7af769-71e197b7692mr661231a34.7.1733883426417; 
 Tue, 10 Dec 2024 18:17:06 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793225d5sm2791021eaf.42.2024.12.10.18.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:17:05 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] boot: fdt: Handle already reserved memory in
 boot_fdt_reserve_region()
Date: Tue, 10 Dec 2024 20:17:02 -0600
Message-Id: <20241211021703.2333-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211021703.2333-1-semen.protsenko@linaro.org>
References: <20241211021703.2333-1-semen.protsenko@linaro.org>
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

The boot_fdt_add_mem_rsv_regions() function can be called twice, e.g.
first time during the board init (as a part of LMB init), and then when
booting the OS with 'booti' command:

    lmb_add_region_flags
    lmb_reserve_flags
    boot_fdt_reserve_region
    boot_fdt_add_mem_rsv_regions
               ^
               |
               +-----------------------+
               | (1)                   | (2)
    lmb_reserve_common        image_setup_linux
    lmb_init                  ...
    initr_lmb                 do_booti
    board_init_r              'booti'

That consequently leads to the attempt of reserving the same memory
areas (described in the 'reserved-memory' dts node) in LMB. The
lmb_add_region_flags() returns -EEXIST error code in such cases, but
boot_fdt_reserve_region() handles all negative error codes as a failure
to reserve fdt memory region, printing corresponding error messages,
which are essentially harmless, but misleading. For example, this is the
output of 'booti' command on E850-96 board:

    => booti $loadaddr - $fdtaddr
    ...
    ERROR: reserving fdt memory region failed
           (addr=bab00000 size=5500000 flags=2)
    ERROR: reserving fdt memory region failed
           (addr=f0000000 size=200000 flags=4)
    ...
    Starting kernel ...

The mentioned false positive error messages are observed starting with
commit 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory
areas with !LMB_NONE"), which removes the check for the already added
memory regions in lmb_add_region_flags(), making it return -1 for
!LMB_NONE cases. Another commit 827dee587b75 ("fdt: lmb: add reserved
regions as no-overwrite") changes flags used for reserving memory in
boot_fdt_add_mem_rsv_regions() from LMB_NONE to LMB_NOOVERWRITE. So
together with the patch mentioned earlier, it makes
lmb_add_region_flags() return -1 when called from
boot_fdt_reserve_region().

Since then, the different patch was implemented, returning -EEXIST error
code in described cases, which is:

   lmb: Return -EEXIST in lmb_add_region_flags() if region already added

Handle -EEXIST error code as a normal (successful) case in
lmb_reserve_flags() and don't print any messages.

Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
  - Added R-b tag from Ilias
  - Reworded the commit message a bit, reflecting changes in the lmb patch

 boot/image-fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 3d5b6f9e2dc7..73c43c30684f 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -77,7 +77,7 @@ static void boot_fdt_reserve_region(u64 addr, u64 size, enum lmb_flags flags)
 		debug("   reserving fdt memory region: addr=%llx size=%llx flags=%x\n",
 		      (unsigned long long)addr,
 		      (unsigned long long)size, flags);
-	} else {
+	} else if (ret != -EEXIST) {
 		puts("ERROR: reserving fdt memory region failed ");
 		printf("(addr=%llx size=%llx flags=%x)\n",
 		       (unsigned long long)addr,
-- 
2.39.5

