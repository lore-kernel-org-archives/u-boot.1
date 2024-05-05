Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C9FC4345F
	for <u-boot@archiver.kernel.org>; Sun,  5 May 2024 09:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DC488069;
	Sun,  5 May 2024 11:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yadro.com header.i=@yadro.com header.b="wIZhZCRM";
	dkim=pass (2048-bit key; unprotected) header.d=yadro.com header.i=@yadro.com header.b="PpfJT/av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7075688093; Sun,  5 May 2024 11:40:06 +0200 (CEST)
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE4588013
 for <u-boot@lists.denx.de>; Sun,  5 May 2024 11:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=v.v.mitrofanov@yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A743FC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1714902002; bh=8SmgDuciKR7sE3t0Q4NMTpXlMtqKd395jjHJxkiyUwE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=wIZhZCRMNSFWLsXbj8/3tXxq8X5JxR8nZUcuiHWnQGohPu0PL5Ca7EKoWc4tS9L5T
 VzvAh5QXLZyRFd2pZCwutJiK2HPGFAJ1FzEdYH9pgyPQVRS9veRiFqCOYOwAE4qu9a
 NStCK74jnafd3TnzYrd0DDq1hqzqrdD8r2JCSznExYWyYO2Ss+mPp7rtNHSFFHiZYz
 j9eXhVzZD5liaNZ+nwVLApDSdTYs8m48k+69ST/RANYujdzisOlheIRVzoUr0U53U/
 Ooz3NROQznOXGHToTvBo4qJhkP6owWJUFlGP4HEhMnrXIpNBraUlJINTnTJcjEnZgj
 Prusvm+m0YiVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1714902002; bh=8SmgDuciKR7sE3t0Q4NMTpXlMtqKd395jjHJxkiyUwE=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=PpfJT/avt/ZJIf3Ruu1C+3pcWrOY5BZzTPpyr84yzDV6qkTZZReh08CJDy/JLcF06
 NdibQcagpZfvxAy0XGLDc38nYeLT63tjxTyaX3Hnek4A/kb6i0+6/sKMQDQbDO+EMq
 nby4OYHW+obcVX+42dP1Osx9d4KgH45yRkJjIBbq2J7PVc2eiamKDNexadro2Bol/W
 irrEKSNlt9S+fLRexg9HADA/p1l4IAOftlVTalAbgbJL2ZymtZFb1FoftHoWW1VhtF
 vxZ43vVxoRgkyRaGFtt7jviX1X/7KqHUCQuHCFY1aM+ax7M7mXeoFlVfcKudCLDFbU
 6Gv9w+MbL7d9w==
From: "Vyacheslav V. Mitrofanov" <v.v.mitrofanov@yadro.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "seanedmond@linux.microsoft.com" <seanedmond@linux.microsoft.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "saproj@gmail.com" <saproj@gmail.com>, "seanedmond@microsoft.com"
 <seanedmond@microsoft.com>
Subject: Re: [PATCH] Fix neighbor discovery ethernet address saving
Thread-Topic: [PATCH] Fix neighbor discovery ethernet address saving
Thread-Index: AQHammY8edxoSjJSfEa2TmoN/0kXxLGIOU4A
Date: Sun, 5 May 2024 09:40:01 +0000
Message-ID: <2c8ff0fe4c082799118bbf13de7b2f6558493334.camel@yadro.com>
References: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
In-Reply-To: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
Accept-Language: en-UM, en-150, ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C2EDF0555C514CA50CAE1A97627BEB@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDExOjUxIC0wNzAwLCBzZWFuZWRtb25kQGxpbnV4Lm1pY3Jv
c29mdC5jb20Kd3JvdGU6Cj4gc29jQHlhZHJvLmNvbTxtYWlsdG86c29jQHlhZHJvLmNvbT4KPiAK
PiBGcm9tOiBTZWFuIEVkbW9uZCA8c2VhbmVkbW9uZEBtaWNyb3NvZnQuY29tPgo+IAo+IFdoZW4g
YSBzdWNjZXNzZnVsIG5laWdoYm9yIGFkdmVydGlzZW1lbnQgaXMgcmVjZWl2ZWQsIHRoZSBldGhl
cm5ldAo+IGFkZHJlc3Mgc2hvdWxkIGJlIHNhdmVkIGZvciBsYXRlciB1c2UgdG8gYXZvaWQgaGF2
aW5nIHRvIHJlZG8gdGhlCj4gbmVpZ2hib3IgZGlzY292ZXJ5IHByb2Nlc3MuCj4gCj4gRm9yIGV4
YW1wbGUsIHdpdGggVEZUUCB0aGUgYWRkcmVzcyBzaG91bGQgZ2V0IHNhdmVkIGludG8KPiAibmV0
X3NlcnZlcl9ldGhhZGRyIi7CoCBUaGlzIGlzIGJlaW5nIGRvbmUgY29ycmVjdGx5IHdpdGggQVJQ
IGZvcgo+IElQdjQsCj4gYnV0IG5vdCBmb3IgbmVpZ2hib3IgZGlzY292ZXJ5IHdpdGggSVB2Ni4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEVkbW9uZCA8c2VhbmVkbW9uZEBtaWNyb3NvZnQuY29t
Pgo+IC0tLQo+IMKgbmV0L25kaXNjLmMgfCA0ICsrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC9uZGlzYy5j
IGIvbmV0L25kaXNjLmMKPiBpbmRleCBkMWNlYzA2MDFjOC4uNTA1NTE1ZjJkOTUgMTAwNjQ0Cj4g
LS0tIGEvbmV0L25kaXNjLmMKPiArKysgYi9uZXQvbmRpc2MuYwo+IEBAIC00NjEsOCArNDYxLDgg
QEAgaW50IG5kaXNjX3JlY2VpdmUoc3RydWN0IGV0aGVybmV0X2hkciAqZXQsIHN0cnVjdAo+IGlw
Nl9oZHIgKmlwNiwgaW50IGxlbikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG5kaXNjX2V4dHJhY3RfZW5ldGFkZHIobmRpc2MsCj4gbmVpZ2hfZXRoX2Fk
ZHIpOwo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Lyogc2F2ZSBhZGRyZXNzIGZvciBsYXRlciB1c2UgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFuZXRfbmRfcGFja2V0X21hYykKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5l
dF9uZF9wYWNrZXRfbWFjID0gbmVpZ2hfZXRoX2FkZHI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChuZXRfbmRfcGFja2V0X21hYykKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1l
bWNweShuZXRfbmRfcGFja2V0X21hYywKPiBuZWlnaF9ldGhfYWRkciwgNik7Cj4gCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBtb2RpZnkgaGVhZGVy
LCBhbmQgdHJhbnNtaXQgaXQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG1lbWNweSgoKHN0cnVjdCBldGhlcm5ldF9oZHIKPiAqKW5ldF9uZF90eF9w
YWNrZXQpLT5ldF9kZXN0LAo+IC0tCj4gMi40Mi4wCj4gCkhlbGxvLCBTZWFuLiBUaGFua3MgZm9y
IHlvdXIgbm90aWNlLiBJIHNlZSB0aGF0IG5ldF9uZF9wYWNrZXRfbWFjIGlzCmp1c3QgYSB1Y2hh
ciBwb2ludGVyIHdpdGhvdXQgbWVtb3J5IGFsbG9jYXRpb24uIEl0IGlzIGRhbmdlcm91cyB0byBk
byAKbWVtY3B5IGFuZCBub3QgbmVjZXNzYXJ5LiBBbGwgd29ya3MgYXMgaXQgaGFzIHRvIGJlLgo=
