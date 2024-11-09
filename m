Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59316D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C8789313;
	Sat,  9 Nov 2024 21:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AmDISvyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5B08931E; Sat,  9 Nov 2024 21:29:45 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7860589313
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso40204005e9.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731184183; x=1731788983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/DnZNNI5FOZMQJiTuNucJaB0ltRC5SFgEU9n6M+jqOw=;
 b=AmDISvyWyGCvRQPayzidl9ppvrbuliIvr1/GfnASwhgG22YXPCAe67ceBySczsz6oK
 nLFILG1dlS1/BZsNKswe9iG9DwEdECQNZKdb7MNIwm88i7wLTWe9oS1F+oLXtTQ3FqBK
 KJcljrQ2xsfBBYklXU1eAics+vDZVqOm0Yb0fp6RaYQSkm5oHTmw6PJjMO1VJxjDWNK9
 80lRAnPSZWa50XVDm4Zyhw+1FjeetJ1ZXaEy0PTtAabgMJGLNatDepw+bjodIjx7W0w8
 JBDLw30F5XgaLK4MbYPbGifmDTguy7HNAkAefhP+Q7pasrtha6iiqfIhhIiG3nSSRqSA
 6pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731184183; x=1731788983;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DnZNNI5FOZMQJiTuNucJaB0ltRC5SFgEU9n6M+jqOw=;
 b=vGlyY6WUaPzbiJyd+m4NxhnMzpFTPKBmWiqUt4XvrUAbbRFEL0a9nk1n06AgLrCD+t
 P1/FJyVqzNRRY3DRcFd+2pilQCyGfC685mc92LUQQgNmaKk7z+I9mwClRlw2Hb3q9YoF
 J9z0slOuDegKhi0ho43Jil4ABV9y5uQcRsGt9R/dEX44esDTyCSAOVGE0S46Fq9V8TjM
 zqMArWwWppRDHBBgW7NB1ZmBwe9dTgHg3r4hJlyy8/lJuZ0Is6gGuJdYXPb5JH+KRO6r
 S+TRzMTmPDwdN/QG194CgOyfBmc6i7k+kbMvANxz+WdHA8Wkxxp+VsvWuNZpt/HTTyS6
 MFcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbr/j16bv4jfD8VFagbe4dQF4QkyInRxkw5xAPG09EqunCRGlG7r6blhGN44bkwKckQuwjge4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx668Ag/xz5OCrKsGXnJcAgQNXE6SmE/VZ23//yEoNl0X2VJqWl
 cDqtm0B3/RQ2pTLnMOoTm9+GpIv5/WJ2PXC+yZXogWGDj9AaPlZp
X-Google-Smtp-Source: AGHT+IHWFjVvtGjRTy44343LMAq5/AihV31L3LrA59H1wbEYPwENWXN5Ijp0daPdI3A2qszbgT9TYw==
X-Received: by 2002:a05:600c:4683:b0:42a:a6b8:f09f with SMTP id
 5b1f17b1804b1-432b7518d0bmr75488985e9.23.1731184182773; 
 Sat, 09 Nov 2024 12:29:42 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa737c86sm161055095e9.38.2024.11.09.12.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:29:42 -0800 (PST)
Message-ID: <672fc636.050a0220.394112.d327@mx.google.com>
X-Google-Original-Message-ID: <Zy_GMoFBZ1cwlmQf@Ansuel-XPS.>
Date: Sat, 9 Nov 2024 21:29:38 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/8] led: update LED boot/activity to new property
 implementation
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
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

On Sat, Nov 09, 2024 at 07:00:25PM +0100, Christian Marangi wrote:
> This series is split in 2 part.
> 
> While adapting the LED boot and activity code to the new property
> accepted by Rob in dt-schema repository, a big BUG was discovered.
> 
> The reason wasn't clear at start and took me some days to figure it
> out.
> 
> This was triggered by adding a new phandle in the test.dts to
> introduce test for the new OPs.
> 
> This single addition caused the sandbox CI test to fail in the
> dm_test_ofnode_phandle_ot test.
> 
> This doesn't make sense as reverting the change made the CI test
> to correctly finish. Also moving the uboot node down
> after the first phandle (in test.dts the gpio one) also made
> the CI test to correctly finish.
> 
> A little bit of searching and debugging made me realize the
> parse phandle OPs didn't support other.dts at all and they
> were still referencing phandle index from test.dts.
> (more info in the related commit)
> 
> In short the test was broken all along and was working by
> pure luck. The first 4 patch address and fix the problem for good.
> 
> The other 4 patch expand and address the property change for
> LED boot/activity.
> 
> Posting in a single series as changes are trivial and just
> to speedup review process. (and also because the second
> part depends on the first)
>

For everyone checking this, tomorrow I will push v2 of this series since
CI catched additional BUGs for flat tree scenario. (I didn't test this
with sandbox)

I also handle this and everything should be ok.

-- 
	Ansuel
