Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038C606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XgJqIjrz;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ndt5zO2f
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D42D40603;
	Sun,  1 Nov 2026 11:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mAt3kgUtidsU; Sun,  1 Nov 2026 11:33:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A92A405FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793532832;
	b=evadiNvytfMRP2KtG+B7coHrLbOW5ad0QJq6HMmyvU7vAoPoiHhnCuly5DKEL9fSiCVc
	 AEQeUrjp1YS8/xUIsym8FxoA7a3BwT4ZSIU12SRO/WV45c3cJF84tFSkPW4W6CaTOA3Pc
	 NYfuUwsTozgvKie8Xz79xSNSUZyS/rUwEgY3RtdvzMFzRh0sVgDpPhx2EwdO3rwrT9mQ9
	 mhO9TtjpQYRKqiPg/IL9ChbT76NJ4hgQKyJaxDCsjmZQzaBWR0W8BJKF7ZxZcACA4p6XC
	 xihfbZj3vzITkHyx3y0yay4M4al7R9uFGo83S8Ga+ghth0AVZoDE3ryeUXSVrdbVmbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793532832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
	b=hVLVuzPDiDO7tQ7P6Jyg/JVFXyxqXPj6M/8UBCR0jzy5eB8dnhzNs7H55nyfCZoTsjVd
	 UlgUluIw1Uj/HDpYrhvWc+xzYl7Urt0nDBnSTgF6CayHumynSmfHhB/YD2XLxCiutrxdH
	 vdMT7OaMzH4p9InnZ+KKR3ZlZZIkNzBmBehXep0jSJssIzN52/fiWeofUf32jB0CaCQGC
	 IxamJIoLiQdnRMh/SGX2mywc3OqTkPf0D4iFTyWkwFEBu396/2xmJVG2/hbtyQR5MixVe
	 bzuSaKGYHlSCD9IMF/W3H6knOeKFX13av5c0K50oVrEJdHoc9lRSglraVXHdDbiwQlw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793532832;
	bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgJqIjrz13DF84tIvhB1cxCb2VQibpqSmDpQ4ns9p86n0vBzAKguksHdzKajCZ9Fi
	 1SwsKmrLWGvUcpavKQ1ugrmdtkLbd4IiSJAleGOXL/ROPCN0IhYNc+Abu0UJ0AQtGB
	 UozHr85LqArMzyE77XuJE0TbNoi7stuhFWLzZb83HYUEHiLz3MjBm1Kaw3O2aAsOQH
	 5xeb0aiqyMBObck9relh+ClfSId5K2DFUsrS+/wTWGA5LH4LN4ZktgxdwN5WxMf5SK
	 CePk/OKulvF/LMrFZZaej208YBlYDr9ixOI0RgUagnziOInpXOsGlRTPvQdjItTqOR
	 B5OV5MWSHkhLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A92A405FB;
	Sun,  1 Nov 2026 11:33:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE4264BC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFC6660623
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qPgThsN94H5 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 11:33:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A856260602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793532830;
 b=gAOKSTe6agrc8EPeU88+2HMyasOIu4WcWXOdds2nzqnH2Ktl1grV+f3sgxRPfr1EfTX7
 bg4uxI+wXL5NLftoYZjuxz+pXnrOSzP3h6LMCY4qSXfR99pVfpskwWmOoa/pBAUOu1j7x
 tIR9zLV1loGg13nlwrw51yqYnwlaGHwnP6QnuurKF4TLsAE68OtIXeSshytJTfbo4MWw6
 ZUhOMuOxOGzhVsiy7kql9u9lrqEzu/TfCQKeglWU0MT46VaIoimmk0sWukbYuKpXVSgOc
 9WDcOZDj20IlvgCBK22cpyzAbjsy0hEoIkD10vuHlDgpN3Al/+83td6qIHsmetzl+Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793532830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
 b=VJr8mJPAT3GitFCwoG4bsZyMXPIDWddhMsUp8aomXZ1mPLxff++KTl5h3RK58TAdbunp
 T8O06LXPTv8scgAzSWYQTkQgwWOI9D451QeVhZh25AXb4TRn2T21e2Fkx563bSErFppXI
 7/vYzwxko0sqA3A0KJj+MIwN+fGw20MvEPz7CH7COyGrXM5tDZ2VXqJiZxtJPs1yTOxOb
 J+mZWHQCAtKcTvfeX+kdeIGgrOx250UWnSVbs647XuKi0FI3hP63cEq2xJ4AFsuRRHzSg
 4MKReGuqiFj/uPuq5IwXkl5KIUbxDRFac+fozJiCO2c8r+MvZF6qF7fw6wPFKzwenlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ndt5zO2f; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ndt5zO2f
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A856260602
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:33:49 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0a921ee46so17412097b3.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 03:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793532828; cv=none;
 d=google.com; s=arc-20260327;
 b=J4+ne/HM/b+sEniBKwPgSODYOm4I6vVWZtQQT2Xkr1t/f8VvbhSxUWMKbje/rFvRIS
 a/0v55B50YLQYLDDL2K1f4qJYkOoDInWFyxg8HS+wXY76p39L63opIXaB5n7Tu76oomc
 i3TONCyF+kdLLD21CTG+arvvO4StLkq+R6LaYe6Qbr7B404+wfC0aTvBec/ssPx+1D/L
 PzYNUqkDN400wur1b4rM9UC/GP3s9sgXS8IxUM9LAG4UAVRGEkMknITQ3AI5Dzget3ph
 pqiuZd76KImbWLWDNw6HPDPjDsX7WL/2ThOY3bl/eblpkVCIXOkewicV06Bp3gF6ahkE
 /DXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=K/LYmOx//6Jkp031rjJMPIrHcmeOASA7/Tjmr7ZYSn8WKh6i8s1A0rwBr+vTXuoBzu
 D02wFwWK3wKdyS7WGozB/H4imKVoifY5dIjsQfG00f/Xvnx27PpDEXU0BGELBDGw0CKL
 epOdl+CkyXiNtK0/iI+R1HwNBJHDzxmYMjKETaqZIXfpr8v7511zbS2n7d9XFn+yP3f9
 HZBsqC7S0mzo2uzhK0wTXTQmC7Qc4xZ/7OnH99TVrHr75Dt9L14u3MoRX98nWRHF2yc1
 ++I92Qboo1pn/m4q/IyylXq4dN9FyxR3N/inPh7+V43/jOGKwaaWXX68jSUwJuZ0tN4x
 zkuw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793532828; x=1794137628;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
 b=ndt5zO2fFU3UPUCLA3HUQgZdZSdAwYpdDty3FQ+uvjNEkveMT+bhNVLrGq0L+dyH+7
 sc6+T8S/trvPCge2jD/M4SvwCAKNUroZruAW2qEdcAaTDJF8bAbZS16ChDC41NWbdVnz
 uIs5jaf/xT6pPsbbkWFoYSiRgR74si1E3IXhmc6YPVit0AnlnroNGipqXe+AZYwixDKU
 MceWo/gSgeFqVApnFqN7Q2cigTxAj2Fk5UIzbFf0owevgVEKbR3z2YvdkqHjLbAqxf3S
 mrVKlUuD18urcVsQqqXJEqOX+ZVw5o6D1oTsI7bfC5U4kT8kGDQFezSilNshZH5tAqsl
 layQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793532828; x=1794137628;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SFatMKQceOkp8+zZyxqdf2FXnnXT+HLwQkfmF8hviho=;
 b=LS7bKwYo72zbqe1FuOCxVqVc6z2uruvTmGNJDQ6dOj9rC9DpuHv0u2ssMqPcK0waqN
 gUkIK+yzSCSucyDRu5x58O2w+tgw3b/U2I1F2uIP7yRlXmASoZNQF2C7/y1uUgadJ3sc
 tJIzZe7UojvfPIZiPY0NYsR8PPBi7qFaarCEpNvF5HfW9/H+1Bj4k+aU1Z3NfliTO44T
 7k+xGy+JHj1tMDQtl1NhgX/vBX7sYgmZXamLJIonIdXdEptPPE954jjicT49QuUJMEPu
 qInooSMARA9//bAAgnby7uXldFZ+M7eNJg079n1eEINK2U/EdOsqzzvyx2EKf+yZZ59i
 I6sQ==
X-Gm-Message-State: APuU4Z/RABcThySSZXMQbEpupt8+9z0SpwOqyMcwhvZURzhfl6KJK+ut
 Jn6lq60/vHwDPwZyErotUyKYoVWxuvVDaDQXss3tWHz0VHtOj8ggqfiibi5Qx7XBTQFNHjC2qDC
 nNw0hv/+Zy/RYggcdhqPCGjIHgAfGxroceCLCo1Il+A==
X-Gm-Gg: AYBFou3mwsnqPWlZnkeKKHZivf70zs9nX86wAB13Mgquj7ZlJ5rwSZkZ80jz0j0/FPA
 A+SO+dmFYayPIjaH4UBLemDEKxu2w9lpwiKsOavmak0Dw7BPo5LCiCKKyxaN2sRDX767fhGf936
 ZbHNY+ZFUQlRnAnva3IWHibnUOy7svVDhft2xOY0Z+HzfN+dWd1QIDhkYPUfpcXp8sAIEzhxUoL
 f/+fqP3LZvoWdbcq/lWhkcmQwurfjAzUWo5THKdTvTM6vM5nQZ4CO0joXksTCf9YSDGhUivwiYG
 SDWPYj8xyVD3+A8GO5BVb6RY6tLqmbFY4O+NVCn1mbLxd5y4BdOv4sZ28qDtC08MF44BC8SRp4y
 s87Iaiu0M1ORNqR8pWhwmtg8x6aSoS8GcvlbGFhdneyfRtquTeWrnXgLMMFYYULXG3fXyITo8Nv
 OSapjW9fC0rrYjQozolvDbVOH9DSug5qDyY9JoLVYdRSFgUitW7ecITBEbxAfg6OO6auwMwNZkH
 SyReIC3N2L9bfGhMyCpODxgvyFg3AYixd+bickAAyVIc26xcYHSBtOyHtc8SyQeDrI+eNQR/5Og
 qVXagtRomktedur798S/umE6WRrNrRlVaBqtOCkt1Vg1ejpgHoTUo8iRlE2KnczXMymldiiZOL9
 McNG9/0Uedgn3g/QpTsYwle5tz7VB/QP8XeTGmHeW5AUCsnqme7iwm7HwJlhIjMzLQWDB/lRevP
 fg/vU5cFWfB8DMyYnORE2L01C0bBbxj+sOX6U=
X-Received: by 2002:a05:690c:8f:b0:8b1:86ae:8ff6 with SMTP id
 00721157ae682-8b2b658c773mr39724577b3.15.1793532827675; Sun, 01 Nov 2026
 03:33:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-4-tkirchner@emlix.com>
In-Reply-To: <20261029150906.1558380-4-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 1 Nov 2026 13:33:11 +0200
X-Gm-Features: AclHuK9dYFsg5nWcCwAqPhjs0FkHTBWX_ARn5v3Oyo2-8MGLXm6EiL6snP7YvQc
Message-ID: <CAC_iWj+KMC-9UR6o6jWpOku19OpF4kPGQ939uiOfa65XJYbd=Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] tpm: detect active banks with algorithms unknown to
 U-Boot
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 17:09, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> tpm2_scan_masks() detects active banks with unsupported algorithms by
> comparing bitmasks taken from hash_algo_list. Algorithms which are not
> listed there at all, e.g. SHA3, have no bitmask, so active banks using
> them are never detected and never deactivated. Measured boot then fails
> later on when the digest for such a bank cannot be created:
>
>   tcg2_create_digest: unsupported algorithm 28
>
> Track active unsupported banks with a separate flag instead. Also return
> an error if no supported bank would remain active: nothing could be
> measured with such an allocation, and TPMs may refuse it anyway, as
> observed with our model.
>
> Fixes: b6228b2e785d ("tpm: add wrapper and helper APIs for PCR allocate")
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/tpm-v2.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 43ca54621d8..b727c645d73 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -66,6 +66,7 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
>         struct tpml_pcr_selection pcrs;
>         u32 active = 0;
>         u32 supported = 0;
> +       bool unsupported_active = false;
>         int rc, i;
>
>         *mask = 0;
> @@ -87,8 +88,19 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
>                 if (tpm2_algorithm_supported(sel->hash))
>                         supported |= hash_mask;
>
> -               if (tpm2_is_active_bank(sel))
> +               if (tpm2_is_active_bank(sel)) {
>                         active |= hash_mask;
> +                       /*
> +                        * Algorithms unknown to U-Boot have no hash_mask, so
> +                        * track unsupported active banks separately
> +                        */
> +                       if (!tpm2_algorithm_supported(sel->hash)) {
> +                               unsupported_active = true;
> +                               if (!hash_mask)
> +                                       log_warning("TPM active algorithm 0x%x unknown to U-Boot\n",
> +                                                   sel->hash);
> +                       }
> +               }
>         }
>
>         /* All eventlog algorithm(s) must be supported */
> @@ -104,13 +116,18 @@ int tpm2_scan_masks(struct udevice *dev, u32 log_active, u32 *mask)
>         }
>
>         /* Any active algorithm(s) which are not supported must be removed */
> -       if (active & ~supported) {
> +       if (unsupported_active) {
>                 log_warning("TPM active algorithm(s) unsupported by u-boot\n");
>                 tpm2_print_selected_algorithm_name(active & ~supported);
>                 if (*mask)
>                         *mask = active & supported & *mask;
>                 else
>                         *mask = active & supported;
> +
> +               if (!*mask) {
> +                       log_err("No supported TPM algorithm would remain active\n");
> +                       rc = -EOPNOTSUPP;
> +               }
>         }
>
>         return rc;
> --
> 2.47.3
>
