Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8601606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aXxKODS/;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=CkwdZwEn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C12E340900;
	Tue, 20 Oct 2026 17:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEtZ_3aFBqmo; Tue, 20 Oct 2026 17:26:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D339A408F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517176;
	b=BjFt1IPND3JxPEuMI3aXrPRzntb4cm09ILtjhCjKHKHeFAdCWIkkIuUj1/nI2SIAFefx
	 +Ke5+1VckLn3ofCPCx3LZxiXFQYu3mYZCbVC3cSB/k1fk3b98LUTg+v1oMER6efBD+9WY
	 bqVqx3LYMfyqEYDRGG6Ou/uJR54HTH116esFAL8vPTZI4H+dg7U3XOOEge3ccWtYyQtVi
	 fgTZZ9iz0Bp/yLOCAFiQouxFJWXjpKcdAaK/OQF3jwdrSXDeVM2FZ29jbgF3kTPndh1i7
	 zlWOLT69SrheOQOARIrpygtlim0GVjex7Pg95+QGv92VIDsPqYrMh4whW0GfTIZBb1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hTCJ3DV0ga9Csqse/MVP0Ms4OUeYDvmS+/r9GtpWoZ8=;
	b=l1WunS3y1VDHvyWuBcgE3shOwFYMA+4hWrFnmlK+plVY8nMNOUrsAJ5WrkK53mik/gZm
	 vZ2y5raxE3fGXAIspHz3EvaLSIKvtzDM6Q85IeuUSPQelfdFB8Y1sRgKWctL6ur8NyXR9
	 +mE6E2J6tGLxNOivh4I+fMQUhYlD1qQbjGwwmJjlrCCvAlJZUHnZoTclywgqiMglx5oT4
	 3fhuHpzGc6GrgbWV/vCDItrpNwUgoEuvBfAD2aEURdhkPCiE2EVeUTuV+I9UgOOLqQSA/
	 JSwSQjqrmhyxEs/ffTfGxeUhxbuHECcbFA26Vnbloq5j6AkcMTULrIzQQ+ow6JZMMcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=CkwdZwEn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517176;
	bh=hTCJ3DV0ga9Csqse/MVP0Ms4OUeYDvmS+/r9GtpWoZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXxKODS/ce85vw1dCMC1dMq8FiuydnlNZ+AEWd4ugvoyGnPj6KlGWIMh+CZJv0hih
	 XWxSTeuVUBQ+togQuB2B2KGw/oMD/OYBoEoAajJUD4uPiPJfJWYpSUGewnkG399Con
	 XiX8uZdNJbIMVmMdm7VpmyUC0TnbM3E90MfdxATCAgoi8Nepc8IJfababi1eV5PreX
	 27IvW5UjRYSKd/e3NbZrB6OYbPbTBUGLO0qQxZmE/abKy+aWHuEmR4m3aaFMLnn2XL
	 81cBhV8bvgZflWFTl4Q9yD57XvyT+yRIVZuYbgKeURW5kyJRplYT0P+58ko3eBZ0Xi
	 MH8jLMKAitXBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D339A408F1;
	Tue, 20 Oct 2026 17:26:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED36B769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D31C04080C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzpJ6ElKGuRc for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:42:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C34F2407A3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514533;
 b=BPnbT4DgKaves/pj9NBBdInlYswC0zaT2NR6/ocjd4F+S/MOGoiPJ6GHZ5kbgSMKmIvH
 4VF8fKb9DrMbScp84lJ7hSEkiZc3prZe2JbM9rgEA28cMVhpvSR5morTlKc5SzbLyannt
 /gAvrgbZr7ctlIOBgf0AeJ3K71f0/qUbJPDuwVwRb/b6bhe/Zb/vxXwtx4w7y9YK9Jm01
 badvNBOhkEl/HSsYjvZyj/qG+EADJuJUBcirQQMjCK+pT4OtYQy7WpRrzaN1XjpxAAd9x
 8qRYzUjCcQR5+3qowvEQsKMFoAwIxrnbOKoDAcDPbkG9byE0mxAQTuitl1Q+hyAnbYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514533;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=hTCJ3DV0ga9Csqse/MVP0Ms4OUeYDvmS+/r9GtpWoZ8=;
 b=UjrCFl86yzEJgkiXc+FINYFX7wUAaXkUPEi950U3A0Qq0AM6CQOFjGwdJ0xqYWkJSpVG
 dYoU9pG1iKX0oDnJDKQYSxlJ23nOU5p3f7NdwHmt/gcO7vBcb7ia0bPEZ+VPKd1/WY829
 W4gKIXLv3NQHOmxzznrPF0nKKLBpQ/iGcA5nJxuUJAS3Dq1TXJ87vdfSFPYklKPhrD1k9
 nQ7P43sgclZcyT/Ss3UtKgAq14aEOE6F7JrXDiJf1fHvcqtSRHzLFrImtDywpeb1df3cV
 V1wc+pajzHHbC/1uTb4pQl7tnuFo9JA/h3QF6/XfyH7Lv4WKxyXucxKPfhub1+667Dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=CkwdZwEn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=CkwdZwEn
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C34F2407A3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:42:09 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1dec056ddso19671445e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514528; x=1793119328;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hTCJ3DV0ga9Csqse/MVP0Ms4OUeYDvmS+/r9GtpWoZ8=;
 b=CkwdZwEnB+CtktOoyFGrgyEye+tnYcdX1y8Qb0fBqPrgLMvhmCswHpOzzrp+SCDH7s
 Fzh0xT3ljK3EVmr5DAK5HtHAoHttoJbkTvSvfxDRNr73+1E2mTKRNN7ZiIzXQw+qj/H0
 buPI6LccoWE+qAtc71a9IkpZz6TByceOvDAFs7QEdqio6EXa5hswy8sWYyttxSVAJdbW
 uzoMZH0juUXl9feubTB88WeFFPMahOoYpCd5CFnC2UEN+NEKgBAJ4Ir7jms32YTqXU3E
 mSd7ouF+ZXcMnGjSKbzMd0UBg9HlLS1kHXKtaeOM0psQk224oVi19kuZf5mYUZniv7zv
 yBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514528; x=1793119328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTCJ3DV0ga9Csqse/MVP0Ms4OUeYDvmS+/r9GtpWoZ8=;
 b=Mq1fgS5i/Ae0QgxscsqvRCw9wY1PNDQiW+xrpytWeDP+bflJKlEXLfli16IJ9cwbEq
 YJytn4XvH/8pASQSPx4NstQaPTy2SuQ779F+FqDmr2y81s5bzb91a2bH+MBJG24bopx4
 Ba5k0Soji7jZ2FBmKYM0+YOrQAn+rQG6cX4pF0OL6OtX82RmiyFEw8WnMCm6qPy/fDtc
 KEGiHMn/A+BII64vKwqoKVT9LXxZfsqxM/Ypq+aCUKTgF1iZv+78FCupP6lBYYzBKWlf
 OY7c7WadZ3DmqX99bDj3LorVPIls7dXmN/rbQIMIEo+WTauwtei/k4DfvZRpz0QZHYPT
 ky+Q==
X-Gm-Message-State: AFq9FYLeqOxhA4WGXan05ZUir0debebtM1IYCAO4ZzeHs50GOHUyCpQJ
 /6+4s4uMYDn6vY26mYo8rYeRsgqB7GzhIaMEXITgT8fRkTH3b2SN0AGJjdGbFkesloA=
X-Gm-Gg: AYBFou2R+nlb5Ykre+YujhSqWSGwGNKN0NyQ7Xnsi+IEbBOM9LEiYpTkIMdtmOSt+BZ
 s1PV4AR//aM/r2fjbxoRY4wUjiAZykUE8fXpSvxu12GmHedi3HMjwgWojn9KVJn48J/pAbHZZ0v
 6ym+N7+GHFZD0sL75T+pT7+DowFgL2RvYlBkPRqTFKInn8V5lTShXd2rmWmVaMJIi0BHdDQ1fjY
 +LM4FrDPp0Fm02b5iLaXwJusqhygOJ3Kr8y6pR7VynOB3VCPgvXykl3+zGz00DExxCdB1/OB6Eq
 V/ZanmI+jWVjVfG6nfOQiy1cq/sXG3nb6FsNb7aNJTMK4KO2YgMXtPu2IpzWiXWkdmIwXMjgxHG
 dmXfElqz9dCHrcxTcCbUf3IHmoI0Z61z2TGOqhV6knnBpTD6ZTTdANZYyk2TSqLeNJB8STWV5ZR
 8WWyliIYKhAZDS+GTL/LJ9Jaq9s5gcu+mhasSdnojDPxXrQxEi1+1ShoH90Ij224piCSq8osnPG
 Zbg0PfGz7lcCng5noCh8y1u9WgjCuvxi51NIMRGp0mQwXJLbOSPxQ==
X-Received: by 2002:a05:600c:348f:b0:4a1:e774:370c with SMTP id
 5b1f17b1804b1-4a1e7743940mr151027945e9.30.1792514527742; 
 Tue, 20 Oct 2026 09:42:07 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:42:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:40:55 +0400
Subject: [PATCH v3 08/23] spl: fit: Report compressed data overlapping its
 load address
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-8-6647aa23ade5@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4727; i=alchark@flipper.net;
 h=from:subject:message-id; bh=H3K9eeLxXhhi+g5ehuOXlhAVKF5PPKOyOjB4wGCikGQ=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGrXmaqiK116gYlNYgzjp9tssHrbOduMoET1CSu+dUZV3kq/4
 4iRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmrXmaobFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlbKYA/1NhVAV13jTaiSTLwJXAP5R/veKWMljEOXyjkmCrLal
 fAQCjrpJGnGqbGD4569eeEzQW8IqOqR1hd/6jyHagzL+3CA==
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

load_simple_fit() stages compressed external data at SYS_LOAD_ADDR and
decompresses it from there to the image's load address. Plenty of boards
keep SYS_LOAD_ADDR just above TEXT_BASE, so a compressed U-Boot proper
there unpacks over its own input, and all the console shows is an error
from inside the decompressor, with nothing pointing at the cause. Worse,
a decompressor which keeps no checksum of its output may not notice at
all, and the image's hash only covers the input.

Refuse input which reaches into the output, naming the addresses. The
output size is only known once decompressed, so check against the input's
length up front, which catches the common case before spending time on
it, and against the whole output afterwards. This is conservative: input
just above the output can survive when the output grows by less than the
gap, but no layout is set up that way on purpose. If decompression fails
outright, hint at an overlap the checks could not rule out.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 50c4b269f700..e0ded9b9b3dc 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -272,6 +272,40 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
 	return -1;
 }
 
+/**
+ * decomp_overlaps() - Check whether decompressing may overwrite its input
+ * @in:		Start of the compressed input
+ * @in_len:	Length of the input
+ * @out:	Start of the output
+ * @out_len:	Length of the output, or as much of it as is known
+ *
+ * Return: true if the input and the output intersect
+ */
+static bool decomp_overlaps(const void *in, ulong in_len, const void *out,
+			    ulong out_len)
+{
+	uintptr_t from = (uintptr_t)in, to = (uintptr_t)out;
+
+	return from >= to ? from - to < out_len : to - from < in_len;
+}
+
+/**
+ * report_overlap() - Report compressed data overlapping its load address
+ * @src:	Start of the compressed data
+ * @load_addr:	Address it is decompressed to
+ * @external:	true if SPL staged the data at CONFIG_SYS_LOAD_ADDR
+ *
+ * Return: -EINVAL
+ */
+static int report_overlap(const void *src, ulong load_addr, bool external)
+{
+	log_err("Compressed data at %lx overlaps load address %lx%s\n",
+		(ulong)map_to_sysmem(src), load_addr,
+		external ? ", move CONFIG_SYS_LOAD_ADDR" : "");
+
+	return -EINVAL;
+}
+
 /**
  * spl_fit_decompress() - Decompress an image to its load address
  * @comp:	Compression of the image (IH_COMP_...)
@@ -279,12 +313,13 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
  * @length:	Length of the compressed data, updated to that of the output
  * @load_addr:	Address to decompress to
  * @max_size:	Most the output may take up
+ * @external:	true if SPL staged the data at CONFIG_SYS_LOAD_ADDR
  *
  * Return: 0 if OK, -ENOSYS if the phase has no decompressor, or another -ve
  * error
  */
 static int spl_fit_decompress(u8 comp, void *src, size_t *length,
-			      ulong load_addr, ulong max_size)
+			      ulong load_addr, ulong max_size, bool external)
 {
 	void *load_ptr = map_sysmem(load_addr, max_size);
 	ulong load_end;
@@ -294,11 +329,29 @@ static int spl_fit_decompress(u8 comp, void *src, size_t *length,
 		return -ENOSYS;
 	}
 
+	/*
+	 * The input must not reach into the output, or decompressing may
+	 * overwrite input yet to be read. The output is normally at least as
+	 * large as the input, so check that much up front.
+	 */
+	if (decomp_overlaps(src, *length, load_ptr, *length))
+		return report_overlap(src, load_addr, external);
+
 	if (image_decomp(comp, load_addr, 0, -1, load_ptr, src, *length,
 			 max_size, &load_end)) {
 		log_err("Uncompressing error\n");
+		if (decomp_overlaps(src, *length, load_ptr, max_size))
+			log_warning("Compressed data may overlap its destination\n");
 		return -EIO;
 	}
+
+	/*
+	 * Check the rest once the output size is known: the image's hash only
+	 * covers the input, so nothing else would notice an output which
+	 * overwrote it part way.
+	 */
+	if (decomp_overlaps(src, *length, load_ptr, load_end - load_addr))
+		return report_overlap(src, load_addr, external);
 	*length = load_end - load_addr;
 
 	return 0;
@@ -494,7 +547,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 
 	if (image_comp != IH_COMP_NONE) {
 		ret = spl_fit_decompress(image_comp, src, &length, load_addr,
-					 max_size);
+					 max_size, external_data);
 		if (ret)
 			return ret;
 	} else {

-- 
2.55.0

