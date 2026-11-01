Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED7606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LVzcb9AY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hhuxYOtH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB3A340629;
	Sun,  1 Nov 2026 21:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9OQk9Z9lOyM; Sun,  1 Nov 2026 21:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B51F405BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567161;
	b=A006XHlAxkhDJK2LLncS3u0NzuzgPZaeCMusFgiQvphYDZswvc4Lz0fV+TdjCShASYf0
	 bFTVy3ANm4+ePR31NLvQPOrwUaCxR8kkANaaIoleCdo0sztjMO9iH88YbeGa1YCG5oTbd
	 FPvG+jUgGy5urzx2uYuxHJIPEhrG/rcx+Lb9rh11CcXhw6zDUnMCTOoqbq6bWpVbxmupp
	 BBCVxednHn0dbuaKGjXIaZzX3cfx95MCpOzLqZSS3hXf+APIYLhFgOq9wga45ViiwqW8c
	 K96NnTXgk/qcMkI2ILCHOTymiTVU6/tQ7s/LC9ddlZYe9BW4VJOQVacBxPM8Ra6vMBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7v1ump69XhqdSRA5wU1K32i+SCIDwkyNGNBC68HInCw=;
	b=EzkBzJ8hewgqvHICIjJBbEZUSUnJQ0dm7iitBDMgWKfID+q/oR8c4+c3y02PwFQNhuMD
	 KhCaO7CActa6gpZIMEKcc0Q/GEQYwnwe2C38tta1eWkNpbfWU1wNdHywESCmrsUmkNCS/
	 tZ1PfGnO7moTmDComBLEHBTpVjC6KwjJvsVvezmL1rV/ppXg01nWBqzvNnXECcvFigQs5
	 J/DwmCUXn6f3YZs2cN38+tuOc+M47hbfrlj8vilWiIza9LoP+H1H43Dtf2mWBjUe8d61a
	 VSwnyEYaFOb2lk/BnUDP8j46GCJL6ygdSytidqkPDwvnS+9TrEhlDeHO7EPTsZHppDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567161;
	bh=7v1ump69XhqdSRA5wU1K32i+SCIDwkyNGNBC68HInCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LVzcb9AYbjW5Hk81NCHhrPqKGc/4qjZetr4Kc2nj2RaqEcW8xmaqz2tWLnjmMZ3b5
	 NnykNYvjw1F9jZ13lQ3P7NXsDgqI6uaH/8kgvMXXrGGtgTtBLY2VoX05HNWMruNusj
	 6YkX2BY8yzCnjdZvLSflwRW1/AO+F8e4wfePAoQjekWRFTo/aTgFS39Y06IPgv1AkB
	 GFsR53y3SbijWZyQrqjT/f189uOm7tj1c+mPwqUnap0KyZqV/iamNxVMMZUUYBvRKK
	 He1LWlFR6eAWhqNP342Tu0pjdI3/aNoS1k9SlReOramMnCt2PCNcnpv38LpAnzXq1U
	 m4Qzfp0UySBEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B51F405BF;
	Sun,  1 Nov 2026 21:06:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A90D435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C5FA80DB0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZxx02RM5PJy for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D69B80D7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567159;
 b=CmoNQDHMGNM9o3AwsDXuQ3vTzCm5yZB2Jo3OBGfHnWJGfgqzqzqouUVk+ZVh9rGJgY4Y
 0bdY3YHX5moMhZzRrlAswUsWJpRfgqnYQivOKB0shv7FAZ2g77O/HYDY75IMtD/f5UPYA
 EpmRWBMS7/ly3q/EfnH69nV0teqPsNC1oCd+0q/I7wAq0A8hms1JeWS6DflGfQ4PBH8N9
 OD/bHhgLtnHzvD8rSfaQwAhAWi7dqyuCXzzKdsWUunTmyoVJgqCYu0Ld62VSlwqhavLm1
 XBgzFNw9dcjPU6ZRCbo3Zn4uOl3cnmQgSUCHOg0pKfUpPa4/x2+Iap370eD7jrrFfVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567159;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=7v1ump69XhqdSRA5wU1K32i+SCIDwkyNGNBC68HInCw=;
 b=dVUiffBfEVQHstHtip2bWmw+3LguUd7y4wN5VxG+iF3hpW9pM62rFcgFdjJJ8uqTfboq
 HPWJ2GxcwxwzU9kO0YEU/wZgeWj3giI8sufHrCpuidM3JiPdaeg4o3DxFTLcz9Kiccgoc
 +msGraHUa2rzKobiwVBiM83IHTvPEPClftEnQmsEnaFOUwERZF1nK0fRELmABNgv7HL+u
 21gSy1Z2kNKBYk20JxA7UzDGR4Me2jYuz35ehaWBZsmjt8t4VG6KQHreaXjx9cmCCi24r
 HAzidXtRGCT7Sv32hOHcnTOUoIUGA2ZNpBVkLHhEHM54bte9n2Qv3v9wnZWWIIpXVBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hhuxYOtH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hhuxYOtH
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D69B80D7D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:58 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3acc7a0b558so7327261fa.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567157; x=1794171957;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7v1ump69XhqdSRA5wU1K32i+SCIDwkyNGNBC68HInCw=;
 b=hhuxYOtH9Wa8ICfnclaTJForTPSLjGCaC/cTUCxvnFPZKiRPZ1zttmAe1xotlZh31D
 30o2hLKYGlGFbyQLKtWOSjMDuAbWvLCfA0f9ANwdW16//DsdZqbfrQs+po9fubKtHWvH
 Mc0/we4dhQdJhiUR5w3q6Lk/VuP5XOXjjWshZpgn/kVgkHKbofCcOlnDUJy7zOGD+ctk
 8+/YsVCTOD3AFhBvANF6T3o4/jzGAnDB9sQ28JYR+Sm7uKWESfh1y1Tc2HO0qUEAGslR
 qyDRpwqlIQ8lRZgWNZx0/OTYL305cxG5XiAi8l4ANISVQFZMuKpP19b6h4amV5kSuRxA
 7zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567157; x=1794171957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7v1ump69XhqdSRA5wU1K32i+SCIDwkyNGNBC68HInCw=;
 b=aYbMEH5J90cZZ/lSQ/f2tzs2NTpU8Io8PI+8FugSCX5YTdW1L1tWwJiFmEtqXamslu
 YBrPfADlUY7lEhGyMQtVkbCc+5aBun9O+D5GfAv0o60jKoSwuyfYWmJTGEj42EByLMVV
 vIIh6AgUABS1EVY62FPBrfmL2AP77anxvxGLWea3pdRHGXYsm8RXIcCo6YGc15yG03c9
 Mu/U8z5OMISmqa/C9BwYLvWr0vjjeRfrUaAjC3jSbZKJviU3Bemz0a7bKupEjdy43BNk
 kYTjlI9NyZ8PnZfULbG2d6YsP1LHNZmkHOF4LO6xgHdIPNWWXiZAYxpbDY/5VaSwc7EL
 gStA==
X-Gm-Message-State: APuU4Z+NjmexGHciO8SHjCG/csR+gaW4dJlfZhHbW33dNN0MHmQcNjRo
 /+RLT0ko0o4LvaYoynshWIigeO3755TqW8ePo1ZdIjRI5jDmlXljEWXicZ/U1DG8
X-Gm-Gg: AYBFou3Pz3nrpm3r1WoG5nDJUtyiErfVjqVnCqXjQnztLMYFps0ycbl03uuGxlVdcJF
 xWCR8qyJIaVHdFhHpxstn0rLPNIcZzljbYPrhdxVL437giOZ7Rd1T8fVew+ex0B/9YqGRFtp0D/
 rebqTLFEVlMVsTTpxooDLRxQTFvTNEZWZJ2i1JiQlGhSUXlK76vMgIxR3fd7vTMLUqWjlKGXRwj
 3LW8rOVFcbUQvFeOuiUECHoUcGSUJq5HHvLRSoFoSo9ZkzcXHSj8UFkBCFM/S1LckPI477LyPD0
 1/LSugxZmsImcm2vzMPi8Citb+bkhm7gRMG+paghE+CPj+V6kBlDiBVfDQRiMPMMha7tK+8mlmH
 wTf3VUKUryhdB48IP2oayvo0F1uu3yjLN7iprQniQytEfwVgOTIfKzTBEKEREUXephWe2B+wbsJ
 Fjhczau287kglJ1aB0pusdE1Gn4mBbKyIaVySlq8sY4uKykDGjtZPr7nsbHaxacU13Aqt6IfnD/
 deTD+BrQkWR9BTELHrzKjRJDnV9z+//7bW8GtrWTovSeuVfzPhSMvAa9GZn7wp2ji/5jhBiLP7w
 vtt5Mtg2OKZ8QBGJlhQ/w47dWFCE6TnejzthJ5eyYyxl17AOVjCLERFJ7qfGJn6V2N4=
X-Received: by 2002:a05:651c:1542:b0:3a3:749e:319d with SMTP id
 38308e7fff4ca-3acb7ac56d9mr20156681fa.17.1793567156622; 
 Sun, 01 Nov 2026 13:05:56 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:55 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 08/10] sunxi: mmc: handle D1 PLL6 clock rate correctly
Date: Sun,  1 Nov 2026 23:04:47 +0200
Message-ID: <20261101210449.1235102-9-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apply the existing MMC clock /2 compensation to SUN20I,
as already done for SUN8I_R528.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 drivers/mmc/sunxi_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 84f4e4c2198..c5a93ebbc80 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -97,7 +97,8 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 		 * like for the older SoCs. However we still have the hidden
 		 * divider of 2x, so compensate for that here.
 		 */
-		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528))
+		if (IS_ENABLED(CONFIG_MACH_SUN8I_R528) ||
+		    IS_ENABLED(CONFIG_SUN20I))
 			pll_hz /= 2;
 
 		/*
-- 
2.43.0

