Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2E9CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1D186E77;
	Thu, 12 Oct 2023 16:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h98bBg/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568A586CDD; Thu, 12 Oct 2023 16:23:45 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC85780711
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ae65e8eb45so611351b6e.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697120375; x=1697725175; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDJr6Py1ofyVCwV1V4fpDFx7nEHx10bVEzbHoClv+Ic=;
 b=h98bBg/hXSUhW/Bb03j/3SkcsYW1WnKEHY80pSHWtuKTQucV6hgxUACtvta52Sc9Lu
 X47tQIhC5JKRbJBdtSmSqqbTzj4KSA+S9BmRFRMvLU3GIZpccpux8rYf+peDvllGS67L
 IY4GT0pv7KWGG5ntaIhsCZMirpB5+7fUckIF7CtkVvdmpuyYx68NU3I8EeqQGb3Gu0+P
 w9Yux3T4Xcg3npiF+VbOdf/5Gy9QAJcVcHFIfj4GS6qWqGolhT234rL7IUMRkH1viPpT
 lzWinBXDllVGSgtV4gnWIKd901b4iTyMU+k/YvKLMsj2KOy10JB4pPsf12sxvRjdiJUm
 5RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697120375; x=1697725175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDJr6Py1ofyVCwV1V4fpDFx7nEHx10bVEzbHoClv+Ic=;
 b=wzFIVdv4KtrGnQQeWfb7HD46IhoT575G5i7DN68M10gjdO/PD29RyD+5RA2JtFD1z+
 wdhf4v4tvK4+2R/ciPtTFm1BqvB79FP9oucGkOc/h0m96HEBNU+C7m1YR+YpXkB3DfZf
 mQ1QDgiAJcFPCZcxwbxFNO4oYVQw0BJE1NgIAq/F21FJJm8GDJRCsW1HFt3uux5svqxY
 U10eB+B0S+vY3TFccmsTUEvE2mvX/TLtRU7ktL1TK0e1whG6ow8Jb+lRDYevZ37TiyHB
 VjrtxXAlJvO46xQyDXhL25YKKPnoShGxu+OmVxeajMnUzrjHx4PDE8mkv7bum7RWbziI
 4Pvg==
X-Gm-Message-State: AOJu0YwCONW/kXqzMx+ReEHPdleS1ExtaSQwqRHl08tOKYXUiu3qz8+N
 hOh51jYX+jHhaa/CwHCT8UA=
X-Google-Smtp-Source: AGHT+IGt03/F8OI7Va8A5v5055ibJvpveXCxPJKVs4HMaTcCaov+yBtqlAL6I3FolD1BBptPuVvG+A==
X-Received: by 2002:aca:1219:0:b0:3a4:57a7:b30e with SMTP id
 25-20020aca1219000000b003a457a7b30emr25391961ois.26.1697120374938; 
 Thu, 12 Oct 2023 07:19:34 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 n7-20020a0c9d47000000b0065d0dcc28e3sm6679078qvf.73.2023.10.12.07.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:19:34 -0700 (PDT)
Message-ID: <01389fd6-0062-5fe5-5da5-ba4271757e03@gmail.com>
Date: Thu, 12 Oct 2023 10:19:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/26] spl: Don't cache devices when UNIT_TEST is enabled
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-17-seanga2@gmail.com>
 <09f4f552-1694-4181-bf63-5482757e5120@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <09f4f552-1694-4181-bf63-5482757e5120@gmx.de>
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

T24gMTAvMTIvMjMgMDM6MjMsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDEw
LzEyLzIzIDAzOjU2LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4gU2V2ZXJhbCBTUEwgZnVu
Y3Rpb25zIHRyeSB0byBhdm9pZCBwZXJmb3JtaW5nIGluaXRpYWxpemF0aW9uIHR3aWNlIGJ5
DQo+PiBjYWNoaW5nIGRldmljZXMuIFRoaXMgaXMgZmluZSBmb3IgcmVndWxhciBib290LCBi
dXQgZG9lcyBub3Qgd29yayB3aXRoDQo+PiBVTklUX1RFU1QsIHNpbmNlIGFsbCBkZXZpY2Vz
IGFyZSB0b3JuIGRvd24gYWZ0ZXIgZWFjaCB0ZXN0LiBEaXNhYmxlIGNhY2hpbmcNCj4+IHNv
IHdlIGRvbid0IHVzZSBzdGFsZSBkZXZpY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNl
YW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPg0KPj4gLS0tDQo+Pg0KPj4gwqAgY29t
bW9uL3NwbC9zcGxfZmF0LmMgfCAyICstDQo+PiDCoCBjb21tb24vc3BsL3NwbF9tbWMuYyB8
IDMgKystDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29tbW9uL3NwbC9zcGxfZmF0LmMgYi9j
b21tb24vc3BsL3NwbF9mYXQuYw0KPj4gaW5kZXggYzZlMjUyNmFkZTEuLjhiZWM5Y2NlNWNh
IDEwMDY0NA0KPj4gLS0tIGEvY29tbW9uL3NwbC9zcGxfZmF0LmMNCj4+ICsrKyBiL2NvbW1v
bi9zcGwvc3BsX2ZhdC5jDQo+PiBAQCAtMjQsNyArMjQsNyBAQCBzdGF0aWMgaW50IHNwbF9y
ZWdpc3Rlcl9mYXRfZGV2aWNlKHN0cnVjdCBibGtfZGVzYyAqYmxvY2tfZGV2LCBpbnQgcGFy
dGl0aW9uKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBpbnQgZXJyID0gMDsNCj4+DQo+PiAt
wqDCoMKgIGlmIChmYXRfcmVnaXN0ZXJlZCkNCj4+ICvCoMKgwqAgaWYgKCFDT05GSUdfSVNf
RU5BQkxFRChVTklUX1RFU1QpICYmIGZhdF9yZWdpc3RlcmVkKQ0KPiANCj4gUGxlYXNlLCBh
dm9pZCBzZXBhcmF0ZSBjb2RlIHBhdGhzIGRlcGVuZGluZyBvbiBDT05GSUdfVU5JVF9URVNU
Uy4NCj4gDQo+IFdlIHNob3VsZG4ndCBjaGFuZ2Ugbm9ybWFsIGJlaGF2aW9yIGlmIHVuaXQg
dGVzdHMgYXJlIG5vdCBydW5uaW5nLiBJdCBpcw0KPiBwcmVmZXJhYmxlIHRvIGxldCB0aGUg
dW5pdCB0ZXN0IGZyYW1ld29yayBjYWxsIGEgbmV3IGZ1bmN0aW9uIHJlc2V0dGluZw0KPiBm
YXRfcmVnaXN0ZXJlZCB3aGVuIG5lZWRlZC4gVGhpcyB3aWxsIGFsbG93IGZ1dHVyZSB0ZXN0
cyB0byB0ZXN0IGFsbA0KPiBjb2RlIHBhdGhzIHNlcGFyYXRlbHkuDQoNCk9LLCB0aGF0IHNv
dW5kcyByZWFzb25hYmxlIHRvIG1lLg0KDQotLVNlYW4NCg==
