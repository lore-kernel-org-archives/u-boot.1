Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B53C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 15:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD70A876D3;
	Sun, 17 Dec 2023 16:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H7Jo5dkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C6C8775A; Sun, 17 Dec 2023 16:37:51 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA536870DF
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 16:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f2dc0f985so11402986d6.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 07:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702827468; x=1703432268; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bvWtJAfzSrOYAShg3NamSzqiJL9F9Tlpr/L7KLLAoVY=;
 b=H7Jo5dkpTE2YLM7jcH30y3tVFtP5akkm+NMCdPF3ftP5rvFwwq82CRu55GFdbRvqqt
 soqnnT9UpblkSp24QuBjoQT4cYS90GLQqzeJoOBuhtbPhDfG1GclztAIuUFwcYGEetUR
 oVK6l4+3RP2vFkeUTim1tMzOU97XRNv8PlqDebPuk76064yIudC6WYhWF4K7+AhprDJW
 enFiRnNUBgET9nCxtOppUGG6fsQpi6gJEJ4CVbi5cqnEAWC7dwfggZZ+5f7iU1jOL7Og
 Ho9wfnhFvNxKYL/2ujiyJd1wVxxLBuWS2ThXOJGCMSW0hyZ1hH6UGU1oXAKFelCt/GgW
 Gnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702827468; x=1703432268;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvWtJAfzSrOYAShg3NamSzqiJL9F9Tlpr/L7KLLAoVY=;
 b=Rhu0j/HjIx9IPFbPxh0RJ1mDErQAUxVM+vR+xzjAzk6c2iUs0c9chJ+t4nhmnGdyoP
 RlJz4tiRiJ4fpBUhCv/oxLhGt8RcPw6/hzxPzLCM0ZqhO7TnSdLysDeLdO4bf55gmvAe
 xyoqTS0rSOiPBKFHtY4losqa4schwwb0hqAY5bDcL6+yzmc8jb5SXh74JsGZOU2WzX1L
 JZHQy2zSkJoZHq45viqwWpf7wiznOY0BuavJ9F7obWdf61kdgmubCdAJ0nMqICO+1m3J
 fbkBkGpnukIXm3TVsr3aWt6TACSc7P9VWcr9Lns71zraEVNioC/JtUMVTTLeoT1a2G4R
 B8vg==
X-Gm-Message-State: AOJu0YyAsvqGVlyDuzMuqW9OHRRhIpoCz0mcUfTv/BkVK2W6m8xmyZDw
 DMdbqnCrX/LlTA/ViCHqdUA=
X-Google-Smtp-Source: AGHT+IEA/PspN6A+jgi3Dot50VR82KgAH35UrD1d8zPljlGZHQ8FhU4xDnD0chJ1n0SGcgoA7gdJfQ==
X-Received: by 2002:ad4:5c88:0:b0:67f:fe7:c30c with SMTP id
 o8-20020ad45c88000000b0067f0fe7c30cmr10592407qvh.124.1702827468352; 
 Sun, 17 Dec 2023 07:37:48 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 z11-20020a0cfc0b000000b0067f2f144eadsm1083016qvo.57.2023.12.17.07.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 07:37:48 -0800 (PST)
Message-ID: <50cf8ef8-e81a-f517-2e6c-14399fb28a93@gmail.com>
Date: Sun, 17 Dec 2023 10:37:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
 <56f7d33e-88dd-edeb-9a1e-d79fd057b380@gmail.com>
 <ed3eb880-c0a5-4060-9727-18ffce40fc46@denx.de>
 <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
 <fb30f55f-90da-46e4-bd83-c1107faa2454@denx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <fb30f55f-90da-46e4-bd83-c1107faa2454@denx.de>
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

T24gMTIvMTcvMjMgMTA6MTksIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiAxMi8xNy8yMyAw
MjoyMCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDEyLzE2LzIzIDE5OjE5LCBNYXJl
ayBWYXN1dCB3cm90ZToNCj4+PiBPbiAxMi8xNi8yMyAxNzo1NiwgU2VhbiBBbmRlcnNvbiB3
cm90ZToNCj4+Pj4gT24gMTIvMTYvMjMgMTE6NTIsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4+
Pj4gT24gMTIvMTYvMjMgMTY6MzcsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4+Pj4gT24g
MTIvMTYvMjMgMDM6NDgsIFN2eWF0b3NsYXYgUnloZWwgd3JvdGU6DQo+Pj4+Pj4+IEV4aXN0
aW5nIGdwaW8tZ2F0ZS1jbG9jayBkcml2ZXIgYWN0cyBsaWtlIGEgc2ltcGxlIEdQSU8gc3dp
dGNoIHdpdGhvdXQgYW55DQo+Pj4+Pj4+IGVmZmVjdCBvbiBnYXRlZCBjbG9jay4gQWRkIGFj
dHVhbCBjbG9jayBhY3Rpb25zIGludG8gZW5hYmxlL2Rpc2FibGUgb3BzIGFuZA0KPj4+Pj4+
PiBpbXBsZW1lbnQgZ2V0X3JhdGUgb3AgYnkgcGFzc2luZyBnYXRlZCBjbG9jayBpZiBpdCBp
cyBlbmFibGVkLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdnlhdG9zbGF2
IFJ5aGVsIDxjbGFtb3I5NUBnbWFpbC5jb20+DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+PiDCoCBk
cml2ZXJzL2Nsay9jbGstZ3Bpby5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tDQo+Pj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jbGsvY2xrLWdwaW8uYyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4+Pj4+
Pj4gaW5kZXggMjZkNzk1Yjk3OC4uNzJkOTc0N2E0NyAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEv
ZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL2Nsay9jbGst
Z3Bpby5jDQo+Pj4+Pj4+IEBAIC0zLDE5ICszLDIzIEBADQo+Pj4+Pj4+IMKgwqAgKiBDb3B5
cmlnaHQgKEMpIDIwMjMgTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJv
eC5vcmc+DQo+Pj4+Pj4+IMKgwqAgKi8NCj4+Pj4+Pj4gLSNpbmNsdWRlIDxhc20vZ3Bpby5o
Pg0KPj4+Pj4+PiAtI2luY2x1ZGUgPGNvbW1vbi5oPg0KPj4+Pj4+PiAtI2luY2x1ZGUgPGNs
ay11Y2xhc3MuaD4NCj4+Pj4+Pj4gKyNpbmNsdWRlIDxjbGsuaD4NCj4+Pj4+Pj4gwqAgI2lu
Y2x1ZGUgPGRtLmg+DQo+Pj4+Pj4+ICsjaW5jbHVkZSA8Y2xrLXVjbGFzcy5oPg0KPj4+Pj4+
PiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPj4+Pj4+PiArDQo+Pj4+Pj4+
ICsjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4+Pj4+Pj4gwqAgc3RydWN0IGNsa19ncGlvX3By
aXYgew0KPj4+Pj4+PiAtwqDCoMKgIHN0cnVjdCBncGlvX2Rlc2PCoMKgwqAgZW5hYmxlOw0K
Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBncGlvX2Rlc2PCoMKgwqAgZW5hYmxlO8KgwqDCoCAv
KiBHUElPLCBjb250cm9sbGluZyB0aGUgZ2F0ZSAqLw0KPj4+Pj4+PiArwqDCoMKgIHN0cnVj
dCBjbGvCoMKgwqDCoMKgwqDCoCAqY2xrO8KgwqDCoCAvKiBHYXRlZCBjbG9jayAqLw0KPj4+
Pj4+PiDCoCB9Ow0KPj4+Pj4+PiDCoCBzdGF0aWMgaW50IGNsa19ncGlvX2VuYWJsZShzdHJ1
Y3QgY2xrICpjbGspDQo+Pj4+Pj4+IMKgIHsNCj4+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
Y2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+Pj4+Pj4+
ICvCoMKgwqAgY2xrX2VuYWJsZShwcml2LT5jbGspOw0KPj4+Pj4+PiDCoMKgwqDCoMKgIGRt
X2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5lbmFibGUsIDEpOw0KPj4+Pj4+PiDCoMKgwqDCoMKg
IHJldHVybiAwOw0KPj4+Pj4+PiBAQCAtMjYsMjEgKzMwLDQ1IEBAIHN0YXRpYyBpbnQgY2xr
X2dwaW9fZGlzYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4+Pj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+
Pj4+PiDCoMKgwqDCoMKgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5lbmFibGUsIDApOw0K
Pj4+Pj4+PiArwqDCoMKgIGNsa19kaXNhYmxlKHByaXYtPmNsayk7DQo+Pj4+Pj4+IMKgwqDC
oMKgwqAgcmV0dXJuIDA7DQo+Pj4+Pj4+IMKgIH0NCj4+Pj4+Pj4gK3N0YXRpYyB1bG9uZyBj
bGtfZ3Bpb19nZXRfcmF0ZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4+Pj4+ICt7DQo+Pj4+Pj4+
ICvCoMKgwqAgc3RydWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xr
LT5kZXYpOw0KPj4+Pj4+PiArDQo+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJuIGNsa19nZXRfcmF0
ZShwcml2LT5jbGspOw0KPj4+Pj4+PiArfQ0KPj4+Pj4+PiArDQo+Pj4+Pj4+IMKgIGNvbnN0
IHN0cnVjdCBjbGtfb3BzIGNsa19ncGlvX29wcyA9IHsNCj4+Pj4+Pj4gwqDCoMKgwqDCoCAu
ZW5hYmxlwqDCoMKgwqDCoMKgwqAgPSBjbGtfZ3Bpb19lbmFibGUsDQo+Pj4+Pj4+IMKgwqDC
oMKgwqAgLmRpc2FibGXCoMKgwqAgPSBjbGtfZ3Bpb19kaXNhYmxlLA0KPj4+Pj4+PiArwqDC
oMKgIC5nZXRfcmF0ZcKgwqDCoCA9IGNsa19ncGlvX2dldF9yYXRlLA0KPj4+Pj4+PiDCoCB9
Ow0KPj4+Pj4+PiAtc3RhdGljIGludCBjbGtfZ3Bpb19wcm9iZShzdHJ1Y3QgdWRldmljZSAq
ZGV2KQ0KPj4+Pj4+PiArc3RhdGljIGludCBjbGtfZ3Bpb19vZl90b19wbGF0KHN0cnVjdCB1
ZGV2aWNlICpkZXYpDQo+Pj4+Pj4+IMKgIHsNCj4+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
Y2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihkZXYpOw0KPj4+Pj4+PiArwqDC
oMKgIGludCByZXQ7DQo+Pj4+Pj4+IC3CoMKgwqAgcmV0dXJuIGdwaW9fcmVxdWVzdF9ieV9u
YW1lKGRldiwgImVuYWJsZS1ncGlvcyIsIDAsDQo+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcHJpdi0+ZW5hYmxlLCBHUElPRF9JU19PVVQpOw0K
Pj4+Pj4+PiArwqDCoMKgIHByaXYtPmNsayA9IGRldm1fY2xrX2dldChkZXYsIE5VTEwpOw0K
Pj4+Pj4+PiArwqDCoMKgIGlmIChJU19FUlIocHJpdi0+Y2xrKSkgew0KPj4+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgbG9nX2RlYnVnKCIlczogQ291bGQgbm90IGdldCBnYXRlZCBjbG9jazog
JWxkXG4iLA0KPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18s
IFBUUl9FUlIocHJpdi0+Y2xrKSk7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4g
UFRSX0VSUihwcml2LT5jbGspOw0KPj4+Pj4+PiArwqDCoMKgIH0NCj4+Pj4+Pj4gKw0KPj4+
Pj4+PiArwqDCoMKgIHJldCA9IGdwaW9fcmVxdWVzdF9ieV9uYW1lKGRldiwgImVuYWJsZS1n
cGlvcyIsIDAsDQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJnByaXYtPmVuYWJsZSwgR1BJT0RfSVNfT1VUKTsNCj4+Pj4+Pj4gK8KgwqDCoCBpZiAo
cmV0KSB7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBsb2dfZGVidWcoIiVzOiBDb3VsZCBu
b3QgZGVjb2RlIGVuYWJsZS1ncGlvcyAoJWQpXG4iLA0KPj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHJldCk7DQo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gcmV0Ow0KPj4+Pj4+PiArwqDCoMKgIH0NCj4+Pj4+Pj4gKw0KPj4+Pj4+PiAr
wqDCoMKgIHJldHVybiAwOw0KPj4+Pj4NCj4+Pj4+IEFsbCB0aGlzIGZvcndhcmRpbmcgb2Yg
Y2xvY2sgZW5hYmxlL2Rpc2FibGUvZ2V0X3JhdGUgZm9yIHBhcmVudCBjbG9jayBzaG91bGQg
YWxyZWFkeSBiZSBkb25lIGluIGNsb2NrIGNvcmUuIElmIGl0IGlzIG5vdCwgdGhlbiBpdCBz
aG91bGQgYmUgZml4ZWQgaW4gY2xvY2sgY29yZS4NCj4+Pj4NCj4+Pj4gT25seSBDQ0YgZm9y
d2FyZHMgdGhpbmdzLiBJdCdzIHVwIHRvIHRoZSBkcml2ZXIgdG8gZG8gaXQgaW4gdGhlIG5v
bi1DQ0YgY2FzZS4NCj4+Pg0KPj4+IFNoYWxsIHdlIGFkZCBkZXBlbmRlbmN5IG9uIENDRiBp
bnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGNvZGUgaW4gZHJpdmVycyA/DQo+Pg0KPj4gSSdkIHJh
dGhlciBub3QuIFRoaXMgd2lsbCBiZSB1c2VmdWwgb24gbm9uLUNDRiBzeXN0ZW1zLg0KPiAN
Cj4gVGhlbiB0aGUgZm9yd2FyZGluZyBmdW5jdGlvbmFsaXR5IHNob3VsZCBiZSBpbiB0aGUg
Y2xvY2sgY29yZSwgYmFzaWNhbGx5IGlmIGEgZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCBj
YWxsYmFjayA8c29tZXRoaW5nPiwgY2FsbCBwYXJlbnQgY2xvY2sgY2FsbGJhY2sgPHNvbWV0
aGluZz4sIGFuZCByZXBlYXQgdW50aWwgeW91IHJlYWNoIHRoZSB0b3Agb2YgdGhlIGNsb2Nr
IHRyZWUuIElmIHlvdSBkbyByZWFjaCB0aGUgdG9wLCBmYWlsIHdpdGggc29tZSBlcnJvciBj
b2RlLiBJc24ndCB0aGF0IGhvdyBjbG9jayBlbmFibGUgYWxyZWFkeSB3b3JrcyBhbnl3YXkg
Pw0KDQpOby4gSW4gdGhlIG5vbi1DQ0YgY2FzZSwgd2UgaGF2ZSBubyBpZGVhIHdoYXQgdGhl
IHBhcmVudCBvZiBhbnkgZ2l2ZW4gY2xvY2sgaXMuIFNvDQp0aGVyZSdzIG5vIGZyYW1ld29y
ayB3ZSBjYW4gcHJvdmlkZS4NCg0KTm93LCB5b3UgbWlnaHQgc2F5ICJ3aHkgbm90IGFkZCBh
IGdldF9wYXJlbnQgb3A/IiBXZWxsLCB0aGF0IHdpbGwgd29yayBmaW5lIGZvcg0KZW5hYmxp
bmcgdGhpbmdzLCBidXQgaXQgaXMgYSBiaXQgaGFpcnkgb24gdGhlIGRpc2FibGUgc2lkZS4g
WW91IHJlYWxseSBuZWVkIHRvIGhhdmUNCnJlZmNvdW50aW5nIHRvIHByb3RlY3QgcGFyZW50
IGNsb2NrcyAod2hpY2ggY2FuIGhhdmUgbWFueSBjaGlsZHJlbikuIEJ1dCB3ZSBkb24ndA0K
cmVhbGx5IGhhdmUgYW55d2hlcmUgdG8gc3RvcmUgcmVmY291bnRzLiBzdHJ1Y3QgY2xrIGhh
cyBhIG1lbWJlciBmb3IgaXQsIGJ1dCB0aGF0J3MNCm9ubHkgYmVjYXVzZSBpdCdzIGFidXNl
ZCBhcyBwcml2YXRlIGRhdGEgYnkgQ0NGLiBOb24tQ0NGIGNsb2NrcyBoYXZlIG5vIGNsb2Nr
DQpzdWJzeXN0ZW0gZGF0YSBhbGxvY2F0ZWQgYXQgYWxsLiBBbm90aGVyIGFsdGVybmF0aXZl
IGlzIHRvIGp1c3Qgb25seSBkaXNhYmxlIHRoZSBsZWFmDQpub2RlLCB3aGljaCBpcyB3aGF0
IHdlIGN1cnJlbnRseSBkby4gVGhhdCdzIE9LIEkgdGhpbmsuDQoNCkJ1dCB0aGF0IHNvbHV0
aW9uIHJlcXVpcmVzIHNvbWUgbW9yZS1pbnRlbnNpdmUgZWZmb3J0IHdoaWNoIEkgZG9uJ3Qg
d2FudCB0byBpbXBvc2Ugb24NCnJhbmRvbSBjb250cmlidXRvcnMuIFNvIGZvciB0aGUgdGlt
ZSBiZWluZywgYWxsIG5vbi1DQ0YgY2xvY2sgZHJpdmVycyBtdXN0IGhhbmRsZQ0KZW5hYmxp
bmcgdGhlaXIgb3duIHBhcmVudCBjbG9ja3MuDQoNCi0tU2Vhbg0K
