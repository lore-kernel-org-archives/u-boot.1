Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A48ACA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4CA080BE9;
	Mon, 28 Sep 2026 22:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHxrjcCxWYwX; Mon, 28 Sep 2026 22:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2036A80BDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635314;
	b=UKaCRUKsPEwh4b6eYAfetajOaOo/XLKlQNlZVxA0JomvgnH3qfNHztfO8CxrSiggV/3l
	 3XLfnnvk5sLacME2gFaSpODFe2gND70iIlsN+ylvVglitSNEtYXfMQQcmLBT72f4l8YZL
	 KWhwyEF1ca4CAuFFvk8cwUb9QBjRz08XJvJuQ1buLfPJO6M16oImWvL7cYuNecTPcjRhs
	 3M6wcoU9+TOBHNJFPiFjzyt0AXTMahBQc7T3iWm5Zp9di/g+YPWZ+v+3WMI5ne7JNhiil
	 xvBAj/mEX89SD1493XAoj0OM3YZiuXP0W886OY+Y93XqY603ME7nqS++DNOW5zOIeuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790635314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
	b=k/kbINT9KDzFPxjgiRbxm5SNnirJhWqM5nMpled7m8UUA4nXIfIFcw/qq2V2l50bkup7
	 Pcqj+BeaHSsKCywSLagr8XXRAPkZTTVf8APvBvsKWMHDhcYZMaiiMsL0x2lTz+1oo/Nk/
	 iK8cegFbKbu1zkcxmq/8wKHCqMcrsuOsDFyo7WgVpJ2XRmKHtQ0ENsme3mXff7Pc3WXaF
	 FkHCyO7QYwdybynTiHmgHcs8uWdbEvr7yyqHLJxEk/uNj+eMIAH4JbE8uLPRoJVel9B9D
	 j7vWXLUK0Qv2bJpJ/rZ+vhH71yNgBnKaNtm40KCfePwwwGZYABwvpoIi+oNl80jcn+w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790635314;
	bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLK19XMDoicvhTGyOGRufG+Ha9RRT6ilklTYoBWZT6nrYw+cdwaiV80rnhb82thCY
	 jhYKVV/C5tiWdZTcXTdFF1R4hW93CAi0uoKxHAwc0tXcclrm3hgApi5/3hL+zIereD
	 ZsbwYnZWF5wfxEK3sfztsmE0Coapp1VIwFNtRwSQnEdVla0tQpdVqdSKbg8J5ofFB9
	 4zUNi6SihAS6k3awb4lbSFIoFIQheaJaXw35g+RNsEqTA69KH82PnjT1KK3k1iMgGL
	 ET9BuUAYuHq1uY2UkPAiPo8dB1mNiYKEBgGxhkzDyAyqEvE5srInA+CYCEFTDHUznx
	 ik8IMugYsUWaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2036A80BDB;
	Mon, 28 Sep 2026 22:41:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4DC972
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9F8B60625
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0-M_bp65H8p for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCACD60614
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790635309;
 b=bTdmvo9/HZSVu/AhlcubTjVNp2NcDcJll4FfgS6QZ+XwHRhSbA2j34+jFZFIauMGRR0r
 TPVNlBmWp4gbaTtbQt7dUKbOZDhAQgHJyqeTtam7XuG+4h/QydsuS2B4b8OSCesSqdDOD
 sRqqMecozpWQMOGvxuw3IjY/f5Akt3YgzuSxHyzLt+SsFZw/9wrYAgrLmVv+e1UA3453A
 S2J250C9Q+P0gk4+Fpng5L07RqsXrZV8K/veRY5a2dJAYlfyxkNap3gH8D/P7fNilKyVj
 wx7kw11Sb0vZCo5/TReb/JSBsfhnw0NzRLGYofw3NLUWUXLRIrO2wDqik0Rlp0SXqiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790635309;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
 b=dvB+wGHFbu+VKWbzy+d+I21NdC8kXm50YfI4Bty0wWHqHpA1KMbO9DtOZnAIUcswHE2F
 tBydq+WD/2XmPbDZQW5AWCYSNBNX7Z04NFDtnPvpP+g1K40T6NxegLI9qNdwy1aLUiltm
 7EBhQTa2ZeB7U9L5g1ac70DwV1uFf7VgxJCu9Qu6XvybKWHNlIF3/x/l9uRoRqERqSTXR
 WiW5VPP2qrF2VC6xpQhc5wPJWvP5TBmHApgGYEo2NXGqtZuq/N7iVOJtIKmbt/Jvqla29
 jRukg3O332PQycURhCi+b+0ViqTV/EXVO+ORu1rY4pixb3043YuOVKXDmystfO6Z1Cw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b9j1A57R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b9j1A57R
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCACD60614
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:41:47 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acae8342d2so170013a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790635305; cv=none;
 d=google.com; s=arc-20260327;
 b=IJdrXDzIz/cZ6tHrbs5l/Wiud6HNxk0QycLhjZXE8p/Jis5pfUJoT5XEzOUn3PzF3V
 Ajuo2Wk9hep8MQB3zVPWyGx6gUXGiYCxzjfQvMAL5iEZTaF3CIaluqgEaXx/GSYuzbeD
 ayi52oWhcyHIyknJgl33kFOPLn8p6sGuGDoFZckl6uTK6NRNh7AaahzkHHVo/y5I9DcI
 WfqaC00ZW1IKZLB/aTLo1JnIswAlpENYbJR0OAHS7QpDQGBcSK3Uo88VOL6jjXys/iDZ
 JbfqkUtJCBOxUAB+apdU7tX2ZwJ58wMlYO1a3YTyDAl3XlF/ZXqNbfLYetvRQDb5N4JO
 hklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
 fh=Jg5L4iN52/+dff2mCs26wdwi3mnxETdMiA1nIE6Co7E=;
 b=OI8WxGpjY72GRYTnvEX+efAmZASOF/tA/aJGXU4zHh2f2X9C6dTVEHcCelz16UCYwo
 HZ4qgT8fd6NIaZkNbKcNvqn0OXH47+E5QL+lysMc1wBKabkTudUeh7pJV5ZlASOrvu7X
 I49471up9vtW52oXWz0FW/xhQNbapwhI0Kk/JfGbl8d/bMV11Vnd2jqdOg0OUVhPdPg7
 4+xc4DWAgoSHDDLPLijiLxSKwCb+rIUmRVfCpVuk7R26KqtToC2iZLX52XySZVNu2eTl
 tRZDg/77/qCPMxR50LbiBTc/UxVkdgKvvDg9wkyZ/u97ykrKDZ1ZAY/6dpkEcSs5CDLV
 cOEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790635305; x=1791240105;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
 b=b9j1A57RT3JlOOfW7pK9Q+wP8QyfcNj+tiesziWb7aKwU9uPyoC/gRZynRDlONF2xC
 OB1HIDFhYyDQf4g2vsszoL05yvWzU7SxoU1mXDW/Szf3YH4/Bw3pctrcr2ounqNtidCH
 e+x6zXUaE3vvNiuEQ6CVG7iGNE5VCPV2q2/Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790635305; x=1791240105;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q/cXlUlREJSHSn47TcMkWhN11Vv0Bj26I4YFAVbC7/s=;
 b=JLiOmOZnp7nBFxO3D0Ps3ad4RbKMSRU1h9ene2vMBSrDlG8bJoAW3A4+GntnwwT7P0
 R+XpS4sVZ2BDH+wLAq+bbM/afGNiCKbn7WyVHSEHnE1T7f4D35WCmiU/Cg31d+wIH7cL
 a1gyIlsRdtAg1iH24Ur/vIJIkelayQ/U7C0smV4i/z2JU7bvzBEUymu431aOivMzjfZf
 4clrAdhVUu2dIaBQUyIDUHHi/ZuR0M1oMgv3n5XM2zPdOAgC2j1GeUw+XcLBgK68df/F
 tx5F/IX+i1o983WtIwONR4+l5LUZasT8eFkEKLGPlX1BhkpcYc8qjYp8j7Y/SDTfh/a6
 ecmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBx2/RnYVtgxNbqG4/uOZtmo27cTNs1ZcDL9ja30JSclBmitUcDjMqULZ3gkgT2YoCT/FKuUU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJvHKuBBZvoeWC8GKq8e7T8BEmKYdRWoloF7HeHCxmTkL9E8SDq
 hEe+qWWWlLC+++EBFQUUXhXmcqvYlRaxV5zKU4GAkNIJh0xZ2nJMApCwHr3unVL3ftieVUquyu0
 X+YEx2HnyRHWxKfipZP+QnAvIPhIt2LoSSB3vfoXt
X-Gm-Gg: AYBFou0T4x4lxoRGf4qHkyksh0suoYCY8Rs2S49ZEn0e9bIMwSd+rogQa0SoVXdxSx4
 dSAdPh8pHBI1kFCpM+LMxARzPWWXAsa/uK/6xuk6QZBTETGTxVY8jxSMjSQJrQdIcgnA5TVcPjm
 YfA58U2jo0Ci02qBjiUk8sPIdKnrl6qDKA0XBjlJBqutAafSBy2RYmb3nftoxEnhd+odlC1EuTO
 91v2XyJM2kHDBtfnauYr67vtjdhEs0JTWKPFv30oYU3VvOjLsGXalkphLkANt9KNFwIzq8gfyKR
 sEtU9STlWXD7TmYzfcVkglV0a2WxK5KBNvUgDA6QotEN7pMeotDQ90Crfw==
X-Received: by 2002:a05:6402:3808:b0:6ac:7d58:dbff with SMTP id
 4fb4d7f45d1cf-6ac7d58e288mr3075274a12.13.1790635305719; Mon, 28 Sep 2026
 15:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-4-sumit.dhami@oss.qualcomm.com>
In-Reply-To: <20260928064041.1432227-4-sumit.dhami@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 16:41:18 -0600
X-Gm-Features: AclHuK8Ks_dkOd6D5omB4P7LrR5_u8RK2hNDl921GMVFnorGd9cSG-rw_0efNxU
Message-ID: <CAFLszTjshtAx94Bk5VYJCf8U4w7622pAEgJV9nB6fUdrBaqKTA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] disk: part_efi: read full GPT partition attributes
To: sumit.dhami@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com, jbx6244@gmail.com, 
 vandhiadevan.karunamoorthy@oss.qualcomm.com, 
 dario.binacchi@amarulasolutions.com, sjg@chromium.org, pbrobinson@gmail.com, 
 quentin.schulz@cherry.de, varadarajan.narayanan@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
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

Hi Sumit,

On 2026-09-28T06:40:33, Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com> wrote:
> disk: part_efi: read full GPT partition attributes
>
> gpt_fill_pte() writes the full 64-bit GPT partition attributes field
> when CONFIG_PARTITION_ATTR is enabled. However, part_get_info_efi(),
> the counterpart function used to read a partition's info back from an
> existing GPT never populated gpt_attr/gpt_attr_valid.

If you are using an AI tool for this, please set it up to use present
tense for commits :-)

>
> Populate gpt_attr from the on-disk GPT entry's raw attributes field,
> and set gpt_attr_valid to true mirroring the write path in
> gpt_fill_pte().
>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
>
> disk/part_efi.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -306,6 +306,8 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
> +     if (CONFIG_IS_ENABLED(PARTITION_ATTR))
> +             disk_partition_set_gpt_attr(info, gpt_pte.attributes.raw);

The accessor already compiles to nothing when PARTITION_ATTR is
disabled, so please drop the 'if' and call
disk_partition_set_gpt_attr() directly. That is the point of having
the accessor.

Regards,
Simon
