Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uZ5PcwII;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KJhCloEt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EAEC80C1C;
	Mon, 26 Oct 2026 23:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zqDxA1EWRoBr; Mon, 26 Oct 2026 23:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A15D80BD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058416;
	b=jCpbns3AZln7gg+2RMgrJEoR5QKQsxFh7620HPPj5dDUION93pH9twvt9XXNJZP7qU6V
	 tV3UdKnsczlxtcFK+IFPn6YHxgcPGHFMgAE++4TlRp74BPj7Smln+ipmiHfU6ZKF5WtgA
	 n+7te89d69W0Zs+/8BqCp+GP7KcO62gAiqeTQjbTJK1+6YTBbeFVgyyBh92Y3GQPvsUm4
	 xrl8iIbkpS+1hXYsBsjWqp+XHon3v8XBD2NjQy4nyNyZcIhbmNNk+QJ3TEFIbCl7p57Et
	 gGlfYlImijOx/Lu0f1cTKFV/kN/wNOXsYjg3b5RZPrSG/EyLP0rw/w1S6ieMPcGyvkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wKtbIninv2cJiCW+HliRpAzvc3fbs6zVxbR0Bd2K7Aw=;
	b=I4Lnl7GxmrJHLQ0eLeJpfy5X3ZQj+iIXV7q97mH+Lr+0UXmJ8bFF2iLbK7uw71Qb/+vG
	 gWkig3GWtPTHwFN9v2+KRgyMKRG8ctop9UPEFrdaGWw/Lt2PGJIXjaiPkoRPnY8JUnVt/
	 dpd6dYQwtxvXpWgRG2nYw5TU9lrqRpkDXHLkI+w6olGZeUaB3pm5ogO36S0psflptazNy
	 TX59A8ZUAK0yZFy4izuDtqlTB5TFuYeZ3Ufkf0/GX7pi+GAOqBx1KIrD7DR54u6xbevmY
	 F/Ro4siiXo6YrVXgDKqc8q0iIpY5zXm3qEx6UVXUVhIc0qS8EEpf2b9wbPemwIg3vuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058416;
	bh=wKtbIninv2cJiCW+HliRpAzvc3fbs6zVxbR0Bd2K7Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZ5PcwIICQmfC8cc+v2STb7hABSTza7t6NJu14JIFPhYLO7R20HGxF2sCNra2m94h
	 s7Ur38CnOwEcMrAK8dgB8v53YG47pZFcT7jWV1AFu2ZPYMHG89P4Jv8oWE2WftKY1Y
	 9m+aT+9M8eDJ9KjCawdiHcn6r6m212KAJAMYd4ja0KUPCAJ86jRfoH6+sblaOS/vUS
	 4yMVTWdrRLndPD2UzgFQtTp8wLRk7ksSO0eRNlUBDQgQv8A5Bx6QGTtkqPtJA5GDRq
	 eD06/8U8JD83Re0Vh//SoU9cm00J0ViwCASY3SM6ZPw+7sUKFFnekTuG26UgIcx0Nh
	 i3mDQAXRAwvlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A15D80BD3;
	Mon, 26 Oct 2026 23:46:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E345356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FE3C40205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VS6x2xTP4iCR for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F0F940062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058408;
 b=jWJnU0JhLNM0TQHhiaRx6GlogCy6V+4KGYiBj1CD9dDW9z+pFJ/UCO/u3RiKFzJjsyrK
 p3ao9qXI0qNoNp5JzDQk9gzn7k+62axgcD33ofWclyMa/cBElzDROJi3Pm6rgBxFdKZDm
 IpKIFHjA0Bz3AZog6q5W4/BhSeW6cTIolcXPAlH21dIJukKY8Lw6II3/nWWpymV1RxJlP
 gS0xwHpO70Ds0ngRff5BJcAFuTQChk/tXoJYC/OHJy9HV51fFvfFaIUrs3sFfIWKW2S4r
 NG5rl9fYG7vRYf2E32PMykrgJCVf6qr/zuQi9vRXHrMgRqH3iEuQalkHbT3dyhRfNCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=wKtbIninv2cJiCW+HliRpAzvc3fbs6zVxbR0Bd2K7Aw=;
 b=e2dclNldH65simot8/RJs2BykuLYV7T9EjyS0knWczb8ZoWK4DJ0K9yeVwZWErg8s0a5
 xJAtvuGZe8tvSwBceNxmx9OkAWXEeXfqyqmuoIh1yYPHFDipn6MEVuRgrcKWXn2T+v6XX
 C70/Nuy8DwlIpYhRjbV7waub2FqGLivHmSnAWqBp40I7R3JT90Kz4q9Ow67b7vHRPqyh8
 9v3i702IS34lgJEs9Fdfrc9bxUIQJ76UzORDVVVcdX2LjudwT/ddbEX/w1tc+aDw+VSIX
 C9enS8fRwTBAep8A3NGDm+ugYSdfVCrtGv2mwoxyyytRr+iZzrCBlno0ASW52Mwxh1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KJhCloEt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KJhCloEt
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F0F940062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-823e4047037so2833966a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058407; x=1793663207;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKtbIninv2cJiCW+HliRpAzvc3fbs6zVxbR0Bd2K7Aw=;
 b=KJhCloEtvq4BoXB96lyGmWdhLajxw3UrEkHttu0srksXPhRyfkoEwK0IMlMpVXcDEy
 cJjWHamiHWQNdzc3A+zud7tjK+qbuXbQokAu16VfDJWWnow4Um1k9MTZcwRqNwa15Bdz
 NQsBliE8eCFBskSvJGrIqp8kThE3U0CT7jndoIjuXn7Eg0xikUsPb8FnSb3pzq2j0pXd
 4jFfwtiSYOht53OIo5JVgNuMZbeTNN8MeWljBYg/jcWNtoF+XthSl/f14feN02xCJPJG
 JetK2i30brNN3lQSrv2KhNWFWC86SW13hag3W6TNrtT1IM2lUPlKNiFPYkXNItdwHaiq
 7uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058407; x=1793663207;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wKtbIninv2cJiCW+HliRpAzvc3fbs6zVxbR0Bd2K7Aw=;
 b=xFyQPH8aKtQMDau0JD/nendiwQiU9BEMdkioYEiYJvCr67GBxerK+r8B97bjxhU8GX
 eWr7ogwNnIL52x1mkffsiCMnIfNIo4uPQuUa5o4iZSzDbJGEvlliIddkjfagHBnADWdW
 Cqf90n8hAZx+bI/RUBTp5kW4S1LV2sB7MMK9D9D0Xf7wTRY1sAVb5JhZEME6HeDrF0QQ
 5t5UUlPN3jqGCNSKBTb7JYN8AvjeY/H8kEWxL+Y9O1Fc8h969DZX07ZK+h9x3OTsskWS
 MfhCuCPiwY1fxDjlnb2QXyJMfJ5aAUe5O4CRN4yCznmNnZXW7gQPOoVAiZ1EstZRZfqR
 mB0g==
X-Gm-Message-State: AFq9FYKrbjXdCy9WqlOkhJojGj8TUZ65lhSwNL5WACts8CA0LMM2tYQz
 C/XGVqZiRYUhZkfdnOgpNEtaBu0ipb51/GzGZ9nBpQb/AmpL0NAT1q82
X-Gm-Gg: AYBFou2Dv1lbgZ/HWCMyPwhsfFxpQW5DlTIxHfKAEAVX1xEmlidfydzbybhmhCiyJL9
 JR3IhzMTax0h7YnhYeSFa5F8s8L61hk/JlmfzeySEfXysR7cAGtDB7TY76TPhhGf1lPmQJUfOP2
 +rw+IWmzhrk1KiC9tMNQCFbyUVe+JkPcw6mHndLZLBUd3wNsAQRqF6mnNaXz4LdOpAgd7+GJd6P
 NS1/hymNLF0avAUzhrv1W1dcPWmkK95KH/YIidIGfLiQj614S7M0+Syvts8J6pgwVMynugp7deI
 dYD+LyOxYiuOsrO7ZiJu4omtvpjaXqXdkn88VnRibrUugpduquaLxKg+VK0Zmy+/Yr2dVC9cGDb
 HLNzFbp5EG8pzxpnOUF1DbfI7LGz9uBxgb5WPB5FzH+TxklpkMzxGibs+aYXJupe5yfuwpOMiab
 /UbyQqdCd9iH5YWGjJFrSwsz+t27Dq3qsmremRd5VfzgR/+5R1/MlXaxk/oZd+AsizKmqdo0Cnl
 uym7LBGWN3PfX/5D4CtpVhlKihbLTXJExfAWwkPLeEJXYqdX6tsNmYySORLzCBBSTnT43HjH/sb
 TPbTZk5ns4XBoOjc2256Ya0f+VbURUUL4xAQWuMNPItA/E3oYNmnMW9vg4elybIJAK8MWScyL5r
 UbPPTi/1gV+OhO/FcTxF+EJweTqjysktEXjZ0GKGWwuYM5HuAbxpZG0gWGUTYxKUwq4wh3fOXQe
 JM1yc=
X-Received: by 2002:a05:6830:2b22:b0:81b:ac9a:5681 with SMTP id
 46e09a7af769-850ff682860mr7330853a34.29.1793058406745; 
 Mon, 26 Oct 2026 16:46:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:38 -0600
Subject: [PATCH 6/9] nvmem: add node-based cell lookup helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-6-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some firmware-described consumers do not have a corresponding
driver-model device. They still need to resolve named NVMEM cells from
their own device-tree node.

Factor the existing index and name lookups through node-based
helpers, while retaining the device-based interfaces as wrappers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/misc/nvmem.c | 36 ++++++++++++++++++++++++------------
 include/nvmem.h      | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
index 33e80858565..736b59bffec 100644
--- a/drivers/misc/nvmem.c
+++ b/drivers/misc/nvmem.c
@@ -95,8 +95,8 @@ static int nvmem_get_device(ofnode node, struct nvmem_cell *cell)
 	return -ENODEV;
 }
 
-int nvmem_cell_get_by_index(struct udevice *dev, int index,
-			    struct nvmem_cell *cell)
+int nvmem_cell_get_by_index_nodev(ofnode node, int index,
+				  struct nvmem_cell *cell)
 {
 	fdt_addr_t offset;
 	fdt_size_t size = FDT_SIZE_T_NONE;
@@ -104,10 +104,8 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 	struct ofnode_phandle_args args;
 	ofnode par;
 
-	dev_dbg(dev, "%s: index=%d\n", __func__, index);
-
-	ret = dev_read_phandle_with_args(dev, "nvmem-cells", NULL, 0, index,
-					 &args);
+	ret = ofnode_parse_phandle_with_args(node, "nvmem-cells", NULL, 0,
+					     index, &args);
 	if (ret)
 		return ret;
 
@@ -131,16 +129,30 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 	return 0;
 }
 
-int nvmem_cell_get_by_name(struct udevice *dev, const char *name,
-			   struct nvmem_cell *cell)
+int nvmem_cell_get_by_index(struct udevice *dev, int index,
+			    struct nvmem_cell *cell)
 {
-	int index;
+	dev_dbg(dev, "%s: index=%d\n", __func__, index);
 
-	dev_dbg(dev, "%s, name=%s\n", __func__, name);
+	return nvmem_cell_get_by_index_nodev(dev_ofnode(dev), index, cell);
+}
+
+int nvmem_cell_get_by_name_nodev(ofnode node, const char *name,
+				 struct nvmem_cell *cell)
+{
+	int index;
 
-	index = dev_read_stringlist_search(dev, "nvmem-cell-names", name);
+	index = ofnode_stringlist_search(node, "nvmem-cell-names", name);
 	if (index < 0)
 		return index;
 
-	return nvmem_cell_get_by_index(dev, index, cell);
+	return nvmem_cell_get_by_index_nodev(node, index, cell);
+}
+
+int nvmem_cell_get_by_name(struct udevice *dev, const char *name,
+			   struct nvmem_cell *cell)
+{
+	dev_dbg(dev, "%s, name=%s\n", __func__, name);
+
+	return nvmem_cell_get_by_name_nodev(dev_ofnode(dev), name, cell);
 }
diff --git a/include/nvmem.h b/include/nvmem.h
index e6a8a98828b..94205fc2763 100644
--- a/include/nvmem.h
+++ b/include/nvmem.h
@@ -6,6 +6,7 @@
 #ifndef NVMEM_H
 #define NVMEM_H
 
+#include <dm/ofnode.h>
 #include <linux/errno.h>
 
 /**
@@ -85,6 +86,20 @@ int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, size_t size);
 int nvmem_cell_get_by_index(struct udevice *dev, int index,
 			    struct nvmem_cell *cell);
 
+/**
+ * nvmem_cell_get_by_index_nodev() - Get an NVMEM cell from an ofnode
+ * @node: Device-tree node that uses the NVMEM cell
+ * @index: Index of the cell in nvmem-cells
+ * @cell: Cell to initialize
+ *
+ * This is the node-based form of nvmem_cell_get_by_index(), for consumers
+ * which do not have a corresponding driver-model device.
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int nvmem_cell_get_by_index_nodev(ofnode node, int index,
+				  struct nvmem_cell *cell);
+
 /**
  * nvmem_cell_get_by_name() - Get an nvmem cell from a given device and name
  * @dev: The device that uses the nvmem cell
@@ -106,6 +121,20 @@ int nvmem_cell_get_by_index(struct udevice *dev, int index,
 int nvmem_cell_get_by_name(struct udevice *dev, const char *name,
 			   struct nvmem_cell *cell);
 
+/**
+ * nvmem_cell_get_by_name_nodev() - Get a named NVMEM cell from an ofnode
+ * @node: Device-tree node that uses the NVMEM cell
+ * @name: Name in the nvmem-cell-names property
+ * @cell: Cell to initialize
+ *
+ * This is the node-based form of nvmem_cell_get_by_name(), for consumers
+ * which do not have a corresponding driver-model device.
+ *
+ * Return: 0 on success or a negative error code on failure
+ */
+int nvmem_cell_get_by_name_nodev(ofnode node, const char *name,
+				 struct nvmem_cell *cell);
+
 #else /* CONFIG_NVMEM */
 
 static inline int nvmem_cell_read(struct nvmem_cell *cell, void *buf, int size)
@@ -125,12 +154,24 @@ static inline int nvmem_cell_get_by_index(struct udevice *dev, int index,
 	return -ENOSYS;
 }
 
+static inline int nvmem_cell_get_by_index_nodev(ofnode node, int index,
+						struct nvmem_cell *cell)
+{
+	return -ENOSYS;
+}
+
 static inline int nvmem_cell_get_by_name(struct udevice *dev, const char *name,
 					 struct nvmem_cell *cell)
 {
 	return -ENOSYS;
 }
 
+static inline int nvmem_cell_get_by_name_nodev(ofnode node, const char *name,
+					       struct nvmem_cell *cell)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #endif /* NVMEM_H */

-- 
2.53.0

