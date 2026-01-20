Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB353D262A8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E3883A3B;
	Tue, 20 Jan 2026 23:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UVeat6x4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C45483A83; Tue, 20 Jan 2026 23:34:15 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602D283A8F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7cfdd3146deso2418313a34.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948451; x=1769553251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qhOAw/z77FMxfP0ZHgVRQE5WtXuk6h9ubfbAXI1W5yY=;
 b=UVeat6x4qLXU3U1dl1mjw2q8AvSEaHoLjkvIMF9ptKyxPDY5R0w3+EgDg4cqzqdqTM
 +gjRa3v6rHCEKKdbUPMTN6lKuUUhf6FWDnmMv5hdi8DjhjVpQrWf7bYxXdG5D/HheS4y
 bTMxn70it8yVwwX32mBAy66ouz9E7rKTWxb38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948451; x=1769553251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qhOAw/z77FMxfP0ZHgVRQE5WtXuk6h9ubfbAXI1W5yY=;
 b=DQz2CoBHOpMi8i/WuyHVsb/uOd+ZUrCytVQ/rYvc/MA6FBbskAJ1z7iRQFGYptTZZE
 uQTABB7wklngkDxoeiASFV0N/oPyVKTiWjjYgMd2CdOM2uE4/JYpEtwHki6oJ6v25miE
 Te12r/oSDmDlmWACNRbImPYWhE6sOaf7kmTMIeT6kiXS/skCKL77elAEfbCbhPemAR6Y
 2hRDoeCEj0SNsLzKqndnUlCQwQF5PmSFvgPp3HmtxNZGL6kOI2zSdC5tlsskWKIfl4Fi
 zly4LLBsIsaWBWi9v2vb1nhLVRpj8qG2j9Hw/KOze3U4ccrXF+UnV38RG2YAi61XxsEm
 vAoQ==
X-Gm-Message-State: AOJu0Yyd36kA7j9GbgiMMFbRhkcKZK1x9HTxVQyEoICpODcbxQXOblCB
 qik2pOj0eyzoGFWioICAhbgqmxShE7oE1f7mW1G9vXs2wBomb86BbpwcGujXE2NmflZZqGElNfg
 3+RU51Lk=
X-Gm-Gg: AY/fxX6w8SKvo/LnfCo+cY95rpWFNXinyM7nbbZaYcyQib7odzBcTep090oS5f9VpM8
 i1Q2ZDxw69yOOK9F5DbeNBY1K/WNctYhcZOkQ4H7v8xrhD7pDuBEgIhDLOlGsjNk9pqqwGZXbGj
 jF5WsXroJcYADz4gB2cfYrLGDJ6Imp+MU+o9xIYktu/bvDxqfneQbof1gu6fJEOxCBSqpQwTTXP
 v23BYlUUbqk5ogOWJTYRdgpBBdB8yTShr14q1Da5IrpiwxMpnp9A08xRC7KA8tYM6jFFbG2eKjO
 8Uo8moktq7UjYffythAZ0CpF4Xjm7gFswbwpE0GGnxVtck3cQAebPXy1cTz+epov4HJ6/I2eRpn
 z8GLjgtu/+mHqcyqIvA0GuEXK7yzBkUY9NqgbB0TIEHqmlt1i9vWrC7yfqO/AfoehnDP2nrloXN
 jj0HaMbjF2eTn8IBJaMXY1DnmLoLxrVMardhc8H7dOzjzhRkiq5k/q8ppRFY3vgTEQYY94MgO1Y
 nz4SWkVMXdzhaD54wpo2BmaxYDysxjzALrSmUtBow==
X-Received: by 2002:a05:6830:3bc3:b0:7c7:2df4:faa3 with SMTP id
 46e09a7af769-7cfdeeb0ae4mr7146335a34.33.1768948450991; 
 Tue, 20 Jan 2026 14:34:10 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] doc: develop: codingstyle: Update b4 external link
Date: Tue, 20 Jan 2026 16:31:44 -0600
Message-ID: <20260120223405.469050-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120223405.469050-1-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Rather than pointing at the source code for b4, point the the official
documentation. Also, use an anonymous reference for the link, per rST
best practices.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/codingstyle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 013bfebf7e48..7304eea0056a 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -24,7 +24,7 @@ The following rules apply:
   <https://peps.python.org/pep-0008/>`_. Use `pylint
   <https://github.com/pylint-dev/pylint>`_ for checking the code.
 
-* Use the `b4 <https://git.kernel.org/pub/scm/utils/b4/b4.git/>`_ tool to prepare and
+* Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and
   send your patches. b4 has become the preferred tool to sending patches for many
   Linux kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` that
   targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintainer.pl`` for
-- 
2.43.0

