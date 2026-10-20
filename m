Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A6606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=udcOiChV;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cKYN9QBu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 080588109E;
	Tue, 20 Oct 2026 09:21:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xxV3XjS5EKjV; Tue, 20 Oct 2026 09:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3830E8100F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488117;
	b=FzzwdduOjSAYphLQBu5vrMhC8PBZs61tUbx679uN2SI4JOcpDkqLxfTWQroKQfjykjvG
	 NvfqRcdhXvHkPTUB+6GQiM03CA7hMZfve5iBrRJqxdKI15xWfl+9uybqcrniFlid/WW7j
	 Lv8bKlicbr6ssvcrMv6sP8aByjHwWO3+gJS3B6Z3VfJUWfP67aU6PkMajtj6g6GM8+ebA
	 9XeBjnaGq7DxXRafUSVeq1+iN2W6DrJ3xdW/91qcP91ZuE5+3+lb/XO3iZtUnGQwAFsxQ
	 Q/oCaMZiwQQk6UIKHHBD/IofQTtXB7Em7ryVFCEMlZNB1RoxSlE01wWO9uRKoj6y2SQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x27VnVcO+PUXaO8ysN9b2Uu5vyTuiP03ZyZnMS/vjqk=;
	b=F/ta5Q5t3JKxZxHCxmJJLf52inWPieHWCYEjUbQmB/VqO9b+2jelqSUN8nzDf6I1A7Xb
	 /k7uc80VlubOqzaewk5N675v3Ku4U1F/yGFdPva8NITQYAT/LeYydh5QR/Q76GU4kmpn0
	 v9EUCvRtKJAuHA+D5SzzKyQbZahbBanEV3LG6IYBA/Ugt1CXPKRpoLekdvmL+IpFKFI+z
	 Qf52KYLJtolqpk/Gd0PF6La2BjFEK/V27Schh819Lje4EwNjBAcm18Si2832TmA4mPN58
	 z/y96ymhbGRPTWmPbs/WDFmuJ0nRmWV5sDXMaonieZCm885yZa1MZV+/Bu1j81/q81w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cKYN9QBu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488117;
	bh=x27VnVcO+PUXaO8ysN9b2Uu5vyTuiP03ZyZnMS/vjqk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=udcOiChVxMuKdOCEjDp1gBGvfcD1B7GiZysUE90TJEMTLtilKN08rILbewLGPu6MF
	 hPt/w2yWfS4XCIhRu2hEJzq+jQF9JXdAiBoMyj2ngGuFmI8QvZu7xnULl8ntZ/7WLH
	 dEmWA34qP7U3XkuXnRaoQER1BZo1sU6XqMo0MnPp+GiswD97tw4K+pmy/QrNAR7D3R
	 x8GqNaZP+ztVCYlkDp+l+ZJGfHvuLehunucK9v+6Jct9mgNuZnHESjbK898SU6CbHv
	 6V3zyyFIVBNBvS7vGFA651WybvjHvTy7+OGP0u0Wo6B/tjs+KJxQOn0D5NGTTNfbrx
	 Ru7PuR0psx8cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3830E8100F;
	Tue, 20 Oct 2026 09:21:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E1703A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7FA08100F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYouplv8C42O for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C59481004
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488115;
 b=mRdnE4Z59IRp5OQSOJk7KLqLD5zjBSj89wQtsZqAgOIDMSiVb+8eqmfRO1H5sGbhMnm8
 oY35DQ6hRckt+x5RPXP00DNzNXDHACZQp4smO71BdZ6U235A8DItS158sLRh21mg0yUj6
 1jJO3IfQ0b+rKy0u+EfnPqfnaC6hpkt0ntrcNSNN5Amr1T+b6ZSE2HxMAKbj1gCDtA1sG
 fEGp4FfaDL4EraxQGUayv4TXpDmKbifmrUqlrpBP+jUoqGXNO/plDooWv+GmLUkndpmuK
 UyzH5/OQ+dL2iUigcOk6WmFH7z+Aq7fLpLPl7xGsBXemUvtil2MfLgcMvQqHZ4Zo3vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488115;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=x27VnVcO+PUXaO8ysN9b2Uu5vyTuiP03ZyZnMS/vjqk=;
 b=imLWBFokw8oVnTkU+5Ors5VX3kU9llID95OUffhhu+AEVS6n4L4qSycIJ2aRQ11IZrLd
 V969MIO+7hc6laOTUdd17puLOl+mcQYu5kEsdSeaa9/UNtgoxzI4SlaeRlJHjt9Fh5Ksb
 kj2aSU0zPg3RdN/umDlXGQM/JaMq2xMq/witTka7XKja8kmuYVWaAfGTml9zVUDgJcTsa
 Za/uoOTF3foNUiL4dzswgTJanmDyP+dCEmEN2KVZQqOvlLd4fl299F8PosUxgTV0adTrk
 jIZHa69Z2ft27BaQ8Q8eq+gY5en45AOfx8oTj3dmNNenLzrhoDNPbjDE02YSxJPkr5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=cKYN9QBu; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=cKYN9QBu
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C59481004
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792488106; x=1793092906; i=fiona.klute@gmx.de;
 bh=x27VnVcO+PUXaO8ysN9b2Uu5vyTuiP03ZyZnMS/vjqk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cKYN9QBu8TOj3gHaUpmStZR1FC3CnEf9X5IqK/FolWKmDRTfeuyweXEnK/kfeW6U
 meLcd6C/fYMvp4Rrmlk/QIHuNRTQHOxsa000Pdzk5u8d5cCTQeUK0obLMmra5qzZC
 ji4l3KV3DnlIn0HlmtcetulYiXpOxgrEn75Hpk8Erw58/eloqZ6OVxuU7XxTjQr1+
 D92vKyKwEWFEqYO3TcFegfXvRwQ/7YBW2+Wg2rw0ZnU5Y4GZZTX6ojp9byD3yuw4Z
 3LafB2vILVzzwyYlSfGG91eWbkavBT9tWe2JgKyRvYvI+1Ns0wqqudXIYguAIlnIv
 H5Hb4OzVhQ8babIj9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1whYMl1EpF-00q7xj; Tue, 20
 Oct 2026 11:21:46 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>,
 u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 11:21:37 +0200
Message-ID: <20261020092137.242656-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:B97Jv3MUs5UG8lx5HkL5+KBwZhi8gzaiqb5e0q7LFtQmB6poL3s
 f6+q3HH88rDkZu5nSlEihwAEzGUHCnGJxtkU1siJVRHqAT2fh+Z+5M7PSmKtchUwUkEORor
 V1p43wEM7b1O8tRk3FgZwO3nHU5EoBryVrSrCW9jklMRYpqrwWjxE9OVrqcKt5OFsjgJlre
 tTT78epBE9dH3vdY2XpKw==
UI-OutboundReport: notjunk:1;M01:P0:Tpd2T4f44U8=;yZ1dFoxZR5lOULt3a9CUwU9SRn5
 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
 xtwDvxwKVXW3UyqJRkjs4lnebrOrE=
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Q09ORklHX0VOVl9XUklURUFCTEVfTElTVCBvbmx5IHJlc3RyaWN0cyBsb2FkaW5nIHN0b3JlZCBl
bnZpcm9ubWVudCwKbm90IHJ1bnRpbWUgbW9kaWZpY2F0aW9uIGUuZy4gdXNpbmcgImVudiBzZXQi
LCB3aGlsZSB0aGUgS2NvbmZpZwpkZXNjcmlwdGlvbiBpbXBsaWVkIG90aGVyd2lzZS4gRGVzY3Jp
YmUgdGhlIGFjdHVhbCBiZWhhdmlvciwgYW5kIGFkZCBhCm5vdGUgaW4gdGhlIGRvY3VtZW50YXRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgotLS0K
IGRvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJzdCB8IDcgKysrKysrKwogZW52L0tjb25maWcgICAg
ICAgICAgICAgICAgIHwgNSArKystLQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJz
dCBiL2RvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJzdAppbmRleCBhN2VkNGFhYjBhNS4uZTdjZjZk
ZTM1ODYgMTAwNjQ0Ci0tLSBhL2RvYy9kZXZlbG9wL2Vudmlyb25tZW50LnJzdAorKysgYi9kb2Mv
ZGV2ZWxvcC9lbnZpcm9ubWVudC5yc3QKQEAgLTg5LDMgKzg5LDEwIEBAIGFuIGFzc29jaWF0aW9u
IGluIHRoZSBzdGF0aWMgbGlzdC4KIElmIENPTkZJR19SRUdFWCBpcyBkZWZpbmVkLCB0aGUgdmFy
aWFibGUgbmFtZSBpcyBldmFsdWF0ZWQgYXMgYSByZWd1bGFyCiBleHByZXNzaW9uLiBUaGlzIGFs
bG93cyBtdWx0aXBsZSB2YXJpYWJsZXMgdG8gZGVmaW5lIHRoZSBzYW1lIGZsYWdzIHdpdGhvdXQK
IGV4cGxpY2l0bHkgbGlzdGluZyB0aGVtIGFsbC4KKworSWYgQ09ORklHX0VOVl9XUklURUFCTEVf
TElTVCBpcyBkZWZpbmVkLCBvbmx5IGVudmlyb25tZW50IHZhcmlhYmxlcword2hpY2ggZXhwbGlj
aXRseSBzZXQgdGhlICd3JyB3cml0ZWFibGUgZmxhZyBjYW4gYmUgd3JpdHRlbiBmcm9tIHN0b3Jl
ZAorZW52aXJvbm1lbnQuIEl0IHJlc3RyaWN0cyBvbmx5IGVudmlyb25tZW50IGxvYWRpbmcsIG5v
dCBydW50aW1lCittb2RpZmljYXRpb24gdXNpbmcgImVudiBzZXQiLCBldGMuIE5vbi13cml0YWJs
ZSB2YXJpYWJsZXMgY2FuIHN0aWxsIGJlCit3cml0dGVuIHRvIHN0b3JlZCBlbnZpcm9ubWVudCBi
eSBleHRlcm5hbCB0b29scyAoZS5nLiBgYGZ3X3NldGVudmBgCitmcm9tIGEgcnVubmluZyBPUyks
IGJ1dCB3aWxsIGJlIGlnbm9yZWQgd2hlbiBsb2FkaW5nIHRoZSBlbnZpcm9ubWVudC4KZGlmZiAt
LWdpdCBhL2Vudi9LY29uZmlnIGIvZW52L0tjb25maWcKaW5kZXggYzZkZjA5YTMzNDkuLjcwZjZj
Y2E3MDFjIDEwMDY0NAotLS0gYS9lbnYvS2NvbmZpZworKysgYi9lbnYvS2NvbmZpZwpAQCAtODk3
LDggKzg5Nyw5IEBAIGNvbmZpZyBFTlZfV1JJVEVBQkxFX0xJU1QKIAlzZWxlY3QgRU5WX0FQUEVO
RAogCWhlbHAKIAkgIElmIGRlZmluZWQsIG9ubHkgZW52aXJvbm1lbnQgdmFyaWFibGVzIHdoaWNo
IGV4cGxpY2l0bHkgc2V0IHRoZSAndycKLQkgIHdyaXRlYWJsZSBmbGFnIGNhbiBiZSB3cml0dGVu
IGFuZCBtb2RpZmllZCBhdCBydW50aW1lLiBObyB2YXJpYWJsZXMKLQkgIGNhbiBiZSBvdGhlcndp
c2UgY3JlYXRlZCwgd3JpdHRlbiBvciBpbXBvcnRlZCBpbnRvIHRoZSBlbnZpcm9ubWVudC4KKwkg
IHdyaXRlYWJsZSBmbGFnIGNhbiBiZSB3cml0dGVuIGZyb20gc3RvcmVkIGVudmlyb25tZW50LiBU
aGlzCisJICByZXN0cmljdHMgb25seSBlbnZpcm9ubWVudCBsb2FkaW5nLCBub3QgcnVudGltZSBt
b2RpZmljYXRpb24gdXNpbmcKKwkgICJlbnYgc2V0IiwgZXRjLgogCiBjb25maWcgRU5WX0FDQ0VT
U19JR05PUkVfRk9SQ0UKIAlib29sICJCbG9jayBmb3JjZWQgZW52aXJvbm1lbnQgb3BlcmF0aW9u
cyIKLS0gCjIuNTUuMAoK
