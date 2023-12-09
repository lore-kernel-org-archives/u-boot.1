Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA7FC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 16:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702A487215;
	Sat,  9 Dec 2023 17:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pin4kVwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8719874CA; Sat,  9 Dec 2023 17:15:03 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FD38717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 17:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77f4b8bbe0eso108863285a.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702138500; x=1702743300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy7Zcu6EgPD0IhBZLiio24dx4lOfH16Q75UB8jU3DaA=;
 b=pin4kVwhcg/fTrN+bxIjlaZIt7fEdah/MJSIOUho4W0lrRM9BbzqgRlqWJLG17dxTN
 o5t4+IN15y4wfIYCwU48F4MvxoGbi3Fem4wNxc93/dumbsd8/D84bBmI22ubwiyiKfex
 cuMpv0cQ9bTsdwL6H5BGBmMoU3+mxf5oXFwIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702138500; x=1702743300;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy7Zcu6EgPD0IhBZLiio24dx4lOfH16Q75UB8jU3DaA=;
 b=Ldl1nZ4UQR21lS5ouqdTin0DmBVOium60zHGx4jprYuRDZuFVvS/9KtmXVXnITfuzN
 VfT3m19iPevRRjLwYxn1h4p6iy/lRePE9I+rQCdHVjOm9DIJARh26h1JO97JnMRua7uw
 6YYVHf0v6ptNOm5ARVfVz4hXatKdHhxdowl1vvRQls3jrfWpQnqEDYAW9x/uBWR5rFHT
 SoOTGlE30TDasMiggWVxiayfjsBi3zITdx97DO/jtNBz463DsTnsRUf4PRt4mZHhXttw
 zurmeAirFcVKqhS0uqZGBYV4sFVneocO+q07E7gbaXKxkdftevUN8YbUo/088OJ4ZLy8
 MTPA==
X-Gm-Message-State: AOJu0Yze8E7n/ctyF9i48y2YKaEUB0UVEWnm+OS7noi3EUMWiG2bLVgS
 OcsLPfGNMNWIFy+YGoWlelnaRg==
X-Google-Smtp-Source: AGHT+IEg1gMpjfpYNOPX9BQ6JVGEusq5y3QR68dOJ9slA9IYbBNMsH8drRGpEzw/AWC6+bZyl5UulA==
X-Received: by 2002:a05:620a:22c1:b0:77f:26:18fd with SMTP id
 o1-20020a05620a22c100b0077f002618fdmr2121714qki.6.1702138500348; 
 Sat, 09 Dec 2023 08:15:00 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a81b048000000b005df5d592244sm616046ywk.78.2023.12.09.08.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 08:14:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 1/9] cmd: bdinfo: Optionally use getopt and
 implement bdinfo -a
Message-Id: <170213849955.3414542.12578678737270108706.b4-ty@konsulko.com>
Date: Sat, 09 Dec 2023 11:14:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 07 Oct 2023 23:40:58 +0200, Marek Vasut wrote:

> Add optional support for getopt() and in case this is enabled via
> GETOPT configuration option, implement support for 'bdinfo -a'.
> The 'bdinfo -a' behaves exactly like bdinfo and prints 'all' the
> bdinfo information. This is implemented in preparation for other
> more fine-grained options.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


