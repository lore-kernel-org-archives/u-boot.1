Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ACDC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D286D8490A;
	Mon,  6 Jul 2026 14:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSlKFN8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B741846B4; Mon,  6 Jul 2026 14:27:19 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689E08490A
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so3938100a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 05:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783340836; cv=none;
 d=google.com; s=arc-20260327;
 b=QlQOao4nC0SZTmLpfVJHu5cwp05QI49eCEyg3RUSAoFep1kLJ9v8PFMHKgdDpMVHDZ
 P28u1xMdUoR8W+WmNbmFCwKcPATfwtb0e51jZeDnriiuhcPEThgPVxUurweLEwkSlS7W
 Q197rFEMY3lCAoTZLBkbN8/bJXEb6cgkhA8DgtP7IICHEqepnsCDPLqxA01W64BrxGAk
 WAWbGiHuiO0kqavVGxhCYmHRjZ9ItnpiVBOY2XsRWhZnlM++clMBxLhUoQ4Soh7CcWjU
 l1s5G2RFRfBKPODQKrqv52ODnbNC0IeBhwI71pu90RVZjFAO96NLUvjBB5TzpDVvy7j/
 xvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2R1zUIyc2xAMcUJIFRM3YMSmuu1Xg6ukCxY75fKlj1o=;
 fh=BBkPPhS6yNVujfuYcdwFmqALKmgMIFNvtiHTib2aCyY=;
 b=RMB/+yaGloT7wffEYuDqXZnAhuN4YHg3uJTBMOaPMi2tBslMOUMXaFyZ2VGEBESwiD
 cTAyUI61o6pIGgMzoqIhXpzl8N0pysT5p/vc1WB1GZPCiLhA4/2/9fTbT4u6W4YG0Wzy
 okCtDQH1Y+xTHO7tXLWXWV8dsWytF9a5XkivAe2LRozsmNIiUs4GG9EqDMztU/j6Y8Ig
 kZehmD1EhdFUD7x+Q/7BxLYXa17JfyEsI6OEbWYYxbw+4nv8nJ5OZprVxtxZf//77ZBg
 I4jnjZL53yamTiLeyQjOqv4as5BDkrE6eYQIbzwUj3e12lFoJre2vBfMBc9sT80DKeU7
 NB5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783340836; x=1783945636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2R1zUIyc2xAMcUJIFRM3YMSmuu1Xg6ukCxY75fKlj1o=;
 b=KSlKFN8jko9XKqa/wEJQSGLQjw/bmsNrn+mvyeZegTsOct2c839PX/2sozXDyn3mYN
 90PteRS4WR8pHhgvjvK5+6MlHTmmwfPJtFYl2MRMXykPVOeYLTdd3etbtmAK7abyphSf
 ii58PH+eDimXqbTGaMianVu+pzKde7bfHYK9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340836; x=1783945636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R1zUIyc2xAMcUJIFRM3YMSmuu1Xg6ukCxY75fKlj1o=;
 b=EC93UeNg/x3+w2/7YL1mXKc1z3DK7KT+WZTN5HjGVR57Y6SuLCD1qroCX7pq9RCqZZ
 VGv3gNF8BQrjPTGzQaNDjMCDVFD2el/Ldkm1nejj9Xq1i+d9Xu1oACjWr6b0MLhWDCOI
 h92uXiFaGcHgmhvQ+Z0mpEJAuO9YOkTQs+lpT9u8B2xwNP3tvB8IMm99afK9aNS6efyN
 G8brND9JNshwRgIEHxsihx3u/SC3UL9jLDWPmjD9C5DJ6n1FhdZwsckD66waJ3cCRKkC
 RRYlWayR021wMGbYfrTKWBSWlXiRA1jZeTgEW6HCXfN3YVdeQhfAsWjuoGK/B3OKw1wJ
 agBA==
X-Gm-Message-State: AOJu0YxZ679EvWfCPQOPtUZDEmv/2WhvHIYW/Q71ykToaE7dFzBOlGMQ
 pdB5LUoEbt8CRnUWDzZoQfrTFiUA8ynuAr8nBSShQHDmkNNvo+0s4RWjEpj+TCzwW4tI7+wF2z1
 w44rqtuNyD3R4b4JU3NmaJgEfZx+DncDv6NSbfKTY
X-Gm-Gg: AfdE7cnIa0GA0ouFaeYiyiYV5q8FkdGYg7RnbSndNBwUXEgJXCzvz0nzZbfaQn0unDr
 qEt7oTrS/UZot9OJZdclvDVozaz1aqLbISoIKMGuuFlpNqTP0oSLRcjz202MRVOqWs/775I/bOr
 +DZs1Gqr107AC6DVQvicl9ArNcBgJfAur7veeNAzXgmSdQwQydeMqBpNf9ypV7hpf13AMVVa7wb
 VT/VhvzY2ufdlQD++cgm/ECBTYzmNBfj4SvAK3P1/FOy2t2Ez1yzTDch5tNmLFkRNZzPsc=
X-Received: by 2002:a05:6402:202b:b0:691:b5aa:5a66 with SMTP id
 4fb4d7f45d1cf-69a85b9b462mr192546a12.16.1783340835769; Mon, 06 Jul 2026
 05:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260630084112.13259-1-marex@nabladev.com>
 <CAFLszTgCOOOxhgP3n7EXGK4eMWNmmiFyCtc6mKNGmCinRYZdDA@mail.gmail.com>
 <b087280e-ae59-4852-8212-72866fa46584@nabladev.com>
In-Reply-To: <b087280e-ae59-4852-8212-72866fa46584@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jul 2026 06:27:03 -0600
X-Gm-Features: AVVi8CeWBVyvB4pZDnr7qxaThwaHTxXM-3FaGfy-wORrDLYLJOwm8d202JQQ05M
Message-ID: <CAFLszTg569u5Kj5Bnrs4Xce8DQNiR+TMhgUnN2RmZgyPm4ETLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Marek,

On Sun, 5 Jul 2026 at 15:26, Marek Vasut <marex@nabladev.com> wrote:
>
> On 7/2/26 1:13 PM, Simon Glass wrote:
>
> [...]
>
> >> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> >> @@ -59,10 +98,52 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
> >> +                # 0x80 ... lookupTable
> >> +                spidata += struct.pack('<I', 0x0818040b)
> >> +                spidata += struct.pack('<I', 0x24043008)
> >
> > Just to check, this LUT is a single-pad fast-read sequence, so should
> > we mention the fixed read command? E.g. if a board uses quad pads,
> > what will happen.
>
> Can you please rephrase this question ? I cannot make any sense of it.

I was trying to figure out what the magic numbers meant.

https://community.nxp.com/t5/i-MX-RT-Crossover-MCUs/How-do-I-properly-define-a-flexspi-LUT-entry/m-p/1016543

So I think you have:

FLEXSPI_LUT_SEQ(CMD_SDR,   FLEXSPI_1PAD, 0x0B, RADDR_SDR, FLEXSPI_1PAD, 0x18),
FLEXSPI_LUT_SEQ(DUMMY_SDR, FLEXSPI_1PAD, 0x08, READ_SDR,  FLEXSPI_1PAD, 0x04),

so always using a single pad. But you have the nxp,fspi-flashpadtype
property which sems to allow you to select that value, or at least
that is my reading of it. So my point was that people might think they
can change the pad setting using nxp,fspi-flashpadtype but it won't
actually work. Perhaps just a comment would help?

>
> [...]
>
> >> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> >> @@ -8101,17 +8101,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >> +        self._DoTestFile('vendor/nxp_imx8m_fspi.dts')
> >> +        self._DoTestFile('vendor/nxp_imx8m_fspi_pass.dts')
> >
> > Since binman now generates the header itself, please can you check the
> > output data in the test, e.g. verify the tag at offset 0 and that the
> > mkimage data starts at 0x1000? That would have caught the padding
> > problem above. Also please use assertIn() on str(e.exception) for each
> > failure case, so the test confirms the expected error rather than any
> > ValueError.
> Sure, if you can provide actual comprehensible example, I can add that.
>
> In the meantime, I skipped this and sent a V4.

For checking the error, see testNxpImx8mCSTFastAuth():

        with terminal.capture() as (_, stderr):
            self._DoTestFile('vendor/nxp_imx8_csf_fast_auth.dts',
                             force_missing_bintools='cst')
        err = stderr.getvalue()
        self.assertRegex(err, "Image 'image'.*missing bintools.*: cst")

For reading the file, if you call _DoReadFile() instead of
_DoTestFile() it returns the output image, so you can then disect it
as you wish. As it is your test checks that the code is exercised, but
not as much about what output is produced.

Regards,
Simon
