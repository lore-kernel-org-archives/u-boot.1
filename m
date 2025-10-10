Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15871CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2DE4844AE;
	Fri, 10 Oct 2025 16:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YWD7V4Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FC0842D0; Fri, 10 Oct 2025 16:35:21 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2C083F70
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso12743045e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760106918; x=1760711718; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4VWSIro93U8AX65eiTscrmX99O/ZIAUvE9kjmqisEaY=;
 b=YWD7V4ExjaYg3ApLdhStXryxCgN4kUR2yO2TrZKYJcX7d/LM4YzDYCgKKrkGNWekg9
 jglth0J8MHkfxw7odOCZKi08Awe9kGtIKTo1ANBj7Jfyo0yFaRHnr8/lGlr+F3XeMtxW
 +X5Oa1pVxR9kBEzoAesrq8SJDg9QQKoFXhXtPRXZtarJvaiEYLzxLctndERqPmeJvfpY
 REoQoF05UKxUhDZvrd2YzGOWxjN/KZ1Yh5nnG98DxRZ0AzbXT/p2WSCaJAg6gmMa/E1s
 feo3Stf9tuPHUQXoKu+hvmLB0TdLxUD+TsemTcZa1M2j0zHqWQEShMm47gc4ah9RXNrT
 1xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106918; x=1760711718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VWSIro93U8AX65eiTscrmX99O/ZIAUvE9kjmqisEaY=;
 b=LrFhb8xfv53cszNvGALXhTICJwFxrBdt1ov/bPqmuwPXQDZ/jaSEOwzMHuKhIZX6ba
 T2TZOJBSlScdNrGl9LMlx6b05jf5zP8jjbVaLUxIyi+k8o52OMQTmhEttiR9lVkhR5Tx
 BnUSxBQN2LBYCpYbQxJUoWD+38iGqlIO4awsTKz5E2ldj4OAx6WVCcHJcTlfk6IijGQ3
 8OLy0Ye7QPFXDuxIGIJOZGgvj9tB026m4G1nkqqxzBUbVobM/8IyqZV1QJWdw2gfWOy7
 +p5aITQ2ISIkkxaW3a4irozyxvtM1U+Of1AemlyflPydbPfVZl5UyGkSPMMqQe/NWQ1i
 H/7Q==
X-Gm-Message-State: AOJu0YyAZOv7k8EQkfkY3J/+K07PKHn/v98qf7DhETWR7cWwFFivg+op
 JYUBj9/ayCGV3ckWbbHVSh9RM+d3jQiQUnwhT/zbHNR3kH11CsAUrS4FQRJem1Ch0s8=
X-Gm-Gg: ASbGncsHlrkyCAL9cP2IMFW7CGna8RR6yEshFfqqVGzcDJOCpUH8z9lDbK2PFaeIsyp
 9a2gt9analM8eRbgYN571bmPIAMzkzXAM0wQiIx+wDZW669KRE1WpIJX7QXPY0hV/nDjTRlD4Jt
 fEs0E21XRlV0ylWeuzNwvZUR53iyoXsbP4PB80fUinMnlR5lZn9PWyG1CfAoQFnF5RBnmx1pC6S
 lisWFLGAQ9wyI6DPV9IcjcNVtB6T7XKaKb4Vi9YtGkIsHprs5/Ced82IfiPODBGqoVQk9DFajXQ
 BA6v4KBesA3f+v/VOKA/Kfi69W7reC90SqWVfNR0JY6vkdQ13CAqqTr0DIzM1ZRHMtE6L9Ib1jJ
 l9oBZ3+pQSxUhMJLUQVJH2xo2O9/iWT9Yr5DrVJ0KG3Y8Uf9E2+gaXEiC9xE+URkZtEsYo0rmGi
 fC
X-Google-Smtp-Source: AGHT+IHOA2FiwSWtYOjEAkhEZwDNW5DcpF+paKdfyLn7kqWvPYggvtkKVucZr4a7/m04ng1x2FsrMg==
X-Received: by 2002:a05:600c:a41c:b0:46f:aac5:daf with SMTP id
 5b1f17b1804b1-46faac50ea8mr56718245e9.35.1760106918182; 
 Fri, 10 Oct 2025 07:35:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm59878215e9.6.2025.10.10.07.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 10 Oct 2025 16:35:10 +0200
Subject: [PATCH v3 3/7] MAINTAINERS: add myself as Maintainer of the
 Generic System Interconnect Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-topic-interconnect-next-v3-3-b384713283a8@linaro.org>
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
In-Reply-To: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=837;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Y3Io42s7iRe+afnhSaQTvPpy1QHVaHa1Y/J4z7yyb38=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo6RmgTN6Lrxk4kvmfUwXrNE2DmVSglLauwGFBwvEo
 WojBJBGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOkZoAAKCRB33NvayMhJ0cb6D/
 9QWES9fo2prWX+0zWIVIi023m2Df4MfyZ/Q7b0rxJhZOPy0Efj5D8kKEM9DJU3UV9q4zQoncP6DmF4
 8JSjxN6uw5LqZEK14aaiQxwcvYIROqKYyERShLQK+ydEOXDjr1TV1TbhPcB1thsJcVWBMYo9bIKief
 f4WsaF5U4g+r45iXxkkJ8SspaRztxAVdt0SIqqraGK19mfrB/UGtdlTQO/PZCqLgnU/C9zJY7BbEHj
 eLWBUbWhT7rX9Gl/FegI5/fOKVhuPMxWEVOLWWdffvQSnFjc3yrM8GT8tOxsKHE6LExlfVDkjK1K7X
 8P2aF9fAZx4DWONfVpelv5wGtLP0G2bN5uoDtUzbStSZKpP8YMvotV4dp8chfpSxDCC6TH7LERiRak
 sjWf6iG11sesdrIjihF/Xn1Kg+a4VOnhyoT4Jo1K98jXdNq0ps5hhqVP1RHxtana/bj48/B98eShqM
 VMBkgrxEE1ATTV/WlXQ7yDoYybixsKZTbSzfsf2tZ9BTZVxLz8AmYi6naxLWWmCzIh8o0Iuclgsx9J
 4l+49BbUCo8ytXuNXbcmtPHP3DavJyj+PhsWO4AVXjLWI9jMQ6SKHiy6RDsAbDGQ7Z6Vw4bb1CkDRk
 mEkEtGwdMeaZPbuscXJVIiVepFKXd7yCpzOK0mRQ9svmJINQt+FM+FsHS/tg==
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
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb163aa1db1dba249e60b40ab3e785db4fde5d3..574d63d0f7c042a6b7c9c38dc56c09de740eaca3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1244,6 +1244,17 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+INTERCONNECT:
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	arch/sandbox/include/asm/interconnect.h
+F:	doc/api/interconnect.rst
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

