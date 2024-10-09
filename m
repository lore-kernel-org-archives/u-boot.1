Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8B2CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DB2890D9;
	Wed,  9 Oct 2024 03:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EWzaJcPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15146890DA; Wed,  9 Oct 2024 03:55:44 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F6789017
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71def715ebdso3104830b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438938; x=1729043738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aGDawDTk3FRyp0+xN5V9DS9UMt3QXW0jFt5A1qhOstQ=;
 b=EWzaJcPy39opAaTUNrbI4hML5QbBIlpKMQ4YUTQal7iR3KeNAHwH9UkxCLXiVQ1la7
 U1kM2Aikn/7tzahbDydyfH3sfYrtpyr+B+693bv2XO+RXLbTR3n90ZdEYyGznJXJfYr1
 13DdfG3SIRLYV+A7p2SzKSZpxDRtBv0QVNM5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438938; x=1729043738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGDawDTk3FRyp0+xN5V9DS9UMt3QXW0jFt5A1qhOstQ=;
 b=oJr3BFjXbeOkQC0v7Ox+/TSps46GuMfDB56tcq6shaowKS6eY5bdksRFUCCvroPEYt
 P1e8mQEKPbKVpVVrbUVjm9pvP/hwHa/Nchu3rgulrpeyI04UeShzaJEXNksj2alcMGEp
 sIRwNf9rzYDYHSGMMcRQqbcEfaYG6G6OX1k2PctL2xa+9Z8DukKAGLP8aXvta5bXGSuv
 BEgjNHMYS5cQl5E3Okq1x6wlPLGQEJDtcAKrOJFCmuT+zgNPF+2ekoYnuwmuMv9o8Pwp
 +3+eHixNXVzK3M4hbwurtx5laYVORyHmCmFdZSUCTBX5oKMzSL/eWqqDxDg+4yUKZtsH
 8ojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF8ixNz9Nsqb0y27YwGGCFAEcaDPNy2u9hfvMyVWXvH8FxqCD4IgV2z7lo1CHeoFXZzQnpodU=@lists.denx.de
X-Gm-Message-State: AOJu0YyJiL11W0uTLnI6PRMxvLMJug4/4BEJeG4lvqS7QTcrbyqeEwWw
 V9qE+JCNsz79vDdAGjjAIVvYPb5wXm9isq1rxknBKrZ2o9FLsAyuaD/G3Z+Fn78BuQnK7Hsj9q7
 FbrHyPT8kcQo5MGya4hqbc+OF9QJha1InAu5tKhVNQ6fmfAwrOw==
X-Google-Smtp-Source: AGHT+IH+VmJGLSivg4ezaAPoZLElEDqrdNxhCzvcF3rXG8i+Pmi74s4ZwjbI9fzrfpBKxmpsjq+sMMCLYgf+Uui2lPg=
X-Received: by 2002:a05:6a21:2d89:b0:1d6:e673:9bf6 with SMTP id
 adf61e73a8af0-1d8a3be3701mr1852880637.10.1728438938495; Tue, 08 Oct 2024
 18:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
In-Reply-To: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:26 -0600
Message-ID: <CAFLszTj26G9WatN_fmksAkT4wiZfQ=sAnT8Ny5bZAfc55eYgCw@mail.gmail.com>
Subject: Re: [PATCH] WIP: binman: expand test coverage to nxpimx8mcst
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 ian.ray@gehealthcare.com, u-boot@lists.denx.de
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

Hi Brian,

On Mon, 7 Oct 2024 at 07:02, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> Add coverage for IMX8M code siging. Create PKI tree and other assets
> required by `cst' using `hab4_pki_tree.sh' script in `cst_3.4.1' [1].
>
> [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> ---
>  tools/binman/ftest.py                   |  4 ++
>  tools/binman/test/336_nxp_imx8mcst.dts  | 58 +++++++++++++++++++++++++
>  tools/binman/test/cst/keys/key_pass.txt |  2 +
>  3 files changed, 64 insertions(+)
>  create mode 100644 tools/binman/test/336_nxp_imx8mcst.dts
>  create mode 100644 tools/binman/test/cst/keys/key_pass.txt
>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 93f3d22cf5..f1c052a7f8 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7690,6 +7690,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>              # Make sure the other node is gone
>              self.assertIsNone(dtb.GetNode('/node/other-node'))
>
> +    def testNxpImx8mCst(self):
> +        """Test that binman can sign an iMX8M image"""
> +        self._DoTestFile('336_nxp_imx8mcst.dts')
> +
>
>  if __name__ == "__main__":
>      unittest.main()
> diff --git a/tools/binman/test/336_nxp_imx8mcst.dts b/tools/binman/test/336_nxp_imx8mcst.dts
> new file mode 100644
> index 0000000000..6cfefdae2a
> --- /dev/null
> +++ b/tools/binman/test/336_nxp_imx8mcst.dts
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       binman {
> +               nxp-imx8mcst {
> +                       args;   /* Needed by mkimage etype superclass */
> +                       filename = "test-fit.signed.bin";
> +                       nxp,loader-address = <0x10>;
> +            nxp,srk-table = "tools/binman/test/cst/crts/SRK_table.bin";
> +            nxp,img-crt = "tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem";
> +            nxp,csf-crt = "tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem";

Please can you check the indentation?

I don't see the .pem files in your patch?

Also we should really tidy up the etype so that it can read keys from
the input path, or perhaps use an entryarg to point to the file.
Having paths in the image description is not ideal.

> +
> +            fit {
> +                description = "test desc";
> +                           filename = "test-fit.itb";
> +                #address-cells = <1>;
> +
> +                images {
> +                    u-boot {
> +                        description = "test u-boot";
> +                        type = "standalone";
> +                        arch = "arm64";
> +                        os = "u-boot";
> +                        compression = "none";
> +                        load = <00000000>;
> +                        entry = <00000000>;
> +
> +                        u-boot-nodtb {
> +                        };
> +                    };
> +
> +                    fdt-1 {
> +                        description = "test fdt";
> +                        type = "flat_dt";
> +                        compression = "none";
> +
> +                        u-boot-dtb {
> +                        };
> +                    };
> +                };
> +
> +                configurations {
> +                    default = "config-1";
> +                    config-1 {
> +                        description = "test config";
> +                        fdt = "fdt-1";
> +                        firmware = "u-boot";
> +                    };
> +                };
> +            };
> +        };
> +       };
> +};
> diff --git a/tools/binman/test/cst/keys/key_pass.txt b/tools/binman/test/cst/keys/key_pass.txt
> new file mode 100644
> index 0000000000..dec2cbe1fa
> --- /dev/null
> +++ b/tools/binman/test/cst/keys/key_pass.txt
> @@ -0,0 +1,2 @@
> +test
> +test
> --
> 2.39.5
>

Regards,
Simon
