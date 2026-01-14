Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1592D37E37
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A19783655;
	Wed, 14 Jan 2026 15:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q7EHMVTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5771E830A0; Wed, 14 Jan 2026 15:13:17 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A8E830A0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so15121605e9.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399995; x=1769004795; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pzsLHm7D3H4SnjLgxIS4kTx+c4mSLhX7lsBrIdTjZpk=;
 b=Q7EHMVTVhAAKhr+JRQAyo6scUSuiWmtyd0ukiNj5wizp689y+m/45Gw6L5fturY0o6
 ddv+knAS7eFYws+vg2eA7TG+V+N4ZvVxf5eW+B1FVONWWLfhzcJ/RZwcvLwObGrMFUdb
 R1T8bJsTpJQJW8DYrE4ZD6BOuEUkIXbENGb5dFekMrK/sMIOGr+ApbGRsfQGqy/jP6Hp
 jfTmEdLWut7cZ/AH0sLsiYrJEWq/b42BMO0p/EDTM3HWyoKNigig9k8hCgxHn7Tz7lWS
 fwkspGs/aP10yh6IRLzo4cG8fKpkoMCGIOxp7OHrQpwk1GhpPDSqtQZpjouNlt0zGOGR
 w6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399995; x=1769004795;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pzsLHm7D3H4SnjLgxIS4kTx+c4mSLhX7lsBrIdTjZpk=;
 b=DuY/rGhLrhEZt0zGEFnopnVj12A0dSZwElWotTSbcOEF+UhTH5uWo21Fgw8nfaCO6r
 Mig5EFvlnAwcfc+AZuKDOP/RyLuE/LNVuX5NWmKvTxw7t/Fie2b1bPaVRU+ihOPZDYuH
 5E6HAZZGcfoiXdN43M/12s3xSuii9rVm4rfDVDrIfyTBQF5obzEj9JqBb9UqewikAte9
 JsKJV2j5uNAJm9fluPp9j9vZqHG/rB20PQ46GR+vrczvLlV+x9U+Uf1DxF6dKpqmRtC5
 jj1Ofyq4e8EDSSfbc0yVeBJ2955dZKHlIMaLeNCmieWCkVJgyd6TvZoNUrNsE5Fi/AFA
 /v+A==
X-Gm-Message-State: AOJu0YzpnP59UUhdhQkKPLbxwgfIiJOKYNsn/dFCchVEo8IqP91n82X3
 5KlFshq5VRqQlF/Hcyz8yQ9sS+mYDdU2YOc6XWAYNSkfCHzJIG//gp8CqyCIt8f3pNE=
X-Gm-Gg: AY/fxX48kH7n/KFme5SARsxdkpo7dbct/it2CR4ip58sm1jaALn1UrvzAZr8WYLuAFU
 293d09laYJM9MaybJV1Rz/k5M7OS695Bo5bdF6XbY7GnjDO3WaY9iGltKEwnQFHP56L8S/OknAf
 Qts21gRPWk+vtblZ1zyaZv/bQPuVnxJPaMM90VkYgO22uzzcFE3GNTjb+mwxnaDydBeeArnxyNd
 ONd+OaZQGdxm3nIyjnleCic4+01rqOEtPJUDvNB17p3mT4bccpqCUKzHkcaNmMmBwD/0CN9H3RD
 fhN/iVYyy7lTDd8oJ+tCeACE/FrTdycu83kHt7Ay0D4L9ceOZ2vQQxmR297ijsO/NWrTn0CEEf3
 4jFkEu8qRU+8M3AstVlf3IrqizHW+hwlXeqTkXuCfueOoAc1caUlyUeM6kD6kdunCzETikTs2gV
 MN0/BgOaRQMqbX9NyMOGAbk8iLbO8VQtZozv3/k5F5pFZ9byaIE3ThAA==
X-Received: by 2002:a05:600c:c4a6:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-47ee47c8db0mr27926545e9.9.1768399994716; 
 Wed, 14 Jan 2026 06:13:14 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee5910fc2sm29279755e9.13.2026.01.14.06.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:13:14 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 14 Jan 2026 15:13:11 +0100
Subject: [PATCH 1/3] usb: common: default dr_mode to OTG when not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
In-Reply-To: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ziTRUmyKY102AO935l7j8W5dBx9qdPz6OJggXhSA2Bs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsz0JRW6FyoYRazNlcx/ps/dM4G3NWr7p8//HFOv/H4eW
 Pp9hb1MRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI/iyGf+ZSVcsOuO+rTK3Z
 fZD7pczd7lvLmK9sOvN3rYTv3IidVQ0Mf/iuv/D6/1+ql9/dcwfbzNDmnr0rD0msnvru+zrfObN
 aNmkCAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

DT bindings dictate that dr_mode being unset on a DRD capable USB
controller means we should default to OTG mode. Adjust usb_get_dr_mode()
to reflect this.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/common/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 13e9a61072a9..e3bd7339e68e 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -29,9 +29,10 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
 
 	dr_mode = ofnode_read_string(node, "dr_mode");
 	if (!dr_mode) {
 		pr_debug("usb dr_mode not found\n");
-		return USB_DR_MODE_UNKNOWN;
+		/* Default to OTG mode as per DT bindings */
+		return USB_DR_MODE_OTG;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
 		if (!strcmp(dr_mode, usb_dr_modes[i]))

-- 
2.51.0

