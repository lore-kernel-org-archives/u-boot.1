Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208E1CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6607860801;
	Fri, 16 Oct 2026 12:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVoMzd8EF5Dk; Fri, 16 Oct 2026 12:49:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73D4A608C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792154961;
	b=AOS2y23sNtNPyduSsFoN22vOhjfnCgOBzv4E6rOv1bSTUa/UPlNilNcjAx6tI7vbgiwB
	 ax1BsNvEORUo8Ja2pIvG8qAM27dZ7Q1avTyLa9AI06enAjQcR5lQnnSQin3uf3iApm/tD
	 YOYSdYs8J47Oqoji7VFD8rs0fubeFF7l6oeGmlvCNvuymtUwvJCZBJYoZcw0dmCwW+a4y
	 UwiWPx+hAgI/tT1biEJ2MX2MfyR0Pb5+lrOVZZEk1EAqF1V8b1+T22EM9na9NHx/IrzEP
	 C6+iWP/3OlgUdqIvGiiSx1BJqEVJhXi7r0KtaTpqyh8rRuADaItpzFcAimU/m9cMc0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792154961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
	b=UQX+Z2oogx44lFmHPsfhSStw7Pmco9JfqDcQS/Cn8Ewu95yKIV4mQrUiWgAZ6v6uuP9V
	 3JSld+oLevQlIjsr0MoLN/fSgk8Il3j5RGztL7CnxTNhBEqob0ex23O1MvA9dzCRfeFer
	 xXAdk7SfzfmexUiWpX/kKqSBUQTZQkf5+4E4I+HeAe73mUcYHlZ/tQ+gVVwIfSaWBu7BJ
	 ZtMZcZq8j1d6BFhvza9p2l3p9McK4o43moIVSY9jrZwIP3T4yhToFOOppjZ+bDlWWQiuU
	 kcdn6WK28zfqfaitQI2mybZpvugj9Wru3/V00ZW9e24Uz4oepWsp6F1vsBWxGH7MD7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fZhahqqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792154961;
	bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FdwBCnbRpB3GUINXNqK3A8yPiYPSXGCj6iyi5sUHHepGVu6+M2b0mDrKXXxGHI+mx
	 vbzvytz39ZipU4gYcYjCsm/Uv5r2qZj+0YkQB+ZqkPJQWGbzNfsiVSZLCGRdBut95S
	 kQSnTnEOvi81ycr+Mh1mCLWh/Ui2iUHMZvt277FvS1f3ReFn6XxkVhW/t6LjdvB90s
	 um6KItEDZy50gXTkA7rN7rwth62/o+jwqABwLjfC3+p/NuTYFtXNruZ/yGOE7jtWdG
	 9dCR5ASLOIQZ2TRqKOmA1945KssnT8X9MgIxdNiBytGGTpcLGsLM+T6mAVpQAWuIAe
	 h2G8rThqCtUvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D4A608C4;
	Fri, 16 Oct 2026 12:49:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76015F45
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDA77607B9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEVxIMz37Pk8 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1BC2606B1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792154957;
 b=TTaM9OOBcl5TFYYrnxCR91pgFUSA1Yw1bGihumYXmGMlR9MTluERT5FbKzEQoT4+yRiF
 jY4Yu8CAPNLGg+6Xd1nj0Ii82Ays+yaB65UhBEtaRJuf2gL1rnWqW5493kmfLIZ9tkE5r
 KgVxZ8wJ9SpH+pTfOj3TIAdb5ZjtMvuJpRSmipzkxnAL/zCUX6sDSKnPHksD3mS3cFnOZ
 +Mf11tK4ZOT+vfP34sFs5177LKVcUgAOhlGNq8pXTDLpc8wRHM/yT63Aj7SGcaUMeoyaD
 wclW7z/V/jYmRFrSnLN9om4ZV1nQt4nL6M1vz+QTRiWnQkvzmDbKszWXLRtJzNtYvnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792154957;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
 b=IJWad37IkI2czwj6ZyBypzCE/XpERsorZz+v8yPT0KidXlOj2uUySrUW3pDPI8Ct8u+h
 7OLm9bZ5TS7rMiPtoO376gA4YvTJ3a2N0ayFCgl6DVmUeGKc7LPrlhW/lHKXPZfDwynVu
 NlTGVVJ+FzkHVfF8Aro6MGgZ6H5YVVT0Mzumc8Xgiigh9hil+WnhJyqWnogd6Ru3lBJTU
 2jQJXui9lGyj6TRyWmhpB38GE3q6gXLrsp9FQGZl0p7Lu0e72dIPK4uCBe+2ToISESQgO
 k55UjxN0hkStA9mvn/yMNg5gyil5DJKYKbAJP+YHgDgBArE7D8APem/PL+Pp2jOf3tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fZhahqqX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fZhahqqX
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1BC2606B1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:49:16 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b8b3c8c4bbso1043296e87.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 05:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792154954; cv=none;
 d=google.com; s=arc-20260327;
 b=R6qqUSWf99LjCx0QXZI2KM7EjQzPOFIlzScyCvlQQG8q77itMBlQX09tWK3OfuK503
 xDwqtVfal4PaLS10pTPyJiBzIKpVa4/e/QsMhBZMHgGUwFke9fzHTZh+XHwK9yvWsAX5
 SmpI47yg+62GkUljhiLB3o38cvjyBodVcKuukBOz5O8wuEoc4C3t3t2LGzWEmlRSi3PM
 R1LpLveXFR9JG4sgI9lQcBGypKk/5TerIcbhDBUK7hipOjZ5whv20sZa+msI9/mxF5Bf
 d5h76AH0y5lDKJxFFv+mgvEbWwTLhum30NxDm5BEJEsubjjl4MxDofYIbQFUtAOtsrbR
 2Gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
 fh=IFsZopDKI1JULOlfhvWaBiKkfOc/MrSmaLOSq/PVM7w=;
 b=V3bMl09wuuauGsLEuU9Y8uppRokN0oZhak8OXNaV1DuP6fCgQTd8aPdXunTpLPyhUf
 LubsVHlM0KgzRX0OchLS08W8MTlNst+YBJFH+Na0htiP6oNU+uqoe68RtzNfGjZoTa7I
 5g2zepxIIEGJEeiHrEs3wMpSQihCDL0f0N7g3OpUSa96Wo5URPjH7x2WFX6mwROj8MN4
 zGAcaYWg0NproWDRgTSnbGdtja6YV7oSKpt/lGRBnr31ZF20Rb+2LIPIeBTt/TkJZFz/
 NRsK9/4tz2IMPex+QNO7vhzJf/Do0PPgGb3Q2J9aK3DYq2a1rWk2liM+K/uaaYoMaz9O
 F9kQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792154954; x=1792759754;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
 b=fZhahqqXx6gj7Ce7w02tFCJT8poZwkDKy1pm+BGU839BGOaDwqAObbv/r4QdOkuMhN
 ZIcwP3jwSHehj1RO2FI0uOZVFVHST+4rHCtw2ceeb+Htwf+N3iF853lp/EfxZ4uiih3h
 2JDl7+8Arti/GjfHbe0JfSMv8pMW4c0DbUP7zwKBC6iUwPWfsJ5KpAaObRf9IFq/zuVu
 AsR83RjeGPfJKhC9+AqfATZQqBfZoFGy7A53mQw1+HSlFx1XvbD29x7eawLWIkNyEN7E
 W/J3xfFyy6H2ZCwVkB1ECbkZ7i6cJl76aZan6KsnTOPfye+b9wlNayRkEuPpnqFsKkBU
 bfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792154954; x=1792759754;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eFaHgKQCfGCdp9X5HapiTvcjg9QxJRnRK9q88FZSv6w=;
 b=p5sPXWsmlQ3SZrUxJf0K+P610PnIt/2VIjTTRvb1PQ/vsJUOLJlXeAIYv8PASmJZhb
 a314BTMWt9A1wbLGPunywGKnfSO20CKxOkUOUznEK7uipd39BH0lZm0I+k9EJvF86F0y
 50Bz4VbamNqnoD3YPi+9nCcBxtqORr6RkicD8b3XJs+BgiUvwpFeK9EaOJCLaAn0/xnX
 1WMHLZcGwaCvLF9kQOH2R32Df9U4/FvzNa6X6jA+P9aq0VtZzYStIV/uhkpuW8PUCIrk
 2vXrPDiVPafeCD6ZPxUx7TkAC+gM2h/lrpNaGsMWYUqpqPAAd73CqQfmjA3i6EJvktT1
 gX3w==
X-Gm-Message-State: AFq9FYLxkl3cbFxmPzOolyCnXWkkQMz4Vv5igRXJtTv5gDkRXXqhFcTH
 PEL4Iv96XoBdJh4nj4PjcpgLgmyB8KzRdjNLvv8BB70qMBa1EmNYdQ6MUOIPdzS2ch9QoxgJSLv
 GzjpQg7mU1dgaiFlJBnv5JmbDaHxvLdg=
X-Gm-Gg: AYBFou0NbFXelezeRXmG1eEYDG7opk4kQST+ciIhqWccDO/pvWaSdmUlDiG9y7dqpMl
 BKpg31Lmx3c2tTiZTXG9VbLy/lgcE2jPjeKhbI4s0WRC9XV3T04wDhKAtY3oXZAvI3mNEaW8ssR
 NgfIGnGLGByaBRhGVAQ7FNkCK0b6QBJqCxxJWapOVqYVYGFp4ZmXZMmjNmirksGPzD5MXvago9l
 FxE7feVjSbVKTLfjvzJxulltej/YSrF4ZwLAjsfx/KkUHDXpucRVCNb0QMuDb+sJu4OI5yLvFnX
 eiakEn0reQVDEEOdeB8DEtn8I/n33w0mByF5XtVdClBNCQsV1dCqCJvlu5FbIfa0cXXl23hqc1r
 0d+9QXk98OvsfNQW9Th9JLm6YJYSXGzpbit6/51QPVlbo
X-Received: by 2002:a05:6512:1383:b0:5be:3455:734a with SMTP id
 2adb3069b0e04-5be475afe39mr1002479e87.5.1792154953931; Fri, 16 Oct 2026
 05:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
In-Reply-To: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 16 Oct 2026 09:49:01 -0300
X-Gm-Features: AclHuK97L1K_byVhFqwad79mTpgAjENgRwCCEnNaPLHx0Av-K950e-W5r7SFsLM
Message-ID: <CAOMZO5DVhvT_dNw8eYKMhwpUU855-P5YK9f+z8o=XwnDhmPzhg@mail.gmail.com>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
To: Andreas Henriksson <andreas@fatal.se>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>
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

Hi Andreas,

On Wed, Oct 14, 2026 at 4:46=E2=80=AFAM Andreas Henriksson <andreas@fatal.s=
e> wrote:
>
> On boards with >3GiB ram, we can end up with transfers above 4GiB
> which is not allowed by SDHC driver.
>
> fsl_esdhc_imx.c: esdhc_setup_dma():
>         if (upper_32_bits(priv->dma_addr))
>                 printf("Cannot use 64 bit addresses with SDMA\n");
>
> Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
> (with systemd-boot as efi application) and print the above message.
>
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 021a82d4709..a5f2e3e1058 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1371,7 +1371,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
> -       default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARF=
IVE_JH7110
> +       default y if ARCH_BCM283X || ARCH_IMX8M || ARCH_MVEBU || ARCH_ROC=
KCHIP || STARFIVE_JH7110

I noticed that MMC_MTK already implies LMB_LIMIT_DMA_BELOW_RAM_TOP in
its Kconfig entry.

Would it make sense to do the same for FSL_ESDHC_IMX and restrict it
to ARCH_IMX8M?

Something like:

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -1,5 +1,6 @@
 config FSL_ESDHC_IMX
        bool "Freescale/NXP i.MX eSDHC controller support"
+       imply LMB_LIMIT_DMA_BELOW_RAM_TOP if ARCH_IMX8M

This keeps the DMA restriction tied to the affected driver rather than
adding another architecture-specific condition to lib/Kconfig.

What do you think?

Thanks,

Fabio Estevam
