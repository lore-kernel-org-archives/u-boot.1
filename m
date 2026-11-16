Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB8606A32C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jums/tag;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B/R7tYAE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D50F0810CA;
	Mon, 16 Nov 2026 20:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeJxi9_LeKsd; Mon, 16 Nov 2026 20:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E5C0881066
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861952;
	b=jItDJAWDk158shXuC093JhGVbf/dtI1A+Bv6/mXdlJqoLSGOTN5cXIF27pM2Fej0URPk
	 jr7yKEgomj0aKam9llziHYf6UlQAvAO7sza5ycX5/u9yys1PZHBZ54Sj7joZjSXjXwi1p
	 KEZ2v2ciH8eo5Q07Q5rRbiLUyQyNhfjYmK8WZiYE91Xx8pu7l8FuDQy0D60Z7cwa1K/Uo
	 Ealiv/YujMfbtgs6q3xqaIUh9sGHIvY/dZZPXX/sMBi0szHiCGPJjNRd5Egu/rKuE5uHC
	 cDJX80IWln7cWEF5Aqa3apm5bLkm2AwC3sN0K7HxocflcFsp2UFTq4z1ttSYpGKR9Hg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OOd3msG4Q85Wnp97uRgpISXFYv3S5fkf3Tjb+4drWZI=;
	b=S+PJzuS6SPLrV1ThGwwO7WmQQqfeqhcL1XnhGzJlqjJDRrf97GqRObsqutt4gAvhd3cy
	 r9po9vwbwaxNYpz5+hNsAHLiR6G1vsGLbJS8IiYbPjeGV5HMLgxZm3EbE2LUKVC+jhZth
	 LRfHB1thxV9cmSDgFcbR70Qqv3d86t4kNLwrTaamhd/2M4H7JpGjnB+YQq7flItxTnvJs
	 D4yfJqMuot1V/96SvHivFlLSME0HrqKcZ5Xeo7YAdzADL2OUpCB8vfk+45TTfduBmCzWp
	 3FtOdxwiNgwSLob6w8KoGS+iTb5hBzUhKYVjhiI6n6BzYU7T/4Ed66+3vXYT9AIJfcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861952;
	bh=OOd3msG4Q85Wnp97uRgpISXFYv3S5fkf3Tjb+4drWZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jums/tagFQzViPcnOQdGdtPA2zWTXF9M1wXlXPM8WFjvGcfw2H0XB8DV/glX67N5G
	 G90XhKr3EohnjbRb9S+71UUxl9huVjZv4Zp4TyxI+GJULVk8TYd1urvX2aNjt5O802
	 AL3WOQNR4RvUoHxRgS9MaduwW+ubT5WZ7OgFUdvyYGjlsoJipkEk+PeSg8IyEtSoif
	 1hnJkzh5gVijDGVPZQkEv62ga9I4ALBg8D944KCBAlfJvZxftJquoGKs99yKAdYAKM
	 E7Ol76DiHcNiGVSaUf+RNYfm42iI6R+E/xFD8hvYDi7nrlSe/6jW6sSOH+DaSugkwV
	 HrF7abGa8cyqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5C0881066;
	Mon, 16 Nov 2026 20:45:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 580A44DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A7456080F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twQKHkaJ9wb7 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 564806073B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=B/R7tYAE
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 564806073B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:40 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so39235225e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861938; x=1795466738;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OOd3msG4Q85Wnp97uRgpISXFYv3S5fkf3Tjb+4drWZI=;
 b=B/R7tYAEjNHctREaZEydzLC+teWBXcNwCO6u/c76930RV/ptlZ1evdwMkrmD6GH9/Q
 iWA1xQdB5q490aZwmW9V6NkDTEcNExYM5gOaysuAqjcn1tiFfO7baq32E5AoXF7dp0nN
 SSwF5yIVnYE+ooHBxpRfcA27mSfY97C0oHfe8Zu+aRz38miqK11xL8MWWt5InVmyPWmc
 oMvMzz/3/k1JB0UhQMsS+HVzrxjAntUhCj5dbl+R8AHoXtdSfugDbdyUjLdiCb6gwBuo
 7POfm4GqzQnkXU0s96n5/xG8FQqkDCES3qc8ysfKJ9qxf+ZGVYR3cs4l73VIwAuEMmqY
 NCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861938; x=1795466738;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OOd3msG4Q85Wnp97uRgpISXFYv3S5fkf3Tjb+4drWZI=;
 b=Y48Ha+0G8m7enzqKFb7j+zjiykXfpmZXrAgZKJqvpSqgEPTgg9oN9/TbYcSYDJtAJB
 HmDsXLMmq25XiAHITR9iex1SwmOONhdGVaRMvErQynEaYZTNWPR1Qy2cmX8uU3eDwlbf
 tUY7VfilUCByt9u6wXuYMBSjqEFm8p3e4UCYYsIekpqvJichVHe3g5H7SW1SRfNqupMt
 KRSJ3Le55rGcLiioz+xmt9yQIoQ0p2E2wplbrN8eBXRqcdyUJ5HBNbyuARPUsvatHnMt
 fnuiZYZDeAfOpla3JFeOi8Sbzrp+L1A61kug2GZOEWmeZ7V/RynRThQuBCYOqNgaoDNr
 Ofvg==
X-Forwarded-Encrypted: i=1;
 AL+hErEriaQJUCgNPNv0dVLMkcdzDG+NJagfjYewgBlGGi2S55zPNZHWUPCspVhsrsxV8NlF0k+F8DM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+HnLRkeBKvH4K8osEUqOIXtGfAN4YFHWU4554Vw1ZuKjeKcDUy
 z2BGTlLfW7G2+pr+GAdMkPVqeBQOmUcLKdHesy6IfHelbmsGbFqKiYrcCvwnvAHDui0=
X-Gm-Gg: AYBFou32YcntrKogV2gADssflpDN4LaaNnt1cx3Q0HN+/hKgAkIDBjIRIrb7lfRuMic
 gqJNhdb+x6oYEW530+4liCQHCaoLaRyAHmxD9JXi+YUneI0r0rs7OHDQlE3uahRWoUUVMlyEgv+
 S3gHmz1ZyacclxSf7iJpGh/x62slb9AYATr4busZhYsXwH3v3t7mxZmAvbgOy4aURBHtKwXeF9t
 Gj6kqEkKLp0ZaWH/Akk5CotM6ZniBt9PfDavlsSps/YFeMmhUIvCSM5/0SX+EMThiMogsTuTWxv
 H6Fd/72B8UOu+wt1kXRm4dIgZQCXPG2PNQQp4AQwua7qbAhAfPEBqpgIYewAd3z+MYP/HHCXeJ+
 LpscOKpB1Wuynse9+QxsuVpzu0k7XPmEEJOw8q5JG2y3iebFzkzxlpn6wxpz3wA1ugTmb8nJy/7
 15WHuOQ7YwOegI5fxk+AJvhQcUavN5i7GRlbxKuzd+i3np14Eip3TSJFLzN4IpJhrZAY3BBh/UI
 +a8aQFc5LlmD7GLBq7uyqR8SY/jT1fKkKnaSAQqfRSf9gZM1JFkN9/iJ9SutpkmgmLCd3cNjswR
 7HwqIfDgYq+eE7LoSkgrCEMBx1vlIhZLSb2sSfzVucTOkaRGObrtlZWSJviSxJpZtjUM29DD3/B
 JSBwruORiUzOVcg8Kgg==
X-Received: by 2002:a05:600c:8b76:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4bb55a01a31mr219631745e9.4.1794861938265; 
 Mon, 16 Nov 2026 12:45:38 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:37 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:10 +0100
Subject: [PATCH v2 7/7] doc: uefi: mention UFS RPMB for OP-TEE variable storage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-7-b64eefcfb0f6@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot's OP-TEE supplicant can relay RPMB requests to a UFS device when
CONFIG_SUPPORT_UFS_RPMB is enabled, but the UEFI documentation still
names only the eMMC transport for OP-TEE-backed variables. Mention both
options.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..5dddfba32ca 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -214,10 +214,11 @@ CONFIG_EFI_MM_COMM_TEE=y.
 
 Tianocore EDK II's standalone management mode driver for variables can
 be linked to OP-TEE for this purpose. This module uses the Replay
-Protected Memory Block (RPMB) of an eMMC device for persisting
+Protected Memory Block (RPMB) of an eMMC or UFS device for persisting
 non-volatile variables. When calling the variable services via the
 OP-TEE API U-Boot's OP-TEE supplicant relays calls to the RPMB driver
-which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y.
+which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y for eMMC or
+CONFIG_SUPPORT_UFS_RPMB=y for UFS.
 
 EDK2 Build instructions
 ***********************

-- 
2.56.0

