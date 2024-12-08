Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968AE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5192893EC;
	Sun,  8 Dec 2024 01:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UkzV+egO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D59893D4; Sun,  8 Dec 2024 01:21:36 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E488489477
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb38f8a178so237207b6e.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617290; x=1734222090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCeNms7zpNG0jTcbTNzWVxUF1LXhhvIVR0PAeT2Txe8=;
 b=UkzV+egO1Wvd9INkNKvo9OJeMY9CWPkczOmv/7DI9jXB/7ZxyP2kuDs42KBhfVgCmw
 igYosOicjxpV+9H+ondyMTwLgduH8ZrP6rw/FuRyhtZvjjqe1olgxyoOhS18KqNYbDnM
 WdrsrnflW7bG/jD4imJec+QF1/rfw3uFt3A1PA4eM6JcFLBpQGUOXldr3c9WShXKyLoW
 3qh/y6ScSSI1FAOqgRpgcIft1CjaxsLM7LVeUl0CXvaX/PZD9nQJY+OLKxIwKGc2JE+o
 RuSf2tOMOIwI9nJVLpuW31Jp5yDTZXAJ0uNs5PDHrvsdqXeHTHZJPetWip5BtCUk2Kps
 sJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617290; x=1734222090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCeNms7zpNG0jTcbTNzWVxUF1LXhhvIVR0PAeT2Txe8=;
 b=KCGRO+hbySDj12NuvBuLIXyOX91F6AwfvQTKnROjaznxHXqSSCjxiYk6HvcOXCEVIu
 qrSy45y85sN5fJxGHZ3YhZ/aERnPsWm1cKPYfynwSnSxOgW0arQXen09KlJ4+SvU9mxu
 jWd8a7FaIsnSDPX3pw8N7ho3aWl2gqNXc1pbjHaXcHPPROOEO1z9aimzrSzD+jBakP3n
 PGS9rodwh01KtI090r9e9sjCfLddK+8+Z+v/pRiN/t6EGJU/kS9TN3a+YgEnWYgfpWd4
 vDcy9xBAIy94Uoefu6jt/rWBNLRj58oMB78mFX9N2C1caa0a1DGvghgF9O4wunqPnmhu
 N/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp1ncinWivaTxXzE02rTken7XWznH9+lI4u6Po6CfNbC7TkTr9w8kAYG8MJZHPCIJCiqRpIEE=@lists.denx.de
X-Gm-Message-State: AOJu0YxrpICFCKOek+rAqDXej5WCHszceybkKG/VrMXtDikJaMUi5MWa
 SpLQqLpE91sM5Musmtv+MtyvZeDAp8OeDcaYB5dSEkajbE9RzuYIUe3uQHwip1w=
X-Gm-Gg: ASbGncvpAD6ZmFpU7LU2OeVaOM23vSqWZOMnIYJLGulpMqstebzqgWyuUkrZG3L7jhX
 I36mVLbGvD0lGI4JOOClu699mfRE+z32P1oafGtkynVwsK0jhn69TWX0d8n8CcgDBF4sboYye4j
 iZr1YTtKYHv2AsYyr7KSwNXl1IDPUw1zvYDzSkxyz6Fky5xNheXHrwHrUxTK9UX/7fXE7IQqIaW
 UM5OPBpa4aTaEN+mrGCh5/DnzV5LTyeYcpvmVoJunz6DzY+YS+S3Jk=
X-Google-Smtp-Source: AGHT+IES29/JriiiuVEiNMpfk7P1kxwiDe1M5OwpoTv4Qp/MsBemqwNJdnGp57ti8snNc8WkOHPu8A==
X-Received: by 2002:a05:6808:f13:b0:3ea:6a8b:a40f with SMTP id
 5614622812f47-3eb19d0e1b7mr3432623b6e.25.1733617290703; 
 Sat, 07 Dec 2024 16:21:30 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b1e3sm1547118a34.1.2024.12.07.16.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:30 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 6/6] boot: fdt: Handle already reserved memory in
 boot_fdt_reserve_region()
Date: Sat,  7 Dec 2024 18:21:21 -0600
Message-Id: <20241208002121.31887-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

Since then, the different patch was implemented, adding the check back
and returning -EEXIST error code in described cases, which is:

   lmb: Return -EEXIST in lmb_add_region_flags() if region already added

Handle -EEXIST error code as a normal (successful) case in
lmb_reserve_flags() and don't print any messages.

Fixes: 1d9aa4a283da ("lmb: Fix the allocation of overlapping memory areas with !LMB_NONE")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

