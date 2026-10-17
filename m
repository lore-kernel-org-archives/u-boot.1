Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85A8CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C7014095B;
	Sat, 17 Oct 2026 10:43:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvZe0ie99dOG; Sat, 17 Oct 2026 10:43:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD20140966
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233829;
	b=g9h+skoJgGWl3YdfNvKPV9ztrfRTWkFLkX7LpglRRwlSGYgclWpwUJifN8DxTANNt2XO
	 FfjGVqH3bTuYua4eMtiaZyRi2sdtPPPLnz8EjWwMNdO1NAh02e9/MpXQRVaGkvQKJZMKp
	 rEMHN84aaG1GK+XnvFLjZQQc9TF0M3FUkUrZwaMVax0v1zcReevYRYsx24btTkeiEE7+X
	 9WBBZNwpAPJR2tfwhIiaEZrIxvJkbWmwinR9rO2kcGvWxONAYcGuFtPdd+s4isX9C3sVL
	 0gyGxJBJFLV1TgiDEuU8XhtSRG0+PsT3sIUmlvUhv2aSQq02HQR2ERQvsY1WE57cLww==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
	b=tGWNurxDtZ3XsVu/2vnl62QW2Kj3iTI0DFiqvtcH6oE5PIamoUmdJFB8aTLuyBpsnGuB
	 XnA62ZcQMh9JsBrVGw3ioE00WkUH9jQOLclqutzkt5olkK2KFRM+SalXn79oeJo8B/l25
	 l4vC+WWT+/Zf05d6BnGoMzEKzOb1SUdzyTqMiwFwUPPDdhkhcPbB187vNMPzOwF8dAQtw
	 BT4NxNK2VlEVcjQQZ7OHP/ezFpuTT9+NU+sZKQrlb1tYkK/m0UcSQYSGsO12cvYhTRaUa
	 zaac9DsRlN6WsM+d1hp8aEb3PMZzSbyO08hr0YdQIBg6wbSwu7Wju4U8g77acC7eRHA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ncq1tShy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233829;
	bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrvNmgr3xVZA4zAIm50zR7ew0nMRYMngaE3PGMvi6xcJHSX4GRyM1+kcqBJMapxtD
	 ZpGzslRIrKbiyxEz5DoeuOOI7m0T5C+pmtzDCjv3F9nM7KB91tC6ocsFgC0PhVeOmv
	 9m4BqgvHbj6kyiqDnI4MzQG3budZAptFKUc3MpwHfC/2A2T0D6c5ADv+ccrkMJjQgb
	 WyWgIqxx+8qZIr4TqJvbAXz4TbSfPtyjDmVrkMfDZUowuei496AUA3kark9kEvBdhX
	 MESSoOI+QOnC7rtVfBKDfaKk0tg2X9ifsW6EwijUx1R1qjIfnkL3kGfXByjMv8V7Ia
	 uqIob6tAVGPxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD20140966;
	Sat, 17 Oct 2026 10:43:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59EA51DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C0E140944
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5HRSIg86vXM for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E557408FF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233827;
 b=fi5jHeUCCMHjcLg5z1HNzt/6R60JV5upz+1oErf/DX4cmj6SkQN2jKYy7SygWcMPQWqz
 5HtXJ2LK3DG7dN5JZyKeVd9VCds5pRRSupFOfxkIXyud03hp/uEgHQx8Iy/FWCE5xiiQU
 hPNWH7ZXaQa6X9RYzjzL2A09CGgnXF4XB86zhigDjalN5fN4yXtgqYatpDIqUSSg9tvr8
 dETZ2aYVOFXqOMVPrCiRq/VS7DO5mY51NBWd5Yi+ZQlG2Uj+yeY5o/DAHwah3jdI9IiZZ
 JxKzFRceJibAKAnJYbdjw+ZC0KiifrGmoZiCLJrVmw4eoIbfDlvTpcSlNiPA+ppZjHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233827;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
 b=PP8bXEawrNmfzfh74+x0Sk83X+f8EC9RzdQJphrGgixyFI4OG8x4H3hSON5rr+sIjE8k
 1QJAKpAdAzG6/heyDwG8KNb0nVBRd9aiiJ0FF4b6TQNw2One1cctU51XnfqkC2jSj1mZC
 sl9Bkh28k+sX8OtClB+y4Ah3XQHA+xD5poiJPy3yuN1Iin5wb2M2Ghfg8qTU4U9qRp5Rc
 GikD+WTJevKxKjoQWH1xYAWyTZ5/ejvmmDNYxfA05/2MX5E41UVNxiGb5AB2P8JO7QKCX
 mtDh5gN+fJcH/kVZCUWmk5CK+1bbDoZRluQGZItqkSEsWEznOuuFf7F0HqQmfZdUzng==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ncq1tShy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ncq1tShy
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E557408FF
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:47 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso5048935ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233827; cv=none;
 d=google.com; s=arc-20260327;
 b=kCrDwSQIjLygv7Ey4jwwFaUfpZjyKqytDa6AVLbpNQt67+ixxqKLjO4b5mY5YhWSHl
 cStR6YkoXHdwGsfccZTGSDMbVjpvw5CFX/NyNqqyV5neW3Orrp9+hEu4GaTDDzOFZ5jm
 a1HDEdoqlzOG7oscJPrTiRf9m01XzQMVUISnpjlJXQNcUTdZjfuXt+UeNftLMFM3Gyw8
 bN/Wj1ibfzxZzbeNB49MLmey1swTIf3roJFmcgZ9ABxZ2vmX3YYXPQeEYuxamVkckIU7
 yyR+6xB+Mr5CUzXWFsuUmw+4JOvAgSQtG+BHsOPS9FFRGar3XaGOyDcWGWULd6zEWyBr
 WsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
 fh=9Y+1q2fl29LFibA619uWA4j4Pk3GMPUFCrYrkXNje0I=;
 b=hwuhAljMBgGFKerkJrMhj3eYg97Fy7ery/PWTtaT7QFkK39Gw8xkPWF/LJRnPK8uKm
 3VM11pWHZutfgBTJ7ozoQ/7st2qA3Gwfihm9Ol+AXml466YAV+gs01GX5s9BIbRlSaY8
 0YQARtXk7R7zOeEKvNSf/g4hxzmYtRFMPYzDAqNRVlb6fCUXpl45HI1M5/9jXBHx4WyN
 fq41JRCDoXKW3dlo6XWcs76+R02C1okudilvBj6wy2KyAQfNeNhGAY5RYWBEJSwq+QDK
 y0qSPdkg9/fKO4gREZztvVmoxrbWGvmIS1GCjL3lGzsFJaR5WtuC9/TjYLUFHJyOBEGH
 p5uA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233827; x=1792838627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
 b=ncq1tShylLG9EBKpPH3jqWTArTXHscN0U1Rn4tu0f0UrBGkuZhe8TYFqO+DrQacEaw
 aR/uvYJziJqZC/CdEHSeYklKRV0OMv57fj/55RQvA+EZ5tTPxOMtfYKAfq/zsCWMcNiH
 qyCTL3rT+Q7uSwolILVS6/lcmxNMXKuXwDTLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233827; x=1792838627;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0l0uhvQjx6o8Du+O4s75k98FNIINMBxXwn+F/35rPeA=;
 b=CDlCQ7CVVpPMULWtbsV+hGcmcP1k0DHSnOOMX4Ntup8PFFxeLmZdToAZjGY4MaJjEU
 i6kEVQbY7Bl3yhU0wDQAOhYbM6gkHOJ+1H6yNOocnkoc4I569dkVzfLXmaeSBpQzg5O4
 5/9Nc1OimmRCOXvKroS5Yg6aomAYcv0ebe924Zp5r34dRAy6X3QwM9s8QQggiLQno8xG
 bpQlTxVx+1/sgR4Z9Snw2IdSpe1uDRSHrst36wwQZGNjslgRgZl31aYKS8+Ig0TfkG4y
 BDgAVOwTt4dDcbYv+LDn7xKzmHt+1xix9Yc/N8mBIFJcBqatLT+z6wWmlqIwstyIYLhs
 +yEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBxqWltJQn4nk2ISNU5q4yKD9M7+joWlFyz++8tRAPHXo9ViDcFP5gKx3ywPNn+Jbmiu34EhQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIRuP1NX74j41C7H+cOf171VIDAIDoMS8KlkY+Gu0YTzxA6Fljc
 Ey9o4zB951OpiJboVJSsQs7fXTSpPV4OnCPV99opgaeEtUkYJBgaXv3N/QlJghtmoMypOeg+3oH
 APlnW9/JGrNzuXwkuSkD2AtQLj0LQmS/PI9au3+QS
X-Gm-Gg: AYBFou32098W4xh57wOqDF8FRFYBnAkB14yD8Svl84KoofwgcETIG1cZIO94/qeHaBq
 6FU8h8M+n3Ma08izKYC8tTbKIr2piASUaY1ZXgCLmLVQjgwjvF0OpSBNHH2pWNLgaUC6ugUP+i8
 qtd1rhNc8+HIaMIHJXmaGvD4lTR7d4yODU9KKAAiBTPEX4zWkz/IDBUcsGsoy/8EZXzO5eaj0Yu
 uXvpFlLl6u7sCRCjIhfQ4eWPXTA/5h2YATWjqycmo3hUHMa7XOnm1ODW1hHFdKJfKGUurHe8AbS
 R66Mp5cfsdv8vPizb7S4UeK9uKlU91oPq/tFqdhUKn0PBNX8h+jmnA==
X-Received: by 2002:a17:90b:2889:b0:3a7:bf13:6007 with SMTP id
 98e67ed59e1d1-3acef134bf7mr2226052a91.14.1792233826668; Sat, 17 Oct 2026
 03:43:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 06:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-6-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <20261012104805.17297-6-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:40 -0700
X-Gm-Features: AclHuK9YJb7g4BacwOyYe1VRsh7zOFPs2nl02zifPTdUbr4cKtmbNZA_zMbN7xQ
Message-ID: <CAFLszTgV1M0CkxqGR6fJ0Y_Da_bmqd8+gv9COoy=HrDJy14s2w@mail.gmail.com>
Subject: Re: [PATCH 5/5] binman: Add functional test for pre-load HSM signing
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Add functional test for pre-load HSM signing
>
> Add end-to-end functional test for HSM-based signing of pre-load
> headers. The test verifies that binman can use PKCS#11 libraries
> to sign data via hardware security modules and can generate pre-load
> headers with HSM signatures.

This describes patch 4. This patch adds error-path tests and a couple
of file-based tests, and none of them signs anything with an HSM.
Please can you rewrite the subject and message to say what this patch
adds, e.g. 'binman: test: Add error-path tests for pre-load signing'?
The missing key-name test is about the file-based path, so it belongs
in the refactoring patch suggested on patch 3.

>
> Signed-off-by: Yan WANG <yan.wang@softathome.com>
>
> tools/binman/ftest.py                              | 76 ++++++++++++++++++++++
>  .../test/security/pre_load_default_padding.dts     | 23 +++++++
>  .../test/security/pre_load_hsm_invalid_padding.dts | 27 ++++++++
>  .../test/security/pre_load_hsm_missing_library.dts | 27 ++++++++
>  .../test/security/pre_load_hsm_missing_tool.dts    | 27 ++++++++
>  .../test/security/pre_load_missing_key_name.dts    | 23 +++++++
>  6 files changed, 203 insertions(+)

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5994,6 +5994,82 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadHsmMissingLibrary(self):
> +        """Test HSM signing with missing hsm-library property"""
> +        with self.assertRaises(ValueError) as exc:
> +            self._DoReadFile('security/pre_load_hsm_missing_library.dts')
> +        self.assertIn('hsm-library is required for HSM signing',
> +                      str(exc.exception))
> +
> +    def testPreLoadHsmInvalidPadding(self):
> +        """Test HSM signing with invalid padding"""
> +        with self.assertRaises(ValueError) as exc:
> +            self._DoReadFile('security/pre_load_hsm_invalid_padding.dts')
> +        self.assertIn('Unsupported padding scheme', str(exc.exception))

In _SignData(), the pkcs11_tool.is_present() check runs before the
hsm-library and padding checks. So on a machine without pkcs11-tool,
both tests get 'pkcs11-tool btool not available' and fail, but the
binman tests have to pass on a plain build host. I suggest moving the
config checks in patch 3 ahead of the tool check. Better still, do
them in ReadNode() so a bad DT fails early. Otherwise these tests need
to mock is_present(), as the later ones do.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5994,6 +5994,82 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadHsmMissingTool(self):
> +        """Test HSM signing when pkcs11_tool is not available"""
> +        try:
> +            with self.assertRaises(ValueError) as exc:
> +                self._DoTestFile('security/pre_load_hsm_missing_tool.dts',
> +                             force_missing_bintools='pkcs11-tool')
> +            self.assertIn('pkcs11-tool btool not available', str(exc.exception))
> +        finally:
> +            bintool.Bintool.set_missing_list(None)

This bakes in patch 3's behaviour of raising an error when the tool is
missing. Other etypes (fit, mkimage, gbb, efi_capsule) produce fake
data instead, so -M lets the build complete and binman reports the
missing tool at the end. Once pre_load does the same, please change
this test to match the existing missing-tool tests, e.g. the futility
one in testGbbMissing.

The try/finally isn't needed, since control.Binman() calls
set_missing_list() on every run and the other force_missing_bintools
tests don't reset it. Also, the continuation line isn't aligned with
the open parenthesis.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5994,6 +5994,82 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadHsmSignError(self):
> +        """Test HSM signing with pkcs11-tool ValueError"""
> +        from binman.btool import pkcs11_tool
> +
> +        def mock_sign_value_error(*args, **kwargs):
> +            raise ValueError("Mock HSM error")
> +
> +        with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'is_present',
> +                                       return_value=True):
> +            with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'sign',
> +                                           side_effect=mock_sign_value_error):
> +                with self.assertRaises(ValueError) as exc:
> +                    self._DoReadFile('security/pre_load_hsm_missing_tool.dts')
> +                self.assertIn('HSM signing failed', str(exc.exception))

This test and testPreLoadHsmSignRuntimeError differ only in the
exception type. Please can you merge them into one test that loops
over (ValueError, RuntimeError)? You can pass
side_effect=ValueError('Mock HSM error') directly, without the nested
function, and a single 'with' statement can apply both patches.

Please move the import to the top of the file with the others. Please
also rename pre_load_hsm_missing_tool.dts to something generic like
pre_load_hsm.dts, since several tests use it and only one is about a
missing tool. The patch.object() lines also go over 80 columns.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5994,6 +5994,82 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadDefaultPadding(self):
> +        """Test pre-load with no padding-name (should default to pkcs-1.5)"""
> +        entry_args = {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        data = self._DoReadFileDtb('security/pre_load_default_padding.dts',
> +                                   entry_args=entry_args,
> +                                   extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]

This duplicates testPreLoad. pre_load.dts already omits padding-name,
and testPreLoad checks the result with _CheckPreload(), whose default
padding is pkcs-1.5. This version only checks the header fields, so it
wouldn't notice the wrong padding. Please can you drop this test and
pre_load_default_padding.dts?

Regards,
Simon
