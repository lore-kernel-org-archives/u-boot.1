Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3AFCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3842540AB8;
	Fri,  2 Oct 2026 11:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCHYoYylGbgp; Fri,  2 Oct 2026 11:15:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D97440CAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939718;
	b=LTkE1xbMKng1tL2OA0Q12HzgsaDRv2fAJI2pRywCr8CprIAhr0UP+Hthepshs9K9A8io
	 PV/CzI7bDdYz3jzYtvvOB0ydPlEMK1h6uQ3Q/gwcWCtdXgPhlPNMgFTyL3XcwhYrU71UY
	 6exAjBCjLlAnr9VxYlRC3ofddk/LmeNOiljDqoRGWDM2Wmt5qKuW7AbKAYwI82srsSBsw
	 i+wi6qdNlUzEd1/lC9fLa5aTbwYhuZNLz0NkXb1HaZX6Bi9Fw2IlyTBW39huLI+1sCbOU
	 /Xlier0sYnjyCeFP+dMa8g/iz0vypxsq8uRxltQzjt26fBRajXnHG/AtAA4ViDuc4bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790939718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
	b=UKKQQPaUsLjqknvrER/FpTNvnz5AuMDUA/o3Uh/qnyd8TGJCN1bhTh9F3pTtXEOCUhqe
	 gQOLOt86wEHlXuzinYwm9XeyfaYg33LzdFz1MnntrOH1ut7zGTMqwInF2s3NCMGTzXCUi
	 WWUCbB5hYrN4BHXCTnaesrD0tGNj8h//bRcznKvQFlYUCESIPCV4C0WZAWdkvbhQrLJNd
	 7c4VopKldZGXCnS770hSjy4LN3P/MKa9XOU487ZFIAiGTACvEx/L3yauoCoyy0o8A+25e
	 sokOyw+PKKk8bwrukge1IyljffJEVfkQ4K9yq2+aUGJaEWTNOGWnkhQGQG/T1VlFj3A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790939718;
	bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HswksQlyYjlIgUh5tU4Cgni4cLKdBZ2FxoKEZf28yR+R5Jf5wzwS5OKnCiBnTo/IG
	 CWfVXK9/QGyeNosQwu2kxSH5S2Dv4QH+FdnC+Upl/iScuBRL/hDMS4OYsLRZsV03sr
	 CdXtky4G1bIsJrz2ggh4uesXiXPBc5Pr5CioTwe+RZekeimdw/fOqTxUmJiE/JO7SN
	 OlZxD0vF/OIV9xaGb7yXG35H6nSD+JNFJeTCTw3TALaJ6NLeezFLjr6KVFr5s97mvR
	 NnmxQ0+25zbH+itw7BFYNrBitk0/+GjP5rxbWBMaoG9lmfNot8FaYUAxeV/LDs8xbb
	 t4MMz2hleAssQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D97440CAC;
	Fri,  2 Oct 2026 11:15:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F2BE2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C8CC811EA
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dG4vsmicQykn for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CC84F811D4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939716;
 b=RyUwjjjKuyU44zhTpuv+AsVqeQe5AvoSSMR4nWFTAIJ/JiaPF0WA+GUS2OmaeD4okXfX
 8wrs2jBBPkRhYslE4E6gBGDXfE8iZw42Fi/3lNZ4OC7TSm97BsEEFd8+T9eDf+ZVKoLJ6
 RMnK9RR/H5mleEXsGDwBXrp/VOcBwwvKoutmPI6OnBwfINJltEvLxXnwaoIe4Kq0W56YA
 UiRu7G74udD+/BWvo0U7p9J8X0pfBSeA5g7LS0IYvkzmPeu75QX3t7f2vlDESeUERgftY
 D3Oz7JSCiRDqvoPZbxpCAK0qGBbio68XuhiuZpUiHui1Mpc4SXnCzotVf8hg1nMrPQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790939716;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
 b=pc9sxKqC1ykhPJZaeflOpZOQlRwMvC4rG8QYNnHcOw5p4hi++HM4BgE8vch3UDwbpMp9
 xlI3coTvVb0nRhplBeD1107Bqbo43dlozjuVNIwde7A7HL7rW3ZSgdhNPC4sb5MCuuhce
 r/vO/rvoH2hh2gKSv0jqdsQ+EGvWrHTMaogOxK8ol7oxPeoHU5LM0CmtPv3ufe0UZWXOH
 KKA97rHZ1ZyS2rhY+urqIDZCJ3FVwRA/ZKn6G6khXKrEB/PNg3rF3gp42EfmHz6lxH8MQ
 0fPb1UhCCdRLXPmPBrV862rbePWDlnHpZLzdv8FVIRvQIhXe51ahO4i2IBSRyAwPxng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cjqMbaKp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2a; helo=mail-yx2-x2a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cjqMbaKp
Received: from mail-yx2-x2a.google.com (mail-yx2-x2a.google.com
 [IPv6:2607:f8b0:4864:41::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC84F811D4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:15:15 +0000 (UTC)
Received: by mail-yx2-x2a.google.com with SMTP id
 956f58d0204a3-6768036283dso2484377d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790939714; cv=none;
 d=google.com; s=arc-20260327;
 b=hYR5g77KpBeDbVkwh7TC3f5gU+Jya3rg2IVauno0CfGCcxSdc+9xI/RurgkzQgmhKs
 uVqbWf7n/Oaue9FYS1OJ4jYsB59kKt5TgJ5kza/ybiJOa33F1nl/Ksov8a1ukmajxwkC
 53Qu8dN+CfX104hzTAuwXvozo+AHN4FuHD8+LcL4kYraJaAZVqxhYc81WbLXqUzRK30l
 pzhl6Pc93RRIk2F3g9ENllbEfHVkjTQasPjtp+5DJ3rZaXRRd50T5jWUG9vKw1LB7Opl
 n/1hRsWhRi136O1UniL7X08sqs/3emrh10XQ2Bnp3bzGY0b6G3hvLsdol5I4WqO44KUo
 h12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
 fh=7CgENe6HCKpQFnev+rEGKH+RCfYA3Gee2JpnQeTn5FM=;
 b=rjZHq4Wy099U03thPFsHXnubp0YRMpztrSguu6KAaCho9i0EX0ER8J+xVif90CkGfd
 mqZvMJRscIRU58AJLsYYBTxhTkqX+kfosCXFjVnw3xc9AlOTeJizKsc3Cs8PIeCd6z1n
 Pd0Vtv0oK861Vc6Sa61JZGjl4ewQTjjbIcMXipYgYsYZ7f4H7VuFuFslMNL2JTV4+vIO
 eTRBQ0fTirhqSOCbmxODdRzAhV06RN/2IvBNFBiULJm44leSIXlPkEs2LOHtZWMDyVkV
 5mqLBTbPmB+PGSHlspdaGp8iLvj91ePcbTQfYGyc68JKxzMF9OxZSIT+YhSpGAewcMJM
 dBeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790939714; x=1791544514;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
 b=cjqMbaKpBnEessVQshyT9HXzoklDVRAljP780mc2RPpqgVfWHqsixIL53n8y6P+01H
 OH9jWWFEOjySxguK2KVOfUHOoCNtLjVL1eS5RWS8K2E769zVXtXsR/dV0i6rI/lY9RdW
 oqe9PAYNLjhA7P4dQokusdE8pCNZQb9a+0DrtPrshFXPQS625IHiE7AcQSTwe1atgHWC
 ncKg/zNHe2Nzwj8iiHlepitRyNZnHeJYf1XRKS8b48EFSZY8yQVQbDIpTmHkI6ZZj29v
 vcJK1mLLLvAhnMjn6uiqYK5tvAW9ja00luAMVxcOfLsxdjvmSNz2giosGWda6l4WmRI+
 gDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939714; x=1791544514;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NbBXxD83KePSaFahsm7WtSDlqQzpwfpZANxXKnPsnIg=;
 b=UcaL21ocT+CqiXIPPULqVipNoxsO2SUYFacJf8Vk/AGXENW2zj2FzVDaCD4y26cF6c
 YTTCbZ6Ezbj2lGK/4MfVG4ClC7YvL8mDkFcBrII4heAPP4IseYtjOS0xxtSnazc/aguD
 BuNdw6JLxT/hnro93Hmg6szVA0/9Fr3AzJUWQ37zcQNQW47Rz9xBsf+KPHMKCuR14AGg
 GJa4swnXE5t4SQaMc8swTT8SmjLcyTNRumtklF+8HU/nmX5WvPTI1fOStdo0ZRbErE/1
 dazBcNzZALz0R22KmMkZoZvZyf+RU87SJVJBAnR7axxk9fc1eYXXtNxKWgCcuqu9FOSI
 UPsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwezdpqE9IC4n0qLaT8hhugv6dyeArGqA62fP0YhRpeiRk07GZ+Fqz0GOD+cBuHyIqpMgXa2Cw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJz83aZj5WOaIIQ5AT1ZQlWP7txL+akktIJUrA44onprwN/TpQX
 n2lFcT96tz3t4aqQL8d2TUeOsMOaD8SpX0FFHRxHBm5YXUTcxc0o5cpZo+0kQRXqCTiDXdZ/sih
 qMtXVCLn8D1C56N5Dyrh1/RRHcc0JB0ewhfXaYwOHLw==
X-Gm-Gg: AYBFou2+1wYI/nKNbxXfJOPZp41TbjPubsj4i/0R0lYjyDF226f2PPrm1MpHcvu2Xt3
 hlsvsu03AWORsilp25bgVD5DI09Cz1UJW60cKmNP261k3QElTNM6BI4RhD1BXMFKDaKGxyr2h3G
 5A8BXOWvr1TBT60FgkUZmvnBuD+VWtgbPx0kt4bWqV15aq7gVJQkYkuoVoQDlJup71Ass+eIhvP
 ioRFe5Zkezn33gCx+ad3tRahaoK+tcBEvNzmbIh6gs1dCwmAp9/EH6VY/ovFS5SndT6OmGJFRZv
 krIOtSY05pB9JPC598AeZbnzz0f2b2KkBYYc/GdSSYqUGFEkvzFjhcWJ7Gv19q4fwa3ZSUvkk2M
 a9mCMXuwpf0LaPlS2HGVSUkC9cr78jWV9RAIFDolK7i84aRx/HvK+iiOd3Fs954HGc2QNI3FvCf
 awdFqayWv3iRvIOuu2Kt6CVQdqKXo0erGkNX3IU7DWGPgh+9eJTwT/NtXKpGU4/iwdEDjIn65Nf
 Od0u8jNG1gaMSOMjZCSVb0dwhcf8bwL3df4ev4f8rQkENLmxlxre63bEa0kIdtk8KUWZBk2YiFQ
 uqwkoS3ei3PSy1i4sGjfDbuJuJs9+lu9IU1pOznHEFmoH3yUkoH4FlUuopbFXynMYYX48TDtkZA
 Zg3LnISU2nCjA8a+jvJp1/pBfeClG+6dt512vbRm1DGzioi2AD6/2jg==
X-Received: by 2002:a53:e3ca:0:b0:674:981:a937 with SMTP id
 956f58d0204a3-677ac13f4f6mr566564d50.121.1790939714057; Fri, 02 Oct 2026
 04:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-6-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260918200641.2286077-6-jorge.ramirez@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:14:38 +0300
X-Gm-Features: AclHuK9yWRaSucbimx5as5ibdT3uvJzRD-gF0ROvnrV8raOzXREYFUeFZUu0yTE
Message-ID: <CAC_iWjKZHNgf=1-GWXihdDifKfdhF8fsudybBtSSo6+7Q1QSVg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] optee: rename rpmb.c to rpmb_emmc.c
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com, 
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com, 
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com, 
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org
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

On Fri, 18 Sept 2026 at 23:06, Jorge Ramirez-Ortiz
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> rpmb.c implements the legacy single-command RPMB supplicant, which is
> eMMC-only. Rename it to rpmb_emmc.c to make room for a UFS backend.
>
> No functional change.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/tee/optee/Makefile                | 2 +-
>  drivers/tee/optee/{rpmb.c => rpmb_emmc.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/tee/optee/{rpmb.c => rpmb_emmc.c} (100%)
>
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 36ac085ef42..d0c7f8dfb12 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -3,4 +3,4 @@
>  obj-$(CONFIG_OPTEE) += core.o
>  obj-y += supplicant.o
>  obj-$(CONFIG_DM_I2C) += i2c.o
> -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_emmc.c
> similarity index 100%
> rename from drivers/tee/optee/rpmb.c
> rename to drivers/tee/optee/rpmb_emmc.c
> --
> 2.54.0
>
