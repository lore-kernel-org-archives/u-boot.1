Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEEBC5ACB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECC08717E;
	Tue, 21 Nov 2023 09:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xP+RcGId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A40886FB5; Tue, 21 Nov 2023 09:18:55 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3A18717E
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso3385438f8f.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700554733; x=1701159533;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zdLAqaxif/qg3VdL46vgXebhGW69ixZFheF7QhnevqQ=;
 b=xP+RcGIdHXIsWlHd1uV3bOEwv751lO/ONiDrKGyoWeNCDZ9hBpa7VvT5IhXtU84s3e
 v4yZo0qQqnlqO0K3M/qEjUQswQf0zEoeq1WjQ+smnV/iN0kBNVR4ErbfCHv2wX81HdVK
 0Vn5jjyqp76B9ZyeaJSl7wrVLFHEqKh/8YwX/cw2IQcIforoTKmDLQV/bCqjALDG/KPt
 O/OEqti32FBi4pcEOKXR4giiN+ymGgplk9dkFBX4bWkd+Oki1i85Wke3uQY2vM4519JN
 gbDV2ptVUTUJUKNOB/ritrg4dDX2kyeguUs2o09KPpdkR7gcyR4kco/RhWwlqlw+g9q5
 qa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700554733; x=1701159533;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zdLAqaxif/qg3VdL46vgXebhGW69ixZFheF7QhnevqQ=;
 b=bBs2njDXD578a6wDGZBLEw6vFSUiz5ralG6FNEVk+UWPvPe9TT1QQi8OBZ2KgsIS76
 h4FtO5zerbixrt7hXvPpYrbSVtPxmtaWvyG+4foreDnrzNhv+Iviha0KTF80lEyGqHvL
 AD3NsL6DtbkaN5MEXlZpfAElC+aQa8HMUFPYYbBIAPFqJI2P4cVX7SHXlcouAUDoMhnR
 Z5GKZPItLxy3U85T2N+PbkZmtZ4n+lHGvAoSrFoIQVk/ZsrIbHh3XGV2vL+IpdPf5BZn
 yrAji3y/wyCjOCaC5CuWdCq6Sh7GEly9ou+aEQ1kS6bpPZaM0+Ue+f2zgBeTlhRV2NWE
 mtdQ==
X-Gm-Message-State: AOJu0YxMCdpZS4spzhuRAh+DczisQTpaEGmVS8giAFpSgLTeyxnRHldj
 Go7ViF7pMGBmb4VyrzWPukL2ZA==
X-Google-Smtp-Source: AGHT+IEKzRIiIlgZGFmLKB/8LmcgcZ/CFJW5NahKhL5AX68KoV9twzfVy7ekwc9SoZPhMlWaOHoaXg==
X-Received: by 2002:a5d:64ec:0:b0:332:c9e7:3d1a with SMTP id
 g12-20020a5d64ec000000b00332c9e73d1amr3257541wri.62.1700554732674; 
 Tue, 21 Nov 2023 00:18:52 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 co8-20020a0560000a0800b00332c32d7ab2sm7861986wrb.88.2023.11.21.00.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 00:18:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Simon Holesch <simon@holesch.de>, Lukasz
 Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] usb: fastboot: Add missing newline in pr_err
In-Reply-To: <85d597ef-1671-4c0a-84ec-0e4bdd678c62@denx.de>
References: <20231120002024.32865-1-simon@holesch.de>
 <20231120002024.32865-2-simon@holesch.de>
 <85d597ef-1671-4c0a-84ec-0e4bdd678c62@denx.de>
Date: Tue, 21 Nov 2023 09:18:51 +0100
Message-ID: <87a5r7msd0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

On lun., nov. 20, 2023 at 03:07, Marek Vasut <marex@denx.de> wrote:

> On 11/20/23 01:08, Simon Holesch wrote:
>> Add missing newline in pr_err.
>> 
>> Signed-off-by: Simon Holesch <simon@holesch.de>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> ---
>> 
>> Changes in v2:
>> - add commit message body
>> 
>> Thanks for the review!
>
> Thanks for V2, now it's up to Mattijs to sort this out.

Thank you for helping with review.

I will apply today and send this to Tom by end of this week (if no CI errors)

Regards
Mattijs
