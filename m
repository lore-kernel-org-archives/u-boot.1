Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83406606A898
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EIU0GQDb;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SbTATWFN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55FA280DBB;
	Mon, 16 Nov 2026 22:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVAnDHeYcFY5; Mon, 16 Nov 2026 22:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F74180DB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868437;
	b=sE8p1u6lU2qSXGyztQ4q1cRmvIK0HTH9DqN4SUOUrzLHCdLVZk+QPuiPtAv9ppeVtoJX
	 M7w6t0yekuHypVMvgDwjNE5ZZNC+awNxGuExSRJPVKdUXS32fMdBqFWiQRVJsUT1bbFG0
	 Muo90CQdHg/wZ9f/pPWU3V8oQ8pR/i634/ab4AcCL2xycyRidJGDsyj7OiV9zozFGqPrZ
	 iirVcr4o+OxxMHSSUqxSWbHDpm2vebtK78BHpcC7zSGLbDVCGjHeL+Tb8aI3UhrUf1K1r
	 IhGk9W/YuVjb3shfTyYiOidOSi8KgUvPdb8MWisU3ndQT8Brj2c23YuHsAywXUX1rzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xCCl3dOBIzPIxdI0fYVrNmFp/vTu093fQX2ed/qwiw8=;
	b=hJEsW3x3jZ5gTtoE838798sLZKszOCt5YT5Z0XrKEx/rKf+j1koHcANzDG5YQOIylYNM
	 MEQi/CeZwb+VPpf7EyLvhOM2ODmmfg9nqtOk4b1GI1JjbiSOmRltSy3R0NMjywh1DVTvp
	 I+b5/iVLBMlFqq8AK+pZDW1aZOA00skMOXTlhlXnXJ8eKdMVCRBRAwrEse6YYWNQL3aNF
	 cXAi1YZwNUbgGAPpDjEFtzKkxxAn6BXadBPt5E8CKCeBEneZz894svEckXd10r00h25Bf
	 VkC+ZSAya+KnQW+NSBA0G1aKZxSPjy4YjUBs9PPAicz6bDuQ+PJeOVRPix7PmHIEkWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=SbTATWFN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868437;
	bh=xCCl3dOBIzPIxdI0fYVrNmFp/vTu093fQX2ed/qwiw8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EIU0GQDblSEFAKV1pA2qjxyMSul5F4jfDgIabvUzo98O6Lh2nF/+IqnXLuFoC7E3w
	 yE5hCLbcHug0gJ9qbMSyXhtd6Kqj3hL02PDiaDHT+vBsI1ytqcAAvWiZUj3sFZ53hj
	 5UgyFUwuhg2+PR5/Yh43r3UeFlOq/nAIWCEPNT7p1QlbnW1ynT25n4EjqioD6MUeyG
	 7GwekmpKvvM7n9L/YSTY/sZeVc01DLF9tNbuJqdwr1v/hLaSRj4JwWnjVtLr4IO0Bj
	 dPftz5GYBDbtULVrp/sS/uuC9us8CNfHSK4efqLcyaullrICbKOBfJBJfGSQUmO527
	 HRhVBWzc4I2Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F74180DB2;
	Mon, 16 Nov 2026 22:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D55FF1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2AB480DB2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKFdtMkpF7rw for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9682380D07
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=SbTATWFN
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9682380D07
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:52 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so5083001a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868432; x=1795473232;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xCCl3dOBIzPIxdI0fYVrNmFp/vTu093fQX2ed/qwiw8=;
 b=SbTATWFN/7K67/vc1ObfQmvJEriFxBO4n16wC7pCOjl4/VBYaznRHYkssgFli/DI3K
 nVw2cpaw/GDDDkmLo2E4W5SRd5Ign6ioY+O5/eBTzxyn9aRfRaiSawj2OpiQpwJj8qPa
 cdZoN+p7ZHYw/Z+MmlJO/g1q5WGet4nBXaEUptpthDhdbQlLXL+HYCMa1zSlPGcF4U1M
 FF6AelFL+to/Ix0heeESxlflhe13n7nURDcdnrdlJCnfNyltsfDC10D6zdRjEliRrMqW
 7iF4Vth2HDfUFqlsfACQTwkuI/elpNqlGZyw+XrsRufC7meoVIuF7DiEDNGWo7TSHHbh
 qWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868432; x=1795473232;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xCCl3dOBIzPIxdI0fYVrNmFp/vTu093fQX2ed/qwiw8=;
 b=qVhgT/EE77BuemW8EA1JNxk5oZjVugAlvHNifozOuOPchiQr0Lh5zX2eDAoRSuZ6h9
 NevyysJrtu+FGSikn/vcBCXezKq9TaKVnigtkikJpL5WDdfYnFGpvUf/sNcqB0d9c829
 U0V9Hj2GKlhlyRmQ6HwnsyegXe0/EUB/+5ukqN6y8cBibJGo86gh7MQyVUEApuK2peO1
 SJbAtbnuKBnHh8EC+JSw933R9T4MrJnL5ltXc6jOPwqFYDgWy9gg/egP3bDWtNg/HTRK
 EjQC6rbUIPdPmIaK6IXbK26I/m+wogx6Bu4HwZJPvjBREe3KFrIrkcV1l5BLrDkD9NV8
 sjfw==
X-Gm-Message-State: APuU4Z/lOFkCXLbvYLEoMuReqJkmEpJbORFEU9VnfMubMY854UE91GXz
 72PsVGQgMPitYNQfQED7XmvW3rDkZ3FPl2bO89tk6xEuBft+6fIhimWM9UXyNJ5Tncs=
X-Gm-Gg: AYBFou1jb7YWVAE3HN+Ynd7PvE46VKgoWMSJ5+ENCiQhe3/kGrhvKcn2SaMGMAAqEu5
 J5KBlMG/iwwsU/4b2sbalEITrWeSD8zGvmpDn4PlhY8suvkM83NN2CPl7KsbEjHsdP5/J27z/Pm
 VmJGHjV38ODAOwGPrkStCum2TDH1mThQxSVkdbqvKhs0Mks5tT4jaLiuI3K8sRmvFALRIm9QcVS
 EbNq8VmPY1raYH68i9UpBHm6Wrd50JLmKGlnjtUXmxnbml0BBVOtdkzZXJNvP9lVqBG8/9PgOkq
 QNH0sqONBCOo9ZRxvFtZExEnLUVLTi17LO8LGDTlJwE7Hu5twGgIr5N5WgW2cSRxnrGfEvQeO1M
 +WWzdguX6ba5XwxfVv6B6uPoaORdO+qPgCoyj76iof6/HJy4QmkqNdsGwkiBmenewn18Dk92AS2
 XSE3dMEmen6HR4MMXHB6AAGCRpQdpygQRmxfUh692ogMvqsPg4z2acAC3cTWRvM2f8UIwAn+QQy
 18PYHoYTY82/CjeXfK2yy5ggMlDFVix1qgK6xx0YQpTtIKOZVqlVRrUN+N/nQUYEsNY2qllLm4G
 PemU+7h4jKPTewNEnuStO2HrBfd0sNF5Wg==
X-Received: by 2002:a05:6808:3208:b0:4f4:3790:660b with SMTP id
 5614622812f47-56e6348aaafmr9746795b6e.29.1794868431772; 
 Mon, 16 Nov 2026 14:33:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:33:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/8] mediatek: mt8189: apply the DRAM description from
 the bloblist
Date: Mon, 16 Nov 2026 16:32:41 -0600
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22QwW7DIBBEf8XyuVuxgNfYp/5H1QNgSGidOAViN
 Yry78VO2lRVDhxW7LzZmXOdXAwu1X11rqObQwrTvgziqartVu83DsJQ5pozTshQwC5/lKdQdZC
 9Bj9k6CRXQmBrybK6CA/R+fC1Ql/frnM6mndn80JaNrYh5SmeVtcZl72bAX9oMCMw8IoISREz1
 rwYfRqDie7ZTrt68Zj5nYKseUjhhWILQrdGMon2H+VyPTW6z2OpIV/vv7fQVze4BDNOZiwRII+
 wJgXpylerRddZ6kuiv/X9CgWkw3gXH3RKEN0mgUDBrG9JccS+JHmg/ql+4/ZhgpazlYXESxCyx
 Lm8CY1ODkqeXch9pZANLQpuyTMhBWuU8l42g7aeuCPuRceo6VQJf/kGiyISOgsCAAA=
X-Change-ID: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5698; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aPngCancQO7v/ZLTK5TVnvM9UWMSWY3L+7JOxapStSo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4SQKPxMvjCwyOkLZHOXCd/XSXqoxjk1YmatT
 BhbfT/BI6OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEkBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUPkIAJLmiGjPCPc024el9OP02HFKhojSqG4ZH8n+NH8
 OKFt4cKDsq8NZAW73a+d4p8CTZN4zG9xBohAye8JZj2wvR5LuXmu3M+Q/Ejj1XsW5wMJ5hEBuX6
 7pyq5Ui57iVIU6PBFq5U2bmTC6Z860qeY7Kp6UR3z0Zg3y2V7O+YLrinYl2QnbEBSQEryd6WwWm
 qgOzq7QdhA9pj7C9cpsUlAHMhj97eXgb2y0jjV0ENi0PgD7h72KJ2zm1ZwC5bFvE2lw1bMnE0D4
 jrW8603JYrrwDZ2DRKmg8TNxCTGR3F9eJfJkees4jHXV8sHrRfielHIMhIMMFPkb5eGbUszs28v
 ZHXw=
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

On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
reserved for the DRAM controller depend on the DRAM fitted to the board.
The devicetree built into U-Boot can't describe them, but the DDR loader
that starts U-Boot SPL has this information.

The DDR loader describes them with a devicetree overlay in a Firmware
Handoff transfer list: a memory node with the DRAM size and a no-map
reserved-memory node for each region. U-Boot proper already applies
such overlays, but only when the transfer list also contains its
devicetree.

v1 made U-Boot proper apply the overlays to the devicetree it found by
other means. Following the discussion on v1, SPL now adds the devicetree
of U-Boot proper to the transfer list instead (patch 2), and passes the
list on to U-Boot proper in registers, so the existing code applies the
overlays. When the transfer list has no room for the devicetree, SPL
moves it to a bigger buffer, so the DDR loader doesn't need to know how
big the devicetree is.

Patch 1 makes BLOBLIST_PASSAGE_MANDATORY apply to U-Boot proper only,
so that SPL doesn't require a devicetree in the transfer list from the
DDR loader.

Patch 4 stops SPL when the DDR loader doesn't pass the overlay, and
patch 5 makes U-Boot proper require the transfer list. U-Boot proper
started as BL33 by the platform BL2 then needs a BL2 that passes a
transfer list with its devicetree as well.

Patch 6 drops a reservation that the OS must not get, and patch 7
passes the reserved regions on to the devicetree of the OS, which may
come from somewhere else other than U-Boot.

Patches 4 and 7 are common MediaTek code, enabled with
MTK_DRAM_DESC_HANDOFF, since the DRAM initialization on MT8366 (Genio
360) has the same code to reserve memory for the DRAM controller. Genio
360 support for this will come in a later series.

Tested on a Genio 520 EVK booting from eMMC.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v3:
- Collect Reviewed-by tags on patch 1.
- Patch 2: include <linux/kernel.h>.
- Patch 4: check MTK_DRAM_DESC_HANDOFF in board_init_f() (Tom).
- Patch 7: print the region that could not be reserved.
- Patch 8: the transfer list must also avoid U-Boot proper before
  relocation.
- Rebase onto mediatek-for-next (Genio download agents).
- Link to v2: https://patch.msgid.link/20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com

Changes in v2:
- Drop "fdtdec: apply bloblist DT overlays to the built-in devicetree".
  SPL now adds the devicetree of U-Boot proper to the transfer list.
- New patches 1, 2 and 4 to 8; patches 6 and 7 pass the reserved regions
  on to the OS.
- Reword "configs: mt8189: enable bloblist support" for the DDR loader.
- Put the SPL check and the reserved-memory copy in common MediaTek code,
  enabled with MTK_DRAM_DESC_HANDOFF.
- Depend on "bloblist: fixes for transfer lists from TF-A v2.15",
  "spl: pass the bloblist to the next phase in registers" and
  "mediatek: mt8189: add U-Boot SPL boot for Genio 520 and 720".
- Link to v1: https://patch.msgid.link/20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com

---
David Lechner (8):
      bloblist: limit BLOBLIST_PASSAGE_MANDATORY to U-Boot proper
      spl: add the devicetree of the next phase to the bloblist
      configs: mt8189: enable bloblist support
      arm: mediatek: require the DRAM description from the earlier boot stage
      configs: mt8189: pass the DRAM description from SPL to U-Boot proper
      arm: dts: mediatek: drop the DSI reserved memory on Genio 520/720
      arm: mediatek: pass reserved memory on to the OS
      doc: board: mediatek: describe the Genio 520 and 720 DRAM handoff

 arch/arm/dts/mt8371-genio-common.dtsi   |  5 --
 arch/arm/mach-mediatek/Kconfig          | 17 +++++++
 arch/arm/mach-mediatek/Makefile         |  3 ++
 arch/arm/mach-mediatek/dram_desc.c      | 58 +++++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c            | 26 ++++++++++
 common/Kconfig                          | 18 +++++++
 common/bloblist.c                       |  4 +-
 common/spl/spl.c                        | 84 +++++++++++++++++++++++++++++++++
 configs/mt8189.config                   |  6 +++
 doc/board/mediatek/mt8189-genio-evk.rst | 81 ++++++++++++++++++++++++++++---
 lib/fdtdec.c                            |  2 +-
 11 files changed, 290 insertions(+), 14 deletions(-)
---
base-commit: 810d7132c6f03430588ff45dacf62e62f3906598
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git mediatek-for-next
change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0
prerequisite-change-id: 20261104-bloblist-tl-fixes-4e2617a399c6:v1
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-change-id: 20261103-spl-bloblist-pass-regs-3130cf768211:v2
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175

Best regards,
--  
David Lechner <dlechner@baylibre.com>

