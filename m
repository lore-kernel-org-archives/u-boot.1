Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC79C3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DE388792;
	Fri, 26 Jul 2024 14:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N0eMcF1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1398875B; Fri, 26 Jul 2024 14:59:23 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1134588714
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b79fc76d03so3642856d6.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998760; x=1722603560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t77mAhRpjKoIC+9Rns8AJv19OQNX3cuqxM1ok0ToT4A=;
 b=N0eMcF1+9gSeA56GZm0PS72uW/C/Q2fGGLk/mmaEtbsev2vWa/DPq80isPmfYxAMfG
 3tiziToXltZcQuD8AuMARsa5UjgdsVuNvexdDJELs6T0DO959ysK1Pgf+8KlxoK6EJEV
 EMuGf3J+yvj7WoEseX9jhIIflJ15/3hml40Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998760; x=1722603560;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t77mAhRpjKoIC+9Rns8AJv19OQNX3cuqxM1ok0ToT4A=;
 b=OCf/xdc9wXQfWj8mMod5D11k7Zz2xjIeyTs68Own7fn5fM9/l93jmkmcGFe9jLzcLd
 9JstcqAqWIYgA4yLWpDGjbdXi/04nQc7xxaw1aMeh7E+OcVTBrI0sQMeKn9/t8ugl6Kt
 R4nXmkOOV8CB0Ui7kJx37G3+k8Gw04guPrdCyj737PeQtrJqzlMJbNF80HBFYlIZPksB
 +xy4DEpBSHxhMrPPaXO9SVbBbB2X98yq/K07VTXdEn/mwpu6NGae2GDGIIfquXgZoG1x
 iCuau9CGjzbFDBfv3B41xxIALsxa/cMypPTEdu0dFLcSB2YRNTZ8RcNY9O6gXjVu1EMp
 hpmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpYZRRmX6NHSgFvn/VkkSWHA52oJ7eQ4xPjuGtRTL9Y7yiv8TXUBHuZJ5JhPWyxANtCC9PzIAyb7OqKFoz/vMMwNFNPQ==
X-Gm-Message-State: AOJu0YwtgNShjbRD2lfq9HfKzmnlGL3Q5SfaXefDhCAFH0sFk+WdhI4f
 SLBGQh8eO0KGi/fpZ/ewhxSg7ltcGA6bqxbYqX44zfPGNgOo927pXeGrtHm5T6XPwn6WMYN0NN2
 aS7qm7vtnlbHVY36Zlodr81qP5p4ds1n2Njbv
X-Google-Smtp-Source: AGHT+IGTN9v0qGZVG1+ZVT4ub7COa8T9UwLjcWZ852NqKexLS6/Xn1r/xU5gbGBh2Dq/Yhnyx1cRMAO/J646pKR84nk=
X-Received: by 2002:a05:6214:d6e:b0:6b7:a248:3961 with SMTP id
 6a1803df08f44-6bb3cac5a8dmr76645266d6.41.1721998759936; Fri, 26 Jul 2024
 05:59:19 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-2-sjg@chromium.org>
References: <20240717155712.2913651-2-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:18 -0700
X-Google-Sender-Auth: oRjc8YQeIsq9Kx1-2YvB7xSaehs
Message-ID: <CAFLszTgfZ4sQ4bxn8grizqoM0wBRRyhZ+0zroiboSiOj+kriQw@mail.gmail.com>
Subject: Re: [PATCH 01/24] qconfig: Fix pylint error in read_database()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Fix this error by initing the variable before the loop:

tools/qconfig.py:880:22: E0606: Possibly using variable 'defconfig'
   before assignment (possibly-used-before-assignment)

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 1 +
 1 file changed, 1 insertion(+)

Applied to u-boot-dm, thanks!
