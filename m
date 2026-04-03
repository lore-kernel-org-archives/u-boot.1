Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71D9E85379
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 16:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108B0840B0;
	Fri,  3 Apr 2026 18:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IjgAXOk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3E7840D8; Fri,  3 Apr 2026 18:29:13 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3473983CF5
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 18:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-66dd1b5bb6aso3541107a12.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 03 Apr 2026 09:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233750; cv=none;
 d=google.com; s=arc-20240605;
 b=Vq2OP/k3KSowXvQ4aPmrjIiuOsrhL2s+n3R/7toAsHNvWf+VZ53vkKuw4KpPrgbwjj
 GWe8B1bnOYKct8HhJUiuqt5VSCmaegIL4K68rHsBA72hiEINwKDsH+aOrxIq1u3155x1
 dQI4gmDW3Hjzl+Peifr5STYosjRkdxyJLHviqbxLt7yhV9QsEWU5mJOWOh0U2R9MmfbJ
 0PgTBzgPYqxED8zhf2stjbSJK0TiOELWWgOrvs784hWt/u7HRgGWrFveDsV1TtO057iD
 EdwSWc8Xm+ZV7GykvClq6Z2oXOAwsfsNI3rWq8lXtlU/aUQHl+RIzp+oHdbqqaJ/343S
 XM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jdG/NG0dU5/SfYTrQZqx8wfXjrEbl2dYHS83u0x2fZ0=;
 fh=Qepf2wxjiXC8Q9eKk6EeMKDlS6GLjE/sRjG6l+q3ubc=;
 b=Qrgt2iuXQlXLmFyuMgZD+jXKi9JjKgwY74NQQB81GzABJB6TKiyGOo4J1HHU7ftDAD
 +E1r+HJ0I7WpfmilmgKHKWe/GRkqAC3Wms00UeqeFQxXaqh8XZJZN9Y8C4Ujb3ZdXOc0
 F4ykXork+wPTetgQ3qP+E9vje1T/RlHReBniYSPd9IVANyxwG64fU/lEnbdckqgSm50F
 VAwBLobO0K8V4LN2MN66yI5IrzPQT8w1TbKYPnOh7xhtQMI76tsVVOQHXL1g8FU2Q7Z9
 RKhWa0gCq6+jxyB5oPEdMKsPBKdB29L0DnKv9BCMfIGgt2/lpEFvgaxlOAZweHN4W7Wt
 pHMg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775233750; x=1775838550; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jdG/NG0dU5/SfYTrQZqx8wfXjrEbl2dYHS83u0x2fZ0=;
 b=IjgAXOk5rzEqgXr2fMV9AqJt16HqWhXr/oSaNSbJpb621X64WKOz6PiATikzg40i0V
 NOKVMhlZx4NZiyK/843XYtnAvcU/zA35lZuWNXj8kWyLbxBi9X0lAgGGPRtXFCfFRFDz
 tVas7eJwgpsKhBgcFJuqzkh+mB/VXqCXbx7GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775233750; x=1775838550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdG/NG0dU5/SfYTrQZqx8wfXjrEbl2dYHS83u0x2fZ0=;
 b=H0KO70xVgrKFIm9/SnM2rDycUD+W7R+Hdmw+Zia6eNAUb7qd/FJVHyivj047Ut1mlr
 KzVSYdvEMql8VetazDxrRsqOVCMengUUGUgvaMCwiEy4qUy5XLSw0H2R5A1dI/XROWm3
 CtbRFH4xMP6L4ABIOb6o3OsRMYSTbzFXxxKHo/tsJn0TS2a32hr3ypeasGYkvN0VWg+s
 NnM0vzdmdJ84I4pLpOXyIl162zSHA+tH0uReT0WkEn41YOWqVDhqcwtbrQkDchN+HCtK
 uYXTjkA/BUYGrX7TnmB2AZn/qryEl2c5Wtd2hXY7sSb+vX8tyd+TIZa7/Cpcgl+ypjTu
 W+wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz4qO6Aewl03hYKKPZzw+Jy9NoGThFDTn4cVAwsO3Yaqid+dA+naQrWIBxsPsiEroMOSTuQbs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8OWSnKhz8krmAur1tdjkEqf5nqgr9XCkSzN0P6nEdasYBmJuQ
 W70kCSMoTmdA3dKNR9IIm+WXljtrPUqYvLfudvawaIIPBM2AkHqSE13xqTPonjJC3kjo88klTQZ
 EM6faH21rJKQ9+fw8x7L2qVo8+ArWSYRmdfsXP4D8
X-Gm-Gg: AeBDietWCmHyjkAIUQQeMfE9FfBB0MKHVw+0elQF4UcCVDl/jjf9xY4o3B50oGcjE0N
 QBiamRFbuf6JPKt2LjBl1Bx8yJiwppwlbpAqkW8/u4PhN7FXqbrxaoZhY2JjIXVQGzYJ5EjKBPX
 ylseP1i9EfxhotL2fS1oobJ2yl+clt/6tuAR3V7Q30PC/TN7z8ddGRXVwYSZZoKy/apOLSX6A9W
 blsWnK3xXlssmxAWNknNr8tiuOY61LM3nChyW1YIW2lR8kPvm9oDj/A988wks64jSo87cbxLTwM
 bxxjDIcULB0cwQnz
X-Received: by 2002:a17:907:c819:b0:b9c:5357:15e1 with SMTP id
 a640c23a62f3a-b9c679a5e68mr195970766b.38.1775233750426; Fri, 03 Apr 2026
 09:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
 <CAFLszTgfN-+Y7K1ZkQS947BdMBFtPqOLof8tsU7b4JzCKJbBJQ@mail.gmail.com>
 <5b2347e9-1168-468a-a762-ebbf80251df6@softathome.com>
In-Reply-To: <5b2347e9-1168-468a-a762-ebbf80251df6@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 10:28:58 -0600
X-Gm-Features: AQROBzA1ThTq3MvuCRdfi1mK3PMtPrc06Wh8HqyAtJ4VCi1PVHoXSTi4syp9-uo
Message-ID: <CAFLszThHzK=q9wkY+5bTJJzCMc_+rEsSs-tj7P_Kj9PYd-DRPg@mail.gmail.com>
Subject: Re: [PATCH 0/1] u_boot_pylib: disable standalone module detection
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Paul,

No worries, sorry I missed the other patch!

- Simon

On Fri, 3 Apr 2026 at 07:26, Paul HENRYS <paul.henrys_ext@softathome.com> wrote:
>
> Hi Simon,
>
> My apologies. I actually sent the wrong patch and in principle it was
> also sent to the mailing list but this first version should be discarded
> and the second version reviewed. Unfortunately, when I sent the patch
> version 2, I forgot to add the reference of the first patch series...
> The second version of this patch series is
> https://patchwork.ozlabs.org/project/uboot/patch/20260331080636.380507-2-paul.henrys_ext@softathome.com/.
> Sorry again for the mess...
>
> Kind regards,
> Paul
>
> On 03/04/2026 15:18, Simon Glass wrote:
> > Hi Paul,
> >
> > Can you please send this to the mailing list too?
> >
> > Regards,
> > Simon
> >
> > On Mon, 30 Mar 2026 at 08:19, Paul HENRYS
> > <paul.henrys_ext@softathome.com> wrote:
> >> Do not try to detect standalone python modules at the top level, so setuptools
> >> stops searching for: command, terminal, ... as independent modules and instead
> >> relies on package discovery.
> >>
> >> Steps to reproduce the issue without the patch:
> >>
> >> git clone https://source.denx.de/u-boot/u-boot.git
> >> cd u-boot
> >> python3 -m venv myenv
> >> source myenv/bin/activate
> >> pip3 install tools/u_boot_pylib/
> >> ...
> >> error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].
> >>
> >> Paul HENRYS:
> >>    tools: u_boot_pylib: disable standalone module detection
> >>
> >>   tools/u_boot_pylib/pyproject.toml | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> --
> >> 2.43.0
> >>
