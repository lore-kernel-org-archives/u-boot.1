Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B13CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B419893FB;
	Fri, 20 Sep 2024 10:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/tqhx/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7631389439; Fri, 20 Sep 2024 10:00:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332B689413
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so13744285e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819245; x=1727424045; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JeLKja+MavrsLxBtauv98C99CzvsjKPwivvG+QizMjE=;
 b=M/tqhx/3ImytjEeeoXFXWECZhuHplofbHks0JhulVjCBS0jmvQ/BTIKpPG3dkMPRuV
 gyILL0J6kB8vmULLYIImxZrHi+u34SU8gh7Y67rc80c7wncj+PnF1rEo+7wRcvVVZdTw
 HE0mMdRFahvQ8Co133mgKaCCTjbvUlTLOnG9U5mbReou0aIjxi5L6p/sawrmgSds5xEN
 PynV5wZYAysS2Kug863kQYs5O4TQuJhdfW4Vv3gvGEv8WdCpBk9gCgNBUV07uTb8ODat
 HAywangDmdG05MCd78XZK0Aey/H99hoquWuOnwmxxmPH7buQWVi7lgYZOWq2vXPwmiPe
 9+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819245; x=1727424045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeLKja+MavrsLxBtauv98C99CzvsjKPwivvG+QizMjE=;
 b=g8NAK6/qrmz2tZnOC/RyosCpHrZ+iVOvbZ/OMFx/31LTKq+kAWjoCWhiJUQde463jZ
 K5qjjNGOZa8K2WTV83tvP3lWLq6cow8kyHr1IkVCqbAAHLKSBr5TCn0+u+JZPB5rSzy6
 2oUh4Ch/xM3AWioJXVhY1j/H86k/1MHrMKx8sf8+k3MLbOoyt3vckMFTW6ImmRW/Wgbf
 CxF13Zcz5hFXZ6yNZJ6JxRRoLxrkRWvL2TZwsIm1+NGlGQw096sXHzc2y6oP8cIpeSUp
 8EJky0HKemvZNMv+eRi/zqVa/Lqkm1k0D7fFuG8EgfHNrnrg0ToAhp2CVP23biJ1woBN
 M7kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwqezgXPs8M16iEtrlqXjh+ljFtVspXPL7rQGNQVQqgrVGSVg37N3YGA33DiI956/FsTQHeXg=@lists.denx.de
X-Gm-Message-State: AOJu0YzW0Y7gKVilqO8YccOpdM6HzqwCVfBHB8VuqeK07mbKeoC5PyzB
 b0MZa64unR9U9+wDt2C8FXQGt8C14Nm3eiUFfqBlBXOyiRPcmWCalobshDvz0h4=
X-Google-Smtp-Source: AGHT+IGxYvIlBgRcAzaEmYfY+odqNYfHXC9nObrnzLHx6Nt+aMFb1BnKDMfIeOIf/9v12dskBUL09g==
X-Received: by 2002:a5d:47cb:0:b0:374:c95e:1636 with SMTP id
 ffacd0b85a97d-37a42265691mr1138817f8f.21.1726819244621; 
 Fri, 20 Sep 2024 01:00:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:00:34 +0200
Subject: [PATCH v2 13/13] MAINTAINERS: Add myself to the list of UFS
 maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-13-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=teMxOUDq733hig/kyMWLnRxRkGZD1mGA8yJ2cdp3EP8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SuewkcC83t3WpjcsYCkpXPs7vBVzbMxCETZJ3Ef
 64I0UqWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rngAKCRB33NvayMhJ0TNVEA
 Chv+8JI81NGOUnRbq6d1DXgB1ym2JdBcY2oY1aA7eaVDH3FOPGM+54pOo9ZIWj1T2PH6+5be/lY6hr
 j0jJDrhW6HpHAVIieKYUDdFPCCX/dggwxPPK/jlrR0DV1GLv8+Rxr7tip/TDr09O/R2maBrBeQPCoL
 m68Whzby/XT87RnbJnoDOcWSQ+KIql5q5ntrnjidcMcuXZPYUu6uJOXh+ayrhFQyfT76dvqkf9aeyD
 05BE3TL2WVwM8FSjlZygXccf3DI/tA1EAn/JwmgdHLcsgRTPlm5jqtCJ2T02iQja7OgbiG4iGW4HTA
 QDLO3EqErJ5nELiSjIlLnUKQr6FkOil70ObX7Y5P1udzKjhL8NqYrrr//u5AG3VT0KOL2siQjdoCj8
 J838FNbb30IxfDTtqGLnIdYuv210zlTKbL4HG3i1i7jDgafBmjsYQsO0x7fwrXUjPP3lSB1NBu6eXN
 kyD5nBSu6UA3/ceWbEUcEuYzTl49aLnc6nNex4FRxf/ZK7n7uBknfIgsE+sX+/gatApqqYBWk3dOSH
 9PBHqrwrNFaAbxQz5e0JQ8RVsvQQ8U3LqpX8WtHit5LPUgWX5bk9LNZjj+jfM12NTSB6VKVi69VPnu
 lxib0Qcq02cSJyq/c8P1uZubGC7lHiflqUmuK7L3r6/IbTJXq0AC8of3y4Qg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Adding myself to continue Bhupesh's work to enhance and fix UFS
support in U-Boot, especially for Qualcomm SoCs, and help review
patches and maintain the UFS subsystem.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ab39d91a55..14809c057c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1707,6 +1707,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
+M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained

-- 
2.34.1

