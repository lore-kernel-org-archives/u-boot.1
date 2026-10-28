Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC5606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HYVMnVFo;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GxfzII1Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC3B081701;
	Wed, 28 Oct 2026 14:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvZ7d5Rs-on6; Wed, 28 Oct 2026 14:49:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C25868127D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198894;
	b=Mt4jBKG6qwT1Pu1vwY0e9e7pU6sSq7JY8JiFD3uOkjTHBAAiv32nIeKFFy2hgCQwyTbm
	 1N0U6yboqCODutIYvUcKMx+6fqRJMBfqNtlqaN/vygdwoQ0JWONS7CWzCmisP7kN0dtlJ
	 mcJAtXxLUXi1eyxhRA36bbmiJoP5jnPhuEjY8LpB2OzwWHU7Mdd4i8Z2z3UJ5SDE8aAA4
	 fPujYy5AfmFMkdKxi+2COyHrjYiHNgiznw4YQp8T6S2TFNOyevg44HaMEINRjAvNV6qS6
	 Xnw+KLaI/QUABPtOVaAaBitl+EJCUIjmYtWPA6uYo/sOd0vOSP87LW5VAGHItXQO1EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=62e0oSKyg0J+SZvcU25dP+WmX7mgjjCBDtJk/1ClFh8=;
	b=iaoTz7IMDJwn3N1W0ttkdMvV2tPx5Hw2LZ8M7ke3Y6s0rGWhOn5YtnJqIJ5R13jd0jZD
	 vOAjo+3/5Sy4/OH015BhD5jEPubVixT6/dFgWtIMFz+sqEd/p3qR74SopmD9dzuGobvTB
	 O05EV8IRk1mSkp+qiA+IGa/MEKWm4q0zJ7pWi3tRi2MbcRjCUK6mxgKFKZy3X2kHDJAua
	 m4CNNg/Qek2wQJBp4JwhEfF4YqQS26vYrmoMAnJM8yhENLxUp9V5710FwA/ool070s3RQ
	 5U6YgdT6L8dQITISoDyG9Z7Kk9wcmxD9ALYtKEWDkJHXJlj0og/x/RVqrDoANM1fqWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GxfzII1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198893;
	bh=62e0oSKyg0J+SZvcU25dP+WmX7mgjjCBDtJk/1ClFh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HYVMnVFosCawFcz5yZhi4Dcyd5oZaOqpcpV1MFAD1S7tCjC9L/cGSyXZRIXQeka5m
	 ffrZQsCaF0zynRppp74JPGhhVI3pvnu+sBU7DuCUGUoUbDSaA5GcBxzJiZEXELiyW0
	 9ckVS1o+CO63qGqspGdp/RmfT6bdUEOLhTmUFDrMElVRyihCsc4u1vS3xCkvz4TU91
	 U61ciwhzG6oiJc4N2tpBmH7zKUlQ+MgM+qflCfIcZTrsCqiOIcbPmoGprmaNMmrM+W
	 p7jTJSoExxnr701ZHtYUl2qQq5L/FNLV/B09HhCKExI0PA284HqAB2t92Xyu9vEuga
	 nwc+ixgUew7FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C25868127D;
	Wed, 28 Oct 2026 14:48:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A9E54235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B90380CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0h3e_zhI2SJM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A072D808C0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197011;
 b=GgfB+tP+7kb3SEiQEf+jgCPlSzyREybQFiPZmDYWhAE3oEaqF8VeN2xzVR7JyZW2Sb/y
 7850hmcE1o+mMUzZ9XM+y+DzHYtPDdahhP/OsTVeIy66VCjpDmmaJvo1+7EXEf0OWiifK
 H3rVaKO74sVmV2BMmn6cx3cvzF1EHUPZHNAs0OAiOyA0SA6KAS3WD7dPZMWLqaCM0Cu49
 IhvcVN6SoQz325lR85+kkO/g7VN9ufat28rbaeIq4VNSLYqPa4D0e3GRG2PE3DFPO8ReW
 YjgGW9xOgLpOTYfVkMILe4fDj+YwUgjt3VX64EcLu0JdwA+tApgYKZd5J/+Aq4i6Xcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197011;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=62e0oSKyg0J+SZvcU25dP+WmX7mgjjCBDtJk/1ClFh8=;
 b=Fc+EIQvur8J/k2j2qnRtLiZ5B94KsqhodSrZ6RzsgjrinP74FlLZ0xgDKjZfqoTVCJVA
 11rMA20+2dDAVZKe7vG10zIdtb/MLUta28DyGXopQhTBqiWasD2kWg1XT/6kfwyc4NjDt
 USNNq1LSY77cD8HgLhQD+GtvFXMEXWBLQcSDTwOR4EO5GnzBRg5NM0HQ7s3xsm7lmA3Tr
 uIWQI87khDW+eza134HUYJvJIDdJVvclTKUEA3riqMdg0/w6qUQn9hvBo7dHVFmY9FlmF
 GJsAIex6wSaQmvoXxnIw/54HISizFXVp3lRPpydVkLqbvgrYTAFrN3xWsVrOvIordmA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GxfzII1Q; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GxfzII1Q
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A072D808C0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:50 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c347be93d54so11432566b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197008; x=1793801808;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62e0oSKyg0J+SZvcU25dP+WmX7mgjjCBDtJk/1ClFh8=;
 b=GxfzII1Q+wziGTm4ZVJi2a/kcCQF+FT5X89aEdyRj3VIK2SsZM6lwC7uyIaFCkbNR0
 IuvC9C8MyhMh0T+VhX6cMuN2HUqs1VogKcbxfIK7K/5KkdIVFUAviAA9b84rWp3d/LLE
 oZx6mzXWUQnyaZKQCSJMwp63z4586vh58LWfJoZqQLtWmt4IC0XEypb39Sok1mgN47ug
 tfbwcVyHV8mjModo2CgE9Dt96BZMHpu/5JvD3bzI3fy5RuYecK79wvF1QBnlV8kbKrHL
 i1sh00Jm/BAPpuYZVSd/XZ1qFDLrh6gBGE6HWiMjAhBDDaogOmDQOooffXUqr+m9AJdT
 kGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197008; x=1793801808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=62e0oSKyg0J+SZvcU25dP+WmX7mgjjCBDtJk/1ClFh8=;
 b=h1p1lSgRuTDr1uOF5b6Y0wMWdqiUwUqObpWSylkSqwQuaIZgDma+Ay8IAian9SvpSG
 wEe/Xtp41sCA/7ee1foUnn+hWTtqLbtqEylMSQyA2y1Cmmh/mFNUZvZ88TFlB+JvBDbJ
 BY6IKUGPYZ6x8+kYtefaOfTMG1qh83iuwCHIIGzXOvErUvIFmyuEhw4oyzMvthdFw4ND
 T5uJLv+65LaypKU7Bdqvv6znYJjh8H77gAoSe0MVcZJO7WT3PmZf61wN83OtBKCliv7l
 F/72yJX3ALwdUVLVYNbNMZcBsWRFouxQMR1zSssycb4uu84mS2ZdO9JIVJ9J5kv91uv9
 mqYg==
X-Gm-Message-State: AFq9FYI2K3O+X1zKnGBdOXbauxYdo2/3yDN0RcVH7iP+HHspmfvE6dDn
 8BLf+kJr6x6PVO8K17xPkALMxzaMCN/fP8RkYoIahI0fOqAYOSLsQ/xqjTVR+c03wIDm6Ze5yUT
 Ubofg
X-Gm-Gg: AYBFou2qkutaln+V2H+TJgr6n1i9Qo2sk6O06ScPZ11QB9C5p8ViUTTAITNvCeTP48n
 JhMnksa/2Cbq6egETBg0zbVS2QeBISCyxu5Ggzp+Nw0KhsHavO9UIFFp2nvciXNTnglyYtbmeX6
 lMuDZRYcjCiFxrYBtK26Y83EbKFPHMBQCJ5n5gd9/6LmfKyuhO+SY8a1oYs5Y5PunwN/rsohk4n
 cF9mk5ANUjc6FiIf6zxFU5B187463UNXD9PZohog6V98EPLNyyio4vyHEX1mbtXMCUoJ2kC2L8V
 3blD7sBCNWmJZKYfH5DD1pDzPVGpnIn4VCIB9z3pMPU3wzwziDml14EEci9nWS0czpIdJD14rgm
 KaRXbrqiv5Vc03Ff/HuEGe75tYZLBEF6P1x8cCrwVDmtb8UvbCnHeLz7IK8XnDXVAhYnKTTXnwJ
 yrTxDhZw37L2j9KjyIVAPJxlqoyOa4LjlmJb1LXcbFxvOpYG5FvFuHgp6EXDyFth4BhBjYfnlVE
 pGhEjTQu7oQzqfRx4KKEGzYGt3mQBdsmiXnZSpKatDJPxo67E8vAfIyOqohTJ92noPSXQLvWbZ2
 UNXZBpmgOJmslAoxnGYIWZiOOB8/kL1jycRKRO7CY4l3oMhYOpsP9jMblHjyv3to+iepMuF42nH
 baVjH2Jyocg==
X-Received: by 2002:a17:907:da10:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c49bda96afamr290410766b.0.1793197008071; 
 Wed, 28 Oct 2026 07:16:48 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630412866b.38.2026.10.28.07.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:47 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 10/30] usb: dwc3: adapt io.h, the Makefile and the TI glue
Date: Wed, 28 Oct 2026 15:15:34 +0100
Message-ID: <20261028141554.3073545-11-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Drop the trace calls from io.h and bring back dwc3_flush_cache() and
dwc3_invalidate_cache() from the old io.h. The gadget code uses them.

Drop the linux-compat.h include from dwc3-omap.c and ti_usb_phy.c. The
restore commit removed that file.

Keep the U-Boot Makefile. The kernel one lists files we do not import,
like dwc3-qcom.c, host.c and drd.c.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile     | 16 +++++++++++-----
 drivers/usb/dwc3/dwc3-omap.c  |  2 --
 drivers/usb/dwc3/io.h         | 36 ++++++++++++++++++-----------------
 drivers/usb/dwc3/ti_usb_phy.c |  2 --
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index a619cd374fb4..a5775c4bea04 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -3,16 +3,22 @@
 obj-$(CONFIG_USB_DWC3)			+= dwc3.o
 
 dwc3-y					:= core.o
+dwc3-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
 
-obj-$(CONFIG_USB_DWC3_GADGET)		+= gadget.o ep0.o
+##
+# Platform-specific glue layers go here
+#
+# NOTICE: Make sure your glue layer doesn't depend on anything
+# which is arch-specific and that it compiles on all situations.
+##
 
 obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62)	+= dwc3-am62.o
-obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)	+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_MESON_G12A)	+= dwc3-meson-g12a.o
 obj-$(CONFIG_USB_DWC3_MESON_GXL)	+= dwc3-meson-gxl.o
-obj-$(CONFIG_$(PHASE_)USB_DWC3_GENERIC)		+= dwc3-generic.o
+obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
+obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
-obj-$(CONFIG_USB_DWC3_LAYERSCAPE)	+= dwc3-layerscape.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
 obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
-obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index 4b219c35eb35..9de8ecff3adc 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -25,8 +25,6 @@
 #include <linux/usb/otg.h>
 #include <linux/compat.h>
 
-#include "linux-compat.h"
-
 /*
  * All these registers belong to OMAP's Wrapper around the
  * DesignWare USB3 Core.
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 1e96ea339d48..23bf1f1b43a5 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -11,10 +11,10 @@
 #ifndef __DRIVERS_USB_DWC3_IO_H
 #define __DRIVERS_USB_DWC3_IO_H
 
-#include <linux/io.h>
-#include "trace.h"
-#include "debug.h"
-#include "core.h"
+#include <asm/io.h>
+#include <cpu_func.h>
+
+#define CACHELINE_SIZE CONFIG_SYS_CACHELINE_SIZE
 
 static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 {
@@ -27,13 +27,6 @@ static inline u32 dwc3_readl(void __iomem *base, u32 offset)
 	 */
 	value = readl(base + offset - DWC3_GLOBALS_REGS_START);
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_readl(base - DWC3_GLOBALS_REGS_START, offset, value);
-
 	return value;
 }
 
@@ -45,13 +38,22 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
 	 * However, the offsets are given starting from xHCI address space.
 	 */
 	writel(value, base + offset - DWC3_GLOBALS_REGS_START);
+}
 
-	/*
-	 * When tracing we want to make it easy to find the correct address on
-	 * documentation, so we revert it back to the proper addresses, the
-	 * same way they are described on SNPS documentation
-	 */
-	trace_dwc3_writel(base - DWC3_GLOBALS_REGS_START, offset, value);
+static inline void dwc3_flush_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
+}
+
+static inline void dwc3_invalidate_cache(uintptr_t addr, int length)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
+
+	invalidate_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
 }
 
 #endif /* __DRIVERS_USB_DWC3_IO_H */
diff --git a/drivers/usb/dwc3/ti_usb_phy.c b/drivers/usb/dwc3/ti_usb_phy.c
index f0ecdea958ae..f1ddc0086945 100644
--- a/drivers/usb/dwc3/ti_usb_phy.c
+++ b/drivers/usb/dwc3/ti_usb_phy.c
@@ -27,8 +27,6 @@
 #include <asm/arch/sys_proto.h>
 #include <dm.h>
 
-#include "linux-compat.h"
-
 #define PLL_STATUS		0x00000004
 #define PLL_GO			0x00000008
 #define PLL_CONFIGURATION1	0x0000000C
-- 
2.53.0

