Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DB5CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 17:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B057406FA;
	Sun, 18 Oct 2026 17:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gawkQ5YJlsNv; Sun, 18 Oct 2026 17:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5ED1440608
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792343805;
	b=TopKF4pWbZtPSScjubnLUleepIMHjMW9EwelRVL9PLSu+ZaAYOlT2eXXAoiGzoYHGuE0
	 2QU8M1gFEBLOHuhpPf8O0Nh65Ga+O10m25dYC8pNnVHTW866nputQQh/HPQO9zsr4erqB
	 IadviZkZ4YZ10QvRxYQbQVOjhY5tsJEA2irGfzMWM1axLwqLMz2FxxMuTL+iFt2rRkleB
	 CrJ6aD5XClftIcy+0/I20s4ACqO0o/e4Wz+KPljOrCDgmBa9gPsLBP4O+lqyeQQXmFK51
	 yuJjG4OjaVqtPme88E0oAVrho3Dyj3wykhKu40LhYEjxB++fVe5vsBFtRO1xY2CiehQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792343805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
	b=HPOK7dmj0uyzUPFmHfEbbDZVsH3Rj/K7Rgav5ewBnmnI3TAyXOKMmwNuklbPilTwLXWI
	 CksGTcWQxgr2LeulEDBqf1Y0qhvkgY0x8CzkhD+kPug3jBIEyOILv3HYvhvNpk6BW8ZFN
	 GD22ryPe2dEWfoGg8VFVKG3mE4pOUcylE8Fz8N8tdM3xmUsF6b1lJPOgtyIrSS/Aqk/l7
	 aJb2mqNP80Xx9vRuMqrgunSZy2WRbAxdDuP/WL351cWN1dnUIwZz+ueYPh741Wo+iW55N
	 leEZzTLaNcPcer7yANw4GnTLBPVJLdmu6eC4xCfS9lqswwnm0ASDvvRxBueY2PQoyIw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792343805;
	bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gYnMw4AXDIuaasNibqpfH28hPFYzDTm0OVRAVEmFwajBwJDY2uyX+XnPisOnJElkT
	 zWANN1qXMxODGsvJktGmyFMyk12PbowLXFw8TWmxRZFj7Ol+0Sa3qmGNaQXWkuillG
	 ByxcTLGMBufviQubS9Jza1zZ7/ihIdgajNijYjavs3RWFP6+yQlw93AtdqqcBWfrKP
	 AWEKWgNX4w6apiJi7K2ylWfM5ywh9bOHbSimQ1nXjIRXj5zFEW8tdgxfXmqkoAXhZF
	 bcx+4SXhLxQ4dQstv0fSDxq9v7F9K3pqLDZClylHDXQduX/MzGOHI7oE7sqYgUea6P
	 AFALFH+yk5acw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ED1440608;
	Sun, 18 Oct 2026 17:16:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C65731E9
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 17:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9D0580F90
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 17:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gB_dYP0W0kNi for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 17:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44FB280F82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792343803;
 b=bBnE1NMGsmsnurV0AW3bext2LTq09k2/XPnbXFOb5s9e6PbENsswqD7QPONoa4jkImE2
 tclzu09feaHTngoUEoQUzOTHQMu8UgP/ieQ/gJxHZVvRgtTAQ/SITTilPrhrU8GhdK5bv
 Zwu6pC3NGsQOe3JSYJ6I82XQTlAEdat+pQWuemb3lcOit6NLvFCy+Y/SxJeDFMInba7EJ
 pQHkvI52YZ1/Pa+sdZwoP0I65xLTIRhgJpT537pUlLQmdmPfYgsXJ+txidBiDAe2+durz
 gJ36jSUhn6FWj7FOzEKFOLBMDdPvpcoxPur8B5o7hGwYol8AW4b7a4U5wwUcaYno5wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792343803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
 b=D7wyjltrK9O24kOooYOzFZ9Y1ZXyJqMJ9XYYHRqhd2pZv/+OmZbjp2megFs05K7tCp3T
 iJedWUFDcribsqDllMxCEPmCb9xlUo4WnTxfksXEgnIz9IqNHYf4oc3Aa6uhnH8h33Z5J
 1omjiDIl8kO2oLNszh4ZH3BkW5MuPeMOfSrz2sj8xqTaNl6y50QQpjetFliBoIDJzIcVe
 +cjXooaPGj5yVjjhETQZ034IU47S0f1qobQUjN2nDd3US2EO/fuhuPNmFoTQFnubvvdOf
 ll+94G4x2JFk9GoATbZRuZgZbCQUF7W2OECkEOQ2S0hhfRjKsYs6mdMybjNiHXvjhCQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=l6MElwmJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=semen.protsenko@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=l6MElwmJ
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44FB280F82
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 17:16:42 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso7516147b3.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792343801; cv=none;
 d=google.com; s=arc-20260327;
 b=Kj6qs5+Ty4VYvlHSMSeQLMwJGRMlk/mechyQGDGrVFWmce2u6eXw+hoZo4IdeI699N
 X2mIsO4NvYlBgZ6wHBr0nbqf3J5VIhoWB6PA5LgadwjUMuE9rZku8kszWdRLEOh+QA0K
 NQ3HtdiJyGJ6UEwrc3t4X7AUwwxAY/U2bi3A/1ZkbG95CkY4zpUD8YJZRMU9rQ8TecYv
 bZe+rkRBb1XkHWOfLCjM5nemgLLvzdp0YDt6TGFwUh6EThG/mrYxNHkvdeVnR5sa7GDY
 9BkH5NvbZDT2M+14vYkap8w3G4NQ7yMjCSX76BhCHDOLKi2LuWiGlejofZ73U/QnUuET
 Ad1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
 fh=oK7cbSORsFlyqJgI90GSJljMunw+bI1mMjAk8JRFxAI=;
 b=ired1PgTpucDL1jRFbhe0QqR7A7Qlt91k0IhAHLYOdcZ0sc3P4S/aRqScGbHM+ftR8
 3NjQvUdslfcyeZs4f4T5txcGSXPSOWCPFJes250aC9ry4/sjfBg0oN92jNDyIzR2ptCb
 Cb6K7KKsKwJ8+DaaBOBqOqHTSK/44zixE6HETIQlh5RcYJxTz4W+RZroJ4truMNgQs/B
 T1PmetFdLCB9q7F6ygRft3rLaGRJjoO0mjC0Zl13V8cHU5PMgMZBhvAK5yA3d0dvchU7
 W0On4yqLlIOo1glz9UGGS/DJ+ctl3CmKANeDlSlALK0XQmMFUM4GALIKiFSEuKirGC0f
 BuCA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792343801; x=1792948601;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
 b=l6MElwmJ57I2LCgaoJkj1oa04WrGUg/IymW40OKFqcSEFUn3IH9AzqojBsEGtq50vZ
 JFEfQJfR0mtfJ4cVCYXz+AeH4TbUtVX8oy7C60G9ITEYy/sJi2iD544HE8ux4f4AF1qd
 IUPUnEXXczk+k61U7p7Zvt0+8NdyWwoptE2/dorTeh4n3nw79jy5ompnsyRCLBz7J/ix
 GeCb94gAObmDLBlspLte5OA6UH/EkXwDUKAnN2ZnK3SqqON5pwW4owOaBmhz3u0Dff4g
 XVE7RLsiCuSvExh9y6+3tWTZCjGw1ZsNYkHhgcMohoQO53MpiBh1+Jvi5JjSUrlCTpD7
 KzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792343801; x=1792948601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgnk/6qS0PmUcGU+dIZi1B5K8MZDT94/tHjnEaQxtys=;
 b=AaP+lBbhvQnJVubtU2lKHqL73Wktw90VojSvR1gbNmlggCh30v+Dmfv/2W1iB53bzV
 aqVkvh1S5gldLFuSLLrWohrXCaEAui9IKFFMVeEhDW3DlQtSBmxBxxsvTz774P5UNB+U
 1v+LUER8dIZjASusUL50Uiu788x+onk0jZaoqYqI6MKhK5o+9mJZ/ychNEV/IJ4Nzcxm
 mBMwW/34nCqty3V3qktq8vST0E983wuCrVPcpul0FKJ5eF76kPXZCyjM8E/xwaQQlVnu
 abdfhU43Favf7sxEFXi/TWhn9hnTdq4r/1as98TPJbLa5YCKVlMUNuJz6cx6My+OBgtw
 RGzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByF3wJ610X2F7vjyD6qvdOjIYEF2lbPHdG6G3Uh3qTWLEWJ97ofUvmHkuDJOsrw9/8o/qu7/FQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLVI4GlrqKCdrHw0aQXleSaGdpXCUm5XGhKGGOVBUdwTPfcMUh8
 wiqLOAhnqCxb5mCxcoZL1am6kf483sMv96a2sxHqXUs6TeZshasZWmESVccMsVPTJnZfT1OFMHa
 XfStKVV5F+L80IVPjFwzPUCQhdb1q260dUExzhbgOyQ==
X-Gm-Gg: AYBFou2vTb0C1EBejv90uT5m6fF4DAXQqhW73WvU7gEw4kXEMLARjnAqOeRc/o2ZgmG
 MXj31K/DwONG+EO3SKnocUCqUV8erezSj8dRx0HwphC952TsdTKoQKcTjH/CJcn9pjG9FXdPibe
 4pDS37tHUySdWWzUy7qR5oXLdDZvguroIB6WfdhcFTfMSWWntZ7k18LJVrV5AlTFXb2iALhqr1y
 1GMECtVlGqt9jE7kg387ovF9sWQsSpAd2O6eie9JdfB4+emOmmnlD6xCew0yqaXx27YaLjzzesZ
 m/QosignAnMwFiIFv5pWpKKU5KMK8Q1vUZxMncpebMfjbSBjRgINLljW8fO6Thd0u2PWokrtUJj
 zGuaK6H4xGNvycXAgD3lKzBBF5g==
X-Received: by 2002:a05:690c:39a:b0:8b0:f074:75a0 with SMTP id
 00721157ae682-8b0f219a675mr18927847b3.23.1792343801129; Sun, 18 Oct 2026
 10:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261018043128.26916-1-semen.protsenko@linaro.org>
In-Reply-To: <20261018043128.26916-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 18 Oct 2026 12:16:27 -0500
X-Gm-Features: AclHuK-ZrioPdQcEGtTiBkHX5MsVUddZiHDW_6R_CXHsAqs4Ss-Rpw13rzSaYHM
Message-ID: <CAPLW+4kL2L5PF98XufC7+9bPivbQ_fMPz5P0fU9nju6=i_7etA@mail.gmail.com>
Subject: Re: [PATCH] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 17, 2026 at 11:31=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Since commit a3075db94d49 ("lmb: Reinstate access to memory above
> ram_top") secondary CPUs cannot be brought online on the E850-96 board
> in the Linux kernel:
>
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU1: failed in unknown state : 0x0
>     CPU2: failed to come online
>     CPU2: failed in unknown state : 0x0
>     ...
>
> This is happening because EL3_MON (the Secure Monitor firmware, which
> also implements PSCI) cannot handle 36-bit addresses in its CPU_ON PSCI
> function implementation. The E850-96 board has two 2 GiB RAM banks: the
> first one is mapped at 0x8000_0000, and the second one at 0x8_8000_0000.
> The commit mentioned above changed the LMB behavior (in U-Boot) in a way
> that the memory from the second RAM bank (which is mapped at 36-bit
> addresses) is not reserved anymore. The change in 'bdinfo' output:
>
>     - reserved[4]    [0x8_8000_0000 - 0x8_ffff_ffff], 0x8000_0000 bytes
>     + reserved[3]    [0x8_ffff_3000 - 0x8_ffff_ffff], 0xd000 bytes
>
> That in turn leads to the Linux kernel image being placed in the second
> RAM bank with 36-bit addresses. The corresponding change in /proc/iomem:
>
>     -   f480_0000 -   f67e_ffff : Kernel code
>     + 8_fa80_0000 - 8_fc7e_ffff : Kernel code
>     -   f6b6_0000 -   f71a_ffff : Kernel data
>     + 8_fcb6_0000 - 8_fd1a_ffff : Kernel data
>
> As evident from the Exynos850 device tree, it uses "psci" as a CPU
> enable method. That means the kernel relies on PSCI firmware (which is
> implemented as a part of EL3_MON firmware in case of Exynos850 SoC) to
> bring up secondary CPU cores. So when bringing up secondary CPUs the
> kernel makes an SMC call (for each secondary CPU) to execute CPU_ON PSCI
> function (see PSCI spec [1]). The kernel passes an "entry point address"
> to that SMC call, which is the address of the secondary_entry() function
> in the kernel, which should be executed when PSCI returns to the kernel
> from the SMC call:
>
>     static int cpu_psci_cpu_boot(unsigned int cpu)
>     {
>         phys_addr_t pa_secondary_entry =3D __pa_symbol(secondary_entry);
>         int err =3D psci_ops.cpu_on(cpu_logical_map(cpu),
>                                   pa_secondary_entry);
>         ...
>
> The pa_secondary_entry is a 64-bit variable, which is perfectly fine
> according to the PSCI spec. Unfortunately, in case when that address is
> actually bigger than 32-bit value, the EL3_MON firmware doesn't execute
> the function at that address -- that's the reason the secondary CPUs
> don't come up. And as discussed above, the kernel image is now located
> at a 36-bit address, which means the secondary_entry() function is at a
> 36-bit address too:
>
>     - secondary_entry() address:   f67d_f5a8  // 32-bit address
>     + secondary_entry() address: 8_fc7d_f5a8  // 36-bit address
>
> It seems like a bug in the EL3_MON firmware, e.g. it might truncate the
> address to 32-bit by using a u32 variable (instead of u64) to store it
> internally. So the right way to fix this issue would be to fix the
> EL3_MON, but unfortunately it's closed source. So instead just enable
> LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9 to limit the available
> memory to the 32-bit boundary.
>
> Although this platform could benefit from having all memory available in
> U-Boot (e.g. for transferring big images over TFTP), and it looks like
> there are no hardware limitations on this platform too (DMA has 36-bit
> support, etc.), limiting the available memory in U-Boot is still the
> easiest way to workaround the EL3_MON problem, and 2 GiB is enough for
> all use cases in U-Boot currently. And of course all 4 GiB of RAM is
> available to use in Linux in any case, so it's not a bad tradeoff, and
> in fact it just brings back the previous behavior (before the "Reinstate
> access ..." patch).
>
> Enabling LMB_LIMIT_DMA_BELOW_RAM_TOP for the whole ARCH_EXYNOS9 family
> also seems justified, as it's likely that all modern ARM64 Exynos chips
> may share similar EL3_MON software, and thus possibly the same PSCI bug.
> For example, a similar issue was mentioned in exynos-mobile related
> patch [2], stating that after "Reinstate access ..." patch only CPU0 is
> able to come online on some variants of the Samsung Galaxy J6 (based on
> Exynos7870 SoC).
>
> This was tested on the E850-96 board:
>
>   1. Using 'bootefi' to boot the Linux kernel image
>      - before this patch: the issue is reproducible
>      - with this patch applied: the issue is not reproducible
>   2. Using 'booti' to boot the Linux kernel image from 0x8_8000_0000
>      - before this patch: the issue is reproducible
>      - with this patch applied: the image can't be loaded there anymore
>        ("Reading file would overwrite reserved memory"), as the second
>        RAM bank is reserved in LMB again
>   3. Using 'booti' to boot the Linux kernel image from 0x8000_0000
>      - the issue is not reproducible
>
> [1] https://support.arm.com/documentation/den0022/fb/
> [2] https://lore.kernel.org/u-boot/20260614-j6lte-lmb-v2-1-6046b54db536@d=
isroot.org/
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---

Also, please add the forgotten tag:

Reported-by: Alexey Klimov <alexey.klimov@linaro.org>

>  lib/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 021a82d47092..e0bfd10f2b7f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1371,7 +1371,8 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
> -       default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARF=
IVE_JH7110
> +       default y if ARCH_BCM283X || ARCH_EXYNOS9 || ARCH_MVEBU || \
> +                    ARCH_ROCKCHIP || STARFIVE_JH7110
>         help
>           Some architectures can not DMA above ram_top boundary,
>           which is after 4 GiB or 32-bit boundary too. Limit the
>
> base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
> --
> 2.47.3
>
