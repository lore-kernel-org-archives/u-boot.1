Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3C606D803
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vCcTNDsQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YI5Byi3C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DE66608E0;
	Fri,  6 Nov 2026 21:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGa8824xOdcO; Fri,  6 Nov 2026 21:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C777608F1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999066;
	b=oYjuQseBe9VtAkmuwMA0/mPkPyLPhtzxZjiZ60WOBZStwV8WdQmYJkSziqwKhx8rC7mu
	 e6wtHCy+b6/AnZJbFSiEBZIodM1i1MvEGv3x3+RKI1SBQgE54iD9HmSvmebGUH1Zv9stO
	 JTDj1U7lT3RyB7Wb+lhtge2fqkb2BW5bUwUjBFZhsjNetSN1LHqXKxHtuS7hqdbGRGvQ7
	 yJo93NtYnpDd+tMFn6yMK3Bh2QKrshKzIzANUBsdVUNO9tcqgRylFw6puAWzoTktZgDkt
	 SB5Ang9O06SOqJoTEtBGRl3ksYV+wrWKZg1v4SWW+6iDtluP3/KsWrr4gLQj5M6Jcrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZO8taQdqd3dYg7Hm06paHx78wJLldSWWL8X676tsTfo=;
	b=sLV9nagseyjQCEl9kCnin5nswuuAp1gX91gDvo8t/t6ePUstrzS8kLk+3CRFovhTL/KR
	 /N97omPenI44fWIwnLUPikgU7CeVWiVZlRsiPL6Bx5Jg0BwOPBTpBLMGrGNqiPQKWHebm
	 siGl0IfhDhPibcoAo3zC4btL6FNyc0WMA6bWGbhD97sTTYdXe/OeYN1R2WtxC/P3Vlnt1
	 41w8UjqzCrq+GoUnVAcA0Huj0U+l86wDO8XsYZozeH7ySDmDZ9CqMlFPr2qKj+qFNIMKr
	 Ppj46HGnIvbTRib1QWq38VcA4GcYcNE092UeSfe+5B6FK9SLjkZNyTP/wwJQm/nGeEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999066;
	bh=ZO8taQdqd3dYg7Hm06paHx78wJLldSWWL8X676tsTfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCcTNDsQr/ZRQ/jCbjV2tPUR6kCTGKkAun3m3ZbFqIfIsYHtFwILfZTaF31cfnrqE
	 8wSgvC3yRtu9Vydq4yyjIPzXBM4oFQR2DDVQqXFbiF+BcoH6wJ3oYl6jLxw9VWPKBC
	 NO9uqyWxzUv8yfYiyMwsUpAt/vm5TYXCkgrZ0iZgs6Nkq/q2NpkYoDQhYXdBPOTW8D
	 t0003EfVxZCeO3h1ejkq1JvrMjyjhunSMTju2GbT9VyduG5f7dwiyn11h/m4th2sj1
	 EEY11SYT/DOVSYOVIEWD5WYgS49jU/wL2WZycW6axCBbrmSM3NfRGYiZ/LtHNGXv4/
	 ij87orap5uTKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C777608F1;
	Fri,  6 Nov 2026 21:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB49D2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D178C400F3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5zP657Q2DbQs for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F353400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YI5Byi3C
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F353400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:33 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-91c7b00a75fso10569686d6.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994392; x=1794599192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZO8taQdqd3dYg7Hm06paHx78wJLldSWWL8X676tsTfo=;
 b=YI5Byi3C2ro2CnLDumUySzM/w+UuH5gV9QyB4+IV+FH93Qq4p489JhsS7rOY0tfA82
 56Biis3e1Fz3a2M3sELcnePUo7VEuLitGJd5ZZcuZK2Suj93R/Ia6xFqXaL5shqkaE3z
 AO6xFZBFW4bCEDD6fK9EXZGDJnYTc6biB+rdBDgImKtTqcX2p/riK5dK0RPVpg0MKe9R
 PkLLgtbtyjZ0y56BJrSul5DKeDMiwJEXfO+SP634zzc+1Pp+iiQEL0++DC23gl79BeHg
 89/oEDyXwMiT69mWFtoGow+rbQZh1XvD03j4lf6y4co60W6roGhsEW1RElKQKUzzJ6GF
 KaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994392; x=1794599192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZO8taQdqd3dYg7Hm06paHx78wJLldSWWL8X676tsTfo=;
 b=oSEFoxBGn5Ygod2i/Un7HyHwJx22ffwDNIodpLFzRj9bZCkukSxd1bOQLFRmuDJazV
 3W01bdl/Y/VW7DqLmU+NPXCYeohNcUjmNBgp9VN/Bo8wXu9l63i4JDHHsCOBpHeZ2bqq
 557z0VTCQy+oyLzxRU1yXFCp6Zu8LNDPusX9B6OdwAU5tp6aZYcZIaIdNNXTgIi7zzfo
 BtOhyH0KcY3OxNHa+eW1HdskuQE39x54USvhaCTUT4kas8/T2GyYuF41dlwF0aGTN56G
 +HXlhzHV5G89aivud2CkwOfCeM9XS0n8+P2vWhR+yy+xs2nJNQV8IIHyta+WSpA1pM7w
 HfIw==
X-Forwarded-Encrypted: i=1;
 AL+hErFM/TV16Qqm1UtiLVGo+yEtcwfvWLn9fXR5B1MwvyM7DgGjaDMW5r4ouUNKDsAssxfPeA9Ux2s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Xt/JMdK2mSc7lEAzVC5vk958tpDZXJQYeOZhpA9FZlZjicoo6
 gnyFdVmGHs4slJz6zPHjn8ZqAfHD1iZ7EF2xrwAnGAnAPlITW42Up7yJ
X-Gm-Gg: AYBFou1GSUbMA978iOYhT8OuVIWLcf1e9YjjT05qRpiSuUPl2iEWvzvLIN6k6PDO9V9
 nQXsFEYw72rch1+pQ6VVrWZXYBbSi8zrKZCcyVUSDTFzcHVNWm3fQToWakxi4Q/Z1RplHhF1ytq
 CUoNVCoIfaQeBOrBaXkGm8EXxNlGGb7dD3DvgdqCrp6OcPx1DQ9Pz3UB4vMzGoVzEg47ISdcvvH
 jcRh8ErZH3ueS995MUR0/P8cvQL8RwT5fBZ6uithOphFB1XMte5DTvafmCKwZ3qcSVv0+Cnzcqn
 r1SIz1GWXZNP4WDfb2eLE3kJazJt7kSpq3eWfKzc89GZ8WTx7RR7eNovM+tTGqE7Nb0twIbPtA0
 iKrUbpEXwpUIDQErbxeZnVwnH3gJkOmx45TRH+cBUO6GuLUyZoStz6QcVray8kNZXs69hkTmMTx
 3KG+kckmByzIWVLfoVeGvps7zpNkQkV1RTXmxm4varEXRILnEghZVguyq/Iwmf8X5Zvt6BpR57d
 LgY4omCXRrUAe6Iiloa9XVyKW4veoRVIAxkl+A7RIEQLVJoZfxIzA5US5LVb3YpzJxz++cEMUhw
 aCe3/nsJ1NsWRRrMbIkbRbLMMcVAWphhfVo4+2AL0CqNB7xtfTR2
X-Received: by 2002:a05:6214:1d0c:b0:91e:a73b:f9cb with SMTP id
 6a1803df08f44-91ea92cac8amr55870336d6.4.1793994392354; 
 Fri, 06 Nov 2026 11:46:32 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:31 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 3/6] usb: musb-new: pic32: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:55 -0500
Message-ID: <20261106194621.510146-4-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106194621.510146-1-oss.patchbox@gmail.com>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 21:04:15 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In host mode, musb_usb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 03b8e04632ca ("drivers: musb-new: Add USB DRC driver for Microchip PIC32 OTG controller.")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Not build-tested: I have no MIPS toolchain.

musb_usb_remove() does not free the struct musb either; that is not
changed here.

 drivers/usb/musb-new/pic32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/pic32.c b/drivers/usb/musb-new/pic32.c
index b878e979d93..2623e6e526a 100644
--- a/drivers/usb/musb-new/pic32.c
+++ b/drivers/usb/musb-new/pic32.c
@@ -253,6 +253,8 @@ static int musb_usb_probe(struct udevice *dev)
 		return -EIO;
 
 	ret = musb_lowlevel_init(mdata);
+	if (ret)
+		free(mdata->host);
 #else
 	pic32_musb_plat.mode = MUSB_PERIPHERAL;
 	mdata->host = musb_register(&pic32_musb_plat, &pdata->dev, mregs);
-- 
2.43.0

