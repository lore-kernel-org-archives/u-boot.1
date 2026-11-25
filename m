Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE1606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J22pZxfV;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T69gamZp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CB0E809DD;
	Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aahmPo8t0wW4; Wed, 25 Nov 2026 10:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8FBE808C1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604323;
	b=riP99GQLslAkSMTv87mJj7KEXU20YMOf72dx+hIVn63gq+a0cBnSIqPW9dF4bMjTwOlR
	 n4Py+c1E9kJKHM+j6yaAlbzBmSKr1nG8hPffVGk9wWkiEuO6nsX2XKRz5GrT4htHhYnbI
	 9Oavc8B1fnD8VkyPEp6RgLHCxMcc/UpwGLO/1/v52x667iqvlNSyZ5gDj6/PyF3L/RfXn
	 754nTZu4cukLZnRBJKFZxJHCfCIgqbS/bJkbBpFPEFOQVgkaT1KNsJWa2nISgKfc5AwWd
	 rYE9dFx6skuU/lSij29SJ05Poe8mm2lmZcpPzk7x5urqAT//vjbRFLFCz5hBSWuMPmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JFuSi+LyUj4v8yHLPN285Vqc3LdPEjQJ23SrwN6tcu8=;
	b=OJMF1I/WVZC3LG2V2Nvoq94wLa5snX4xa+XpfjGrp/G/dp/Bw8uGtbgB1JQjAIRvhRGs
	 IsdRBpoMHKr+lIedL9KjQKLJ0cuMJ/D936ki0xRPkTF6rRC19AAWrNO/IT5mn+OKj8S/T
	 EzEwmtikJ+Ly+q4aVRUvtDf0B9wC4PMksZbgnQqZ0VlrcxY0YJ7VEOKMWv5lrp0ILkvyS
	 j+pUF64NHBA7wKsAM3D0mXNXl/HZHRLCGdZlwQyM/VLbzwnv65uoAjkaqcgzeJr0H+nix
	 J/oPILaUdaTBtTaw5UoUuZB4iW0p53Svnx1umHpQrGiDy9OsVQ8zp7clUVdo11XF2Tw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604323;
	bh=JFuSi+LyUj4v8yHLPN285Vqc3LdPEjQJ23SrwN6tcu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J22pZxfVKTFcHu9XKEAlTFS5Lcw0okSn405OtTMlP0ayZNmAPaU1P52jazCZG0vzC
	 IRB4YNvyF268tzRyagixEbG2TxrV2WanyVi0iw2SqKjfrbG7ncqdIAB/eZhAqkxIUM
	 cjOCxigWVDgEFYkq1iCnxYky0KxC5HxkltZPsNWOXyWzT/1H3M1EL+yuZAnBH7vJUW
	 CUEtwxlvTkt09AMgwomQYKYJ0Fj+KONU4MDSKzgOAVXMXxiDtnj56uMWHX2aKphZy+
	 FVAc2kTq6l4D7q/pfL9AFkNsWx+5jLUale3tyWbNd2nhMas61mrW0TPe35fTHUyFYt
	 RfF6weE3e/NHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8FBE808C1;
	Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE5D2F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC4B240180
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OgYVjxuvNVfP for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CBE8400D6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T69gamZp
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CBE8400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:35 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so3178637f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604314; x=1796209114;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFuSi+LyUj4v8yHLPN285Vqc3LdPEjQJ23SrwN6tcu8=;
 b=T69gamZpLF2nXNZd+hmeX5mS1NatrlswxE+AwMNlYvjT2xoRC5Fse9NRlBFxgFjMkj
 7W1Q2e5bUlJDx/D3fGlUZDBIKpY7q9QDoObpkJ6XjfHUuAz6e8RCsdFyqk4pYtcCOO2s
 vQXR2LhZDEU6Vm8PihG9a1Y9f/s+HtY+0Q9ItvPTtkiL2z7k/QfmCbijRvPBoUiaOoqf
 E6Yh3neRaa7EOccwZ76qv22Xc/uapG4tiVWJGrdhCelAlWbIn2ShwrSzoGE8C9CBDx5d
 jhK2cdS2Xiv5brgsvDccM5uAOu8/QEDKOIpR0FIbGrDaLURCRyIpQASt4SzezevZ7Dtm
 /3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604314; x=1796209114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFuSi+LyUj4v8yHLPN285Vqc3LdPEjQJ23SrwN6tcu8=;
 b=SxSremOLpN9mu2XnLjLl9dCULXKMIvoqIK6SPzU93YvnwnJL+xSFkyfbzYjk3xGaLS
 lC7lETg9QnurJXhQg69W4dWdfXkt2KdtskaJ/w2L5FL5jEVqlhHQSWMwaIsqZ6B3cEZc
 0VvNxp7m21PrXuLdnsjQldh21pjkE9LEFJL8CIa5LLTQ7I423g4IzIDq4vr7L/btssJo
 axuKFXwe9BDNyMSxVfLNIMF2CHXRym4moTxzohqxysfqnU4PnDgZskQeohr05b7iFKQM
 cC6BRAkCdy1A8uiTTvtfimgoawXNfo0dAXkBExqimkTuApEVQYx8BXyCs381saVlsOI7
 AYDQ==
X-Gm-Message-State: APuU4Z8yDT8V8AQltFV7EX15ABhFxS1bQhHKeuCaUxm4Z/gKKAvyH+ej
 P2+1F1Cs2krUn4HtFdx/g9VAuG5JZRh1VZtzbbVtijL6G6/30qCa4HpKu8jfArpJyAqV6rowdi/
 83vbooZdPLg==
X-Gm-Gg: AZFdTZfKOmJPOQdXtg8eZDdGh9mlMROEosSCkAXs+CbdIULOmPtob1rx790ytHvfk33
 CCpUY0xrwBXzCuAPa70HXYuVBQMT1TqsgaOFQLIcoctGxsVDzSPXpqhek3loT62U3o5RhN2tYF7
 7BqDJIeylOQJw5YuC1BOXo06Vf0F/FIyWmRY9XHEJlCPxPP/1h9ewjgFzq0thXKY4uWVZ+lo4t9
 wSZZSWQvQyqRXKpzTH0CqwrLIgdJd/f2NLSyJAmMS+xkjW2K6Wj+DQ58VfAgqCEDSDPsYC9AMrN
 cVuXxqLbEtDnufvr3eRUTfrbV5geBbMc34WIEnOX7lSNhqUKErkDAPf2qLLGBfJ85n3fV3NnZsh
 00SPD6YWgnJn7WBGDlmgEvsmpzm9VtZ+6wFG2sV4VfD56wD2npTFRQy+T1u4cglh4Ip+FNgNE5b
 7RwRYdHrukNJsF6skcQ2/nONZs0URAXJF2KqmyKG7TcsVeu3RLwhDIqOPz3JWTrc81OkcdIKyLL
 8D+2YTxuGs4iO+fXZIvDdtXedpdYQJBnl/29j03hZPDmKTt9PhZZf3XAzIomz7wRe6LHl3rFD2u
 03SCYx/ES4y+MeylxnbeY/iGkaoHA2vHyEeUQTJ6KV7AWVmDQgH+
X-Received: by 2002:a05:6000:258a:b0:4a6:4f35:1bdb with SMTP id
 ffacd0b85a97d-4abb44d3448mr35122165f8f.39.1795604313921; 
 Wed, 25 Nov 2026 02:58:33 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm12945986f8f.12.2026.11.25.02.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:33 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:11 +0100
Subject: [PATCH v2 02/11] env: flash: Define env_ptr in every build
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-2-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

env_ptr is defined under an #if that lists its users.
The redundant save stops using it once it moves to a shared helper, which
would change that condition again.

Define env_ptr in every build and mark it __maybe_unused, like flash_addr
next to it.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/env/flash.c b/env/flash.c
index 31dd1656e721..0148ce2b835c 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -43,15 +43,12 @@ DECLARE_GLOBAL_DATA_PTR;
 #define INITENV
 #endif
 
-#if defined(CONFIG_ENV_ADDR_REDUND) && defined(CMD_SAVEENV) || \
-	!defined(CONFIG_ENV_ADDR_REDUND) && defined(INITENV)
 #ifdef ENV_IS_EMBEDDED
-static env_t *env_ptr = &embedded_environment;
+static __maybe_unused env_t *env_ptr = &embedded_environment;
 #else /* ! ENV_IS_EMBEDDED */
 
-static env_t *env_ptr = (env_t *)CONFIG_ENV_ADDR;
+static __maybe_unused env_t *env_ptr = (env_t *)CONFIG_ENV_ADDR;
 #endif /* ENV_IS_EMBEDDED */
-#endif
 static __maybe_unused env_t *flash_addr = (env_t *)CONFIG_ENV_ADDR;
 
 /* CONFIG_ENV_ADDR is supposed to be on sector boundary */

-- 
2.56.1

