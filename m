Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67936CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86C29406CF;
	Tue, 13 Oct 2026 08:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XaVW_OotlIM; Tue, 13 Oct 2026 08:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2BCC406A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881232;
	b=WkZZniehrkbE31dyOH95XuZSEtbqmexNH7875J7zT600gaJ6253kZK+7y4TluNT86Jmw
	 sEgT81Sc9kO/+gyMjZC/LXF/zZEZpplGWWbgBsT3Lsw/jpa+Hps74TLx+D7aEoMGseHrr
	 9kGtKGmUJTir0YX613GcrHBdBXF0hI1H7JtL4e5NMRcrGe1ApCA+/mQhpKhAZs1eA0MFX
	 m1dYD5UzKzP1wpHbXfi9ujhPAF+q0uGwVcisLjgPoqLLPpO8SSiT97A6QhgFYTgfUuJTe
	 Eo4rQWz9vxWzDf1Gi4r1Dw3MQ16Dhoz+cutmJvsmU2yXYJhMGzAP2v+fXtkCPgpQMlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881232;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pLwcN2FdMvrvU6kH0B8rNpj5VDpAbBQVtw0KcDb8ir8=;
	b=UZ8iTYSbC+StvlrfqFBJhNOhqQC6H9ZQuPp0uR/ZjgUIhTUnN0DDqZJdA1nWfRq0IYxZ
	 tE/bIFMJ3gHjtqih6C3+Jn4Mw/WoRhWCoeO9AQGPlbYdba6PjEIPW3z7KCUiHDJpsJl0p
	 OXpcTRGXd0U398jSUZHGf+aKEt2K1e+zEdiGrA5IoflTVYWUK+Qavkihn6bFVO2v5hS9n
	 JXNnzg7LwzZDjrLZj9QFBmizgiB9t0Iq33+fJ3B2DvoQK/OWD7HvscugpuSJl3LAoSJBP
	 N5RCpQbay1nK68LBACwAAs8QnPj0KRp5+vrhXTfiXBKpH72GWtKRxiLt/GYAh8bPiXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881232;
	bh=pLwcN2FdMvrvU6kH0B8rNpj5VDpAbBQVtw0KcDb8ir8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WM6EWzaH73RNnLdI0/IfJIvIqDsGC53fNn77+HYdNYHAikVooAKe6Vf6Y8YS4CHGM
	 rGdZs7s7k7lMCpOJGRuODAjx53MF55wCtZK+W8CHk47hWQS6hDwRAEWj63BJX3e5Rd
	 wajA6DioXrEy7pXL1XFKi3/I187HxlXNV9o/k41oJmyocPsDMgvH2qxNooDdxJDLC9
	 e3AXJhrNmMEVoudapuV1fqh+bD2gTTBtR1a0TXfMMSZ1+HH62HSjDUX1qQCOLpgraX
	 ljlLemBoFCq0k0U2rCcNt1MYc+U1w1jq1xlALlmMezZRvfzAPmXIOF9eqXPGqeXPCL
	 wqyKD1aikRDOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2BCC406A8;
	Tue, 13 Oct 2026 08:47:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5330B1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34F2C6074D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8wUF0Vs2CmS for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5AC86605D1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881228;
 b=dY100i4vUT9/Gl6uoXYSBvZoZ9oSNJCKtrPzLSPHJJYTl0cd/BPyF961vljHb5yltUbW
 5bPUqwjrf+NRgP9yHT+QlnhJwZpJQALjaGqbqbZD7+KMTIkpdQL/0z9Rp84IyV+Ttc6uV
 DpVNZJSH7LCt31klFyDdHjlz2IfM+JpQerA1H5JfTjvMMKMOSeKvJa672+AD+stjscVA4
 SL098EIWmDiWCGFwfA2wtM+OxkNyHnOgCDwe5NfwdS/ZAY8tWKidm2e9zTLMcy5E0LcJm
 X82gJWE/cGvrO3rBWIQen3zFIn4fYtE6EQD3cZgXPVf3D9J33cqzkDRvesAuzzR9rMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=pLwcN2FdMvrvU6kH0B8rNpj5VDpAbBQVtw0KcDb8ir8=;
 b=hsLrOaWefmAmL9L923vyBczAsP9OaBtlPvNOsGRfLGHHTps8u/BjK8+8x5VdVW/eL19u
 CVp360wDO1V33wZuyC4EAOGgrONFp2Z5SPqT695jYJ4HFGo4qB6lWDASNqoKyYW44FSDS
 7OseOgaFPWUjmBn4gHh2maNWABlymCxcF1A4iAdnCk+RZaaB1fIJzfKs0KExT6TMUy6VB
 /Ja+Jhc7yzaw8BYj9P/8v6W6hIKAEid39EAnNDs2Hp8HEuwEUMOXJ+ReEawsv7svveJqi
 agjClzl2ehUh8T6s/eAuOHG1jgMAXf0j6ki1d7rqQzPP4FoAeqXUPZ5Eh18D1Mk+e6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e4SoDe9c; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=e4SoDe9c
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AC86605D1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:47:06 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1880e1bf1so24785965e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791881225; x=1792486025;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pLwcN2FdMvrvU6kH0B8rNpj5VDpAbBQVtw0KcDb8ir8=;
 b=e4SoDe9cHYZvqpUi0zwQ7ryJS2CegwTqrJdX7gNi45852WKVZCc6fGK9iATJb7tN05
 FpoXRMYxHUsTuteU04sQ2VBtFMUfCVfpjVPvUe4nuejx8pRhADSIx+3d537ajHaJBDDu
 ayoCeizKSBplR17vHio9dK0ula3QO92sTYA/JKrwJ0g2zEGB1dBnU958uK4DGZTQk7Oo
 vhKL1CXsTTid75RRXVG6TTCCyihkLmNc1aZoDaBJneSZLmLmGjwDy7JWZ6nxVM19u7/V
 MLj5dOZc1cFWXB9uCGhhxdqaUfJmHk1rRt+JYZrdmySdMKz324AU/KgrJPHlmJPjFUXc
 GPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881225; x=1792486025;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pLwcN2FdMvrvU6kH0B8rNpj5VDpAbBQVtw0KcDb8ir8=;
 b=AEj8jkXOWh0i61OeQ9RLofSCXA9+t6m1pvTvfMC5PNIEY1qZHibNkdZpO/LTQbMwmM
 IBe/B09hmWrNKwODE2irKdrJ3k47+LiA7rF2PXXU8Rqd/JBqaAoFl+dUUD2cvfeyJnqV
 wTPGbLhG9vwrwPoYQkApbAzXcy6ls+8wT7fRS6/n4wNQxpSR6T6uxp+iIjaOZjZw9KfL
 QUhm2pDv/4ucm4a2S3f07dqjNuNxSkBO4bqlGxHQOFJyYdcstI1JRqZOorE1+YhmVrxS
 2c0zcm45X/kHx7BJ0jwgKBsKxgXRD5rLj3kClOr14IvwxJw26ZHNl231dcG5OEDzL50s
 Lucg==
X-Forwarded-Encrypted: i=1;
 AKwUvByHCUHjUF7X8cts7kHChtFk7lWDxR6PzktJHiRB09KAgmwn6JXQ33mCodeCynONadesoYyaZvU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKaX0Y2qyy83omO5vbZlcp5Gqby+zHbcP26ZdWYpncMJF+0twoy
 IsCJkUQWwOD3EyVPzHW9zqMAxqkK0ApIUOFbZvjDrDGe5LeJHlQS/A1zdp7peG4FhGM=
X-Gm-Gg: AYBFou33AvINTok0XCCVqxGxvoyPctaB0lLXH8JITeNrV4xaEmgLCSv+qBjrQna4kvT
 4MqX6FYRoVdohyCddtUvMD1zX0PYZEJUhh3UyzxQP28M87qyaxXpDzVDqCqeSeIhR4kW6LSsr9Y
 +k4judkJZqx3szoLrN7SgU54QQxmB0sMNlNkPa6Qav1aj+CtCnbL+cVuCBXApX6bEJMt4lSpLNm
 udx/Wbmsrt7I50HstaKMm/73LOlgS6bkvNwZapaATh7hS/PcrsV0PRmtGhArF663CuuGTgwD1M3
 +povOd/U8dioDp4VkqV4vXGb4lgj0fy60UhH2GJn59VKFAwfkVQ5l81DyOErCVmNHHMLNXrQmVg
 IioH9vkSHvY3x3Ax5x7HaZPe/zWwyM6NWycnd9iYkNojzq81swvcG+3+3zzWIbf/IbS80Ef8jx3
 3ylbC32j8BHxw1jGJcdbTHd0N0D3k9duBQiG2uBQHCaEZvFh6OlbIoeHa1iJ24G8kx0nxeK8VgF
 8z6pVjjIqCx0kJxuV29syIMrVjteElpmbO7lyn1K/bqrGhLF0nUruPhXj9CkLFcEX4xXv0Zv26v
 oR5EsyudkB72G+UZie5WH7VoFJC/kAJAUElcZwgjrnRLFJbvbLh60lc=
X-Received: by 2002:a05:600c:c049:b0:4a1:9a97:c88 with SMTP id
 5b1f17b1804b1-4a19a971118mr94964985e9.5.1791881224623; 
 Tue, 13 Oct 2026 01:47:04 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c85009csm271972705e9.2.2026.10.13.01.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:47:04 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/13] video: mediatek: add a DVO driver
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261009-mtk-genio-720-edp-v1-7-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
 <20261009-mtk-genio-720-edp-v1-7-4fbcf5b2904d@baylibre.com>
Date: Tue, 13 Oct 2026 10:47:18 +0200
Message-Id: <179188123838.53105.4574669844453871147.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791881242; l=2666;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=wBCHjnuS7WyJ5rXaRnyK0y7VQAud0dwrssANF+WIIsA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMtqk4w37Ys2b6Oly4zhe1G1/bGojclw++nUwxS8DWE/XNkgV+ng/iw2j7KJ0po4GcV9hwWI7nG
 lLcOg3Zw6yAM=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add a MISC uclass driver for the DVO, the display controller's output
> stage on MT8189, which replaces the DPI/DP_INTF block used by earlier
> SoCs. It takes the pixel stream from the vdosys0 data path and drives
> the attached transmitter with video timing. The driver exports the
> configure and enable entry points the driver of that transmitter needs.
> The block moves four pixels per iteration, so both the horizontal
> timings and the pixel clock are divided by that before they are
> programmed.
>
> The register programming and the display buffer watermark calculation
> are based on the DVO support in the in-flight Linux series "drm/mediatek:
> Add support for MediaTek Digital Video Output (DVO)". Linux programs a
> fixed per-mode table and then overwrites it with the calculation, so
> only the calculation is kept here. Its fill rate is taken from the
> engine clock, which paces the data path writing into the buffer, where
> Linux uses the pixel clock. Only the SODI pair is programmed; the other
> watermarks are left at their reset values.
>
> The driver has no Kconfig prompt of its own: it is useless without a
> transmitter behind it, so the driver of that transmitter selects it.
>
> It is the device that holds the display power domain for the whole
> vdosys0 front end, so it is marked DM_FLAG_OS_PREPARE to have DM power
> that domain off before the OS starts, as the DSI driver does for the
> DSI path.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
> index 346d02e9c02..88cf3d11b2e 100644
> --- a/drivers/video/mediatek/Kconfig
> +++ b/drivers/video/mediatek/Kconfig
> @@ -34,6 +34,12 @@ config VIDEO_MEDIATEK_DSI
>  	  pipeline (overlay, RDMA and, on the SoCs having one, the colour
>  	  pipeline) to scan out the U-Boot framebuffer to a DSI panel.
>
> +# DVO output stage, the eDP path's replacement for the DPI/DP_INTF block
> +config VIDEO_MEDIATEK_DVO
> +	bool
> +	select MISC
> +	select VIDEO_MEDIATEK_DISP_COMP
> +
>  config VIDEO_MEDIATEK_HDMI
>  	bool "Video HDMI Support for MediaTek SoCs"
>  	depends on VIDEO && ARCH_MEDIATEK
> diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
> index 9de9a9c78f1..ee3d7eed618 100644
> --- a/drivers/video/mediatek/Makefile
> +++ b/drivers/video/mediatek/Makefile
> @@ -12,6 +12,8 @@ obj-$(CONFIG_VIDEO_MEDIATEK_DISP_PIPELINE) += mtk_ddp.o \
>
>  obj-$(CONFIG_VIDEO_MEDIATEK_DPI) += mtk_dpi.o
>
> +obj-$(CONFIG_VIDEO_MEDIATEK_DVO) += mtk_dvo.o
> +

keep it sorted

-- 
Julien Stephan <jstephan@baylibre.com>
