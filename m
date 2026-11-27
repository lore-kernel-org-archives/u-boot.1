Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C35606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zoLRcg1/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tk42H+ft
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67018130E;
	Fri, 27 Nov 2026 18:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaNY1YiJafr3; Fri, 27 Nov 2026 18:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BE6881309
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802550;
	b=hBRynAhrGd0FArfGP2VjUR4/55gmAwWxfgm8FSA3fru3Ae4+3nme2JChO0Y1lh06Xz9F
	 rFE+qP9fiGQaUTHlz0vHZj0eww/b4yI84xTQXrpfD0X63ialPK4gGbX8Dpsjdd3K/K7lX
	 Enp2K30df4yZ/bfmFaQStGUnXMfAlBoOayMLePcet5F6zmSE/jJPcP65PrSxilkRuf0+9
	 HyLdAVdXp5L8L+jdvMey334jjVRpn8FLKh80QQ2uYB0nsu26nbcTEqDQfYvy5u4MjVwTA
	 rhVsGyg32QbU3yWNnda9LOVjLsc1TJw2DbviYVt0zF3DbMSXiXaPXpBOlnsTkJwZM6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O/E+30wG/evfc9coG8TSB8/H1RkXzDv7rmUVw4Qfs8M=;
	b=JF+gB+kDDIW4Mjq0e+Of4TTHfwAmT/DUI2+SjoJsp7n1KXMIN/l7ABi8Ri3eXZU/dWMq
	 b5HoqX1lDN1u1fpjcsKbgHs7IRGD+hNq1KJS8Z8A0lnptBeoI4Sc3aMqJBw4Nl7MQ+ayT
	 OVV5CO7oURe/LkK1B6oHt7nxOY3VnXGhbWixoCGDHajJwPXtRxlE70GT/ua+ttq9M++Al
	 Q4gfVFBffSNJ5ZBoNrvFaMMoiAKXXhQ/xsG7aLG4lVSFG/aZQg/i56I6YVNriBdgAAJEb
	 +t7VgIyB9CQDwBfhdwvxGbM5Z3Esj5HohE2o8Cp2nm6N3OOxNsEG+u2fcwa/0L5YYiw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802550;
	bh=O/E+30wG/evfc9coG8TSB8/H1RkXzDv7rmUVw4Qfs8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zoLRcg1/PhVpOOf/8ZecRH6gCV1nf17nU1t1Nbq1jYn1YKblpCJXo1tDLSqE1WuOJ
	 ZzjHtTmGhHDkk4HCHPexQFWDWU11zmEB4GPXpld5mlDbNsocXm0gO5eN7Zj3/+94+j
	 ayJzdlPYFErVai89hErdSVJIgXJTB4Q1d/WlO8YlYWoVf9iQHmFnthqiqj5Yb4ardF
	 5q9RhjpgFr3GG+LgWbshXzKyqJyYxxkAE8WR3bIfmsNxTKxLIemig+2ftFtuyhVqqh
	 9uuIHn0ePbL8A4R7dgJEEDX9L3ISgKZodf3NhrLdo9aq0krz4nENCPvPaXOUd1Y/Nl
	 zhsbGJlduCf6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BE6881309;
	Fri, 27 Nov 2026 18:02:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBF9A373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD97240CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DZ3L1bpmMJMd for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D69F740CA6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tk42H+ft
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D69F740CA6
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:02:27 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6bb06dc1fd5so6167789a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795802545; x=1796407345;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O/E+30wG/evfc9coG8TSB8/H1RkXzDv7rmUVw4Qfs8M=;
 b=tk42H+ftjwF1mEDcjkOUSFsD43WzefpDEpDR5/Njw4FwrpnkCDGiecBcvklIlWXgks
 VUzARj0xDKf7sMRV1DKwXXA4cyg9wJju4HoIZUakz5skxjGsytvsUzOrDsVXZ1rPWdF/
 TeBWnQ9sKLNaLLNerQfuJ73fbAWFqBR9ThgIBCfbwuQgUXYExMM3txRlS/OE59VYO7/a
 /pXPKoYRfkKdLdnB1ACz/mOiSoOIjRYkEv0hV1/xaiqcL0kKYP1gdcRyCaeoUjphTWaI
 nP8yAqDC6YF1RgP/Mn8Ye6Ax/lAQNYmQiejW9wHKVcfwys9ZNZDYkNwb5HDpzJHjNIwl
 qINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802545; x=1796407345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O/E+30wG/evfc9coG8TSB8/H1RkXzDv7rmUVw4Qfs8M=;
 b=HRRjtZTQqA69UuPKSuhi6pc/aMdwSNdhsOsOX4BR7ZZeTwo4LpUdROdRiEmVU83dvl
 dfgG3tAAs4wCXeqtI4RYtviZ/rfRoO8YvChfDliSO4gg2+48O0KE9+85yk+s6i+NpzCX
 7FIqi1mwpx2tbxQ9AUOAtrJZz2pjDHT31yNUqYXwxjgpahohSuAWzN1415ZT8v2h166P
 DVbFK9SntXcMdCCKDZ4FqaYm9KQ4DD8zsT9YUMsxB8vC+pUIst0X9u/xOq/NP3V1cmFP
 VS8UGF2NpcYWrbPBxLKuM5nwg4XuoTHiBxS0oWSP6+U5bQlxsg24ysZp1p5uf2swIp6C
 wFUw==
X-Gm-Message-State: APuU4Z+7ykQ4zDak3fCE/XihPHDdFPH2L8kVvEJHZ7HD5Gbitg6ZNgDX
 p78k2kaSS+K7m6RKKCGnwqWBF8bkNyc8CKvECMv6QjvqBNU9gW0I5685dIiubeD6rNKBrMq/E84
 sh4GZ+G8=
X-Gm-Gg: AZFdTZdGOqNHAntj5rVk2hw2Oha1uEyxGXcRrjeUQ6Qirdoy52EJku6gx5IQoHoofic
 YDwvvWsS0f83C+DDtYPCOD64etukq3uEAHT5WbqU8TrjMMUwyoeE4gv9ae82Dopy7gXpjHwobhj
 hHJ2eExGfvixbxA56YLRC8X0UXJgkPY4HjqGxgiYu98tCzeXIY9dKfZ6xLF6G4faREdMJupKFUU
 a7cbRvpxe8KPGrcfMrpA60d+HF8u/LbbG7+MRPRKUTtwvM9vvm0GNPK74y24n5MGfbFnK5Nkb6s
 7HCoOr9UtotaVpzKj9dLa17simQpNQbpC+sv9BdCT6YQmV/mAhIECGaeSmo1Jy/NIUpDJ5jaAEK
 7u+YSOn5bFxPx86P+U6aludX8dTUpDC8t9Lb5jwFqdLxkp6LEWMdO1Na6468dVfkOhDQRaZ/Bc/
 FocYeQhdTnf4tA4f4jOAY9ONsc9agyLxESX0oiwScsrK8GZ74bRiR/TLjHRrNEbzID3XM8gLGxY
 jxWNX4uxyQRUy5HAVy2wKXEIPQpOEAtk2JebikvxiU94/MY175P2TTLtB0KuYuAdbvdhqo8zS5A
 KYxItosYFagOEjKkNLxAOI6mq+LrVppldYGt+fXF
X-Received: by 2002:a05:600c:a088:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4bb8880ac02mr484515295e9.6.1795802535052; 
 Fri, 27 Nov 2026 10:02:15 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:16ae:8ed1:cf83:edae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb42absm49164452f8f.1.2026.11.27.10.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:02:14 -0800 (PST)
Date: Fri, 27 Nov 2026 19:02:12 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH] arm: stemmy: Recognize legacy Janice and Codina machine
 IDs
Message-ID: <awnFpMWwJnCAfgN4@linaro.org>
References: <20261123-ux500-secondary-bootloader-ids-v1-1-a90bd12873cb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-ux500-secondary-bootloader-ids-v1-1-a90bd12873cb@kernel.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 10:17:42PM +0100, Linus Walleij wrote:
> The stock Samsung secondary bootloader on Janice
> passes machine ID 3294, Codina has similarly ID 3297.
> 
> Some of the secondary IDs are already supported but apparently
> I missed some.
> 
> Fixes: 5d50adae908d ("arm: u8500: Package Stemmy device trees in FIT")
> Signed-off-by: Linus Walleij <linusw@kernel.org>

I can't find those in the downstream Linux kernel sources I have
access to, but this could be some old firmware I guess?

Anyway, doesn't hurt to define them additionally:

Acked-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks,
Stephan

> ---
>  board/ste/stemmy/stemmy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
> index 8526deeb29bc..49b92ce632fe 100644
> --- a/board/ste/stemmy/stemmy.c
> +++ b/board/ste/stemmy/stemmy.c
> @@ -70,6 +70,7 @@ int board_fit_config_name_match(const char *name)
>  	const char *dt_name;
>  
>  	switch (fw_mach) {
> +	case 3294:
>  	case 5000:
>  		dt_name = "ste-ux500-samsung-janice";
>  		break;
> @@ -77,6 +78,7 @@ int board_fit_config_name_match(const char *name)
>  	case 5002:
>  		dt_name = "ste-ux500-samsung-gavini";
>  		break;
> +	case 3297:
>  	case 5003:
>  		switch (fw_board_id_get()) {
>  		case 0x101:
> 
> ---
> base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
> change-id: 20261123-ux500-secondary-bootloader-ids-14f6d90c9911
> 
> Best regards,
> --  
> Linus Walleij <linusw@kernel.org>
> 
