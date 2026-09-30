Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9489CA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7859980ED9;
	Wed, 30 Sep 2026 12:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MlG0eS5ub2gM; Wed, 30 Sep 2026 12:52:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7811480E55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790772744;
	b=Jg1dGkja5R1DIqawhJBan/pwnsqcTI3huyEUdnKBmrcSzzhJJod5xJ5HREe/YUiYdXud
	 sgPcZ4goTOIqsDAgVPAVP9DD7ldBT2Se1ikHcKcysmkKjhX1iX6XJ41MSB9c2ThNBhzR7
	 cjNT8u3xshAtl5xD2BYp3N4oYyKPPacDKz1sm81VVBkcGm2xcEeW+EgeKsB5dwm+OMEn6
	 VniB1gH5iJIHHDnbyIKgFgKHFt0ytgro/00cfJqam5W0PvAnxPEhTOnb9jtvu01hltfmN
	 1MyRD614SVwGazWn+54V5c/cdeoXwmXHAXFx7uRT6sb79GnVNFQJPmkWVuYjVnS+VOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790772744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FtbG2gi7bsbTIjoD5anpuJfZDbwAFf8W27ttn7+3BO8=;
	b=ksJmzPXBPliMb+TBAZW7AaUTTRmupc/Y6DFSxvJsKOe5lfNGv2h+omHd0FewjaUQHqqX
	 8Tc0jcAtiFf+id3PyHkmTFCnW52cNEwTDEDtk8TOfQ/onj7IEJN7MZrnv7EB8U66Thq0n
	 nCtsZnvHctd0d0WAGQozpDij2upqlzS47U4YpYTto4YwCUHJBdm/n+SHEKf7OPTsNdBS0
	 K7hFZe+Rvr07UUWyZLwP3ePsXdpHVbAP8IpPRq+2EW6LKfVwN+8zlmut+XZzNpWMEQV0p
	 qdaWvcIB7SaI3VdHVfCe9mP1JUKKWOdiM21+Y7Snft0Z/g1Nvl/PXjg5uREbacpiSQA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790772744;
	bh=FtbG2gi7bsbTIjoD5anpuJfZDbwAFf8W27ttn7+3BO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w3Cmo8kXOU8dp6LjHNw7PAG7xjnTvb8B9w6gOLUGm3OxTS49tPzpq7Launwae3ceP
	 AwZ/AMRTuhBBSrxipNTmSM9l/WapRKwIrBN+XEnIwrs3nzxZIY5ZhzrrfucRr7wFDr
	 4613bIkt4gqTu8pFJo5kg84x55SG/0jERp6NtMT4ZFiSjpe1bzkoGrXsss6DwUKj0z
	 LNxMkGV7VoDzufMCwRZW3MUa5p6MNfY63gK4faBQt3ov7Ea1z05hYWZCPMcWXnFV1S
	 C1PpqcQKyTej153fqYNKNHBCLxk13VtftJ333YWUmiYemErNFTlweRthAyqOr7lmRV
	 hvwJh/xy7soRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7811480E55;
	Wed, 30 Sep 2026 12:52:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5438934E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A29140A6C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RrXVF0B0owm3 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 01A2240A72
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790772735;
 b=eeelZoCzn4pfWsnRq0BH+3IJo+dAc2qziTP3BWBVdm4Ydt6kYqpTz2xZ3XqlaNpUqZDS
 z8acXGO2yEGOHQMKLPSt30MfNV8ERfsV8EWsnYI1c2WUs+W9xwICQ1FoeJugrGZt08yhm
 GoP2bgw5G/uvyY0XKB3Jd+kbxoPdWCEwXvoVfVNHB4lUxlYHy9S3iNtilg3rWL2G6m7Zb
 oAnN8TXbeocfRZDpzcvxLQFSh6skvZ86BX9XuafMacWzwhc8wxWR6VeIiO7MCWtZJEysm
 kPQtdZ09rrTE/LlhFJ0SoI7P4PfvRv8+z/WO/cgaY2MFDY5e5rxijhQLDMvSSjwZJtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790772735;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=FtbG2gi7bsbTIjoD5anpuJfZDbwAFf8W27ttn7+3BO8=;
 b=lwb6D+IDnPTrnqaPltyzSEJPQTnRbYOkTsSW1ODwyGUcfp1BevWjk82u6aE+9P2nMoW7
 232c9BgRr04GjCmIUm0oM6wBWkD6crcS3tMR7y3Eo0W+sVS5+tCc/ypG+oXNa1u91spcz
 sH/kxMI+ywBeesZwwp9SjH9KItLwsdwiZMmMaHNuilMe9xpijqx6QgUJNHq9uVv4M93Nx
 168di1sOHGH67LGtZWIKF+p5kQOnjs0xR4dNVpRJ3zstRLLMt5+Ir0LAIvu6h/n6V1cGk
 +Pu8pzW78zg7XZeq8hyse/K3ivD1fFZauR0uGQot494btd339WUiJZUP05MbJJk/0Nw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="JY9/5vK/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JY9/5vK/
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01A2240A72
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:52:14 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso40482035e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790772733; x=1791377533;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FtbG2gi7bsbTIjoD5anpuJfZDbwAFf8W27ttn7+3BO8=;
 b=JY9/5vK/owv8MzYgVs3wenhHS+w0gM/SwZHiGK3GxliD4EJjQGnxluSz1gakJ5Zp2q
 xwbQn/NeHwtP/u+jqrMmz0rY4j7WdWSwGrMFKwbeLCBHOCA7ggjPuphGYU5dVyPBRC3B
 ZrBq0IZozgp80f9WHlSLQeD2gBNlMqsZ6wS3Y/26wFvGYAxsXeGYu9ufQKTS0Dq8JmVf
 E55jAsx7EmHHNDqUnDd11UEU3//ZGc2tCOqw8os2z4pDmx6dP9P1HdFZ2T6bsSkZnuFi
 9NM/3oSE7NM4HrTMeUmfSwk6XQ3B9zUlq5h1QtdWitPlSzKOClyznuXp4C1DanGVF7bt
 R3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772733; x=1791377533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FtbG2gi7bsbTIjoD5anpuJfZDbwAFf8W27ttn7+3BO8=;
 b=Uu3uJGFQD58QbUu86PokS76zVpfU7y8Us219ZMRS0hDoca/DM2Er/d9//qpABNL+30
 h8fv2vTzWElGUJWwiJipiiXaEwz3dKaXnYlVX3iXCp0gt4PkWeXY7RKiYaGmdYirI9vR
 Iw7VXUgWcGe5duNmV8M8SEZKHABai2YkLNXtIOnodwFpmbcO66fT/679LSf/uXgMjRHE
 XprUzxHIRJAFHu6leNzPBN/IhwzUnr9TAdpP/mEU0NPhfcod80tQJ0JHbgl6tIzcfzJ1
 mrk+BJfgIssx+tcCVnQCFfQaIGCrLQ8h1SG8tSjn9Ot/Uh1xMDicyJbrKhv3EBHdMFn3
 WXSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPb6qNkyN45kyxn4mOSmsFTTteZaTHDlqKmSHTezJDbsGfmUJm+sR7ZAxIPndHVkZ5TAQt7dg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kFJRRHuC2QCx12iGbsDFaKzauk2xPiGy5QlzC+Ajn1tW/5sbOI
 006B0ZHAWnSrceZ6sMGqVtU5IejkQTWP2+Zn0hVO5HlfMY5DnUARmw4Fd48tkaG7EhU=
X-Gm-Gg: AYBFou2TDib/potawbuSAQP0rBmWrFQfmcdlwh+4WE+iE0LpgpFldm/Co+4FzS6HDud
 ghG0srW3qFL1RcQGSjVDSvx8U/RvZbuUQBJhQawNZLo0RqfYlGDH1xTwemcyesZ5NG9zhvNSuC8
 agHQkTavSxZYAB5A1wW1pmQHFbgcrGweiEXlUBjvofVJkIT9Er09nmXagGQrztVqh7PQ2XDFPLC
 jo0h07V2D1EdzuEV5CQ2tjREs7Mhqth6XCyD7++Zz0qkyUuYE+58f5jtp8u2P86bt9GbfnyHeu5
 j+1FKCz0najlZ/T4oBmEol2e3iSQpf6pEGSA4X0obASSyuPCi3VtR4MCcDQrvykXS03qpe1ekOv
 ewcvg93s8Hs1vxzK5xX6iEX8Mf4NGKzgODyOI3g/qzAtzy9SqVhUT5p7D6BrbhVqQhXlGjxlCIY
 dO68OKjgIDt4s3Nxm5k7c0Lb7jato7fUJZ5c8lln+aDTbnbc2PaA6nEpTuNDCOxz1+seIiDS3bp
 ZaC1h74GG7vY8iDTroaNSmvwzBQNC5zOzOOQ7qhoS83aH9+j97spKOsE/MOLDWHRhKy69IpOqUY
 86wZSUAP7zLOIlRsQO98IPg=
X-Received: by 2002:a05:600c:4e41:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a01ad8effbmr24188875e9.2.1790772732555; 
 Wed, 30 Sep 2026 05:52:12 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm9928905e9.0.2026.09.30.05.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:52:12 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 30 Sep 2026 14:51:36 +0200
Subject: [PATCH v3 4/4] doc: board: mediatek: document Genio download
 agents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ccaione-upstream-mt8390-da-v3-4-ae6091c7eda0@baylibre.com>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
In-Reply-To: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
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
index e36e8faeb48..f8e9685fc87 100644
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
+Both agents prepare the eMMC boot partition and bus settings, so a newly
+flashed board can boot without additional host commands. They also
+permanently enable the hardware reset pin if its policy is still
+unconfigured.

-- 
2.56.0

