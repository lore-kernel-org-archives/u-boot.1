Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BE1C25B74
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88FBD8837D;
	Mon, 13 May 2024 20:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="hzgmG+JT";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWpqHXbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087C8882ED; Mon, 13 May 2024 20:13:27 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4A2882D5
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id E867A1380255;
 Mon, 13 May 2024 14:13:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 13 May 2024 14:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624003;
 x=1715710403; bh=A1wComkWrp8Hc+Tq4SkW/NLwxO95sCAxZYzBrXtwEnw=; b=
 hzgmG+JTj4xwEjZHhWlSBt1xK9KiKMkXO3grUwx02A45gf6whLsdNyO7Gegc4IQH
 YlgLUE3uC8mmYe5OoUYd1ACW9gSV4yWsHw5z6jpgjb0UVejxY4VPPU1uOJJWZLDQ
 58cB2qvtUDEI3U88uKQ5eTfnE4OyX++ZDl4Klz5JNI+x901La/TKyQSFP8501+lH
 aBwIE3c9Ejx0UnjBaMesZQujEQpiFgdpZBpT4rbVtDWnDL2qXiCJ0r21be4GVM+n
 XbhtCAYtK0ScccVDAV5Pzugae/d45Kbix2e3WnhrG7EcHqWM1KdkYGa8AVSWjkRa
 20NNHWvLua8CqgdRX/yDtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624003; x=
 1715710403; bh=A1wComkWrp8Hc+Tq4SkW/NLwxO95sCAxZYzBrXtwEnw=; b=c
 WpqHXbqwTmYRDUEOg9vveZQ+H5TO9kCyut6SAySxB2HixKPqndoohCeJAy+xhfPM
 zNlin6WLr7vsPpJXT9LG4r3FV+HdVlXvwn4IlAcCrHej6gNJEwMTXj7cwwnD7UO0
 aDBYwC68AGDrnOmDYyCjK7tyCVD3KQP7qVvjOXiiEDI7XKXsI6fUTOmz5mXbh/Wl
 326bRE9ipwA2F4+9ong7vgvkF8ZAsVVIE6WGhGWYrqpDEP5izsNHx7ZroCx0c9sg
 h+6WYJE4rVJYfsQ+a1CV8ONc+OTWX7j6VWaAwZdfddrjGVkjD7N1cMi85F417/R4
 Klvxgp2CffkNw0MjNfZaA==
X-ME-Sender: <xms:Q1hCZhMXoOkWG9Ixcsb0UpVKMGB81P07s4HsOsQRlLtARlGW7paqsg>
 <xme:Q1hCZj8BX1V0EAirSKj9PYQa_L1yJJnxOg8mqyTZYTShmBtmoIlrCA9rX7pp7E-52
 I78SVCasjaCYNHKy_4>
X-ME-Received: <xmr:Q1hCZgR6BnSPrgaG1fgisWc-Q6dkl1AS8fTWaAYeHmUrXDx6fzXh2BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Q1hCZtv39HDG3Ts69-Sn3lcg08Ip_lHR6zeeJ7fJV_HuonE6NKj07A>
 <xmx:Q1hCZpcOJNPH75gKjnEyMLpH4uafPjBnB_aUYUQitfFBaGtRDZlrbQ>
 <xmx:Q1hCZp18kDGupP73SGjbhKTbVJ9-LaohFogo1pURpcWF7pcdKH2N6w>
 <xmx:Q1hCZl-u02MTO9GOrx2xn3yy7HuCfoQwg4JBiAaaPOjQAo1ojCk4zw>
 <xmx:Q1hCZqV0F7FTq10chw3zJAFZEiUYZ5werzXyEVcJtDWwtvdYd3lMV0RM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:22 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:06 +0100
Subject: [PATCH 09/13] syscon: Probe device first in syscon_get_regmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-9-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=TJg3OOVTati5R3kxZvkybLYEG/0RO3iGsh59qtO3nYw=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCGP+u+GCf9cd3L7UYX1g5e49txavaPN6d+Hwp/0rg
 /bYmy3r7ihlYRDjYJAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJpH5m+F87N+jLsn1+c7bd
 /X7ov3Hc69nSAnUJcpc3bLl6frr6og3cDP9THDRjohacu3DXtLcoODfaWOPdN4fyqCXpm8rXBp/
 3keYAAA==
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

When bootph-all is enabled for a syscon driver, the device
may leave unprobed when syscon_get_regmap is called by another
driver.

Perform device_probe in syscon_get_regmap, there is no side
affect as device_probe will return 0 quickly for an activated
device.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/core/syscon-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/core/syscon-uclass.c b/drivers/core/syscon-uclass.c
index f0e69d7216b3..b09f7013194d 100644
--- a/drivers/core/syscon-uclass.c
+++ b/drivers/core/syscon-uclass.c
@@ -32,10 +32,14 @@
  */
 struct regmap *syscon_get_regmap(struct udevice *dev)
 {
+	int ret;
 	struct syscon_uc_info *priv;
 
 	if (device_get_uclass_id(dev) != UCLASS_SYSCON)
 		return ERR_PTR(-ENOEXEC);
+	ret = device_probe(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	priv = dev_get_uclass_priv(dev);
 	return priv->regmap;
 }

-- 
2.34.1

