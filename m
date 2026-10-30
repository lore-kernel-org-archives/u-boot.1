Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D29606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j3Udken4;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MkYdFCAM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67A9A406A5;
	Fri, 30 Oct 2026 12:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EConxfrkLddd; Fri, 30 Oct 2026 12:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E7654068E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363321;
	b=lxIWm6Thhin3sLPajnxaC6GY8llywlDbTUKmL2sAl/t5ZXp4k3DH43hBFjuqa6Vny9tw
	 ggu+0InU+hHzKDGp7Sy9x5JC97PlVdgi4o34BPYAGqKc50WBr4FpzkxM3LVAS2XTL73Vw
	 XAlZKJPvudiPruznv9IMvhShOuEpGDYu1Z+OOiyO5ZWkkHubjbjTkxX9BdTWZhd+4dvwW
	 OxC9CMI9hk6nBArLGFqgabqVgkPldcDjLupxfYPMpJQ++sDuadeELy2RKxG5SRg3xWleB
	 08YBz5D1EA3T5a7blPG8Wjdzs24qYlvaErlF3FVs4rWK57FSxxIBF9zuO0Cp/STH0BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O3FXRkJVBqUuVCPa28GxetgJgzk1Qq7hk3suCetQ6i8=;
	b=TJyMGAsY/eBl+sJbnjGOIJcXlYQFRGGysFYeruY62vI4grPAJu0ZMW6H4NjwM8RUupbA
	 s52C4gRcOXeBI02/XGOXgpE6IYV/cMR5YdnM2ZQjCBYSpeLENqij9wGQJFzFwfJF1NgAo
	 mhixlx6pRN6bAUU1VBV6TDfftBfLL1RBscnFgib2ojEN6pnzJ8XmTqydfbK/W0Bo++WC9
	 xJctaxO7NVSO0dcfcHE4K727A51TcVW2oa9x9RBbSRW/FHxKdCzDkyK6TzK+ysbuzkNXT
	 WHXXIEIur3rBT8Dvtdw8rZciJ5MZPRIkmxBYkd9gKL4gLIdgPAwQbsxcMzatfIBb+Sg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MkYdFCAM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363321;
	bh=O3FXRkJVBqUuVCPa28GxetgJgzk1Qq7hk3suCetQ6i8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j3Udken4GqnhmXnb12maNjHVn5CHjygZg9CKn/KFycRR5C64NUYCiyosj3dtxN7+K
	 xzK295IwhW0EJU8Z7xC2AWnEKXUN+Nt2BmB0Pqpp1ZzKddNI/LmIUEPX8xIeerLq2I
	 i5Pw0UGao7DDJslCzT72gLk3cB8CuAT9t/5a01Q6bLQLQ6RKs4lLD1wtQB2M8YQykx
	 AuTaNcIFoX1YalgqdRyqisoFtrrXtRrc3any4jQew9gl4lmY0cRUtECm390BevPnbN
	 eZGy803PuMcxqfmkghV5VOejse11W2GlnLzbesp+RqM9nA2hKYu47PFgTzPT+tjWM/
	 ct27+4PgVSn9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E7654068E;
	Fri, 30 Oct 2026 12:28:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B36D43
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D8934068E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndIK7b5WyciK for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE50F4066E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363316;
 b=OoDw6lxjCDJ8ByU2cW0UkdpElwIRvR3C2ouXjWd9bIEJQk4CubSJ1I22psMuq3H9AEWQ
 znlHHaa1UewRiih5mDGsh6+OYjlzXxmd/mjiY7r7e4P/7TYWKoco5AUVEU4vW4WwaetBS
 DGDo1Igx9nfd49KJYjyE2jbDi6XLD0+c9H6xHz8Pf0BFC3CoUI7i98ccCGGBPD0g7QFXL
 iM/lrUvizNvoMsXjto6Hx/Th8VTpsdXCCEbSXzhUL9vUjiP8Q73Z0eINQaU+w7lb3yMdC
 YlDgnKCeh6vQ9wrIHaH3a+QecN8gG9V5TUZjym+c5Z4Z4Dg+azl1QoqOJ7/8x/Z3VAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363316;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=O3FXRkJVBqUuVCPa28GxetgJgzk1Qq7hk3suCetQ6i8=;
 b=Je10AudT5DEs1OhOIeLwtnecKyDs+zBTBrqVBCa/rJFglMpXwDy0FcIY5bznurzI2BoK
 SlUz6vRsvLLpCwM3T2qromxLKmOck0fgGA+52XP2W+CRqaiGBxPy+uyqA+5T4cn9InX8k
 UYNPB4xZFxNVhmv1/hyKjqY2dCHhYOHq/XMH8Lnhj1hRCYlqZ+1pPdfKTkdU4fNoCuMRa
 fsPJGWot2/9rkjjogV7gayrFTLLcpEZgLjD2vVkQtdwK3YDt78ttd1WtH81en0492qzAm
 TjGChv9ShCYVomUbzrJgfswvfoB7UfZMT+Il/4veKvnXmw8po9kijOsAu9+SGNyRQbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MkYdFCAM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MkYdFCAM
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE50F4066E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:34 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so9332015e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363313; x=1793968113;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O3FXRkJVBqUuVCPa28GxetgJgzk1Qq7hk3suCetQ6i8=;
 b=MkYdFCAMNeo0mdWh6dZboWYxipArYBfe4bSMY1qHxEKmH18v94BBTxgQhRRYHjRndw
 R2s8OsFqFxzTzhVzsWDYEyCxI5FCfkfecTlZNG8dxJKipJYbBQFEDgLcflwIQaaf0v4o
 DaTpKQXLA/Waje9caQkr+8BpSNMFI/ww9Stzk3NReGM8xbxjlzLn7YP0eyVjmZemYlyh
 H8iG2ziEaGqxLBEcaXLBHZUC8Ur953bUGAzQ+kHc6mWkf40VVdg4HPk7UeJ8B+pAuNxM
 X7+CuBDiuzPJPXi29Q++/HtdauWQECO/jPVolcDu0KB8vV6irY1yIVymc7VI+12gXVRb
 hkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363313; x=1793968113;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O3FXRkJVBqUuVCPa28GxetgJgzk1Qq7hk3suCetQ6i8=;
 b=FnEaUB9REs7cymoDnBhjZzuWFLB5fsLLeYKBiuGAlCQSi0r8hGbcQOUTzotSwxzKB1
 I4Gdq3bf/AKGHtbVg6tOC+L7r4p/+TQze4XLrxgE+REl02iSpaYAkyrO7Jj24wTob7H7
 lrfrSRQ5kyX9oseKprtosYlk0bi0nCEc/GVFF20kVZt5xWAFCxEY4eqAcmt+kIgu4hk9
 5UAsazg44vaYC9vym3tZbQI9OsQfJ16lyu6iCmAaGAalztJK+VW64PaqqCwaWVCKQWGb
 Q62Rmw3PyTBix2Fd6QvySDpC/ZW1eAbCqNKoxNhh/bBjTO/tlrkEM4l4rZFjdL1Oh1PI
 CFLg==
X-Gm-Message-State: AFq9FYL2Z5slLO55fiUk1u4pUrUkxPkl5KzvNqdt5iUvNUiutPlJ83rX
 3pwNZeNzp4A24XPJ/SFgHzUb+UD16FCzqboGpn5VDTAiG2k3RZSWO4jVSwambqahMh4=
X-Gm-Gg: AYBFou3LXzXwxYLPwVKHq4ztk4ccD7xTeelHICVjcXe5seGOTdM52Fs+Tb9ICrfi0nT
 3IMOzpeEZCAVaxpTDGZltCMJgeK5dvFjUhSXu33m3WlGvtv0Hv7cq1MQan34oUTp1Vnftckxxp0
 zf6+siGH0TQQ1UrdYSdeAh4JhkCcUSKE4yF94yrnjqEpSWvMsYBckOOGWNdQb9ECl3gFzoOzzs9
 aFYm9ZTNoRcRp4SQ83WJ9NrLQfkkVpH6SBIqC7/aR5nJixR6K306UY7EzYyGMZc2A3j1GcfAmVG
 spWv71CrnaVOrp2CchARldXotd7c9ypiFfCAuV/Hs4Fp7PByFqBGLCCvVNUMtNe88gRem/OrR/p
 B+Ye7PeeHKvFcwGzzDAIKaEqX3V1d3e8fOGf0Td1lZt2cP2WABlq5Ao51jHS8ZBEmo7sf+AcryZ
 c3unEVFY6Orjh1g1w53MckS8e+XglwqBFx1oDH9IAK1naVnT3F2cyHPCzcec2COD412jl5Pv94h
 ZoUuUgQtojyvM/uIMyQKaGNxZnu5IjR+252UqLSg7Xi7t74EZH9sJlMLXDhTzzbacnIv6HKf37t
 y+KHJUJEK+25fNaYIlM+lxoMuQaxe4F6IW3rKM+aEnRyUw==
X-Received: by 2002:a05:600c:37c8:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ac16acd93cmr48534695e9.6.1793363312981; 
 Fri, 30 Oct 2026 05:28:32 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 0/6] K3: wait for TIFS init before CTRL_MMR unlock
Date: Fri, 30 Oct 2026 13:27:39 +0100
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuN5GoC/53OTQ6CMBAF4KuQrh3THwriynsYF20ZpAqUtNBoD
 HeXauLCne7mJS/vmwcJ6C0Gss8exGO0wbphDWKTEdOq4Yxg6zUTTnlBKy4gpgsYhQFvE0xutAZ
 UX3BoAwSExt5gHjpnruCVQWCyqVWeSy5LJOvo6HGtvMDj6Z3DrC9opqSkRmvD5Pz99VFkqfc3H
 hkwEJTWta4aqXF30OreWe1xa1xPkh/5R2CUFT8LHCiYUmkpmrLSIv8SlmV5AhwXwX9jAQAA
X-Change-ID: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=msp@baylibre.com;
 h=from:subject:message-id; bh=vHrNMLPioJotc/jbqQOjFUXQuKoX512vkmvN7ShpkAQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvd7C80xNNt+pSfzDu/xXXea0rwb7TvjdUPOeaPnIw
 3f2++qCjoksDGJcDJZiiiydiaFp/+V3HktetGwzzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVLPvYvifOVHxXXOVpd//xN//NjlcEjw+/VGzUEbIDsVTsk9ri2dbMvzPF41af3D
 J23+nmDiq7gpXNGVJ6h8VlF2qypgdmpi34jcXAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

this series uses a TIFS barrier before doing the ctrl_mmr_unlock(). This
specific implementation works for the platforms where TIFS is already
running at this point. Note that other K3 platforms may have the same
problem, but for these this implementation is not straight forward.

This series is only tested on am625 HS-SE. I don't have any other HS-SE
boards.

Best,
Markus

---
Changes in v3:
- Added patche to add SPL_DM_EVENT
- Changed the patches to not wait for TIFS and unlock after
  spl_early_init() but instead at EVT_DM_POST_INIT_F.
- Link to v2: https://patch.msgid.link/20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com

Changes in v2:
- Create a common helper k3_sysfw_wait_ready() to make the purpose of
  the get_ti_sci_handle() clear.
- Extend the series to the other SoCs with the same boot process: am62a7,
  am62p5 and j722s.
- Link to v1: https://patch.msgid.link/20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Daniel Schultz <d.schultz@phytec.de>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

---
Markus Schneider-Pargmann (6):
      arm: mach-k3: common: add helper to wait for TIFS initialization
      dm: core: Add SPL_DM_EVENT
      arm: mach-k3: am625: Wait for TIFS initialization
      arm: mach-k3: am62a7: Wait for TIFS initialization
      arm: mach-k3: am62p5: Wait for TIFS initialization
      arm: mach-k3: j722s: Wait for TIFS initialization

 arch/arm/mach-k3/Kconfig              |  4 ++++
 arch/arm/mach-k3/am62ax/am62a7_init.c | 17 +++++++++++++++--
 arch/arm/mach-k3/am62px/am62p5_init.c | 17 +++++++++++++++--
 arch/arm/mach-k3/am62x/am625_init.c   | 17 +++++++++++++++--
 arch/arm/mach-k3/common.c             | 10 ++++++++++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c   | 17 +++++++++++++++--
 drivers/core/Kconfig                  | 10 ++++++++++
 8 files changed, 85 insertions(+), 8 deletions(-)
---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

