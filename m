Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE68D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20318415E;
	Thu,  8 Jan 2026 20:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VtlNdUdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A29F8415E; Thu,  8 Jan 2026 20:53:10 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A144384150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so5477844a12.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767901988; x=1768506788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kD+ouVanAuspVW3Z2aQmnzHRP0J0NxZXsqgW8MeR8IA=;
 b=VtlNdUdCCe3ky3Cf8sHcx8KB1O5wWibsii8iRK5Dq/Jda15GC4Qyy1mJxlEIaNiEM2
 k9St//4hNVmofzq4KrwlS5oLSh378V76U6Bah5K48qUNSafF1bLxcecU2AMahH4Ci8qO
 /gK2dLY1z4avZPPyFlUlqxsrX0UCOaU31sbEO+IdhLdJYNFX34wxvQKLMqabhXHN5dAp
 H5MrudeAqcf82WxSUJIRbMn07KHW8T34c+5LDC4nxheW/HgnWV88co3n3HYKmUKMbmUy
 ghjxbf3EifsehgpzPTts+if4sYmaLn8n9V/91Is7TjEl3DPwZN9LdTObDbVuVTFHnmqH
 ZooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901988; x=1768506788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kD+ouVanAuspVW3Z2aQmnzHRP0J0NxZXsqgW8MeR8IA=;
 b=XAJU4UDlaaZqezXbD5mR1IQLxIaHFEm5sL9X0ciB5/K0xo8e+iSfUffmS5EvmHzIob
 l61JTp5O6ngvBfdLRI6rXi4BTULOPqLErKRIZ5PjChE0fFEaYg67a11clF+Jno0lgF8p
 vuzO99zXxGW5Wax77K/YK5CRQx8HI9QziAysYMoOAqQvmjxNiXxqsWAMH3U6Iyt8GzJk
 LIjlYfxbXDJphZ3DT3gmPoD/SPazs5EbnPLJ1XFHffaYiP0CQ2whQZZ298rlPqhGAFeI
 geLIb5LpbmmARIxHEpYUwd8LVcKdvwbQucznYP1oTq8vqKYSeiQOk5BS79BAE0PQ9i0H
 H7wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Pwd4t96/3+KFU5By3QYf4+C5ie+r8XfAsUK9WkZ/UUC8Osbt/8olsBqg4qe5i8/yYvYrOuA=@lists.denx.de
X-Gm-Message-State: AOJu0YzFUSKLxyEAHV2Pl70dOXRtzhl5m5bEPzgW8LATQUp7ZXW5nlRk
 BkAV4boS0rWaCD4n+cJRYS91hkl4DGMrQn4pPPoPY7c/mQVQ7pYwxNw8uQTmMN+UWlXiI4rzqO0
 +Xe1u
X-Gm-Gg: AY/fxX73cwnPED1Z3Rzo9CrGicgm6qWkGOljKOe8OkkB/wGJ7uwAFVyedRrjTLYb1B3
 VmgYfCQByc/sn0OGl348ZVWpdvezATeMtcRf5FRW+mpGMVnpoLpAyY/pZJvMIFu5OKZ9+kY8ACQ
 f8icnUdquQ9U1dHAHRdk0PtZtu4ajQLLMl3gcLAXPJJfgJ/EhtpP4Lw31REefyLUZ24sCeHNDh4
 x+gxeeW3hyr34ozeJDSLavPDEV8fx8jjYtAa3GLwSVi3CagTvzYCl1cxIh4LYq8Nkr6JgXdUTgi
 GKaCnesPPVsh6yqu8kNqko9APowSn7Gue9kALguksO9N2Q5lmU9j/xhMnaDws/Jl7a0IbdBsmCY
 qLgqP3G1HrBoOZ1DeTkzFoouT+63L+iHKsponEltJtifxgPvFrGyzpSy5JSjdxX/8lJBGiJ8Jyb
 w8hznc7Unst58IRsJLcvUJlGmmA7KrassEAxTxuOGMWg0onQvcklzgtNKSMfknNQ==
X-Google-Smtp-Source: AGHT+IHdpA+NmAmApRzbIQOab8on6oa+xWtNjcPouAhLWNUZM1Kz0h2Dnbx/uAj7aAgxcpkv6C5ehw==
X-Received: by 2002:a05:6402:3481:b0:64b:6ebf:b65b with SMTP id
 4fb4d7f45d1cf-65097dd295bmr6202341a12.5.1767901988073; 
 Thu, 08 Jan 2026 11:53:08 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be65197sm8541638a12.19.2026.01.08.11.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:53:07 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] i2c: geni: bail when clocks can't be enabled
Date: Thu,  8 Jan 2026 20:52:55 +0100
Message-ID: <20260108195301.3159260-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Failing to enable clocks will lead to bus hangs and the board crashing
in some cases, let's actually deal with this error and fail probe rather than hoping the clocks are already enabled.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/i2c/geni_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index d29e00fdf41d..fbe5ab0ad0c6 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -493,9 +493,11 @@ static int geni_i2c_probe(struct udevice *dev)
 		dev_err(dev, "clk_get_by_name(se) failed: %d\n", ret);
 		return ret;
 	}
 
-	geni_i2c_enable_clocks(dev, geni);
+	ret = geni_i2c_enable_clocks(dev, geni);
+	if (ret)
+		return ret;
 
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
-- 
2.51.0

