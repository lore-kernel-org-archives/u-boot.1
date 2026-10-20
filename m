Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AEA606A32E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z8so78uc;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=nxPeGsKk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C791A60885;
	Tue, 20 Oct 2026 17:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRsyctKmW12R; Tue, 20 Oct 2026 17:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CC6360780
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517182;
	b=ibxHWY6E8bx+4wVTxLFpXPO0aBalMBp/aft+gdCuVUTTUorqMz78rEBcP9B4gJjOmzhV
	 Vwg+r5XAAsOe5BHN4cklA0tioC3q1FwGPN+I8UEjO6hBwwrq4nTGpYf4rCYSoxLQyDvs5
	 nJHt6fVfpSu6/26DvbEXp1qjN8QxpJRUhWj+yC9ZMIZcfIZNt+4ziLg94VStuO3h+cmn/
	 cZinp1WbyfkdiH9QdxVOkoiP/B+lPZZLhsrW0ji0Fg3S2ASljx6J9WrwzdqgOwGHn/dXn
	 n2fnXrY8kYRTMmaTn3A1ACEslQRqKpjyRvoNjxnahIqEV70oo/sl8jPrx7KC+jXVCUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cAc5JdieMyE4SrJtcxxSYc8eDgtIG993PemKDn6zqEg=;
	b=RKp5S7D+gtmP3JASl5EN6FbMkFZXGFFa30WQpcsEqFtAiGSzdX2lpQdX+V5J8TmYBT3e
	 bDTET6PyTYjZlO0rrOzZQ+klKd5XyBh5orWUz5C16Ya3U627fPH5vp0XNthzKaB+PY9yo
	 bee9zMg9a0glp9mM5wOERzMz7vJ8Rw5iL+HjOt5qLOBnQTrh85qXv/y3SPuLKx7FFyx+S
	 uadhxVQtBFF79RkadhAjb5meltb1E3sMjIane3xc8N8Izd6jv5YS+OdH6jor2sR99I34T
	 JzGp6cZl/EJyMbdYd8qI52j1HpehXBHW7zTEVoDoQrna3J1mfa7mgJaEbMokDA4fVRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517182;
	bh=cAc5JdieMyE4SrJtcxxSYc8eDgtIG993PemKDn6zqEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8so78uce0KbZw5Zn1+Drk+uSUGHx1WWwM4ZkWVeMLsVxTvBoHWTymoksAuxooqkO
	 8xc/4aQcMJT75OnWg6NtpxCi2wA/sxKxpVi33amgOPtGPIJWmQ9IGa9EJ2oIZRObj2
	 Sn+KFqnU54QiYZDhvpluWrR1J1ICzXA7kg6yQTVFfJVoyBJr0DUDm3e6MKwsrl0fGa
	 q5xR0BX3/pFfro9TDkHCEqLunuRoyC8gcmk+dJl/pW60v1+B7wkeEPXzK3ZcD/gxiW
	 CX4rZnZUcz9foiA1QKBhEf/oQo+FgSfppvaBtvZRyFJO+obngEZ+N4YTtWdgX97q4U
	 aTalq/aJZJW/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CC6360780;
	Tue, 20 Oct 2026 17:26:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8FAC3A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ED18400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJ2DxLRp4EzH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 361DD40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514556;
 b=mafAf0Ze+tdhxoUwuqL7kG1J1fauMfNZm+bkJ44GMBhfzRuR99KTx0R9e2UY+XJH1Aet
 suk7Av/MNiJWGjoUYLhNDv9//Ik1uRUDct5CgrZzo1HqPhuTsFZ6wu6h7ZXVj9dfkqeoH
 vEbBylpw7hYnQJ/mHqPdSslw62wCcztZ9DyAAu1KO+D53Sv49HCB/qzZwuOSdTmzxOPSS
 f8YdmCn+J+bHfOaC/52NayS0ihsiOemN0HAZ3fBN8lUjSlnzNpEW50YO5pDf6vh9VibuY
 0+sBMF5SqDOsRHXWoYeEP5nLxZb4HlAvIOvKySEwQ5BebvLc/n7hyH5naLTUnNX0/pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514556;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=cAc5JdieMyE4SrJtcxxSYc8eDgtIG993PemKDn6zqEg=;
 b=F5N7Lo2aGQrhVUAQ2K6BqhCtd+nKGKpkdktaqTNMDdgRNOsvK9QPu4X/gntH1TqVaPHB
 egbstoj1buWDY6xk04AZbnQQwNXJLaJzVv0KgcB7TJwpDVzB5fLey8Gyo6kVEgruO+7aP
 r2IgTZrIhgRM9dRPvVoLaTKL2NC/yQnCgOIAL2kRECHYAJelfQaOIuTf3D7qiL4S1R8vC
 jyfAq0D7lxIIxy0gNmp+M7jVveJo3g8OlAOirp17oleQiouSVooDSMVR4XB99Vf+k7gy7
 6JHYxmLubDojAgfRUPdnJS0pHwJo2Sc3QZ7vXOTOPcQjtAHTnKFaZ7hUiRUKOJzsiow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nxPeGsKk; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=nxPeGsKk
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 361DD40060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso34600205e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514554; x=1793119354;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAc5JdieMyE4SrJtcxxSYc8eDgtIG993PemKDn6zqEg=;
 b=nxPeGsKkrp2WojJCPnuVXg2ZoP4/4l86XZK6xG9C2k2wG0hoH7vNSwrOzeA8Jp39yl
 oRihb9ZKxj6M3BV4HRiIWdFYi7MdS56R4GViOOEFob9kPRgRCIMK5qx3K2n9KbwpocgM
 hcnC6ElyVuSkp3VNprHcdUpiX++7cwZltTT7e/wtf7zwM3ABUBePTgSV5noizKavN/Hp
 Pr0EiaIytD/IfRd8F6/nJYaCJSQgA8+82cEL6jixmLVq9NrvGeWwjDmTQ7GP8506mXuV
 fQwobWwzcW+zxxhPA3bw5kOQI6bnmBfZ3oXLJhs880XsMkRZtivJy+ZnIvkLSrU/mHEI
 R1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514554; x=1793119354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cAc5JdieMyE4SrJtcxxSYc8eDgtIG993PemKDn6zqEg=;
 b=Tn7+NLrQ2wRhBFq+3+zlQgJjHw5vnGLVDojtViQWW1TgA5IF6xUoTEKt3xSwADIS9i
 ceE18vmFsBCQ2hu4z3gH8JBsDxQHv2HSX7FFqwDuvXdW7HWpp7Bq9wG4Br103wBpEM9f
 Ln60AjjZXOuzNOsprNXuS8MCHzybrLKMxKR+QdToxbFh0uDMgL9iT67KCK8+tdMGAhMn
 x1+Tdv4h01KJm4KLmanuq9zXaGNnnXnLQF9OlumfmmCMjC6wr20ysZ/bt4YN7EpIvxvT
 AZkQsTh401lVr0tosycKeoHXtFZmoQr0RDsjrxVFULg1Zch4eMaaFYYSc1PRhUK21PN0
 0ZNQ==
X-Gm-Message-State: AFq9FYLsar8Ny/U4FAQZd9mh9rLcIlyPiaXaHPHAPQFs6fs49w6DiTqb
 F5F1hQCQb4BUGkgmHoqzYAfdfmj//G7gGHqVHUrjyYcJP8udhiCs48MsvRtKez2n5us=
X-Gm-Gg: AYBFou3KJjTeZGWxJ4Gd4e0VYMfjp44415QBjvBs6vj9AqgOp8G4b8Ig0Nbt1cMhFc/
 kffmP3O+ejPFNe+VhDtrJcpn7jrXqA7nyiKC2FAd4VhN6FblNFF2uDy6iTncJEVOOVzkyAJjFwj
 M04Qtx0ddG0fJ6HUCXLgTpAgmpDaf1I9Az3YYfXgQW7fuMX26jiQvMpjIHOHUbJl7Jpp27nh0Cc
 1rmRSFHYbrATvzZGAb+RgnW6TvIFghoCdcrCJ1glfjsqX337K4LGnD0tNQkLad0AKbW6+J9EK+h
 3SGpjhza8BW2vYJH342t0I1yRq75e2oNmcUmyCkduKrUZLPwXckex8k7H2oVbfYvlXv6mqeVBc5
 6nws19LXc8s/H5OSprLdGrHGDXLH0rWbulattZoBJHM0WD9BCrOv0m1KZvhDrwBaKZqj+h5VmZO
 7bIrGJ+ct7HkMJt1M2p+M56Au73IMkx1b/5754RBQBTYXrS0cPgIHK++NwbTePeON8k/LjTQU9N
 NconT6+g7NiryAQrwKNgXaCY+Z/EhFTg0//Lyuf9Xt88ApeIJLf1RnaHeWD6xbK
X-Received: by 2002:a05:600c:8b6a:b0:4a1:f89f:35fd with SMTP id
 5b1f17b1804b1-4a1f89f3764mr41627455e9.24.1792514553581; 
 Tue, 20 Oct 2026 09:42:33 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:59 +0400
Subject: [PATCH v3 12/23] test: spl: Cover FIT image decompression
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-12-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11415; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=LuNOO2LrCzunl2tDJN+oecjfiNi+ab8UJ6Jt2276GyM=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7mq6/OW2afmPsnaP+F25+RJqfPqJhk4ntt+4OduX
 hdzuf0MuR0TWRjEuBgsxRRZ5n5bYjvViG/WLg+PrzBzWJlAhkiLNDAAAQsDX25iXqmRjpGeqbah
 nqGRjrGOEQMXpwBMtYwFw38HRZeVTt9zq3ranV9ZCEX52gtZMbz+du1rpXHr6oNujvyMDCc9rri
 +5Vq44uLVhk6F37MV7jnZGb3cd3/d0c1RJ/ONMzkB
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing exercises the decompression in load_simple_fit(): create_fit()
only ever writes compression = "none", and the canned LZMA blob is only
used on the legacy uImage path.

Let create_fit() take a compression, and load a compressed FIT both ways:
with the data inside the FIT and beside it, since only the latter stages
it through CONFIG_SYS_LOAD_ADDR.

Derive the compression from the image type in one helper, shared with the
filesystem tests, so that adding an algorithm does not mean finding every
place which assumes LZMA.

Have image_supported() take the algorithm from the same helper and check
it apart from the container, so that a compressed type needs no
fallthrough of its own.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/test/spl.h        | 25 ++++++++++++++++++++++---
 test/image/spl_load.c     | 47 +++++++++++++++++++++++++++++++----------------
 test/image/spl_load_fs.c  | 23 ++++++++++++-----------
 test/image/spl_load_nor.c |  2 ++
 4 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/include/test/spl.h b/include/test/spl.h
index c5349b06e290..b77b16d168ee 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -6,6 +6,8 @@
 #ifndef TEST_SPL_H
 #define TEST_SPL_H
 
+#include <image.h>
+
 struct unit_test_state;
 struct spl_image_info;
 
@@ -30,16 +32,28 @@ void generate_data(char *data, size_t size, const char *test_name);
  * @LEGACY_LZMA: "Legacy" uImages, LZMA compressed
  * @IMX8: i.MX8 Container images
  * @FIT_INTERNAL: FITs with internal data
+ * @FIT_INTERNAL_LZMA: FITs with internal data, LZMA compressed
  * @FIT_EXTERNAL: FITs with external data
+ * @FIT_EXTERNAL_LZMA: FITs with external data, LZMA compressed
  */
 enum spl_test_image {
 	LEGACY,
 	LEGACY_LZMA,
 	IMX8,
 	FIT_INTERNAL,
+	FIT_INTERNAL_LZMA,
 	FIT_EXTERNAL,
+	FIT_EXTERNAL_LZMA,
 };
 
+/**
+ * image_compression() - Get the compression of a test image's payload
+ * @type: The type of image
+ *
+ * Return: the IH_COMP_... the payload of @type is compressed with
+ */
+int image_compression(enum spl_test_image type);
+
 /**
  * create_image() - Create an image for testing
  * @dst: The location to create the image at
@@ -123,16 +137,21 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
  */
 static inline bool image_supported(enum spl_test_image type)
 {
+	int comp = image_compression(type);
+
+	if (comp == IH_COMP_LZMA && !IS_ENABLED(CONFIG_SPL_LZMA))
+		return false;
+
 	switch (type) {
-	case LEGACY_LZMA:
-		if (!IS_ENABLED(CONFIG_SPL_LZMA))
-			return false;
 	case LEGACY:
+	case LEGACY_LZMA:
 		return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
 	case IMX8:
 		return IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER);
 	case FIT_INTERNAL:
+	case FIT_INTERNAL_LZMA:
 	case FIT_EXTERNAL:
+	case FIT_EXTERNAL_LZMA:
 		return IS_ENABLED(CONFIG_SPL_LOAD_FIT);
 	}
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index d9447a030b03..0a3ca0e9829d 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -40,7 +40,19 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 
 /* Local flags for spl_image; start from the "top" to avoid conflicts */
 #define SPL_IMX_CONTAINER	0x80000000
-#define SPL_COMP_LZMA		0x40000000
+#define SPL_COMPRESSED		0x40000000
+
+int image_compression(enum spl_test_image type)
+{
+	switch (type) {
+	case LEGACY_LZMA:
+	case FIT_INTERNAL_LZMA:
+	case FIT_EXTERNAL_LZMA:
+		return IH_COMP_LZMA;
+	default:
+		return IH_COMP_NONE;
+	}
+}
 
 void generate_data(char *data, size_t size, const char *test_name)
 {
@@ -57,7 +69,7 @@ void generate_data(char *data, size_t size, const char *test_name)
 }
 
 static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
-			    size_t *data_offset)
+			    size_t *data_offset, int comp)
 {
 	struct legacy_img_hdr *hdr = dst;
 	void *data = dst + sizeof(*hdr);
@@ -77,8 +89,7 @@ static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
 	image_set_os(hdr, spl_image->os);
 	image_set_arch(hdr, IH_ARCH_DEFAULT);
 	image_set_type(hdr, IH_TYPE_FIRMWARE);
-	image_set_comp(hdr, spl_image->flags & SPL_COMP_LZMA ? IH_COMP_LZMA :
-							       IH_COMP_NONE);
+	image_set_comp(hdr, comp);
 	image_set_name(hdr, spl_image->name);
 	image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
 
@@ -161,7 +172,7 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 }
 
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
-			 size_t *data_offset, bool external)
+			 size_t *data_offset, bool external, int comp)
 {
 	/*
 	 * What the FIT needs besides the payload: a fixed part, measured on
@@ -220,7 +231,8 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 		return 0;
 	if (fdt_property_string(dst, FIT_TYPE_PROP, "firmware"))
 		return 0;
-	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+	if (fdt_property_string(dst, FIT_COMP_PROP,
+				genimg_get_comp_short_name(comp)))
 		return 0;
 	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, spl_image->size))
 		return 0;
@@ -272,22 +284,23 @@ out:
 size_t create_image(void *dst, enum spl_test_image type,
 		    struct spl_image_info *info, size_t *data_offset)
 {
+	int comp = image_compression(type);
 	bool external = false;
 
 	info->os = IH_OS_U_BOOT;
 	info->load_addr = CONFIG_TEXT_BASE;
 	info->entry_point = CONFIG_TEXT_BASE + 0x100;
-	info->flags = 0;
+	info->flags = comp != IH_COMP_NONE ? SPL_COMPRESSED : 0;
 
 	switch (type) {
 	case LEGACY_LZMA:
-		info->flags = SPL_COMP_LZMA;
 	case LEGACY:
-		return create_legacy(dst, info, data_offset);
+		return create_legacy(dst, info, data_offset, comp);
 	case IMX8:
 		info->flags = SPL_IMX_CONTAINER;
 		return create_imx8(dst, info, data_offset);
 	case FIT_EXTERNAL:
+	case FIT_EXTERNAL_LZMA:
 		/*
 		 * spl_fit_append_fdt will clobber external images with U-Boot's
 		 * FDT if the image doesn't have one. Just set the OS to
@@ -297,8 +310,9 @@ size_t create_image(void *dst, enum spl_test_image type,
 			info->os = IH_OS_TEE;
 		external = true;
 	case FIT_INTERNAL:
-		info->flags = SPL_FIT_FOUND;
-		return create_fit(dst, info, data_offset, external);
+	case FIT_INTERNAL_LZMA:
+		info->flags |= SPL_FIT_FOUND;
+		return create_fit(dst, info, data_offset, external, comp);
 	}
 
 	return 0;
@@ -326,7 +340,7 @@ int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		ut_asserteq(info1->load_addr, info2->load_addr);
 		if (info1->flags & SPL_IMX_CONTAINER)
 			ut_asserteq(0, info2->size);
-		else if (!(info1->flags & SPL_COMP_LZMA))
+		else if (!(info1->flags & SPL_COMPRESSED))
 			ut_asserteq(info1->size, info2->size);
 	} else {
 		ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
@@ -786,10 +800,10 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 		     int (*write_image)(struct unit_test_state *, void *, size_t))
 {
 	size_t img_size, img_data, plain_size = SPL_TEST_DATA_SIZE;
+	bool compressed = image_compression(type) != IH_COMP_NONE;
 	struct spl_image_info info_write = {
 		.name = test_name,
-		.size = type == LEGACY_LZMA ? sizeof(lzma_compressed) :
-					      plain_size,
+		.size = compressed ? lzma_compressed_size : plain_size,
 	}, info_read = { };
 	struct spl_boot_device bootdev = {
 		.boot_device = loader->boot_device,
@@ -805,7 +819,8 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(img);
 
 	data = img + img_data;
-	if (type == LEGACY_LZMA) {
+	if (compressed) {
+		/* The canned blob holds what this seed generates */
 		generate_data(plain, plain_size, "lzma");
 		payload = lzma_compressed;
 	} else {
@@ -823,7 +838,7 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		ut_asserteq(plain_size, info_read.size);
 	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 935078bf67b4..0979b9f84ae9 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -320,10 +320,10 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	struct blk_desc *dev_desc;
 	size_t fs_size, fs_data, img_size, img_data,
 	       plain_size = SPL_TEST_DATA_SIZE;
+	bool compressed = image_compression(type) != IH_COMP_NONE;
 	struct spl_image_info info_write = {
 		.name = test_name,
-		.size = type == LEGACY_LZMA ? lzma_compressed_size :
-					      plain_size,
+		.size = compressed ? lzma_compressed_size : plain_size,
 	}, info_read = { };
 	struct disk_partition part = {
 		.start = 1,
@@ -334,8 +334,10 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	struct spl_boot_device bootdev = {
 		.boot_device = loader->boot_device,
 	};
+	char plain[SPL_TEST_DATA_SIZE];
+	const char *payload;
+	char *data;
 	void *fs;
-	char *data, *plain;
 
 	img_size = create_image(NULL, type, &info_write, &img_data);
 	ut_assert(img_size);
@@ -345,18 +347,19 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(fs);
 
 	data = fs + fs_data + img_data;
-	if (type == LEGACY_LZMA) {
-		plain = malloc(plain_size);
-		ut_assertnonnull(plain);
+	if (compressed) {
 		generate_data(plain, plain_size, "lzma");
-		memcpy(data, lzma_compressed, lzma_compressed_size);
+		payload = lzma_compressed;
 	} else {
-		plain = data;
 		generate_data(plain, plain_size, test_name);
+		payload = plain;
 	}
+	memcpy(data, payload, info_write.size);
 	ut_asserteq(img_size, create_image(fs + fs_data, type, &info_write,
 					   NULL));
 	ut_asserteq(fs_size, create_fs(fs, img_size, filename, NULL));
+	/* Compare against a copy, so that losing the payload can't go unseen */
+	ut_asserteq_mem(payload, data, info_write.size);
 
 	dev_desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
 	ut_assertnonnull(dev_desc);
@@ -374,12 +377,10 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 		ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		ut_asserteq(plain_size, info_read.size);
 	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
-	if (type == LEGACY_LZMA)
-		free(plain);
 	free(fs);
 	return 0;
 }
diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
index f53a6724e27f..32265f6346f4 100644
--- a/test/image/spl_load_nor.c
+++ b/test/image/spl_load_nor.c
@@ -35,6 +35,8 @@ SPL_IMG_TEST(spl_test_nor, LEGACY, 0);
 SPL_IMG_TEST(spl_test_nor, LEGACY_LZMA, 0);
 SPL_IMG_TEST(spl_test_nor, IMX8, 0);
 SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL_LZMA, 0);
 #if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
 SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL_LZMA, 0);
 #endif

-- 
2.55.0

