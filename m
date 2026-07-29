Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F46C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDF91811CB;
	Wed, 29 Jul 2026 13:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YFc-KLiRK_to; Wed, 29 Jul 2026 13:43:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0264C811AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332623;
	bh=C/18e9uKQuZAe1XiiTlnYViNwoXPOxj3efSkDD9ytZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yZsd9oFn2v1lP5Q4KyQbBSDNI7KfzhXT7/oXk/lpUFQw17AkeR6OoHhl5u09QW+ab
	 x1SoLEuyQoEs4heUyZobnKbPgdRU8EDd539B3INTw3t4ny4lj66TfFtyp6MZfALl2E
	 wivFPm1N3/qoDqMIGz/2qy1q4zLZ+/QruORQf/TfF4z68RHJSu5uVWkt3kS7TGDK/J
	 sXIFRtpPM/9BAZSawklgJQflWXxoGK/s/SQEOH9sKQhTXmIxaiwplFm1VzjsUJRgMt
	 4B2d2qLM+3Zn6UyY+Jcs7xB30/jgiVtEawHrH/5wGzLvb+wpr/widvAl3Ze05JoyXj
	 n32lG9lJXosSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0264C811AD;
	Wed, 29 Jul 2026 13:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7274F2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 584ED4065B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5G8aGTD6sO-4 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:43:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 74054401EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74054401EE
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74054401EE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:43:41 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso1477025a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332619; cv=none;
 d=google.com; s=arc-20260327;
 b=YVXyoCtXkS9ELbhvtKSu5QSyVfZ03pWC/RpAIAUsec6kiXpMEMkOvIW7bZVq0dMHBu
 +rTYR5SDatrXlzGCgoLWCkhdBTSFqzyZMdjG0DzOwKV9XtJoGC4O30OGJQn8CicjTiOa
 o1mPQrA2edwbBueHHgqO7rZdiN5FE6RlPEtH/3+p+xchLYKjJyAbAtt8qaJIY7I6jOOl
 L/oEiEskIQnHVRQsRRHZZtwgkwl+KPQGA6kX6cjVmrfRHd5Gm9s2qva8I7UDp/035izQ
 4jTz6+0x/rDDtOCAJ5mQxm6p0PWwzQoBYEvBGvSwAo28w0CSSCd7xTGyLEJ751eSTCnJ
 a8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C/18e9uKQuZAe1XiiTlnYViNwoXPOxj3efSkDD9ytZc=;
 fh=8pxfua0FHSxMte9LGORPF5y2tOWRiVGo+HLFVMUHo7k=;
 b=bcBDnQnCJ+PhKWbDr129RY68Y87oUxjlEXxpx8XXMfqdOyZ4tML5TA5fOB43lg+4Hs
 N8VlRXh7895AoHJ5w8KT+qLEHg+Pgg52r46CTtOegQf6LaCKjcOHLTYIIqoGBDmQPAUo
 BzTPXTm9stTICSlD3K5KRPePzn44vPlScm25y5LJpFsxO3TppsPRM5Wp0OCxPQr21L6o
 n1UmJs26Lq0cZ6hbb26Re+jWm5gqoYm5fg7vpBUaXzXXEHJ1lYBWCVLSjnhBZvjtbi9R
 2WHaTxw9jG1yodUzP+SdvqQ8aIORoyDngSZcKrd88sTTeh/ReCjWxK3FMEBg/LdMcsRr
 R+ow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332619; x=1785937419;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C/18e9uKQuZAe1XiiTlnYViNwoXPOxj3efSkDD9ytZc=;
 b=FUpxB+oF/Wcs4ykQoVNdFoe7W+PDGvilAcC8/mSaN624tE7ZRZyz/UnM6I0qUpaS/2
 FpfI7w+b3QjcIxYC6yzhPTVfa5yuZffXYavDESToRK+snyaUcm4MSp+WzzBIV1ANjm7U
 GfdvxpCplYDgiC70MvZuQCF9zfTOUbmWloG5TOYLcmsqb0lH+rBbIApkgjDRiuRFQo25
 2grqPYqRDecl5SSf1IC/dqYRgF2Xnv8k/B+0LcifHcVHeqYiFwLerIkFJ5W7nJqTL7S1
 vael5SgSNSEuXovhmbB3hGg7jE5x1XEj8Uo95tD9dQ9Z/y6GgstChpH3nqmlz2PRvsjB
 mHIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLJHKNK5ad9Wn9jxuvPWlaa0WMyBsrju+99yjK9PkcuiObJdTXeMlzRVp11SvlMVKx85sdTMI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy7I8+nOjMAjZBwVidXv0zTOn0gcvXsql7rr0GkSkjXGbkegI/w
 lC/v2PUUq1JoKcpyi7kjPSNPyYZOdLVS1j46OV/4eQYtcQS4JwaUGyM3lfDEnoeQiSfPugu3geX
 m7mAJeKJOVAmwwNYZjelRO8PcBLgwEkQmGkrCFQBwcepsx8QJY29c1w==
X-Gm-Gg: AR+sD11/GGXxxg3Pq/Tro+7EWMDSRagd+DP5WITZLNOJighamPXbOJpPdo9BlPpMMsX
 IjAPc/8RNMMVts0CMr6NoeX8bqIqXUhUWQcMXyFqSZiKf307mWXu3UaLdK2/R/qF7YPlv6tffTT
 v4HCRKiuKhQCV49JfHD16GBeG7gTLw0nP3tt13MAOl3nasfreeVGysc8H0ZXA3r/5DUGE7sEeWh
 Cqj4YWINuVvoJ70N34N81IiykfUPJ0JSTtSTIUe+oYwQLv6nn1jw9qpJwGuFOCesldVLKrbRg/w
 5zE/UpsTnZJy35KJ8dlZtpeG1mc3QKbfRfQcFlEMfno=
X-Received: by 2002:a05:6402:430b:b0:698:4405:4feb with SMTP id
 4fb4d7f45d1cf-6a0349dba1emr3621912a12.3.1785332619437; Wed, 29 Jul 2026
 06:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com>
In-Reply-To: <5ab38df7-9065-4354-9b83-364d14efa390@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:43:27 -0600
X-Gm-Features: AUfX_mwJqq2Sb6MlMqM4FeVjkULS4NbwOG1cyq5E7d5D23MaQ8SJBwAK3wrg5Wo
Message-ID: <CAFLszThHfKipCfGpjQ+S3cO4YzhkXwWOytRGmstGrUtxMhXh4Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] rockchip: doc: add boot medium layout text
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332619; x=1785937419;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/18e9uKQuZAe1XiiTlnYViNwoXPOxj3efSkDD9ytZc=;
 b=WabosFfN7afFEkM0bWD5TRKlesgDgGpLSa8ZvnIRzs+HX+/6lzj16JHFVHIIQY2d0d
 P+RIaHhd1n58A0id8GmrN42HdXxQMSOpc1UVBg4XO28WlUCnZmrVztWdnYhnEctDXwG8
 4PzIxGtn90lZ2fiuq9dOwvifE+BzGnFEdpSwg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WabosFfN
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add boot medium layout text
>
> Add text that explains the boot medium layout options.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

> +The boot ROM only checks a boot medium for a limited number of pages or blocks for data.
> +It is not possible to place these blocks randomly.

Please wrap these prose lines to around 80 columns like the rest of
rockchip.rst - several run well past 100.

> +  Rockchip uses a unified GPT partition layout for it's the open source products.
> +  With this GPT partition layout U-Boot can be compatible with other components,
> +  like miniloader, trusted-os, arm-trust-firmware.

As Stefan says, 'for it's the open source products' doesn't parse - I
think you mean 'for its open source products'. Also
'arm-trust-firmware' should be 'arm-trusted-firmware'

> +  Write u-boot-rockchip.bin to offset 64.
> +
> +* SPI:
> +
> +  Write u-boot-rockchip-spi.bin to offset 0.

The Flashing section below uses seek=64, i.e. 512-byte blocks. Please
state the unit here (e.g. 'blocks 64'), and likewise for the SPI
offset 0.

Regards,
Simon
