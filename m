Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED67C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B0887E77;
	Thu,  8 Feb 2024 13:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=careweather.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=careweather-com.20230601.gappssmtp.com header.i=@careweather-com.20230601.gappssmtp.com header.b="VP/0QZbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F28187CF6; Thu,  8 Feb 2024 01:18:04 +0100 (CET)
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com
 [IPv6:2607:f8b0:4864:20::942])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0306987CDB
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 01:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=careweather.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick@careweather.com
Received: by mail-ua1-x942.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so568516241.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 16:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=careweather-com.20230601.gappssmtp.com; s=20230601; t=1707351478;
 x=1707956278; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OSygxAnAqBFHSdO8qL3of+0h69kLwNMPJjPfOz8RxlE=;
 b=VP/0QZbOSgJ1eeS7UEmAzSHZU/Yf4Dbw3C/eULuVVggo0x9yhWNXqFMingdRFrWrAT
 NOAL7ZvWm8U7h7mdJQI6whM8nXhHiN+N0bIrBnv3tjbt56pra2rcDLR28sKXR9adpzsB
 H9Gq0mlI98fDOm+MkhWvAocCcZlctgVX+XXmTSiwoYioyDOZ2wlOFFxenJd2y2n7J0Ry
 QnvcCRCeOfQ5shskUI6uiBgz8PUtalEALm1nHHNYqVAuPirJXdRFP2VVbPBMAsOQFYSV
 mfbCzHuKhnD0gomxF80h1Vrr6MX8mC8HBnkljZXV5sjwjiOvsy7f17kuFw1EZCxAGmbN
 Dp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707351478; x=1707956278;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSygxAnAqBFHSdO8qL3of+0h69kLwNMPJjPfOz8RxlE=;
 b=ERDNtu/ykqn5KtKWuF6c1ALJtQuUZsIzBwL8rO7qY97oFt6V8ubY+42Xuib1OFq7gX
 AAedtERlQRWqRdoAUjR2nYfmZDfBbnFQaqZq0xpmMkF5qnnCGnitAsArk+/vRp60maRS
 9QSYaIgY16jM4Cho6am3kb3+M0bl3jb9bWVGbyNnY8PHgK1MtycdQ8Js/prZOi2O1/Hq
 TpFMzp+kLFeNiNbltJhtJpT9SsidF1n5c621rEnwq0n547ufhN17/z8GHDPZI9IaQT6j
 jr1jb0CPSiKJK/SdEpbFH21gB3JE2lQ+SwWxqltQVUeJCEzJgdamNpMX9ELGGsCj5ch8
 N+og==
X-Gm-Message-State: AOJu0Yw2gAf2okVgamCWHQNabgy0smV3P2joqXa9AN6yY22GTf5ybbzi
 UuSUdsTvGxE/U+HraBf7Ztd8rCdxFle3dGuqN5fNESr2yYpRg+zi/WucbkrLr1s+mlSTVfSEYvj
 /zCE=
X-Google-Smtp-Source: AGHT+IHbM1nYvR9KFh+ql5wRqL5fP1LoM4VxxvoRVNF85hQOOp1RPepizqwk6q/kvdg1Pmtes/ui4g==
X-Received: by 2002:a05:6102:1986:b0:46d:3c07:f635 with SMTP id
 jm6-20020a056102198600b0046d3c07f635mr4475562vsb.34.1707351478358; 
 Wed, 07 Feb 2024 16:17:58 -0800 (PST)
Received: from localhost (0.92.231.35.bc.googleusercontent.com. [35.231.92.0])
 by smtp.gmail.com with UTF8SMTPSA id
 t25-20020a67f5d9000000b0046d1c6547c1sm277857vso.0.2024.02.07.16.17.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 16:17:57 -0800 (PST)
Mime-Version: 1.0
X-Mailer: Superhuman Web (2024-02-07T20:06:16Z)
X-Superhuman-Thread-ID: draft00a6046020c8047b
From: "Patrick Walton" <patrick@careweather.com>
X-Superhuman-ID: lscgz39a.302093ec-75b1-46c7-83b4-1416a5070b3f
X-Superhuman-Draft-ID: draft00a4d6523adfa632
Date: Thu, 08 Feb 2024 00:17:56 +0000
Message-ID: <lscgrcfp.54a556b9-85d9-4bd1-91e0-33993fcf0f4c@we.are.superhuman.com>
Subject: Bug: PDF documentation doesn't build according to instructions
To: u-boot@lists.denx.de
Content-Type: multipart/mixed;
 boundary=99f0b721b571733f154b27a091ef108a87d7cd89b7e303e8b125968c01cc
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:11:14 +0100
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

--99f0b721b571733f154b27a091ef108a87d7cd89b7e303e8b125968c01cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When I follow the instructions for building PDF documentation ( https://doc=
s.u-boot.org/en/latest/build/documentation.html ) , I run into an error at =
the texi2pdf step=C2=A0(attached). It appears to have to do with the boot f=
low diagram of k3_current not being an acceptable format for the pdf compil=
er. I tested this on several releases and it appears to have appeared in th=
e v2023.10 release and continues to the latest. I was able to build the doc=
umentation on the v2023.07 release.

Take care,

Patrick Walton
Co-founder/CEO
Care Weather
801-227-4740
www.careweather.com ( http://www.careweather.com )
--99f0b721b571733f154b27a091ef108a87d7cd89b7e303e8b125968c01cc
Content-Disposition: attachment; filename="doc_error.txt"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="doc_error.txt"

Li9kb2Mvb3V0cHV0L3RleGluZm8vdS1ib290LnRleGk6MTE5MTMwOiBDb3VsZCBub3QgZmluZCBp
bWFnZSBmaWxlIHUtYm9vdC1maWd1cgplcy9ib290X2RpYWdyYW1fazNfY3VycmVudCBmb3IgcGRm
LgpAZG9wZGZpbWFnZSAuLi51bGQgbm90IGZpbmQgaW1hZ2UgZmlsZSAjMSBmb3IgcGRmfQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBlbHNlIEBnZGVm
IEBwZGZpbWdleHQge0pQLi4uCgpAaW1hZ2V4eHggLi4udCBAZmkgQGlmcGRmIEBkb3BkZmltYWdl
IHsjMX17IzJ9eyMzfQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEBlbHNlIEBpZnggQFhlVGVYcmV2aXNpb24gLi4uCgpAaW1hZ2UgLi4udHJ1ZSBAZmkg
QGVsc2UgQGltYWdleHh4ICMxLCwsLCxAZmluaXNoIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEBmaSAKbC4xMTkxMzAgLi4uYW1fazNfY3VycmVudCws
LEJvb3QgZmxvdyBkaWFncmFtLHN2Z30KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKPyAKLi9kb2Mvb3V0cHV0L3RleGluZm8vdS1ib290LnRleGk6MTE5
MTMwOiBFbWVyZ2VuY3kgc3RvcC4KQGRvcGRmaW1hZ2UgLi4udWxkIG5vdCBmaW5kIGltYWdlIGZp
bGUgIzEgZm9yIHBkZn0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBAZWxzZSBAZ2RlZiBAcGRmaW1nZXh0IHtKUC4uLgoKQGltYWdleHh4IC4uLnQgQGZp
IEBpZnBkZiBAZG9wZGZpbWFnZSB7IzF9eyMyfXsjM30KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBAZWxzZSBAaWZ4IEBYZVRlWHJldmlzaW9uIC4uLgoK
QGltYWdlIC4uLnRydWUgQGZpIEBlbHNlIEBpbWFnZXh4eCAjMSwsLCwsQGZpbmlzaCAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAZmkgCmwuMTE5MTMw
IC4uLmFtX2szX2N1cnJlbnQsLCxCb290IGZsb3cgZGlhZ3JhbSxzdmd9CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCkBUZXhpbmZvIHN1cHBvcnRzIC5w
bmcsIC5qcGcsIC5qcGVnLCBhbmQgLnBkZiBpbWFnZXMgd2l0aCBQREYgb3V0cHV0LCBhbmQgbm9u
ZSAKb2YgdGhvc2UgZm9ybWF0cyBjb3VsZCBiZSBmb3VuZC4gKC5lcHMgY2Fubm90IGJlIHN1cHBv
cnRlZCBkdWUgdG8gdGhlIGRlc2lnbiBvZgogdGhlIFBERiBmb3JtYXQ7IHVzZSByZWd1bGFyIFRl
WCAoRFZJIG91dHB1dCkgZm9yIHRoYXQuKSAKCi4vZG9jL291dHB1dC90ZXhpbmZvL3UtYm9vdC50
ZXhpOjExOTEzMDogID09PiBGYXRhbCBlcnJvciBvY2N1cnJlZCwgbm8gb3V0cHV0IFAKREYgZmls
ZSBwcm9kdWNlZCEK
--99f0b721b571733f154b27a091ef108a87d7cd89b7e303e8b125968c01cc--
