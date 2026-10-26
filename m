Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bbNG009y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h4vUQRFE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C9FD60648;
	Mon, 26 Oct 2026 07:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 95ZcH8q0NYZa; Mon, 26 Oct 2026 07:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C786260623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793000548;
	b=gPSuih92KLjYstyj7epyQY+6jnbxfKSG3vPMHR0oVh+vlfZpDq9UQgHDRn6UMqkEpcXI
	 HufsD/s4+G3xPiRvRSDAxrs/2fkZ5xT+0idf0/X5OD7CmpxqdEKHcNqj/qsZ0Tod1Juqc
	 mCEIIh2WCnIBeyLE1ds5XrhxMy87XOgzTXHBoDZPcAvgM+TAH+iCW0h7sfuWoSLBLEwO3
	 YtPPui+6GJEdAhC3lDCQt7sO0zBbdkFyTesx7nAvr5mQnBe1e9piPwXk317AxaZqXq5nD
	 s2/yTNPlRTpE2/Ug4Pb/H52VdASoKaBzUvse2YKRoqB/ALESWodfq4BM2Aj1SBPhehg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793000548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
	b=WdkLc5ybRKOgU4myvCOVJpoD6namp9LvEXRmDQ0ZMa52R53VHxCZahXwk8vFj+11dm9S
	 lZx2nf4gLHuq51gwIf4JDPRhifBIrMjwa/0yd0YPBqAUbEf2NNj5a9RciIvAHHURSNKVV
	 OwckIvvqpq76mN0FLHqrFkwr73qaLGMi8dt2k+js+Xg0zbtq5WhSgzy6NV5WgAx4w4v+i
	 InGi7PemF0j6C+tGtTOEzf8lBaV4UCkiSVROH4jL1F3+ERbOIzJLyXI4R3gGvJ6gwcD/f
	 2fJ7Dd0+b2IgVoB9oFdYSKax/xXeYdmRcQUhf5eoNNKAc+aIpnie9CWW5+srbrriOIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h4vUQRFE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793000547;
	bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbNG009yAKd6gFESVJSuu/IUsLdQH0GkhYv/qRGoruEUkppdgBa7voY4M8qIqdMSz
	 dHO/gXCjW81i4OvP00pBbEf79rA//EVW1QAcxcO2ixImbIdAl2kPtcDqFg0om27yBn
	 r2C2yiKaSF75Tk4IcO2kx2nfMUx7nefDVGVzeJYjOExXPFFHNY2evkYyDn2tXgMD/g
	 CQ8SyY2McA2/wWOhLPPsam4bZIYn53lRZMM053FeXupFjXaGgP5Qam9mLRdsNFPDSl
	 OCRDyTNVgwIvguLSn4lg3QfEAn7HNpAqskWsTHPH6coFsjXFzM0XobQForCZIktQLJ
	 sWaYMu6OwJNNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C786260623;
	Mon, 26 Oct 2026 07:42:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CD44334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EE1F60623
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRD2Uh2kJmmO for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:42:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A53B60604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793000544;
 b=mj4v6e6MF0D3HJrIuMxqnOYlJL/t5qJkiCPfocAcJxmWnZFLVSyUXdgNnNR/htuIu5QK
 IK5M4mQjGUd0eRhlDFUTfOJjdkjrh7Guym0ZthRd+oY8Zn5vwU86uCkxBb63bvnM2bptl
 7/mKIscZw1rqnC4nqF14GR8lqiDbCEXMu/hKUPCP5mSeWTzE3ZCYmaRQzduH8lSoLKBVA
 fUB96oyaPI13H4DayVNWciD7Xa1rJEBBt18dhAshg3INx8oFENnDnn8x+fwE5QcUQ23KF
 sa3lew36/zS5C5BxvpyR5i1GqUkB+C0f2/Hn/KVZwY03iqQ0Wk3EHjOxKt0US5ZNK5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793000544;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
 b=MbznwseSjFnTqUi5JjejQR25PAx6+yg0zAQ1iD1StSce5StUuvySNUhwBWLN8zRe1lHM
 E6V/nvFEt0zDfPV4FjliFANQEkB1NdMt3UnRzMjX5WtgY3xVB1SRKUcf6LYX3vXc5k60w
 5qMq9/Kt3uJzsl64nrz/7kj10VRTaeyivy3Gj/AmCn0/UxAgY3W1W/E92SYhl4jVVoh9n
 h16RmHBkIXwZ7izqFdrRIaz6hNxX3RyVG4+MMqVg/PDHfI4fmg/QM60zJg6iwdHL0rTFD
 /9HqQyLgrO30bojKtIfrpuIjImfHu64GI6v8LflbRV22fQ1ED0IJP2ZKn4MbzJHCiuw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=h4vUQRFE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=h4vUQRFE
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A53B60604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:42:24 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso3736635a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793000542; cv=none;
 d=google.com; s=arc-20260327;
 b=oHgPIG6PFHtzt+ScZQaKfnJUbKcCRLfEY42XZQtWAaNhVNpt9YoVvKXGlD9xmBB9jl
 UdgjaJHxu+Y/G/pbREHXFweaFraydioFX6v/fGvUfWhTH/UHvgzdkTxthI+5ThrBErR2
 TwXq3njIqgRkSVU4LkGucJ9gd3d0iVqtJ42clnChRbADmPCYNCAEuGHVG9E3nvanOcuj
 7eEfzZ/aTi6XDyV2WJ8e8mWjyzk2HI6nkmEeO7oEjSjKE/WILUvIE/2hrfQl9Mm7DGSE
 I64CkzsexxckqLTg467hKZ1VU6LPmLTu9RyQEO0uwOuaaxe/uWohWkYuEQMWYBpbgEqh
 aYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
 fh=E5tvpFIvScpXscbBrxBGskjz+PkbVYgiaDgTbvGJ8VY=;
 b=XlONWAaRv8WC5axmIQBw4Mt89LRVJdi5R9UaxtYO/fg0z4gJox+9NWus2aul3+IOLi
 OU3s2ISAujn9mCldey5PD5b6m0/PaT58JJyN5oinaP+E1NApi/Y7Tzd86sv+Lv3oisOL
 /vui8aEUhF3hCD9fYrV2OpDstvtcFdNj/1YR6xq9Q7yTPIzkPAglv4ePO5CGIhLcbUbu
 u/47wuajEHdq8+HSBJhxd6XywuuIMG3AYWnGHDotbMY81NqcS6WJ66hLdr/om2JiNs/3
 G+Kh8dV/kRclqoNp8U703SDHGvJZ5Hz5iSUDAp4Le+/CyPpAKEfygvY3tUTp1qyuh/JK
 lUgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793000542; x=1793605342;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
 b=h4vUQRFE0whco94xbcZWAGDATDMvXFaqcqcT1RWK+Zn2To9vo1jcfwLO3Ate90plK4
 iFSWBNgW2/78BvlHEyqo6Fq9ZSN9ZZbEW6RxQ0RaikG+mJbX/2zWiT5/u5ig6Y2jMMyQ
 sFFCexcIrYpfEyX3murS/44tSntmCQZBDuCvvnuHfa8r5BqXE5/jaRMa8Jw6ateERFQO
 aMdYtBAFy9WVSh/uBsCkDlq3YuHx8MgS3Lo3mZzqPeOopjwcVmXW4yjCYTg9AK1JtokD
 Sv/e3L+ESFBhAh1n/wF5d4XHP+DmJVc0E8lrRs5yeFRu++dvUdR7kIG1W4KICUFI7TSS
 el0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793000542; x=1793605342;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=owigP+rVtkos4u3MiymfpV+UI/6i2zGqttd+TzDwk+I=;
 b=gSlj1rUEY1Et7txnked+dAKsv2L3jDYEUHXOYt6h7UN4UAEO5pGhZ/dHpAoOuvgZyp
 u9YTJjDxI5lRsJYmE/htGW060ONZjmDQeqXFWoASIj1uq5Jr2VRSg5cR8TjUjyDYX2nO
 T42YMLlrAUntrVAmX2Rejz+u+/pDbz4jYxJAEmQvd1jg79wq/2yte41UsAmgbhC0ziSQ
 rfYShhks/ho7ks8MFFiLRIic3CTaF5gaWzacE59lO1gPCgFovpRcf4Ob8MFYXLS6S+pC
 eJI7o0UVc85O83215qrtbDMfrgp2GNxdihuPUO3g1dVybVyzI1cwlKBdRixHX363ze6x
 dDeA==
X-Gm-Message-State: AFq9FYL9WRmSaAarYEgbb5o37j4kQJVOHohYQbhuJBV5P/3rogbbrssz
 mjE3SvvPR6OusENk9PdAURZVuPT3eTkECbmAOejhmzOEuv/HUo4Xaym198SjJRFpSuyLIwL3ZxJ
 QfG2d5dz6jhKlv6oUMhJXkNv1RWZVfSc=
X-Gm-Gg: AYBFou1QNx4vrmqDp+93L12mAoxznCBVm12hx3GgIncHjqeOI3uX29KHTGdFxhJCEEq
 AuFfWxgSbd3N4plyLLzmpAAK6ONWHPDIg/SkA9PCoRnXPndQDqLYKxERVO3G1uOi9s0HDiLG1B1
 wxegpnl6pMzwCMkzaUlT0x8noY9fQqcu8unESMKI2FyeMlOT3kph8an5l+og4pLemdYS/ioQ8og
 dOobPOaqn6pGuIOl0qC7dRsLDEKU06yUAEPEjkj87KShSJtt3wwr7XUAG5tKMxu2c35sgyA+1qe
 gAi5/3YhyK34ilzgFJCht5qatoTtSWJYe24VReq/RoTOcnUiGU28X0tUW1vgdaJ2yTSLzhFGl5O
 rbloM4+h6x4xC8M+buMPZxEaFxPza45SXwyPWc3Wwx6qBuT/+rH8jOHsZj/E=
X-Received: by 2002:a17:907:94d1:b0:c2e:3307:b922 with SMTP id
 a640c23a62f3a-c46bde546a7mr671515866b.28.1793000541894; Mon, 26 Oct 2026
 00:42:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261025231839.1155290-1-marek.vasut+renesas@mailbox.org>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 26 Oct 2026 08:42:09 +0100
X-Gm-Features: AclHuK_TCyKonTnQB-0T4JWSJd72Gv-08T4qGXkeG84F9SFNWmdGBVuzkvO3ha8
Message-ID: <CAC928HbBT6=qBN6KSV=WT+DEUEuUNdW+vant86xX+rpq-ZtDaA@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on
 REMOTEPROC
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, MD Danish Anwar <danishanwar@ti.com>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

Il giorno lun 26 ott 2026 alle ore 00:18 Marek Vasut ha scritto:
>
> Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEPROC, else it shows up
> in configs which do not have remoteproc enabled.
>
> Fixes: fb49d6c289d9 ("remoteproc: uclass: Add methods to load firmware to rproc and boot rproc")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: MD Danish Anwar <danishanwar@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 7f9e35283f9..cde572d61c1 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -151,6 +151,7 @@ config REMOTEPROC_TI_IPU
>
>  config REMOTEPROC_MAX_FW_SIZE
>         hex "Maximum size of firmware file that needs to be loaded to the remote processor"
> +       depends on REMOTEPROC
>         default 0x10000
>         help
>           Maximum size of the firmware file (elf, binary) that needs to be
> --
> 2.53.0

Wouldn't be preferable to have all the remoteproc options under #if REMOTEPROC
and to drop the "select/depends on REMOTEPROC" under each of them, instead?

Regards,
Massimo
