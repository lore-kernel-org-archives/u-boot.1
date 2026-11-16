Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C253606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bQLrHiW9;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JJPEG74e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4829160635;
	Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9INzF1FTtrk; Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83AD1606F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826770;
	b=tU6p3Ik70t0nHqCy82YI6OFQaBtmDNLaC0wy9PwV9ifO9j8Cb1Xc3aNwYru6eiE+Cxgf
	 WUpd8x/L2kAx9GT6mmukx+PKVmrCrJqMsZyWAtTa6j8h5Jgm0KvydV+JpRFbTPDknTWFT
	 QWGXqsdpBe3G9PGKlF+/MeyIEjSfl5pi7zpM2MBrfBsheoOk/cUBK/PnM8IGoi5eN0eR8
	 vHASoHcUrzFuJjXTJlUKqrtrJs+Fd/Qnnl2aczb10NX8y4UIfhSOQPobzbg0xbzcUSILp
	 IPoY9ZBQHerL0ryDhFlQGT7y5UsheV0bu+Wz5GlrkXEw/YD1hL/lVKzoYEwIAMlTW+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
	b=gkOOTsC31NKLNNP5nRMrsLo23mAZArfunAoFcElzHEV76Cko0xVvfxTiCPCrfxTyh5P0
	 96yosx+4mfxoqX7RPfWVJYUzh3lrsWc4ODK0A019fZq8XkoxpqOXuTeL1mNaAjGIQVf+e
	 ANyNNPD2QF1ad6iRv247wG9rPlRjn3WSSVRKGV/lqfYP9sZBXLMoRtDAGGqChmOhArrWc
	 44DRmtO44lRbuedtviGdly0ygmx4EA/CeiQU468wzkVkcPFFoPqNPE6Xn3khB3GoKjh2x
	 u+HkdCqf887u6Oa3B64Xet4t/0hdkpAYLYM/jV1Nh1reqlDYXvHjvK4rApCq5Vsq+Dw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826770;
	bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bQLrHiW9cZnC480ZYABESA/03ivQrjBGN5ygR+AnG8+yFTbor49u20eQFrlQFpTKN
	 qtJ1i1xDPKxxnhYCz/z9W1m/YHUooIoABvSB9OgV1i5MLO37KTaZSNVl0UXNblMt6z
	 ejdtAqQynqnpjgkrL4adliKEFu3gLWgPY4vne33egk+vMNJ833wOAVcjocyc3o0BPL
	 7unC1OQqsdd950AqWb5HDPwjjgfabv/hvO5ArUnULPtmohHCiYYu6L3OjXQ8stKJZo
	 m5O1orhOV61fIQByxCzIr2TxRg4YJvqUCNrn2TwQUWf/toIXrVpWWKqx/B7UiCBXeS
	 NxXpg/EmG4enA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83AD1606F7;
	Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BF7D1E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CE324009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ly66dKym4ds9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C15EE40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JJPEG74e
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C15EE40070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:27 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso12401475e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826765; x=1795431565;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
 b=JJPEG74e3wnV6t30+7qjc1FoiXbywGQMKCAn9C6kfuA/p0aVUrnxhO9HYolVZJifMl
 BfQpW3dSf8pLejtzZvqwNpX+Y5OSeQTOaw3EktAmlbItAvpXpZfHQa6xL2Ly+F94LjpX
 oq83Y3Y7L6jhcj6Nj3du1DWcoDrhOpq+dR75yQvzifLh5c0Uo2d7kxTIqXrMaxitRUE2
 uny0aXbmmoT37TrH//79esPmkgWAYWvW4xFEUdhGeA+r5ppERHWLgfJfnTDhLMO7+I71
 vAyrtGDYbHh+ohByvtXS1mr4uz+xvP05+3TcQYe//clQQWBwLf7MjHu91PXjRs+9onOX
 gPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826765; x=1795431565;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pnuIdh7ld/4cWhFw0fwe1nCnXPcS0LNdHs62BoCskEc=;
 b=bqhzKslAP/JZeIF5vE4ikHGjag+MR0lImljXO9WSJ8aS8QWZyBd8n8/VIMBmUxUzUs
 7Nptkn1fAjIcBbkHLhRXoQsR3hc7WfrNb+pRnsS0svuvCiE35v0plf1JE6t5hZhs07Vc
 Jehgd2ZkaOjvzBZnx/O70Rs34MzpORjMP20Ay7+jASK2Uh6L1ZR2cjHMPPCTTUmoNzdW
 BIikSFacNFbz4NqjM2q1Km/taufzF2+yROM7SNpHhuRif6myNme6bXMX3eRfi7vVqx9R
 Y3R+c22Fjp9Y+JL0uc/XdLRz2v2t6pJfKz+Thd7cMZ3KectcVwlaFD6T62hJ1U52bzPM
 B7Ew==
X-Gm-Message-State: APuU4Z+AhDCKkX5RCFtiGWiSOcjaochHz2WK4KSrk8WICvfRmn6kfG3g
 VcYIBEUZCvweszmd25UltIFbyXMRM6NBtXyZOg2h71aXFMyfXnEPpvMt65sFwVXZvK8=
X-Gm-Gg: AYBFou2smUhDe+4HQHBWNQ/0uA1HE+wEoW3zeiK7Zml4U5aJdN+UYyP3OnYnBtOMqDk
 EGvfNevamOyGG+n9OpnqKznZn7x58+TEkV+aJ8FKygCfXUEyfGFfW4AzPOzKrr5LvAKmb8B3ORt
 wc89YK9bFbKVPZ/7czcexjzNLM77q48kX+QUnL+qCxqmbUkr22AUcRYnQbfaydLhfZvKU5u7971
 3buQjc/K0TKJnTFI+QWDenJUAj1jgAWPzel6za+cfWp16g8pR9d+f0ofcSt3YW7SvPakru6n0mZ
 GeVNybMsUGSeWwxjBDYy1kIDoHwDAGyfkH7r2klBlBY9AHG059KmrLa++R7OfYFRchTaX/sz9M0
 BbunKbL8Nw4pibjH6pkTBBYA9VMfdYSgAoH+NGIggpgUVKyVr5eIADVlMTTSF1W/mIabF5BOL7X
 JDH1GnjmuBLz3RPLI0fkkB/oN4P5o2QegzUaEeDET1oo0Hphmv9MkCOOo7reR/+Vc7yiowbnf2N
 ZHYjW+Dya/8FtLPqGoGDS2YXPvIp6AFuG/NMs0S+puEA4fQQDF+TZnvQKcfQuGvYhaNWTq+vOcB
 oBDhsmVAIxNi67avJv3MR0bJOQYYUe1zvrvKAcuUlrI7sp7E
X-Received: by 2002:a05:600c:4f0e:b0:4bb:5f43:23bb with SMTP id
 5b1f17b1804b1-4bb5f43261fmr174832755e9.33.1794826764833; 
 Mon, 16 Nov 2026 02:59:24 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:24 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:21 +0000
Subject: [PATCH v3 01/15] binman: btool: lz4: Update version regex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-1-b6cf7e96944b@linaro.org>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
In-Reply-To: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Simon Glass <sjg@chromium.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the update to lz4 v1.10.x the version string has changed format.
Previously the string looked like
"*** LZ4 command line interface 64-bits v1.9.2, by Yann Collet ***"
and now it is
"*** lz4 v1.10.0 64-bit multithread, by Yann Collet ***"
The ',' following the version number is no longer present so remove it
from the regex used to match the version number. The regex will now
match the version number in both of the forms so will continue to work
with older versions of lz4 as well as newer ones.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lz4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a56..fcc0d91553e 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -76,7 +76,7 @@ class Bintoollz4(bintool.Bintool):
         man lz4
     """
     def __init__(self, name):
-        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
+        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*).*')
 
     def compress(self, indata):
         """Compress data with lz4

-- 
2.47.3

