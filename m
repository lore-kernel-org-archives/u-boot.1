Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D46ACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1766285DE0;
	Thu, 12 Oct 2023 16:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VO5R27WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BB780711; Thu, 12 Oct 2023 16:22:13 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCAA286DF6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-66d0ceba445so5989716d6.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697120191; x=1697724991; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0we/6wT7YoaGil0EKLA/AMgRfgSuZ7HH5zu2PIqWe8g=;
 b=VO5R27WFfq9WdHZIM71cbJuOh7mBH8XdFJ2hLYjvrJw/v7G/Lf2F2cNTr5PLJ2wVpH
 k2vcqmTTPF/K7jSf78FsA8sBSdus0A3nw43nWKk7LzrRzgT6jkTl+1KphcyP3Qv7utln
 AeUxCtFaTj2mDYTxrf3YXlakWUUsyLjfjx7kpIE9Tg44qw6FzIphN/YssZaYA8e+Hw0a
 avy5JoX5ixcS5rE/U61gULvtDiksPv4smmRBwW+kdSqWXWAsyutzAf3M9kFePA1JRmuu
 Mn0OXJ8dxH71IC4Cim71zOwfTU33DXfmUx0MhOQloLdT3RcwuYJat5+O3D4tBs6mdt/L
 8UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697120191; x=1697724991;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0we/6wT7YoaGil0EKLA/AMgRfgSuZ7HH5zu2PIqWe8g=;
 b=WjgVYOsBb8HPr8PXDcEOWkkb5vWYjPnRodhGObzt2ZOiHfs9B0kPcB+VMu1+iukbbQ
 VLYyB00xkX5HJ0JShoQmKi9qRIUD7IGh1J/KpFAlFwTKduqurLTutKh8DqweVjdgRxZZ
 hDCLpOARsOPGwwNm8ROTInvhUzDh7FosYoYhyNhYL3Lf7dZXweM6DVds1aTwJCdCCUVv
 YiG55tntfmD1MdMXW2MonclHfWjOCUfCT1+AYYHM5hJOWcNRigL1hKLos+9AdRLj0nbk
 VrveoUvRIV2Qy71LODme4mSGEXTvjkXvNWhgjX6z9EYlIx7Zy197P0PtqqGivr49nP/y
 QVog==
X-Gm-Message-State: AOJu0YwgVkctEmIy6vwtQnaegs+vwI6Qu6lM5kgNdPGGqUmus0sGS5bl
 1xPMpA7aIQlnJUe/mDXThVQ=
X-Google-Smtp-Source: AGHT+IHHGn8w4YhS69QXYQDr2SJTrzPsqviriQ4NeoV777ZO5vRjDoOzlqDjgcjSV0OcBeTd5naqnA==
X-Received: by 2002:a05:6214:1d25:b0:66d:19b5:9a9 with SMTP id
 f5-20020a0562141d2500b0066d19b509a9mr1664194qvd.65.1697120190698; 
 Thu, 12 Oct 2023 07:16:30 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 g15-20020a0caacf000000b0066d1bae2326sm268252qvb.57.2023.10.12.07.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:16:30 -0700 (PDT)
Message-ID: <8ae9e50d-e87c-35a7-060d-87fec10f8971@gmail.com>
Date: Thu, 12 Oct 2023 10:16:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/26] net: Fix compiling SPL when fastboot is enabled
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-14-seanga2@gmail.com>
 <49dee352-e5c9-4a43-b365-cfc4c654b396@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <49dee352-e5c9-4a43-b365-cfc4c654b396@gmx.de>
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

T24gMTAvMTIvMjMgMDI6NTIsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDEw
LzEyLzIzIDAzOjU2LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4gV2hlbiBmYXN0Ym9vdCBp
cyBlbmFibGVkIGluIFUtQm9vdCBwcm9wZXIgYW5kIFNQTF9ORVQgaXMgZW5hYmxlZCwgd2Ug
d2lsbA0KPj4gdHJ5IHRvICh1bnN1Y2Nlc3NmdWxseSkgcmVmZXJlbmNlIGl0IGluIFNQTC4g
Rml4IHRoZXNlIGxpbmtlciBlcnJvcnMgYnkNCj4+IGNvbmRpdGlvbmluZyBvbiBTUExfVURQ
L1RDUF9GVU5DVElPTl9GQVNUQk9PVC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFu
ZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IMKgIG5ldC9NYWtl
ZmlsZSB8IDQgKystLQ0KPj4gwqAgbmV0L25ldC5jwqDCoMKgIHwgNCArKy0tDQo+PiDCoCAy
IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvbmV0L01ha2VmaWxlIGIvbmV0L01ha2VmaWxlDQo+PiBpbmRleCAz
ZTJkMDYxMzM4ZC4uNWVhNThlZWY3ZTQgMTAwNjQ0DQo+PiAtLS0gYS9uZXQvTWFrZWZpbGUN
Cj4+ICsrKyBiL25ldC9NYWtlZmlsZQ0KPj4gQEAgLTI3LDggKzI3LDggQEAgb2JqLSQoQ09O
RklHX0NNRF9QQ0FQKSArPSBwY2FwLm8NCj4+IMKgIG9iai0kKENPTkZJR19DTURfUkFSUCkg
Kz0gcmFycC5vDQo+PiDCoCBvYmotJChDT05GSUdfQ01EX1NOVFApICs9IHNudHAubw0KPj4g
wqAgb2JqLSQoQ09ORklHX0NNRF9URlRQQk9PVCkgKz0gdGZ0cC5vDQo+PiAtb2JqLSQoQ09O
RklHX1VEUF9GVU5DVElPTl9GQVNUQk9PVCnCoCArPSBmYXN0Ym9vdF91ZHAubw0KPj4gLW9i
ai0kKENPTkZJR19UQ1BfRlVOQ1RJT05fRkFTVEJPT1QpwqAgKz0gZmFzdGJvb3RfdGNwLm8N
Cj4+ICtvYmotJChDT05GSUdfJChTUExfKVVEUF9GVU5DVElPTl9GQVNUQk9PVCnCoCArPSBm
YXN0Ym9vdF91ZHAubw0KPj4gK29iai0kKENPTkZJR18kKFNQTF8pVENQX0ZVTkNUSU9OX0ZB
U1RCT09UKcKgICs9IGZhc3Rib290X3RjcC5vDQo+IA0KPiBQbGVhc2UsIHVzZSAkKFNQTF9U
UEwpIHNvIHRoYXQgd2UgZG9uJ3QgaGF2ZSB0byByZXZpc2l0IHRoaXMgc2hvdWxkIHdlDQo+
IGV2ZXIgZGVjaWRlIHRvIGVuYWJsZSBmYXN0Ym9vdCBpbiBTUEwgaW4gZnV0dXJlLg0KDQpZ
b3UgYXJlIGdvaW5nIHRvIGVuYWJsZSBmYXN0Ym9vdCBpbiBUUEw/DQoNCi0tU2Vhbg0KDQo=

