Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C555606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mad/CTbF;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XUgXpSgC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6151B81226;
	Wed, 28 Oct 2026 14:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MVH0mwkdHxU; Wed, 28 Oct 2026 14:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 814F481325
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198918;
	b=iUtOgzbRZhTMwtC9f0ofsUo+tPoE7gdVXPYxJcH7BmFrPvKRHprk6S0YQ4sTyf6kR7J3
	 9Cuvpp6qs1gyitoqutM5Gl0hpmQ/tFdlW6+otpg838nlPG7vvsfTIZCYzQHUXS0U/3UZ1
	 tWPFGM/pcuxbDcErfKMK88wlNlGLtf9JC6KozaPUcYs4yQTiHnaQmh9X81360MVkKPEMW
	 QvbukSyH+q3xSd1Y150JqUWrh1Rl25qSz3/Twjb35FePnry9AnmZQf/ibrkhKsB7TBozE
	 8QZdSuqLOOq560CIUZ0gnYEzGjCvZmIyJ3HsT5PzfhEfjJz5JhYGDrBHi7tRdTEoW3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
	b=gTL6mRWPUFMypVpex7XUwiNKIs5JjxYIUb8kEDogjI1gOJ+3/XBgfXRbCSNWKyIBMdxq
	 OTXk7lNvWqDFKMZ+zPrxqV0qFXsXH1ydoeyrmPKJGDY2aws3gER/OPDoXmoiQ+gf8jyq0
	 QME6BnJwAEwgS3g15zhCb8FzE7nfIpRQqIKQ38LcnjVhhqVh1/n88JcuQC8+5jyBHC8Tn
	 nhcocH0oeb7MBAEYi1ZP6uVdqrd8+TXrafUjipxNzBVz7FExnRTC0X5L1Evp1jLm4lxyT
	 9ka3spPzj/RpIwGqKLZtxwkM2wiNzUHjx84b0tiTZ75jIQP4L+KHHPbeNspnPF4AhoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198918;
	bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mad/CTbFTU3lw5CymJd1ryPxLeyxwfK1ZRtacF5FvjgLO79gLvf86lPXD8Mgn8bMD
	 kFauxCshjOf1SE08S4jRYJr3RYrWkcuXud9cFyuOqCab4WAjK9ggKlcUwPcWss2KLF
	 8lAknK90lJ35PFJ6OaYEP7mUfbviQQbfUXmOs2u+zTofN/6RiXxsT7oboU9+rACod3
	 jMP9GNb5qoMOaIGdBf0Srka6gierlix70Xbo9A4r1d5B7RrTAzIHnGBpjYUQC+6rPV
	 GcFwx3AgIQ59+x0sTJDLV+uiPPHhkTKZ4V/yaJVSIvhVcMRgII0PGyzyNI3Q6/ffT4
	 Y5kTZyiTbjqIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 814F481325;
	Wed, 28 Oct 2026 14:48:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93AC8356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79E0260665
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KB2E5Ul8QG9f for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AF37605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197064;
 b=pRTrYZyJm8keqN/utpC3fKV3z1Ku5jWsHbbWza1lgo9ych9Jy2jSQBSK2JkP1Y411BVC
 7UNR0zP4SUkY3/xXNkn3FRRUxLQw5eSvn7NymyG2wJfy4KpJzaaMTA/sqRR+SGiyV5L7C
 kjmtZ6ftgIuqEdBp+msLRD4JOTmXFoE88Mx53QV8Ls9c5kggun3MUMvncfbL5kseGhnro
 pPg6RCliewxPzqKuWfEgtXkCJh0NX0h0QByl4fWXi385eN0NcfchzZkg0Hp4QpPcLTiRv
 zkgrZtuffQ6oJ3a9HKEXByWqnxUvwx5Hm94Bmys/4j0qE2XY/naaNvEOU1hRJ3xlL8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197064;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=LbPh/2KiM5iiUm9L30lHBG7q8KhCNXriWXXduvPP9vkMbYdXStmWffKrBGT6z1kNh+sT
 dPXORZObklzYJZNFGpA/Yws1KJxXqvRGd8ayfJ6RIIl6WqGRPK3aZPowoZD/aJ4MjOq0C
 9rSbXxQqr1LXRrzvpAOKvQb362M0rCJGWq/kAHM6ePLTe9ki8c3pp71rzloWVEs4AETm4
 YipcQmuIVQm6Db5+tp3MchX3GnwvtKHcLQEezzXKxYTfMw9maAm1C3Xwjy3k3LyWNXcfv
 VcgsiNi5sA0AQzD28JkFS3HOIKhIWIlkaeKSETCeetGRdG2U1mDkEJAXVX4STzNSw7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=XUgXpSgC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=XUgXpSgC
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AF37605D2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:44 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c407213696aso10487966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793197062; x=1793801862;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=XUgXpSgCZ+Xbc1llr1pgpd2XUXAulk7CbZUvkLnIPBSPmln7i9+nzhGHHvrp7CPxu6
 6J7rRfGTE/oPQGhR6cePFABs2NA2D+P2GVtq5iq7e9K4jtIbcyvwNmsrlHJNEmM+/emo
 BUxBTm6vm9A8Kh4VgOzVlYyTHQUZzatpNny4y0ZpV9QUxMqf9o4GlHIl2CyZyS5tYsTN
 yzODLTYplPF7BECB4vbDE08L17YXTNlFp4MhDy6XXDt5yqkF7QOFlXmLLKve7Z7Y6dBl
 CoppeCgB4t+zqH9p0Fd/wup23dRkoUEb6zTGv/giTLmzZ3BF3dgrwbXzGgphPHkZVcYP
 haDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197062; x=1793801862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=33cEKM3J/a++Z7XM9TGSWj16FwieEgO7bvuinWAmRsk=;
 b=CFqFRR8noIHTXfiBuQ7JN24RroxAdRcSmUnefLKLY9Tepnot0RONoTcsqvvpYuwN3r
 ZXNTkAe2KDuW7qiBmYj9nrOKNen9goFxJv3VrnoFQgnjWmlbdw+HMWBkqBxJftn9CNEK
 yCX+Nd/N33wtEW1O6OUMkquspjC1yIj64eoIcMtAuNxrCExXVDxVWMK84kkEBHbR2V6k
 8GwQaCgDc2sfj0yjOH8+TPrPgqkFMSkRWOwkhl8rpvyKzWzvajPVK3DCl4GAblAASWqT
 zq2RlPlvh/d9Ua3CD+g/OcNQYeV0yz31tY6ziWgyRWT36jgRm6QE/C4IFmg4tUyfLG0H
 8klg==
X-Gm-Message-State: AFq9FYKP69zk5xlq7s3kJ0aWtVQdwPXVDMRwsjJzLx2/nV209RiaCH1s
 ZGOb+tnuvQamaqthoHZKCucNqX7LbKszu0pdi4j0IU/o6pot2iWEBkHxZW5ZOcRb++vHT+PA7d/
 3SwGB
X-Gm-Gg: AYBFou1XqCSglTgEctGH90OePu3zsBYoza//MXmmjrifTgD1X3VkbFc4MXtndIU5+dl
 RKF5QPC5ZkchDtfzSHrwz0JJFery0QbcACqooH7CCXUnAs5HcHv+4TxoUubrE66XUv8CQuHRhlP
 QY22x39JKGKB+gQ8EL5iU290CmA52XX+OivufsG+QOTyXK2Yf1s/8QANzOCtG21oKWsOq6HiUp7
 /046UrmVpMZB673KEO9GmQjfJnE0kkOjJ3qbC2yQiTpcq0C4btZ79s3CUjm+goj3uzq96f1fuSH
 J7A6mZUCafEaabFHy6tXhT+lV6s4Yl13UhsA05jgJno8BB1o9+FZlNUZjgBfALZjSYh3ua+7ZH4
 iT8seBe9zy3Y0zQ1aiG+IvFl+3H+c8ZqoqN5zIfJJW1zLKedSlOru9eqrDYU91Ouv0UEKrSIy+u
 hDthlZsjdXkUpCs+LhyumtjseaB+9UyMFGP5MTucss6cnRsXvOG0lxXCWKnVMpPhInSfo/Ukcsu
 IxkyAZxm4oc8zKz1VDFjM3v3t7xKBqPJU8cCD65YwimYZ12dN4vrjJkKYiP1nBVOYxMrwikErpi
 FWzhfo5+cDKHZJhXW0mXl3cFSVz5zCK5qWIeJFtKmCtGEy4mDVvld6B7x48F1vEFMZ7tYn37BDE
 9s1z+GxAtry6kBkDUfYe4CdYaGaBfXOA=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr311951266b.0.1793197062183; 
 Wed, 28 Oct 2026 07:17:42 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm618675366b.0.2026.10.28.07.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:41 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 23/30] usb: gadget: at91_udc: set endpoint capabilities
Date: Wed, 28 Oct 2026 15:15:47 +0100
Message-ID: <20261028141554.3073545-24-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced epautoconf.c matches endpoints on the caps field, not on the
name. at91_udc never fills caps in, so usb_ep_autoconfig() finds no
endpoint after the resync. Same problem dwc2 had, fixed in
commit c5c4cc4c6b98 ("usb: gadget: dwc2: Set endpoint capabilities via
.caps field").

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

