Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA07F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 818C3843AF;
	Mon, 20 Apr 2026 22:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XKC2hquJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047F884258; Mon, 20 Apr 2026 16:55:58 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 017CB8421A
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 16:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90B063F57C
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776696955;
 bh=JcAIBR2DJEGJM/Qr+QQfxP2BEXnZB5C8li42YcMI044=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XKC2hquJIN3EZr/XzD4dmOOPPjKmgZDm3L4TDWz+nZ5NF048thYJKOI/uJwAGBTEy
 /hpNGKAB5HTNcn6WqsHZHB2uFIytLDrPDrm+Yrbl+dOyKQnj7YTF9capQc+Sdj4eFj
 4erCZhRq7uGGxGGlq+fFE5Mc7nHZINySzgUGOGT6E4emePGek5DjU+xkVBBRG2VU7k
 jEex6qrfgyAhR2bz2SV7AB5Vtrra0PlxPfU37bLxtKRIIpSy+wTYOs87JzAuFBYSYV
 PAV/rX26G/X6qLF1KllgraXhg7dDjEl7Qh+rVetN2ipwDxr0qnAyHDYNELwLImUTOX
 RJkljlvAUfViaiEtgxFqm9LbFvRnca2WskywNj+ooFbNFT/SB1/apSCJhiN2/PlzZs
 or2hT5v0mTsoxswbFs8KDPkFZ7zdRTGS5yKVAlmYiw4HVB4uarX/Qn7Y6sBl/SjEU+
 ImcFyeCsb4F0mqc1NclV88tnBxsfoPgRiNYAI7T4CPIj0JNwhIbiQ/ROtbWWIAjfkV
 moVv1B+ND2xIywY2Q8HKZvifzxPCz/l74WDe9ux+BAGOqAKIviWX49Axh9Tq7NA9g2
 mavtIimf2umWxb+RMvfOF6bce4UhfMunAqqcYzsIeI8GhzOiJqsdKz+PqrDVB6lPVd
 8gxnF6lpUFflg2qgl1Dgf+mE=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso39023465ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776696954; x=1777301754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcAIBR2DJEGJM/Qr+QQfxP2BEXnZB5C8li42YcMI044=;
 b=qe8RUAUnMwGaszLcYOIOTIR1qx/t7FKr8s7yc5KnP0x9T9nNqiP95V+JQj3zfqIHP/
 8C1cW0VTBDrhN/vhrIJ75bBoJzdpmljpnTr7KpjC2PrPxgyOyOe+Ax4ojVUyJfVA3Vz3
 zoOIV/4wUQNn9zJdHtKMJfsrkR69NLqhJYceTRQnJ1DXPHev2QJVDUhIhlVZmJGKZ7NA
 cMOCZPlhMpnOZcp4LVrxsMmvZQIQXjtALvHYZEEcB4CfccRcYu9quA9LnwLgpPrb2EnE
 WPpvGMSetSYwL5XlKzktrhwFQnc8j4W/F0+qoFObumhTa/vfq6vm6AUPioIigwset6C8
 CcXg==
X-Gm-Message-State: AOJu0YxxqLgucKvspN9h2MLA1YvC95R1f61lODtD5upmd85y1/mw8HEg
 lYFv01YnxRcMD86FoZMyKpqQmdxQVZuSmz+E0p3XR0i+r7OWvRSGPWQSBj3j2fUZUyNBi2kUffJ
 +kB2qNmODf37pnOFTRf/tyXXqSO8mJtIroKpLA17SrQQDG3EDoxqIQTsDnBWEMBzfLS62JYYl8u
 XqrF4PgA==
X-Gm-Gg: AeBDies92lh5U8PTijoccrWsmH2XVmrMSg+YSzbvo0fc0a/GD+qwL6ri8PjR/Ul1WdV
 sO3qDhmuDLs5m2XS2Tdgdnc7s5MbE5Mp2GcoybmveciUcZkosbLnZOaz6pAO0zFB0zbyO2XuM5D
 bw/2KHEnK5bBOsRWNsGYNyU/i5F6Dglk3FjbL7s/0vr4Aym7e5gZx7RHQHA1Ray6PnxcZVylenX
 H13B/GA7Hn7g6COrd4kcCkkxH8kKqq3IH+3kxDvr+Xo/VJtmQxBvv/nqEDR7yN87JMz9jZUsbRu
 K1Lo0IS8JiMdQUjKA3Otv+PPn6yPX0+wjmB643G/vG9eB0xo1iWnU8lFNxOarfQoUTctV4TFPau
 x3Vjc0l/npR2NyE6CzF+ZZxiSszGYGtPceUio2Qd5xPF693F/E1tyS0k0Ytd6g+C3UMBrErMras
 1I+MVCsVg=
X-Received: by 2002:a17:903:1104:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b5f9f37032mr157659475ad.26.1776696953847; 
 Mon, 20 Apr 2026 07:55:53 -0700 (PDT)
X-Received: by 2002:a17:903:1104:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b5f9f37032mr157659025ad.26.1776696953221; 
 Mon, 20 Apr 2026 07:55:53 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm113118845ad.13.2026.04.20.07.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 07:55:52 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: ggiordano@phytec.com, w.egorov@phytec.de, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org, bb@ti.com,
 afd@ti.com, d.schultz@phytec.de, peng.fan@nxp.com,
 patrice.chotard@foss.st.com, hai.pham.ud@renesas.com, michal.simek@amd.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/3] configs: r8a78000_ironhide: Drop duplicate
 CONFIG_SCMI_FIRMWARE
Date: Mon, 20 Apr 2026 14:53:38 +0000
Message-ID: <20260420145353.3923395-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

CONFIG_SCMI_FIRMWARE=y is listed twice in the defconfig. Remove the
redundant occurrence so each option appears only once.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/r8a78000_ironhide_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 64e2c278a7e..d225d5a970d 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -32,7 +32,6 @@ CONFIG_RCAR_MFIS_MBOX=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_RESET_SCMI=y
 CONFIG_SCMI_AGENT_MAILBOX=y
-CONFIG_SCMI_FIRMWARE=y
 CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_SCSI=y
 CONFIG_SYS_ALT_MEMTEST=y
-- 
2.43.0

