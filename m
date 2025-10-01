Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38200CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 10:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A839480107;
	Wed,  1 Oct 2025 12:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y1mxSGHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5774181D6A; Wed,  1 Oct 2025 12:32:51 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424CE800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 12:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so4432038f8f.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759314769; x=1759919569; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAgLrB7XaLmX+REuIux5pCJNC8bSEzO5pgafirmAvug=;
 b=y1mxSGHSI+B7PXZpKBcHoOlZXmUNE2AcsBT4Nu+yQZcEMBwaj7Osijzy5wSjbYK3jO
 DmTNtr+jupmF3I17RAqY5wT8q/PoY9I38Rg77qE9EIbj7s/rCvT79mBFx7QpU1Pr+1OR
 QmCKBirplnpn3FwsdFXw+PWhrGdy/IYy8maQ3qtCZLrl177/7LehPRmFqdMI4Ybzvavx
 p0z6GtnrA8Ja3o018ZT9cOTyNUavATgDCnzoiaYY371KgXU24qBgdPhLZ+3DOIs65gw1
 MU5fpZh4iYMpN+U+2g5hAn8hy9BvXKHGRKh+clSOA7VcDrcBvjLMjFTXXj/bVIy3NSAj
 8NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759314769; x=1759919569;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SAgLrB7XaLmX+REuIux5pCJNC8bSEzO5pgafirmAvug=;
 b=mKieJU7YQ0A3E2bpn1GEziLXou0XhFqNo4Dp0scPReVXpRuyaPT32Bp52GD9dEwSYH
 78IY85no8ml+bz0tlH1l20cTCDgYTJs/yXCy/21WmU6b8+hMmIgNuqiHgfo9OlTyKSYJ
 JxFj4qrIYceWN8kxxyrTJc18wJDvXoNEe4IV6HfEaYp9Br0hQr86Z9rGl8vLle02+XXv
 eOT1/NV6QR1HSnBiqx5sMEGljqEHXUVq0j9GaiU+OQlW/Cc/tjjKocb9vg7qE54pM75r
 EHT/IJkIvMraJsVDduwKuW6+pwUaioQW9DZzqlfWEpOsGdhrD9+sNA6Smnv8JIRchmFf
 yPew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeIH3qslo1YpdkKmkeISQY3D0M9CD4XeRlOcSE1SZVLWr5W7qgizLqyIgDOFhBYPckBeFqIdw=@lists.denx.de
X-Gm-Message-State: AOJu0YwN0LnKD/Nfc/JWW6SPGkSNjdO0QVRn4Y8VDVnpT4q8E/XIJi2N
 5oPx9aHho0kr5uJHWB92tcG17r8zquqN1myIQi9Uz84xje0cd1qVnNmWKSoCyNz6PlI=
X-Gm-Gg: ASbGncv3tqDEurAtuZKnICwMim7Mt2Yiw+jPDR3Oamf2Ou6K5aK6EPwIDuoCfrEOwqN
 4MczZ4dDLDLkpzR9JyVO5m+EhwSe7atM1pgfpHH3KBTj5CqEG7waKu+Y/MZeOBfjpHMZ8O0D1Fb
 bJzHLeUE4ln1cWlsq74Tk3PNuEGtV6Tm3xTUsoHWveQfOuBUbLyIPHkg8BEWijdMQSyfCwVLYXp
 NmzKojyPoF55VzpXWwuH5FUSdB6Kt2Qz4toiv9E8Z0++VdlT81GW4ISiBh+geTTK5NFsDJHmxXa
 cgLbDs1D7rpR9cBbtThfKbtLGA/4hqu5EWSdkWy/kMN7B7meaV20uO5UcKUg9h5QRArClPGjVFJ
 aMPRInNCzTS5SjuT5BR8O9kFJTyWXEYYdnKKXUFXl3YkF732jqf2eLFqSd/oZN0ESAYd/5YzBi6
 z4pIpTXkDbtHGGrItrtPVxmdUBcQ==
X-Google-Smtp-Source: AGHT+IGdQdpcS6Rt4bOTH98g6o5Cf9pXG1ePQdxzqPw7DWRrrMybTLcfeKqO+nVUDNA7woh5O16hYw==
X-Received: by 2002:a05:6000:240c:b0:3ea:d9a7:43e4 with SMTP id
 ffacd0b85a97d-425578196damr2342817f8f.53.1759314768652; 
 Wed, 01 Oct 2025 03:32:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c?
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a265f6sm32900955e9.20.2025.10.01.03.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 03:32:48 -0700 (PDT)
Message-ID: <1370613d-5b3c-4f87-845e-7f0de8eb7d0d@linaro.org>
Date: Wed, 1 Oct 2025 11:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch reported issue in Rockchip video
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

Smatch reports the following issue

drivers/video/rockchip/rk_edp.c:769 rk_edp_i2c_read() warn: ignoring 
unreachable code.

Looking at the code, the warning is true, there is some code there that 
is unreachable. It is not clear to me what the fix for this should be 
but I will prepare a patch if someone could suggest what needs to be done.

Andrew
