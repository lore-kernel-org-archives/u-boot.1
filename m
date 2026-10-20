Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31345606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MLVYCHC6;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=NbLl3nDt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E975781136;
	Tue, 20 Oct 2026 17:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCwcLuMNCx1w; Tue, 20 Oct 2026 17:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E308B8112C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517169;
	b=jNKjjDwUXt/m3WqOnfCVTH4DOQtwAnqbXXAPwOGD1mZSE7KB7m0NKN302Ju7DT+CVeS5
	 kc3Y8lpOQi65AqI6shpaLcfKWYRkfqRn48pdAa5rV9Y3Khl1Cy4P4Q+nr8WqlsaTeGidI
	 thMU9KOSCAWT9J7m1YrJe/Lf/ZcrexHVBcLj2WO+cyJ2ww4U4MZ3IFVRmbgKy5vLRKFve
	 Eu2o7gDp3szS4mE0vm8kuIE2PTS+DxxPaDsqJRvdCZUXrYVIYQ0/6bIi0IjCi+PhAt4Qa
	 K5c6IQGCIZ9jPAH8oFRkBgJ0+JcEHAnEWZKglPFVEA5+mPNmM1IehacNi52eyUEmX9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=asi3YCMIR5tmAnsMiDLqVW2MXajvwDhj4RSl/5KLwh0=;
	b=HzP2ycHnOMbmmFRUzbmn6hr8joRLSpjzue+mdJPQ/c1nS31VytXH4B6Y6ZcTD2mklMm7
	 WhCLIdcibdFrPzQeoRcuY7aHV6vMsjadVwxJPRAlDt9cP4aTDTOsfUQ+beyEmTt/eirde
	 v8tPGzfcOUZV0T3aU1Xe8BNrKm6j9KwUCSzQlo14x+NCok655qbfxjP7NzuLc8ma16T2W
	 Ljx8e9x9aAFMaBPPgh3EMvtKJAlMIHmob3ZOyvo9QKP5mOzPc6NYMzCGkhfGt3xw1YgH5
	 EKXI7bt0iAYXpSr810IFQ7V0lzZ0KNfuGlhuT66lQirblfztWdBaiji4IxuHqq+oYDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517169;
	bh=asi3YCMIR5tmAnsMiDLqVW2MXajvwDhj4RSl/5KLwh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MLVYCHC62U0r+90YFnRi3BZ9VSXWjjbb3itP63xzeGW7tL8cisEFMInP9GMeeSYT5
	 YMLhSbFiimKWNyt46XVnKQ4Vt+IfR7JwX9NInUpkMeq+PPfL5SqD7X5ILh9imeFXbW
	 7bb6DFJyzY6BW+aF8S+3+nKoxgFu6c+cmLSx++jQBGGps0E8N5+7IGw3h6DZuI5Mc8
	 8VxQ5jv38qIfDCb4kDhV09U0gW/KC8E7veZ2x1e6kUu6JjJYIoPhIhTihTtO5dqoTZ
	 YRTa7tFoJdUrON9zOKg3sY+wp04gHoGxmcS6v/m/X3G1rDxUiP/yAmixSUqfWjy7wW
	 4mmUHVsHb1VVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E308B8112C;
	Tue, 20 Oct 2026 17:26:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2FA9769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C47C060773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBnc-Owr62De for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD0416071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514506;
 b=cKnmoJ4LgZM7m11BHTOIOf4IltMB/SUrf/XKLa8PSrBkrx2hTqAvDmxCvAOimZWpmcUH
 hmx7oRb4RgW/iMHjU4/O+F743y7+KFVNbcB41bFDq16mKmdgwmG+e6SGFErV2Ph7DUK7b
 NMLoehDEjOX8FT6Zarndji4iow3smZB5kHQNuwOWM7ogMH9/I5biCLihePPcvUpoP914y
 3qHxJosv7rYLWhVzCoOoL1GqnzfR8WDU3qNFIzd6gdCicjXWYFkau0ZQCO58bMZUko3oe
 x4ZrOn9Lrs0Toswg+b2RPmRKB5Tc8Lo4l5HUKDBQ5aStzC6IEikiItbT30vTND5asAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514506;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=asi3YCMIR5tmAnsMiDLqVW2MXajvwDhj4RSl/5KLwh0=;
 b=kgYf6U3FUZBHPi2wca7pVVRQfMFL0Vse0KMonzsM2oenHihffWq///BdAzTlSxx+Rc8i
 XZQ2OZCoyY6TqXo6hU2UFguQAZY6oTIrdjN6NG2PPKdqWWzftXrCrAbnGIKWUZ9tIKosJ
 qbjTlIrrvgNIx1L/jCNVXbd3OMfQsulFnMqV+ACGIXe9eM9u8u0HYqv3LzmiGmgnJVhcA
 rTrZIo5I/+YoZcJUjpdZ4XBQISphaRCkCOBlhTbHm071MYCFejNVv8VuoM5DknWMN3dMa
 fhKFMT+1uYVKQ594FwpOBgHXhMnbImmZ/q32d2lsXsOSS7evJSfswtkXERwo5u6OxJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=NbLl3nDt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=NbLl3nDt
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD0416071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:45 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so26805215e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514503; x=1793119303;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=asi3YCMIR5tmAnsMiDLqVW2MXajvwDhj4RSl/5KLwh0=;
 b=NbLl3nDtANX7i6vgNqMRFtx9J/FwIWHcUDES72V0Fpb2qsEQzuX8/q269OFC9BMkXI
 KSTUJs0+fhfP1FPedxsJQLtKdHo399sLGr5B88DpOMOFtIxPP8gCiI+rcUrqG3vVsJ0P
 KmKhBvYD0QklI+vOEeS3XxoJADxl7F2LM/XPebFwQxhS14bHKPGzSCLkRoPwB3nIz68x
 ApG3XvpbcX2pm//7dcL3/rT1Dn1rYGAvGF4QU25QVNRASxfCi4NqBtWJlr2YX1RP4jbK
 5aYZJTObF/YC6p5Zr4BTO3gkd0VttyEsXFzXJVrrdQwOvkpnis8kSKwKVYZpzD5X6jEQ
 V0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514503; x=1793119303;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asi3YCMIR5tmAnsMiDLqVW2MXajvwDhj4RSl/5KLwh0=;
 b=THMpo1ea1UKCkCNDW1QEBo2hqy/oUYa358pN177DUZQ+xX3SLAE4P/0L94nP5jzsLk
 2YwsNRpUCmLzIS5Qlybkd2MjXAFkbsrIamgwjWFBg+Are1esLBPI8GZ2thmnh67QcAYa
 rOBUdDdghnXFxf4Yhc+Cc9Bu1TVshXovRHL9WmJgGisA6rJhrULHXlfLxirHUOTRTu4G
 V2GWyJ3BVt1NLeUIaBxC4tI5YQEyo9tjcHnAhLTmDVlFvW5EPXqQ/5cvHG6udNBrGDSk
 7XgotnPUiJioINQbVFuecn50/6jd+bY2MORuiYYkDd/B7yVRSDzSFucDNHkjhqrTAoeJ
 CLqQ==
X-Gm-Message-State: AFq9FYJhQaZE/g9/oGt9KiLTtw4gWw1b0+iHsTsSK4IwZ4APYLQfbuXd
 PifeYFYZY9WSuibhFB1ty0/fVHEbVwOjjQnmIOCO7q2agxwyRYIyR2jePBgMIivWstk=
X-Gm-Gg: AYBFou1+oHz11kEf8nA9FFnFXO5+VqchNTZk+u3bYuyo2sVcJ5XvRYXJZanFt/EtXNN
 aBH3f6QaSodJkNipdy+iKQ/ihuvWHOKhN3pOI2zAmCYq4l+tiGqbzlYWs2JcFDB8VIZa25zMT3b
 utV2yf54nN5d8iAqL/jgpnMsKL2K0O5aIeAa4Am93O8WD932jIcu1INyZUd+Ih7aGt0Tfoeuh/E
 irDa/UOFfC+75JIOe2252I1yombVNOurfsO0A7AasPIRqdBffOl9qmIhgdaFnTh3PEYEcCRqQCe
 e7Omr/MWamDimlEF9OVaU9mgTvIDXhzF1b/OHD9oAJzTsdQtTWqW5ec/lt5cmV+Q6/Wqn+WSB+A
 G9SvYkGyewcKFltzLeU4JIwlyg92wGbK1ukxpZiVgn/rVsOgh/0EibAgZl7krxIoSl9SxSnl2E/
 dvfuPnOZ8NI9w/1fQq9PqTeJOc+Mk7KWQLp8Ck7dVTHLEGFMVWb0/DynMzF8iDxGmn+c4lAJ0Gg
 jCuD++cEUfKXDnBIGwME4o4cR8IuxtyalnaK4lyYnoPnevd+yuhVw==
X-Received: by 2002:a05:600c:8b22:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a1d760d9fcmr257639335e9.31.1792514503494; 
 Tue, 20 Oct 2026 09:41:43 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:43 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:51 +0400
Subject: [PATCH v3 04/23] lib: Let SPL minify zstd on its own
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-4-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=alchark@flipper.net;
 h=from:subject:message-id; bh=YaRP8tCdQfFF0+BeE9amZVztKdVIFk8qsMgatNlx8jM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7lyvuGa45dEF80qiZjGePkLz+q2JatD3bwlvqQnf
 JNdwOuR2jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUG5xn+O9gILiudlvvUk/u65pv5qb7n4/7wpqwW0/LRtJWobg6Zx3D/zLOWQG
 NBsbJ9UuiJdIWnUy/Z3Dk8KzPRWsM2m/ZbfSexwIA
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
enables zstd for SPL alone gets the full-size library in the phase which
can least afford it.

Add an SPL-scoped variant of this option and key the build flags off that.
Default it to y on its own rather than follow ZSTD_LIB_MINIFY, as size
matters more in SPL than in U-Boot proper: a board which turns minifying
off for U-Boot proper now has to do so for SPL separately.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/Kconfig       | 12 ++++++++++++
 lib/zstd/Makefile |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index e9acc25b80db..5f4698f0795c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1099,6 +1099,18 @@ config SPL_ZSTD
 	  buffer and takes its window from there, so the compression level
 	  does not change what the SPL heap has to hold.
 
+config SPL_ZSTD_LIB_MINIFY
+	bool "Minify Zstandard code in SPL"
+	depends on SPL_ZSTD
+	default y
+	help
+	  This disables various optional components and changes the
+	  compilation flags to prioritize space-saving.
+
+	  For detailed info, see zstd's lib/README.md
+
+	  https://github.com/facebook/zstd/blob/dev/lib/README.md
+
 endmenu
 
 config ERRNO_STR
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index c9a7dfe405b4..9d1b4d4a4f72 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -11,7 +11,7 @@
 obj-y += zstd_decompress.o
 obj-y += zstd_common.o
 
-ifeq ($(CONFIG_ZSTD_LIB_MINIFY),y)
+ifeq ($(CONFIG_$(PHASE_)ZSTD_LIB_MINIFY),y)
 ccflags-y += -DHUF_FORCE_DECOMPRESS_X1
 ccflags-y += -DZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
 ccflags-y += -DZSTD_NO_INLINE

-- 
2.55.0

