Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71E606D813
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lwip0Nl3;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fBQrH+He
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC66D81C6E;
	Sat,  7 Nov 2026 14:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MC_GDT2DJ0d5; Sat,  7 Nov 2026 14:34:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B9AD81AAD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062060;
	b=JoUH+aXjolgwbl81YX1eOEPG2YZH+NWqEnmDRIxioNiMHbiiEDVGau9zmwigHh01bjjk
	 Msuka0UKepMQBNsbjzpw2x6Gjwj4vU4k/pvrqeGxwYQXtvfr+RrbPyrf+26ajFnAtgwEK
	 9jDSdHcIDLvuG+eNH7HV7/uebfLgkPP1YOeffEDZ1EqzWQMgRZvDxAMmDkbZH923B2kh6
	 Ui+7D9RAKHpY1x4faG7EX5ACCL/CBrTBBl93YlqmHAE+nWuCD6xsps+YXdZKdJgLF6Q8Y
	 yuBZnB9pYiObyFAspztFMWCc0woghsxbr3yGHEhi66DEYaVHkn2lWVyqCtom0g10Pzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hokDct9bi63+UI37U6Y89DzRDWHxv7ijKQymWRSb8x8=;
	b=mIJmaFypYpQDHXByfVFwaM4EWZR7yF0o943RLFqmr6OHUMQjfU0+fB37JtBEygfhuPkG
	 hopidD1SoVwm5WCXyDFKf0t8jSP68LjuIAE152UttOz4NI4di5qxbSJOPThmraX5TMorh
	 LTDNI4MuTzlx95iRTPg+2TPhyvbfCpVof8ro/IW+jd5UcbIAwWThDx0ck0WWcXCGuDfh5
	 jkjzOhiRNzG3Ta5sVuxg7/+dzh0SlSd/cFr3ydwtUXK6XRvdnxtFmBs8Q7OykEAN6VooV
	 YOVQskyAMj0UP1tRRg0banx0M41FuoZjvqavRvC24IYIao28qNyfTGjqdrxRV5Fb+Tw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062060;
	bh=hokDct9bi63+UI37U6Y89DzRDWHxv7ijKQymWRSb8x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lwip0Nl3kt8K0CFTY6vqMAW7f7b6A2MHhiULobScjYecZrduuP/6m5S65B6qImK/1
	 WDmbwDT+UMAKQExW5G0OWefSgcSaH7CthML6aRY1h0PAeXpr+ojm5A3wbYHZu04FP9
	 R11dHB/W6Z75rXiNyyZeG4KgOwUtruUVNe1mrIP97ll/2D/ZXCuptanJGaTSlafy/l
	 rZDBv8Kyi5RCOgrY9J+lz4wDwdiWJue21ouCHaCuXo9TKdFg9mK//Vd6S1tAH8dcaJ
	 KZRGldgMEXF8t1FI7+kURHfizq/wZTO3AQeL0jZsjLfNg9GHQLFodWdNcz6pUIkVWr
	 Kl9N0EhHyY3qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B9AD81AAD;
	Sat,  7 Nov 2026 14:34:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 322F84B8
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2167340757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0I5Gt9Cnx6S for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 427204075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=fBQrH+He
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 427204075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:47 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so240108f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062026; x=1794666826;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hokDct9bi63+UI37U6Y89DzRDWHxv7ijKQymWRSb8x8=;
 b=fBQrH+HeeqJl03Wq09Ce3xURw9TLEbKfwb+2bXRsKsTBPLYEV7SybNGEDaoW/f8+Hh
 IRY5DRfAtbY7JfUSbXpWH62QuqiqJU/L+5SEI/7nW4yMubxXNFTHc9zTOxuHnINioE/s
 oR7vtF25zH/31nGBxKsWYR8dftKeVWJVAg+gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062026; x=1794666826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hokDct9bi63+UI37U6Y89DzRDWHxv7ijKQymWRSb8x8=;
 b=lt8tqsNKnO4lI1mN7nLjdgZ91gVbbnLO8LyRg7xjL84IqBgi40h66WIF0bnbmUdDGN
 A6ZF1H+r4l2J9le1hgYmVAxeYH+bThIYyyf+9Eo+gjiUenR+1cf4wcrb6mbc3YkVyoBa
 tfdzIQPlIvuoyvgzKPZHCDoELMjdiUTEpXUUTatU92wuCQi3Lyg3WRRmbrCPfZuDdbpe
 f8a+QVIxK5puBo8DM0b8RRk/WKfmkMWYZFZBXLesJtge5aRjYpM4luzVEeQ3EHi3oA8a
 lkVTsbrJhiKdg9L6RP4Xd0UuO5xXaSXi2b0ZCX/qzSncHd1z+sKzn6wrZvbvnoihuB4k
 72Ow==
X-Forwarded-Encrypted: i=1;
 AL+hErGk6YIooL7d17HSoBErb1jPGmARlLyluSuK0vmHz73GDYrXYI2Jt9zMiKpWqGIhoDOY3v6dES4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+4gx+f30Fq2Xzui8fX8qxrClWJBD1CSRa2nUyrhl08fSML1Vhr
 G0oV+Zq4/+uiCxbSLtKJSvxHjIcFH87HTlpgsWgxqMC3aX0uNykaDTx4qAtN3EJHggc=
X-Gm-Gg: AYBFou1VRUTsaaK/njkDM18atBfdLPqkCLZ5EOOzhl1TUJRw6q2MzIDDdlUgNlh5IiT
 uRsaBgSgy6PW63+kBfhL/JK+e1cVwYDe+VvGsl1KGBYOgPHMsiH0u2uHOdFqtojdo0C7TIlLI9L
 59m3FF3G4RP9MWM0NEc2IN/vKSDwtwkR3gVjeS4rquD0U+mj/wlFBYogQor6XC9CRZCNEOz5Syq
 gIhOZAl0/kEnkTxpJgsh4XQyOoDX7pvjIs4IXR86GJ8TMt4oxb/105RkOYwDlsVyyATYJ1Ds5uj
 jdbVj4wd+6i0CnCNuJFCrQCpH7SrQ9D8Wkb6ZWIqnRBNxqKL8rXy/PoOsW1twtwULRu6nWdy2qn
 oFhgtX8uL1n2fKYOQEuzklWWFZjgoVRdkuj7YYnaJww+muvR0GGlrRhNeg8wF86LYV2elLR0RoY
 N+8zIwglRyJHMKWBLpcTfO3mA0RIBG+O0BTFu3C2XOTeh0M7bSOFU0ZRG1ClFYFKMuvDfuLoSXw
 q0bE8Q7KIbNHqCtN12DerC55zm8UzVkoE0PxET/rUwl3B3k2rDZx1qcmPqiyCDJw2isN+u5x39S
 jw1uk7UK9jklTaYh6puMMR068xbkRUROhKX+qFBUMO2KsO0aJHGcZ3ctyJLVwk12JZw7iZCgM/i
 K+hWKqBsd6D1uzCPtbFSSsyaHlIGGv/6mdX5SpDjtEytSDI0Dpjs3cFLPwwRUswg7CFYGIDQsRA
 yBg/ZDsaZH4MAmFqwfMyjzga/6uw==
X-Received: by 2002:a05:6000:2011:b0:492:7f3b:8cc3 with SMTP id
 ffacd0b85a97d-4927f3b8d62mr11752856f8f.29.1794062025956; 
 Sat, 07 Nov 2026 06:33:45 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 30/35] boot: extension: allow longer overlay file names
Date: Sat,  7 Nov 2026 15:32:20 +0100
Message-ID: <20261107143241.2236511-31-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The overlay file name is limited to 63 characters, which is too short
for the Linux overlays named after the base devicetree, such as:

  st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtbo

Increase the buffer size to 128 bytes. The structure is never passed to
the OS and all its users size the overlay field with sizeof() or
strlen(), so the change is safe.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

---

Changes in v2:
- Add Reviewed-by tag

 include/extension_board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/extension_board.h b/include/extension_board.h
index 0b9fb99ad7dc..f72db21441da 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -62,7 +62,7 @@ struct extension {
 	char name[32];
 	char owner[32];
 	char version[32];
-	char overlay[64];
+	char overlay[128];
 	char other[32];
 };
 
-- 
2.43.0

