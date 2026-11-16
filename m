Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20118606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MGvFpYnm;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mtZcdjjF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92E266073D;
	Mon, 16 Nov 2026 10:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlRsaxcwVxVa; Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 572E0607B6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794826778;
	b=DrO30PJlexLYIT6zdlNiIgv6RLB58BiJQYzSmC1SbcpszHDQ4GdI+VB0tXK/LJjyoPZh
	 5si74S+P0EVCjK61PzAvBDQa48XMr4wYKxCBzfXPoUTjaol3n/jScgGsCHAkguQgVngcV
	 I72A4SK9aqDLRJM4CmqFXhRMyiZXxi9AGnthBynqI9G8O/9RI1OeTjWPX5prGZL1oZeZA
	 bbsAhwu5tJpJdeb79SHnGmto4a+fzDwpTMtrgaYQe/QlY/ZXVGFqjgszbpODIhy8/NUqS
	 QQG5E0ZP2DrL1rfGtNeIazq5Umyk8RSnGrT1DqS0Or3KxRcLBPaIn49WAQY8K1aRMqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KM1V+cR/tNCw7xnPQLUfGw4f06JroNah7ImueR7H2rY=;
	b=Av+8a/7GCCyCpDqzfig0bspeCmAnzf4D8ce/b3l+eyhD9EWmRQh9+0QbghkhMKTQ0NKb
	 ub2XO3mNLaZBVkV7xyuMPZi2d2u2dMoLbE3DlMgvv0WU4hsfa/B/FusBwTiQ/d4DHxHiD
	 aOFOq9vlRPazd08kXwbIfboXMouYE4o+HVH4smMjs6TXafdczmeVkv6uJ6sQH2G5/clLd
	 bcWZIP4XsqOLxdd05yMLm+Eui8PC/Ncc5sGg8WH5T3RxUWiDrvoWw7JiTDC9Q+AZYd/PF
	 exiIcCOlmEnORj0VHAyLpYkXkol52tcBdl8DKX3qEQTVsym8EmH2Mb/UVZE5thn+XJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mtZcdjjF;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794826778;
	bh=KM1V+cR/tNCw7xnPQLUfGw4f06JroNah7ImueR7H2rY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGvFpYnm8M2AMJ/y3eU8rZprXAzsSjP9rxeoYpu+Ia5bljVV2l6nMOhCnW7QZv8Sj
	 Jb3FG0h8rgI2VxwxV648OMZnMdg2qbf2ekgg4ATb0HeQ0lvTBXJj2oIzwIXEPYcJZk
	 TsTmPlyulNfaUotM5riwaiovKenLKc6LRQhuEZDzIiNaOLZdxKvM2m0OTnk2PW77Qo
	 QS1mGu02i4YiG/yWj3O56cDVGSVAu+G28i0RIcRN15Qv+7n46V71nmuQ7OadF/SLRD
	 UMc6hEja33Et+1+8bvA7fBPOM5ae0AjQW+Y0JGXoqlxnq9R1Byhc6T39yB8HaumEt8
	 JGq50wlv3cwsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 572E0607B6;
	Mon, 16 Nov 2026 10:59:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 431E71A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 354FB60635
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-rIpLbwFgmh for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48FF9606AE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=mtZcdjjF
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48FF9606AE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:59:27 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so8915315e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794826766; x=1795431566;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KM1V+cR/tNCw7xnPQLUfGw4f06JroNah7ImueR7H2rY=;
 b=mtZcdjjFUggIMNKpvEJ+SSVNJgSS2FjNX0MZGf8OhJEhtBL/n2aG0RUn4KRLFy7qWx
 ihldbOCxmx5sEFEK4nDIvbFkRX9uXoVvJgPTtVUUOaL//wgZc7iD8kk/Q3NrUsLHUnRQ
 C0TodtwPJ8Ft9S8dpmJ48spi+pamY2uCRorlvyG4DeDDmzchALfKCBVaKAc6DnAtKbW4
 3Ex/K29IVNcalVktsRjCo14yvF9ods0/AYXGs2oN/fLfudWQRMjN6WhN8sncaEE0JCl5
 wOlg/70ZgSXh0+xxAKUf98qcXYLzlT4nsNbo1R3pzOUX7xVX/R5P139Wnje8QyWPp3GF
 s/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826766; x=1795431566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KM1V+cR/tNCw7xnPQLUfGw4f06JroNah7ImueR7H2rY=;
 b=qs3AF0QxCJwk5rTZFqdNMwuNl+2h6pOmPbCegqr0NFk2ldVp3hEzJg3gOM3GGoHxQV
 KIJNtZWqZUTBlLmxXKghfDZyh1E2v+FnLr1qjSiLZE55y7fVTyDmyQXrn7GGVIg3Z9bG
 lKff9+0clvtpeG5h3LMn2FqlwXObMe7WRm/At6wOAtdVANc8DSYsnuwwdbM5Fb4bIJiT
 mTS8awzNWUzxh306+KImzQneHte0hGa4hW9T/cUllCLnC+eSGM0oYuvsASJEKABxwvZk
 elwNy2a6SrLkFAOZmcPPmvu3k8qo7hq4hcER+BvJL+2QHnbxWMA+4wcxTX0O1jJH67Fe
 rP/A==
X-Gm-Message-State: APuU4Z+ORHAzUm4tOVV/2958e0nlACv7zyuVPfwm4pYs5HQCMiUONtD0
 n+RVo/fIhsIchfXwt6JKuecot5QyuTq+wMdWWAlzcJWy5zC/oWiXn819Uu/8HEJuUVc=
X-Gm-Gg: AYBFou03jmfOVi8rBmX6wJsZszPapvk2142VvS9QUky+fRhICYl1vYBHarmQV4SVVtx
 1P0Zbgr0xjoxAtygt5bNJVPTVeqEBov4SDc36QEtd8XYAIfybySsdWKyBa950Qm+iJDOyq7iEvS
 tVnlEawdwaHWZsUIRrXPqLtNwFO9u8LkJ5e3NlriX56UWLYmAvYi05lPGYbHPwMoEl0w0QG+JpK
 SFkcSuop1liUwY/42VKMq8Ebma3IfYB3W5brCG8zbqZzgq3BxBn/A9cxKmpCUWo3iWG7d8RxeQ3
 HvSTE+B0jb823exDUL8Z5fK1QJ/XRkqSLDdyl11HcdD6elLn+CDi9vhyfAOlvsSkJWQZMREL90E
 d+by/sxO48TGBnddoOi1c4Hotf/Z9OQYp4pF0JhGJl+d95Zp7WTKv8O6m734EsE/C9SFFFSdQEB
 CUVzTu/S/iYyWJe0KUwbs1Tl0tK94Sab26CckvaT0GOYmXLcEED6LZ4Z4xOi1eE/W9qTKPdkbFG
 dfigTUKDtwdlOt26SO/skffg547Si2TERMjqQoHPr12JBEYJLXmUcCeHtaRQFUKy6haob079vDM
 Qb1OXwQLe3GoYRyiu8nBUZ5mPmE4lH0xmAvIcGl3OLIg4d0u
X-Received: by 2002:a05:600c:1f90:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4bb55a45050mr220757345e9.5.1794826765836; 
 Mon, 16 Nov 2026 02:59:25 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb64ec7b58sm219594065e9.5.2026.11.16.02.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:59:25 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 10:59:22 +0000
Subject: [PATCH v3 02/15] binman: bintool: Do not add empty argument
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-qcheck_fix-v3-2-b6cf7e96944b@linaro.org>
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
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>
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

If lzma_alone is invoked with an empty argument it will emit a message
to stderr. When 'combined' is used to examine the output of this command
the content is not deterministic in that stdout and stderr may appear
out of order on occasions. To prevent this situation do not add an
argument list to the command when it is empty. In this situation no
error message is emitted only the usage and this is always sent to only
stdout or only to stderr depending on the version of lzma_alone.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lzma_alone.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
index 1fda2f68c7b..deba3ff7677 100644
--- a/tools/binman/btool/lzma_alone.py
+++ b/tools/binman/btool/lzma_alone.py
@@ -116,7 +116,7 @@ class Bintoollzma_alone(bintool.Bintool):
         Returns:
             str: Version number of lzma_alone
         """
-        out = self.run_cmd_result('', raise_on_error=False).stderr.strip()
+        out = self.run_cmd_result(raise_on_error=False).stderr.strip()
         lines = out.splitlines()
         if not lines:
             return super().version()

-- 
2.47.3

