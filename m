Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5BDCD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423FA83EF9;
	Thu,  4 Jun 2026 01:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnp+DV8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2073D80433; Thu,  4 Jun 2026 01:51:44 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4677A80433
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-beb19bce272so229866b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530702; x=1781135502; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zpsEQ6hVXm0/T/c9p2ODebamIXxnXUlyVKUiGIK7vMo=;
 b=jnp+DV8soYgle2GtsB5gwk5LDSnI4LwdvgvaYRDIEvgOzVXmII3t4I6pa97/M63HsO
 jqBy4qA+f8R4lohq7jXnU6ta7E+r5Xylq5s3TVLHTWCHV9b4CCE2G7ttDUxlfnAnFqZ/
 9fbqgR0R0jyr5L0BARSOF2kcReWeDHTP8IXiAvUK+QLflp0XBpMuYW69OqMca4OeWXod
 Ow5HeZYJT748l5iM3rUj9mu8H0ZNPtvJ9vr04P4Uwde7gv5U56UqDfenrG27HWZqTCvX
 u1v3iGpL9OvqnefXDrSYfP3mJ+uokFdom37wI9H4CbhI6DZ+JnLvtdMs6j52G1mNK3yw
 l68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530702; x=1781135502;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpsEQ6hVXm0/T/c9p2ODebamIXxnXUlyVKUiGIK7vMo=;
 b=WMgyp9nlAE3nJvtNaon99PH0JwyN5q9EwKwvXVa5Hgyq5PqBDXF6AWRC82ulWsVKGq
 /KBdYQu77BqPoj3fNOhY22bbzwQLSTHtmOh+12pwnyyWoOVOixlC/gYWmu3jLry9fJH0
 7J1YgLQko/pevKfRuqnXRKuxlxAzvQSyNv8GzyNwLzb6NsQrVOqRYb3/pJsi0eMXhDhA
 OeecMB7jTGoIyDmNE0O72nv/b5b83llNFDT2+XTGCIMK3nBrX4Ykf0L6BVU+j7OOwjVk
 fPeBEK+fW/E1bSdiqaorTLQil3vY4Dv0BQh5WOYKknjg10Q5Rk7s4UU30iDPt/aB76kD
 pC1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BzYVBWsgTU6Dmk3RCkwp4zTzmfzHtFzy3kJfXwJxqFbrsdU0BtVh3OJRV5gbcEg4NXvHW9KQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzWu6ycakXrC6iK0/TcJnKyfTWJ4bsc82pLlCQ8KpOow09AXbqe
 /Ik4PZS1s4qEB6dEiDnrHyCZhgAjBvdPsO/VJ8nni6ihwLfcVjZ0U++9
X-Gm-Gg: Acq92OH0gR+lnhianSlfLwAYP2YwDl7mB7RxF1nIMoWO2lyzBzj0gms2MNogCEp0sjJ
 tCM8diA6EB0CcWTwfO15RSJjFm1P568zfvgT61FiX2ufnG5/kn4VQKHsiNQTOEHMAKiqIb368Rf
 0TmwOhdk2GiLTw0zZNWeHMu+uWxwUTHp1mmCTVcCjyec0XhoRHCoCF9X1ckMN9xtB5A+EClzufa
 FTJzaFt2czMgtMWA6poEvpAgmHZQRv1Wz/V5a6Cjr9rjpwZXhWZVfC1KnSpPjDAvoQbeDA+ZPLA
 TWKDueoys767S7Y9kA0m7ead6DRWY631RkaRDnWiMV85UPLsBEPv7IukbJWW4fObUoBIfc7gHyJ
 NzG57XVHO9SQwIDOSN87q9ndPpQyesuKNOh9RE6xteopXH8FKRORDc6nisdk0a8y/S0xCN2bqU7
 Ge+dT/CJdGCOE4CrC9VfsbpNEbkc4a5nMFPq4N0VedXRpy7lYqnFfKFcmSXldiDMR8cG/Arh0o
X-Received: by 2002:a17:907:1ddc:b0:bed:4cc4:6be5 with SMTP id
 a640c23a62f3a-bf2259cbafbmr5252266b.4.1780530701685; 
 Wed, 03 Jun 2026 16:51:41 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05176fd14sm227306466b.11.2026.06.03.16.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:51:40 -0700 (PDT)
Message-ID: <5acaa5d9-d194-46e4-bac1-d1e9675cabd2@gmail.com>
Date: Thu, 4 Jun 2026 01:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 10/10] rockchip: configs: enable USB in SPL for mk808
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Enable USB in SPL support for mk808.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
remove SPL_DM_RESET
---
 configs/mk808_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b8c6f516591a..97246dacff3e 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -87,6 +87,7 @@ CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_USB2=y
+CONFIG_SPL_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -106,6 +107,8 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
+CONFIG_SPL_USB_DWC2=y
+CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
--
2.39.5

