Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8D606A31F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EUNfYpyk;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hvBF93OA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34A58409A3;
	Thu, 22 Oct 2026 09:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcWzjcEASUY5; Thu, 22 Oct 2026 09:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 576F5409AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661197;
	b=sIuVdcjQ3BiKAMZHDX2ELMeK4bs1De6vM3U0TkiCY9PL0F/rQO2ADVl/fCbGbZhHyfdA
	 werDfm5OMQsac8rXyw3aZeSSRjyuxJRNN9N1uOnqwU65WZMVMsEdlcYTdmUdm7pu8Hdql
	 7YeK2nhcwar3toJOTt6FYyhzZSvle3ni2kbHWbNRzlWVWrIOmkUIaWahmVN5TF37bs3Rm
	 TsIKtvNvhmF2xm9troz22m3NFNIOEcAq1JJ8bf5+O4zxIF7bxieKlUZ8fGcWNYITsNv1Y
	 90NPb/ygc/KmRbp0z2bqKTulHs6RPjNGV/SNMIVuTYv8bShyJX7c3+/VgRabSw/iRhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
	b=dN4QFGiGmo7nRGm8mfK4QcLTy5H0CaZ00TY6vqqqQwS11ZDour04ghjmEevZ3hL+w9Ca
	 UOOTeGevUG5khQMbsB/gupte9L2rBr/QgRTvzRtG4DPWkyIPMEcWRBAQbDX8Pen1Z5GHQ
	 FS/qVURB6rTKprpdSV9WhBw21IxN464ChXb7I3zFLZdeJ37I5k0+08zTWNp5ewrAF25oS
	 QOSiHdYFzsk/KCxZQykZQqDmHdlTGUFSKJEwiNiX5lcYCX+9sGoiL2+bo65s4JOmecnwN
	 c+lCB0LJBi2J9wO8e74gJ4sOBXQpyB81/QpZZSGXU3zYYOsHg5WIAVNYVGkwzFrGPvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661197;
	bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EUNfYpyksJyZKsewILK9k5t3X8NVURxlEszxAyqpAUOLWmu97KbEhki193ARTz0kx
	 z68z90zoDgBBPTiS2A94Sf9s8d6jpuYys8H9HhDLnf/5hbX8ds4Es5q/8bcygWJsee
	 1nzfUVEVPB4UpSFUxJIS2OUDWUG8jWG29W8ftA6fivXImBYFS9zvk1tDtEQxwag1V1
	 YGlh0zscT1ppIdYM8rsrz5xQ0Z5b/M3j3oyPd9tjIwVWfYNlPEWCOcjdgTtu/i02B6
	 UzoJGJksvNbCZ2tY1QmmgmMrQjvwHQK36Cvvf2XBzc8BBkIKB7k7ko6iEcW7x7iBIq
	 QWZfnFJTe223w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 576F5409AB;
	Thu, 22 Oct 2026 09:26:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF4813AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59E640050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkpLynpvFtyZ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B5C7401A4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661188;
 b=KeONtIv1YfFdhw+RIsRMgcqYoneG/UViToPODobjWd0qLFlsL6dm/wWAjBo+hLKY0kFq
 9lW8LB18nPvpRDkaMctLTO09jr9TwLKRTN3dYvIeihxkkX9Mii38zMF7BGVbIcvwtL0Ba
 6DwxWhyT+nZreucz4J4uI/Z/c1Q5k/qHleJvRSxiUvhIY5m5+m4IQzSybx3BPP6tmRRHv
 M44fl3f8+RSq79al5qrQyTOATQFYY4cxziHL7VtzZrP9WgDTNQZRzGMLWRDBfX0BKB/QM
 iq2EsiufAxc0n57ZslyNgdIAdOX5fhkKFwLjDL9+oVBSF7DYMs34A50HRx4JSOyfu/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661188;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=fNNV/T/232axmN9fvnA5r5JaFr64TegCct0UJsVZkrPKJVWXgZ2Vc4ra2Cijy0iRY/iv
 1BDFpEMZZzHgrzhgVJYf0DanH0VJScNdilhFLQqzehWg4iXgxpHNTj+mnrHIsJmKmpBfm
 k/rnBVXmzmeROPQZ7J7ajEgBhBGrScsuidhf+ZgZVDgicSbYQi1eWh72NkVjKigoSFsis
 A9XrEy6EoqKeMt+vPAXoWNMI2/IGFUjwfkS2tBTB2479NPKs767VUJwmyh+w9266otqcC
 ulE7PaCV4RWdbI3kOhaqbRo54rpIGwpNQXqNZnbvGXU+VeVUTj2B5il76lTBIqfbi1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hvBF93OA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hvBF93OA
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B5C7401A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so12603905e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792661186; x=1793265986;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=hvBF93OAfrJLiTN6F9th5xF5vLSPEga/mGtMw9vlvWXEbOaExqegeMLornSDjGRPnf
 BGk/b/eA8fSwoYo4SRwHQw9aSrLfwp5hXp25m+NuhlheDBL5HCxdV4tDX/P787dYjD3q
 Ky1ANkIxP0Mw3OLpFQTqOhE84BBaUe8i+BOc2N6PRJosi0IPgGYHiu9ohq8zwv3GE8sK
 Lj4bo66HoPxxyaV/rVejpzP7rsAv5pQpuWs3OTvQ3cu+tjvt0AK7XrmWm1+NzmDn3p5S
 aKu/DepoGZOjJEMT5iV/q/oPvYUi37XpqcYOGNhKAiWbVjXoIQpkx8XnIykNDJ3YDK5V
 OFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661186; x=1793265986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GhQX/ZUomR8lynK0GlwnI9XtHthN1NM2U9r+zAFaBhc=;
 b=BHED1UBDcQjT0XF7FSpwZLzIhrH5vY6mwLxbNXtrDIfegAhu7ssX4HR7YtPZDBrFfe
 Ly1avL4mwS9OSslXDBoVXyNBK3znkI1xXfWKplOX+bAA7G54QQ2sAYi156oOKeThyM2R
 GolSCOcBvEHBzHTGIdYlTx1dxhT9beGzPZ4HeZGaaLs9GG1DxcJUCLf8dNeG4E5Uixnk
 C4+G6tcJ1KC/kmUkjdo4/Hpf5YHMxLgaVYts1AHBqo+e6TbSGjTehUBTCSRi7J+Ew/nU
 B1w2j7QTVjP7IokOqGbDWdAv1TrRmjxP28ZuSQeeU6QV3bIFNTrKc6i08481fGh0Gh8U
 C6mw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuUidyWQ4cAIuqxj3yo+W4Cs1R2tHlIoKnLbP0d2jTeF7At4kn+bNj/hnCncfcCfVwfgOAxOg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJaYtfN9Bgl8mR7U2Mx9p7L0qGUEqlnBW3ci/uGtTniv3GxnxtH
 AuG7a0rOfhCjgRol8N5tp5OkM1cgkbKgUlVQG1SaPckKPQo/TlVa6oVrc6Lw5B6XhAw=
X-Gm-Gg: AYBFou3QtuxUCKMlRC38GHKT7kONH5jHf1QyliY6uuBzfL0iMiQOAXneaP+G5ovgHW4
 AXyUR0718Cks28q2wrAOotFRqtGnziZzwJrTS8IHUz1w3zP4SMpqcly66XqNMP+7YDqqSoApDYw
 jT0z9XlmrNpOwZncKPJwrCXEbzV2c4J6t5kMkKTWssMgCaOkLMsMKnmW07JU9QOcNxzNtYqhvyK
 BZN+WlKMpG7Dxpx77f6A1T40GfrUj0aWMRZsbCD5vIif4T1ErTXlVejbZSQOy5qswEpjLuLEV2f
 nh9fwRVcBsRtqP2bRa9XeDw9PYUKerD1UqDGb2YxlaRNVeD0btmukVpzfNktuehxcHvSBd1K+sC
 bIGp88burjfjyxMc6wcIRfteVNXcf+12zDE2RTihHVKusaJuN+2/XEA+XnqHN6rJTXbVJEbJNsp
 hItynyjNjEA1fDWBgUxHMNQWL3Z39FWskKd94cbkdKLy1UNboS0H2lLQHVnV0/kAW+MHQXdNob7
 9hjYKV5PeJtIDXBDpKE+qNTkTKxVybJnPlZH1qtQdmy2LUYlKzw8Rg37CJ7DtRC1ZkZaBjf/1gS
 qfOvZJHes5GV5u7/LR5XYiLDkqtyWuMAB/JFfTjupqIbRfNBLlgS/qJk6uY+Aec2N2BoAA==
X-Received: by 2002:a05:600d:864b:20b0:4a2:1e1:d55 with SMTP id
 5b1f17b1804b1-4a201e10debmr51724895e9.28.1792661185932; 
 Thu, 22 Oct 2026 02:26:25 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583522esm11426793f8f.35.2026.10.22.02.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:26:25 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 11:26:17 +0200
Subject: [PATCH v5 3/4] doc: board: mediatek: document Genio download
 agents
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-mt8390-da-v5-3-58982fe11312@baylibre.com>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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

Download agents have different firmware and eMMC provisioning
requirements from normal storage boot. Document them so users can build
compatible images and understand which persistent eMMC settings each
agent changes.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/board/mediatek/mt8188-genio-evk.rst | 135 ++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index e36e8faeb48..6c7cf02ec22 100644
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
+* ``CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT`` runs fastboot directly in
+  SPL. This keeps the provisioning agent small and independent of BL31,
+  OP-TEE and U-Boot proper. It needs the matching external DDR loader.
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT`` uses SPL to load BL31 and
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

