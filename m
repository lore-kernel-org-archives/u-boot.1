Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194CC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8067082EA9;
	Mon, 30 Jun 2025 12:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="arUy46NL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1A082E40; Mon, 30 Jun 2025 12:53:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D47F82E08
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751280819; x=1751885619; i=fiona.klute@gmx.de;
 bh=/hrL2tIZNsPjDL5SIVVUhuW+6h/ERPQpbC/uXYO7G0s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=arUy46NLnIXFHVnXtDo6oNn0VakGFVQGQEHv2c5i6HzXqpBRw6NvCz0kvERFExOb
 XPp/a8zTho97Ntx6YFbMBAguT66bn3AWCQlhCWoHytDvHpJF9lCYPMUUyI8Y2GF0G
 /Pncrq8aoe4opLOWkrAxfBZWGI1T/4gpTWnG64yQRYBOhGfDwB25ti8/e+ApU8zC8
 1oMzbGj5m0qtd/zsa3i/W0HnDcpiTVT8lF5tGyuoPNTwVphrhuUCW9wGXJkJ5RnmG
 PBV7YtvcqmMkjWJatTnGQWZWl+wlsHcLlKs47ZkspR77Z+gX/uc+nWP2m1DhzHfWl
 nxUpP+9GcVodkce5jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.121.243]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ygt-1uY79U1il1-00D6B8; Mon, 30
 Jun 2025 12:53:39 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 3/3] doc: PXE: mention extlinux.conf and sysboot
Date: Mon, 30 Jun 2025 12:53:23 +0200
Message-ID: <20250630105323.1346850-4-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630105323.1346850-1-fiona.klute@gmx.de>
References: <20250630105323.1346850-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:oYFL1tZ56s5FUyZhgMHNMbt9sry4y1dxOB68UnjmkU70/QWyULL
 S0VZTU4dPxn32BoqSpBwDs40PnWi6bUYngi4gjOw7nVB34VOq1LVrw94TYGEx6JpY0jQNlD
 u/QmTc2dr9TPnXv3xewOUSKbuINegvVmKXYVjTwF4KjeF4ksELt4hwhFv0dYsU1/fsrzsBP
 WxbhlLlmbc3wOcfc/H4XA==
UI-OutboundReport: notjunk:1;M01:P0:onyf+y3xWIQ=;GlJbbFhjFPubojwpH7r59yUrWhs
 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
 IbSoNtyrd8w==
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

VGhlc2UgdXNlIHRoZSBzYW1lIGZvcm1hdCBhcyBQWEUgYm9vdC4KClNpZ25lZC1vZmYtYnk6IEZp
b25hIEtsdXRlIDxmaW9uYS5rbHV0ZUBnbXguZGU+CkNjOiBUb20gUmluaSA8dHJpbmlAa29uc3Vs
a28uY29tPgotLS0KIGRvYy91c2FnZS9weGUucnN0IHwgMjMgKysrKysrKysrKysrKysrKysrKy0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RvYy91c2FnZS9weGUucnN0IGIvZG9jL3VzYWdlL3B4ZS5yc3QKaW5kZXggZDIz
Y2Q0NTMyMjcuLmMyZGMxMWYyMThkIDEwMDY0NAotLS0gYS9kb2MvdXNhZ2UvcHhlLnJzdAorKysg
Yi9kb2MvdXNhZ2UvcHhlLnJzdApAQCAtMSwxOSArMSwyMiBAQAogLi4gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArCiAgICBDb3B5cmlnaHQgMjAxMC0yMDExIENhbHhlZGEsIEluYy4K
IAotUFhFIEJvb3QKLT09PT09PT09CitQWEUgQm9vdCBhbmQgZXh0bGludXguY29uZgorPT09PT09
PT09PT09PT09PT09PT09PT09PT0KIAogVGhlIGBgcHhlYGAgY29tbWFuZHMgcHJvdmlkZSBhIG5l
YXIgc3Vic2V0IG9mIHRoZSBmdW5jdGlvbmFsaXR5CiBwcm92aWRlZCBieSB0aGUgUFhFTElOVVgg
Ym9vdCBsb2FkZXIuIFRoaXMgYWxsb3dzIFUtQm9vdCBiYXNlZCBzeXN0ZW1zCiB0byBiZSBjb250
cm9sbGVkIHJlbW90ZWx5IHVzaW5nIHRoZSBzYW1lIFBYRSBiYXNlZCB0ZWNobmlxdWVzIHRoYXQK
IG1hbnkgbm9uIFUtQm9vdCBiYXNlZCBzZXJ2ZXJzIHVzZS4KIAorVGhlIGBgc3lzYm9vdGBgIGNv
bW1hbmQgYW5kIEV4dGxpbnV4IGJvb3QgbWV0aG9kIHVzZSB0aGUgc2FtZSBmaWxlCitmb3JtYXQg
YXMgUFhFIGJvb3QgZm9yIGBgZXh0bGludXguY29uZmBgLgorCiBDb21tYW5kcwogLS0tLS0tLS0K
IAogYGBweGUgZ2V0YGAKLSAgICAgICAgKipzeW50YXg6KiogYGBweGUgZ2V0YGAKKyAgICAgICAg
KipTeW50YXg6KiogYGBweGUgZ2V0YGAKIAogCWZvbGxvd3MgUFhFTElOVVgncyBydWxlcyBmb3Ig
cmV0cmlldmluZyBjb25maWd1cmF0aW9uIGZpbGVzCiAJZnJvbSBhIHRmdHAgc2VydmVyLCBhbmQg
c3VwcG9ydHMgYSBzdWJzZXQgb2YgUFhFTElOVVgncyBjb25maWcKQEAgLTMwLDcgKzMzLDcgQEAg
Q29tbWFuZHMKIAlodHRwOi8vc3lzbGludXguenl0b3IuY29tL3dpa2kvaW5kZXgucGhwL0RvYy9w
eGVsaW51eAogCiBgYHB4ZSBib290YGAKLSAgICAgICAgKipzeW50YXg6KiogYGBweGUgYm9vdCBb
cHhlZmlsZV9hZGRyX3JdYGAKKyAgICAgICAgKipTeW50YXg6KiogYGBweGUgYm9vdCBbcHhlZmls
ZV9hZGRyX3JdYGAKIAogCUludGVycHJldHMgYSBweGUgZmlsZSBzdG9yZWQgaW4gbWVtb3J5Lgog
CkBAIC00MCw2ICs0MywxOCBAQCBDb21tYW5kcwogCVRoZXJlIGFyZSBzb21lIGVudmlyb25tZW50
IHZhcmlhYmxlcyB0aGF0IG1heSBuZWVkIHRvIGJlIHNldCwKIAlkZXBlbmRpbmcgb24gY29uZGl0
aW9ucywgc2VlIHRoZSBFbnZpcm9ubWVudCBzZWN0aW9uIGJlbG93LgogCitgYHN5c2Jvb3RgYAor
ICAgICAgICAqKlN5bnRheDoqKiBgYHN5c2Jvb3QgWy1wXSA8aW50ZXJmYWNlPiA8ZGV2WzpwYXJ0
XT4gPGV4dDJ8ZmF0fGFueT4gW2FkZHJdIFtmaWxlbmFtZV1gYAorCisJTG9hZCBhbmQgYm9vdCBh
biBgYGV4dGxpbnV4LmNvbmZgYCBmaWxlIGZyb20gYSBsb2NhbAorCWZpbGVzeXN0ZW0uIFBhdGhz
IGluIHRoZSBgYGV4dGxpbnV4LmNvbmZgYCBmaWxlIChrZXJuZWwsCisJaW5pdHJkLCBGRFQgYW5k
IG92ZXJsYXlzKSB3aWxsIGJlIGludGVycHJldGVkIHdpdGhpbiB0aGF0CisJZmlsZXN5c3RlbS4K
KworCUV4YW1wbGU6CisKKwlgYHN5c2Jvb3QgbW1jIDAuMDoyIGFueSAke3B4ZWZpbGVfYWRkcl9y
fSAvYm9vdC9leHRsaW51eC5jb25mYGAKKwogRW52aXJvbm1lbnQKIC0tLS0tLS0tLS0tCiAKLS0g
CjIuNTAuMAoK
