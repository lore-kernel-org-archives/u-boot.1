Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD907606A332
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FnOjMXHM;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f++XL1+z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B964088B;
	Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2h_a4Hmf5Ukq; Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD7A04085D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313456;
	b=qBSAw8pOVsBQHWwXy2rwCc00/6uyE1gRNuBW2v6lK3JMqj/0IDTiZ8BpF5ocEAYiGeco
	 z1GxYyAvmSmtTpwakkpO/ki1Rimg1Dnpp9ird6HGe8pLxoCPf34r/eNz+Xy9z3MTm0Yrl
	 bG0lLt0ia3Yr7FEkdRNyreCEjDY9bXN85ToRErOgJ5f8DvPC2mNsXKv4yi0OeXh8GY1rB
	 UBpannaMNkbj48qTca9Un6gygIdqW5TB7ujx9qGiI9cRnACDjOEJa8Rl8B6M3cNFBcG8d
	 UdAEUdON6z/ihYpQRIjMfDMIE/Rbg8JMAK/qZA76XR9pRLa2GmY4OhIVH72xvIElahA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rQ7u//a2CIyRjf026QeBqxiFLqjBUB4eTt3mISAKtIU=;
	b=QQ7sPw/Cr8J9D9TfuDGrHKlF0PYOVDvCB3xJ3bH/6usaOjeZCfEeYt2hels1nVf2mF6y
	 ORF52xgyF5863KzNB9rG8HARFEGkQp8Vrf7NkJ/oYU8eS2Z/uyZoKUoWlIJb0EcQ3T4/3
	 +gaSm20IU1lNB5JhDHzKGIU0n+bHu5l+sN99HeKA3RDYfnX0rJ8MXziE9lsgSHvvKvxYC
	 VQ4//pjn4bMEsoGHSl6xnpilXcO9Ar37AmNjM+EGgsssTOdErb4ebZXjHWLDn6XWn6Eik
	 xS4resHwDeFUXQAfCgmdHXFwRa7JPSjAtjTCoJo9jFWgoZzRZlFajtjuU+bmifp24Dg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313456;
	bh=rQ7u//a2CIyRjf026QeBqxiFLqjBUB4eTt3mISAKtIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FnOjMXHMFu+d7FZXC4lTZ3BXkZ3BLl9DwBSEbp+xZ1s/qfybc6r737/XdXqPHI03o
	 VcDwI950QLpKrCFLaEtJX3ipApzIhXM73CP51wC3wDZgiBRNE58c4aQd7ShlOh0BY/
	 Z1IpPIxneBhRAjvY2HdaNQ1CbHRJlSHfrnmvyGwUqNx5VXvC1+BxeNxAll6Y7PapNj
	 AFwKXsgBlLma0i4rNois8JUx+caj0c30X7UrJUNSphtupwLq+FvUUEqBJUttFR10/a
	 /c1esJFBVY5Fyg0NuWqO88ao5NUzadG6oRR/Zz4kGvc3ObAj/ciZCSZesXW63HBJk7
	 FSVtQot/ogrpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD7A04085D;
	Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3939F4B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AAB381178
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQtrG14deFLZ for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D6D98112A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=f++XL1+z
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D6D98112A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:10 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso18904295e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313449; x=1794918249;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQ7u//a2CIyRjf026QeBqxiFLqjBUB4eTt3mISAKtIU=;
 b=f++XL1+zNbc9Bo3eOSHKpWaGE/RfTtRtgBU7mCHYeQ02i7uywgmRITEw1lSW9VmupU
 tTpBrb4nD/JvOXsFe80ybNZperYDSrgBOe2FlzO66LfTQA8k990wrAGzifwzVnUNlSD5
 Hj7ZeNu6bOScM8BIBVTz/cqmoRhqxR4fMIAkCF/6EqO3+Nx76Lzs545k2r3vlwcc9p6R
 RRnYKgjx7z9VcwGAHLw3lZgS8XVRz0joqjlHVTVqcaokhquQJDxApIFXxZlBo0coUOq8
 QlDp8ioJiV4tpWfWlFRxXyy8wbQGA4c6LeP2v7LIKPC4Yf2zXnayt1SZ6CkRaozCpduz
 A6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313449; x=1794918249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rQ7u//a2CIyRjf026QeBqxiFLqjBUB4eTt3mISAKtIU=;
 b=GFrgJ099R5ssgp3TW0S3idWLkYNSxUoU9OOOJrxc/lUY/DVGjARGX4dTk5lIk07Jhq
 zj3iO0jCDQBW0/TNatwvxiHuKY0djMBM+jMI+53lZMPVPkNCFnW3q4KnpPwSpXXykNZJ
 RMiesVb67E4IkFmg2odRAUcDk6YxEG/Iyxpxc6IqcrdXAUruwMmd/PIjCV84nbSd6TTH
 6uv8WcwHO8x/t5ErAtz8NmEQqAVQFObmsZLH7l5Xj41eDs8Znt/+50zGRCvwhxzopi5u
 T4/f9OwQeQiSZPyLuvqlwYxUhslhpAzHNbJTzG7JnHmf4LzWCao1GWd65Ar1T+1TGK1/
 EL/A==
X-Gm-Message-State: APuU4Z+DcWhBD7LMZAnr5W5qoksGLmgD0EKiyh1sXj0Xksogl3Q2J124
 JD0qU/PhPC+GGKamTul3l9jStg8wCS2BCgfaQGnuT0Y1acRLdrA0/gGwbMQX7Fc0otg=
X-Gm-Gg: AYBFou16gkdj5d7NzjQBRCTctkLshV1FWLZ7VOPbkJ6+Jm33O64hu0LlUcPTeU9EKaY
 io9G8PdW1deCAAE75E3QznQlCzMnsrQ1lnXlLZBeAvnungsoFOv+VwmzNoO/84MGVYKb62Iirvd
 xr2mbp9JrljMuss+884Ymvy/E/gMJm/HZ4yCfaMBoJATLEFDg2A1EYVXoKrg4lYv/BR5NbCqbFY
 ikjISLCOS7YiStdjyI5Z4I7UTpZDziyBlf3lPXFX1V4gPa/t8TqY4Jghcx0FSLkzPo2FveUVWDC
 eGygcQO/AhqWSwszMb48p6fyPGRdVlTkGkEXCMb9NC3wxHaYxLTKO4CO9AkzNwnSc/DxnLvL3gH
 BXJAcBwx6hWDRUugguksyDuWlgasNYmheYUuVXAz3JErm0bUnudWOZzZrjdtZSwnTazMHto5ySO
 Buu0WEEGtzPtVfl4iyWwzhJBXnQfF7smDRtZKCaFZ+dbHRcgwEKEPmZCitzDMJ6IIyYzOLIXYSp
 BtRMpGrhhEmNtn7TFJZR0Y537fLh8IT1fNVRPbLLkg5IOC9yxU/HspBVhWaIrxzm7nYTTVLwDnj
 dxIBj3N9qB5PLXTcS9RQT6KJlji3r7vhaF2335RpdaVMepb4
X-Received: by 2002:a05:600c:8909:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4ba02346b6fmr30555885e9.17.1794313448907; 
 Tue, 10 Nov 2026 04:24:08 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:08 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:23:59 +0000
Subject: [PATCH v2 02/12] binman: btool: lzma_alone: Update version
 function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-2-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.16.0
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

lzma_alone 24.08 now prints its version string to stdout instead of
stderr which means the current version function will not find it as it
only looks in stderr. Instead look in 'combined' which contains both
stdout and stderr and so will work with older and newer versions of
lzma_alone.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lzma_alone.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b..aa44c897223 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -116,7 +116,7 @@ class Bintoollzma_alone(bintool.Bintool):
         Returns:
             str: Version number of lzma_alone
         """
-        out = self.run_cmd_result('', raise_on_error=False).stderr.strip()
+        out = self.run_cmd_result('', raise_on_error=False).combined.strip()
         lines = out.splitlines()
         if not lines:
             return super().version()

-- 
2.47.3

