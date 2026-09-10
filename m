Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E029FC88E45
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E5F810CF;
	Thu, 10 Sep 2026 22:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79MwIdjC54Jv; Thu, 10 Sep 2026 22:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A7B0C810F0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789078110;
	b=hHonIGBqPMRoj8GbmcBGje4tKgv9qw70ugLvFLqz0PWcNq2r8f2pbgD7witgcIcWTC0F
	 JaYQoVxOy3d7/mT3Si1FmGSy6zHWFy7BauIvUF++xsQdwo/eA+R0QSSlJ1hIPAZEURW/t
	 puJIswR3npmKK+5sQh2j38Mqo+d4RIw9leIp9NwqwIrXqF6sTwmgkH2EgA/K50ckUwR4C
	 0lYTfAtUsK5ltElaWY0ezB6bqnFfQpN0FZIb5VzNdQzOfKNrtcV9mGELh4npgVv7R0Obs
	 6qxKEqc227QQjbwu/ewBJnBLORMoLN3QcilOIGzmzbtKiZKK4t4wsvDHxtVJ22xXvLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789078110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RD/PHe8+oEZjM2drlqEd8QptR8fPLgO4MN8jeBHck2Q=;
	b=CmsnRioYKcqA+C3s/vJS0arPdo7IfzStD4F6ykA7AuBwrgA228AW3lIb2GFzOfK7c7k9
	 a9IbVVyognR6WySTjAmqiUvsvJUj5hH00/+584dTBAJ+NqcizKIS+Gb5d4Y7p4O/Bog09
	 r7BqAwHceb3alwM8XDMDxJU4PgbvcN+9EsNt6I50/QkOY5Io7j21m79GqXFEp/shB3QY1
	 STm/+qg+u+skEzgnfVN0D0rrplPDzoJ+R3prT3rGc0iwRIpVOzByXA6bmnmtlM5gz8F7r
	 Tk58MnQFV/DfTfT9+xcJjSXjSUdTowPglsKqAo4lZx3JgZ5Ai4pjB+7F0O6FjxfyG5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789078110;
	bh=RD/PHe8+oEZjM2drlqEd8QptR8fPLgO4MN8jeBHck2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HraHk95C/+9vs/CM7x/crt+CARGfM/khhTEpVzj304oLBHG3VsuE1sZxCVFpuV/rL
	 THFtTSeDm+sfUOMWe3L7Of5OZ+SdXvFN2FRsJsWw2ImM1zexN03E4HQK0DjOOorlgq
	 pjXoILtHTkwf7b+RcbaGHSWQwClGbZ+L7GYg5eVSxTqogias2/fzEOgF2Cty62HpVe
	 QXvx0pqz537evYB+0Z8dvaSAuyiWkVCkeAsrruP68ZMfzusjn70jUKbtp8u3rGGwiN
	 8bts5SSdIIIEw3XC2rZDgB8Wameu7RqbjIzypPlqijCSSjDKDk4xqNU+aofBaZ5CLM
	 cf3ZglcJ/0WxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7B0C810F0;
	Thu, 10 Sep 2026 22:08:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C4F514D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 172A860B83
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkX8U1dR2u9G for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E333460807
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789078106;
 b=mpD7LGc1OuefNj3q/zq9EAkbCGu44j2xFgvAVWZALEL7o6FtXfi0htdPMf2GRFCuqEEo
 qlPvGF3ic3R6mp+Z8voHdysZTRSWKVKHxqNfLEHOCyoAL12/49V+MHJnLXm1bsG8VYaTf
 w2VztN5di28juqAkN4NekSSGbd5AlZk4Wq7vRu8VOJQHJovD+D2PgFzELgGe4GSV/UqIk
 3bxwAxCk8Hcn4mXPZ3ubSLwGKkqI11VvYmXp7/vxSusreMgM9HV1kv9w3TrEb6TuKRnrZ
 kcfAqZvY4BMzY1NYWvRQCt5dz12xLRll5smF7lxg7rkNxRguUC/+yPssfsPR5tRksfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789078106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=RD/PHe8+oEZjM2drlqEd8QptR8fPLgO4MN8jeBHck2Q=;
 b=q/p2mJGRl8/2aSobNgYVEgw9xpdJ8zVFGlXXZnZiD70T/rEeNfMhVjQ+KKBN/Zq1MvtA
 ljbA9cWRVRWOCY8kRClkT27EaVGNmdow1YWaWGSg4/aQ5Bp0ei14Lk3qFwzCUd4J9XJ7n
 ij2ziaVBnpiCg+G88DhpNZyA3igCthTB0XUOIF3koZk6/716PpH4Hp7uzEwjJSGV6zNQX
 y7iQ52b+td4K5csYhivRiEqbQQhSEL/IrLJQI3PADkjM2PRJ4avEE/N+KmUJv/90mL5z0
 vtpOWYIEktRueJOjSJgFUjU6jjaUtVaqJtNs8Si31IYTOMcUDp/kolHIhX/yWIpncnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=PM+r4697; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PM+r4697
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E333460807
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:25 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so1078715e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789078103; x=1789682903;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RD/PHe8+oEZjM2drlqEd8QptR8fPLgO4MN8jeBHck2Q=;
 b=PM+r4697RR6QxjJ0FO4reelIK/AtNqiA+0K9+y6EOmQNh7lPhhbjeMsIA//RVWhFOh
 xygpbaJXW6SFZH68FdFW16evAzYuTIVAO6AIXfWBANTEjqeE0TUaUCIIYMjOIiP1mN2U
 wbIoyibjQB+BVPbu/mIRU+3j9DTXoZ75Do0DeZ48aae0UON5yzl7Lmzra/zUsQpHXwOK
 BwsKdfeU6qHC2Qn9YrACvcSF9PNuSt0nd1syTvfBty/0mFgZFCXhphu/bxzGtJ77RcRr
 o8Og59ey7j3WJEOcNCScsarUEzGO3ZSvwqxHTldvY9JIncRAmhFV2zr5ooZ5IQ/Mp8mw
 zyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078103; x=1789682903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RD/PHe8+oEZjM2drlqEd8QptR8fPLgO4MN8jeBHck2Q=;
 b=NKyTtgInlC8za/kifyqnhkALz+LEnR6dsxM+Sx0Q3yUaBlIKwxaRHOLH1uxry50z4m
 ERoSnk3UHlO2na1F6SrGtdi6/9fVbfYHehAso4VUawO9UBL0keuhuQT1nCaEyH3adFNF
 zW0oZeca86Oc5I0oJzZ/ZB0GFvcxD4yp+0pUyeH5A6iRVU9QyMeNERTpOcX+wD52YF5Z
 UX8hQU9oifKLS6WO8YWuOAmuTnhzgJ84Btpq2NGlasptH8L4fosTRm1UGcnNRktkONXY
 kJCsPgMOF+VrxDLPelPSd5Md+QcwqmK4W5blIIsqgWTlNftH4E2iSdqQpULF7XzB4zQb
 gbWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5j8vfY7FhMyWA14Sdv47dpKljG6g0acatb4Ol37I0KNMywCnw4vbZzITv7AXN/6GitqddtLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kLEtd8w4OMcb9s+zdgbK7gVp8R45hKdst2Az2fT2cui+7timZh
 dYkMFw6mYYWwdKg0RF7Il8XmYME0rlXydXTZnNFLDMHGT3LAHRGhebQnLTsgmx+u
X-Gm-Gg: AYBFou0jE7hCq9JsB1uehGD0f1TpkRECpDB/kfCvOHLaetLzZWHHiIF02L0rsBoz5Y+
 eY8q8yTIA31xjKIPC9Z735h1WA0IEJKNnlFrNKOlgySYX8hjFBhOwPznL4N9K1qdd4oCKgm801O
 CZGUGMeNtj0P5N8mqVhkDWxdIsU/1q/IxmaTpMvyENOvmioSFcasjUAOaTl9xOA/YWWO9B7bmJw
 tQxly0gpx4ottP4rmsr6DreEgsRwtPgvPs0dtM2KHDFY2/qgmnj46jg2jaLEayBWVrzEmppHEKU
 L68TDKsdTmt0F0RborGy3nMVsgCC+g8HJ18mhCg/fW/m3G6jZxqJVXf9x3FULy6n2hr7h2/Bxbd
 LlzIk5a+9pQ5CBhWPlTOMhMr58dAn8lFHrGOrGKb/SHIcg48be3kt2wvOiRCqswD/mmS1aYDKQn
 tlysbOL/Bs0wh+4Y0e3201Yw5Zyi2HGWVScKUF19+fj4jVDF6mH9eZ5m98DvWq8L2V6Gv21sFnR
 mWK
X-Received: by 2002:a05:600c:4584:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49e60f5afbcmr15947915e9.3.1789078103335; 
 Thu, 10 Sep 2026 15:08:23 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm4795595e9.4.2026.09.10.15.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:08:21 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 2/4] regulator: claim the enable GPIO at probe time,
 not in of_to_plat()
Date: Fri, 11 Sep 2026 00:08:16 +0200
Message-ID: <20260910220818.3093364-3-mehmet.fide@gmail.com>
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

regulator_common_of_to_plat() requests the enable GPIO, which probes
the GPIO controller and claims the pin while the consumer's platform
data is still being read. of_to_plat() must not do either: it runs
before the device's pinctrl state is applied, so on SoCs where the
direction lives in the pad register - the output enable on Vybrid is
one - the pinctrl undoes the direction the early claim just set, and a
fixed regulator configured as always-on powers nothing.

Parse the GPIO into the platform data in of_to_plat() and request it in
the new regulator_common_probe(), called from the fixed regulator's
probe method. The gpio regulator's voltage-control GPIO has the same
problem and moves the same way.

Two things change on the way. The gpio regulator used to log and carry
on when its voltage GPIO could not be claimed; it now fails to probe for
anything but a missing property, since it cannot switch anything
without that pin. The fixed regulator already returned such errors from
of_to_plat(), so nothing changes there. And the parsed specification
stays in the platform data after probe: priv is not allocated when
of_to_plat() runs, so plat is the only place it can live, a few dozen
bytes per regulator traded for keeping the two phases simple.

The fixed-clock regulator shares the of_to_plat() and used to claim the
GPIO too, although its set_enable() only drives the clock; no
devicetree in the tree gives it one, so it no longer requests it.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v2:
    - rely on the -ENOENT contract instead of checking the present flag in
      both probe methods (Simon Glass)
    - drop the request from the fixed-clock regulator, no devicetree uses
      it (Simon Glass)
    - reword the stale debug message in gpio-regulator (Simon Glass)
    - commit message: spell out the gpio-regulator behaviour change and the
      plat footprint (Simon Glass)

 drivers/power/regulator/fixed.c            |  6 +++++
 drivers/power/regulator/gpio-regulator.c   | 21 +++++++++++++----
 drivers/power/regulator/regulator_common.c | 26 ++++++++++++++++++----
 drivers/power/regulator/regulator_common.h |  3 +++
 4 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index 1dd137f493e..ff01812e8d0 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -38,6 +38,11 @@ static int fixed_regulator_of_to_plat(struct udevice *dev)
 	return regulator_common_of_to_plat(dev, plat, gpios ? "gpios" : "gpio");
 }
 
+static int fixed_regulator_probe(struct udevice *dev)
+{
+	return regulator_common_probe(dev, dev_get_plat(dev));
+}
+
 static int fixed_regulator_get_value(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
@@ -150,6 +155,7 @@ U_BOOT_DRIVER(regulator_fixed) = {
 	.id = UCLASS_REGULATOR,
 	.ops = &fixed_regulator_ops,
 	.of_match = fixed_regulator_ids,
+	.probe = fixed_regulator_probe,
 	.of_to_plat = fixed_regulator_of_to_plat,
 	.plat_auto = sizeof(struct regulator_common_plat),
 };
diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
index 787f8170234..84a61f1a92c 100644
--- a/drivers/power/regulator/gpio-regulator.c
+++ b/drivers/power/regulator/gpio-regulator.c
@@ -19,6 +19,7 @@
 
 struct gpio_regulator_plat {
 	struct regulator_common_plat common;
+	struct gpio_dt_spec gpio_dt; /* parsed voltage GPIO, requested in probe */
 	struct gpio_desc gpio; /* GPIO for regulator voltage control */
 	int states[GPIO_REGULATOR_MAX_STATES];
 	int voltages[GPIO_REGULATOR_MAX_STATES];
@@ -28,7 +29,6 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
 	struct gpio_regulator_plat *plat;
-	struct gpio_desc *gpio;
 	int ret, count, i, j;
 	u32 states_array[GPIO_REGULATOR_MAX_STATES * 2];
 
@@ -47,10 +47,10 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 	 * per gpio-regulator. As of now no instance with multiple
 	 * gpios is presnt
 	 */
-	gpio = &plat->gpio;
-	ret = gpio_request_by_name(dev, "gpios", 0, gpio, GPIOD_IS_OUT);
+	ret = gpio_parse_by_name(dev, "gpios", 0, GPIOD_IS_OUT,
+				 &plat->gpio_dt);
 	if (ret)
-		debug("regulator gpio - not found! Error: %d", ret);
+		debug("gpio-regulator: cannot parse the voltage GPIO: %d\n", ret);
 
 	ret = dev_read_size(dev, "states");
 	if (ret < 0)
@@ -76,6 +76,18 @@ static int gpio_regulator_of_to_plat(struct udevice *dev)
 	return regulator_common_of_to_plat(dev, &plat->common, "enable-gpios");
 }
 
+static int gpio_regulator_probe(struct udevice *dev)
+{
+	struct gpio_regulator_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = gpio_request_parsed(dev, &plat->gpio_dt, &plat->gpio);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return regulator_common_probe(dev, &plat->common);
+}
+
 static int gpio_regulator_get_value(struct udevice *dev)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
@@ -153,6 +165,7 @@ U_BOOT_DRIVER(gpio_regulator) = {
 	.id = UCLASS_REGULATOR,
 	.ops = &gpio_regulator_ops,
 	.of_match = gpio_regulator_ids,
+	.probe = gpio_regulator_probe,
 	.of_to_plat = gpio_regulator_of_to_plat,
 	.plat_auto	= sizeof(struct gpio_regulator_plat),
 };
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index c0387eff4fc..dfc58cd60bf 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -16,7 +16,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
 				struct regulator_common_plat *plat,
 				const char *enable_gpio_name)
 {
-	struct gpio_desc *gpio;
 	int flags = GPIOD_IS_OUT;
 	int ret;
 
@@ -25,10 +24,10 @@ int regulator_common_of_to_plat(struct udevice *dev,
 	if (dev_read_bool(dev, "regulator-boot-on"))
 		flags |= GPIOD_IS_OUT_ACTIVE;
 
-	/* Get optional enable GPIO desc */
-	gpio = &plat->gpio;
+	/* Read the optional enable GPIO; it is requested in probe() */
 	if (CONFIG_IS_ENABLED(DM_GPIO)) {
-		ret = gpio_request_by_name(dev, enable_gpio_name, 0, gpio, flags);
+		ret = gpio_parse_by_name(dev, enable_gpio_name, 0, flags,
+					 &plat->gpio_dt);
 		if (ret) {
 			debug("Regulator '%s' optional enable GPIO - not found! Error: %d\n",
 			      dev->name, ret);
@@ -49,6 +48,25 @@ int regulator_common_of_to_plat(struct udevice *dev,
 	return 0;
 }
 
+int regulator_common_probe(struct udevice *dev,
+			   struct regulator_common_plat *plat)
+{
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(DM_GPIO))
+		return 0;
+
+	/* the enable GPIO is optional: -ENOENT means there is none */
+	ret = gpio_request_parsed(dev, &plat->gpio_dt, &plat->gpio);
+	if (ret == -ENOENT)
+		return 0;
+	if (ret)
+		debug("Regulator '%s' enable GPIO request failed: %d\n",
+		      dev->name, ret);
+
+	return ret;
+}
+
 int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat)
 {
diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
index d4962899d83..951a02b5416 100644
--- a/drivers/power/regulator/regulator_common.h
+++ b/drivers/power/regulator/regulator_common.h
@@ -10,6 +10,7 @@
 #include <asm/gpio.h>
 
 struct regulator_common_plat {
+	struct gpio_dt_spec gpio_dt; /* parsed enable GPIO, requested in probe */
 	struct gpio_desc gpio; /* GPIO for regulator enable control */
 	unsigned int startup_delay_us;
 	unsigned int off_on_delay_us;
@@ -19,6 +20,8 @@ struct regulator_common_plat {
 int regulator_common_of_to_plat(struct udevice *dev,
 				struct regulator_common_plat *plat, const
 				char *enable_gpio_name);
+int regulator_common_probe(struct udevice *dev,
+			   struct regulator_common_plat *plat);
 int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat);
 /*
-- 
2.55.0

