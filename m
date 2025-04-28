Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264CAC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF081828D0;
	Mon, 28 Apr 2025 23:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ykj46QbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06A282836; Mon, 28 Apr 2025 23:34:06 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A1C8214B
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7301c227512so3173566a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876043; x=1746480843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8ONLeqNfLSksZl2YsG1y7iOQ2mdVXHnO6Pwwdr7t2Zo=;
 b=Ykj46QbX8CNjLP3axq1dedTELCRgtWp9u3957dDfFd2ol7eN53pkhqGLWXyLkgkwTj
 S3ahh8BxcKkUDnbnot7sTIRHPaIyHb/scK9DdCNo6RGuC54gsWZ4y1vbpdwZPhnXMpk4
 jmhtdbJkaQMxvDeBpMkPXJrIslIxz0jbgn0LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876043; x=1746480843;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ONLeqNfLSksZl2YsG1y7iOQ2mdVXHnO6Pwwdr7t2Zo=;
 b=rCuOZ+FTUfWbKZPYggAd65rZSXVXbAnkYaAEd02ouMA4eyon1dMemgYVaP+fugFoa1
 pg71yfZwNwkKbBMd0yWR0GzonItdC5Y1W6Pj9p8FFf5U3TiLc6/OKmt3jY/WrZ4VYsDS
 5DIiaT4kAh4FF8eSytXVcoib7RT+kBr6sES5nAJeUZ3oFXjAmwoKnIaT/cazbfCP6oqE
 HMmqKuB5V2nfNQgrMjFon9Iwdzbmbq23m2pSRC+ij0wwn5JVIPWSxncv3xiC6aFw7t1X
 iOALVxX3NgSoSLBSoAdCB41nrmP6bUtJu7VCbclD61NfAGtNWRJO31NUdqk1eXn5GWlf
 XhaA==
X-Gm-Message-State: AOJu0Yys5Dfaa7RhLEknESYM8otdZxnP4/Gz1FzytV9+Hs9F104KuQjC
 R1D1qJNp8oHGgCvFwgZehfw8UGI0UjrVTWOY2mPUuEoNAVFJnZ5ZteOTS2QoEoy2d9SKW0t7+0d
 q
X-Gm-Gg: ASbGncuJ47EnDBt19KIYSdxWlvZzbr9kYNMN7OdOhkZNaAJnYEyD2xpMjKlrohGsmlo
 pKraSL+ugmyAj2tYW5C+x5sbBkG5WMX/1WFyjKuiOhWxLm8QV4+nMbvt2ZbQ+PIc5/V7TrnD2Ts
 JYQw1AKMAXnCOHz0dUKK0YzmULZnkqfrJy7U7VkR+uKV/x8JB2R9MOM8kcVcw9QEILFVVkgXhNN
 DlBCz/blkdss837Hn4lkHMf/o42XIB5xMl7MP7u/KhEpxcYJHyj5Q7emAsmz12ZqkxLZl7ceCrL
 FqIfe6FP57vQ39ccO+1lVIFHfMsF3enB4yxWapYereZZdLmxwD2h9AlUKhlLutKG/unyZna1Fnc
 9
X-Google-Smtp-Source: AGHT+IFVQrZhSl5X11aH70zWMDp/VAbbF1jkHVkXDKaEox8qJj/FeKec0PUd0E1VdchXJdwvlHenlw==
X-Received: by 2002:a05:6830:6406:b0:72b:9316:d596 with SMTP id
 46e09a7af769-7308a4f129amr278126a34.3.1745876043101; 
 Mon, 28 Apr 2025 14:34:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:34:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>
In-Reply-To: <20250424150820.98516-1-carlos.lopezr4096@gmail.com>
References: <20250424150820.98516-1-carlos.lopezr4096@gmail.com>
Subject: Re: [PATCH] mkimage: fix option parsing segfault
Message-Id: <174587604240.1121500.1852277722040415190.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:34:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 24 Apr 2025 17:08:19 +0200, Carlos López wrote:

> getopt_long() expects a NULL-terminated list of structures. The current
> list in mkimage does not have a zero-filled structure at the end, which
> can cause getopt_long() to walk past the end of the array when passing
> an unknown option, causing a segmentation fault.
> 
> As a reproducer, the following command causes a segmentation fault
> (tested in Debian 12):
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mkimage: fix option parsing segfault
      commit: 2c529839a93d886253c596449545f62bec21a4ac
-- 
Tom


