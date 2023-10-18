Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D2CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 17:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E484A86FDC;
	Wed, 18 Oct 2023 19:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0Jlp8Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E0086FE9; Wed, 18 Oct 2023 19:23:18 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C3C86F8B
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 19:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-65b0e623189so41539506d6.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697649795; x=1698254595; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BC+Frd53ND0vQJ6yleg8nC4V7rHKJeyQQQKO6zcHXXI=;
 b=D0Jlp8TjhANceCaNKkZUmKJcpI/fZpt/x3IDXZ6YlQ1IJOU9ESTYDJDAL8XKy691bL
 BrY4Ehq/kpu1xi61zbuTPNynXNSO89hWHYVrODNKmaESaKfvUzrhgMFAGgG1KBKggmfs
 aaKXIimDu9KJXVDAC+/eECgMVvkP4qjI73ngeJZYxS6QINwbRH9PTYrNwU2f1kbOMYQd
 dYlsCAx4q9BhlSzYznLQF3CnCGrsws0r/2NSEf/3QKGCIffo+0wHHbBhX2O46KnICE0q
 hrUMUsGw1YveQBTZveOtlGLSTGJLocpb6dZDOZn+AQ0fcfQVPt+Yx4afQ8BoTpGeaBuC
 LcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697649795; x=1698254595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BC+Frd53ND0vQJ6yleg8nC4V7rHKJeyQQQKO6zcHXXI=;
 b=iYYwMs4qyi/sI20LglE4qoW45Sg0jbFUheHOn+7YV2PkVaBKDIeilT8aW8jeTvJd+2
 iOnhxPW6eu+zmlzMGhq8g4pbc5IajEUVCuOblFFIPGZDncRmp9dJTzvks88ubuGsYP0W
 PJ9RcBCvJ8tnZaR8D6KFksOxDuTkokLL136Qjrhumwxb55tHw8Ckd5rJx/DAa/o/TI61
 KCXT8QzjMIM8/k5aiUUUOemLQ1CgXE7zvytBNp5Q22cwek+yrne+Aq/3wuO5YAKxSGgh
 61dSMOwfnCPP5ERGVa+vv7H/YqurJe0ncFXIs9gZxFX+dfmTPPaPfdTWp5f1KUdBPTBF
 bMhQ==
X-Gm-Message-State: AOJu0YzE55M7BhV0Wd5SBVdi6kwCzmyL7IY0kJjdd51eqbyZzzqpl1av
 uYJvp7uNeyqhWtVAfSSpnXE=
X-Google-Smtp-Source: AGHT+IEPIEWG5nlZhtjxMPSbCrCCCTYPTgpOBjH2OnvsAJFLeTqlMAyAzFk6MzOsAxta+ORFRtGFMQ==
X-Received: by 2002:ad4:5f09:0:b0:653:5960:8959 with SMTP id
 fo9-20020ad45f09000000b0065359608959mr7935680qvb.41.1697649794772; 
 Wed, 18 Oct 2023 10:23:14 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ph5-20020a0562144a4500b0066d11e63ba1sm110098qvb.5.2023.10.18.10.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 10:23:14 -0700 (PDT)
Message-ID: <fc59685f-4c31-1859-73db-04fac964df4f@gmail.com>
Date: Wed, 18 Oct 2023 13:23:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/32] sifive: Drop an unnecessary #ifdef
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-7-sjg@chromium.org>
 <8ce172b2-8665-442c-8e41-6b36f1255e5b@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <8ce172b2-8665-442c-8e41-6b36f1255e5b@gmx.de>
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

T24gMTAvMTgvMjMgMDk6NTEsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDEw
LzE3LzIzIDAwOjI3LCBTaW1vbiBHbGFzcyB3cm90ZToNCj4+IFRoaXMgY29kZSBpcyBub3Jt
YWxseSBjb21waWxlZCBmb3Igc2lmaXZlLCBidXQgc2FuZGJveCBjYW4gYWxzbyBjb21waWxl
DQo+PiBpdC4gV2Ugc2hvdWxkIG5vdCB1c2UgVU5JVF9URVNUIGFzIGEgc3lub255bSBmb3Ig
U0FOREJPWCwgc2luY2UgaXQgaXMNCj4+IHBvc3NpYmxlIHRvIGRpc2FibGUgVU5JVF9URVNU
IGZvciBzYW5kYm94Lg0KPj4NCj4+IERyb3AgdGhlIGNvbmRpdGlvbiBzaW5jZSBpdCBpc24n
dCBuZWVkZWQuDQo+IA0KPiBUaGlzIGlzIG5vdCB3aGF0IHRoZSBwYXRjaCBkb2VzLiBJdCBp
bnRyb2R1Y2VzIGFub3RoZXIgY29uZGl0aW9uLg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4+IFN1Z2dlc3RlZC1ieTogU2Vh
biBBbmRlcnNvbiA8c2VhbmdhMkBnbWFpbC5jb20+DQo+PiAtLS0NCj4+DQo+PiBDaGFuZ2Vz
IGluIHYzOg0KPj4gLSBKdXN0IGRyb3AgdGhlIGNvbmRpdGlvbiBpbnN0ZWFkDQo+Pg0KPj4g
wqAgaW5jbHVkZS9rMjEwL3BsbC5oIHwgMiArLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvazIxMC9wbGwuaCBiL2luY2x1ZGUvazIxMC9wbGwuaA0KPj4gaW5kZXggZmQxNmE4OWNi
MjAzLi42ZGQ2MGIyZWI0ZmMgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2syMTAvcGxsLmgN
Cj4+ICsrKyBiL2luY2x1ZGUvazIxMC9wbGwuaA0KPj4gQEAgLTEzLDcgKzEzLDcgQEAgc3Ry
dWN0IGsyMTBfcGxsX2NvbmZpZyB7DQo+PiDCoMKgwqDCoMKgIHU4IG9kOw0KPj4gwqAgfTsN
Cj4+DQo+PiAtI2lmZGVmIENPTkZJR19VTklUX1RFU1QNCj4+ICsjaWZkZWYgQ09ORklHX1NB
TkRCT1gNCj4gDQo+IFdlIHNob3VsZCBiZSBhYmxlIHRvIGNvbXBpbGUgd2l0aCBhbmQgd2l0
aG91dCB1bml0IHRlc3RzIG9uIHRoZSBNQUlYDQo+IGJvYXJkcy4gV2h5IHNob3VsZCBDT05G
SUdfU0FOREJPWCBoYXZlIGFueSByZWxldmFuY2UgaGVyZT8NCj4gDQo+IFdoeSBkb24ndCB3
ZSBtYWtlIGsyMTBfcGxsX2NhbGNfY29uZmlnKCkgbm9uLXN0YXRpYyBpbiBhbGwgY2FzZXM/
DQoNClUtQm9vdCBpcyBzbWFsbGVyIHdoZW4gaXQgaXMgc3RhdGljLiBCdXQgdGhlIGZvcndh
cmQgZGVjbGFyYXRpb24gY2FuIGJlIG1hZGUNCnVuY29uZGl0aW9uYWxseSwgYXMgbG9uZyBh
cyBpdCBpcyB1bnVzZWQuDQoNCi0tU2Vhbg0K
