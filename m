Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F07C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 600F960BD7;
	Thu, 10 Sep 2026 22:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kENSf0KIQNBZ; Thu, 10 Sep 2026 22:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 51D1660B83
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789078108;
	b=LNn/tvCbzcbuQENGlvaliNeWJr7g1WNvEFKzIgXdFGzoCvzm21nQ+CkMYvoKzMQXS0yg
	 NMqZCzAYeLZ3mTOcEKHa6vlZ8cvjQ0+B3+n0/CYDdgB5jTD+cY5RKu16aoLWv3LVD24pm
	 bsVub8lGYyLhh3BbVY4YDgES8pji/t6wDwJbpbSdJorzEAmWRObB4ovNV1kTSo66pqoLB
	 rHcUm2e4hfecfGpj4HrG1MlVXwn/soIGimhU6qSDY6px9PGFLbKg6ZiANBG9Pa0V1+oYY
	 E2R1eJ3VpCw3zlzuwLvpVMnIzawEnrnOLWHWaKDRfXWhlg1epUtsQMybGfNOp+DSB3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789078108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LcX9HYhZKgZ9yS5tcBqVeS4iQpVEfKdt4u7PSgSwLcA=;
	b=EH/aSGFbgfbBvS27YmsOQ/eQYaYBmxnr2vL4nnjKXoDnskxDDEJX5KoXrBViBleQgUXB
	 vEXWh+K8tPFe6ysxCWhtMDgFOKCC6lPFkHbWfJPh9HQml0qOtrV8UbO9IpurWbiMuoZrf
	 BYtOdAlVihX0xcx06kmHUSb8wOEbhReM4PQtXoBp1yjkO+FgeydqSneKr3jr44wRuhfnQ
	 9w4+abQ4YbEcQUa1uP0WMFoXGl836oRsAlATFer74rxwAdvwuKuynzBQxj9WXOTzjRPk2
	 g2LgsuPlyLCbf2s0ptPhU8edKJ9ooBabUEPTA5iCwb2RBOcRN0D0Un5BE2SAa6lj8NQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789078108;
	bh=LcX9HYhZKgZ9yS5tcBqVeS4iQpVEfKdt4u7PSgSwLcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B7wetagQpZLLZIisxa2HppjEhUR1n7Wk68MoNGzdPjrgFZA0G8Ni31VbLYdQSmIw9
	 TAdl0IqZ34DTw9ll/Q8sgkwm2z/P8chqAl7R8kRW35Y3xhGbieUGaOLjzeiSIaAjEZ
	 dO7XarId+DZs1KHu3t6Qau1iWw/xXD1GXuT1Tyyc9uIcdgPHmANvvKdVr1oASLxfzj
	 hSPAnHF9Os1F0gz4vhO0PpropPUGPjWbnWd9hUss1rNqjn7tL6InNqS61e0aba/JFW
	 lNcovkPc7+pibWm8OZHvdQfs9AlBwOYy1+u5rGufuriG25o7uZPXy6HP6E8kWKQ8/7
	 j5k9s9xEMG5vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D1660B83;
	Thu, 10 Sep 2026 22:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A599D2D0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 944FB40B81
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QEmp32FcT3mH for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 121AB40B6A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789078105;
 b=cdnjU7bh0HdpR9jPiUGm+EhK0pRiBd9n+/kHxVPmZ3XdNwIbWBdzlakwuTVEPmueyfVG
 K36RX4GQWDR7EPL9Pid6E5Gvu8rQduYgpqd8Yn53it01J6QV9h75R6fSJHfyKFV2r0bWa
 Dh6z+X51OMJFlWqEELqabjaXzQeVGp0t2ryhOMwt28DPwCD9V5owVoaLc6umc2onKz8Ix
 ZgCZYCrPiC/dq3f3AFR9XQkd2HizEtjXJMXxYp/qHSzQwKWWg6aYCu9srou3wTQVNwfiZ
 uIRC+b7B8Byuxfi6IMfe/7Zu/yM4Cu+INGUgFT0MZPr+ZhIuXprqgfyKYxwstVwGDVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789078105;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LcX9HYhZKgZ9yS5tcBqVeS4iQpVEfKdt4u7PSgSwLcA=;
 b=IFJL9NdytgzJUrITs1a79h3eGJGaJHok9Xxd7h+6foL7gMD+zeicqDu9F8D2WJ4Idh2x
 xJTQNPGQON/XMwyUb/9/3Vlx9KXBWR/qcthSbaYUgVk93d5wfHZZuwoIn63TEZl8CrlPq
 upAd4GNByoJ3NZLgCG/p2TF/9DeByXBC1yi/5YhtPQhII8fYOqohGJYWQ4eNqD9fEJQb4
 QEJpCRY9ua/+rADXJ8APSY4uPCaHDz2pIF3H4MnCiTYhlIaiZypOOcYS0I/9CpLcMQl16
 2MMDf76g+VzTjerYohkaZDDazJESdNmWbIaOqGXTihchkS+n2mxkjm0ixNoCtXOJtCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NSlLf5kT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NSlLf5kT
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 121AB40B6A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:23 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso3543455e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789078102; x=1789682902;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LcX9HYhZKgZ9yS5tcBqVeS4iQpVEfKdt4u7PSgSwLcA=;
 b=NSlLf5kT8MyeGZLSCjZy/8x0gXcduWXRBlz2ZTsbTnNZzpTI+7w1tIsGN96LiN01IH
 K11N8sTUoMGa2ol5+lYOYE2d5L51yKiNG7RRxvmKA/pWGbWTtAvFfOjnjlLdu6QTRN4Y
 iAIhSAs5njoNoIhn46UOeAJ1y56egFAAL9IV6T+TqGaTBH6t1rjq4hBpWTo8vBe8ayYO
 f+jSIlh8n81QE/GHC4/kABxAOlAZSNjBtt69EFFBq6GGqwS3HmS9RBd5hErIXavgpRa1
 bHVd6Jsj1Z4jM55ngHA3T/3A7jK4HaoAzt62NAgV6bEjyYEML8BsONiYZK3boimvFbS+
 w3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078102; x=1789682902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LcX9HYhZKgZ9yS5tcBqVeS4iQpVEfKdt4u7PSgSwLcA=;
 b=LHoUnZIcOjqMtfTIl2ujJ67Q/lo0SiZzLE+y4yQW/M0EgcYzI9MxLunyGE78Kf6A3Y
 ORDOoh8mBxax2XCl+tX8bAvdaECBjM/PGum4dFUBW99+1qe9z/G9glySjvDpDCpB1jno
 x+o6Q447wiVvCgoqZIyFYkkgD7Z3Qba7PFuHVsJlx0M/1EdyN7D1xAqo6Ms6dSs+athe
 GlQ0TsJ7ioAT+sHh66YXwzB2ACUFz92nueXP1VTulZV4I+zlgQtmTeCpYQzkmrU+J8X0
 sGSbuLAZcY+aFQnyM3ELxe0TYAZF95nrv9cUYuS79m48Vd/ygDK4zXc3W8lTZxiCczS9
 VnDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz72BBZADuc65Pg8POIIXuDAHGjgqZ8vh3sdcZcpsF36KlxXhi1ti3tQ7/D73AxFUhMO5H6rh0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kPkRn6p7nTcFYPRcQsGS+LqRJ09emxObbsjku5gQwTDCteSExX
 ACxafjl+LuegeT0Vccy5tu0uMysdCJ8nvx385RlrtxjTBoB64KNhiu9Z
X-Gm-Gg: AYBFou1zE0SHGRCrSKdnrQwKPSkWpk2qZ52/vTThANh6vOyA+mkKoZ6/6i4lNyFiFcN
 iYd1qa7yrGmxPP+i8cUQgbVsVIjMFJDc/8rhEF77z15FJKL4BJCLjZC3E3YMEgDkI0j48uy7lwg
 SaX/tbFrGdMueltkQP4DedrUNr8PR3ARK/L9MbG/abr5fUE/5Jsh91TAKxtZYsNFEMkbi5L4Gni
 FSa6hM8wYsnQtXKrcaPdoE7G5C9NZvcRfdc8vdjGHPJjN2SNbhvao1ZZZUerLPXuM9t/OljKBjQ
 nkS2b7EyIj+A8/kEv0qfgy/UyBeGasmUXNPjq+z7M0G31trH0sD5Khoo5g3W5p8b6eNXB4lHAot
 Zy5QzasY8ApObYglRX2LTMh3cF5xrv21cTErNsE2UAi8VRRmaA2cjEzyf0Mg1TysStvocH0Qio3
 8m+VLBuC7k63UJGxDHf/BeQJgeR0t5aqkiLjkQ8OXxOM4njLKFdWxZ1PCiaYdYQaHW72GvH6pRe
 b70
X-Received: by 2002:a05:600c:628c:b0:49c:fc7a:22d5 with SMTP id
 5b1f17b1804b1-49e6188840amr12102825e9.4.1789078101563; 
 Thu, 10 Sep 2026 15:08:21 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm4795595e9.4.2026.09.10.15.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:08:20 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 1/4] gpio: add a way to parse a GPIO now and request it
 later
Date: Fri, 11 Sep 2026 00:08:15 +0200
Message-ID: <20260910220818.3093364-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910220818.3093364-1-mehmet.fide@gmail.com>
References: <20260910220818.3093364-1-mehmet.fide@gmail.com>
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
struct gpio_dt_spec without touching any device, so it can live in the
platform data; gpio_request_parsed() resolves the controller, claims
the GPIO under the same label gpio_request_by_name() would have used,
and applies the direction flags, for use in probe(). A spec whose
property was missing requests as -ENOENT on purpose, so a caller with
an optional GPIO does not need to check it first.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v2:
    - keep the list index in the spec so the request label matches
      gpio_request_by_name() (Simon Glass)
    - rename struct gpio_dt_desc to gpio_dt_spec (Simon Glass)
    - document the list_name lifetime and the deliberate -ENOENT (Simon Glass)
    - test: check the pin is unclaimed between parse and request, and the
      request label (Simon Glass)

 drivers/gpio/gpio-uclass.c | 34 +++++++++++++++++++++
 include/asm-generic/gpio.h | 60 ++++++++++++++++++++++++++++++++++++++
 test/dm/gpio.c             | 39 +++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index ff17cabd601..33eaf2a2022 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1219,6 +1219,40 @@ int gpio_request_by_name_nodev(ofnode node, const char *list_name, int index,
 					   index > 0);
 }
 
+int gpio_parse_by_name(struct udevice *dev, const char *list_name, int index,
+		       int flags, struct gpio_dt_spec *spec)
+{
+	int ret;
+
+	spec->present = false;
+	ret = dev_read_phandle_with_args(dev, list_name, "#gpio-cells", 0,
+					 index, &spec->args);
+	if (ret)
+		return ret;
+	spec->list_name = list_name;
+	spec->index = index;
+	spec->flags = flags;
+	spec->present = true;
+
+	return 0;
+}
+
+int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_spec *spec,
+			struct gpio_desc *desc)
+{
+	struct ofnode_phandle_args args;
+
+	if (!spec->present) {
+		gpio_desc_init(desc, NULL, 0);
+		return -ENOENT;
+	}
+
+	args = spec->args;
+	return gpio_request_tail(0, ofnode_get_name(dev_ofnode(dev)), &args,
+				 spec->list_name, spec->index, desc, spec->flags,
+				 spec->index > 0, NULL);
+}
+
 int gpio_request_by_name(struct udevice *dev, const char *list_name, int index,
 			 struct gpio_desc *desc, int flags)
 {
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index a21c606f2b8..8229a5faac1 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -574,6 +574,66 @@ int gpio_claim_vector(const int *gpio_num_array, const char *fmt);
 int gpio_request_by_name(struct udevice *dev, const char *list_name,
 			 int index, struct gpio_desc *desc, int flags);
 
+/**
+ * struct gpio_dt_spec - devicetree specification of a GPIO, not yet requested
+ *
+ * Filled by gpio_parse_by_name() from an of_to_plat() method, which must not
+ * probe other devices or claim the GPIO, and consumed by
+ * gpio_request_parsed() from the probe() method.
+ *
+ * @args: phandle arguments naming the controller node and the GPIO
+ * @list_name: name of the devicetree property that was parsed. Only the
+ *	pointer is kept, so the string must outlive the spec; callers pass
+ *	string literals
+ * @index: index of the GPIO in the property, kept for the request label
+ * @flags: GPIOD_... flags requested by the caller
+ * @present: true if the property exists and was parsed
+ */
+struct gpio_dt_spec {
+	struct ofnode_phandle_args args;
+	const char *list_name;
+	int index;
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
+ * @spec:	Returns the parsed specification
+ * Return: 0 if OK, -ENOENT if the property is missing, other -ve on error
+ */
+int gpio_parse_by_name(struct udevice *dev, const char *list_name, int index,
+		       int flags, struct gpio_dt_spec *spec);
+
+/**
+ * gpio_request_parsed() - request a GPIO parsed by gpio_parse_by_name()
+ *
+ * This does the second half of gpio_request_by_name(): resolve the
+ * controller, claim the GPIO and apply the direction flags. Call it from the
+ * probe() method. The request label is the same one gpio_request_by_name()
+ * would have used.
+ *
+ * A spec whose property was missing is deliberately accepted and answered
+ * with -ENOENT, with @desc left invalid, so a caller with an optional GPIO
+ * need not check @present first and can simply tolerate -ENOENT.
+ *
+ * @dev:	Device requesting the GPIO (used for the request label)
+ * @spec:	Specification returned by gpio_parse_by_name()
+ * @desc:	Returns the GPIO description, ready for use
+ * Return: 0 if OK, -ENOENT if @spec holds no GPIO, other -ve on error
+ */
+int gpio_request_parsed(struct udevice *dev, const struct gpio_dt_spec *spec,
+			struct gpio_desc *desc);
+
 /* gpio_request_by_line_name - Locate and request a GPIO by line name
  *
  * Request a GPIO using the offset of the provided line name in the
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 3d966e0d1a6..2401c5ed1be 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -257,6 +257,45 @@ static int dm_test_gpio_opendrain_opensource(struct unit_test_state *uts)
 DM_TEST(dm_test_gpio_opendrain_opensource,
 	UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test parsing a GPIO in one phase and requesting it in another */
+static int dm_test_gpio_parse_request(struct unit_test_state *uts)
+{
+	struct gpio_dt_spec spec;
+	struct gpio_desc desc, chk;
+	struct udevice *dev;
+	const char *label;
+
+	ut_assertok(uclass_get_device(UCLASS_TEST_FDT, 0, &dev));
+	ut_asserteq_str("a-test", dev->name);
+
+	/* test2-gpios index 1 is a4: parsing alone must not claim it */
+	ut_assertok(dm_gpio_lookup_name("a4", &chk));
+	ut_assertok(gpio_parse_by_name(dev, "test2-gpios", 1, GPIOD_IS_OUT,
+				       &spec));
+	ut_asserteq(true, spec.present);
+	ut_asserteq(GPIOF_UNUSED, gpio_get_function(chk.dev, chk.offset,
+						    NULL));
+	ut_asserteq(0, sandbox_gpio_get_direction(chk.dev, chk.offset));
+
+	/* the request claims it with the label gpio_request_by_name() uses */
+	ut_assertok(gpio_request_parsed(dev, &spec, &desc));
+	ut_asserteq_ptr(chk.dev, desc.dev);
+	ut_asserteq(chk.offset, desc.offset);
+	ut_asserteq(GPIOF_OUTPUT, gpio_get_function(desc.dev, desc.offset,
+						    &label));
+	ut_asserteq_str("a-test.test2-gpios1", label);
+	ut_assertok(dm_gpio_free(dev, &desc));
+
+	/* a missing property parses and requests as -ENOENT */
+	ut_asserteq(-ENOENT,
+		    gpio_parse_by_name(dev, "no-such-gpios", 0, 0, &spec));
+	ut_asserteq(-ENOENT, gpio_request_parsed(dev, &spec, &desc));
+	ut_asserteq(false, dm_gpio_is_valid(&desc));
+
+	return 0;
+}
+DM_TEST(dm_test_gpio_parse_request, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* Test that sandbox anonymous GPIOs work correctly */
 static int dm_test_gpio_anon(struct unit_test_state *uts)
 {
-- 
2.55.0

