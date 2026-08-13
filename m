Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E71C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52105811F1;
	Thu, 13 Aug 2026 16:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f4yEZLEisze4; Thu, 13 Aug 2026 16:35:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AFF8811C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786638940;
	bh=psu5LSdCirrJ8JaEk4OxuEoHlZ6f790TDSKdppaoYcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xirm1KDcThZEdwQUtMrDditr79dYHK5s1gJgzBYcupLn+cp2tvRCLTvyIA1bxtL7n
	 yp6pOQyexnudLDMEvZnIIwYi7jRy4NBJXTmdGYSELfLeP2/iWd7LKwTzUZw2cCsxoG
	 3yxJN9Lh+ghMj9++GJaYQAn63kNK1a2s/SAtORWvnsSDiIP0z4MdkO89WdbOgDCUgk
	 k8PKxQwHWiPGkhxffY4eNDRAuNmt9y7qDJhbpUfDsXjPvoT2XRu79bZZAWc5uMOXUv
	 RMGKMYRTiQyJRqr5dATwDfblqBd87Yq50B9JbE0ZubHPXomfXLxyjePiV+y+0WhYdS
	 Zgx4ueXY0jVxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AFF8811C1;
	Thu, 13 Aug 2026 16:35:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8483F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 765D6811C1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krqIc29bSiEl for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:35:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7E9AD811B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E9AD811B3
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E9AD811B3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:35:37 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b1fcd3b1a9so395617b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638936; x=1787243736;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=psu5LSdCirrJ8JaEk4OxuEoHlZ6f790TDSKdppaoYcI=;
 b=f30gS8/7pLR7gfQAmVPxwx3mUYVxWix0KaRnSJaEh1y3j31kZaQia/a8wBBWW2Sjiv
 QAoJVLa3piQSzIMWKq7H/z+BcmwY4vFf7NTWGiiy9oTXgDo/jNE1uMn62Zl9a5I7xAOp
 TWxjOInfNh0LCR1tFpjPqCvt+4dm6XEzwJpG0+jPpndVu4NDHs1fOdejhSuvbQNI9bcO
 LqrQwIVhQhQ8WqaV1gkmZQKqnsd4wngjGcj1ykMWtdx2Abwn5kA8Gvkr4qZM7VpVFSVP
 cZCsYe0HGCbRkBfVuC1/0Jj3+x2yY1YnuAav/Fa+pY2cNPSyHJGUFWKwcr/WEyFUNatJ
 V/jA==
X-Gm-Message-State: AOJu0YwnZWCPVgupDLNRyMIL4n3lii8vIjIN/6bK0Q00KEgF0WUJwLZx
 fpBHs+Pg3i3Uzgv5KJw5blKMM1baNbt2rRd4EVV6xqRD/EjsWZ4iuX+Spy+Fr1G9Z7E=
X-Gm-Gg: AR+sD120Yn9jTpDVDPpcVNfk8SOVU9i96l1FLehuGCjT+8IFIheW2QgJ89IxeFK8XbO
 Pw5DZD4iOLOzPZ3Y6iDFNDLG6+4hOyNv5TqQh6cn3XI6QJFtpbEp/IVycriM3C0sKQhWgRh7VBf
 yCTMM7bKMZoa51OHBFQu3uF/24Ls0ZnB/tnGFsIIlifhUfm+ZtTLIZA+VDVnnzYY38QFz0xEfD1
 a0nTiBqMjpZEQUQ3Uv/TsZjG4K60yDYPk2b63crovNquBQTENzmFhiQj+8m71kejrUkQspkqMmd
 7COL3yyYHL41Ph3Hfo67Pi6cra6LY0k27o29VSZpIeykmyXpftiCDnQ9oq6IMLgLRsPZb1KYnSV
 MBI+G75FQ1bsTeRAj7lvbI/fj7rrtt+mQpWNG3xVgNeo1gzH3CNrQle4SPkBvUf94+FEat4w0ab
 /W7EiDSBtniKZkVgx6HOpzydbnKvRwYu81fnncIWdbiAfx2wcjfLYOP+dLEZSQknXP
X-Received: by 2002:a05:6808:4f0b:b0:4af:88b7:94ab with SMTP id
 5614622812f47-4b2277ddb62mr6287969b6e.7.1786638936136; 
 Thu, 13 Aug 2026 09:35:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b22cf5c4c4sm1928962b6e.9.2026.08.13.09.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:35:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260731-mtk-clk-mt8189-fix-missing-qualifiers-v1-1-92f3f0e44817@baylibre.com>
References: <20260731-mtk-clk-mt8189-fix-missing-qualifiers-v1-1-92f3f0e44817@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8189: add missing qualifiers
Message-Id: <178663892582.2270888.4121091714165722460.b4-ty@b4>
Date: Thu, 13 Aug 2026 11:35:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=k1nxC+ZGmKOQsjMkDufHDtJu+3J18PGx1zIAinXViaE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqffJQF17VkkW+BXJPN96Reu03YP3ghNhtA+cXO
 OyiMeoV5ieJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan3yUBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaakH/0bP3sruh30TslqDE1m6yq8sxoqnfnq6IlTQZ7P
 8fdURHuj3MU9odYsALpkpoqAMRcT3y280O4CRvk6IWNe5x4oJvHXZv7QUSqEwLwONTfJaAoYPuS
 li+0Hbdgbdy5MfiOxvcjydlUBJLNu0s6p9ZNMoOmnok1uQsotKNHfrN73Op4OSkRZi4DfwRrZYN
 ofC4cv3OAxisX9IEAj6o9Br3yavQWaRB0TlQvbpODdbPKPlE3RHjdiczuQ9Z0IQidVKLaFrhymT
 SXKEH+bx3SmWD29+yV1s13XGlc85EzppU7u3an2S4mgjzVVuzQudmTHIhZF9npO2YJrtYwN/0pU
 77yc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786638936; x=1787243736;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=psu5LSdCirrJ8JaEk4OxuEoHlZ6f790TDSKdppaoYcI=;
 b=OyK/ulujWBLE9l/bMTDbdqfvAA9qkKnK4DZDUT1BGPNCPYEDq2NMg1ZbP1GKp7ligM
 OgySrnLyi86D16ijbMGz+k2XtgudDGhwKE2UpT4KiPDESlrRJGRjXVVre7UP2NQ+dWDi
 GnfrxXV1SgcJPQaEZBC3ASgKup6XvlvlclHAzXo0qd3zRkXSplUbrpyloa+6at2xJMj3
 5LqvnxPeH3PQKdNlaAQFROVKof5W1NqxG7D2gRoi88Wf2ljShcQfihXHhJsem5iK6sOE
 DcOYYtZY4A+i7/7JsXCNyqyu+37K0rDTWOBC425OsYJM70/G8YNLrVlnrftkGIuY+gtq
 jUvg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OyK/uluj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 14:25:02 -0500, David Lechner wrote:
> clk: mediatek: mt8189: add missing qualifiers

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: mt8189: add missing qualifiers
      commit: 4a6f93a28daee8a01fc0c9f797a653e64d97c046

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

