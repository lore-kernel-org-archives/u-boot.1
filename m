Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719F8CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE70D846B4;
	Sat, 30 May 2026 00:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fuqfYCQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E0D846FD; Sat, 30 May 2026 00:03:59 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78EE1846A3
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-beab79b0978so42969566b.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780092237; cv=none;
 d=google.com; s=arc-20240605;
 b=EQ+2eV6fPvZA48trkKQRZpGDx23QHwbKivAjTFHTkFrAiMd/xyIz7QXqtLcELC3LF+
 n/doAZpiUEULkqnC9ZBLT0LrHQqO70JYLglk9t95U44IDkWxdr6lYL7Jx9BoGWw+yjo8
 NkvUI4poKMonb5lJZ2RPTY4MDfbi4kW+MzJEkNy5dusqIanDM/pAMQIkw9TTSc6+IDuw
 6OlapjPKDWPARaBUFqwIGipohk8Ga92BcbI51hekixZr82q29CNKv28cfQ7KqDHzxvpO
 42O30OXInbHZVbkCOIC6O4zeCKTWnEzKPtRKhoJ4clpIxabtJ5CT7Zf90NqaaMYuJ1D+
 c11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nnYzP3lUrbsjFsBFnk2T2EN0E0FsncPeYrNr6VHZYWQ=;
 fh=3vbYSVaifU3E5yjV41YkOEuRcfdK8Bup9NZXioA8VLI=;
 b=IjNCRid0q2wdVoZnH0t4vLNyGFMh+KgR6L4OOVRTCz7BTbx1si8RbYOmGFq3lo3YAX
 ZH+maVuavm+gaDvJP5z2uecJaS10c2ZF00FfFV9Rc9ghSMd8O3j0Oqcx8oOEuxTEtClr
 XiIMleXpbogWsts3/OzLLmQYJQSGr7j6YsAZ6vSbcCPhlX23Ap5Y+wIoJulCv1Caqxoy
 7DJcwDLB5MPy24N3Xssh+P4dYWAqC3d2zj4rg7DsKWvFkO5o/kC176iiI2iqLu/QfMLh
 MXY91PPWpflw3Nx7oSFbHpngAaY6iXhuSvIPQNq5OmgDe419xTq5t+qW5+AQq6esYAuM
 v2bw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780092237; x=1780697037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nnYzP3lUrbsjFsBFnk2T2EN0E0FsncPeYrNr6VHZYWQ=;
 b=fuqfYCQnDAQGTusDjADdMB1Vzr5s1cA3mAPY9is9Lo63ngXG7c63K7UYk2Mm+a7Rkv
 tlKZV9FTPOY8+xqzsek554nOjgmRFup+rPnpL2xkR5X4CWd3sDrhDyww0wSn1RJnfuCa
 LXezhwWyTG/ZmJvkZsM2DNCUcraAjix906T98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780092237; x=1780697037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nnYzP3lUrbsjFsBFnk2T2EN0E0FsncPeYrNr6VHZYWQ=;
 b=JBbqJxY0b6nXPQAoz8zKUZiZ3I1WLYT2twOD1L9EgbXVTMnGDPk2yghAkaN4iNT/pG
 Yg2zqwoci2Zbl8oNTRWhmjBqzqZDS8C1fUt0DseZf2b2UxOwgW2UNZ42kdULRWjgTNlf
 5w/5w3jCkVGB7n44RNiAFRB6/G2LeqzzwctNQc6ZwtSDnHEHwAi2IxfsUJ18Neq3Xj4y
 CDUjd8Hpj80HLKNZS5kKyCVVCh5AjQOPwPtfKhlzpORs1hiwXELEARzVP1A9myraLOOQ
 FeI56bE4mqwNP6v4edNdrZfUYlZK2Sd/I2axRY3qoyZ0GH8MCZfAfBoRgKwRhOQW9/ue
 OMUA==
X-Gm-Message-State: AOJu0YzB+lTdPOyB/+8TURQYfa5qdXqsVD6H1+htjElar5McyAV1btFb
 2aUjmtYCNk8/SRp+rPaTI4Hdxi8p9EZFNXWt2XZ1H7wJEZfDFSrPCBJ+21sq6mEam0RcJfaMBfl
 ohpBYhXcFPdyJZ59B5rIZJVyjMeS/E+0AGIjNs1Yf
X-Gm-Gg: Acq92OHzhCyD3tgXZGuxVnFT7auRJkvovzp4jeA29V0XJIF+smdS6/r/aRPAdnC5pch
 x8vHy75sb+ngPmkajN0AnQM7Mrt1KPfEd21mOGfaThXqE5V1suqv/PYNgR/yAvsVDih1eEv08HZ
 2C9V5h4jwZUV7iFSUHxbe+j7z8fuVByfBS5Ms4aBLR2J7JAYiaEqE1IxgCFSTlTNZQaU0dVF4U8
 6KFz8Vnw9ekHiOnsmwHDEuOk82o5FbfdEwbUOiDPKDDKCop19dr8WRJU5frFUkiNz75E/6l/y7U
 uvKc3dlRcWdzks0OAPI=
X-Received: by 2002:a17:907:9729:b0:be1:4955:a0c9 with SMTP id
 a640c23a62f3a-be9a78d1734mr271217166b.21.1780092236833; Fri, 29 May 2026
 15:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260525235155.96167-1-marex@nabladev.com>
In-Reply-To: <20260525235155.96167-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 17:03:43 -0500
X-Gm-Features: AVHnY4L97Ht7wnqfxZL4eAb1dnfK16-AhCxei0fUbF_m0wzpM8GXApV9GzDKjQk
Message-ID: <CAFLszTht55rS-LOCoMLBQ2wO=w-w95EGFUY3vD4vr3HvZPFuWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: imx8mimage: Handle nxp,boot-from = "fspi"
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On 2026-05-25T23:51:02, Marek Vasut <marex@nabladev.com> wrote:
> binman: imx8mimage: Handle nxp,boot-from = 'fspi'
>
> Boot from FSPI requires additional 448 Byte long header, with U-Boot SPL
> starting at offset 0x1000. Currently, both i.MX8MM and i.MX8MN attempt
> to generate this header using fspi_conf_block with filename pointing at
> CONFIG_FSPI_CONF_FILE file. This does not work, for two reasons.
>
> First, the CONFIG_FSPI_CONF_FILE is generated by mkimage -T imx8mimage
> and may not be available yet when the fspi_conf_block is evaluated. That
> leads to a race condition where highly parallel builds fail to find the
> CONFIG_FSPI_CONF_FILE, which is usually called fspi_header.bin, on first
> build attempt.
>
> Second, binman gets confused and patches incorrect offset of DDR PHY
> firmware blobs into U-Boot SPL, the offset is incremented by exactly
> 0x1000 which is the size of fspi_conf_block.
>
> Fix both problems at once, make imx8mimage handle the generated FSPI
> header and prepend it in front of the imx8mimage processed data. This
> way, the race condition is solved, because the data generated by the
> [...]
>
> tools/binman/etype/nxp_imx8mimage.py        | 11 ++++++++++-
>  tools/binman/ftest.py                       |  9 +++++++++
>  tools/binman/test/vendor/nxp_imx8m_fspi.dts | 18 ++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -33,6 +35,7 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>      def ReadNode(self):
>          super().ReadNode()
>          self.boot_from = fdt_util.GetString(self._node, 'nxp,boot-from')
> +        self.fspi_header = fdt_util.GetString(self._node, 'nxp,fspi-header-filename')
>          self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
>          self.rom_version = fdt_util.GetInt(self._node, 'nxp,rom-version')

Please update the class docstring to document
nxp,fspi-header-filename: what it is, that it only applies when
nxp,boot-from = 'fspi', and that the file is read relative to the
binman output directory. Binman has no separate entries.rst, so the
docstring is the documentation.

> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> @@ -52,7 +55,13 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>          if self.mkimage.run_cmd(*args) is not None:
> -            return tools.read_file(output_fname)
> +            outdata = tools.read_file(output_fname)
> +            if self.boot_from == 'fspi' and self.fspi_header:
> +                spidata = tools.read_file(os.path.join(tools.get_output_dir(), self.fspi_header))
> +                if len(spidata) < 0x1000:
> +                    spidata += tools.get_bytes(0, 0x1000 - len(spidata))
> +                outdata = spidata + outdata

What happens if the header file is larger than 0x1000? The current
code silently concatenates and shifts everything downstream - exactly
the offset bug the commit message says we are trying to avoid. Please
raise a clear error when len(spidata) > 0x1000.

Also, if boot_from == 'fspi' but nxp,fspi-header-filename is unset,
the code silently produces an image with no FSPI header. A debug log
line noting the header is being skipped would help later.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -8099,6 +8099,15 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testNxpImx8MFSPI(self):
> +        """Test that binman can produce an iMX8m FSPI image"""
> +        testdir = tempfile.mkdtemp(prefix='binman.')
> +        image_path = os.path.join(testdir, 'fspi_header.bin')
> +        with open(image_path, 'w') as f:
> +            f.write(bytes([0x87]).decode('latin1') * 448)
> +        with terminal.capture():
> +            self._DoTestFile('vendor/nxp_imx8m_fspi.dts', output_dir=testdir)

This only checks that binman does not crash. Please read back the
produced image and assert that the first 448 bytes are 0x87, that
bytes 0x1c0..0x1000 are zero, and that the mkimage output follows at
0x1000 - otherwise the regression we are guarding against would not be
caught.

Also, you should write files using tools.write_file() and and write
tools.get_bytes(0x87, 448) rather than the decode('latin1') trick.

Regards,
Simon
