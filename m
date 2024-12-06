Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04AFE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BBF89783;
	Fri,  6 Dec 2024 03:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbkFRUIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211C089791; Fri,  6 Dec 2024 03:38:18 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E937389756
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841a9366b08so47558739f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452693; x=1734057493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlzJGU4+LZ7F0oEmRxjQ2/0xIF3Ehh/AF5D318jSqeg=;
 b=UbkFRUIM/DIjfuEu/lhpovmkz7V6Xj/ElaCANyf/387AfQNodGovhZrTfGO6WbuZAb
 Io7HTsAOcPS/kgE54W7qIsh5/O7Ywm9gqH+pjWHKaIVR5uNlvWB0EsFt0diHL60ywa8G
 F99ujmtjVjxh6x0+31waDDSFnk1NYypgF1kAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452693; x=1734057493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlzJGU4+LZ7F0oEmRxjQ2/0xIF3Ehh/AF5D318jSqeg=;
 b=ExyOXxlDsKdXwkITu5LZYYyNkZP9Jvl16NH3lweRVM1KCRjsP3YLh2LdA5skLreBJs
 B7TrnPPzUIa3r+5lS5U9pbnEoiIn0HxX1CdK+ig8/9e5Vv0YoMEJsly738EfZM0vNbuQ
 j7j9IOO4hatabBIMs383xK8YLZEPFy1LwnkoEPdePmXrup+FOa0Re1Zzb/y7DAB6Jyxy
 S7t/ooPARLG4tFZwWbxs1iS/HS1NJCEv03EK+nxDlozDOA+kwMJaFrJrPtqTuCiEddfy
 CdD+XGnz6eT+Mzga0mPLNajp/aj8tmA6+tPNuazlMm10wqNqE+uJ19mL/qE1+jdpkdnV
 7yMA==
X-Gm-Message-State: AOJu0YyTOCBD9ofnYHy8VpCgmHMfDsLil+xQ3VV7kNK7sPPDhZtNyzrd
 BgzmcDx4vudR5Xe13mvCDKBp9t+E24SsmVd3Glyk1lUKZ15eXhbvw1QyattcszsKvPxYxMgCZVo
 =
X-Gm-Gg: ASbGncuV+4FrrWA2BVZSJCHsQeNsO3/DVYvyvizB6gxmNpEmg/XgKcCsxlfFy0kiR4P
 5/5OPEAT0R3F9JLDvLkMjCSuA9XwSjHhMAH2X7KqZI42DrUDCDr29fbArfiqIGKZR65KfU5s0/J
 0bpuaMSb/xjnhJAdfBxHfwX3rKWJK7dmUMLZuowJwopAXizOwWxdCpT3qpFMsD0hUkzXmokrpe/
 gzAtLP2tzHAy37kp5ycxrmZb2bT8neVIeaU2Ph8A41oduVUWz2hlJ/K5vUW2vd3c/Qi9lpYSxHO
 DE8zzER/wqw=
X-Google-Smtp-Source: AGHT+IHRqxPOTzIJ7sX2F5ECUyFIOBNsPl/6abChURGtsTs2WCiAFoPZ1ORdNBwn51kOr7RaWVnAgA==
X-Received: by 2002:a05:6e02:160a:b0:3a3:b45b:fb92 with SMTP id
 e9e14a558f8ab-3a811e47e7bmr19858675ab.23.1733452693671; 
 Thu, 05 Dec 2024 18:38:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 38/46] bootmeth_pxe: Implement the fallback option
Date: Thu,  5 Dec 2024 19:36:17 -0700
Message-Id: <20241206023626.2456858-39-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Provide this feature in PXE, so that it matches extlinux. Use plat data
for this, just like extlinux.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index f2b9ffaae89..6b3cb3c4b91 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -139,16 +139,16 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
 	struct pxe_context *ctx = dev_get_priv(dev);
-	struct extlinux_info info;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
-	info.dev = dev;
-	info.bflow = bflow;
-	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &info, false,
-			    bflow->subdir, false, false, bflow);
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
+	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &plat->info, false,
+			    bflow->subdir, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
@@ -174,6 +174,7 @@ static struct bootmeth_ops extlinux_bootmeth_pxe_ops = {
 	.read_bootflow	= extlinux_pxe_read_bootflow,
 	.read_file	= extlinux_pxe_read_file,
 	.boot		= extlinux_pxe_boot,
+	.set_property	= extlinux_set_property,
 };
 
 static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
@@ -188,4 +189,5 @@ U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.ops		= &extlinux_bootmeth_pxe_ops,
 	.bind		= extlinux_bootmeth_pxe_bind,
 	.priv_auto	= sizeof(struct pxe_context),
+	.plat_auto	= sizeof(struct extlinux_plat)
 };
-- 
2.34.1

