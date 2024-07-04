Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B04C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 06:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F58F885CE;
	Thu,  4 Jul 2024 08:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CC7zmv8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4306885EC; Thu,  4 Jul 2024 08:40:10 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DF2882DB
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 08:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720075208; x=1722667208;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4sLojKTOZb6HLsfpDxBm0dNWh5RZ4Ke431hPj/IGsoI=;
 b=CC7zmv8Oq/pxC5gQw6wWP/+m2S8q7veMnOZJJZ3F5NtNLVQFIN1HfXBRt39Jy8LH
 y2OSaRKmVU7R4e8Z8M7nq+SEnTpIK08b0WKI3Q4wePFB/n0pzMIEC6d14OCMXrlJ
 KtH5EXnK/TqZD8qgUqez3MlB6ZcVXE3SwTbCU2ffWS0=;
X-AuditID: ac14000a-03251700000021bc-60-668643c8f2ae
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4E.A4.08636.8C346866;
 Thu,  4 Jul 2024 08:40:08 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 4 Jul 2024
 08:40:07 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 4 Jul 2024 08:40:07 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Daniel Schultz <D.Schultz@phytec.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>, "Wadim
 Egorov" <W.Egorov@phytec.de>
CC: "d-gole@ti.com" <d-gole@ti.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Benjamin Hahn
 <B.Hahn@phytec.de>, "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 1/9] include: env: phytec: Create env file for loading and
 applying overlays
Thread-Topic: [PATCH 1/9] include: env: phytec: Create env file for loading
 and applying overlays
Thread-Index: AQHazQvLBlUYarGB4EaHdnzO5rbCS7Hl/mWA
Date: Thu, 4 Jul 2024 06:40:07 +0000
Message-ID: <e06298ee9b229034cf6488d8b0210686003a4e28.camel@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
 <20240703054202.2812540-2-d.schultz@phytec.de>
In-Reply-To: <20240703054202.2812540-2-d.schultz@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DCC733B59C23841B0CF5FC5A5679DCB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWyRpKBV/eEc1uawbLrwhYtaz0sHl71t/i0
 8zGrxYyb09gsXhyby27xbcs2RoupkzazW7zd28lu0f1O3YHT4/2NVnaP2Q0XWTx2zrrL7vHq
 wCp2j7N3djB69He3sHpcP7OdyeP4je1MARxRXDYpqTmZZalF+nYJXBk/zrxiKpikWPFwzUb2
 BsYlCl2MnBwSAiYSB/qes4LYQgJLmCT6u+S7GLmA7HuMEpum/GaDcNYzSjx5tJgdpIpNQEPi
 5YluJpCEiMBeJonbTSsYQRxmgSuMEn+bPjGBVAkLJEl8P7SHGcQWEUiWuDS/D6ibA8g2kvgx
 sQIkzCKgIjFx12cWEJtXwE3i9ez9LBBn5EjsfrYGrJVTwFri34n5YCMZBWQlNmw4DxZnFhCX
 2PTsOyvECwISS/ZAxCUERCVePv4HFZeXOHFrGhPIWmYBTYn1u/QhWi0kGl+vhRqjKDGl+yE7
 xAmCEidnPmGZwCg+C8mGWQjds5B0z0LSPQtJ9wJG1lWMQrmZydmpRZnZegUZlSWpyXopqZsY
 QVEuwsC1g7FvjschRiYOxkOMEhzMSiK8Uu+b04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4I
 ThUSSE8sSc1OTS1ILYLJMnFwSjUwsqje2HlVNC3j8mnTS4vkfl7OOuM5b5bzDPZDsrFKmVHn
 tvkrpvfM+aY+wSQs/DXrymY2/oxJUfEvBGXO3UqLWDt1LmuVb9Qh1p0a6YvM7zWba/YX9rc8
 TrvxxeXp7//Ky4Pds/l/u2RLv5zLEHuKU/5gitb5w3fmn3d8uMZbmO1c8HaniolaSizFGYmG
 WsxFxYkAZ6qeUeACAAA=
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

QW0gRGllbnN0YWcsIGRlbSAwMi4wNy4yMDI0IHVtIDIyOjQxIC0wNzAwIHNjaHJpZWIgRGFuaWVs
IFNjaHVsdHo6Cj4gRnJvbTogQmVuamFtaW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4KPiAKPiBU
aGUgZW52IHNjcmlwdHMgZm9yIGxvYWRpbmcgYW5kIGFwcGx5aW5nIG92ZXJsYXlzIGFyZSBpZGVu
dGljYWwgZm9yCj4gbWFueQo+IFBIWVRFQyBCb2FyZHMuIENyZWF0ZSBhIGNvbW1vbiBlbnYgdGhh
dCBjYW4gYmUgaW5jbHVkZWQuCj4gCj4gVGhlIGVudiB2YXJpYWJsZXMgYm9vdGVudl9hZGRyIGFu
ZCBmZHRvX2FkZHIgYXJlIGJvYXJkIHNwZWNpZmljIGFuZAo+IG5lZWQKPiB0byBiZSBzZXQgaW4g
dGhlIGJvYXJkIHNwZWNpZmljIGZpbGUuIFRoZSBlbnYgdmFyaWFibGUgZ2V0X2NtZCBhbHNvCj4g
bmVlZHMgdG8gYmUgc2V0IGluIGJvYXJkIHNwZWNpZmljIGZpbGVzIGFuZCBjYW4gYmUgc2V0IHRv
IHRmdHAgb3IKPiBkaGNwLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFo
bkBwaHl0ZWMuZGU+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFNjaHVsdHogPGQuc2NodWx0ekBw
aHl0ZWMuZGU+CgpSZXZpZXdlZC1ieTogVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRl
PgoKPiAtLS0KPiDCoGluY2x1ZGUvZW52L3BoeXRlYy9vdmVybGF5cy5lbnYgfCAzNwo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKykKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2Vudi9waHl0ZWMvb3Zlcmxh
eXMuZW52Cj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZW52L3BoeXRlYy9vdmVybGF5cy5lbnYK
PiBiL2luY2x1ZGUvZW52L3BoeXRlYy9vdmVybGF5cy5lbnYKPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NAo+IGluZGV4IDAwMDAwMDAwMDAwLi5mZWJiOTkxZjRmNQo+IC0tLSAvZGV2L251bGwKPiArKysg
Yi9pbmNsdWRlL2Vudi9waHl0ZWMvb3ZlcmxheXMuZW52Cj4gQEAgLTAsMCArMSwzNyBAQAo+ICsv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcsKgICovCj4gKy8qCj4g
KyAqIENvcHlyaWdodCAoQykgMjAyNCBQSFlURUMgTWVzc3RlY2huaWsgR21iSAo+ICsgKiBBdXRo
b3I6IEJlbmphbWluIEhhaG4gPGIuaGFobkBwaHl0ZWMuZGU+Cj4gKyAqLwo+ICsKPiArLyogTG9n
aWMgdG8gbG9hZCBhbmQgYXBwbHkgb3ZlcmxheXMuIExvYWQgb3ZlcmxheXMgZnJvbSBib290ZW52
LnR4dAo+IGludG8KPiArICogZW52aXJvbm1lbnQgYW5kIGFwcGx5IHRob3NlIG92ZXJsYXlzLgo+
ICsgKiBUaGUgdmFyaWFibGVzIGJvb3RlbnZfYWRkciBhbmQgZmR0b19hZGRyIGFyZSBib2FyZCBz
cGVjaWZpYy4gKi8KPiArCj4gK2Jvb3RlbnY9Ym9vdGVudi50eHQKPiArbW1jX2xvYWRfYm9vdGVu
dj1sb2FkIG1tYyAke21tY2Rldn06JHttbWNwYXJ0fSAke2Jvb3RlbnZfYWRkcn0KPiAke2Jvb3Rl
bnZ9Cj4gK21tY19sb2FkX292ZXJsYXk9bG9hZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0gJHtm
ZHRvX2FkZHJ9Cj4gJHtvdmVybGF5fQo+ICttbWNfYXBwbHlfb3ZlcmxheXM9Cj4gK8KgwqDCoMKg
wqDCoMKgZmR0IGFkZHJlc3MgJHtmZHRfYWRkcn07Cj4gK8KgwqDCoMKgwqDCoMKgaWYgdGVzdCAk
e25vX292ZXJsYXlzfSA9IDA7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Zm9yIG92ZXJsYXkgaW4gJHtvdmVybGF5c307Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGRvOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgcnVuIG1tY19sb2FkX292ZXJsYXk7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmZHQgcmVzaXplICR7ZmlsZXNp
emV9Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZkdCBhcHBseSAke2ZkdG9fYWRkcn07Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmaTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZG9uZTsKPiArwqDCoMKgwqDCoMKgwqBmaTsKPiArbmV0X2xvYWRfYm9vdGVudj0k
e2dldF9jbWR9ICR7Ym9vdGVudl9hZGRyfSAke2Jvb3RlbnZ9Cj4gK25ldF9sb2FkX292ZXJsYXk9
JHtnZXRfY21kfSAke2ZkdG9fYWRkcn0gJHtvdmVybGF5fQo+ICtuZXRfYXBwbHlfb3ZlcmxheXM9
Cj4gK8KgwqDCoMKgwqDCoMKgZmR0IGFkZHJlc3MgJHtmZHRfYWRkcn07Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgdGVzdCAke25vX292ZXJsYXlzfSA9IDA7IHRoZW4KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZm9yIG92ZXJsYXkgaW4gJHtvdmVybGF5c307Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRvOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgcnVuIG5ldF9sb2FkX292ZXJsYXk7IHRoZW4KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmZHQgcmVz
aXplICR7ZmlsZXNpemV9Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZkdCBhcHBseSAke2ZkdG9fYWRkcn07Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmaTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZG9uZTsKPiArwqDCoMKgwqDCoMKgwqBmaTsKCi0tIApQSFlU
RUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdl
cm1hbnkKCkdlc2Now6RmdHNmw7xocmVyOiBEaXBsLi1JbmcuIE1pY2hhZWwgTWl0ZXpraSwgRGlw
bC4tSW5nLiBCb2RvIEh1YmVyLApEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRl
bHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8CkZpbmFuemFtdCBNYWlueiB8IFN0Lk5yLiAyNjY1
MDA2MDgsIERFIDE0OTA1OTg1NQo=
