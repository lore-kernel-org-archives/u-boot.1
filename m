Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0B606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yr/GRgZX;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Nhf+SpeO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14CCE607BE;
	Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yibulWPVBvYC; Wed,  4 Nov 2026 08:54:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0BF10606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782469;
	b=SbCOW2XllSbWJuK74Hm/kF7WCSL8+8Hi7T0U+fZjjmiNk3ecjdz3c63BoH0A1Ph4pN4U
	 3sNomiTcqh01/RC6MziwSyEjAH6uM0N4s+FdAVp68Tr/ILsdIOpWYJ+b8Vd8/GBYJZ90f
	 7TYqPZa4IVkVgOcI93v99Y3KqfsRsm7utyaJJlP83NtTPX/QTDNmLC/jmYXWndfFvx7o+
	 PE3G2ew/PaUygqyWbZxfvbrnxunfy8UdbtPEQHt4nE3Mzcgg5IGhr8vjSL6petiZMdaEu
	 N0s7FovpisysNQSLruvLYsBJ5brC+C+EtityoWTLNPIlgpXKwPseZ2YcntHR1B8rY2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q9RTj2yrOYo+p73QFq0uh4WbPFVxqLpmgEcCD7RD5Cs=;
	b=VaTMvpEDrTjZ4R6pXgZFjIB8IvmpLD2+oKm5s5k8V48SxuhqfgRHCRK0T/epu+QDttab
	 gUfrF9pNnQQx0oRoQlTb6g6G465HYb1Bti681wjKYzA5Z6yi1fkE/QtpI5Qs9wyfObdJm
	 dMf+ClblYR4sMmP5e/G4HpMGnAHnE1rPnrln32G8x3qlPq8OMllq6GPVdypZPcLZhYorF
	 Xaza3Rd7F1TGw/2tdUJFP7hvajUsYp0BIZ0lLiOaJK/h212a4Oi+ywlcSRP+1C08rC4Je
	 aZQIQgQpv5s+Ca7l1fGvvwL6tVUgA0Er5g28A/LGUzzWLyrOSXKKc64f7LM4DhEIn4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782469;
	bh=q9RTj2yrOYo+p73QFq0uh4WbPFVxqLpmgEcCD7RD5Cs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yr/GRgZXoyt+ZHGqzr6elfgHHUpzFTU8ztdVRdOXD/O0/Z+cDYVSqZJUZJ2gAeioe
	 FEBtQI3/Wb6YYk7upqSGieEUP/MIG/s9cibKjMlUwolsOcsj+koCIpCaU9X7/N2+Ui
	 WHfLG0R1HJhAE4CTdjvoYvKbWfMXi7tGlb51lqWT82P7P/dDNMB18RNf//zxlBW4lu
	 he3fqbq+Q281Kg9uixDj6A15xhHGaBOl/4QD0k0M2l8tNE6ASB5eQckegI3W7bVej7
	 0+lZGjV+G781g20fYCQC+1R3uTnfPw7ChETNuiOxCPg05Ae0JFrcKdHkSm8QAShauQ
	 NkUKmuebchT6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BF10606FA;
	Wed,  4 Nov 2026 08:54:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F18A2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C2D14004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hNmezeAmzZ2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D487D401FD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782466;
 b=U+jMuh7ObxjKmRTXRGTzkkmBUe48HbaZG6tvtimKU4lBQ0ocY9z/ddbcdSyaJJfpqKU8
 /OMl2I+nQ5udBuhFuyy1goLqWXUfkJW/vMgvQej+VoKJd1O2xgRBLMVsg6Lh+y3Izsnft
 O+ybKUPdLQ879o463F7ptVp86T5sJuJwDrzSrM8AndoQ+DdgsTOC4K+Jh+Ui7/VKBDmOI
 FdUDyjixSl4PpGZgHrO6mGyF91rr8fVYMvGX95nnUjsgZbAEFy9cXKxLN962CgMamTpzd
 LzULh+FLOETSJSWA/UJUiuN9lshBqkoHktXqvoULu24z9ZjHZGwduu6SEbSFq1O14bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782466;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=q9RTj2yrOYo+p73QFq0uh4WbPFVxqLpmgEcCD7RD5Cs=;
 b=Ua8MubhHY4RdykAjg/uXdzhvrzo1y477Nep85OLq3ZVgA48Bv0RpPK8fJbh3GVdUDu54
 HbKyd9QEiTPOJNFw6HRyEbfJhDm+tEbi+KkoGXpVJcAOidK3IMYfLkX/JUII4tLmVPr1h
 e7JJRixPIPoRMxuu0vtXiiCv2PvjKGM5AhBhyz8JBl2cZjIFLzEgnm2G7g0l1DGSwi/A7
 XAGri84Mu7VuoG6K09MEuDaEV1oFBPwThAQ235PW+VhDhovbG7rFUu3gLdkWhO5oorGH4
 25SK8v2A8jL7QnOn+sNSodH0vQA6PTumFSlhLuxdRN39YauI1GNPq1nYMsrLEJIo5ug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Nhf+SpeO; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Nhf+SpeO
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D487D401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:25 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so3448665e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782463; x=1794387263;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q9RTj2yrOYo+p73QFq0uh4WbPFVxqLpmgEcCD7RD5Cs=;
 b=Nhf+SpeOx+aueSQZxFHaXRuxevBaYtN9TW/2KGuJb90yGS+tHOevZJbOdqES1rHj9v
 msx1I0FsY3q4bbFOxkEt2ki+O4a5NLjOm52Cv6VoYzfJJOF/KxQ7b5vKlnsgDAyXOVoa
 MFuNeyGSLqKvD1c4uFmh7Lzg3hzq6/jWHn46EufpeDnIffaDODdP0Ilb9j1foRi3EsZG
 H0jrXinf5L8ETRrgPqLA24pWOH28hC5a9wgKoo6RAApHIJIxDCY/PT7tLzI/Vs/qxy2q
 N7qs7LIQA6iaHC6jtZ2IyfSa6Tp/dpNBzCQ//xaS4g8DrNpnZivVjhJOBCWtsYgh6Gis
 bEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782463; x=1794387263;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q9RTj2yrOYo+p73QFq0uh4WbPFVxqLpmgEcCD7RD5Cs=;
 b=Y9aqvufyUMAnBajM5DCS4zAU6XCgmLU5AB3TGD3BR34blITV38figVc+B5v/V9iM1+
 HLQ1Y164Yq4ryYKXNpvJR7parchXYO6qw1mCjSNJAT7zOtH8kXIt/jwdmvprgI2wOWRL
 NMRrOU76wB7pAmQj9ctsxHWadKZ2CPVDrtIXESYdb0hS5oADmJGH4IUumzJhYqmmkp5o
 xCVM+nJjD5zfCnG1GX+8s7g6tBKh/BAzipFJJL6orruT6IrfBxlij0Bc4iT6i1Girk2i
 PFWj9R34IbsEzVGNdSjrcA2AaDeuRyXFnaYFXkmlYR//Nkj/cRdi2XO0VkhEp7W2nHua
 RO3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKi8c8y52NScRYb8nsLDZHndlFjRd6EwTqxFKe5b+2c+dm5bfauVwjoKkMNomWB4XBk8nbLqg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9f8QvtX2u92hTEqCL3DaRXQKmI5b4jbv7eaHf5N6GLW9k6BjAF
 G7DFBng4zg0htWYnG0XU+nP6qPDabbZ5DceRMULS1yGuJqay1oNq0P4HZo0QT7IhNLg=
X-Gm-Gg: AYBFou2IDHAph8YJnTCZ5ykl2wXCj3y2ka7Mdi2+kgE7i8RU0DR9qLaNL8rMB0cJc5X
 mJUQGyalNL7x/7vBcDUWGBpBCZaDCCV/zWaTlku1SQlKoU5zPm62/PsqzUtr/qRacQWZ7t1VHj7
 9/lImK8rT2ZBN9VIpDWNkRZWq2LAnWm0iA4px7GwKxQ+zeh/pR9PqLAiLoCZ3BV4kXaxu6avOIu
 Ys3z2fHHrk2JcU5MTeEKYHKFkb2XwumzTfVA/XtgI+tU0ePnmVGwqBsBwSvN3SQlzJ4bxOY+52Q
 UGkBABfFXNtYReyMhx85JSax96TSIFY/+ibjzQUbusN5v08pSDXNCipHm6zyezxqDvEz9dXrqCx
 paLOaGfC+a/wsEsboLN67G26p85aZK4FEi/fQWg3LWEo2mHE5Qwt0OsHNsAQfnkAJsWMr0icIYU
 OgsmZtCtG3vIc5ZyK1aSmOOyRXE3v51iR++RbI8+aTb7gk/xHJWxDkXKHHry4bgKX025ONrpjCY
 +1iafXxiCwqCE4oB1ZJx2PQGmKWzClzXjEXktcCzNc49vvbOU6Vn5Ll/s9uFY/O27OhGMzt74mj
 mnbX2j8mdKcn+OvPjQ4mA4eUMoJ+jWwQM8gI+/+6e7fMFJQ3hU0xUEfYnZzBE0x8SRIgYa6PVN5
 4xhaJTUzx8mL2C78lxhLcP1jw+JiX0B3JcchJXa6nNBkUiw==
X-Received: by 2002:a05:600c:468c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ac17d168bcmr359713885e9.9.1793782463276; 
 Wed, 04 Nov 2026 00:54:23 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm20656245e9.0.2026.11.04.00.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:54:22 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/4] Enable USB host support on the Genio 510 and 700 EVKs
Date: Wed, 04 Nov 2026 09:50:28 +0100
Message-Id: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0K6dsxQFNSV9zAs2jLAqAXSFiIh3
 N2CF3D5kpf3/yI8OSYvbskiHE3sue8iyEMiTKu6hoCryEKizFOUVzBGRYVgHHxwpCzY8IKmQIT
 RaygymRdYIxp1ErExOKr5s/cf5Y/9qJ9kwhbdjJZ96N28H5jSzft3a0oBIddYVUqeNWWXu1bzm
 7Wjo+mtKNd1/QJ1llGI3wAAAA==
X-Change-ID: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the USB-C PD host port on the MediaTek Genio 510 and 700 EVKs
using the existing MTU3, xHCI and T-PHY drivers. Both boards share the
same USB controller, PHY, onboard hub and connector wiring.

Two supporting changes are needed before enabling the boards: the PMIC
wrapper must recognize fallback compatible strings, and the onboard-hub
driver must initialize the TI TUSB8020B hub's power and reset controls.
The remaining patches provide fixed-host settings in the shared U-Boot
device tree and enable the required drivers in the MT8188 configuration
fragment used by both boards.

This enables the USB-C PD port only. The USB0 download connector and the
USB2 M.2/header controller remain disabled in this host-only setup.
Dynamic Type-C role switching and PD negotiation are not implemented.

---
Changes in v2:
- Remove the redundant PMIC compatible-property lookup and pmic_name.
- Update the MT6366 comment to retain only the regulator-support caveat.
- Drop CONFIG_USB_MTU3_HOST, which is already selected by default.
- Link to v1: https://patch.msgid.link/20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com

---
Carlo Caione (4):
      power: pmic: mtk-pwrap: honor fallback compatible strings
      usb: onboard-hub: add TI TUSB8020B power and reset support
      arm: dts: mediatek: configure Genio 510 and 700 USB-C hosts
      configs: mt8188: enable USB host support

 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
 common/usb_onboard_hub.c                     | 12 ++++++++++++
 configs/mt8188.config                        | 14 ++++++++++++++
 drivers/power/pmic/mtk-pwrap.c               | 14 +++-----------
 4 files changed, 46 insertions(+), 11 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

