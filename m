Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109C606A329
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wu/38IBM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=awE/Fuez
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF2B0813D9;
	Fri, 23 Oct 2026 11:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJIIb4k5_Wms; Fri, 23 Oct 2026 11:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99005812E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754188;
	b=jjUYlUbgzAYT/Bwr2wR/v3V7LSUZBUdoXVTfWsQkUUe/xwyTsHLOCOpcJNK3gpE2fMn9
	 EEyduyt7QyfGeUfgjKNe+Pm+7tqMMcIhSfLBV1jB/6DnRrByJgckKrXMQ0obxD/eHAGSI
	 zY6oPD/XFuIWv+qV6dLuHDHOrdUV8J7moZrwczNFnhorXC2t+3kG0K9fuiEO7O243Fg/a
	 Ha5u6Ej+wyJWmCn0KZYgDic2aT/JVk+qiPHt9csDMjqEOlIih5nleIBr+CLf1rQqttw1o
	 3rT7ft4dvhD0NxwVWjvH9YVSvRpcAgD9mc//xCUNCD54MZAvIVfzDkBCvTmVtJw2UMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GA6RiSRUxRbS38yrJA/FxpGiYZW9HWb/6eDCp03KjRw=;
	b=iCuijMVEv7xaArLpnpKhH3qdF7PiffvuwFE5WjfhR7ChcfriF2i0wro3oY/h2jeahUuF
	 iZGlfbKNq60Syo37SMCXRk0JCsje1Xww8k7T+k1kaTUnpu1qO8jqxZca8Plel31GPcQNl
	 LAyGjETh1zW0M5f2oAyRpX/P19cbSMpbQGq1Z/eG4k7FUqzwRTdMSxNB4FX9PLIg+IvgY
	 TEES+6C4g5Jtn/64TTk3qMQ10O3IXSH5a95mEPRjohCz/2ubdhU5wUm3VRVRxyrmI99UC
	 F0qs2IxiDyolBFluftfuwcoa6r1W/D7Gf2FZwHDttd1rybsaM3bSGeMYDFzOwpKcmGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754188;
	bh=GA6RiSRUxRbS38yrJA/FxpGiYZW9HWb/6eDCp03KjRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wu/38IBMv5Rv+sNHxI47p96Dg0C9Eq4gcWxqjGty57hrtmcIynfIzL5Kvi0Sx9ftH
	 2NG/CKddmE2v5O6x+WJ7o6GxHIFRdRvYOLCwbwAOQ+f9Zgkgnz5z4UhL7KWWWNbJXu
	 xxXODS+kBqBmF/jM0NcAONtzyWazrR3RwkAA9BEBYZ1dnRcAeY4VTElf2JQKki6AsV
	 NOjZyXoV0NUM3ptELueAcqzqzaoP+AQnb1qrwnOIW59i/5eYtRTvVNvWrJxwwiGs/K
	 uVfUe5P3q2RNqpcYrixV09kPi/1gCVQs0oaYD+nFBguOVg8a0pSqHUGCVG7yRM2hcU
	 YqBAWth2bFHUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99005812E1;
	Fri, 23 Oct 2026 11:16:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06108B02
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFD194082D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypArHMlOkwxH for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF5C74083B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754174;
 b=sY5S0rYWx+2vxnjTUYwbXWFgvyDELnvdn5yBZWAC0XA1IlZKgkcux/G5bs58rEEFfcba
 BVsV/Ho0QvY4oV4tzORABeAp8nnJLEGmu9gf+PA/Z87bSH7LiApV4XsQCw3RIvsAvbFri
 E7wOskQaS4Mt56lo+QoG+gVNQuTrCWdqPpRsiQfPpYIpKAatBoYhQJCQG9NCDkPu3AVEL
 AplA3ENsEjnGaLTXvpjJqPAJ1bezytIDa3xyj+cVkhKJ3DrZJ5LJh72RNFySALbwOC8Kx
 nBWgrFJ1n36xnEMG6euih/FINumuwToVzmC+0ebAD0GLs51IrNpfPS2bqXar1c8J8pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754174;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=GA6RiSRUxRbS38yrJA/FxpGiYZW9HWb/6eDCp03KjRw=;
 b=pnHVbyNgS1EGP64uNSvXTYZSbIKi3GIKhQ8Hl+e/FEVg193f34duSjmCulWQ4GYZRyuA
 bv8WzgN1LZwO3KgLw0vqAkp0cTlG5htKNVdjTr/65vhl/LqvVB8FifhTKwGrNzi2bk4z6
 m86ZZ4n72ghXede9oGCaqx8SK/FQRptwg6uEjJFDCzXb3w0NShDZ308/YjjvDb4gQskef
 puGV5UhH6yzmlBh/rkvbvZw9UG9nNaRwVMCCk3EzZL1UfBp9QsaDuspRB4qabP5WV//3O
 EtHiUu+korwjfjYAfKujtXUN1zzyailkIw+egv0vGGIPgbUOqOhBb6V2xzja1NAFbbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="awE/Fuez"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=awE/Fuez
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF5C74083B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:12 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso472699f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754171; x=1793358971;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GA6RiSRUxRbS38yrJA/FxpGiYZW9HWb/6eDCp03KjRw=;
 b=awE/Fuezh0xSkqKMQb3n+gJUkmsWM8127Jb5IgyraJTSIsI+FD0inHXd8P8sED9CZi
 ql76KAQovK8nSLBKRC3bYZ0APTE6Q5/7J0b/Il38vl6xf1APC20vJeSS7pANBJFUGi6f
 mx8vr41C6VFt1KBsv2kHqRYQyN/q/uzcRW0A2x0ybkXnkSRP+O8lqoCs/Xh3pNkt6+4Z
 K1tMxZ/VVhYwSuLZ7hepBNSRWnOKyhqwq9yuLfmJCc7MpAJFX0TGcuaOMp7/foKyJi+9
 Yx8EK2xJj4R5u1LfT82v40dtg8uWq9n1uAxdQX0ghJGstaQ1Jmth2N+wdH0NU6XK70le
 70ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754171; x=1793358971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GA6RiSRUxRbS38yrJA/FxpGiYZW9HWb/6eDCp03KjRw=;
 b=Cj/s3kcIk07AJ0h4TE0ujCvGIRBc9l+UNfmyIVNifRQJVrLpAz2WlG54BfE7vc1itv
 8fIMBwb0+pMX38bJOFYJaLFRKeGKiUWIEbJ8qNsnPCpFimHYAk+Cy0l0wiBRmWRyC081
 zk+r1ErqBvxPmfUg+yYG+xZGrhmRuYQLTP2IJSKp+A91dVwCwK3D51E6PC40+x1Cyz6J
 NgDGCHrz43gCXNI+3rO/TUEZu7xBiWveN7jJXuXhMRdTGMYpYtETZsFwdumIaiK+nWa1
 4zt3VEmwj4Zwx25WhdzTIVZBeJl5EAqEglRwXzBJ/9TviSzx9Hi/MDQhfZNIZMRkm4dS
 wiRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwta+pbU+pcHiP1MSIlZPRqwJDlZjgfrudNiUmfYHAv01otlsXNmhNVWWdpxEQFUO7+qz0QCMo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLeYicuKZOPlxUmKKkPrasEB9YNDUw5Dx04I3xwT8+qM/tRIdQY
 FS2PWi+XB3c89jDaMlaA557d1Mt5tKTWLD1LLF0DRNxVl1uFoK2wYDVC
X-Gm-Gg: AYBFou0fcOWcjRa+wPwW5rmYW1wjeNiO8Z2Zf88fU6nWi7Gb6RlzDzyr9sVNfFxsYw5
 YOhdW/C0xMBPOxUn0wPM06FBeeNvwp98zKPCoIdYbmLSogKAwMsBT9MjNi8DrQ+rWsHLfCTQyKs
 OFUB1UHK4fk8+t1lg2BU+uCG7WqCdscM/hoYDFmXouUXS5iLv1mzNv86EsD94UF7+B7ku4OWKcc
 FMZerpmdqtUCrvRKToE7CNNOWDIEJAhSkKsVBNvjXzYo+AfWqV5WTDtkDXLGbWpsv1FngabOHlx
 dQ1Hh8IFigusOHSGAjvVzJKAvJp/kVKYbrXXbPp9yC51LjhwuOlkGriBaakE2hGxDSFVy3s0pz+
 wTJSi3YK68Wy0SNNN645w7rouwURkp+3Iq+JLcDVriA31yuFrnYjGbfZeo/dn7X4Mk6CwGB3/j9
 vPB2mx/89sNBHoF5tvqyXwculGGy2lwonjHR7ppwSU91nVzMGP4Tso9iDCsgcuGaZ32+nR5j74E
 lNL8d8yTgNF6bTMFHmdlcVQlr73UNcdVcowYLAS78RV4mnhnGa0SxOBpvib9g==
X-Received: by 2002:a05:6000:26c5:b0:48b:11e1:8bc8 with SMTP id
 ffacd0b85a97d-48e385ae3demr2880496f8f.39.1792754170673; 
 Fri, 23 Oct 2026 04:16:10 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:10 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 8/9] usb: ehci-vf: sort the includes
Date: Fri, 23 Oct 2026 13:15:58 +0200
Message-ID: <20261023111559.4081795-9-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Put the includes in the order the coding style asks for: the top-level
headers, then the ones in subdirectories, each in alphabetical order.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - the include the previous patch adds is sorted with the others; the
      Reviewed-by of Marek on v8 is dropped for that line
    
    Changes in v8:
    - new patch, from Marek's review of the vbus patch in v7

 drivers/usb/host/ehci-vf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 46d8f6b4461..364ac5b831d 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -7,21 +7,21 @@
  */
 
 #include <dm.h>
+#include <errno.h>
 #include <log.h>
 #include <usb.h>
-#include <errno.h>
-#include <linux/compiler.h>
-#include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/imx-regs.h>
 #include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/io.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/regs-usbphy.h>
+#include <dt-bindings/clock/vf610-clock.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
-#include <usb/ehci-ci.h>
 #include <linux/usb/otg.h>
-#include <dt-bindings/clock/vf610-clock.h>
+#include <usb/ehci-ci.h>
 
 #include "ehci.h"
 
-- 
2.55.0

