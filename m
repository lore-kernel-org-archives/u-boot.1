Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D519CD12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 01:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00738914F;
	Mon, 11 Nov 2024 02:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkaUlFuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A172F88915; Mon, 11 Nov 2024 02:47:06 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B852789232
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 02:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2b9480617so3257850a91.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 17:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731289622; x=1731894422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u6e2ZuWktxkauZewcIGAGIDiQqo/F+K3nvxgsbi9LrA=;
 b=SkaUlFuUVoTb7V+cZKl7GU0JasrVdjRSKiTf5jywuGJ/CirtGzPQQ1hw9L1OCuT4dO
 hVdpehpxqLbQhEfQ/y0DARgn1ySZixI0jnQ/LNhBtjJEDbX4CLVOymABmMzS20C1LOVK
 ieFKjdJDR/0OBJnSWakD+1EA4cFFrA0oocFGPIsoWO2ZW7eVVwn3l7wztKDy+5QYFgU2
 SWn6HqpFVjYCuzlchOyWSgYZvwwVgmGy1jA/FCC4L2PY/8XWInwHghMr2WgdCM7iTTHF
 iJ7swjTaSoRroZpRQmLpL8Rvzdx1msAAxAOYMzDT50ouWAi+Ln2tB70I1C3geVtUFSbf
 +cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731289622; x=1731894422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u6e2ZuWktxkauZewcIGAGIDiQqo/F+K3nvxgsbi9LrA=;
 b=TNoPxb+kmFA7fRMo4ZwYhexzjcECpdKePKUhNg6f46MznseGUBiMFP28vElYrBsrUP
 4E1TSwlU41f0cCc6USDlsjS+SuS8QlHxTdE0G/fCM5p3WGCxPQTXiaLj92WRkeGp16ca
 eqsq355yVQtn6mZLCzAkfQhEVB170PUW2QtEo/b5N1beH/PQmG+FXcCRo0bPhC6tFEWA
 aBD/AHkKODYO9h1N1ODtAaiICGFTu/m5xROg011JdObx+ws62AbxQUdugzF/CF5gc1dk
 4sLR6t4Y0gJZa1ahll6S1i8A6cUshOjTOfzWOhHiFaMlXONhNFBshvAU0IvWUh1rxhB4
 3UqQ==
X-Gm-Message-State: AOJu0YwYhmfhZQZKR1NlrCMTCSIqj0okK8Sbtw4ukHUrKvO6E4E/qV/N
 +bpxuIEHYzoa8T5CF+T+yHilTm9tQM1EP2n1sC7gbhANqVLIOQb4SoimvXHoefHEc0JGwsxSy4M
 Fz7ty/UQV8+cN9q96S2SzDKXBeiPNVXRe
X-Google-Smtp-Source: AGHT+IGlEnc7PtK06oTLnIFkwST7gtfsVi0qLvr+GlKQtYbCTDYqdPDMsWWP3Ymwj03TNfhoQltKAHCur8QKKaq7FhM=
X-Received: by 2002:a17:90b:180a:b0:2e2:d434:854c with SMTP id
 98e67ed59e1d1-2e9b1655951mr15099184a91.2.1731289622002; Sun, 10 Nov 2024
 17:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
 <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
 <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
 <CAHCN7xL1Cp0kkmo3bTPRsKPaqbQFqTXu7spgY2LjOYU0FS3heg@mail.gmail.com>
 <33d0df3d-afff-4cbe-8383-ffb33edb01a6@denx.de>
In-Reply-To: <33d0df3d-afff-4cbe-8383-ffb33edb01a6@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 10 Nov 2024 19:46:50 -0600
Message-ID: <CAHCN7xK7Z8TPLqFRfie2TCfND-4_u2wbds4a9M=x8ocSh_JTwQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, lukma@denx.de, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: multipart/mixed; boundary="000000000000ec62f6062699465d"
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

--000000000000ec62f6062699465d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 6:49=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/10/24 6:21 PM, Adam Ford wrote:
> > On Sun, Nov 10, 2024 at 10:42=E2=80=AFAM Marek Vasut <marex@denx.de> wr=
ote:
> >>
> >> On 11/10/24 2:15 PM, Adam Ford wrote:
> >>> On Sat, Nov 9, 2024 at 7:34=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> >>>>
> >>>> On 11/9/24 9:06 PM, Adam Ford wrote:
> >>>>> When FSPI_CONF_HEADER is set, the binary needs to be built such
> >>>>> that there is a configuration file located at 0x400 and the start
> >>>>> of the file that would normally be flash.bin starts at 0x1000.
> >>>>> This used to be done properly until the device tree was converted t=
o
> >>>>> nxp_imx8mimage.
> >>>>>
> >>>>> Building these with the offsets built into the binman device tree
> >>>>> changes impacts how the actual image is built and the locations
> >>>>> of the various blobs aren't fetched properly and booting fails.
> >>>>>
> >>>>> Fix this by building a standard image as if it were to boot from
> >>>>> eMMC or SD, then use that image as the input for a second image
> >>>>
> >>>> This seems like a workaround for some broken offset calculation in b=
inman ?
> >>>
> >>> This used to work until it was migrated to nxp_imx8mimage.
> >>> The blobs appear to be at the proper offsets, but the contents of
> >>> what's stored at those offsets are not the same.
> >>
> >> I know, this is what Lukasz reported too.
> >>
> >>> If you're going to claim there is a bug somewhere, I would argue that
> >>> it's somewhere i nxp_imx8mimage
> >>
> >> I agree with that claim. Well, by extension, the problem might also be
> >> in binman itself.
> >>
> >>> .  However, if you look at this series,
> >>> the added benefit is the ability for Nano to be able to build both a
> >>> SD/eMMC image and FSPI images with one config which allows for the
> >>> elimination of extra defconfig files.  I am guessing Plus would have =
a
> >>> similar benefit since they have similar bootloaders.
> >> This I do not agree with. If the intent is to generate two images, the=
n
> >> there should be two full binman descriptors, one for each image (one f=
or
> >> flash-plain.bin and one for flash-fspi.bin or some such naming).
> >>
> >> Can you try and fix the FSPI generation first, so an FSPI compatible
> >
> > I am not a python programmer, and I couldn't determine what was going o=
n.
> I am hoping Simon could offer some input here ...
>
> Can you try the attached diff on MX8MM (use "git show -w" to view the
> diff better) ? It will generate two files, flash.bin and flash-fspi.bin
> , the later should have the fspi header and maybe even correct offsets?

I reset my branch to to U-Boot master from wedneday a7a96a37cbd8
"Merge https://source.denx.de/u-boot/custodians/u-boot-riscv")

I verified the FCFB header is present.  Unfortunately, when I burn the
FSPI on my 8MM and attempt to boot, nothing happens.

However, I changed the "nxp,boot-from" parameter to "fspi" and it booted!

U-Boot SPL 2025.01-rc1-00168-ga7a96a37cbd8-dirty (Nov 10 2024 - 19:27:21 -0=
600)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Trying to boot from NOR
<snip>

I looked at your patch, and noticed your FIXME. Once we get the code
working, we'll likely need a way to pass the header offset, because
it's different between Mini (0x0) and Nano / Plus (0x400).

I'd like to suggest we #iifndef the section filename where "flash.bin"
currently sits, and remove it if we are building for flexspi.  This
way we get what you originally requested, which is a single binary.
I have attached my diff file, so you can see my proposal. I am happy
to test either Mini or Nano, but I am traveling this week starting
Wednesday afternoon (US Central time) until Sunday night, so I won't
be able to test in that window.

Let me know how/if you want to proceed.

Thanks for looking into this.

adam
>
> Applies on top of 56accc56b9aa ("bios_emulator: fix first argument of
> pci_{read,write}_config_* function calls") .
>
> I noticed that there is some dependency issue where fspi_header.bin may
> not be generated yet when binman is triggered -- that needs to be fixed.
> You can detect the failure by running 'hexdump -C flash-fspi.bin | head'
> , if there is no FCFB header then this failure occurred. The easiest way
> to work around this is to run 'rm flash.bin ; make flash.bin'. The real
> fix is likely a matter of some Makefile tweak.

--000000000000ec62f6062699465d
Content-Type: text/x-patch; charset="US-ASCII"; name="aford.diff"
Content-Disposition: attachment; filename="aford.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m3cczr6d0>
X-Attachment-Id: f_m3cczr6d0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2kgYi9hcmNoL2FybS9k
dHMvaW14OG1tLXUtYm9vdC5kdHNpCmluZGV4IGQzMWJjODIyNTMuLjcxNTAxYTU3OTYgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2kKKysrIGIvYXJjaC9hcm0vZHRz
L2lteDhtbS11LWJvb3QuZHRzaQpAQCAtNDIsMTY1ICs0MiwxNzAgQEAKIH07CiAKICZiaW5tYW4g
eworI2lmZGVmIENPTkZJR19GU1BJX0NPTkZfSEVBREVSCiAJZmlsZW5hbWUgPSAiZmxhc2guYmlu
IjsKIAlzZWN0aW9uIHsKLQkJcGFkLWJ5dGUgPSA8MHgwMD47Ci0KLSNpZmRlZiBDT05GSUdfRlNQ
SV9DT05GX0hFQURFUgogCQlmc3BpX2NvbmZfYmxvY2sgewogCQkJZmlsZW5hbWUgPSBDT05GSUdf
RlNQSV9DT05GX0ZJTEU7CiAJCQl0eXBlID0gImJsb2ItZXh0IjsKIAkJCXNpemUgPSA8MHgxMDAw
PjsKIAkJfTsKLSNlbmRpZgogCi0jaWZkZWYgQ09ORklHX0lNWF9IQUIKLQkJbnhwLWlteDhtY3N0
QDAgewotCQkJZmlsZW5hbWUgPSAidS1ib290LXNwbC1ta2ltYWdlLnNpZ25lZC5iaW4iOwotCQkJ
bnhwLGxvYWRlci1hZGRyZXNzID0gPENPTkZJR19TUExfVEVYVF9CQVNFPjsKLQkJCW54cCx1bmxv
Y2s7Ci0JCQlhcmdzOwkvKiBOZWVkZWQgYnkgbWtpbWFnZSBldHlwZSBzdXBlcmNsYXNzICovCisJ
CXNlY3Rpb24gewogI2VuZGlmCi0KLQkJCWJpbm1hbl9pbXhfc3BsOiBueHAtaW14OG1pbWFnZSB7
Ci0JCQkJZmlsZW5hbWUgPSAidS1ib290LXNwbC1ta2ltYWdlLmJpbiI7Ci0JCQkJbnhwLGJvb3Qt
ZnJvbSA9ICJzZCI7Ci0JCQkJbnhwLHJvbS12ZXJzaW9uID0gPDE+OwotCQkJCW54cCxsb2FkZXIt
YWRkcmVzcyA9IDxDT05GSUdfU1BMX1RFWFRfQkFTRT47Ci0JCQkJYXJnczsJLyogTmVlZGVkIGJ5
IG1raW1hZ2UgZXR5cGUgc3VwZXJjbGFzcyAqLwotCi0JCQkJc2VjdGlvbiB7Ci0JCQkJCWFsaWdu
ID0gPDQ+OwotCQkJCQlhbGlnbi1zaXplID0gPDQ+OwotCQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3Qt
c3BsLWRkci5iaW4iOwotCQkJCQlwYWQtYnl0ZSA9IDwweGZmPjsKLQotCQkJCQl1LWJvb3Qtc3Bs
IHsKLQkJCQkJCWFsaWduLWVuZCA9IDw0PjsKLQkJCQkJCWZpbGVuYW1lID0gInUtYm9vdC1zcGwu
YmluIjsKLQkJCQkJfTsKLQotCQkJCQlkZHItMWQtaW1lbS1mdyB7Ci0JCQkJCQlmaWxlbmFtZSA9
ICJscGRkcjRfcG11X3RyYWluXzFkX2ltZW0uYmluIjsKLQkJCQkJCWFsaWduLWVuZCA9IDw0PjsK
LQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOwotCQkJCQl9OwotCi0JCQkJCWRkci0xZC1kbWVtLWZ3
IHsKLQkJCQkJCWZpbGVuYW1lID0gImxwZGRyNF9wbXVfdHJhaW5fMWRfZG1lbS5iaW4iOwotCQkJ
CQkJYWxpZ24tZW5kID0gPDQ+OwotCQkJCQkJdHlwZSA9ICJibG9iLWV4dCI7Ci0JCQkJCX07Ci0K
LQkJCQkJZGRyLTJkLWltZW0tZncgewotCQkJCQkJZmlsZW5hbWUgPSAibHBkZHI0X3BtdV90cmFp
bl8yZF9pbWVtLmJpbiI7Ci0JCQkJCQlhbGlnbi1lbmQgPSA8ND47Ci0JCQkJCQl0eXBlID0gImJs
b2ItZXh0IjsKLQkJCQkJfTsKLQotCQkJCQlkZHItMmQtZG1lbS1mdyB7Ci0JCQkJCQlmaWxlbmFt
ZSA9ICJscGRkcjRfcG11X3RyYWluXzJkX2RtZW0uYmluIjsKLQkJCQkJCWFsaWduLWVuZCA9IDw0
PjsKLQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOwotCQkJCQl9OwotCQkJCX07Ci0JCQl9OwotI2lm
ZGVmIENPTkZJR19JTVhfSEFCCi0JCX07Ci0KLQkJbnhwLWlteDhtY3N0QDEgewotCQkJZmlsZW5h
bWUgPSAidS1ib290LWZpdC5zaWduZWQuYmluIjsKLQkJCW54cCxsb2FkZXItYWRkcmVzcyA9IDxD
T05GSUdfU1BMX0xPQURfRklUX0FERFJFU1M+OwogI2lmZGVmIENPTkZJR19GU1BJX0NPTkZfSEVB
REVSCi0JCQlvZmZzZXQgPSA8MHg1OEMwMD47Ci0jZWxzZQotCQkJb2Zmc2V0ID0gPDB4NTdjMDA+
OworCQkJZmlsZW5hbWUgPSAiZmxhc2guYmluIjsKICNlbmRpZgorCQkJc2VjdGlvbiB7CisJCQkJ
cGFkLWJ5dGUgPSA8MHgwMD47CiAKLQkJCWFyZ3M7CS8qIE5lZWRlZCBieSBta2ltYWdlIGV0eXBl
IHN1cGVyY2xhc3MgKi8KKyNpZmRlZiBDT05GSUdfSU1YX0hBQgorCQkJCW54cC1pbXg4bWNzdEAw
IHsKKwkJCQkJZmlsZW5hbWUgPSAidS1ib290LXNwbC1ta2ltYWdlLnNpZ25lZC5iaW4iOworCQkJ
CQlueHAsbG9hZGVyLWFkZHJlc3MgPSA8Q09ORklHX1NQTF9URVhUX0JBU0U+OworCQkJCQlueHAs
dW5sb2NrOworCQkJCQlhcmdzOwkvKiBOZWVkZWQgYnkgbWtpbWFnZSBldHlwZSBzdXBlcmNsYXNz
ICovCiAjZW5kaWYKIAotCQkJYmlubWFuX2lteF9maXQ6IGZpdCB7Ci0JCQkJZGVzY3JpcHRpb24g
PSAiQ29uZmlndXJhdGlvbiB0byBsb2FkIEFURiBiZWZvcmUgVS1Cb290IjsKLQkJCQlmaWxlbmFt
ZSA9ICJ1LWJvb3QuaXRiIjsKLSNpZm5kZWYgQ09ORklHX0lNWF9IQUIKLQkJCQlmaXQsZXh0ZXJu
YWwtb2Zmc2V0ID0gPENPTkZJR19GSVRfRVhURVJOQUxfT0ZGU0VUPjsKLSNlbmRpZgotCQkJCWZp
dCxmZHQtbGlzdCA9ICJvZi1saXN0IjsKLQkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJCQkJ
YmlubWFuX2lteF9zcGw6IG54cC1pbXg4bWltYWdlIHsKKwkJCQkJCWZpbGVuYW1lID0gInUtYm9v
dC1zcGwtbWtpbWFnZS5iaW4iOwogI2lmZGVmIENPTkZJR19GU1BJX0NPTkZfSEVBREVSCi0JCQkJ
b2Zmc2V0ID0gPDB4NThDMDA+OworCQkJCQkJbnhwLGJvb3QtZnJvbSA9ICJmc3BpIjsKICNlbHNl
Ci0JCQkJb2Zmc2V0ID0gPDB4NTdjMDA+OworCQkJCQkJbnhwLGJvb3QtZnJvbSA9ICJzZCI7CiAj
ZW5kaWYKLQotCQkJCWltYWdlcyB7Ci0JCQkJCXVib290IHsKLQkJCQkJCWFyY2ggPSAiYXJtNjQi
OwotCQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7Ci0JCQkJCQlkZXNjcmlwdGlvbiA9ICJVLUJv
b3QgKDY0LWJpdCkiOwotCQkJCQkJbG9hZCA9IDxDT05GSUdfVEVYVF9CQVNFPjsKLQkJCQkJCXR5
cGUgPSAic3RhbmRhbG9uZSI7Ci0KLQkJCQkJCXVib290LWJsb2IgewotCQkJCQkJCWZpbGVuYW1l
ID0gInUtYm9vdC1ub2R0Yi5iaW4iOwotCQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOworCQkJCQkJ
bnhwLHJvbS12ZXJzaW9uID0gPDE+OworCQkJCQkJbnhwLGxvYWRlci1hZGRyZXNzID0gPENPTkZJ
R19TUExfVEVYVF9CQVNFPjsKKwkJCQkJCWFyZ3M7CS8qIE5lZWRlZCBieSBta2ltYWdlIGV0eXBl
IHN1cGVyY2xhc3MgKi8KKworCQkJCQkJc2VjdGlvbiB7CisJCQkJCQkJYWxpZ24gPSA8ND47CisJ
CQkJCQkJYWxpZ24tc2l6ZSA9IDw0PjsKKwkJCQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3Qtc3BsLWRk
ci5iaW4iOworCQkJCQkJCXBhZC1ieXRlID0gPDB4ZmY+OworCisJCQkJCQkJdS1ib290LXNwbCB7
CisJCQkJCQkJCWFsaWduLWVuZCA9IDw0PjsKKwkJCQkJCQkJZmlsZW5hbWUgPSAidS1ib290LXNw
bC5iaW4iOworCQkJCQkJCX07CisKKwkJCQkJCQlkZHItMWQtaW1lbS1mdyB7CisJCQkJCQkJCWZp
bGVuYW1lID0gImxwZGRyNF9wbXVfdHJhaW5fMWRfaW1lbS5iaW4iOworCQkJCQkJCQlhbGlnbi1l
bmQgPSA8ND47CisJCQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOworCQkJCQkJCX07CisKKwkJCQkJ
CQlkZHItMWQtZG1lbS1mdyB7CisJCQkJCQkJCWZpbGVuYW1lID0gImxwZGRyNF9wbXVfdHJhaW5f
MWRfZG1lbS5iaW4iOworCQkJCQkJCQlhbGlnbi1lbmQgPSA8ND47CisJCQkJCQkJCXR5cGUgPSAi
YmxvYi1leHQiOworCQkJCQkJCX07CisKKwkJCQkJCQlkZHItMmQtaW1lbS1mdyB7CisJCQkJCQkJ
CWZpbGVuYW1lID0gImxwZGRyNF9wbXVfdHJhaW5fMmRfaW1lbS5iaW4iOworCQkJCQkJCQlhbGln
bi1lbmQgPSA8ND47CisJCQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOworCQkJCQkJCX07CisKKwkJ
CQkJCQlkZHItMmQtZG1lbS1mdyB7CisJCQkJCQkJCWZpbGVuYW1lID0gImxwZGRyNF9wbXVfdHJh
aW5fMmRfZG1lbS5iaW4iOworCQkJCQkJCQlhbGlnbi1lbmQgPSA8ND47CisJCQkJCQkJCXR5cGUg
PSAiYmxvYi1leHQiOworCQkJCQkJCX07CiAJCQkJCQl9OwogCQkJCQl9OworI2lmZGVmIENPTkZJ
R19JTVhfSEFCCisJCQkJfTsKIAotI2lmbmRlZiBDT05GSUdfQVJNVjhfUFNDSQotCQkJCQlhdGYg
ewotCQkJCQkJYXJjaCA9ICJhcm02NCI7Ci0JCQkJCQljb21wcmVzc2lvbiA9ICJub25lIjsKLQkJ
CQkJCWRlc2NyaXB0aW9uID0gIkFSTSBUcnVzdGVkIEZpcm13YXJlIjsKLQkJCQkJCWVudHJ5ID0g
PDB4OTIwMDAwPjsKLQkJCQkJCWxvYWQgPSA8MHg5MjAwMDA+OwotCQkJCQkJdHlwZSA9ICJmaXJt
d2FyZSI7Ci0KLQkJCQkJCWF0Zi1ibG9iIHsKLQkJCQkJCQlmaWxlbmFtZSA9ICJibDMxLmJpbiI7
Ci0JCQkJCQkJdHlwZSA9ICJhdGYtYmwzMSI7Ci0JCQkJCQl9OwotCQkJCQl9OworCQkJCW54cC1p
bXg4bWNzdEAxIHsKKwkJCQkJZmlsZW5hbWUgPSAidS1ib290LWZpdC5zaWduZWQuYmluIjsKKwkJ
CQkJbnhwLGxvYWRlci1hZGRyZXNzID0gPENPTkZJR19TUExfTE9BRF9GSVRfQUREUkVTUz47CisJ
CQkJCW9mZnNldCA9IDwweDU3YzAwPjsKKworCQkJCQlhcmdzOwkvKiBOZWVkZWQgYnkgbWtpbWFn
ZSBldHlwZSBzdXBlcmNsYXNzICovCiAjZW5kaWYKIAotCQkJCQliaW5tYW5fZmlwOiBmaXAgewot
CQkJCQkJYXJjaCA9ICJhcm02NCI7Ci0JCQkJCQljb21wcmVzc2lvbiA9ICJub25lIjsKLQkJCQkJ
CWRlc2NyaXB0aW9uID0gIlRydXN0ZWQgRmlybXdhcmUgRklQIjsKLQkJCQkJCWxvYWQgPSA8MHg0
MDMxMDAwMD47Ci0JCQkJCQl0eXBlID0gImZpcm13YXJlIjsKLQkJCQkJfTsKKwkJCQkJYmlubWFu
X2lteF9maXQ6IGZpdCB7CisJCQkJCQlkZXNjcmlwdGlvbiA9ICJDb25maWd1cmF0aW9uIHRvIGxv
YWQgQVRGIGJlZm9yZSBVLUJvb3QiOworCQkJCQkJZmlsZW5hbWUgPSAidS1ib290Lml0YiI7Cisj
aWZuZGVmIENPTkZJR19JTVhfSEFCCisJCQkJCQlmaXQsZXh0ZXJuYWwtb2Zmc2V0ID0gPENPTkZJ
R19GSVRfRVhURVJOQUxfT0ZGU0VUPjsKKyNlbmRpZgorCQkJCQkJZml0LGZkdC1saXN0ID0gIm9m
LWxpc3QiOworCQkJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CisJCQkJCQlvZmZzZXQgPSA8MHg1
N2MwMD47CisKKwkJCQkJCWltYWdlcyB7CisJCQkJCQkJdWJvb3QgeworCQkJCQkJCQlhcmNoID0g
ImFybTY0IjsKKwkJCQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7CisJCQkJCQkJCWRlc2NyaXB0
aW9uID0gIlUtQm9vdCAoNjQtYml0KSI7CisJCQkJCQkJCWxvYWQgPSA8Q09ORklHX1RFWFRfQkFT
RT47CisJCQkJCQkJCXR5cGUgPSAic3RhbmRhbG9uZSI7CisKKwkJCQkJCQkJdWJvb3QtYmxvYiB7
CisJCQkJCQkJCQlmaWxlbmFtZSA9ICJ1LWJvb3Qtbm9kdGIuYmluIjsKKwkJCQkJCQkJCXR5cGUg
PSAiYmxvYi1leHQiOworCQkJCQkJCQl9OworCQkJCQkJCX07CiAKLQkJCQkJQGZkdC1TRVEgewot
CQkJCQkJY29tcHJlc3Npb24gPSAibm9uZSI7Ci0JCQkJCQlkZXNjcmlwdGlvbiA9ICJOQU1FIjsK
LQkJCQkJCXR5cGUgPSAiZmxhdF9kdCI7CisjaWZuZGVmIENPTkZJR19BUk1WOF9QU0NJCisJCQkJ
CQkJYXRmIHsKKwkJCQkJCQkJYXJjaCA9ICJhcm02NCI7CisJCQkJCQkJCWNvbXByZXNzaW9uID0g
Im5vbmUiOworCQkJCQkJCQlkZXNjcmlwdGlvbiA9ICJBUk0gVHJ1c3RlZCBGaXJtd2FyZSI7CisJ
CQkJCQkJCWVudHJ5ID0gPDB4OTIwMDAwPjsKKwkJCQkJCQkJbG9hZCA9IDwweDkyMDAwMD47CisJ
CQkJCQkJCXR5cGUgPSAiZmlybXdhcmUiOworCisJCQkJCQkJCWF0Zi1ibG9iIHsKKwkJCQkJCQkJ
CWZpbGVuYW1lID0gImJsMzEuYmluIjsKKwkJCQkJCQkJCXR5cGUgPSAiYXRmLWJsMzEiOworCQkJ
CQkJCQl9OworCQkJCQkJCX07CisjZW5kaWYKIAotCQkJCQkJdWJvb3QtZmR0LWJsb2IgewotCQkJ
CQkJCWZpbGVuYW1lID0gInUtYm9vdC5kdGIiOwotCQkJCQkJCXR5cGUgPSAiYmxvYi1leHQiOwor
CQkJCQkJCWJpbm1hbl9maXA6IGZpcCB7CisJCQkJCQkJCWFyY2ggPSAiYXJtNjQiOworCQkJCQkJ
CQljb21wcmVzc2lvbiA9ICJub25lIjsKKwkJCQkJCQkJZGVzY3JpcHRpb24gPSAiVHJ1c3RlZCBG
aXJtd2FyZSBGSVAiOworCQkJCQkJCQlsb2FkID0gPDB4NDAzMTAwMDA+OworCQkJCQkJCQl0eXBl
ID0gImZpcm13YXJlIjsKKwkJCQkJCQl9OworCisJCQkJCQkJQGZkdC1TRVEgeworCQkJCQkJCQlj
b21wcmVzc2lvbiA9ICJub25lIjsKKwkJCQkJCQkJZGVzY3JpcHRpb24gPSAiTkFNRSI7CisJCQkJ
CQkJCXR5cGUgPSAiZmxhdF9kdCI7CisKKwkJCQkJCQkJdWJvb3QtZmR0LWJsb2IgeworCQkJCQkJ
CQkJZmlsZW5hbWUgPSAidS1ib290LmR0YiI7CisJCQkJCQkJCQl0eXBlID0gImJsb2ItZXh0IjsK
KwkJCQkJCQkJfTsKKwkJCQkJCQl9OwogCQkJCQkJfTsKLQkJCQkJfTsKLQkJCQl9OwogCi0JCQkJ
Y29uZmlndXJhdGlvbnMgewotCQkJCQlkZWZhdWx0ID0gIkBjb25maWctREVGQVVMVC1TRVEiOwor
CQkJCQkJY29uZmlndXJhdGlvbnMgeworCQkJCQkJCWRlZmF1bHQgPSAiQGNvbmZpZy1ERUZBVUxU
LVNFUSI7CiAKLQkJCQkJQGNvbmZpZy1TRVEgewotCQkJCQkJZGVzY3JpcHRpb24gPSAiTkFNRSI7
Ci0JCQkJCQlmZHQgPSAiZmR0LVNFUSI7Ci0JCQkJCQlmaXJtd2FyZSA9ICJ1Ym9vdCI7CisJCQkJ
CQkJQGNvbmZpZy1TRVEgeworCQkJCQkJCQlkZXNjcmlwdGlvbiA9ICJOQU1FIjsKKwkJCQkJCQkJ
ZmR0ID0gImZkdC1TRVEiOworCQkJCQkJCQlmaXJtd2FyZSA9ICJ1Ym9vdCI7CiAjaWZuZGVmIENP
TkZJR19BUk1WOF9QU0NJCi0JCQkJCQlsb2FkYWJsZXMgPSAiYXRmIjsKKwkJCQkJCQkJbG9hZGFi
bGVzID0gImF0ZiI7CiAjZW5kaWYKKwkJCQkJCQl9OworCQkJCQkJfTsKIAkJCQkJfTsKKyNpZmRl
ZiBDT05GSUdfSU1YX0hBQgogCQkJCX07CisjZW5kaWYKIAkJCX07Ci0jaWZkZWYgQ09ORklHX0lN
WF9IQUIKKyNpZmRlZiBDT05GSUdfRlNQSV9DT05GX0hFQURFUgogCQl9OwotI2VuZGlmCiAJfTsK
KyNlbmRpZgogfTsKIAogJmNsayB7CmRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vZXR5cGUvbnhw
X2lteDhtaW1hZ2UucHkgYi90b29scy9iaW5tYW4vZXR5cGUvbnhwX2lteDhtaW1hZ2UucHkKaW5k
ZXggOGFkMTc3YjNiNi4uZTU3ZGE2ODA3OSAxMDA2NDQKLS0tIGEvdG9vbHMvYmlubWFuL2V0eXBl
L254cF9pbXg4bWltYWdlLnB5CisrKyBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9ueHBfaW14OG1pbWFn
ZS5weQpAQCAtNzIsNCArNzIsNiBAQCBjbGFzcyBFbnRyeV9ueHBfaW14OG1pbWFnZShFbnRyeV9t
a2ltYWdlKToKICAgICAgICAgICAgICAgICByZXR1cm4KICAgICAgICAgICAgIHVwdG8gKz0gZW50
cnkuc2l6ZQogCisgICAgICAgICMgRklYTUU6IE1heWJlID8KKyAgICAgICAgaW1hZ2VfcG9zID0g
MAogICAgICAgICBFbnRyeV9zZWN0aW9uLlNldEltYWdlUG9zKHNlbGYsIGltYWdlX3BvcykK
--000000000000ec62f6062699465d--
