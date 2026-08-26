Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324A7C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C028580B3D;
	Wed, 26 Aug 2026 16:34:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q1kZkRsNyLFy; Wed, 26 Aug 2026 16:34:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762090;
	bh=HgdEUWNMm+RUeKbwX/eTOuG6tq20B0TsIMprD/4hY3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmhdqMd1zYMYlHUuapeFxf5jAuWKzNGLukJrICyHiKv8EW79w8JQgaBjAkZfNI6Ea
	 DVowmNaOUwgI2opLj4IGRLFMRux0pMGlVE+98Y3UfSEep0ardxw8el/HR3tuayxiPc
	 OHhozLmwlSLJKNpGHO+k0ThAwE8lZjQ2AfByF0j9xrsZFh0hQnr8oX1ZsNjAsyFxU9
	 /8YwNFvpEi2WYONdhsWWJTcmiO9cRvNUNqpacGO2RciJ6iCCp79B7Q8sKhh7FNA/dU
	 ZpJMTmIxOzSNJjD/G48+v+9+KL2173cyY6j/gVJ/Q10xe8wQYEE3ZWu+ExP2pX0LsE
	 lqgiYoN6CHQOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC14580B5C;
	Wed, 26 Aug 2026 16:34:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47F9E341
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39A9740586
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKMK7us_plc9 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=shj707oF
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E45A940562
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:46 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2530cabcf4so73454666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762085; x=1788366885;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HgdEUWNMm+RUeKbwX/eTOuG6tq20B0TsIMprD/4hY3g=;
 b=shj707oF5KC3zviWNM6BtNtiYtfL/hDOCLyh0JMDV8uVEoCoQU06D6qejp3vd847wR
 46Nd89VkkIi5VwVjsVm5/OXiiOLyu/ZPBdL/N+MXL/ocoWon42l9+eyph+DswLtZ+CdF
 40YPVxKblvReb3p7ks5rcAfoFbm8xUHYWo9wic/cZtSpT00nMZLTdLJAUBxQJi5uO7mx
 YJMPU3NraAUqbBqqjLp6aY3HNep7BMI/Afs78drm9vbsc74epo44jZl8GhSpUAryawFk
 rq5qK9igF2qwNzOxwRSbNYTjDwkq3mIjCh3IfzBn+WYfYVrs+Y0q7rbP+O8naQC1kBEy
 SBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762085; x=1788366885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HgdEUWNMm+RUeKbwX/eTOuG6tq20B0TsIMprD/4hY3g=;
 b=Wc9+MHUxP5GiP0t9xRURzqpNlHO0zN2j23Rak7p7V0g/JzKmP4i1bKYcVvuC/1YGSZ
 NKMSCHPkrZNsqqDfZ9K9RTjr0OowFEi797ALfcTIOqWqHJXrH78w0J0yljCsGSuzuYof
 oVVt9kWHis5ZEa3XFtIVbCNTRiWxzBO52VtVmsElfw3PqmHOcGjUNR8tRmsh69+NxdDs
 ejR+/tB3fgjgw6WhZsTb7z1V6i6/zmwTlr+eZoTN2hVG8rW+e/wzoYnSijRoRTtOak9P
 L0agcScpjy70d4G5qgxQDtWH+W0bBbkdUPj+DtqcLYTBMegtrvOBgy4I69ApY+BULbZs
 j12A==
X-Gm-Message-State: AFuF++lmCZzy23jJspkq0AuqNR7XFphg1CzW1kLSQ9pSYrG3n+IXiZbx
 /7bgP6z0sCAIrrxnzb01YeSSEzhSu+6un2OCHTgmtz+yXArgqQHG3kxoUHhY3krHlao=
X-Gm-Gg: AR+sD12WNhWeaa/fDBIvOyld7sDKjZeUy8Oyue1CkML4xMMgJ/ast4F/WRsJKoDuEbU
 3mRnkCnt8Q+jT1nMRpMC9x8ELgJuwppDULMId0k0kiyoOYtSqD5KQR/c2ulhC7QqZQlhoxHcwH7
 921s6iSuwxXjklggHQYzTzd0Y3BdrxAE1rgx2+hnlWhMXDGleDfYgijX41JhCdNxrDV5e+gKo7h
 uSYAS6AnjMTsM4Uz9YUAslzSABVBTwzYY4eNZxbnpKUE+clQv6HD2uqgUNyl0jsa4eFBrtfMUDS
 F7WHmT7euD21x/w9SGkLoRqewlUMqlqG654Wt/Sax897m7PVZDXC28Y+sQn1UML4zez84KLxMLQ
 EXBPyzyLPzqaJXz8P+PYaVcGz+eb0O4SAeoRGMUsGqhQxg1gKVR5ViBFlsj6xJxRdpf52Xk+hfD
 3qlqOn7UePwV/agsxqo18DRzHkyGdwcZrEaoKhTCuazQI/UU6J0OPiqKWuSvro6js0ySSvG3f5/
 3k5UHJjRs1HEPYriihDV8OVwYiubeh2F5ktQtS6fYHnmCIMOnPC
X-Received: by 2002:a17:907:9802:b0:c25:2f1a:b396 with SMTP id
 a640c23a62f3a-c252f1abfbemr368373866b.13.1787762084705; 
 Wed, 26 Aug 2026 09:34:44 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:44 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:59 +0400
Subject: [PATCH v2 07/13] pxe_utils: accept "title" inside a label as a
 synonym for "menu label"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-7-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=alchark@flipper.net;
 h=from:subject:message-id; bh=4F3uvyVftmtFaOshjI0ltyXtrWQ7wQuLsx9xOZwYh6A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/Y2C38raZp10IYvRPh63syj0XN5Fqzl0bueLX5gZ
 vR89u25HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz15UWMDM+6H/osf+n8dKbtlaoYjehdP6pf8swL5xSWm2h4XbRphy4jQ9vNXG4
 XrZ/5TxpWRBn82rX+vtC89qOTrJ9tzdIxqF7yhgUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The parser already understands the "title" keyword at the menu level
(via "menu title"). Boot Loader Specification [1] type #1 entry files
use a bare "title" line at the entry level to give the human-readable
name of the entry, the closest extlinux equivalent of which is
"menu label" inside a label body.

Make parse_label_keys() honour "title" the same way it honours
"menu label", populating label->menu. This lets BLS entries surface
their pretty name through the existing label->menu plumbing without
the BLS bootmeth (or any other caller) having to special-case it.

No effect on existing extlinux/pxelinux files: those use "menu label"
inside a label, not bare "title", so this change is purely additive.

Link: https://uapi-group.org/specifications/specs/boot_loader_specification/ [1]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 994da42f7cd2..400ca99085a9 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1284,6 +1284,19 @@ int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
 			err = parse_label_menu(c, cfg, label);
 			break;
 
+		case T_TITLE:
+			/*
+			 * Equivalent to 'menu label' inside a label body.
+			 * Boot Loader Specification entries use a bare
+			 * 'title' line for the human-readable name; honour
+			 * it here so the existing parser handles BLS files
+			 * natively. extlinux/pxelinux files conventionally
+			 * use 'menu label' instead, so this is additive.
+			 */
+			if (!label->menu)
+				err = parse_sliteral(c, &label->menu);
+			break;
+
 		case T_KERNEL:
 		case T_LINUX:
 			err = parse_label_kernel(c, label);

-- 
2.54.0

