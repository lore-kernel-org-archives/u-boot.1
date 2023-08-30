Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE0C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732E58669B;
	Wed, 30 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NjTLcb6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B6886567; Wed, 30 Aug 2023 20:06:22 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D377A865D9
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so2321539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418761; x=1694023561; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFbsrgJ4WmSH9Ug7jXFa449YGavBasIps1+bY+Itlag=;
 b=NjTLcb6rSECC9Sg2ZmmUMfvR5LG9NXIjbJqWC8gghfSUVoy/u+JRfvoMUMZTxqm6Ye
 3nAtQHgIIC+InuCkSXMB2ahSqOCNqK6UCPAlyVgteoe+W45nA4Uc4V9JC+SwK1eFnndr
 M4UF4dXTqJdkiBIWietxX0xAoxAYlx6npX68I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418761; x=1694023561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFbsrgJ4WmSH9Ug7jXFa449YGavBasIps1+bY+Itlag=;
 b=KtQpUa0Z6z16QSF7tY49MxhSj5oB7GeSrxPNWdPuYG3E1zTVHcLWc9wK8IIpPBedj5
 9c6y0Se6ye3Qpt3dEXk8Prt1HN4GNzop/HURSMOPz/0keiK5i1KXVslmy74W+1lOhAMC
 lXQ79QqaYBRIDVoIvesmborZPOb2j929GwSKeYXEFzJ6DcAQojT45icDSuAL95i9c6Q7
 Mg16Z+dCAs1SChF5+/NP3aHQJESuKvWZLdP+fSRHwyXPgV2U/m+btKiDB3HNfvo5R+b6
 X2qv05nbfHOH5GjpkdguEEcTaJgy0akBVuRoqcwtcmI3ej16UZVbfDMEPf/q+eyCO+e5
 N3Lw==
X-Gm-Message-State: AOJu0Ywt+sA5YvTuKwh20KJQ2IhqvvJLDqArYH2MEDme4bwg3qCPeBUx
 ZgqxBC5Di/sHVQpA2f30NYyyKs0DVkrGgD52Bp0=
X-Google-Smtp-Source: AGHT+IEbHVJD2+odWSMtaphhPuxrJzB3JJI4EY2CcYHNB8jka9OPbPk1fyg4EKS5Ck4dvHqZil9J9Q==
X-Received: by 2002:a05:6602:474a:b0:795:2274:1f3f with SMTP id
 dy10-20020a056602474a00b0079522741f3fmr2849136iob.3.1693418761391; 
 Wed, 30 Aug 2023 11:06:01 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:06:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 27/32] sandbox: Only read the state if we have a state file
Date: Wed, 30 Aug 2023 12:04:58 -0600
Message-ID: <20230830180524.315916-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

We should not read this unless requested. Make it conditional on the
option being provided.

Add some debugging to show the state being written.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/cpu/start.c | 8 +++++---
 arch/sandbox/cpu/state.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index d4c4d071aef..5a70ec9ecb1 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -527,9 +527,11 @@ int sandbox_main(int argc, char *argv[])
 		state->ram_buf_fname = NULL;
 	}
 
-	ret = sandbox_read_state(state, state->state_fname);
-	if (ret)
-		goto err;
+	if (state->read_state && state->state_fname) {
+		ret = sandbox_read_state(state, state->state_fname);
+		if (ret)
+			goto err;
+	}
 
 	if (state->handle_signals) {
 		ret = os_setup_signal_handlers();
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index fcc0028ff4a..e38bb248b7f 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -521,6 +521,7 @@ int state_uninit(void)
 			printf("Failed to write sandbox state\n");
 			return -1;
 		}
+		log_debug("Wrote state to file '%s'\n", state->ram_buf_fname);
 	}
 
 	/* Delete this at the last moment so as not to upset gdb too much */
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

