Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D689606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SFc8GGNb;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gpmfUWU8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 219F8810AA;
	Mon, 16 Nov 2026 20:45:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJ3wbiX4A3Zr; Mon, 16 Nov 2026 20:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 32A5381076
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861947;
	b=ZrtZaA5GtW5uaud802Ze/xcdldvIu2aP/GfzNVEzMrz8EtuYh/fUihvAL4UeOR+YhdMj
	 8BqISMnLEPJToshrX2b8JJGeRU77VE1+ovyZMUtQ0sva17TZ6zXktxKjcTp9klD8l1TyV
	 U+3z4CNrQTAgVjiHeSl8BhHB3F2wNMoO2rtBHd+OJZY6dPWstUBFTzfEZUQ9uf1Hbfwzx
	 NWfXaW4KIlBtgxshJ7TSVYOax9AMrjk3YJwdDvwpEGZ9hrh4UJfSxEZe2u0hrFQYXSqKz
	 WdHGQ8sfAJtYRlOmIF4+2EOEzU9A4aZLvgRL7Wk6DUqWzUgt4KcVuObuZsWMJBLS7KA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
	b=D87mKCOsTvuc25KWxLB+1YtYvCerwoYhSUMeytn+UtjRv1lA/xaIN7Nq53/8QtyZyAyO
	 MAVc62VboGc0cL+XWJjr31xYwnt03tBbYSNIxE9/jFWIEww/7GXDxT4n84qXfB1kTJpWF
	 T87wO1y1vU1MCuqwVM/fgas37KzOcWD3WlrinsqoPFHdWYgyhPcuqKwcAP2fNQw9CP3iT
	 pxXODJh/NYnQ6OEhqR8uTmGWWEq4QZVnvXN6794NbAw4fzRPPhw08pRguYvq9EviUw9aW
	 hSNgRZ539c6yiTpT7K52Cs9YHO/ouNP63hFqamFC6XahHG+zu108+HzhPYWjH9s98FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861947;
	bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFc8GGNb/8+3qEgHIblEe26lJCPKvK+Ll4AjpFI8NGhuvrqKr5rZz3dQkqSQUdxLN
	 6G3wrZB8X4vnnXz3RNzBG+JSaH3q5P+nv/6/Z7mMlPRO8NsYkz3tnEdP1rWRSv+VjU
	 3TEW02Vmckh6HZyS3lnFwvAX7j3AvS3gmuiYDWCdsZ0UOEp4OqbMaCDE152vIi7jCG
	 yXo2vWBerkFjZikYE35iXXnArpLhCQ7NHNvXsDS/RR+1JZL5+1lavbx5ZjK8dWGmjD
	 WCzaXkOMj0xHCp07XpeI3YdmchUPFntsKMRocbCX1p4qXe3cLQ045s58lg/rODDFvI
	 E07RnwUhfsPWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32A5381076;
	Mon, 16 Nov 2026 20:45:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2D0C109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94D2E6080F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7cOMTVpc7Tm4 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B68616073B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gpmfUWU8
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B68616073B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:37 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso27435195e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861935; x=1795466735;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
 b=gpmfUWU8UYaZfjQvOLj+Zd7HfJwkhG6093O580oxRpvLkHVqBjtzKnlVMs1yfHVUxI
 K1Lj3RXCoR7wWucnTkCOBxWqdvMEfWOr6+yF8VpO3pi3QUOIR6UPB9GS2cOd/2mMWRXQ
 YcSsOpg//XhggVv4WcLsIZwBYYCBeNA4gsmC1ywvXd1+wSIfkf0g1vQIozuq7TlhVV+x
 chz4Kr6vHpZfvpLIZYMW5nILnOiGIJ/+b4ox2eRQl758GhbzlECLI+PEzdqPuDtSegnC
 kG8ua3cSV1DL+N2Nqb802MFMZSj6UofXPBwHnjyul+dGZuiVaNZcnsCYab9zNbWp+Krx
 5+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861935; x=1795466735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brd1oaO9ncOUChAQKoaK8Asi5TCBoXsc8Mx1nWwyOIY=;
 b=NCfaPwgPODU8LdWWztOsboRg4xkuI5CdhFwM65RTkksf4tJ+uHDrA54gt+1pXMv0It
 VOObxs6b7dzcLg1452Qy88Lqu8Hk6lP0x7Ifnl0/I2g2Ga3pSgRCZcZMuveChIA3M+RA
 nYPg0kU7L+zprl54STZDnAl5ti8OWvEhJyQH2W1UPjUABWuylykDd5kHRjXcRbfWCTaj
 jQqMpZ7ghC1ou5ryAr34fo+Xl2ElT+Ez9xPeor0UANsHdd+Q7EZ5KFS+jtlE4I3bnd+Q
 o6jWUetmQs119Eivf3yP4fNR+nR7DRqL8DJekA7aWuQ4ahNMEot7vLZh8Zp8YSpJoj4E
 lymw==
X-Forwarded-Encrypted: i=1;
 AL+hErEZWNkYLu45dkIxfiPcAXGlGCxJS/Rlwjg3PgGYlP5K9QqEI914cZXAQS7NMeauO8EeHuPtYqk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+bP382oZRXCEW02zvFOt6ypjv+I8UPYfdx+lCCuPlgZ4y3WC/b
 hT07ZRquiXat7bMfBYbUSEN9oNzk2wSOKY20q9+N0AE9765P9zrODkWlLIwAkD//npA=
X-Gm-Gg: AYBFou2/Cib78FiucYtlvJZKXw64+G08OoOKm/yR7gTGPra3VqyT/+heI8bP7mZW4lU
 08Gha3q8ovzOvScevOlA00Ii0zzHSzuo8crWfur5qkHHnku0vM6Xlih9x6Oa2kVOyJtL4pAutPT
 BIK63w1/OQEveOjuuz0y92/rogQsK5Ix090c/53Z1NQ+KDIpuOGP2W/4seo+VB/o9PCMS+kiuCr
 2zn6ECXuAr7MoLVNHCNIGsoZKfPV12dQToZueyvl0ziXxwOXvRIqOhiuPXqpl4VVAM1DZYgppih
 I6R8nQwK5N7zRRgPtVl/Y3uWkOWPCS6JNHxqCgji//PFjrfG0/pnINbaMw/avQrlx4eHSoSKAYH
 LhaLPuFVKRCBdFpHs+NU6q33ff3pWsPUQSvjXtX91xCgIjJYlTXw8N48QDz0eBmFOhNWaDmjTkz
 5+a1TT4b1QGfnnE2GvGp9v/AiqZCLfcPhgFGXKQyCm7tlLsFghSSjORp2mbCtb8CnbBywovTR0b
 qMrG1tmw44FXHFElWcOhF4uTdcysvXQEsx/aUDTze/YHcWlaELUZdoqkAiDgnT5BpCA84G3ZG0z
 d/ZgEcIXKpNKow9z0+ttMIc/ItL7gxBG6HoN/8vOqP8BDbV3jDV+6IjEBAmKW1BsfSwJr1qgzeq
 fvrs+wWLm2T/6P6/NSQ==
X-Received: by 2002:a05:600c:8b57:b0:4bb:6118:4f57 with SMTP id
 5b1f17b1804b1-4bb6118533emr204445885e9.18.1794861935532; 
 Mon, 16 Nov 2026 12:45:35 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:35 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:08 +0100
Subject: [PATCH v2 5/7] cmd: allow the OP-TEE RPMB command with UFS storage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-5-b64eefcfb0f6@baylibre.com>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

CMD_OPTEE_RPMB is restricted to the eMMC transport even though the OP-
TEE persistent-object interface is independent of the storage medium.
Allow it with the UFS RPMB subsystem transport as well, preserving the
existing sandbox path and default.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ace0b2e9c80..6f07eccf16b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1554,12 +1554,12 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	depends on ((SUPPORT_EMMC_RPMB || SUPPORT_UFS_RPMB) && OPTEE) || SANDBOX_TEE
 	default y if SANDBOX_TEE
 	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
-	  in the Replay Protection Memory Block partition in eMMC by
+	  in the Replay Protection Memory Block partition in eMMC or UFS by
 	  using Persistent Objects in OPTEE
 
 config CMD_OPTEE

-- 
2.56.0

