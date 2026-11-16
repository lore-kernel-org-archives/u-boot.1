Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC639606A881
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uePdhWy4;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FUmkOpQc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86A75810C0;
	Mon, 16 Nov 2026 20:45:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dmbwtv-pBDKH; Mon, 16 Nov 2026 20:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A6738100F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861949;
	b=Fsh2AHsdylo6CDyJJpVEAyUg8lDtAbA7DBAyXVvXajEza1jB8SyPlCc7a6c3HqrI2nhd
	 uRA+8C5yLzIYlIyGlezgE0S3yevvbsHsVnei+o36InQTzwX74nLD9JIWo3vF7DZXQdG0N
	 MehQb21DQgA/f6yjjo7yCWveZu8BFULdlFhEs5rgcnucLrEv31LfD5/NLvxTDuxe5c1L0
	 e2Z1h7GCGhXfKacx8ReopwToAakbskxqmEoHYsrdvoS8OZUGkQorHr/L5b0yHpAxwn2Df
	 h0o5kQ7A4KGMmRLg4uAZ4GZrr1vZcLu4d0xyxv5L4Ygt1DYFmUe6OMFfFJSSh8WR22A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EVlhCQ9en4mocmH4P5qGYQ4geo6ycrc9irp/rSlz6n4=;
	b=lLwlUftEG1aOZkRgZgcsLeu/uGm7AatfG93VUiztWw70bnE/oyuj3EsINlP2l6+5/AHc
	 pN6Ke1cLCtK7BHb3l7tT9MdnJ/FgLkoof6KNNj4tlheaYbG86mAChnRFN/aajK10rPepG
	 /8NUCgEJWVso42xGg5e4zgSqGi15Qn8En/phDm1oSmeWBNYixwT6eRF87OJjz97DLElvj
	 /79upJI6x7YywlsOgZEGez2VuaJiZyjNEpJc0j1qUdV3/93w0cvEjD0C0Z+qt99sKdsz3
	 padKW9Fh6YZ35i9XQluXT7mw8IjnN7yECOERSlCi1ZoJJubHvwgebT5fu528YEVzxEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861949;
	bh=EVlhCQ9en4mocmH4P5qGYQ4geo6ycrc9irp/rSlz6n4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uePdhWy4Iy4uV5DZUjuB+t0Exxt5849gxaSllZ0G9qWk5bjtKssyiNvrk5tGZOi1i
	 9R8njyCO0evNZH/sow/xuRCtvAXIp6yhs4lxTpHAbbF1eCtWcwc1Oh1Tbw7tS37k/b
	 5SnGc5IS3HhnE9uXt8Il3aDWt+EAHBSdENO/kkR1gl0Dnf9w9BfY5IHAHgPsCxB3IC
	 bRvRKn8G/0wbYXipKMm8+Nbz+2JOMpEtUdAstJ4nnImeiy0lfbToeft+MyagYNZ9KG
	 wG1AJUHJIsMs56xvPmehrDlxL6a3H5jrVwjyX7xQOWrEtizuhE49QLKABaTU88e/DT
	 +FcmLU/+h7Ruw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A6738100F;
	Mon, 16 Nov 2026 20:45:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B4F11E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E540B40670
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SaCHkp0giKqe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8D7040644
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FUmkOpQc
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8D7040644
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:38 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so20959675e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861937; x=1795466737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVlhCQ9en4mocmH4P5qGYQ4geo6ycrc9irp/rSlz6n4=;
 b=FUmkOpQc0IxHbaDrbvj8WPigJpvlS8Fg26906kA9z94GDx64HBOJ9popKMrd8mTW0d
 7hqWOCzbzDfFBxKQR8UBT1t0wvnhejnMSy1P1oUvBtUYrIrJjROhXYxzyBs/eW+Wy8n6
 k7Y5+TTIAX4j837STixyTPr+MzoWzIgoRxP6UFVjO9qVsge1uiOIJIIVeyrZzionefP3
 2/J9aD0/J9asB5BN/hN2NGnRAn+Oav7QfFRS9XgL1bU2VRy+YPUSKu7Ky2sJpSsnEatn
 fbl5WHXkUSucg0Ts1Gl6QAMi6nI6pHr15puj4qJmGhODbZJcrKIMgpEXaRQnmqXMe+oc
 sMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861937; x=1795466737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVlhCQ9en4mocmH4P5qGYQ4geo6ycrc9irp/rSlz6n4=;
 b=VLb5lMGHzgzjwyP8+jRSx2ACKVFShPHbImq5gNgq6XL3fOcMvkQFXmsUdoyLrdnUR4
 Q+KNYyVVgBaYbCz4Q3DQGVvd4qjVLWNE09g97ePQqowH/Zv56b+p02dS4mDwtk9Ti0FQ
 XI+8JPxGAsStI4tggi6a2X9sVXPdgta/0VHZJPqFicF13WPS9HIkT7QyF+/jBBVWSs2M
 z8QfqlZP6veJzU/HHENnphhOy3SFqOonh+qerhuIwJQPfFMCcsxBU46g1YE/CyCWzqfr
 BPYZuaPd4RJNFuSUc/Ix+XkeCwwbMW1HJzz1dQaxRk0uec87z41SZapHY2YbW7BrFTST
 qILw==
X-Forwarded-Encrypted: i=1;
 AL+hErHpFjXwn6dt/CeVLg4V6LJuWWIwOLrqS0P5uX6Gbw8Bo/2uAnaK7jWjLFZFU2/NIQK7nTnOKv8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8rxA99RndxAkjeVHWej6WkG/TLnMCpD0qN+GaLZAtrdKoVBIsm
 ufx+okiRbWL31hdKc2v2IJRaJk0ZDBNGTW20zkleH8IvJ/fxW/id4joTr2DNpTyh2b0=
X-Gm-Gg: AYBFou35kRHr1EQBEWq2ggDj6yAXezlX4ZWUln5L3W3va1wTw8+lvtAlirg82A/T5Im
 OiZAM4+pj/g97W4MQEkZGm5JUKvEFCkQI9KOFaBAefDXWvhPANctweQVhgzMTKXEVQ2lmjgnSEm
 sYi7wGzGDyNZwd9+kPhv+ry2z2LbkMIF5ix9DDs13HFgjXlP0RNWN20GaBQYAs5keEwnAdbA8x2
 xHVZH29kYpRwMv+gWlgy+zOaDYdDVKWAASUY6wh2qb834wTXfRePRdzS0t9MynyoW0oEg+hOo39
 PKAgcQcd8O4EfcXBQneJPLI3aQqXX+9Rr+Z3yXS/dqaqpnEQpupP2lkm8tfeK2ip2hrQce/K12D
 VrwobhTK47w4Dyi5TV6T5cvlp//2qNGHqExamfowY7wCp3ctqPgyw+mqRPvqWgAnNHaaEKUkWjW
 CZlf5T89nQ9noixxnv51znLwN+R59svIoacZNOU0Fhwb3vTCWXWDxcTQTrm7FOh+EMPVWybY41n
 6vFJKtvuVmjG0KUWougQJcXTBm91efWcvLwr/jf2QW+Pye/5v3IPIDejAfO7L5mTLQGTfJThYO2
 dP9K4ajK50V9qcKwy5gcVGYdQknRrFpmE7pmrQOBsAF/XO/5LaK0YpDp5GTVufFm/Q0ZofYR8cc
 b6siMobn0bfotLZwtqw==
X-Received: by 2002:a05:600c:81c9:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4bb55a65b31mr239460855e9.18.1794861936808; 
 Mon, 16 Nov 2026 12:45:36 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:36 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 21:45:09 +0100
Subject: [PATCH v2 6/7] configs: mediatek: add a UFS RPMB fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-6-b64eefcfb0f6@baylibre.com>
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

RPMB-backed services need provisioned storage and matching secure
firmware. Keep them optional so the Genio 520 and 720 can use their
existing defconfigs for both eMMC and UFS. Share the OP-TEE client
configuration and select the UFS device tree with DEVICE_TREE.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 board/mediatek/MAINTAINERS         | 1 +
 board/mediatek/mtk-ufs-rpmb.config | 3 +++
 configs/mt8189.config              | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index eaf645086f6..8159cdbaf5f 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -4,6 +4,7 @@ S:	Maintained
 F:	arch/arm/dts/mt8189*
 F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
+F:	board/mediatek/mtk-ufs-rpmb.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
diff --git a/board/mediatek/mtk-ufs-rpmb.config b/board/mediatek/mtk-ufs-rpmb.config
new file mode 100644
index 00000000000..dcb59e6ce18
--- /dev/null
+++ b/board/mediatek/mtk-ufs-rpmb.config
@@ -0,0 +1,3 @@
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_SUPPORT_UFS_RPMB=y
+CONFIG_EFI_MM_COMM_TEE=y
diff --git a/configs/mt8189.config b/configs/mt8189.config
index a60f67bd7cb..54de8d94861 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -51,6 +51,8 @@ CONFIG_MTK_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MTK_SNOR=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MTK=y

-- 
2.56.0

