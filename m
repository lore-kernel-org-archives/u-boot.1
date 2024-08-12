Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C693CC52D7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 00:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE81F880E6;
	Mon, 12 Aug 2024 02:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="kb4pN+kU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470AD884DB; Mon, 12 Aug 2024 02:37:22 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by phobos.denx.de (Postfix) with ESMTP id 03AC787F3B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 02:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=j0TVWkMBuBf1EW+zQYeT5KQaK4tiqTXyAm4OuVmtAww=; b=k
 b4pN+kUvdv2+xB05+Y/TtubwJx80tqYuQhEkardtoIS8HJsw4o2bSfwyn3ARUlko
 BtnQtm/sZBPCS2KQVcT4VXNs3egwY2d0LlTGQda3jl1bGg16jvAqEc+AFiE8pZNv
 ZHD//mMOKeE+f8i5nC2CUEMZogHe8QuRSraixISi9I=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-140 (Coremail) ; Mon, 12 Aug 2024 08:37:05 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Mon, 12 Aug 2024 08:37:05 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
Subject: Re:Re: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
References: <20240811100255.1664095-1-andyshrk@163.com>
 <20240811100255.1664095-2-andyshrk@163.com>
 <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
X-NTES-SC: AL_Qu2ZAfiZvEgp4yKYZOkXn0kXhec2W8Czvvgg34JRP5k0hyXh4w84enhsBWX50cSJNTCNtx+ebhV8+Ol2d45bUpqNC6eHKJp7jfDWcxZf646U
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <30bf7280.59c.19144046836.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3n0kxWblmoS8RAA--.7690W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0g05XmWXzpUwUAACsz
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

CkhlbGxvIERyYWdhbu+8jAoKQXQgMjAyNC0wOC0xMiAwNToyNjozNiwgIkRyYWdhbiBTaW1pYyIg
PGRzaW1pY0BtYW5qYXJvLm9yZz4gd3JvdGU6Cj5IZWxsbyBBbmR5LAo+Cj5QbGVhc2Ugc2VlIGEg
ZmV3IGNvbW1lbnRzIGJlbG93Lgo+Cj5PbiAyMDI0LTA4LTExIDEyOjAyLCBBbmR5IFlhbiB3cm90
ZToKPj4gQWRkIHN1cHBvcnQgZm9yIENvb2wgUGkgR2VuQm9vay4KPj4gCj4+IFNwZWNpZmljYXRp
b246Cj4+IC0gUm9ja2NoaXAgUkszNTg4Cj4+IC0gTFBERFI1WCA4LzMyIEdCCj4+IC0gZU1NQyA2
NCBHQgo+PiAtIEhETUkgVHlwZSBBIG91dCB4IDEKPj4gLSBVU0IgMy4wIEhvc3QgeCAxCj4+IC0g
VVNCLUMgMy4wIHdpdGggRGlzcGxheVBvcnQgQWx0TW9kZQo+PiAtIFBDSUUgTS4yIEUgS2V5IGZv
ciBSVEw4ODUyQkUgV2lyZWxlc3MgY29ubmVjdGlvbgo+PiAtIFBDSUUgTS4yIE0gS2V5IGZvciBO
Vk1FIGNvbm5lY3Rpb24KPj4gLSBlRFAgcGFuZWwgd2l0aCAxOTIweDEwODAKPgo+SXQgc2hvdWxk
IGJlIG1lbnRpb25lZCB0aGF0IGl0IGFjdHVhbGx5IHVzZXMgQ001IFNvTS4KT2thee+8jHdpbGwg
ZG8gaW4gdjIKCj4KPj4gCj4+IFRlc3QgYnkgYSBBcm1iaWFuIGJvb3Qgb24gVVNCIGRpc2suCj4+
IAo+PiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4KPj4gCj4+IC0t
LQo+PiAKPj4gIC4uLi9kdHMvcmszNTg4LWNvb2xwaS1jbTUtZ2VuYm9vay11LWJvb3QuZHRzaSB8
ICA3MCArKysrCj4+ICBhcmNoL2FybS9tYWNoLXJvY2tjaGlwL3JrMzU4OC9LY29uZmlnICAgICAg
ICAgfCAgIDcgKwo+PiAgYm9hcmQvY29vbHBpL2dlbmJvb2svS2NvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgIDEyICsKPj4gIGJvYXJkL2Nvb2xwaS9nZW5ib29rL01BSU5UQUlORVJTICAgICAgICAg
ICAgICB8ICAgNyArCj4+ICBib2FyZC9jb29scGkvZ2VuYm9vay9SRUFETUUgICAgICAgICAgICAg
ICAgICAgfCAgMjMgKysKPj4gIGNvbmZpZ3MvY29vbHBpLWdlbmJvb2stcmszNTg4X2RlZmNvbmZp
ZyAgICAgICB8IDEwNCArKysrKysKPj4gIC4uLi9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1n
ZW5ib29rLmR0cyAgICB8IDM0OSArKysrKysrKysrKysrKysrKysKPj4gIGluY2x1ZGUvY29uZmln
cy9nZW5ib29rLXJrMzU4OC5oICAgICAgICAgICAgICB8ICAyOCArKwo+PiAgOCBmaWxlcyBjaGFu
Z2VkLCA2MDAgaW5zZXJ0aW9ucygrKQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2R0
cy9yazM1ODgtY29vbHBpLWNtNS1nZW5ib29rLXUtYm9vdC5kdHNpCj4+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgYm9hcmQvY29vbHBpL2dlbmJvb2svS2NvbmZpZwo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGJvYXJkL2Nvb2xwaS9nZW5ib29rL01BSU5UQUlORVJTCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
Ym9hcmQvY29vbHBpL2dlbmJvb2svUkVBRE1FCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmln
cy9jb29scGktZ2VuYm9vay1yazM1ODhfZGVmY29uZmlnCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQK
Pj4gZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1nZW5i
b29rLmR0cwo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvY29uZmlncy9nZW5ib29rLXJr
MzU4OC5oCj4+IAo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL3JrMzU4OC1jb29scGktY201
LWdlbmJvb2stdS1ib290LmR0c2kKPj4gYi9hcmNoL2FybS9kdHMvcmszNTg4LWNvb2xwaS1jbTUt
Z2VuYm9vay11LWJvb3QuZHRzaQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+PiBpbmRleCAwMDAw
MDAwMDAwMC4uNTgzNWJkNDM1MmIKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9hcmNoL2FybS9k
dHMvcmszNTg4LWNvb2xwaS1jbTUtZ2VuYm9vay11LWJvb3QuZHRzaQo+PiBAQCAtMCwwICsxLDcw
IEBACj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkKPj4g
Kwo+PiArI2luY2x1ZGUgInJrMzU4OC11LWJvb3QuZHRzaSIKPj4gKwo+PiArJmZzcGltMl9waW5z
IHsKPj4gKwlib290cGgtcHJlLXJhbTsKPj4gKwlib290cGgtc29tZS1yYW07Cj4+ICt9Owo+PiAr
Cj4+ICsmc2RoY2kgewo+PiArCWNhcC1tbWMtaGlnaHNwZWVkOwo+PiArCW1tYy1oczIwMC0xXzh2
Owo+PiArfTsKPj4gKwo+PiArJnNmYyB7Cj4+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsK
Pj4gKwlwaW5jdHJsLTAgPSA8JmZzcGltMl9waW5zPjsKPj4gKwlzdGF0dXMgPSAib2theSI7Cj4+
ICsKPj4gKwlmbGFzaEAwIHsKPj4gKwkJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsKPj4g
KwkJcmVnID0gPDA+Owo+PiArCQlib290cGgtcHJlLXJhbTsKPj4gKwkJYm9vdHBoLXNvbWUtcmFt
Owo+PiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyNDAwMDAwMD47Cj4+ICsJCXNwaS1yeC1idXMt
d2lkdGggPSA8ND47Cj4+ICsJCXNwaS10eC1idXMtd2lkdGggPSA8MT47Cj4+ICsJfTsKPj4gK307
Cj4+ICsKPj4gKyZ1MnBoeTAgewo+PiArCXN0YXR1cyA9ICJva2F5IjsKPj4gK307Cj4+ICsKPj4g
KyZ1MnBoeTBfb3RnIHsKPj4gKwlzdGF0dXMgPSAib2theSI7Cj4+ICt9Owo+PiArCj4+ICsmdXNi
ZHBfcGh5MCB7Cj4+ICsJc3RhdHVzID0gIm9rYXkiOwo+PiArfTsKPj4gKwo+PiArLyogRm9yIEtl
eXBhZCAqLwo+PiArJnVzYl9ob3N0MF9laGNpIHsKPj4gKwlzdGF0dXMgPSAiZGlzYWJsZWQiOwo+
PiArfTsKPj4gKwo+PiArJnVzYl9ob3N0MF9vaGNpIHsKPj4gKwlzdGF0dXMgPSAiZGlzYWJsZWQi
Owo+PiArfTsKPj4gKwo+PiArJnVzYl9ob3N0MF94aGNpIHsKPj4gKwlkcl9tb2RlID0gInBlcmlw
aGVyYWwiOwo+PiArCW1heGltdW0tc3BlZWQgPSAiaGlnaC1zcGVlZCI7Cj4+ICsJc3RhdHVzID0g
Im9rYXkiOwo+PiArfTsKPj4gKwo+PiArLyogY29ubmVjdGVkIHRvIGEgSFVCIGZvciBjYW1lcmEg
YW5kIEJUICovCj4+ICsmdXNiX2hvc3QxX2VoY2kgewo+PiArCXN0YXR1cyA9ICJkaXNhYmxlZCI7
Cj4+ICt9Owo+PiArCj4+ICsmdXNiX2hvc3QxX29oY2kgewo+PiArCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7Cj4+ICt9Owo+PiArCj4+ICsvKiBVU0IgQSBvdXQgKi8KPj4gKyZ1c2JfaG9zdDFfeGhjaSB7
Cj4+ICsJc25wcyxkaXNfdTNfc3VzcGh5X3F1aXJrOwo+PiArfTsKPj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtcm9ja2NoaXAvcmszNTg4L0tjb25maWcKPj4gYi9hcmNoL2FybS9tYWNoLXJv
Y2tjaGlwL3JrMzU4OC9LY29uZmlnCj4+IGluZGV4IGU3NTFkNjRlMWExLi5kYzUzZDU1OWVkOSAx
MDA2NDQKPj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1yb2NrY2hpcC9yazM1ODgvS2NvbmZpZwo+PiAr
KysgYi9hcmNoL2FybS9tYWNoLXJvY2tjaGlwL3JrMzU4OC9LY29uZmlnCj4+IEBAIC02LDYgKzYs
MTIgQEAgY29uZmlnIFRBUkdFVF9FVkJfUkszNTg4Cj4+ICAJaGVscAo+PiAgCSAgUkszNTg4IEVW
QiBpcyBhIGV2YWx1YXRpb24gYm9hcmQgZm9yIFJvY2tjaHAgUkszNTg4Lgo+PiAKPj4gK2NvbmZp
ZyBUQVJHRVRfR0VOQk9PS19SSzM1ODgKPgo+SXQgc2hvdWxkIGJlIGJldHRlciB0byB1c2UgIlRB
UkdFVF9HRU5CT09LX0NNNV9SSzM1ODgiIGluc3RlYWQsCgoKQ29uc2lkZXJpbmcgdGhlIG5hbWUg
b2YgZHRzIGlzIHJrMzU4OC1jb29scGktY201LWdlbmJvb2suZHRzICwgc2hvdWxkIHdlICB1c2Ug
VEFSR0VUX0NNNV9HRU5CT09LX1JLMzU4OCAgaW5zdGVhZCBvZiBUQVJHRVRfR0VOQk9PS19DTTVf
UkszNTg4IGhlcmUgPwoKPnRvIGxlYXZlIHJvb20gZm9yIHN1cHBvcnQgZm9yIGFueSBwb3NzaWJs
ZSBmdXR1cmUgU29NcyB0aGF0IG1pZ2h0Cj5iZSBtYWRlIGF2YWlsYWJsZSBmb3IgdGhlIEdlbkJv
b2sgYXQgc29tZSBwb2ludC4KPgo=
