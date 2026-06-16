Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B679CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 13:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED56284704;
	Tue, 16 Jun 2026 15:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQcYc74W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E241484869; Tue, 16 Jun 2026 15:11:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C11846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 15:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so43770115e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781615502; x=1782220302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9ZItGk/oV5TVBjXx1muUBqUYF7RmmQUm6sJrPXJxDg=;
 b=oQcYc74Ww4FtcAOEFdyP7SIFFzdorAw+cEksPfiLxa5MmlA9rd32yV11jYuvDPzxfj
 lSXkCiew5e48B7VPgGDh9ab8codIn4avZm8GMVQarMJGlq5K0Qw+6S1sv5RpcAWT4HUJ
 IS8VOBG1DhuO3pb+EQCvOyWwR5xETZUqMmX0vtmYi6WM95+CmFTgrFccoOoamFcL5F2V
 DKYC3ALVz52S1NU1i3zuFhoO51KAr7C1dzvEt90Rdu6GePEa50FUjgy/lb4TSkn315Sg
 w9ACNxNK0MNAM6i75Rh1Td741KTPcOYoye0WoOR5l4wwBhp2d2bGPkHvMBVWhtKr3HHV
 Ii0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781615502; x=1782220302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9ZItGk/oV5TVBjXx1muUBqUYF7RmmQUm6sJrPXJxDg=;
 b=BfWRIW3v+FG+GX6ASd45daaCVE3qMPLs3+AUp8FccK40YJc1Jss92ljJO/XieUG1Ka
 jlf4ugHsOL+W1h3SvwkiEw29gFAYp9dPZdORi/PN/O1YCad7jgcf5CFd2owJY78h77Pi
 9gO/WQXT2qWEIEYn+pPTcqWtCx8jMNKirC/mftAGIjjRqdLILYKHhoKCEJTqRefR/ZiO
 14mEiRVAAuZL3nAEF+EyXhQGDqfS39vVs+ejrhJdbu85Sf+XSi8RzlhhLko9vTjb2BRx
 q+Ndd59IenYAB4x0JUrGgwnKdqt91jfiFGk0HIQUogIPyjUJZx26Va+jX8iMzCg3Vf5r
 sJ6A==
X-Gm-Message-State: AOJu0YzP66255Xcgql5DSDpOcPr5plVKu4D98sagseeNRF7DzIyJWOYa
 z1rHYl4y7kHoUJvjPfO2LPm47zDGly7VxLAW/MFlpfTqywtGgktYd0WFHQL/b0v6zNe1eIDvEDw
 GlwoheEc=
X-Gm-Gg: Acq92OH4Tn+apZjFOO9aKtQXvS0C9Wf2WU/im7c5au9yr7lnARXjiD9/ns65rpwC18w
 m2JVwoEn8XkvtVqQhlxlqk6MdjtNvrweHLa3RyxbzvqCVU1YERZ6k+FQqKioT8sigsDaHORb+TF
 X7O6Uz7wtspoD9ZXj1Mk52Sjfx2McojS9RxysKdweubcV4t16h2DJ+tdFpLzXCNO8oaaeUyXkDG
 Uu/Qp0pi3a5P2rj5nfoMn0olcPv14O4gR2gPleSTGMZW3G3ZPEhi4oEkOBtmai8rsixV3naGKST
 yO0s/8cQ/CbbZOX2r+vW59IjACq3iMFOfBdGGEZDlCyJszK2L0tKf+3J3M8jhlthbh7jjGkZGV9
 kyhZd7s1+1ee4qgPL5lYnWlG9s9U8wAHIokhxec15up4Lu/5RcVQ7vxZSSFAAscIpKgNGYruBCq
 tMkX+L1g+/IefpcfrrqX75KkXRzQN/ItaonSu7L48O9aapFT7oGJU01RK5CWRsGF3lnuCSGGe9+
 g==
X-Received: by 2002:a05:600c:a20f:b0:490:e19b:9632 with SMTP id
 5b1f17b1804b1-4922fb071acmr37826795e9.17.1781615502213; 
 Tue, 16 Jun 2026 06:11:42 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e032.dip0.t-ipconnect.de.
 [91.41.224.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea9563b8sm276968355e9.2.2026.06.16.06.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 06:11:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] get_maintainer: ignore Tingting Meng
Date: Tue, 16 Jun 2026 15:11:26 +0200
Message-ID: <20260616131133.2143136-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Their email is no longer valid and bounces, ensure we don't include it
in get_maintainer.pl output.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 .get_maintainer.ignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index 899a1469b2ae..5b7d84646f62 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1 +1,2 @@
 "Pali Rohár" <pali@kernel.org>
+Tingting Meng <tingting.meng@altera.com>
-- 
2.53.0

