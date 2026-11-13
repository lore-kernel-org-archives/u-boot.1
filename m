Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465D606A32E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OkLi8QF1;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b=PzCiVP/I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F74181E05;
	Fri, 13 Nov 2026 12:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERgNY-sJPFpt; Fri, 13 Nov 2026 12:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C8C481DB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794573385;
	b=U0GhMx6s5kUySMH0+BfrFQG1Gzy3Du053P8doGzviwNJh9cU7BMtmrR8+w/4I47U7IQA
	 NcI1KZXDNBIdoIzUsRsd8f83pyML4UUrsKm4xBPfkm4EbfEyTNzEj3A9xbASDWpU6LqRu
	 nu3g0swoXeuaRCJn18w0mp7VdtoAr6fLgHTDDv5YFaUx+ISnv2noU7x5xP7GACq1pDnZi
	 aUZnlURNZTUrkrImMAdeaRzoaozfwjaPWxc3teiXwSYQGBP/DQZjUV4VH905pzYeN45GN
	 lQHAWriC+1E/Y9YTigbsita8V63Ubcgw548vy5hES+feekWN2bvjPkgUMNkewRwERGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HxkAVcIMKMXakGBEkh3sO8r+0H6ztXTVM55Ez0tZKwI=;
	b=PXvlHv9WzDFxhwE/+dWDxIdepakYNgw8eWLJ2RkzEmlPy27s5daGEdG5K3Bf52W12fTk
	 Yd/gvc4unr3ACDLm0GHVq0EPyt9huOfOV1YoGtb94hKg7BjrxeAAAXAJrnlTuQ9S2xPFD
	 4jWFCCEo3R6CUhox+C8fWEV75yQh8AAJIwWwYZcohBx3l64k4luqAkIeT0hI6MJ1BqYiF
	 YZFXpqFXT7gnsnUtSbZhLrYgGavqxaWHyMU0ccnhXdtsCTyqAiZLdhxe8zbee8XxW3HKF
	 1TGGUU8raS1hxpqH/383oVcoZrrA5M0RS3gGJV9ms82/ZiySNZtPRcE4tKVemkcVFBQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256 header.s=google header.b="PzCiVP/I";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794573385;
	bh=HxkAVcIMKMXakGBEkh3sO8r+0H6ztXTVM55Ez0tZKwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkLi8QF1PM/CIAv7j8sFbOMeVkMPx79bgWvvbcMftuLboVYJEZireZoKZklTACa6W
	 PHT6L9B8JQNR6YEpZm5wpR/adWZvWHaIUBDDE3wtSw9xNFidBPu9qNRqo1+q0wqmTR
	 bM5p3IXgTOm9IRMc2l1rE2FxT7A8m5/hseuLieZd8nH+kJDM2WxWyZJpuLNw4EMQu8
	 9RkdraVMwu572pv8jkskCeCgEGiCalurzSKoESiBVEiY1QS9IiIfAMHTtBSzK8Psdo
	 23jD4yChvSxXJ2j9Xo/X7EuDuqNa0HyXYHFwTqPmpD37VLhYuPOoXDMja6DeQKUXbC
	 kgz33Vx2oG06g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C8C481DB2;
	Fri, 13 Nov 2026 12:36:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1F4BAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3D2681DB2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:36:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3SOAm1209Do for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 12:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E9A381D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12f; helo=mail-lf1-x12f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar.com header.i=@riscstar.com header.a=rsa-sha256
 header.s=google header.b=PzCiVP/I
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E9A381D47
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:36:21 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5c15956ce07so1991608e87.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 04:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar.com; s=google; t=1794573379; x=1795178179;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HxkAVcIMKMXakGBEkh3sO8r+0H6ztXTVM55Ez0tZKwI=;
 b=PzCiVP/I3AT/TOK87cHcWN6Xr3FeZ+XY/3RIZySuOpvjK071WpyzGembYjsKHSS1YJ
 EhQ5Vsovs0XGBmuP2oF+jvp3tOV+BtOwPXRpmDdXCQsnm/SSV4zL/dDzzARQFq5p1foO
 GhUDITlXq7GHV7dlbgwTzEdqhkAoh/RuH/1zSeit0gUMZ9EfzWF3fny3HeAYrySVRK15
 3gkE9tp6txvXuysrKeRJGf0IF2G2RnlyLu050AWu6gxaVKVrlfSXXXUiDkpTdyvTXsHT
 dk0IlE8tRwWlLD6oEQOJYiG9vsKwqZ5F0ih5be2An/mxgFi7OUSzqnx8vwq4vQUlcjdv
 E33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794573379; x=1795178179;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HxkAVcIMKMXakGBEkh3sO8r+0H6ztXTVM55Ez0tZKwI=;
 b=QwjrDi5o4A5EzW6f+uDoMP8Pt8Bm3yMdsoyYaU//Gmt9nq5gFbMueTAMqNkk72hW2Y
 xohsL1/lGoaKh6MQjDz+X4LVBexYQnSv6U+MIrDA5OgKsN3nkYxOUCMdOVESSwFYAZO1
 BiMAzIi73fFbVUtY6dVRm20p8rNs2pC/Nfsp1FaeB/MouaeYGpBV4imrq1Zpxr5Jgxkt
 LpjuMR2pUWGM9FDlmvpsGyhOvqe1FS/utLEAuPlTmJNiKFMX4uSXOOSI1qkifeKvoYSN
 ZIKglrBlOipz7VmNvr8XeiqRkC634jZIc9hFAB2ocxrToKwjrvmXPTkMtzg8yFcSnS/l
 tN2g==
X-Gm-Message-State: APuU4Z8rzMaP5Fhaf1VAqwEpYpzzpkiZ8M27s6KwZCdTe0ldf8Moxv4u
 h8t1/SXxxAYiKCTWjnjveEK7Nf87UHbs++YI361a6zL3vT5mlFo60hEhzQoJUpRRgIJj82Y5Qbi
 3eTqqywviBb4J6suuLHBhejQa/qdDecrfv4pStRh6C7P2ipGYklSfawI=
X-Gm-Gg: AYBFou3T9U+FCWpW/bqwr+ij4g8g//QmbZ5y5ENJe8no0vm9XvCbZPD2qkIAD+ZCcRB
 /sM9Sqyw/TBS1pCnhmUXL8+eBUdGL9E9du8EXnIuiAnyqCZyXohod39p97xkE+gBMyCjpbvfbU4
 XZNubRMxMMSAlXamg/RaRowklIh6eVd/YLmqxGwC1/q8wsZx+UPRUFrVorOZrj1u/asuwyg1O1R
 FC/OpBQGUrSaai4xJ2iu+HHgmxSPbzHmP5aNuoKN5dFt2VECn/0TtHavsN1yqpzcf/KnFEGA61O
 aNatNoY5xdcUJXG8eQnPIIyceRGZeTOwE5DcoCMw/3YyLmSF8AB4leGVCqmSXVert65u7Zwe4w1
 7q06IFAD+mcOzZI63U0sa9rnX5JnG2gZFTJgdDOq91Z6lj+ynIRFVCSC5o86jwGj3ebUDjfj3VO
 1nrhhbTzlL3MEWbVQslRXBQHSgc3e3dZrzyEoYRWOBDdRfLjlMu+zt7apdrEaaN+oWKXnpiA==
X-Received: by 2002:a05:6512:230e:b0:5bf:b6f6:e81a with SMTP id
 2adb3069b0e04-5c170b1ec12mr850526e87.19.1794573379577; Fri, 13 Nov 2026
 04:36:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-02-k1-sdcard-fix-cd-v1-1-08f89230a13c@kernel.org>
In-Reply-To: <20261111-02-k1-sdcard-fix-cd-v1-1-08f89230a13c@kernel.org>
From: Eric Chung <eric.chung@riscstar.com>
Date: Fri, 13 Nov 2026 20:36:07 +0800
X-Gm-Features: AclHuK84gpAdLUcYQb9BsbPdn4fXb4-aF054zEo6wh5gwVvcwJdYlybkcftqrFI
Message-ID: <CAH22mJwERDKaUSbYdSqRoq6m+xqXJdEYz4MA0qCVNiLY9URFnw@mail.gmail.com>
Subject: Re: [PATCH] spacemit: k1: fix SD Card Detection for MusePi Pro
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io, 
 Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 6:50=E2=80=AFPM Yixun Lan <dlan@kernel.org> wrote:
>
> Previously, on the MusePi Pro board, reading the value from the
> SD Card Dectect pin always returned 0, and cd-gpio is overrided
> in dts as active low, causing the system to always treat the SD
> Card exist regardless of whether it was actually inserted or not.
>
> With GPIO bias patch[1], the GPIO_PULL_UP flag can be passed down
> at the Card Dectect pin request through "cd-gpios" property. So with
> correct pull up settings, the SD card CD pin is just work fine, no
> need to override the DT property, so use the default from dts upstream.
>
> Link: https://lore.kernel.org/all/20261104-02-k3-gpio-pull-flag-v1-0-de9f=
0a9b7669@kernel.org/ [1]
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> This patch try to fix SD Card Dectect pin for MusePi Pro board,
> Please note the GPIO bias patch[1] is needed along with this one.
>
> Previously, without the fix, SD Card Dectect pin is configured as active
> low, so it assume SD card always exist no matter being inserted or not.
> And it will abort at later command phase when no card.
>
> Here are U-Boot logs for cases without or with patches applied
>
> Case A) Before, the patches are not applied
>
> =3D> gpio input 80
> gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
> gpio: pin 80 (gpio 80) value is 0
> =3D> mmc dev 1
> switch to partitions #0, OK
> mmc1 is current device
>
> =3D> gpio input 80
> gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
> gpio: pin 80 (gpio 80) value is 0
> =3D> mmc dev 1
> Card did not respond to voltage select! : -110
>
> Case B) After this patch and GPIO bias patch applied:
>
> =3D> gpio input 80
> gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
> gpio: pin 80 (gpio 80) value is 1
> =3D> mmc dev 1
> switch to partitions #0, OK
> mmc1 is current device
>
> =3D> gpio input 80
> gpio: pin 80 (gpio 80) already claimed by 'mmc@d4280000.cd-gpios'
> gpio: pin 80 (gpio 80) value is 0
> =3D> mmc dev 1
> MMC: no card present
> ---
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1=
-musepi-pro-u-boot.dtsi
> index 200836cc204..f2688a1868f 100644
> --- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> @@ -131,7 +131,6 @@
>
>  &sdhci0 {
>         bootph-pre-ram;
> -       cd-gpios =3D <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>=
;
>         max-frequency =3D <204800000>;
>  };
>
>
> ---
> base-commit: 26a75ef02a879b08f1140508aaf9f0051f73d5d5
> change-id: 20261111-02-k1-sdcard-fix-cd-2a6fd1272a99
>
> Best regards,
> --
> Yixun Lan <dlan@kernel.org>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
