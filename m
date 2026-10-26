Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA7606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SXSF/koe;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iJCHz2+W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A982580DB8;
	Mon, 26 Oct 2026 16:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdGB4hcro-sb; Mon, 26 Oct 2026 16:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E213D80DB9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032464;
	b=OacnW0M9J9B8twAqVgxAWWRd284K8aKNyiMgk9epZ8TIbotcRvD6SrlkhNWBmBpjoOCj
	 3ZaXAhRbBRb3Nu4T3wWSiQijVrHSORUZ+y62TsV3B+RGe1IezBoiY1f7pwnM1lH5BPAfF
	 zP1T7PcPFFFLbQfWPN/ta7Eq0+nUO16w5mfLGYBkNMF7+JA94DcUiHTq6XVKj7Qb35l1M
	 Vv6vEnhXj9nAKBXSKi+udaHM4FmOn5cBCoLUj10cSX9DlwxPdL5A3mlbs1mwLDLK1HlIV
	 6burP5bACDpbyO2QBdC1B+YCqhXCY4UJ178PqV9dgIuI12jwyS4cUDHnveneyia7C3A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793032464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
	b=iYQPIbjhvJaqn5YwoyJuOuQ+futvis6VNQfndP+9JwDNB/kRs9llXfLDhxjSb2ShH+uX
	 iFi6EalH1VuI55hEcQoYRkhkvb9noC79gKcciHPmXo4ebOmzi9vVDhb5WeicaeFCCXPH5
	 MOLJrPpqon6y1pn9qmQD0Q9h/3WdvnHat5yC06xsFgLG9ASS7z4DqtgiUp9JS3DANA++Y
	 k3d/Dj9MiWj+5KjFyPAo6/Nbzt343I5pwLLHD4SnPcydQgX/VL9qYIljrfEqKXm86YrRa
	 Yoywk3qsS9Zha5cw8A+6KDdKpVZiAW3itWxNAVpAypkaYEo8sGbx6OK0vL+FmoMRtsw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793032464;
	bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SXSF/koePAWwGD/+v6SwWhV2PzRGTQoacY6THiO+o8ZPnFteip3oFAz0teuKy58MY
	 AsJUQuJNS6TBTjTdD8FWWGshxAs8Yfn4TWe96zREwR7jw7s/hHcn9EglnGD4vyTP8I
	 y+e8z4QuMA63weG86QuMhYLM+gjPIYZBlqLkGj2RC9h30Wf1UE4vsCeVRx/WsoolTc
	 n3IuX7AoDb/0R7QUFwpYz40fZPkoCl1/fV+uNiiEa1KPUbtpPFQGg+0vvpqeQyWNm1
	 LTqNihR9LjEmbIF6nHuIZen9uzJB1SNSXaXTHz1bAsmICJ2xzeRtQYqEb8wRgHLkfE
	 OrG/PYyy+Dr3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E213D80DB9;
	Mon, 26 Oct 2026 16:34:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44F663A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36B09605F7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dIqoLfkSvIn3 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 433BB605F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793032457;
 b=J8CREsNzJWRy2PLaRZXL7cLXxbj46K5FK4Fe4O0AHI/IcYQBRp3HQ1PNY8vVADw0G8HV
 XinKFrl1TkXhrlGaNsdn7cZ0ILx+EwGFiFqi6sdmtvIApnDIibn6U2jEQ0RsFozx3CSMF
 quiSeWInIh4TRe0Eho+gHsSkfeWazICRBBQTgo037jsnhZG2KMqJ8rBsQSxINjSTXztjE
 yMk5mDxJBd0yqYND6lPqsuTLl2UjjrEsvAf+/C12b/oZVYp+6i9AcG7tJdie+oNqLbVAD
 bLazUnhMCF5YlYWkk49Vnj2bSPcotKmLaYGXaXKssDgyfFfmdX279fk6qC5U4617lvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
 b=HVUE7vmsrMV7GAVc2FIzCmBB8qUjNS5BI1ep8Zc3tWcoVcpUZQOoRYB/RtA76e4M7xO2
 b9VG5w1Ybwxl5aVD/6D7L7bKCV+lmVF4lCKbbOtfdUEpgcJ4QbOPh2NHrazeFZi3smySf
 x21mzvUTbspFHtk+6Cc9X2AV7jeCxf16pV9bPa9dZUTtHXav34QO0Chr1TaQclF1SVxbL
 QM6GCotWg4NkTkGJSXeYgJL+90580ocZw6CXrIhpskApbhahjVAzzW7gK9dNPH3GJV9s5
 O8tigQ/4ma+RTxB8vi5YE8gEJL1R28sskt5bSjWlOZFcKFy8MDWkFbPmxmQx2cpp0Fg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iJCHz2+W; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iJCHz2+W
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 433BB605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:34:16 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b40fc523faso3469901a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032455; cv=none;
 d=google.com; s=arc-20260327;
 b=Z5fhD6v/x31HW0SMQa5eONDem4MYxT/cQvwQbz3hDHGXH07qZRqIcQxLROjVjFZn7L
 nbHVRS/8/Qu6xlQDycceVdyCGKG7CkiPQId1AlnEGhI8gU/OGWLzSlVIa4Qhs6p/k1kP
 PEPSs23UesXVLeXTKi279NRaYSWmGD5NFszLqcWwniUrVccOiVTSwlP6rqy8SYqfZtrq
 9D96isqAQTwc0VDRIIlHkRRLvPWEpXrg5ATTv2xT+LQroSVJc/lcXGg4JuNsTfTeBtye
 8q1+bfU2BCuoK+om2r9vTqWVx2wWmUosJ2Jyk7shW/ctND6qoj75/P+sar+vX4GtLpFM
 v8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
 fh=twIHBGMIXle5m1B9U7GGHxOCOBbhmjnGb3lustvImmg=;
 b=NNTh7kLwK1+p1s/FWEqcTGfvydd/oASeOKrn5saCcVH2gE4gFf1/KQzPRbfkm6i421
 N4ZKibyvhmYdXkQUXwFcIBka29b4UDMyMjzdPtn9oKhXndrTZU9Sl4Wrhh/naGT+qNID
 LRG/aKSUnZylmBgar8dYw7NojENHOG1a+az85a/Q8OAftyPH1bIpGBdcWI2Grz0u2ICf
 qAs2IJyVqPZkp5Odd1fS/0TLlMq3XngOp+OvLRZlops26o3a5IX5Lco1xMuMMl9lhcYc
 p5RiMcXkzpoO68SBR2vItT/rON2numSuaVkXCRUgyXryfkJqkxip97ZezbcNOWzFgLid
 KMVA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793032455; x=1793637255;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
 b=iJCHz2+WZOmHYSX/DWuaYyDG7sjmkMdu718NGPGAVSB83VE9EhURBfYLFspSMjLZMv
 ICRjYxRdyoCcP7+hJPvzayHS+IlRrEljQr6nJvUjp6GzyV/mbPT2fQYB6dJtKhsAFUq7
 XOFHeT213U9gl3xl+9C9bGvgziDR6jj4Kfn50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032455; x=1793637255;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vh/xRYxpaKcmUoxSj/28rMTH2BG732S9dzTrW0XPj0g=;
 b=qW53zSqBfAgd6H8i3YL3rDjheBvVr5jK8xgZKjluUAShMQWfpvgysd1jGLyxs8Simw
 AEkrjdpKU8C/jukqQyuekEhwZZySFEoTDzzJJmiz2MsC3VgbA4Un7x/vrilWfwRW9XXy
 nnJQRglBSK0HOklpOHtqfkBsNChKGtcApZ24ufPMn65AssMNJN2qLE8KRv9uqAgZ8yMa
 ObC4zxWyjroQIRId801F5Iu7fL0/8A3U5vF6FOYBE6wwEdom82qovHXAichkjcWucJ43
 sonxF4LPVg3QkyZN3jArERKQOfj5B+WD24uZsVBO0lXtd61g7zS4vKAo34+se5CCzHc4
 aj7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwm1uDX1V7WhSXv3b8svbhvm/h5I0ZZsqbZssfa3HYKo3Zc7KYLtDpseHhGqK0NOL/3iOywwYI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLnOSdb8h8OCdUo2S/190SqSRfC936aF12teG8UKhtqOFbHbqui
 KZimQqkPHMIBkxbjHLYE3Lir7TOnkio8h1F7Rch+21KU6X8lKIRTeUkI1FsMD9iIc6MfFyKfRnf
 YkHNJj+ma68cknlTv869BddFia0l/CUznZsQOPwxT
X-Gm-Gg: AYBFou3EylnV8wjDWnka2A7dLydEruUHTq7AzOcwNDfsIozL/w7/xVErsDlwkHvTBrw
 BpRg3Qr87hEs9NFTQDfCmO6ojJw7OFHdQnDi1x2uWiJGhd1FvzLdnMm19O1HnOfpONtmGg1Tfzp
 IN96l3XLpp6D4jEczwqbqLWdxmQtg83FS0qqlLfKFedSrOherd+a7IjM/cC1jdfYs5HdQcWVo4S
 ErQCJlSELU9fc2/3E/ys6sC8WxREW+DQ5IA9DUxoXeBQmfqr8yfMtvDNB+2+3uY+UJr4etI4xsR
 9pHhASKiN0notHKukxjBtzWKIPQTIbx3jCCM0C0P6dxHfXMFtUQqa/4dU0IqQAlQsYrQfRmDqSE
 YYl4J99Otah2XgvtF+iN7pS3cn0I/NCNQ2rHj+e7DBHAKcr2d6Iw8bY+pFA==
X-Received: by 2002:a05:6402:448c:b0:6b1:d2ee:3933 with SMTP id
 4fb4d7f45d1cf-6b443122e1cmr9509269a12.45.1793032454881; Mon, 26 Oct 2026
 09:34:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:34:12 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:47:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261023-mtk-mt8189-tfa-fdt-v1-2-f86616860bcb@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:34:12 -0700
X-Gm-Features: AclHuK8VC6xFMtGJM0eUzlPQq-WRsJ15hPhcbuU2edtXKIeAyHSIkhKjFFSj6KM
Message-ID: <CAFLszThpZaQySrzTVH70dTuuRZqsOp-kFN_AX+01L+KuS1npwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] configs: mt8189: enable bloblist support
To: dlechner@baylibre.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On 2026-10-23T22:32:44, David Lechner <dlechner@baylibre.com> wrote:
> configs: mt8189: enable bloblist support
>
> Enable bloblist support so that U-Boot may pick up a Firmware Handoff
> transfer list from TF-A and apply the devicetree overlays in it.
>
> TF-A BL2 can describe the DRAM with such an overlay: its size and the
> regions reserved for the DRAM controller, which depend on the DRAM
> fitted to the board and so cannot be described by the devicetree built
> into U-Boot. Without a transfer list, U-Boot uses its devicetree as
> before.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Carlo Caione <ccaione@baylibre.com>
>
>  configs/mt8189.config | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/configs/mt8189.config b/configs/mt8189.config
> @@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
>  # CONFIG_BOARD_INIT is not set
> +CONFIG_BLOBLIST=y

Just to check, since the DRAM size now comes from TF-A: the MMU map in
armv8-mem-map.c still uses the fixed
CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000 (8 GiB) a few lines up. With
more DRAM than that, U-Boot does not map the extra memory even though
the memory node reports it; with less, it maps memory that is not
there. Is 8 GiB the largest DRAM fitted to MT8189 boards? If not, it
would be worth sizing the map from gd->ram_size, perhaps as a
follow-up.

Reviewed-by: Simon Glass <sjg@chromium.org>
