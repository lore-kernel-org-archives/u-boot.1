Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A81091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F207C84113;
	Fri, 20 Mar 2026 00:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A1ZV8syU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A5783FC5; Thu, 19 Mar 2026 21:57:21 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF47283F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso12326375e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953838; x=1774558638; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygNuSeQGX7Q2b/F+EBUD44n+zE24EFeQxx8wjWtK2jE=;
 b=A1ZV8syUFxDbJ2adxcb6EQENAg+YUsVXxH/MKLO2BVzkHejdUEaI8bMh/sEncESuwz
 7gqL6nIUrMOqYhe2IlOUWkbWlK/Ho1uirUnfspg/jOmRSRXnx+ZVnRQSX6/r4LgUEp/v
 IQJE1G1lTacczV9xr+hH6nubTT0maBBWvqQKZ3PsNxUCzuB99qlEwSLPokz0qlUtX110
 Q1gktgB0/QmhoC+vQz9WOryzjOpm0lNkop7RQBtGXd/VkhAwLxd0WHDDSZH3kjs7jiT/
 baUa5oEGztPGDKeO4Tn2ROkRhp4WFPsEWu7lCVcxQJEnRu8i3kk/cjThk3ELonvK922Z
 U3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953838; x=1774558638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ygNuSeQGX7Q2b/F+EBUD44n+zE24EFeQxx8wjWtK2jE=;
 b=jHL9Sc/f3+guHNJHPenDUjx0NOiWijLfyRVDrqU/vULDDun2JhggD7DJVMdOwRZno1
 Ky7tZSuJUQ6Ofg9PVFjq6m/kfhOodBdoPANkq+QtkKZtPOEjTOT0b1xN/t9zc7/u/m5g
 rK5gXQuN4uDwUkAGB1wY31ndanT6RrN4C729xrAVvy9Y3/6LXvPCdPZt4BOCQwxW+fPI
 rcRULMzejZ7QQzK1EpQgp+6szJL7M+bebjGfNBnosFFqrkl2gcgUU1vl5q1vJ9spp/MV
 pp1yhpTTGX8iK2Q+EwSg1xRCwnxlKO4cz8q4UtEzAjp3APPBdKZfyJtN+kVnB2j7wvu3
 wTzw==
X-Gm-Message-State: AOJu0Yx1yr97yzfVeL3dpZhvKqxKn/K5kkYQ7c5krWSU8bWZv7q3F/Ho
 cxwqyljBfNRHJcKYGT18n0yxl8prPvXNfU1CfIYwOa7twrlfv4OD4R7hd7x4bkbyTec=
X-Gm-Gg: ATEYQzwgjo2sMliaJKlSaCFFFr6QHunUdHzREKRjIFOn8yf8NqmpA9exlX9T7QuFTa6
 YFPQ6ijkWCgsyAEWgoOkcaeZomn3DVFqtuhlXUFVmV+I12Vo4NQBSeZ9a4e2OmYLDMt6RMx2roy
 NuTWEwIfQXtCBgsfG70q7UifceDyBHxW9K3pq/YHfO6yG1A9sErBr/SiZRYrco+LdJ1kyroZBRd
 U/vk34FzIKnm/xRZlD23ijzY3WfZlh4xG4MmHGwUJiKoYYJ5F3j6TV+yZ+CzglWhX37SIUahkeN
 dtNqFC7+gHsZRYNPk9RQfvTqwtzLp0Rk1nLY8SmITSAu+jRNMsKCi8mQ/ckZq0uDjcDob1FeZb1
 Sj5Po7g1UdmP/dWRUjDhgZ4SMjvnoFu5fDGgfj6CjF9nHktkJmuDjoA1Bqkqjauv6ZrwuhPeQV4
 IIuh5tRei6XbDq8UsX1qO444HtLTVTdNh4ed734uz+MEEspOl96LTyDVkAoX7c+Z9oa5Y=
X-Received: by 2002:a05:600c:3b07:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-486fedab4bdmr8055315e9.7.1773953838012; 
 Thu, 19 Mar 2026 13:57:18 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:57:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:28 +0100
Subject: [PATCH RFC 06/40] ofnode: add read_u64_array and count_elems_of_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-6-4df2ee2226da@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11186;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=4U4486dk/kYnPVEPw0EBh1G48lAL739YPPX7748xid0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yXw8Qh9ERZdlZ/wUX8sWa3zppmptxa5fHxuczKx41
 x+rDzbvKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABM5d4fhf4lG/6fcBe/yLt67
 tDt/vrZNTcOhG3JsWxReZqs9ePLMIZbhr8RcMS9tt70pfIx9utNa3C065L0cNs9yf2b9vihqGce
 SjwA=
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

These are similar to their Linux counterparts, adding helpers
for reading arrays of 64-bit values with of_access and fdtdec
implementations.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/core/of_access.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/core/ofnode.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 include/dm/of_access.h   | 20 +++++++++++++++++++
 include/dm/ofnode.h      | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/fdtdec.h         | 16 +++++++++++++++
 lib/fdtdec.c             | 18 +++++++++++++++++
 6 files changed, 204 insertions(+)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index b11e36202c15..969492aae37c 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -597,8 +597,27 @@ int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
 {
 	return of_read_u64_index(np, propname, 0, outp);
 }
 
+int of_read_u64_array(const struct device_node *np, const char *propname,
+		      u64 *out_values, size_t sz)
+{
+	const __be64 *val;
+
+	log_debug("%s: %s: ", __func__, propname);
+	val = of_find_property_value_of_size(np, propname,
+					     sz * sizeof(*out_values));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	log_debug("size %zd\n", sz);
+	while (sz--)
+		*out_values++ = be64_to_cpup(val++);
+
+	return 0;
+}
+
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
 {
 	int len = 0;
@@ -844,8 +863,41 @@ int of_count_phandle_with_args(const struct device_node *np,
 	return of_root_count_phandle_with_args(NULL, np, list_name, cells_name,
 					       cell_count);
 }
 
+/**
+ * of_property_count_elems_of_size - Count the number of elements in a property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @elem_size:	size of the individual element
+ *
+ * Search for a property in a device node and count the number of elements of
+ * size elem_size in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does not
+ * exist or its length does not match a multiple of elem_size and -ENODATA if
+ * the property does not have a value.
+ */
+int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size)
+{
+	const struct property *prop = of_find_property(np, propname, NULL);
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+
+	if (prop->length % elem_size != 0) {
+		pr_err("size of %s in node %pOF is not a multiple of %d\n",
+		       propname, np, elem_size);
+		return -EINVAL;
+	}
+
+	return prop->length / elem_size;
+}
+
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 			 int id, const char *stem, int stem_len)
 {
 	ap->np = np;
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 3a36b6fdd031..d605c0f7b7c7 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -663,8 +663,56 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
 		return ret;
 	}
 }
 
+int ofnode_read_u64_array(ofnode node, const char *propname,
+			  u64 *out_values, size_t sz)
+{
+	assert(ofnode_valid(node));
+	log_debug("%s: %s: ", __func__, propname);
+
+	if (ofnode_is_np(node)) {
+		return of_read_u64_array(ofnode_to_np(node), propname,
+					 out_values, sz);
+	} else {
+		int ret;
+
+		ret = fdtdec_get_long_array(ofnode_to_fdt(node),
+					   ofnode_to_offset(node), propname,
+					   out_values, sz);
+
+		/* get the error right, but space is more important in SPL */
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+			if (ret == -FDT_ERR_NOTFOUND)
+				return -EINVAL;
+			else if (ret == -FDT_ERR_BADLAYOUT)
+				return -EOVERFLOW;
+		}
+		return ret;
+	}
+}
+
+int ofnode_count_elems_of_size(ofnode node, const char *propname, int elem_size)
+{
+	const char *prop;
+	int len;
+	assert(ofnode_valid(node));
+
+	if (ofnode_is_np(node)) {
+		return of_property_count_elems_of_size(node.np, propname, elem_size);
+	} else {
+		prop = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node), propname, &len);
+		if (!prop)
+			return -ENOENT;
+		if (len % elem_size != 0) {
+			log_debug("size of %s in node %pOF is not a multiple of %d\n",
+			       propname, &node, elem_size);
+			return -EINVAL;
+		}
+		return len / elem_size;
+	}
+}
+
 #if !CONFIG_IS_ENABLED(DM_INLINE_OFNODE)
 bool ofnode_is_enabled(ofnode node)
 {
 	if (ofnode_is_np(node)) {
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index 44143a5a3917..fe0de73d7e25 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -384,8 +384,25 @@ int of_read_u64(const struct device_node *np, const char *propname, u64 *outp);
  */
 int of_read_u32_array(const struct device_node *np, const char *propname,
 		      u32 *out_values, size_t sz);
 
+/**
+ * of_read_u64_array() - Find and read an array of 64 bit integers
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ * Return:
+ *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if
+ *   longer than sz.
+ */
+int of_read_u64_array(const struct device_node *np, const char *propname,
+		      u64 *out_values, size_t sz);
+
 /**
  * of_property_match_string() - Find string in a list and return index
  *
  * This function searches a string list property and returns the index
@@ -615,8 +632,11 @@ int of_parse_phandle_with_args(const struct device_node *np,
 int of_count_phandle_with_args(const struct device_node *np,
 			       const char *list_name, const char *cells_name,
 			       int cells_count);
 
+int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size);
+
 /**
  * of_alias_scan() - Scan all properties of the 'aliases' node
  *
  * The function scans all the properties of the 'aliases' node and populates
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 120393426dbf..c905e86b2835 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -374,8 +374,15 @@ static inline oftree oftree_from_np(struct device_node *root)
 
 	return tree;
 }
 
+/* Dummy put for Linux compat */
+static inline void ofnode_put(ofnode node)
+{
+	if (ofnode_is_np(node))
+		of_node_put(node.np);
+}
+
 /**
  * oftree_dispose() - Dispose of an oftree
  *
  * This can be used to dispose of a tree that has been created (other than
@@ -587,8 +594,27 @@ const char *ofnode_read_string(ofnode node, const char *propname);
  */
 int ofnode_read_u32_array(ofnode node, const char *propname,
 			  u32 *out_values, size_t sz);
 
+/**
+ * ofnode_read_u64_array() - Find and read an array of 64 bit integers
+ *
+ * @node:	valid node reference to read property from
+ * @propname:	name of the property to read
+ * @out_values:	pointer to return value, modified only if return value is 0
+ * @sz:		number of array elements to read
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * The out_values is modified only if a valid u64 value can be decoded.
+ */
+int ofnode_read_u64_array(ofnode node, const char *propname,
+			  u64 *out_values, size_t sz);
+
 /**
  * ofnode_read_bool() - read a boolean value from a property
  *
  * @node:	valid node reference to read property from
@@ -651,8 +677,32 @@ static inline ofnode ofnode_next_subnode(ofnode node)
 	return offset_to_ofnode(
 		fdt_next_subnode(gd->fdt_blob, ofnode_to_offset(node)));
 }
 #else
+
+/**
+ * ofnode_count_elems_of_size() - count the number of elements of size @elem_size
+ * in the property @propname.
+ *
+ * @node: ofnode to check
+ * @propname: the name of the property to count
+ * @elem_size: the size of each element
+ *
+ * Returns: the number of elements or -EINVAL if the property size is not a
+ * multiple of elem_size.
+ */
+int ofnode_count_elems_of_size(ofnode node, const char *propname, int elem_size);
+
+static inline int ofnode_count_u32_elems(ofnode node, const char *propname)
+{
+	return ofnode_count_elems_of_size(node, propname, 4);
+}
+
+static inline int ofnode_count_u64_elems(ofnode node, const char *propname)
+{
+	return ofnode_count_elems_of_size(node, propname, 8);
+}
+
 /**
  * ofnode_is_enabled() - Checks whether a node is enabled.
  * This looks for a 'status' property. If this exists, then returns true if
  * the status is 'okay' and false otherwise. If there is no status property,
diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed26..3d199e56b031 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -699,8 +699,24 @@ int fdtdec_lookup_phandle(const void *blob, int node, const char *prop_name);
  */
 int fdtdec_get_int_array(const void *blob, int node, const char *prop_name,
 		u32 *array, int count);
 
+/**
+ * Look up a property in a node and return its contents in a u64
+ * array of given length. The property must have at least enough data for
+ * the array (8*count bytes). It may have more, but this will be ignored.
+ *
+ * @param blob		FDT blob
+ * @param node		node to examine
+ * @param prop_name	name of property to find
+ * @param array		array to fill with data
+ * @param count		number of array elements
+ * Return: 0 if ok, or -FDT_ERR_NOTFOUND if the property is not found,
+ *		or -FDT_ERR_BADLAYOUT if not enough data
+ */
+int fdtdec_get_long_array(const void *blob, int node, const char *prop_name,
+		u64 *array, int count);
+
 /**
  * Look up a property in a node and return its contents in an integer
  * array of given length. The property must exist but may have less data that
  * expected (4*count bytes). It may have more, but this will be ignored.
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c79..e23e53f58f24 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -713,8 +713,26 @@ int fdtdec_get_int_array(const void *blob, int node, const char *prop_name,
 	}
 	return err;
 }
 
+int fdtdec_get_long_array(const void *blob, int node, const char *prop_name,
+			 u64 *array, int count)
+{
+	const u64 *cell;
+	int err = 0;
+
+	debug("%s: %s\n", __func__, prop_name);
+	cell = get_prop_check_min_len(blob, node, prop_name,
+				      sizeof(u64) * count, &err);
+	if (!err) {
+		int i;
+
+		for (i = 0; i < count; i++)
+			array[i] = fdt64_to_cpu(cell[i]);
+	}
+	return err;
+}
+
 int fdtdec_get_int_array_count(const void *blob, int node,
 			       const char *prop_name, u32 *array, int count)
 {
 	const u32 *cell;

-- 
2.51.0

