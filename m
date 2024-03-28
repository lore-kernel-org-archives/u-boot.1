Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9ACCD1288
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B6887E9D;
	Thu, 28 Mar 2024 14:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmPMI/RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5511C88127; Thu, 28 Mar 2024 14:45:21 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F3A87E8E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso223657a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711633517; x=1712238317; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AqhRvLd4v87/DphmoMUSTav+TGpkhVHYXapKPGwT6pI=;
 b=dmPMI/RMDfL7um0n6lSBwPuRPY2Sl3Fnu/6thd/muoHlqJQkMmCeCrFXIFffGDfGPF
 pMjA75tMdgRWIciLG4NM8Z9ETKwaiR1367xhhin7PJINBKi/lc1Fzyh4M5z8D8mb2D/m
 9h8QxUM0uPQwzAxkKSWMPc8N8QvwdYiXEICF3P+QnRe8i/hedr5EiJzfdZGkBgYiMqdW
 k72KSize8yO1SBrCDhBKr1+w6OTRDOnNWTsC4VGPYrfHYxKBSKWz8akM8ZDIEpWPy5xE
 h/tR4CfGiulTRA74ySPHKteFVthkhsTTwvegB9mAMSFyZRbMYR1N1+KVSYCWa+raOupr
 e0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711633517; x=1712238317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AqhRvLd4v87/DphmoMUSTav+TGpkhVHYXapKPGwT6pI=;
 b=RzqMjpjkiEvW23rsQgVlqujnBqZVPONpdzcT4jyl2ePGl3cC7M2/D8zqowYrcQECdh
 x4mJtExX6ga7WL61BBXT8WK/sesck5/qWZNUaej6GvoYUWycPJ1eGAUHcFDMQxemVqRD
 bw6V/8ABmHson8lJD2X+brIXYAmdrFu9y6Az8q4JDkAznLXQSKhvMVNqYfBRxzxBW2le
 QuK72bN4K8goHZEAhqa2dPKuTWOFV8qoVMxQXjVWW43ZsIGIg5B70KoAK5ZJyC0eYuXL
 u+zPd2AdAFfTN84RH9Z25RSexhFvdL5tZONjey/Ldrf08ieT1DXqrNrd3W3Yt9hqnfyB
 e7Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJaP0w2EsIJ/p9Tjx+zyTWMWQEYq2VtSL5aAxa76a37fB7c89IWJU7FOkO33jBBuEAHd1nc28CA5dApYMyXzRQfN9ZAA==
X-Gm-Message-State: AOJu0YwCK8SxgNyDkQD8cOD2ZP1m/hGKxUgd/vD1fO4yIh73mRvhIT8u
 6QMLuV3PAbgfrY7L6Lo5aZZnYt+NV3zrJtvlxVYpu8wlgjMKLhdr5rmoQAbnsKK7AbDxI4b2f0P
 9LnpbMMHCQLF7Ov2q4kyXIMR/jZPG+9//
X-Google-Smtp-Source: AGHT+IGtOsMWjQu9JUKM56OtIJ5bSm+NRQLBR7GRENF0PIZGVbNyfK8wSJX3r0hqZOCdBRq6+Grb4JvbghcGeP91Pu8=
X-Received: by 2002:a17:90a:dc13:b0:2a1:fe2e:d98d with SMTP id
 i19-20020a17090adc1300b002a1fe2ed98dmr2335394pjv.3.1711633517190; Thu, 28 Mar
 2024 06:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240327170359.2167228-1-festevam@gmail.com>
 <fbc0c244d688872c793366a6aeb15ba5@igalia.com>
In-Reply-To: <fbc0c244d688872c793366a6aeb15ba5@igalia.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Mar 2024 10:45:04 -0300
Message-ID: <CAOMZO5DCafY+UzUtyMc00gW9oJ5FZgwKTnASyhRFuURb-bNQuw@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: Do not print devicetree model
To: Christian Gmeiner <cgmeiner@igalia.com>
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000c73e7c0614b8bbfa"
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

--000000000000c73e7c0614b8bbfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Mar 28, 2024 at 4:18=E2=80=AFAM Christian Gmeiner <cgmeiner@igalia.=
com> wrote:

> This is not what this patch is doing. show_board_info() is the only
> caller of checkboard()
> so we end with the following output:

You're right. The attached patch should do what we want.

--000000000000c73e7c0614b8bbfa
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-mx6cuboxiboardrevv2.patch"
Content-Disposition: attachment; filename="0001-mx6cuboxiboardrevv2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lubadi7f0>
X-Attachment-Id: f_lubadi7f0

RnJvbSBiNzRhNDEwMTI3Y2FiYzEwMGE4OTkzODQwYTNiMDBkNDAzYTMxNmFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjggTWFyIDIwMjQgMTA6Mzk6MjkgLTAzMDAKU3ViamVjdDogW1BBVENIIHYyXSBt
eDZjdWJveGk6IERvIG5vdCBwcmludCBkZXZpY2V0cmVlIG1vZGVsCgpUaGUgbXg2Y3Vib3hpX2Rl
ZmNvbmZpZyB0YXJnZXQgc3VwcG9ydHMgc2V2ZXJhbCBib2FyZAp2YXJpYW50cy4gQWxsIG9mIHRo
ZXNlIHZhcmlhbnRzIHVzZSB0aGUgaHVtbWluZ2JvYXJkIGRldmljZXRyZWUgaW4gVS1Cb290LgoK
Q3VycmVudGx5LCB0aGUgZGV2aWNldHJlZSBtb2RlbCBhcyB3ZWxsIGFzIHRoZSBib2FyZCB2YXJp
YW50IG5hbWUKYXJlIHNob3duOgoKLi4uCk1vZGVsOiBTb2xpZFJ1biBIdW1taW5nQm9hcmQyIER1
YWwvUXVhZCAoMS41c29tK2VtbWMpCkJvYXJkOiBNWDYgQ3Vib3gtaQouLi4KClByaW50aW5nIHRo
ZSBkZXZpY2V0cmVlIG1vZGVsIHRoYXQgaXMgdXNlZCBpbnRlcm5hbGx5IGJ5IFUtQm9vdAptYXkg
Y29uZnVzZSB1c2Vycy4KClVuc2VsZWN0IHRoZSBDT05GSUdfRElTUExBWV9CT0FSRElORk8gb3B0
aW9uIHNvIHRoYXQgb25seSB0aGUKYm9hcmQgbmFtZSBpcyBwcmludGVkIGluIGJvYXJkX2xhdGVf
aW5pdCgpIGluc3RlYWQuCgpTaWduZWQtb2ZmLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+Ci0tLQpDaGFuZ2VzIHNpbmNlIHYxOgotIFJlbW92ZSBjaGVja2JvYXJkIGFuZCBw
cmludCB0aGUgYm9hcmQgbmFtZSBpbiBib2FyZF9sYXRlX2luaXQoKS4KCiBib2FyZC9zb2xpZHJ1
bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMgfCA0MCArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiBjb25maWdzL214NmN1Ym94aV9kZWZjb25maWcgICAgICAgICAgfCAgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYm9h
cmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jIGIvYm9hcmQvc29saWRydW4vbXg2Y3Vi
b3hpL214NmN1Ym94aS5jCmluZGV4IDhlZGFiZjQ0MDRjMi4uMzFkMzBjZmJiZDdiIDEwMDY0NAot
LS0gYS9ib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMKKysrIGIvYm9hcmQvc29s
aWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jCkBAIC0zODEsMzcgKzM4MSw2IEBAIHN0YXRpYyBi
b29sIGhhc19lbW1jKHZvaWQpCiAJcmV0dXJuIChtbWNfZ2V0X29wX2NvbmQobW1jLCB0cnVlKSA8
IDApID8gMCA6IDE7CiB9CiAKLS8qIE92ZXJyaWRlIHRoZSBkZWZhdWx0IGltcGxlbWVudGF0aW9u
LCBEVCBtb2RlbCBpcyBub3QgYWNjdXJhdGUgKi8KLWludCBjaGVja2JvYXJkKHZvaWQpCi17Ci0J
cmVxdWVzdF9kZXRlY3RfZ3Bpb3MoKTsKLQotCXN3aXRjaCAoYm9hcmRfdHlwZSgpKSB7Ci0JY2Fz
ZSBDVUJPWEk6Ci0JCXB1dHMoIkJvYXJkOiBNWDYgQ3Vib3gtaSIpOwotCQlicmVhazsKLQljYXNl
IEhVTU1JTkdCT0FSRDoKLQkJcHV0cygiQm9hcmQ6IE1YNiBIdW1taW5nQm9hcmQiKTsKLQkJYnJl
YWs7Ci0JY2FzZSBIVU1NSU5HQk9BUkQyOgotCQlwdXRzKCJCb2FyZDogTVg2IEh1bW1pbmdCb2Fy
ZDIiKTsKLQkJYnJlYWs7Ci0JY2FzZSBVTktOT1dOOgotCWRlZmF1bHQ6Ci0JCXB1dHMoIkJvYXJk
OiBVbmtub3duXG4iKTsKLQkJZ290byBvdXQ7Ci0JfQotCi0JaWYgKGlzX3Jldl8xNV9zb20oKSkK
LQkJcHV0cygiIChzb20gcmV2IDEuNSlcbiIpOwotCWVsc2UKLQkJcHV0cygiXG4iKTsKLQotCWZy
ZWVfZGV0ZWN0X2dwaW9zKCk7Ci1vdXQ6Ci0JcmV0dXJuIDA7Ci19Ci0KIHN0YXRpYyBpbnQgZmlu
ZF9ldGhlcm5ldF9waHkodm9pZCkKIHsKIAlzdHJ1Y3QgbWlpX2RldiAqYnVzID0gTlVMTDsKQEAg
LTUwNSwxMiArNDc0LDE1IEBAIGludCBib2FyZF9sYXRlX2luaXQodm9pZCkKIAlzd2l0Y2ggKGJv
YXJkX3R5cGUoKSkgewogCWNhc2UgQ1VCT1hJOgogCQllbnZfc2V0KCJib2FyZF9uYW1lIiwgIkNV
Qk9YSSIpOworCQlwdXRzKCJCb2FyZDogTVg2IEN1Ym94LWkiKTsKIAkJYnJlYWs7CiAJY2FzZSBI
VU1NSU5HQk9BUkQ6CiAJCWVudl9zZXQoImJvYXJkX25hbWUiLCAiSFVNTUlOR0JPQVJEIik7CisJ
CXB1dHMoIkJvYXJkOiBNWDYgSHVtbWluZ0JvYXJkIik7CiAJCWJyZWFrOwogCWNhc2UgSFVNTUlO
R0JPQVJEMjoKIAkJZW52X3NldCgiYm9hcmRfbmFtZSIsICJIVU1NSU5HQk9BUkQyIik7CisJCXB1
dHMoIkJvYXJkOiBNWDYgSHVtbWluZ0JvYXJkMiIpOwogCQlicmVhazsKIAljYXNlIFVOS05PV046
CiAJZGVmYXVsdDoKQEAgLTUyMiw4ICs0OTQsMTIgQEAgaW50IGJvYXJkX2xhdGVfaW5pdCh2b2lk
KQogCWVsc2UKIAkJZW52X3NldCgiYm9hcmRfcmV2IiwgIk1YNkRMIik7CiAKLQlpZiAoaXNfcmV2
XzE1X3NvbSgpKQorCWlmIChpc19yZXZfMTVfc29tKCkpIHsKIAkJZW52X3NldCgic29tX3JldiIs
ICJWMTUiKTsKKwkJcHV0cygiIChzb20gcmV2IDEuNSlcbiIpOworCX0gZWxzZSB7CisJCXB1dHMo
IlxuIik7CisJfQogCiAJaWYgKGhhc19lbW1jKCkpCiAJCWVudl9zZXQoImhhc19lbW1jIiwgInll
cyIpOwpkaWZmIC0tZ2l0IGEvY29uZmlncy9teDZjdWJveGlfZGVmY29uZmlnIGIvY29uZmlncy9t
eDZjdWJveGlfZGVmY29uZmlnCmluZGV4IDI3Y2ViMjI1OTlhNi4uZTNhYmE3MTVhYTU4IDEwMDY0
NAotLS0gYS9jb25maWdzL214NmN1Ym94aV9kZWZjb25maWcKKysrIGIvY29uZmlncy9teDZjdWJv
eGlfZGVmY29uZmlnCkBAIC0yOCw2ICsyOCw3IEBAIENPTkZJR19CT09UQ09NTUFORD0icnVuIGZp
bmRmZHQ7IHJ1biBmaW5kdXVpZDsgcnVuIGRpc3Ryb19ib290Y21kIgogQ09ORklHX1VTRV9QUkVC
T09UPXkKIENPTkZJR19QUkVCT09UPSJpZiBoZG1pZGV0OyB0aGVuIHVzYiBzdGFydDsgc2V0ZW52
IHN0ZGluICBzZXJpYWwsdXNia2JkOyBzZXRlbnYgc3Rkb3V0IHNlcmlhbCx2aWRjb25zb2xlOyBz
ZXRlbnYgc3RkZXJyIHNlcmlhbCx2aWRjb25zb2xlOyBlbHNlIHNldGVudiBzdGRpbiAgc2VyaWFs
OyBzZXRlbnYgc3Rkb3V0IHNlcmlhbDsgc2V0ZW52IHN0ZGVyciBzZXJpYWw7IGZpOyIKIENPTkZJ
R19TWVNfUEJTSVpFPTUzMgorIyBDT05GSUdfRElTUExBWV9CT0FSRElORk8gaXMgbm90IHNldAog
Q09ORklHX0JPQVJEX0VBUkxZX0lOSVRfRj15CiBDT05GSUdfU1BMX1NZU19NQUxMT0M9eQogQ09O
RklHX1NQTF9GU19FWFQ0PXkKLS0gCjIuMzQuMQoK
--000000000000c73e7c0614b8bbfa--
