Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6108CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8904C849AC;
	Wed, 17 Jun 2026 09:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pnLJM7C2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED46838BB; Wed, 17 Jun 2026 09:49:43 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7240A849AC
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso46941005e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682581; x=1782287381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5rOT04NDDlKqs6lxrJ4KMntz1f6Fzql5JvlSLJ06Ro=;
 b=pnLJM7C237Y5Me4w2YoS7Y4TWxiMqMiVmmzZSx1kkvZEifRIGSikNdWHC1jCIQkt42
 spdzn1D5IxU1mopRDB+/HVL04KZKDn/4XUGGOa7q2TTH73rLWFBXtUPSBMmM9zQpTI9K
 C/qEPfXuzrX1C65MHG8VgsAQAi1lVrygg54HmrplJu+YXuW2h5tZ26YdIDetUzVQk2IQ
 PVwvsKo4VOLu45DFlMWbHdeuyw0tgfS4/rr0IIWYt4s6wU5bwq8v+t7J5CnP+YbbyRN0
 doW5rYGbEMdoMXuGa+zpebJYXiejDg1T98sz5AdC+GnCxXJOc63Itltjgx5Y9nASmhGy
 l6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682581; x=1782287381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/5rOT04NDDlKqs6lxrJ4KMntz1f6Fzql5JvlSLJ06Ro=;
 b=b0PHGiD7qqlMWMvkzqk1rWjtuXTMXTviY3yhAYyROYhlHxNaFT7SjeDroRWAoWGJCz
 mALj8bl5t5b93Qkm4IAY56gN8kpIOIVXCCfu+TtJ9qL14IRvXHxF7ejAPg1ZFCQWDpXL
 oSYVitSIJcKdm++fow5Mqz97M7xjsnx5KaRkLDy8b46LFqBJzsMlGVX88w3XNbAzTcP/
 286VHJ+3k2hKJUk6eU9K0CYnRl7a3B0B0/9mWz/xxCyyyi5jdPQOuuLV+8GZmq4ijSh0
 RwvJTEHMkKQCs+9x8HQRDauEKswPwAU7CuWN5G8hdMIL6qmGcfPTznul8JZy9JqJvWQX
 HtVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DWddlNmIABhbeP5MWxPEicAjBLAaOeNBrUEsHF6m1dFkERdC4/Fzb4U3ZnPi0YoHy8xKd8kw=@lists.denx.de
X-Gm-Message-State: AOJu0YykvNk+G4SD+lPaSgQvBp02FTWV6h7Epsf2DQCWYU6lngZxHM7c
 m62vXYHKHDLFyY/oVxxtbLHGI2wzpfe60+R5FY/4BrlJ8csCbu8p0fku7V8bSiIo7nM=
X-Gm-Gg: Acq92OGGC9HO6JUxDuMUaIyAIg5J7UmeTO80pYp5OLojEw+mydaEONH2BylxGGgPted
 RO0i8FIrbk/+A+lv3hC23QfVYrNPellJ59YY6XadTFBzEVnJa+it1qJBe52zLiahkrP6z+aM6or
 QuT0pQ8cx2aDiV6zlboM1tvyCX/F3ocSiYrFaiKPWRoixuO9Q7XfffZKXjw0Fhl9Yf/tHfIXqbi
 J+P7fWe54dJIKQyPQCS/FGneNCNfnMk1cJxsQkUqVU6Q6IoYa3adSaOOLXthQvCJdUmSAS6A6us
 R2Evgr2d8CEQqQvXTl4S8NR4ucBOpXEEXmEQSwQktDd7eu+4wTFCvgoHeJufaCORfD+9RlJhI8J
 ccWG3G5aWCqu4XPtts0cXb0tr3VXCkK/0bJ1jvcEb8ce3928tskCa04H+xVOkKkyJ+RBP+FUKSg
 xLa9MWlpdDI4hYZi1nrstlD/qxswtVxe1iEPVqKdMx9tKUeJ5DT4psL91nRwhijnseo/FKeojCm
 Z93Ou3sH6kPpqA6S/kaxoFG/gEGgE1ZW24vY/mrXbSKTjSCL6dvh6yNTM8yqzlHHhqqtBMmPyBi
 76GfpNUvWPzl4hOlti6a623fh7yiBtYXFegqZBEOm3L+w/WZEAq3eTPlAEe3UDnNto/VuUy5zG+
 zU9p0i8IYucxSjNg/gYPE1THcVysClDmfgOYN1rsv03KQbIsp5IiKhDBHKcJwo7PXnqRgQ8dXPx
 j0pvGSx1E8m8VkRRyYcZ+zXtzmZhyEu0Ojou1iPnLjUz4LWbqVuG0eC2mxpS7sZxOEfZP7/YaFP
 GLEZqHt13JsDuDEtg==
X-Received: by 2002:a05:600c:c04b:20b0:492:32ec:ca2c with SMTP id
 5b1f17b1804b1-492333eb2fdmr37550515e9.26.1781682580890; 
 Wed, 17 Jun 2026 00:49:40 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v7 7/7] doc: Add a warning about using RELOC_ADDR_TOP
Date: Wed, 17 Jun 2026 10:48:25 +0300
Message-ID: <20260617074846.84362-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Since devices that can't DMA above 4GiB will misbehave with this option
enabled add a warning on the documentation.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/memory.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
index 5177229630d1..3da39bb6c664 100644
--- a/doc/develop/memory.rst
+++ b/doc/develop/memory.rst
@@ -111,6 +111,15 @@ U-Boot Proper Flow
       This follows the same as in SPL flow. In board_init_f(), a part of memory
       is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
 
+   #. Relocation address
+
+      By default U-Boot will try to relocate below the 4GiB boundary. If
+      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
+      gd->dram[] and try to relocate to the highest available bank. Use this
+      with caution as devices that can only DMA below 4GiB will misbehave
+      since their buffers may be allocated above the 32-bit boundary.
+      Boards can override thre relocation address via board_get_usable_ram_top().
+
    #. Code Relocation
 
       relocate_code() is called which relocates U-Boot code from the current
-- 
2.43.0

