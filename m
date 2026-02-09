Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA29E81BCB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 14:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81342839A5;
	Mon,  9 Feb 2026 15:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLoZoEIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387D383BF4; Mon,  9 Feb 2026 15:24:55 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB478341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 15:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso3328611b3a.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770647091; x=1771251891; darn=lists.denx.de;
 h=mime-version:msip_labels:content-language:accept-language
 :in-reply-to:references:message-id:date:thread-index:thread-topic
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fqMAwc0O3PrD3wH0QSIMfjXJEbN63AQmN1hi0kx1qP8=;
 b=hLoZoEIN2Qn38ClxIhs/SKXwgmsn2umY+vidEeUVO871HKaKP0sH8vEi0fmLMotglJ
 3c6kTLJVrpBcaUTldq5syj2RRaJ7gHFJ11tSvAyPcrBvQeaEBEW/5WJQL6aNPcajst0Z
 R4B4ncdZv8QegAbKd5tN87YdYNBv9DEkmx3C/H0nFXrk0fzx/SayuTRXpfzsfNrnvfR2
 KyBwlYEYgRIqiji7Q8WYLGhn79FVFRCsJvXBqE59CeZFkQH7bJSEi5N9qftuVBUGnvGF
 8Q7cqbirhv4CB5JhAv34U1jBjlq5egOtwxFe1XQeM4El5WIyewZoTWTMic82ITKYetBd
 HGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770647091; x=1771251891;
 h=mime-version:msip_labels:content-language:accept-language
 :in-reply-to:references:message-id:date:thread-index:thread-topic
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fqMAwc0O3PrD3wH0QSIMfjXJEbN63AQmN1hi0kx1qP8=;
 b=ZS9/iDqDAVrrofiR5UR1W9/gQDBdWyUeZi3tjlo6BP/vnT6dn/VyQAlb8eLPyzZXhp
 35Qb9h0u+Jp3i1qgVcRKfJjCQwBCLKyCcbNU/KP+DTmKZksW9ipVocfg4zZBPOnXfL6Y
 d8N9gfAPQO5g+bU0EIc0lfPP25lBYaOJRxK32Af7b6qCgoo8vG3MkUObyfc6PCeTHa2Q
 iEs+vo8+erMOxB6zklizdbz8xL39ZES3GzptS2kTt51WRy1VoSYNc4+LI/irSth3nZxx
 IuPQn6jrIqmXeWQ/fG/ZPcAildggBkuXARyPWEuZfPog3gvO4RnrfVHOa158Zp+bb7tX
 iV8A==
X-Gm-Message-State: AOJu0YxKP6X/p13MakmLXl8PUzvmEJZxmeSBhgoLmTB7mmkEtnvCJA5w
 syoaj/0sivT3CiYGikfZ8nAVStWV84wVxNyrQ6dVcWqqSL5jFOOdybjC
X-Gm-Gg: AZuq6aJJZ280iqHngED1ULNAc71ECVKEIHjomNaoZA9IEk8Zq6xNuj42AnMIK0sslhW
 FHSI5dRyOzgzi8i47JKaxDCXPH7sxX4axvHLqFGNkbXe0OMkgmvkyRGkG+WfUCLXtM+VToIpVWf
 LGdqnD1duBLdBoYFnnE/lthK507gdRpmleduZFiT75Gt8b3u8B1Vbk6H7X9IpmgVsirJeY5jrpT
 HGDgBawF8iP3HYdMxk+LftpYRzvT8nSvSXSCgCviObWPAQohk3CPNIsw33a/WucwpXjL2/abT8G
 scCdY9eZ0IxicWTGNNUkT0Z3Tsvn/44jpiTnRreHeXavc2W5i4yvNEc/Ejoj4hVYRkIqG4z/TGc
 Obxk5xHlYwsgucjHpACCvxpvxgZhD1ZFsthSYUFYSd0V21GNrHmvy5eunmsFPYdXmpkPsL8zkMo
 cQooIH53OM9u2zwanRbxENsZhxu6Ak2a/w/TNX+SkNpD1JTcuN5w6fFreJCbIigeMo4coN3vA5R
 A==
X-Received: by 2002:a05:6a21:7002:b0:38d:eef7:6acf with SMTP id
 adf61e73a8af0-393ad020846mr10827554637.31.1770647091095; 
 Mon, 09 Feb 2026 06:24:51 -0800 (PST)
Received: from DM3PR20MB6937.namprd20.prod.outlook.com
 ([2603:1036:301:1018::5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb4fb808sm10308414a12.6.2026.02.09.06.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 06:24:50 -0800 (PST)
From: Caleb Ethridge <jcethrid@gmail.com>
To: Greg Malysa <malysagreg@gmail.com>, Philip Molloy
 <philip@philipmolloy.com>, Utsav Agarwal <utsav.agarwal@analog.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "caleb.ethridge@analog.com"
 <caleb.ethridge@analog.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "linux@analog.com" <linux@analog.com>
Subject: Re: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
Thread-Topic: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
Thread-Index: AUF5K0E9ram+MzDnHWpmOmizHyjzgGc3U3BRsweNyNo=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 9 Feb 2026 14:24:48 +0000
Message-ID: <DM3PR20MB693750F87513B2C46B679EF6A065A@DM3PR20MB6937.namprd20.prod.outlook.com>
References: <CAA=Y9tYS6=KJDyMYK5VAR5JDiv57M+MAv+i-m3cykb=nCtv3qA@mail.gmail.com>
 <CABdDSeUX_QrW6KE0aeepbFZNmiFCYSG4-h4A5kO7zwG--9u2og@mail.gmail.com>
In-Reply-To: <CABdDSeUX_QrW6KE0aeepbFZNmiFCYSG4-h4A5kO7zwG--9u2og@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels: 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Feb 2026 15:34:42 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgR3JlZywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgd2lsbCBzZW5kIGEgdjIgb2Yg
dGhlIHBhdGNoIHdpdGggc29tZSBtb3JlIGluZm9ybWF0aW9uIGluIHRoZSBjb21taXQgbWVzc2Fn
ZS4NCg0KVGhhbmtzLA0KQ2FsZWINCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KRnJvbTogR3JlZyBNYWx5c2EgPG1hbHlzYWdyZWdAZ21haWwuY29tPg0KU2VudDogTW9uZGF5
LCBGZWJydWFyeSA5LCAyMDI2IDE6MzggQU0NClRvOiBDYWxlYiBFdGhyaWRnZSA8amNldGhyaWRA
Z21haWwuY29tPjsgUGhpbGlwIE1vbGxveSA8cGhpbGlwQHBoaWxpcG1vbGxveS5jb20+OyBVdHNh
diBBZ2Fyd2FsIDx1dHNhdi5hZ2Fyd2FsQGFuYWxvZy5jb20+DQpDYzogdS1ib290QGxpc3RzLmRl
bnguZGUgPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgY2FsZWIuZXRocmlkZ2VAYW5hbG9nLmNvbSA8
Y2FsZWIuZXRocmlkZ2VAYW5hbG9nLmNvbT47IHRyaW5pQGtvbnN1bGtvLmNvbSA8dHJpbmlAa29u
c3Vsa28uY29tPjsgbGludXhAYW5hbG9nLmNvbSA8bGludXhAYW5hbG9nLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGFybTogZHRzOiBzYzU5NDogVXBkYXRlIHNjNTk0IEVaS0lUIEdQSU8gcG9s
YXJpdGllcw0KDQpIaSBDYWxlYiwNCg0KK0NDOiBQaGlsaXAgYW5kIFV0c2F2LCBpdCBsb29rcyBs
aWtlIGdpdC1lbWFpbCBkaWQgbm90IHBpY2sgdXAgdGhlIGNjDQpvdXRwdXQgZnJvbSBnZXRfbWFp
bnRhaW5lci5wbC4NCg0KT24gVGh1LCBGZWIgNSwgMjAyNiBhdCAxMTo1OOKAr0FNIENhbGViIEV0
aHJpZGdlIDxqY2V0aHJpZEBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBDYWxlYiBFdGhy
aWRnZSA8Y2FsZWIuZXRocmlkZ2VAYW5hbG9nLmNvbT4NCj4gRGF0ZTogVHVlLCAzIEZlYiAyMDI2
IDE0OjQ1OjUzIC0wNTAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gYXJtOiBkdHM6IHNjNTk0OiBVcGRh
dGUgc2M1OTQgRVpLSVQgR1BJTyBwb2xhcml0aWVzDQo+DQo+IFVwZGF0ZXMgdGhlIHBvbGFyaXRp
ZXMgZm9yIHRoZSBHUElPcyBvbiB0aGUgc2M1OTQNCj4gRVpLSVQsIGFzIHRoZSBjdXJyZW50IHZl
cnNpb24gd2FzIHN0aWxsIG9uIGFuIG9sZA0KPiByZXZpc2lvbiBvZiB0aGUgaGFyZHdhcmUuIFRo
ZSBHUElPcyBub3cgbWF0Y2ggdGhlDQo+IHNjNTk4IEVaS0lUIGFzIGV4cGVjdGVkLg0KPg0KPiBG
aXhlczogYmU3OTM3OCAoImJvYXJkOiBhZGk6IEFkZCBzdXBwb3J0IGZvciBTQzU5NCIpDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IENhbGViIEV0aHJpZGdlIDxjYWxlYi5ldGhyaWRnZUBhbmFsb2cuY29t
Pg0KDQpDYW4gd2UgYWRkIGEgYml0IG1vcmUgZGV0YWlsIHRvIHRoZSBjb21taXQgbWVzc2FnZT8g
V2VyZSB0aGUgR1BJTw0KcG9sYXJpdGllcyBpbmNvcnJlY3QgYmVmb3JlLCBvciBhcmUgdGhlIHBv
bGFyaXRpZXMgZGlmZmVyZW50IGJldHdlZW4NCnR3byByZXZpc2lvbnMgb2YgdGhlIFNPTT8gV2Ug
d2FudCB0byBtYWtlIHN1cmUgdGhhdCBpZiBhIGN1c3RvbWVyIHdpdGgNCmFuIG9sZGVyIFNPTSB1
c2VzIG1haW5saW5lIGFuZCBmaW5kcyB0aGF0IHRoZXkgY2Fubm90IGFjY2VzcyBvY3RhbCBzcGkN
CmZsYXNoLCB0aGF0IHRoZXkgY2FuIGZpbmQgaW5mb3JtYXRpb24gc2F5aW5nIHNwZWNpZmljYWxs
eSB0aGF0IHRoZWlyDQp2ZXJzaW9uIGlzIG5vdCBzdXBwb3J0ZWQgYnkgZGVmYXVsdC4NCg0KPiAg
IG9jdGFsIHsNCj4gICBncGlvLWhvZzsNCj4gLSBncGlvcyA9IDw4IEdQSU9fQUNUSVZFX0hJR0g+
Ow0KPiArIGdwaW9zID0gPDggR1BJT19BQ1RJVkVfTE9XPjsNCj4gICBvdXRwdXQtbG93Ow0KPiAg
IGxpbmUtbmFtZSA9ICJvY3RhbC1zcGktY3MtZW4iOw0KPiAgIGJvb3RwaC1wcmUtcmFtOw0KPiAt
LQ0KPiAyLjM0LjENCg0KSSBhc3N1bWUgdGhpcyB3aWxsIGJlIHNpbWlsYXIgdG8gdGhlIGNvcnJl
c3BvbmRpbmcgY2hhbmdlIGZvciB0aGUNClNDNTk4IHRoYXQgSSBtZW50aW9uZWQgY2F1c2VkIGFs
bCBTUEkgZmxhc2ggdG8gc3RvcCB3b3JraW5nIGZvciBtZSBvbg0KUmV2IEMvRC4gTHVja2lseSBv
biB0aGUgU0M1OTQgU09NIHRoZSBmbGFzaCBjb25mbGljdCBpcyBkaWZmZXJlbnQsIHNvDQpJIGRv
bid0IGFudGljaXBhdGUgaXQgdG8gcHJldmVudCBpdCBmcm9tIHJ1bm5pbmcgZW50aXJlbHksIGJ1
dCBJIGRvDQp3YW50IHBlb3BsZSB0byBrbm93IHdoeSBpZiB0aGV5IHNlZSBzdHJhbmdlIGJlaGF2
aW9yLg0KDQpUaGFua3MsDQpHcmVnDQo=
