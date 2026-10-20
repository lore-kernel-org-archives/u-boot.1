Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C29606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UYb2MxnZ;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=WNxobKO2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1C4C6081E;
	Tue, 20 Oct 2026 17:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mM2c1R-1LZQW; Tue, 20 Oct 2026 17:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06BBD60819
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517167;
	b=B9k1JErR5E1cIc7SIpczRZ5Nstdqg7mLy7wofLD8xfQmNPZvGPTzXe+naaEZotMiNP5f
	 O11/vN8z8uIED2yqYQu0A7OgfQG3J3JDYYRYeOUAc3xdXgj6FFmBNV2WEO4/fBnJe7ny4
	 VDYzgPJ7wn7cimmLCyyZUykRuP9LJ3h9MayqwdsqbJdVoRU6t9LO3tgm0ZxrzlJht2kOy
	 eKq0EGQWPDaYbIjOuB7/rl/OLybUMANJ5UYiHv72Z2BE3bx9ey0+rr6o2oSmx05AAbMhK
	 Kx8qzMgjNZ2eMiPZ/1K7binheUoM37riorqTbnMpLIZ+OcPnttvTalpd3xruXV6F1IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+sK1ZADN/ejKTq1+1HxO6A6XEhDGHLQK2bhm6WhPq5c=;
	b=dw7kCntJ6pIN03EijnsszznikY5v7hgksWjeMSj5do8uLxvg9kG6GaeRcshCXWdC9XKR
	 vYBM/0FqAiH8hJAKaEE0xbr8TavOTe9jHsvPXtjJGuC1j1zrKTNJfn9jB4PoTsYlr4lIc
	 sOrwTXF3de0jitS7dAvUicd3x6yiYJN8PoqgcHNutI/MqUXRA0GfUsJmLXl0+ZodUiksH
	 GnUD8nChkTq6513MowPIDSn0X4dCTlQVIrhJ4qkQ5IeA7/5DRmOQ3uIfDIg3ROzmBMCi+
	 hnRJgiD8Q48yWiwVZVawcjvcK2151VF0CvH5feFnlf68HUSR/gY2gJqzyQ2Rm8D8jHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517167;
	bh=+sK1ZADN/ejKTq1+1HxO6A6XEhDGHLQK2bhm6WhPq5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYb2MxnZxqh/JRu9x3Ldg1I7/IfSFViwyokgMNYlQwB1U9lSogQ9tLKk6hKs+aWoh
	 wam2OpmLP9NuvaPrEV77F/g3I4ZhHEuumQeV7kKH0RPH/WoeKblT1XYRCNhI1kS+EU
	 ecclGUkM9ls+a8l6ug6PTkGkeG+nkwJ3jXZZYr1nIk6DLFkTZcv7PTadnbzajPmOok
	 tz+LPfwZthlVAjlqzIvHNhb/yOVzbP0taYWBfu95MZuUJ/hyooEATrNjfOCOMoPyJJ
	 ofvXQkDqZr6zCUol2bes+6gFESuyO5i2YUVn47RbEI0H6dlEcRKCJNrMdO6fZjGoV6
	 P4tBQ6fZf81bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06BBD60819;
	Tue, 20 Oct 2026 17:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAD1B3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7E7D402E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OF-gXNeOB8C1 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A580E400CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514499;
 b=BejxnNYVOjyv7SB6WkBq/IUYHuY0uWjZCsZL0US0UgvxBlFTSpS8uoiiHuiurLVlyNMD
 dN4KAVLI2x0ChcGvKRDrW1DygTRtKIid6TVjVETbTCs4ergEryWETkoZZFbDNaLZYrKZS
 wMuijD0D7bRhcUwLVA63O3K2/d/HSPyzMpGsITmBkv/WysgR0p8TmiuWm0sPOyDVkDVyw
 QC1tZ5TZvG8ItW8f1uOsuZK08pIARZv3TtvCHq09m++DK5D95XvkFp4FpluqvQrV7X8So
 FLJZvEXQthkiIsPQMji0ZY42xfMK554FFhGKulK7qreloctpo8jQY5CT0O6pSZBa7MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514499;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+sK1ZADN/ejKTq1+1HxO6A6XEhDGHLQK2bhm6WhPq5c=;
 b=YxvK7BWsPYEJHPl46SFUz/COXiBMQcZ0a9SV4LZsCmza5Zzd+55KL1wZfQH4dqccoMJ2
 WT3J4ifQJK0ikwtSgZgeCcJ604gg0F+bPA/RBCnrjvO5/j4Es2yQtyVsKjk+WRA2nw7am
 6YbK5rWq/pIDOKNq53jGrRVwxSYTVo13jH+x8Y73sX5msZj/bknp9McTzpD0dmzm4gfH3
 MOJddYzyoDFvlfjZKYnFT5dma6PIqk4riXmPiYaKGXRRmzZgq4+6C0ho4DTlQaW/7/3tp
 9wp+pPdx29iatEqQUTJ7IpZogpEHeoqxPcgkVPzX75+aoGvPqWZK3I9lzr7fHsm+QhA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=WNxobKO2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=WNxobKO2
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A580E400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:38 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so32646155e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514496; x=1793119296;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+sK1ZADN/ejKTq1+1HxO6A6XEhDGHLQK2bhm6WhPq5c=;
 b=WNxobKO2+o9i/vzRT+ZZ3zq4PhJdpD0cJF99OxjtjN090xSW+gt/BazOQmpXPlke5Q
 iQSj904sC9POf6qvxoe1u+Etki+XJjXRRNKki3W9vPbCPmuwnnrKMCfc/RqyACOpaDHE
 1DCo9vqrICsmH9+gwGmix8LDyCh1MHsgnIz72VDcp8GiRKi6p2JarWHLNWdK/hhXnitI
 /5S+Q/suMBCLtUrvLgkYcJw015+pnR8whFu1cyReFOwITjafGeDcP+rL/ujJlt1NYb3q
 zmqjvnrpur3IE3pjQS9RUJp4kKNWRNJJUF39yZEGIx+pe/2V6pqRPvr9XZjOpO8iTRB5
 iWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514496; x=1793119296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sK1ZADN/ejKTq1+1HxO6A6XEhDGHLQK2bhm6WhPq5c=;
 b=lrBeUjv0qgSmnDg7IDQChv0jeKir8pTbtZcsADzhmW9vcv5Xxi3eeqbvkrtPvzvjPa
 2W3vf0NxAtZbS1JNhEQH1fSRlo3IPSFEO0vtbxkksVbAYwaVsrM/IEMgkP34R0Bb91zc
 fbfHDlGPLxu7kesYwXsuqlQhRNCdASHXpAFNNp62i7Se/vIck1LbuyZgLj0Yb6uXnORV
 tsHegJEUA6wYkENjFZpriOoHyHBXKT4/usB3CwMqkuwPOp29jDWMslwEvohRZ9W2I6rO
 fCHvK7DxqYvpi7i+D/6WMgtYxvfmzumK+XQQrpcvsyWUg8VD6sSyG+9ezopvwbMf4mhF
 ia3Q==
X-Gm-Message-State: AFq9FYIGzMc5kB8+d4qkLKaeCpSM53PqxG/p4eGONuax6qC96Z69wDI7
 SzY6rKDSOHLUiW6s5b8lhTdrxtU+6hReGiN/Ax7IepfdWLIarLr8LPoeoB0qdBjXxVA=
X-Gm-Gg: AYBFou0LTrYsZYApgcBYj8Kl8EQ8UZnLVMPjMgpLer+kO//oIY1HIFeswCFqXzm0JnP
 5wnZPTEP3zyM7b0AH7xBb8+3T8yI4V+2Kmu8r4fi2hsYjWco1s5Hbdaf6zocUHqfsssXFjBL8AS
 GAuJp6UhrKtBnK165/ZDtv0w8w9TqZ3+HtEeUBABvQfgrRMTCkcIWnl/TWrA0z5djUQo+Z196tp
 EkAuI9aj6th3llmRdiKyi6oZE1jI4V6FbtqLmxszwJP/Hopgazk+UtFIeFctJVNdTK0QSHo9rlU
 nlfS7Msbtm3S0dix5kxP3Ubmn0nnTLuYfpFVBcAorSkmH/nBMrPXYl6pdIuNBy3CBMv4Wz3Jpr9
 5/GhAsIO+JbYylreGCiDSxQpMlJ4zZJBqmRXaE1uSlHx1cRULOp0xqq1daayRjxQcos2dZwUq1u
 sKabUjtlevr+IAZuS9AZaY/yNgYqHwChlvvBStMVIli4qhXuB63Vebks1FqZxdNCS+9uAHWkoAB
 49sMhZySvpGclmB3+DF4pzIggIltab4nnFlksYmx0RQlGDLmBhsyg==
X-Received: by 2002:a05:600c:4f41:b0:4a1:e0d5:293e with SMTP id
 5b1f17b1804b1-4a1e0d52a92mr217672715e9.21.1792514496199; 
 Tue, 20 Oct 2026 09:41:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:35 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:50 +0400
Subject: [PATCH v3 03/23] lib: Build xxhash in the SPL phase
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-3-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Lu4Zp1m5Iv5YG5BXWbbccbawMM0jtyR4mN7vuP9YZEA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lS+ffjC5dVwqb86Ym5Y17MtF9O9mXLvqfTDITOX
 88onvYzomMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpzp/PyDAzO91TcsHdRXP7qmv43uoF+L4sTa5pPKQ/dWVpx62PkecYGY79ZV3
 w4+SVX7p12uLv1hwI2DX7b/+KucmFfGLpcita2VgB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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

SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
decompressor calls xxh64_* from code that survives --gc-sections, so
today the option only builds because nothing in SPL calls
zstd_decompress() and the whole library is discarded. The first caller
would fail to link.

Give xxhash its own phase symbol and build rule, the way the other
compression libraries already have, and note in the SPL_ZSTD help how
much heap the decompressor wants, since that is the other thing which
may stop it from working.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/Kconfig  | 10 +++++++++-
 lib/Makefile |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 268e9a509544..e9acc25b80db 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -909,6 +909,9 @@ config CRC32C
 config XXHASH
 	bool
 
+config SPL_XXHASH
+	bool
+
 endmenu
 
 menu "Compression Support"
@@ -1087,10 +1090,15 @@ config TPL_ZLIB
 config SPL_ZSTD
 	bool "Enable Zstandard decompression support in SPL"
 	depends on SPL
-	select XXHASH
+	select SPL_XXHASH
 	help
 	  This enables Zstandard decompression library in the SPL.
 
+	  Decompression allocates a 94KB context, and nothing else: the
+	  single-shot API it uses decompresses straight into the caller's
+	  buffer and takes its window from there, so the compression level
+	  does not change what the SPL heap has to hold.
+
 endmenu
 
 config ERRNO_STR
diff --git a/lib/Makefile b/lib/Makefile
index 925cb6198071..79308b10f7db 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,6 @@ endif
 
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
 obj-y += ldiv.o
-obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
 obj-$(CONFIG_PHYSMEM) += physmem.o
 obj-y += rc4.o
@@ -88,6 +87,8 @@ obj-$(CONFIG_$(PHASE_)SM3) += sm3.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
+obj-$(CONFIG_$(PHASE_)XXHASH) += xxhash.o
+
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o

-- 
2.55.0

