Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1038CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6608480F5C;
	Tue, 29 Sep 2026 12:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hUwbuqiO1JlZ; Tue, 29 Sep 2026 12:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10E1D80EDE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790686393;
	b=rPaOyVvETilD3waXTm3L9xw7zMCot8SFbeWKckrUTvTDLx1d1lnlUKP4C3uk/LDpT4ZM
	 QtSQxaHSxIBcr4wV6csTOnySkn+wwAPTmWSqc+03gH8UTq15X9ZI9z7UNWboUx/mBLI2c
	 47lbceyK6P31gLYKOMttLYPYVvrI7dFSmEV20DTNxaRIAgNpfAguSIGVDH4jYrTZTstQ0
	 Ccv9VMlx4Bq7jp1Pg+/eQz8DlSRYcPEu4LjxK/fnEZuDHY/7Y4pWTPb6BU801z/WsUp4b
	 6kIfqPAq5IvAPItu9BmQa4xsKZzjkDgjpB0tVkL1u62jkZ1M4e/FJSy0a42GsXfGnXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790686393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YvcGGUBk9IbFmjPl+FUleFf0YcJbJhciPbVzGm5lX6M=;
	b=clMWLLvp3HStOGAWm5yXqvk0q7Lz3cZteD+LohdtMEo1cGFQ3KX4CMvwpJ7gTyqSoArq
	 ijYH+SbVj8e0f6pGrTECE/QP3Vm+x36pygvGtrRJDZGf0l5OZD4kQ1XtOBZfHt6YtJFOR
	 hBVMdlCvgSUqLgNBm1D12NFD7Zumc53vpvnsxbG9Cl/829cvNxgkcdaU5bUVs0gXEMdyc
	 WxnMAo94Vb9eySlu8G8Z6exjL2kzaSRdRZJj6fFWM6vaVvirwauMsIdj7M+1At5QRWBMF
	 CnBunsapLm1U0WX41vP1TfkYZgGzD44VA4LozJdt4bR2E67Sn6ffpwhmQeXcegqO/Mg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790686393;
	bh=YvcGGUBk9IbFmjPl+FUleFf0YcJbJhciPbVzGm5lX6M=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NLswbOMAXXbK+A+2xk89QebAQxQNvEteaotANrMj/JVQqIOFlu/aiAyfYzqMAA+D0
	 mzNaccD7e692xc1m9d9QreEpxi81grjK6rk6+EmaX2FnooLqFmW2c5Kl3zT3elwJx+
	 YnZH2dYhhoQIKe0I9i6MzbQgua2lIt2PPgya3Kb99joSGfaWVnlcQpjVETD4AeisVg
	 BLoqnd/tSjff3BDWRepApgkRvJD6Rcq2VRf/BZz6Xe5hr1eJeMnNcryfXc5rYbxcmS
	 9ogt2wl9oz5OUa7Zla7g2WaE33NO017FVN2OziZFTZomKJECabcmUieai9G1+MlPPi
	 AuaJerZ07tCRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10E1D80EDE;
	Tue, 29 Sep 2026 12:53:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85932D1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B7AD402EB
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5437HI3PgHf1 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7A70D402E6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790686151;
 b=O/TetiIJ/3WUPQxBT/WJBK65As7ocyBHiKyKPhj+EPhy65tybzmDyQNhnNmgqBw0rVS5
 8M/Yb+SxzzpFvHxYIJMtWgHf3+PbJMv6b+yide8A5DGaQqR4Y48jU/6CNvSUOl4okMwbl
 kd1et87gwAFde7vmuWE51mGevNoHUIwPP+hg2B3fwcpEN7Gqg5Jp6EEmgxxTAM6pDtA9v
 gFOozESu70kPlCroxOyqYDHDedZ3hNc36zDUX/olpE7VqqVQwhhbHgLvDIVoLerSBNzkV
 TJFbLA1hDEclqVTxikdimyiJ5HDwjR4BBbnzS0PVtgplQP//DG0qqTZrZC0gC6Hc+ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790686151;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=YvcGGUBk9IbFmjPl+FUleFf0YcJbJhciPbVzGm5lX6M=;
 b=jcmdf3L3V0Yj6j2mqSO9nMACn4EWvBEP5cItHTZVZH2XLg1MEvypCUtYNzqyLuIaQNLO
 m07+Zg2FmQHtmmVC75U/ePlGOXcJ5LcytJP9bK3PlwW8fwhsRsZLsHrNURd0jCu3MXERI
 /dvE0lwjSPEyX6dmqnMgA0WNIDQwdFvJSX/OyI3gJlmRPiWi5m+1G6LJKXBlvKO+LJsGq
 ugAItrX9rOgKgzjppvdph5X/fO0GMUp7bRPtLyjHP+oIyEOzPLSsol8oxt0GWGGTg1HB4
 4ILnaHXbk299865FYiqXaNwce25PAZ4tdOJ+gxUnMH//3IGObY/V/BIrP99ZgqbLCMA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=GAtl0vlW; 
 arc=none smtp.remote-ip=185.70.43.27
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=iostreampy@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=GAtl0vlW
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A70D402E6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1790686133; x=1790945333;
 bh=YvcGGUBk9IbFmjPl+FUleFf0YcJbJhciPbVzGm5lX6M=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GAtl0vlWzkycqwfLc5/KpTwwYuWsVm+lD3i/0N30aY/L/NwPeFu1ThdUOh4CxUuso
 7x6mTfP71Rf6S+0rB0VI0yiAScxk1P6muOy3o1QAoZdqxloSGBjgfEQH08Vv1qZRoY
 OLDEnTRjq4+26g1hsH8LQuCJrks34ActdHa4PzgKVI4FX9oV6XSzy6AUfVjUh20GkM
 bhpT3Wf0LOALbenrJ6329cJV2vuAphLe2cAQbU02FH6U0KrhYm5SdEQ8NOloTte6UD
 jLWyqxLUrVYKuyRZtjbv0Y1HBt3RtI8QMB7KuPHd36baha8fTwM43DJHmXL0p5PCow
 ARoQjgRVnhWZQ==
Date: Tue, 29 Sep 2026 12:48:46 +0000
To: u-boot@lists.u-boot-project.org
From: Jaeyeong Lee <iostreampy@proton.me>
Cc: trini@konsulko.com, sughosh.ganu@arm.com, kory.maincent@bootlin.com
Subject: [SECURITY] FWU v2 metadata_size under-validation causes heap
 out-of-bounds read
Message-ID: <179068612070.290852.2536897028462322324@proton.me>
Feedback-ID: 96968035:user:proton
X-Pm-Message-ID: 7ee492dce674faf6fd2da416a7d9915795c1182e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 29 Sep 2026 12:52:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello U-Boot maintainers,

I found a heap out-of-bounds read in the FWU v2 metadata initialization pat=
h.

Tested version
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

U-Boot v2026.10-rc5
Commit: a06e89ab05eaa2b8344d521319399333cd760ae5

Affected configuration
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

CONFIG_FWU_MULTI_BANK_UPDATE=3Dy
CONFIG_FWU_MDATA_V2=3Dy
CONFIG_FWU_NUM_BANKS=3D2
CONFIG_FWU_NUM_IMAGES_PER_BANK=3D2

Summary
=3D=3D=3D=3D=3D=3D=3D

FWU v2 uses the metadata_size value read from persistent FWU metadata to
allocate heap storage for two metadata copies.

A metadata_size of 40 bytes contains the 32-byte top-level header and the
8-byte firmware-store descriptor header. It can therefore pass the version,
descriptor offset, CRC, bank count, and image count checks.

The metadata does not contain the image-entry array required by the configu=
red
number of images. However, fwu_data_init() copies the entire image array wh=
ose
size is determined by the compile-time configuration. This results in a hea=
p
out-of-bounds read.

Technical details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

lib/fwu_updates/fwu.c allocates storage for two copies using the metadata s=
ize:

    int fwu_mdata_copies_allocate(u32 mdata_size)
    {
        ...
        g_fwu_data.fwu_mdata =3D calloc(2, mdata_size);
        ...
    }

With metadata_size=3D40, the total allocation is 80 bytes.

lib/fwu_updates/fwu_v2.c compares the descriptor's bank and image counts wi=
th
the configured values:

    num_banks =3D fwu_get_fw_desc(mdata)->num_banks;
    num_images =3D fwu_get_fw_desc(mdata)->num_images;

    if (num_banks !=3D CONFIG_FWU_NUM_BANKS)
        return -EINVAL;

    if (num_images !=3D CONFIG_FWU_NUM_IMAGES_PER_BANK)
        return -EINVAL;

There is no check that metadata_size includes the corresponding
struct fwu_image_entry array.

fwu_data_init() subsequently performs this copy:

    image_info_size =3D sizeof(data->fwu_images);
    src_img_info =3D &fwu_get_fw_desc(mdata)->img_entry[0];
    dst_img_info =3D &data->fwu_images[0];

    memcpy(dst_img_info, src_img_info, image_info_size);

With two banks and two images, the relevant sizes are:

    sizeof(struct fwu_mdata)             =3D 32
    descriptor header                    =3D 8
    declared metadata_size               =3D 40
    allocation for two metadata copies   =3D 80
    sizeof(data->fwu_images)              =3D 160
    copy source offset                    =3D 40
    bytes read beyond the allocation      =3D 120

memcpy() reads 160 bytes beginning at allocation offset 40. The allocation
ends at offset 80, so the final 120 bytes are outside the heap object.

Reproduction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Build U-Boot with the configuration shown above.
2. Prepare both the primary and secondary FWU metadata copies with:

       version       =3D 2
       metadata_size =3D 40
       desc_offset   =3D 32
       num_banks     =3D 2
       num_images    =3D 2

3. Set a valid CRC32 for the declared 40-byte metadata.
4. Store both copies in the configured FWU metadata locations.
5. Invoke fwu_init() through the normal FWU initialization path.

The mandatory-header, CRC, bank-count, and image-count checks pass.
fwu_data_init() then reads the missing image entries beyond the allocated
metadata storage.

ASan result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    top-level metadata size: 32
    descriptor header size: 8
    declared metadata size: 40
    image copy size: 160
    total allocation for two copies: 80

    ERROR: AddressSanitizer: heap-buffer-overflow
    READ of size 160
        #0 memcpy
        #1 fwu_data_init
           lib/fwu_updates/fwu_v2.c:55
        #2 fwu_init
           lib/fwu_updates/fwu_v2.c:259

    The read begins at allocation offset 40 and extends to offset 199.
    The allocation ends at offset 80, resulting in a 120-byte over-read.

Impact
=3D=3D=3D=3D=3D=3D

An attacker who can modify or supply FWU v2 metadata with a valid CRC can
trigger a heap out-of-bounds read while U-Boot initializes the metadata.

The confirmed impact is a bootloader crash or denial of service. Data locat=
ed
after the allocation may also be copied into U-Boot's internal FWU image
information, although I have not demonstrated disclosure or control-flow
impact.

The issue is present in current main at the tested revision.

Regards,
Jaeyeong Lee

