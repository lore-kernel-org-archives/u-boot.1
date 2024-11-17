Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B807D10F22
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 16:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5B48904E;
	Sun, 17 Nov 2024 17:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b9ml5Jls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F794893A0; Sun, 17 Nov 2024 17:46:43 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E017788FDE
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 17:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b148919e82so193078985a.0
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731862000; x=1732466800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roSRPcOoG7evGCshvTgBRHBP1kVhO9hK6jaKQvXlLfI=;
 b=b9ml5JlsgM7FWtnRGZvDjkhknDOal05A6+XnrEZcDl8L11tqYS/GZnboGbphlTSUx7
 jOL92FVqUvgAmAXVTjxDeuLoiT91kCQAtIpcKdb9CAay94RiUwVPrvBThv1hOIolTHO1
 z+5FHYrwbNVrrIJbL+YOqwRQCSlGw7wsRsgXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731862000; x=1732466800;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roSRPcOoG7evGCshvTgBRHBP1kVhO9hK6jaKQvXlLfI=;
 b=RuBKjX45JCST+s8GOlQw3OY0kSwCuhM0VBAjm6VNlDOdShp9ZMY+lXMfIViooxPw1a
 Q2kuEMWDModdaCvNwPAqETocbzWUJ8usuU3VTZocLug0MYFSnPy6Be4ZjrjUlA4N0ROA
 b8IPUePJwc66xn4dZPzXayneNTlQTQQdY6/40lyelNuE85eTzRjQPV+oFnAflEvXH38n
 1PPq8q4LEoqv35yD9YkOgWa22KZPUN7tbAUaDNd9VaJoKE7OgxdWFgLwQQcjQvq7jkur
 ZjDWx2RAmzcml0QdEXk93intCF3UkVdryFXN0Cv4B8+2xpTnMOCDy6wThX706D6Om2hU
 JaSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8dJcmQnChZZpEO5UTK8d8PPbUe1mutyDwnUDGw+32tPpt+pdYvp5GUGlUwOuBefsDM5scjgE=@lists.denx.de
X-Gm-Message-State: AOJu0YyBY1qHmInad6aEJFCEW1UJunMLTxxByqC/BlXp42fkMzkmh6E7
 q03a1b/KaYnd9nCOmANbN18fSgxxc1MEPBebKfoeNWQJGWlkexDmwM5SxYC4Ojfl8QQVcq4U2oo
 m/CY=
X-Google-Smtp-Source: AGHT+IHkkWFqBxFa10y8dS0x006On8N358s5nj7IjGzOHY6sYQ2D72b8XDDbNNSRj15wUT94VnZJRg==
X-Received: by 2002:a05:620a:471e:b0:7b3:51a5:556 with SMTP id
 af79cd13be357-7b3622bcd1fmr1362684985a.22.1731861999883; 
 Sun, 17 Nov 2024 08:46:39 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca4dcdcsm375768885a.102.2024.11.17.08.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 08:46:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240714194948.1271135-1-caleb.connolly@linaro.org>
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] dm: button: support remapping phone keys
Message-Id: <173186199731.3244505.9675137628346602283.b4-ty@konsulko.com>
Date: Sun, 17 Nov 2024 10:46:37 -0600
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

On Sun, 14 Jul 2024 21:49:19 +0200, Caleb Connolly wrote:

> We don't have audio support in U-Boot, but we do have boot menus. Add an
> option to re-map the volume and power buttons to up/down/enter so that
> in situations where these are the only available buttons (such as on
> mobile phones) it's still possible to navigate menus built in U-Boot or
> an external EFI app like GRUB or systemd-boot.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


