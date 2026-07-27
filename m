Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA5AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38AB580D77;
	Mon, 27 Jul 2026 11:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RtIxMVMw-BcL; Mon, 27 Jul 2026 11:45:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D7BF80D60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785152720;
	bh=o9k7eLsT9r5b7zJ/JoLLgx9frly/OwGMm6e3olhUuqQ=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=NbG23y8y4OPpgFUPYdNLgs6WPMKC/8r8VKUsVsidJVI1IEMWiMT5yrAxkUqtW8VwB
	 xeZJv2EZ3Kbsr4MPC6+mbiLd9BE3JiLL8e7O5Iszh+SnEoG6n+gdoSIWrD0vdbgt9/
	 eOJCkv6uPxkwHcxPkuOed/sPdd/Ppty54Bp6vYrl9qimK5De8OfBg+OQL8Ye4ZEzMV
	 HuMzZ9ejQ9bYKgaJ0uv8JgkX7oke8dHvJ3AFMRyp9SdRLDXcgOn31ct9HMpZGPnW+p
	 8mAPyWKGK1xRoQi40UpxUfH/c9KmLi8+I+EiqCcKM8VVqULoM/IIEDdceFYoEyEGoI
	 pL+Cec5r8/ORA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D7BF80D60;
	Mon, 27 Jul 2026 11:45:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EB3C357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94157606D6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Um8ajrCyDxsW for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:45:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 43403606C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43403606C7
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43403606C7
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:45:16 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5BA3B40195
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:45:14 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955d314945so18769825e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 04:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785152714; x=1785757514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9k7eLsT9r5b7zJ/JoLLgx9frly/OwGMm6e3olhUuqQ=;
 b=ptpLEop/U2y89wPvTWNs/j44Z75jqu3bmXAS3c2O5X5mF9tKj4EKKbRG71lSkz3wib
 xFfcgum8kQLFmpnQ0rqeWenm5MuYHM1IZVDUOJgNYR8aPly43yRZ1IdKWY2sZ3Svy7K2
 7M0YZU/Nf3Okstwshtu2FZeq+fB7t1wDIsjrXwxYFU8kPgZ1Dg8AwiKfvpjN/8bHjfVc
 /LFqsQ+qo2bqm9UbVDR8fkEjU2OQwPuwW3FTqkHF1PKgC3phhprF6UG/9mHUuaz8pMPi
 6gsMzeZ0NLF6rSe4pGavBA4k5KF15xkFG+nf7k4ffTArKzqKjBQnrCF09actaFb6bk8j
 scdg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/G5HKxGGG2bvK+36O07/UzgvlwC++vceI3VTu4l4IQ8Z6IWarqSw4GTu3kBR2NIV+AvXOd9Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyCsk+gznqyV+l9wGfHd4PICmIwfAAddCZ+d072FbgaCKE0mh8b
 GnB8Fbtl2kD4yj98ArhtWncA9HrUgV1Xc40b7vgxeT15JzyZVIO/jFtQlz1VRSRgu5T3Qy2jAaR
 AN5s/9ljCYXKhOrAR9GHYo1nf70NmzpjTEGsmbUD/aqSf3YPNo63G+osQRi2pC40s5U3sxx/0Vi
 Gc0SzDggYKpVqT99tPQg==
X-Gm-Gg: AR+sD13mZ7BL5quNagnR2Umxh/n+TrRxt39GdrG6qoAuz/s5AUh3jNUttlETOz4qCiK
 55AQSRdhO6u47fl738VM2WvN73TBii+b/VzoI5KkVGzyQ68tRH8lSJATMH3SuverwQHFZ9n79ur
 BNC/ePgMrENnXfHFc0e60h/Kr0ohAOcUdoT7fmfmSuODZzEZDUlZaY2QAdIzKD7uGgC5LhTz7zY
 tNVktsU1YKVl1jIgX/53SJEh9goZbU7VK7lmVmrEgnPiWCB5OxuRe9BWJPSvPgSsaSg35G4fnO0
 pZD4U3JQc0q2O4vplw5O4fBcnb7kxVOKQzFiYuPXV0EAunm+qqdkNlDd50eigO34q8Px7F0oDz3
 4JHPFtXaFPtwXuZavlRgTsPsh6Uxp93S3s9BJ1oB2HLNXHnZTsFhdgBei
X-Received: by 2002:a05:600c:4687:b0:493:f6c1:2f09 with SMTP id
 5b1f17b1804b1-496b57108bfmr106326325e9.6.1785152713890; 
 Mon, 27 Jul 2026 04:45:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4687:b0:493:f6c1:2f09 with SMTP id
 5b1f17b1804b1-496b57108bfmr106326095e9.6.1785152713567; 
 Mon, 27 Jul 2026 04:45:13 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:96c0:6fce:32a7:7281])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b388d5b4sm161876545e9.3.2026.07.27.04.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 04:45:12 -0700 (PDT)
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_loader: fix memory leak in
 efi_sigstore_parse_siglist
Date: Mon, 27 Jul 2026 13:45:07 +0200
Message-ID: <20260727114507.225710-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785152714;
 bh=o9k7eLsT9r5b7zJ/JoLLgx9frly/OwGMm6e3olhUuqQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=m9cR4k/vByr7+wKJSp3Eis/bbe3cVTkdjPh0LM9nClVawkq0M5ct2CHvCvCLdIM7a
 ai/hRPCOkQfudAW0OGljZkRxbAf8dx3Hf3tLe6iVu0z4tCX7ZPCopvImCY7wiaO4Iu
 ZTR3XOTbN7fmIZNGQHnsRM4KCV0UMqn7sLYCHSHXZ/JLnac0l2PnStiXt2BpDY265D
 wYNnL5zJHCBU6loPGM+6mJWpvdHQTdK/P8x/MU4sC5xNKWmKTs/QbhaHha6Ge5Jxr5
 Dg6rJ4KxB/Tirs2OIwn5GzR4PuzGgY/9HQlgxsyEe1dpomyUqJaMNb2mjcSPth59yZ
 /2Y0xJjKCFTxmAQTi9F4MJh+aPrwOr0rZJarA25qeeunIfcWXg+7YqkNPhZcCCKZq2
 j4oHjReAmWTPVcKxIpzftxn5dzAKDOCbWXbfsZXRmpq+h7xHnz4e2qFeTMJK8RaNd3
 HxzxdjNfTx4P206UWIx9W5en+eArsaQguTP4vz8uOQ7Qu+LnmEXKYlz5MnADPqYgSX
 gWBGBTSB9XJsU3X0n//3XzzzHdpy95idTlwcMbymM+dXxmotdZPonInWcqoRosBdNG
 H+sQ/MaNS2KwgAN6zTS5ukUhbc/QaDgENwNXdJot7ITm6fmcdf0n657YNAISCIDXLw
 RRZOsN7CZ4CEhxXoZ/PMDNRw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=m9cR4k/v
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

In case of an error in efi_sigstore_parse_siglist() function
efi_sigstore_free() is called. Currently it fails to free allocated data
because siglist->sig_data_list is not set on the error path.

Always update siglist->sig_data_list when a struct efi_sig_data is
allocated.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Update siglist->sig_data_list inside loop.
---
 lib/efi_loader/efi_signature.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index f99a0c29d2b..c2be5cb61b3 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -647,7 +647,7 @@ static struct efi_signature_store *
 efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 {
 	struct efi_signature_store *siglist = NULL;
-	struct efi_sig_data *sig_data, *sig_data_next;
+	struct efi_sig_data *sig_data;
 	struct efi_signature_data *esd;
 	size_t left;
 
@@ -690,7 +690,6 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 	memcpy(&siglist->sig_type, &esl->signature_type, sizeof(efi_guid_t));
 
 	/* Go through the list */
-	sig_data_next = NULL;
 	left = esl->signature_list_size
 			- (sizeof(*esl) + esl->signature_header_size);
 	esd = (struct efi_signature_data *)
@@ -709,6 +708,9 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 			goto err;
 		}
 
+		sig_data->next = siglist->sig_data_list;
+		siglist->sig_data_list = sig_data;
+
 		/* Append signature data */
 		memcpy(&sig_data->owner, &esd->signature_owner,
 		       sizeof(efi_guid_t));
@@ -721,15 +723,11 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 		}
 		memcpy(sig_data->data, esd->signature_data, sig_data->size);
 
-		sig_data->next = sig_data_next;
-		sig_data_next = sig_data;
-
 		/* Next */
 		esd = (struct efi_signature_data *)
 				((u8 *)esd + esl->signature_size);
 		left -= esl->signature_size;
 	}
-	siglist->sig_data_list = sig_data_next;
 
 	return siglist;
 
-- 
2.53.0

