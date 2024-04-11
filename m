Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733B2CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D2988149;
	Thu, 11 Apr 2024 05:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vx4Ys8om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E188758B; Thu, 11 Apr 2024 05:20:06 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CD688149
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-436433a44bcso5350481cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805601; x=1713410401; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6M5ce3enEGYQPk4CsYyEBnrJIjvbNvu+ti8qNNwRjKY=;
 b=Vx4Ys8om+1rLb8sVoqRnJTLD26U+/RI6lqaAIwVpujI9k/rswi0M/ymK3799xyF5ba
 1KUeVltQHUq0v5IuiSf0G6gQf2yKN7CfvA788ahO2IE/yOjMqNYGPQNhUWwBdcxcMwH5
 tQc5A7jC+cjYfgByzfIypL0IgEBoNLSKYh7seQ+EEMHpjk9ZpdPk3akAW/gy7V5Y8umQ
 CPtrEkSlJQCdi9Pna+lhGnUL7x3OGeBp5lEfqlFx7iFqoh5KBTLP+Ana+C5PHCWPjwA3
 V/tL9FMgsAuNWS1ffit3D/ILHWW9Pw/ROTe+VRu214Kep1mpQa4GhbReyKvk1k3aENDT
 s5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805601; x=1713410401;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6M5ce3enEGYQPk4CsYyEBnrJIjvbNvu+ti8qNNwRjKY=;
 b=CmR1LonyMCUsO5XaNXiQSw5FbXI4ov9ECr1uc3aHYGfm/I++d+GP+Mufjxt20dmiba
 +VdqPm+tYawDVbX8u9hK1GbDtq0B1CYj3StXxIHB1itYZYV4ayl+wCUBcLBjkLymBU3Z
 U5M1wS2eBqs8cy4kHwSahT20sBi0RNiz8IM43OtgZRV5vYLRVxni1ejt+grhxk+BxUeg
 2BY9iZLN7tJTEtOb3PSCeD680IYOCK6+zJqunsCzl9Y+Wf5B69mUMAkc+A/V7mjYZhzS
 wotCxa88kMgNp5AEABfPB2YPLzMnNu4JYiczqpR9K7YKW9sT+TDVyD8BHULCybyXq+a0
 /SUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWos1RuPl5m3sy0OnyQYmClGFT6SCPAudAWOH4C4afOvoK/yNzNcrMw97vqrh8jZFtBmcEyAa95evFMkoHspLlE08R0g==
X-Gm-Message-State: AOJu0YzZUdaPoXEY4hWKZ9JZFuQnDGZ7BrsctzX6sW2Eovhwe5Ex0LPh
 iSvlff0ZYGj2yC0NAKZLmdfHQm9/PMXQQZSJAzoUi2avXzcbuZkPs/Z6rA==
X-Google-Smtp-Source: AGHT+IFufi6/RRDN3my97sCBia4fSoDdxpvjj3WTbZWNRCF9576PEv45hAqintA7eXOGooPk4xnQGw==
X-Received: by 2002:a05:622a:1393:b0:434:ce3e:f970 with SMTP id
 o19-20020a05622a139300b00434ce3ef970mr4473754qtk.34.1712805600879; 
 Wed, 10 Apr 2024 20:20:00 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 z8-20020ac84548000000b004349bb95e01sm361511qtn.26.2024.04.10.20.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:20:00 -0700 (PDT)
Message-ID: <6e0144ae-5820-a7f1-ba47-eadc87cf3ba6@gmail.com>
Date: Wed, 10 Apr 2024 23:19:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: imx8mp: add pwm clocks support
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Tommaso Merciai <tomm.merciai@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linuxfancy@googlegroups.com, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20230310151544.1111042-1-tomm.merciai@gmail.com>
 <e3bebfc1-685f-6439-d7e2-d3b0ec3b09b6@gmail.com>
In-Reply-To: <e3bebfc1-685f-6439-d7e2-d3b0ec3b09b6@gmail.com>
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

T24gNC8xMC8yNCAyMzoxOCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gT24gMy8xMC8yMyAx
MDoxNSwgVG9tbWFzbyBNZXJjaWFpIHdyb3RlOg0KPj4gQWRkIGNsb2NrcyBzdXBwb3J0IGZv
ciB0aGUgUFdNIGNvbnRyb2xsZXJzLiBUaGlzIGlzIHBvcnRlZCBmcm9tDQo+PiBMaW51eCB2
Ni4zLjAtcmMxDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVG9tbWFzbyBNZXJjaWFpIDx0b21t
Lm1lcmNpYWlAZ21haWwuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtcC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9pbXgvY2xrLWlteDhtcC5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYw0K
Pj4gaW5kZXggZmZiYzFkMWJhOS4uZmFjODdmZjUwNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14OG1wLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1wLmMNCj4+IEBAIC0xMjIsNiArMTIyLDIyIEBAIHN0YXRpYyBjb25zdCBjaGFyICpp
bXg4bXBfZ2ljX3NlbHNbXSA9IHsiY2xvY2stb3NjLTI0bSIsICJzeXNfcGxsMl8yMDBtIiwg
InN5c19wDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
InN5c19wbGwyXzEwMG0iLCAic3lzX3BsbDFfODAwbSIsDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInN5c19wbGwyXzUwMG0iLCAiY2xrX2V4dDQi
LCAiYXVkaW9fcGxsMl9vdXQiIH07DQo+PiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBp
bXg4bXBfcHdtMV9zZWxzW10gPSB7ImNsb2NrLW9zYy0yNG0iLCAic3lzX3BsbDJfMTAwbSIs
ICJzeXNfcGxsMV8xNjBtIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAic3lzX3BsbDFfNDBtIiwgInN5c19wbGwzX291dCIsICJjbGtfZXh0MSIsDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInN5c19wbGwxXzgw
bSIsICJ2aWRlb19wbGwxX291dCIsIH07DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBpbXg4bXBfcHdtMl9zZWxzW10gPSB7ImNsb2NrLW9zYy0yNG0iLCAic3lzX3Bs
bDJfMTAwbSIsICJzeXNfcGxsMV8xNjBtIiwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAic3lzX3BsbDFfNDBtIiwgInN5c19wbGwzX291dCIsICJjbGtf
ZXh0MSIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInN5
c19wbGwxXzgwbSIsICJ2aWRlb19wbGwxX291dCIsIH07DQo+PiArDQo+PiArc3RhdGljIGNv
bnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfcHdtM19zZWxzW10gPSB7ImNsb2NrLW9zYy0yNG0i
LCAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMV8xNjBtIiwNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3lzX3BsbDFfNDBtIiwgInN5c19wbGwzX291
dCIsICJjbGtfZXh0MiIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgInN5c19wbGwxXzgwbSIsICJ2aWRlb19wbGwxX291dCIsIH07DQo+PiArDQo+PiAr
c3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bXBfcHdtNF9zZWxzW10gPSB7ImNsb2Nr
LW9zYy0yNG0iLCAic3lzX3BsbDJfMTAwbSIsICJzeXNfcGxsMV8xNjBtIiwNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3lzX3BsbDFfNDBtIiwgInN5
c19wbGwzX291dCIsICJjbGtfZXh0MiIsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgInN5c19wbGwxXzgwbSIsICJ2aWRlb19wbGwxX291dCIsIH07DQo+
PiArDQo+PiDCoCBzdGF0aWMgY29uc3QgY2hhciAqaW14OG1wX2Vjc3BpMV9zZWxzW10gPSB7
ImNsb2NrLW9zYy0yNG0iLCAic3lzX3BsbDJfMjAwbSIsICJzeXNfcGxsMV80MG0iLA0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJzeXNfcGxsMV8xNjBtIiwgInN5c19wbGwxXzgwMG0iLCAic3lzX3BsbDNfb3V0IiwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAic3lzX3BsbDJfMjUwbSIsICJhdWRpb19wbGwyX291dCIsIH07DQo+PiBAQCAtMjcwLDYg
KzI4NiwxMCBAQCBzdGF0aWMgaW50IGlteDhtcF9jbGtfcHJvYmUoc3RydWN0IHVkZXZpY2Ug
KmRldikNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfR0lDLCBpbXg4bV9jbGtf
Y29tcG9zaXRlX2NyaXRpY2FsKCJnaWMiLCBpbXg4bXBfZ2ljX3NlbHMsIGJhc2UgKyAweGIy
MDApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfRUNTUEkxLCBpbXg4bV9j
bGtfY29tcG9zaXRlKCJlY3NwaTEiLCBpbXg4bXBfZWNzcGkxX3NlbHMsIGJhc2UgKyAweGIy
ODApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfRUNTUEkyLCBpbXg4bV9j
bGtfY29tcG9zaXRlKCJlY3NwaTIiLCBpbXg4bXBfZWNzcGkyX3NlbHMsIGJhc2UgKyAweGIz
MDApKTsNCj4+ICvCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfUFdNMSwgaW14OG1fY2xrX2Nv
bXBvc2l0ZV9jcml0aWNhbCgicHdtMSIsIGlteDhtcF9wd20xX3NlbHMsIGJhc2UgKyAweGIz
ODApKTsNCj4+ICvCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfUFdNMiwgaW14OG1fY2xrX2Nv
bXBvc2l0ZV9jcml0aWNhbCgicHdtMiIsIGlteDhtcF9wd20yX3NlbHMsIGJhc2UgKyAweGI0
MDApKTsNCj4+ICvCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfUFdNMywgaW14OG1fY2xrX2Nv
bXBvc2l0ZV9jcml0aWNhbCgicHdtMyIsIGlteDhtcF9wd20zX3NlbHMsIGJhc2UgKyAweGI0
ODApKTsNCj4+ICvCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfUFdNNCwgaW14OG1fY2xrX2Nv
bXBvc2l0ZV9jcml0aWNhbCgicHdtNCIsIGlteDhtcF9wd200X3NlbHMsIGJhc2UgKyAweGI1
MDApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfRUNTUEkzLCBpbXg4bV9j
bGtfY29tcG9zaXRlKCJlY3NwaTMiLCBpbXg4bXBfZWNzcGkzX3NlbHMsIGJhc2UgKyAweGMx
ODApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfV0RPRywgaW14OG1fY2xr
X2NvbXBvc2l0ZSgid2RvZyIsIGlteDhtcF93ZG9nX3NlbHMsIGJhc2UgKyAweGI5MDApKTsN
Cj4+IEBAIC0yOTIsNiArMzEyLDEwIEBAIHN0YXRpYyBpbnQgaW14OG1wX2Nsa19wcm9iZShz
dHJ1Y3QgdWRldmljZSAqZGV2KQ0KPj4gwqDCoMKgwqDCoCBjbGtfZG0oSU1YOE1QX0NMS19J
MkMyX1JPT1QsIGlteF9jbGtfZ2F0ZTQoImkyYzJfcm9vdF9jbGsiLCAiaTJjMiIsIGJhc2Ug
KyAweDQxODAsIDApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfSTJDM19S
T09ULCBpbXhfY2xrX2dhdGU0KCJpMmMzX3Jvb3RfY2xrIiwgImkyYzMiLCBiYXNlICsgMHg0
MTkwLCAwKSk7DQo+PiDCoMKgwqDCoMKgIGNsa19kbShJTVg4TVBfQ0xLX0kyQzRfUk9PVCwg
aW14X2Nsa19nYXRlNCgiaTJjNF9yb290X2NsayIsICJpMmM0IiwgYmFzZSArIDB4NDFhMCwg
MCkpOw0KPj4gK8KgwqDCoCBjbGtfZG0oSU1YOE1QX0NMS19QV00xX1JPT1QsIGlteF9jbGtf
Z2F0ZTQoInB3bTFfcm9vdF9jbGsiLCAicHdtMSIsIGJhc2UgKyAweDQyODAsIDApKTsNCj4+
ICvCoMKgwqAgY2xrX2RtKElNWDhNUF9DTEtfUFdNMl9ST09ULCBpbXhfY2xrX2dhdGU0KCJw
d20yX3Jvb3RfY2xrIiwgInB3bTIiLCBiYXNlICsgMHg0MjkwLCAwKSk7DQo+PiArwqDCoMKg
IGNsa19kbShJTVg4TVBfQ0xLX1BXTTNfUk9PVCwgaW14X2Nsa19nYXRlNCgicHdtM19yb290
X2NsayIsICJwd20zIiwgYmFzZSArIDB4NDJhMCwgMCkpOw0KPj4gK8KgwqDCoCBjbGtfZG0o
SU1YOE1QX0NMS19QV000X1JPT1QsIGlteF9jbGtfZ2F0ZTQoInB3bTRfcm9vdF9jbGsiLCAi
cHdtNCIsIGJhc2UgKyAweDQyYjAsIDApKTsNCj4+IMKgwqDCoMKgwqAgY2xrX2RtKElNWDhN
UF9DTEtfUVNQSV9ST09ULCBpbXhfY2xrX2dhdGU0KCJxc3BpX3Jvb3RfY2xrIiwgInFzcGki
LCBiYXNlICsgMHg0MmYwLCAwKSk7DQo+PiDCoMKgwqDCoMKgIGNsa19kbShJTVg4TVBfQ0xL
X0kyQzVfUk9PVCwgaW14X2Nsa19nYXRlMigiaTJjNV9yb290X2NsayIsICJpMmM1IiwgYmFz
ZSArIDB4NDMzMCwgMCkpOw0KPj4gwqDCoMKgwqDCoCBjbGtfZG0oSU1YOE1QX0NMS19JMkM2
X1JPT1QsIGlteF9jbGtfZ2F0ZTIoImkyYzZfcm9vdF9jbGsiLCAiaTJjNiIsIGJhc2UgKyAw
eDQzNDAsIDApKTsNCj4gDQo+IEFja2VkLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdt
YWlsLmNvbT4NCj4gDQo+IEJ1dCBJIHdvdWxkIGxpa2UgdG8gc2VlIGEgUkIgZnJvbSBvbmUg
b2YgdGhlIGkuTVggbWFpbnRhaW5lcnMgKENDJ2QpLg0KDQpXaG9vcHMsIGRpZG4ndCBub3Rp
Y2UgdGhlIGRhdGUuIFNlZW1zIGxpa2UgdGhpcyBoYXMgYmVlbiBhZGRlZCBpbg0KDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAyMzAzMzAxNTIzMzMuNTNCMTE4NUVBNUBw
aG9ib3MuZGVueC5kZS8NCg==
