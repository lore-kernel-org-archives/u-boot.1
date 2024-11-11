Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB6DD12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 00:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAD3890F8;
	Mon, 11 Nov 2024 01:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731286152;
	bh=dn2G2tu7dntNCZw0VH81Gk675JDGJpP5I0vtFewGmCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y7NtUHLHW2f2k/t9m2+zXD+9d5eysbW2IvEJWV/RFHp8lmpx1ZQCq/zDTb6hnBSkL
	 bgU9ikcSdQjwjsO4bIy/QW62Rbt1o2KQY26/ydiQ5Agxpf+vRWWl4KPBIhHCqA9SeM
	 zxSmpHHU7wzULbHMe+34K3Yj5+dsJmTPWv9SsFbkAMwZcO1rf3a+USMo4Qp+DZm+db
	 MRACupQqRiMKQqyS7/1hAIwQnXClZ4TPa7ioMz5dbhCvbGl8P2exRUpOzy8PS8CGFG
	 MeK+D+5V1pRurlQY6v7h+fEpMQHRHuZAEWwzpmv/OyxoaLV3k+jbTYx+Kl5mtb1OeA
	 QUVEfz61M6ATg==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 74A3988FBF;
 Mon, 11 Nov 2024 01:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731286151;
 bh=dn2G2tu7dntNCZw0VH81Gk675JDGJpP5I0vtFewGmCo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i9Y+zwQFVxN39idfEO75cXE83B/KF/Vl6H0z0l1nTWMgwrWJwj8ZzYejO6vTfWCzz
 lbq6Uy8rpxJCCpooit8tydcgisEdQOGuKHS426TCq/j1u0/KE3/QEcCVKoUzlSYnf8
 BaQpSzD46ei0KcmOWnbihgfYFaG7VK4skSf0pLy2l/Rp7w2FbyXkhwJ57NJcfCygmd
 ac/04Mg1nDOqRU496xERzVNz5OYoqmHo1WW6XCUWXKxQn72yGQosnHIQ+5MD7OWJjB
 jO5BUtj+aFVKYP5EybQ2/tC9vrcJv8QagASc0XOrjwY1KiLkwM+0mSwcUuhGVvkoV/
 lz5QLn+GxDhHQ==
Content-Type: multipart/mixed; boundary="------------h6ocx0hA0voWf70m0umVXkX0"
Message-ID: <33d0df3d-afff-4cbe-8383-ffb33edb01a6@denx.de>
Date: Mon, 11 Nov 2024 01:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, lukma@denx.de,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
 <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
 <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
 <CAHCN7xL1Cp0kkmo3bTPRsKPaqbQFqTXu7spgY2LjOYU0FS3heg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xL1Cp0kkmo3bTPRsKPaqbQFqTXu7spgY2LjOYU0FS3heg@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------h6ocx0hA0voWf70m0umVXkX0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/24 6:21 PM, Adam Ford wrote:
> On Sun, Nov 10, 2024 at 10:42 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 11/10/24 2:15 PM, Adam Ford wrote:
>>> On Sat, Nov 9, 2024 at 7:34 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 11/9/24 9:06 PM, Adam Ford wrote:
>>>>> When FSPI_CONF_HEADER is set, the binary needs to be built such
>>>>> that there is a configuration file located at 0x400 and the start
>>>>> of the file that would normally be flash.bin starts at 0x1000.
>>>>> This used to be done properly until the device tree was converted to
>>>>> nxp_imx8mimage.
>>>>>
>>>>> Building these with the offsets built into the binman device tree
>>>>> changes impacts how the actual image is built and the locations
>>>>> of the various blobs aren't fetched properly and booting fails.
>>>>>
>>>>> Fix this by building a standard image as if it were to boot from
>>>>> eMMC or SD, then use that image as the input for a second image
>>>>
>>>> This seems like a workaround for some broken offset calculation in binman ?
>>>
>>> This used to work until it was migrated to nxp_imx8mimage.
>>> The blobs appear to be at the proper offsets, but the contents of
>>> what's stored at those offsets are not the same.
>>
>> I know, this is what Lukasz reported too.
>>
>>> If you're going to claim there is a bug somewhere, I would argue that
>>> it's somewhere i nxp_imx8mimage
>>
>> I agree with that claim. Well, by extension, the problem might also be
>> in binman itself.
>>
>>> .  However, if you look at this series,
>>> the added benefit is the ability for Nano to be able to build both a
>>> SD/eMMC image and FSPI images with one config which allows for the
>>> elimination of extra defconfig files.  I am guessing Plus would have a
>>> similar benefit since they have similar bootloaders.
>> This I do not agree with. If the intent is to generate two images, then
>> there should be two full binman descriptors, one for each image (one for
>> flash-plain.bin and one for flash-fspi.bin or some such naming).
>>
>> Can you try and fix the FSPI generation first, so an FSPI compatible
> 
> I am not a python programmer, and I couldn't determine what was going on.
I am hoping Simon could offer some input here ...

Can you try the attached diff on MX8MM (use "git show -w" to view the 
diff better) ? It will generate two files, flash.bin and flash-fspi.bin 
, the later should have the fspi header and maybe even correct offsets?

Applies on top of 56accc56b9aa ("bios_emulator: fix first argument of 
pci_{read,write}_config_* function calls") .

I noticed that there is some dependency issue where fspi_header.bin may 
not be generated yet when binman is triggered -- that needs to be fixed. 
You can detect the failure by running 'hexdump -C flash-fspi.bin | head' 
, if there is no FCFB header then this failure occurred. The easiest way 
to work around this is to run 'rm flash.bin ; make flash.bin'. The real 
fix is likely a matter of some Makefile tweak.
--------------h6ocx0hA0voWf70m0umVXkX0
Content-Type: text/x-patch; charset=UTF-8; name="fspi.diff"
Content-Disposition: attachment; filename="fspi.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2kgYi9hcmNoL2Fy
bS9kdHMvaW14OG1tLXUtYm9vdC5kdHNpCmluZGV4IGQzMWJjODIyNTMyLi43NGVhYzM0Yjg2
MyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vZHRzL2lteDhtbS11LWJvb3QuZHRzaQorKysgYi9h
cmNoL2FybS9kdHMvaW14OG1tLXUtYm9vdC5kdHNpCkBAIC00MiwxNjUgKzQyLDE2NSBAQAog
fTsKIAogJmJpbm1hbiB7Ci0JZmlsZW5hbWUgPSAiZmxhc2guYmluIjsKLQlzZWN0aW9uIHsK
LQkJcGFkLWJ5dGUgPSA8MHgwMD47Ci0KICNpZmRlZiBDT05GSUdfRlNQSV9DT05GX0hFQURF
UgorCWZpbGVuYW1lID0gImZsYXNoLWZzcGkuYmluIjsKKwlzZWN0aW9uIHsKIAkJZnNwaV9j
b25mX2Jsb2NrIHsKIAkJCWZpbGVuYW1lID0gQ09ORklHX0ZTUElfQ09ORl9GSUxFOwogCQkJ
dHlwZSA9ICJibG9iLWV4dCI7CiAJCQlzaXplID0gPDB4MTAwMD47CiAJCX07Ci0jZW5kaWYK
IAotI2lmZGVmIENPTkZJR19JTVhfSEFCCi0JCW54cC1pbXg4bWNzdEAwIHsKLQkJCWZpbGVu
YW1lID0gInUtYm9vdC1zcGwtbWtpbWFnZS5zaWduZWQuYmluIjsKLQkJCW54cCxsb2FkZXIt
YWRkcmVzcyA9IDxDT05GSUdfU1BMX1RFWFRfQkFTRT47Ci0JCQlueHAsdW5sb2NrOwotCQkJ
YXJnczsJLyogTmVlZGVkIGJ5IG1raW1hZ2UgZXR5cGUgc3VwZXJjbGFzcyAqLworCQlzZWN0
aW9uIHsKICNlbmRpZgorCQkJZmlsZW5hbWUgPSAiZmxhc2guYmluIjsKIAotCQkJYmlubWFu
X2lteF9zcGw6IG54cC1pbXg4bWltYWdlIHsKLQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3Qtc3Bs
LW1raW1hZ2UuYmluIjsKLQkJCQlueHAsYm9vdC1mcm9tID0gInNkIjsKLQkJCQlueHAscm9t
LXZlcnNpb24gPSA8MT47Ci0JCQkJbnhwLGxvYWRlci1hZGRyZXNzID0gPENPTkZJR19TUExf
VEVYVF9CQVNFPjsKLQkJCQlhcmdzOwkvKiBOZWVkZWQgYnkgbWtpbWFnZSBldHlwZSBzdXBl
cmNsYXNzICovCi0KLQkJCQlzZWN0aW9uIHsKLQkJCQkJYWxpZ24gPSA8ND47Ci0JCQkJCWFs
aWduLXNpemUgPSA8ND47Ci0JCQkJCWZpbGVuYW1lID0gInUtYm9vdC1zcGwtZGRyLmJpbiI7
Ci0JCQkJCXBhZC1ieXRlID0gPDB4ZmY+OwotCi0JCQkJCXUtYm9vdC1zcGwgewotCQkJCQkJ
YWxpZ24tZW5kID0gPDQ+OwotCQkJCQkJZmlsZW5hbWUgPSAidS1ib290LXNwbC5iaW4iOwot
CQkJCQl9OwotCi0JCQkJCWRkci0xZC1pbWVtLWZ3IHsKLQkJCQkJCWZpbGVuYW1lID0gImxw
ZGRyNF9wbXVfdHJhaW5fMWRfaW1lbS5iaW4iOwotCQkJCQkJYWxpZ24tZW5kID0gPDQ+Owot
CQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7Ci0JCQkJCX07Ci0KLQkJCQkJZGRyLTFkLWRtZW0t
ZncgewotCQkJCQkJZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFpbl8xZF9kbWVtLmJpbiI7
Ci0JCQkJCQlhbGlnbi1lbmQgPSA8ND47Ci0JCQkJCQl0eXBlID0gImJsb2ItZXh0IjsKLQkJ
CQkJfTsKKwkJCXNlY3Rpb24geworCQkJCXBhZC1ieXRlID0gPDB4MDA+OwogCi0JCQkJCWRk
ci0yZC1pbWVtLWZ3IHsKLQkJCQkJCWZpbGVuYW1lID0gImxwZGRyNF9wbXVfdHJhaW5fMmRf
aW1lbS5iaW4iOwotCQkJCQkJYWxpZ24tZW5kID0gPDQ+OwotCQkJCQkJdHlwZSA9ICJibG9i
LWV4dCI7Ci0JCQkJCX07CisjaWZkZWYgQ09ORklHX0lNWF9IQUIKKwkJCQlueHAtaW14OG1j
c3RAMCB7CisJCQkJCWZpbGVuYW1lID0gInUtYm9vdC1zcGwtbWtpbWFnZS5zaWduZWQuYmlu
IjsKKwkJCQkJbnhwLGxvYWRlci1hZGRyZXNzID0gPENPTkZJR19TUExfVEVYVF9CQVNFPjsK
KwkJCQkJbnhwLHVubG9jazsKKwkJCQkJYXJnczsJLyogTmVlZGVkIGJ5IG1raW1hZ2UgZXR5
cGUgc3VwZXJjbGFzcyAqLworI2VuZGlmCiAKLQkJCQkJZGRyLTJkLWRtZW0tZncgewotCQkJ
CQkJZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFpbl8yZF9kbWVtLmJpbiI7Ci0JCQkJCQlh
bGlnbi1lbmQgPSA8ND47Ci0JCQkJCQl0eXBlID0gImJsb2ItZXh0IjsKKwkJCQkJYmlubWFu
X2lteF9zcGw6IG54cC1pbXg4bWltYWdlIHsKKwkJCQkJCWZpbGVuYW1lID0gInUtYm9vdC1z
cGwtbWtpbWFnZS5iaW4iOworCQkJCQkJbnhwLGJvb3QtZnJvbSA9ICJzZCI7CisJCQkJCQlu
eHAscm9tLXZlcnNpb24gPSA8MT47CisJCQkJCQlueHAsbG9hZGVyLWFkZHJlc3MgPSA8Q09O
RklHX1NQTF9URVhUX0JBU0U+OworCQkJCQkJYXJnczsJLyogTmVlZGVkIGJ5IG1raW1hZ2Ug
ZXR5cGUgc3VwZXJjbGFzcyAqLworCisJCQkJCQlzZWN0aW9uIHsKKwkJCQkJCQlhbGlnbiA9
IDw0PjsKKwkJCQkJCQlhbGlnbi1zaXplID0gPDQ+OworCQkJCQkJCWZpbGVuYW1lID0gInUt
Ym9vdC1zcGwtZGRyLmJpbiI7CisJCQkJCQkJcGFkLWJ5dGUgPSA8MHhmZj47CisKKwkJCQkJ
CQl1LWJvb3Qtc3BsIHsKKwkJCQkJCQkJYWxpZ24tZW5kID0gPDQ+OworCQkJCQkJCQlmaWxl
bmFtZSA9ICJ1LWJvb3Qtc3BsLmJpbiI7CisJCQkJCQkJfTsKKworCQkJCQkJCWRkci0xZC1p
bWVtLWZ3IHsKKwkJCQkJCQkJZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFpbl8xZF9pbWVt
LmJpbiI7CisJCQkJCQkJCWFsaWduLWVuZCA9IDw0PjsKKwkJCQkJCQkJdHlwZSA9ICJibG9i
LWV4dCI7CisJCQkJCQkJfTsKKworCQkJCQkJCWRkci0xZC1kbWVtLWZ3IHsKKwkJCQkJCQkJ
ZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFpbl8xZF9kbWVtLmJpbiI7CisJCQkJCQkJCWFs
aWduLWVuZCA9IDw0PjsKKwkJCQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7CisJCQkJCQkJfTsK
KworCQkJCQkJCWRkci0yZC1pbWVtLWZ3IHsKKwkJCQkJCQkJZmlsZW5hbWUgPSAibHBkZHI0
X3BtdV90cmFpbl8yZF9pbWVtLmJpbiI7CisJCQkJCQkJCWFsaWduLWVuZCA9IDw0PjsKKwkJ
CQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7CisJCQkJCQkJfTsKKworCQkJCQkJCWRkci0yZC1k
bWVtLWZ3IHsKKwkJCQkJCQkJZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFpbl8yZF9kbWVt
LmJpbiI7CisJCQkJCQkJCWFsaWduLWVuZCA9IDw0PjsKKwkJCQkJCQkJdHlwZSA9ICJibG9i
LWV4dCI7CisJCQkJCQkJfTsKKwkJCQkJCX07CiAJCQkJCX07Ci0JCQkJfTsKLQkJCX07CiAj
aWZkZWYgQ09ORklHX0lNWF9IQUIKLQkJfTsKKwkJCQl9OwogCi0JCW54cC1pbXg4bWNzdEAx
IHsKLQkJCWZpbGVuYW1lID0gInUtYm9vdC1maXQuc2lnbmVkLmJpbiI7Ci0JCQlueHAsbG9h
ZGVyLWFkZHJlc3MgPSA8Q09ORklHX1NQTF9MT0FEX0ZJVF9BRERSRVNTPjsKLSNpZmRlZiBD
T05GSUdfRlNQSV9DT05GX0hFQURFUgotCQkJb2Zmc2V0ID0gPDB4NThDMDA+OwotI2Vsc2UK
LQkJCW9mZnNldCA9IDwweDU3YzAwPjsKLSNlbmRpZgorCQkJCW54cC1pbXg4bWNzdEAxIHsK
KwkJCQkJZmlsZW5hbWUgPSAidS1ib290LWZpdC5zaWduZWQuYmluIjsKKwkJCQkJbnhwLGxv
YWRlci1hZGRyZXNzID0gPENPTkZJR19TUExfTE9BRF9GSVRfQUREUkVTUz47CisJCQkJCW9m
ZnNldCA9IDwweDU3YzAwPjsKIAotCQkJYXJnczsJLyogTmVlZGVkIGJ5IG1raW1hZ2UgZXR5
cGUgc3VwZXJjbGFzcyAqLworCQkJCQlhcmdzOwkvKiBOZWVkZWQgYnkgbWtpbWFnZSBldHlw
ZSBzdXBlcmNsYXNzICovCiAjZW5kaWYKIAotCQkJYmlubWFuX2lteF9maXQ6IGZpdCB7Ci0J
CQkJZGVzY3JpcHRpb24gPSAiQ29uZmlndXJhdGlvbiB0byBsb2FkIEFURiBiZWZvcmUgVS1C
b290IjsKLQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3QuaXRiIjsKKwkJCQkJYmlubWFuX2lteF9m
aXQ6IGZpdCB7CisJCQkJCQlkZXNjcmlwdGlvbiA9ICJDb25maWd1cmF0aW9uIHRvIGxvYWQg
QVRGIGJlZm9yZSBVLUJvb3QiOworCQkJCQkJZmlsZW5hbWUgPSAidS1ib290Lml0YiI7CiAj
aWZuZGVmIENPTkZJR19JTVhfSEFCCi0JCQkJZml0LGV4dGVybmFsLW9mZnNldCA9IDxDT05G
SUdfRklUX0VYVEVSTkFMX09GRlNFVD47CisJCQkJCQlmaXQsZXh0ZXJuYWwtb2Zmc2V0ID0g
PENPTkZJR19GSVRfRVhURVJOQUxfT0ZGU0VUPjsKICNlbmRpZgotCQkJCWZpdCxmZHQtbGlz
dCA9ICJvZi1saXN0IjsKLQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLSNpZmRlZiBDT05G
SUdfRlNQSV9DT05GX0hFQURFUgotCQkJCW9mZnNldCA9IDwweDU4QzAwPjsKLSNlbHNlCi0J
CQkJb2Zmc2V0ID0gPDB4NTdjMDA+OwotI2VuZGlmCi0KLQkJCQlpbWFnZXMgewotCQkJCQl1
Ym9vdCB7Ci0JCQkJCQlhcmNoID0gImFybTY0IjsKLQkJCQkJCWNvbXByZXNzaW9uID0gIm5v
bmUiOwotCQkJCQkJZGVzY3JpcHRpb24gPSAiVS1Cb290ICg2NC1iaXQpIjsKLQkJCQkJCWxv
YWQgPSA8Q09ORklHX1RFWFRfQkFTRT47Ci0JCQkJCQl0eXBlID0gInN0YW5kYWxvbmUiOwot
Ci0JCQkJCQl1Ym9vdC1ibG9iIHsKLQkJCQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3Qtbm9kdGIu
YmluIjsKLQkJCQkJCQl0eXBlID0gImJsb2ItZXh0IjsKLQkJCQkJCX07Ci0JCQkJCX07CisJ
CQkJCQlmaXQsZmR0LWxpc3QgPSAib2YtbGlzdCI7CisJCQkJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsKKwkJCQkJCW9mZnNldCA9IDwweDU3YzAwPjsKKworCQkJCQkJaW1hZ2VzIHsKKwkJ
CQkJCQl1Ym9vdCB7CisJCQkJCQkJCWFyY2ggPSAiYXJtNjQiOworCQkJCQkJCQljb21wcmVz
c2lvbiA9ICJub25lIjsKKwkJCQkJCQkJZGVzY3JpcHRpb24gPSAiVS1Cb290ICg2NC1iaXQp
IjsKKwkJCQkJCQkJbG9hZCA9IDxDT05GSUdfVEVYVF9CQVNFPjsKKwkJCQkJCQkJdHlwZSA9
ICJzdGFuZGFsb25lIjsKKworCQkJCQkJCQl1Ym9vdC1ibG9iIHsKKwkJCQkJCQkJCWZpbGVu
YW1lID0gInUtYm9vdC1ub2R0Yi5iaW4iOworCQkJCQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7
CisJCQkJCQkJCX07CisJCQkJCQkJfTsKIAogI2lmbmRlZiBDT05GSUdfQVJNVjhfUFNDSQot
CQkJCQlhdGYgewotCQkJCQkJYXJjaCA9ICJhcm02NCI7Ci0JCQkJCQljb21wcmVzc2lvbiA9
ICJub25lIjsKLQkJCQkJCWRlc2NyaXB0aW9uID0gIkFSTSBUcnVzdGVkIEZpcm13YXJlIjsK
LQkJCQkJCWVudHJ5ID0gPDB4OTIwMDAwPjsKLQkJCQkJCWxvYWQgPSA8MHg5MjAwMDA+Owot
CQkJCQkJdHlwZSA9ICJmaXJtd2FyZSI7Ci0KLQkJCQkJCWF0Zi1ibG9iIHsKLQkJCQkJCQlm
aWxlbmFtZSA9ICJibDMxLmJpbiI7Ci0JCQkJCQkJdHlwZSA9ICJhdGYtYmwzMSI7Ci0JCQkJ
CQl9OwotCQkJCQl9OworCQkJCQkJCWF0ZiB7CisJCQkJCQkJCWFyY2ggPSAiYXJtNjQiOwor
CQkJCQkJCQljb21wcmVzc2lvbiA9ICJub25lIjsKKwkJCQkJCQkJZGVzY3JpcHRpb24gPSAi
QVJNIFRydXN0ZWQgRmlybXdhcmUiOworCQkJCQkJCQllbnRyeSA9IDwweDkyMDAwMD47CisJ
CQkJCQkJCWxvYWQgPSA8MHg5MjAwMDA+OworCQkJCQkJCQl0eXBlID0gImZpcm13YXJlIjsK
KworCQkJCQkJCQlhdGYtYmxvYiB7CisJCQkJCQkJCQlmaWxlbmFtZSA9ICJibDMxLmJpbiI7
CisJCQkJCQkJCQl0eXBlID0gImF0Zi1ibDMxIjsKKwkJCQkJCQkJfTsKKwkJCQkJCQl9Owog
I2VuZGlmCiAKLQkJCQkJYmlubWFuX2ZpcDogZmlwIHsKLQkJCQkJCWFyY2ggPSAiYXJtNjQi
OwotCQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7Ci0JCQkJCQlkZXNjcmlwdGlvbiA9ICJU
cnVzdGVkIEZpcm13YXJlIEZJUCI7Ci0JCQkJCQlsb2FkID0gPDB4NDAzMTAwMDA+OwotCQkJ
CQkJdHlwZSA9ICJmaXJtd2FyZSI7Ci0JCQkJCX07Ci0KLQkJCQkJQGZkdC1TRVEgewotCQkJ
CQkJY29tcHJlc3Npb24gPSAibm9uZSI7Ci0JCQkJCQlkZXNjcmlwdGlvbiA9ICJOQU1FIjsK
LQkJCQkJCXR5cGUgPSAiZmxhdF9kdCI7Ci0KLQkJCQkJCXVib290LWZkdC1ibG9iIHsKLQkJ
CQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3QuZHRiIjsKLQkJCQkJCQl0eXBlID0gImJsb2ItZXh0
IjsKKwkJCQkJCQliaW5tYW5fZmlwOiBmaXAgeworCQkJCQkJCQlhcmNoID0gImFybTY0IjsK
KwkJCQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7CisJCQkJCQkJCWRlc2NyaXB0aW9uID0g
IlRydXN0ZWQgRmlybXdhcmUgRklQIjsKKwkJCQkJCQkJbG9hZCA9IDwweDQwMzEwMDAwPjsK
KwkJCQkJCQkJdHlwZSA9ICJmaXJtd2FyZSI7CisJCQkJCQkJfTsKKworCQkJCQkJCUBmZHQt
U0VRIHsKKwkJCQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7CisJCQkJCQkJCWRlc2NyaXB0
aW9uID0gIk5BTUUiOworCQkJCQkJCQl0eXBlID0gImZsYXRfZHQiOworCisJCQkJCQkJCXVi
b290LWZkdC1ibG9iIHsKKwkJCQkJCQkJCWZpbGVuYW1lID0gInUtYm9vdC5kdGIiOworCQkJ
CQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7CisJCQkJCQkJCX07CisJCQkJCQkJfTsKIAkJCQkJ
CX07Ci0JCQkJCX07Ci0JCQkJfTsKIAotCQkJCWNvbmZpZ3VyYXRpb25zIHsKLQkJCQkJZGVm
YXVsdCA9ICJAY29uZmlnLURFRkFVTFQtU0VRIjsKKwkJCQkJCWNvbmZpZ3VyYXRpb25zIHsK
KwkJCQkJCQlkZWZhdWx0ID0gIkBjb25maWctREVGQVVMVC1TRVEiOwogCi0JCQkJCUBjb25m
aWctU0VRIHsKLQkJCQkJCWRlc2NyaXB0aW9uID0gIk5BTUUiOwotCQkJCQkJZmR0ID0gImZk
dC1TRVEiOwotCQkJCQkJZmlybXdhcmUgPSAidWJvb3QiOworCQkJCQkJCUBjb25maWctU0VR
IHsKKwkJCQkJCQkJZGVzY3JpcHRpb24gPSAiTkFNRSI7CisJCQkJCQkJCWZkdCA9ICJmZHQt
U0VRIjsKKwkJCQkJCQkJZmlybXdhcmUgPSAidWJvb3QiOwogI2lmbmRlZiBDT05GSUdfQVJN
VjhfUFNDSQotCQkJCQkJbG9hZGFibGVzID0gImF0ZiI7CisJCQkJCQkJCWxvYWRhYmxlcyA9
ICJhdGYiOwogI2VuZGlmCisJCQkJCQkJfTsKKwkJCQkJCX07CiAJCQkJCX07CisjaWZkZWYg
Q09ORklHX0lNWF9IQUIKIAkJCQl9OworI2VuZGlmCiAJCQl9OwotI2lmZGVmIENPTkZJR19J
TVhfSEFCCisjaWZkZWYgQ09ORklHX0ZTUElfQ09ORl9IRUFERVIKIAkJfTsKLSNlbmRpZgog
CX07CisjZW5kaWYKIH07CiAKICZjbGsgewpkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFuL2V0
eXBlL254cF9pbXg4bWltYWdlLnB5IGIvdG9vbHMvYmlubWFuL2V0eXBlL254cF9pbXg4bWlt
YWdlLnB5CmluZGV4IDhhZDE3N2IzYjY1Li5lNTdkYTY4MDc5ZiAxMDA2NDQKLS0tIGEvdG9v
bHMvYmlubWFuL2V0eXBlL254cF9pbXg4bWltYWdlLnB5CisrKyBiL3Rvb2xzL2Jpbm1hbi9l
dHlwZS9ueHBfaW14OG1pbWFnZS5weQpAQCAtNzIsNCArNzIsNiBAQCBjbGFzcyBFbnRyeV9u
eHBfaW14OG1pbWFnZShFbnRyeV9ta2ltYWdlKToKICAgICAgICAgICAgICAgICByZXR1cm4K
ICAgICAgICAgICAgIHVwdG8gKz0gZW50cnkuc2l6ZQogCisgICAgICAgICMgRklYTUU6IE1h
eWJlID8KKyAgICAgICAgaW1hZ2VfcG9zID0gMAogICAgICAgICBFbnRyeV9zZWN0aW9uLlNl
dEltYWdlUG9zKHNlbGYsIGltYWdlX3BvcykK

--------------h6ocx0hA0voWf70m0umVXkX0--
