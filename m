Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E167EC98311
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A06CC40ED8;
	Wed, 23 Sep 2026 21:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJBr44FyGfvy; Wed, 23 Sep 2026 21:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 685A340F50
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790198305;
	b=MLv0RhS7KzOtk7r62lcLbHScDW/7GirS5cidqKSCS63XzKepJJMQBynsYft6kWV8TUmV
	 bvP1AUWRoVRg+3ySberEzOWL8+ae7CRZVfrX8Qb8DdDSkTK8/tM0IDx3GL3inE1dWEbRU
	 Dgk70TyCyVZhVxNAaFN6HGpFU8SSFV5b2hP6jdKcEotAEqGVBtbd+JeRPq5kEWsYKM40V
	 sWH1Es8m2WnIH1eOd8WldQAPN8uPozXUjtXn0d0Nj+42wR+V9cPF7tdBjk+t9Q/iixuCp
	 22FoVSUQ2uxwVculqaRH8kNfPapqs8KGW2AbOIwJvzwTo6hul2D9GozxP1BZkSOrGOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790198305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4zTr2gJk0BfP1/JmtMEqM0mgvcvPn3wp1XjZkXD7gJ0=;
	b=Q4602AxBj3F+FgmYidEG+JTnuN71fU4dnC4XBIemnQgsVCMCgbkm4/P+WWPBYvC+jTCD
	 IfswNs7Rw/mmTz7A3BVWz0w6f2Xgf+kBJ44OBi5jYjtLLIwoUHKlQS6c0nKkLHtBD8xeP
	 BS+rs2kqk1ZCvPmJT0gMizBEQgZfByMaYNwyRt6GZsUeyll6PaqDPKx41k5Y4FAhodiR0
	 IDHDmeDCRnWQ36aG3J+AYxmJM9e1H23EilQW1u8XVrBfHpKLVtORfsVUBfpFuyhgxIBN4
	 hQ1mKWjGSZEkrmZLtG7MRwAtxzviNAmw+oR6vX64Ngvz+Xhuoe0M70r2OTssGLsJaLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FcueNGHG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790198305;
	bh=4zTr2gJk0BfP1/JmtMEqM0mgvcvPn3wp1XjZkXD7gJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Pmgh3TcGUbsPrG0MFYhVfamEF0bkYDzxp4+hHXB3Fk3KBflGDnP0meZoy5j5rXWh
	 iRAuXgRruDjK/I+PkFshOCK+dqO4VNCO87v82Ol0oxLx47L6ENxR0z4bZW4JW+ujWX
	 TQ9Nq6Fk9ebr1ltb7NPXjRpkwF31+tbl7KMihHWKhpIc6MJns9SbLgKy69DVLApPOt
	 +hgt31T/qZmdTpWgwu00yexk/fDk35BCfhOFHpRHn9BhKdRSgIWJ3JVzd2ZTOX9Z+l
	 lE6pY90APhhmD5+PECxqONnjwEJfUE/hsIPJ1N7P48h3fcyEz8Fq/UYh6Oxz4G0DWi
	 vp7AO4+T/OR4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 685A340F50;
	Wed, 23 Sep 2026 21:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9694828C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB09F40EED
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmyqh-msI7Pu for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8224740ED8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::12"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790198299;
 b=Y6PrN69KDrJSrsbWjZpiANwi3uzAezq+uT//ikK9vNXdRVa3kHUmSw3e+v3lOttBhRE+
 tJT6KA5nYyl2WNJ1Ze4d7RTUSBm8kME9TBUTNrM9HnUkbHr/BgW/kL7QzwwfdJdoSrUKn
 Fq0Uguy78pmBVYrnAll8wbExuuMc8GUunEtCNSaRI0fHzuL5vvglADNXZYGe1fplxtphc
 if3eM9fcar+xmB5Su6kljMzUz6Ssy4gdSQo9mJlMvS3xCsAIptple+j4IPkxqB0dPPoMi
 xjtCH5xLKoRmov0fb34g1qyPsROhydFA2e+nBFm5pQ70sTT0wYZqQeQER21oFE1iW/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790198299;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=4zTr2gJk0BfP1/JmtMEqM0mgvcvPn3wp1XjZkXD7gJ0=;
 b=as93jojYGN3CJ7YhRXht2k6drYe0hV9qKMXYOq4LeQXjGo1p5QN3o8Y/ad6FkgdVNSdl
 BMJGZN0okmJooR7ZLKlEn52CiQ+HuqEbxlrUn9S9bC2tsvQaK3wKRxjMXluAF/M3V70ic
 1DR0zJB5wXB+J1aFjwOJxwNb7YB9cIc996+7nlRfOOjEBh8skVf6ArTtWmqLTCMARWPuW
 gOWAoSKGO6eRkC/yfbnotiKKNXRKrCW4aeMjvZqW2q47Dtq/ubJ0o5x5u58WeiIQT+K0v
 i427zZno51bVoscrOH6AmHX3O4yVqLMEy/LU2D/C9rRRaBxjMvG4XhGyR0xXt8CFrdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FcueNGHG; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::12"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::12; helo=mail-wr2-x12.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FcueNGHG
Received: from mail-wr2-x12.google.com (mail-wr2-x12.google.com
 [IPv6:2a00:1450:4864:30::12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8224740ED8
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:18:18 +0000 (UTC)
Received: by mail-wr2-x12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso1133602f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790198296; x=1790803096;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4zTr2gJk0BfP1/JmtMEqM0mgvcvPn3wp1XjZkXD7gJ0=;
 b=FcueNGHG3WyuefXGDDQg/qGXzgfzpgwuohkF2Av7FEFYibHy6lqXzIMP7bkm+tBSlg
 AFdfILApMiTpz0EC615duolvrrT6+8MlQlUaooiePqdFxCQnZTXm6vfMSHgLNmUoo0iJ
 o2N4fPr5sKk7XakEd+KPR6EuKb5hVHYishNIWTFSm5ur7Vg8i5cR20G/7iiNtDYtIUNN
 yGBxDsAExB8TljLLDnIPSN2zYJmbvvu7Vj643froT/3hvS5uVLq/0XbjoVZgfh7v3dW0
 FpxhBcsdWpVlATvCV8hHGOKeR90aT8QZ5JHlFc5N4WWwGfgjVhgbmOvULKjQSEdKOw/2
 dY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198296; x=1790803096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zTr2gJk0BfP1/JmtMEqM0mgvcvPn3wp1XjZkXD7gJ0=;
 b=CyWMe8he6BEE1DFG6E6kFsideOrjPqjzrmYQl6CCsK3Aka23cWWq7r3NHS6D7C/+Py
 zjKODUUp/a8B2f5O8FGCKR5SPQfD0UWeDZAaGqcC8HqSnTpXYvZ+JqmeUjsyYHDck7Lz
 hshN7BQjrUeilkZ9VOYVFxC2HygT5Db0GZorMXuYbP0ijLhvxftc+Zt5Z4P8OeguF8j1
 j3YDm1/IARqPB2LIl8OVd3ANsqG3Bhi05XvV29RVQQov+yKMjHSpuIC5ORic2XLhXcrC
 655b7+hnG9mwYaN6QQFj5LUW8FbPRHQnsr8B1iXyofJICGZMA6FMfJAYhRltBGDgYBNZ
 TVow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCQkmITxUrCoD9eC6lGVgwB+S7UzqBXN8SRPGavmi7hanp7HAh/w63Zv9bkVcbculhSVM+/O0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mRKfyJVYmnGHnDxTmOwMdS21H7Z+Euz9O9j9SJxLMd6pvdNNxQ
 EMjZQ/WHTJxZ2yzPoIFgjcwXat4l6nDPZbOgzwC8vo+tWet6G0GMMmVg0/eVrICVGZs=
X-Gm-Gg: AYBFou0sORW3/G5feVxFqAnECTjh6Kh+qZVW8QNw4NF/IcBMke/1zxldlO5wF7hCSW3
 ARJ90+k0T0rcfsq7RJjOLHf6ut9EgUu13atQv8OSCM1FpLIrpMO8kTN4rkz3XylwRbMMhJ951uR
 bZnTsVKN4D/sKxnr4rnwTwp4xMQxtjOMB6fBFmytqNFnHElELyV26maVp+Le7tfNcsKfpSAvF0T
 0q+4ugjA8FVzLz1qHBzS8IFhZrW2iUPcvB4g167jW1oGlzU2UHfFMeUJ2GAsgzJO8V9vNc7QU6s
 C/TjwKHlqgNh6FHaDY7PF/SAvFN1O9Xvf6InJrzhgOcdHqpBGUYETziguIFcdb8jZb8hhWLgX20
 FMTex78FkjK9rW2mG3ghwMmQgcJRbPS9zSGnenTW0eVrnq8eV/hYu/l+VPGkdTm//iZHZq216Oz
 7SeepKjsxJGhdmKQZSYNBU6AG9EWH650KtMuUwFPoYCi3tytYksgZ4p6mMN2E6pzbfLL7bgFObm
 qs0BtKIE74CQZDmRAGdpdCzf8fHynUTA0xP59xBBOJ0ZazDz8ccZz1EtOnveU8=
X-Received: by 2002:a05:6000:2003:b0:487:27f9:833 with SMTP id
 ffacd0b85a97d-488717080a5mr701925f8f.40.1790198296293; 
 Wed, 23 Sep 2026 14:18:16 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm8684345f8f.22.2026.09.23.14.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:18:15 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 23 Sep 2026 23:17:44 +0200
Subject: [PATCH v2 3/3] doc: board: mediatek: document Genio download
 agents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ccaione-upstream-mt8390-da-v2-3-8f264678ac29@baylibre.com>
References: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
In-Reply-To: <20260923-ccaione-upstream-mt8390-da-v2-0-8f264678ac29@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Carlo Caione <ccaione@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.16.0
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

Download agents have different firmware and eMMC provisioning
requirements from normal storage boot. Document them so users can build
compatible images and understand which persistent eMMC settings each
agent changes.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/board/mediatek/mt8188-genio-evk.rst | 135 ++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index e36e8faeb48..70d9b8b84b3 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -279,3 +279,138 @@ Genio Tools uses the default bootstrap from the image directory. Keep
 ``bootloaders_b`` unchanged until the new images have been tested. Add
 ``--dry-run`` to check the selected files and partitions without accessing the
 board.
+
+BootROM download agents
+-----------------------
+
+A download agent (DA) runs from RAM and exposes eMMC through USB fastboot for
+provisioning or recovery. The BootROM downloads ``da.bin`` into SRAM; the
+external DDR loader initializes DRAM and enters SPL using the same execution
+contract as normal boot. The DA itself is not installed in an eMMC partition.
+
+Prefer fastboot in U-Boot proper when the complete DA fits the platform's
+BootROM download limit. It provides U-Boot's shell and boot facilities in
+addition to flashing. The complete image must fit in the SRAM download area
+before the DDR loader can initialize DRAM. Fastboot in SPL offers a smaller
+executable payload for configurations where including BL31 and U-Boot proper
+would exceed that limit. Both variants run fastboot from DRAM.
+
+Two mutually exclusive modes are available:
+
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT`` runs fastboot directly in
+  SPL. This keeps the provisioning agent small and independent of BL31,
+  OP-TEE and U-Boot proper. It needs the matching external DDR loader.
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT`` uses SPL to load BL31 and
+  U-Boot from a FIT in RAM. U-Boot then runs ``fastboot usb 0``. This mode needs
+  a matching BL31 built without an OP-TEE dependency, and a DDR loader which
+  implements the additional FIT copy described below. It provides
+  U-Boot's shell and boot facilities for provisioning flows which need
+  more than the SPL agent's flash and erase commands.
+
+The two paths start USB fastboot at different stages::
+
+   Fastboot in SPL                   Fastboot in U-Boot proper
+   ---------------                  -------------------------
+   BootROM USB download             BootROM USB download
+   (host -> SRAM)                   (host -> SRAM)
+     |                                |
+     v                                v
+   DDR loader                       DDR loader
+     | Initialize DRAM                | Initialize DRAM
+     | Copy SPL to DRAM               | Copy SPL + FIT to DRAM
+     v                                v
+   SPL                              SPL
+     | USB fastboot <-> host           | Load BL31 + U-Boot from RAM
+     v                                v
+   eMMC provisioning                BL31
+                                      |
+                                      v
+                                    U-Boot proper
+                                      | USB fastboot <-> host
+                                      v
+                                    eMMC provisioning
+
+Build download agents separately from normal boot images; do not enable
+``CONFIG_MTK_GENIO_BOOT_IMAGES`` in a DA configuration.
+
+For Genio 700, build the SPL fastboot mode with::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make O=build-da-spl mt8390_genio_700_evk_da_spl_defconfig
+   $ make O=build-da-spl BINMAN_INDIRS=/path/to/firmware
+
+For fastboot in U-Boot proper::
+
+   $ make O=build-da-uboot mt8390_genio_700_evk_da_uboot_defconfig
+   $ make O=build-da-uboot BL31=/path/to/da-bl31.bin \
+         BINMAN_INDIRS=/path/to/firmware
+
+Use the corresponding ``mt8370_genio_510_evk_da_spl_defconfig`` or
+``mt8370_genio_510_evk_da_uboot_defconfig`` for Genio 510. Each build produces
+``da.bin`` and ``da.map`` in its output directory. Use board- and mode-matched
+firmware inputs; do not set ``TEE`` for these builds.
+
+Image and loader contract
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The default ``da.bin`` layouts are shown below. Offsets are relative to the
+start of the image, and region sizes include padding::
+
+   Fastboot in SPL                     Fastboot in U-Boot proper
+
+   0x00000 +----------------------+   0x00000 +----------------------+
+           | DDR loader           |           | DDR loader           |
+           | 300 KiB              |           | 300 KiB              |
+   0x4b000 +----------------------+   0x4b000 +----------------------+
+           | SPL + USB fastboot   |           | SPL                  |
+           | 700 KiB              |           | 148 KiB              |
+           |                      |   0x70000 +----------------------+
+           |                      |           | FIT: BL31 + U-Boot   |
+           |                      |           | 572 KiB              |
+   0xfa000 +----------------------+   0xff000 +----------------------+
+
+Both DA modes use the shared ``mtk-genio-*-binman-u-boot.dtsi`` templates and
+``CONFIG_MTK_GENIO_IMAGE_CONTRACT`` settings. The image starts with the DDR
+loader padded to ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by SPL padded
+to ``CONFIG_SPL_MAX_SIZE``. The loader copies that SPL region to
+``CONFIG_SPL_TEXT_BASE`` before entering it. SPL fastboot reserves a 16 MiB
+heap, including space for the sparse writer's 8 MiB buffer.
+
+The full-U-Boot DA appends a FIT at ``CONFIG_MTK_GENIO_DA_FIT_OFFSET``, in a
+fixed region of ``CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE`` bytes. The external
+loader must copy this complete region to ``CONFIG_SPL_LOAD_FIT_ADDRESS``
+before entering SPL. Its ``DA_FIT_OFFSET`` and ``DA_FIT_SIZE`` must match the
+U-Boot settings. The FIT container is directly parseable; only its BL31 and
+U-Boot payloads are gzip-compressed. SPL decompresses them to
+``CONFIG_MTK_GENIO_BL31_LOAD_ADDR`` and ``CONFIG_TEXT_BASE`` respectively,
+then enters BL31, which starts U-Boot.
+
+The default padded images are 1000 KiB for the SPL DA and 1020 KiB for the
+U-Boot DA. The latter fits the Genio 700 BootROM download area. Selecting SPL
+alone does not remove the fixed padding; a tighter download budget also
+requires smaller reserved regions, with matching changes to the DDR loader.
+
+These fixed regions are part of the external loader ABI. Changing the image
+sizes or addresses requires corresponding loader changes. Binman rejects
+payloads which exceed their reserved regions. The generated DA is a raw
+payload for the platform download tooling; it has no eMMC BootROM wrapper.
+Its FIT hashes do not authenticate it. Platforms requiring authenticated
+DAs must use their external signing and BootROM download tooling.
+
+Using the download agent
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Select the generated agent with ``genio-flash --bootstrap /path/to/da.bin``.
+``genio-flash`` reboots the board after flashing.
+
+For manual fastboot sessions, use ``fastboot reboot`` to start the installed
+boot chain. ``fastboot continue`` boots firmware from eMMC with the SPL DA,
+or returns to the command prompt with the U-Boot DA, without resetting.
+
+Use raw images for ``mmc0boot0`` and ``mmc0boot1``. Android sparse images are
+supported for GPT partitions and the eMMC user-area alias.
+
+The SPL DA prepares eMMC boot settings and permanently enables the hardware
+reset pin if its policy is still unconfigured. The U-Boot DA does not perform
+this preparation; provisioning a blank eMMC with it requires configuring
+the boot settings separately.

-- 
2.55.0

