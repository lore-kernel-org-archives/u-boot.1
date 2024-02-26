Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1138EC54E4A
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F1087F99;
	Mon, 26 Feb 2024 18:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xIZP1TrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 120BB8802D; Mon, 26 Feb 2024 18:27:04 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FC087F86
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a8b79b46so4666555e9.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968407; x=1709573207; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M+ieQvcr/8QtHK5yo9ZyCn/KcPk4zXV61kI5KA0E7iE=;
 b=xIZP1TrTDJCJzK/R4ws57+lZaNPaACdihl1PfFQjllolJs9if4ET+wjBdGvbbsjy1Z
 E+Q6iht+LRzLoxrp/ENqb3vNB8iUb4fLXI8dTboAY7Qkx77hEzNOkOoDzLJDn0oYCwyq
 l3B9/C5lvTKVi2OdOMgZP4c3yzdrhkyajiGdAogr3i0PO5FFr15Cbhpt/+WhLu7aNKrr
 gGzJgdVpcXv1eErDEKe9JGTpqfFTdmfxWGJ1wkGcduikguQIjs5Tpjc1bnn3GBNSYrDx
 qhusxoK+StHbmgtM9k0uKK9GsrAWmBnLR82Cpaq/5FyAFszVapJ5NmrQzJW8DMAIe6D4
 xX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968407; x=1709573207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+ieQvcr/8QtHK5yo9ZyCn/KcPk4zXV61kI5KA0E7iE=;
 b=TKiDac9+fWCsOrTyPBEKYzAcQE1Jqzyqobx6Cm0MA8GG7GWvBuJco3gX6/OMD/lqez
 pF2xiaAOlT+mzHWvBVkcMPpdSk9wAT82dv+4Vv6axafOrJbt2jor3zPaRtLTUjK6LYSd
 hpGXHK8IIuldor6xXqODHnS6r1dZLgUMrevqiu5MZe+O407o4fh8CfU9dlhOfVtYmEcw
 sjAGnsT0zFfnmYmTF6HE+uzhjU8qZs0EoiSzJltc9NZf6HGzzEkQ9tq77S2hOjLz4Q3p
 0gFSycX6Ek5i+H/rXWSlwOaIWWSF1I5Lra3BSuwyHy6ETSRVnXqA8Qi0NBofGn9QDUiG
 Mi5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVSTEgHecyQr34mnzDMCeUIUa3yIQocQQQ2ILilJoUEw2yN9YSAkgW3RLmhou5s36y6NzEwxY7trxkJRMa828BPFcDuw==
X-Gm-Message-State: AOJu0YyQtG1mblLSbY8YREWnoPbUHz8BPJrvuhNMAEv5wdsdUb8RTZnP
 2st5nktoFHy3NjWPtXYbLSTMAhxtdBI8pcsPh4kYcshDZ01YREHe9R42yIsAr+Q=
X-Google-Smtp-Source: AGHT+IFjDwxdv3ROsfZiyLEyJIihUw8F07hBtK9nOE6cgPXJz6yvI5WNcZDJtKnT1qH8IBH2rjsmpA==
X-Received: by 2002:a5d:66c6:0:b0:33d:4cf7:1e27 with SMTP id
 k6-20020a5d66c6000000b0033d4cf71e27mr4700691wrw.59.1708968407104; 
 Mon, 26 Feb 2024 09:26:47 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:30 +0000
Subject: [PATCH v5 26/39] doc: board/qualcomm: link to APQ8016 TRM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-26-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HZ5wrU4bToFWxso/aqlO6i3uaV/CZomsCZRTMTrjaCQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3d/uFD/8FnqvUcr3xmyurGrd15dv4xpC2t956H2k
 im2Ry8c6ihlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATmWPDyDDF5pTR8Z9d97/l
 nll9ql0ue+vauoOCChkTvLxDX1VfmdPPyND06EQb09v2I+vV1Y/+3vlcgOvlIebynE++GbsWLpl
 idT0TAA==
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

The MSM8916/APQ8016 Technical Reference Manual is publicly available and
contains a lot of useful register maps for many core parts of the SoC.
Include an archive.org link to it in the dragonboard410c documentation.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/board/qualcomm/dragonboard410c.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
index d0de9dbcbc9a..34629241110c 100644
--- a/doc/board/qualcomm/dragonboard410c.rst
+++ b/doc/board/qualcomm/dragonboard410c.rst
@@ -13,8 +13,10 @@ partition. Note that the U-Boot port used to be loaded as an Android boot image
 through LK. This is no longer the case, now U-Boot can replace LK entirely.
 
 .. _96Boards product page: https://www.96boards.org/product/dragonboard410c/
 
+.. _MSM8916/SD410/APQ8016 Technical Reference Manual: https://web.archive.org/web/20210525022203/https://developer.qualcomm.com/qfile/35259/lm80-p0436-100_d_snapdragon_410e_apq8016e_tech_reference_manual_revd.pdf
+
 Installation
 ------------
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``dragonboard410c``::
 

-- 
2.43.1

