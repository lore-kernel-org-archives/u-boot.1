Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299D606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JEQsFKTc;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jyjgpTUN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3010640926;
	Thu,  5 Nov 2026 23:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lnc85wWPhV0J; Thu,  5 Nov 2026 23:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02F28408E6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922407;
	b=GSzHmG/kQt3j3NbrNAIpwwz9xxj5KEz++pi0RroJzhWrYk6tk6s96OaMSHI0HxzUMdkA
	 oegvIZy9oqGN+ZdDjwLzpj/K7U713Ca5430iTWgnSD72P5I0dDXKV5UWhaPTkmYjHL8/S
	 j4a3UunErunq9Wk/O2kfH3hO5fv1e/fR/bbic7e+gcE0tuwInDnvqWoxGnVc9VYSAnpzX
	 QZEAaZaH17WAMzj+WNc2rQes/I17Izk9fOVFaMxrcyybmOh8eLL1uUC/niJgvkcfdg8ZO
	 A4ANaubUji+2ZYMKN4H/39dWwYPtA3FMtS00d8FUr3RfaTO5vlF5vDCFwV+NtDlUaCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mSQd1RDsE8UCBSEAc2FLXtGOycpXKLijwjwAeEJyqak=;
	b=U7u/1Be/fosD1wbA210t05OmhLXnxZqfXY1/mhXZZ1J2JRGEGRWLf3H88yTGwurJJIoF
	 y9hzBhfMgYCNXPgJ1qq241uiiAo1nlHIBpOmEkWztprjWQAReHe0HfG44+hlEJfx3c1fD
	 iy83TmpACrlHoAJOD4EGVah8cUMrdfgv/n/sVwZtYATiNg0hE1QY9Zren+U850Z/4ffGB
	 APWqFCscBFLyK1/G8j+FbU5BiuwIkPonnDJ3vGf9x7IVHXGh1tEguFrLEJDwiNI7oKkMM
	 jM33p+vN6SMX0RCZ1+AopVFt5TsnfcPfadnOuabbYK1chtMnGoDxNldUepGaz9eizJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922407;
	bh=mSQd1RDsE8UCBSEAc2FLXtGOycpXKLijwjwAeEJyqak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEQsFKTca48WFDQAAMqUoA80A34PTRyCZEuktdoHMfW/qfgcs0GAdMv83sDBMN3Ya
	 hebcrpaLhG8FN3QZqGS4s7Qvkrps8mCCgRAyWMTYWh314eshVz5cbqlhD+jgOio4df
	 /dDcGZPbnPyyI3bL5ni78LLcXQ8YMJDdbeah0uaqXJKexegIwe1PhTHg1Sz/nA0d+M
	 01hEznaKey1angsVKLkecilQDp+PY9oW2LsWH8bGJwDnGGyGwc7JpNgiJOm6vLZJFi
	 XOqA8J4dwcl+1/+N+rn+wjYR+05pPyXAo5u4O23qUYrYRYB/4Oeq1YZWNQrnrarf3r
	 7Zfug480uq/mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02F28408E6;
	Thu,  5 Nov 2026 23:46:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3404B49B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A219811F3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6r-PNWlpman0 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 153BC811D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jyjgpTUN
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 153BC811D9
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:37 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-84e513877a3so97072a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922397; x=1794527197;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mSQd1RDsE8UCBSEAc2FLXtGOycpXKLijwjwAeEJyqak=;
 b=jyjgpTUNrgEUhtoDM7OKAzqxGNY8MzxIHHtX6pJxaYDK5sDSut4mrC6fDpfHKNPUCa
 GFpbz09ijr/gsCgT7+3i9xEz9/tVMVCfWHv//2HC463mTY/HkmzjuGjnvocPxCgCd09L
 iuwZ3NX67m7/KBvgTQ9yTaBibdOrgYw3QfONJoAiGq//ZW8npf5z236ytPPhPtzoV0pl
 Cesh2oIP6LqXAWh7n7zookLpjSku3FlBmHp4i/0gebx8qM/McjI/YClnmoJ1SjZDsQ0O
 EbCjo6VmIxlkn3zNQGVB/7qmYVX6LS8yQx6skiGUqnNgFh7Wt03+bnwu3bM5fJ1Hzp0s
 0DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922397; x=1794527197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSQd1RDsE8UCBSEAc2FLXtGOycpXKLijwjwAeEJyqak=;
 b=vUG3stvyqlETV4XmjBo7Rum74DaBxzGU+u5dAXDS/9L/6Uxb3SO138AGAMPiyYSW1D
 vnDCjrJiBPeGaE5bLUPpRHRQnNjA2LF/xODW6nuJi2iKsOnB4U9o6SQaW1CXaDH+bE/8
 fdSDMleIXLPuixOVsENLWzX0GK7Rvazf+/eb1Ys8+wTFtog7gT7J1jTKpqY50h9umxcU
 Yra8uYXW7wdR5buklZ/57dY7nO2ayym2EtZiCHroTd/5xtb0mL6nbhKQ2+BcG3gQgLyZ
 8OnC9UBrFWxINLuY5iZfn0UfpC+krBFWj12/zhyYV4AO9vyJ55Q2QybOcC0b4uShDXAL
 OnUQ==
X-Gm-Message-State: APuU4Z+6+pbqepYyw9DBUyWAUWEI/8AM9bFpQ2sMPv0fakWL/N+E2p9X
 L5y6Wg1yIxLiEejMuTzXwugtNZS2V4plIGB1iYDTilifLlTGBhV4+FvRdtYy49XlCtU=
X-Gm-Gg: AYBFou0Zy/kVWDYSwePafcdq3vkTvTRra7Nm6yFPvzb7ox8UN15UvpByxq0vK205cs8
 dlpnDmmrXhcpPYA0LJogTof0Ecj4r58qCnQMdM+dM4yGraxeTBt91ULIZ9cLAin435b8DMaRBsD
 6G9tCbxDHI+1HBgrrKVYINBDITBNcCgV+3hjY9vMKCFtHpE15cWUGBf77qA7rZxu3/it0DaEj+n
 zf7qEqTrdRGhluSXpwCLkIhp/UuKOmrc+9HimNtZu02EO4lqpfH47KSk60uxBbN2uuJ9Dhltpl4
 ZP25Ybx2lAFnVbsVpG+9MSo7v9z21t7j1oSMlYi6HopL7N5N5p68Q0N+Z2C0yKxc5/ynK/UsEto
 8APxZtsd6WSpmUDKS9wON9Q5Y6zCcFFWoYS8lxQZ9GtOkrNNMEvKrms5BlEK/Vjd88CUmixnJ5+
 4hKQa7by+3e7dMadPv4XRqI9WbbY256M6K1Z3cuunmIp8BOv8BTypziMi+gSWz20DRW3L3NRyNt
 aLYfVHOIxiD/gEjzBZacAnjmk8dFEVQzh3SFKnIH9IW767b083d2WwolENPvuihIr8g612KH6XD
 ywILuetlcF+L/OpJG2HZUKiHS3HYZdVTFkzIaY6WFlvg+wbgioCfNwQ=
X-Received: by 2002:a05:6830:3d8f:b0:855:4d49:10aa with SMTP id
 46e09a7af769-85f0592af2cmr2644115a34.24.1793922396744; 
 Thu, 05 Nov 2026 15:46:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:30 -0600
Subject: [PATCH v2 8/8] doc: board: mediatek: describe the Genio 520 and
 720 DRAM handoff
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-8-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5594; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=uIlqgFKEYj6radQJXOxYuT5dbRpeES/bvHW0+Cp1wMY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RVLLccvATtq25wvWsvFAjwwQnQuwmHPCif0n
 JOyBKNUY5+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VSxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ax5cH/RO1sF1SE0ZDMIaaKAcCVXZAdqSoiLogeLiBYGz
 m61DaPApenIwtpTU24mEqvPal6rbwCiqe6r2xIupgGd01OANkAPhsam6DZwq7XVW+MDH8R2uvYG
 4KCPW90xUobNeHidCuy3+cp9RjBkmWCLkVLGOVUQKYqXN7lbsrbg/wv53TWVpoVLEIQE2KLjz4q
 DzdECWuQrNBPXC4wxBzUjhreQ4rWVL5AujZRb5J/j4xWRJyM0zFKVUVDVDN1O0UcVulwgjITahL
 24jJ8BlWwkW3AVJy4QEKhL2hY9akSvULlDbIoiQDVBoljqoRKMez1gSFfDeMZJDiXu1zuU4vOzd
 bza8=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe how the DDR loader passes the DRAM description to U-Boot in a
transfer list, and add the transfer list to the DDR-loader handoff
contract.

Also state that U-Boot proper started by the platform BL2 now needs a
transfer list with its devicetree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8189-genio-evk.rst | 79 ++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index 184085b83c1..637aa21e271 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -35,8 +35,11 @@ In the usual boot chain, U-Boot provides only U-Boot proper::
      -> U-Boot proper (BL33)
 
 The platform BL2 initializes DRAM and loads BL31, BL32 and BL33. U-Boot proper
-is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``. It takes the DRAM size from
-the ``memory`` node of its devicetree, which describes 8 GiB of DRAM.
+is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``.
+
+U-Boot proper requires a transfer list containing its devicetree, and does not
+start without one. The platform BL2 must therefore pass such a transfer list
+to BL33, together with the DRAM description described in `DRAM description`_.
 
 Building
 ~~~~~~~~
@@ -96,12 +99,71 @@ by name.
 Make sure the DIP switches and jumpers are set for eMMC, and use the default
 devicetree.
 
+DRAM description
+~~~~~~~~~~~~~~~~
+
+The DRAM size depends on the DRAM fitted to the board, and so do the regions
+which DRAM initialization reserves for use by the hardware, such as the DRAM
+controller's tracking buffers at the top of each rank. The devicetree built
+into U-Boot cannot describe them, so the DDR loader describes them in a
+devicetree overlay. It passes the overlay to SPL in a `Firmware Handoff`_
+transfer list, which U-Boot reads as its bloblist (see
+:doc:`/develop/bloblist`).
+
+The overlay contains a ``memory`` node with the DRAM size and a ``no-map``
+``reserved-memory`` node for each reserved region. The first compatible string
+of its root node must match the one of the U-Boot devicetree. For example, on
+a Genio 720 EVK with 8 GiB of DRAM::
+
+   /dts-v1/;
+   /plugin/;
+
+   / {
+           compatible = "mediatek,mt8391-evk";
+   };
+
+   &{/} {
+           reserved-memory {
+                   #address-cells = <2>;
+                   #size-cells = <2>;
+                   ranges;
+
+                   dramc-rk0@13fffe000 {
+                           reg = <0x1 0x3fffe000 0x0 0x2000>;
+                           no-map;
+                   };
+
+                   dramc-rk1@23fffe000 {
+                           reg = <0x2 0x3fffe000 0x0 0x2000>;
+                           no-map;
+                   };
+           };
+
+           memory@40000000 {
+                   device_type = "memory";
+                   reg = <0x0 0x40000000 0x2 0x0>;
+           };
+   };
+
+SPL adds the devicetree of U-Boot proper from the FIT to the transfer list and
+passes the list on to U-Boot proper, through the BL33 entry point arguments
+that it gives to BL31. U-Boot proper takes its devicetree from the transfer
+list, applies the overlay to it and passes the reserved regions on to the OS.
+If the transfer list has no room for the devicetree, SPL moves it to a bigger
+buffer, so the DDR loader only needs to make the transfer list big enough for
+its own entries.
+
+SPL stops if the DDR loader does not pass a transfer list with an overlay,
+since U-Boot would otherwise use a DRAM size that may be wrong and would not
+reserve the memory used by the DRAM controller.
+
 DDR-loader handoff contract
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The contract between the DDR loader and U-Boot SPL consists of a fixed image
-layout, initialized DRAM and the execution state at the SPL entry point. The
-BootROM loads the image payload to ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+layout, initialized DRAM, a transfer list describing the DRAM, and the
+execution state at the SPL entry point. The BootROM loads the image payload to
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
 
    offset 0                                     +----------------------+
                                                 | DDR loader           |
@@ -129,10 +191,13 @@ The DDR loader must:
 * copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
   (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
+* write the transfer list described in `DRAM description`_ to DRAM outside
+  the SPL region and the memory used by SPL and the images it loads,
 * leave the MMU and caches disabled, with all of its writes visible to the
   CPU, and
-* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions
-  masked.
+* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions masked,
+  and with the transfer list in ``x0`` to ``x3`` following the transfer list
+  register convention.
 
 SPL obtains platform information from its embedded control devicetree and
 initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
@@ -236,3 +301,5 @@ a prebuilt Genio image for the target board::
 
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path while testing.
+
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff

-- 
2.53.0

