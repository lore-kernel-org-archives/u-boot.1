Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED53606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cD3skUv1;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rdcdsO5r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BE8240871;
	Tue, 20 Oct 2026 17:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocJcYv9UdTZ6; Tue, 20 Oct 2026 17:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6874408C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517170;
	b=OEz3eQWshDfOYVu5sd54HT4WyuxxxYlxgqpdwNgzRyAO1ewbX0rDz7cMMn0sB+wUKWxY
	 QIiOFgKAXviwSmgYD+lTyyz+GW3XkGCsP420QHnjOtK7rV77eJZ0soz5aQ2oWBKibcKEk
	 +hhIDZXoWHbf/R1fdLegdidzhZ4nfoHnARipcwkBGkkIT687NRJqQZQA94rz0Uk80sdzh
	 Li8aI3EeeM5P0NNnAvm2ugRjwHrmI1AmJ4JVivANQMKH0cotgtSOPR4N6W/bDUcqnFDBl
	 vEwH6CnTfDHNp58qLI92m/9QkZ5AQkHuBqupC3zt+D3XagDHqzaKB599COk+nPZWwBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G5MRcz8VRCuKdiS+SB1bEVpw3qtM/ThRfX0lK5Q9ENg=;
	b=rdCpL7Q4EjSEQUHmCl590URKXu0K0CLH2gcHciwJk8L6IJ6MKjJ/iEDDagSmZwgLqemJ
	 HczPAoStOZ0dDlzMGbgMe0EXFOr5iY98gzUyqo1Nbez0lSstTxgzvRKK5r3znpIJ+sjk1
	 zWsYF7O0FThP+7wFXLvfOgfDOLfysbG+cSFFy2TFQKe7oW0/TWlo0extBeMKNJFiwYOZN
	 mwX2CpEciwYRMkjaM30BA5baEoPWCoRILaDLXaFrSQ/l1xRc9NBtKgsm5fikaMn5gJfUW
	 2VwsCC4T4qgvW5VErDr8emB7hGFAIaSQpmOp1lvwT42gJc4zxCHs/VkZ/Dl9HHvpivg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=rdcdsO5r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517170;
	bh=G5MRcz8VRCuKdiS+SB1bEVpw3qtM/ThRfX0lK5Q9ENg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cD3skUv1XfyWLrIiI9m8guydrrjsIwzoUGIgtKeOGibeN9uj6BO1tKUe7uiM8+Oyj
	 X/sZDxn99wJbRMKD2RBgUQQFT/eAYX3x1Jdym0mPXDV18wajkOS0Y3adOzNcN5OXae
	 UuuquldCWQjTA5iGG/TMnE8xVd9eWkQu7iqyGIam+Pls4tUv09Asmyv1Ad5PV4cB0/
	 fJP2l1H8lsBMmLLj0Lrw3SL3pKT3V0SrS2KyipDkqvxDGkKD+wYBNFmPPjnzSvqfpH
	 8SE2sd8VaU7HOZ8893EtIYajEtI5ISbJ4ghpkbAygTbv4lHexyVbajPoChSunxdc0a
	 E0dm7j4oXENCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6874408C6;
	Tue, 20 Oct 2026 17:26:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EBB551AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D17F840898
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qwaoawngfq4T for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8B8D4080C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514512;
 b=Sl0DqCl1bMRp47mpINuD2z7PilcEvCgedvP9I2qTThYrS+1QQ1v4jhHCQWPzCNxaRI5X
 G4NkHSkvF3CsD2tWB+IzdzCTFh5oE0+rNyHocUFTuslqkamm1SpKqumE0lxvnzggEqniu
 AHxdPnpoEWCtxiQDxFICYOB13b6w7qIqTvj+A+IOT3ZKsYU4LvD2jgPWZIrQ1WpAScHI8
 7kuw+/mBHicya71p2wXAHyL+IJ+2u8SEGjZZEsL5FAhveK8UgdQJYxsjpdyyGYVDyqCap
 DNSOeFdqzw9/KjhYwYbdbULGkoyUjxyrugXzQxlc3+KDKnVjhUXueuQE29KNgt3xSWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514512;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=G5MRcz8VRCuKdiS+SB1bEVpw3qtM/ThRfX0lK5Q9ENg=;
 b=OoUtwBKwQQMhhJz8+oqzvcWZcG4JUnKYvmwqbjmLNlY8X4Q8pREHwd5dNpDYy4vKmlIH
 fp/nU+iL0kgLnWJlGGXNea8qz9SQw5Sfkj/6aodOli64Qdf4DYKyodz8FVXQQ8L3C4bda
 WlccAIh9JA5XNbpTj4t0dS5Wr1v2+xLF2640QbeEHZf5vAv2kIv6hiv+4arEfLH24lnlO
 16EFOLihJGX+nJeDxcgYl960LIe37hU4cb2XobbUpXovMC1VVRlgVMhQzr052DcD2elff
 AYDwe8D+b9MhOPUPmBH5bZQzn0jU4V0sMehOpHEoJeTJHPnGlzLzE4J0XAKUY7NAsDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rdcdsO5r; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rdcdsO5r
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8B8D4080C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:51 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so24101245e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514509; x=1793119309;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G5MRcz8VRCuKdiS+SB1bEVpw3qtM/ThRfX0lK5Q9ENg=;
 b=rdcdsO5rOrIYKrp4qJHC3TpwjE1JeGvPuLEu0/V1R/OrJreTIfz9QMqUc6GZ+LRt0r
 mAS/Iqkt/8ZtE2qAkw8ArzcOtj8Mf0NMbslQCLXPF2szXusKThQsbYcGcN/Zq5vC99/r
 w6Pbz1xtmlOqYU8X2qnLs0rR+1K1PKA3Ov4TTbc3gn1fQ58y1PQm0Yu4T3PORzHHPQtY
 Hrt/R8Nl/WPGmfOD9vO2Aa5IFNVgv3qtqxWEL642rYzUay3lVI8TzcfZk1v9AekRmW7l
 Z7ewJs10hsrI9qJTxOIXOtYw3o6EZDK3jfYwjZtAa+kQCmSA2ykg5I+MvAoX25XJUxBK
 nCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514509; x=1793119309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G5MRcz8VRCuKdiS+SB1bEVpw3qtM/ThRfX0lK5Q9ENg=;
 b=AQ9frtOIrb9gacnjnqmXcadg4j90E7Ua4jNgNvFYN9iTy8ufCil9A3alfpAjPHtc47
 +UNEJNhBsKup4WVHh68KQE7Pc9t5+7JwPkZCrE+6XhLUBkdQ3LyXAn6fXsIR+f8tsLpW
 o/p5R55ZAZFl4W4bJMOHjwXPufFTIvVqpfxlS7ZjnH34Bh4N76jc8tMmYrbANaOIBBYn
 OG7UM+6WrHIGGKPupTyFKJWozEeVHASFPQGurX78bqB5KCXID2MPR34njihzQfG5rp23
 w5I9/NH9PVzx+7rklAGq+1JcEC0ryvMNQDV38DRDRT/lbtupfdElCxEEHnYH7PNEUylr
 twlA==
X-Gm-Message-State: AFq9FYKxJLBh3dlBrwO6CQJK2Q07yz7KIu8wB8RkNmL2egvKeU3KVUwy
 q9i4skWgK3PHwTKFPvWm85OynsGNcoMcx2P6JNwhNUoq+XckeP4g6FCV4frZ+SVVK48=
X-Gm-Gg: AYBFou2h1hM0OPr2g1Nvj6O7UAl/kECE53nUml5JkeNSDRI/1Cj0aP1rT3DM7xiOhwY
 16IdtcU0vkOx+Cu+PdtC40kkz47auip99F80wiJHECGf9X/glTr4kg4Y8X8dPVH6Jv3G4M8Y3DC
 8J75qF7ZzwZtbDj8nYppT/l/Kzn5CNr7K1XiUTj6DNmkxF8Y2NWvN5KIotlZaEF/m9VMzX90EkK
 UOZ9pTTsN4haRkuDtVriEwUd8ZSy7Wmr7OPsRgkuNXcl32R8T1KNvBkg+RtQx3RwtI9vNHL8RAO
 cRz4sDP6v96d8Bt/PK/qgRpAxs28wMP792Ai0rFJdYjQve6ob9ecIAkegKA9e+1Pimnlo7nBtXQ
 Rnjddh/Ku3ps3K7UW08zJTiAzlJXIsc1hjstmIFdBcWpADnvsgs7JugQwK4eA9qIqo00f4eEIMX
 WatfzagytvvVur84hFfRIPKyxU+TNrK/ArZmp0I9ytzxntLRjOR/RI/8aJG+Ks1CdqYvgwsR84o
 MxgBlyQ+1tkLwkcy6qgmBJzMdsO5eREfiShvGg/dcAT92Sy6SgO+geGmnzSe+bZ
X-Received: by 2002:a05:600d:82c7:b0:4a1:fab3:cf62 with SMTP id
 5b1f17b1804b1-4a1fab3d2b2mr27753445e9.28.1792514509310; 
 Tue, 20 Oct 2026 09:41:49 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:48 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:52 +0400
Subject: [PATCH v3 05/23] spl: fit: Look up the compression without the
 table in a tiny FIT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3023; i=alchark@flipper.net;
 h=from:subject:message-id; bh=4lXddZdp7raRPBfq+utHWGKlAUVCzd5n5mPdcB8x1fM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7mStf5eqFDUovs775kJFK5oPFg+I8syI0rV0mZaz
 cm7/ufsOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAbjqOYwMbUcbuUr9d5903MkV1cXO0HiRrcRS6Vj1M2752b8m2Cw7w/Dff2bjbpE
 lXkcjZ9zSW/xKTzU5mfOQ3ELGSue/WmGvF8myAwA=
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

SPL_FIT_IMAGE_TINY keeps image.c's tables out of SPL: the OS of an image
is looked up by comparing its name against "u-boot" rather than through
uimage_os[]. Reading an image's compression, which SPL is about to do for
any decompressor it has, still goes through uimage_comp[] though, and
brings back the strings of every table in image.c: around 2.5KB on
tqma6ulx_mba6ul_mmc, which has SPL_LZO for its multi-DTB FIT.

Do the same for the compression, and only tell apart the algorithms the
phase can decompress, by name.

Return the compression rather than fill it in, and count an image without
the property as uncompressed, as SPL always has, so that the caller needs
no default to fall back on.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index bbf156f204b6..a07c9a86d7d5 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -230,6 +230,47 @@ static void fit_fill_image_info(const void *fit, int node,
 		image_info->entry_point = FDT_ERROR;
 }
 
+/**
+ * spl_fit_image_get_comp() - Get the compression of an image in a FIT
+ * @fit:	FIT to read from
+ * @noffset:	Offset of the image node
+ *
+ * With SPL_FIT_IMAGE_TINY, only tell apart the algorithms this phase can
+ * decompress, as spl_fit_image_get_os() does for OS types. This saves the
+ * table of every algorithm, and the strings which come with it.
+ *
+ * Return: the compression (IH_COMP_...). An image without the property
+ * counts as uncompressed, as it always has in SPL. A name not recognised
+ * gives a value which image_decomp() rejects.
+ */
+static u8 spl_fit_image_get_comp(const void *fit, int noffset)
+{
+	const char *name;
+	u8 comp;
+
+	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {
+		if (fit_image_get_comp(fit, noffset, &comp))
+			return IH_COMP_NONE;
+		return comp;
+	}
+
+	name = fdt_getprop(fit, noffset, FIT_COMP_PROP, NULL);
+	if (!name || !strcmp(name, "none"))
+		return IH_COMP_NONE;
+	if (CONFIG_IS_ENABLED(GZIP) && !strcmp(name, "gzip"))
+		return IH_COMP_GZIP;
+	if (CONFIG_IS_ENABLED(LZ4) && !strcmp(name, "lz4"))
+		return IH_COMP_LZ4;
+	if (CONFIG_IS_ENABLED(LZMA) && !strcmp(name, "lzma"))
+		return IH_COMP_LZMA;
+	if (CONFIG_IS_ENABLED(LZO) && !strcmp(name, "lzo"))
+		return IH_COMP_LZO;
+	if (CONFIG_IS_ENABLED(ZSTD) && !strcmp(name, "zstd"))
+		return IH_COMP_ZSTD;
+
+	return -1;
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -285,7 +326,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	}
 
 	if (spl_decompression_enabled()) {
-		fit_image_get_comp(fit, node, &image_comp);
+		image_comp = spl_fit_image_get_comp(fit, node);
 		debug("%s ", genimg_get_comp_name(image_comp));
 	}
 

-- 
2.55.0

