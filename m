Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E8CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 18:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9088309D;
	Tue, 12 Aug 2025 20:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="O7xEdoPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A58835B0; Tue, 12 Aug 2025 18:29:54 +0200 (CEST)
Received: from send194.i.mail.ru (send194.i.mail.ru [95.163.59.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6FB83542
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=TTHGHX/y8qizidCYqYv02/7QxbJMkFwzUd9/OFZFf9s=; t=1755016191; x=1755106191; 
 b=O7xEdoPrW1eGB/DsYhdzxzORyNzqCkIszEGhwvhuZsU+wZ9+OQZ8CptLqX2IW9cMdByB2uCtmLY
 IxT5F0P2XWJoqzciukt8VTyCALzcQbsZ1oH6JIVX/RsiREoKGOqdsEijLYizBO1RAqfu+7AGalIsj
 spevFMASJQtlqPpyI81p8q7/khxE7aj2r5cEtpx2gvcqOFz9+ERggv3g5nyKEM1jWaARdNEuh3CXQ
 8QNFb0gSVtlMs97pPKtl+5xeZdXhHOhX5SdOZdKuz02/j3NE93IpU1ytnFAgAGLtgpZsR4NzIx96N
 Kl6tNASzD4uuG/drxNbIE3qfIaFcK4Iq35pg==;
Received: by exim-smtp-657df4cdbd-ld4pn with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1ulrsj-00000000OD9-1qVO; Tue, 12 Aug 2025 19:29:49 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, jonas@kwiboo.se, ansuelsmth@gmail.com,
 marex@denx.de, semen.protsenko@linaro.org, miquel.raynal@bootlin.com,
 patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, trini@konsulko.com, seanga2@gmail.com, lukma@denx.de,
 Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] clk: introduce of_clk_detect_critical helper
Date: Tue, 12 Aug 2025 19:29:46 +0300
Message-ID: <20250812162946.892728-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-657df4cdbd-ld4pn;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD933317763FDCFC32001BA87318A8037F4C8B7D0F69B536A54182A05F5380850404C228DA9ACA6FE2734C2567A22C48A9D3DE06ABAFEAF6705252D9D9F986DFB5A59BDF76BAF083F4FD73A67995FDF1B13
X-7FA49CB5: 4BFC5D8501E51E47CA8F6BE7C18995EBF17A87A288458776CAA7A3E14223D7B8A6333920E0F9D84FF01C4FAB541DE28FCE208E8FC270FF883B56EE1CD41719AD6EEED3D1F8F94EF624AD3460B7163A6507627EB66F572D0C63D3EDE7CE9F49F504D6AF0AB02B6E8A0BD82CCAF9CC66640D74609957F4D9B73223A72DB2132C0FCECA9111E32953443ACB880A4D218A94D06846632FBE33422E5A41300D5CA53781DA2A2DF6E06EB9C0F7AC48229FE00DAC7943500F4AA200C63912019A8FF6CD1A495265874E50823A509FAFE750B9BFE47C9C07E8DDB84581DA2A2DF6E06EB9961C42723899017F08BD49AA745F4EB9DB3D003A4FE8D71063A17EB2A382449571A1B796659512979E5F4869DB6CD4C26BCF00562456A40918BB8896F27FB42885659056A66B9957CD57035CC7A4315E02BA5FF546A055A8D9EB6E07428221D9C7E0B1B477519308F773605157A43CC879566C173A773ED81CCF1E2E70252529
X-87b9d050: 1
X-C1DE0DAB: B30BEEBCB9DAB3F07C80AF639BBB3433478DEAD3877DCF164E76091D3AF57C6D17D9D3EA34930E2CBCC2DF43DD22AB26DB841BC0FD54B826D9B579716B1FE18465C483732B0C61AE0404AC03FA789E4130AFED0B0E96279AAB8C77F2232E6289
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF501D51C14306817B822E5ED547E1475D61BEEEB0B2AA96D262ED82B3CD86678E5896E83BF38A9601852ABD534936F63158106F793B7DAD2EC2EF6B2085B6B53EB925FFA6CC0C2810146D90F64BF3396102C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtFC74YnnYpwS7UMu6syBGcw==
X-Mailru-Sender: 689FA8AB762F7393FE9E42A757851DB64CADEEA4B9F2849F29764F317585F47F190EFA0F7E33874590DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Tue, 12 Aug 2025 20:04:30 +0200
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

This helper find clock-critiacl property in dts and assign
CLK_IS_CRITICAL flag to the clock.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/clk/clk-uclass.c | 17 +++++++++++++++++
 drivers/core/of_access.c | 22 ++++++++++++++++++++++
 include/clk.h            | 28 ++++++++++++++++++++++++++++
 include/dm/of_access.h   | 17 +++++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 7262e89b512..4f35b90382f 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -835,6 +835,23 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 	return clk;
 }
 
+int of_clk_detect_critical(struct device_node *np, int index,
+			   unsigned long *flags)
+{
+	struct property *prop;
+	const __be32 *cur;
+	uint32_t idx;
+
+	if (!np || !flags)
+		return -EINVAL;
+
+	of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
+		if (index == idx)
+			*flags |= CLK_IS_CRITICAL;
+
+	return 0;
+}
+
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index b11e36202c1..59dda3ae152 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -666,6 +666,28 @@ int of_property_read_string_helper(const struct device_node *np,
 	return i <= 0 ? -ENODATA : i;
 }
 
+const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
+			       u32 *pu)
+{
+	const void *curv = cur;
+
+	if (!prop)
+		return NULL;
+
+	if (!cur) {
+		curv = prop->value;
+		goto out_val;
+	}
+
+	curv += sizeof(*cur);
+	if (curv >= prop->value + prop->length)
+		return NULL;
+
+out_val:
+	*pu = be32_to_cpup(curv);
+	return curv;
+}
+
 static int __of_root_parse_phandle_with_args(struct device_node *root,
 					     const struct device_node *np,
 					     const char *list_name,
diff --git a/include/clk.h b/include/clk.h
index f94135ff778..ea708f54fd5 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -589,6 +589,27 @@ bool clk_dev_binded(struct clk *clk);
  */
 ulong clk_get_id(const struct clk *clk);
 
+/**
+ * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
+ * @np: Device node pointer associated with clock provider
+ * @index: clock index
+ * @flags: pointer to top-level framework flags
+ *
+ * Detects if the clock-critical property exists and, if so, sets the
+ * corresponding CLK_IS_CRITICAL flag.
+ *
+ * Do not use this function. It exists only for legacy Device Tree
+ * bindings, such as the one-clock-per-node style that are outdated.
+ * Those bindings typically put all clock data into .dts and the Linux
+ * driver has no clock data, thus making it impossible to set this flag
+ * correctly from the driver. Only those drivers may call
+ * of_clk_detect_critical from their setup functions.
+ *
+ * Return: error code or zero on success
+ */
+int of_clk_detect_critical(struct device_node *np, int index,
+			   unsigned long *flags);
+
 #else /* CONFIG_IS_ENABLED(CLK) */
 
 static inline int clk_request(struct udevice *dev, struct clk *clk)
@@ -665,6 +686,13 @@ static inline ulong clk_get_id(const struct clk *clk)
 {
 	return 0;
 }
+
+int of_clk_detect_critical(struct device_node *np, int index,
+			   unsigned long *flags)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IS_ENABLED(CLK) */
 
 /**
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index 44143a5a391..dba725498f5 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -405,6 +405,17 @@ int of_property_read_string_helper(const struct device_node *np,
 				   const char *propname, const char **out_strs,
 				   size_t sz, int index);
 
+/*
+ * struct property *prop;
+ * const __be32 *p;
+ * u32 u;
+ *
+ * of_property_for_each_u32(np, "propname", prop, p, u)
+ *         printk("U32 value: %x\n", u);
+ */
+const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
+			       u32 *pu);
+
 /**
  * of_property_read_string_index() - Find and read a string from a multiple
  * strings property.
@@ -701,4 +712,10 @@ int of_remove_property(struct device_node *np, struct property *prop);
  */
 int of_remove_node(struct device_node *to_remove);
 
+#define of_property_for_each_u32(np, propname, prop, p, u)	\
+	for (prop = of_find_property(np, propname, NULL),	\
+		p = of_prop_next_u32(prop, NULL, &u);		\
+		p;						\
+		p = of_prop_next_u32(prop, p, &u))
+
 #endif
-- 
2.50.0

