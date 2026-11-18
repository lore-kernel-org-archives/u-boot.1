Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFA606CA45
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sbx61TPP;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kC3zT8qK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8548D409C8;
	Wed, 18 Nov 2026 17:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3F8TbxkZqwz; Wed, 18 Nov 2026 17:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D687440A20
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023230;
	b=BRV72uk8SzXhcuMLs2suUgTeN4V8mu+K58NB2TMNsekYTrrNOSP+gdPAEqdexA2l8wvr
	 MxxWzgX0zTF55viScAIa7ZQpl8+vacZnc6lxMTqssqqzDJRCCgTXr4MKnLEDmdQWFt4cV
	 NY+Vb1V36rcoINXr6Q40KOFaX82jp16vcgAei8XEYx9LZ9oqI2mFlSnGb4HaBD9ykqsi9
	 OY2BkW03vEE9KFiulLXH2jaQLmR0OGQnbpeoEvIqcjnorQYZA+6Tu0oHHN+8vS8HqOPxt
	 9r5O25ot/MgVtvqH2GkOyyrKsOWoOsZlzQ7fa3QZMgz8mqQUdZ1GipT58nQDict7sXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sQIy6JCUccB0u1VyKHIGnKOey3vtTBHyI2GPcwCgfWo=;
	b=CcAf+AMumVKQ3f1Thned2rHAO9GN8ML86U5dVKKBosGcWgCG00G1+bcxQWgWp1hV2x6w
	 dMpUax6Ofda6g0A+FF2NY8ASB/nyqN9Zn2EWw1U2MP+v4PvQyMIgVMsGW4TSUt0KPPPc4
	 7IzxzJzXTR6ou5Y/fVr7Ot4cHbtoUM+wiuiY+ZB50p1nks0llhFFSkWaUJUMzTT2v6KWs
	 stAlUG+oeyY42ROEjvI05ipWM35Q+T1V6hHqom/KO9Ily9+7HKu0P0wA3JKrSfUc8zyYv
	 EqiUgP051dtfpiQxo2Xryp0n5RTPiDgRCklikRN/iJdCvu2sUjQ7R0nbv126sGHZXkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023230;
	bh=sQIy6JCUccB0u1VyKHIGnKOey3vtTBHyI2GPcwCgfWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sbx61TPPzo3MPTNadXCZY2WZ+28D/oMaYjD143B0zDX03CEQPGUIdok4UA8waNdEQ
	 DJNXBfE2iiNjX+FpMpzia1AAx0hk0LyblFAjDAxNjJNKIMrObpPtAah42tGa7x8x9Z
	 U1+oHG8TvBGxNv+JKbOA9SZ7tP/MOjm8djs3+HlzSUG5AaknQVB+zlM+QfUOgu6SOp
	 JskxEh4Q2mOAGvlxzAIILwaQwBhvMzRMBlAXZ1IWc93xbW9EKWo7IXCWgvhGB86CQB
	 7XLcxijr0gqNhZiuotmmbmEq8pqPr3hjtENUGamERXSOK5MWsq4VmVoLJBqIfaQ33Q
	 SJdzYR5CdiLGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D687440A20;
	Wed, 18 Nov 2026 17:33:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60F38A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CDD181046
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZDvdjG4GMNMk for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DB0D80A98
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kC3zT8qK
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB0D80A98
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:46 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-483d290f398so696321fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795023225; x=1795628025;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQIy6JCUccB0u1VyKHIGnKOey3vtTBHyI2GPcwCgfWo=;
 b=kC3zT8qKiq2cFXvUayj0rkb1u2YgNgGj3BsthU47a/ZHr3u8S2iuz1HbE7CSASPqSc
 7lqDQ7fo5cf4z8ar0L13p6iZXLJoUiA/oOvjzOtqDEM3YkeKGZmKvNgg9jhfxAzwcbi6
 GHecvvfzNlO26oh9qjjjT5Sig15QWDt/FdKvPGbC/TEU/4rELeDQliD9e2dRrQu/3v5s
 NaF395cHFJvN8+jQTuDm2/lGoTSkaFAhdzzu3jq+TsheE6W+NfgxBGpTgbx0iU2b8uFu
 iZ9JHXk2BZLd8yvhv7E7Pw95u3g+qnh96p1aE1Z74VP6tcI9uSJUGuq607xAyocuLqwj
 /XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023225; x=1795628025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sQIy6JCUccB0u1VyKHIGnKOey3vtTBHyI2GPcwCgfWo=;
 b=VfAYrc9Zgc6o+YEY+qXa9cm3Vz6yKC1bkPnOCTrKcS9d+KWt0xD27qxMnrgih6NPYD
 QvbGlZM1K+4VXE3vE1rg8xBs8NflnyMqb1OPzbMoU8oZdE8oWYUjjMvKsRRam2xoKH3S
 zfY4aElq5tWU30/XzcYUgFZg9efcs2383s/JNtOVPEp/H5/Ss9/amHQwQsbScvP2JMwO
 zC7DkHc4A9rdeMXegUydXUjriKmoD6gcbclWilSQXa6TuEHe70CD63WsvuyRZMWBU2fO
 8av9jiOFK1bZ7S9mIE3xRHDWH9Ze3y2d2C3RlZrbRB8gQDERmQQPjA0MAy1wFO7trOfW
 CBVw==
X-Gm-Message-State: APuU4Z97BVWcM32PV7YsfmoBRY/Z164DSWAOoNSmiQMFBNG+0bm1js6f
 /OhwdXSAUubf0BeqAoDfqX5GerjQFepvO6DDwmWaV70BadkWAvBkgF467sIZGU2Tfk3nD4rbvNe
 h1SnCNRI=
X-Gm-Gg: AYBFou2Eq4rNMbB9AWD8V51QIOrSGsutm5J+ZVkA2LT3ovh/C3NSuHyoCiHUVn6vwNC
 GEzdwTcADXRc5pV/xl4rZC4Zzyn1yTwr4AjlO0pKaofur26Z7j9q312xXc6DvvXtTSi7r3oCtlI
 plWx361Cdb5MquM82/8enrPZV2HsKTANH5wO9Tcpo3LwG8Opz+yAJtuOfd027jJvdZtmhQ3Z5e3
 72lp8Z5WVNMIfSi7uSSxFje2hD/XAveHOnz+Bx+sNkzY+dBAPr3sqb/r/BVqR53IIIP9rNZF5RR
 LIxf51GymphuP6ilKCPW8U7xsdHLfMyZP6dhK3mK2SCCrpF+sVlKL5kl/8aipDCq/7PWJMxa1aO
 ffDtNnWPQQV47WZX3bWkB2E4NPwUGG55V7otf/IyDHJLKWWB6dzSIpxw+JZw50xQt09S6OJOwZq
 vifMGbHXQv6AbPHEhB9y2ojimmpAO/LZi8bVwW0kK3wPgOqWkqi/2LMJ99BVEVPmd4gF1pRGg67
 d5yARcaO972NC7AcE6QFqCC9AhQhm0VJakPvi58bQVPYNasCPnMDh6TJLjlCXYzABA1Z3t2Ya+8
 mNlK8CaIEAN12Urs/KLFWgve7XQ56bpqsavPhjj0UH9M8Hb0QOSsOg==
X-Received: by 2002:a05:6808:c121:b0:53c:8f0e:ee3e with SMTP id
 5614622812f47-57741d2211bmr3587760b6e.36.1795023225598; 
 Wed, 18 Nov 2026 09:33:45 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777ae93f99sm2193865b6e.14.2026.11.18.09.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:33:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 11:33:12 -0600
Subject: [PATCH 3/3] fastboot: spi_flash: add missing newline to erase
 error message
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fastboot-spi-flash-fail-response-v1-3-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TZR58/tEu37AtgTdSSy9usbgv2pZP1Gbe115e6c0C3s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/eFqYdleKzJjfeQ9XJu5mZyUSzOELYKsfAWa2
 Ft3n6LbwZGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav3hahYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0m0H/itkotcFSJnl5M+2HjJ1J5jXVqaIJmfzbyShATY
 Fc8LrQH0LGBABchezD8OwLEzNrrGH0WecKUx1GaD4+LXDKxD2vdW74tKqc56svRNspD1o+MhpXF
 IdGq9llQIWOiNmIoZJEJ0cUeZV3mzM/tlL88KeaqfkKUQvyyo0Irt64VfrRQxPB3HLRMzUG84fm
 gW9W3ybs7UdQlcDOytepvq2EYcdpN4si+r2IoM997T2/G23Xps38tRbuBsh2z7Dv5vm/sxPJZ6k
 JVd3orBacAcgQO3e4ZRdDpEFQT7XN+/trBk07Lbo0QQpZ98K4V9VnHZgKVqrAc0TIQ2/OQfAG7s
 asDE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the missing newline at the end of the error message printed when
erasing SPI flash fails.

Without it, the next console output continues on the same line as the
error message.

Fixes: afca60620ad7 ("drivers: fastboot: Add support for SPI flash memory")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/fastboot/fb_spi_flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_spi_flash.c b/drivers/fastboot/fb_spi_flash.c
index 68a794b871e..4f47bd9ea92 100644
--- a/drivers/fastboot/fb_spi_flash.c
+++ b/drivers/fastboot/fb_spi_flash.c
@@ -250,7 +250,7 @@ void fastboot_spi_flash_erase(const char *cmd, char *response)
 
 	ret = spi_flash_erase(flash, part_info.start, part_info.size);
 	if (ret < 0) {
-		pr_err("failed erasing from SPI flash");
+		pr_err("failed erasing from SPI flash\n");
 		goto fail;
 	}
 

-- 
2.53.0

