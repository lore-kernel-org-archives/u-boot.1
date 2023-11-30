Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0423C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D9B876C7;
	Thu, 30 Nov 2023 15:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kd46C8JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFB6876CB; Thu, 30 Nov 2023 15:48:35 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F958767C
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67a545a9462so5302796d6.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701355711; x=1701960511; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DaKAvvZBmZfswzRBX3tWT4k2C6OgtOotW5JiObT6UXg=;
 b=Kd46C8JWd6jEiP/UCB6/nRXmamOdvTLM4j0RXx9bFNvs7AGseINRPo7rZTrmKn03iF
 jqIX77kTlX2JQq+h92TZHq32rbPOBDRHp6O7jc5uGj+denO1jVqTGlhjj8Qn37TD704X
 /LiqLwl8SK3gBstFvkMZpTNL6uq/9EPFKh5g7tumvmaQtX3p10ZyZYfdCBvO/Pykswmr
 duuWbjX9UzJ9JnKgw6d4gdABmxH6kub134ZnuDviNBjhUK9AbexIOcyIOXh7uSEtfIhu
 8xQ3KBx95+PrbihR1Q59GIq7QfRJj0pxIrKzyJMdEwMWuVEv4dkeeNq+Oe3uovCYmnSr
 g6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701355711; x=1701960511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DaKAvvZBmZfswzRBX3tWT4k2C6OgtOotW5JiObT6UXg=;
 b=plABDe/PaFxOlWa/j2XKARxnHZoT43DzKirEh+jxx6A0hx2ObouODFZ7AZs0z8wts1
 a3ENHeMxp6xduzB1sqb8Hri9xiaIF1WMTCSF8hOqLHl+XfN4FQvjlOmyQpDU48rSvUPw
 4jKfnHRlz1im7gNnFqoZQcxn2FGHiPT51eWwlra0RgvNVMd76FK/iC5aypvYD1KctFQw
 DznengErGMkqEGOKrVzhqsaOx+mFjp1JCPMwzEEEzPhVLj6mXntJKMw2NOkiHRg8InJj
 U+1idyb4GIcbk5g1O6OBBtf49zbRTeMRpyQsOpgaXcqBSFaM1v0Iy2WAlpXEPSW0EtF5
 nWXQ==
X-Gm-Message-State: AOJu0YyEuWFZzEUFz2nuE9rb2cSBROcCOMy4O44gpUh7A0taodiUynY2
 Lq0PfQpoCx5WI47ejPwxE3o=
X-Google-Smtp-Source: AGHT+IHPoS0wPCNMK5Qy+3h/1TQi5B8RlYiC+BCx9uHmFDze4CcDsoDtELOVqAQKfvZTwj6mMZlLKg==
X-Received: by 2002:a0c:ea52:0:b0:67a:4b63:ca63 with SMTP id
 u18-20020a0cea52000000b0067a4b63ca63mr12840869qvp.53.1701355711386; 
 Thu, 30 Nov 2023 06:48:31 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 h17-20020a0cab11000000b0067a359ffd82sm567355qvb.35.2023.11.30.06.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 06:48:31 -0800 (PST)
Message-ID: <f6bc6c2f-d9d4-0d33-48f2-c7b70288aaa5@gmail.com>
Date: Thu, 30 Nov 2023 09:48:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: TPM SPI issue
Content-Language: en-US
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <OS3P286MB1495F9E99D2BD002B94D4174F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAOMZO5CasNqMJ28QcLX-asaLPd+LuPR3B4d=8zqGD1XS=pxD5g@mail.gmail.com>
 <OS3P286MB14957A0AA37C837969AB16A5F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <OS3P286MB14957A0AA37C837969AB16A5F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
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

SGkgTmllaywNCg0KT24gMTEvMjkvMjMgMTg6NTgsIG5pZWsubm9vaWplbnNAb21yb24uY29t
IHdyb3RlOg0KPiBIaSBGYWJpbw0KPiANCj4gSSdtIHVzaW5nIHRoZSBzb2NmcGdhX2N5Y2xv
bmU1IHdpdGggdGhlIGRlc2lnbndpcmVfc3BpIGRyaXZlci4NCj4gSSBhZGRlZCB0aGUgVFBN
IHRvIHRoZSBkZXZpY2V0cmVlIGFzIHNvOg0KPiAmc3BpMCB7DQo+IOKAguKAguKAguKAguKA
guKAgnN0YXR1cyA9ICJva2F5IjsNCj4g4oCC4oCC4oCC4oCC4oCC4oCCbnVtLWNzID0gPDI+
Ow0KPiDigILigILigILigILigILigIJtcmFtMEAwIHsNCj4g4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCCY29tcGF0aWJsZSA9ICJzcGktZGV2IjsNCj4g4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmVnID0gPDA+Ow0KPiDigILigILigILigILi
gILigILigILigILigILigILigILigIJzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwPjsN
Cj4g4oCC4oCC4oCC4oCC4oCC4oCCfTsNCj4g4oCC4oCC4oCC4oCC4oCC4oCCdHBtQDEgeyAv
LyBzbG05NjcwIC0gVTE0NA0KPiDigILigILigILigILigILigILigILigILigILigILigILi
gIJjb21wYXRpYmxlID0gImluZmluZW9uLHNsYjk2NzAiLCAidGNnLHRwbV90aXMtc3BpIjsN
Cj4g4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmVnID0gPDE+Ow0KPiDi
gILigILigILigILigILigILigILigILigILigILigILigIJzcGktbWF4LWZyZXF1ZW5jeSA9
IDwxMDAwMDAwPjsNCj4g4oCC4oCC4oCC4oCC4oCC4oCCfTsNCj4gfTsNCg0KVGhlIERXIFNQ
SSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCBob2xkaW5nIHRoZSBDUyBsb3cgYmV0d2VlbiBz
ZXBhcmF0ZSByZWFkcy93cml0ZXMuDQpUaGUgZWFzaWVzdCBmaXggaXMgdG8gdXNlIGEgR1BJ
TyBDUy4gSG93ZXZlciwgeW91IGNhbiBhbHNvIHJld3JpdGUgdGhlIFNQSSBzbGF2ZQ0KZHJp
dmVyIHRvIHVzZSBtZW1fb3BzLCB3aGljaCB3aWxsIGVuc3VyZSB0aGF0IHRoZSBDUyBzdGF5
cyBoaWdoIGZvciBhIHRyYW5zYWN0aW9uLg0KSG93ZXZlciwgdGhpcyBtYXkgbm90IGJlIHBv
c3NpYmxlIGZvciBhbGwgc2xhdmVzLiBGb3IgbW9yZSBpbmZvLCBoYXZlIGEgbG9vayBhdA0K
Y29tbWl0IGZlYzdiZjA0NjBkICgic3BpOiBkdzogQWRkIG1lbV9vcHMiKS4NCg0KLS1TZWFu
DQoNCj4gTkllaw0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiDlt67l
h7rkuro6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4g6YCB5L+h5pel
5pmCOiAyMDIz5bm0MTHmnIgyOeaXpSAyMjoxNw0KPiDlrpvlhYg6IE5pZWsgTm9vaWplbnMg
LyBPQy1JQUIgUEJELUMgREVWRUwgMS0xIDxuaWVrLm5vb2lqZW5zQG9tcm9uLmNvbT4NCj4g
Q0M6IHUtYm9vdEBsaXN0cy5kZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCj4g5Lu2
5ZCNOiBSZTogVFBNIFNQSSBpc3N1ZQ0KPiANCj4gW2Zlc3RldmFtQGdtYWlsLmNvbSDjgYvj
gonjga7jg6Hjg7zjg6vjgpLlj5fjgZHlj5bjgovpoLvluqbjga/pq5jjgY/jgYLjgorjgb7j
gZvjgpPjgILjgZPjgozjgYzllY/poYzjgafjgYLjgovlj6/og73mgKfjga7nkIbnlLHjgavj
gaTjgYTjgabjga/jgIFodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmlj
YXRpb24g44KS44GU6Kan44GP44Gg44GV44GE44CCXQ0KPiANCj4gSGkgTmllaywNCj4gDQo+
IE9uIFdlZCwgTm92IDI5LCAyMDIzIGF0IDk6NTHigK9BTSBuaWVrLm5vb2lqZW5zQG9tcm9u
LmNvbQ0KPiA8bmllay5ub29pamVuc0BvbXJvbi5jb20+IHdyb3RlOg0KPj4NCj4+IEhpIHRo
ZXJlDQo+Pg0KPj4gSSBoYXZlIHRoZSBzYW1lIGlzc3VlIGFzIGhlcmU6DQo+PiBodHRwczov
L2pwbjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZjb21tdW5pdHkuaW5maW5lb24uY29tJTJGdDUlMkZPUFRJR0EtVFBNJTJGSS1NWDgt
VFBNLVNMQjk2NzAtU1BJLUNvbS1FcnJvciUyRnRkLXAlMkY0NzI1MzMmZGF0YT0wNSU3QzAx
JTdDbmllay5ub29pamVucyU0MG9tcm9uLmNvbSU3QzBlZDkzNDJjNmY0ZTRkMTRkYmJlMDhk
YmYwZGQ4MGI1JTdDMGVjZmY1YTk0YmVmNGE3Yjk2ZWNhOTY1NzliNGFjMzclN0MwJTdDMCU3
QzYzODM2ODYwNjM1NDQ1MTQwOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1D
NHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAl
M0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPUQzZjA5UlVYNGkwRWNnUWlVQzRydjN5MVZQM0E1
S2Ezb3pBUjhkWGRlbjglM0QmcmVzZXJ2ZWQ9MDxodHRwczovL2NvbW11bml0eS5pbmZpbmVv
bi5jb20vdDUvT1BUSUdBLVRQTS9JLU1YOC1UUE0tU0xCOTY3MC1TUEktQ29tLUVycm9yL3Rk
LXAvNDcyNTMzPg0KPj4NCj4+IGFwcGFyZW50bHkgdGhlIENTIGlzIHJlbGVhc2VkIGluIGJl
dHdlZW4gcmVzcG9uc2VzLiBDYW4geW91IGhlbHAgbWUgc29sdmUgdGhpcz8NCj4gDQo+IFdo
aWNoIFNvQyBhcmUgeW91IHVzaW5nPw0KPiANCj4gSW4gY2FzZSB5b3UgYXJlIHVzaW5nIGRy
aXZlcnMvc3BpL214Y19zcGkuYywgdGhlcmUgd2FzIGEgY29tbWl0IGluIHRoZQ0KPiBrZXJu
ZWwgZHJpdmVyIHRoYXQNCj4gYWxsb3dlZCB0byBwdXQgdGhlIENTIGxpbmUgaW4gbG93IHdo
ZW4gaWRsZToNCj4gDQo+IGh0dHBzOi8vanBuMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGcHViJTJGc2Nt
JTJGbGludXglMkZrZXJuZWwlMkZnaXQlMkZzdGFibGUlMkZsaW51eC5naXQlMkZjb21taXQl
MkYlM0ZoJTNEdjYuNi4zJTI2aWQlM0Q2YTk4M2ZmNTEwMmZmMGQ4NTlkZjA1Y2EzZjVjZjJm
NmExN2MwZmFkJmRhdGE9MDUlN0MwMSU3Q25pZWsubm9vaWplbnMlNDBvbXJvbi5jb20lN0Mw
ZWQ5MzQyYzZmNGU0ZDE0ZGJiZTA4ZGJmMGRkODBiNSU3QzBlY2ZmNWE5NGJlZjRhN2I5NmVj
YTk2NTc5YjRhYzM3JTdDMCU3QzAlN0M2MzgzNjg2MDYzNTQ0NTg4OTAlN0NVbmtub3duJTdD
VFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1RM2ZlUWpE
Y3lBcnhod29laEdCM0QlMkZ3bnEwcGhQUHMzcGI4amRta2RhU2clM0QmcmVzZXJ2ZWQ9MDxo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
bGludXguZ2l0L2NvbW1pdC8/aD12Ni42LjMmaWQ9NmE5ODNmZjUxMDJmZjBkODU5ZGYwNWNh
M2Y1Y2YyZjZhMTdjMGZhZD4NCg0K
