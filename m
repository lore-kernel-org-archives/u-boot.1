Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA5BC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598EA87F51;
	Mon,  4 Mar 2024 10:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X2LYbaEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2331287F5C; Mon,  4 Mar 2024 10:34:55 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B5087F41
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88E6D3F275
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709544892;
 bh=3Q4nYYh44Ny3+6cXGv3dcYGAXt1sAyPD+Z0Wrqd41M0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=X2LYbaEAv42CrmNaPsnAAdxtPzI90ZxKCh25Gv17bBV0hTaP2XXLP4jgdE/ar7PIM
 YvsP00I5HACtgI69gNiAXIiS1X/G1pmOoCtQ97+rUPMnS4rj8z1sJgBU97BZL50eBY
 6zOlXldAg3BV1v7DmyzgZS4avfQqwEEufTLpZEAoR2PP0GALhyaDzRGJTr0Wre04IA
 LEmUuNw+h31nBaRA/KDGnOkExBu7eTzh0RAn84y8Si3KXmaRyWf5Ie1ulLJbx5Rk0V
 UdQ7ECqC7irfYafQfGyIJmyD7qLXqOBc7DrbuHN8dXqNznNmQftGUT/+ysZDsxJSLY
 4Ab4gO6BFJeIQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412e4d20b28so3032735e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709544892; x=1710149692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Q4nYYh44Ny3+6cXGv3dcYGAXt1sAyPD+Z0Wrqd41M0=;
 b=rNZd4debswhLkIj72dyfcfJXjuGhPs+ht5d0ltCEBfg1r5BcBnMHMUO0Mw4V76hoku
 jz1XO1Gh3Hf0AlE+m46NQr6VpeXyoyUpQ/PvTH31ybDuVjeG9whLK9jh8eOG5VHdhmX9
 hxpQIvZ0ra/YhgYkTc8KKKE1qx0fCWJwEQ+yAR+F+W910jTJS3RbulQl9PD3kn8E4Bpg
 6iiRfDM2i7mAoynDAEBlnPPtQpIuEvWiORhNX/9vowRzzdLEQyzOer7L0ehOjW6JnsHu
 u/MutamOeZwM9WV34oWaXrhN6rITCiSxQ87dfnDaEHuwUUjS+5Ub6UB+K6rKwXTSkFVK
 SQRQ==
X-Gm-Message-State: AOJu0Yx84qvzGQiNMPUbybSz7VfTmh2v7Kf4An60XyUzEjDWMSvRaXGH
 EbBwqPVqkD17Q2Jq1yWHRTXqYiGvf6pbsw23MBcAaqo4ftYRDkm9uv8dX/kDb+aOk0In91WKMkb
 TL0FZ7JY57C2CWsn+VpQnz3tphx2UstRsKt5aPL6tQzeKYcjhsdenjmuUowl6oClDgjw=
X-Received: by 2002:a05:600c:1f12:b0:412:e321:c9a6 with SMTP id
 bd18-20020a05600c1f1200b00412e321c9a6mr1720583wmb.25.1709544892179; 
 Mon, 04 Mar 2024 01:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo3ubp3e+2kjkx+oHfB80Q54hFCYVY4nOPFgy5XMETDdkZGwKyRXB2xUX3NPbMAcHRriuanw==
X-Received: by 2002:a05:600c:1f12:b0:412:e321:c9a6 with SMTP id
 bd18-20020a05600c1f1200b00412e321c9a6mr1720573wmb.25.1709544891843; 
 Mon, 04 Mar 2024 01:34:51 -0800 (PST)
Received: from [192.168.123.67] (ip-095-222-037-056.um34.pools.vodafone-ip.de.
 [95.222.37.56]) by smtp.gmail.com with ESMTPSA id
 bt12-20020a056000080c00b0033e3a110d7fsm3111976wrb.71.2024.03.04.01.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 01:34:51 -0800 (PST)
Message-ID: <06628723-2b72-4398-9068-a29ece9eb4df@canonical.com>
Date: Mon, 4 Mar 2024 10:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: invalid escape sequences in
 maintainers_include.py
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240303134022.33062-1-heinrich.schuchardt@canonical.com>
 <20240303141447.GC1523872@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240303141447.GC1523872@bill-the-cat>
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

On 03.03.24 15:14, Tom Rini wrote:
> On Sun, Mar 03, 2024 at 02:40:22PM +0100, Heinrich Schuchardt wrote:
> 
>> Update maintainers_include.py from Linux next-20240202.
> 
> Is there no better upstream tag/commit to base this from?
> 

The relevant changes in Linux were in 2023 and 2021:

86a0adc029d3 ("Documentation/sphinx: fix Python string escapes")
4217e5074f33 ("Docs: drop Python 2 support")

We could also refer to Linux v6.7.

So maybe we better copy these patches instead of only a single file.

Best regards

Heinrich
