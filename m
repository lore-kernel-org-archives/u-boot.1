Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE90606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xqvsnoqy;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=kCaGH1o/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18A378114C;
	Tue, 20 Oct 2026 17:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dx22ns4-ybiK; Tue, 20 Oct 2026 17:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B22081125
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517179;
	b=eHpyXgJ9pPJeeD7C3h4Ik1VUEwbcbBFACdPdNVp4Aikhu1ybgLdiLhybn3pUXYCFr+7l
	 3kmN15HUQr1Es1s97+cVbaIyvKhnOaFMWN2pHZs2gkbeDMerHUr8QNTT5EYkbXLeRtUAx
	 D+J2NKWQSXvQY3I53DwR7fWtpiZdQKRpXpIjXW1ntYl9tEJVxxK29Y/RQY/Sg2Xh9bacJ
	 XXNP2kKsfEjc5OV76KKLsMJWBmp5AoiWfPBwuWzMTedhC6bFZI/d2S+a16Jys1IpFe1ct
	 FJ+d9JgdL2Owp5mT2GV/uMh9IYBk8xPAfTHnd4MAdkqq/b3TZZUgv93BZE/7tvIFQNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rQ9JeOP31QiuVTdN12S1Uv6bd6MJdPi12PyMSdM7KxY=;
	b=SN1h00Pi1i1RYmpi3ZaDJfygDyolB3yuI+qYEFsq81p7lcU+T0h4RcpVhG+IFvQbg15M
	 bD4usTrsWyu31lrUklTiDAaJH7rx2Wc3CTJh8ccx+xifw7vXG/iaiyRF7oyibh+orN2Bj
	 DCebD7do984TXJL3s4N9RndST6nj2HCQC/qDyYYM/jnEkHAMHXlE7th8hKfXJ1pXafgIv
	 7WPcE7aQjPoNLi0B8o3A63lKUYYw+k80l9vuoJy1+pg2Tte9GbjaAKzAb42Yirx/Gx+o0
	 +ST+jbCHrf89OT1dmhThPdwR1/DtSZ+dAfxDHbaNZhEN43Epx8VO/NuZ1KtsFm9o/uQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="kCaGH1o/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517179;
	bh=rQ9JeOP31QiuVTdN12S1Uv6bd6MJdPi12PyMSdM7KxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqvsnoqynQx0krLihZc+UnHQqAUoQQWYq5oVun9R44JGgey94NV8doq+pX6y+k4VC
	 826ghwCoTdZUFgNnToc2WhWlD3/tX0IEi9hySDXS//Bzz4ZPlbN53yjZR+ovl0yTmX
	 4lCsbjt/k+SmoJwDBAmwI7mSwOXch8vE9/0dDaIUK9mzCG+4f9eC/WSXmJNiXjRbTs
	 zXLk8Cd2wxGENkORjOE8x011XwkyI3jwBMA2SPxFi9qkBStyrkPSzRr+GCecSN1u2R
	 HLl5DpcBXEtHPUKMLIBArwUkEcoMX/QPKm670RDZILwjAt5IAQLXzO/M+VuI6EaL+f
	 9Gq7gahw5KNdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B22081125;
	Tue, 20 Oct 2026 17:26:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EC6583A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE9F0810FE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQ7p3EohxQFz for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05F1E810FB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514544;
 b=ZokUqX+gAvNXZA45Jx2bK6KAS8iGprSJTPDNkgnRw/M7LUQGHaedxZWgtuELiacnSIFg
 pUhLRQdqV7NJ/lJkF+fYhgna2f9Tpy+PShKiFNQAZMrF3XmdWpTU3KX65W1yPzwJ5Mss/
 wSpeiOHFk+M8F3pTgjF+6bDnW9d61pTtumHg/HNizVuwTY79hkNxzNBXxLVEUcMdrdbiW
 EztvHw/vzytUdzaydjhs3F7qIwCe5Hr5qmssuRPl74+N6oaRXwIVo3rQncrs+ZxLHWCzh
 lG5oM1UtH8z3/AbBx7b6gvxC4Nenv2r/n79oAMYuWIMxq+wETxdZ9z1YgC3H5Nxo+2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514544;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=rQ9JeOP31QiuVTdN12S1Uv6bd6MJdPi12PyMSdM7KxY=;
 b=DJLv+SCbueuLUY+QOHpQZ3LGN1NhzSS7fIK48tTs/b0ZMwzqOnPDYz2vH3Feoq7Sa8xU
 OrP5QiffX38nbwzgMNIIfXsIGIJ6SU7TQST954K4ChjCg6ynBqjdwyKdvKptry8yml5lO
 x4lDRjpOkNLedoZ3HpW9kPkZ00EMNt4Mp6PPxQ/ad6BN9DjMN+hM08VKIiSGUgTywA5lR
 2AnbROwFQ6SpU7ZZWinxPvGhN4DcX2uhybuhfW1QNhDWXTQseHffQfwssbSAHQOOplREB
 4PjVNm5ty1ApU6RxYdSqtlIovfKJ3FypD5EU9Wkcxblm4ZiPZTcWtwydQOHR2GXRb9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="kCaGH1o/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=kCaGH1o/
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05F1E810FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:21 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso24962035e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514540; x=1793119340;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQ9JeOP31QiuVTdN12S1Uv6bd6MJdPi12PyMSdM7KxY=;
 b=kCaGH1o/3RnApehum77MKvKV/S3Fx+kItNQPiXVAcw9EAoljaoA43QgLc3FAGCbfAo
 91RaGJ9JuQ4cPl5vPZI5gl6WRRSPd9XcS/4zlfwy0ANuZx3kAWsuY4/vPf16ILuQ1eSk
 3tA1/3E99NZBGbvW4AdDO+Gyg/rTgEvVf5bU+YWbG814uRIzSIdJLpdLkq8gm7enjkUx
 aStyN6FhY6K8yIh49Dc/6XwNp5GJHhLnRM3XGIaXhH2ZETKCi3utRqzoP6Tw5Y+1m6fX
 ugNC2KwoajSDvSeq5SCQjnD8Mcsf422fLcmUrMxZts76GCiqCFYitmfIMvax/hESWQgV
 iPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514540; x=1793119340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQ9JeOP31QiuVTdN12S1Uv6bd6MJdPi12PyMSdM7KxY=;
 b=Vvtb3u9zn4jguOweZou+2aFYlT/sIXBd0qN41VSam/vL3qjB99qGwy0HRe1igfXzXw
 wopRcmSH0JU3y2LKr+Rnq7MYLIr28eS5rYCzpQOtt68jmA8JlV3d1t7wXpDPMF4VK9Le
 J6j/PJjBhd1lnirjGR9zsylaG+LgJwkEAlr1I9NP5UwAZXtXl/nWSIKmKNEA7t7EA0rq
 bi9atfaxDFSSh4dGfb+2SuLRVC9PYF0CG8FZhC6EbbT0WSWbbtkSJSZwIXXb5jpfySQm
 zzqLR18EYY1dC1xAUzaPHhb3yTPnHQdnh3RuEihOokKOML+xpvfVI3QTsIN0o+DcjC7+
 g+Uw==
X-Gm-Message-State: AFq9FYK/Bbm7AM4zK4aesGU2H6cTM5lxhDWgRhUUXAJrzFqPwfSYUy54
 4gh+1Hn5im+kZWc2h+VBY1JSweIBG0gQWBY3tlPHr9KTckjp1hN+JIIRZoUGC9Rstjw=
X-Gm-Gg: AYBFou2xquUxYSCbjzUs+IeOc7n3eRFSrpr7z1k6GR5ySe7Giu1HbQSgP1h1MHrW2Vx
 PPB+lOrE/6xGtOC/4X5pvlyuAR0sMavRdbcYJcfPT/XK7MHIYnnDGd15NSLipSHEYuRxSQgQkic
 sy/mtpmDZrkMWrdALyOWwDJjcsZrH7Y0Hjb/y6IHZhmo+CzwL+RDRrlRaAojDywTEMF/RlojMc/
 wqx16tKGPKf0ay9wZa+NFhsRslihqnfhnUymnm1UtyQIO20eMi7y0L7vqAGdOJ7QDdaWW8n68VW
 ogrdEjLgn8/aGLCrL1gyt8S7vvRF9tNSNQQ0/eoYPYzR/NrWHd6KGCwEfKdLtNUIkY/e++XAHx0
 YRilCO+APzlqf1fni9sFUL1rhDjqGLvAAxOmMlAuPG7nwPyF63vt8jgvQOczwTlI0YfnvWkM5qn
 YSKNrBQTJOKu4SoXAaFmzxK09Yk6RKSlJM6qZQW+Cb2xdGffwPY4d3OlZLCvMnJ58JOt01/AiHq
 itnWpOXQpPL4dvsnNe/uDQW2uaZbGhUVfDMbXVgbO/SbBYldZ032Q==
X-Received: by 2002:a05:600c:3b17:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a1d76139ffmr258653995e9.13.1792514539896; 
 Tue, 20 Oct 2026 09:42:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:19 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:57 +0400
Subject: [PATCH v3 10/23] test: spl: Size the FIT properties for the image name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-10-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=alchark@flipper.net;
 h=from:subject:message-id; bh=wF8MEucVHlkhM132jfNLclN17ZnI5+fELGh95wnt84Q=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7mKffsT6xSHOQ7JXqmrhLouvfr9u3GzY6xJrPn8D
 xFqu9rbOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqez8YGU7lTs42qdRd27SzzeTaxcWMv4o4JnvE/he4NPnEoVeXN3IyMtxL9gl
 8cG6DaC/LhHX/ruvzNqzeplIn7bc4dLP1zs9mV9kB
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

create_fit() budgets a flat 596 bytes for the properties it writes, but
one of them is the image name, which is named after the test and goes in
twice. 596 bytes fit a name of up to 27 characters, which is exactly
spl_test_image_FIT_INTERNAL, so a test with a longer name causes libfdt
to run out of room and create_fit() to return 0. The next patches add
names such as spl_test_nor_FIT_EXTERNAL_LZMA, at 30 characters.

Budget the fixed properties and the two copies of the name separately,
each copy padded the way libfdt pads it.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/image/spl_load.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 212fe0f08428..d9447a030b03 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,15 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/*
+	 * What the FIT needs besides the payload: a fixed part, measured on
+	 * 64-bit sandbox for the longest OS name used here, and the name, which
+	 * goes in twice, as the description of both the image and the
+	 * configuration. For external data this is also where the data starts,
+	 * which the loader expects 4-byte aligned, as both terms are.
+	 */
+	size_t prop_size = 540 + 2 * ALIGN(strlen(spl_image->name) + 1, 4);
+	size_t total_size = prop_size + spl_image->size;
 	void *payload = NULL;
 	size_t off, size;
 

-- 
2.55.0

