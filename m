Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4B2C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1598588A76;
	Tue, 27 Aug 2024 20:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uuEH1Z/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343F488AA4; Tue, 27 Aug 2024 20:35:49 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D28889CA
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so33205411cf.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783746; x=1725388546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ke9W5J5XOXNdIoWCAKyD0ePdBJsRut37WRDuTwQCAT8=;
 b=uuEH1Z/XnVN3scswiO254EwuFjdqxWDeN7gz9zN5kirzzwxr/UkhLkcS/9hkXbryd8
 t1oPy8bMHWDKGxOIOOlkEl9MZooPv9x86wFHIa0CeixPGxJeITjA1NdArncg8iSpXZ/t
 U5vFmQ7J1tp5akqeK/cuI7t61CKXVMx2N1c1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783746; x=1725388546;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ke9W5J5XOXNdIoWCAKyD0ePdBJsRut37WRDuTwQCAT8=;
 b=siDiwhCMsLT00JdV7skM/r1JvELHOjxzrLQRWUEmSBfLaYntHm6uKuE+w3o9Cy8kpD
 hrGSF4Qor8UpnBoezEJyDiiamaZ2XF1BFbGQvOOfAbPOyWAczZj5hrnQi9GRSyQKR/cS
 IN288Rpj3IBY4Je6abn7CdTgIkw7Nl7JeDh3E9dsy8gILjDTz68i74jSixKsnz+yTvGY
 chBn+82ZSuNJzuA5+mNLh0NYElrQKlQisXAElePc1PjcRAqBrsxGah7UdoncHnZgDsAi
 yy2JuZe/l0zZSOesL57XA+B6S2ULQUFF4YZGE7d4xD8DjHhb44BNEZpE2dW3RUr6Yu5a
 K+5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUec1XP2YCNnpKyygIrmuN46DGf9HhhwgFOQ/+Aa2DiyGqS7l96l5FreO4p/84JHYE6LukRuhk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxewxk7aAcrR/uZIEsISqjGWYEbxk/aBoXvSZ5BgqshMW4W7o2O
 Magj1qYQcHpEfTMMfhkyppVCsVaqfqAocmXVtwV2EWzT36xGbXMLu+oPeftrxus=
X-Google-Smtp-Source: AGHT+IH54x53HzjD5sTLZh6B/HzS9tTPYEC4J9FyEib2UycEL8QVSDjmut5ytOZpjI4MpumfDuJnBA==
X-Received: by 2002:a05:622a:8119:b0:456:61f0:830d with SMTP id
 d75a77b69052e-45661f0835dmr28726051cf.9.1724783745810; 
 Tue, 27 Aug 2024 11:35:45 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
Message-Id: <172478374474.2927671.4677105894012380040.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:44 -0600
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

On Wed, 14 Aug 2024 09:10:37 +0200, Heinrich Schuchardt wrote:

> A system may have multiple SATA controller. Removing the controller with
> the lowest sequence number before probing all SATA controllers makes no
> sense.
> 
> In sata_rescan we remove all block devices which are children of SATA
> controllers. We also have to remove the bootdev devices as they will be
> created when scanning for block devices.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


