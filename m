Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007BBC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FAE87524;
	Wed,  1 Nov 2023 19:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dt9RZGQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC6087D7C; Wed,  1 Nov 2023 19:24:49 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4F286C3B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d13ac2796so755576d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698863084; x=1699467884; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6oYtTDn9QsVapD1YkrOEFXlBZRWNRZzEYu5o2cqhXBU=;
 b=Dt9RZGQ5S+N1lQHBcJWCOFd8cu+ItxcT0QBE4250L4WENriY5vnHF+eQtcW3RARnbN
 LZJZiZajY7k9uHw/HKf/0J6mWG+xnn9ehd3HDweiP3s6Vw8bMfyA8lTGV8gaVStfxfsW
 AKZj25VVEn3P70ikb2B8NSYv2KR+160EkV2LYXHAm8LHAFPziCbRt5NdpjngGLubnsPy
 CcgZ5gr0RQzCjyH7eDrwB2O8hl0ZNlzfpmE7JB0H4wnOxridX7Bv0xLl9g8jQQOd2NRr
 pK16QHLoa4XPnU9SJhp+KB53bJaZXwnpYw4C/Mzu6c87Z0zJeoA51xOvOzea24QOXi3U
 /ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698863084; x=1699467884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6oYtTDn9QsVapD1YkrOEFXlBZRWNRZzEYu5o2cqhXBU=;
 b=NAxJ17uTWwKsANiv6c0KGTyg6Hxc5S3FrT+qau3BPddIjiiCx22VSrCYXXbVBU59jc
 GYzSDBAAGrOg1YopV5qczWWngB7HbzbHa4Q1LY9kIk/w8+jSFaxMa0539r5O7wrWLaQL
 ioXdwOlLpf+pf76FiezWYuULw3wayeZGXqM+ZwDj6TZpifZmBo9rGkDMqaNtjzYpSSkF
 EZ7xZBX6a3p4jNdnLiA0xJYkt2UcWRtkpFT7xANnrEA8D5ExgCa0qge9gowFLJLbVwbt
 062zXDnOB0AR1ZdkXCszrB36b7jvp0RoPSf0sdw6dibfjAcCZ0qC2pDwzek7JJQPhBH2
 ZtLg==
X-Gm-Message-State: AOJu0YysANoavklo5TSl5vIgWz7o3YpgNwnA24F2YQv2u07QbVizVnrk
 6gQBEV7tNCSds+bWJ+vNQ8o=
X-Google-Smtp-Source: AGHT+IG8Qpjgx6MKJgK8F9nKg2cSbT6wl/MEkI3ods17zN00PHdbSsyPhu79BPTJkjCamSiJuvmnIQ==
X-Received: by 2002:ad4:5beb:0:b0:66d:4df1:cb0b with SMTP id
 k11-20020ad45beb000000b0066d4df1cb0bmr19119965qvc.50.1698863083645; 
 Wed, 01 Nov 2023 11:24:43 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 pp11-20020a056214138b00b0066d12d1351fsm1663692qvb.143.2023.11.01.11.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:24:43 -0700 (PDT)
Message-ID: <e58d8fe1-e8b4-408d-510d-a6456353cdce@gmail.com>
Date: Wed, 1 Nov 2023 14:24:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] clk: nuvoton: add read only feature for clk driver
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com, lukma@denx.de,
 u-boot@lists.denx.de
References: <20230307081326.13359-1-JJLIU0@nuvoton.com>
 <071cf3b3-c3dc-20a0-e592-54bef97e67e3@gmail.com>
 <CAKUZ0+FBX36mFeknrANjv8X4ADTLicBsCe86v-p9w+QOkj_G4Q@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAKUZ0+FBX36mFeknrANjv8X4ADTLicBsCe86v-p9w+QOkj_G4Q@mail.gmail.com>
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

T24gMy83LzIzIDIyOjIzLCBKaW0gTGl1IHdyb3RlOg0KPiBIaSBTZWFuDQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3Lg0KPiBUaGlzIGlzIGEgc29mdHdhcmUgZmxhZyBub3QgaGFy
ZHdhcmUgcmVnLg0KPiBJdCBqdXN0IHByb3RlY3RzIHRoZSBjbG9jayBzb3VyY2UgYW5kIGNh
bid0IG1vZGlmeSBpdCBpbiB1Ym9vdC4NCg0KT0ssIGNhbiB5b3UgYWRkIHRoYXQgdG8gdGhl
IGNvbW1pdCBtZXNzYWdlIGFuZCByZXN1Ym1pdC4NCg0KLS1TZWFuDQoNCj4gQmVzdCByZWdh
cmRzLA0KPiBKaW0NCj4gDQo+IE9uIFR1ZSwgTWFyIDcsIDIwMjMgYXQgOTo1N+KAr1BNIFNl
YW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAzLzcv
MjMgMDM6MTMsIEppbSBMaXUgd3JvdGU6DQo+Pj4gU2V0IGFoYi9hcGIvZml1IGNsb2NrIGRp
dmlkZXIgYXMgcmVhZC1vbmx5DQo+Pg0KPj4gQXJlIHRoZXNlIHJlYWQtb25seSBpbiBoYXJk
d2FyZSwgb3IgaXMgdGhlcmUgc29tZSBvdGhlciByZWFzb24/DQo+Pg0KPj4gLS1TZWFuDQo+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEppbSBMaXUgPEpKTElVMEBudXZvdG9uLmNvbT4NCj4+
PiAtLS0NCj4+PiAgICBkcml2ZXJzL2Nsay9udXZvdG9uL2Nsa19ucGNtLmMgICAgfCAxNSAr
KysrKysrKysrKystLS0NCj4+PiAgICBkcml2ZXJzL2Nsay9udXZvdG9uL2Nsa19ucGNtLmgg
ICAgfCAgMSArDQo+Pj4gICAgZHJpdmVycy9jbGsvbnV2b3Rvbi9jbGtfbnBjbTh4eC5jIHwg
MTIgKysrKysrLS0tLS0tDQo+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L251dm90b24vY2xrX25wY20uYyBiL2RyaXZlcnMvY2xrL251dm90b24vY2xrX25wY20uYw0K
Pj4+IGluZGV4IDhkNzFmMmEyNGIuLjE4Y2I5Y2RkYmYgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJp
dmVycy9jbGsvbnV2b3Rvbi9jbGtfbnBjbS5jDQo+Pj4gKysrIGIvZHJpdmVycy9jbGsvbnV2
b3Rvbi9jbGtfbnBjbS5jDQo+Pj4gQEAgLTEzNSw3ICsxMzUsNyBAQCBzdGF0aWMgdTMyIG5w
Y21fY2xrX2dldF9kaXYoc3RydWN0IGNsayAqY2xrKQ0KPj4+ICAgICAgICByZXR1cm4gZGl2
Ow0KPj4+ICAgIH0NCj4+Pg0KPj4+IC1zdGF0aWMgdTMyIG5wY21fY2xrX3NldF9kaXYoc3Ry
dWN0IGNsayAqY2xrLCB1MzIgZGl2KQ0KPj4+ICtzdGF0aWMgaW50IG5wY21fY2xrX3NldF9k
aXYoc3RydWN0IGNsayAqY2xrLCB1MzIgZGl2KQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgc3Ry
dWN0IG5wY21fY2xrX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+
ICAgICAgICBzdHJ1Y3QgbnBjbV9jbGtfZGl2ICpkaXZpZGVyOw0KPj4+IEBAIC0xNDUsNiAr
MTQ1LDkgQEAgc3RhdGljIHUzMiBucGNtX2Nsa19zZXRfZGl2KHN0cnVjdCBjbGsgKmNsaywg
dTMyIGRpdikNCj4+PiAgICAgICAgaWYgKCFkaXZpZGVyKQ0KPj4+ICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPj4+DQo+Pj4gKyAgICAgaWYgKGRpdmlkZXItPmZsYWdzICYg
RElWX1JPKQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+Pj4gKw0KPj4+ICAgICAg
ICBpZiAoZGl2aWRlci0+ZmxhZ3MgJiBQUkVfRElWMikNCj4+PiAgICAgICAgICAgICAgICBk
aXYgPSBkaXYgPj4gMTsNCj4+Pg0KPj4+IEBAIC0xNTMsNiArMTU2LDEyIEBAIHN0YXRpYyB1
MzIgbnBjbV9jbGtfc2V0X2RpdihzdHJ1Y3QgY2xrICpjbGssIHUzMiBkaXYpDQo+Pj4gICAg
ICAgIGVsc2UNCj4+PiAgICAgICAgICAgICAgICBjbGtkaXYgPSBpbG9nMihkaXYpOw0KPj4+
DQo+Pj4gKyAgICAgaWYgKGNsa2RpdiA+IChkaXZpZGVyLT5tYXNrID4+IChmZnMoZGl2aWRl
ci0+bWFzaykgLSAxKSkpIHsNCj4+PiArICAgICAgICAgICAgIHByaW50ZigiY2xrZGl2KCVk
KSBmb3IgY2xrKCVsZCkgaXMgb3ZlciBsaW1pdFxuIiwNCj4+PiArICAgICAgICAgICAgICAg
ICAgICBjbGtkaXYsIGNsay0+aWQpOw0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+Pj4gKyAgICAgfQ0KPj4+ICsNCj4+PiAgICAgICAgdmFsID0gcmVhZGwocHJpdi0+
YmFzZSArIGRpdmlkZXItPnJlZyk7DQo+Pj4gICAgICAgIHZhbCAmPSB+ZGl2aWRlci0+bWFz
azsNCj4+PiAgICAgICAgdmFsIHw9IChjbGtkaXYgPDwgKGZmcyhkaXZpZGVyLT5tYXNrKSAt
IDEpKSAmIGRpdmlkZXItPm1hc2s7DQo+Pj4gQEAgLTI1Myw4ICsyNjIsOCBAQCBzdGF0aWMg
dWxvbmcgbnBjbV9jbGtfc2V0X3JhdGUoc3RydWN0IGNsayAqY2xrLCB1bG9uZyByYXRlKQ0K
Pj4+ICAgICAgICBpZiAocmV0KQ0KPj4+ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
Pj4NCj4+PiAtICAgICBkZWJ1ZygiJXM6IHJhdGUgJWx1LCBuZXcgcmF0ZSAoJWx1IC8gJXUp
XG4iLCBfX2Z1bmNfXywgcmF0ZSwgcGFyZW50X3JhdGUsIGRpdik7DQo+Pj4gLSAgICAgcmV0
dXJuIChwYXJlbnRfcmF0ZSAvIGRpdik7DQo+Pj4gKyAgICAgZGVidWcoIiVzOiByYXRlICVs
dSwgbmV3IHJhdGUgJWx1XG4iLCBfX2Z1bmNfXywgcmF0ZSwgbnBjbV9jbGtfZ2V0X3JhdGUo
Y2xrKSk7DQo+Pj4gKyAgICAgcmV0dXJuIG5wY21fY2xrX2dldF9yYXRlKGNsayk7DQo+Pj4g
ICAgfQ0KPj4+DQo+Pj4gICAgc3RhdGljIGludCBucGNtX2Nsa19zZXRfcGFyZW50KHN0cnVj
dCBjbGsgKmNsaywgc3RydWN0IGNsayAqcGFyZW50KQ0KPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9udXZvdG9uL2Nsa19ucGNtLmggYi9kcml2ZXJzL2Nsay9udXZvdG9uL2Nsa19u
cGNtLmgNCj4+PiBpbmRleCAwNmI2MGRjOGI4Li5iNDcyNmQ4MzgxIDEwMDY0NA0KPj4+IC0t
LSBhL2RyaXZlcnMvY2xrL251dm90b24vY2xrX25wY20uaA0KPj4+ICsrKyBiL2RyaXZlcnMv
Y2xrL251dm90b24vY2xrX25wY20uaA0KPj4+IEBAIC01MCw2ICs1MCw3IEBADQo+Pj4gICAg
I2RlZmluZSBQUkVfRElWMiAgICBCSVQoMikgIC8qIFByZSBkaXZpc29yID0gMiAqLw0KPj4+
ICAgICNkZWZpbmUgUE9TVF9ESVYyICAgQklUKDMpICAvKiBQb3N0IGRpdmlzb3IgPSAyICov
DQo+Pj4gICAgI2RlZmluZSBGSVhFRF9QQVJFTlQgICAgICAgIEJJVCg0KSAgLyogY2xvY2sg
c291cmNlIGlzIGZpeGVkICovDQo+Pj4gKyNkZWZpbmUgRElWX1JPICAgICAgICAgICAgICAg
QklUKDUpICAvKiBkaXZpZGVyIGlzIHJlYWQtb25seSAqLw0KPj4+DQo+Pj4gICAgLyogUGFy
YW1ldGVycyBvZiBQTEwgY29uZmlndXJhdGlvbiAqLw0KPj4+ICAgIHN0cnVjdCBucGNtX2Ns
a19wbGwgew0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9udXZvdG9uL2Nsa19ucGNt
OHh4LmMgYi9kcml2ZXJzL2Nsay9udXZvdG9uL2Nsa19ucGNtOHh4LmMNCj4+PiBpbmRleCAy
N2UzY2ZjZjU1Li5kMWIzMmUzMjM3IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvY2xrL251
dm90b24vY2xrX25wY204eHguYw0KPj4+ICsrKyBiL2RyaXZlcnMvY2xrL251dm90b24vY2xr
X25wY204eHguYw0KPj4+IEBAIC00NSwxMiArNDUsMTIgQEAgc3RhdGljIHN0cnVjdCBucGNt
X2Nsa19zZWxlY3QgbnBjbTh4eF9jbGtfc2VsZWN0b3JzW10gPSB7DQo+Pj4gICAgfTsNCj4+
Pg0KPj4+ICAgIHN0YXRpYyBzdHJ1Y3QgbnBjbV9jbGtfZGl2IG5wY204eHhfY2xrX2Rpdmlk
ZXJzW10gPSB7DQo+Pj4gLSAgICAge05QQ004WFhfQ0xLX0FIQiwgQ0xLRElWMSwgQ0xLNERJ
ViwgRElWX1RZUEUxIHwgUFJFX0RJVjJ9LA0KPj4+IC0gICAgIHtOUENNOFhYX0NMS19BUEIy
LCBDTEtESVYyLCBBUEIyQ0tESVYsIERJVl9UWVBFMn0sDQo+Pj4gLSAgICAge05QQ004WFhf
Q0xLX0FQQjUsIENMS0RJVjIsIEFQQjVDS0RJViwgRElWX1RZUEUyfSwNCj4+PiAtICAgICB7
TlBDTThYWF9DTEtfU1BJMCwgQ0xLRElWMywgU1BJMENLRElWLCBESVZfVFlQRTF9LA0KPj4+
IC0gICAgIHtOUENNOFhYX0NMS19TUEkxLCBDTEtESVYzLCBTUEkxQ0tESVYsIERJVl9UWVBF
MX0sDQo+Pj4gLSAgICAge05QQ004WFhfQ0xLX1NQSTMsIENMS0RJVjEsIFNQSTNDS0RJViwg
RElWX1RZUEUxfSwNCj4+PiArICAgICB7TlBDTThYWF9DTEtfQUhCLCBDTEtESVYxLCBDTEs0
RElWLCBESVZfVFlQRTEgfCBQUkVfRElWMiB8IERJVl9ST30sDQo+Pj4gKyAgICAge05QQ004
WFhfQ0xLX0FQQjIsIENMS0RJVjIsIEFQQjJDS0RJViwgRElWX1RZUEUyIHwgRElWX1JPfSwN
Cj4+PiArICAgICB7TlBDTThYWF9DTEtfQVBCNSwgQ0xLRElWMiwgQVBCNUNLRElWLCBESVZf
VFlQRTIgfCBESVZfUk99LA0KPj4+ICsgICAgIHtOUENNOFhYX0NMS19TUEkwLCBDTEtESVYz
LCBTUEkwQ0tESVYsIERJVl9UWVBFMSB8IERJVl9ST30sDQo+Pj4gKyAgICAge05QQ004WFhf
Q0xLX1NQSTEsIENMS0RJVjMsIFNQSTFDS0RJViwgRElWX1RZUEUxIHwgRElWX1JPfSwNCj4+
PiArICAgICB7TlBDTThYWF9DTEtfU1BJMywgQ0xLRElWMSwgU1BJM0NLRElWLCBESVZfVFlQ
RTEgfCBESVZfUk99LA0KPj4+ICAgICAgICB7TlBDTThYWF9DTEtfU1BJWCwgQ0xLRElWMywg
U1BJWENLRElWLCBESVZfVFlQRTF9LA0KPj4+ICAgICAgICB7TlBDTThYWF9DTEtfVUFSVCwg
Q0xLRElWMSwgVUFSVERJVjEsIERJVl9UWVBFMX0sDQo+Pj4gICAgICAgIHtOUENNOFhYX0NM
S19VQVJUMiwgQ0xLRElWMywgVUFSVERJVjIsIERJVl9UWVBFMX0sDQo+Pg0KDQo=
