Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CB0C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC93883A9;
	Tue, 18 Jun 2024 15:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ro//kz9b";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CldX2dG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0D087F5C; Tue, 18 Jun 2024 15:56:31 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0115A882ED
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 370CD18000D3;
 Tue, 18 Jun 2024 09:56:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 18 Jun 2024 09:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718986;
 x=1718805386; bh=llM8J/ihAKvSxRFDxwofhhSG1YekkNqe3YRboh2c+1M=; b=
 ro//kz9bxwEP66R9sRF9sXQ0j87WVzj+wnu0qznqEi4H24wp/mnAF4oOKpI6Rgqx
 EXXBkphd+sJIL0AyxKaC2U4JTQoud78uHMSHypPhvzAy16AJyG9cKl/208kAjat+
 eq4gXf0+fCyQvEQh+LfGbqldV7cmtBG2w2JgYxWusHrzH+i/jqjCp1jfLQEMjhTm
 LJ6oh6j0dbBi8CL7bpd9rG9C503j/mku5m3RX+MY7I4aZwIjRckTkmJNvPfN5rKx
 9dDRelJBZp8Uo6aAPrKBuu0YMf+JXvx5ra3bsPyXycE54WhHLmWvwJ6XeryQFvqv
 z9gj/1qLNKzTgWBB5rN2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718986; x=
 1718805386; bh=llM8J/ihAKvSxRFDxwofhhSG1YekkNqe3YRboh2c+1M=; b=C
 ldX2dG6ecrMLYRWs7qTF1KUyIzNd+J7J+fvaMU3iqnlr1RHWK3ChbETJOwKFN80U
 3rFAwgWNfK0nbqPml8bErYYdcmdjz3eVvHPoQZ7XdzeGcdW0gfng7imWAXebvfQj
 lthylXTiBMpBqldqwLj4jgRHaV1srEcbBkwGF0/RhiuZQdwZvN4BKp+kFh0m7aZz
 AvpSrirsOUCZHmhzdrWqxXCwEBGTlQSazk8uZHolVBfRcXFfy7WhPjZ/OT20P7Wu
 8lG2aNR5N/bFRlgpkT2LN+t3QiA1C5Fw9WL6OFlq4htlYZRyK0S7fDdc3bujxwZG
 RATi8NDyWyFNpjHUMkNmA==
X-ME-Sender: <xms:CpJxZvxXm46N7f05AXtxIeMoQkf8Cx4Ka_TpDxMs6j0sgphbNe15dw>
 <xme:CpJxZnT6djXCD3scbHK8NaaEgeAKfilOngI8QNMcg73JkfSuDEdTRgfu8cCo3o6W6
 rOsfXmlpUtSYA5dYTc>
X-ME-Received: <xmr:CpJxZpUz_RqeJtTJoElE9y_uBP4dpF5Xkn1lPTaW6yCHrexVDTYnZ18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:CpJxZphAZgJWGjHDBeik7LpoJ_oWo9YhIgi8h4DtUuGRHU0d6tD1uw>
 <xmx:CpJxZhDV9XvvEeTG-WcTzlOKA4bG_vDw2m7A8iJS_0rlzJMA-y8d_g>
 <xmx:CpJxZiK0vnA51gDFm8NbjQYmScF78amrFgq05BS6yOb7_M6xOUauAw>
 <xmx:CpJxZgDQ_lRmM0wQQ3qbt_HAQ29iE0xaa-cMzfZ43FbpIdKh5db7ww>
 <xmx:CpJxZj20vnV9Fq3R3sB43c-zmdEAD2fkE8HTNY_X3TbL2nCzwOOJDDIa>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:25 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:04 +0100
Subject: [PATCH v3 04/12] xtensa: Define PLATFORM_ELFFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-4-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=N24eZYxZLUyusVP2k/IJowRxSUb0LlvcwQQo3gqkjf8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYxzjKb8Edv8zGb2g7iS+tmiro7Je/ouSjALJ0VOK
 Z3lbO7UUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABPpYGVkuGO/xdJ41/nU/7JH
 dPpmv9MLWeg3fZvQbae19fxJOjnl/YwMj4/FsS1uv59RHbOgNXHdzN/8C8U7NPv/zt25cpepEvt
 1bgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

u-boot.elf target requires it to work.

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Concerning big endian CPU

Note: CONFIG_SYS_BIG_ENDIAN will never be set for xtensa
for now, but as we don't have big endian headers for xtensa
core either I think it's fine for now. This will be improved
after my arm64be work get merged.
---
 arch/xtensa/config.mk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
index b0809999e403..200b66f85047 100644
--- a/arch/xtensa/config.mk
+++ b/arch/xtensa/config.mk
@@ -7,3 +7,9 @@ PLATFORM_CPPFLAGS += -D__XTENSA__ -mlongcalls -mforce-no-pic \
 		     -ffunction-sections -fdata-sections
 
 LDFLAGS_FINAL += --gc-sections
+
+ifeq ($(CONFIG_SYS_BIG_ENDIAN),y)
+PLATFORM_CPPFLAGS += -B xtensa -O elf32-xtensa-be
+else
+PLATFORM_ELFFLAGS += -B xtensa -O elf32-xtensa-le
+endif

-- 
2.43.0

