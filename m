Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B81D3E77D
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 20:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEDF783B48;
	Wed, 10 Dec 2025 21:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OrjChC/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A0683D03; Wed, 10 Dec 2025 21:45:29 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12CC83CB5
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-44ffed84cccso80556b6e.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765399524; x=1766004324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xXuhhQpVXPiGIMGVS9W6CEE5EPfAB4Fk9kW5KnvtdA=;
 b=OrjChC/FEeZLTWm+3++czIvwNqV3t1SL39JfTUw9hVWlPfYkb+pREjVkoiWf5NL17m
 839JgEdjldZDZgtJwwHHKgAIU9+NVCfXIiA7wjbZA8OHm7swLKMXVEXvT+5GH6gtUXx2
 MFAVZSVdMrTgr/C6kvmMarf3HmsOeL5gpHBik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765399524; x=1766004324;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8xXuhhQpVXPiGIMGVS9W6CEE5EPfAB4Fk9kW5KnvtdA=;
 b=vJZBzFCbzq7HIXDgfDJsuU2nct8O20/i4KKJh1NZ0y2TuUAe2rLdB4q8UuNPYQQHFg
 DGxOeQFFZkv6pT8SFJ26xQRRfI7HIBNqhcRR7A0zpzvzRc/siFZ5s2kfn8dtZXsvWk7/
 hCC1vOhI7dZe+yexxcbQcfwey9nLJ3lBddJ65aOpo00oOGMSnL53rISy00TxK8o3FBr0
 iO0PSgmsIcgbMacbbrmTxTjEPoAdqERvxuGaDsit+UXH7UBQ0Pv8uos84cpTJGN7slkv
 nlCzOlm+9ciUW8lstdHEc0nO94NF6L2K2bZbzzxQFn0TFWo51j46uN6YNyEbBsSD3Ux+
 gw8g==
X-Gm-Message-State: AOJu0YxWzNtYCY3BTp0SEOfrMkBW2LPctkY2gUweS8J8zGzZhlbNauf3
 JkL7L+YFZrtXiLzWwiocWxUtFyqDbWlOXzwM4HlazOAuL9Uz9f65/rVyM0bIhr1asJEXKODhJVI
 uydcF5CA=
X-Gm-Gg: ASbGncuwpsKA0Ezzu/g/77QepfSNKEkhK3R5wp5F2XE43U+DOC2wUbHejnSPRBZSo+m
 RteAZ2WxAJElcjnvMj7Ux/IyAvCfrBymDJPC8fsDbO7XQ0W4OFxC4PlYHrM9HDCJT5I9Z5QErtq
 VZW5X4TMgFBQDFtk+tkzTnQbmwjHHkXxBbyIkokyXNNaU6F/Z0RrnfKWopWoHWgiWwQX2Cbxz4L
 0MLQSEmkaY1Kj+sG86DuIvep/NB7KGPj412Tdw+7adhBlJvk3oxcNIbbU5kZqIzi13farM0PwPI
 d3INOygezGNZho8bUEqMQZL7YS9UrtVnTedm3+6oRTEf5wSUnY0d2MIX0XE2v+HxxfjNB2z/SUo
 pS55MWRAIcIREUOQyrQ228OKa4wOEQLF8h6O3vat+k/4t4a0uXrkfHPJo43J9VrVkbKELKOURl5
 URxpJl69T0nEhkBQqcBmvvOEleXOHNy5H1T26U1rtCSRaVHV2d
X-Google-Smtp-Source: AGHT+IGgGdBzqzV97zEtmCcbt12q2Aqoqji/1XDHGYicDRGMH78ZF8TDf32taubqFGVtQ0JJDWY0IQ==
X-Received: by 2002:a05:6808:6d84:b0:455:804c:f835 with SMTP id
 5614622812f47-45586377744mr1869909b6e.14.1765399524525; 
 Wed, 10 Dec 2025 12:45:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e70030sm485887fac.6.2025.12.10.12.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:45:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: m-chawdhry@ti.com, Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20251127140428.701755-1-w.egorov@phytec.de>
References: <20251127140428.701755-1-w.egorov@phytec.de>
Subject: Re: [PATCH 1/2] arch: arm: dts: k3-am625-phyboard-lyra: Drop
 bootph properties
Message-Id: <176539952385.3502425.7480629842468149780.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 14:45:23 -0600
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

On Thu, 27 Nov 2025 15:04:27 +0100, Wadim Egorov wrote:

> Remove bootph properties no longer needed. These are now handled
> in upstream Linux device trees.
> 
> 

Applied to u-boot/next, thanks!

[1/2] arch: arm: dts: k3-am625-phyboard-lyra: Drop bootph properties
      commit: 8c5166e9fea2de59c62e6adc12eb82ae01f01105
[2/2] arch: arm: dts: k3-am642-phyboard-electra: Drop bootph properties
      commit: 90dc6a8b10f903fc2b84a7dd18a120c1c728746f
-- 
Tom


