Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81476606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lGivTHSU;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TI0CMDwa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5030960686;
	Tue,  3 Nov 2026 21:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pz4TuLRZbJ19; Tue,  3 Nov 2026 21:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F3B260697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741204;
	b=kTreOeQifhdcCY7J7YuiOeH26YUr6pav6MuDplHbDxMqRb054FKcZk3QaOcroaNyRL9V
	 88oDj9AEuPxiVfXerCbsiBHUjV/SM6QWBI6Y7KBxrifT6A+XxAsZg0tkWzUu43CtZK6tL
	 PKvAEU3+gYJML6e3HLo243sS0vaZXKkxY8v0vHpL9XBIt6QZdxZdLg4/YonLwKAkrMp1E
	 916olFEYZwu7rlKX1CVGTgv2ujOOtZVFKsPgyooKHi8HECgqZZBqsXaKmYOFMsoLq/MfT
	 /vD/XmZIjI9VVO5WWuofSaeUkCYC/ePTZ/z9IOjJMKsRofs4EpaZ6kvBFmL1pUwG5zQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qjd0jJNvrtzoU9HeA4tNZwnA0w8a5mjm1JqYYjSaUUI=;
	b=YmNjqYDIDoGVa2173H2lozld8h/XHVosjARP6TDbQCrpUwLhsXBvFl9CbzNYwmFXIf/7
	 HLWAVa07u9F4gtAWygFXXDX49fcZaLNV3/X9Oi7KEdiqW4ZX6K30xT/mm4WZj2L/hMCyu
	 u9ZNq3c/Xl2mpUP88Yial5/vizxAuDNGMJnUTc8VTc2OQJ33/Tvav+1Yff5e4Ww0dvgMp
	 ZTsei2NASlRJzBM8KzZEFNAGqJB+J1FpaKLEoFysxuQcr3JL5+vB71aNWFrr4pnnZQFVu
	 uycLaZ53oSi6k++AfoYUHisDNPbq9rZkJ+MfuqeW+ZPnsQvmAnxtHn4cNBOw2d6fxSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TI0CMDwa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741204;
	bh=qjd0jJNvrtzoU9HeA4tNZwnA0w8a5mjm1JqYYjSaUUI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lGivTHSUOI9TKplc0TtYLMhRjF4h+euNi0JTugiyLVqCk4RvWShT3zALu1jDvss1X
	 ZIDj8iiGtVh+r0Ea2DDezteZrnG/U3t/eFmCBXeeCLFaDFpoT1vHX5GOhik4/ROkPq
	 bis9/crIGZ6UZ2JHHWS0Oqe5LD8x93C6YN7BEdiK9mBFd8r5+ZvI2bIwIaubyBC0PN
	 3Tjk8laRh2gyY/zdYdgrY+v3bz2zT1MuSxOUSK0fSgEUnp6YuImuS8SmbJPGbBmjfm
	 gYL8JxpMkCS+o7euJ9wYSY8GH524E49JOoZupkjKV1nuR3kSGP3XL/dsgIctqVX9N5
	 5twP9jC0Tp7fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F3B260697;
	Tue,  3 Nov 2026 21:26:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80FE2784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72ADE606BD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irqjlDviGElP for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:26:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13D0C60697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741201;
 b=V6ZrQXRjycyScA9TPUDpo4h6yAAzeBqecVOd/RvGiAnuq6Upmp7TwOs1M6Dh0AR5gR++
 QVkE8Mz9zhbuoIUDGs1G0h+WZrfqsed13FXHHEZZ5H+L9hDz8/z/QI20HNaj+a3UTeCbQ
 MTN6bGTYIcGHXPshLKQoCe7xfkE8MeeFz2jMDOGjmjPMj4ybqNzXhIxxRDKsYSDPcXjJ+
 ukTzO/6I+VNkTdY4oRmFxd3wG7GDJoA+F4iCOVXphXvumeyO5OeBYppchEmOjsqRu2KvM
 F2JkFzwXiLlKaP5TcF3Lpqr+oDKTnzT2si2cYcgDD9GCW7uu5dOgd70h2SRwivoxX7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741201;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=qjd0jJNvrtzoU9HeA4tNZwnA0w8a5mjm1JqYYjSaUUI=;
 b=aOxRrEqZkBr9SBbBPo6JgmF2kknd4Vkca1D7jYwSXeDKk5JiNBdOpU2NKtDLRMMRAXoe
 2J85Qf2WTYOvA/I2PJ81emQ2AgKqTJWG1woYaQViLsqVN9C/rU0RSLoYBpp2iOT87H+1y
 0dzbLhiK61cUVRH0LGHq5TAsdJO9vhJAQDUhXorxilcGc8X5tA6du3dYqvJWcXMvq05wi
 c1BEKZSqzMkO4dWmCMDBf0vP99f08u3RfsZCSOEt9ay/nnNX60GlSdlCYswJrXc+FWQds
 Q9FhUfE/XnFh13TIUww9oWHuv/sdHEweIVLn9ssWye1MDONCFSUcpxBu3oazu8WdWjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TI0CMDwa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TI0CMDwa
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13D0C60697
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:40 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so15356a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741199; x=1794345999;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qjd0jJNvrtzoU9HeA4tNZwnA0w8a5mjm1JqYYjSaUUI=;
 b=TI0CMDwa2vNwhUYUSYZItreTVKzJt52QLi8Xo7Sena4MTll94zWzI3DhJzb0yzLJd4
 VdlFWl+4oQyB1gWIVX2RJmqt0P/Z5i6YzsfGJWd2qowWsvxk5lvm89mjBnoh0ZgrQbSd
 S5lLP2ra3I2nw5TDQVLp6jIdNH+R67H9rEvfB+bXx12bEkKATwx0fhbnRGlUCF9c3IQR
 pDI1tgaqZiPywwj8LiZlriyg3zYokSK1UQ/7p4DPbMGxACJrtsZ74s+4b0bvamL82FXf
 7zOg5f74kynhYk528qYP9oY6a0sT0Y0VpCPuqyktWxdvNEj+spGqtVTlYnyEjLQiwlJq
 GIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741199; x=1794345999;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qjd0jJNvrtzoU9HeA4tNZwnA0w8a5mjm1JqYYjSaUUI=;
 b=fGdacf1LdDDV+ZbqvKaXspzsAqjSjmD/2fEZcaY18DUbWpWAnk7dlitbEb9SF1cCA+
 p8K3uELAX6tHZsLrDd9HwTeIbm0+ufxXC9doadQao3ETT24udXPklxFCN0teBkg39FiO
 sd9rQEn76DfXYmVQAXAWOUN99Esh1dmadNA7Fj+TUhBIyoxsOVVKvFuY8UeqOSSr1ez7
 JEjpC/f9PA1mXj6sCiL1ZSIVMnSd867oiRdHjVngQsDFep6PZKW+w0WC24QBjXFsbqef
 0cgCNz1DWNLkk9rr2wXF6Od3MAB9UHrWMtdoPCQl+X0KntMdSwH9FK6EwV/MYHNdLQgm
 nU1Q==
X-Gm-Message-State: APuU4Z9uGtxA4gv1jMUMndR6w9Md6S+4rVWEZ+B+/msHKRExHufGUE4N
 vo/oqyysozluN2tzCybDOv+kiWX+7y2q8RV/IMK4mxNcjHF7ObMBH9uvqdOIWd4Q9JOigkZQojx
 HOPjZsvg=
X-Gm-Gg: AYBFou0aOVt6rn/mIfBaK3Kdf1sYiMDrkL9idxqRwRuEOZNARDtFo42azz2WKLq3lF1
 AMxOmzQn6iYhyt/YoHEjG8oX1/Rup706xe9dTHA4AYzT2AFaWAVG0wFhZHk0rs9ksObHgC+r7q5
 sloyTKcvB22m5zUqk08/goVhE5rSTe29dAC9KPhqWKibxIEihCHNaX+QpN3aIPsyWsInFcAXSCD
 A+ccMU8H0MSOYXx0FOKdWe4QC0e4km6ioNF2JD1Qfz/VJRJ5FpMFwOTk4pcUuXW67SThXIWYejE
 5UHpCZ/jRkhT3QEh8vuxPDncK3/GqUblCCksGVAwMPs/KqdO1YfNAOPqGReOmt87+L64NFMDfak
 jJV83h2C8SZNtfOMpT/vbk3dptAnI1Fn/9M1xEhD6LgcQdwGfeGdnO4VK4m4wElubdT+/kS+M3O
 s1rgapjbE4cHyEIYoekW2qBWdoEOSNsPhz+3jeAfI09Iq5BNfcUU25nakg8W0sdXxpYnB6/V1rR
 IhA2QGsUDGd9s6oRanBlYcTnJrRsF6x3QM+kTFQgqe9zKXZKmUQupfCHfK7m7b9cP/mqYGKxsfv
 wYaivGZ0lAsi41QrTtzuwRRdRYdMqw5G
X-Received: by 2002:a05:6830:6411:b0:81c:b7d6:e6eb with SMTP id
 46e09a7af769-85d3648e726mr10488465a34.7.1793741199291; 
 Tue, 03 Nov 2026 13:26:39 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de203dsm289371a34.6.2026.11.03.13.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:26:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] spl: pass the bloblist to the next phase in registers
Date: Tue, 03 Nov 2026 15:25:59 -0600
Message-Id: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQSaCKVxEXTZzWkdCG/FWE0
 rsbdfkt3tsIWk1B526jqi+DLXODHDpK92GelO3WTN75XsQFRskc8xKzYeUyAFx1AgcJLo3H/uR
 FqMWl6mjv3/hy/RvP+NC0fm+07x/P438PegAAAA==
X-Change-ID: 20261103-spl-bloblist-pass-regs-3130cf768211
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0bNK1JaO5/7WGFARj8AkXDC3fMaDmFeWc54gpd29OKU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq6lFr288+xk1bPCp12fLa755tRG400ZDKWb9MZ
 cEwx5QYUdaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaupRaxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbG8H/1lBZJZ4SxnedMhe2Fzpg5OW4rGuQ9Qdp6cS0pt
 Qize9cfpSJiHeHUjKh/SRhk2D0RM/lm0SsGgFnuR3/nKEOwObC54/QuYyl3VszYPDdzEMwHt0eW
 YXyZG4HMGVhKTwgoHgy48oXOL7EOLJe73ImIpsgGPVHGaSPOyLj/QMfCzmopI3tAVsCSYpbzLTv
 j3hgHLhoT3VMOgf5lzwi7cMh1hlO33AX4VIFJcMPYnp7jVjnbllPwdzXSqCYgp13qlGFgJj2vUW
 3EKUfZ12L4dYHsLFcdRKCQf8PhFRRVEJb3m8zntyjyRoWEEseIlj/h7Fu+A4PEhptP1/bvPzYdB
 p4eE=
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot proper already accepts a bloblist passed in registers with the
register conventions of the Firmware Handoff spec, but SPL has no way to
pass its own bloblist on like this. The only option today is
BLOBLIST_FIXED, which needs every phase to agree on a fixed address.

This series adds config SPL_BLOBLIST_PASS_REGS. With it, the default
jump_to_image() passes the bloblist to the next phase in registers. When
SPL starts BL31 (SPL_ATF), the bloblist is passed to BL33 the same way,
through the BL33 entry point arguments.

The register values come from a new hook, xferlist_to_boot_arg(), the
counterpart of xferlist_from_boot_arg(). It has a weak default in
common/bloblist.c and the ARM version in arch/arm/lib/xferlist.c, so
other architectures can add theirs later.

This replaces "spl: atf: optionally pass the bloblist to BL33" [1], which
only handled the SPL_ATF case. The Genio 520 and 720 SPL series will use
it.

Testing:
- sandbox: new "ut bloblist reg_conv" test.
- QEMU arm64, SPL -> U-Boot proper: on top of "board: qemu-arm: Add SPL
  support" [2] (which also needs scripts/Makefile.xpl to skip the SPL
  devicetree when OF_OMIT_DTB is set), U-Boot proper finds a record that
  SPL added to the bloblist.
- SPL -> BL31 -> U-Boot proper: Genio 720 EVK.
- 32-bit ARM: build only (Cubietruck with the option enabled), checked
  the register order in the disassembly.

[1]: https://lore.kernel.org/u-boot/20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com/
[2]: https://lore.kernel.org/u-boot/20261009-spl-for-quemu-arm-v2-1-460427488c17@gmail.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      bloblist: add bloblist_get_reg_conv()
      arm: add xferlist_to_boot_arg()
      spl: optionally pass the bloblist to the next phase in registers
      spl: atf: pass the bloblist to BL33 in registers

 arch/arm/lib/xferlist.c | 23 +++++++++++++++++++++++
 common/Kconfig          | 17 +++++++++++++++++
 common/bloblist.c       | 44 +++++++++++++++++++++++++++++++++-----------
 common/spl/spl.c        | 19 ++++++++++++++++++-
 common/spl/spl_atf.c    | 29 +++++++++++++++++++++++++----
 include/bloblist.h      | 27 +++++++++++++++++++++++++++
 test/common/bloblist.c  | 24 ++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 16 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261103-spl-bloblist-pass-regs-3130cf768211

Best regards,
--  
David Lechner <dlechner@baylibre.com>

