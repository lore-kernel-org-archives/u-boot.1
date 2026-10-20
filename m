Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kdAf9LBm;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Mht6AHHU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6CD360745;
	Tue, 20 Oct 2026 11:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHMaA_v0jJqx; Tue, 20 Oct 2026 11:24:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 064B9607AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792495461;
	b=qfcjrTZ+If59xI57hfjHwz5ECJ9dsMzyhYoJNpHwEl39O2lKSECgdSkPaTJWdqYYbn54
	 MtKnOHhKen6x92eLtRDEpmBq/QS38s+z1ZubHqKcgrADf6ZKEJABXthF0yZDDh9WpkYxr
	 OW+Ro+Azd9f9JKEDkJslW6EtnQbXcHGvQOhHAyOU1Jpq7huAuOAxA6pmkLL+EXxa9yATH
	 aXSrLHKhMj/aUBCTpRGs06r72mlSvoSV6ru4K4FtkO1ST8Mcd/Q2F02tu/9iud/xS+7Wx
	 DOoLYxJX3+wIR8L4V0L2MUTQb6ZmW20Ap4tcl3zZjUJgPlXAtCugFO5G4ULe9GLHWFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792495461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0oJnaZXsBk9g/8KB5Z2qaWyK9lPpXFkj5Ob8G42hTxk=;
	b=FzGvQLI73v3lSeJuAgYv2xLDov0oGN3lcZHbLxJEwxMMgv1k4idpOWo33poGFsiLmKSR
	 Mo/WQvb2xdWbCqxaJIDrPFefe72N/ZFSXsmCKFUanDY0BwUsxcwJoLCE1g2Pagqup+ivS
	 NehZ7SiwV/9gxtZgmgfMZvj7zaX2gt3OjJSl63Q4LdFC+puZGS6l/tL90CYdUTv0+rT93
	 uOIMW+XT6pccyG83pIT8JvgnUeldVXYDD3/S5GYhX+tG+x9goP/pdAJ+4chBrix15J7TB
	 oP0DdX1YOVfsC3pM15k1h2OOCjhcR6qX0AMIo1K7YWx8OUZvwFs11VpLH8tLLNvCYZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Mht6AHHU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792495461;
	bh=0oJnaZXsBk9g/8KB5Z2qaWyK9lPpXFkj5Ob8G42hTxk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kdAf9LBmbyEpBwh20Y2LERR+rCvFPIkvPBWvVkmE3KvtP2VlH44Fh0vXl/5W9lYuV
	 w2gxWgjqMGTARVZuG55iQBOt1Qhci9RsNvSY4JfuPHC9xobww1F4SKmNnRlJB5UOrh
	 T9Bw7gTOaBZjzOpucnmh2fn+m+b/VpfZJrZ/9cfG5zAKy1o+vdmgd7Ca2N3ko0f0fx
	 GhmwBDb99XydWQ3uMuPlesHV8TNbiUO3A/UFRxktnnBFEWWYwgODdgbEkS7FIFhXnh
	 smIStP5kEyjjJIwSmo1gErXQGHscWjeC65vU+FMs+MkADBmwodgcLYRzOmcbJZKGyf
	 8eLj0eM/4mPqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 064B9607AA;
	Tue, 20 Oct 2026 11:24:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FA27465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 817D560745
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ-iDOIdXptN for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34C25605FC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792495458;
 b=Xi234lz73xj5LnlBJmpE34pp+laiCV454dRczDBmGw0DldE6xBaN/grdqBFHJ2kTZv7b
 ah2L3wUGwmU4L8EvRWZjxVxW/gJFb/Qi49po3aHJOpaVeb6Pk4Ko3QL66MUldCjS90rOH
 kB65EjwadMqNKsWO7m+ffemjw8q11ilCkvGBhodDWoiMOltr26ViTNpiwqpQ9Nhh+c0CA
 Bx4zvO6S61w8B+SgJ/wQeIg422xE73f8lN93a7Sn3mgamrlux4ShDDi2Jz4WitalnpaUj
 Yw1ezxiNfd1eg5Mkydmwf87SM4CVnImnPqKIDPpuwiAxBSIDIAF/Iqb1PrBO9wHPqgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792495458;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=0oJnaZXsBk9g/8KB5Z2qaWyK9lPpXFkj5Ob8G42hTxk=;
 b=lGsdoIPdUuHpzI85c5Hh4xlIazOx5Tc9bVgRPtAx76izMtBs0i2+vgOdrjS4MR5cDlwh
 8A9koPpy7fPjYBj8qPNjJy8Qsl1yTB4gkz9m6T+iH1HRKWD8Tzm/eRa4Rk4HX5KPnFa+b
 4xsDXzC/E1oEaD4nM3BIfCh2rBp/lRwCqDfArY19bD43TLsJgOeOdNCdig0nqwVPR2VCH
 utbHJIP8O9RXOQ7KynzEHSW/xiPH3gzzm/vA3ySIBaGtGqzIzDkToFAvV03VkCbSAkuiU
 QqkhSK4e/voKMbLhsDX0Sy0Ix64j1Sh00jaoqichMD9w3TzKa8sgH+6q9x8NinjRpGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=Mht6AHHU; 
 arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=Mht6AHHU
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34C25605FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792495454; x=1793100254; i=fiona.klute@gmx.de;
 bh=0oJnaZXsBk9g/8KB5Z2qaWyK9lPpXFkj5Ob8G42hTxk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Mht6AHHUDy1h42YQ6JrNMLXfJXGySyUK0fx7OyjxWseqSmq5djFE87HeBqvOKApI
 QQnfiygjonRh83gKSl0tQ3GJbOI7KUero1ifQuxL4AIEJdpByuaXHdKU8a90NQHzm
 DxGAjEPZ9Jo1QGB3GG7k6vtI+uvdZwf13XY9YxHhIru+YFConoUChwYv9ofn43hSc
 B/hm4Z/WJCVs49oF1txF/D9nGPs8ZIauWRdTR3BooOu//rat0Jsi2zAmdZXli1US6
 L2jdASIaLEWx9dNHkn1Db+8TL8z/7hgYeVKop3rPuEjiGJfJqBkBC8dSpyaEhZJIt
 i+vsiXqiBSwSz0xcqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1xJNzt2kcp-001i76; Tue, 20
 Oct 2026 13:24:14 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>,
 u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH v2] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 13:23:58 +0200
Message-ID: <20261020112358.523872-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:oZglzASlSJwv3fIJ7xd+4XWL7ncvu5FsTJD3yr3MBMixv+snIjh
 X/silzKo9VH0Ryk7HoI5VXa1dFhgFyMTVYf1FS3PukAJXEYET2ugRWh24c/sOoy+qaC7eKg
 AHcPxAvBaLQm09KMJeJGY6xHG/1z8QRZ/y/zadAd/zysSA8/arWCm1kvo9hRoy1yi4UfT0v
 VQ6QGTkp+TtP3r48TxJEQ==
UI-OutboundReport: notjunk:1;M01:P0:Or2M9RpcHQs=;h1Se98mvRN8lrMKN13IEsdrEvqV
 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
 =
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Q09ORklHX0VOVl9XUklURUFCTEVfTElTVCBvbmx5IHJlc3RyaWN0cyBsb2FkaW5nIHN0b3JlZCBl
bnZpcm9ubWVudCwKbm90IHJ1bnRpbWUgbW9kaWZpY2F0aW9uIGUuZy4gdXNpbmcgImVudiBzZXQi
LCB3aGlsZSB0aGUgS2NvbmZpZwpkZXNjcmlwdGlvbiBpbXBsaWVkIG90aGVyd2lzZS4gRGVzY3Jp
YmUgdGhlIGFjdHVhbCBiZWhhdmlvciwgYW5kIGFkZCBhCm5vdGUgaW4gdGhlIGRvY3VtZW50YXRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgotLS0K
Q2hhbmdlcyB2MSAtPiB2MjoKKiAiY2FuIGJlIHdyaXR0ZW4gZnJvbSIgLT4gImNhbiBiZSBsb2Fk
ZWQgZnJvbSIKKiBjbGFyaWZ5IHRoYXQgImVudiBzYXZlIiB3aWxsIGFsc28gc3RvcmUgbm9uLXdy
aXRlYWJsZSB2YXJpYWJsZXMKCiBkb2MvZGV2ZWxvcC9lbnZpcm9ubWVudC5yc3QgfCA3ICsrKysr
KysKIGVudi9LY29uZmlnICAgICAgICAgICAgICAgICB8IDUgKysrLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kb2MvZGV2
ZWxvcC9lbnZpcm9ubWVudC5yc3QgYi9kb2MvZGV2ZWxvcC9lbnZpcm9ubWVudC5yc3QKaW5kZXgg
YTdlZDRhYWIwYTUuLmM0MDJlZTAyNmY3IDEwMDY0NAotLS0gYS9kb2MvZGV2ZWxvcC9lbnZpcm9u
bWVudC5yc3QKKysrIGIvZG9jL2RldmVsb3AvZW52aXJvbm1lbnQucnN0CkBAIC04OSwzICs4OSwx
MCBAQCBhbiBhc3NvY2lhdGlvbiBpbiB0aGUgc3RhdGljIGxpc3QuCiBJZiBDT05GSUdfUkVHRVgg
aXMgZGVmaW5lZCwgdGhlIHZhcmlhYmxlIG5hbWUgaXMgZXZhbHVhdGVkIGFzIGEgcmVndWxhcgog
ZXhwcmVzc2lvbi4gVGhpcyBhbGxvd3MgbXVsdGlwbGUgdmFyaWFibGVzIHRvIGRlZmluZSB0aGUg
c2FtZSBmbGFncyB3aXRob3V0CiBleHBsaWNpdGx5IGxpc3RpbmcgdGhlbSBhbGwuCisKK0lmIENP
TkZJR19FTlZfV1JJVEVBQkxFX0xJU1QgaXMgZGVmaW5lZCwgb25seSBlbnZpcm9ubWVudCB2YXJp
YWJsZXMKK3doaWNoIGV4cGxpY2l0bHkgc2V0IHRoZSAndycgd3JpdGVhYmxlIGZsYWcgY2FuIGJl
IGxvYWRlZCBmcm9tIHN0b3JlZAorZW52aXJvbm1lbnQuIEl0IHJlc3RyaWN0cyBvbmx5IGVudmly
b25tZW50IGxvYWRpbmcsIG5vdCBydW50aW1lCittb2RpZmljYXRpb24gdXNpbmcgImVudiBzZXQi
LCBldGMuIE5vbi13cml0YWJsZSB2YXJpYWJsZXMgY2FuIHN0aWxsIGJlCit3cml0dGVuIHRvIHN0
b3JlZCBlbnZpcm9ubWVudCAoZS5nLiBgYGVudiBzYXZlYGAsIG9yIGBgZndfc2V0ZW52YGAKK2Zy
b20gYSBydW5uaW5nIE9TKSwgYnV0IHdpbGwgYmUgaWdub3JlZCB3aGVuIGxvYWRpbmcgdGhlIGVu
dmlyb25tZW50LgpkaWZmIC0tZ2l0IGEvZW52L0tjb25maWcgYi9lbnYvS2NvbmZpZwppbmRleCBj
NmRmMDlhMzM0OS4uMzk0ZTkxODMzYTMgMTAwNjQ0Ci0tLSBhL2Vudi9LY29uZmlnCisrKyBiL2Vu
di9LY29uZmlnCkBAIC04OTcsOCArODk3LDkgQEAgY29uZmlnIEVOVl9XUklURUFCTEVfTElTVAog
CXNlbGVjdCBFTlZfQVBQRU5ECiAJaGVscAogCSAgSWYgZGVmaW5lZCwgb25seSBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgd2hpY2ggZXhwbGljaXRseSBzZXQgdGhlICd3JwotCSAgd3JpdGVhYmxlIGZs
YWcgY2FuIGJlIHdyaXR0ZW4gYW5kIG1vZGlmaWVkIGF0IHJ1bnRpbWUuIE5vIHZhcmlhYmxlcwot
CSAgY2FuIGJlIG90aGVyd2lzZSBjcmVhdGVkLCB3cml0dGVuIG9yIGltcG9ydGVkIGludG8gdGhl
IGVudmlyb25tZW50LgorCSAgd3JpdGVhYmxlIGZsYWcgY2FuIGJlIGxvYWRlZCBmcm9tIHN0b3Jl
ZCBlbnZpcm9ubWVudC4gVGhpcworCSAgcmVzdHJpY3RzIG9ubHkgZW52aXJvbm1lbnQgbG9hZGlu
Zywgbm90IHJ1bnRpbWUgbW9kaWZpY2F0aW9uIHVzaW5nCisJICAiZW52IHNldCIsIGV0Yy4KIAog
Y29uZmlnIEVOVl9BQ0NFU1NfSUdOT1JFX0ZPUkNFCiAJYm9vbCAiQmxvY2sgZm9yY2VkIGVudmly
b25tZW50IG9wZXJhdGlvbnMiCi0tIAoyLjU1LjAKCg==
