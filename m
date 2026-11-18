Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB888606A33A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=om7qIxY8;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=L/jiNYQt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E388B40897;
	Wed, 18 Nov 2026 17:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZTQDqLlNDLO; Wed, 18 Nov 2026 17:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B74140873
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023223;
	b=oMugU8pK6reEYt2t8NlskL1bkLsGK7KzXxyywfUZOkM6gxyEe/ifPPIppUlh8cDlSnjP
	 m4a5RYAiLeUqjhGlItiVRmLVC8kEWXYAnXmS7W42iqETsSk0ir/GBvQZbXBz4wr8roTIj
	 U6c8rOq6KyJG+ZlSFup+ijxN4biEnIjKIFMH7B42saAFGkat/Ag8e3gTYBS+27hJuoD/8
	 Pgnvm38xRqIsVZn2lw1I+sTji5iiUIgehx+HbODJH6i0gwm9qH+XOKWVOLN6dvrrUVdC1
	 +pFndkXKIOyuGML89mj7pViItHkwzrIxUeua/IrsR8RGf8vkD5iZr38IMDrCnnvkfNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oeTtbg3CKELChais9JM8B/oj806EX2I1jCQ5R9S+WjY=;
	b=b15syP1CXlvEhuxRLZG8mENCpc7gyENzELM9WLGBxOiIGJIr8dsLc1UoSQnuuvoDwlmS
	 sIS3SxmrkI+C/JWpFvvIIvEHpaFNMDgaTRCI2KPMF9Dm7OWyD3HASOBgtw0S9blOE6itz
	 bSuC/0EaG94/thOJ62kP6l8KzkAav1Wyp3tyapmR/F0+hwzH8ft43NgbFyPkRDDJOKj1V
	 etCqnZQ6yAPcy6HZRv6cr1JJoNES3EXs3976VOocWBjhjuDDD0UrbG/V1xr8O4ciMe9qM
	 RQFCWRtr997r6Y6tpNXjI4+SOoRImlP9EOvjWvPI8qVrPy8xMJF5pXb9yLtzX0JrgoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023223;
	bh=oeTtbg3CKELChais9JM8B/oj806EX2I1jCQ5R9S+WjY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=om7qIxY85gwpsXZrAXMuzkyk8kRmR4ikgjph+wfB3ATgHKnhP9gpew6g9zQgeN+km
	 nZvV6zwGVKgVnkWlWEQY9WXopgg0XLdyTmEe0lb4+M0k0tpliB7gaTZUCQUKzhX7i8
	 5Lp+p2fXw+qTGTGCgWTee7RW98TVLTq64M8/X6kPrYGz0D12t1ksvSOkEI2EP4Q6fU
	 DafOd9hu0ZM/BLRxfDp6Q8kvifAgDp0Qp9skh177cYpHgSNJ9wMzuUVYt4ESX6NbRX
	 KAYWPP19uH8DKYI8MK5mMhydkBns4Pmt47LrMJkGR/gCGWXlEABBKtHltGDW4Qr+wJ
	 nDMJlGdYkEH+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B74140873;
	Wed, 18 Nov 2026 17:33:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96FF3977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D64C6069B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWFmr6goamf7 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:33:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B030605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L/jiNYQt
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B030605D2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:33:39 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-844a8bf7e25so798330a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795023219; x=1795628019;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oeTtbg3CKELChais9JM8B/oj806EX2I1jCQ5R9S+WjY=;
 b=L/jiNYQtPCTiVCvqjkTxv3osmeqpD6JcxhooK9muKyeS/Wz2xMaBTTdxIvqZCjMjfL
 WbLpzfpZtq4JAK1FGrkEmMw26pxoJ5phxIugMZv0afaGOCFT3OD+QgtkMlPUxPsjQwCV
 hDOOwZ//MN1cQhK+TMEcWzs2VPTUQckqPh547K8emcl0zK94rhFYE1xiFSWObZiBBFYU
 /m8Vzd3WRfBHuRvGIpGgCSN2nOFcwzPBr7AaUSjGgyga+p9CbSk8MYmlFknYi/LPXNIJ
 Dd/LYkdngMv6ERJ2zRdS1ONJJWi/HVzEcJz+rWHhcjL2QbZPhEchP2hO09s17hvF/GhN
 RrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023219; x=1795628019;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oeTtbg3CKELChais9JM8B/oj806EX2I1jCQ5R9S+WjY=;
 b=xcpqZaM6wZNkz5JVePJ599ELCIofVGeaSv5TGkxV2m3masZUFNW83rwEgu3lipWLHo
 9+3xszjeFZi3WgNAU4NSxbzfiivvqQORts1e+Ue5bZLhYWHbuQSlYJ5hb+5g0KNvOWQq
 fOJSfidxbRqsdmHHFi0AX8gDl9NOSdCaoFrAyTAJbDr5i9DM2dorNoKKQuKFTqhCL+UD
 x9AgbmuF7EtEe76KowlrH072q3kZ5exWAYcVE+OJSJeThCCFOYH5SjiMc+09DzE/nQtS
 j0spWkaHFyPIA4r4s47MuzVBnenjoIlbBOCaGFTaFwtdl7PFPBligEeK1OPszk1sj8wb
 vFZQ==
X-Gm-Message-State: APuU4Z9C6/eQ/pl/RB9+/+CX7wHDFP1duGkIndqI2cmqoKM1Wkva9A4J
 NOBq32cNy8zBn4jxkXRr+DZhIva2i4CVeI9NpqYiwrxdQlo6Kvk9dlGSkX5rHH+Ho6XYzXMJ2kb
 IpCBoB1Q=
X-Gm-Gg: AYBFou2t3ndJztvZuL8x3XC9aloVAZWfCkb91UJ23DvuD3IGUf02KIf+7yp/xn45sF4
 nUZg3+X0Ood5kgXvA5jmwgcH+tAVaV7/yHXMJ20gZyZMKxnWn9VFoKcP/jrxALcdBo8pqXie7Pl
 jdjGYi++aUQX8EiBhhJ2pkA6SingwphzVD2vS7TwNuG3mWCMlr14Fp+16tZ/WVwKF56XUsWaooE
 kYPzgn154ZcI8x+ELy92XNdm5Ij5CgaSdCwbixoCGPJ5Ki8awtlsj4TYdgGMlu+yPyWO4SvlRDi
 EAiN3IPCB2uxFcb8YHYsCJjtpSKMWoA6+aLXMPL5YHx2mO+rpY6bDUkiTnphotRgwG2mMBPcSrR
 1gqKuO7lLq7BOrLfC+6sf37fSLS32B8JFoeJpcMewsAC5oKYyfeTvB8QZ3qydlouyjvgIq33AI5
 6hP29i2eb0NlZ++MiAADyQzV5KNtFx8Qi/oZQC82x/6xlc/3WHcBwlTdcjPPJnDAAsAfe9tT7V+
 KIhICsh/G4yJvZHpDQqdJAIjvV3krDhKQzN7qTnEukSSe4QCQtCidMtB/M5KdnG57Wbcz5YiPaw
 kdwDMAETehIRR3aVN8lnfVWZd4HdkCYzII5rdEG6goEXxbMwz4LhkQ==
X-Received: by 2002:a05:6808:f13:b0:573:399d:d487 with SMTP id
 5614622812f47-57742f41c5emr3466895b6e.65.1795023218878; 
 Wed, 18 Nov 2026 09:33:38 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777ae93f99sm2193865b6e.14.2026.11.18.09.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:33:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] fastboot: spi_flash: fix error handling
Date: Wed, 18 Nov 2026 11:33:09 -0600
Message-Id: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrDIBCF4auEWWegCpo0VwlZGDs2U4KKY0sh5
 O617fJ7i/8dIFSYBKbugEIvFk6xQfUd+M3FOyHfmkFftFVKDRic1DWlipIZw+5kaxPvWEhyikJ
 oB3O1ozaj0R5aJhcK/P5dzMvf8lwf5Ou3C+f5Afcxo7KEAAAA
X-Change-ID: 20261117-fastboot-spi-flash-fail-response-67596825852c
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=o8CCSrO8FRmEaKlXb0WSWCbHF6vRXMeLXiMANEWYKYU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/eFXduZKMIs5iJ/nvLPo2WsTmdAZYH4JVoPnU
 yk8sB7ej72JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav3hVxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/hsH/iVU8D9O7Vp7CYkzilmmtKDspSLAUlMy4FnVgVI
 NUQLHddMNJ2/DaV3GaC5rPtc5QpH7SH7k+OWYcHSy76HNEM9qrx6kEh3jA2qhSJrWz0YC2ZzHVu
 VlV7UOCoLFc95Xh7sK/1WFusjmz2JD4poSd4sESb5UTJP83Gx2qN7cVUEQF2j/22a0YCOTan/C7
 /D61EqnQWccZHu9N37jGjEOh/xPAscxQ5KvUNOfLOlzeyZmz3XLh/JikEFfQmTgz4/AsOijN4D/
 pcUAmzecIB5pYBfBxEMjpXutsaDLcL8JAAyaKgwouMYcWp6Kd4YAuNcMuUWeG47ejYcPkBVszj/
 ygiE=
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While working on fastboot SPI flash support on a MediaTek board, I
managed to trigger some error paths that revealed some bugs. So here
are some fixes.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      fastboot: spi_flash: fix probe error check
      fastboot: spi_flash: fix missing failure responses
      fastboot: spi_flash: add missing newline to erase error message

 drivers/fastboot/fb_spi_flash.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)
---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261117-fastboot-spi-flash-fail-response-67596825852c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

