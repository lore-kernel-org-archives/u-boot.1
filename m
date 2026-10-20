Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uJsYtxjN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RoVENGb6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9176810E4;
	Tue, 20 Oct 2026 13:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTQrMBq-__Af; Tue, 20 Oct 2026 13:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CB9B810C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792502493;
	b=Len3PZx3E2uvhG6NxLIdDRuEKMSPv4si/75cKq5HeEPubqX7reU1s0PTVXEjN4vWv2Oq
	 hNMyPyMG8/pgn0zMk5asjXZ8OMppwc1OkC8rytJR3vWOw40xGmpDvTTlAS7bJ/aRrn4XV
	 s09Qe64QirLpF+TmpnCbHXn3D7SWzXsOc0/kOUeifV7n2oG+xcHb68dhuBecjAgHNUdp4
	 etXxJDsELNxfNvldbTfrwGUyY0HW6PLXBpuCXT1lIBKiKOxY/JIWD1lj/f/tpPFzqyzUj
	 wglj0EfT3HONrdEIAhFK7nQRyzhTK0trHOo0S6MCKcesHQ6ZW80BkAhCO4lONIKw1Qg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792502493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
	b=emGaB9WTkTvvHBWKPOOrMuVDWc6od4sBH/gxWPwIOvb1rq/V6j8SrKg1ZY7ddIiMmCGN
	 kXK6og5g7e5cA/ZlV3DDsiIGwTX3A/d1JwqrL9xqn78ik7JmUnoYXbNmL4Ze0Sj1QMRtX
	 paRXoJsVNjdZMLWPoMO+C/0KjeBgfORuHrVfUmevcvaXiHZgKPfQwoTWh9+cau0Mgxw3J
	 jvtCFfPeW9UOTVjTzTeIjPb8Ab0bXOdxcnOkVubMv8WecwbuTZmucwegKcuU91KEDU5Bl
	 cAVwvGwA3xy7Y5kWZNDAW9S99EPjg8fxA9eYVS7pxV2UOS/I+A75ry1XS0arYVM17AA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792502493;
	bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uJsYtxjNITGsdAtaeocORXNBNfB4378QRHro77DeSUcrnXMDORBe4g5GrWx1DsULr
	 SDJPIJV7R1aIVjkZqJ07cyExSAzTXkaF9mWbZY9B4ESLqW7uhx3cdRWSsPk5JC7DmH
	 CoSv3LoshKONGH33UCa7bhnm78+Lx8LQVmmS/gW4vSU2n+/NoNG1JvtyQJyQoNywtL
	 veV4yZQMHzmsW+Tp2cYzeznT8gkrvST10YSsnffYxd3+O8C/+BOeDMQw0pC9CUAYZm
	 dgsygFYYPU9zB0ReY8p4hb6g8cCSGY/ysKRTDMJujv1olc60iX5UbrlzfjqxK3cf86
	 w0mTBGQhNtBMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CB9B810C3;
	Tue, 20 Oct 2026 13:21:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09F0D1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06D7C407FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AsCCi-fkusbP for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B9AB407D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792485364;
 b=WQJMUxSjLVwpyXG+aLVVEjQqipqASKd75BzH3SKsSFp4AC+xSocn3/jweNCHunuVWgQs
 4O3qA/OGhB+JsWCleRGShkIW5JCVfl93NcA2DD40MOySmrVtx9hJs+jYmzDzSusxImT6A
 5l0LmvH+vhuwTHxh8WyfjqXPaPZHnStQCI1DDAmNjkYWh0w2xuP8mefUdhb2fWbmFvsPr
 XarrZiAhlzv8xNzr1fXFNFi0RRExCPb5KBGDfh4Va7Nldc6kwBk0mtL4j1uHXfSxmwdLp
 eJsIEW/pxBZ91LUlK3r+CYlq05950N9aBaUrauB8uLK13jeVC/FV3KSl/UVPmAbTVwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792485364;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
 b=RD5n3cbudHh7m55HbqztdoKPMPD144CG/OHAp27kt0g67ENduXMOCFWHaiSRtqqzayjY
 PBByquQB8I4Ct3r8oAT/yT2opImmZVyPMDUQ0XCAvjWL3o1y6ukohe9vxjJknoWJ3Nmpb
 RcPmFZ1L+ylLneJvxsGttLzYrL9kr4hUKsge4MJjthuLhyqi39DJYyOJPnCEX5Fr+ryDG
 9upyJCNK9MjojVU4s5tx4NF5M/iCu/niLnynUbq9eqQViPfYgnw4qpyZ/Okn6URLbNkgS
 fm5K32MUeifQ5b0HHJAshiYaPWIwr1OENhrl2GdilSFESyMSQVigd9LFa7970B/FAoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RoVENGb6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RoVENGb6
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B9AB407D1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:36:03 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4a76d86a3e9so921990fac.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792485363; cv=none;
 d=google.com; s=arc-20260327;
 b=sgFQ7Ltld+xEQBlxiRzrjqnR7rXyDp6feTbRNOhvOlk3i1aaVBYJy7+H6UOEB3GdbV
 GabkkPC1dsK7HDArFD0ilLvWQzbdzhfLnvukF+pPJB7W55GCFC1SlYVRXq3DtCYZt4EP
 OkvCkPzL2WXBAcS4za+rBRLFgPg/9P0C7881XsMiZWH/2skmNRu3FjuK19gySIWWC2Mx
 rkFC5Qc+rnBDddM15KraPArLarR6A+DUKuRbmnf7oTwoTOqXU2VAt4koX6ctXIIAxLsV
 2HmSymrwiu8j2pIx3vaOMrE9G9oszjHuGqHtUU3bXs12p2i7LniTC7aDTDJ1nbzqYzAe
 7zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
 fh=GNNxkcoCE74kfzIXrNqXtwgB81K6wc7T4m+z4qJ78cA=;
 b=IlvRgQ9CUQj/8CfdmQu1Ny9cXxY3UbMnBcfIX+mAUCFi7yDnPj9wfGKgdzlcTdeL6n
 M40mZSGYsBLGtjoraX7VeTCQOH8laSKUHnTNAk7DWUw1zvYhHreLNtN6cuNY0T94+mJg
 NIL4ahviiYqKsDX4BIImu64lVDixESBOz38LS8UHHEHigySVQlZsZiKXketM7EFTn1bP
 spA/Fz7dGcRrvob8Qwl+t7oWrz7RUh58eUatEFMNehb/2QILHFBLK6FHxGuDaR/W2C2M
 KaiIP2b4BPA2Zf2+AyS8KFAE+Mrzl8BEmDXMFUD6BuemjT000QKJ0/m5xHvBMXGy3aMd
 PicQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792485363; x=1793090163;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
 b=RoVENGb69CAH+TfZa1tUJTvbbEYc74AJcAA8kka2fn/TxnVVCGrMXcEPUYe9OB9sh2
 s7xEgvEZ/S2UvrJ6GKEeWiylUQbApr5exwb5zIgRrKACR8UhaFJl01LV1T0gYlbQAbLx
 nfIJULzHpClAMza0SsZtIUnmGiKAjEZwgVjQgnpKomiu7fsz3O2HhKpcYqfB9lygKfRq
 51OT6x/RbGFkVrebyDPmAmBQNOZNjwukvS4JftgKG4Dzl6ho3ASJKNwmAsQVLJcsH1lv
 0TkxUZRzJlW2uocRjhO8A8hfqrbyabwBnvD5iUQ4+3r486LZHSi7J098OkQUnTpzmpU3
 NSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792485363; x=1793090163;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bykDrkaQJr7YSgZrrKuULZ3iXjcr7BIlf/KJfP0NGb8=;
 b=NFZ+TTKsja2VGlODPZC7YhqWf1oTV0Ui8xMG00zBTu+OIylOvHO1QYHITg2N8NoqTZ
 LOT1a+tCatpxUI2RWMNnFIFdEaenywo3awYM8PvcLg1MXsOr5IyGZwL+TOezx9g/7XuW
 0Hw5NlHLOl+Gwk5g2a8zdXQDte+vyPU5vDNj9GNk57Ga01TIpiG+7Z3Jcu570ncUOU/0
 rGJPeOowKRXBznKDHsTnedU1xHU2pEjXI7kZs9OJBkqZJ3Ip0EFGOzRRXA+d+8LItMIB
 SysWpEYu1x3XqLJiQvTs5jGN8JxIUh4D+c0oUdd+J0RZELTcb+86Q1u0TAGsIPCy4KHc
 7AVg==
X-Gm-Message-State: AFq9FYJRxy7qs/91P0/Y/d3Q5gDkRjJKhmoogcHlugpL5vXH6beumDpm
 dLpJNz3hwuZbAsr6CxSnaOQXzMVet+drbyoLl5yDwlw2QcrwMbY9VlwRXTEBuCOgPd9LFmE/yM6
 u4J4bSSMn9038LulbK/YNVhmstd2Nhu4=
X-Gm-Gg: AYBFou0rbIo6Abt20DLCggxlhImmztCgam2yESaTzggbksCqGHRgSDg4MetQhEhVCbO
 vz2Y06l2go56hmnZkkYWhWUW2Th3zbWeMLNB2nJS1UkqZn1/Tn/PLPgctHzMglAacSe1IxQYreY
 lEqaGcEfguKswYRmjFTm93p8gKxhuYA7fjgDm0gfz3l4SgrsIHv31BNLZjKaK8GYY0Ih1pbykOP
 4qmJxrl+oYgI/vh1hec3V8byPqGnlB6IuZTOBfKF8yQsGYV/F8mT00iVjIE9lnAJ26OAeZIxhem
 DC2nnXIkUWuLN+8os4spfYOVlxHv0TWClmKXV20DIlRapLpT6GTaHoeW
X-Received: by 2002:a05:6870:7818:b0:494:7d13:7a5c with SMTP id
 586e51a60fabf-4a757a73607mr7790213fac.30.1792485362722; Tue, 20 Oct 2026
 01:36:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019205932.28038-1-nimeshacharya197@gmail.com>
 <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
In-Reply-To: <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
From: Nimesh Acharya <nimeshacharya197@gmail.com>
Date: Tue, 20 Oct 2026 14:05:51 +0530
X-Gm-Features: AclHuK_gE2oRFGQJFaLv7_OmszjLu32Sr6pkokxK8Qx55tyvRtU-v0R12vn54aA
Message-ID: <CAMb=oEaXycpsLz6wfxKVqucox+ZuJumMgaz3Q=+dfD8R3o804g@mail.gmail.com>
Subject: Re: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, hsnaves@gmail.com, 
 marek.vasut+socfpga@mailbox.org, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@altera.com, trini@konsulko.com
Content-Type: multipart/alternative; boundary="0000000000004f6bfb065e418578"
X-Mailman-Approved-At: Tue, 20 Oct 2026 13:21:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004f6bfb065e418578
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for bringing that up. In fact, on running grep -E
'SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|SPL_FS_FAT=
|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE'
$B/*/.config

I get this output for the default config:

CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2
# CONFIG_SPL_FS_FAT is not set
# CONFIG_SPL_LOAD_FIT is not set
CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x200
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x0
# CONFIG_SPL_FS_EXT4 is not set
CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D1

So, me adding CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 again =
is
indeed redundant. I'll fix this soon.

On Tue, 20 Oct, 2026, 7:08=E2=80=AFam Marek Vasut, <marek.vasut@mailbox.org=
> wrote:

> On 10/19/26 10:59 PM, Nimesh Acharya wrote:
> > When using the default meta-intel-fpga configuration in Yocto
> > 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> > U-Boot from the raw a2 partition on the SDMMC device.
> >
> > This change configures SPL to locate the raw U-Boot image using the
> > partition type and data offset, rather than relying on the
> > default offset relative to the beginning of the SD card.
> >
> > Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
> > ---
> >   configs/socfpga_de10_standard_defconfig | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/configs/socfpga_de10_standard_defconfig
> b/configs/socfpga_de10_standard_defconfig
> > index 04f9d6c8494..f170778c322 100644
> > --- a/configs/socfpga_de10_standard_defconfig
> > +++ b/configs/socfpga_de10_standard_defconfig
> > @@ -70,3 +70,8 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy
> >   CONFIG_USB_GADGET_DOWNLOAD=3Dy
> >   # CONFIG_SPL_WDT is not set
> >   CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> > +
> > +# SPL Fails to load UBOOT without these!
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200
>
> What does get configured in the .config during OE build without these
> options ?
>
> For example SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE is already set to
> 0xa2 in arch/arm/mach-socfpga/Kconfig , so that shouldn't be part of
> this patch.
>

--0000000000004f6bfb065e418578
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for bringing that up. In fact, on running grep -E =
&#39;SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|SPL_FS=
_FAT|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE&#39; $B/*/.config<div dir=3D"au=
to"><br></div><div dir=3D"auto">I get this output for the default config:</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">CONFIG_SYS_MMCSD_RAW_MODE=
_U_BOOT_PARTITION_TYPE=3D0xa2=C2=A0</div><div dir=3D"auto"># CONFIG_SPL_FS_=
FAT is not set=C2=A0</div><div dir=3D"auto"># CONFIG_SPL_LOAD_FIT is not se=
t=C2=A0</div><div dir=3D"auto">CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy=C2=A0</div>=
<div dir=3D"auto">CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy=C2=A0</div><div dir=3D"=
auto">CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy=C2=A0</div><div dir=
=3D"auto"># CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set=C2=A0=
</div><div dir=3D"auto"># CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TY=
PE is not set=C2=A0</div><div dir=3D"auto">CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT=
_SECTOR=3D0x200=C2=A0</div><div dir=3D"auto">CONFIG_SYS_MMCSD_RAW_MODE_U_BO=
OT_DATA_PART_OFFSET=3D0x0=C2=A0</div><div dir=3D"auto"># CONFIG_SPL_FS_EXT4=
 is not set=C2=A0</div><div dir=3D"auto">CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=
=3D1</div><div dir=3D"auto"><br></div><div dir=3D"auto">So, me adding CONFI=
G_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 again is indeed redundant=
. I&#39;ll fix this soon.</div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 20 Oct, 2026, =
7:08=E2=80=AFam Marek Vasut, &lt;<a href=3D"mailto:marek.vasut@mailbox.org"=
>marek.vasut@mailbox.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On 10/19/26 10:59 PM, Nimesh Acharya wrote:<br>
&gt; When using the default meta-intel-fpga configuration in Yocto<br>
&gt; 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load<br>
&gt; U-Boot from the raw a2 partition on the SDMMC device.<br>
&gt; <br>
&gt; This change configures SPL to locate the raw U-Boot image using the<br=
>
&gt; partition type and data offset, rather than relying on the<br>
&gt; default offset relative to the beginning of the SD card.<br>
&gt; <br>
&gt; Signed-off-by: Nimesh Acharya &lt;<a href=3D"mailto:nimeshacharya197@g=
mail.com" target=3D"_blank" rel=3D"noreferrer">nimeshacharya197@gmail.com</=
a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0configs/socfpga_de10_standard_defconfig | 5 +++++<br>
&gt;=C2=A0 =C2=A01 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga=
_de10_standard_defconfig<br>
&gt; index 04f9d6c8494..f170778c322 100644<br>
&gt; --- a/configs/socfpga_de10_standard_defconfig<br>
&gt; +++ b/configs/socfpga_de10_standard_defconfig<br>
&gt; @@ -70,3 +70,8 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy<br>
&gt;=C2=A0 =C2=A0CONFIG_USB_GADGET_DOWNLOAD=3Dy<br>
&gt;=C2=A0 =C2=A0# CONFIG_SPL_WDT is not set<br>
&gt;=C2=A0 =C2=A0CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy<br>
&gt; +<br>
&gt; +# SPL Fails to load UBOOT without these!<br>
&gt; +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy<br>
&gt; +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2<br>
&gt; +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200<br>
<br>
What does get configured in the .config during OE build without these <br>
options ?<br>
<br>
For example SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE is already set to <br>
0xa2 in arch/arm/mach-socfpga/Kconfig , so that shouldn&#39;t be part of <b=
r>
this patch.<br>
</blockquote></div>

--0000000000004f6bfb065e418578--
