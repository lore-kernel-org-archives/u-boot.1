Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051EEC531E4
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 04:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563CD83946;
	Fri, 20 Feb 2026 05:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCqTdo9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46AF83AA9; Fri, 20 Feb 2026 05:04:50 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956018366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 05:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-895498f3819so2594696d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 20:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771560287; x=1772165087; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LibYZpVRGCdbwWUQoCy6W+Xr8sG8HdPyASgkptpoZz4=;
 b=HCqTdo9EwC/MEIgyJMb6jqPIIdEguQmZeYZisR075TOO1xjrdYrEjGb/RiMaH0U+GY
 z4WTChq1qcR5AWRLk2rRl0ZhQOGf+TA0KNMWknHOk2NRZ80VPZ6hhdV+HgZOZdNMdYQR
 TBdxPuj1nTcK0WqAWuH+ytUJ2b5W5dThkQBSAgF6SBUCymi+etpuO/uHvJM8FPWsae8x
 mF9pxVSqELkLGcScwFFWaV/PKAg3grQpWteRiQUPpx4BT0ahV/CJsmn3SvBjkSK0SV2c
 KLDQ7A75dd0rlD6j2EyJbDOrIObATXvCLB8GXFAiDeXuKUvVaS6Rl5LBurTirb+JVvfr
 udzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771560287; x=1772165087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LibYZpVRGCdbwWUQoCy6W+Xr8sG8HdPyASgkptpoZz4=;
 b=OPxt/1fCRmqSra5kTVGxYjGO2cMC8WYwraSoUWLFLnZXEU/mw0vkxnvQKlayEi/28Q
 WRf15U9oge+kkDAEkzICE2VKZCUYzlomelawxLwI8wfz/DV0DG0ZwcPbu1arNP9M6ASb
 ON4l+jmyjdPCu5uFNXxFm9MvRE8gCNzFrYXyExKy8W7w7DyNu/QDphjdjatBXJPsX+pA
 p61jxCxEtoYs4diJrRxvgwNiI+UK0JpplbB0D53okxZPNziYIlphDIS1jai8OFoAhrfb
 dPgQvK+U+9/gw/bmFwwjEvqhDgkKmhyG3tFkmC/wG21v7pSEB22ljV7stEeR+VrMIqN7
 0vHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUjAESu2OK2eLE08uw7SiskJ5ZN0BgmT+j8MGb45QMAs+cJdCYK16IclGzijwemiCNk6Pt5x0=@lists.denx.de
X-Gm-Message-State: AOJu0YxS21qsXEWkMfjREcLvbh/w635J+Eg60w2QvwiVelhXT2uw8kFe
 YoEbAoQ4rOpijUTgTPDWFlD3VBSytL26vIQxbIH2R2phZNP5q/Jt1QL5
X-Gm-Gg: AZuq6aLdLF30KVqTDlscBUAPDTzeN0Lc37TxkprY9zBE3+FsD+sKpEkD4DXnZHEuwQG
 F/PGIP7P3USA51jzq0BEEV2rJHVQwge2nlskB6bLThNCLtctrYerIdjoz93yV8foUzpC8ORq/AP
 HZfk+0Bzfra5b8zL8b7pp8q9FRI7C3i9p8sHWEEY7JumRhZAA21nrkGswGO3HO+TZHKZxdSawg9
 T3BE2YWIZ7vq/EPaHCiW35WIYZPiQ2nQxkXtP2iiApPYl7T46DJ2begn+ogZUFPQPQGwIjRWviq
 qy8aYJQoyk1gs5KC7Vma2DZOJqhMWiOMmLZpFsw/gXrxOj0tB1o0uqFo92h8GGNS9wB4lGq7I7E
 JjnysjIcFdEIeKMGBqzHI7kvfTVkk2CEQVlC8RQ9fiTfGgGyftU7jLhonM1XimCVUzLTcCiF+5V
 SsW3pTTDp9nHvZaYUm08D7hQYL3+AnGARMQFlwDSMzNdfXZxN4GsIpk2WO2BWFIx3MqhQ=
X-Received: by 2002:a05:6214:6014:b0:894:9d67:7329 with SMTP id
 6a1803df08f44-897346fe806mr234325296d6.2.1771560287120; 
 Thu, 19 Feb 2026 20:04:47 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971c8e60a0sm224849426d6.0.2026.02.19.20.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 20:04:46 -0800 (PST)
Message-ID: <2b329216-f2f8-88b4-f63d-370d3640e4e7@gmail.com>
Date: Thu, 19 Feb 2026 23:04:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, sumit.garg@kernel.org,
 casey.connolly@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
 <3fe5e11d-7240-c577-64fc-062d5c5e4d6a@gmail.com>
 <497f7e07-3a5c-4a7a-b2bb-9016d6927ba4@oss.qualcomm.com>
 <96a3a5e8-a853-b766-a013-d3db6bfce117@gmail.com>
 <23fa6538-d69b-4f59-9e36-f3cf2c6dd543@oss.qualcomm.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <23fa6538-d69b-4f59-9e36-f3cf2c6dd543@oss.qualcomm.com>
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

T24gMi8xOS8yNiAwNjoyNCwgQXN3aW4gTXVydWdhbiB3cm90ZToNCj4gSGkgU2VhbiwNCj4g
DQo+IE9uIDIvMTgvMjAyNiA3OjM3IEFNLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4gT24g
Mi8xNy8yNiAxNDowNSwgQXN3aW4gTXVydWdhbiB3cm90ZToNCj4+PiBIaSBTZWFuLA0KPj4+
DQo+Pj4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KPj4+IFRvIGFkZHJlc3Mgc3RhY2sg
c21hc2hpbmcsIHdoaWNoIG9jY3VycyB3aGVuIHRoZSBjZWxsIHNpemUgaXMgbGFyZ2VyIHRo
YW4gNCBieXRlcywgSSB3aWxsIHJldmVydCB0aGUgYG52bWVtX2NlbGxfcmVhZCgpYCBjYWxs
IGluIGByZWJvb3RfbW9kZV9nZXQoKWAgdG8gcGFzcyBgc2l6ZW9mKCptb2RlKWAgYXMgdGhl
IHNpemUsIGNvbnNpc3RlbnQgd2l0aCB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24uDQo+
Pj4NCj4+PiBJbnNpZGUgYG52bWVtX2NlbGxfcmVhZCgpYCwgd2lsbCBtb2RpZnkgdGhlIHZh
bGlkYXRpb24gY2hlY2suIEluc3RlYWQgb2YgZW5mb3JjaW5nIGBzaXplID09IGNlbGwtPnNp
emVgLCB3aWxsIGNoZWNrIGlmIGBjZWxsLT5zaXplYCBpcyB3aXRoaW4gdGhlIHBhc3NlZCBg
c2l6ZWAgKGkuZS4sIGBjZWxsLT5zaXplIDw9IHNpemVgKSB0byBjb3JyZWN0bHkgc3VwcG9y
dCBvdXIgMS1ieXRlIHJlYWQgY2FzZSB3aGVyZSB0aGUgYnVmZmVyIGlzIDQgYnl0ZXMuDQo+
Pg0KPj4gVGhlbiBkb24ndCB3ZSBuZWVkIHRvIHplcm8gb3V0IHRoZSByZXN0IG9mIHRoZSBi
dWZmZXI/DQo+Pg0KPj4gSSB3b3VsZCBleHBlY3QgdGhlIGNoZWNrIHRvIGJlDQo+Pg0KPj4g
aWYgKChjZWxsLT5iaXRfb2Zmc2V0ICYmIHNpemUgPiBjZWxsLT5zaXplKSB8fCBzaXplICE9
IGNlbGwtPnNpemUpDQo+PiDCoMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPj4NCj4+PiBBbHNv
LCBpMmNfZWVwcm9tX3JlYWQoKSBhbmQgbWlzY19yZWFkKCkgd2lsbCBjb250aW51ZSB0byBy
ZXF1ZXN0IGEgcmVhZCBmb3IgY2VsbC0+c2l6ZSBpbnN0ZWFkIG9mIHRoZSBwYXNzZWQgYnVm
ZmVyIHNpemUsIGVuc3VyaW5nIHdlIG9ubHkgcmVhZCB0aGUgdmFsaWQgZGF0YSBmcm9tIHRo
ZSBoYXJkd2FyZS4NCj4+Pg0KPj4+IFJlZ2FyZGluZyB0aGUgYml0IGZpZWxkIGxvZ2ljLCBh
cyB5b3Ugc3VnZ2VzdGVkIHdpbGwgc2ltcGxpZnkgdGhlIGJpdOKAkWZpZWxkIGhhbmRsaW5n
IHRvIG1heCB1MzIgc2l6ZSwgd2hpY2ggc2lnbmlmaWNhbnRseSByZWR1Y2VzIHRoZSBjb2Rl
IGNvbXBsZXhpdHkuIEdpdmVuIHRoaXMgc2ltcGxpZmljYXRpb24sIGlzIGl0IHN0aWxsIG5l
Y2Vzc2FyeSB0byBrZWVwIHRoaXMgYml04oCRbWFuaXB1bGF0aW9uIGxvZ2ljIGJlaGluZCBh
IHNlcGFyYXRlIGNvbmZpZyBvcHRpb24/DQo+Pg0KPj4gSSB0aGluayBpdCdzIGxpa2VseS4g
WW91IGNhbiBjaGVjayB0aGUgZ3Jvd3RoIHdpdGggc2NyaXB0cy9ibG9hdC1vLW1ldGVyIGlu
DQo+PiBMaW51eC4gU2luY2UgdGhpcyBpcyBtYWlubHkgZm9yIFUtQm9vdCBwcm9wZXIgSSdk
IHNheSBhIGNvdXBsZSBodW5kcmVkIGJ5dGVzDQo+PiBpcyByZWFzb25hYmxlIGZvciB0aGlz
IGZlYXR1cmUuDQo+Pg0KPj4+IEtpbmRseSBjb25maXJtIGlmIHRoaXMgYXBwcm9hY2ggYWxp
Z25zIHdpdGggeW91ciBleHBlY3RhdGlvbnMuIA0KPj4NCj4+IFBsZWFzZSByZW1lbWJlciB0
byByZXBseSBvbiB0aGUgYm90dG9tIDopDQo+Pg0KPj4gLS1TZWFuDQo+IA0KPiBUaGUgc3Vn
Z2VzdGVkIGNoZWNrIHdpbGwgZmFpbCBmb3Igb3VyIGNhc2UsIHdlIGFsd2F5cyBwYXNzIHNp
emUgPSBzaXplb2YodTMyKSA9IDQgYnl0ZXMgcmVnYXJkbGVzcyBvZiB0aGUgYWN0dWFsIGNl
bGwgc2l6ZS4NCj4gDQo+IEV4YW1wbGU6IDEtYnl0ZSBjZWxsIHdpdGggNy1iaXQgZmllbGQN
Cj4gDQo+IGNlbGwtPnNpemUgPSAxLCBiaXRfb2Zmc2V0ID0gMSwgbmJpdHMgPSA3LCBzaXpl
ID0gNA0KPiANCj4gV2l0aCBzdWdnZXN0ZWQgY2hlY2s6IGlmICgoY2VsbC0+Yml0X29mZnNl
dCAmJiBzaXplID4gY2VsbC0+c2l6ZSkgfHwgc2l6ZSAhPSBjZWxsLT5zaXplKSAtPiAoMSAm
JiA0ID4gMSkgfHwgNCAhPSAxIC0+IFRSVUUgLT4gcmVqZWN0cyB2YWxpZCBjYXNlDQo+IA0K
PiBJZiB3ZSBoYXZlIGEgY2hlY2sgYXMgYmVsb3c6DQo+IA0KPiBpZiAoc2l6ZSA8IGNlbGwt
PnNpemUpIC0+IDQgPCAxIC0+IEZBTFNFIC0+IGNvcnJlY3RseSBhbGxvd3MNCj4gDQo+IFRo
ZW4gaWYgY2VsbCBoYXMgbmJpdHMgc2V0LCBiaXQgZmllbGQgYm91bmRzIGNhbiBiZSB2YWxp
ZGF0ZWQgc2VwYXJhdGVseSBhcyBmb2xsb3dzOg0KPiANCj4gYnl0ZXNfbmVlZGVkID0gRElW
X1JPVU5EX1VQKDcrMSwgOCkNCj4gDQo+IGlmIChieXRlc19uZWVkZWQgPiBjZWxsLT5zaXpl
IHx8IGJ5dGVzX25lZWRlZCA+IHNpemVvZih1MzIpIHx8IHNpemUgIT0gc2l6ZW9mKHUzMikp
DQo+IA0KPiBUaGlzIHZhbGlkYXRlczoNCj4gDQo+ICDCoCogYnl0ZXNfbmVlZGVkID4gY2Vs
bC0+c2l6ZTogQml0IGZpZWxkIGRvZXNuJ3QgZXhjZWVkIGFjdHVhbCBjZWxsIHNpemUNCj4g
IMKgKiBieXRlc19uZWVkZWQgPiBzaXplb2YodTMyKTogQml0IGZpZWxkIGRvZXNuJ3QgZXhj
ZWVkIG1heGltdW0NCj4gIMKgwqAgc3VwcG9ydGVkIHNpemUNCj4gIMKgKiBzaXplICE9IHNp
emVvZih1MzIpOiBCdWZmZXIgc2l6ZSBpcyBjb3JyZWN0IGZvciBiaXQgZmllbGQgb3BlcmF0
aW9ucw0KDQpZZWFoLCBidXQgaXQncyBpbXBvcnRhbnQgdG8gZW5zdXJlIHNpemUgPT0gY2Vs
bC0+c2l6ZSBmb3Igbm9ybWFsIGJpdGZpZWxkcy4gV2UgZG9uJ3Qgd2FudCB0byBhbGxvdyBl
LmcuDQpzdXBwbHlpbmcgYSA0LWJ5dGUgY2VsbCBmb3IgYSBtYWMgYWRkcmVzcy4gV2UgcHJv
YmFibHkgZG9uJ3Qgd2FudCB0byBhbGxvdyBzdG9yaW5nIGUuZy4gMHhkZWFkYmVlZiBpbiBh
DQpjZWxsIG9mIHNpemUgMiBlaXRoZXIuLi4NCg0KLS1TZWFuDQoNCg==
