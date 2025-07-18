Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23680C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 14:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A452A836A7;
	Fri, 18 Jul 2025 16:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AhxBoMbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C57835B0; Fri, 18 Jul 2025 16:16:50 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D43836A7
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 16:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4ab58105261so41934261cf.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752848207; x=1753453007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Twng5CF3mkFazTeQJ6ELs/kyM8121MTSmmK2f9Ak2dY=;
 b=AhxBoMbx8w5UAWGFYPBYNp0Ccu84tDWV66pws/T+7zjdr1fwCUkRPgiDGHaM9k49pz
 EhV5gUjhpCobvuZmMTi46DJbrFIIZcH4dAR+OPE2itm9ZCB2mrIbko/uuxHrwLoM21+i
 JxMTIV7Obk/bWSdaqwuq4lAIhhAbQDZK2naC6YzIEBwF3tPJg9wmiMJKe94HNt53X+uq
 HIuW33XQsuivXgr1J72SyzvPFrBNGijWnUllmQ9napADoffOghY5J4XSBpIo4oZuO5nv
 fokHSEFMhGKvRfdWnNLP5yA3NilzZ1AvtjDQtdMYYkIctNiMyrrabcDk4p+MLhbm3eFx
 wY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752848207; x=1753453007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Twng5CF3mkFazTeQJ6ELs/kyM8121MTSmmK2f9Ak2dY=;
 b=DkedqeCqfVAXI8XaiDJffOuVI9u9Ubn6qLHCNj/LAH+ILNvwZCtVsEBMJybs8CloZ4
 7e2wSAKab8bfrOn48xb+IJFDr58n6/IjunRv4oVVywKUMFRR0trAudCKXccmyUvjwAsp
 OZxVG/i/U0N7nwJ+t/fXa24n0XvHHSpnc3ffHPKde+WXHEVlSCZNo1P/dOZYGwIbIwGo
 t/941Vkx5tVBb3b4Sht7pXAW2iYPmqWM+Y6kBRC/x46TAbIQvAHTBGNvxbeOHRRF2R34
 DOsVQyNYA+LTwZ8q/a/FGF3Myssf+alEsRp3P8SptRoSiO+6CtY7aJ2Eod79wNq7l5PB
 /tzQ==
X-Gm-Message-State: AOJu0Yyxt+n0oLF4g7XP+7HB6I1UQDfLmcfWvpEig+A9XJ0o+J8uWOyC
 9HQYN/l+auHQ5sl5WKR/HztGwILRta+APGJqZITgZnfBgxjapFxcPfRFABmkwRET+n7i3d8fLyP
 dVnbC
X-Gm-Gg: ASbGncsuxuYKiHk1hhFg0yF6cMsF4Fe9m90fTxAxdbALKdr/Uy/iUl8JxSc62HNbky+
 uRLUYyX8/56T3R0dN6aIzEquHeBWhkmC0sk4EXOoZy0LEJyBfY7+5KLLOqPwEkqAOgNAim27xjv
 z2Gr/JFPQ3O6U1EfEKSzHR7DH/4sQxYwFkCMRT3cV0aUCfXgJHil+FX8B7yXHxM5RUzk6OXC9WO
 1Yg3eRztoMUdR4yT5cW1G4kUqMxZIGtK8Opylr4HKyhTmmbsCdHotzb34KYXiCcGzjZEVixxV0A
 cCv6XRH+Z558A/XIMOb7bDHzBrA1SnV70y+SVwEpr2FA3VIaBB/LWITBPVIOMx3u60TpKOEOy//
 A6enqzkwrKta0hBeJMqUS8NjKen0vZz8dC9Dd25Fk/ouZWRqBURZZrjH4CKEvpaaUD7NAvWoNdQ
 lASavUp7w=
X-Google-Smtp-Source: AGHT+IH5Mg2HskRX9zSvbDp0N6LssKr6ptcvM6yXZKesT/d+jvQV4JDbjqDgI1FT0A/N8YKsAhsAVA==
X-Received: by 2002:a05:622a:4c:b0:4a9:cd88:2ce5 with SMTP id
 d75a77b69052e-4abb2d956c6mr48845591cf.43.1752848206908; 
 Fri, 18 Jul 2025 07:16:46 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb499e91csm7558341cf.19.2025.07.18.07.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 07:16:46 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/6] bloblist: fix a potential negative size for memmove
Date: Fri, 18 Jul 2025 07:16:16 -0700
Message-Id: <20250718141621.3147633-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
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

It causes a panic when blob is shrunk and 'new_alloced' is less than
'next_ofs'. The data area that needs to be moved should end up at
'hdr->used_size'.

Fixes: 1fe59375498f ("bloblist: Support resizing a blob")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- None.
Changes in v3:
- None.

 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 488908f605e..550c0c78ffc 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -335,7 +335,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	next_ofs = bloblist_blob_end_ofs(hdr, rec);
 	if (next_ofs != hdr->used_size) {
 		memmove((void *)hdr + next_ofs + expand_by,
-			(void *)hdr + next_ofs, new_alloced - next_ofs);
+			(void *)hdr + next_ofs, hdr->used_size - next_ofs);
 	}
 	hdr->used_size = new_alloced;
 
-- 
2.25.1

