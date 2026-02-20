Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BDAC531F8
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C03583946;
	Fri, 20 Feb 2026 04:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dgO/tLor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0982B83AA9; Fri, 20 Feb 2026 04:28:43 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D8E8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 04:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8946421dd8fso2308546d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771558120; x=1772162920; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PfztaurUN34F5hhNqKfRSJe0JHCShbqF7aIpveammQA=;
 b=dgO/tLor1VFV0Thjj6a/CwqKZFKRxrxnY2AoLGwIvzcW0n3I0rESxLxHZpCqOt3PeH
 nMB0/44bI6ygr4KOFKcmMYSUrVsLeRF3Yzk0nzRzLC3+9ibvt08Sum5VvFZQ110vi1ol
 IpvRG9whmi4NuoX3HseOydu4eUuux1W5R067z+AnklSxDBajdFUAnm8eB+EjC7ZgkUh/
 gsRkg3xY6KxEg0WIekymE6SLqtTbEoOJTUT98ncVR+zTMNlGEfoFs337PapIOhLY/RaV
 TBpgcSfITxXU90uGZQH+U/tlIOVq7baAz75EgCBCSsh044BJjPbBjO7NROKGardbLZSs
 x+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771558120; x=1772162920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PfztaurUN34F5hhNqKfRSJe0JHCShbqF7aIpveammQA=;
 b=QCfH9/VO9wD4AyBx/GVaRhfJuKM8QZoKA6P9uAQT1DFX3EjFkEOA+2sS4oKXfihFE5
 noCBM7SsvvSlORAzyUrbGOKIdn8ZYR49FcFes+k8owXcfLlS3B6GvGnR+xtfKSBmw+jE
 xlgotqzUWM4Bmw0fVGTSQn+sTwSxX+J0mdZYtcW7dTDJRpA7f4s/iRN7H760eDe5GXnG
 7FVcKyMoKbrI6YbLlI86pRC56wo1fcajlAsG0JU4DBKuWzt8TLY2eo+4dF4C7qRecCk6
 q1UYpLdG21h6P6YNyO3Tuhq/picS/rEFXp7ZDPoq5B1AELx4LETycM+t0804BLdWVk07
 sWhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3fKmGs9eaHhGQG8a+6hf0Nfg+SncMRgmOBySfnmaH59M4VltKzTve+6XlbvTsaX1GFM0xzwk=@lists.denx.de
X-Gm-Message-State: AOJu0YxwLGcfC8a2uMQpccFcmiU/ermcHztx6Y7ltH+BfT1Q68KSxL70
 FW9J9g42oqQthJcrVhoj5clUOUkBdgpcEUJg9Ojbx+KGRFBCvv6nVQkVLaNzDQ==
X-Gm-Gg: AZuq6aKCICVH6Q5CSQnHGACmx3Gef7rDFGnTECek46UkgUJp1iQkqTiCIg87yU59AAn
 N3IqAqJm1bOIV5YOTkNDswuuL0kENgD4L4n1EmvxBoHkj1dMBL9z6zEIvbGKMwAPc6RGLblsTic
 MRXEDIKo9BKbPyZeeyu2icwAdhrFOoieGoGQlfZvfhesSkg6+hPtWi8ldK87LJ7xhkFAUT/dPS5
 s6PEkg0ZjIDcgpOjk7SLRrXiDofao4TTUloKYU6SIuBYMqIVfamRqckXGkJggaeRvdT835OaHyB
 HA3JZOEqPsUCx/umQygWj4Ohto6nj1wBeETVxkE8R0Evqg6SaIlKLXq3IWf/onbugivYOQKImiy
 m4w/GaWsFFmEtAiW9ggbpTNnMB1HoJPxNE3q9uXo0kFPQKAOVQjnyMoFlyh2MwFaqY4bMQAsju+
 fMnezQkQFC+Ehcq/EkvaFHjpY0v+6tb04bp/7LQr1YMevg5di+dUfAEglad8lQVNmhAu4=
X-Received: by 2002:a05:620a:40c9:b0:8c9:eee0:dba6 with SMTP id
 af79cd13be357-8cb408caccamr2243561585a.7.1771558119662; 
 Thu, 19 Feb 2026 19:28:39 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b1f8185sm2246154385a.36.2026.02.19.19.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 19:28:39 -0800 (PST)
Message-ID: <efb79f53-2d68-4a10-cd06-66442da3c710@gmail.com>
Date: Thu, 19 Feb 2026 22:28:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: Add generic SPL MTD loader support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: michael@amarulasolutions.com, dinesh.maniyam@altera.com, jonas@kwiboo.se, 
 trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260211222550.739727-1-festevam@gmail.com>
 <2b5ebaa9-76f1-e2b0-4e8c-fc8b6c197136@gmail.com>
 <CAOMZO5C2ZUmA=CTQ8YamKS_9GTwHN5QUXwmX0xeAGciUJyhKDw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAOMZO5C2ZUmA=CTQ8YamKS_9GTwHN5QUXwmX0xeAGciUJyhKDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
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

T24gMi8xOS8yNiAyMjoxNCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gSGkgU2VhbiwNCj4g
DQo+IE9uIFR1ZSwgRmViIDE3LCAyMDI2IGF0IDEyOjEx4oCvUE0gU2VhbiBBbmRlcnNvbiA8
c2VhbmdhMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4+IFRoYW5rcyBmb3IgcHV0dGluZyB0
aGlzIHRvZ2V0aGVyLiBGb3IgcGxhdGZvcm1zIHRoYXQgaGF2ZSB0aGUgc3BhY2UgdGhpcw0K
Pj4gaXMgZGVmaW5pdGVseSB0aGUgd2F5IHRvIGdvLg0KPiANCj4gVGhhbmtzIGZvciB5b3Vy
IHJldmlldy4NCj4gDQo+IEkgYWRkcmVzc2VkIHlvdXIgZmVlZGJhY2sgaW4gdjIsIGV4Y2Vw
dCBmb3IgYWRkaW5nIHRoZSB0ZXN0cy4NCj4gDQo+IEknbGwgdHJ5IHRvIGdldCBmYW1pbGlh
ciB3aXRoIHRoZSB0ZXN0IGluZnJhc3RydWN0dXJlLg0KDQpZb3Ugc2hvdWxkIGJlIGFibGUg
dG8ganVzdCBjb3B5IHRoZSBleGlzdGluZyB0ZXN0cyAoZS5nLiBqdXN0IHRoZSBiaXQgdGhh
dA0KY2FsbHMgZG9fc3BsX3Rlc3RfbG9hZCkgYnV0IGRvIHNvbWV0aGluZyBsaWtlDQoNClNQ
TF9MT0FEX0lNQUdFX0dFVCgxLCBCT09UX0RFVklDRV9OQU5ELCBzcGxfbXRkX2xvYWRfaW1h
Z2UpDQoNCndoZW4gc2VsZWN0aW5nIHRoZSBsb2FkZXIuDQoNCi0tU2Vhbg0K
