Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B4CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E9DB40535;
	Wed,  7 Oct 2026 16:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oka-01zeHw0d; Wed,  7 Oct 2026 16:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 541DC4053D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389247;
	b=UtYBpikPLAh1zcYI8njBBYkJ9Y2rawjtzTMO7Nz6JbSM9sH2oxiLUhqRyLCXc4KSE+/T
	 y1xcAGj9mDFdFEMsFs1Z0ccyexx8LLMlQLXRCOBvdiImo8tz468cDI24FFYkJ8HGELK6F
	 ytMGsN0kSr2BnMZkvWUHLy5L+7SkwCJ15jcLtpJ2oH2k0mFs6zG4XN6u77tQS6lrj9LWQ
	 3JZCaviLIi9v4SsckU3K0Rpw8WCm2UJEnDrHKFIOFzLERDelX5V9OODZoPRfTESvbpuAl
	 cz6pv6hO8Xz2l8l94x12j7STBG4OLGzXOwe8nDPzLJHcslnk0RyohWxmNuNrWnHu0pQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fMlqWF4UZQeF5ub8gmgVp9IFFVtlH8b3NQ63F7EakGw=;
	b=jClMHbkQ/hmI633tH7FOqUjf6+9vHDDXCaJfFvNblK4SZDK48SW0jKI23Dzw/Msu58cS
	 yFE78V0SGPJ9EGJV5R6NlGr3YgMB9mCqgJ8Q/qffvm0gY1TqonGFexO7vwsfOIynv81tl
	 NGsuT/wkwkh5bOdS7oK3zd9yTImfSH26BbezeON11avgzQznzmAM02XkauMdT3u/Ho+fU
	 RX9qRZtmvmtgv2SVVSjW8+R1HoTDg92wcSth3Uv8b07luIaeUcBhlIKatqO/YQlUfxDFL
	 m3qVdDkW6D+6mV8kAgQZbnzdgNGy3MUUjiP1RHPCW92nNfMef2H4x35pQ1sdH0IUxrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389247;
	bh=fMlqWF4UZQeF5ub8gmgVp9IFFVtlH8b3NQ63F7EakGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axrDv8deyvYcXHaBoSzGhnX5OPCjiXe/sw/2ujkcS2vehXLYm6mi6AZzVh/p2iV1C
	 a4Fal4amWiXr3u3isDfUeN6/0HwQSdZdAGoJo1mfv4lgOYv5v5gsp4bNGtq4tnu5hO
	 N6GiTySr8CFMIrOgspi+tBmlrPtMiR3e1lWd2g0f3IerglkoUcoqTxBeRZ6HLgZ2n3
	 27yyPehk3pgY0nhPVJJ2RSDNUMIjDBgW3SYy9+qJ1hfgMeVIOcJb9bGLtK/Svd/mJc
	 w5dHWLB1PsRHe9gjyWCCKtivk/1uomdxgjCZxa1fLuUQq26f0mdpST7uqMtxqQHCmp
	 Ayhpg19bkcmJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 541DC4053D;
	Wed,  7 Oct 2026 16:07:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FD3432F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11DA4606A6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFIhK3-dE781 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1519C60670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384356;
 b=VqQAFf0s496CKGjv8PhqhIdL39OBnbuMFD8v+l8xXhAOkua92kpPJg2t2ykAQuzppjbR
 wAiSw1akF1RyRaNDkuMXUnQYaSTKWVxUvR1q3fmjUSl7v7tPUE0Wb1A2SUDtqb1IYbR1b
 U1n5JvLqpB/Bip5hTtOCBAgWlIwQpofbuX+pK8GWP0bflf4LfdGSZHFaI4CyO4cNV0GlY
 ShrOPk2Jcj4brZOGREi1PvJQbYxEL0n89joi7edvRjvqP9BPYKwR3onSbM75od6J+M5vo
 Rk7RSEIzZiX7CQ9Q4Xd2jcRJU0X5Jt6ZGJNxEmxYiMFDlEC9nxe1LzGne870eA6zLmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fMlqWF4UZQeF5ub8gmgVp9IFFVtlH8b3NQ63F7EakGw=;
 b=Tf7W5At0FT+janzB4+UeEOC3vI5QJAKBYRjJVhUtRe2RcT4cikgterwsh7I8/LPoPRVg
 E2Xw5OY1IIncO+CVTUgUcZekeF3NtrcdAt2gFkiY2f6QKhdOcznPbJReTGa311G8cj3L+
 f9z0CQOEUlBc8NeokIAlc3aGA6O6VNuQ6ELXpQ53l/zYp4NuLWcnUbP5BC1laZBy4Q+sn
 gY6GIQzcmiM9Z6zY518TsM3w1E4LGm84Jipkhu4rleYjKc8Z4tbPaHmKWK3+XGrwRZEki
 8SVeWb/DcLGbPgHyI4iUn+WderE+qvIiwwEU5x5GX+R9GAgftTUMQlmanXnnMZtPI+w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ogRNFFjM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ogRNFFjM
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1519C60670
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:55 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so17545015e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384354; x=1791989154;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMlqWF4UZQeF5ub8gmgVp9IFFVtlH8b3NQ63F7EakGw=;
 b=ogRNFFjMBa/cyfN8XOEpIUV0X8VMDt6YqSaD5+pznIGo8hK9l0vWemHHz+iAZbVeIU
 bQDl39DDoXf6h4Eemk8/ebg2ijxeOCN07CdtxcZY64C0dWIte2hgIzbROP/n0VAz8TTH
 I9J+tgv8gzUOvrUiiQ5o1UMbrqMvWDT+BvkS/jcHQo+Gif008RpmWUW9HV7Taq9qw5KF
 OCQI5Ft4V56UxfjLV29l1FfSSczw2m0K9n8Uu2Mn/ekJ/lzs0cOQI78ALnKMsdPK/XFN
 OAzb3M82kAx3vgJpYrW+C/VT0j19Po/CIwrU2AelReQTmsZO7T6WRb3+I68CUukpwk+e
 qCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384354; x=1791989154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMlqWF4UZQeF5ub8gmgVp9IFFVtlH8b3NQ63F7EakGw=;
 b=gJKt8jVAKWqfea0wETRD9J8zSfaylWklKDtZTzJKPYLh8ceMoO/euJA2CXfQo6ozp6
 bhi9f+fBs1N9iJMKEBOQLbWHwpNG33XN/lcgFQ6hLwCX5sXpLA0eCLiF+fQKo23W6OUB
 uGhPFpjvQNKNoedKA2BgKC2SPLbGrg0ZD1e0fotATv0EKqSlq/6hE3EwVX20E1EEozsU
 kZavInY64DHxkAOWIcUMQwY6NwtMgGhyKi9WYWz589xfu5jZL0er/1PVGHG7B5MiytWd
 xojEBLI6nsTvUR1gLLhUobXEmMb43MYbmr2G8K9rri29ymUUp8aA+Cd70N0shiNVeerk
 /MQw==
X-Forwarded-Encrypted: i=1;
 AKwUvByrfA5yC7nuwHt3JOv/vLd0CPYwAiw0DKKwXEVFiCLg4sLiHIgn04w95bn2epkgPGUNgDEsk80=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mTkrWS8E/7CHcIDYC99VCnPjCjSbdOWBlyobEhkX6GvsJ4fMQT
 K8+CW1ZkbSgsMI8u6LB/MOSwG3OrvFa+oWP2L6ctCNGb1funlBKHM8g1
X-Gm-Gg: AYBFou16WHuS0B/AF8QK1Xy0/p37t+22t689xRNlRJxhg4cnihribdRMMOFKGZKA1mD
 oInCjvuO2a0SVQ2tnzEn6fVpn/16y+z+de9NZI0DXBilliFogtzUwF8iEVClmRFkxrj1RMBuCjH
 WsY9Uw8vr4vWuI290Pp3TRf4c0pRnYYvuxjpzj4q9ULu49AH9v2kqKirBAhVJoYceoyeglJyni8
 BT9uWwuQtXle+h1hyiZScl0zezYH7DteawvUMxMntT56zMFMcZOjveR6o8nTDwShcPeALtdtLL8
 48t3BiESeoo1Dy5g7fOXKrdp5hnaFMMs1Lh9GYBQKYLJ21VQmog/5eZtDWgmc7Gtzbh7gAIjvVN
 1RbnMVFZtwb8+BFHyfqGH+3xbZdBwSp98qtKVFLgJ1EJ1y4ARnXRS14i5NtN0OOjedMXwySbwUT
 H31/NTOvVeQufRC+9ooXOPu9Xa/517ifDGtLsOZXJeJ2VQlQD0VSlCP8wwmsXRJDecTxrAikoln
 2BS
X-Received: by 2002:a05:600c:19d0:b0:4a0:1f51:ba2d with SMTP id
 5b1f17b1804b1-4a18045373dmr38464535e9.22.1791384353761; 
 Wed, 07 Oct 2026 07:45:53 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:53 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 6/6] usb: ehci-vf: enable the vbus supply of the port
Date: Wed,  7 Oct 2026 16:45:44 +0200
Message-ID: <1f8f348163a7da49e1ac9a6278ca533ce8a2847d.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
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

The driver never enables the vbus-supply of its port, so on boards that
switch VBUS through a regulator, such as the Colibri VF50 and VF61
carriers, the port stays unpowered and no device is found.

Do what ehci-mx6 does: look the regulator up in probe, enable it in
host mode, disable it in device mode, and turn it off on remove. A
missing vbus-supply or a build without DM_REGULATOR is fine; any other
lookup error fails the probe instead of leaving the port dead.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Changes in v4:
- enable VBUS in the reset hook only, as ehci-mx6 does: enabling it in
  the shared init as well counted two enables per probe, so "usb stop"
  never switched it off
- the dm core patch it needed is dropped, next claims the regulator
  GPIO at probe time
- reworded the commit message

 drivers/usb/host/ehci-vf.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index b1cfad14b09..7b8aeaecf38 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
+#include <power/regulator.h>
 #include <linux/libfdt.h>
 
 #include "ehci.h"
@@ -53,6 +54,7 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *vbus_supply;
 	int portnr;
 };
 
@@ -254,6 +256,13 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	if (ret)
 		return ret;
 
+	ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+					      type != USB_INIT_DEVICE);
+	if (ret && ret != -ENOSYS) {
+		printf("Error enabling VBUS supply (ret=%i)\n", ret);
+		return ret;
+	}
+
 	if (type == USB_INIT_DEVICE)
 		return 0;
 
@@ -279,6 +288,15 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	ret = device_get_supply_regulator(dev, "vbus-supply",
+					  &priv->vbus_supply);
+	if (ret == -ENOENT || ret == -ENOSYS) {
+		debug("%s: no vbus supply\n", dev->name);
+	} else if (ret) {
+		printf("Error getting VBUS supply (ret=%i)\n", ret);
+		return ret;
+	}
+
 	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
@@ -306,12 +324,21 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	regulator_set_enable_if_allowed(priv->vbus_supply, false);
+
+	return ehci_deregister(dev);
+}
+
 U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
 	.probe = ehci_usb_probe,
-	.remove = ehci_deregister,
+	.remove = ehci_usb_remove,
 	.ops = &ehci_usb_ops,
 	.of_to_plat = vf_usb_of_to_plat,
 	.plat_auto	= sizeof(struct usb_plat),
-- 
2.55.0

