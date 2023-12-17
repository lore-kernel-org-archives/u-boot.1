Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F35C41535
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 01:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9557B87727;
	Sun, 17 Dec 2023 02:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXxXgz8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD13877A9; Sun, 17 Dec 2023 02:20:12 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5658D8771E
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 02:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f36efcab8so2529436d6.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702776009; x=1703380809; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fCuzRZpylGDIeX/qUAFotgLPmdbEbiS6Hx+7js9FgzQ=;
 b=GXxXgz8n6RJIyHy4OY0iMwnTstm/OqkQGk5IzqhiQxeOdwPiMGcYU/h7PPeoMuT6ii
 9Wovayao878GAy8xb3mQ5reG5IRrB5CFCYTcpzjmOcoSZitDlGfGwdaDKHLeYb0o/2T2
 f1qIWKS3fxY/XCSIbLTOBK57bwX8fOci/Qubivh1izFBhprz7wRgrVraxVGLNw10jYOA
 Vj+BE/dKNzQfhuhyf9YpSvQFQ68T4mHWSBY/+77PTS9w2Q+EWgUGsAm0hnCO9YHa6fNW
 NyjkOqfGQI0b0HifouNd95VLrOoMJofhpUAVQ66cFd8Me+SR/jDiaiAiFMGHI0zsOJ1h
 6O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702776009; x=1703380809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fCuzRZpylGDIeX/qUAFotgLPmdbEbiS6Hx+7js9FgzQ=;
 b=DolyFnvJsRq+pmHTZWNB1UMXnS+GonKioWz5HPSm8OI0MKlMKYeMo8X9raoylVSC4J
 r6ClZKSXfxy9BxZoBdHQDg+f6S3tqu2wQCxlN8F3s17b92/67weR/Ipr2uT3KyZSd7uv
 MXjqJN2ruwAv2wHhZnsFS7BEgSl4agbqFxZTmztaLEYcYJaSEqaZLnmm/b+MoYbj1AQg
 eRGjz981Ga0vYVJcyW7Gy6WBTs//kmMKwzQAjqKKx2BX8cA6HmEWPz6npvpBm+4Ao+JZ
 5BqXeimd3wlQMI/Xff/fcRnPq335xLhRiSc2XXTOB4XvZPfMAyiDjZ+THJx35Yyn/A/j
 fHxA==
X-Gm-Message-State: AOJu0YwCXkafrcFvUP+csFUcw0t2Tcdd9+eFEW5SlG8kTidyvfW+RTza
 3E+Ody4h3XIeKrN28yGYo3o=
X-Google-Smtp-Source: AGHT+IGFfJ2VCPGTUFafJH6QgMvznL/skOncpLtH7rrxj/VduKSu80aYAGTmnBxVDpKPaQ9TGFdVag==
X-Received: by 2002:ad4:5d42:0:b0:67f:206a:b23f with SMTP id
 jk2-20020ad45d42000000b0067f206ab23fmr5832291qvb.111.1702776009092; 
 Sat, 16 Dec 2023 17:20:09 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 dd18-20020ad45812000000b0067aa94409e9sm8214155qvb.18.2023.12.16.17.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 17:20:08 -0800 (PST)
Message-ID: <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
Date: Sat, 16 Dec 2023 20:20:08 -0500
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
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <ed3eb880-c0a5-4060-9727-18ffce40fc46@denx.de>
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

T24gMTIvMTYvMjMgMTk6MTksIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiAxMi8xNi8yMyAx
Nzo1NiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDEyLzE2LzIzIDExOjUyLCBNYXJl
ayBWYXN1dCB3cm90ZToNCj4+PiBPbiAxMi8xNi8yMyAxNjozNywgU2VhbiBBbmRlcnNvbiB3
cm90ZToNCj4+Pj4gT24gMTIvMTYvMjMgMDM6NDgsIFN2eWF0b3NsYXYgUnloZWwgd3JvdGU6
DQo+Pj4+PiBFeGlzdGluZyBncGlvLWdhdGUtY2xvY2sgZHJpdmVyIGFjdHMgbGlrZSBhIHNp
bXBsZSBHUElPIHN3aXRjaCB3aXRob3V0IGFueQ0KPj4+Pj4gZWZmZWN0IG9uIGdhdGVkIGNs
b2NrLiBBZGQgYWN0dWFsIGNsb2NrIGFjdGlvbnMgaW50byBlbmFibGUvZGlzYWJsZSBvcHMg
YW5kDQo+Pj4+PiBpbXBsZW1lbnQgZ2V0X3JhdGUgb3AgYnkgcGFzc2luZyBnYXRlZCBjbG9j
ayBpZiBpdCBpcyBlbmFibGVkLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFN2eWF0
b3NsYXYgUnloZWwgPGNsYW1vcjk1QGdtYWlsLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gwqAg
ZHJpdmVycy9jbGsvY2xrLWdwaW8uYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLQ0KPj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2Nsay1ncGlvLmMgYi9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4+PiBpbmRl
eCAyNmQ3OTViOTc4Li43MmQ5NzQ3YTQ3IDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9j
bGsvY2xrLWdwaW8uYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0KPj4+
Pj4gQEAgLTMsMTkgKzMsMjMgQEANCj4+Pj4+IMKgwqAgKiBDb3B5cmlnaHQgKEMpIDIwMjMg
TWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+DQo+Pj4+PiDC
oMKgICovDQo+Pj4+PiAtI2luY2x1ZGUgPGFzbS9ncGlvLmg+DQo+Pj4+PiAtI2luY2x1ZGUg
PGNvbW1vbi5oPg0KPj4+Pj4gLSNpbmNsdWRlIDxjbGstdWNsYXNzLmg+DQo+Pj4+PiArI2lu
Y2x1ZGUgPGNsay5oPg0KPj4+Pj4gwqAgI2luY2x1ZGUgPGRtLmg+DQo+Pj4+PiArI2luY2x1
ZGUgPGNsay11Y2xhc3MuaD4NCj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVy
Lmg+DQo+Pj4+PiArDQo+Pj4+PiArI2luY2x1ZGUgPGFzbS9ncGlvLmg+DQo+Pj4+PiDCoCBz
dHJ1Y3QgY2xrX2dwaW9fcHJpdiB7DQo+Pj4+PiAtwqDCoMKgIHN0cnVjdCBncGlvX2Rlc2PC
oMKgwqAgZW5hYmxlOw0KPj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjwqDCoMKgIGVu
YWJsZTvCoMKgwqAgLyogR1BJTywgY29udHJvbGxpbmcgdGhlIGdhdGUgKi8NCj4+Pj4+ICvC
oMKgwqAgc3RydWN0IGNsa8KgwqDCoMKgwqDCoMKgICpjbGs7wqDCoMKgIC8qIEdhdGVkIGNs
b2NrICovDQo+Pj4+PiDCoCB9Ow0KPj4+Pj4gwqAgc3RhdGljIGludCBjbGtfZ3Bpb19lbmFi
bGUoc3RydWN0IGNsayAqY2xrKQ0KPj4+Pj4gwqAgew0KPj4+Pj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgY2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+Pj4+
PiArwqDCoMKgIGNsa19lbmFibGUocHJpdi0+Y2xrKTsNCj4+Pj4+IMKgwqDCoMKgwqAgZG1f
Z3Bpb19zZXRfdmFsdWUoJnByaXYtPmVuYWJsZSwgMSk7DQo+Pj4+PiDCoMKgwqDCoMKgIHJl
dHVybiAwOw0KPj4+Pj4gQEAgLTI2LDIxICszMCw0NSBAQCBzdGF0aWMgaW50IGNsa19ncGlv
X2Rpc2FibGUoc3RydWN0IGNsayAqY2xrKQ0KPj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgY2xr
X2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+Pj4+PiDCoMKg
wqDCoMKgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5lbmFibGUsIDApOw0KPj4+Pj4gK8Kg
wqDCoCBjbGtfZGlzYWJsZShwcml2LT5jbGspOw0KPj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4g
MDsNCj4+Pj4+IMKgIH0NCj4+Pj4+ICtzdGF0aWMgdWxvbmcgY2xrX2dwaW9fZ2V0X3JhdGUo
c3RydWN0IGNsayAqY2xrKQ0KPj4+Pj4gK3sNCj4+Pj4+ICvCoMKgwqAgc3RydWN0IGNsa19n
cGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+Pj4gKw0KPj4+
Pj4gK8KgwqDCoCByZXR1cm4gY2xrX2dldF9yYXRlKHByaXYtPmNsayk7DQo+Pj4+PiArfQ0K
Pj4+Pj4gKw0KPj4+Pj4gwqAgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xrX2dwaW9fb3BzID0g
ew0KPj4+Pj4gwqDCoMKgwqDCoCAuZW5hYmxlwqDCoMKgwqDCoMKgwqAgPSBjbGtfZ3Bpb19l
bmFibGUsDQo+Pj4+PiDCoMKgwqDCoMKgIC5kaXNhYmxlwqDCoMKgID0gY2xrX2dwaW9fZGlz
YWJsZSwNCj4+Pj4+ICvCoMKgwqAgLmdldF9yYXRlwqDCoMKgID0gY2xrX2dwaW9fZ2V0X3Jh
dGUsDQo+Pj4+PiDCoCB9Ow0KPj4+Pj4gLXN0YXRpYyBpbnQgY2xrX2dwaW9fcHJvYmUoc3Ry
dWN0IHVkZXZpY2UgKmRldikNCj4+Pj4+ICtzdGF0aWMgaW50IGNsa19ncGlvX29mX3RvX3Bs
YXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4+Pj4+IMKgIHsNCj4+Pj4+IMKgwqDCoMKgwqAg
c3RydWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4+Pj4+
ICvCoMKgwqAgaW50IHJldDsNCj4+Pj4+IC3CoMKgwqAgcmV0dXJuIGdwaW9fcmVxdWVzdF9i
eV9uYW1lKGRldiwgImVuYWJsZS1ncGlvcyIsIDAsDQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnByaXYtPmVuYWJsZSwgR1BJT0RfSVNfT1VUKTsN
Cj4+Pj4+ICvCoMKgwqAgcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo+
Pj4+PiArwqDCoMKgIGlmIChJU19FUlIocHJpdi0+Y2xrKSkgew0KPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGxvZ19kZWJ1ZygiJXM6IENvdWxkIG5vdCBnZXQgZ2F0ZWQgY2xvY2s6ICVsZFxu
IiwNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgUFRSX0VS
Uihwcml2LT5jbGspKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihw
cml2LT5jbGspOw0KPj4+Pj4gK8KgwqDCoCB9DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgIHJl
dCA9IGdwaW9fcmVxdWVzdF9ieV9uYW1lKGRldiwgImVuYWJsZS1ncGlvcyIsIDAsDQo+Pj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZwcml2LT5lbmFibGUs
IEdQSU9EX0lTX09VVCk7DQo+Pj4+PiArwqDCoMKgIGlmIChyZXQpIHsNCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBsb2dfZGVidWcoIiVzOiBDb3VsZCBub3QgZGVjb2RlIGVuYWJsZS1ncGlv
cyAoJWQpXG4iLA0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fZnVuY19f
LCByZXQpOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4+PiArwqDC
oMKgIH0NCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+Pj4NCj4+PiBBbGwg
dGhpcyBmb3J3YXJkaW5nIG9mIGNsb2NrIGVuYWJsZS9kaXNhYmxlL2dldF9yYXRlIGZvciBw
YXJlbnQgY2xvY2sgc2hvdWxkIGFscmVhZHkgYmUgZG9uZSBpbiBjbG9jayBjb3JlLiBJZiBp
dCBpcyBub3QsIHRoZW4gaXQgc2hvdWxkIGJlIGZpeGVkIGluIGNsb2NrIGNvcmUuDQo+Pg0K
Pj4gT25seSBDQ0YgZm9yd2FyZHMgdGhpbmdzLiBJdCdzIHVwIHRvIHRoZSBkcml2ZXIgdG8g
ZG8gaXQgaW4gdGhlIG5vbi1DQ0YgY2FzZS4NCj4gDQo+IFNoYWxsIHdlIGFkZCBkZXBlbmRl
bmN5IG9uIENDRiBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGNvZGUgaW4gZHJpdmVycyA/DQoN
CkknZCByYXRoZXIgbm90LiBUaGlzIHdpbGwgYmUgdXNlZnVsIG9uIG5vbi1DQ0Ygc3lzdGVt
cy4NCg0KLS1TZWFuDQo=
