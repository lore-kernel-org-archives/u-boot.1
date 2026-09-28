Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52705CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7FF080E09;
	Mon, 28 Sep 2026 17:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fp848Es0wUWK; Mon, 28 Sep 2026 17:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 14FFD80DF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615577;
	b=LdnjVApKM5nLP1EYC1h8IY1iKM72M8fkZnUQYEHNvlZjA99HwVkbFuohrhicFUs1ORwR
	 mlGcbCRnIXYALchHtn5yBfCBaTipJDdVGe0iN2zgF/blTuJhpLj9iu8coHsXjjR6ktObd
	 dzE94KLmCo5GOteu+ItDxuo0ZpZckt704hn8BfCszVLkFRHUxHSECqQSdYUR4gmWjOvFd
	 CHz9Cm4yo17590gPG6t2U/pQxrj4JUe5aZVap42FlyEj9kZkhpRTKusn9SKZzNdHkM9qd
	 0oBFqtyV/a/96+HOBZN0z4rZPqY4H1d5dTVo2L6AcWoEY28N7hSe1hjy9RC/FNyayCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
	b=p5B6WO8gOipRJh+sffZ8cLsV8kfkGCAbnqjAlXHAww6WtxTVf0IkignduUh8F++bfwjr
	 9TereMXLSp/FSg8sf/vf2sb9qpUKpANKtcR+EyXso4l7PitlRJFYUKi6YJld+XhMXQoU1
	 fTXMw/UcUHIGWFZC1HKOqsTtYkRllau62+ggUcG+25Kpgj/fa5TOZ4o1BFcvjgZV7Fe/i
	 CFv4Z21KYSGzN1WhNw5OgZ0FcZm4Z0Cn96zaer6ZooNLZWo3Y3rvJA7cW+tN+i+xCW6y5
	 fJNcZ+24aJIMx3fmlDieasRC0+AXVAc1sgIWvaTvOfwyPSouo6xHyqEQnVoah+fu0Xw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615577;
	bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=POwMhTeRM65tq0Rt1hF0KrVz3kTHRBc1mj7iBN5vg6vqbtdpH/mKh49FL66mpDrge
	 0Ze3/CPH+Xq+SicFBZptHIJIANmcWKEXMqbpdUo6s5IqiMhvqAxwO+8wV4GxJYBKLK
	 qLRmTjlkCDSx4k+t2x2Z8Cs/t/xmXGy9QKhJSyjVH8qoBP48GDz7znLd7Vq7M6Hvqx
	 x6skGonS2w3Jr6qL68bH2Hgob9TwonhF0FvUoWJcV9kVJ/le57MNcvYmoA52QCvqLI
	 Ic0xeYRr7OLCLKMGKoiVExBvPCvv+ODc0VDpcvWcD87YjP1cZETV0GrooDg3EqaZxo
	 HTgdjYLTVd8dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14FFD80DF3;
	Mon, 28 Sep 2026 17:12:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C8F24E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02BED400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5kDhDftmKO2 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DCC30400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615575;
 b=hrjjQOogbEGgDB1Ho37AkMBDWVGtzcgLUvwv+Wn87WXKGEV//+ZUz2kD2xr5tqB/kTqF
 kPp2y9smVogfR3WPn2K+dBYqspSv1i5Y/Ad3O+CsK0ssDYkneiobI5Ski3z1aocH/zfOg
 vybHUcrBuxQCO14EATCHnqNwcDVU0t4wakh3Qq+Jy8LWFo+DL8b2ICmZD6KNbB5B8PsjC
 jBTipbm817TlAOayQqGzCrG6ZP490P4N833yuSd8U52ZyFmsFT/8xOWoWwEpqHJG2Zpct
 rCx9UC47e4nGgduIjT6WekNLGZP1BkGze8XokGFuG51wNgFxDPSBA+sNvoOeYEz2OuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
 b=iSjEe7SGZziE39w9L7nRT+7FTVqWt8RT9UMkvMcbSsrylP8Kqq6gxnA5eGFYf5Rf+Vte
 QJjCSxuFHmAPNQpbaWtS44+ERZTF1+/NzSzBOQ3sixjmWWlRtghAqpGZjArOa7ftrTiLX
 fWlWZFAm7g+hGBuW3lkDyHmAj5QmhYPyb3MJYG/mZ57fsBEG4aPqi2gEvERIwSlFINrP3
 iJrOoFFpcTfbWjpojo8NE2ISlNJH11Ssl6RrEl5kkQQ95LMcNGJn3KLQXdWcpZz5OL7Zx
 X3elMEHD7k7DyZRT70jZOj2HjYdY/VVJlRivG3BAHZbdgIJTPJuFQ5y9jw9EvxsUyEg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Jz2yw2lG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Jz2yw2lG
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCC30400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:54 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab0c3c3af6so3015010a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615572; cv=none;
 d=google.com; s=arc-20260327;
 b=ft1cnAV+81EG5uhzxNn8spycJ9GEtir3TpLljKCP4gLzftv2bwXLYGWwUItE4jVE8D
 VafQy/UEM8BIs+jfTLqjw91nw+eP+nqfne64cFzKc6mLdGLxmNjPD5XOgyOvjXpeUKZG
 mu9V4vvXawGt3u7+BPjJOXNOfnHZF8sJbiTqusfBcMXREWPLnL5+BI3o08tuY6AK72fr
 lrHgxXAy4pzOnrWotNunOm0GLCMfkP57vtOvSSfcJHJKypPePsvnyMOo3R8HjNdOyHcq
 bi8Yp182GVhpGDJjAKYE4/ONfSjCTCtElqbcKsGcnsBV582XQEAxX1W/w7IlQ6s5U+Pu
 1NQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
 fh=durgfX1b4/1SnC3pJJVYM3Gc1F35eR4yNe+Lv0h5pxA=;
 b=FW1aZE2pJMK0VaEKDBnaBvaSa1zA7UwCfRi96jkrq12Y+WzmnyTFIpzOodcx/BcOjZ
 2YnGLr87IXczh3thp+YdceN37Bl5G3XeTTWSBH0c7U6D4y+dY+sgX2afBmGqvjuy48NL
 ZwqsmpyjSitmPXnfnBeUhYfx1+/0lh/PIAeQ1TYMIU1/1kEDFOfgp770371ZB1ZKW+Yn
 CnChyw9b5SZ7pKop18cTz7dpxHk/xg4/rsc/Ha+k0hOJJtcILnFrKXJBVpVAVsxzNjrw
 NL7ltvC9OOGUnoVbaPz7giYGOizToMMiS9IVd7G5Z34OG6kRdoMBeDPVR55pKK44itVB
 2z0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615572; x=1791220372;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
 b=Jz2yw2lGMccc96sITbN1jgYVTikvGVGzkuIxDYaNQLsUu60aej0rG7rdDfPBkoC4E0
 F/nc5lXU1vFzrzASiuevTuZbCXA7mI93NWEPB29CNludwdsbVhISK8fO9O22vhEYFoZc
 RvO1ECVBtNZQA8zxh4SpoJfRTvfcuYpcm1qng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615572; x=1791220372;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hZ/izPddh3yI7U4vSsonbswbWGd7HVYxmm9nA/oC2kM=;
 b=qTcf8GXLCSzjhrv5CYoWjb/KRJgeh1JzZ4ps8z8iL9seLCvpihwPrCkFpoWHCC6DJr
 IMNy/CuAIubTdcyX3ol/XHCajivxR3XrwT4RrE9exRiFcHRLa7ZTAoaFhtwZHT3cC0r9
 iut+5/VBLKb2i2ejzpIwPr81U/M11FseDjlfZVmBilpoLsJLixv/VzJZ99gTVJ7+dDXX
 iWFj/CdQt5r7X3/DVsQ73yXVdDOU8o0WPaDvnqYrLVeKDHlbzjEaT+2/ZsNdxM3Z7Y6d
 fwrnWTMKYffNp+dCqYxBv1iA3xXvhp76PE+lbwxWvDj3P0y+CKpSgd6PSa6dt1FDHmSH
 0RmA==
X-Gm-Message-State: AFq9FYJu7kMUhEQ8DtD/NOgDXwA21V1tHizjhYalZeN3JBBM1tHGB4Co
 rAb0SFnA20QrBMGoJyNeYydzhbMl+P3xsJvEo9eRS1e9q6C+/g/kWZ5L+Z2RqJHvxcG1umrSSST
 i/fG1umubT7UBOOgOHRF6hPauo4lUcaIGjiuBRdPW
X-Gm-Gg: AYBFou0hzwpX+rCeBssp/SAqET1OYiQNalE3CCd3/HHYRtHwyVZu+VIMTABsJYkAHhh
 Wk+72zykczkev1xr/NCp8KEsp+AXgbhb6FEgEue8yGNRN6HrlylM8I7MPpwW/7S4fQYmV09uwPU
 5JDnflXIfHHXJLk5SC8aIqPIMbEYtzI7n+wF6wmERP9TkFE4z9Z4iqzdEnQkEh+gWaZpFqOs57Y
 ihKRh4VojVhTejLtvK6J9dWoBbG9cFV+hJyMSrh1OMgqy6HdWjEsLwLGiInKbnleIJpR22feuQk
 F7HXK4CnEV9Cngg1oeh7GveQi8FahHKluFwiqfmfzacJEOxJ0pu4rw==
X-Received: by 2002:a05:6402:210a:b0:6aa:a05d:c08b with SMTP id
 4fb4d7f45d1cf-6aae8eb59aamr8390985a12.25.1790615571825; Mon, 28 Sep 2026
 10:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-3-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-3-016658d0b6ba@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:12:36 -0600
X-Gm-Features: AclHuK9saqxYKCumMG3-82gc0qr8gSfC7NmDbKc8sCx0Y6AZnQoUJmR8oG_EPqU
Message-ID: <CAFLszTi04d9sWpJw9uJXFxLP8k3-LWNfqT70sGwG8bi=7DxCpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] bootmeth: efi: use the firmware-owned devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Carlo,

On 2026-09-03T13:09:47, Carlo Caione <ccaione@baylibre.com> wrote:
> bootmeth: efi: use the firmware-owned devicetree
>
> When a firmware-owned devicetree source is configured, stage it at the
> same fdt_addr_r value used by the normal EFI bootmeth fallback and pass it
> through bflow->fdt_addr to efi_install_fdt().
>
> Use firmware_fdt_stage() in both disk and network paths. Only -ENOENT,
> meaning that no source is configured, permits the existing ESP, network
> or prior-stage fallback. Any failure after a source is configured ends
> that bootflow.
>
> The firmware-owned devicetree is complete and authoritative, so do not
> apply extension-board overlays on top of it; those combinations belong in
> the FIT.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> boot/bootmeth_efi.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -130,6 +131,22 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
> +     ret = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
> +                              &bflow->fdt_fname);
> +     if (!ret) {
> +             bflow->fdt_size = fw_fdt_size;
> +             bflow->fdt_addr = fdt_addr;
> +             return 0;
> +     }
> +     if (ret != -ENOENT)
> +             return log_msg_ret("fwf", ret);

Just to check the fail-closed behaviour here: a few lines above, the
function has already set bflow->state = BOOTFLOWST_READY, and the
existing code never fails after that point (a missing ESP devicetree
just falls back to the built-in one). This adds the first error return
after the state is READY. With 'bootflow scan -a' the errored bootflow
is still recorded, and as far as I can see bootflow_boot() only checks
the state, not bflow->err, so 'bootflow select' / 'bootflow boot'
would run it with fdt_addr still 0 and no BOOTFLOWF_USE_BUILTIN_FDT
flag, which is exactly what the fail-closed policy is meant to
prevent. I suspect the simplest fix is to move the READY assignment
below the staging call (or reset the state on this error path).

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -279,10 +314,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> -     fdt_addr_str = env_get("fdt_addr_r");
> -     if (!fdt_addr_str)
> +     if (!fdt_addr)
>               return log_msg_ret("fdt", -EINVAL);

This quietly changes the network fallback from "fdt_addr_r is unset"
to "fdt_addr_r is zero". It is a different line from the one Ilias
commented on in patch 4, so please make sure the v4 fix covers this
one too, e.g. by keeping the env_get() check before calling
firmware_fdt_stage().

Regards,
Simon
