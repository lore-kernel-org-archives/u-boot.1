Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4987F5A8A6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 18:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDFE84329;
	Mon, 20 Apr 2026 20:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="iQCLT0xJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EB58432A; Mon, 20 Apr 2026 20:20:19 +0200 (CEST)
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCB4842BF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 20:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krotti83@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1776709215; x=1776968415;
 bh=2IWCrizQdOmuw21/IeeLoGHxGAC8wNN/4pHir48bvP8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iQCLT0xJM6t57lKoyZfWnCYizYcpitiYcfD7NrFpf+6C82pG1mLWHJW2IG/L8A24d
 +jp35Wx7cbbWUYg6k9V1Z+NtOOpi2VP/3VurXlRgLckB2GiLQoucko8qQNtmTD9Dki
 HYYINLbWA1pV3wo56gR9ZdaBtNzvSO0dyh9W6IOT4AWrJuV6yf07YIG4cq2gPessLS
 cVOWPVA+FFsLfm4D8FApXS0lj7UgJFShmJk34hwuvT2tv+be7XTaKJWz73XsT9sdip
 liTXFZ/Bm4gZCo1XbF+OXy3il28Gh3AwrC/W76qvVC20BPLr8s+I3rmzaRIogunxp7
 DXVTJSBEqPS1Q==
Date: Mon, 20 Apr 2026 18:20:10 +0000
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Johannes Krottmayer <krotti83@proton.me>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de,
 sjg@chromium.org
Subject: Re: [PATCH v2] doc: emulation: qemu-arm: add secure state steps
Message-ID: <3468f39a-8a0a-4123-a0db-9f21b3bf5333@proton.me>
In-Reply-To: <a5724941-bf58-4e5a-b0a7-0d460e4d74c0@gmx.de>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
 <20260420112815.1448132-1-krotti83@proton.me>
 <a5724941-bf58-4e5a-b0a7-0d460e4d74c0@gmx.de>
Feedback-ID: 148511850:user:proton
X-Pm-Message-ID: c6cd8f3c2b049ad2c813c87683b0a508f12322b9
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------496d4e49b98a894d0ac83f32c4f8ed636a0dc77054c2a41052cee03d9daa9268";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------496d4e49b98a894d0ac83f32c4f8ed636a0dc77054c2a41052cee03d9daa9268
Content-Type: multipart/mixed; boundary="------------tSDp6BF3Pwz2Fi1CQKEoKJ03"
Message-ID: <3468f39a-8a0a-4123-a0db-9f21b3bf5333@proton.me>
Date: Mon, 20 Apr 2026 20:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: emulation: qemu-arm: add secure state steps
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, u-boot@lists.denx.de,
 sjg@chromium.org
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
 <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
 <20260420112815.1448132-1-krotti83@proton.me>
 <nHkVtz_J9SWzzQQrBoKbg3jw84Deem1vyb34w9R9HmsZb3xBAsVIwpByqwuTOGpDtiRliB-OTj97-v3BSAhigg==@protonmail.internalid>
 <a5724941-bf58-4e5a-b0a7-0d460e4d74c0@gmx.de>
From: Johannes Krottmayer <krotti83@proton.me>
Content-Language: en-US, de-AT
In-Reply-To: <a5724941-bf58-4e5a-b0a7-0d460e4d74c0@gmx.de>

--------------tSDp6BF3Pwz2Fi1CQKEoKJ03
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Heinrich!

I'm really sorry about that. Seems I have some troubles
with my mail provider or the software (Proton Mail Bridge).

Will definitely try to fix the issues.

I have test the raw patch file with success on a local branch.
Haven't got any errors.

I know it's might not be ideal but I attach the raw patch
and it's might violates the contributing guidelines.

Would be nice if you can test the patch file and report if
there are still errors please.

Thanks in advance!

On 4/20/26 7:41 PM, Heinrich Schuchardt wrote:
> On 4/20/26 13:29, Johannes Krottmayer wrote:
>> Add build steps for building U-Boot in secure state with
>> TF-A and OP-TEE. It includes the full steps for building
>> OP-TEE and TF-A to use with U-Boot. Also a short description
>> how to invoke QEMU with enabled EL3 and EL2. EL3 (machine
>> option secure=on) is required to run TF-A.
>>
>> Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc:
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
>> ---
>>
>> Changes PATCH v2:
>> - Fix typo (OT-TEE -> OP-TEE)
>> - Fix grammatic and correct spellings
>> - Fix line warp and formatting
>> - Add 'git checkout' for the specific (tested) version in the used build commands
>> - Change misleading filename 'flash.bin' to 'qemu_fw.bios'
>>
>>
>>   doc/board/emulation/qemu-arm.rst | 88 ++++++++++++++++++++++++++++++--
>>   1 file changed, 84 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
>> index 1c91c7f3ac6..9e993ca9783 100644
>> --- a/doc/board/emulation/qemu-arm.rst
>> +++ b/doc/board
>> /emulation/qemu-arm.rst
>> @@ -24,8 +24,78 @@ Additionally, a number of optional peripherals can be added to the PCI bus.
>>   See :doc:`../../develop/devicetree/dt_qemu` for information on how to see
>>   the devicetree actually generated by QEMU.
>>
>> -Building U-Boot
>> ----------------
>> +Building (secure)
>>
 +-----------------
>> +
>> +U-Boot
>> +^^^^^^
>> +
>> +- For AArch64::
>> +
>> +    make qemu_arm64_defconfig
>> +    make
>> +
>> +On successful build 'u-boot.bin' should be created. It's necessary in the following
>> +steps (building TF-A).
>> +
>> +OP-TEE
>> +^^^^^^
>> +
>> +- For AArch64::
>> +
>> +    git clone https://github.com/OP-TEE/optee_os.git
>> +    cd optee_os
>> +    git checkout 4.9.0
>> +    export CROSS_COMPILE64=aarch64-none-elf-
>> +    export CROSS_COMPILE32=arm-none-eabi-
>> +    make PLATFORM=vexpress-qemu_armv8a CFG_TRANSFER_LIST=y CFG_MAP_EXT_DT_SECURE=y
>> +
>> +At least OP-TEE v4.9.0 for AArch64 needs both compiler (64-Bit and 32-Bit edition) for
>> +a successful build. On a successful build following files should
>> be created under the
>> +directory 'out/arm-plat-vexpress/core' from OP-TEE::
>> +
>> +    optee_os/out/arm-plat-vexpress/core/tee-header_v2.bin
>> +    optee_os/out/arm-plat-vexpress/core/tee-pageable_v2.bin
>> +
    optee_os/out/arm-plat-vexpress/core/tee-pager_v2.bin
>> +
>> +TF-A
>> +^^^^
>> +
>> +- For AArch64::
>> +
>> +    git clone https://github.com/ARM-software/arm-trusted-firmware.git
>> +    cd arm-trusted-firmware
>> +    git submodule update --init
>> +    git checkout v2.14.0
>> +    export CROSS_COMPILE=aarch64-none-elf-
>> +    export BL32=path/to/tee-header_v2.bin
>> +    export BL32_EXTRA1=path/to/tee-pager_v2.bin
>> +    export BL32_EXTRA2=path/to/tee-pageable_v2.bin
>> +    export BL33=path/to/u-boot.bin
>> +    make PLAT=qemu BL32_RAM_LOCATION=tdram SPD=opteed TRANSFER_LIST=1 all fip
>> +
>> +On successful build the following files should be created under the directory
>> +'build/qemu/release' from TF-A::
>> +
>> +    arm-trusted-firmware/build/qemu/release/bl1.bin
>> +    arm-trusted-firmware/build/qemu/release/fip.b
>> in
>> +
>> +The following file is at least created with TF-A v2.14.0 and can be directly passed
>> +with the '-bios' option to QE
MU::
>> +
>> +    arm-trusted-firmware/build/qemu/release/qemu_fw.bios
>> +
>> +If the single file ('qemu_fw.bios') doesn't exist, 'bl1.bin' and 'fip.bin' can be
>> +concatenated with the command 'dd' alternatively::
>> +
>> +    dd if=bl1.bin of=qemu_fw.bios bs=4096 conv=notrunc
>> +    dd if=fip.bin of=qemu_fw.bios seek=64 bs=4096 conv=notrunc
>> +
>> +Building (non-secure)
>> +---------------------
>> +
>> +U-Boot
>> +^^^^^^
>>   Set the CROSS_COMPILE environment variable as usual, and run:
>>
>>   - For ARM::
>> @@ -38,8 +108,18 @@ Set the CROSS_COMPILE environment variable as usual, and run:
>>       make qemu_arm64_defconfig
>>       make
>>
>> -Running U-Boot
>> ---------------
>> +Running U-Boot (secure)
>> +-----------------------
>> +
>> +- For AArch64::
>> +
>> +    qemu-system-aarch64 -machine virt,secure=on,virtualization=on \
>> +    -nographic -cpu cortex-a57 -bios qemu_fw.bios
>> +
>> +For additional QEMU comman
>> d description see runn
ing U-Boot in non-secure state.
> 
> This is not a valid patch:
> 
> b4 shazam
> https://lore.kernel.org/u-boot/20260420112815.1448132-1-krotti83@proton.me/T/#u
> 
> Applying: doc: emulation: qemu-arm: add secure state steps
> Patch failed at 0001 doc: emulation: qemu-arm: add secure state steps
> error: patch with only garbage at line 17
> 
> Best regards
> 
> Heinrich
> 
>> +
>> +Running U-Boot (non-secure)
>> +---------------------------
>>   The minimal QEMU command line to get U-Boot up and running is:
>>
>>   - For ARM::
> 

--------------tSDp6BF3Pwz2Fi1CQKEoKJ03
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-doc-emulation-qemu-arm-add-secure-state-steps.patch"
Content-Disposition: attachment;
 filename="0001-doc-emulation-qemu-arm-add-secure-state-steps.patch"

RnJvbSA1NTlhNWMwMzU0OTg1NWUwOWM5MzYyMjg0MDg4ZDQ5NDRlNzVhN2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2hhbm5lcyBLcm90dG1heWVyIDxrcm90dGk4M0Bwcm90b24u
bWU+CkRhdGU6IE1vbiwgMjAgQXByIDIwMjYgMTI6MDg6MDcgKzAyMDAKU3ViamVjdDogW1BBVENI
IHYyXSBkb2M6IGVtdWxhdGlvbjogcWVtdS1hcm06IGFkZCBzZWN1cmUgc3RhdGUgc3RlcHMKCkFk
ZCBidWlsZCBzdGVwcyBmb3IgYnVpbGRpbmcgVS1Cb290IGluIHNlY3VyZSBzdGF0ZSB3aXRoClRG
LUEgYW5kIE9QLVRFRS4gSXQgaW5jbHVkZXMgdGhlIGZ1bGwgc3RlcHMgZm9yIGJ1aWxkaW5nCk9Q
LVRFRSBhbmQgVEYtQSB0byB1c2Ugd2l0aCBVLUJvb3QuIEFsc28gYSBzaG9ydCBkZXNjcmlwdGlv
bgpob3cgdG8gaW52b2tlIFFFTVUgd2l0aCBlbmFibGVkIEVMMyBhbmQgRUwyLiBFTDMgKG1hY2hp
bmUKb3B0aW9uIHNlY3VyZT1vbikgaXMgcmVxdWlyZWQgdG8gcnVuIFRGLUEuCgpTaWduZWQtb2Zm
LWJ5OiBKb2hhbm5lcyBLcm90dG1heWVyIDxrcm90dGk4M0Bwcm90b24ubWU+CkNjOiBUb20gUmlu
aSA8dHJpbmlAa29uc3Vsa28uY29tPgpDYzogVHVvbWFzIFR5bmtreW5lbiA8dHVvbWFzLnR5bmtr
eW5lbkBpa2kuZmk+Ci0tLQoKQ2hhbmdlcyBQQVRDSCB2MjoKLSBGaXggdHlwbyAoT1QtVEVFIC0+
IE9QLVRFRSkKLSBGaXggZ3JhbW1hdGljIGFuZCBjb3JyZWN0IHNwZWxsaW5ncwotIEZpeCBsaW5l
IHdhcnAgYW5kIGZvcm1hdHRpbmcKLSBBZGQgJ2dpdCBjaGVja291dCcgZm9yIHRoZSBzcGVjaWZp
YyAodGVzdGVkKSB2ZXJzaW9uIGluIHRoZSB1c2VkIGJ1aWxkIGNvbW1hbmRzCi0gQ2hhbmdlIG1p
c2xlYWRpbmcgZmlsZW5hbWUgJ2ZsYXNoLmJpbicgdG8gJ3FlbXVfZncuYmlvcycKCgogZG9jL2Jv
YXJkL2VtdWxhdGlvbi9xZW11LWFybS5yc3QgfCA4OCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQogMSBmaWxlIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZG9jL2JvYXJkL2VtdWxhdGlvbi9xZW11LWFybS5yc3QgYi9kb2MvYm9h
cmQvZW11bGF0aW9uL3FlbXUtYXJtLnJzdAppbmRleCAxYzkxYzdmM2FjNi4uOWU5OTNjYTk3ODMg
MTAwNjQ0Ci0tLSBhL2RvYy9ib2FyZC9lbXVsYXRpb24vcWVtdS1hcm0ucnN0CisrKyBiL2RvYy9i
b2FyZC9lbXVsYXRpb24vcWVtdS1hcm0ucnN0CkBAIC0yNCw4ICsyNCw3OCBAQCBBZGRpdGlvbmFs
bHksIGEgbnVtYmVyIG9mIG9wdGlvbmFsIHBlcmlwaGVyYWxzIGNhbiBiZSBhZGRlZCB0byB0aGUg
UENJIGJ1cy4KIFNlZSA6ZG9jOmAuLi8uLi9kZXZlbG9wL2RldmljZXRyZWUvZHRfcWVtdWAgZm9y
IGluZm9ybWF0aW9uIG9uIGhvdyB0byBzZWUKIHRoZSBkZXZpY2V0cmVlIGFjdHVhbGx5IGdlbmVy
YXRlZCBieSBRRU1VLgogCi1CdWlsZGluZyBVLUJvb3QKLS0tLS0tLS0tLS0tLS0tLQorQnVpbGRp
bmcgKHNlY3VyZSkKKy0tLS0tLS0tLS0tLS0tLS0tCisKK1UtQm9vdAorXl5eXl5eCisKKy0gRm9y
IEFBcmNoNjQ6OgorCisgICAgbWFrZSBxZW11X2FybTY0X2RlZmNvbmZpZworICAgIG1ha2UKKwor
T24gc3VjY2Vzc2Z1bCBidWlsZCAndS1ib290LmJpbicgc2hvdWxkIGJlIGNyZWF0ZWQuIEl0J3Mg
bmVjZXNzYXJ5IGluIHRoZSBmb2xsb3dpbmcKK3N0ZXBzIChidWlsZGluZyBURi1BKS4KKworT1At
VEVFCiteXl5eXl4KKworLSBGb3IgQUFyY2g2NDo6CisKKyAgICBnaXQgY2xvbmUgaHR0cHM6Ly9n
aXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy5naXQKKyAgICBjZCBvcHRlZV9vcworICAgIGdpdCBj
aGVja291dCA0LjkuMAorICAgIGV4cG9ydCBDUk9TU19DT01QSUxFNjQ9YWFyY2g2NC1ub25lLWVs
Zi0KKyAgICBleHBvcnQgQ1JPU1NfQ09NUElMRTMyPWFybS1ub25lLWVhYmktCisgICAgbWFrZSBQ
TEFURk9STT12ZXhwcmVzcy1xZW11X2FybXY4YSBDRkdfVFJBTlNGRVJfTElTVD15IENGR19NQVBf
RVhUX0RUX1NFQ1VSRT15CisKK0F0IGxlYXN0IE9QLVRFRSB2NC45LjAgZm9yIEFBcmNoNjQgbmVl
ZHMgYm90aCBjb21waWxlciAoNjQtQml0IGFuZCAzMi1CaXQgZWRpdGlvbikgZm9yCithIHN1Y2Nl
c3NmdWwgYnVpbGQuIE9uIGEgc3VjY2Vzc2Z1bCBidWlsZCBmb2xsb3dpbmcgZmlsZXMgc2hvdWxk
IGJlIGNyZWF0ZWQgdW5kZXIgdGhlCitkaXJlY3RvcnkgJ291dC9hcm0tcGxhdC12ZXhwcmVzcy9j
b3JlJyBmcm9tIE9QLVRFRTo6CisKKyAgICBvcHRlZV9vcy9vdXQvYXJtLXBsYXQtdmV4cHJlc3Mv
Y29yZS90ZWUtaGVhZGVyX3YyLmJpbgorICAgIG9wdGVlX29zL291dC9hcm0tcGxhdC12ZXhwcmVz
cy9jb3JlL3RlZS1wYWdlYWJsZV92Mi5iaW4KKyAgICBvcHRlZV9vcy9vdXQvYXJtLXBsYXQtdmV4
cHJlc3MvY29yZS90ZWUtcGFnZXJfdjIuYmluCisKK1RGLUEKK15eXl4KKworLSBGb3IgQUFyY2g2
NDo6CisKKyAgICBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL0FSTS1zb2Z0d2FyZS9hcm0t
dHJ1c3RlZC1maXJtd2FyZS5naXQKKyAgICBjZCBhcm0tdHJ1c3RlZC1maXJtd2FyZQorICAgIGdp
dCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdAorICAgIGdpdCBjaGVja291dCB2Mi4xNC4wCisgICAg
ZXhwb3J0IENST1NTX0NPTVBJTEU9YWFyY2g2NC1ub25lLWVsZi0KKyAgICBleHBvcnQgQkwzMj1w
YXRoL3RvL3RlZS1oZWFkZXJfdjIuYmluCisgICAgZXhwb3J0IEJMMzJfRVhUUkExPXBhdGgvdG8v
dGVlLXBhZ2VyX3YyLmJpbgorICAgIGV4cG9ydCBCTDMyX0VYVFJBMj1wYXRoL3RvL3RlZS1wYWdl
YWJsZV92Mi5iaW4KKyAgICBleHBvcnQgQkwzMz1wYXRoL3RvL3UtYm9vdC5iaW4KKyAgICBtYWtl
IFBMQVQ9cWVtdSBCTDMyX1JBTV9MT0NBVElPTj10ZHJhbSBTUEQ9b3B0ZWVkIFRSQU5TRkVSX0xJ
U1Q9MSBhbGwgZmlwCisKK09uIHN1Y2Nlc3NmdWwgYnVpbGQgdGhlIGZvbGxvd2luZyBmaWxlcyBz
aG91bGQgYmUgY3JlYXRlZCB1bmRlciB0aGUgZGlyZWN0b3J5CisnYnVpbGQvcWVtdS9yZWxlYXNl
JyBmcm9tIFRGLUE6OgorCisgICAgYXJtLXRydXN0ZWQtZmlybXdhcmUvYnVpbGQvcWVtdS9yZWxl
YXNlL2JsMS5iaW4KKyAgICBhcm0tdHJ1c3RlZC1maXJtd2FyZS9idWlsZC9xZW11L3JlbGVhc2Uv
ZmlwLmJpbgorCitUaGUgZm9sbG93aW5nIGZpbGUgaXMgYXQgbGVhc3QgY3JlYXRlZCB3aXRoIFRG
LUEgdjIuMTQuMCBhbmQgY2FuIGJlIGRpcmVjdGx5IHBhc3NlZAord2l0aCB0aGUgJy1iaW9zJyBv
cHRpb24gdG8gUUVNVTo6CisKKyAgICBhcm0tdHJ1c3RlZC1maXJtd2FyZS9idWlsZC9xZW11L3Jl
bGVhc2UvcWVtdV9mdy5iaW9zCisKK0lmIHRoZSBzaW5nbGUgZmlsZSAoJ3FlbXVfZncuYmlvcycp
IGRvZXNuJ3QgZXhpc3QsICdibDEuYmluJyBhbmQgJ2ZpcC5iaW4nIGNhbiBiZQorY29uY2F0ZW5h
dGVkIHdpdGggdGhlIGNvbW1hbmQgJ2RkJyBhbHRlcm5hdGl2ZWx5OjoKKworICAgIGRkIGlmPWJs
MS5iaW4gb2Y9cWVtdV9mdy5iaW9zIGJzPTQwOTYgY29udj1ub3RydW5jCisgICAgZGQgaWY9Zmlw
LmJpbiBvZj1xZW11X2Z3LmJpb3Mgc2Vlaz02NCBicz00MDk2IGNvbnY9bm90cnVuYworCitCdWls
ZGluZyAobm9uLXNlY3VyZSkKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCitVLUJvb3QKK15eXl5e
XgogU2V0IHRoZSBDUk9TU19DT01QSUxFIGVudmlyb25tZW50IHZhcmlhYmxlIGFzIHVzdWFsLCBh
bmQgcnVuOgogCiAtIEZvciBBUk06OgpAQCAtMzgsOCArMTA4LDE4IEBAIFNldCB0aGUgQ1JPU1Nf
Q09NUElMRSBlbnZpcm9ubWVudCB2YXJpYWJsZSBhcyB1c3VhbCwgYW5kIHJ1bjoKICAgICBtYWtl
IHFlbXVfYXJtNjRfZGVmY29uZmlnCiAgICAgbWFrZQogCi1SdW5uaW5nIFUtQm9vdAotLS0tLS0t
LS0tLS0tLS0KK1J1bm5pbmcgVS1Cb290IChzZWN1cmUpCistLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQorCistIEZvciBBQXJjaDY0OjoKKworICAgIHFlbXUtc3lzdGVtLWFhcmNoNjQgLW1hY2hpbmUg
dmlydCxzZWN1cmU9b24sdmlydHVhbGl6YXRpb249b24gXAorICAgIC1ub2dyYXBoaWMgLWNwdSBj
b3J0ZXgtYTU3IC1iaW9zIHFlbXVfZncuYmlvcworCitGb3IgYWRkaXRpb25hbCBRRU1VIGNvbW1h
bmQgZGVzY3JpcHRpb24gc2VlIHJ1bm5pbmcgVS1Cb290IGluIG5vbi1zZWN1cmUgc3RhdGUuCisK
K1J1bm5pbmcgVS1Cb290IChub24tc2VjdXJlKQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiBUaGUgbWluaW1hbCBRRU1VIGNvbW1hbmQgbGluZSB0byBnZXQgVS1Cb290IHVwIGFuZCBydW5u
aW5nIGlzOgogCiAtIEZvciBBUk06OgotLSAKMi40Ny4zCgo=
--------------tSDp6BF3Pwz2Fi1CQKEoKJ03
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - krotti83@proton.me -
 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"
Content-Type: application/pgp-keys; filename="publickey - krotti83@proton.me
 - 0x1A5D6E0E.asc"; name="publickey - krotti83@proton.me - 0x1A5D6E0E.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYUZyS2dSWUpLd1lCQkFIYVJ3
OEJBUWRBdm9MdzByd3hVZEZsMyszSytnTWhkTnlTK1p3WjU2Q0hlc2xBCndyKzhzalBOSjJ0eWIz
UjBhVGd6UUhCeWIzUnZiaTV0WlNBOGEzSnZkSFJwT0ROQWNISnZkRzl1TG0xbFBzTEEKRVFRVEZn
b0Fnd1dDYUZyS2dRTUxDUWNKa05aaG1aenF4TUNlUlJRQUFBQUFBQndBSUhOaGJIUkFibTkwWVhS
cApiMjV6TG05d1pXNXdaM0JxY3k1dmNtZnQwODBDTndEN0laNnB0eVgvVzhucHhhRFlwT0x6Zm05
Y21aK0hUUGJZCkN3TVZDZ2dFRmdBQ0FRSVpBUUtiQXdJZUFSWWhCQnBkYmc2UkVwSmNUMWFzaHRa
aG1aenF4TUNlQUFCdy9RRUEKOVVkYTBubVA4Q1g4UW1PciswNEY5U3g0c1NSUHhza0NsdE5rWlRW
RHROb0JBTjFlL3I5TnFZbUx1MjI4eHlVbQpmMHBkVXFlallJTytPT0lFZFFhMEZQd0V6amdFYUZy
S2dSSUtLd1lCQkFHWFZRRUZBUUVIUUJjYVpHMlZxK1MxCmV0Q2NSWDVJaGZnSHJCTFhIcGV1SzJC
VmZxZFNFVlltQXdFSUI4SytCQmdXQ2dCd0JZSm9Xc3FCQ1pEV1labWMKNnNUQW5rVVVBQUFBQUFB
Y0FDQnpZV3gwUUc1dmRHRjBhVzl1Y3k1dmNHVnVjR2R3YW5NdWIzSm44bk5IbWtwbApTakU0b1pU
WDVDZVlsamVGcmowd2pNWERNWENXZzdNNytnc0Ntd3dXSVFRYVhXNE9rUktTWEU5V3JJYldZWm1j
CjZzVEFuZ0FBZGdBQkFMc2p0elBMYjBnVytUQkFzVXNGNjNZUW1BRXBsUm55RWwxQ20rclJNZXJv
QVA5dVRkVFUKdThGL25ab0RUS3BxcGM4L1RqakhkU2JWMzMyUmhBdW1NSmQ4Q3c9PQo9TXJhaAot
LS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
--------------tSDp6BF3Pwz2Fi1CQKEoKJ03--

--------496d4e49b98a894d0ac83f32c4f8ed636a0dc77054c2a41052cee03d9daa9268
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmnmblgJENZhmZzqxMCeNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcTPjg/pjKI9GQGsCIW8HWAFiEEGl1uDpESklxP
VqyG1mGZnOrEwJ4AANNxAQDW1XuUYa4WJEqw8MmTa07JATIqrJj7Je8Mbn3n
iBbDVAD/Sizxy23LI+IOdK9HG32uYcPhLCq+wIk3DBQZbFPkBww=
=ip2+
-----END PGP SIGNATURE-----


--------496d4e49b98a894d0ac83f32c4f8ed636a0dc77054c2a41052cee03d9daa9268--

