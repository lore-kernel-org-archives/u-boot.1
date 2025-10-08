Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFA1CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288B184054;
	Wed,  8 Oct 2025 17:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QDaA92vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2AE840AE; Wed,  8 Oct 2025 17:31:40 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF67E83FBF
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e52279279so52928065e9.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937497; x=1760542297; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLc2UZs2QmfE10NlP2QOwNYVjlGsR37PKg0zhsGi+3A=;
 b=QDaA92vplCzURSkI1MV6EA89pOsG8p/vuxTP5AFx209a4Kku0V+AKuHC47FgqvP5LA
 XcFI4KlnxPugtF7gWp6sDWSEyeuT1HZm3eY2Kj4yiobRBGSzHA09fhOwkGf2fu6GEmmx
 ioUtfC301bpvkKBKxqWemSeKQpxFGm0Q5pW0P/k75WocBqUnoZ14aLPBsiBjlaNaCyc5
 ClfHtfMuwbX1zYZq4J6JucQpJaizeCXHZ02eL3JHzr/OYzdlGyAzrox9/HvonBB+pWGl
 jAxKNT/Jng78i8bKkeCUReA9F1usLjFuGGdjyebIc+W6xH2pdGK3DfE9MpYkFq7tnl+1
 JgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937497; x=1760542297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLc2UZs2QmfE10NlP2QOwNYVjlGsR37PKg0zhsGi+3A=;
 b=ltGUi3dISj5K6FWNstqXigbFWUMtZUG7+ieWr0ZdPougb9egCLd7Yfd7MBO5aubyKB
 Q29fhYCSE3MO2Glry8nIKocTZxO1i+g1q775UrfrrLb/eScB3oyrlYOtTzVuGYeLAvgz
 kfCp8RVLWUEicA/aY1lbtvfnn1bsCsQM/KPRVPnMsda7Ny4yYJuw15F43tiOykGHNHhh
 AbogX4/PAckZdx5qOkt8AohotCQaUvjm5cpEKNVQ2Bcr8jUTgOEv2A2AdtR1MvGHvDQI
 FF/JShIO3gYCGjFlvSNTe+GNPwidLfoob87wNtjGZCO7BzGlUrwEQjLEZo0XwFfvsU2u
 CNtQ==
X-Gm-Message-State: AOJu0Yx6jQVxRIgdgDQtVf6B1jAvb7LSzFwd8UxQ91sOOAvpTWDYMImE
 VA1OReNDOSYMWbuVfTXvSg+hXRjcrsSDlv3p85iA3Zw7HBUgAAkgM4XerOK5ycLQ16M=
X-Gm-Gg: ASbGnctMuwTHiPbxAG1pKCQStVVMa+I7IXL9+ALJL5R42shZv63v1NssQpoRdyFx9gq
 IOYqw6pEzOmWldZoMYHPsG9hz+58+CDTeQa4Bl5T7UZflJ4onRauz+FkuUbQlmLPbrJpS9s2Fbm
 IyNYVjwjMnSvMiAkRDk/6jyOmVWhBilDLHMP8JNpZGJfiKbVwErJF7w1e8uaVQZ9OxGXPE9utjE
 rxxrcG5YJE/W/CBo1RYMyPa/I6yV1aaJeBj3hsTLjtWyLeG6eJcCujxe+xuGZZHwNz5rTrmSPmd
 VqWiZfN04sH78a9UDip1UW4dQ/wOWZZYKRb4KMDcaiMP5m+XRLs+VY1X3tHFQW+GI913VvXh4Ej
 8qPgfIHDWsM85nc5ZU5uL0t7/qyXZl4KsIJNMqNuH63Juli2BSjPvXMYk3nT0qvUiRMqZTyo=
X-Google-Smtp-Source: AGHT+IHlMRrVhhBXrpICJmrsZy8SM3km266nT9XujoTdyDEz1h+CR7IkS1bOep7bs9cz/lgAgefH6g==
X-Received: by 2002:a05:600c:1d12:b0:468:7f92:5a80 with SMTP id
 5b1f17b1804b1-46fa9b076cdmr27610975e9.27.1759937497240; 
 Wed, 08 Oct 2025 08:31:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 08 Oct 2025 17:31:30 +0200
Subject: [PATCH v2 3/7] MAINTAINERS: add myself as Maintainer of Interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-topic-interconnect-next-v2-3-c46e94dd328e@linaro.org>
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
In-Reply-To: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=806;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tpIScB5BIfUjQ19fjCwzffGusQIyNnyYzIcu2rgY98Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPUB7tCru4NPwZ0shhvQxQnZpvxtJhfUHTWraOz
 zMV4gDCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD1AAKCRB33NvayMhJ0bhvD/
 0XzImHDfuvSf1bnkxu9tClmW0q01Rn9dmTq/ICHL9WYFWM9y1jZ138AR5g/hgZCeeyro/Bkwp9AQGA
 DUsAlyyvIhIr3XE2Gs0tFv/B1SwYLztTaw6UHLEhCN/B5ZH4Ivy5Qn8zje8S8C2lSE6ltFveupcFdw
 ElW2aOwTv+hVDt8jqbzO95o8Nvl0pvAjPBDFVp7+NKIg7qeAaEtdtN6PjatZKmy4kKzWZOnEVYD3y6
 DZKBxf7u+g3Lugdg0N1jooa2Em+rHB2kW9Bo+mPyiFfdn48YMrUTtVuC0GbU9Yh4EJA+lJuXrGYZ3y
 wu7z/VMM2Ia/tkTjk6S/XwR2EdGvV3MyV6KcOkaH6FOBl2z1HjUZJPySi6kgoRPEzFvpqaotepA4pi
 DCxaNvBIzjBAeFkcPhbidI0wedHh7vOwPrK7o1FtI04vTctx93N4N+kIC0Uo56cYG55/SFDRnMJlGu
 E3Qb0Dd+CVmLduyVDqY3/TUTclbTHURd5Uuj41bKXrFWwa7o0CfY0iPJr7ryadJUYGDuxvj5xZDlCz
 JYIhyCum6rMvwBev49bJjAwUg31FQy5Hllxa9aKwgmD4GHDyRzePEuDqqa42VBDPDYyePRFb443m+G
 4qdYYiIoiE5Eov9GnPiZ13T7sluggaQ5jlf973zbasMWwK35Byjk1vz+2RrQ==
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

I'll maintain the Interconnect subsystem.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb163aa1db1dba249e60b40ab3e785db4fde5d3..fc48ffe99884137eb407d4ed52a70ce51ba15e04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1244,6 +1244,16 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+INTERCONNECT:
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	arch/sandbox/include/asm/interconnect.h
+F:	drivers/interconnect/
+F:	include/interconnect-uclass.h
+F:	include/interconnect.h
+F:	test/dm/interconnect.c
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained

-- 
2.34.1

