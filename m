Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F23606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IKebaBJn;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KE/vLPqh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F6294061B;
	Thu, 22 Oct 2026 14:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GhLFAdPyWEYM; Thu, 22 Oct 2026 14:19:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4F5C140554
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678770;
	b=MMqjJT8fYAJRx4wrbUbZhRTCYPAjPiF4hNkqVaE+uFyEHmiyt6WCNb2Qt+TonkvexXVC
	 /hi3NoJVbezY3A6CuFHQKdNlnz6frREf1gk4xKR3xHYjZbCAtESJb/VsoQ2C9xYdim9jr
	 /d/qqpiaZfJkua86HonVB/yKoXymUhyWmpMaJw1fPrZ1pWyG1h6BFnlthVeOZqqha4b3F
	 mfum2ivGBTI+ql+POdMWpp0SThx9hT/fFL0/sUncQ2l8iAOgnxqUxdmgov4K5Oh+RbTYp
	 tjNjvoCOMeoe4zmM5G2GYtPA41oqredTWxVWJdl0R78ukrv8wgyoEizrzZvZ9FKJ2BQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OHtBITZ2r/zH8gBXgPSnqr1C9LTnC+DZF0tz/s0XXoc=;
	b=F4Ftt2HeGsin2VNQvW0Nm9EHBOIiNmiqMfaofMUz4yKt7F2FrpnPedNd82sfLQsayrhZ
	 AtqLZpcTWOz+FYgHsiO+NHagsx3LGN+C65Uw+XYlGiQ87agiP58mJmlZnpeHkWq5nfa0v
	 9TQkMRbfzinaoW9Xv5byQXlbuDXXeBd6tutsoTrIAkIK0w6H8wNX9xIJ1R7UVQdgqNOKl
	 TXZnfOVLeeLkOEt9QNN9c+p+zs58E7kFKLIhmjZdhMBDjbOVA9bF9965iVEaM7J+uaMvZ
	 tEfX1rXApPKWluPrEzByZRYcr2F7lry5SBTekEvETDhcaDWt53SLTLEvKsLSnGq2IAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678770;
	bh=OHtBITZ2r/zH8gBXgPSnqr1C9LTnC+DZF0tz/s0XXoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKebaBJnwCeHvFi4+KpA2Lf/WQELYxdhhe469U5ev0kaQvUvDqz/MHXvUwBm0didf
	 mKvkEownu8/MC1pJ2Mj8E+ifFcGiegzFwMF186vt/q2kx+BDGRejIRVlieigvS0Fx2
	 ApGoEOwXNPMeYwYpK07b4JgdIugB96eBQaWyKHgRMA4isna32Xu64P8LoH0+nvEJaj
	 eOzOfbKRq/BOwKfHmoZ7Vmfh0ZZAHBGssQs9QcXzkrwZ6/+MpHXVojiLJSaAvDWYcw
	 RKPjEH2NVInebCidTbkZufy5S2HV9+vXnTfbaywVMXYs8/pBYQSGWOpykVBrVwW1jn
	 na6RWZz2tiL6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F5C140554;
	Thu, 22 Oct 2026 14:19:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAE762A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA6A60673
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSF36SlV7nVb for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3705A6063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678762;
 b=RVXj8DHnqGgZqCXKqqVGE6Kne5hfwFY/jP/hpIH+WgJS6dWAD6YW3wtiNCxssfqewP37
 GtzL7RSnk0F0WvpPZjMxm1x/VDt8TcdbIST+419PvjsAecS6q8iVvgeWdjCRC30F+yYpN
 4ydgKh+RTo3fzrLZVzc1i48UJ8nesm3oMwNJKEuHdRvBYlFRzRTI4G1SaNG/TRHic5Cw8
 IQhdxU+ha3WybQfe/16czXiXHZ7DGtRJ9br8jRSpVdT2uWnJNR80WwA1QhnaEEGV63OaM
 Ef57jSnDy7mxttI2/d1pkJbO9lRvJel+uzrQHH3TKpWkajCug2IZaOdMhrppz+Ztslg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678762;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=OHtBITZ2r/zH8gBXgPSnqr1C9LTnC+DZF0tz/s0XXoc=;
 b=DKUj6ZAY6XIwJeKehFrpN7yIyESQ8SPb5iVJ5eIofR0+AsziG2WuK6BcJJPDS6CkFJ0r
 yDV+nZUW8cs9HgpXCBMvdDCxTLP8Lh/a8SmLt9CKpFQph5EJRSpHiD4ZsVau/liNcEyoc
 M0b03tV8F+pVdLA/FwUs1MI8wvTe5Wp+YA3jK4Sk08yhaayor2dRXOySetOZBCSWckEzR
 6DqdX2wrNk/qpj8iqCA6sl8NWX/d7qJcfsSBJZMrCaYKOe+a54WP46gFd8Gc6gOj2A0Qg
 9ghYuyKrjnBUqE0SbYJwyC0MZWZioxdy9xtDL3GMpjOretvkhDC+fm4kDf32CAeB0Qg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="KE/vLPqh"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KE/vLPqh
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3705A6063A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:21 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-843ea301d60so1370523a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678761; x=1793283561;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHtBITZ2r/zH8gBXgPSnqr1C9LTnC+DZF0tz/s0XXoc=;
 b=KE/vLPqh3Z1/suTDY58cZhP12PehCEmRVgfooFLWNWvCBxctXrps2tWEU0choas25v
 Msc5A8USTow6YIHrkRNFAsDcEdT/JLoUUBtOmG3oM9QDCRJtZtYVZeRdAePQX2ki1Pw4
 zEKY0EWTmfL3CLVw/QBkVZvnjodUqVFfhHd5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678761; x=1793283561;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OHtBITZ2r/zH8gBXgPSnqr1C9LTnC+DZF0tz/s0XXoc=;
 b=FWZvmnhIgy1nc6JKFrZOztnaOovLphLH0kNMuNDfGHwtRr5wiUUo+tYhzh8R+vYRYP
 aRmXo7PKYyq6mBnviJBJ0LS7zaQ93zjRBXqjMGRz21L9HEriKyd6VXxJJGNrSaU4qIff
 RpW4XWgbMNYudP4Z6LHaL1/m09RZ8Jkm8MyCKenl4bWspG9ueUBdlksgUc8JB0yrtZSP
 c52RSANMP1Mdzwh3udoAc5B5JFB+N9C9aX+clwJnOmcoIfEaYzVfuyZ5azD+2pGvMPmD
 6xpnQE6qFag2XE86SstHWJxaCG/DbUVWrO/6fpsMps0VXtJ/MvccMARdNcytKM6Yn0yo
 qXlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBziuTV16MtV/NMf63VQUG8513A/dSLP8jV3FHiQyHYZ3kKFifMuowGssjSTsqv2ieQlmc9lQ28=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJwGVTEtRqAY0if2VBLVvZgztHc2znqtUkAwxEqA7qDkGRGjBr5
 1WIDUJ8Ov5FX1N3rqWrsxeq8P/xHcsBh+A6vSlHl4el0VLqWFhC9Zg6R4Mpqk7qXbVYUwKc2tIE
 km27UEm8U4JyJ
X-Gm-Gg: AYBFou2+bnEP9r5VcK1eA4aGzlhe6vARThNwZofxa2UMHRlSEH0b2+kTh36Zv/2+kei
 rANMZytbZy9XhrOerNDVx+YRkvme2iMH+C933Wzc+li+IAlbum0TCUKMHa+Mj+nVWwAgaOW51no
 k475zshqaVIrwagAPzFwmb0oo2oXTpxFjnoc2iI7cIch7czUJRH2haD8+5rP7GmJFlNvBJy+WQf
 RGHcshRi01wwtCO1fWx7WGbJrjsDPy2XVEWg4YbEDf1uIhv/tI6rgBXkvqQMdDpCa47HZrR9v17
 Gs7erMr9a9IlALBQyUV69mcTzjZ1ZkM3kGNwIi60ciKY4GqgAu8kaBrJs9pTPwtOGDT5E9e7mIl
 RROZZ8MlWsbMLXI/kl5HBnLjVFYgcWcVaM51RBSYPGVFt2UJTXMCPhk+x1LOqlIVepoOX6tGZBW
 ORFf1URdhkmhJnSKNONB3rKf2coj8+okqr7Wk0QmgTNS16lGHeeO9ai2rFuW/9Czsi9pzLfITUG
 QOA5ppxinFdDu0GFySeZBGChm/DoLtwpumt8HlZ7AS8rMUq4KInW14aC8iO1HohOxWIH+58N7WR
 Q9xvxMO6zgiQ/krYgyQAcZBLWyCgAy2cF88uTsI0ofN+/Qu/yYnc3iR7MX/BwRCEoQH+Pr8jJvM
 =
X-Received: by 2002:a05:6830:d05:b0:81e:a323:f3bc with SMTP id
 46e09a7af769-84d07f1362bmr4486594a34.13.1792678760748; 
 Thu, 22 Oct 2026 07:19:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Ssunk <ssunkkan@gmail.com>
Cc: takahiro.kuwano@infineon.com, u-boot@lists.u-boot-project.org
In-Reply-To: <20260708145648.329-1-ssunkkan@gmail.com>
References: <20260614134406.542-1-ssunkkan@gmail.com>
 <20260708145648.329-1-ssunkkan@gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Message-Id: <179267876002.3588521.13143160198415232490.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:20 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 08 Jul 2026 22:56:48 +0800, Ssunk wrote:

> Add support for Dosilicon DS25Q4BB (256M-bit) SPI NOR flash.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor: Add Dosilicon DS25Q4BB support
      commit: 411065073ad5d0a02ee6765026aedad1661b746d
-- 
Tom


