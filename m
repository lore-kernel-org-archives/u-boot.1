Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B432606D804
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nJAJyEq/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uABcBmU7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 782B560778;
	Wed,  4 Nov 2026 12:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vF-8jc8ThIiY; Wed,  4 Nov 2026 12:50:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC9AE606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796648;
	b=mfjoFR/fvaZll9ND38eibLOVV0XS5CRDDcEHk2clONWZsI3dB3seS41P4RvceMNyE6YA
	 kA2MeOto2fFt9+W0tI4VWkMBrt42aMj/k/nPIEKTNDnlhZuxpMrk7i7d3niN58FkdFdRv
	 v6ueb0VjdmNfTvMt4g+tcPUiaftU690o4EO95hNWL9AoWgZK4HTCwpZC3mrIqMyffCVoT
	 1RlLTI5pEEPRf5MxoiSoTwVd3X7A8Y8VEHDZJCp6IQTPL40gnV/eZva195yKJUhs6Pe7K
	 Z3wVncWOl4+R4Eb1ZAVV0LSO/M3vd5N9uQgPxUCIoi7mifGg9FvdvwO/9VoWq6SpXVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
	b=R3qmuzvsTgr1D5mGI4aHX7GOQ44H3NBF5MyWxzTy43qUA0kn/oLt7PLQkQI6bFf0z3/P
	 sag2KMBUhIsn25/+/Hlhw4nYx569wuCsPYwWwRPRUNm97uWmlo/cG69sotccYGr4ftv4S
	 J56Y6mih9ugqXHx0A4csN90KjJ5Oo8gpDcTOXMXkRRWETpVJicqLlK57PcRFO/L2gH9JL
	 pvK6iMtdw23qPwLXr/MeqfDwrn3Or75ntyTIk8UdyWsjSceTEcUj6OAgfn1CzZiA/oEMI
	 XOYlhZGgERVJheD1MLaS2e8OpzW3UfHM0mqJMcVawZfTxe9yD26yrkuEq2k893gkOcg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796648;
	bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nJAJyEq/8E7cn5/bhAqQpxbISyzlpbQ6MPdsbB29DVxW2SC/+Rm1tl3jbkcYrZwIz
	 7SFH1ye9bgPELE+MZEmF4CIatSuonYxixvDSKbCIteWuZbD3zqo9nl10dvtgP6RIHQ
	 hp0C6LfQez4kKB3eEDOF9L4u3DGLBvfCHKMPHsuvNLaiYt9JLu2FczizL0nQm/pwjL
	 VQPqQxZRJQ50o70dTk0kikLwhIvnUGMHKcJaAwsAbTIhAYoE1jXd5tJFshSSq+hdOM
	 dmmfJQIR65q8BTvy98H1/oUfiK40VK78oYYsjoFgddlMfNd8gNETosgHwj660s9Jj9
	 seo6FFnEckBxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC9AE606A7;
	Wed,  4 Nov 2026 12:50:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D24435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49AB381061
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYa1ZRTd_6ok for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:50:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E76E80D66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796646;
 b=a9ZAWaiYstiVxXin0erQBU+uCt/Ii9VoV8UJJwSa5kOxrMh5KkYsYnh4w9/iZLWxBkv5
 ESTfaSoIHR9H5Km85dNh1yehizE0reFG55RhSMHcGZk+g4JoM0Q/Yj2/2OlKzxYKrLfTS
 lrAdfT+ko9+mvScx3FqKivkuHT20h9KiS4ZvNI5KHYb2PQfp+PuYsxMBasZjDqnPnefvN
 VnhS2ZXLL8khU0BDb2YoWNrtoiq8+K+1D3Tp7Kq3TBVK2cyiJ9DAENdIUEBnuoVLmc+yg
 A6wh67stso0AvtCkyFF4JEGb1GotWitDnabuOL9P9ohyLli/nfzufcWb2oYB8PTPVWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796646;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=XHmSGWR80/EFjd3urkQzVFOjeXwgo5tQsYNOgRL+VMvlHVpXC0xjKzNFaadesXTssmhw
 fylWvC0NW/j39x1eh7+/c4BGAVW3v/7sxKg4Uqj25xo01OBR3rm6KlfsGUTvoVZ+6d/fC
 Out5NGMFGpd+pZpalAQ4o/jQkrIk0rOeGoLxQoq+4EJ/SQ3hDzVUkxP5pmZnE5PLImOrB
 dYJ6YAmhHiR6MO4g1/5PGopERjwsE/F4CZmIR8pm5NeANIBecOC6l+FStYppEYtroj5AG
 YoqknIc91VVH8ge1OKHWx1hJ9nZEORhPlr6F6qThNGnppwX/WwnZzHEf00Y/5pGISuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=uABcBmU7; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uABcBmU7
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E76E80D66
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:50:45 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso101596266b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796644; x=1794401444;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=uABcBmU7BsYXidwC1aB64Wy/EHpPUw2IYwbM2l7aTAbQcrQEpMFPpderjceErlSIok
 Z2YDAX2QNy3hOhxXo7yXJgFo20Uy0pWTZCH+m7o1tpT/CwhgpO0XHZ+KeOwVCyXi7Bwr
 EfQW3MWHeJ0dRMtQmFNMpwsScfqtE5KFVUGQhs0VL7rG8mfQt0PFgSnvpta1UxC3CYlu
 wWDHB41Jhl6u55A/Qobu6VKOppRhtC+N9K+zS4sNT+CotcLexy/4rOCk2CNDtM7iMneo
 lgyCkI1ACRnLF8qYNqkKeeJpDYNSnrQRwLOROX8MnFuYQ53EtuV2y24M9USnrhF3sjTL
 SdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796644; x=1794401444;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qrAR8lJ4imukpXjrW4CphDMWtiygvgmxq3C6YxdCJwQ=;
 b=bp/bWkqyAoojhItsIixfoUhW2Am7KKZ8OROsrECi/2VEXEqOfuv/gfrAMQXKc8mQh0
 lknqfoEXoiZBE/9TcjTG87AFDyVj59JisdjopDR9+blIPt129lZCB/yTHvchFBUBaD2X
 1spNEOpcXrn2akdUlwfQBppHHN6AlHKB0q5S8R3Y5Y9rKlUZulqLNArm13OaZR6Zup29
 HL/aJeQUNn88gtDGAUgqfBdF4LV3oJOejXyNZ2bCkYld2fTv4F1PdMJ/MRIHZBoaY52z
 30U8NkhS7946wpXMXHI/0Z1VMwOZwctMIyGGgBlGg2swk/sG8op3ZBgGV+sw9Y5ucAe7
 L5dg==
X-Gm-Message-State: APuU4Z8Y9RPW/+Ysh+nL9wC+zyVEpl7dzF+sEf4QNvRxZqIM7EsG6mcv
 ZNZjuoNr6JodQ/N8rq5ruc6nxNzmm1vx4myiPBrTot/QEqH5Eu/Tb1dn
X-Gm-Gg: AYBFou0dnstqmTcyhoJohjJSR5ZVjNBdNrJvwDzOd6f7YVZAlIq0HAm+/E4n476OA8H
 d7oHmOwgo7v7nNoQEBoaS3kUts3hdAU7DvXhogK68KkAHT6aDu3rD8tZQcKzV+QbRPSZSplhGcL
 xCCKz/TR8zK43ZbrH0mf7sNUoWtZ/w1G7HXZiviDpav4feCdI+UoOL4aKCSxOpGGV/WUpoS6zbp
 sDNe2lJd+wj5mRoagXt5sELrwpJjnb9gffZVMqjU3VNBpFe3AVQBAB0d4A/RXEwH6t0U1TLfKLZ
 IOCwfGCDJhm5hUgD6rn9BMI7zdkcESB7McftGn60LTtORHpDCrpheSgFQHA5l3RugrvrSnrREC+
 XDyIr9BhfI3k7sR2cnFhI9ojHNerSqN/OadtuwT3Ef+gTeD7JeAMSWX3GyEWk5rS+w9lm+tN9YW
 IlOhws9kcnQ7VGqQWkblXi950+YqWkP3UlFuCUSCxRadeaG0jDyGcX/maCSr64Zv//9rQhj9jAf
 ZrMZJvXn4hY4bhIslmSC9/qbT3GmrENacmcckbfm/w/D3Bd4oav0WBUzPjOIzRf80j69RA0bAR5
 4aSHxlSYeXocJHdPXbx4uaZaP6Udd/Q9
X-Received: by 2002:a17:907:7254:b0:c46:2987:2156 with SMTP id
 a640c23a62f3a-c4ca7aac2b3mr1344824666b.29.1793796643435; 
 Wed, 04 Nov 2026 04:50:43 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e424f89sm66151466b.29.2026.11.04.04.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:50:43 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 03/14] usb: storage: Fix the capacity faked when READ
 CAPACITY fails
Date: Wed, 04 Nov 2026 12:50:42 +0000
Message-ID: <a6f346ff-1865-4c75-a86e-aa2be64ab185@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

When READ CAPACITY fails, usb_stor_get_info() makes up a reply of its own
for a 1.44MB floppy, 2880 blocks of 512 bytes. But it sets the values in
host byte order, while the reply is read back as big endian, so on a
little-endian host the device gets 0x400b0001 blocks (about 1G) of 128KiB
rather than 2880 of 512 bytes. It also puts 2880 where READ CAPACITY
returns the last LBA, so even on a big-endian host the device gets 2881
blocks.

Set the reply in big endian like the one it stands in for, with 2879 as
the last LBA, so that such a device has 2880 blocks of 512 bytes on any
host.

Fixes: 149dded2b178 ("* Add support for USB Mass Storage Devices (BBB)   (tested with USB memory sticks only)")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v2)

Changes in v2:
- New patch, split out of v1 patch 2, with a Fixes: tag (Simon)
- Give 2879 as the last LBA, so that the device has 2880 blocks (Simon)

 common/usb_storage.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/usb_storage.c b/common/usb_storage.c
index ac331f1c1b0..f7c96195b59 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -1496,8 +1496,9 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
 	if (usb_read_capacity(pccb, ss) != 0) {
 		printf("READ_CAP ERROR\n");
 		ss->flags &= ~USB_READY;
-		cap[0] = 2880;
-		cap[1] = 0x200;
+		/* a 1.44MB floppy, as READ CAPACITY gives it: last LBA, size */
+		cap[0] = cpu_to_be32(2880 - 1);
+		cap[1] = cpu_to_be32(0x200);
 	}
 	debug("Read Capacity returns: 0x%08x, 0x%08x\n", cap[0], cap[1]);
 #if 0
