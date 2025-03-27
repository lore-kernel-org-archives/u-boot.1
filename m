Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68EBC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 23:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C1081DCA;
	Fri, 28 Mar 2025 00:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wJzKO7lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845D481DCA; Fri, 28 Mar 2025 00:13:36 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA02281CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 00:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-47698757053so18834491cf.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743117211; x=1743722011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hL36Wbb8TO9qEktMy9bu/dscpHz+Fq3yQezwgW13lIo=;
 b=wJzKO7lO/EyBeFUgzNIb5uAU436+W10EZ/142QeKbt+Xrf6t+R6gohZyYCmyZwPlGw
 ze+Z/CruLgtDpsRFBYtLNcgHr98elQ+5gDmuLlH9PDQezAope7K/wdICdAgyX4wNHYUb
 r635Iz6W3OYnUXKojjUSZGZSr6cgasdHiSE7L4vuNvgAZaBnvgTEpuaF7LtO3zAWgCM8
 IF/tARwXCyn1sY+tqyN3vv/Sc1qvIctZ8spnBOgTbFxoDwH39v9nLL9gkQNJUIbvEZkO
 5dTbRbCefqL3177kCUnoBJGAB97+4dMU+KwMQHi2N8799VwYEhozyEdme/+ed1QbzWC7
 LrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743117211; x=1743722011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hL36Wbb8TO9qEktMy9bu/dscpHz+Fq3yQezwgW13lIo=;
 b=jgd1Wq8BnA7zHtRmkpBO5k+4ylv81qSnk7onjEiG7fiq/M2kYCnFzAFbQFLu/EBGKu
 rI9TJzIfofvZYgo3qXBWvowmFppREWVXIsnfcobmZZnWgpwhlbvuWUjYOUaYCObzypBd
 5dKOE1D9Em875/zyQL/lV6OIoHx1vGFpuQc5fdULepbKVdtsD0526Q5U748MjmgmA/jB
 nnjxKqJeFIwd9hwXSnycEsjfQi6YOvoEqW+5V4QgFdd7IRKVaItPL7eW5o7c99rG8HvJ
 /M64mMwIXWlIIRdYmQN11cuR1o0fWtxXB+WR4C/cDz91l5yTBwmk0hhUhT+AmAmCe5WM
 aQ1A==
X-Gm-Message-State: AOJu0Yz3wvddYDesSziSNG1/r50mYl3bgTdmrW6t+rVD9F/qHdNLY6KJ
 Jb8b0H5nOVAycDG+S/wdfYsBZ+V8YSelKASe+MdHBwih/eNGy8Ua5jR/jmfYZuBfE5RV3jiE0Uc
 8
X-Gm-Gg: ASbGncvdxOYJ01BB4xmehvAMQzMHUhiL/pqwn2GKm7B4SdX2wPlLFkDLItfOSx7FZ++
 5gP34MzkRnM5d6YV/9FmQ/C1ySib2j/StlIHdrv/jHQUb4H5TXUJm+jsfYSiow/S0YVmtK5OauF
 wNNdV/9NcKDv/o3PTT2ekTIOHD/o/p+59OPE7VikqMocGt+4RJzDb1qgjwsRvlR5ZS7BsQ19XMO
 baVi0KaCP+Hf0h068ozXLI/WS5WXWXG/gkWnzJFQKs4xK5AGwoxFu/NslQca8UfP0RvZw9tq+qI
 2EzYr5rZZp26QMowjxbhK5iB+8wX3XUmdtEEfAtZa+qdjzv20isKR/IGI6bBb7vnQs5HWg==
X-Google-Smtp-Source: AGHT+IH7R8hJ3zi4yEBZgHaDCteLf39QXaJ21gbvWOHMDSESZPeMccPepqRR6oXMXfhtnMhqOg2DeQ==
X-Received: by 2002:a05:622a:480f:b0:471:96af:c005 with SMTP id
 d75a77b69052e-4776e1bc694mr92355591cf.33.1743117211160; 
 Thu, 27 Mar 2025 16:13:31 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47782a7fa50sm3283761cf.45.2025.03.27.16.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 16:13:29 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
Date: Thu, 27 Mar 2025 16:13:16 -0700
Message-Id: <20250327231318.2713201-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

When a bloblist is valid and contains fdt, it explicitly means
a previous boot stage is passing transfer list compliant with
Firmware Handoff specification, thus the fdt from bloblist should
not be overridden with the ones from board or env variables.

Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/fdtdec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index f09c9926a7a..c38738b48c7 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
 				gd->fdt_src = FDTSRC_BLOBLIST;
 				log_debug("Devicetree is in bloblist at %p\n",
 					  gd->fdt_blob);
-				ret = 0;
+				goto setup_fdt;
 			} else {
 				log_debug("No FDT found in bloblist\n");
 				ret = -ENOENT;
@@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
 		}
 	}
 
+setup_fdt:
 	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
 		setup_multi_dtb_fit();
 
-- 
2.25.1

