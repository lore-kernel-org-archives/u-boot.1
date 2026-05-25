Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49307CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E4884862;
	Mon, 25 May 2026 16:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SkcOx9gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD36846DE; Mon, 25 May 2026 15:26:47 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9848460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD2033F633
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779715604;
 bh=Ejzl9tEEuJ+BIPkYym+tQYt7Y39F1tQ80DoViVwtNG8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SkcOx9gB/6r8NvyoZT2r/PHcKwnKurd+YY/AGcuPgeSA+8VSl4qisKCzjvkHjezlm
 lmRwuFZ6mu6mybkwbXdIIvOkUKBu78yRK/DG/NhYjLifCAO9O+IfqR6mKO1M23BdOL
 HgbVXqNSAcJA7ZFBhQSNPqms3d2JzIKvssPhIu9t3XNjnk+QeM3fCSHxf2oxM6PiNb
 OvHiPXxT0AgcSilWocKUq619Bn/dn7nlw9ZnGlZWUHx6FdwpNnlB0EDddKYz2+/e2x
 TIJnc7TiAIRJfifSdOKQg7pikZTp1bsa1AERz1DhHhrxl63zqYvzbio+77cRpxddhR
 FwmyO1dGHMp86EnmqnymjjxSbDMH7xcH4JPWbJRkQXycFVGskDwMN+FRXkUjjik37A
 r5IYk6vUwX9aAYZEY7GKUdLh+NRu5MWEQEsQKBDEPfoPFB+Hgx1POM3vcSvS6Fi3VK
 U0ey5ZOB7Qyjhcve4xI5kNDV8OWwVmxyhBMDgdV9o8u3URy+lk1EkIEzRB5Ra5eOWM
 Uk5LHbzW2Vu0eUlngm2wb64dtsVcNnn58ls+pYtHjibAe2IUMTcGJz+5MG9P4OHWhE
 GxXv5DuS3s26iNfmm6wYfP1qWt7PDckp8/B0wVDI+0nm4NQvlbgdQMUQ0vT7lR+A08
 b81nf483C5bIh3l9YsiAlZiY=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f85179263so11374174b3a.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779715603; x=1780320403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ejzl9tEEuJ+BIPkYym+tQYt7Y39F1tQ80DoViVwtNG8=;
 b=hxsr0nG1uSsmdxTuxi2tpNVPj4Kj0zOQS/QxYc8wgvyIn7/IN3Wm86Q9t087xfo8yt
 GDdRMiHr26v/J4tG2sokGI51x9VFmORGA0uJkOWrKnoYsK02aAVgA1ORfNsPGJ8+Uz2t
 C4M4BI32Ggl6RufymgGJF2Hlj9HCfFF023UqNtNTaRH8rpdlHKq0be2pO46HFQj+bIhi
 Sc5lsd/Jkmg0QT01ppBEVTvsxVtui5iS3tiWgEiJzebK4RVU6kNXW4q2Qe25YO6REBkQ
 f69qeTF2EI/FMKD45i0pQjPFwGyevQw2bb2xWTWNFzeiQu4F1vHRy3iITyS25vE60b1/
 ezLQ==
X-Gm-Message-State: AOJu0YzFdrseyU6aMRw0PiDIb3BBsYA/5Xu5OG3nQI8/FbHBx5QGLbQg
 YPVaKaQ03mjV9XapcSb9TvfRok5ZpQCLEN6UufEq220h8FgV0jNV5Ey6nRKgg4154le8/L+p0Io
 fuEfUf3DboP5fLS1Q/yJ482yOukoECE1569iLXY7n3W+WxVyhL7y4rNaNdrzdnQcZTGqDk7qP/L
 026M0ThA==
X-Gm-Gg: Acq92OEyrk2gCfXflHPAMaZ2TAlbpbI7FPo7058bZm8nqYtlExVch1Qj7UdPSdI8Uma
 s34DItymOJL295NAVCVT+mIk//ZHngPy5SvQ5NwyuqnmYS3MZyWaJLlRo/BIO2p7FurwSel6rP+
 LuG6bCpv1GIIpgm+IXxSc+29bSWRfPgrt6UvQPtLfnMiIITVw6kIDsrpuyf1B2jmVJXyjAkddUo
 kG9amN0cXiEXU+zOPOWdmjV/86GDXCpW9qKA8Xknh2chQ5w64pRjjoezSk8pHTR/1FV3g3LKFUw
 VXfupuZiyPVYWl7T04liH7gsSsT0L7hGIy8GJY+weBPlF/H53yTg7+l9IVtfe49aQKOYwgiv2E7
 LfwitN0WoUVDhzox/NWTY22hI+jK46pAzZsHDwUgrvlOf4D9uNdDpRAj8x0Cuvua2YJXWt1jWbB
 xZQg3f4BJ4e2z5+u8=
X-Received: by 2002:a05:6a00:3287:b0:835:405a:7e62 with SMTP id
 d2e1a72fcca58-8415f612e6dmr14165512b3a.33.1779715602907; 
 Mon, 25 May 2026 06:26:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:3287:b0:835:405a:7e62 with SMTP id
 d2e1a72fcca58-8415f612e6dmr14165479b3a.33.1779715602336; 
 Mon, 25 May 2026 06:26:42 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841648a2bf2sm8806449b3a.0.2026.05.25.06.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:26:41 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/3] fdt_support: validate property lengths in chosen and
 dma-range fixups
Date: Mon, 25 May 2026 13:26:22 +0000
Message-ID: <20260525132628.755148-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 16:46:18 +0200
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

boot/fdt_support.c contains a number of helpers that fix up the kernel
devicetree handed to the OS during bootm/booti. Several of those
helpers consume fdt_getprop() results without validating the returned
length against the per-entry size implied by the surrounding cell-count
arithmetic. When the OS devicetree is not signature-verified, for
example an unsigned FIT, a DT loaded from $fdtaddr or $fdtcontroladdr,
or a DT supplied over a network boot, the property is
attacker-influenced and the missing checks turn into out-of-bounds
reads or writes on the FDT blob and on stack buffers.

The first patch targets fdt_fixup_stdout(). The function copies the
value of /aliases/serialN into a fixed 256-byte stack buffer before
publishing it as /chosen/linux,stdout-path, but does not check that
the property fits. The patch rejects an oversized property with a
warning and -FDT_ERR_NOSPACE so the unbounded memcpy cannot run.

The second patch addresses fdt_get_dma_range(). The function reads one
full dma-ranges entry of (na + pna + ns) * sizeof(u32) bytes after
checking only that the returned length is non-zero. A dma-ranges
property shorter than one entry causes the subsequent fdt_read_number()
and fdt_translate_dma_address() calls to read past the property within
the FDT blob. The patch validates the length against one full entry
and returns -EINVAL when the property is too short, matching the
existing failure paths in this function.

The third patch is an unrelated cleanup. A handful of printf call
sites in fdt_fixup_memory_banks, __of_translate_address and
fdt_get_dma_range still use the gcc-specific __FUNCTION__ identifier
while the rest of the file already uses the C99-standard __func__.
The patch converts the remaining occurrences for consistency with the
rest of the file.

Aristo Chen (3):
  fdt_support: bound serialN alias length before copying to stack
  fdt_support: validate dma-ranges length in fdt_get_dma_range
  fdt_support: prefer __func__ over __FUNCTION__

 boot/fdt_support.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.43.0

