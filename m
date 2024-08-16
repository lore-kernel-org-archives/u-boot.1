Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B1AC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0802C88ACB;
	Fri, 16 Aug 2024 05:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UUBMJ3Ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86B788ADB; Fri, 16 Aug 2024 05:47:27 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F5188AF8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5d5bb03fe42so920717eaf.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780044; x=1724384844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezC4toIW6zji50lpy01TyTHqglYKHQQampzn1Yb9n7k=;
 b=UUBMJ3Tyy27kCWbh5I8iiZXqOSfDIskbUEbn+umFZS9jhsireS+AJvaKO0lDsK/qm7
 lxwu1sexREivP8IpCDEpTZtr7MnMU4Gvln71VgcUd3uEw1JEjdHJb0rLEMbbQDbjvHQb
 qG5CNLxIlZ+js/O/8JmNK4IXcszP31zy/qz2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780044; x=1724384844;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezC4toIW6zji50lpy01TyTHqglYKHQQampzn1Yb9n7k=;
 b=lDhbRVg412w+Yp4+dE1dkBWOgD02G1NedpgcRRhk8tv8NsEYstw+F3M/8lr9r3RZSy
 v4HLQtdmjd/BeihL6H1Tg34ycWfSsRo0NG71q+VXemflbRQNxJI0ygl7zMM1ynLwHQ49
 eOrTM7DHwrOMwu5m1dxSN/91jM0qwH5JVWTIyFwQeeAGVEmNBx3tTlkE1ec85SdjeaD3
 boTRf6QNhZ6NyrLej+VCMExNrE+NJa5KQUkGpgfD7EGxHHyJ7xZIdaNn+p6M7SMpvkDp
 7xL0/ZtlULZPeWcQPoCUthfn558VYW3JycBa7WbyusfNv30dkvTzPGkoTpKc+12tJPbq
 1KgA==
X-Gm-Message-State: AOJu0YxbWoacvls70qwl5ZVk49A3fsHhtCvSOqC6FqxTF5oGLu9Gk3yN
 Nx9KiKnyR/drdn3VLXIYpIF3DvEj1EwxmSqf5sTJsSm5T89tkjXSVoCb3zf7IqA=
X-Google-Smtp-Source: AGHT+IHW4e/q1paDBDtwcDoyIV1C6v6FoONMSjGdna8NwbhP9+cF6AUMUwThnU8GbNAj/RNl52jiiw==
X-Received: by 2002:a05:6820:62a:b0:5d8:c33:43d8 with SMTP id
 006d021491bc7-5da97d2d1a2mr2187516eaf.0.1723780044217; 
 Thu, 15 Aug 2024 20:47:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, 
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, seanga2@gmail.com, 
 upstream+uboot@sigma-star.at
In-Reply-To: <20240729213731.14993-1-richard@nod.at>
References: <20240729213731.14993-1-richard@nod.at>
Subject: Re: [PATCH v3] ext4: Improve feature checking
Message-Id: <172378004311.3540666.6105664990268658816.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 29 Jul 2024 23:37:31 +0200, Richard Weinberger wrote:

> Evaluate the filesystem incompat and ro_compat bit fields to judge
> whether the filesystem can be read or written.
> For the read side only a scary warning is shown so far.
> I'd love to abort mounting too, but I fear this will break some setups
> where the driver works by chance.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


