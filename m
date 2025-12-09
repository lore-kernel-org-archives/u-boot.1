Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FBD3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AD683C64;
	Tue,  9 Dec 2025 16:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UCzAzHBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E198683C98; Tue,  9 Dec 2025 16:03:28 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358D383C5A
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7697e8b01aso779316866b.2
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292603; x=1765897403; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KIP0J8u8klFco0ZC7AnQ1v9Vgxb68DB/0LgYZSsWO5E=;
 b=UCzAzHBpnkSfeSecL23T0c0n9Ow+tHDgI/vDMWUKKWQI9rXEr6ukyMZOp0EB/KarR7
 +iee0tEObvi7PntgeEj9kD1DKSeEsgr1Dx3rFL8sqCT8tJXKvikKnzx0nuTI2eOpSXtM
 Ir15OKrDUbTfjGx1GMdISCTqxe2ltXvraGVRA6X5GZZ802iYsr7CriSHHJe1OFfSH0RJ
 htzImdRvFOYVoXGSthUBHb9NHqR3/ypA8YL6UizMbUNUVIDEW7fp7HsoDiY86aEa0UKY
 xJZz1DJ7NhbNVaHgPvI5+q927da2dpypYXgshxZ6bTdLF30Hkal3DaSMsak/G69xKEe7
 p5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292603; x=1765897403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KIP0J8u8klFco0ZC7AnQ1v9Vgxb68DB/0LgYZSsWO5E=;
 b=phM+WCsFLJw79cYKmfgvaZCIPCnn4jcNPLBH+T2OF1FbkhtgSCRlH6prJBVIUPPxsV
 OSKdeVptC4objekafdm0j2AMWfd5Q2PBQTGTuyFoLi8ve3r0UyEdzHJsrCzxYpPJphTm
 +s1hoauMpUKpoC7CJ2yAQkGMmgHoeIqH7Y/Al+GzOqBAIZd2EUIJKuiz72N+u1dX2HvD
 cUg6gyAjUc295rmjYF9XhII804YnTw4CcvBixWPz+OC0DfaOPw1sVNIm6EeYk52XkCyR
 bDWkD4C0NZWags6ns0jHxMXKxkuaHV03IBqkvME4eldH+qcCx5Bw30MepQ05AkOfvi7r
 7tVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMSPb9Vo/MvbmcPK3lNrtgnRdorV2Ca5kj8sV4w1tXwKb2D+3uQ3etdWqAq11Byty5S4v3LEk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn2POVQ8auorCR+33beKKBE5hcKEoXx1XmwVrupWRZFFSJDY6g
 XaUH0mPQGVHcvWSZQCPSurmhtyoIDzBtfUIPXnZOc9JekRfpCzybuajXt/KZP+38tYfc/voCoZv
 3SpJw/MQ=
X-Gm-Gg: ASbGncuEbfUt12pXbjvEZhWJ8Ti4OmbXce01WXgZAlOcyBqA2iherP/Nkk8EZohN+UN
 IIZOgC8IDP9SVkFpTxtwp1XZFLL7hanoIPmOBHtop4KSu/SdPVMXEReWFKHWzcOOXxGJ4axyYyQ
 643u87zw90UTHY2fCVtxo7FmlRB5Ucra66IZc9ZtdHuVyyZJeg2rpLj/0DZnuQOIOkL+d5lt4A0
 qe8phdJgZoEC41vjI1Ag9u2J+EnLahifl4+t9hW5XGzuPzVhsoj6epbHIGJfMyqKDODj/ikUkF8
 Ok6R1+1ECvF7yTHh8d2nQupugdGfklF7+ibdV7D/XQM5G369XJuGE5fs5+5vQ5dHCTDPmAu026e
 6uhy7DJq+oG0r65ZSLPwGcy+c2raFAF1RPdbapjH7no8nKY+PTKg8TK4Bg0+pOOhlK0jSJK/s3p
 rw/4wyWi8PzI9ZwQ/vMbXm5g==
X-Google-Smtp-Source: AGHT+IHuxWir7T2eFNylikE6RZODU/vgQxmhQQbqG0A7naiPP/4HxcgwU4Xe64fVILtBn3/huqOY+g==
X-Received: by 2002:a17:907:72c7:b0:b7a:1bde:a01a with SMTP id
 a640c23a62f3a-b7a24846255mr1282051666b.62.1765292600959; 
 Tue, 09 Dec 2025 07:03:20 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4976732sm1417015566b.43.2025.12.09.07.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:03:20 -0800 (PST)
Message-ID: <be39d58e-8c56-4f5f-8cba-814b9a851b2c@linaro.org>
Date: Tue, 9 Dec 2025 16:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: move net_state to net-common
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-1-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-1-1f5d31e15d00@linaro.org>
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

Hi Andrew,

On 12/8/25 13:52, Andrew Goodbody wrote:
> Move the net_state variable into common code so that it can be used by
> either the legacy network code or LWIP. This is needed for porting
> across the NFS support code for use with LWIP.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/net-common.h | 17 +++++++++++++++++
>  include/net-legacy.h | 17 -----------------
>  net/net-common.c     |  3 +++
>  net/net.c            |  2 --
>  4 files changed, 20 insertions(+), 19 deletions(-)

I don't think this patch is needed - see my comments on "net: lwip: nfs:
Port the NFS code to work with LWIP".

Thanks,
-- 
Jerome
