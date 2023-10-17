Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99459CDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 08:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE41F86C6E;
	Tue, 17 Oct 2023 10:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=spox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=spox.org header.i=@spox.org header.b="VywRQY1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6648086C91; Tue, 17 Oct 2023 10:14:25 +0200 (CEST)
Received: from spox1.spox.org (unknown [95.143.243.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546C686C66
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 10:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=spox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=niziak@spox.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=spox.org;
 s=20180410; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EatVj/CR8GP0cCshG6rO8ZWHDKgRGf2YPxx+zvf10s0=; b=VywRQY1LQ3HXkOMVnQZ5ksyLew
 5ZpIKjFvW7kCr9q/vmcGFZzoLU/of68um4o7v8BGOh5y2kBYMyyqplJh9cAM6LjADSQE00heCiDgo
 hpqkq6nFMZgxrKYh49ueO4l1bSYXXxnwngmL8ehAnNrsXT4fg9j7gfOkAA8LBSIvH8faasTGYIwvX
 EWY9In0Wv0e/AG7/jeq0Jp2IDVr/X6okg62snhA18WBR0iytsUZcn5JY6vye36WogXwJzMb3XL5Gk
 EmcxOoNObnbBozbA8DortTc3gQwLnRJHLRl+toR41VSwFf8x12rj17Sav3rZWkWstJrmYVNdCbUnQ
 M416dvfw==;
Received: from 217.97.77.98.ipv4.supernova.orange.pl ([217.97.77.98]
 helo=[192.168.177.169])
 by spox1.spox.org (envelope-sender <niziak@spox.org>)
 with esmtpsa (Cipher
 TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) by authid <niziak>
 with plain using Exim (4.94.2) message id 1qsfDV-008dG5-AZ
 ; Tue, 17 Oct 2023 10:14:19 +0200
Message-ID: <6591c92d-6ea7-4434-89bb-d64f0ac68068@spox.org>
Date: Tue, 17 Oct 2023 10:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US
Cc: Simon Glass <sjg@chromium.org>
From: =?UTF-8?Q?Wojciech_Nizi=C5=84ski?= <niziak@spox.org>
Subject: env: Allow U-Boot scripts to be placed in a .env file
Autocrypt: addr=niziak@spox.org; keydata=
 xsDNBGBZ3RIBDACVEvW9Q8zRoellzZF1kyEsXcCMmyJaAoMJgsFhknCHKLWSqCEuKT/wecXG
 Q293v7JtQxhdG3dSJdoJFt0M8Ly7GT9ArhNWawLRhwgRLs5gmu9Z9eDvQNlMv7VLoNv1DG/V
 C5qfl/Q/c7ze07rOVlJKrm6rgzyWTNamu5X5vsau+rbcICxuFValtuSAIPQ8Ec4UhMbXaVEC
 rwmSxAQvVsg/Bppc0iiycPQMlLyF17DciiB1kRMCpt2kFG+6j/zIRxz1oojaJ6UQ7h+EeGyj
 qPfkyTGGUNYugsXlt76cd/8NDRvGRkaU4zI4C1v0Mbj0aLIxrXuZmJDYatiDgfYP5AsF55MI
 jMiG+obRbHoCxsNJ2Any+JUrMNGug/vDOK3l898fyP7SRYrMcBAUbU1aZw0h3JBKhftV4Tra
 qhgs2AUbuKbVLPm1aMoq21QrcpWShfCsGMkjYB5NvduqtN8p3OskLw9BzCivv3D+ut9Mofdq
 QpJT0ERpVpIzqPLP15vbCtUAEQEAAc0jV29qY2llY2ggTml6aW5za2kgPG5pemlha0BzcG94
 Lm9yZz7CwQ8EEwEIADkWIQSv4wnW3k48r2h7xv78AuPVNqL9rwUCYFndEgUJBaOagAIbAwUL
 CQgHAgYVCAkKCwIFFgIDAQAACgkQ/ALj1Tai/a85cgv/c1sWSQ+822hegajG8vJyysJRJu20
 MQSx5vR5SOZ/kusdoSShU1Pd6hEyxX1NJO1peJcC7tlVk9CNG5g8Fu8JdLaKlsj5WG3zVlAS
 cGqYKZefUIJPU9Ae9sz9w/YhZjl3ytEvr6cjOzRjIdr4G2REdR9UGKySfvVkg56YmrLObK18
 7cHFEd727+3DSRMzyMS7zXBkvqwLMQFxTShzTOdTjkrxXzEzmRa9oakpY1RSYR6CXoD/tqTr
 NcBuzfdSW+z9SDZAldK4fqBdr+ERbKUBzRQHcuBBq8+j5xcbcVdppbA7kARv/3arzFoHMCDh
 FYzjGmfbkCj3AcyjahDO8i00zKwGAlpAzxjLuQ9pXP9Vv4E0ivih3nBrMOkH94pC057Iy8iI
 DENGZzD23CBH+OqTtYPtwrcRklXT0HzyMyVozg98sv54RfxMHWGrMCztHOUaM8JWLYY65AGy
 HmKMtvDpyDQUSFhF9etiwu6r+Nt/Euazl6X5E+SmByfAZoXlvwSVzsDNBGBZ3RMBDACa79/U
 8GA5SsCxNvJvlWAbNkSmR9g0F3Izet6HKQeSU74BOIBA0snma46OQs0vhT6iKU+pacYfd0jN
 ZTYw3oJhx1LFRfWS7rrKAhd23ACQ7ssQGWSCIumQNO49mNqYUsqT7irk5Q1iK9Zp7yZVJ+WM
 Z9OtK9NkEnqTPkb+wGtsXpnq63J4SnNRZkOSvU2tq2P5AelfPAZBuDwzg63V6/OF4NqM2CA1
 HL1e6OPEinxqN+hUCUprxee7ZOz72NgnY1hGTJa5nCEhuvAdiuuyt1/fZytQ7df6/lIsBzTC
 vpkN/w4cpjLfGWm/v07mZbRpcEg0i+33RGF+XM5gh43wwEfo+4G20dFjm6b0knO2sFwNcwnu
 mN9hMIu89ANn/g7JBtzVQyzxc4e/6prgHTB4ezprOBMELRYYgmPit73x8/5hHhzdPPsOGNdq
 Jzq9uAljEWWx1hzkcslC3WK2Z9Guad6fFPQLwY891Jn0Y8cRiIm1fcajRT2wkDFYeLKvwe2Z
 /tkAEQEAAcLA/AQYAQgAJhYhBK/jCdbeTjyvaHvG/vwC49U2ov2vBQJgWd0UBQkFo5qAAhsM
 AAoJEPwC49U2ov2vvjgL/0E164Ldr/AIe+c9WHSPEODnWSsxfWb4/cIQj6mPoEqpmW9ySaNy
 F9NoXMatuoYacL/xK2RIv4od1M4RBsxFJdLyY9Tay86ajiuwxK9DHgwybGPc+Sk+Uwe34MOf
 RiBQBy0BDhjgAkvstoqP5QX+jU1V+FA3sLuqbR5PfOlhf1Wg1iGbaawlqisq5Qx2Dabc4mH9
 Wqa40uwHiK13tfHCjR9KOzKHBglv+ioWkBToshrvVvqsqqZvV3e7btwth9GmRUMHxswM2OXQ
 qb11pAqVqXTpvbZvSbPDGhtY996YV2dE6dMiJhhK5KEv9U3YH1u58vU9uFZbt5B4vj3tY0QQ
 MN6dIykQZzNfs+QwTNDWZQWh2flaeZvSWJBGJ83L5Tv34AClQ2F22CB9Vy83TQ3/MYdc5MIH
 JdNm+QZ6tbcNjzwGteOxHbmLZGB9ssGmuBUGNSsY8tNq36+FyIrduGgpQ+sY5xsoRjQ7jv5d
 SMCDJF2KPVOLtVRTHghwCo4d9q1MFg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello.

Very nice feature was introduced in commit:

     86b9c3e4e48ba47ef28781d06b97846aca74bc8e|
     env: Allow U-Boot scripts to be placed in a .env file

This feature works as extension for old CFG_EXTRA_ENV_SETTINGS and make 
me confused why it doesn't work for configured default env file.

Now in U-Boot config we have two features related to external 
environment file:

1st feature (introduced by mentioned commit):

     CONFIG_ENV_SOURCE_FILE "Environment file to use"

2nd feature

     CONFIG_USE_DEFAULT_ENV_FILE "Create default environment from file"

     CONFIG_DEFAULT_ENV_FILE "Path to default environment file"

In 1st feature only basename of .env file can be specified. So env file 
can be located only in board dir which is a limitation for this nice 
feature:

     "The file must be in the board directory and have a .env extension, so
     the resulting filename is typically
board/<vendor>/<board>/<CONFIG_ENV_SOURCE_FILE>.env"

In 2nd feature I can specify default env file as full path so it can be 
located everywhere - even outside U-Boot source - which is very nice 
when U-Boot is built by Buildroot. I can easily set path as system 
environment variable and it works:

     CONFIG_USE_DEFAULT_ENV_FILE=y
CONFIG_DEFAULT_ENV_FILE="$(BR2_EXTERNAL_FOO_PATH)/board/foo/u-boot.env"

Unfortunately I cannot do the same for 1st feature without patching 
U-Boot sources to put my custom env file into board dir.

I can see two way of improving features:
  1st: to extend 1st feature with ability to specify full patch to env 
file, or
  2nd one: run the same parsing mechanism also for 2nd feature (default 
env file).

BR,

Wojcech

