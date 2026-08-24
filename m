Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CDDC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD0D4405BE;
	Mon, 24 Aug 2026 08:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z44aozIQ6rde; Mon, 24 Aug 2026 08:14:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787559258;
	bh=efl5VrAx7MHzwqX3vrpzweawS/RA1jEdLGEffFMmeBI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pNci5wumtm05KIP32h2M6qsp0RdvyjW0mwjlcsku6k/uURknFd1w7m31IDya7mb1i
	 +jtUIlHLXmtZlgrUCO2NkcDwkVA1qt6G3H15N7T3MKR/KAC3OrVsc/JXQOj/cMIOQ5
	 ZdMiEm6pQ2BErlyeiUDeFdPcClokCw3YTLNOwgs87A7H3vTnPiDVidJg/Qkea89H1j
	 tMufUhVQq7NLhj334EOE6T9fqa+NdJL2t9I0gSerGyaBLapwf2OfC/toyYP6DPsLnR
	 soetDbTk25tEpl4PLkFEvkk+SlBRQnsKbvPo5JgvmP3JesNZ9vVlzQebftK9B0LVod
	 FqCI+gM/IJs+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F232240565;
	Mon, 24 Aug 2026 08:14:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 275BE3DA
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DB974055A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dmH5hK_C_xpP for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:14:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=OA3GIXQC
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98C0640565
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:14:14 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so2043706a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787559254; x=1788164054;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=efl5VrAx7MHzwqX3vrpzweawS/RA1jEdLGEffFMmeBI=;
 b=OA3GIXQCc3bGLqse0q73v5OJ9ojvIQBj9OjojmXkruIoUk0983HAulweoTvlINne/7
 rE6S2jBBTcTL/OnXtaC8Q7nkZjfWIn8VWmSdGPjoBDV3Igfm9xzgL3qOXV5zyBoc40H4
 VG7TDtW9OYpI8uK++fp2PIfzZBuWocQ/LiH/Tf5NDl3bE8nS/4iHGXSFXnra8+C3znZK
 W8cAfpReKJYtPar5UgoEhRN9kwDutxZ1V6qTtNiTJqykFngAM8PS6lSqbZYf1i9r9llZ
 FZf9M5r7kUo4dGYhxCfBK5X2lzDZyycAi5xQnBCL5kRozQnUkeTzXFAlA/+1JZYJgrHA
 DMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787559254; x=1788164054;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=efl5VrAx7MHzwqX3vrpzweawS/RA1jEdLGEffFMmeBI=;
 b=nx6F70FTR2DyogW1M59RltfhH3dC7FcyJmeLcuL2sWrIyVqSiIC7D7DJ/LDFmv9jdm
 s2CkGqQr5mE0BMxaN1iNIzVka+2gOTvdfyh1T9fsrOzE/AT6fmYHL34m4bML73lA+hQh
 pK+hFlqrFmO2rTRHA8pWBTPABPv2NYPmhFaJfq2BuyRc5reW/GzD+ei9LRMIPgy3uift
 sJQ9nfNcrwtHHLmiptURqrHv0s54PNwdj/IhbHYDA2HkP+Ea0nyc8qY5hBBp+blhmYoA
 USD/UdTw3kNmhBWP1i4BkiYG3MQQqLkv3NLR4y4U4buKfWrIIHLTrDnW4jwub8SvRmg+
 KbBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEqG34bmGn2zf9LYgI5N2gegK3rGy0piznIQxsF8pAc+br5Y5QLQ45uRN5LAudNCA8D7Lsfqw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lVETzHNMbN+bSSFSW68rJ6CFDJsTpw9lm+GR/ig7Hs2hAs2CQ3
 /lPYQLGr28U8AhfsLfPE0c7svPiWwZ1gvKQDFv4iUqkVwruF6HGJACyPIC4zNQYTotU=
X-Gm-Gg: AR+sD11JNmg+LCT9j2TrhhRUq1+nCqWqCanRUgKWIwV6PORHzoSBec3Jmpv/+J14dTE
 0pqoKiq9t/x5ly2Yp8uXd2jxwJxO9ozatjcw7sTBPwGZsYYsl1+dxRB0wZJjh1wcCAe0I38gxVZ
 v6L3Swfq9YaJQKu3ri8gqZGzkuhQjZnpM3JGX0Aa8Sfjhu7MVoa0ObvvZri4MHetR/4/YilQ/NZ
 hafXa7SgO09EfgtPwVXXP575Eyqx9aoyfYo0HwFMk5M0/lLcF+COscoFsktbrRhp+C5HhJ1iZts
 2cVLF4VZksRqfX0GSFfJtyBoFhhxW7K7bqpVffmDs4b74UnkwMZMMQPCe0LYuvDD/8VnoUaCndD
 9EhGn5ZnPh7VOEVNJyb+urpbQYqnTqxy4PKilwUAZdlKegyDhiUntER0Qv/xOPlTYo+OvgmrDex
 rYiENYV60CRwTUoNoRn/Lazq4jvYPIk77Z+uRrKjJ794beicSiEutcBvmzuUmn2r6HniMLZMo/v
 R1v2NgFLdv46BV5nY5sqM0yScRkj7v08AU6isQP5nHul2syI8ZHt0gp8oWOPy8d+PCBTz1TClTP
 Lc2OzrxB//XMqUfIfnSo9hn+5jUHhHAP98Pn
X-Received: by 2002:a17:90b:528f:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-395c35636acmr45556137a91.7.1787559254160; 
 Mon, 24 Aug 2026 01:14:14 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860df25csm21408153c88.5.2026.08.24.01.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:14:12 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 0/2] pinctrl: fix on Spacemit K1 SoC
Date: Mon, 24 Aug 2026 16:13:58 +0800
Message-Id: <20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEb9i2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMT3YLMvOSSohxdc0OLtFRTg9QkyzQLJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAKBQZ3FrAAAA
X-Change-ID: 20260824-pinctrl-718fe50eb9f8
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>
X-Mailer: b4 0.15.2
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

- Add IO power domain control register programming via APBC block with
  ASAR unlocking for dual-voltage GPIO banks (3.3V/1.8V switching)
- Fix drive strength configuration: use FIELD_PREP(), preserve io_type,
  return correct pin number, and remove redundant initialization

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Eric Chung (2):
      pinctrl: k1: fix drive strength configuration
      pinctrl: k1: add IO power domain configuration support

 drivers/pinctrl/spacemit/pinctrl-k1.c | 107 +++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 7 deletions(-)
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
change-id: 20260824-pinctrl-718fe50eb9f8

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

