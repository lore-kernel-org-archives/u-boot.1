Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB7C54E41
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEB0A87C9E;
	Sat, 24 Feb 2024 23:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JWDB1keY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE6FC87A00; Sat, 24 Feb 2024 23:11:28 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0763587A00
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so835653a12.0
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812681; x=1709417481; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKjkcN0eSyn7Q8NO5glNCjXGGt7O8+fCLvf/WZKN2co=;
 b=JWDB1keY9oIpdZTOApqoQ9TcPSAkGb1zdfj+QIlZ1fCV/+LsDHhMMzcbzCfVVoeTEo
 TxPeQkWCbZBSsIU8FB/AeDu6mATAJlY5r77Pdu/It4k5S6TixlPMKvmXcwyCm+5I3fJf
 sm+OYB2Fo1djCmjyOpHMVGPMRCJ29p6p68fZJhotuyp+1AdHgFnjSlD+WL5UHPDUb6uX
 4rPubLspB+4thrbV/YGZKqQmD3OmbPjw4BYaXJhEUHpPhJ2ji8m+Pjj6wPhIehcH/jMW
 N2PxXEIZDzt+wLz2hrcNcxVJrYCaGLuI0Og7CO6Mz+su7kGRh/5LUw1hq0Q6rCwrMdzl
 0HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812681; x=1709417481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKjkcN0eSyn7Q8NO5glNCjXGGt7O8+fCLvf/WZKN2co=;
 b=cqD6s1Sk+DiAnSoS5NgT0zdDC7o0edHJ50SQJt1124zxuUuQh4tWpT356ricM5STDW
 x3f7rUw8lguUd4+SLl7dWDY5IapkmKqZkcFGU/KyC9aTp8RQu35ClrMSlUwblwF/578a
 h9FTLXIgU+Xk9LjqVzUTHaccYHjVNBMVsYfazFlPeJs3YhRC+FQopbr/plBd4wFQkHgd
 TkLnI6fJ4rjwW/+OYY9NcrOaFZP4kM1vnD5efhXWVam1VGjvQGC4192NtS8s541tv5tE
 eCJ3/jmQz5p7QSyh68zJoxq4/Ms5HelxcV9w+yd9CwHRu4wvIHTJpq6+IwM/2s/QCDog
 Yk0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0BSbF5ncpfx2BMpBKEXTut7LHvjQGsw/134i+KqvzeSX9aT4zNIZWr98sOYPHuHElee60YXXlxFOVXC24izkuEniRQ==
X-Gm-Message-State: AOJu0YzpUbeXZl+ZhddpXbBFLfm4XL1+4vHXvQn9W64GIvnBlqk7zy+G
 B2ctceAthIfKZD7ru1cl/VQD1sl4ctvAwM/3gRe53O/t08xcbOTWhMKE6r9mQ7T1BVBA0QR1F5P
 CvEb294uiZ5iiHUBi9W6beuu5afA=
X-Google-Smtp-Source: AGHT+IEAGqH8/ueXCn7WyFv+30LpJRlqwDp9D22Z8QMimg/MJNUd0HmYBpmPCqUdRCOkCAYp5MS2tJRJNvEaCYpkNG4=
X-Received: by 2002:a17:90a:4902:b0:299:4a1:ca9a with SMTP id
 c2-20020a17090a490200b0029904a1ca9amr2593236pjh.0.1708812681083; Sat, 24 Feb
 2024 14:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20240220090102.32932-1-frieder@fris.de>
In-Reply-To: <20240220090102.32932-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:11:09 -0300
Message-ID: <CAOMZO5DiWtEayWuRCvmzcC31gf6gE7Hex3GCh0O9-=cL_uF-Fw@mail.gmail.com>
Subject: Re: [PATCH] board: imx6dl-sielaff: spl.c: Remove multiline string
To: Frieder Schrempf <frieder@fris.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>, 
 Stefano Babic <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 20, 2024 at 6:01=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Remove the malformed multiline string and fix the checkpatch warning.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.
