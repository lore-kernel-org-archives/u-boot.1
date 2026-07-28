Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6156C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3DFD409A7;
	Tue, 28 Jul 2026 11:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFX1ZP_UxRX9; Tue, 28 Jul 2026 11:19:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1E9F4099A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237568;
	bh=2v6+UJjdhkRs8/KvCfTwjD162vG5mGpk1JSvGPvaBR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X/oNqqtxLlnFeqWqc4QCZqKvkrEf2ir3YM9KJgDfMQvFaVu+7Lv3Wpl5G29YkOb9y
	 navRYGDXJUsDmU7LCCyYU+mIVzF+ttN/7lemXqjCv3p5C2F7Ba4Eu9dLXfbv8C4Tkw
	 +ou6Z7jeGETi8FjEaWuiNMUI2ZkNZ2vAORMSxzjlzNSDXZxEfk3mmz7QY4wUO3cW19
	 w+KCuhuLo3WbaNl+UNQM9G7Ipl9dFYP3W6qybXTvKBhIVXUYQYG3C1Yyl+i1koFhQr
	 thj9oeSSNOQy5seKdqSl0y9JKbVyi9Wuvokx46RXN4zq7wZ8i5DuhO6hdAO79Vjn2b
	 JD1qV7afd3uCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1E9F4099A;
	Tue, 28 Jul 2026 11:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F9D9350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41D1B60758
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l7MX4GpR4kY4 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:19:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 54B71607B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54B71607B6
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54B71607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:19:25 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so5535737a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237563; cv=none;
 d=google.com; s=arc-20260327;
 b=bL4hqF+0SPQCPQXZsKBOmRHWkdruvl5GVXs4l+TllDqgjfnTgbJ1WH6IZAYRjF80DC
 usbgEBD6EXeccDofyDs7Ky/GPMby+2VE5m+cwcEuFns3eaECjadccAMoo5uCUWAv3u4M
 0iZd4JguSxUuTOaQ8Ef0eTN2duVmHRueCiD6Wlg3yY/5Y/7+Ghxiq8WTfPyTM9pzj0Kt
 MXq3NlTRIgia8LucK1odGRtMeRssutC66FJsBFybaj4ZGZMAZx1CzioNHfH8DLRHhjsq
 IBHsFu6LSskvfZmSTkT3aAq7IV+fmrt0pAnUETngSgiOw5wSnzyULqfCXLzQgD10NSjJ
 ezPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2v6+UJjdhkRs8/KvCfTwjD162vG5mGpk1JSvGPvaBR4=;
 fh=Q8XP6s0K5Em331BgwTxMzSVF+kexbD/6KigL7mDdNoo=;
 b=UM0Hpr1Opg/Cc+XKTRYLdFAClTCPeFYaDYM/QdFdHcm+QeXXtKYKf6gIavOMKupUrE
 FxKjZTksIEN+ERCHC6ZX67YEO1y05kj0sY/hjMX7cdW1kRkzry0/ZUuoGpSEm0+GyS1D
 EO63UeCrBKSCAMqf7KWRrRPQuEqDAHoKcAFIbF+TLG0EJAIL0G9BKC3BSjvqU294Av7C
 5fz237WC1geKKL0k9FWaTvwCMzfdXz0uf0wa2JPFKy1zGb0eKJDH6YT8PflVVm//n9hz
 y5YJnuMrOeuEHhI5Jk4ds+Bg3w1u4uwATbZ76C/pl3R7th95+89mTl6pwTNqgHnQwKyw
 47zg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237563; x=1785842363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2v6+UJjdhkRs8/KvCfTwjD162vG5mGpk1JSvGPvaBR4=;
 b=Y8w8w0fM3Q6qAYcCwWMAfGg/84dDSDZWDoWvSx5O2aHd1iRaDn8QAxkqx1jFSEkOdN
 C9/yR4AqNat3UlWU9nO0oUVUoEV7hwu94Hil71QrWFGiSVn2euziMYH41kS428qKn5BA
 +Za3rnSLJS3QAGxzJXy4D0KnQGBkX/fbcIfCMpTGQFE+sCz+4X4y5LIukO66rPoCer9Q
 0XiCj0eQynS5RpFRBaitr8QfO4orm1ZmKynkIQFUpt2RmV6V6RKDLd7Y+YYtlcJ6liuT
 QPGX7t2P+NVCGEzGImbIri7QTbAE2i+m+qOixiz+robKwwszNNsnHBaKOpcMxD8hKlTW
 /vtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqisM37xArJ+m1mbuKxxRnHSBsYpSjO4oOGmKC3Zv3SLTiHt+beU9ope8GJgydHw8To5Xuzkj4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxoDXfElPnRw2yPZiwiqltJBiwfVPWIeSphlzs1kFmBv1BB0vwb
 zrcppnlUiVsBiDf8oV+PJdFv1ITL0brX0EiTQ0/3B0cu6/kbVs8xUgIfOCmoMFka/FIn49FNTIU
 x6CyGwY49var3+Fx/Bjwy8t8FMX3E2wPe6/d8EU+i
X-Gm-Gg: AR+sD13cIOnBMaJnitNHjEMF+jzmdDtbFnoLKnN9aUfq6B72WB00SVhTPSeHC3WerxC
 hxn0Z9IThI+wPGHoRcrOa+L3WxKQvTKQf4Ax+tJe6CmlSa2ZjVqE3fA88V3wss63/MGxzNkH2b+
 KwpQnXiIBUpO0RZTjG5Gd0kZYm6sOTjudw9w+z6cLmLMxFLGzBbK31VtSPiEdo7UT+D0eRurivi
 a1JyWm6KT12gT86t4wB8UclSJj3ZQvKqZ5gIG1byqDJKDVYaaD5CvETF2nx
X-Received: by 2002:a05:6402:388e:b0:69e:35ae:8afa with SMTP id
 4fb4d7f45d1cf-6a034a544bdmr950523a12.27.1785237563170; Tue, 28 Jul 2026
 04:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-7-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-7-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:19:09 -0600
X-Gm-Features: AUfX_mz-ZPXBB520V50zBHtIl9L6JpYTwbj69H7T3jIx7qGSvCtv98f-2o7FPKI
Message-ID: <CAFLszTi_RPBC_jjbdVO1u0VtvUcHLoZusCDDmCbVS+65JvRxdw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] test: fit: cover mkimage load address overlap
 detection
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237563; x=1785842363;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2v6+UJjdhkRs8/KvCfTwjD162vG5mGpk1JSvGPvaBR4=;
 b=iYpqXvgyWCgLwq5ZWU0bu7CGTe7PQrCb94Mm/g5Lvjaxn1r00h4wXM5HjD3zx/BZ5/
 zLZu8xns+evv+wos1KktZDk7mswFtH/qUQNzJijPkX4jzKlhDQynZSj9mMy7Fa96e+IN
 T6CjkCr3Ecdwdh/1fKpzvEwRNaeYpA+SBWOnU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iYpqXvgy
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

Hi Aristo,

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fit: cover mkimage load address overlap detection
>
> Add a test that mkimage rejects a FIT image whose configuration
> references a kernel and an FDT with the same load address, and that
> the error message names the offending configuration and images.
>
> Also add a companion test for the intended escape hatch: two images
> may use the same load address as long as no single configuration
> references both of them. Only one configuration is selected at
> runtime, so such images never coexist in memory. This mirrors the TI
> K3 tispl layout after commit c85bf61b14f9 ("arm: k3: select tifsstub
> via board_fit_config_name_match"), where each security state has its
> own configuration and all tifsstub variants share one load address.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_mkimage_validate.py | 134 +++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)

> diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
> @@ -160,3 +160,137 @@ def test_fit_auto_basename_dotted_directory(ubman, dtb_relpath, expected_desc):
> +    assert result.returncode != 0, "mkimage should fail due to memory overlap"
> +    assert "has overlapping load regions" in result.stderr
> +    # Check that it identifies the specific overlapping components
> +    assert "kernel@1" in result.stderr and "fdt@1" in result.stderr

The commit message says the error message names the offending
configuration and images, but the test only checks the two image names.
Please can you also assert that 'conf@1' appears in stderr, so the
configuration-name part is covered - otherwise a regression that dropped
the configuration name would go unnoticed.

Regards,
Simon
