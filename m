Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF68606A335
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hboXokaQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=csCFfEMV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E658160A87;
	Fri,  6 Nov 2026 21:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KT6CukGAoUqK; Fri,  6 Nov 2026 21:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9965A60AC9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001017;
	b=LEMIvkCm3nBVn91sGmh00li08bG7Ygp4uI2L0ZLNTRHFGjOZaFZA7oLDlSDIjCgo56Ez
	 3Z3TR58CuXcs3cm8hDIOk7AD4C4vD3uC2d43qRL+z92KyKe0QR0Q2ZSO901rgayeKHwaj
	 dilcCJsstSsaeVgERGD7z7X3efaEzZeH1aKH1vYxkunhfPudimKKAvchphKgey88hpdlk
	 Sgz/FHFJ3WqNnJ3yu27TSxNn2J+94IFECaT83d7RYTsF7OaO3QB7CqPZDz5VerZviQZ/m
	 u3+bhV2bvT8iHMiaFER0O+rW5o08BS7cHxc905ZPcU8WuwM61hpcgZllWxwpxM1RuSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5feUoVOdiiTR3Tun9T1Pit9ahrH1B5oj+L57Y8er92Q=;
	b=T96X74r31ZC7AHqG9mxBXaASzMUYIFr5Gm2FCCUILe2oC0zvjsCMOdywMF+UFgPsond5
	 tXynzj8eGTih1lA7fZ7MRivipq5c+yaoF+1YjBdbFaZGshfm3SbZWfoKrWYALvujoyhPN
	 Zt48+3Qy0GvIAdHWJl5JgdBWrTTPK0f/e3tWTuGcY//6a2LMuOzjj+5DEhu8WEAbVnI50
	 /OKjuPaUd0EK3Xmo3XVRtyWD54Ahee2sWaCtBBhrFLxMcf8oB6mPmgMjNaRKZGcT7afhk
	 UnMWT2QFuiA1kMcFNG+kLN2d+WoMzA4QfJ8k+afpcTG7G+0YlOooifSwMXuX9X/x7rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001017;
	bh=5feUoVOdiiTR3Tun9T1Pit9ahrH1B5oj+L57Y8er92Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hboXokaQN6vzOZH5eRQeNT3yDbeibHG9T/Z78J5iawJoWakoKfOQ3um3JKLDaUu54
	 T1rdCMsWJEksRfkgn0Z80heU1IpY7KoN9ecuNZ/zLb1lYfTRDQZRFtevJLQfWxWjeh
	 TfkVctzCWdsA7dPDg/s9aVtVGlu/NiSpPkM4uADelBmiXm1ZyByxgn7swn+iCjorhr
	 OfoEWaVDMTJN2SGs0oIVs2M2KIapu00kgFyIpyKsydHHGgIQhQFb2bzQcUHY4CvleE
	 /JVh2oMuyJ0il1fM6QgfRVO7nlXLHvsrEtoQA1klZwIPuqVqC0W1hpFCJn41xCTAT3
	 AWp0SEN33P1iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9965A60AC9;
	Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91CC831F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82E58407C4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rx5VRUogIgdn for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8B94407BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=csCFfEMV
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8B94407BC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:53 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4d198f1a591so637893b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001012; x=1794605812;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5feUoVOdiiTR3Tun9T1Pit9ahrH1B5oj+L57Y8er92Q=;
 b=csCFfEMVWSq92Pga6yxD8lKyEmzfCv4Stv39voU73BP55DYbdwDk5TUHgQIjk3GYyi
 BGr/GUyMhymDFbf6GVR7p14kpq1RUGKiutN/0pmNlFy478wfxB0JPKJGCJFrsAzrv5ee
 +8i7Q+WeoF/6fDUlVfcFwVvaHBcpSYl2tL3vbVRoM8bKQINDZ8Aeyjy3yE03B4bQxMXI
 YcQ1I9WmNhn4xiFEGMd2x2Cj9dmUrHJ8Hpnknbq2LBoU+G1weAJAYaHqDq+BuFK8HM8k
 khmaDIBSZSx7XwmnNT6Oa8Oz2mjLDHV0MXYW0vN41zk3ZZ2P0wbL4lqFmFWxSGCb3Mj0
 ILMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001012; x=1794605812;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5feUoVOdiiTR3Tun9T1Pit9ahrH1B5oj+L57Y8er92Q=;
 b=y+sCoOlN0Ek36fCPrx2TP8P9PErLCa2Qm03S9pN9okVewoqUkPWgvmBO8h67oIgtm1
 gLfmJ+j2+FLPNhyjcZF9ggqfuchZUQjSlCPfv20YaZo9XC4134HBGGb+rc3/+l7bd9eo
 pnaJRt6vaPfbm/l1fWjE0il+eR+wUr1fJ77RMK2oz5nh9h8s4jacF1grPsRbrFbhSZ4Y
 IskgiltFOzwDlz8CqVb4y9SePNGUs9VuKzuxnMvlFVLHsPZb2N+QPidCUlwkQBM7CjZt
 feiPA1q85gKNzURtt1gBajmnoIuL+etqh7JTK/kaP89sBsuKVmnxaE9tM0N2MQLxPv/G
 vAsw==
X-Gm-Message-State: APuU4Z9XXwjxp1OVhoTuAy1bJBqxf2Qf/Y09kEG1YP4wBk2e7LFScoEU
 0lnwJcZQG8eHyaONYQW5zBXix347vf5i22eggdqE273w1N7Uza4zWJdRMGYiFsYWeNc=
X-Gm-Gg: AYBFou3owpvtrvLXh2DiAyxyMeVgWMLGD9eiGSTXOQ2IDqoPUcP9YsgdYXM/r4O2j0s
 sveNjIciYqxrcNM/5IPoOMY1OttrOomLq/SWHpkth6YEWmPGhlARZhPc84Ou22dzjVzJKOGAMau
 g89/myxc4Tt78213Rm4qNPDR5G71RhNAPhwkCWPRh2m4nIOmGwrKC+l0skVbfgk3ihEtpwUu9Dc
 JCtDIFSoZSYcWZHQbXPaD+LLvtaUnkLDUeksLw64teQY3X/TVYyt3MtoIkPy8UT+QX6rS6bUHT0
 LMbvlRaUEfOL9CuhGWNWjH9H4mo7e6wB7OIaV23OrfpKCt84wRTbvk98kyQUaU5+w2uHPvHNb9P
 h191ktxwY2REQ68WOVEx91XrQyOIil67VqmG5Dnlw5VtLWzRQdapv9dLT9+gEhDZkaf0S6gpRVw
 Jsea4bWumgdcEIm4gC0mMF279VkRxoFmN9ztE3YVKdscLVrzMxZ3xPmUJA8u8ro7haId+q+1xTz
 l/SfVQfYFY4hAJBCRzn0HktA25/3iQgD1R8rTFBhuErVKJwMxLTRLSMe1kDP73JClflFJjFA8tS
 nwjMh9tU7YF+f0lJl8ytCNP0lkn1SZn3rw==
X-Received: by 2002:a05:6808:14d2:b0:4f4:dd0d:207a with SMTP id
 5614622812f47-567e0f327c4mr2617632b6e.4.1794001012041; 
 Fri, 06 Nov 2026 13:36:52 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:51 -0600
Subject: [PATCH 1/7] tools: mtk_image: add UFS support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-1-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7178; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5LBKSyOYCHKL8rINI738cUHFaclEh0kbzBVdq9owF6Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khBlGX0VAITDblCticY/pWSSRDLc2Lr+lYEz
 416/+o1MyiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IQRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzY0IAIcvx4OJUG9vO4JcpvOeC27gTtVLhzq5WwGNMQv
 jAW8MHuKGxhvEDyVfOy7UaxkY7SBdnH5wD0ezDezbvpSZVzdWp3fk8wk03DdzdiJ6FHqrcYv7rH
 z7A+t6rUpAy5iIgbJCVHGN0XA+dm8gtx7aKV1945+mUl9SKkclqIn/cAFbDFLtURr0Og+r83G+l
 zYhrcnjE0iYGJoyheuDHiVMJCAIjDAP9zOpM8AouNlozd20zIRQn/wRl5bZO1EMQ3JQZWbI62v7
 Ur3BvKu9l1MInEOwh+gTFMmFwBzY6XcgL4eBtUbvGQaP/zAf24qYWMJJ1Nu8Gyh0GhbR6OCWkW4
 ONQk=
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

From: Fabien Parent <fparent@baylibre.com>

Add support for generating images that can boot on UFS storage for
MediaTek SoCs.

The UFS device header is 4 KiB instead of 1.5 KiB, and the size field
of its generic boot header covers the whole device header.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
[dlechner: rebase, fix header size check when verifying, document the
 ufs media type, use mtk_image_verify_gfh()]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/README.mediatek |  1 +
 tools/mtk_image.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/mtk_image.h   | 16 +++++++--
 3 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/doc/README.mediatek b/doc/README.mediatek
index 246579d4be2..d38709408b7 100644
--- a/doc/README.mediatek
+++ b/doc/README.mediatek
@@ -107,6 +107,7 @@ To generate these two headers with mkimage:
 		nor  : Serial NOR
 		emmc : eMMC
 		sdmmc: SD
+		ufs  : UFS
 
 	   nandinfo: Desired NAND device type, a combination of page size, oob size and
 		     optional device capacity. Valid types are:
diff --git a/tools/mtk_image.c b/tools/mtk_image.c
index 1b1aed59924..ac9c86df6bd 100644
--- a/tools/mtk_image.c
+++ b/tools/mtk_image.c
@@ -36,6 +36,9 @@ static const struct brom_img_type {
 	}, {
 		.name = "spim-nand",
 		.type = BRLYT_TYPE_SNAND
+	}, {
+		.name = "ufs",
+		.type = BRLYT_TYPE_UFS
 	}
 };
 
@@ -262,6 +265,8 @@ static int mtk_image_vrec_header(struct image_tool_params *params,
 
 	if (hdr_media == BRLYT_TYPE_NAND || hdr_media == BRLYT_TYPE_SNAND)
 		tparams->header_size = hdr_nand_size;
+	else if (hdr_media == BRLYT_TYPE_UFS)
+		tparams->header_size = sizeof(struct ufs_device_header);
 	else
 		tparams->header_size = sizeof(struct gen_device_header);
 
@@ -357,6 +362,65 @@ static int mtk_image_verify_gen_header(const uint8_t *ptr, int print)
 	return mtk_image_verify_gfh(gfh, GFH_FLASH_TYPE_GEN, print);
 }
 
+static int mtk_image_verify_ufs_header(const uint8_t *ptr, int print)
+{
+	union gen_boot_header *gbh = (union gen_boot_header *)ptr;
+	uint32_t gfh_offset, total_size, devh_size;
+	struct brom_layout_header *bh;
+	struct gfh_header *gfh;
+	const char *bootmedia;
+
+	if (!strcmp(gbh->name, UFS_BOOT_NAME))
+		bootmedia = "UFS";
+	else
+		return -1;
+
+	if (print)
+		printf("Boot Media:   %s\n", bootmedia);
+
+	devh_size = sizeof(struct ufs_device_header);
+
+	if (le32_to_cpu(gbh->version) != 1 ||
+	    le32_to_cpu(gbh->size) != devh_size)
+		return -1;
+
+	bh = (struct brom_layout_header *)(ptr + sizeof(union gen_boot_header));
+
+	if (strcmp(bh->name, BRLYT_NAME))
+		return -1;
+
+	if (le32_to_cpu(bh->magic) != BRLYT_MAGIC ||
+	    le32_to_cpu(bh->type) != BRLYT_TYPE_UFS)
+		return -1;
+
+	if (img_gen) {
+		gfh_offset = devh_size;
+	} else {
+		gfh_offset = le32_to_cpu(bh->header_size);
+
+		if (gfh_offset + sizeof(struct gfh_header) > img_size) {
+			/*
+			 * This may happen if the hdr_offset used to generate
+			 * this image is not zero.
+			 * Since device header size is not fixed, we can't
+			 * cover all possible cases.
+			 * Assuming the image is valid only if the real
+			 * device header size equals to devh_size.
+			 */
+			total_size = le32_to_cpu(bh->total_size);
+
+			if (total_size - gfh_offset > img_size - devh_size)
+				return -1;
+
+			gfh_offset = devh_size;
+		}
+	}
+
+	gfh = (struct gfh_header *)(ptr + gfh_offset);
+
+	return mtk_image_verify_gfh(gfh, GFH_FLASH_TYPE_GEN, print);
+}
+
 static int mtk_image_verify_nand_header(const uint8_t *ptr, int print)
 {
 	struct brom_layout_header *bh;
@@ -504,6 +568,8 @@ static int mtk_image_verify_header(unsigned char *ptr, int image_size,
 
 	if (is_mtk_nand_header(ptr))
 		return mtk_image_verify_nand_header(ptr, 0);
+	else if (!strcmp((char *)ptr, UFS_BOOT_NAME))
+		return mtk_image_verify_ufs_header(ptr, 0);
 	else
 		return mtk_image_verify_gen_header(ptr, 0);
 
@@ -530,6 +596,8 @@ static void mtk_image_print_header(const void *ptr, struct image_tool_params *pa
 
 	if (is_mtk_nand_header(ptr))
 		mtk_image_verify_nand_header(ptr, 1);
+	else if (!strcmp((char *)ptr, UFS_BOOT_NAME))
+		mtk_image_verify_ufs_header(ptr, 1);
 	else
 		mtk_image_verify_gen_header(ptr, 1);
 }
@@ -658,6 +726,33 @@ static void mtk_image_set_gen_header(void *ptr, off_t filesize,
 		 filesize - sizeof(struct gen_device_header) - SHA256_SUM_LEN);
 }
 
+static void mtk_image_set_ufs_header(void *ptr, off_t filesize,
+				     uint32_t loadaddr)
+{
+	struct ufs_device_header *hdr = (struct ufs_device_header *)ptr;
+	struct gfh_header *gfh;
+
+	/* Generic device header */
+	snprintf(hdr->boot.name, sizeof(hdr->boot.name), "%s", UFS_BOOT_NAME);
+	hdr->boot.version = cpu_to_le32(1);
+	hdr->boot.size = cpu_to_le32(sizeof(*hdr));
+
+	/* BRLYT header */
+	put_brom_layout_header(&hdr->brlyt, hdr_media);
+	hdr->brlyt.header_size = cpu_to_le32(hdr_offset + sizeof(*hdr));
+	hdr->brlyt.total_size = cpu_to_le32(hdr_offset + filesize);
+	hdr->brlyt.header_size_2 = hdr->brlyt.header_size;
+	hdr->brlyt.total_size_2 = hdr->brlyt.total_size;
+
+	/* GFH header */
+	gfh = (struct gfh_header *)(ptr + sizeof(*hdr));
+	put_ghf_header(gfh, filesize, sizeof(*hdr),
+		       loadaddr, GFH_FLASH_TYPE_GEN);
+
+	/* Generate SHA256 hash */
+	put_hash((uint8_t *)gfh, filesize - sizeof(*hdr) - SHA256_SUM_LEN);
+}
+
 static void mtk_image_set_nand_header(void *ptr, off_t filesize,
 				      uint32_t loadaddr)
 {
@@ -754,6 +849,8 @@ static void mtk_image_set_header(void *ptr, struct stat *sbuf, int ifd,
 
 	if (hdr_media == BRLYT_TYPE_NAND || hdr_media == BRLYT_TYPE_SNAND)
 		mtk_image_set_nand_header(ptr, sbuf->st_size, params->addr);
+	else if (hdr_media == BRLYT_TYPE_UFS)
+		mtk_image_set_ufs_header(ptr, sbuf->st_size, params->addr);
 	else
 		mtk_image_set_gen_header(ptr, sbuf->st_size, params->addr);
 }
diff --git a/tools/mtk_image.h b/tools/mtk_image.h
index 54a838de863..8b4a601aec6 100644
--- a/tools/mtk_image.h
+++ b/tools/mtk_image.h
@@ -11,7 +11,7 @@
 
 /* Device header definitions, all fields are little-endian */
 
-/* Header for NOR/SD/eMMC */
+/* Header for NOR/SD/eMMC/UFS */
 union gen_boot_header {
 	struct {
 		char name[12];
@@ -25,6 +25,7 @@ union gen_boot_header {
 #define EMMC_BOOT_NAME		"EMMC_BOOT"
 #define SF_BOOT_NAME		"SF_BOOT"
 #define SDMMC_BOOT_NAME		"SDMMC_BOOT"
+#define UFS_BOOT_NAME		"UFS_BOOT"
 
 /* BootROM layout header */
 struct brom_layout_header {
@@ -48,7 +49,8 @@ enum brlyt_img_type {
 	BRLYT_TYPE_EMMC = 0x10005,
 	BRLYT_TYPE_NOR = 0x10007,
 	BRLYT_TYPE_SDMMC = 0x10008,
-	BRLYT_TYPE_SNAND = 0x10009
+	BRLYT_TYPE_SNAND = 0x10009,
+	BRLYT_TYPE_UFS = 0x1000c
 };
 
 /* Combined device header for NOR/SD/eMMC */
@@ -61,6 +63,16 @@ struct gen_device_header {
 	};
 };
 
+/* Device header for UFS */
+struct ufs_device_header {
+	union gen_boot_header boot;
+
+	union {
+		struct brom_layout_header brlyt;
+		uint8_t brlyt_pad[0xE00];
+	};
+};
+
 /* BootROM header definitions */
 struct gfh_common_header {
 	uint32_t magic_version;

-- 
2.53.0

