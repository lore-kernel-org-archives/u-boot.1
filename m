Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F226DC61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 10:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 734E96070F;
	Fri, 28 Aug 2026 10:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tT4Wa2Sz3-RG; Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787914339;
	bh=cNiCKrMoc92e46IuNBoJbGouNjngFAChGOQfuidDS0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szCkQyRfvZ0mjK2AWaQIi6OOdSgrIuJo+mP8W+ljriX3OkAh199I6CyESRksqhTJA
	 wnza4yxFk6uy/N/r+3TXP5DGvU43v01cb81rau+LtAcDS/gbxggJZphnNpxqdYNWLB
	 IDXJDmZy3jnbK1+HVMRPjTG2zQ1tWEBtMvlZkLb6xGIXU/oMumumtZwqeul9FxsZEI
	 8WhTtRkDoKDh3hsUNfbkkB4kGCvSQ8hB6215gBuLzySLcwIscbw2TubmGHnFKVhAk8
	 JEVRtfnpeKRwZvNxsF7lczZvYJpXE0AxMB4b7G6QAVTc0ZfuTbo+n/UZb48MYsdxwM
	 8UxW+Yszjh/YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94871606A7;
	Fri, 28 Aug 2026 10:52:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B240105
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BA7E606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VyuuXCdeVKzD for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 10:52:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GA5NHOlP
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91554606A7
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 10:52:16 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso659870f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787914334; x=1788519134;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cNiCKrMoc92e46IuNBoJbGouNjngFAChGOQfuidDS0s=;
 b=GA5NHOlP9xVWv6ugTFeM0/y1oir5L5QMS6lleHVYYZcme6ojPglYZQVWkBF5JR9dTN
 vKQXs6BrojiI3ywVPVx1HBDKtax6BxOTNJD9HyTFRwHslcGjUdsGv9vh80tazeDuzjU3
 LZAQHYjTLF4kk7LKi9nDeDe9vLGslXVKKek/cyLVxDHXRv0tUOlzTXfX0js0yzX12/MI
 mhrJyNXeY4JnatX6gYwqP9eAh55PuqJM+Kbz1sAZkGidhvmzKEeFZ+uVxs+lMNOJ3q47
 LTTCTv38H2ikQRUFFT+Czt0x7aQh4oAa5kcJesadV5+kxx+nXssPfkMq5rKLshIiICBS
 AWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787914334; x=1788519134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cNiCKrMoc92e46IuNBoJbGouNjngFAChGOQfuidDS0s=;
 b=sYBDl4IVZ+3nQKO+qMT4hoRD+HIUa1QUiGAANmCNmbFD8qSFKBXkiLqcxjqZ7UtAc/
 bOXu57/qDjdRUnowx8/KAS+kU11pDPcQOyruRDeVkwqB69F1Vj3OUpOf9+o5V9iCpDBT
 XdHVvx9u1KTaf7XVJmn+iLQHWyz9ohwxqwM6+lTETL0qMINnnt+6281Dl3m3jVvN9Twr
 OpeTX2/PRH4ocXbWYw/mFGoqVIkCyT0zx+yM5NC0Gt1kqc7/9u53CQm5BvE5fhOTyuM5
 a6KXoo9QSgmvtR21HG5LwODvvy6gk+Xw6CsyamDToZ23/1vBsoKQD2QfQuWdqdZPuYDh
 7rGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqf9HxcvVLsQuk9Tl8CwrwalpehpHV6dTKny02AS3WOQOGpHbi7BJCM+plAp+X8aZH88jlcd6Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kZYH2N3ZMvHd7q8iNoMtU+tFEYZMMExDoyokiQLiDh2K+hx2jv
 dEWt4HpWRB3ChewnCRZhSNFia2pez9ECcUL8amDWniWd/0ATkEpl0CS5
X-Gm-Gg: AR+sD10nZFzjuWqJrjMbfabKxB6IYJuexIQmiWdm6Z7u75iEDf52N8yektwwrWEWJ6U
 UmYn/jDLzKoMBk510QC6JZxAaJ7Gp8RlQul8S2/X01qhfJz4ZnCkdsPRjUiVbJGwKCgp8yp6sOv
 MxggTShf2j4bl6lUWKfk2+aVxybhmpBCVM/csKDynvJj8N+Uv5UlvED/LNRcpBsTBjCcP406M8K
 EjfVVcZXxufk8FcZADsuz+mbxgWp/Yz2i/W1lJipcpwbZQPA5ojtOz7dT4vPWpcRCFtpbV1f5uD
 0z7CH3VIfm85gRrOZOrfF0k8nnmjOn3ulVptnspE7KQ6SUVVKMkbfjF/EVlQ9A9IO3F0hfCIrDb
 qn7vMQDXbpFJut0nym3/d7fJca7IVxQMQxaKA9ITnOdqWFu5NHOdxKrdLoFHQ19W6pvZaY+MESC
 oK7Oti9Wf++m7CE9MV89DD93MEdyunDuR+TplKxnkX8qcLMQFIEWYzrCgP6tcglUEHHAE=
X-Received: by 2002:a5d:64ed:0:b0:482:fda9:d644 with SMTP id
 ffacd0b85a97d-482fda9d66fmr1939660f8f.7.1787914333959; 
 Fri, 28 Aug 2026 03:52:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm3212202f8f.1.2026.08.28.03.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:52:13 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 1/4] gpio: add a way to parse a GPIO now and request it later
Date: Fri, 28 Aug 2026 12:52:07 +0200
Message-ID: <20260828105210.32664-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828105210.32664-1-mehmet.fide@gmail.com>
References: <20260828105210.32664-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A driver's of_to_plat() method must only read the devicetree; probing
other devices or claiming resources belongs in probe(). Several drivers
nevertheless call gpio_request_by_name() from of_to_plat(), because it
is the only way to pick a GPIO out of the devicetree: it resolves and
probes the controller and claims the GPIO in one go. On boards where
the consumer's pinctrl touches the same pad, the pinctrl state, applied
between the two phases, then undoes the direction the early claim set.

Split the two halves: gpio_parse_by_name() reads the phandle into a new
struct gpio_dt_desc without touching any device, and can be stored in
the platform data; gpio_request_parsed() resolves the controller,
claims the GPIO and applies the direction flags, for use in probe().

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/gpio/gpio-uclass.c | 33 ++++++++++++++++++++++++
 include/asm-generic/gpio.h | 51 ++++++++++++++++++++++++++++++++++++++
 test/dm/gpio.c             | 29 ++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 4d40738e5aa..b65500eafb0 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1216,6 +1216,39 @@ int gpio_request_by_name_nodev(ofnode node, const char *list_name, int index,
 					   index > 0);
 }
 
+int gpio_parse_by_name(struct udevice *dev, const char *list_name, int index,
+		       int flags, struct gpio_dt_desc *dt)
+{
+	int ret;
+
+	dt->present = false;
+	ret = dev_read_phandle_with_args(dev, list_name, "#gpio-cells", 0,
+					 index, &dt->args);
+	if (ret)
+		return ret;
+	dt->list_name = list_name;
+	dt->flags = flags;
+	dt->present = true;
+
+	return 0;
+}
+
+int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_desc *dt,
+			struct gpio_desc *desc)
+{
+	struct ofnode_phandle_args args;
+
+	if (!dt->present) {
+		gpio_desc_init(desc, NULL, 0);
+		return -ENOENT;
+	}
+
+	args = dt->args;
+	return gpio_request_tail(0, ofnode_get_name(dev_ofnode(dev)), &args,
+				 dt->list_name, 0, desc, dt->flags, false,
+				 NULL);
+}
+
 int gpio_request_by_name(struct udevice *dev, const char *list_name, int index,
 			 struct gpio_desc *desc, int flags)
 {
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index a21c606f2b8..9d64f78e642 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -574,6 +574,57 @@ int gpio_claim_vector(const int *gpio_num_array, const char *fmt);
 int gpio_request_by_name(struct udevice *dev, const char *list_name,
 			 int index, struct gpio_desc *desc, int flags);
 
+/**
+ * struct gpio_dt_desc - devicetree description of a GPIO, not yet requested
+ *
+ * Filled by gpio_parse_by_name() from an of_to_plat() method, which must not
+ * probe other devices or claim the GPIO, and consumed by
+ * gpio_request_parsed() from the probe() method.
+ *
+ * @args: phandle arguments naming the controller node and the GPIO
+ * @list_name: name of the devicetree property that was parsed
+ * @flags: GPIOD_... flags requested by the caller
+ * @present: true if the property exists and was parsed
+ */
+struct gpio_dt_desc {
+	struct ofnode_phandle_args args;
+	const char *list_name;
+	int flags;
+	bool present;
+};
+
+/**
+ * gpio_parse_by_name() - read a GPIO from the devicetree without requesting it
+ *
+ * This only reads the devicetree, so it is safe to call from an of_to_plat()
+ * method; the GPIO controller is neither probed nor touched. Request the GPIO
+ * in the probe() method with gpio_request_parsed().
+ *
+ * @dev:	Device requesting the GPIO
+ * @list_name:	Name of devicetree property containing the GPIO
+ * @index:	Index of the GPIO in the list of GPIOs
+ * @flags:	GPIOD_... flags to use when the GPIO is requested later
+ * @dt:		Returns the parsed description
+ * Return: 0 if OK, -ENOENT if the property is missing, other -ve on error
+ */
+int gpio_parse_by_name(struct udevice *dev, const char *list_name, int index,
+		       int flags, struct gpio_dt_desc *dt);
+
+/**
+ * gpio_request_parsed() - request a GPIO parsed by gpio_parse_by_name()
+ *
+ * This does the second half of gpio_request_by_name(): resolve the
+ * controller, claim the GPIO and apply the direction flags. Call it from the
+ * probe() method.
+ *
+ * @dev:	Device requesting the GPIO (used for the request label)
+ * @dt:		Description returned by gpio_parse_by_name()
+ * @desc:	Returns the GPIO description, ready for use
+ * Return: 0 if OK, -ENOENT if @dt holds no GPIO, other -ve on error
+ */
+int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_desc *dt,
+			struct gpio_desc *desc);
+
 /* gpio_request_by_line_name - Locate and request a GPIO by line name
  *
  * Request a GPIO using the offset of the provided line name in the
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 0fb05b5ca06..4df9cb902eb 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -257,6 +257,35 @@ static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
 DM_TEST(dm_test_gpio_opendrain_opensource,
 	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test parsing a GPIO in one phase and requesting it in another */
+static int dm_test_gpio_parse_request(struct unit_test_state *uts)
+{
+	struct gpio_dt_desc dt;
+	struct gpio_desc desc;
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device(UCLASS_TEST_FDT, 0, &dev));
+	ut_asserteq_str("a-test", dev->name);
+
+	/* parsing alone must not claim the GPIO */
+	ut_assertok(gpio_parse_by_name(dev, "test2-gpios", 1, GPIOD_IS_OUT,
+				       &dt));
+	ut_asserteq(true, dt.present);
+
+	ut_assertok(gpio_request_parsed(dev, &dt, &desc));
+	ut_asserteq(GPIOF_OUTPUT, gpio_get_function(desc.dev, desc.offset,
+						    NULL));
+	ut_assertok(dm_gpio_free(dev, &desc));
+
+	/* a missing property parses and requests as -ENOENT */
+	ut_asserteq(-ENOENT,
+		    gpio_parse_by_name(dev, "no-such-gpios", 0, 0, &dt));
+	ut_asserteq(-ENOENT, gpio_request_parsed(dev, &dt, &desc));
+
+	return 0;
+}
+DM_TEST(dm_test_gpio_parse_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test that sandbox anonymous GPIOs work correctly */
 static int dm_test_gpio_anon(struct unit_test_state *uts)
 {

base-commit: 527115ef6783cec49e5610c523c124b399011361
-- 
2.54.0

