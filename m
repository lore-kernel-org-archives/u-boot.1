Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CEC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E3188076;
	Wed, 20 Mar 2024 15:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyE3AgYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7FD8808F; Wed, 20 Mar 2024 15:41:14 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A930588076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69625f89aa2so19916246d6.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710945671; x=1711550471; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ud7WFavJwYIA3CiyQu+6VjOH9A38WykeKdMfTghP7Ik=;
 b=LyE3AgYpeS5bG1limQr66iYzl4+lfR0YmVBKJHoYORpUiLDNsNCK52RHPhlN15K8TR
 o0WlWDZ/6Gf8sb/+KLKLIe6pUm4TpaqXgeMMCHc2mCA327klbDsS3AZNaAu6/HLJSGYX
 VWzZZti0P3rO6O3UeLoh36ByreV8drXOryLab1m4eFA5ijswAK4Fx3DpIKW0qMvkU31P
 Z8M50GUO5jsT7c4NcQs7NlqsNTI3c3h+rYgAexGua1VSBtJ488AjLRK4tQiK2yTsTdpD
 RSLUi1bg21m/SEj2fA2kOMM3F7z3Y9RBXzy7XheXyPmpwLKJEfOspjn1y9Bq1pPQCrtI
 fJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945671; x=1711550471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ud7WFavJwYIA3CiyQu+6VjOH9A38WykeKdMfTghP7Ik=;
 b=hWnmB7KdrW5FeZjX6uhz3ndABFX4iIHGmevLUTrBbO+yr7WYgFp2K+iX68peOOtIy1
 rUATf4lKJ2E2QXH3apdq+kRSeKCytsLij85KNCgzyMUJ7XGacSteYQtVjJF296nNQeZP
 SXShXQZhOrLOaeqQXxmfv7zscyeDb9qPxCdPAwd42owO7XwotBBqV50nfAp6IhTe/p1k
 sDcxd+FgeikgmPMnS/uPbMlaZQVFdt9UbuQ7owS16LYv6AvGj0VQsdv2PiZCkLLDbbiy
 ZPw4E3TaO5hKpDrFq7OHes2MFZg+hbFN7mFz1WP26C+MYpvrzKaA7cknB1B/RYaY7XMp
 u3cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0pOipintfDvXNIOKflCu+59vTDcFx/7bsbhpnrWB1z4mQ+z+KqpIqte2fvFu5FwEogBYe41BK3Ug9bYvo258lxIu14A==
X-Gm-Message-State: AOJu0YxqCXVB8cbKBdZCj6KFT3qf+iZpdgFKHY0T/lK2VUwv68Okf5BP
 snR9yfTxj5iyIoQnQP3h2MSJ9xzgMF7aB7i1eMLakUyyMsEsPjN4
X-Google-Smtp-Source: AGHT+IHG+VpB2p+iY0o/kSuBkbgMmHoR8PcFRS5mGeJB5J0un8TphN71ZUDEEFEc7RDhH1vQfyG8WA==
X-Received: by 2002:a0c:8d44:0:b0:690:d002:af1f with SMTP id
 s4-20020a0c8d44000000b00690d002af1fmr2355680qvb.2.1710945669683; 
 Wed, 20 Mar 2024 07:41:09 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 eo8-20020ad45948000000b006962040f002sm3398156qvb.139.2024.03.20.07.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 07:41:09 -0700 (PDT)
Message-ID: <32118bdf-d881-b614-1f1b-43749db274ab@gmail.com>
Date: Wed, 20 Mar 2024 10:41:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <CAPLW+4nqmeFNPRibP2PKSOpR67Ud=2wPL1V=XSxnMYDiSM20-A@mail.gmail.com>
 <SEZPR06MB6959980F8716A68AD09D27FC96332@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <SEZPR06MB6959980F8716A68AD09D27FC96332@SEZPR06MB6959.apcprd06.prod.outlook.com>
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

T24gMy8yMC8yNCAxMDowMiwgWWFuZyBYaXdlbiB3cm90ZToNCj4gT24gMy8yMC8yMDI0IDI6
NDIgQU0sIFNhbSBQcm90c2Vua28gd3JvdGU6DQo+PiBPbiBUaHUsIE1hciA3LCAyMDI0IGF0
IDY6MDTigK9QTSBTYW0gUHJvdHNlbmtvIDxzZW1lbi5wcm90c2Vua29AbGluYXJvLm9yZz4g
d3JvdGU6DQo+Pj4gU29tZXRpbWVzIGNsb2NrcyBwcm92aWRlZCB0byBhIGNvbnN1bWVyIG1p
Z2h0IG5vdCBoYXZlIC5zZXRfcmF0ZQ0KPj4+IG9wZXJhdGlvbiAobGlrZSBnYXRlIG9yIG11
eCBjbG9ja3MpLCBidXQgaGF2ZSBDTEtfU0VUX1BBUkVOVF9SQVRFIGZsYWcNCj4+PiBzZXQu
IEluIHRoYXQgY2FzZSBpdCdzIHVzdWFsbHkgcG9zc2libGUgdG8gZmluZCBhIHBhcmVudCB1
cCB0aGUgdHJlZQ0KPj4+IHdoaWNoIGlzIGNhcGFibGUgb2Ygc2V0dGluZyB0aGUgcmF0ZSAo
ZGl2LCBwbGwsIGV0YykuIEltcGxlbWVudCBhIHNpbXBsZQ0KPj4+IGxvb2t1cCBwcm9jZWR1
cmUgZm9yIHN1Y2ggY2FzZXMsIHRvIHRyYXZlcnNlIHRoZSBjbG9jayB0cmVlIHVudGlsDQo+
Pj4gLnNldF9yYXRlIGNhcGFibGUgcGFyZW50IGlzIGZvdW5kLCBhbmQgdXNlIHRoYXQgcGFy
ZW50IHRvIGFjdHVhbGx5DQo+Pj4gY2hhbmdlIHRoZSByYXRlLiBUaGUgc2VhcmNoIHdpbGwg
c3RvcCBvbmNlIHRoZSBmaXJzdCAuc2V0X3JhdGUgY2FwYWJsZQ0KPj4+IGNsb2NrIGlzIGZv
dW5kLCB3aGljaCBpcyB1c3VhbGx5IGVub3VnaCB0byBoYW5kbGUgbW9zdCBjYXNlcy4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFNhbSBQcm90c2Vua28gPHNlbWVuLnByb3RzZW5rb0Bs
aW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4gSGkgTHVrYXN6LCBTZWFuLCBUb20sDQo+Pg0KPj4g
SWYgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIHlvdSBhbmQgdGhlcmUgYXJlIG5vIG91dHN0
YW5kaW5nIGNvbW1lbnRzLA0KPj4gY2FuIHlvdSBwbGVhc2UgYXBwbHkgaXQ/IEl0J3MgbmVl
ZGVkIGFzIGEgcGFydCBvZiBlTU1DIGVuYWJsZW1lbnQgZm9yDQo+PiBFODUwLTk2IGJvYXJk
LCBhcyBlTU1DIGdhdGUgKGxlYWYpIGNsb2NrIGlzIHNwZWNpZmllZCBhcyBjaXUgY2xvY2sg
aW4NCj4+IGR0cywgd2hpY2ggcmVxdWlyZXMgZnVydGhlciBjbG9jayByYXRlIGNoYW5nZSBw
cm9wYWdhdGlvbiB1cCB0bw0KPj4gZGl2aWRlciBjbG9jay4NCj4+DQo+PiBUaGFua3MhDQo+
IA0KPiANCj4gUGxlYXNlIGJlIHBhdGllbnQuIFRoZSByZWxlYXNlIGN5Y2xlIGlzIHF1aXRl
IGxvbmcuIE15IHBhdGNoIHNldCBmb3IgSGlTaWxpY29uIGNsayBmcmFtZXdvcmsgaGFzIGJl
ZW4gaWdub3JlZCBmb3IgfjJtb250aHMgYWxyZWFkeS4NCg0KU29ycnksIEkndmUgYmVlbiBi
dXN5IElSTCByZWNlbnRseS4NCg0KSSB3aWxsIHRyeSB0byByZXZpZXcgcGF0Y2hlcyBpbiB0
aGUgYmFja2xvZywgYnV0IGl0IG1pZ2h0IGJlIGEgZmV3IG1vcmUgd2Vla3MuDQoNCi0tU2Vh
bg0K
