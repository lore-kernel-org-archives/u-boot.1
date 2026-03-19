Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAF11091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E76A841D2;
	Fri, 20 Mar 2026 00:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GH7Qu5ZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F69783FC5; Thu, 19 Mar 2026 21:57:52 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BA683F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so892931f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953870; x=1774558670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zn1QgF+UBH7ig2aMz9R4BmUloIuxItZzikjPINQdHMU=;
 b=GH7Qu5ZEkH+HxHSCzZs55F6Cyki7nHnKzlRcUFn98Os9FQuXj+MCTdqD0gkBfIrCoA
 QBk1S1DZkYwM242ycQFdeEqXmX2KzKhVirhoE8vfc3f7Ao60/BPXyB8FrDkb9DFjIQQp
 kdJTIYn7q3aoaqBwapU1U1CmFvW6Y9ckBh9xj0ozwxJgsfoel/2qnSokAcTEyPIBUy4G
 u48hxduIG+EpKApOT0O9NliIMk9POmV8lSvQsfi5u9X5du4RzGQl3hiwZkEqsIQMGrqk
 inqwo7x37DiD0L3Q5tZhmY0e4oAu+w/ULwoi8d1AQwcKPdl9kigzkfKIQXhjBuUY/0DQ
 JY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953870; x=1774558670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zn1QgF+UBH7ig2aMz9R4BmUloIuxItZzikjPINQdHMU=;
 b=Wm6ItN2ME7RS11WzFCGjLl8sxwntyUc26t3nDCwdo70GhPykJc9YMU7TAiT7vA8SKi
 vTHNhb3lffjaXhAC3uwSiF3IIOkKPHoXFE+E+mh3eaKt1P/VSLNgnOq4bgINrsmNhUy/
 9l01/5xxbSHQLWVzXSFCfxUD6uj7+ARhU09cey0QApoK0ah9o0qrKOCnAlFjChg1XJK3
 p70GO5oAJ1wC8G8yLEjb1CdATHloc6aD2dzfZzCtU79zAZyhGWbxYqUAUOSNbJOexA8i
 mFabtvDypSQxR4WjO9xTuXZhsYt0E7532VwhVkbJzogl+VKhHIWLF8xvgDniD2+HRwln
 iIiw==
X-Gm-Message-State: AOJu0YzrE+zBXPgI4E2qT9jPb7NMmLAdAwHioSik3HvtJvqBK9uIWeTZ
 VlFgUT3F1HTwzklfow8uYp/foVLwkgZhyrOMr1IjnOstR+aybBNv4rFTxdlyG62eT7E=
X-Gm-Gg: ATEYQzzqKdn0mlLSvPHfbp/BrRQTg8E/BwyesUUCB6j0PK/fRlAPG2k4mMdGqSvtTPv
 GWbD2C+2qnLc0Aov1D/x6z3AoXN2lghe+pd2IK9mHmcTL81R1RigO+ZznaqRQJ+frMmpRy9YqzH
 J19vrPQX2HPublSataO0+lcyVL93x4Md3bCSnM/i25DauJwv2iQaPs2L4h5dFc+OPE9l4W/2SL/
 Mu+SL6zb7K8/PdqMwIQAS0jaT7XeZw2bfUjuGSzrzvig/juIJMNbOw3Hb8bq21/CzcE43vgd5F/
 QEOpiWfoSks8uY2cMwali0uqIUimSdQ9d/MJcTf6wIccHkDu0o44k0wYlyHuDxmzx+ClwzUohST
 UrPAhShZeXCBxhIyBkL/YKxCzD0N4nDHW+gU6EdrhurCJDW7p6RY3lRiOPFwlSGAyQyZoo2cCJ3
 PFzIag1PiyTduZw3zadLw5dLN9oeIU7lAGTULvZxXcc8PKMDYg7IR6okLORoiGJAqwj8w=
X-Received: by 2002:a05:6000:40c7:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-43b64277ea7mr1265772f8f.25.1773953869574; 
 Thu, 19 Mar 2026 13:57:49 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:48 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:36 +0100
Subject: [PATCH RFC 14/40] compat: math64: add abs_diff()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-14-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=yarHnrRLw4B3Nkf5OgSsh1JbtkF80PzViaDD1jJC89M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXysZ04XXPP5zuj8wEnMqr5Zzevr1ZttXY6berkW7
 vi2bg97RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZgIWx3D/wyRMgaF+LuBWyfu
 EnV8Um1RXbjzTLzSwxO8QgqW4b/W9DEy7Oid0fLBe7sgb95nhsoCz+WslYtY7toncncef7X6m/w
 tfwA=
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

Add the abs_diff() macro, copied directly from Linux 6.18.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/math64.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index eaa9fd5b9685..70a7ee3ff1d3 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -256,5 +256,24 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 	return rl.ll;
 }
 #endif /* mul_u64_u32_div */
 
+/**
+ * abs_diff - return absolute value of the difference between the arguments
+ * @a: the first argument
+ * @b: the second argument
+ *
+ * @a and @b have to be of the same type. With this restriction we compare
+ * signed to signed and unsigned to unsigned. The result is the subtraction
+ * the smaller of the two from the bigger, hence result is always a positive
+ * value.
+ *
+ * Return: an absolute value of the difference between the @a and @b.
+ */
+#define abs_diff(a, b) ({			\
+	typeof(a) __a = (a);			\
+	typeof(b) __b = (b);			\
+	(void)(&__a == &__b);			\
+	__a > __b ? (__a - __b) : (__b - __a);	\
+})
+
 #endif /* _LINUX_MATH64_H */

-- 
2.51.0

