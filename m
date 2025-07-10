Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE1FC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A4F836EE;
	Fri, 11 Jul 2025 00:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LsmxZx8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151BF836F0; Fri, 11 Jul 2025 00:42:01 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA7C836CE
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73cddf31c88so750443a34.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187317; x=1752792117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8kBeEf2fh+bFPQJ6i/RjSixNnQmFDjCrmPERr18CRfo=;
 b=LsmxZx8OrzHZ7n6PsFY89e31J1pct2PoboDJMaPI5gyk/eKSapBlAnRQRJkkp0Q+hx
 1hoAu97gywMXNBGc85kZTYm7plZuIH8XoHvAnYgV6e2DJ8VywN7Q5gL7k0ql/1Q87lgh
 U8/fdseXvfnFEfz3Yww4eRvPehIdVhgavQDxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187317; x=1752792117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kBeEf2fh+bFPQJ6i/RjSixNnQmFDjCrmPERr18CRfo=;
 b=VN6sDXCKMfGP4BrrfYzB98uVGlgvXWNaEbOmM27EvaenpAFJvETXNJ4JtRtXYwIdzM
 TvgAlsLCRzpgy+N+ZFcU6hUlsmKYKuBAPzQt60BZAanIR5JAmKj4vmRDOB3ZTHAMRDJZ
 MCfsearOJ6iB7AH1fBJbrwl6WJ+r38ZlxcqPxJZgHD8Y0d3qGxqInGlas1mknLbAjw3N
 pvThyy2xzagWGOaKWCdjaNYyAgg9Uvy+wAPIN0G2svoasf19QtFF0o6Luz31yv2hOJE9
 qCLky6m/I7b6zBEypfVZW+/Xvnpomeys3zyLytYrh6b/+sFZABNUaaGblXaWlp1kmqlh
 2WsQ==
X-Gm-Message-State: AOJu0YxAqfufDYo+fmzOcd5Va++u4yW9uhIriJyNx8sZuE9ANi3+LIty
 lUZGRuXUnKxnmqNI83lC9KlEiy1od5elzx4lAhp+xP7oa4HumetaMjdJFOXzb4vZUiWb6BhZNnX
 WqfhdWtw=
X-Gm-Gg: ASbGncteHf8+rwY8svvl5Blra3ahoin9tJHG+o/gcgXI+RQ28yE2u+S9ZkQSKS2H2tf
 V0UPegZargCJ/OWJhzB4CaBIWxkhAPANIjdqTFE3Euyw48XTkfGOFWm5fS25lZ5sU3sFCtQ6x0S
 /RqGvbaPFZ0TO1Rg8U3aZIxrv+W1yikgcSp5eOatJR+4c474klhHY9Gooago0g5Z7oFLNyvucvi
 iRuuu92JWWosajhqSI5zjPIfInnA8ar/wDeau3e6xlNLLtsVitpZ0j/jY/j6LG53CbXx4Oqq/vZ
 zoh9SCHeEVKKlJpqKgnCO40lVBSVan6EtlUgHw1aa90TjBXEn1+1uTV9Z+MejqUhzhw95Koq3+P
 52uMTgSQjO1rzWRohOtsDkkPoht9p9HBqqNG2v/CpypYlHFVLoZheuMA=
X-Google-Smtp-Source: AGHT+IGdfCjkJPSSz4t4hPg5HLIFwXJhxY4zrARUcOtpDdV4EbysO6BFLvadNOa/9ND9WoFUCqOn6Q==
X-Received: by 2002:a05:6830:650b:b0:73a:8a8a:5154 with SMTP id
 46e09a7af769-73cf9e85492mr989855a34.3.1752187317529; 
 Thu, 10 Jul 2025 15:41:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:41:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250701184257.3191508-1-trini@konsulko.com>
References: <20250701184257.3191508-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Add some missing {clr,set,clrset}bits
 variants
Message-Id: <175218731667.2073260.3286521263265314138.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:41:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 01 Jul 2025 12:42:57 -0600, Tom Rini wrote:

> Add the 16, 32 and 64bit versions of the non-endian {clr,set,clrset}bits
> macros.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sandbox: Add some missing {clr,set,clrset}bits variants
      commit: 7faaa16a471b0b611685dd3872a057f1cb286262
-- 
Tom


