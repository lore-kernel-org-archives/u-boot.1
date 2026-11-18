Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A5606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kfYE72Mk;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=idZ++13Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B6CF4060A;
	Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFvaonFpII2n; Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 048CD40761
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795037019;
	b=DYXjVpi+F6CN7p74koNxN75kkrycHJXg1fNlwSruQ8WNE0yy/Bt8bgCkQ5bp76uV2hTS
	 IjiA+u2iWxjmOVhXVKhGucRAmVQRmn83mO/U+c7WAeIRtbXdV6+i+cVeXtOZWO+YXu7NC
	 taCidn5zbC8RWqlJ3Kec5YNvTI4ZgwpeiyNR5/fjS/Bmpe42ZeoN7qNFAHV8swNYkj6ka
	 J92cjCq9Ghx4OdfoBqfj0dnxaCvPrzh2VDpjVECgMaMC3ZNIPK82XMwj5xkm/DunEgxIF
	 4fLAamET8e9eGqrdOQJHgvqlr0MgdWZPoOMQ0tNors4uTLmyOaxieIzZDFw8XuvnnaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795037019;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EOq1mMyVsLzrLQZplN3v4Sgf3vfPsvMxcfUTtD37utQ=;
	b=oZfFlUkMWprbnxGFIq52aC/BIvnzFze3iqJNmmB3ATl2nWsWZ/HaB/tv+h50Urx28S06
	 6fiLYnYyUW6TBaddwIBIgiiNXlSuyjyuFFjNRlCJ/d1HVuh/eJdB5S1WWGfLitvh0fQBZ
	 kpDXD/t7JvN0F7dEzo1rLENzxaPV1+SUSKNM0KCLM3k62xhpGVKWjJiF2EazlyNHqJQlF
	 hJdLtuUS5CI79REvgF/gibOwST8FyJ6UMt/dEGAsh19AwX/oRZhRt+Fti69CueHzvAOtH
	 voesSkP7bp5oq2RwX5MZ1GUbtSNPKV+ywKuGY0tiV0IJabAROEFtg8zVNh+U8tCYJeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=idZ++13Z;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795037019;
	bh=EOq1mMyVsLzrLQZplN3v4Sgf3vfPsvMxcfUTtD37utQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfYE72MkYz8jAttGIgHGihkYMt4A6ZFX/TubBEWgFYzpx/m0EsjJ61UpC56T+rIHD
	 0uwbL42eTZNfIN9ZbxXY7BDNdbugC+EobFPDdveiXkT8RueYm3ar19fOts3kFrItlG
	 cM05DCy4xEa/ZgZF4OnMaF7mZ/FFkjDbIFD+bcJ35XAuLbXvM2+HV9dacYs2YvOFZf
	 LOXRkIbpF6SAZ0CzKag3YfdsRVwrDcncU81XxsjDvVuwvQlf6YPrQkqSVJ77DXKHZV
	 y5CLwmQV7LTwMZXR+sN1HmhAmc67Aqeuri7y61LZJZelkexzcaIfSktKuCkZQklkwJ
	 kn+Ze+KIfYH0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 048CD40761;
	Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FDAF61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D45440761
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ta2N43eptAlh for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C35E74060A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=idZ++13Z
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C35E74060A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:35 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so1233261f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795037014; x=1795641814;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EOq1mMyVsLzrLQZplN3v4Sgf3vfPsvMxcfUTtD37utQ=;
 b=idZ++13ZMrCPnNyio05CMI/NfY39kCCu7OuKCIN2ozDl/tPJMzsvmoI3S08WANXSAS
 o0ENKA/sfSp+bADpXqAaJ0+bTQn4Z1nCJmw/4WnRctzl8N9iskUmT3vLxTHaUAAZfo55
 T8Jnjbsoz6L5Io8nqzcVlxOk0F1l2lJKmC04fka8oc32RevuPiXW97GKiG258W8Lkr2B
 5gf+Uk29l3KEFLGCtTgIqJPaEzUXikluMgHCg8iLtVLF8G2NGT3WR7zFQDAD/WwODrWo
 IEpcyn29UYaN/fb82wj6H7l4/DD7HdsQ0K/8o+m/qrLHQJLRd3jXWy7YT9bEnW5JLE5p
 3/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037014; x=1795641814;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOq1mMyVsLzrLQZplN3v4Sgf3vfPsvMxcfUTtD37utQ=;
 b=rmOKtbr6gTYx/ntwFos9diQq3nV0hy+e3pOc9wogSi2Mzztb4M03jwEElsalCTCwIj
 0/zgAGd3mUpM07iHigA5OMSxML5l5LNOoFhMzBiUxqCsd+daCR1fRvsmt4cXEXFElTT9
 PHtkOxZ0Hl17fa+du6T8W4jwLCHGTrTbQZFOiLlFxXjQxTkja0YSb8BS8/5ApdmZUXvY
 63G7yHz1YBfb1thiPrtDhTaWsSw+Lf0WAzolq+V/bhnoHU7FsBH9fqScg+N7VJbDYgM2
 TXbJs+GvwoWH4wYCR4dmY15EGqgrCAfrxPGrF/EbCWQ1HmMEfg5KrKtdzNs2FWPdCDsN
 f8gw==
X-Forwarded-Encrypted: i=1;
 AL+hErFXmq09muOqFXdneO4cGaD+R3k5fBD+0WocSUDrrV4CJX/Iwx0qCwcu46YoI2W3eJeinxlL7/U=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+jy25z0Hz77n332adBYqONBTCNA1n++4kFMOJZqoKeVz71zZlV
 366iWmOhuLoEl84smgB7c0BmBe9LIYwphMdTG7wV+ajx+mP81ndM5yvPHJPjmQmcKI8=
X-Gm-Gg: AZFdTZfjgIOQGQyl099JOdW0QShxPaIuWBEdwFRkhu5bhxsZV3trvtib8QyShcgciBC
 q1ZXVWuklatR6KObImJeAltlQ41wdViirR8voFB1Tgo137WIGqpsYL7QKr+51VhBT6kVyuH79ic
 usUFz/SfzkfRY8Gr2iFIATJzZdA7fY77jxu3xOd9ZM9EQrrKzKrdWBYlRJYnkaPm6DsXrcSInZC
 ktoxkRpIcVyEVq06u/2X0lL0QT9uOaI5Lt2fbPCZ+9DMbu1KxVx4eF2oGEJngnNmGnwROcmFvpq
 pq77UGrTP8YhHKryE1iJZ65eC1Klw8kOUqXtc9Z8S7vrkeL0yD+ZyX19op9bFqyT3VCp7jY+yYW
 edXmnF7Atdxu/zb5DvSC2GflKNUvgyQ10QJDU7a2VCx7JoNAQJPS1fECGvpX/ZR8eUiFIXoAVZD
 rRetn09hhZDlr7yiQtQrek36apWcxPuxKyfIh0Fy95YlSoaPK9zxCjzRlv/vi3hy6wbxsp/nu4p
 Vy9ldhIOrEuEytfGlr0EJCzJqEEY0zpokaiteFD22lsnCIr8BvCodxu6XFAJaDaDCIAEnX6ofiJ
 K9sAexUNRLUWnP7V6OdLYb+0JLfTv7jt8qq+p9RXo6GfT1FeziPZwOMY6lhAUJ58LlZoES5m
X-Received: by 2002:a5d:6f12:0:b0:4a9:1b17:4f34 with SMTP id
 ffacd0b85a97d-4a91b17502cmr957468f8f.50.1795037014196; 
 Wed, 18 Nov 2026 13:23:34 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm7383280f8f.9.2026.11.18.13.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:23:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] bootstd: android: rollback indexes and misc system
 space messages
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
Date: Wed, 18 Nov 2026 22:23:30 +0100
Message-Id: <179503701089.2286122.17200461178451456474.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795037013; l=342;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=odD61aW6JTstB5QDGRaIOKKbBZfaH+LnKaaHYaSHVJs=;
 b=of88xuo5LJH/Nr1RtBOqH/lBKQ8tSRMtfNlcyl1TcZTfruZKFoOzNE3tHl0g4iIxqDgXY+XNM
 xUiSetQEJosBkvrbaohlC+SrKabr/xN0aNYLESzN7cM+1NjbnywHZ9q
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 10:13:31 +0100, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

Hi Igor,


Thanks for your patch,
i don't see patch on test , it's not possible to test in sandbox what
you add ?

btw you send this serie with your gmail email not qcom email.

Regards
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
