Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71471606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iSCHmzu/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AHofjTkr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 460B7608C0;
	Wed, 25 Nov 2026 10:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SV03ASmXVEqf; Wed, 25 Nov 2026 10:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 81018608BD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604331;
	b=gENfqakkYhvhZqDC9+4usNjOcIrtywLiOv6ftod8Bhm9AlNIxv7h05sbPpQCntmHr+mP
	 zOyh2bHvUpOtRStjMefrYVTTjKnOnK75di+gyT8zSqAJ3tkSIlsd1laEJtbkv8iRn9qXO
	 VtwC5vfHqX6uUwLtRGG7QtzCQuvVc3nPjqQDR0jdkl0ehHlPMrAq5MMgKPcK39a9AH+sT
	 zPo0hTcw/3YR9wMghhWKMy7hyB/V+sCfyFY3rQ2Kdbmh9UQOdABADrwAyepiUm9wrB4tf
	 7/k+iVPmdQpbT8dPhZdpTOtZcnpQ95c4zQv+gl1x2JBNPFVD3b1Z1Eu3BdzegVWGwTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qur/TR2ZVZMmhHZ8TH6reUCMvkUoe6Qnuh3gaGyzAxI=;
	b=DOszjNG3iTf4DM2nJlYAgpUPfwx5DSHALl4lEZeE/Stvr+5MYWxVN2+mTzDbI7tEG5z+
	 MTABNQyfi1v7z7h+qThMX/ViCtNilvSUSa1n5XcGaOBscAfN78LMb90kYFA4xX04MRMfd
	 zXNR7RfMomHHEQOp3p1ek4ua9gNWqIx5It/EFOeyavygZiiSQhUE8mK/xnqXvnmV6HMFl
	 HOptYqvbhebi4oNHQI1/euOsvKiuhcsuPkicVYBXsTz6qXF1w7afakr+Rxs4zcVEKLAFH
	 F3LQIIGfRlhhJmO9TITh9YjBkfw23u074CFU2Pkms3GmKYZcP6K4jArcTOKGq51yyCg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AHofjTkr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604331;
	bh=qur/TR2ZVZMmhHZ8TH6reUCMvkUoe6Qnuh3gaGyzAxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSCHmzu/1A/DOq36rhISZu8jws651lga+YB93j9uSXgT5+u1thH7L0jpoKPceZ3k0
	 gyNTycERWcG6+6m900g/+O58xnwyvQF8n7uoVYdOStE/hBYfVBFJAN2Biaxuxngf1x
	 1gbjH3O5/zNHFkdlko4uFQc60J//hJfIbsCoxFA5W/Tiehxr8xfI3EB1yEIWUyFYrf
	 zUO50j7ME8vl4X0pXLorXODI08zYlW2xpJ8N78YCHRxfGfu5wT3zNP6CnToggfCeIz
	 6ll6cKn+2qk1uDc+bNZqKZk20XyxlrxV7tHdnvXwpD9IxJFjypPyRvpux9BySjnXgv
	 y0SQbUNUOLqfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81018608BD;
	Wed, 25 Nov 2026 10:58:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A37B2DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0282160627
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXxvFc_BECTR for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93749606A8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AHofjTkr
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93749606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso3510080f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604317; x=1796209117;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qur/TR2ZVZMmhHZ8TH6reUCMvkUoe6Qnuh3gaGyzAxI=;
 b=AHofjTkrQpEl//K5JkTtt3IjtK3RUDuCLtnM8keggZF6In9hqDKg9MyyMwXYFV/Oit
 HBxClhw9KKIt0gYkM+Gs4xdpBbxYtbwlggHaeKxKP6OxR/kPtDzcMX+hdbJ1Ag3tOhnA
 c0AxNC+FFQScGdpXDWCkjsru16qh8cFf2VUyqAq5Uz2TGUL2ulFLxzFZRpVmqh8mgLbM
 vYK5YmlZGtsJLvU4yy6KQo6o2nQsneZtDg38U6phhjaFvfAsYHW9XOddWaPF/ZZbr09b
 3q8idjp97CZ8MVFipiohGtYzwjUnyk4+jQGdRpojLREQZeDfmphTe3tzxjXA1gS0dMQ4
 MIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604317; x=1796209117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qur/TR2ZVZMmhHZ8TH6reUCMvkUoe6Qnuh3gaGyzAxI=;
 b=Q2hpR1RC2YcwJ61Rk3qFiRrYKkW2Nn80cxjP23cNrCk0HrcejlgO+XdhjFox3w995x
 TSd6R34B0fXDOvlLuZNLjO1qsfw4IDXFObPNMEm4cDK+4UaCG36ed3TXnupZlh+/kUZz
 XiLVnKPXzDUG6kpahYDIz3GluXoBRx+FMEsdEtqvR4wDjmIGbjJuXp43Xt3TKYgdDR25
 w0kbsexulx7zMKWFqNCkQUlgotrWx9hTJXnzOHUJPFdze2T1OXJiRXi2rzCllBypLiBk
 J6uaUEx7a9HtXyjQpti1QtmgCR0FYUx+xdC9RhbKdZa/ETewd5a3ocAq+vVSAihy8ISw
 EF4g==
X-Gm-Message-State: APuU4Z/VptzXVrlqRBC9DaQeBLvNZSL96aKZ6grOGsNV25u6du6kJRoL
 fghAHMwqYkR+9/O563ifzx5i4hd5Inge1vaEPVNFpFfLpA538cgojDHi7Y+BTAXE5ilNXpGv8N9
 hNKrIZv708g==
X-Gm-Gg: AZFdTZd6ZzFGY6ds2nAGNAKCflWHBXqlRH5frFgTeNGhUX5j9SJMOo87w8mk/f08bDG
 Y3rlBTDIH2lYhFTG0oCbVvf4MrrBlZCovELu1tVPX4Fykwg1SCrK3XIoKqAAEE4l3YDOM40mpHz
 uvaw5d31sQUtdYDsKnapQ2LwbHYqgG4ZnF4uAumEztqw7H8hLnqbOgevhfnFcL1t9b6OoH+WSgn
 2zW1kWmEMcmigHklhKJ8aSxLc+qviAZ1W0hw+5kjENDCiihrO6imPT4MDnqngu0Mid6ppgPH6rm
 E5RRXpTjj1c8TbN9MQYi9m7BGz2YB3/EgEBFIv52/7RH5WLbGHn0NteAA9/5JUAlcX052luVqhh
 AFzperVoamQEtItcXWjX81kRenxu2iMaqG6TOAXjPhvOFRIxbbCn/9g6iaxkgcUXx8siW1vQlrh
 dka4AftwizsmKEU3b6Tvbxx9N+BU32jFqGySRN2UmqyBBZ/2tT1huFNVIx1LabZxXOXad88k6Fy
 0jQYNbVosoMJfrGKmz0iMpH/Jr5bPWBTZGSGVs7LiWZklJmrh/gLEw4Ikosk74IfhXryS+vtxes
 ysVFMSe+KgWixtb/rxajNq31sNIjUMXbaVdwf5q/UmihGPU4G519fM1iZigMf5/kVBh+g0vA
X-Received: by 2002:a05:6000:490f:b0:492:a72:9303 with SMTP id
 ffacd0b85a97d-4abb47b242fmr33655641f8f.22.1795604316881; 
 Wed, 25 Nov 2026 02:58:36 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad644140b5sm30289994f8f.17.2026.11.25.02.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:36 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:15 +0100
Subject: [PATCH v2 06/11] env: flash: Factor out the flag update of
 env_flash_load()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-6-8d31a33a54d2@baylibre.com>
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

env_flash_load() unprotects a sector, writes one flag byte and protects
it again in two places, without checking the unprotect or the write.
Move that into env_flash_set_flag(), which skips the write when the
unprotect fails and prints the flash error when the write fails.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 env/flash.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/env/flash.c b/env/flash.c
index fbb66ac2a4e7..2340926b07a5 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -252,6 +252,23 @@ done:
 }
 #endif /* CMD_SAVEENV */
 
+#ifdef LOADENV
+static void env_flash_set_flag(env_t *env, char value)
+{
+	ulong	addr = (ulong)env;
+	ulong	end = addr + CONFIG_ENV_SECT_SIZE - 1;
+	int	rc;
+
+	if (!flash_sect_protect(0, addr, end)) {
+		rc = flash_write(&value, (ulong)&env->flags, sizeof(value));
+		if (rc)
+			flash_perror(rc);
+	}
+
+	flash_sect_protect(1, addr, end);
+}
+#endif /* LOADENV */
+
 #else /* ! CONFIG_ENV_ADDR_REDUND */
 
 #ifdef INITENV
@@ -316,26 +333,14 @@ static int env_flash_load(void)
 
 	if (flash_addr_new->flags != ENV_REDUND_OBSOLETE &&
 	    crc32(0, flash_addr_new->data, ENV_SIZE) == flash_addr_new->crc) {
-		char flag = ENV_REDUND_OBSOLETE;
-
 		gd->env_valid = ENV_REDUND;
-		flash_sect_protect(0, (ulong)flash_addr_new, end_addr_new);
-		flash_write(&flag,
-			    (ulong)&(flash_addr_new->flags),
-			    sizeof(flash_addr_new->flags));
-		flash_sect_protect(1, (ulong)flash_addr_new, end_addr_new);
+		env_flash_set_flag(flash_addr_new, ENV_REDUND_OBSOLETE);
 	}
 
 	if (flash_addr->flags != ENV_REDUND_ACTIVE &&
 	    (flash_addr->flags & ENV_REDUND_ACTIVE) == ENV_REDUND_ACTIVE) {
-		char flag = ENV_REDUND_ACTIVE;
-
 		gd->env_valid = ENV_REDUND;
-		flash_sect_protect(0, (ulong)flash_addr, end_addr);
-		flash_write(&flag,
-			    (ulong)&(flash_addr->flags),
-			    sizeof(flash_addr->flags));
-		flash_sect_protect(1, (ulong)flash_addr, end_addr);
+		env_flash_set_flag(flash_addr, ENV_REDUND_ACTIVE);
 	}
 
 	if (gd->env_valid == ENV_REDUND)

-- 
2.56.1

