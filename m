Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C12AD3A66D
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35558918A;
	Tue, 29 Oct 2024 16:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A530yjdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E565188D29; Tue, 29 Oct 2024 16:45:39 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFC989187
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so744299966b.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216737; x=1730821537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5XGemX7W11ZQ+Gl3UrcKumYRCE12oEK1g1TETsKxPNE=;
 b=A530yjdOexhjcVQqhwe/wPu3DD6i/RMLPFgEXh50zPwmsnN8TLVfeTZiPno2QyzfQb
 BKF+jmykNE7++Rx8nlbUj32N3Z04aNdEnSqBXD1odFlTy7TWgZPUbC0Z1ct9azSo/TdK
 qGh9juwoyc6p/bNwnyAr7ZDMjiiAK6dRlIYY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216737; x=1730821537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5XGemX7W11ZQ+Gl3UrcKumYRCE12oEK1g1TETsKxPNE=;
 b=ssz4nhAZ2XGufKr904d6/rJC3ZUMTJKZbASCEc9jDfkMD5wBhWLVjr9RzsCg5o5k+G
 wW9Qa+E9hLjUj1696BFCUZG1DIgiGqFB+Eljq4xG2Fl1/BAOCO1WxwCxWD2mZ6yWqjbH
 h14en7cTsvBBnj9Ir06UP1LCXtsbfyVH8cHllKG2sO9ZUgAhOn4uPvx3VjcI/jv0Whk1
 AO5S81gWphj6mNFm4odj1Uw7pBf5ho/3h0NYOqYsQ4fIaWgCptktwOTXIr0kge/lGwWI
 CSLZLkLbs26VACsHePCpgq22l8o/9jDGYhIePzVhDBo2Rs9ym1q+n8GV6d81LppA/frE
 ixaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhsfvKnOIWorRDzrSYK1DWkPjiqQTi4ljQKGTaii3S3v7A85FrF3bvMm0c8juSCpWKw+BMJyw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxv+syKDlztL+n9NdwmUzOkWccaT8+ogeW7qncBkdyjY0tffnh
 BjSp6UmNacFvAmn34MEPppZCgxLa4KDLLDVdeXyjCpOs1+sEX5NsaO9S6uEhAd8se0rMHeG0qxZ
 4T5BtMpXrBlt/raco4sve5AUOgnWUkBvRXFXQ
X-Google-Smtp-Source: AGHT+IF/yBClYeXNaioPwbbuF4aWE12Qyt8FUJRTYSlhRBwWWbypn033xCXcJCcUnBpR4SK2bOtYAXPkzjruC8unQkc=
X-Received: by 2002:a17:906:7315:b0:a99:33db:2035 with SMTP id
 a640c23a62f3a-a9de5f056d8mr1024324366b.26.1730216737013; Tue, 29 Oct 2024
 08:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
 <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241021073749.63-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20241021073749.63-2-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:45:25 +0100
Message-ID: <CAFLszTiVrdqvixoKH4nhTadcVOFo0TJ9kFTjDish3ZBuh-YgGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: expand test coverage to nxp_imx8mcst
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

On Mon, 21 Oct 2024 at 09:38, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> Add coverage for IMX8M code siging. Create PKI tree and other assets
> required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> `cst_3.4.1' [1].
>
> [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> ---
> Changes for v2:
> - Added missing *.pem files
> - Rebased on top of "[PATCH v4 2/2] binman: add fast authentication
>   method for i.MX8M signing"
> - Included a test for fast authentication
> Changes for v3:
> - Fixed relative path for SRK table and *.pem files in
>   341_nxp_imx8mcst.dts
>
>  tools/binman/ftest.py                         |  11 ++
>  tools/binman/test/340_nxp_imx8mcst.dts        |  58 +++++++++
>  .../test/341_nxp_imx8mcst_fast_auth.dts       |  18 +++
>  .../CSF1_1_sha256_4096_65537_v3_usr_crt.pem   | 121 ++++++++++++++++++
>  .../IMG1_1_sha256_4096_65537_v3_usr_crt.pem   | 121 ++++++++++++++++++
>  .../SRK1_sha256_4096_65537_v3_usr_crt.pem     | 121 ++++++++++++++++++
>  tools/binman/test/cst/crts/SRK_table.bin      | Bin 0 -> 531 bytes
>  .../test/cst/crts/SRK_table_fast_auth.bin     | Bin 0 -> 531 bytes
>  .../CSF1_1_sha256_4096_65537_v3_usr_key.pem   |  54 ++++++++
>  .../IMG1_1_sha256_4096_65537_v3_usr_key.pem   |  54 ++++++++
>  .../SRK1_sha256_4096_65537_v3_usr_key.pem     |  54 ++++++++
>  tools/binman/test/cst/keys/key_pass.txt       |   2 +
>  12 files changed, 614 insertions(+)
>  create mode 100644 tools/binman/test/340_nxp_imx8mcst.dts
>  create mode 100644 tools/binman/test/341_nxp_imx8mcst_fast_auth.dts
>  create mode 100644 tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
>  create mode 100644 tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
>  create mode 100644 tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem
>  create mode 100644 tools/binman/test/cst/crts/SRK_table.bin
>  create mode 100644 tools/binman/test/cst/crts/SRK_table_fast_auth.bin
>  create mode 100644 tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem
>  create mode 100644 tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem
>  create mode 100644 tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem
>  create mode 100644 tools/binman/test/cst/keys/key_pass.txt

I am still seeing some sort of problem here:

======================================================================
ERROR: testNxpImx8mCst (binman.ftest.TestFunctional.testNxpImx8mCst)
Test that binman can sign an iMX8M image
----------------------------------------------------------------------
ValueError: Filename 'cst/crts/SRK_table.bin' not found in input path
(/tmp/binmant.tryjm0q0) (cwd='/home/sglass/files.local/u-boot')

======================================================================
ERROR: testNxpImx8mCstFastAuth
(binman.ftest.TestFunctional.testNxpImx8mCstFastAuth)
Test that binman can sign an iMX8M image using fast authentication
----------------------------------------------------------------------
ValueError: Filename 'cst/crts/SRK_table_fast_auth.bin' not found in
input path (/tmp/binmant.tryjm0q0)
(cwd='/home/sglass/files.local/u-boot')


but it could be because I had trouble applying it:

 git am ~/Downloads/v3-1-2-binman-nxp_imx8mcst-read-certificates-from-input-path.patch
Applying: binman: nxp_imx8mcst: read certificates from input path
Applying: binman: expand test coverage to nxp_imx8mcst
.git/rebase-apply/patch:210: trailing whitespace.
            X509v3 Basic Constraints:
.git/rebase-apply/patch:212: trailing whitespace.
            Netscape Comment:
.git/rebase-apply/patch:214: trailing whitespace.
            X509v3 Subject Key Identifier:
.git/rebase-apply/patch:216: trailing whitespace.
            X509v3 Authority Key Identifier:
.git/rebase-apply/patch:337: trailing whitespace.
            X509v3 Basic Constraints:
error: patch failed: tools/binman/ftest.py:7804
error: tools/binman/ftest.py: patch does not apply
Patch failed at 0002 binman: expand test coverage to nxp_imx8mcst
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
sglass@okaro:~/u$ pm
patching file tools/binman/ftest.py
Hunk #2 merged at 7906-7912.
patching file tools/binman/test/340_nxp_imx8mcst.dts
patching file tools/binman/test/341_nxp_imx8mcst_fast_auth.dts
patching file tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
patching file tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
patching file tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem
File tools/binman/test/cst/crts/SRK_table.bin: git binary diffs are
not supported.
File tools/binman/test/cst/crts/SRK_table_fast_auth.bin: git binary
diffs are not supported.
patching file tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem
patching file tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem
patching file tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem
patching file tools/binman/test/cst/keys/key_pass.txt

Could you please rebase on -master and resend?


Regards,
Simon
