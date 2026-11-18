Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BxbN7Luj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CzNdoQ7j
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2821940A01;
	Wed, 18 Nov 2026 23:20:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LM-21K59pY3f; Wed, 18 Nov 2026 23:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72724409F3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044034;
	b=EjQKv+qsakJ1OR52DAaa7GXbFNt64nnJ0HjGngEqyPCDM5PiguiHTM2BCfBxFF/hkhZM
	 HN9IGduBm8yPiGazCIRvP/8EFuiCBej/Yc1XeXurzCEiC5muz7zHVc/p7K5bsxrfUM0Ev
	 QloGWM7WZNgEZuGhPbMTuIWZNUdu8wWN4DXZXD5m5tRTbk66rVbF8/DSf1Cazwl80tsic
	 CnOV4GNRVrNDjA36kU4tqLH1zPJicv5czEfhdDC4vV+ooeNFZ3kQuAKGZK3Aj0r6jIjNE
	 o/iVdZCxOe675hJ9eRpoBtNc9pdQokE2F6Qbw0jVAYT9L7MyR5cRGiXymqJIcd/ikZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vDiQ+CirQFm6yvZcDPjm8wq9gBk6sdLB/oeuOa5XGe0=;
	b=QtqpBPlh5rUtHX+4KolPdUPRI338hNH8pHYytRAILneJw3CtjL2Tv9Cha6FkYGHvxzoJ
	 Bll6NqblwplJof150duqyrArghpZKS6naLqU0u3bcWKZ7hDYArb255fzAlyydqVZFgX5Q
	 u2wePNIiNieKvxkEWSv9LVse1/wC+2kSbM5S7URDUV0/Wc833NCRSgZ9qKKvG5MAWK/17
	 2UvaASlsYNUlw/udd3um/OMRCEpmEIes8VohGb9QHSy9JQxTZmxG69vlIzCo4qXMfx9lu
	 pUYuyWt/qrlr8A6+E9d8Ezk/uZEyx89pMxlc/RSmGOyxYjSqcK/97mQHbCcQYoDtKJA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044034;
	bh=vDiQ+CirQFm6yvZcDPjm8wq9gBk6sdLB/oeuOa5XGe0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxbN7LujEqQkbqtL7o0OQTidpbrjtdVZuDveSJkgpGnkCgyNRBr6eWAzzuVay5J0G
	 gWLPIqx63SUVkp00fTeNBGyH3p9m2VpF3WrOdAEMtf9jfsGKvzDJLytF5vaHy1b8ip
	 Dy+6GA7RposYI6Q5qS6MSKea1FyCqjsQm6pWTyY0HA8GZe+Dkr4/m3EQZpRTXdQFXJ
	 FJbi8vPeDFlr/eiyojXytQQoUnBG6Us8dfsQ0mZl47iuS6PlllMI2jhGytT1J3Bu4B
	 ilyUqZb1IN0n+7ncJvMmh90+fI04x4FHk16NjM6T86ain+bXi5y9wxF66FkL14Jcu5
	 RbGoKgQYYS0KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72724409F3;
	Wed, 18 Nov 2026 23:20:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 486DF798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A36060A52
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACyI2moJbvcI for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 845BE6063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CzNdoQ7j
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 845BE6063A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:31 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-833e671ee9fso1439054a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044030; x=1795648830;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vDiQ+CirQFm6yvZcDPjm8wq9gBk6sdLB/oeuOa5XGe0=;
 b=CzNdoQ7jK/eFT1xFRUVuAdoYdhdFsNYGu1nLN4UmS6EU9kRRsUryDUQwFlxE5jpHi5
 +2YGs43SdasS06hPdUZ+QcRDKzChND3re9RTEeAndmw7Kv8l+XUni1c8BvIFy2dlnvIQ
 N4KqWCFrQG/yz7mPwNuKPbsf5Jg9B4Mxgy0eAvOmyvBD6BuKmTwDywywa+rynUh3VxOj
 158qySgl+eijQfaaE/x844q2ZPpJGtUedmuLe+gVwn+tEexlC9kR6kUkqwKsGtRvpCiW
 cPhNMa6B2lbSmVqThqs4gMegFL9rtu91r1NlgMJAgh3pjc4U6BNUIsK5cZCq6G8EyLtK
 OCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044030; x=1795648830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vDiQ+CirQFm6yvZcDPjm8wq9gBk6sdLB/oeuOa5XGe0=;
 b=Y7AaAFz8YeopUPAOzhB9N0rjymrJqnLkvO6HXVExMzQLznR8rWebnCy7bVML2lA3jT
 zJyb6M689qB7dueRYySFz8lDNaqiWojnSOUGfmMxlwHgQcMMAi112otUP9eaiaLWo5oJ
 8Qp0YyjyZJAM4wVm204qI3WRSCkHfxzOJJWmOHr6wFc+S5lWLR62ASGPgZ+8PVAva7OL
 jpOAWdHx1Wkx6e1XHq/iv/3sSKLRmmT5fM0VWzu5QxsXKfeGH/O5MrBOszij4mZY5U9a
 yNuYywSx2x1IUKQ4553eProirAnXWFu9eTJD3yoWEhM2DOchkxwk4cUBcSiQ2blYDLjr
 EcRQ==
X-Gm-Message-State: APuU4Z9UbQKVin2mdKNuWORD2c7+CaNim/IsqBsgofuysF2UaiAicJAl
 kQtJcMABMHnHZQLp/6+z1dzb51aCgIJppgCBF3vWIGl6jlE6pmtSWQ/oT3d1zUKFEok=
X-Gm-Gg: AYBFou32SI8pwhJUXdpEz5aSuxft4h9D9qZf4zlEQ0Iu8pGB+L6wzffaLlXbdgpSLRm
 whVV2UTmVbt0c5Pu9hNZzAqcdYNrnMIbOC4AmRti0T0zowL7/cLmeJyy4I07cEh/8z4Y1kAgK3B
 5sqi7wNN5RiK5mH939/SsVKRn5jKmVhM/N4W8FFfJeiZTxtwCHuuVRAAVcssyR77ql8IGZ8vdsP
 +WWPVIkA7umHY1oks538EoPey2yNJfeQhA5L+72IdXO2FODdFYRogVamyzPuTpRKSAXkBYKQCL/
 LbUj+QVHDtVIBXj8fresf5FVItmUsXDgMwCQ+H10YSr6KRcEQOiEMsfoudDu/5JiaXyDVmOty4K
 U+sMzCnD+CqIdquQ9gJSuPXK6dCH+IRlnDWgG+0/7BHFIYLkjUFzfl9itYhJLr9tG2gSwnq8g1w
 p+P6k2MhS3vs2wAMuJItl/ni56iGCNVNPTg+lha980mXVQHC28FTPNkZTBoYGOSvYv0P6nRW4R8
 Vd5I593F/12f5xwEiwzvH0NGtZDIsheWaoyEmvkRIUfjKNCJ6dWIoBK07baaaGqVGfVx7ecbEt6
 EvfYJFEmFNZt+ymU+zXD78rGGHE/aYJq
X-Received: by 2002:a05:6830:b16:b0:862:bc33:da9d with SMTP id
 46e09a7af769-862f0965c43mr4247935a34.23.1795044030271; 
 Wed, 18 Nov 2026 15:20:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:04 -0600
Subject: [PATCH 5/7] configs: mediatek: list the Genio 520 EVK devicetree
 for Genio 720
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-5-1505d27fdfcb@baylibre.com>
References: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
In-Reply-To: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CerxxtmQ93Dg16DMTcRmH9UmD7grIkteijYHZi5alDQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKbT42LIH+ixt9+YMQQvWzWuSUKrUQ6aB5uj
 W0OQs+PvliJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4ymxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsMcH+gP8QJR7W2hLwNSB24xU2lB50zKmLlkVx5Vt1uT
 d0yessepsQ+9erhvVBC4GfssmbpGIXfa0YVAgcefyG+Zv7JciPvFrqKLJq3JBU0GfoblHJr1zpf
 NTnOPFlfUbst1NZn0IrKsZiChtCjiEUjhx1cUdnZomx2WRZsD6gJW3dtzmmBXnbcB3lUF9LTGUq
 BFjUDW9x9MwYrtkE+CsGz51V/1gQ3fsDsAS/BXmHf3rwr5lYOA91sK3iZTPgCSZjgVKvjw5rDPB
 ++wA/jQiaz7nzZibG6vRQ4oVMZHFXjKlWqV0NIziu9eDKfsi3yWlpAWTU7sDVCjN+/LfF2X62aU
 pxWc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the Genio 520 EVK devicetree to CONFIG_OF_LIST in the Genio 720 EVK
defconfig.

Both boards share mt8371-genio-common.dtsi and can use one U-Boot
configuration, with the board selected by DEVICE_TREE=. The local
devicetrees are all built already, so this does not change which
devicetrees are built, but it records which boards the defconfig serves,
as the Genio 700 EVK defconfig does for the Genio 510. It will also be
needed once these boards switch to OF_UPSTREAM, which only builds the
devicetrees named in DEFAULT_DEVICE_TREE and OF_LIST.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8391_genio_720_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8391_genio_720_evk_defconfig b/configs/mt8391_genio_720_evk_defconfig
index d1ca4f3731a..e22e8c700bf 100644
--- a/configs/mt8391_genio_720_evk_defconfig
+++ b/configs/mt8391_genio_720_evk_defconfig
@@ -1,3 +1,4 @@
 #include <configs/mt8189.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mt8391-genio-720-evk"
+CONFIG_OF_LIST="mt8391-genio-720-evk mt8371-genio-520-evk"

-- 
2.53.0

