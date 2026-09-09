Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978BBC79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A0EB407BC;
	Wed,  9 Sep 2026 12:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UzD7nb0SmwXw; Wed,  9 Sep 2026 12:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 69B2B40774
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957990;
	b=fcyDjnoUag5pKMlRTggljvQvbgWjNM0t0W3N4MnM1m5jPqo81O/x5bxqlsuQtCRO6KO+
	 24p8PBAE3aYSDkLSmPWRcz08F7DLJqmnK9vwjIPhjtxT1kmwODdB1qUuK8ukeJc+HTAvT
	 qkJtO+Lxi64zAg9QwCA6KXwKVZKqjf1mDndRgmQbu/4np4bmCmEGdZWoh+sykuFHJJJ2i
	 aBg0Z4/+s1OJbRd4LnWdXztDNwbqUS84vPqR6rltZvDvWFekrSu48J3uBBax3tJ4gNvdI
	 taMBSqfMDOjlLcG0EgMqRuyGvsv51T8VZSAUF8+L08/nC6saiTigla/KlOZBTk0yOBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	b=e9stihSFAVmUsavS5aGHE6MX58RRgLLOZpTElbsqukAYaMW2XNtabakIuQYFJl4hVizf
	 Ni0+4K8YvXXOgOEIP58B7NX1+wioE2XC8HW9AFE73v/YpfbHJt0SdeAXvC3vLsJ7/jw8y
	 cuVVtHF4pFgBQ8zYHPLq8y4slbWDDeXCWzxG8v+W6hUXLU+A9bXk6SXDRKeZ0M4hEODkp
	 GLa+2e6lEnkt/7SmmeiZJMUeT6bedCWfGk7Ev1UoS3GjCKodX0k2oeUGUYEIjFwVxCsmm
	 pqBbKLUnai9etzRA/eb17oFdSMZp0fgtHwYnhwgajKtXAp5yy5PCG5RIIHmqPG4jHlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957990;
	bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0mDwIIm73lPHNtlQMpf68iCsYC/ZfeCj4TLHVSnQp5FTLqdCSpDhDQMx7pw8CjNgT
	 MWR4f7GbM8tp6ehUnwE6U4yS+f+vIKVBdg9M/chh4te2fbb5RuTs+lQrSnam9a2n1+
	 FcH0E+1bNwZwCzjKUyS+b9ioCbCzMXCdw0gymJ3AUyLU96qWGz3kVtoK8j6qSLq5qZ
	 nvogNCqWs/c/8fRpQb+IG2Q18oECdkB5B4uYU9Ssm94T79lwUFJEdNTaN2inU+O3di
	 p07w35/S6iGvi5p+oCVeZDg22wWkCnH1/g8n4RTgHKeCf2ad9ZTYYuyg+e6xLUZp1+
	 QeN6l/CJFlcww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69B2B40774;
	Wed,  9 Sep 2026 12:46:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA53724
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94E34400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z59Qy2yVIQGR for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7947540055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943951;
 b=l6eDsoxnE0rQxlWaNmxqtf7TJD1+J9PSuLdyI4VTjSatAW3sUN6wTf7NCu8y1ny7UQrw
 VHJXJtnecArTWE50E50DFeqAAlcF+0jet8CHwUu79copYjp3SuCb1npmtL7W/ZBOi8yVP
 0ql+X/2XNH71CH99yzyyjEMJITSp+RzzPptAcm/MKPNRGuzLdyTXKTsjcxn0oHcNE0JIn
 ccICssDQrYJE19D9XGtTtZ77f99ZgLhcGbje3dTJS6gBj5h3HTIPyFg4dPBmSF/TyVioe
 GdLNMCKer0NbkYLLAlA1Jpp7XauWMFb9+/R5QFDoDwNI8yjDOT2junI8d6311LxVN8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943951;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=ePeEXFtPrXqOR+q0LCtWGDhLT2CMqj6YA1QMs9Yw9yzcU/qVLCFGGRvmlCX1704OeTm5
 ZCKa8T912g9J4dD8WQmBPcwLCiIkrqlayXLPTgCOcu+s+bz8SQ+9NXuw9jreSGv5b0R93
 /5Xg/9OXBkHMFw+M21bh+dm96ilO7ewGOORZefUJ6NBlh8cbxbfU9bWbhACYBVtSBHLPk
 APjyVYAuWXZ/ypF2E6wJDIQqcvQNhOshrsFtPMe5noDV2yOdMlINcj2+CBH3Cff0DYvY+
 PzXi084jqmSodPsJYHqQ6CEQl0BDtB7ZBtBVPADKpKEMR4j9PH30+qB5FNCacQxl29Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MxYT2cS0; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=MxYT2cS0
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7947540055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:31 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c25bf832368so59717766b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943949; x=1789548749;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=MxYT2cS0KLUVMpCCk7CwTG80IIRLHDEtFrX8det5ilJ1KvVZKJABhYlfI+OzjC4vhD
 /WEcQWPAd9MMd6JpEbW8ByU5MKsQ7zbI4hZkl9/pJIXkYYE0L07sxhvdVRvgIN/gonHK
 ayWduyrt/ynruz0tF/4jLgfscSrd1XyKaAupLqmvsfrXtbtfAb3yg9Q55e0LUOAG20w+
 z+eLMMj3zUCI/xbfzr1Bbx8M9bDnft84myudVgi8S2yAuddQ63oZORQ7N/EodbULSO49
 bt8qBIyLjVP/enjZrsTSUNONOtJoVri2uiRtsP8voM8/VdGGe5ZvOAGzsV5miUiqzDWz
 dt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943949; x=1789548749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oT2FuHTTPF3pecCQrjUIO1WAZjJoahpan0cHNIYr/YM=;
 b=cXfTVdROnkPBvOPJyCDr0qzOsJvDNmMvzXIyFBcF189C0sgAkoW950IneIIO68coks
 PejpJ8zILlsEJLicK+f03LXz4l0BxKW9DL2phGizt1ebDgOncjK8ROvSCTTZUzrnuU9I
 F2loPnTpLCT5efpUhQDvsBCKcVpl3uyKj047fA045c4aTx0EijrGAnmINcheitJT6vPP
 HzSKVHU3lGot4pPC7UeJiYxbwa8ESPYYQCC8NdxtdIqL80GF/9H51IUCet7IWCyFPS1s
 NxxuXOdEPrZetlaqZfCXSTqBD3tzrl9dkjhCVmz1PY+hfA3AMWoYYP+kV47kC7XkQoil
 hzpA==
X-Gm-Message-State: AFuF++nUn3Bx3/+wjC6DzUSU62PSh6Z3n0wtDEQ90drDZnCq6T4OTG6G
 ogj5WyefunSjq5BFMV1Xd914zW8XyPH6cLqYJnphDgZDZU6AGFt1aW+GgO/yhPQUNtKWHguN+k4
 RVy4D
X-Gm-Gg: AYBFou2ke9TyjDFyB/SYuKqVyDBodLDnJ14tiPqP7PS4UfnL/5pvaSbbbMORawbsU6F
 Q0++kaTOURCbRwFxfFEVvvn+RLO3Mlbcy06vsJLwlVVwDilRTpIU6DF5zPhuJ7dOJeE+raRDWOW
 BwJ09lsuToYSDXThhlCFBDfZKQRY4mBQQwnzfmapdboE+Kmi0q1jMC/B+xLC3ZF61nJqSitJbwp
 S87Zq+jkMHY6W/AHz7AeenT5Amg87DgTd79nKxJ89i6ESNXCPcJotxugQ3VCdOFajoR42Hvpi07
 3/NwcKU4Ie1zYdqcrud7xAxoS0yIohlfSsJqiwIvR2egYC+I0qfzz1WVGCPsA8t6U6Z+chxNwzX
 oBpmHSM/6MettcHIi49M978eJnk+oZGRUnY38r+vPea12my6QaBacL6074+my0x2O2LdJK8LVq1
 THE5DI2W42y8gLZ5juAypbKWtBYvR7wrLkteaRdXoy5YiLvKg5bjWfYXcpvfnPoh0bfOLtXRGLt
 kw0IkIi91mvs0Qv+b9zF8OfnwlXkdf+
X-Received: by 2002:a17:907:c0d:b0:c25:2fb5:e57c with SMTP id
 a640c23a62f3a-c262508549amr1012593266b.3.1788943949521; 
 Wed, 09 Sep 2026 01:52:29 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v8 19/25] usb: gadget: at91_udc: set endpoint capabilities
Date: Wed,  9 Sep 2026 10:50:09 +0200
Message-ID: <20260909085015.2480097-20-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. at91_udc never fills caps in, so usb_ep_autoconfig() finds no
endpoint after the resync. Same problem dwc2 had, fixed in commit
c5c4cc4c6b98 ("usb: gadget: dwc2: Set endpoint capabilities via .caps
field").

Move the endpoint names into a table together with their capabilities,
the way the kernel driver does it, and copy the caps into the endpoint.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/at91_udc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index ee2af2d699ff..a8ca22c906c6 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -51,15 +51,23 @@
 #define	DRIVER_VERSION	"3 May 2006"
 
 static const char driver_name [] = "at91_udc";
-static const char * const ep_names[] = {
-	"ep0",
-	"ep1",
-	"ep2",
-	"ep3-int",
-	"ep4",
-	"ep5",
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+	{ "ep0", { .type_control = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep1", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep2", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep3-int", { .type_int = 1, .dir_in = 1, .dir_out = 1 } },
+	{ "ep4", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
+	{ "ep5", { .type_iso = 1, .type_bulk = 1, .type_int = 1,
+		   .dir_in = 1, .dir_out = 1 } },
 };
-#define ep0name		ep_names[0]
+
+#define ep0name		ep_info[0].name
 
 #define at91_udp_read(udc, reg) \
 	__raw_readl((udc)->udp_baseaddr + (reg))
@@ -1469,7 +1477,8 @@ int at91_udc_probe(struct at91_udc_data *pdata)
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		ep = &udc->ep[i];
-		ep->ep.name = ep_names[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &at91_ep_ops;
 		ep->udc = udc;
 		ep->int_mask = (1 << i);
-- 
2.53.0

