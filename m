Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986F7C61DFD
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 20:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4787E80A90;
	Mon, 31 Aug 2026 20:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34pQxzsD10hy; Mon, 31 Aug 2026 20:43:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788208982;
	bh=gz7YsqrJCrjwt0aV8kSg23tqGhML183jv0zLE31iOU4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=g57U53P2Jyn7s4ZKk4qaz3sujTjZdKLwrkKCjtwnb6wtn+LPyV1vMrKxnch0b7FzO
	 vraL7j6eSYWRMq6DmQGILmThoMnLw0F5zTt2Rxmr7SkoFVy7cCfWC0CkSu1bXzUO4Q
	 G/g2BhMFUDKfiFAuSAwwocrqW+EmOW26/knNREu+Fh8aiORkEZFyEfOf3lJ+TnL9j3
	 PHPe89W8eUj16wCqxrLU1hOxSL61DiHcnogofm2B7JxGbL6NOyRhCe/pBR482KO5a5
	 lHPPSHEVwEQYxAuG+e+WE8S4ekxBcHY5EQGclN+qC5aBvG6So8aMLMfAnubfrsuo/Q
	 EFhP5wFonztww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E95780A9A;
	Mon, 31 Aug 2026 20:43:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B3122FC
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 411DF80A9A
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAd-OFQKWBOE for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 20:43:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DxqvdWkZ
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89E4380A90
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:42:59 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so27301f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788208977; x=1788813777;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gz7YsqrJCrjwt0aV8kSg23tqGhML183jv0zLE31iOU4=;
 b=DxqvdWkZ/65pu74Plz4sdeDJPmd0A++rRSu3wx12FHiiMXF59IPf9f9Q0aCv/3Zba+
 JW4aJHPAoHtkC1Y7Vt94CLBvNToXn+JJPvOs2ii8X1jw1pyDm0vcWOKMrd9K4GIQnP7A
 sO+0/7M/ctd7zhDjy4sTMkqbITe8OcbuWKk3fJ4jVvDptnObTNdIxzdlhtHBpldDx+LF
 SuTx5yJPtRKRdkUN/8FNIVjjFPoYedA2PJxvAIWy1zWapkqB8N71DhDjVxSvlkSlPgtI
 bwT2baGGw8WlRBfS7piNz8GRnhMBga2olZ/KEr71uvBhx6MMmhLdNbsHj82j5jIPToG+
 irFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788208977; x=1788813777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gz7YsqrJCrjwt0aV8kSg23tqGhML183jv0zLE31iOU4=;
 b=liPkyBYWOoTIBD5h+tfeLw8IM3/kif2+r1ity4atgmRIsziQk9gIilToGBMKM1lrTt
 jRZmhMYjIY0MHABCZSiQDM0ga8MaaZeWq+9F8r6bH1GVDvbhWOrI5j7h42ViLPnLQN7Z
 Zs4q9yCIsCb5m2RNXOGyCW/6qilEoqfE0J5FREeO9sV/mMC/x8tlSwuP/N9KhStdfLSd
 KRKI9wvnUeKKyoISxZ8aGa5sgm4S0Z4fJPYd2Wu5tm/1Vu306owF5cfGOYQ96lhdaxvN
 /JYjiG6ah4iZazFQc4PwN6U8rEqlcUMyXMfggUWH8CWCDkHUEIZZmVXmoQTEjnWw7T17
 2RHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNajGkYAWqb8NoAgv+0wo5FTjJwrG2atKdWdOofPGQDNhu43N20txYC71qwEWJ7vL7nliKLZM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFLhNzCHSSBrsXSf2BrSJLgZsjc/43MCc+b0mrxSbmwl/qTEgh
 Gr7uoPrrc5bUwIegUP87l3w/H2ambZ0tXPi/TrXwSpg+eKprE66MECEVRK15Se/Bf7U=
X-Gm-Gg: AYBFou02ot5dVxUUmjCRo4cRr8feTvcpD7QSZxw+uLMd8+0pEbZZAku8qzH43Vo8e7G
 P0+jbrK2FNaP70+YiLqbn2jwEPDy2FRt/ONEdDRfLcpgJtSXYLcX8SaltBAK823ow+V2EX5JwOj
 mUYbncwC+CV5UI965qt3epUIQ/7BIDFT5cZqjFwPDAuyp6u+pZeZNKfAIZrZaAnR1e4bbfOPGMi
 8yf6PEeryOOgfggAcqJhdzdZHh9ILOOauKZuBlS/kbYa+luSGVROqEgJ4CZWmevhzpK5PCOqaY6
 SKKEucWaD4B9GFpLJ/bTClsnhMSJGuF+D4XXFXD9SEQ7aQDAYMNDLzbnCUsjfQkTE6+t+DmXD3+
 Rhj5laL2we8VTBjqrHthsXtPrPocULtmaKq6nMBeLzUFO9Pw7V7+8rgtxsjId2q8kxYgsKt8RTX
 EQ2pa8NA6aReGI30RB7lcSXdPUkiv24w7JTC0Al/DDt9+WxJxlwrfwCjDM7cAVrSk+TCfgbHiLr
 VwJtpzAig1LLTL1afWYmi9VgZLnIfnvy4eP486iYyEqmUcT+sBa7cqWc04k8g5QkOaYWAxqpRDd
 nCEVjhM8pWaamctwfrenbJt/OHBDyRT2G3MFYq2Bk4Vsc7E2yzSHhVk8gNcuFFO+K2oisN8Ujrv
 rUrdsnbh7or8r1A+XGMqqvmS+jOvTFtyjcLesnZSgDF/1uPRxTM8o8/BLYUq0rif61cU3Tn8Pgt
 aMq1bni2JVh/MuJ25zLO9+I4A+tFInchMFokVz+H6vIMbJb28PrBC82K+zUXKOiE6/MpkGn9yLu
 AbpCCKctc5g4VnF9JuXtfRWds+cC/h91V6qCM2p9wuKvFE1UU5lrNewBEqwvBFyhg==
X-Received: by 2002:a05:6000:4716:b0:482:e66d:aad2 with SMTP id
 ffacd0b85a97d-484421d9150mr1476527f8f.13.1788208977110; 
 Mon, 31 Aug 2026 13:42:57 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d787b8sm224453f8f.29.2026.08.31.13.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 13:42:56 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH] efi_loader: Remove duplicate declarations
Date: Mon, 31 Aug 2026 23:42:51 +0300
Message-ID: <20260831204253.1382974-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

commit f4bbd7b9faa4 ("efi_loader: Separate device path into its own header")
split some function declarations to their own header file. Remove two
remaining duplicates efi_dp_from_lo() and efi_dp_concat()

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_loader.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c5..ef25124fd84b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1026,11 +1026,6 @@ struct efi_load_option {
 	const u8 *optional_data;
 };

-struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
-				       const efi_guid_t *guid);
-struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2,
-				      size_t split_end_node);
 struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
 efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
 					 efi_uintn_t *size);
--
2.43.0

