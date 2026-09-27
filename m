Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B3DC98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E00C60642;
	Sun, 27 Sep 2026 15:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x87nuQUI3wVB; Sun, 27 Sep 2026 15:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1043B60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790522280;
	b=fJ0xBhnA/uV06Ya/sQknB1AAe6zp/7G9uaNaE7bk1T0RjdozTdtT0ExM3YIfFPfEGoPV
	 sqIU9j7bgibC7ReaLYvxc91wFJcL7zqeDtAATBicChV/vivpPeGHCPlp8li7+fnUQqcrO
	 8RnkTLSFR+4m3ID8lMWc2RAObffcUOL847ZJCnqNSfbkOQdJr9k7IcqfrJh7hhyT5Nulr
	 I4k9XbyxenyTmxAMv28BwNCcKlPtwd99sZs2Jo3zX6y6PlZ2oeR+O7lNdNdAjTDDZutQB
	 SYktMW8RKwscg7ivooAfLCsvWwU3pM9u5KdiDPZ0RaaN63+PYnsw8jcHYyoPhvBpLMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790522280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
	b=aFI4Y5zL7IM47JRE5lSW+jHeGUZInxFoXpD54akXSmrL5L0uQ+VnLXk32mV7R1hQYNdX
	 I24ivJ2LX/giLK9sOTJ0q/nbnau0ofS6irwYRkwy5aH154JytPn8N7XDQMoIb/U+cr8UK
	 g5z9HJh2fb+OTk/BnH0k/D8upgbzuD1vB8mPzVeadMYYu4gKnFvP6Owj2QsibAaxvvHpH
	 LyOKoQjW/jct/toDgz4wrpZMvo+PtjPLFMofAdw8/jbA/CoufEJkZhsjRt8aBQ9Hjbph5
	 Q+09k8kPYNxLYAJ0t5zn0E1ftXP+9awTpEspiLnDQ/oAOepPXDY6cAbW9HLOF+P6d7A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790522280;
	bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ty5QDaJtDVMWNkmWIvvoirlCJzi8DzuxFOZV+f71zqMhBWzhz0IlilAA6Oyahc/aC
	 5iW4/eF6i3O3ZsjrlQO4/Ld4y0jLk8dRTgqe+UBdDni0qXxcUdL2c3S6oKlCEmk+Cc
	 OjC/7BVK5qfptrpVAU9VSZ3dqpSmtejfM2tLmfvHCuKG+3B0vLn40XKRCcexvJArak
	 gH9KVr3Z/0YyxgcaZql+f0usfLvvEGJK7YHdck1NzZxjsCBH2VrDgLO8es676VTU7M
	 pqWTgJrYeJIeIb7WhuJuDFu7i5lvWvAzAvSBXB9HL+UQSp1LigGSTfEfNtX914D9il
	 p09WKKsdj5szw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1043B60621;
	Sun, 27 Sep 2026 15:18:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B39653D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5505400B0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7E0uJnmRyT5A for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 68F1740068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790522277;
 b=ABX3ZNUUbwxgaKfiiJDIKh2AI0FHw+Y63Lnbx/C/+xGONB7H4F+T5QqsBD9jihibX8+U
 KK/Kd2OoeL98sVZyfTRLdccdtFtUeQ2QiHDXeQExRp9P+hm2/ZwfE5K4YRovaF9ROdSIl
 GgTlsvPIqJ/Av6WqMAfs1MkUNHeYKO3S9noOK8M59JJY5dgJTrFuAVp/ixKnCWE1t2M6G
 x0RvZlM3/W1af2bgEz07/YVoE6mo0KkECzCZjUfW8tH6ONs9tBo8DZDAeBx9JF7SIENz/
 tbnJoDSPFbLu+0HMz/JZEXY2CpQiBg3l3JJ0frTY9YVh9wpT8OSpCrnMGbr1ooEwJCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790522277;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
 b=NgwpzKnI1UDkFC3Ae3+IDmAY+vcyO3SUTf/n3gIvSvcdO3XBIw7Ufj/zbOeSFZYYvhoD
 WTuHvK6do5S8gkj9IE8pawKiGt3FxLseROfAqgdEe3dtB0a1KSr+p1CTSZjCz3FKLE1gW
 wS6liF4D2JDFBFxZYkJCqLEJUA0BdS6O+Cqf4r/DRuDAoILI1xmXNnNcAxbSB/l4tjwkG
 4xEsXdCk6jpE2E0nVWh8mgIzpkoqTv3PDySS/ERjLiQBDx/75TVnuFsBOru96BBKLv8Iq
 8AX+MMpRTUAZQiWOvW039a7ZXt3wiYzPzlya2fb1rZHey8lNIGgG5N2OV+i0J1OTQWA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hBWLwxV0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hBWLwxV0
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F1740068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:17:56 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2db9cc3b45so102006566b.1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790522275; cv=none;
 d=google.com; s=arc-20260327;
 b=g1nu62h9aee97aLDugK4oTM5J7hi5OamSB2b7j8ZrBLpS6C4Cy5Q28ZCdfuc1toI4q
 nmnJZ0dW9dFD3eTa7445feWp2Svf/OWzUlQiUGla366nXcfL872W5+ILF+3cTaTYFK0I
 UwcXtaaSZnjbsuxFESrm4xQh2Ld0/j3S9Hn0bkSn3HT/LNHMXiIjXy2MoBZc54E65lo+
 9W1YtiWYIrUEH0LTCctgMCyB5viGSJq9nXDVjwqtZGGBJURphWyZwisvqnYLBxnSVD/9
 zJBQSFp4Wve1Q+1BkCsypI0Ke7C0DM+3f4myyS4CuIIdUE7f54N77FrQhvL/redjRMVH
 T1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
 fh=CQt8LCYaUTMjh4NzJwsgCklcH6ompS+N/yCkyaBDuoA=;
 b=CMCBdxdfwO4i9KIEWMVpr1NFAbHTLkU4lS7n5BTE2FVX52sOes7PXR4pvxJrOrmb24
 kOZUyKNYXzsPmvp3IlbfPh9xkBuj0tGXARV6hoG8fuPWMQSVddBwC34WMucMZqqJa8LQ
 5L53UZNVj5zTc3JtAsiqtPN9FxSx74iO8EEUHx0LusO6xa2teWYFbPoBjmtdPLC0nGhw
 UEpKl3Sq3txWEtXXz0Oz5fYmlOxXP7Ch7/d3VSfogGI8nSvk13v3tR5BFZSwpNipisu0
 ZNBH/ZLXOPMjilTHAfGu73zHa+FMFmx6Mft55DZsP+7PHOOv46SPSeapdL5USRXtYKVv
 ntEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790522275; x=1791127075;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
 b=hBWLwxV0f4SwWK9IwK4F6vSTTShCTo6VRk67jrw5Dt0iT7oQOZYmlFZArdS42zkr4J
 Y76UzCLUxbUWkMcKgeIArgyjqZytsrjZCeX7CHVAch8Xwy0fRY10QB3WDSOxtV3UV4Sj
 DxVmc9vfIFkskEnMybafCGb4ujqN0+ebP83nWx2eHNvhDI7Uz11GrIhk3o1fvFhpjFnP
 Kzo0vi+aoWiJsKyyH8G88wAmRas/+EJ/6gjtqClCi2vvWDSqKkSLUUxk6FRkrGub6NMA
 fxKsPcmY5siMil5uIwo9Kw67GDd3/sLfGGSGOGxsdOiudtf0gadtva8wS5HVXwkZj6N5
 ydUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522275; x=1791127075;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EwZr9cgx6Ub3vXWo6JXZokphi4iqbg9ceqiFxeUEHfA=;
 b=UgtlOyBRn/t2SLeO+nGKeRfRAB+6Y2wDhP55pbMiZ6ntUddte8ql+MnwVmGni64MYR
 iwACftlAoYlpty/XIYOFONmNERqf40LlUHdB0tTr4QX3nuAo8gtxNECwyNggz2zUihuN
 d0c7m4kIGH1j+tgJdRsy9UYd2Fl+5n4p28V1gQmO2VQ0QSazA7MBLp7cKlqMks5ll5Wk
 NwzPwzFxvXG12HAniJFtJ8IXmT9f5d3tvWBviqz5GKoM8AGfDm3PFhwNnt7j1PC6Bfb9
 p4rQLPRSiAgp6kQTah3zm5wTVqKS6JssG5LNDMkybb/78pHtaij7YBJs+wXXSm0XqXrm
 9EjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsPRkrb9E8OBaUKmdaSFE9n1lKsBOWuP31W2IGzRwlJboLm5JmztSnbZ1KT2kDpCfpPL2cu3s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mlGZ+i68cUTYYlk6CA63lOnmUQByDI7PbvxRr6RWArLUxL1zK3
 sPEJiN1jUI3Y6rGQaJu3IoITKbMwZouYiAo5Q9To4SbVs6zoSCirP40LeV5qPapan/nIpxxRQjq
 8C8CK3pc1bpk3cB0jBL3XoG/nDKNU3nA=
X-Gm-Gg: AYBFou1N0y6tnbJKxxo9j6TCrWLgesu9ikWvcSMnmry3llDEolQmpuH+dZnLSV1wWkd
 k+L5uD6d6ylqEc6I2y73avwO5QqndsJc8ioewgWOOwbbcc70tSypSkmFcERH5g4/dE1Cdwg1L7Y
 /g95kPXUYlIz5Xiyr4IGrAp8oaols55lROPPXMOE7f4b6gz+8YDLlbWcSDn9bAScc4gFyq0cFmp
 Hr4T/ncPIUwoIL/SZCHouh/bi2EwiCmO3ffOLbUP9eqehAaWNeJNB/ME9Xoflr5KN4R94sOSbwd
 V5KKOGAk+h9OisQUD6GDV7Ft6yDf58JPKx9/Si+ITrqtH1uQ6fQofhj5Sef/rLvc
X-Received: by 2002:a17:906:9f90:b0:c27:420b:7c90 with SMTP id
 a640c23a62f3a-c2ac26723ebmr910313466b.48.1790522274611; Sun, 27 Sep 2026
 08:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-22-jonas@kwiboo.se>
In-Reply-To: <20260805174509.2968252-22-jonas@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 27 Sep 2026 17:17:43 +0200
X-Gm-Features: AclHuK-3Jl8msSozCZV332HJxMhogb6ZExgAowGei1xRkC9NC0LsT2LRl1vWqsk
Message-ID: <CAC928Hbh+XG_EA89aBeG4=fUYrm1YbuZug7JFy7EOnOdzv__+g@mail.gmail.com>
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Jonas,

On 8/5/2026 5:44 PM, Jonas Karlman wrote:
>
> Implement the sysreset get_status() ops and return same value as the
> existing get_reset_cause() helper used for DISPLAY_CPUINFO. Only include
> the ops in U-Boot proper to avoid increasing code size for xPL builds.

Does excluding xPL build guard break any XPL size constraint? Otherwise, I would
avoid it, to have a driver with the same functions wherever it is built in. It
can be added later on, should constraints require dropping unused functions.

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/sysreset/sysreset_rockchip.c | 52 ++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> index 27ba4ee0667c..4b10d6bb762e 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -11,8 +11,19 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/hardware.h>
>
> +enum {
> +       GLB_POR_RST,
> +       FST_GLB_RST_ST          = BIT(0),
> +       SND_GLB_RST_ST          = BIT(1),
> +       FST_GLB_TSADC_RST_ST    = BIT(2),
> +       SND_GLB_TSADC_RST_ST    = BIT(3),
> +       FST_GLB_WDT_RST_ST      = BIT(4),
> +       SND_GLB_WDT_RST_ST      = BIT(5),
> +};
> +
>  struct sysreset_reg {
>         unsigned long cru_base;
> +       unsigned int glb_rst_st;
>         unsigned int glb_srst_fst;
>         unsigned int glb_srst_snd;
>  };
> @@ -38,8 +49,48 @@ static int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
>         return -EINPROGRESS;
>  }
>
> +static const char __maybe_unused *rockchip_sysreset_get_cause(u32 data)
> +{
> +       if (data == GLB_POR_RST)
> +               return "POR";
> +       else if (data & (FST_GLB_RST_ST | SND_GLB_RST_ST))
> +               return "RST";
> +       else if (data & (FST_GLB_TSADC_RST_ST | SND_GLB_TSADC_RST_ST))
> +               return "THERMAL";
> +       else if (data & (FST_GLB_WDT_RST_ST | SND_GLB_WDT_RST_ST))
> +               return "WDOG";
> +       else
> +               return NULL;
> +}

As already stated in the RFC I sent [1], neither the glb_rst_st register
bit-flag definitions nor the logic on how to handle them are common across
Rockchip SoCs.

[1] https://lore.kernel.org/all/20260920-reset-v1-0-42820216369f@gmail.com/

Possibile approaches I see to overcome the issue: add a bit of information into
rockchip_sysreset_bind() arguments to instruct the sysreset driver on how to
decode glb_rst_st value; implement rockchip_sysreset_get_cause() at mach level
and pass it to the driver as function pointer arg of rockchip_sysreset_bind().
Other ideas?

In both of the cases I would probably feel that the mach area is a better place
to implement get_cause() instead of sysreset driver code. Of course, we would
lose static advantage but with LTO it is probably a minor issue. Anyway, I do
not have enough deep knowledge of U-Boot architecture.

Regards,
Massimo

> +
> +static int __maybe_unused rockchip_sysreset_get_status(struct udevice *dev,
> +                                                      char *buf, int size)
> +{
> +       struct sysreset_reg *priv = dev_get_priv(dev);
> +       const char *cause;
> +       u32 data;
> +
> +       if (!buf || size <= 0)
> +               return -EINVAL;
> +
> +       if (!priv->cru_base || !priv->glb_rst_st)
> +               return -ENOSYS;
> +
> +       data = readl(priv->cru_base + priv->glb_rst_st);
> +       cause = rockchip_sysreset_get_cause(data);
> +       if (!cause)
> +               return -ENODATA;
> +
> +       strlcpy(buf, cause, size);
> +
> +       return 0;
> +}
> +
>  static struct sysreset_ops rockchip_sysreset = {
>         .request        = rockchip_sysreset_request,
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +       .get_status     = rockchip_sysreset_get_status,
> +#endif
>  };
>
>  U_BOOT_DRIVER(sysreset_rockchip) = {
> @@ -68,6 +119,7 @@ int rockchip_sysreset_bind(struct udevice *pdev,
>                 return -ENOMEM;
>
>         priv->cru_base = cru_base;
> +       priv->glb_rst_st = glb_rst_st;
>         priv->glb_srst_fst = glb_srst_fst;
>         priv->glb_srst_snd = glb_srst_snd;
>         dev_set_priv(sysreset_dev, priv);
> --
> 2.54.0
