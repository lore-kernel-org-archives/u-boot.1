Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AFCC25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC6088385;
	Mon, 13 May 2024 20:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Gq7S1q9q";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gxr/ZmaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E46E882ED; Mon, 13 May 2024 20:13:28 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1CA87F39
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 984F31380255;
 Mon, 13 May 2024 14:13:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 13 May 2024 14:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624005;
 x=1715710405; bh=dqH7MeKxmLgwT7duSypbBpjdgwqP27IixCx8Vqgz6qI=; b=
 Gq7S1q9qBHHeNMFie5PHUUzVw3gWWLQouwlW7oVfyJZOJGAFrRlyEHfNiXgjpsf6
 +N5xxIbGgoLsESSn4hrjbAvBmi4Nnl+OQdDxKlr9bnig0MYW7d1eLTepjfuvWS5g
 LtEov5XXGb5VxE7Oi25goWiOJ3p2+lu/HKYaScfMF8YxQJtKq5kspR7uchXIRicf
 VYCGPtFrOfirb2dGTcYoiJW7fTv+anokqYntm6R50tnaI4SC5/KhF1uCP3LAI2Rd
 r1WujayeRAKZX2VyGmkALuX2ykbrpqNLrN2WN2a84ytw85HbTeJhx80pm16NDb0l
 n5uNB0pV8wcMz0JZYzskag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624005; x=
 1715710405; bh=dqH7MeKxmLgwT7duSypbBpjdgwqP27IixCx8Vqgz6qI=; b=G
 xr/ZmaNQ1nCnr0MquTbqCP2Baz2glh7wJ0aKSYeLpnDBI96k82Mle/h7DKrHjiuV
 xHG8eXhzgPXGBHJFDKF7aaT7S36FGNbhnzv+fANuboE5+C2e92f4XXsfJ0Dev+ph
 Iy2Z97ueBRH34TycBD26P7a5uYmUOxUCre/SQj+WT8VgKvUObCmGU5G2j80seLOm
 LZQP80gHFkwlMrSYmGPVCcSxygVloVBd/ARdlksrQkvpmnBILouIA8P9O7gH7tj1
 EtFxUmbEGI3PBZ1o39cmJk0C65z588dDbsMgZ1/VREtsHstaMcp0jkI3ziZwVSu2
 DCq606g49yi3mcCsAEDwQ==
X-ME-Sender: <xms:RVhCZtdtK8OrYftQqJJeDM7xSKXCzV2IujqN6ePwTLDkh7o8Dffo4Q>
 <xme:RVhCZrMKVxpL0CGfeEdSd_3z-gkPIKPmrywcPp6T0DX-j0X994IS5f3DUH1b3fT_w
 Fm70S1_GqlcsS02ldU>
X-ME-Received: <xmr:RVhCZmi4EHkMpuD5ajN1K5rliyrxJ24Db6u39LcW-2iUo9_BsUBM_uM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:RVhCZm9gjwaOnBA7fJhdBqTE--EOHBwjMWhN2muGlnszLuaVOTXBjA>
 <xmx:RVhCZpuNRwAo7CFyrL06PFRkEw-JbRMQKY6vcT-ICNBbtKS4t8QP3w>
 <xmx:RVhCZlEpe910jX5_Z2yfJuKLsVBvWyh39CdDKIzHg1biyue2YAqi8w>
 <xmx:RVhCZgPv2LuWYDJOOaUYX0HqxlXRbeLhlMvZMVc4WNLz8iimiKAXdw>
 <xmx:RVhCZqm86HuTCJaoPmcmaHW3lTfkOzYLHuzxsFcrcgykX9VSrgbjVfgD>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:24 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:07 +0100
Subject: [PATCH 10/13] clk: boston: Allow to get regmap from parent device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-10-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=DfqmG+aARBsvQ0h3NuFP+96dkFMiCYO7T5+Q/H3qFVo=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOMUrvVPX/cnGjAUvZY+z26urXKBs/JjnN6Kug+1g
 olHn0d3lLIwiHEwyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwEQmcDAyzEj+IiSxdIJw/+wJ
 0Wvyb05gquDLunwsqS/gRNuzj1Un9BkZPniuld6g/XjjbqMp/lJlDEYf5vWt1rU5u9XNS25ppks
 NAwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

In upstream devicetree, clk_boston is a child of syscon node
and there is no "regmap" property for clk_boston node.

Try to check parent device first to look for syscon.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/clk/clk_boston.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk_boston.c b/drivers/clk/clk_boston.c
index 030ff7cc58ec..2e584ed867d5 100644
--- a/drivers/clk/clk_boston.c
+++ b/drivers/clk/clk_boston.c
@@ -64,11 +64,15 @@ static int clk_boston_of_to_plat(struct udevice *dev)
 	struct udevice *syscon;
 	int err;
 
-	err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
-					   "regmap", &syscon);
-	if (err) {
-		pr_err("unable to find syscon device\n");
-		return err;
+	if (device_get_uclass_id(dev->parent) == UCLASS_SYSCON) {
+		syscon = dev->parent;
+	} else {
+		err = uclass_get_device_by_phandle(UCLASS_SYSCON, dev,
+						   "regmap", &syscon);
+		if (err) {
+			pr_err("unable to find syscon device\n");
+			return err;
+		}
 	}
 
 	state->regmap = syscon_get_regmap(syscon);
@@ -94,4 +98,5 @@ U_BOOT_DRIVER(clk_boston) = {
 	.of_to_plat = clk_boston_of_to_plat,
 	.plat_auto	= sizeof(struct clk_boston),
 	.ops = &clk_boston_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };

-- 
2.34.1

