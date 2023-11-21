Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D341C61D93
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0058757E;
	Tue, 21 Nov 2023 12:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lOzpPw4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCBA8757E; Tue, 21 Nov 2023 12:58:09 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9C087545
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0C7173F335
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700567886;
 bh=6OgmA8e6Nj+Oc6SEy3FTJqwTWJyi5cwMnU+bfEWF99I=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=lOzpPw4frXPAyHpQNbs6Sx8z298YDwQPHjDP6nprzxfT4G7US8y+i98TjQHvJN9t3
 vHNWKVGwxe8BijgJAiRBV6qztyPm1d0lDVgq2rfakwM0uNo3sgPrtb6BwhOyhmXzs4
 Z0GfDaRI0bAHBWBRUvVxJjAYWuM3Ptd9flUQJ399LvsEHx9iWr2owq8AOOKI2wPTf7
 2UiRA98XDD3LbEqUwBD+Gd52lCCDepdNchzsuYpjVCC0w41ROYNbl5v8AoubcgKV1R
 cfiDsbg2km09RaZUDtHCjDhL5UlnMp7A4FqxVzpnZP7DbsAtmV/dAJNTKHspF1njqM
 CaHkQ8huhDQYQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32fd8da34fbso2524213f8f.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700567885; x=1701172685;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6OgmA8e6Nj+Oc6SEy3FTJqwTWJyi5cwMnU+bfEWF99I=;
 b=De30Bv34eX8P3nVgBTQRcsAFg2sIFfX333CYDdwp6BfPvNcB+V70fYUi0vqtTucZIx
 Cf5ZYdtGfofsmYV48dcBx42QQKfjnYMqL8lCFj8PaP1EBrgpCxX2uE3foTOmT5ddlKJZ
 7mhQZwra11ZewHx8rCkXZBDidJH3mOQ85QsFGA2k2zh31oEf4gDyx/iMWf+cdQqokPeh
 tzrHQx7oqH2wuYLSjXLG1tmRp3p1zrJyumvgDx/qw7SA04LrmYuWcFOF3znqJLbkPm8D
 hpKxVR3afbnF9aJRJG1xUbEiEUA9lfpvpUkU6RWy0mQHOj+got8V7H/7R4XNgM3LXDD8
 aAjw==
X-Gm-Message-State: AOJu0YzeyxPFCv/dSgAUqWO08i9aSxmaIQFECcTJAgiKrh/WDvMpB4ZG
 MftwF8nR6jyP7W1J3NE4Dx5FTbZr8jg0x+G7UM9lqqGCCTiawi2gXprxLrzfjBqwcm4hFY0ZFhr
 m0+vShliNbk+ER2gbcMa+yyQWXkN+hhc=
X-Received: by 2002:a5d:6a0f:0:b0:32d:b031:9719 with SMTP id
 m15-20020a5d6a0f000000b0032db0319719mr5272047wru.42.1700567885647; 
 Tue, 21 Nov 2023 03:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCU634mWzDuvGOQpJiEvLnK+oMWVkDfkBE2y6+Niz0sIrQzv3MZlRDLxIyup7+BnR6o1aBFw==
X-Received: by 2002:a5d:6a0f:0:b0:32d:b031:9719 with SMTP id
 m15-20020a5d6a0f000000b0032db0319719mr5272024wru.42.1700567885196; 
 Tue, 21 Nov 2023 03:58:05 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 h1-20020a05600004c100b00318147fd2d3sm14155332wri.41.2023.11.21.03.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 03:58:04 -0800 (PST)
Message-ID: <bd09ee5c-5c73-4990-8b27-bca9bbe14881@canonical.com>
Date: Tue, 21 Nov 2023 12:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [BUG] Video does not work as expected on efi-x86_app64.defconfig
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

Hello Simon,

I have built efi-x86_app64_defconfig on v2024.01-rc3.

On my laptop the video output appears twice. See
https://gist.githubusercontent.com/xypron/24ceedb749a68031790864c3a35c5f30/raw/30068496f43e5b088300748d062d0ad64674bf46/screenshot_efi-x86_app64.jpg

Are we accessing the video buffer directly instead of using the EFI API?

Best regards

Heinrich

