Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FD3CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC85836C8;
	Fri,  3 Oct 2025 10:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VySHQpP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA1E83775; Fri,  3 Oct 2025 10:56:33 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6A8836C8
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1581679f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481789; x=1760086589; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Zc0xENALygKf5EL0MYs7kvCkFOEKR9WrApcLbPEyA8=;
 b=VySHQpP7Ny60pDgvMa+Yx8py8DW1WsJPA/mlRNo0DfDoqfwAfJVurmPpZlxSgIkIQe
 0d9snTxWcUrlrNek2j7Sr5n363fhK7kJrM7LIg3gmJ92gPpf/Unvya6j/EWH5QmrzkGC
 66EFCMS9Hezo8aWc8IP9loPlOQjPQeSVc+3k6z/Mzmalwx7Kmb+1sHPPql+rGobHPJFE
 nDOBvf2rm74dXuk3jN+uPmpukwOPB2IJjdDV933bAejJ9ABdFChtvbJb0LvnDj6mQVlq
 vo6glFU6hky6Z+jvzt+6HG0+8I86mhY9Hs+G215ArMGGPCA+g/zzfr3WWDd8xzZZWGBM
 IpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481789; x=1760086589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Zc0xENALygKf5EL0MYs7kvCkFOEKR9WrApcLbPEyA8=;
 b=USX7FtRWVYF63vwLb3zlkFCV6MqcAf8PoQPDpt4Ni9AZ9rDLoiqmJbZ47OO56EqCwz
 +XTtLXMLPV01r6qWz5Fx3N+lQ4T+QQYrf0AffNCkXPdu2kRx/t/ejQ2cypRoclZTuKlN
 RuNY5yn7XTVkpZFc+ACXEWn7IumByuwGFo3div2abZtzmuT4WtnwE2VEhIZTXmx9Nl7O
 yRCukXQWTcKZ3u/RvoPpGQOMKPmlTmb5JuHmHRWXFr9040/3Wh2QLk7nREgUvTD+hb67
 dW/t+8wol6tOkyvs+LptRKIkeR7mtGQ5b8nnBW8t3iG2x9q9qUdaXV4bDxinxluSeSHa
 MYcw==
X-Gm-Message-State: AOJu0Yx6RpCeHGs1EMWBWGC431rAjE8N0B30QW9HwEt0izvoFAqRb/IL
 BNXU/PF/CJVwwloCV3sxJOpGlVCpGISoP5t5oAp8CiD6ENuJK+LLtSR47w3r/4Q2w1Y=
X-Gm-Gg: ASbGncv5w4Zd0OkqnRsco5d0sfblHTuFEpd7WgprNeMAl1tzY6EUTtfYYKNicg0Z1io
 i77Gpwq4esY38PYnrvR+4hOo4UmNNuhwdiVx3iP3Vr9QKFAzvy6lUnQpXr3gwnptZv31pyXtwvZ
 /6kzMYYfvRCpEigL5Pv/ra7GvlptavLDBQGsFjoLNTneGEKuMdlWhKsML4j9FbKkOvY3ZMoZ2F8
 5euHP3uxhy73H9Oka3jI3tNSu9Y/4wkVkwz9v1b1C4MhmpGEONEwfQrOMWju8RkrbCbPtYw/dME
 xvGMGxsY5+DRuIU16/7dkdfEke0TTqlMvUQf4P20doTT280+i62OiGy/+9JGiykkJFIqz8Dwjot
 cLIRDiaXrup5/REjyocwGy1fXasPTXIX2DaZcVpgAACQqm25caOCQKUQ14t/VtNy5rhjIAZk=
X-Google-Smtp-Source: AGHT+IEzwvxWpud+fXO87ta7lDgUJc793txcBVRZNZ5GIDqHwhPWOlWvYX7aSlis7Mc5fTQ4TKlJIw==
X-Received: by 2002:a5d:5d07:0:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-42566c38a6amr1611390f8f.16.1759481788498; 
 Fri, 03 Oct 2025 01:56:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm6951709f8f.41.2025.10.03.01.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 01:56:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Oct 2025 10:56:22 +0200
Subject: [PATCH RFC 2/6] MAINTAINERS: add myself as Maintainer of Interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-topic-interconnect-next-v1-2-955eef068b6e@linaro.org>
References: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
In-Reply-To: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=729;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hYd5w8HSfMEfaaZfE4UJNFbce0QDbIF/vmfSYmHn+BI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo34+4Zr9NO+6vLiMuoZy6yRUkrQgTAU2e/Exn67hW
 YYzZOHiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaN+PuAAKCRB33NvayMhJ0VujD/
 9QJCaLx/tc0AJTFgzn/B+QDOlsaG7+WfVWvF6vpoq5CD9O6BDnugaXYNDhQxuL58E8Cex492UKIZuq
 jbMUySQ2l7wWqWQ4lYkOYBZslmCNDLi6xwP9obfoTZg2efH4q4APIDPW1YLAGYao7tojbApGsorcav
 fD4mZrD/ZmTJmTDdBmDbOFu6QO5AJjB0JTOOaXW6ikN5WMHIofPh0Ue9rFisSgRTbrLLgLR6D+AwTr
 +a/cGm14Ktsvmc1shKvcjiOP77iwb4mo7WPCP2FwX/CAo2VYqZ1vGc06fjJ29E4DhYi21eNYnU2QGh
 FIQjUbmaJCxit3W3Ejb59m3elHFuYpj6wfSr6rO1apa6Q5VlLNK377NA0An7jZkZIiHaXXFNjy3nmH
 j1ZIC6KsiOC8ahe8JqLCaR4V+J8FrFS4MUsvD0Tm5JoeD8LB6jjw6L5ifqSS0GE9ZqXVMATifBWQwD
 wLAm1S/5aM8ZhIiRCkxyJvznb/8rdzsZ1EB1WrGtd50fPTuWC0AwSX8UWXd5NBDI5dxt3LPZuh5Ibx
 jx3xWd2lpKCKrWfhl+ZFU+UkGLhOLDjxyD2gms458QYhuN8tY6xajubADXOlQX18kJcnF7Ji9OG+2G
 YU3zX/Ex6Wcqws0C9bMwaCfchsjT/8iRMRt01tfUwNVqZapXdV67KCr/96mw==
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
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12043a1f82e5093c357a2e6dc4b9db2f8f431e5e..e7c42f1c7c81cf53ec793c12e3819bd98b6128fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1245,6 +1245,14 @@ S:	Maintained
 F:	drivers/misc/gsc.c
 F:	include/gsc.h
 
+INTERCONNECT:
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	drivers/interconnect/
+F:	include/interconnect-uclass.h
+F:	include/interconnect.h
+
 I2C
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained

-- 
2.34.1

