Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471E606A32F
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l8zrDLJG;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i5CRFoHl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB16C608A4;
	Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QzMhJBk4UqHx; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2ACD6085B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922395;
	b=O1POvv5weu/ibedukYwOvvWlxhHrW6UrHb5pEXlKG3ok38XUFdQKbYQ20/IxQcMBEccX
	 y/ipWOr5RuaebDW/If/7zOhZ2tJm/QmfD/UAQEPUTwY6tLAj0F8u4ANKKGy2SS4sg6YbX
	 wf65VQTa97EOmhxfNDVTe2ZTlVWessukNRfu6JYbJP6Qmk9y7HnqREPWbn+FTUXL0VKQ6
	 ItMyfRnLJhs0PDfMkrIQgdNU5LMi7pa/kGmSpluLXvZrkWTjo7BshDGrNFcAQEJXSd+32
	 wDj5hMutwMPdrjLdGNwk3wi6LNOxWW/qFbqeizurnPycqj3/N6SFko9Gfh0yZ3VRL2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m0nl5kiuRfOjRK/af3MksZwh2RIss0dGcdbyg6muXho=;
	b=USYo6Tqk0YlkpnQsG+qu79ldS5z2p+HmjuZnHdcPGFN9vxUhV3Ch0v+anyttlEwSVOeD
	 TojlneA059N6ZydkllU3n2Kq1WMNNkJsM/vFCUdj9ilZW62lEZxy0Kem/1EpiL4LN2eIo
	 uxYlxzpRXkFAoyeSQNHaQz7bEjQZa6ne3Hg7/X6z9kRzVfGcFKYPnUhSLTwApErmMxl4F
	 PjMgxSD2VjM9GcNnLlGEjJNiGxdQsgTxmc0Sa9Yjoi5CXHu+PVxhrFOXU8J0ia8fwPss3
	 /vKY3B2vjlEQnyGDudXyYox3JkUZfyzR29cYWgYOVJ5CfbyV20mQpr08wlGLqR2w3/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922394;
	bh=m0nl5kiuRfOjRK/af3MksZwh2RIss0dGcdbyg6muXho=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l8zrDLJGwOt4WYsPUr+UwHRlJq6osSFW8ZEqmBZ3BdnqoqlbnWIWhhqHxIgVTslpx
	 I/vizWxVzsYp0c8TehDWWZPgjAZ0MMswPIF+kaWkDmsfsFtSMhnvzV9p17RrHWmS9f
	 HXsFs7DgghtKV7KvN+6oyceEm2aaCHxLxdxtIqWZLNahGA8zPUojpOuaDBMpiYfGbE
	 oYgXbMW2tazOUZTgmqfMbKyGcJSN0s9kiFvVrX8QKmnSV9UKxbdZJJPX5pRfKUU03h
	 IvTiarz1kaNPM2mjqte91aw7j3Ad81JCrSYZt9keWEHImvgw7oAASJ5+XE/C+3OMj3
	 4NCsSlyJVUZDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2ACD6085B;
	Thu,  5 Nov 2026 23:46:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 190D295F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ACF3811BE
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buvLjy0tEpwK for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EE57811B4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=i5CRFoHl
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EE57811B4
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:29 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f84a55e31aso102090a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922388; x=1794527188;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m0nl5kiuRfOjRK/af3MksZwh2RIss0dGcdbyg6muXho=;
 b=i5CRFoHl3qxx4pfuQ9WN841kDu6ed/iILEyMBU7kdPsyGVc9M75MVrokq5+0nwrie4
 812TGjCo4rCyhNhUJo3gXHTBP2PAAN6kf6aCruQvUlTlB4sT2weAaGXeRDi8y+KRxZyb
 BWsV20dCFew7kZzseMcD7b85req7KvIxVphedJZ9VQnQjIlwRFOgkQ4ubC5Q3ORRcfQg
 8E9BpEBd/DnumRxPQRLpnMbX5fk2UnMyk996nYy0iustbpNixfTT0ZqUDjG0Q7idsTnW
 dzgdJXsWbxJ9Ey+v2hO1e76VtQ1UhguOFYV3xG02Fkc0HGG3DllTXj45qgjTsdvmxJlR
 MHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922388; x=1794527188;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m0nl5kiuRfOjRK/af3MksZwh2RIss0dGcdbyg6muXho=;
 b=jgOSI4efmVy8v0wHqJPt3GAym0Kl/PwTEN4pgFEnLC5XyY01EXhBOHDMoyBp1rnCWf
 mF9Q2PTl5UebGfSanWVd4dpWRmKabxOILMpSkg3L16L0EO3e5kkjDTTfGUIvhFSKn7pg
 bKSgSa/pPPypKnZSaQNxUhLV7NyzNCzcNuzXZFHksLW1EqsEwSly9hErIPFfhZleoDAt
 lCcDptLxZsqES1pYX3QgJmd+jI1n3VNQiSxB5n+xkjM5W8yi6Jf8l/jBMZ1MRUwubxfA
 aBzOkCyif6Gt5+JPfYszfqUe4zOhGr5SNRwjgAqxger8NZS7VmZJehglQKQIhxs47vFM
 NWoA==
X-Gm-Message-State: APuU4Z8UBFK7s8ZYyJo+NzH9TeHiob2T4tir2qPMiX8kN+Oyq1rI+qFh
 x8cvVtOPPkMhekuA7RJvJvEp0rQWf0DwXXqxt2hiDXM5rhUnHOQzpfKYsaQZETwCnWQ=
X-Gm-Gg: AYBFou1PDio+4/NIXU8UdWXQ+0BsxmI3dSAjIB3NXB1FFoojaQCiYbuMT1HvLKhVXKG
 iT1MxQVspvt/weL5OQh7YIvPhPT+zjuchfyr8nEvqR0Y4DOWGZxjXoisL+Be5TeQXj95CihHHuM
 kKg5I3nlWbuwwrgjhP9I0KfrMBNErajW3YViIlR97AkKwYG4RrtwsmlH9i8c4Jwmw8nBy6QYli/
 /3bRzkwgv2hTOBW0ybbvOSmVFcxYmMYl5xRqmTES0quaUShoxFi8AWhVxIq7vNkjpjVLVxA6yfm
 /8iq6We/Tnq/eVjR0I5gdauY/QDBlXxYV+FVk9bjl1Ps//lk5HdSSDfTaGYTGsMzatjpxyWx0u1
 TszOX44Lwys80VTqnN9hT3loOWn+UdrseYArglXYuZGeRW+sWgcB/DYS4nlAGhs/j7Zx9X25tyG
 1EFhCYhC6Dl89k/OKRj5rfYJQ98u69rdzOj2o0wqA/j8B3qUtbWW5i41c7d8fuIyTVI/1970EMb
 1MHW4ch5gRh89vhMMRNaO/iGqislWy4Ag6Z1Z0iTz5YWCoQxs/Q3+46V6zmFt2yoFYMpTgoehB7
 71ep/DkZtgWFQqjTDdCIUSWXU69PpnAtbA==
X-Received: by 2002:a05:6830:911:b0:822:45c8:a94a with SMTP id
 46e09a7af769-85f1cfa5506mr1279163a34.17.1793922388390; 
 Thu, 05 Nov 2026 15:46:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] mediatek: mt8189: apply the DRAM description from
 the bloblist
Date: Thu, 05 Nov 2026 17:45:22 -0600
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22QwW7DIBBEfyXi3K1YwGvsU/+jygEwTmjtOAViN
 Yry78VO2vSQA4cVO/Nm9sKSj8En1m4uLPo5pDAdyiBeNsztzWHnIXRlZoILQo4SxvxZnkbdQO4
 N9F2GRgktJdaOHGdFeIy+D9+r6fv2NqeT/fAuL07Lxj6kPMXzSp1x2bsDxFPAjMCh10RImrh19
 s2a8xBs9K9uGtn2eoNE/3UqBfKN/Mhf6izmyBXYYbJDgUMeYM0Iypev2simcdSWLP+L/wklpOP
 wEB9NShD9LoFEyV1fkxaI7SyeqX+PtvOHMEEt+OqFJLhCciSEugutSR5KnzHkdtNhpyrXCDJVj
 b0lh566GnnlhObl2qSowcqbUv76AwDqusnFAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5208; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Yakg01+1yn5bgGq7eM8tIKT0xjOAljRrUgzrlWwtFhY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RUWk9xKAs+5Ss3Y7U8mfG8yq+MAyfM8Qyi5E
 tEa4eJFtiOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VFhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ab9sH/RAr3xdeShEVEVLVRVFhOUesMKXgbgrykPkPfV1
 vDRx8gFwLal5RtMv9iYfEXHZ/6Ru8dUzwYR9bwAf1UIaNcOqgtmGWmxuryuOZf8n4otJVIC21Ch
 0kCmt6JM/4k7TM9IDlS5G8OOPw6iOBJqd1mNXadXeLNgTGPWccJ5qjUQdBLgKpVN7ojA1yvAX9+
 GK4eIwFWKgprTCkJmLiAjJcfcvXG9tNsuIfItx24pkK9zGGWCv8JhyNuteEiyze6uim41vm2z2X
 p4ctmW3afrHKkdStRNGkJOZJhqA2HH1Byf06puS7ovw+J9I+wsAI3abu1pCpXHIJtexnfjBekHY
 4D8U=
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
 arch/arm/mach-mediatek/dram_desc.c      | 52 +++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c            | 31 ++++++++++++
 common/Kconfig                          | 18 +++++++
 common/bloblist.c                       |  4 +-
 common/spl/spl.c                        | 83 +++++++++++++++++++++++++++++++++
 configs/mt8189.config                   |  6 +++
 doc/board/mediatek/mt8189-genio-evk.rst | 79 ++++++++++++++++++++++++++++---
 lib/fdtdec.c                            |  2 +-
 11 files changed, 286 insertions(+), 14 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
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

