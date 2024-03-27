Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5ABC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C365588044;
	Thu, 28 Mar 2024 00:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SlLxoNMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E60C8803F; Thu, 28 Mar 2024 00:17:33 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546AC88044
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a050cf9adfso83887a91.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 16:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711581447; x=1712186247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ma4PxtI4f1XZKYc1EK0Cy1QNfFI7m/iGL49uiaSar8k=;
 b=SlLxoNMWCuBOtiLOr9eh8XHM1CFxMOQZzEqJrnnedd92Bd9bGRBACzvfcpPoNjj8wx
 P4oyZpGQeH1XVfqc4gNoCKFx2NpP+cRpGJHpTPd2t39n+YUs5jqjOakq6Y3ZMS6mhZnY
 nVq5McG1v9Z37v0Em2Yg2oMuaFYyxDnaAUnb84x2K54ye3tK3f0cXUvSlWR1yOAOOqoW
 tym8VdZ/gjXNnh5mKTMaUhs+VTdmMVvUzb4k8YixPdaNtbTHEajLupUh7+zDHse3zBFR
 5S9T9rUrz9htvHPjVJPrToP5CA+5nvKzor+1CpSY2Lbzdblp0JM7SGd9cspmwF9POEZT
 AFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711581447; x=1712186247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ma4PxtI4f1XZKYc1EK0Cy1QNfFI7m/iGL49uiaSar8k=;
 b=JQULMH5q7wIEYyiMB9ySdKliIKk8nqj2Tpl2NnBtpyLvgAr+r/Uks6BsqfFa/Zdl0f
 EQ4amqWxZCx5Ff4akLHex4YUpMMvYtNDpALZfWDBztK9P3gL8+FrwY5USK6ZGeB7XaN0
 ldQf5grETGA1LKBUpr6IZjyvfMWAyrjBt4KAiND7plo9RkLqa7jMkh0FK3HQ5shnNWFc
 ijK9PQqXdF8EUfi5YBmnSgxD8+rs3m6y2Cz3ag01+1dNR58jZaVJqvi6iR94TwWB2BYy
 ARdnrkCFDJctrJTaIQnBJgxGIoKBGAOeFmg9nfe+L99LY5jNYYFJOH9XzCxgpso2Yg88
 PoyQ==
X-Gm-Message-State: AOJu0Yxts4oXbSi6tJs2bzdx5n28koCafavdCTmjlXoK6SbHLP+Q6nO5
 wdf/Omx0n5wTKawBM4gb+F3rq2Fhc7EA3YkEBNQpjdk7p+R63GMNw3h8/fv5xeCNIjz4wUekLQu
 +ilQvV8t1C3Jj0LujWsRxOv3Rstrl20UXcaI=
X-Google-Smtp-Source: AGHT+IGqb9M4H8lPBXnZLEuOAfRF2pTPHuYSqO+6Zwe7TkWW3L1EadjZaS62/79agNSnSxebU9Iix28PWv7ylG1uxQU=
X-Received: by 2002:a17:90b:34ce:b0:29b:961c:2df0 with SMTP id
 kh14-20020a17090b34ce00b0029b961c2df0mr1105374pjb.3.1711581447533; Wed, 27
 Mar 2024 16:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
 <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
 <CAOMZO5AQArxRN25J0+M1hjNSwBQUoLsGhD9cChDkfUrv3ys=Rw@mail.gmail.com>
 <CAOMZO5AjeShry9xQRpEq==zswOc=aL5RoKyL=Y439t1wtkKRuA@mail.gmail.com>
In-Reply-To: <CAOMZO5AjeShry9xQRpEq==zswOc=aL5RoKyL=Y439t1wtkKRuA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 20:17:16 -0300
Message-ID: <CAOMZO5AH0BS_Jhx0jR9gj_cAuPPzVuVM2FeWF2xh_RiXpSkOQQ@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
To: Josua Mayer <josua@solid-run.com>, 
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Baruch Siach <baruch@tkos.co.il>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Content-Type: multipart/mixed; boundary="0000000000002f522d0614ac9c65"
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

--0000000000002f522d0614ac9c65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 6:04=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I took Josua's patch and modified it a bit.
>
> Does the attached patch fix Ethernet?

I forgot to delete the old ethernet-phy nodes.

Please try this one instead.

If it works in U-Boot, please also test Ethernet in Linux as we are
touching ft_board_setup().

--0000000000002f522d0614ac9c65
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mx6cuboxi-Fix-Ethernet-after-DT-sync-with-Linux.patch"
Content-Disposition: attachment; 
	filename="0001-mx6cuboxi-Fix-Ethernet-after-DT-sync-with-Linux.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_luafdtzt0>
X-Attachment-Id: f_luafdtzt0

RnJvbSA1YWYxNWU2OThhZDg5ZmFjM2NjMzQzM2FjNGFjODdiYjEwYmMwMTRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4KRGF0
ZTogV2VkLCAyNyBNYXIgMjAyNCAxNzo1ODo0NyAtMDMwMApTdWJqZWN0OiBbUEFUQ0hdIG14NmN1
Ym94aTogRml4IEV0aGVybmV0IGFmdGVyIERUIHN5bmMgd2l0aCBMaW51eAoKVGhlIGkuTVg2IEN1
Ym94LWkgYW5kIEh1bW1pbmdCb2FyZHMgY2FuIGhhdmUgZGlmZmVyZW50IFBIWXMgYXQgdmFyeWlu
ZwphZGRyZXNzZXMuIFUtQm9vdCBuZWVkcyB0byBhdXRvLWRldGVjdCB3aGljaCBwaHkgaXMgYWN0
dWFsbHkgcHJlc2VudCwKYW5kIGF0IHdoaWNoIGFkZHJlc3MgaXQgaXMgcmVzcG9uZGluZy4KCkF1
dG8tZGV0ZWN0aW9uIGZyb20gbXVsdGlwbGUgcGh5IG5vZGVzIHNwZWNpZmllZCBpbiBkZXZpY2Ut
dHJlZSBkb2VzIG5vdApjdXJyZW50bHkgd29yayBjb3JyZWN0LiBBcyBhIHdvcmstYXJvdW5kIG1l
cmdlIGFsbCB0aHJlZSBwb3NzaWJsZSBwaHlzCmludG8gb25lIG5vZGUgd2l0aCB0aGUgc3BlY2lh
bCBhZGRyZXNzIDB4ZmZmZmZmZmYgd2hpY2ggaW5kaWNhdGVzIHRvIHRoZQpnZW5lcmljIHBoeSBk
cml2ZXIgdG8gcHJvYmUgYWxsIGFkZHJlc3Nlcy4KQWxzbyBmaXh1cCB0aGlzIGZha2UgYWRkcmVz
cyBiZWZvcmUgYm9vdGluZyBMaW51eCwgKmlmKiBib290aW5nIHdpdGgKVS1Cb290J3MgaW50ZXJu
YWwgZHRiLgoKU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+
CltmYWJpbzogQWRkZWQgdGhlIGNoYW5nZXMgdG8gaW14NnFkbC1zci1zb20tdS1ib290LmR0c2ku
XQpTaWduZWQtb2ZmLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ci0tLQog
Li4ucWRsLWh1bW1pbmdib2FyZDItZW1tYy1zb20tdjE1LXUtYm9vdC5kdHNpIHwgIDEgKwogYXJj
aC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9vdC5kdHNpICAgICAgIHwgNDAgKysrKysrKysr
KysrKysrKysrKwogYm9hcmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jICAgICAgICAg
IHwgIDggKysrLQogMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9v
dC5kdHNpCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDZxZGwtaHVtbWluZ2JvYXJkMi1l
bW1jLXNvbS12MTUtdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1odW1taW5nYm9h
cmQyLWVtbWMtc29tLXYxNS11LWJvb3QuZHRzaQppbmRleCBlOWIxODhlZDY1ODcuLjM1OGNmOGFi
YzRmZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vZHRzL2lteDZxZGwtaHVtbWluZ2JvYXJkMi1lbW1j
LXNvbS12MTUtdS1ib290LmR0c2kKKysrIGIvYXJjaC9hcm0vZHRzL2lteDZxZGwtaHVtbWluZ2Jv
YXJkMi1lbW1jLXNvbS12MTUtdS1ib290LmR0c2kKQEAgLTEsNiArMSw3IEBACiAvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsKIAogI2luY2x1ZGUgImlteDZxZGwtdS1ib290LmR0
c2kiCisjaW5jbHVkZSAiaW14NnFkbC1zci1zb20tdS1ib290LmR0c2kiCiAKIC8gewogCWJvYXJk
LWRldGVjdCB7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14NnFkbC1zci1zb20tdS1ib290
LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1zci1zb20tdS1ib290LmR0c2kKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi40YzVmMDQzZWE5MmEKLS0tIC9kZXYvbnVs
bAorKysgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1zci1zb20tdS1ib290LmR0c2kKQEAgLTAsMCAr
MSw0MCBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkKKwor
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPgorCismZmVjIHsKKwlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOworCXBpbmN0cmwtMCA9IDwmcGluY3RybF9taWNyb3NvbV9lbmV0X2Fy
ODAzNT47CisJcGh5LWhhbmRsZSA9IDwmcGh5PjsKKwlwaHktbW9kZSA9ICJyZ21paS1pZCI7CisK
KwkvKgorCSAqIFRoZSBQSFkgc2VlbXMgdG8gcmVxdWlyZSBhIGxvbmctZW5vdWdoIHJlc2V0IGR1
cmF0aW9uIHRvIGF2b2lkCisJICogc29tZSByYXJlIGlzc3VlcyB3aGVyZSB0aGUgUEhZIGdldHMg
c3R1Y2sgaW4gYW4gaW5jb25zaXN0ZW50IGFuZAorCSAqIG5vbi1mdW5jdGlvbmFsIHN0YXRlIGF0
IGJvb3QtdXAuIDEwbXMgcHJvdmVkIHRvIGJlIGZpbmUgLgorCSAqLworCXBoeS1yZXNldC1kdXJh
dGlvbiA9IDwxMD47CisJcGh5LXJlc2V0LWdwaW9zID0gPCZncGlvNCAxNSBHUElPX0FDVElWRV9M
T1c+OworCXN0YXR1cyA9ICJva2F5IjsKKworCW1kaW8geworCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKKwkJI3NpemUtY2VsbHMgPSA8MD47CisKKwkJL2RlbGV0ZS1ub2RlLyBldGhlcm5ldC1waHlA
MTsKKwkJL2RlbGV0ZS1ub2RlLyBldGhlcm5ldC1waHlANDsKKworCQlwaHk6IGV0aGVybmV0LXBo
eUAwIHsKKwkJCS8qCisJCQkgKiBUaGUgUEhZIGNhbiBhcHBlYXIgZWl0aGVyOgorCQkJICogLSBB
UjgwMzU6IGF0IGFkZHJlc3MgMCBvciA0CisJCQkgKiAtIEFESU4xMzAwOiBhdCBhZGRyZXNzIDEK
KwkJCSAqIEFjdHVhbCBhZGRyZXNzIGJlaW5nIGRldGVjdGVkIGF0IHJ1bnRpbWUuCisJCQkgKi8K
KwkJCXJlZyA9IDwweGZmZmZmZmZmPjsKKwkJCXFjYSxjbGstb3V0LWZyZXF1ZW5jeSA9IDwxMjUw
MDAwMDA+OworCQkJcWNhLHNtYXJ0ZWVlLXR3LXVzLTFnID0gPDI0PjsKKwkJCWFkaSxwaHktb3V0
cHV0LWNsb2NrID0gIjEyNW1oei1mcmVlLXJ1bm5pbmciOworCQl9OworCX07Cit9OwpkaWZmIC0t
Z2l0IGEvYm9hcmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jIGIvYm9hcmQvc29saWRy
dW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jCmluZGV4IDhlZGFiZjQ0MDRjMi4uZmJhYjM5ZTgwMGE2
IDEwMDY0NAotLS0gYS9ib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMKKysrIGIv
Ym9hcmQvc29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jCkBAIC00NDcsNyArNDQ3LDcgQEAg
c3RhdGljIGludCBmaW5kX2V0aGVybmV0X3BoeSh2b2lkKQogICovCiBpbnQgZnRfYm9hcmRfc2V0
dXAodm9pZCAqZmR0LCBzdHJ1Y3QgYmRfaW5mbyAqYmQpCiB7Ci0JaW50IG5vZGVfcGh5MCwgbm9k
ZV9waHkxLCBub2RlX3BoeTQ7CisJaW50IG5vZGVfcGh5LCBub2RlX3BoeTAsIG5vZGVfcGh5MSwg
bm9kZV9waHk0OwogCWludCByZXQsIHBoeTsKIAlib29sIGVuYWJsZV9waHkwID0gZmFsc2UsIGVu
YWJsZV9waHkxID0gZmFsc2UsIGVuYWJsZV9waHk0ID0gZmFsc2U7CiAJZW51bSBib2FyZF90eXBl
IGJvYXJkOwpAQCAtNDc5LDYgKzQ3OSwxMiBAQCBpbnQgZnRfYm9hcmRfc2V0dXAodm9pZCAqZmR0
LCBzdHJ1Y3QgYmRfaW5mbyAqYmQpCiAJCXJldHVybiAwOwogCX0KIAorCS8vIHVwZGF0ZSBVLUJv
b3QncyBvd24gdW5pZmllZCBwaHkgbm9kZSBwaHkgYWRkcmVzcywgaWYgcHJlc2VudAorCW5vZGVf
cGh5ID0gZmR0X3BhdGhfb2Zmc2V0KGZkdCwgIi9zb2MvYnVzQDIxMDAwMDAvZXRoZXJuZXRAMjE4
ODAwMC9tZGlvL3BoeSIpOworCXJldCA9IGZkdF9zZXRwcm9wX3UzMihmZHQsIG5vZGVfcGh5LCAi
cmVnIiwgcGh5KTsKKwlpZiAocmV0IDwgMCkKKwkJcHJfZXJyKCIlczogZmFpbGVkIHRvIHVwZGF0
ZSB1bmlmaWVkIFBIWSBub2RlIGFkZHJlc3NcbiIsIF9fZnVuY19fKTsKKwogCS8vIHVwZGF0ZSBh
bGwgcGh5IG5vZGVzIHN0YXR1cwogCW5vZGVfcGh5MCA9IGZkdF9wYXRoX29mZnNldChmZHQsICIv
c29jL2J1c0AyMTAwMDAwL2V0aGVybmV0QDIxODgwMDAvbWRpby9ldGhlcm5ldC1waHlAMCIpOwog
CXJldCA9IGZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGVfcGh5MCwgInN0YXR1cyIsIGVuYWJs
ZV9waHkwID8gIm9rYXkiIDogImRpc2FibGVkIik7Ci0tIAoyLjM0LjEKCg==
--0000000000002f522d0614ac9c65--
