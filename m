Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19540C48BEB
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81DC880D9;
	Thu, 22 Feb 2024 12:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cFgO1iM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E567887663; Thu, 22 Feb 2024 10:37:53 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D4B88072
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-59fc4d05861so2258566eaf.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594669; x=1709199469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XyCybnabdst+3CZ0/r+NmrIx0w00q4z9pT7wJRsqhU=;
 b=cFgO1iM5k5fc417QLpDhCdbekv2qYWNA5H4N7airMcBTEFbt9tJt9u1sr6J97UQwOl
 vYaiYK282ly9tAR+0dOp9qjkv54fDXHyfmOQNk2KQ4u7ih8L6SZfwJ3pSQ4hBe2yfPnz
 tji6iBPQtCSEf/VfgtBzSsIi9UDzuoJeZPyqGnOoj8qUSqp0TiUjPcXLTBViqUi+owJx
 v5ni3tqrXf/l1B6KuCRcvoAIwxR4mc7R+5iCQEgqMPABZw9ehYy5PjXrnUxq8ySdtnRT
 5KzXDcpLCJn/+xOErYjcd8hzZ3R/l/Ym++0IMSo+2PxocK+XvgE3OObDX8+DsHR+AaeM
 8eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594669; x=1709199469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XyCybnabdst+3CZ0/r+NmrIx0w00q4z9pT7wJRsqhU=;
 b=qWzVVWSqsG7REZh1m83e+k9q7AzLFjTpNK+IMJLfCzvjLcq6nSqAYgdhUzoC3oCzsR
 cykFGXg/mNk5RBjREFkPxPnlpuvFbgh0/q/DgRkUTuW9uSaLUKCyjYo/ckdNSFSWd5qi
 I7uFSYx6ceGQjPwep1eojlMWhJQxyg05ccokiu0DLXWcfL00SLwGdhDP20c1Aiiupdnn
 /ZgsnL3NTSVmTYkdbeqKqA+l5lrpPysj0m4C5hf1ChhQIu20RPycLoDekmCIpedvqvAQ
 KOOS+l+w2JLPrKC3RmAfxqkgnTUPtyHKvQt8zAb/+bUTxCoPj6Mfp0CM5d0nwcVsL+S1
 eYYg==
X-Gm-Message-State: AOJu0YwfVUH5cAPEG9LyoTf0ehJC/D27HahlUkKBNCRcZMvUltP/jXxq
 4Ab3cCK2td3QX/6hsNbzThp7Kd0RrKxSs43qyS5j9INl20lnacLcpVrpLgqWajd7oySnjqfF0Tc
 I
X-Google-Smtp-Source: AGHT+IGO8zlm5N3Bw7a8KiFZdFhLz50IigprirfgWKaYEloNBRR8FAIDBPuzCOBFbKcgWODgNe7y3g==
X-Received: by 2002:a05:6358:6f8f:b0:17b:521d:9fcc with SMTP id
 s15-20020a0563586f8f00b0017b521d9fccmr6734041rwn.9.1708594669094; 
 Thu, 22 Feb 2024 01:37:49 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:37:48 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 09/11] MAINTAINERS: Add myself as devicetree-rebasing
 maintainer
Date: Thu, 22 Feb 2024 15:06:05 +0530
Message-Id: <20240222093607.3085545-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:08 +0100
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

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added commit description.

Changes in v3:
- Picked up review tags

Changes in v2:
- Picked up review tags

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b08ca192397..6541ab2b3a87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -989,6 +989,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	dts/upstream/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1

