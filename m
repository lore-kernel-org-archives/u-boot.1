Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40837109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453008412A;
	Fri, 20 Mar 2026 00:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G3CBnER8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D530583F8A; Thu, 19 Mar 2026 21:57:24 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC33183F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso14292295e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953842; x=1774558642; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMo1yfbKFmerV3xsWbvjjs6LxK5NznRTCCY7I6Qc6M8=;
 b=G3CBnER8Nh92ur6FPHHRidgXweCTkRnGBZMhrK5L+AsdE07Gyoj5rnWgxSLEa6kUI4
 DyiLEuksWzo7MfbT1RtwZvWxkxBkrOZ/ewFqyxWBSayWxzo1YKvT1r8RQJpXYMnWNNdZ
 v7yT9SO7ZfAgIcapAaqSv9ouSAlKgC73pWDqQYelZIkwCgE/6CpHMNQbWMCCysBIm7bF
 rCwPE/0MHg4Y5BV/+7HRJHLWddY4TCeKkwsudsSXZCaVrPv7KO3tyXbwx8ykd1bLLpU9
 IAD5HP0JbA9+vz9oBpBaX1SRqOhPnOkvIn2kWGF8iE/CTw5KM+IJT4zV5c4V1adRxWaO
 vbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953842; x=1774558642;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eMo1yfbKFmerV3xsWbvjjs6LxK5NznRTCCY7I6Qc6M8=;
 b=Z88f0iqbQ93r9XG7WA7BtCMGHSYp0BnHC3mXYsu47jVE0AZgXlePArtalk1j3XTiCT
 KJHgXhTaF7FHVhB+rVJhDqwl6FCNYWLJnCXR0wZKcdQDF+LvDOAII0H3/tJ6+watVanX
 E2BUB3RDSkzpGuSQxxv1cmXrP3E1BpSMBhCEzakSh1kp4lF8SQV1liP2cK+tIqGLQlXA
 68gnUEkzUmFLiXdLzqv4iOArVWWOiVO9559b37nhj2xhT3DiJlMIBdJy0B1lrgyuSgEf
 LZ/ajJhM0a63FR9YgM+Xp5ET8myMvOckHDdDG2Vo7hvJJaL+FYs67T91qtFrIyMFt6FX
 AbWQ==
X-Gm-Message-State: AOJu0YxKYv3ML88/RlclFZ/rmpfBieAnAHofJOaL17fCgeEuAHrDfEJG
 8M3bz5oBn/6WtLPkLw8EOjeC0/Z31c2m77alipPdd2/E96ClqoijDE3EHtRHqK2OXUk=
X-Gm-Gg: ATEYQzw97hn+69ZVESWtUMjbNeawtHIJmQVBZ5PuimlFQP/Py/tApdjGH9GWG/T2Zyl
 i7POVNyTvzsMdARNW27By32BT3fbxsqX/7q8QyncHSk/7YwEZunVV4/wx0DJXvqE3MoxrL5Gop0
 nXeXGs0XfB5Ebs/UTxX66SsGKSXuVxXhTOpwhxMZyApQhDZ0vdGIp8WLVo3KP0CfJm3Bpr5ztpq
 zBSSzbTjmdB14pqU/v812JI3B61q4Jn6DWNSxSft+oUrQmFgtlylnbNeA14UY09zx782OgKUZPq
 4gcrHV8qBxa+v2AuWYJ4Tf1dlPZWRqckdskIOvjUxqn5trCXK80zXDPoVRNdOLJI6N/EbBImLK6
 Ezz2xuc3Rn+8APGOMn5OxQlOCZpPju4QodvN3bOW0Uu7l314VnJ8t10QOXLTIsFv5OmwW9nAcjK
 kpIdFONWzCZsEuyPATD+zjfFYqwO/l1hBblMEgF7xSU+tl41IhNAvWJnnEEPtfaqWrEgU=
X-Received: by 2002:a05:6000:402b:b0:439:fe98:20f9 with SMTP id
 ffacd0b85a97d-43b64277f99mr1285897f8f.27.1773953841849; 
 Thu, 19 Mar 2026 13:57:21 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:29 +0100
Subject: [PATCH RFC 07/40] linux/compat: add PTR_ERR_OR_ZERO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-7-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=s4BvCvcz+cf1uqyJqqQOoJjrtHGguWSJkB09XcWQKu4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXzfuVz/FLU0H722es1cplue71aVJGc8jj+1fPO/j
 E8hdrWzOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEXLIY/pcvZV70YWtbjvOr
 L98kSvON59xe1Flg0PznnxT39G9iF1Yx/GKedCzWmU/bZleQysqAXzqHrl/lad+yN684TavjdX2
 dvS8A
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

Imported from Linux, this is nice to have along with the other ERR_PTR
helper macros.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/err.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 7a0b212c813c..2463c4611b29 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -52,7 +52,32 @@ static inline void * __must_check ERR_CAST(__force const void *ptr)
 	/* cast away the const */
 	return (void *) ptr;
 }
 
+/**
+ * PTR_ERR_OR_ZERO - Extract the error code from a pointer if it has one.
+ * @ptr: A potential error pointer.
+ *
+ * Convenience function that can be used inside a function that returns
+ * an error code to propagate errors received as error pointers.
+ * For example, ``return PTR_ERR_OR_ZERO(ptr);`` replaces:
+ *
+ * .. code-block:: c
+ *
+ *	if (IS_ERR(ptr))
+ *		return PTR_ERR(ptr);
+ *	else
+ *		return 0;
+ *
+ * Return: The error code within @ptr if it is an error pointer; 0 otherwise.
+ */
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
+
 #endif
 
 #endif /* _LINUX_ERR_H */

-- 
2.51.0

