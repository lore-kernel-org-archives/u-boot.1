Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE73E63CA4
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 19:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEA083D0B;
	Sun, 25 Jan 2026 20:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HALBu51N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C9883D0F; Sun, 25 Jan 2026 20:43:52 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B39983CF3
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 20:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-662b5db048cso1079922eaf.0
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769370229; x=1769975029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ0wop+kimrH2xhAbabXl+YFgAf++a4rsWAXfrA8ulw=;
 b=HALBu51NIhl7Wgen5cg5ZL6fm7hAKEqxInlnhVdwft6ng6xNVgsNzhik2nABm8NhLN
 Mo9MhOH5pbvFJbs6zPD5St++xiWyuFF2CHndnQSLoGwR26QhX2C9V8njGurv9Vu4iJLh
 offmSda23cxAM8Y+gykxVorF0fqjxpLUhBIGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769370229; x=1769975029;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJ0wop+kimrH2xhAbabXl+YFgAf++a4rsWAXfrA8ulw=;
 b=jOvSjOMkY559IRJ3aANff9TFm2LpcN9rPvpIaFJFmYs6sgQpZaBWsbVQdEZdkUjAeA
 lA3aZNDobcv53lXqDj8zYpewWHiR0tlCJqV7H4MXo3wj6Mgva+D4TzTlD59n3OoXlrDS
 YOVwTTotXg4XzBGjk+nnYId14ohwffKi2RFI4apNObpCyam2fG5moTwFVYFQmcosRJh7
 o3VLwF8R5TW+gn/MIVB2icBvS15XnDC/pjNXpwj1TTdNOkYpPRnydscGs4w9AaNuTqGV
 8icjme2mVw6CJWCNCpNqVs1erMPzUj1itzxMukuVZD9TNIJrfSmqFdbnIet1gzKS/N5C
 Wp/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8dWB5yaLulME0FydO26/H0psuO4K1SZb2IUGIl8Me/cgPH5wcy/xdyuEorcCAChcpavhBbqk=@lists.denx.de
X-Gm-Message-State: AOJu0YzVGu9wHyj/mVQ3f4TBi8yLxOwcWQx9rKhDgdGyEJHjsn4hLcKv
 IZ1nnXK75m0u52I18splaD6rJbMpIXpBtC7UvZe9IW98hVAVewL7AK9161W75Q7VM7g=
X-Gm-Gg: AZuq6aItveWQsoI11s0NDn8hdVsKlBpgwundysbTDiBgtse6sjEzA0eW7yBAWpGQJXD
 KKNgumrgZCgfPwXWvxd8A8YkW95kM+5t3J7hHUzT6+uuDnWIB6rO7sELWyTU42LVQYYboGcgYHH
 jJrKSrbhgx/6KzdTmCOM9QuWGMeyYS8r0HhxXCXKYOhr5f+iex3I7Ssg5O5IszXp8AdMu+Igath
 3rDhYTYl40jz/ZcoEyVsoKKZ/u2VRMYsw0SmncfIa5cMP6F9aKjQ0zCsClz8FxQZdtnNF3Fxo6t
 avIYieVZ3opHRLWdj7JNxwJWcu4n/tFZ0RP76W4qvhmpbjr1bQhZTxEmoczTjoR7d/sP9ce2/2E
 ZbBjTImXYhTQm3wn1+eJ/psDNDoG1/plb51dNeDUdjgikiTH0mzBHXg1PkyvfIASqlI1rZHr4s5
 khvRc7em8jSKe+XQSLIuCPiQbIq6aDoSVJWbvVF3UVk2JXLtUxncHGUbYN+XBNDnr0TdmueG2Kh
 nJb4JmJLACAF2kDhmSA0yP27zhgE7y0/6aMHA==
X-Received: by 2002:a05:6820:460f:b0:65d:757:39f6 with SMTP id
 006d021491bc7-662e044652emr967950eaf.39.1769370228944; 
 Sun, 25 Jan 2026 11:43:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662cb4e5a33sm4100544eaf.2.2026.01.25.11.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:43:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20251120193448.310274-1-heinrich.schuchardt@canonical.com>
References: <20251120193448.310274-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 1/1] video: add DejaVu Mono font
Message-Id: <176937022760.3566385.16754859413817180399.b4-ty@konsulko.com>
Date: Sun, 25 Jan 2026 13:43:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 20 Nov 2025 20:34:48 +0100, Heinrich Schuchardt wrote:

> A TrueType font for U-Boot should fulfill the following requirements:
> 
> * mono spaced
> * support full code page 437
> * easily readable
> 
> Unfortunately none of the fonts provided with U-Boot fulfills all of these
> requirements.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] video: add DejaVu Mono font
      commit: 3a9795581eb7d2c7978802d2d91832ce00e0efe4
-- 
Tom


