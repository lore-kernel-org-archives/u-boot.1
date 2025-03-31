Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171B3C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 22:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D9B81879;
	Tue,  1 Apr 2025 00:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TdxThqZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD7981E5B; Tue,  1 Apr 2025 00:40:24 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772C080FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 00:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c5568355ffso431361385a.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743460821; x=1744065621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nxiw+hu+Vh14X6NAY2ctG2zOXMcjZ/m7rIhmDMb9xLQ=;
 b=TdxThqZDX50TX90dxrWMGZMMvdNyhYSR9ODw37vsUyv/8viW9tdtz9E7KtvPG78jgZ
 8EFRSDw4DvPIUef1vShIhMlFCOT2tSIuJU8xhkX7LMbsMCyFIOxYE9b3TZh13MC6zuXg
 VMcz+GuCCLT//IfXS21MmPJPu9+YNb2wXJ4OEZVgY30PRLVP1TTVTD+HIZqngFgvYbkX
 y4Hxdj+0JN3ykTTppmkVIwUEkun2vG4DjZhLGmygQpU9vokPDbtLPZ2YRETvlsMJ+zXY
 oL7CffhBO4wqFrrZ/wHe5ZHehmemEoNySycm/MvPRt0Ol24lRbgeh/Nc5d86oeGdRpwl
 kNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743460821; x=1744065621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nxiw+hu+Vh14X6NAY2ctG2zOXMcjZ/m7rIhmDMb9xLQ=;
 b=fqC8lmGPRog2YxL/Ort78xHRwpmWZG4MNYC9XDIq3KAnIYQtdMdF39CCF/yHoJSU90
 o64nC9NOPlc1U/a+sd71bBr0tjxM0/dLKD87EZvmu0bXSFPGGmDg2OTlR60SfB+flOQw
 dG5AZUsgHvf8XbhMZLlN4l1e1wKYA0Y/NYy5bbdGDGjuswql7AqZweHDCmAcsuDsnDyA
 CVbrh88KZpioWkYmv5cAabSIUh2nnX2tekfFgLPWmhI8uRh08CzmgMo8i2rAtdqV42xY
 Bd254sIVH4t95+52c0DqK2WHas1oD1UB9tr2Lwlq3+tjQ0Wv++oqRfcLoaHcWdv82hm6
 QeEw==
X-Gm-Message-State: AOJu0Yy/Vp4sgpcSev4GNlg/sdr85het43L0ZIJ//M20RXGxJ9+chHwB
 BB/yr5Q56UEhz2FfB00w+Pk2uqYdyf/N314+ph7V52QOurnaqjyw2yo5nfg1IVz7OvyqKPN9Vrv
 Y
X-Gm-Gg: ASbGncvpx6oV47fMUZPsoVOuDOBY3CJL3em436aipJkpo7fE1YZOWCkReaNf3BeA8kS
 IVDUPanN7pVx5vXIfNa5HNoSYNrCnPAKeGAnCkT3+CGQ1vup+/hNlfLzSucmipF4nUhC7++iGdM
 PAVvZyr1KaAde2b6IgvydEv3Ppi5h6ZwAsxo+5hOozswR0sPzPayyDuvyQZGNXA62kAzCc7nThO
 FPW8M+reKzjImKCPQBhupuFp069Wn5lcSmFRZPVr8XHIqRAB3CaOseZxzhZnGI+iDCJNS56IR2h
 1jytoTlwCOm2pWHVK4cvRVu5AG1NJUMF3GFHdyPcfr5Uob5qXJ5n0zcB66MPvn5Hpl8CWSN2TCU
 3jMwW+yujmc/RhH67dvG3oEZNs2db4g==
X-Google-Smtp-Source: AGHT+IHKS0VolGMti+yPO/iprcC8uUA491j9ca2WtNvcfVMjjdT2dTeC7QkFQArExouQ7aNZfyqcuw==
X-Received: by 2002:a05:620a:1a25:b0:7c5:3d85:728f with SMTP id
 af79cd13be357-7c75bbe691emr133517985a.25.1743460820727; 
 Mon, 31 Mar 2025 15:40:20 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-139-107.cpe.distributel.net.
 [172.97.139.107]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5f777eee6sm553088085a.108.2025.03.31.15.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 15:40:20 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Tom Rini <trini@konsulko.com>, Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] bloblist: fix the overriding of fdt from bloblist
Date: Mon, 31 Mar 2025 15:40:09 -0700
Message-Id: <20250331224011.2734284-1-raymond.mao@linaro.org>
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
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- None.

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

