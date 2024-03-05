Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B73C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21C5880A3;
	Tue,  5 Mar 2024 17:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJp/w8be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26A587F63; Tue,  5 Mar 2024 17:03:08 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF2288078
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68f41af71ebso52456436d6.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709654582; x=1710259382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCF+LaJPnMUKzGuhh84rfXUxLi8GvF8rp5tk3Jb7AyU=;
 b=TJp/w8beHvkAzkfymm6BjMYkakoqea/VeYYfcCKHaSL/QVN9RIECcTkc4cVaboEzn7
 kev6XtS3tXDccvV0ynOkp5NmjjuM4g7l/+3rYgVmPdGGxy5usrruggOlrPQTGABz9PNU
 8+4CfwachAf5PO5+TaZsftfUx0iA1KiJANsXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654582; x=1710259382;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCF+LaJPnMUKzGuhh84rfXUxLi8GvF8rp5tk3Jb7AyU=;
 b=kT19TTKK7oDB0wfszguP7dQj1blkpTHSZlt2OT4ZmH0iNM2clkVHsn6NkoRkxXET+N
 W3M5k5EUJBy0HgcVIVq3gUt9GycO5V7DWKVVsuKuiNmbwm5q8UIkJEVgfLQvl0t4ByAs
 ewCL48UhcwSlqffy0KItLgThD/CepivRyIpkhH9EIrRMs5BryDKnKsxjYDkMiBGof56y
 z66EG/45Vl344EbPyBW49bbcCkUoDzdfWySAsF2JiCWEQcdLh7Epxw07jKJso2Rj4K6D
 X/CzEQ0JYyxwZwzObu9Uy+/mOiO0Cyav3XIte5RT0lMbrD9nGBdC3y1Gf4pncLeYxIej
 EtvQ==
X-Gm-Message-State: AOJu0Yx8hKqXGTL4cPsYEcUlF2OLd9xYsg4H6SlicBoKJtEwhidvnHMe
 rLnu5E5v7KbCHDdyEx6PxpzfuEfq5UxEKK26+vRT85TU17gxSRO21tltszeqIyQR15NSkFcbsO3
 T
X-Google-Smtp-Source: AGHT+IGmkcLej2p3SR57trVEvSi5DHFau/PPw4R90BJLkUg9ezeXIbV239UjPPRGkcWW1MDPR6mMrg==
X-Received: by 2002:a05:6214:162:b0:690:7261:29bf with SMTP id
 y2-20020a056214016200b00690726129bfmr2314315qvs.8.1709654581918; 
 Tue, 05 Mar 2024 08:03:01 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm6382512qvb.88.2024.03.05.08.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:03:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240224001702.2283727-1-j-humphreys@ti.com>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
Subject: Re: [PATCH v2 0/2] enable OSPI support on AM64x
Message-Id: <170965458121.2808800.3531640899315541635.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 11:03:01 -0500
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

On Fri, 23 Feb 2024 18:17:00 -0600, Jonathan Humphreys wrote:

> This series enables OSPI support for AM64x by setting the proper configs, and DT
> entries for SPL.
> 
> fixes: fa09b12dc5f6 ("arm: ti: k3: Resync dts files and bindings with Linux Kernel v5.14")
> 
> Changes from v1:
> - removed the OSPI phy pattern partition, as it wasn't used
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


