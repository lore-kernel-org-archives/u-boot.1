Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455D8C88E74
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 08:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803CA83EA9;
	Mon, 26 Jan 2026 09:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cSdtLMAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B479E83EAC; Mon, 26 Jan 2026 09:28:52 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2197283E9F
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 09:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b884a84e622so668585866b.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769416128; x=1770020928; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FHZJ9aAjkeRLFMrclwBu55wN358fGd48y2gWK1aGno=;
 b=cSdtLMAlhWJW24NhejjW/k4dRxIGt87X6MwSfO0GQXAySr++MpvYhWqzqYDxrqv9ur
 IHo2cLQel41YvcHx3UgdfNbzABC/H4K6NHChU52kvMlFlDBTbJ7dP2PZa5vhQmBqiZ8M
 294QgW5TOInfBIeb6hyx0h5stNQDZkkSZ340PUU6KFm3MaJbFPZ/Kp0wQvZ2UcCTt0yq
 GdBxNf5XTK2ldVWGbgc6ALN7tDvFW7mzjKI3pzyEdoO55y16E/w59K7et+Ftq8WrYN2y
 LTN4Jo55A05Zkez8NiMUPfCPqgGdDthRVZWzT+ajOraUCvHHSMAfd9IA3eh4r2bsn1GP
 AnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769416128; x=1770020928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FHZJ9aAjkeRLFMrclwBu55wN358fGd48y2gWK1aGno=;
 b=VHfGquQ6roVTWPWNycV2yNcCjw1M0Y2shiVyV97mw+2AZX1zS2DUY2kf6MqfQSke2F
 +97SRmk1NgHMhymMfv8TDCmImqi4vK7taSedLxjJLv0qMTlRL0iXIPnEruPRynP0g18j
 PGVEKfAyXQzFQGpwmTNhgrz14Vfde1yFPp0FT8SjsBE+ksfHmd4XUGeB7yDZ+KUd8FIT
 qxvEdE/gYOAx4IJd+tVNzFBTXnR9pKhtNHV55FTGSz9KhXhiv0WGgoYMCasrlUq5oAEX
 q0PKQs00HUQKsNzRtHtrgTUISE9Q6LeG6sy03O+vdkDElqz3dtWl7c72vi+UNfhHoNAY
 HpRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2ljSsKwKWGhInby37QRHUzBifIdmtMfPJQCI/WIjQHK/9/avySsHTZmkiMwEPw7vhWfZxZ0w=@lists.denx.de
X-Gm-Message-State: AOJu0YytIe+M3ly2x1ThN+bZcoX+932pqOlgt2OJqq6X2GlSNLbmSKC4
 6Ps4wiJi/n3KBSGRueQyiZp+XwThjPFiJTElpO+qvaOV/fcdnLKYEUeVWoACzqz2vHM=
X-Gm-Gg: AZuq6aIzRpHOKid4z4kVPBWL3xFTo5Mq4H2yselS2faHvftoN9SYHDxEu7Z5sCrtop+
 LE7A1ZKPlmvFvtWDiZO8DvbuhBQ0LUaYiJeE/W8+2PhYjZm5xhQs76Og4zMmFHcHcWaLS8Fuwo1
 8Y+0VlTyj3MOBl4S+ukotU1naRS5bfUmhRAhAM0KuaHjouOnNyY43zpelSTJOpOV5mkCYsgeHYu
 L8VfvHbqhPQn/2rwi3zOOKniH7GhshWiyWDrKod+yZDUVLbxIK9+ot33iurR3mKCW/q2r/XOj46
 uTg0cilhNOGeaG92OSIIOIXaoQVuLGZxISFbJ21NMxTDiPSnYEdKFVXsNML3qSJIgifkPfCPS/o
 x4ahuHKPc7OYv5F530Uv5JN3ZkY1ayrtOFOPsv+aItJx+Opq3H3tk470Y5IREWF+FkRsJyaVEGN
 BKE2nw9cCDHzrcSBt+Rknbhg==
X-Received: by 2002:a17:907:9447:b0:b83:1326:a504 with SMTP id
 a640c23a62f3a-b8d2e83c6ffmr266277766b.60.1769416128424; 
 Mon, 26 Jan 2026 00:28:48 -0800 (PST)
Received: from [192.168.1.221] ([80.227.159.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8864a14e94sm551334266b.42.2026.01.26.00.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 00:28:47 -0800 (PST)
Message-ID: <6c4d59da-6643-444e-ac0c-5a5be40da81e@linaro.org>
Date: Mon, 26 Jan 2026 10:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm: at91: move atmel_serial.h to
 include/dm/platform_data
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 sjg@chromium.org, hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr
References: <20260112131258.182173-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20260112131258.182173-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
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



On 1/12/26 15:12, Robert Marko wrote:
> Move the arch specific atmel_serial.h header from AT91 to the generic
> include/dm/platform_data.
> 
> This will be used for support on Microchip LAN969x.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---

Applied series to u-boot-at91/master, thanks !
