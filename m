Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2726C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 22:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A17D84AAE;
	Tue, 30 Jun 2026 00:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="j/g8d/oA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995E784AC7; Tue, 30 Jun 2026 00:52:29 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59D684AB3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6176D3F174
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782773547;
 bh=2/gdpY+LGIYpLgamSCJOUppWNNia9s2x44dYgDB67fI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=j/g8d/oABhLV9ERVsbRVjABKDndcw22hYpbV0Jdr30JDtwMZtWQzZhq74zmk51JPI
 F9s7TrO0CbIsq6QF+o1Wik2AL4QCmPpmgXG+11RVXfL5lwx7rL3lIUZJSnvXQTiX7t
 sFNPORLp+d9tKPuBSJ3qorSqrEKfNs8gHR/3hH63OdQeMVRQTOmAHeR3LJjbFMdXjP
 icWo8COZ63duazpDLZXcN9CYAP6v/EjTj2gY2cNGkMF1YtHwNhhZn1QaMnODnQ7/Dg
 I5fDJKCkfix9b1tOvSj7J8OukBsaj4aWB2bhCBg9844LPltwn7+cd4jkQADTWGXN9x
 Hl3T4wu6CdyAR2TjyWtAaSKAaluhl9XOFtwSVTNz0ReCqLwO6tZEShkS0lkL6WLA8c
 PuZ0k1QNAQF5nL3l5kl/bqtW/zKATrG1DrXy9spq43dBeat2VZeXfYNPBZPI4fjk1B
 rgt9R1qGLcEJMY1A3IHunR04Aga+5qM7bHXpHJPmqHP7j9t6NsSz294PzugnLk0en9
 eJkRc+KD3rLtQjQBGvrrO21e34pDLCCMatVLGI9kjj5wSyQf7pakGyM8i36oSNNINt
 4LEMA+5Ov5OkN900kvSsFZMk/JokzLps4eWHlOTiSSKQujKs8GfoZzyX+6ELGo3wk+
 oOfhL/rojlBeggwwwsZver00=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so834235f8f.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 15:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782773547; x=1783378347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/gdpY+LGIYpLgamSCJOUppWNNia9s2x44dYgDB67fI=;
 b=lgcNKLIZEQunkMVYJc8zbrp07pn7niu8+4rqS4OMa2mYXG/Q5VxdFR86DFzYpG7iUE
 yzUvl5egGbHAPjTW/EMzzxEg87FNutNKa3KzNcAEGvfLmo9PIDb0BiunUOQpfQc5clDZ
 PMCGRg+OUeeDjg5imukQ1koqV1HipobZKnUJk3lh1deqLQspPs+Hqj9eSsIwcDDII6QL
 jHX4amhyl+t9A1UcrvwxToMJVOV23coULUXkaGFDa4HIFCxu264tXKN64sXPR6HIjn4t
 J6Wmpou6VHzmJeO8FU3/NmF2GuU/iG9t0ajuOhGi7xW0LyCqp/cDo8yLlvOEX5jUz3Bd
 hMVg==
X-Gm-Message-State: AOJu0YzJ91eRbWJW63dnNMo5Boxb9nTMyaUq6IaXbl802gQI713zZbMD
 6E/9jAA15JYkkiccCfhyWejtWF2gIQfJ0aB3ZocnkHeYQxL+KDjEr31HGjZLxvCsawEKDRCZJ6B
 odTQfOKBuGFAtZbhLPVF/3psT4xWfes2qYtXZcqp7MUT3/axAmgM4GWru8L5QvsaZuv8KqJQ=
X-Gm-Gg: AfdE7clf/EnySlOSXJRMfmcQo65FxHcBiaaWasBNTOWHOP7GFIuCkCO4HP5wozbGEPh
 Naiib/u8bwNJ9QtmZPWm1ZhSJVPlNPkClirhCZsyI3al3iqKsox4Bdp97mKw7c6D0Zl1MyDOdlt
 oF0iYPQcgY4vKmFxqmZ18+OGbARUm9O+Wo1HXg+tGe/SvOZCpbj7U0aB2jBhGDdTopUWlNBIHmD
 BTWLJhj9/ryHx5Rvd210M6cae/12JmFhgy3UXiUki2op4sbnejEfbxrqpeOJ+rpo4/AXo6Cdlqh
 ciAW/Fy+jrrqCfMdM2S9R+N5tiGT7cUv6gcqOnHWkVkntwW2fAlIkuADKbu2PZblBgwasl5Ignq
 3jtJ3Y2rlijGqz8QxIrb7zUh82SvRyZRt/RakeZp53e9zkxZjWeY1CcBhF0AAMmolfg==
X-Received: by 2002:a05:6000:1acc:b0:474:6301:3e25 with SMTP id
 ffacd0b85a97d-4755259ebc0mr1573548f8f.28.1782773547044; 
 Mon, 29 Jun 2026 15:52:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1acc:b0:474:6301:3e25 with SMTP id
 ffacd0b85a97d-4755259ebc0mr1573527f8f.28.1782773546782; 
 Mon, 29 Jun 2026 15:52:26 -0700 (PDT)
Received: from workstation5 ([2a02:3035:626:ba8f:5998:4d02:a4c4:fa47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47563d194b0sm1965194f8f.1.2026.06.29.15.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 15:52:25 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] efi_loader: fix buffer overrun in
 efi_sigstore_parse_siglist
Date: Tue, 30 Jun 2026 00:52:17 +0200
Message-ID: <20260629225218.209368-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629225218.209368-1-heinrich.schuchardt@canonical.com>
References: <20260629225218.209368-1-heinrich.schuchardt@canonical.com>
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

In efi_sigstore_parse_siglist() sigdata is allocated. But instead of an
allocation matching the size of sigdata, tainted external data was used
to calculate the allocation size. This may lead to buffer overflows.

* Correct the allocation size.
* Follow the man-page. Use the structure size as second argument for
  calloc.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_signature.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index 93a4f257016..6aff5c14a89 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -703,8 +703,7 @@ efi_sigstore_parse_siglist(struct efi_signature_list *esl)
 			goto err;
 		}
 
-		sig_data = calloc(esl->signature_size
-					- sizeof(esd->signature_owner), 1);
+		sig_data = calloc(1, sizeof(*sig_data));
 		if (!sig_data) {
 			EFI_PRINT("Out of memory\n");
 			goto err;
-- 
2.53.0

