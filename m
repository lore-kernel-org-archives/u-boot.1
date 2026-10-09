Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFDCCA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AC4B811C5;
	Fri,  9 Oct 2026 06:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pCgbl9oCBD2E; Fri,  9 Oct 2026 06:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3AA7280FA9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528742;
	b=Lbk/D2JkzTwyUUycs6Ee3IWwoZLOtN63JhxhJBV4wqeESUxYKuWcjseL/ZFcD3DagfBy
	 vMrsjQCnZWZLT4Zzd2p1ck6uAQpWRmawpuugkn2y4mWnfmhPCuT1x8SE7hUUK1WvSXx9C
	 6d0LQ6zW7d00ImMqOu7L8TgXD8O7a6LV9rZRdXalcj6Go8DzGfhNJzJKQrPXTx6lt6gS9
	 f1JepaQK93fDzwjSpJI27nALIlR9EP/hi1h0klRq/XpwzHa0ukVLOodAt89qcGqUm1g41
	 dnMNd0l/6M9K22YnLw9GUOOfmsLmLRoMAmeFVtVe3QaovF1yCMlPnDWpUkCXXEUWJLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791528742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
	b=qKiS0letgTZhCTRGFWPHuIkFnAfeNa/ilkO/is6jMalH5SdJIy7Md/ykWD+H270V2g9/
	 8TJ0fc5DKQrKF/6jnZVQHy3NGGLXFNV6e4NpFoAXfGVCbWRWvfzXjVmM6hLvaFmjTJf3I
	 HCbaWBCk6jzGKENCK62wV4Mbmp934Pph+TV/ne+MXXis1wvo8UFxPqbdowu4XMV6Z07mH
	 EWWB1Xq4j7GqytRyIHehs6bl4JZfLLEmMbfuuo3tkDa9fmWgh1P654LJ0wR3LIbX7ZtvO
	 tZ5WzFhx+nfYIUOS/hOuyJvzIQVYEO/NOPsGyAjRpx16ooU53ar8kAy6YmPbNozQE4A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791528742;
	bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iP6kjCZ2wop2CR7l5coDHSjcpH2Ex4Bf8i5y0QHxnsO9e8tzRhaNXh/N7kgRX/DvM
	 i7Y8vZGeFAePDMXqTvW2/TreFzTV2fOUhXLeDvyYvB/Aox6hM+j3ginyUqmlX9OwG8
	 oYEWdOmZkOBUj4SAUKi12l7InbtgOpqp/JN8E5UdP2jo0dNgkBWEE1ZyLfnU61Wh+L
	 1NFYLQH1K0y1x8FvW6wKkpCirfByiWuJdsdWn/HlMdtOUwgBf6wtR3Y8UiPYioV2D0
	 ZB2gRVtCLphbOGC12pBZKPMrmOiyZUVIwLZRIEy1v09d93FW1vEYYKvCT4TkffA/X9
	 Snxz5Tc9tLw9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AA7280FA9;
	Fri,  9 Oct 2026 06:52:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 042121A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9ECD6060A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZHCaR3GW8uS for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EBFE2605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528740;
 b=hqqxVi0+jIoBxoCReRenQnqPaHssW0YtHzk+TqMfqlEJQWhI9XfYHjSMlLR/qrYker60
 qxWYXLEBLK0uIEri6Kmbu0aLZS/HpPwCZtSeVTjBwfXttsPqK6OSuTU4QHKZjqFZA4MXb
 VOX2lhzC4/9cGKIvcLycwdljbs0us2s8U96Fydj1hUr+TVUelgMgVzNqykMS8kbQcQEPr
 EMCWLMy2KPaQVCnQmcMt6QHhqDsX0YRyLP8FCZpME3qTcGDLPK7RbcRM2bO8FVYWROfcT
 1t4LPY2D0T7ZqlHJ/bck/Q05eBUy858WUJKNoecSfDg9o3xMUr5NRh/tKkkaI0h+6HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791528740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
 b=iXsGgUam2TNltRy5X22aFoGw//OUhbWE7+8rI1zjRQAZ6Ekqe0sm7qDPAVejpFjwGjLW
 Qi3Q4SeMhfycPy5cH/Ip0vKoDuaFHEIjrtpfgqi6fCVOfGNGHTAGX8oIVbWcmbY9AiyO+
 +T52WzmNUIdCW6g9x/MESeHjy2EpIE0qxy7O7ntIHRA/vdDHqSYhGiwQ1QDwo3bq9OUVh
 zJgCpV7p7bvms5IR8Nu4maqdDjVGtgDb+XBWyJRadozsZaKwIdKMFa9JYmxVu4+PNkdf9
 OGV2osrnJV1JEFG2fGPLfVsoOvhWqhepIZwMsBL6joEZkasS485EAZueeBPz3b1mknA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X9Ci7hLe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=X9Ci7hLe
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBFE2605EF
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:19 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so1490454a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 23:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791528737; cv=none;
 d=google.com; s=arc-20260327;
 b=MNTr/kv7e2bXElklPOUmaDoZbjPnfrn2EbSd1+1ps/BGp45tY5VeYh88UM73o6bzmJ
 1hBl/QuAxzSE+iyGEXl28jzQLtnen1A+BveoUZMF1sebhAKtn9ROrberClaXWVdtVRSt
 XmpbdlezuSHDzyAD89hSrswBiO+nW7JuzrMhvwlKzDNSacZUFsztfs317uerBwRZkbwq
 ccJHRd/dQ3n9joyN4N5CDL8rK9ZpAA1/uXcFf42xdZ6A1880hsORGEpUnabQnWVjmVCV
 4dC9BtK0enwOwLo3GmWh9xTJpfO4xaNkQRGd46C/1awV1YpIXJyeFwpidhuAl5mBmpTd
 RdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
 fh=WZgsC/K8eplFCdu9IhgHQGuxjSkK5Oe+6pMo4nlHJ7k=;
 b=k0jpwhBytDCcoOWA/pIYiHnZYLuDB+u0vNedvGsQUyE/wGTg3EV03kYa9mPJ/g+6v4
 Bs5RjKrd1g2m/cES0pFZ06V6H70CkEwJ1C0EvtGPWgIf1i1LOcgDITb1UtDqYLo1FX8e
 hHlQkTjZhOjHPnxwlRyd/efUNLbWm3SBIrnjP88/ZA1ofAtKaVyKaliieL+07OIi45mZ
 ChYt48bU3JqeaTtlZxwHk+W/exCI6xE4YjOr0kKbMhHN0eyRi7locfRbDIfrBp6QE5Ox
 yjHHU6QIJFYXOrVn7g54HtZUrPCMapnV71c4wZythnsP882mBTvT1W7xMzxPRM/ULuL2
 dfmw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791528737; x=1792133537;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
 b=X9Ci7hLeC77diZFWmZmA75SSwSdvmSnm0+howrEGJmuqhuNcK8ZKlSGk4Xu2tOAUwt
 hOJMBwEXVZRaMwoi1yp+bypzr3BQ/pVh0ViF7O+FtLcPFuHM9FxQyIRtpcLBFPUZGnZ4
 sj6akWMvARG4+XIYjNhdtXHqEmk5E6v9I1qFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791528737; x=1792133537;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ftsChqr3aj7Untlbao3dEcFHrXQjL+Gsfg6bYH3jyas=;
 b=tR4Kqg0odzxQllnF8x1vTs8A7nWNJ0s6H0Y5z21tnCgKkZLRlaR43PPHM8kQyfFD4q
 hM35T9iASbAStDAEg+7RzgpbypFwXjk2G/t1dhs7rxSJx9O0CZjlYrgIPVutmiUsnM9q
 8juyoimpKdi2CK+N3iMLigNEBIL617/vy5Nv+lxTCZ99iKqDmxhywxt7141qBCBjsV0S
 A7Vzft0XJrQhPrUmeTmy74UYpFuQAGhSH336MBx2ojx1icMJB5SAFtv0p0yMfl3FVY3/
 fkzQiW6TVj2k9hmc6yAP76jlSdwcITWGktrMlos0GHeCF68in4vyJTaQxba2V2czZjUx
 0cdw==
X-Gm-Message-State: AFq9FYLs76hVJ0A1Oi8p5yAZQUx7G1br6dYl7g6Vd9W486MY2/x5y4ch
 zuuF+PlkZ5F5+SBS7VthYZP9whiY0we/ELQMWNOmLzzv0/Gs1KjpSDv7/DvRzkmOzs4Zv7UQU+H
 MZe3XYFVX60/jqxd01Xfia7fBLAg/bf4LH8fO75Mx
X-Gm-Gg: AYBFou3RVSrsRAZ74owSkyrQTwzMrPTn91soLTmsYJtW1TtZxn+FErpqwWvg9STDvsh
 8hNVm7v2kgKIbyIKsBsmAiE76hX1yzd9AtsH0Yrdum/6iLeRacZgy3/64tZeVCaK1D1/U8TyuzN
 Dn1++iYx108fJeKn4UsJrRRdFOfWah+DgtSavJF2w9rAEgMfxDRYSdR0ppqaGDBwyVugCHN7wSP
 LzstxxH6+7TKAfr/lDsJshs0UhkiuGPZOw6pKDM4kHMQaYGVr/+3hGZWFKuzaY9R+8TfrsBS4sT
 NKJtBBFy14HmVjtPnnRQSlRNIuez0mV5ds2wz6jcCFwd8vzyQRZ0d4Y=
X-Received: by 2002:a05:6402:5cf:b0:6ac:afa3:6f72 with SMTP id
 4fb4d7f45d1cf-6b17c1ffa7cmr584911a12.5.1791528737566; Thu, 08 Oct 2026
 23:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261008070116.328864-1-aristo.chen@canonical.com>
 <20261008070116.328864-3-aristo.chen@canonical.com>
In-Reply-To: <20261008070116.328864-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 07:52:04 +0100
X-Gm-Features: AclHuK_4pRF9m0uLjxIXTDMUIxrjpH6_L1A6E9nsc_wO1f5tKomYHUlACZMOTKs
Message-ID: <CAFLszTh04Wjyg0Z277p-Xv3+kSO-CPaExFxKrGL9CkiqksuALQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for
 data-size-unciphered
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>
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

Hi Aristo,

On 2026-10-08T06:59:47, Aristo Chen <aristo.chen@canonical.com> wrote:
> fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for data-size-unciphered
>
> Commit 195f273b6c86 ("tools: mkimage: resolve image-data references
> between FIT images") added FIT_DATA_SIZE_UNCIPHERED_PROP but did not
> convert the existing code that spells the property name out:
> fit_image_get_data_size_unciphered() on the boot side, and in mkimage
> fit_image_write_cipher(), which adds the property, and
> fit_image_cipher_data(), which checks for it to avoid encrypting the
> data twice. Use the constant there as well.
>
> No functional change intended.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/image-fit.c   | 2 +-
>  tools/image-host.c | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -608,7 +609,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
> -     if (fdt_getprop(fit, image_noffset, "data-size-unciphered", &len))
> +     if (fdt_getprop(fit, image_noffset,
> +                     FIT_DATA_SIZE_UNCIPHERED_PROP, &len))

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW, test/boot/fit_cipher.c still spells out data-size-unciphered in
the two fdt_setprop() calls in
fit_cipher_test_data_size_unciphered_len().

Regards,
Simon
