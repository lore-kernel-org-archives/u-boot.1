Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D630C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 10:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF138861A;
	Mon, 12 Aug 2024 12:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="jMZPRzmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB321886A7; Mon, 12 Aug 2024 12:01:10 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by phobos.denx.de (Postfix) with ESMTP id 06D35884C3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=x4pGUbL5hVSMcfqqDGkoZxSr2jzzdF2gyXbDCpb7OwU=; b=j
 MZPRzmAaznE1wFlKoWb8Mkf4xvmCqgvPJGY1Ejsof8KQLdJCjqrxCCy37CJr/LJl
 RFHePg3WNWWqgOz07V/703X+KPc47HI5QBegQJ6MRGGYwKie8Sn2uR7v8TUVnUF4
 lb0KXdE2wLbmnLf/TtuDw/uLinpTZgPTIJV5VVPpgE=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Mon, 12 Aug 2024 18:00:55 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Mon, 12 Aug 2024 18:00:55 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>
Cc: "Dragan Simic" <dsimic@manjaro.org>, kever.yang@rock-chips.com, 
 jonas@kwiboo.se, u-boot@lists.denx.de
Subject: Re:Re: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <6d73380c-d554-4c33-841d-1f6c0c025b7e@cherry.de>
References: <20240811100255.1664095-1-andyshrk@163.com>
 <20240811100255.1664095-2-andyshrk@163.com>
 <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
 <6d73380c-d554-4c33-841d-1f6c0c025b7e@cherry.de>
X-NTES-SC: AL_Qu2ZAfieuUAu4yafY+kXn0kXhec2W8Czvvgg34JRP5k0hyXh4w84enhsBWX50cSJNTCNtx+ebhV8+Ol2d45bUprIsdIVwJ2M1f/kGgbOKzLY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <20861389.8bc6.19146089e81.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3_+NX3blm_YsZAA--.32784W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0h85XmWXzqMCpAACsR
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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

CgpIaSBRdWV0aW7vvIwK5ZyoIDIwMjQtMDgtMTIgMTY6MjM6MDbvvIwiUXVlbnRpbiBTY2h1bHoi
IDxxdWVudGluLnNjaHVsekBjaGVycnkuZGU+IOWGmemBk++8mgo+SGkgQW5keSwKPgo+Pj4gQEAg
LTMyMyw1ICszMjksNiBAQCBzb3VyY2UgImJvYXJkL3JvY2tjaGlwL2V2Yl9yazM1ODgvS2NvbmZp
ZyIKPj4+IMKgc291cmNlICJib2FyZC9yb2NrY2hpcC90b3licmlja19yazM1ODgvS2NvbmZpZyIK
Pj4+IMKgc291cmNlICJib2FyZC90aGVvYnJvbWEtc3lzdGVtcy9qYWd1YXJfcmszNTg4L0tjb25m
aWciCj4+PiDCoHNvdXJjZSAiYm9hcmQvdGhlb2Jyb21hLXN5c3RlbXMvdGlnZXJfcmszNTg4L0tj
b25maWciCj4+PiArc291cmNlICJib2FyZC9jb29scGkvZ2VuYm9vay9LY29uZmlnIgo+PiAKPgo+
T3JkZXIgYWxwaGFiZXRpY2FsbHkgaGVyZS4KPgo+Pj4gZGlmZiAtLWdpdCBhL2JvYXJkL2Nvb2xw
aS9nZW5ib29rL1JFQURNRSBiL2JvYXJkL2Nvb2xwaS9nZW5ib29rL1JFQURNRQo+Pj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPj4+IGluZGV4IDAwMDAwMDAwMDAwLi5iYTE2NTk1MzE1NAo+Pj4gLS0t
IC9kZXYvbnVsbAo+Pj4gKysrIGIvYm9hcmQvY29vbHBpL2dlbmJvb2svUkVBRE1FCj4+IAo+Cj5X
ZSd2ZSBtb3ZlZCB0aGUgUkVBRE1FcyB0byBkb2MvYm9hcmQvIHNvIHBsZWFzZSBkbyB0aGlzIGFz
IHdlbGwuCj4KPllvdSBtYXkgb25seSB3YW50IHRvIGFkZCB5b3VyIGJvYXJkIHRvIGRvYy9ib2Fy
ZC9yb2NrY2hpcC9yb2NrY2hpcC5yc3QgCj5pZiB0aGUgaW5zdHJ1Y3Rpb25zIGluIHRoYXQgZmls
ZSBhcmUgZ29vZCBlbm91Z2ggZm9yIHlvdS4gQ29uc2lkZXIgCj5leHRlbmRpbmcgdGhlIGNvbnRl
bnQgaWYgaXQgZG9lc24ndCwgYW5kIGlmIGl0J3MgdG9vIG11Y2ggd29yaywgdGhlbiAKPmNyZWF0
aW5nIHlvdXIgb3duIHJlYWRtZSBpbiBkb2MvYm9hcmQvIHNpbWlsYXIgdG8gaG93IFRoZW9icm9t
YSBTeXN0ZW1zIAo+Ym9hcmRzIGFyZSBkb2N1bWVudGVkIHdvdWxkIGRvIGp1c3QgZmluZS4KPgo+
Tm90ZSB0aGF0IHRob3NlIGFyZSBpbiByZVN0cnVjdHVyZWRUZXh0IGZvcm1hdCAoclNUL1NwaGlu
eCkuCj4KPj4+IGRpZmYgLS1naXQKPj4+IGEvZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9yb2NrY2hp
cC9yazM1ODgtY29vbHBpLWNtNS1nZW5ib29rLmR0cwo+Pj4gYi9kdHMvdXBzdHJlYW0vc3JjL2Fy
bTY0L3JvY2tjaGlwL3JrMzU4OC1jb29scGktY201LWdlbmJvb2suZHRzCj4+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+Pj4gaW5kZXggMDAwMDAwMDAwMDAuLjY0MTgyODZlZmU0Cj4+PiAtLS0gL2Rl
di9udWxsCj4+PiArKysgYi9kdHMvdXBzdHJlYW0vc3JjL2FybTY0L3JvY2tjaGlwL3JrMzU4OC1j
b29scGktY201LWdlbmJvb2suZHRzCj4+IAo+PiBJIGJlbGlldmUgdGhpcyBzaG91bGQgYmUgdHVy
bmVkIGludG8gYSBzZXBhcmF0ZSBjb21taXQsIGFzIGEgY2hlcnJ5LXBpY2sKPj4gb2YgYW4gdXBz
dHJlYW0gRFQgY29tbWl0Lgo+PiAKPgo+WWVzLCBhcyBhIGhpbnQsIHlvdSBzaG91bGQgYmUgdXNp
bmcgdG9vbHMvdXBkYXRlLXN1YnRyZWUuc2ggcGljayBkdHMgCj48Y29tbWl0PiBhcyBkb2N1bWVu
dGVkIGhlcmU6IAo+aHR0cHM6Ly9kb2NzLnUtYm9vdC5vcmcvZW4vbGF0ZXN0L2RldmVsb3AvZGV2
aWNldHJlZS9jb250cm9sLmh0bWwjcmVzeW5jaW5nLXdpdGgtZGV2aWNldHJlZS1yZWJhc2luZwo+
Cj5Zb3UgbWF5IG5lZWQgdG8gcGljayBtb3JlIHRoYW4gb25lIGNvbW1pdCwgdGhhdCBpcyBmaW5l
Lgo+Cj5UaGUgY29tbWl0IGlkIGNvbWVzIGZyb20gCj5odHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9kZXZpY2V0cmVlL2RldmljZXRyZWUtcmViYXNpbmcuZ2l0
Ly4KClRoZSBkdHMganVzdCBsYW5kaW5nIGxpbnV4LXJvY2tjaGlwIGEgZmV3IGRheXMgYWdhb++8
jHNvIGl0J3Mgbm90IGluIHRoZSBkZXZpY2V0cmVlLXJlYmFzaW5nIHJlcG/vvIwKRG9lcyB0aGF0
IG1lYW4gIEkgc2hvdWxkIHdhaXQgYmVmb3JlIGl0IGxhbmRpbmcgZGV2aWNldHJlZS1yZWJhc2lu
ZyByZXBvIO+8nwoKPgo+Cj5DaGVlcnMsCj5RdWVudGluCg==
