Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0C606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tOCcU7Eg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bHQiT3AF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07BA260867;
	Wed,  4 Nov 2026 08:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YRKUy57Lbx2i; Wed,  4 Nov 2026 08:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 439EC6077E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782474;
	b=LMmmvzrgseyiprWiOQLdpWrIxcMA7F6phWQcNW5bfQEuW/f5Nb+xTYrEzs0Oq3Xyyl0p
	 DnplHSVfp/Lcjvll85YY1AbiO8vAQ7kfGd+wXDWyEUGWsCLlAXKPb9gWdgXCbyiBWXdkJ
	 ZxicezsD/fqnruvJOLhMZUVrA2CLbeeO7ebZ3EHU2f+L5V9Zdo7uJdM4zf46WhdyZtdDB
	 2m2ohrqput2hfcUVc+JfaIgAIT6YQwZ9U5+VZykhgWeB0ExPj4VHOEcS6S95IIbyG4iSE
	 48xo1CFdklE3Qvkhvj+1wLVIXBnzDk9tyC1x2incoRpulrLnVqYw3AVWLSKXp4r3slg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
	b=EVjyFoqsxok3SGR+2+mS89NpmM1lX5XpqXVu+wSiPsc6dR3dJAvp7/Wbcsk+c8FY3bGb
	 GNvQI/eZ1RZwCTmuAF2LJC2Qf8M7BC2ucS8jg/cQ56vDp9qVAZYYpVgzKfl94LNcSOiZ5
	 YPS2bQU7w8l+p1VS4F4mfgQ1EIhchfaJ/rL1UvGXnYro5JEdCgiM/Wpz49LAzBR31vO+W
	 s/LXGOfZ/GaOLEgWkztbaLHcwv4y1A5boQswF4pH8ChEjlEjKmtTu03iUEKURGk0yiK1t
	 a2zj0Cs52WxXjr7Bqz5k94zKaoKPbX4BMM6f1CDhtQLbaHyuUlSUj57QLKLuActpItg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782474;
	bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tOCcU7Egln/4RbEOD1PWVN3eT1biN1413qJhWqJLR/CenixrSQI9eiwvnWqd7+YtN
	 ycvL76s1jo+1gZvlpk1hv4WCqeuBwmYrB6wxO0J7Ze9mIruyciK0DE+aceKZW3bTrX
	 R9TlPYYXtzhrO/tVShXT8qldYROuywT3drttbCLWCsu6zTTVXWZBKsq873jvdtxTTX
	 encXuYhBiK8nNOE/8lpVwRQ/487A89c4pCIhLY3PeiaM9/WtagtdFNvdUHsnQ2quKd
	 LUR3RQ9LmtyjFp0n7P07R+IFAAhuWAHCOC7bxfhJNgtlEX7y4bgsu6ApWCLcCbxYX8
	 2pQLT6X+fJLMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 439EC6077E;
	Wed,  4 Nov 2026 08:54:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2636A235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1856B402B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aghgY7A5_16 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E440C4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782471;
 b=j66YKCbQFp0yMMRbic+AjenQN16emLSaNB/PyYnfXe320XXQSWxo476UsHjikkUfddnJ
 Aqz09dFqYqZcOXHyykOKHsbjbQeceazB2/hk73c5rUVqN4ps19jAsDBl8LV+5XwR6y0jM
 1f3Wycf5l27eP9GBJq+IuAtG1aLtt7KcYPPNS3VrmmUR7sw88N9/Svcau0aas9uzmRkIe
 f+vpMaeWJaWWpjXms/K810K1cddiBHLh4iEe2SS/KtHCT4T6TcWBZQaDqoVcpNmn91/Nz
 mwv0RADeRu4biRN8PzAuhCZVezYefhUQvSngxZSQrgh8xEmFDNaj4a+pnhG/x5rOi8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=O8WuZrWX7bw2kBvC7r/0wwUnEnEmqfnqXq+v7W5+q/vLUClFEH/OAzwXuTEvlfcezfQ1
 8jwMXUyPms3b/i9liJHBH9bN37xswZIaEiJlK04hqPEtyn75APMz7JZIMcxEhZaCblCkL
 XkoJiN/1Y7WIKaSryvQbaUPMCfoLQqJmPDQFodGlkGJRiGqja9p/svi8EtYc6hckvWeAi
 zwu1WBqV/Ji71VUN4eIzwF+wGQeAOkCLbp07xGn4y+oE36uEufUDaqpzS2cBN6gBpmCJx
 qo+ZsCIRNSIExAc3mDk4u3bvV8rmPLZg43vNwcL5hYDakSMl4NBCnzmniZCoN1nHDSw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bHQiT3AF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bHQiT3AF
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E440C4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:30 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so242436f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782468; x=1794387268;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=bHQiT3AFxDZYypPZ4azj7pom3ZhmKjnTtCobIgwWZeVfRkblM/TLarRJhKaeyh6FeF
 /5HbSXlbzXqDvNcrxKnlZyM37zC/xVe0FJrwbpcR8FsCh487CQE4ewoJXdi0iqYFo+Kt
 XRcdTGWzg5j3XaE88fkWBq1M0KFH1ebunnFxgxfBPGJ29BR6rJHkQbjafDTfiGYALTlm
 RTDUFYwg22/AG8m/SVaSCXDfi815KOOOeyu4hMemyLDJzhtKtBZQTo5iKQx9JBjLAPZV
 J0ZI72C5AO+EDIS5J/e0w7rwOFj+GVFN0XvAoaw7daTvnPJ3WDVTvo7Iy9K4QmEUh6wB
 dt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782468; x=1794387268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=sDEWCoBEMOFgafriCNBmg81Lu+5m0EnFQkwZK5tdjDTJiO83SkWkcW1t2JfXha8G+G
 m9z1XN4oV0Dk/96Z2ol3JFocrVKZMfHK3eDiw2aMxRHrXLP4g1NBlXyDi8VkoCBQAm39
 65+YY2KUl4v9jEVwqZlx/UTSMJ0jhLZya8iI/imcKUVN/6vpoaA9O7CPl6fuEoumalA2
 eIsUHZj2Mw/EIlkrOqeJxE3rJVVQd+DY/x0r1SYVsXA56uNX3ZS9i/xEzMW9LH2hhNdp
 xHVmsFBuFiQPBqjxy7P/C/U6yBvu1DUlCJNGuqaRmlso558a9/HJWSwq7nbI8E4Sydxi
 H0Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBKUDBX8W6qdTXAWVjBB9SEGuwV3rh0P73DPMPXHWLD0327DToOMSedRX8KOTv6jzl8Ptvfrc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8P5iycIVTQVoICng1qdSU8m6H7A9QoLidgGRJDu5zwKmt+y4SO
 QouseUSTZp9KpwXbC3Mdp6WVPmJiAwC3rW+vcdIYTmir0dvZK8fipt5QgTha29tO1yY=
X-Gm-Gg: AYBFou2Mw+Y+SCJlaCaMO9sRGvhlv0zLvr9tF6bfx1QE6PT9+78Hcd+WX2Of7nUCXJQ
 BNCASMFkpTIm5bsZy+gb+Qb/hDy2O4Sg2ukE7rT4/3udQVJyQF7DHRwN2DbOPhJFc7Ie8gwLjke
 AGeKuBExoVdH189KFJwm8r70X6wdNWIwsGoL3b8r8ttKnOpoIYhcXX6bNT/NOEu/pRkq40ldsBM
 N7wA6m6hwpo4vRZL8+FNqzmLKtRpreYGXJ+gqNODesVnt3dxmCwkGIkVF8qUWkR8PzqYJsBlHkU
 AyIjfHuyicXe3pSAjYLOXpmpfXmO745qCniI07lalaV1VGVCprh4Ox12HMftJaoIjaJyCH6VnYW
 sCtySBkaXkRFn7oW5IQ6TtZa3czU/QdpHA+KCBY0ysyOS7f+IbiAvEc1o+K3PJdO2Ik5mh1oYe8
 DJmug91fIndPR0wDMBIzyOrUL6o81MG9kLdFkXrOjIXiMWABTwjlEk9/YIORnRDWfg0RM6825Tr
 RQKgl6GB9vG1BxWcqAtQxtRB7dpQvjW1iYHYDMqa8/OAqgzs4SLfvJfP2sVnB8mQ7xM5ARhm912
 Ac6anQsNAdplScxDH1dip8wKSbDWEdFGT8tAtfjtVLDwM+Ype8ogZVLsweA6TZ5hiV1DX5CBaRA
 wwN7yY7NBpzHNmNif8bqtRG57tsNg8wzXf9+CutRfUH1KYQ==
X-Received: by 2002:a05:600c:8b4c:b0:4a5:1cf1:b7b8 with SMTP id
 5b1f17b1804b1-4ac17b2cf8amr356007225e9.28.1793782468314; 
 Wed, 04 Nov 2026 00:54:28 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm20656245e9.0.2026.11.04.00.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:54:27 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 09:50:31 +0100
Subject: [PATCH v2 3/4] arm: dts: mediatek: configure Genio 510 and 700
 USB-C hosts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-mtk-g700-usb-v2-3-b8dc65b47373@baylibre.com>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs share the USB1 controller, onboard hub and
USB-C PD connector wiring. Use that connector as a fixed host in U-Boot
and connect the xHCI controller to the GPIO-controlled VBUS regulator.
The shared device tree assigns this regulator to the Type-C controller,
whereas the U-Boot host path needs to enable it directly.

Keep the USB0 download connector and the USB2 M.2/header controller
inactive in this host-only configuration. Their OTG descriptions would
otherwise also select host mode when USB_MTU3_HOST is enabled.

Put these choices in the shared U-Boot-specific device tree so both
boards use the same settings and the OS retains its existing connector
and role-switch descriptions.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index 6e84dfcc6f5..1aad2514b8c 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -85,3 +85,20 @@
 		bootph-pre-ram;
 	};
 };
+
+/* Only use USB-C PD as a host; leave the other OTG controllers inactive. */
+&ssusb0 {
+	status = "disabled";
+};
+
+&ssusb1 {
+	dr_mode = "host";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+&xhci1 {
+	vbus-supply = <&usb_p1_vbus>;
+};

-- 
2.56.0

