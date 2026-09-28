Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCD3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4299F80D3C;
	Mon, 28 Sep 2026 15:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfiosJ-gVh56; Mon, 28 Sep 2026 15:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 33DBB80D29
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607603;
	b=CFaYSSnOzdrZqFuy/v8B1xkTgQpVD3LEcwSujW01hJ7btlUuhKaV4a7WryIpF20LCQPw
	 MwFv0fp8MFUD4zQkVONOQbQ16fD2IKZm0PIhgM+MDuHssiwHNbXw3H+VKnUF0qqU9Jlf2
	 II2PfpFVJXQ/tvubswngYM2shRQPiaZwCrl3wqPzkbDD/O2Od2X+4rlGuxEouWl40Czzy
	 jtB9LjvFMa0pYduF0pE4rcyAChDSYsBtcAZUM4ggWodRItCBliMjF/RVre7uNZ9a1QoJx
	 HDIC4ThYCxuINDrHllCUaO79PYHspXyniFNWF9NeO2iXFpGKEhI/XP/H7xQ3PI7gSEg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790607603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
	b=ASghIEyxfYtErYlncCoaanw/FzAFccuahRCVA9LBf/8ZhmIjPykTDb04HQH2LaAySVwQ
	 Ef2acjOcHpjleeL45GNCFmPpZT9kFtlmEk/MLoYomcREjcktBt+eeFfsktc27vTY4ewk1
	 6t1BI5afGSvu8igOuFuieIigE8rERElpvzisp1jkNoLyt6LKscczh/x9iRp6NoL4leFhD
	 GV28XfQY0ofa7Yc/wkFVEKuA6sE2ucUyKpeA4+05LQ5WHQcpHSEfajnn8mAqLEdPmR1yA
	 XjINZx2oONTbNeBphJrKGFtD/4c+BGJQfl0CPZDu/Zk1a1jZfOsJfRDe9JAAuxttdVg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fhXdwuIq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790607603;
	bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njCnhuY/Yf4ZqeelOmUxxHBlZTcyKdCIYbg8sPifpDa7oxrVGevplcbUwgYBhooXE
	 GItYLXYMdcqintF0ne/0XfgqeGH4IZBi2WMgeu2ny3Wyl7Eh4ItEh+ne6UEzpQ6Cms
	 ncnjaKKVCVigGEgDycyQXQixx1JspyQ8fASXY/ZZLFGdbxfzWXgDPJZ9DwZ8fxgLrO
	 HdOZsfnHx7fZlYoDfTgS/B9yowujQeZdLJcfY1JXatXFnL5Ef8VlxQY8HBa7IE0qkx
	 H6lokGhUaDnnpy9XaNxkG7eUg3HfPcgXF/akaGZW0DuvKvnIOk/AO+AdSDyHtJ2pyX
	 6C8Q27uZ/2rcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33DBB80D29;
	Mon, 28 Sep 2026 15:00:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 100C72B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9A6B80D29
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qhTAs8Nh_ls for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:00:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B03C080D05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607601;
 b=D23XzkrEpdQda/f/cIarZv2YEGe5aTLWpfDUQk9tuuhy8zs+zRgrn3ByaSBuehjohPn+
 bsvajV+Rsy+QnUz3f72KtybjT2g4R5SskC8CHtxDSRyOFJYKGv0vAy0R5Ln+QLKMLa7Jm
 sB4sTFzRDtu/FYBaTialXlAIC52emu/5gXVorIY7sguZWax2o+arEdDUnesBW5Z/RdPOC
 NnEjewpuvMgXRAEIfECKixOjfho1/l+XpCXEDrTDHlOX/N9RxJMhuP+7ef+KoKnkLCZz6
 bivkDPHspcVwM9oUTQwIFysTKIF3/0pLGhe5AYcUUoUOQ4PGANHvxrI86anfr2P3aDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607601;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
 b=IWopSobwcNx5CZQLeAxGgb31U/8DoT9DPzE+Z22r3IPAN1MhY7FXbpw8lmaAKTlvJ595
 N/oCC8im0UDhUqgTSMK4QCJ4E+lIu3l5v+ixnxTVI4SKKJlN7uCmL4KjIFr3WSR8HCFLa
 xm9MVsGGu6mvuueI7hNa/RoWEHltzrhnPGt7NZ+7LQ7Nlz7M+oqA/ejv+Gq9kZJcSbD4V
 woFJY1Hx6B0QHi7Ff5HQ6lrNvKlOrtnW6Cz/NKJ/ZCwJHNApE/sZQpz/1kP5J+GoUqdP/
 mz7bxWSvPCuJCplGmuRHaWc5KrdIhaY0rJProD7/wr4tl/mgYmo6spzhD8/j7166o6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fhXdwuIq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fhXdwuIq
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B03C080D05
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:59:59 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so4619411a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790607597; cv=none;
 d=google.com; s=arc-20260327;
 b=WL5btas0JYPlF16h+iNF+dKREYP+1w0nFYRrMcl9TVFER0IyuaiYxy2zMbGYNxNh0Y
 c8Pb23Pii0TSD17RKyQeRY8NpLRBooHt/H/TetWA3pU87pLQ5vkpROKlSz+stshH+22d
 DSdXVb4ZElT1kqAR1vmG0gqdlOQ6t8S8OMkUcHwoxmi/ll2kID2jPrPmaRd9Vpo69RZT
 pxTYWqgMu3gXfqqGiX+z0NmVxOwYllWJFsHbOqIoYYcSvsvbNsxOIT4MMWfSBWnB0bKD
 VOqRJu+JrFIB/BcPBiIUocPrJjb3TZSa3gsQrGxqkFIgsWCO67i7iKgUHl30WfaaIHEB
 Gawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=aFrO9w8MFsnGXKgyK0sqSbnNt5y6l2FVhNfTsqzK7cStejjcwpSMp1LsUWTzfUoyMp
 AmrkWtpM6QlfOEFgTp2Hu4jr6/EMpg3huOl8RUnLc4Z58IUBpzHsq9wd/Rkhqtunie1H
 9o1NSnB+KRjnm6OXOMK4KxMydWuhzxGthE09xeKoUtPw8ZqouPVdkxWRFHTYHy4qZih4
 tQhhcYd52A/LaWSxnfVOMwtTVeTdx4h48jUlwzatMGRFTzABtFF6piulueXFiUP9/IHj
 sqPgV8j/+kMxSYURBskHsJoW5kOUqWv9aKtW+gWeThrtRcZHRr4WHwntKQwY49tg8mFT
 7efg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790607597; x=1791212397;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
 b=fhXdwuIqUhOi28mXoE8Z9irhraBSQzBdnd11mGzv+UTcmpTzYaEkoJG8Jre+VT8f0J
 Bd0DSCWi/VbEHyhIGVA0Z5eJImYRnIO59Bt6bJeNCLDVDijQSzs3VTDjj1GXx9vmnTgQ
 EeVxmSRgXjOrKUzvLk1eBltA6XB2OHd1uc8zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607597; x=1791212397;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uky7MzEvNFK8+Vyk8MI3i8Ls/jc9w8lYI1zDvGMr5Cw=;
 b=Yh+xiglLOlq9RepOd/01OJsGWczsdxKSPJtpbXHcrMKYIySFVz71fGWZlUC7a5hJQo
 GyOmnEcnTeC76Xq8fCf1xsUjcQyukyqWE8vdLTov8K3iI9DUCa8vPvSaO+CXU6uZ7L2u
 pi2ayb2an07MG913ZQgv8WMl8ReDG7M49pqka6g0aI250O2h8B5Jarw+9dMsDGAKK/T/
 PhoThY5dylC650r0x5h6vVVX6WwEcB8CVnIxzpZKwJDZP4sF+zTess/StswFDXfgGtCh
 62cfzybDMkWSmBInrGt/sSQR7kZR8VM4m5yaWZj8YhFvh+Hw0ojIIstjWXzZkpY48Om4
 d9IQ==
X-Gm-Message-State: AFq9FYKjNNw3cJ9H0PWhZCdU1fD0me6mNCH3Gt5vUbICBP7dZ6PDnLcz
 d6ah/hitdO6sUvbNeNijHUPLSMDJkWG29L6UQUK4OIeiOkp13sCUSXWXXAG8eo+2YQdjVEiOtTe
 0b80GwvTC0ToixEvjq2jYx+gmSgE/9ADaOfPY0njtguNMezlfB2w=
X-Gm-Gg: AYBFou3SEiriVh6VRsqIzbFrt7lRJfQDkDSOkXidJ8HvVhFQE7o3nv2NXmldwVxiCCO
 nc3i3xjgcQaLGsc9WlbUaVedyg1HVSFAqtIQEsEDyopy9r9jMpOKKmWj1kvG6DIrPop7+rZPpX8
 Kh+XPJi4F10QCQx2v+jr9BwxMaatn532bxxX4oJaNNmrl5jl7veEE6N3k9i2Y7enX/q6cAt2mHF
 O8hpaFOmOfCZ12VLqH41x0qhXEPrYaWLW2PVk8bE7WEpyyyseeNerNkFzmwyZP0/p3+9M+ThUhT
 aGpewA2RTqjMwoDm0C74IOYPA3p/SGAzccDizuJARmosN9DibkrIiA==
X-Received: by 2002:a05:6402:2750:b0:6ac:5dfd:7e60 with SMTP id
 4fb4d7f45d1cf-6ac5dfd8294mr3937414a12.35.1790607597268; Mon, 28 Sep 2026
 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
 <20260917065545.1989088-4-lorenz@sigma-star.at>
In-Reply-To: <20260917065545.1989088-4-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:59:42 -0600
X-Gm-Features: AclHuK8hKjfAzEfvb1Sddtzd9pPIvgO6QAd9B5bvAiU5SQ5RJqAPH2tMOX7fqRk
Message-ID: <CAFLszTiKhq-ir7rA-+3By98YPWpTUqSV-YS9pzqzepDqgRY2sw@mail.gmail.com>
Subject: Re: [PATCH 3/3] binman: pre-load: Test signing with an OpenSSL engine
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
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

Hi Lorenz,

On 2026-09-17T06:55:42, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Test signing with an OpenSSL engine
>
> Add a test that signs a pre-load header through the pkcs11 engine, with a
> key imported into SoftHSM, like the existing FIT signature tests. It is
> skipped when softhsm2-util is not installed.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
> tools/binman/ftest.py                              | 79 ++++++++++++++++++++++
>  .../test/security/pre_load_engine_pkcs11.dts       | 24 +++++++
>  .../test/security/pre_load_engine_pkcs11_pss.dts   | 24 +++++++
>  3 files changed, 127 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5937,6 +5937,85 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def _SetupPreLoadEngine(self, prefix):
> +        """Set up a SoftHSM token holding the key used by the engine tests

...
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        try:
> +            tools.run('openssl', 'engine', 'dynamic', '-c', 'pkcs11')
> +        except ValueError:
> +            self.skipTest('PKCS11 engine setup not functional, '
> +                          'did you install libengine-pkcs11-openssl?')
> +
> +        data = tools.read_file(self.TestFile('fit/softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +
> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')

You could use tools.write_file() here if you like

> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf}):
> +            softhsm2_util.run_cmd('--init-token', '--free', '--label',
> +                                  'U-Boot token', '--pin', '1111',
> +                                  '--so-pin', '222222')
> +            softhsm2_util.run_cmd('--import', self.TestFile('dev.key'),
> +                                  '--token', 'U-Boot token', '--label',
> +                                  'test_key', '--id', '999999', '--pin', '1111')

Nearly identical to the SoftHSM setup open-coded in
testFitSignPKCS11Simple() and testFitSignPKCS11Object() (and the CI
capsule tests). Please can you factor this out to a shared
_SetupSoftHsm() helper on the base class and have both the FIT and
pre-load tests call it? Otherwise the third copy will drift from the
first two.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5937,6 +5937,85 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEnginePkcs11(self):
> +        """Test a pre-load header signed through the pkcs11 OpenSSL engine"""
> +        softhsm2_conf = self._SetupPreLoadEngine('testPreLoadEnginePkcs11.')
> +        self._CheckPreLoadEngine('security/pre_load_engine_pkcs11.dts',
> +                                 softhsm2_conf, 'pkcs-1.5')
> +
> +    def testPreLoadEnginePkcs11Pss(self):
> +        """Test a pre-load header signed through the engine with pss padding"""
> +        softhsm2_conf = self._SetupPreLoadEngine('testPreLoadEnginePkcs11Pss.')
> +        self._CheckPreLoadEngine('security/pre_load_engine_pkcs11_pss.dts',
> +                                 softhsm2_conf, 'pss')

Both DTS files use the bare key-name = "test_key" form, so only the
URI-expansion branch of _sign_engine() is exercised. The docstring in
2/3 documents key-name = "pkcs11:object=preload;type=private" as
supported - please add a case using a full PKCS#11 URI so the
startswith('pkcs11:') branch is covered.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5937,6 +5937,85 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEngineMissingOpenssl(self):
> +        """Test that a missing openssl is reported when using an engine"""
> +        with terminal.capture() as (_, stderr):
> +            self._DoTestFile('security/pre_load_engine_pkcs11.dts',
> +                             force_missing_bintools='openssl')
> +        err = stderr.getvalue()
> +        self.assertRegex(err, "Image 'image'.*missing bintools.*: openssl")

Nothing covers the new 'if self.engine and len(sig) !=
RSAS[sign_name]' check from patch 2 - with openssl forced missing the
stub signature is exactly RSAS[sign_name] bytes so the check never
fires. Please add a case where the engine returns a signature of the
wrong size (e.g. by mocking Bintoolopenssl.sign() to return a shorter
buffer) and assert that "don't have the expected size" is raised.

> diff --git a/tools/binman/test/security/pre_load_engine_pkcs11.dts b/tools/binman/test/security/pre_load_engine_pkcs11.dts
> @@ -0,0 +1,24 @@
> +             pre-load {
> +                     content = <&image>;
> +                     algo-name = "sha256,rsa2048";
> +                     padding-name = "pkcs-1.5";
> +                     key-name = "test_key";
> +                     engine = "pkcs11";
> +                     header-size = <4096>;
> +                     version = <0x11223344>;
> +             };

The two DTS files differ only in padding-name. Since
_CheckPreLoadEngine() already parametrises padding, please keep a
single DTS and inject the padding via an entry arg or a small template
rather than carrying two near-identical files.

Regards,
Simon
