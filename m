Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6E606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rBV6aYPY;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MqtCsKTk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8762E80F4C;
	Wed, 21 Oct 2026 10:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hFpYI-R8FE9; Wed, 21 Oct 2026 10:44:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5372880F3C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792579455;
	b=ryZND+srfKLGr/VNY6tKHqRph8FB9Syw3JR/RGW14lA27tZglXCy6xoptq3ZmoGSlLtC
	 JTQAK89qy+sQ+kQTXOcIGIgPyTX8+bBMCkHTmSfDClUkOxkDV0wgGE5emtZLfngyU0b04
	 DQ16aYzNSMWBHEhOkiCv3kFg/Gb6GsdmndkbtX6pAhGIw9yAja0eQOkP1B31Bw7V5sr9O
	 Wb6hTAhMb28pCTVBGQ7SpT0wp3QtRcZhFafTcR2T1GUX7TeVJbxm91hGPpK0qC/pz2J9o
	 NG/w71/40Mf4/lqm/GL75vqBw3fn4tp9mzACoLSP0RApsEwXhOgtgcQgRQz8w8u1WHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792579455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E0fqjW8BoiM9lQZJ5yhWq1NJeqqmPrgC4klbrcWXoRk=;
	b=TT+pLn4qRCOUWpqWjGnECnxmEUqUuRY8g89U9iLFvzHu+9k/oOBLwB1C7njPDU+FUe4s
	 hEgMWrNkH46yGLJcYk6Ns5lKBL1kJTKWy2LDL6o8mhEuyvj4h9AfEBs+46Pvre6yBqzt0
	 Igw44HTmScf73p+VnaiHGYTMtylnaAEeTgWUgnaT7OkYgLd/n7mdlmxsUlPahwxJfOw3a
	 JyEKME/RnxU4HWC2j3GobSpWhxtxMn+tWTzkRI8X2BUnRRphBupa2kU91DE0EQBySc0Az
	 UUxJ/mb6SUkttGg1y/+cFRsq+oT2Klx2U3ZYNdwadInZNcoNCBROdvTQUSVikL5IbLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792579455;
	bh=E0fqjW8BoiM9lQZJ5yhWq1NJeqqmPrgC4klbrcWXoRk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rBV6aYPYWtm0qOQQ4kzlwDXnY16bnEzStabGUa/duKk2aU0jcE3Vvclzf53MfjB7z
	 CVgA8P1AXfiWX/4CXwhkRprjl/XfWso2zCzP3lhiZPBJlUnNhXN0w2sEw2JT6dfGAy
	 fwT7IqK3uZ7Wz4GfjEAOBiV81kaObGWWcYbWKCZzyFF1VrzTwC7aEI12LNyi7bVlxX
	 Z5K2AlJcMNXUycr04ViexuEZXwrBB1vxJm76RD2JM3nLBI0T4tXe9GS5i0R93JyrbH
	 33rnqQ3S6/3TUg8PMMmUOvALdnXFEWaE2goHSedbOYf1XDM7WPptoaXGFfHDQBvhX+
	 znPHUiXcIhxSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5372880F3C;
	Wed, 21 Oct 2026 10:44:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84F801E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8299240380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRAxJFPMh2Q5 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:44:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E27DC40060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792579452;
 b=qW+Pog20QKhTKIqfsvc90qfYWvVM9ElSXjxR9sgKe/cD/5lvajGPpblnBBECxYlm7zJ9
 uiQuu66BnWI/rseWcrzyeoImd4aT528ogArKGvBDF8Vu46ZaYHrrGA8QRWQaFeTLfsFb4
 7/gtd4NuUYbe2E3YzLCvnsqH9OlUobUJ1RRWU8csEbeqDGrLr20i9dG+ePflX+z9VCJBk
 R0Ndzy9YuGqp3ZYRMJirefMQOVIHFA2hn1g2u+wRY1cvlLxdUDULEhnhsQUMwwo5TCYy2
 AipubbvDVdtqo/kkfLnC1Qz5Fm+3kQgwUEajZLPF65ZlAtVU5VMbut2aP9j9+zbnbcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792579452;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=E0fqjW8BoiM9lQZJ5yhWq1NJeqqmPrgC4klbrcWXoRk=;
 b=YlfnkCnYYIAw73DUUtZv10FU8zRAI77VecAocnauCRDSBZsxOZNnVi2q6BsQs/+tVZip
 ouswWMZnxy/zgAc+vU0KqxrLOOK4zY6GRi66NmPxUEfeEE1968sm3ZW0l3vo8YI0BOjXx
 k62MSCzTaLDlk97QSA3Mk8LAfAF25SK5UMwENFlybMTnTSDjqUM/CgPtrgBbqzW8vaD2t
 8ApEoUSGw3836kXiCp3ad+tDfOGQeoVwnkKICcX1JgBb5xQxDH4tTe8tDw3i35X2wx6G6
 FJqdg9nVAkZCzOPeY8D2U5jv0x8uAXgAUNltpkJ/B8iM1BYsGOwPEtmJcrzLE0VZ3Qw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=MqtCsKTk; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=MqtCsKTk
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E27DC40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792579449; x=1793184249; i=fiona.klute@gmx.de;
 bh=E0fqjW8BoiM9lQZJ5yhWq1NJeqqmPrgC4klbrcWXoRk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MqtCsKTkBgAFLKGMDt7rLXt4lsRaL9F8HViDJ+gJSUSV+rUrPw0t505eo9PPwFzH
 VpD7k1g2FBxKG2qRY1RwyqyLLuOEu7Qjrtv1/Rd+ExKztRos/UOwT3tmEmZtyPONu
 rbTRQxxpXik3bgTPnx9pJqoHgHQn1kiwx2XM0WNlYK6MNFn3LjShrbeFGTggjermN
 XOeQ6WGKW/BiKFxBtiIrQ/OB4G2x1aFl+bb9HXFxDYHXiBU+Y+1W2s22VLK59h+GQ
 OnESVv+FEmDyZzk9/nmWeFkjqx0t3XlSygvH8FJ9zbeO/LS6hpGBoFWNCoFBRZRFf
 beNbPVJ16ocD0oqQ2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1xK1lb2Eeg-00ASBH; Wed, 21
 Oct 2026 12:44:09 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>,
 u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH v3] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Wed, 21 Oct 2026 12:43:56 +0200
Message-ID: <20261021104356.2084625-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ccUllrynQuigqK8lrekcSdG/evxq5i9G1xOTs+n+7k4oKYX7Vza
 f2VCXy9XC+IUuz3SRETBxZWWN2b/F7G9FiyyBNaRZXHUqmrQGJq7iB/oGFYTJ2skE50Dske
 xbRzrSUCIB9LCMy/YKfOIuNHdqWzFR8JAglKCRzfiAL6mwR2eQEtv1p6GDo9NLINGnylLLg
 YCjZZlOXilZetGnwBR/ew==
UI-OutboundReport: notjunk:1;M01:P0:jhlOGOufFHM=;msjshBCPYRmujNUtK0tPWL4V/2+
 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
 AhWmwhQltBIRHxrxD5V0+PM3wr7Jk=
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
b24uCgpTaWduZWQtb2ZmLWJ5OiBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgpSZXZp
ZXdlZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT4KLS0tCkNoYW5nZXMgdjIg
LT4gdjM6CiogImNhbiBzdGlsbCBiZSIgLT4gImFyZSIgaW4gZG9jL2RldmVsb3AvZW52aXJvbm1l
bnQucnN0CgpDaGFuZ2VzIHYxIC0+IHYyOgoqICJjYW4gYmUgd3JpdHRlbiBmcm9tIiAtPiAiY2Fu
IGJlIGxvYWRlZCBmcm9tIgoqIGNsYXJpZnkgdGhhdCAiZW52IHNhdmUiIHdpbGwgYWxzbyBzdG9y
ZSBub24td3JpdGVhYmxlIHZhcmlhYmxlcwoKIGRvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJzdCB8
IDcgKysrKysrKwogZW52L0tjb25maWcgICAgICAgICAgICAgICAgIHwgNSArKystLQogMiBmaWxl
cyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJzdCBiL2RvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJz
dAppbmRleCBhN2VkNGFhYjBhNS4uZDc2MzRiYTIzNGIgMTAwNjQ0Ci0tLSBhL2RvYy9kZXZlbG9w
L2Vudmlyb25tZW50LnJzdAorKysgYi9kb2MvZGV2ZWxvcC9lbnZpcm9ubWVudC5yc3QKQEAgLTg5
LDMgKzg5LDEwIEBAIGFuIGFzc29jaWF0aW9uIGluIHRoZSBzdGF0aWMgbGlzdC4KIElmIENPTkZJ
R19SRUdFWCBpcyBkZWZpbmVkLCB0aGUgdmFyaWFibGUgbmFtZSBpcyBldmFsdWF0ZWQgYXMgYSBy
ZWd1bGFyCiBleHByZXNzaW9uLiBUaGlzIGFsbG93cyBtdWx0aXBsZSB2YXJpYWJsZXMgdG8gZGVm
aW5lIHRoZSBzYW1lIGZsYWdzIHdpdGhvdXQKIGV4cGxpY2l0bHkgbGlzdGluZyB0aGVtIGFsbC4K
KworSWYgQ09ORklHX0VOVl9XUklURUFCTEVfTElTVCBpcyBkZWZpbmVkLCBvbmx5IGVudmlyb25t
ZW50IHZhcmlhYmxlcword2hpY2ggZXhwbGljaXRseSBzZXQgdGhlICd3JyB3cml0ZWFibGUgZmxh
ZyBjYW4gYmUgbG9hZGVkIGZyb20gc3RvcmVkCitlbnZpcm9ubWVudC4gSXQgcmVzdHJpY3RzIG9u
bHkgZW52aXJvbm1lbnQgbG9hZGluZywgbm90IHJ1bnRpbWUKK21vZGlmaWNhdGlvbiB1c2luZyAi
ZW52IHNldCIsIGV0Yy4gTm9uLXdyaXRhYmxlIHZhcmlhYmxlcyBhcmUgd3JpdHRlbgordG8gc3Rv
cmVkIGVudmlyb25tZW50IChlLmcuIGBgZW52IHNhdmVgYCwgb3IgYGBmd19zZXRlbnZgYCBmcm9t
IGEKK3J1bm5pbmcgT1MpLCBidXQgd2lsbCBiZSBpZ25vcmVkIHdoZW4gbG9hZGluZyB0aGUgZW52
aXJvbm1lbnQuCmRpZmYgLS1naXQgYS9lbnYvS2NvbmZpZyBiL2Vudi9LY29uZmlnCmluZGV4IGM2
ZGYwOWEzMzQ5Li4zOTRlOTE4MzNhMyAxMDA2NDQKLS0tIGEvZW52L0tjb25maWcKKysrIGIvZW52
L0tjb25maWcKQEAgLTg5Nyw4ICs4OTcsOSBAQCBjb25maWcgRU5WX1dSSVRFQUJMRV9MSVNUCiAJ
c2VsZWN0IEVOVl9BUFBFTkQKIAloZWxwCiAJICBJZiBkZWZpbmVkLCBvbmx5IGVudmlyb25tZW50
IHZhcmlhYmxlcyB3aGljaCBleHBsaWNpdGx5IHNldCB0aGUgJ3cnCi0JICB3cml0ZWFibGUgZmxh
ZyBjYW4gYmUgd3JpdHRlbiBhbmQgbW9kaWZpZWQgYXQgcnVudGltZS4gTm8gdmFyaWFibGVzCi0J
ICBjYW4gYmUgb3RoZXJ3aXNlIGNyZWF0ZWQsIHdyaXR0ZW4gb3IgaW1wb3J0ZWQgaW50byB0aGUg
ZW52aXJvbm1lbnQuCisJICB3cml0ZWFibGUgZmxhZyBjYW4gYmUgbG9hZGVkIGZyb20gc3RvcmVk
IGVudmlyb25tZW50LiBUaGlzCisJICByZXN0cmljdHMgb25seSBlbnZpcm9ubWVudCBsb2FkaW5n
LCBub3QgcnVudGltZSBtb2RpZmljYXRpb24gdXNpbmcKKwkgICJlbnYgc2V0IiwgZXRjLgogCiBj
b25maWcgRU5WX0FDQ0VTU19JR05PUkVfRk9SQ0UKIAlib29sICJCbG9jayBmb3JjZWQgZW52aXJv
bm1lbnQgb3BlcmF0aW9ucyIKLS0gCjIuNTUuMAoK
