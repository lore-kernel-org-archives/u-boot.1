Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C981091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9BB84142;
	Fri, 20 Mar 2026 00:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CheRAX2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDDA83F8A; Thu, 19 Mar 2026 21:57:29 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2B784006
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so10150915e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953846; x=1774558646; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LclK/WFnKQsMrtdNvHDrf15plVujXWqfACmvsP31Zb4=;
 b=CheRAX2ce9xjvazJw1ayTEW6fmTBwFDemQUsy2npArF9UF1ghT2czzxNsC9LSfeGld
 cBgM48QEUNeKyhZcg4sXlFekvFF6J3s7lz+g8V1YZW9vj1KvuIPSfzj/D7EHPKgiXf1r
 S8WDe4KfP/TIOLGUpQbegor23zQVvyDGan6/LjNDNpKSleFj/jhYGFabRlRzut4WEteP
 49gE9ZQ2LG2nfRjSWkOqIiYUkieiLJyiIE90cM1YgJ9foBMj8W3dRWY+ylKx8WuJ0JzS
 lktq+kFuKa88QOyH7AQymFrh0cjEoZmPseIykj8Pe6wkcJ23TBjeBpma+T/ub16g35QM
 BIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953846; x=1774558646;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LclK/WFnKQsMrtdNvHDrf15plVujXWqfACmvsP31Zb4=;
 b=cKuGllMotGQJVj3yzhLc554rp+xBryQOj3Fx2BhrGJOBdzw2XLV94Femw2o5ghok6e
 pfXRRcAWuxSUDODiVvH0661VI/oXCEJoQTOH/aELjmTBXw9GsDlY/q5v0aJj5M0klRmA
 8sQH5tarpkkSFEso2FAHo2pu1IGe8FW1auDspxy3EHseJNa9NvBm9kJBfIvVuXy0jX7A
 W5yFnvTW+lT2z5Qs/FwCyAl/TK32lguG8IYq9xIiDDwE+39nPnptYkKWZIA3egt+aFc2
 aEvFbqI9sClLkGOeKmFaAssYq/azjsgYCV8hoLTmkhvxYW4jxjDJPjs64/UH8dRHCofg
 hvsg==
X-Gm-Message-State: AOJu0YzMbZgKkAZrZebukSGRlhN4ivVvQPjAq3kSKzX373apDCu1TOG1
 Wr0g5JFUtALTJM93wtndd9LWV6z1yggFKL5SLJvon53kbVPzmw/qr3WgdV5jEo5wLbc=
X-Gm-Gg: ATEYQzz27GZn8JePQn+pdjqSIzG3j/D4FWPcGIJMxLJUjmCzbXAJPssTZZgT78FuCW+
 QOjPXFRnPQRSgJ4gBTC2W1suBAl5bpb32dbeAY7nnHuoUyPYPuMBFmoZC8nbWC/w9KTffPkF87M
 323QGtSasgSQz8mlF5kw8weZ56i3v5uvPZZwATsJmvWHSO2u8zCKpNfELlAUFXWpULXPqi1gKhA
 4RNDlGT1vTthNWWRTp/8nMrde2M4H0tYnxuMlVjmvYx/Yu8WIlx7XLXl5PADptJHN+wHiqjY/lj
 jh/CbvC+E5Mjr9odjY6u+NWWY4WTJiaj7HYZFWUNy9ePV6LBjsDPGKo83bTJYXbya4RDk8qVGt8
 UlG3OJwXj/IsTnP7+SDb8IfFBMl1giw1Yj0r1XS57/ickZvM5y2IPNzrE2P+Ll/aqzSVgYGC+Aq
 Rc/qW/XdMRcB2rd6nvDQzVzTDUb0y0jatwtcrcHBkDJRvF8l/Sfs9IKjYCPpfKk9RIASY=
X-Received: by 2002:a05:600c:810c:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-486fee1af0bmr6999785e9.24.1773953846113; 
 Thu, 19 Mar 2026 13:57:26 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:30 +0100
Subject: [PATCH RFC 08/40] compat: add kref implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-8-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=IsUyr94uAbhBQSS9jsTFSHJPICURKHi5YxAKX4Vf8eI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXy5y5tOcrYem5L3KWG3osXTpDXskYqipYIBGazNl
 66J/o/oKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPxuMnIsJjNYE1YT8rRht/B
 iaabPVzeHzxb8nBHy5roHxz3ItauPsbwV+QhZ1PalOcfmM99MD7zIHuKzKrIe+LcoT92tka6xfm
 0JgAA
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

This is a very basic port of Linux' kref, we don't actually need atomics
so we just use a simple counter. This is used by CCF to free unused
clocks.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/kref.h | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
new file mode 100644
index 000000000000..30927047d549
--- /dev/null
+++ b/include/linux/kref.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * kref.h - library routines for handling generic reference counted objects
+ *
+ * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2004 IBM Corp.
+ *
+ * based on kobject.h which was:
+ * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (C) 2002-2003 Open Source Development Labs
+ */
+
+#ifndef _KREF_H_
+#define _KREF_H_
+
+#include <linux/compat.h>
+
+struct kref {
+	long refcount;
+};
+
+#define KREF_INIT(n)	{ .refcount = REFCOUNT_INIT(n), }
+
+/**
+ * kref_init - initialize object.
+ * @kref: object in question.
+ */
+static inline void kref_init(struct kref *kref)
+{
+	kref->refcount = 1;
+}
+
+static inline unsigned int kref_read(const struct kref *kref)
+{
+	return kref->refcount;
+}
+
+/**
+ * kref_get - increment refcount for object.
+ * @kref: object.
+ */
+static inline void kref_get(struct kref *kref)
+{
+	kref->refcount++;
+}
+
+/**
+ * kref_put - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ *
+ * Decrement the refcount, and if 0, call @release.  The caller may not
+ * pass NULL or kfree() as the release function.
+ *
+ * Return: 1 if this call removed the object, otherwise return 0.  Beware,
+ * if this function returns 0, another caller may have removed the object
+ * by the time this function returns.  The return value is only certain
+ * if you want to see if the object is definitely released.
+ */
+static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref))
+{
+	if (--kref->refcount == 0) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * kref_put_mutex - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ * @mutex: Mutex which protects the release function.
+ *
+ * This variant of kref_lock() calls the @release function with the @mutex
+ * held.  The @release function will release the mutex.
+ */
+static inline int kref_put_mutex(struct kref *kref,
+				 void (*release)(struct kref *kref),
+				 struct mutex *mutex)
+{
+	return kref_put(kref, release);
+}
+
+/**
+ * kref_put_lock - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ * @lock: Spinlock which protects the release function.
+ *
+ * This variant of kref_lock() calls the @release function with the @lock
+ * held.  The @release function will release the lock.
+ */
+static inline int kref_put_lock(struct kref *kref,
+				void (*release)(struct kref *kref),
+				spinlock_t *lock)
+{
+	return kref_put(kref, release);
+}
+
+/**
+ * kref_get_unless_zero - Increment refcount for object unless it is zero.
+ * @kref: object.
+ *
+ * This function is intended to simplify locking around refcounting for
+ * objects that can be looked up from a lookup structure, and which are
+ * removed from that lookup structure in the object destructor.
+ * Operations on such objects require at least a read lock around
+ * lookup + kref_get, and a write lock around kref_put + remove from lookup
+ * structure. Furthermore, RCU implementations become extremely tricky.
+ * With a lookup followed by a kref_get_unless_zero *with return value check*
+ * locking in the kref_put path can be deferred to the actual removal from
+ * the lookup structure and RCU lookups become trivial.
+ *
+ * Return: non-zero if the increment succeeded. Otherwise return 0.
+ */
+static inline int kref_get_unless_zero(struct kref *kref)
+{
+	return kref->refcount ? kref->refcount++ : 0;
+}
+#endif /* _KREF_H_ */

-- 
2.51.0

