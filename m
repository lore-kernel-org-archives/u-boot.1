Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EBBC369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E46B84019;
	Fri, 11 Apr 2025 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kmO71LMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271E084009; Fri, 11 Apr 2025 14:48:00 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E3F783FDE
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1536412f8f.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375677; x=1744980477; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0CLKStleFsDlucFcVBypNI53bNGF4KiYAU5jyo/fWc0=;
 b=kmO71LMtHEQX3arA5kMSWAnlLI66Mbz8cb9SlBETTGOPXsIXDd6sGJMEKyFnYVvCid
 TOzZ/PfZAg+s8HfQWYG8hjquMejFrczpQlU06KMio3culHQpZmjU5c1ZHXFq2TeBII72
 4an73CWq5azueYK0VlXnrJCYFA8h8rCPB32c5UMNMWxvD6wtBgJCOsYnjT6dT5uuoJuP
 S+N2tviqfuTLFAvbOFbNeqRLMLj24EY1i2QcLP9mx7xgOF09qb1ejeuiPS9BHJz2Upsw
 mkYLeAA9S1NY9OAhP1s6fIpX2XShEtUHu2FOyMWT1jKoaSmbcYn/Ez1rxax41rhcL5pb
 B1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375677; x=1744980477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CLKStleFsDlucFcVBypNI53bNGF4KiYAU5jyo/fWc0=;
 b=Ule4t/G+P3dFlzIdFRbtjW1cPlavd2c0CMkMW3XKmQ1ggbuDtOJsrFqwYPBCYpsQFp
 fRHKftpcccBPE/5XacP1NPSxuCuTajzaSsrAbQ9Wc+Z6hietQiEgE+Ash3ehjCviWvTp
 z9hDYO/wL9JWuyxWYLCSxmriuCyC2lbVSlx8mjq/lCFIk0RYKgnR6tismqWWcaPZccQG
 a2sP8v6XReOhw0TQM2jmb18J7cw2RjIk8cwb3q5xRe9dNNM2YRZKSCB6rK+B+nflUPHx
 AWK4lvoP6SsnndamJoIcJgbQ84+jh4kbpweFvtMSSi5wdgUZ0uw8GuWFCmXj0p3Z9YbB
 uBkQ==
X-Gm-Message-State: AOJu0Yxj5SpWy84Bgr5rFw0e41fJApAUTM2skIcxsu2d340f46fMf0Yl
 FnQofchBaKZ6i5Orm+57gbKTR2lVypqi9wl/jvd+ODeHmxbT1ZxWWDzqiIUFjy0=
X-Gm-Gg: ASbGncuRKzSsoH49CSKCLnliRzfBFKvr8cg3r4y9HyAJDlAQTvFRCiGhQZgDp7kzdv8
 mUD9xWsc2uStOaYDpDvcDtOvQCscjoYx6p2I9egvwwtGQwH1e92qAD48J2VfVq3jvu1RuJbtPAm
 OppYdL3R5gu3LUlcUArz3Sj0un7ENhucbovuXxT6lkKnqHqpB5o72UkyugU6oXDXYyOa6SROjsr
 MrKc+bhDcm1HaBtSJTlPpWlvM4wHCx9ITTOylP+WsLuGBF1JLFO24JjQgs3ETymRxIV5HvupVQu
 7cnhmvRu3ih6riRZSL0O2Rnv3vsL3ZUiXv9HDKxz6u3sboJS8pO6C4aILIM4ptkqfmUnIT7VKa2
 Ar0pTIuYb8wNrfESQMg==
X-Google-Smtp-Source: AGHT+IFiYkgeN1ClEsK1X378HxDB8rNdIHgOis71ZRcJ4uy2lt3SnCoJKDP+OrGgs8qsF5vGMxQnfw==
X-Received: by 2002:a5d:5c84:0:b0:39d:724f:a8ae with SMTP id
 ffacd0b85a97d-39ea5217203mr2103852f8f.33.1744375677572; 
 Fri, 11 Apr 2025 05:47:57 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:42 +0200
Subject: [PATCH v2 5/8] mach-snapdragon: of_fixup: update comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-5-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ROoqDoPJ5ix1nRKD+zCXBiwhwz7iX1neYdedBALqDdE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q90qLNah/t8W9n7fmmCrEldLsdNm/Gn8K3Vk
 h+mnCc1V+yJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPdAAKCRAFgzErGV9k
 tpzVEACPrN0RTuxEjJ+Uq1AABodg0x+Zr8U3q8WR0DW2bWxgog2xP3OQLCoZ6CwYepc5YFvYaZN
 JjMATg3WZwtBLKSRPTdJ5y7KtniByK0UcFtZ/2zRbkrZ9Ty/SPO0WuzVeJBCEPanWimV+5bpqg0
 VgWmxJXzJdgDF3dWU58HM/dQHm9XPom/ajyloJ5DS2OAWo81h58y5iyTgF7xiBBzdqmIMKnLpL6
 R38H82G/gxR0XT09pFmJjWgrkndAuYSbbK3ktUVXZt20CX20g6uueVnmg/S7y9RlKrLhM0ynBmk
 867doJwDKCptMF/joTDb137TmF750kVOmht22jDbFDb5WKlY4vQeluWC2IGdFMx6EzHU1I1v9aH
 jOkGWjvJV9rn1jPpFfJ2yILMKkUidCFIvfgTJ9aaJrWapjCAN4SXlIvcuCIhtcLjaDLgDKYZOvK
 VKN+YwK7gNr+RGAav7MlEN1h2d3GBeh5VcvqVdRRPDMo4SllDIF98lkXVpEvwdGDz8JxwBenNgm
 TIgwNK4anOiWA5T3wzwTqi5m4StHfbHbK8sUX9DeWpneo69+47AZEQMA7MvPoL6rmBw17lvTicf
 rhBeUUS+JNzJyApDsXd1xBaGsyY/rt8Ze2c6WeOLmiPqL7s2NgJ51xWu6/m2xWzU83UKwlHfHc3
 5JqDrA31cvRtTFQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

we don't rewrite the volume buttons any more.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index a5515c02d3de05944dfb7c1b2a5542631b517497..10053e48d88017d2179c96f2f3724c4d5dc4f3e2 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -3,10 +3,9 @@
  * OF_LIVE devicetree fixup.
  *
  * This file implements runtime fixups for Qualcomm DT to improve
  * compatibility with U-Boot. This includes adjusting the USB nodes
- * to only use USB high-speed, as well as remapping volume buttons
- * to behave as up/down for navigating U-Boot.
+ * to only use USB high-speed.
  *
  * We use OF_LIVE for this rather than early FDT fixup for a couple
  * of reasons: it has a much nicer API, is most likely more efficient,
  * and our changes are only applied to U-Boot. This allows us to use a

-- 
2.49.0

