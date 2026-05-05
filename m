Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A6ACD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0299A8497A;
	Tue,  5 May 2026 17:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EVTNH3WI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C1084977; Tue,  5 May 2026 17:48:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B08B848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso38736745e9.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777996130; x=1778600930; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s7kkB7TzQkNJ4z68+hPk/SvdtXd6UOGR8HAZmFg3jr4=;
 b=EVTNH3WIydje/aUBcK24yAQLnG21vIflQ74092WSoJ6dl4coD/bOxUGl9u2Vue95kX
 rmSLEcKB3yyNlZa9Y4NK1YCmBGNPr6CHhUkxjaWR+Srcrh50SW1vnLGGOBNHYgS3CMZF
 h9gyhQiSGqJ95/Zl97o/SXcMbXhSEA5z/IcnE4Ve8wkpPNrmXC87/3Ef13PJ3J8M2Bvt
 3mnvtNeONLDkOhxdhbKWix+jdCMuqP3o6Ss0aCM3iDHYVHYeUZ34gtE9iLt6m2h/RZQ6
 hICdbcSkUMZsvvOf7VPetCHKPKQk88AIvSY46kV2NK1b1Q+AskRkcjQnV8ZGBn25rdma
 ZKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996130; x=1778600930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s7kkB7TzQkNJ4z68+hPk/SvdtXd6UOGR8HAZmFg3jr4=;
 b=tCTZ+z/7gIo5EhIudrlmRxBaMfDcbUPiO32+pQoYkFXFVc8bKL7xTC/oECIPudCupb
 jBM6GDpslDiPNeaZi7K7yO1nlTzRPrlr0XTMmGoshjY22gET0EfmcyYLEHQ1hd864Jg1
 z0FKNDwRqoH5TY5/Cg2qwIgAuOuL5h0EtJvmE4mWqI1SJewx1zCEDDdu+31VFYDbv44h
 HJtH1PwwlYRJhVEnxQDDM4IEXzVIxRR20f047ntTy2mIv2wBy0FPwR+lRYmDvwRNSe0h
 2d2PFKvjtxGOndarKOL8ElR2M9rZzDTkBzz96X9+HSELEPn2QdC71szHBlVAYPpWyuEZ
 UE1A==
X-Gm-Message-State: AOJu0YzLte5IMoVpByOM22/2PE3skhw+OGdwogLrF1VhKv31VvTOzUOK
 4NgBG0v0FN75KIgdPiyWmXfJGg7NVrhuyxcKqACL7JZsSyC9t+34fik2Ue4MwAmN5q4=
X-Gm-Gg: AeBDietl6dg7WIvTnqNkuBfdmx0AUOfPGPHn5yQwDZscmZz+lrygJVp8fyHwQt+T5a5
 kQAvv6mtAZiIDyXJCLdF67eOUNNfR0z5H7j55Xfhybvte0qAAPDnqC2poCShd85I/cG4dW3PHJe
 wqR8ttUPBGkAe0LV9rlJOzQGFAbw4K4rDTxgPnXHFbboFN+jc9BN44nxL3kcwBjNV0wMk3k+4Up
 7aEKV1FiTeBVn543+XCxT0QErxz4vNrjHb+tB/WCsHxbH3k6y+qVXE8hFbLQWDawvn0bBd5LxuD
 s2tZxGcd+hARRc+pxubcI2FsYeYIfkEA2CEWU127OgdTMMMP6cfqksAiXqUMxRS/0mRcVJVP7Y+
 U8CKRWnAqvEGsFZzY07CKJLcJ1nG7ITyqSp2Ork0vTL4kLUw3rqmUlEE2f1y/sV0kvyMbPnepJq
 JjX76urAonzkUF3ZPOQMJ0AhXVQsd9szUdiRyQj32pPGF058UlcqfoVwdbSIQNFwq3ARMANRZel
 PXxe9lcBA7k3MekJA==
X-Received: by 2002:a05:600c:8287:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48a986526f4mr226049765e9.0.1777996129330; 
 Tue, 05 May 2026 08:48:49 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d182ee923sm20305955e9.27.2026.05.05.08.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:48:47 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 05 May 2026 17:48:41 +0200
Subject: [PATCH v6 1/6] config.mk: support vendor generic includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-b4-qcom-tooling-improvements-v6-1-a5fb673f4af6@linaro.org>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
In-Reply-To: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=MGaoxch4SsVQZC1dEIhBgZq+n27nfp4e3dpNvMtD8Jw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsxfgjE7b6tOFbyzWLbubfh8+YabU59sXKNw59DaD+YMf
 +cpnF/c31HKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmMlOI4X9RS0r7Kx410f0N
 tvLlrFN2xnsteij1++27m9wyqesyT/xj+O8V6Phr2WPDi/f6fU2e/o6du0Fg55vSA6dvdh//1KA
 mIiELAA==
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

Currently only board/vendor/$(BOARD)/config.mk is supported, add the
additional usecase of having a vendor generic config.mk which will be
used to add a Qualcomm specific make target.

Additionally, fix the ifdef to correctly check for $(BOARDDIR) rather
than $(BOARD) since that's what is actually used in the fragment path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 config.mk | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.mk b/config.mk
index abed9cb65c6f..28a4228b8fa5 100644
--- a/config.mk
+++ b/config.mk
@@ -53,10 +53,14 @@ ENVDIR=${vendor}/env
 else
 BOARDDIR = $(BOARD)
 ENVDIR=${board}/env
 endif
+else
+ifdef VENDOR
+BOARDDIR = $(VENDOR)
 endif
-ifdef	BOARD
+endif
+ifdef	BOARDDIR
 sinclude $(srctree)/board/$(BOARDDIR)/config.mk	# include board specific rules
 endif
 
 ifdef FTRACE

-- 
2.53.0

