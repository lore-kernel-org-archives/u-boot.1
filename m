Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2312606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eMwIYjvI;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kP0zZ0mj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E5AF807F5;
	Wed, 25 Nov 2026 10:58:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7byGeu8NXfHM; Wed, 25 Nov 2026 10:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4B7A80ACC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604336;
	b=Nj4VoxG91OGK7h/0JcWqWzEp70o1MtiY4Bu8j9W0A063UdfFNxg1JBd4tYDr0poMucrC
	 3A4b5Ei4m9wAoeuvzbq9zeP6fdwBQMUQqpzxaZN1PC3etOkl7ETYaVYlc2dDpbUg3SPxs
	 inYoHwUHcreYmR3KpgR2yK/d8MuWDDEEI79TDEy4iPfVKglz7xIqNFTVSRNz+ROkh+BRc
	 LyG8kd9ACzeKPeNTPlTbpjHCY/nrcZzVlXfO/JQ5RQF/T5TA9RLSicDbYb4DqYcAESeHc
	 zl/XGW9s5JRBkhgaZBTPnxBT6rr22ij/p5KSl+pE4S7kCeq2cMib7NcPhbdUBdnHMuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HAVusIRHulo+jziSPxksTCKhgPBk7yzEarVNSsSKXwY=;
	b=BrJieCl7ONGDAxPe3WZo5TJjHTCPvYUH26PhETDmRW7+W7+MPtqVaHRh24jefezAqQyI
	 vAAmE8/VJgYs6auusNMmZUH54heeILKvz31yS0XbhPNKOTSsXa73CpjrSPRoYIJQK/KEk
	 zIMc/fXLEaqWYsX30n93/4AcU4eEJkb0F6WVXV5g2ynp6sKGU4RhlAHNlsIdho3OAXQ/S
	 oW9NembP6ukWmaC1zd0D/zyQQhr5sXohbsvCo8RTIFY+AJTSCXqPq4fJYghodFD0Abzv+
	 7KCgOSF9/mdqCR6mHIPM9N/TyqjT0zZy7DrA9dGs4F8N9h2ppQ17lAB5+vvX1DEgDTA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604336;
	bh=HAVusIRHulo+jziSPxksTCKhgPBk7yzEarVNSsSKXwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMwIYjvIHR3MWFSraPky7mxrxgkliowjMO2aE3kUJ4RlTSFiNTTOP+1sRlsWPKbRn
	 o/B2rM8wlDTy1zNFQIDFvTsTpD88zFx6u+8DuDmWApNup8HdQ2+mC0bBRLajRxOofr
	 pvdV1npIemXmkMRo+VzN688OSjtyo4nuhBupEbDeLlWYLhgh6ZqdPKmG8tXC3wArHY
	 d21Geo0V4v5zALXIzZ6u/FCBENHQV6O+GBQmPDyq2lFoZ7+K7lqwusc1CI+0VRlr4a
	 oxnYsufEXCPxp6+DC0hXH8cVjjfQUUpnySxoBZ2kJaCwnXpD2LhawflBxVbzfZ4AEn
	 9ITiyc+d3ONDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4B7A80ACC;
	Wed, 25 Nov 2026 10:58:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCA632DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B39E3400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5z2gz_CHJXqa for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA78940180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kP0zZ0mj
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA78940180
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so4359205e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604318; x=1796209118;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HAVusIRHulo+jziSPxksTCKhgPBk7yzEarVNSsSKXwY=;
 b=kP0zZ0mja/QBW6cL5hXX5kbvN/Kc924TN3+fNnEWuRRir6quYlXRcKNVVlDlBaRxF4
 Pe+5qbyiw96bxUS22cTqeC+rOcgv9WyT57IUYy5DvQP4TUAWdZRuraJpywB1y0BbKVn6
 AdO0107PieeiW7aHA1/jpFpMGjg+uvABU1xkXP+2rhj8C2tulmkoxY5pjvQhq+rrdf4q
 86uCbacymGD4Zz+89c8/0t2TWz88tycqzCnx03PrWypx3CCtMWy2YGvze5aLQX+D+f2X
 e81hgdDqibAGTKlYbX1OcCz5I1NbFhXU8lPB1SyYHKTkxdOe2/sYbL//VKKj668RRNX4
 KHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604318; x=1796209118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HAVusIRHulo+jziSPxksTCKhgPBk7yzEarVNSsSKXwY=;
 b=tFQ86aVLJ46sKtD7en+ZsCkqC9OYCZenpxaroA085h6sAg1iMg3SPKSTzM3CecH3cR
 VOJ+HyPxKHFylkqxeIy1TXR1EB+wls8xPLYiAUuAU5QQ0yl97qfrJJ6C5fjezIjle3QY
 RnkbXqzk6UDEQn/W4oAyV544W+jCiD2Q1Fynifc4lnNTTyX3CdEcxJIKnD02XB5QhxKH
 SUhTKllDXWNmCLipYITut7txz52pwXkoI/Y8GWNEnSYc+9fBkcfHRM6RLUyWbEZ8W0IJ
 y66v33sxY8F9aPk77FjXNj+qkL6lOeL1kVb0OVYPY3sLhsDaB4F/d/TlLdKd0ppM8nlV
 n1lg==
X-Gm-Message-State: APuU4Z8IIGAc7UROXlQp4zXf78S5uRNkHnf7jM76yzg13qExrRrLD1IG
 oIcR5hsHX9VlBu7gvhq/bUB7H/Bt/ExNnZEMjp/5IDNw6xK2UuEautr4wCR2EMoxKSQkbSQMHOs
 WHZ0L5wr1tw==
X-Gm-Gg: AZFdTZdIo8JNKU00SbSo/m2TFQFm8jDqDhXOaO3mRhSXUEHsEdtlfMrJlVwfoBmLEYg
 sqHC/OyB4xJ7RznRjg3MIN/9TqRJeYJAqepMm4td4peceAg8K46fmOLDa2DGS4HWavQtvyNwuLn
 3DdPUkYNeBTnKaUudLvG0OQ1bVDD+EvsoMyAGkVtPOv5lEZhVpMHGYom6Z0zeJB77X00rFwUeOS
 A9a3h+E3DRkbRMy1H5mjgHdKOKeBZYlJNL/BTMm/46Kv8fVbvD+J5y7emI9HyY8Dd1NufJymL1z
 zvDajdxhMiU5DeXbui6kZp7QjrKi/kJttJsSWDAQdwuy63YDw2Ms4fdMEheYrHwA7MCNC6XxBE1
 2QIEQYbXaJWNNobozzoz00H58d/2iAsAbGpC+ryUQxql91qd1Mr8JUbQBH3gSafIx8g3HGv5q8a
 PFEE7qxZAlrIM3t/lFtqrkNa1+dUoSj4Jm8j2StRLOlq2CnsYCHaKJPLSuZmVd8oNaql0j3H0zJ
 bUASGUtNEnD8VRiWNCoTtAkHQdnR9dSzuXAaigPcIi0pyj5weEQZUBQ51GAV8nSsz6IGuTFAA1/
 pzVotzLTEXnq3WofqocxEuOTkDXYgVAEfzfbmnCe18xsVUtJIGM=
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb8881ae90mr364212935e9.32.1795604318474; 
 Wed, 25 Nov 2026 02:58:38 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f643adsm232277805e9.1.2026.11.25.02.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:38 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:17 +0100
Subject: [PATCH v2 08/11] env: flash: Only mark a valid copy active in
 env_flash_load()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-8-8d31a33a54d2@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After an env erase, or on a blank flash, both copies are blank, but
env_flash_load() still writes the active flag into the current one and
warns that it recovered the environment.
Check its CRC first, as it is done for the obsolete flag.

Boot after an env erase, before this patch:

  Loading Environment from Flash.... done
  Un-Protected 1 sectors
  . done
  Protected 1 sectors
  *** Warning - some problems detected reading environment; recovered successfully

  *** Warning - bad CRC, using default environment

After:

  Loading Environment from Flash...*** Warning - bad CRC, using default environment

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/env/flash.c b/env/flash.c
index cd5474acddf5..db6af4b9d76e 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -325,7 +325,8 @@ static int env_flash_load(void)
 	}
 
 	if (flash_addr->flags != ENV_REDUND_ACTIVE &&
-	    (flash_addr->flags & ENV_REDUND_ACTIVE) == ENV_REDUND_ACTIVE) {
+	    (flash_addr->flags & ENV_REDUND_ACTIVE) == ENV_REDUND_ACTIVE &&
+	    crc32(0, flash_addr->data, ENV_SIZE) == flash_addr->crc) {
 		gd->env_valid = ENV_REDUND;
 		env_flash_set_flag(flash_addr, ENV_REDUND_ACTIVE);
 	}

-- 
2.56.1

