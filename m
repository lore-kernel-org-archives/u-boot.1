Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B598D18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E2E88D51;
	Mon, 14 Oct 2024 23:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DQjGEEj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576F8891E9; Mon, 14 Oct 2024 23:07:12 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EEE088D51
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd1a4217dso50356946d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728940026; x=1729544826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kNvO090YGh/yMcuaQlw9jFkhFsr85CchvIcnlKlOdl0=;
 b=DQjGEEj9HjCXDrLUcM0clcA0kdeDxxB4bQjrqiaWq+5JS09X6Kn+LtKrfZwL+Kiljd
 0lFwL0JB9kJCgjWBK46dRIZGa+fDYiONZSuUOg2ewIRarFcfihKUkmRRsiBpm9ynFP+C
 9Nl/lPQ3zvQ9KSNTsM8enEcSEID2N081RAJbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728940026; x=1729544826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNvO090YGh/yMcuaQlw9jFkhFsr85CchvIcnlKlOdl0=;
 b=jdNvJSdbp/iJoYrU65lamuabL323wJa5SXJ2ct+Q57e/oTWc7Tp0nPC0BbMBPp9q0K
 I6v9/Ho5OJZ+crZkwQyspJ05cYEzDXX3jx1EKbC47wwI5ZaXd2B0wWsja9L7jZSq2Edh
 wC7QsUA0JiqmNz2zco9UR9akZwRBN0BTf+1HX1TGy4Z7TzT7k84C4cb4kyzEuOTvqrlf
 cqj3c04WrRFnP15dJo9Ye475iuAuxtSXT/7P9lN/G+Vubbcj5MnlquioSR/dhWxznxly
 ucV/iZVh21BzKI1Kni8Dsx1IK1DNijLgVvN1jdNzFFV6G3J2K+o2XKfs9kjzwPoDCtgL
 ow2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ZUoKJtmMz4MKPCtMu+XbW/4l5UmL2bne0BcL0iw4ezP2kiHMMFZt3QZdzrWUnkI0pB1jzN0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1A6kQu7+G9CMBWp0piPBzPMkrFx618YmWpcAhKQ4GXRSOwmVX
 PqYstOo5VCSK7FFkqLz2KkNPqeTWLes13JyD+qSVhBiZ+uixjr0grPB6IN6fuFKAeNHKxYC5Ndv
 +4Bab+3xGG0/yT1LPtKsYqidlAKyzUfsDtTXX
X-Google-Smtp-Source: AGHT+IHXep4g+YdUP7fWYZgne8JlZ3lqGgIUFMm6+Eid5B46263/+5GB4DXGWfk+qxBgjwHvW+2sq3BOoQegxBoWxbo=
X-Received: by 2002:a05:6214:5884:b0:6cb:e662:c59a with SMTP id
 6a1803df08f44-6cbf9cb325emr128603616d6.11.1728940026224; Mon, 14 Oct 2024
 14:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
 <20241010112451.27242-1-brian.ruley@gehealthcare.com>
 <20241010112451.27242-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20241010112451.27242-2-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:06:55 -0600
Message-ID: <CAFLszTg3RWyx_Z6waYaBkJMRKCQnv_cQr6xaMF3v9s_R3bKmYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binman: expand test coverage to nxp_imx8mcst
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

On Thu, 10 Oct 2024 at 05:25, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
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
>

Thanks for doing this! When I run it I get:

inman test testNxpImx8mCstFastAuth
======================== Running binman tests ========================
E
======================================================================
ERROR: binman.ftest.TestFunctional.testNxpImx8mCstFastAuth
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8mCstFastAuth
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call last):
ValueError: Error -11 running 'cst -i
/tmp/binman.lk6cfgwh/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.lk6cfgwh/nxp.csf-output-blob.nxp-imx8mcst':


----------------------------------------------------------------------
Ran 1 test in 0.198s

FAILED (errors=1)

Another test fails too. Do you know why I see this and you don't?

Regards,
SImon
