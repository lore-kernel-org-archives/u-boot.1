Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03ECCD18A
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D11842C3;
	Fri, 10 Oct 2025 15:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JVAvPkKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64EA843B6; Fri, 10 Oct 2025 15:47:19 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D098842C2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 689FC3F7CD
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760104037;
 bh=kWiLNACgocLZeUOAjpdazg6w9sAv7cWPLBh11p9m4JI=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=JVAvPkKhbjtsp9p5/SIewDmn7UURc5O7Hcx2hw85A7tsbX5lAORMHgW0FUuhZKDlo
 Ff5gmu+98Lh3ZJD+XlfCitgBvA5tD+XgGupEAL8VfpvLvWYJHV9EQlCwr9Y/GajMpy
 F/ijQm4LmmnbPXXpKhSgWyhZ1DEb+y6Gze5bvDTk0xF0ikTo0OxxTCuw2/FzSq27mA
 kSBS2GKI5CDRROTvLSZl+DqEZZkovGD050QFvBpfyADvDmx7+TNo/FVFuZZ8C686Xb
 XWQHjCV2+E1nJ7++ZtJnbgKNnL5kzdLu+bXaxCRpHROp3iGm5HQlhPQV32lNh7/vAC
 Tr+7Kh0gNdoajYeM81PA2YPUkXcGdxVSLkRuj8J1MlNAq7/FP5wTHydfTllgf/VzQp
 8FhjePEJ3KK6JXEvG9RBEbXXBFRox/Pnq8wLjKZYNuCsU9HLt6TyFl9sJVZvDfl+zL
 WHGVvzh1kHEDROqcoxSZr+dKPZniyrHN2xcIdM8YaCkOVy8cCufbxTRfoQDxTsjrH4
 Wd/lVsAMHTkvFuYjQZPw1pl4d7nXBC1wwceXxyLeLRKmLqrBOqNleCVSYzCtdjc6oO
 NfIob2fqyMDMuLjoPESKRGoWamjTlcoc1osDnvzd4lZMb2zHKIfy5JW6ID43OVdC2P
 aT15Or7h2nKgG/PYL/NVjU7Y=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ed9557f976so1848441f8f.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 06:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760104037; x=1760708837;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWiLNACgocLZeUOAjpdazg6w9sAv7cWPLBh11p9m4JI=;
 b=GeKeZRe60I46nkIQ2bI4K23WhKBVAfDNT4u4F7mNkDURfb5Q5gUG26zkCvhaWsDqn3
 Wx6EIvtoVAeOZhdH7FjWxNtbfAdsrUasBtRkJZ9c42AlnHINyWU4g4D19QgNXa42hGr9
 NXPC62jFITNxb3tlf57qy6TZOizXzSuAejsaDUAO94w7+L0BpHmSUZZaDFvqYmFZDndD
 COSkR6KDXbY9Plhri1eIS95/LvDrJfUivCgVaH0vU/TWUGkSBp3YVLtybYy4sZWvX6sK
 EPLu0gCW4dNlvWPuLI+xhg+oeMDJYPjAISusgNqH6tci/upiyzL5rOyPjBOUJJekCKJ1
 iA8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYoPq3Aju0S8lT3Zl0JU3BdgGGiPvOSAL2qo2wQqYx1YP1mXlyRkBlJ0bTcHEAYRjdD/WMOeI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywhmlf+vcSm+9qANXBXw/SRmjXZ8bgAvaqGDcolrrauoD8w097W
 pz0eF3C4siL4kR8lM/HUCoqEYCOo9+2r5zAyaMGnZqM6xJ6hx/2qjZoTUpGh4PQgirdanrITmvY
 2nXsjSjmdUJ1Lf4pcy3KbFaxMIjQS2YNS6EPDo1U89M+96s8P3TId+RaMpU/eY9UD+pKp9d8=
X-Gm-Gg: ASbGncsquYZvsw8m33x1iLq/JN8kW6FBQsJ/aNNclBA+45+myaE2KULcOdt+HmTkAxL
 m11SCmtHke2La1bzNWG1FLvN1C/cAfmyOFcZ3S1FG3FQRidtJlNyS6VrKMcJhfUx+pp4w/jDC6K
 VaOuF09nEGyDmmSYc9AwB4t9/Y7xI0pAnRLnvBFoqehbHbsoxJk1an+0thTBbbpdci4OGmoMzvR
 p8WiG2pSqEUIMqH1PUk2kY80jH+szKERAfEFsWOQADVQ13Hgzu760aqXMPJ+jlXgSFfj26WmBtS
 dpUzR4bVhAUyGxHNl3Y6wJ6vxeRfMjLFyu+0UbfuegiwJYik1onraAZ9/W0txlKuFHwhcE8L4z+
 sWeCfwJ3oDT01sx3w7v2pO5U4iwxSLkg=
X-Received: by 2002:a05:6000:2408:b0:414:6fe6:8fbd with SMTP id
 ffacd0b85a97d-4266e8de55dmr7517101f8f.54.1760104036922; 
 Fri, 10 Oct 2025 06:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCSvuOxxUbcx20w1eDY6NPQcpIAFJay3HpsNYaIlAP33mffq7WfK9GkmLycNxUfp6NQdj/ew==
X-Received: by 2002:a05:6000:2408:b0:414:6fe6:8fbd with SMTP id
 ffacd0b85a97d-4266e8de55dmr7517083f8f.54.1760104036555; 
 Fri, 10 Oct 2025 06:47:16 -0700 (PDT)
Received: from [192.168.103.116]
 (dynamic-046-114-109-147.46.114.pool.telefonica.de. [46.114.109.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb492e6ddsm55860055e9.0.2025.10.10.06.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 06:47:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <d407b3a6-3945-416f-95fa-160da63ca8fb@gmx.de>
Date: Fri, 10 Oct 2025 15:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFH DO NOT APPLY] test/py: Update to pytest 8.0.2
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251010134330.1094378-1-trini@konsulko.com>
 <20251010134410.1094470-1-trini@konsulko.com>
Content-Language: en-US
In-Reply-To: <20251010134410.1094470-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/10/25 15:44, Tom Rini wrote:
> This is not intended to apply directly as currently it leads to the
> sandbox.py (and sandbox build with clang) tests failing as the efi
> selftest now has 4 failures when before it had zero.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Why wouldn't we try to move to the current release 8.4.2?

For reference Ubuntu 25.10 uses 8.3.5.

Best regards

Heinrich

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   test/py/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/py/requirements.txt b/test/py/requirements.txt
> index 672a58ae3584..4eefe374435c 100644
> --- a/test/py/requirements.txt
> +++ b/test/py/requirements.txt
> @@ -1,5 +1,5 @@
>   filelock==3.0.12
>   pycryptodomex==3.21.0
> -pytest==7.4.4
> +pytest==8.0.2
>   pytest-xdist==2.5.0
>   FATtools==1.0.42

