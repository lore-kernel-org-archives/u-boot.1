Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DFFC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AD887AF9;
	Fri, 15 Dec 2023 19:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U7uiNXfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7512687C44; Fri, 15 Dec 2023 19:33:02 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C5C87949
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4261450a7a4so4068921cf.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702665179; x=1703269979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/vj81QJFtWqu1+xvkjfAnxhNDHPkQJ4aYbrSafNkbQ=;
 b=U7uiNXfnVfBObHjvu4U8QSMuGL7N2Ewa+Kumbx1EyD/ehDtA+SYfxqC8x2VGbkFCAq
 S6UilA59pQQl50FmQWGOeQFkMHeJ7jYvCqlhnLtgWisp0BVEWEVBhzuWH6QPnkOYC5n5
 rrBtfW2Eh2wCgKj2idaQb5PnpGZ0RzxsF7XrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665179; x=1703269979;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/vj81QJFtWqu1+xvkjfAnxhNDHPkQJ4aYbrSafNkbQ=;
 b=mAyw6tkoIAVfbP+E97lB3U+S6ZkuI7ol/rujM5J4U43hWkhh0V9KHXhBPVOURyNY80
 KMXZDm8g12fgD26ztTlwLvEz0vPA4ICXV7H2T2QiyssKlpRvN1dP8Gs2jyDc2RZ0ah6y
 4ywp0rqQJWuzY1YvgIf86vRTOJSm6wwlFG4GrCI/ca+ul9drmBx5QYOVCs6jv3lenk99
 +VEUzUo9KH6cUTYtQf5iPQcFhnrNDhKnq2AkncXIUcNh9/LudaHs55bP2aPtzDcdvAZb
 0/OOP7gdeN///cxrTXspK/aXKj+OPglIob0qKdtNqxLYXaysLnyTJAlzICgwIMD4NiRm
 gocg==
X-Gm-Message-State: AOJu0Yx7aad0hhNbo/DcnCs+ASu3XcXFB3gR0nBsEwyUlj6Mut8Fpxth
 P7kYN+1VLK78a2QdD3enLuNJKA==
X-Google-Smtp-Source: AGHT+IGqof85Tcr74YY5Q4tFFIAGvZbGDVKXYaffNMCyPLphkDNVaHrQ/TnecPnCMEfucPMbxB1sdQ==
X-Received: by 2002:ac8:5dc7:0:b0:425:4043:96f2 with SMTP id
 e7-20020ac85dc7000000b00425404396f2mr16558740qtx.127.1702665179050; 
 Fri, 15 Dec 2023 10:32:59 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 h20-20020ac846d4000000b00423a3f5ea75sm6834129qto.21.2023.12.15.10.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 10:32:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231119144338.630138-1-sjg@chromium.org>
References: <20231119144338.630138-1-sjg@chromium.org>
Subject: Re: [PATCH v3 0/4] bootm: Handle compressed arm64 images with
 bootm
Message-Id: <170266517802.3909914.10736740943321629157.b4-ty@konsulko.com>
Date: Fri, 15 Dec 2023 13:32:58 -0500
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

On Sun, 19 Nov 2023 07:43:30 -0700, Simon Glass wrote:

> This little series corrects a problem I noticed with arm64 images,
> where the kernel is not recognised if compression is used:
> 
>    U-Boot> tftp image.fit
>    Using ethernet@7d580000 device
>    TFTP from server 192.168.4.7; our IP address is 192.168.4.147
>    Filename 'image.fit'.
>    Load address: 0x1000000
>    Loading: ##################################################  23 MiB
>    	 20.5 MiB/s
>    done
>    Bytes transferred = 24118272 (1700400 hex)
>    U-Boot> bootm
>    ## Loading kernel from FIT Image at 01000000 ...
>       Using 'conf-768' configuration
>       Trying 'kernel' kernel subimage
>         Description:  Linux
>         Type:         Kernel Image (no loading done)
>         Compression:  gzip compressed
>         Data Start:   0x01000120
>         Data Size:    13662338 Bytes = 13 MiB
>       Verifying Hash Integrity ... OK
>    Bad Linux ARM64 Image magic!
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


