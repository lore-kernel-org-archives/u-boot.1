Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEA606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZS899q7a;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pu9p1wf0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D6EE60A8D;
	Fri,  6 Nov 2026 21:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8wpuYI3Xy8u; Fri,  6 Nov 2026 21:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A904C60D72
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002204;
	b=P4oY2s2CiydyvMm7VCR0JiTA0mA3TxVp/FxGVQp/rvLJUl8cUcJYFLOHKhRMjfsag2NI
	 t8f8WrMlT+FC7xVveGC7NpmaFGjVzshalLVLybLNJI/Y4wMRJVtLMoJeHgC8B+4xsQEDY
	 rhWeJK2Ibw0B5P759A3FX/wiZ+Wacvr18TUUOIYJv2NH6Nb/YCOPpphrWJuX3B3o6+Wav
	 as4nDMFKmIzLH5k58C72EjX9zeihYz9MPezDDe502iOftYNmFzCkuvhuc8ytiwG6SMh9x
	 nXdPFbp7oSobPWvL1sY0qlW7NAyWYFmAekqFXcnxylkxSvsHZt1Oi9kl4bHh8B6TbKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dzH2tKpYq0rX96m63PV1OqbFijtSzLFmzFFluRTC+Ic=;
	b=j2MgD7jXqIrGKH0oEmxt4xomh8qTnQqBEkACM4Mzeq6yUfI5a7sRJb4jlN8Tgmg9VJ7l
	 +46sblhSnXiLd70p8y+NnlHF3s/DpnZQRJtlGBG/c5Zers5AXbvLeq7aIlItAlKskO/u/
	 KWKQffsmTqpiiLgq9/dppCP9A5OwBBc3e9dO9Qlf0ngcCreZW+OADypOl+s+YU3X/GHAV
	 pH6zOLQ1h18QExREpptf1T0mH/s+uqUi6cBT8l4yJpr15fIzUXtQhtgL0BCjjFGDBaZ8B
	 /Nz5YY6vtNVgdyGfBncbNA6IOjaZQcn1cnWawkjGBgN9Xx8c9bnaRx8QVA2sqjAluEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002204;
	bh=dzH2tKpYq0rX96m63PV1OqbFijtSzLFmzFFluRTC+Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZS899q7arn0DJt4FHiDwOaIB8rmLvW8v9V+smYD8E5rvV0tcybTqkAmB41v/ntuy/
	 rjtilAlJEBFSq7Nun0ERzZaSrqTgx1uoO6KO74D2DfmTN9Wn5ix7+2566hGr/qQyhM
	 6QiwvP3MIWfJFQiw6lgtSHWVS4AXRtEhY3sww+SECGc6cq3baH64c9Okql3SlgkdUl
	 5OFeFtwlNz/00nNMiBql7QKDI/etPYr5myE+omJG0bCruCkj1/AhC44Z3fuQOxMHW+
	 vmyLABfl2xK7eBw9dd0umxC1Wy2aoqHi4iSSaFt7QUBz7bOyL4s8crnP8upwvy7pJ1
	 xCTf9s4JuHFlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A904C60D72;
	Fri,  6 Nov 2026 21:56:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E804235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 200C5409B3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmOSuY_7WL-w for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 359C6409AB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Pu9p1wf0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 359C6409AB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:56:42 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so652932f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002201; x=1794607001;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dzH2tKpYq0rX96m63PV1OqbFijtSzLFmzFFluRTC+Ic=;
 b=Pu9p1wf0TL8mtWi1RawEr83ldnnNiotpM7FNvF7+hwzregu2DeqlY1HS94nxFhj8se
 gZ9j02NWHxj2ZKvrB4uR6M3/YQ7E9gkI1z2cglalZ3sfO+GNagc2AB+MUenpm6m+vkoC
 C3sQiygcyx9zsbAEabz6xPEPfL2cQY+XVZ2e1TG0CNzUsw/9srppUx70HNKNGa1DuHAY
 7j5kCMGAelQ3Ef06IP0A6PeqPd8BkQW+57EZe7o8b8YI2u2NES4Ms2nsNf0yA/OebN+u
 2NLMLtaGsB6OPSHq6deoiFUarxf88OvHZBq/EGxdHSyLAmZeZ/vymQrsI8mMZo17x6PJ
 rPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002201; x=1794607001;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dzH2tKpYq0rX96m63PV1OqbFijtSzLFmzFFluRTC+Ic=;
 b=v/iZmDDWYg1cNEelZEetxXzzgGxFcY4yDO8H9AF3pcRN797yVZOHSecH7ldicDKIF7
 o3DiMS3cndpidd0eTXCoW6l4hVtLDQ55KfMy+RAnm9qH/9iWkhv5twKH+ybRoqBBF1lS
 Q/isd2sVgxGq+LQDx9fKk6i2npa/XPWA98hMBNXeY1fGjDH1MFVYsKPHCp9wxTRtMXwA
 TWbVZvLr0zic3dw0ujPVXmPdp9Lc1G8QE+jXCKZ6Mxr3ut0KRM9QPyzA9Jhd5z0X+48W
 bMJps+Hpt93uitghuor2bWGRwYNSRG+CsNiUTnxiqgcT3qb+IfZrqN9yfw/OhL6df7eW
 3lgQ==
X-Gm-Message-State: APuU4Z/h6FWIdaZPb0+fuMGHbm1aHB8hMRjQGR17G7n/6DEC91C0R6pL
 Y6ZylGNXmwu6YkQMGJDVP/VqodDI54hRklmIhX6ybd7DDOkiXbvX+E91XlvuCYrfoJk=
X-Gm-Gg: AYBFou3K84JLPR5dMMX7Iu0LEbMzOTAcM4pY7zR/poL0m04AqSZnm6prm/8GH5MoSq7
 hApeNF9cdYoWLHSptIzhQzrwIOaPbODuES47ev6dxXWbhVEmwa/W3QNcFbMFgxvhzHqAtDM+bDt
 2AlXYTBJzEp29ZJW4hra+HAGyPe0QOqXP2TiNcjNI5NG5acBzHLItx3L/IhQ8EGkeoQhjZuPwMy
 xDFE2l4yzBO3UG63NoQssYDrLV6GTlhDVVC0TVcd1qlg6GJdVu2S9WkWRcNaSM6njcVYa7Kl7V5
 pvZXVI+UWADtmUcLw6zMHCAyH7p/420S+sfqjP3+kOW21DZQ0cpECTlmY+7u0MRcsUqytzVwDpv
 caGHUlNa6b++TtEq9N7CcAATu02vOG0bzvWJCjZruCyoIpm11OneEbYq8FQ3SOOjrXM7O8EWA+e
 dt45xxYq13QyJUf/N+QxhhlW4VcBfcNr33L2+3mexoQK2QnrN2HytAyZkDk3mu8UU8WhTP9GQaU
 fb+8V+qQYTq4ivlmb4pO/T2lbo2GDsMuSWsBHfuv0CZ8EVtkSBRaQM5qBew7YhyjBbTPQTln3lM
 3c3yTDLeO88CxwqdQWVgRT7ZTECzMmM=
X-Received: by 2002:a5d:59c3:0:b0:48b:1a0:5630 with SMTP id
 ffacd0b85a97d-492778d16d6mr7835217f8f.41.1794002200792; 
 Fri, 06 Nov 2026 13:56:40 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7233297sm5989826f8f.27.2026.11.06.13.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 13:56:39 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 03/11] efi_loader: reject a PE section whose end wraps
 around
Date: Fri, 06 Nov 2026 21:56:38 +0000
Message-ID: <40a76498-7b85-45f0-8ec0-ae3ec0d5043a@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() computes the end of each section as the sum of its
VirtualAddress and its size, both u32, so the sum wraps around before it
is widened to unsigned long. A section near 4 GiB then yields a small
virt_size, and the memset() and memcpy() of the section write far past
the allocated image.

Relative virtual addresses are 32 bit, so reject a section whose end
does not fit into 32 bits. barebox, whose EFI loader is based on this
file, fixed the same in b6598389d46d ("efi: loader: fix integer overflow
in PE virt_size calculation").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_image_loader.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 82083cb73d9..b21947e979a 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1048,9 +1048,21 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Calculate upper virtual address boundary */
 	for (i = num_sections - 1; i >= 0; i--) {
 		IMAGE_SECTION_HEADER *sec = &sections[i];
+		u32 end;
 
-		virt_size = max_t(unsigned long, virt_size,
-				  sec->VirtualAddress + section_size(sec));
+		/*
+		 * VirtualAddress and section_size() are both u32, so their sum
+		 * wraps around at 4 GiB, on 64bit systems too. A wrapped end
+		 * would make virt_size too small for the memset() and memcpy()
+		 * below.
+		 */
+		if (__builtin_add_overflow(sec->VirtualAddress,
+					   section_size(sec), &end)) {
+			log_err("Section %d virtual address overflow\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
+		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
 	/* Read 32/64bit specific header bits */
