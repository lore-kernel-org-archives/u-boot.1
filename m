Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB011C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37653608AC;
	Tue, 28 Jul 2026 13:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6IHJx0xOnYI; Tue, 28 Jul 2026 13:48:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3831C60899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785246487;
	bh=XIuuKpIzI45kvC53eKtKhIUkNqmMxGFw0ZbKiNR+x98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYyK5nn2D5MRoz6CuhSYcLJTeYWqPpW4n0ue75xAyHoHMagxwXFrvPgIcv0fKDfLM
	 wNVRwzHrOA9HawSJapmcZCJAsVuA0DQzWSEK6RDoMk4wqO6ECMDH/82gqSP/0hCOGm
	 4zfs9GCXLEYDExBs2n1QXNc1kFi5xabRuy3e0wJN/FlJJVwy7R/3cxZPdrrk9ww31u
	 TCCahbcv1Duu6E5Qmtlti+ppp7f4WaY/tZALmmWqNVFiERoVJJyy3KG+Y5F+g7fuvn
	 wFk1ZacddH6c62t0XJ4HkD5xrrL8PtovLUYv3v4F4Mc5s+OzZ8Prmn1gQUioLrYV8o
	 atnaVR6eldfPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3831C60899;
	Tue, 28 Jul 2026 13:48:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E542E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C9A6409A1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C1Qfgd6uZ7Gs for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:48:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D7AA240994
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7AA240994
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7AA240994
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:48:04 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-455ca262ccbso2118242fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246484; x=1785851284;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XIuuKpIzI45kvC53eKtKhIUkNqmMxGFw0ZbKiNR+x98=;
 b=Kkd/vXX8GLvI5izNIqggWxmV8ih12+xkYHED1/8MPx/s/C+/VDzw8BgWpKAFxq10u7
 42WSoHMaQ+lT0Bc/AFh69huP6dvAtjK9WTngVapGPbUab2KXUtjHRHYVRKuTo6/BZEXG
 CpRvn4c9Z3JAQ0g8/iE5zU00vGL7ILj6Tjagb1czl0UGDhLjVUEtfjxui2wNQflfTweN
 FRk90ECs7zwxlodtDUhUZljf2uSiUUMCkYE1Db+idXsPzwOxBl1QURgsbTOFjt88BJk5
 bifaZwGhNQhecW4XQc+Q2aloK+Jfd0Dr65WigQjqkssAuq1hb99SSKtpcfkql4m1WOYi
 Ow4w==
X-Gm-Message-State: AOJu0YzPNlGwbXrwb6ATa8rRNd4okl5lwBf1jbVjNHl/G6Q91ky4Mlsr
 vFxBp5sodWFwhnCd+OVf/TjVcejKsqsQvfSD3CPTl+P7d3fTqN3guEG3ZuLTChPworVKpUxH9nT
 7xLny6eo=
X-Gm-Gg: AR+sD10F6UUVGdFo58v/zkIkl92evcjStyMg9d28fa7rKd51VhaUGNRwzhhnBFHvk+Q
 KjalPBMAObnCZlGz6cbcxMXbJc/z2nrzLmyYLQCox8kI7Kk7mX05BKaTlM0zpvgh8XvsUNmeQLF
 WsIy1SNok5zmD1HczshG46cwtmyY/YSAZwIi6I1eSmoeI/dfq0I6u0CRtpyEZuGXWvAu3C/5AUO
 Vn9GcmehJ1tE4TzStybClfRMqEap3ObggLvHX8stSOGpOPs4fmqCxCerZboLW5NZajfYt+b1z2e
 hfAqA7yV9jIWqixMgYr3nJglDRqCYt5yYIyXONDqgpkGoAvzjb8KG1J4eJJbZWkYDf16v4UQ4od
 BHVMUgv7aM88shTH/z52ZfN58rNwRsV5OjZ0KwtWK779S+v9MNTldSpS9VI7H5wvfBUwUqakOVy
 QH0v9wfXSdDwIKWYFEeomN+aTHwnSmiRgjB5g4OZiMyQ5Mkg6L42vTRoKfnuTdRuvZORx2mYCrl
 LI/ebZNEg+lC4Tais5gxJIWnficN81DzvuF
X-Received: by 2002:a05:6871:8a2:b0:456:3b34:7a0 with SMTP id
 586e51a60fabf-4586c9f0076mr1516690fac.28.1785246483635; 
 Tue, 28 Jul 2026 06:48:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-457a07c9427sm16191664fac.9.2026.07.28.06.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:48:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, chris@kleiner.pro, uboot-imx@nxp.com, 
 Max.Merchel@ew.tq-group.com, emanuele.ghidoli@toradex.com, agx@sigxcpu.org, 
 marex@nabladev.com, mathieu.dubois-briand@bootlin.com, shofiqtest@gmail.com, 
 vitor.soares@toradex.com
In-Reply-To: <20260727213351.2603837-1-festevam@gmail.com>
References: <20260727213351.2603837-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20260727
Message-Id: <178524648230.1579717.11765881194800360903.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 07:48:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785246484; x=1785851284;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XIuuKpIzI45kvC53eKtKhIUkNqmMxGFw0ZbKiNR+x98=;
 b=DWFRkOmjVg0UNs7G94JGDJnQk6ELwpY2vz5LUJYCWimVbGGM7qevnkbwyJclPHaRPA
 1/4MiHLwqsTniTt110R1z0HqEbMh/i2AEsLMmWzwd0VdMk6aMMNKI8LRm0KafwS3XEh4
 Sw4wtI8z0uNmQzRbSQRMXCaGZkRK/9PXRPDjE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=DWFRkOmj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 27 Jul 2026 18:33:49 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/main, thanks.
> 
> The following changes since commit 574b1adad70a19d95c65e0f37f9c36d94fb5418f:
> 
>   fit: prefer the default configuration on best-match ties (2026-07-24 10:46:16 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


