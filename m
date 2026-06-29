Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494AEC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 23:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CC284AA0;
	Tue, 30 Jun 2026 01:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PD4ArIdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51954849FB; Tue, 30 Jun 2026 01:35:30 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3765284AA0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D74813F5D9
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 23:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782776127;
 bh=8YGV8JSD9sIQsHcs7aA56ToRb9Km/2QUjFCaZ4DfqEI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PD4ArIdztpEzXev5rzeu99FWEbaSrqqsi0n5tp8dfM4oikA3hLUA45FVzTjxsdTDN
 Ww39UV610EZRxSSelEs6CMgveOuY6cYWAJyvOZ/ovuj/SJGGhxs/zq4gK3Cvc1TvGl
 s7+GNcareyErY7cPHS67Hyv1rSEkU7+31aVb6EU4RxaxVxIbxPQeyF1qwuyCTaKutj
 jPjun2nZyDK3W4314lZ3/PD1/Fpi8xPIVc3yWnCDuIeQ7PY2Nf1pvqfLNJj+PX3MFY
 /gFC1V4gRgPZOL1ncBkgY+sbvg6WjAf66hIslgZWaq9JkKfmFQyZZBkkYpY93GsN86
 k/rEeXW8G/6CYomISN7yd2E8LsfiPnTzBNlybQyh0NVEUGeAgFhYJhJIb3+qixh7/r
 NSbTsr+ZlK3luu+jX4lACM9MQrhq7aD36KTN3TT000MrjAfAMfMFxoWR4oVn914Bjm
 N1IJA/s3fj8vOqBc52w8JY4fB8qIxdlvyOhFsC1Ll2cJrS2GG5XS4htrdnL7PkHxp4
 LlB07vLe0qCGNmN3g7xeQnEw1zWVhsI691/gGq7QKNBrktgaYKYoIDLjmyLmoVVfZD
 vdSPCal2LHTFg/SUn9Epe0Y8c9Qq8Z5zRfer31m+cxMXvxQfNgz0SHIacFUs9npUn2
 bOcZr/1iKAQcX+Brq06k2YY8=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473f4a48e9aso861481f8f.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 16:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782776127; x=1783380927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8YGV8JSD9sIQsHcs7aA56ToRb9Km/2QUjFCaZ4DfqEI=;
 b=qYT7NfUMmAyoDjHCC34IQF2mua8Cxo2qKtMwBK+nDfYSbFiHGKdscf2kyKeQhojLuR
 /71qzvux8r/LrakYRZWS06FZn7tpKl41pnnc6SSDtEOMZzAgwtKXWSuuPy/bi9CoNmex
 G930yRKMcFyp4ug1UUzlcEX0eHVrnxXHuXU+TZsw+cc+tjojTB7GojkhUML3jDpwYveD
 5ySHlk4dV1dTjFaw0mc7XxuoFY/OXyAeDieH3MNYf0rVQ2d1lJxW4dbAqXl9/gE3gtyS
 fkVkFaH2RxPfVosNP+pRciFv/jRLxjEJoQxsXK0+ABdYTEqBdbGBBwIfEN0IDUIVwd/i
 pLeg==
X-Gm-Message-State: AOJu0YxKiXHh6kYtWUTxHy+eQSuQyaK7swZr7nLRtGuRn2xUHSdEbehJ
 WL1U5DSQ+okFMD6TpKSe+cHqzbr39rZMQiMN6ephkqWyBdBDGiyU/JMC4EZzM6gTpJxH7SsBKd5
 Zfbgs7AxRTGX4YRcQlLWnkoV1XovrllLjBpL4uh5JRXUCU3B+nRJlhu3MvFY7AJkfllFg+Tw4dP
 JTv08=
X-Gm-Gg: AfdE7cmpAhReypZ33ZCeHdD4KZ3jfjaEak6G/Zu1VVxzxa2sOhs2LIPillhlAI7LaWW
 j3aqUPa3GXd7cfiyud6yJRPVq2elBhrWo40t+3IvT6h+RGyv6YDrh87uHlhb/U7znZajl0MLnx9
 HjGjYdR23h6glP6JWl6xA+7lkZAIjhi2Q+xX4/vZuxHv9r5HOJt1zkY95rXK7DJyZTwM2SN+QzG
 aaxb8WrndJjncBj4wRyg0g8Ld+51wpldFwqoO37KVtDiHA9AWwrzC/0RY7vV/P71mDBpzsMhO8r
 xw5LVQV3jYOvt5D2vNj8Bhfh2tQFexFEAavEQP8utnIRATP+Ru56Bd4mzy/+cj7zD8kDrkpPp/e
 Mccpxr5snqmWth82zE/JR3HLXn6izZRMy0DVDsk14YzccTZFq9ICtt72dq3EADolx4g==
X-Received: by 2002:a05:6000:40cc:b0:465:5627:79d5 with SMTP id
 ffacd0b85a97d-475521c86b7mr1720750f8f.24.1782776127445; 
 Mon, 29 Jun 2026 16:35:27 -0700 (PDT)
X-Received: by 2002:a05:6000:40cc:b0:465:5627:79d5 with SMTP id
 ffacd0b85a97d-475521c86b7mr1720719f8f.24.1782776127084; 
 Mon, 29 Jun 2026 16:35:27 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566fe448dsm1968537f8f.27.2026.06.29.16.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 16:35:25 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] efi_loader: fix memory leak in
 efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 01:35:14 +0200
Message-ID: <20260629233514.211746-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
References: <20260629233514.211746-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When malloc() fails for sig_data->data, sig_data is leaked.

Free sig_data before jumping to the error path.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	fix typo in subject
---
 lib/efi_loader/efi_signature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 6aff5c14a89..1da656161bb 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -717,6 +717,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 		sig_data->data = malloc(sig_data->size);
 		if (!sig_data->data) {
 			EFI_PRINT("Out of memory\n");
+			free(sig_data);
 			goto err;
 		}
 		memcpy(sig_data->data, esd->signature_data, sig_data->size);
-- 
2.53.0

