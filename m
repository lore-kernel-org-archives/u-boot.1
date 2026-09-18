Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9578C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A55060D7F;
	Fri, 18 Sep 2026 10:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZVHVHCBsjZW; Fri, 18 Sep 2026 10:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D75A660D8C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728814;
	b=sitOs9NVHL+DM3Q2RdU/hZPagXqf0V7GXDCHAtSyMoV/AFduCX4XzQ316SCiXMbbzUis
	 JLgnGzH6XU348KCMMDA/MRmd2h5QmtQPiy8gWLqIT2BQdtca1LXQiWVRGzpdwMEuP/N2h
	 cOuAs+nG00nARZpTt3/6zBkyx/ukYueYZiYBag1SJ80XWjXCx5d5UGoSECSMW6Ns/73L5
	 gyzt8TAsB+fnbcmDhZjWAXh8AdcUsqZ8vJbvhndg/y+vSG3dNMIdfEPiUu4UkY8gMzjW/
	 GwbYwfwROGxZFGujkOK+zZ2f0A2Va0S5rrF/iWItbwGD/BfvSRytTK4lDy6ReXiFpXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
	b=j3a/6gWvjCkTSHfVlrG/bM9Ny/VgM75CJP5SQ1kIScXuw+vGaAVwpn98ydRvXXR6Rbrl
	 9yHbYLtDB6WmyLDIhBOb8R5EIKBFRDxQvw9YZQvrNloMILTw7knUj/71esthWOynvH0PL
	 630VMPWmrgf7QfKGfyw0DICEKLRzBuidFL9ZDu46FdqsBEODWzhex0XYrJmwGFhd4ru/f
	 /77LBlC3PPsMSMfZ3HExlwRdC9kgQRIBQSfcjR2oAJaGdX3SjWtpdPR5lrTeW2FMnBp5D
	 r/B4+x7LG937YGtFoVcStODT3dFIs1g0cp1UJ7DujPJqEQLLSAMKej20mpNokEokIKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728814;
	bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0pf/dm3KBQpvFxypc/mmnx+WYBsV9uFUziwFJsQjcG/PmoaLCmcbAPWqKARS4KPMj
	 LK/PRNolcJ/7hvQXCULMdcDV6KFQ4iuXn4rAqURQwqbgTBduVR9aLIPqPzu2Wa9rgw
	 mAfmCk80SvNbJzj5mcLxde98wVaxAmuAMxdJ+GctSSjoRXIE3hUBdWMtp9sIn1kjVn
	 0WffQBgNzt3TvktUG4U42PEd8hHOry6vpHCwvmvmU+ideWf+pHWyW0hEa7/Olvz6s0
	 Ucpg4Yr+fjnixKO+jdlFKkP/hvgGQHn53s7PNaLe9zON+ZJcaaRYeRkoHEamN2JP2K
	 i3+em7IrBm64w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D75A660D8C;
	Fri, 18 Sep 2026 10:53:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F96543A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 219F640B6B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N-CZ_gMtetH3 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CDD3E40B48
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728812;
 b=HFNED2VBmr0nGMSe45xIZmSwbcRUBcHlOD8TzRTTsQRytkLfG5gnSgVby2MCEbGd6aMC
 GA3OOgS5fEFV+PJ19xrIM4OvbZtt8yfxsXxfcGZ5NmUWD7XhEUhpSPslUsqaZ+Dt2raKU
 59wc4K/oYtwP1b67e+ghEE3fWu4LQJghk/E9U0jly7v1eXvi/y1ndukVQvtF2Wd0Ykwi0
 KHqHCo0oQzKKK5CnKJwGqtBpcLg7SoKG2LNaMEvU57rT43QzpCsRgfoqsLukBfKrRA4zz
 Lmso2urHA+Vcsn2cssKUjr8cQs8OTMsqlLpe889uqUA7XysZ/wdjSLlDvvHsNmPW6wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728812;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=Iq0FAsQ/+Xw/qZ+vmkSY7LrhWDQ5gX5Nr1OnD4Xjlq2dCRPwuCtHlDxX1YStuZQRGPyI
 OK2DpZ6bR4IYiiF0UNO6H6IrpbDZcezwpfl/qUzylGu23TFjp4TH0fMDszxEDsjqT+n8r
 Y/j0R/skP68+Yk1lXHPNhr1biecZTPHuGqXuN+1uVqS0bATmY7IDrPa2XZw2w5SmBRT9k
 5tHmRReuR3B3xuGIUWpdtXOLoC0rwJ9UFKfp2x9rmQtAtk80H+r5/ipVBj1qesOFBse1a
 oDuQNNYg02WSfAjPg0Tn8wMkLXdn4ON5Tw7y78zWd0+ePlUQFrxMK/9tD1RXxGykAxw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=rJ2gjBaJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=rJ2gjBaJ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDD3E40B48
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:31 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so196626f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728810; x=1790333610;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=rJ2gjBaJpi67vM8KnNKhZSOvxAW8x5QtXIv55Kcdvh7CGhZR4UQ9NFmyVwn+QxwbMt
 y5lCba90G+u0f34SLJl2V6VvpParbswWCEVOEPD8hliSo5LZHyetFvaGG8IByUfE4Pyq
 iOGXCye5+Q2VVyoNsGdiCLK2tPQOlQ5bi+bo9rip/fgF3ONpfyZ/aGhlvYzPf30jfUYQ
 u5mTlqsu9ApCgKNYcxasKEZCdBkhF4DZoJD22CfrDEf93bMUwwA6vhUJrQYtsxVFGqQK
 Jzg3uBPnmRXB6WPIaxNCUC2erdGoKMYc4bd+8PivrF7cU54AFt+D2RLMmPbOtcew+31A
 6mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728810; x=1790333610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DuWFCGPZYjce49/mhby3CRj3/8KXJB8akjKNTZwO3m0=;
 b=w1FvBVbmVup7exIlgtQG3d1ddm79l0Do450cKyQfulY7/WjpRQPzt4fDwFR7fvPPnX
 4bWsdgzeIBb3t3rAExeijAZcgz1Ej4eQFMireTTp+mz9/D7fanSjtHK09LJGFotlx+Km
 79GCU4+Q0OHkcAYVrWNj88KSLTea0BIGR1dfsjAuDIi2ihN4sbM8vkQ7ajt88el6H0mW
 +gsIvBVoabEWLOn+sYrycJ1/k8VoPNaFrSscRgwJHOCH3d5GyLCRyLpKQwO3FlJSeJ4J
 pEQZ5XeeW6Ekw5ZAJoLC/gOWWFVuChsL3i/nVBzdZl/eahzEdZthRxjF+qSKqvcNgwVD
 eEJg==
X-Gm-Message-State: AFuF++mG7zPpIGNcVIqPT4xjLFEXIVAFQ1ApFEh0FXlT2Mmq0Shpt8p7
 ZieFGOsf447WCcVkklAzwxboKWouZEPYl6d38cJOAUzKv8TcoLSL+uOEzJkJerFY3X0=
X-Gm-Gg: AYBFou3fwT3aI7YdAZ5VNgQd1YVWQskFuBF26/RYP9U8Hep7gZvfBkIjKqD7jkjO4UB
 lk2s8AG1OJTDTtMMICGBPH+lIiPdtn5oooX1Ep+NP1r9/7uzCbjdyYCZ9N34WBw9MgSDJOtDzeJ
 yi9toPlF2YLBRdhz24KeANEzbdE+9ffdezklTmxFf8YHSk+u9T00ZhaKMn7omGFT2fBYOZq/5Sy
 zJ5JFIjjmSOfIm20/kOZdPmGVFCf/rGNsr93Ojjt8sulXVS2Lz1t4psoPppuRjcZAooqkm7UDsd
 gJ4ohgt2G+OyfUDSZwuD4jdSEQFAdaCfBlPzZ+3gLKueqjARmBZlnEbqtYcXThprfOO7uX25Xxw
 OyzYyucQ0kcsIlk2H8Y7t8N+DmYEhR6AjlMIhYa+hiim3t7es/vXeRJdkWYxjFsJ05K8kFrYccz
 DTdQ+rKLK2+6vTjjdjWwfs6Qu18dhaT0cWsC3Lhmlga3DgbeyVbkKz8Pgb/BmkdkIoego8U1byf
 Oy3DEnjAqQrBDzgA+UWWG04Ap6edkpfiwV0sSDTUlpfK1JQLiJV
X-Received: by 2002:a5d:5f4c:0:b0:47f:9158:5924 with SMTP id
 ffacd0b85a97d-4871d9ac5c2mr3457263f8f.9.1789728809593; 
 Fri, 18 Sep 2026 03:53:29 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:37 +0400
Subject: [PATCH v2 10/11] binman: Allow choosing the compression level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-10-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12028; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=yjjDgYmHvXUqSKeo6U2v+4223EpunLKukA4LjXPuoH8=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf8Xs8z27XSGeuVHCvYcnK9Ke++I6SQsdtuwdse7/
 u4YrmlJHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1X2NGhhaP34t6Wt9nf9pg5TzroYoLh0xBHbsQ/62ASzLz577jf8fIsEzt87d
 PG3ZUZr6ft36mymueo0GyXCujLCa98esR8GAuYwEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Every compression algorithm binman drives has a level, and the best one
to use depends on what the image is for: a payload sent over USB wants
the smallest it can get, one read from fast storage would rather not
wait for it. Today only the tool's own default is reachable.

Add a 'compress-level' property, passed through as -<level>, which is how
all compressors want it except lzma: the LZMA SDK tool has no such option,
and is controlled by the -lc/-lp/-pb values binman already passes.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/binman.rst                            | 21 +++++++++++++
 tools/binman/bintool.py                            | 10 +++++--
 tools/binman/btool/lz4.py                          |  6 ++--
 tools/binman/btool/lzma_alone.py                   |  6 +++-
 tools/binman/entry.py                              |  6 +++-
 tools/binman/ftest.py                              | 34 ++++++++++++++++++++++
 tools/binman/test/entry/compress_level.dts         | 12 ++++++++
 tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++++++
 tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++++++
 .../test/entry/compress_level_no_compress.dts      | 11 +++++++
 10 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 3a860421a697..d14fbe8e5fd7 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -711,6 +711,11 @@ compress:
     Sets the compression algorithm to use (for blobs only). See the entry
     documentation for details.
 
+compress-level:
+    Sets how hard the compression algorithm should try, as the level number
+    the tool itself uses. Requires 'compress'. See the entry documentation
+    for details.
+
 missing-msg:
     Sets the tag of the message to show if this entry is missing. This is
     used for external blobs. When they are missing it is helpful to show
@@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
 algorithm. Currently this is the only one that is supported. The uncompressed
 size is written to the node in an 'uncomp-size' property, if -u is used.
 
+Where an algorithm offers a choice of how hard to try, 'compress-level' passes
+one through::
+
+    blob {
+        filename = "datafile";
+        compress = "zstd";
+        compress-level = <19>;
+    };
+
+The number is the tool's own level, so its meaning and range follow that tool:
+1 to 9 for gzip, bzip2, lzop and xz, 1 to 12 for lz4, 1 to 19 for zstd. Asking
+for more than an algorithm offers usually gets a warning and its maximum
+instead. Leaving the property out uses the tool's default, which is what binman
+has always done. It cannot be used with 'lzma', whose LZMA SDK tool has no such
+option.
+
 Compression is also supported for sections. In that case the entire section is
 compressed in one block, including all its contents. This means that accessing
 an entry from the section requires decompressing the entire section. Also, the
diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165bf..caddb9eb8fc8 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -558,11 +558,14 @@ class BintoolPacker(Bintool):
             fetch_package = name
         self.fetch_package = fetch_package
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level to use, or None for the tool's own
+                default. Every packer tool spells this as -<level>; one asked
+                for a level it does not have generally warns and clamps it.
 
         Returns:
             bytes: Compressed data
@@ -570,7 +573,10 @@ class BintoolPacker(Bintool):
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = self.compress_args + ['--stdout', tmp.name]
+            args = self.compress_args[:]
+            if level is not None:
+                args.append(f'-{level}')
+            args += ['--stdout', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a566..92b3dc7410a7 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -78,11 +78,13 @@ class Bintoollz4(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lz4
 
         Args:
             indata (bytes): Data to compress
+            level (int): Compression level (1 to 12), or None for the level
+                binman has always used here
 
         Returns:
             bytes: Compressed data
@@ -90,7 +92,7 @@ class Bintoollz4(bintool.Bintool):
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as tmp:
             tools.write_file(tmp.name, indata)
-            args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
+            args = ['--no-frame-crc', '-B4', f'-{level or 5}', '-c', tmp.name]
             return self.run_cmd(*args, binary=True)
 
     def decompress(self, indata):
diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b4..d5a7bf3e1495 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -55,15 +55,19 @@ class Bintoollzma_alone(bintool.Bintool):
     def __init__(self, name):
         super().__init__(name, 'lzma_alone compression')
 
-    def compress(self, indata):
+    def compress(self, indata, level=None):
         """Compress data with lzma_alone
 
         Args:
             indata (bytes): Data to compress
+            level (int): Must be None: the LZMA SDK tool has no -<level>
+                option, it is steered by the -lc/-lp/-pb/-d values below
 
         Returns:
             bytes: Compressed data
         """
+        if level is not None:
+            raise ValueError("lzma_alone does not support 'compress-level'")
         with tempfile.NamedTemporaryFile(prefix='comp.tmp',
                                          dir=tools.get_output_dir()) as inf:
             tools.write_file(inf.name, indata)
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 9b39c7118892..e93b90801113 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -143,6 +143,7 @@ class Entry(object):
         self.image_pos = None
         self.extend_size = False
         self.compress = 'none'
+        self.compress_level = None
         self.missing = False
         self.faked = False
         self.external = False
@@ -325,6 +326,9 @@ class Entry(object):
 
         # This is only supported by blobs and sections at present
         self.compress = fdt_util.GetString(self._node, 'compress', 'none')
+        self.compress_level = fdt_util.GetInt(self._node, 'compress-level')
+        if self.compress_level is not None and self.compress == 'none':
+            self.Raise("'compress-level' requires 'compress'")
         self.offset_from_elf = fdt_util.GetPhandleNameOffset(self._node,
                                                              'offset-from-elf')
 
@@ -1222,7 +1226,7 @@ features to produce new behaviours.
         if self.compress != 'none':
             self.uncomp_size = len(indata)
             if self.comp_bintool.is_present():
-                data = self.comp_bintool.compress(indata)
+                data = self.comp_bintool.compress(indata, self.compress_level)
                 uniq = self.GetUniqueName()
                 fname = tools.get_output_filename(f'comp.{uniq}')
                 tools.write_file(fname, data)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a70..48adacebb6dc 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2168,6 +2168,40 @@ class TestFunctional(unittest.TestCase):
         bintool = self.comp_bintools['lz4']
         return bintool.decompress(data)
 
+    def testCompressLevel(self):
+        """Test that a compression level reaches the tool and round-trips"""
+        self._CheckLz4()
+        data = self._DoReadFile('entry/compress_level.dts', use_real_dtb=True)
+        self.assertEqual(COMPRESS_DATA, self._decompress(data))
+
+        entry = control.images['image'].GetEntries()['blob']
+        self.assertEqual(12, entry.compress_level)
+
+    def testCompressLevelPacker(self):
+        """Test a compression level reaching a tool binman drives generically"""
+        bintool = self.comp_bintools['gzip']
+        self._CheckBintool(bintool)
+        data = self._DoReadFile('entry/compress_level_gzip.dts',
+                                use_real_dtb=True)
+        self.assertEqual(COMPRESS_DATA, bintool.decompress(data))
+
+    def testCompressLevelUnsupported(self):
+        """Test that lzma rejects a level its tool cannot express"""
+        bintool = self.comp_bintools['lzma_alone']
+        self._CheckBintool(bintool)
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_lzma.dts',
+                             use_real_dtb=True)
+        self.assertIn("lzma_alone does not support 'compress-level'",
+                      str(e.exception))
+
+    def testCompressLevelNoCompress(self):
+        """Test that a compression level without an algorithm is rejected"""
+        with self.assertRaises(ValueError) as e:
+            self._DoReadFile('entry/compress_level_no_compress.dts',
+                             use_real_dtb=True)
+        self.assertIn("'compress-level' requires 'compress'", str(e.exception))
+
     def testCompress(self):
         """Test compression of blobs"""
         self._CheckLz4()
diff --git a/tools/binman/test/entry/compress_level.dts b/tools/binman/test/entry/compress_level.dts
new file mode 100644
index 000000000000..78c999590469
--- /dev/null
+++ b/tools/binman/test/entry/compress_level.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lz4";
+			compress-level = <12>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_gzip.dts b/tools/binman/test/entry/compress_level_gzip.dts
new file mode 100644
index 000000000000..d2852fd653dd
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_gzip.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "gzip";
+			compress-level = <9>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_lzma.dts b/tools/binman/test/entry/compress_level_lzma.dts
new file mode 100644
index 000000000000..da52497b11a0
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_lzma.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress = "lzma";
+			compress-level = <5>;
+		};
+	};
+};
diff --git a/tools/binman/test/entry/compress_level_no_compress.dts b/tools/binman/test/entry/compress_level_no_compress.dts
new file mode 100644
index 000000000000..1e58202ce639
--- /dev/null
+++ b/tools/binman/test/entry/compress_level_no_compress.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	binman {
+		blob {
+			filename = "compress";
+			compress-level = <9>;
+		};
+	};
+};

-- 
2.55.0

