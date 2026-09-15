Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D6DC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AF4C40603;
	Tue, 15 Sep 2026 20:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6E25TmctCV7o; Tue, 15 Sep 2026 20:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40EF0406FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504544;
	b=VOjE17kILxk7iX/OBm5d1uxEOxEYnsZG4NQ8+nGuLa4KzYX9Cw9+AHVv05aNtQ5M33wO
	 dm1RDcIJWHRSmpBkxXUbqdOvqZc/W/ROtLtcHYtDT5nwwDq+Fd5DtEsHvwCojhreTpzBI
	 PStZnnj8XLSowtnX2zse0GppYcRdbLSfBEs6ayPThvq1PEMz/xsuo/7RwFnjGfsWrfAmE
	 dbvvqJCBxodYCqyB44wEurVeFHafZcC/82zkaLDd5klcB13dh5Rw36odaJQdyVpGCeQDw
	 HtampbkOCUkJVQlgXjL2acHLwy+5IhgNG8SiG1SADh5lp+kqey8HdD5PHlFx17Cj9Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DoTJhZNW6Ymd57055qhKBUsNdEnOSrGFmShvL6bMh9s=;
	b=b8uf8RXe0Y43VZC7BDBNsVYtSz6Cerm6wfRN5ZZoYnwIC4aRTlbGzjTv89LlzkPezdPM
	 WjvTvz3c/7gu5keAB76HH5S72QPX3zQeLXCFLiORKsHhoSKvUTbWShTB5L+0LpVm1J3ji
	 LuIDR/Q/7Rbd6aJT6MOOAPpubKT6pkyWQ/s3i7G9UjEN+GBLu+gwllS7nd4/juh7rhuC2
	 fkF/Jj1M43G3Ezog9ZZEou8SM9+wePZlre6Ale0xW7IvVRypEgHfR42kdEoj/MobdSYP1
	 YQ2rLYrcflv+cgXTzJBfx+Em8hAxvoySaN1lx/m1Mz8Lmn2Ej/NjXKevfmMwGft0z2w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504544;
	bh=DoTJhZNW6Ymd57055qhKBUsNdEnOSrGFmShvL6bMh9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gp3WqlaNvO8Mg7fZcvobsUGkroMv0/G4Gkzc7zioPtlaBMAz6nkej6//nTqOmtFh5
	 u4GWuKv3qnsdZdyyT6yl1N4kdkXb+npwAscM12lK0kbt/vQTpoeszdgSkc4Ut0jgP0
	 nlmih9/8U5aaH1wQhLJX5Ajrd+Ua+95bAER5wEPu+XXjTXuD91DyIMTwUSxN2g9nyv
	 L9UIeUKlhP3lkrJYC2bS35QSI5PQNmZ9r6U0NizpMUchFPzkjEteuzcmfwKUd1XSAp
	 eF/crchihZI8S5D+8q224LLpyE5JoSCUuTiaWqfpeatW/bV63i8zF83dLftzxHSH/m
	 1mV//Ro5gBHWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40EF0406FA;
	Tue, 15 Sep 2026 20:35:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6084B2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5259260783
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ze2U41cZR2E1 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B42326060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504530;
 b=sqsSwsgnQl/Soq9wyQkInpRdZs1xiODYCcKdMtfF/6oEzqTy6PCZTwRr2uIK+D9p/fDZ
 6xtpGe+FKD3yFegK3HYaaB5YblRwOMOMVkKTLV9Ba+zmiTgS9XGanWePY1GvFLR09aTyG
 BtpmairPz1pBCli6sjyHPJYhG1VT6ba7ZGAIlMLPCd2TSeFcedMKsSbCY8DPDlZZgAxut
 KWvPvxjQ9arO8x/VtdT3CicIVYpolKqjQbD8b3MJQG3CSvWt/JCx3ApwAP/HIIlWtPP+O
 r0vwsWQKH/fEl9p8zd2vQIjCFf+/wefhW9URowRc2ag/UtVjtjaWkwWI/IctbI5WDjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=DoTJhZNW6Ymd57055qhKBUsNdEnOSrGFmShvL6bMh9s=;
 b=LHhSXpxtt1HAWNDmig19Kukkk/UjhxYG1PbRAkSGnlJzG4fn+2OhmbyxrVigOFa99f8X
 rwIJdRxUWthFLw3IvSUAikWf4bLfEWhpBtJ8hwdV3PjZI3U4FVj+zr5N1m2tiBSloiOpG
 slaQI845zx/2BJdzERfCJI61mKvYVG56vt07970ZF0vb8O7zAWdjrBmWqJeq3oJKwaQLf
 d0UOgGk7gp27GPnZeCWmEKuI2Er56LuVE4x+B1z//+4jdBpSitxEg1bQEMrufncHkGbrY
 rLYhxtoKga0t7Gozy3V7GkFM3cxdtnMjm4MHYhPQVjn/WUlqFn+NOfbnrJH0wRb4d0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BlLJYYCb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=BlLJYYCb
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B42326060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a3688a2so228832b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504530; x=1790109330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DoTJhZNW6Ymd57055qhKBUsNdEnOSrGFmShvL6bMh9s=;
 b=BlLJYYCbvRZ39nceYNdZF3YKEPEr0SXlTXsgCXiPeJjDWeyiTWfAqcbo8kkGB9dGM3
 ZEvIbpOBDHpXgDQaHBeiGvOXRqk2vu/LIbD7KMJgdNdaYahUZ3aWdnhgXiPXi4MOe9kD
 8Z1PNZMPIeBEAuNw6itPOZvDkk+pQh28fpHiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504530; x=1790109330;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DoTJhZNW6Ymd57055qhKBUsNdEnOSrGFmShvL6bMh9s=;
 b=JNFCv5amAj1aXklEd5VgnDjC8eFIFo8pLefVlcEtEzezv/Aow8irY0K5p0dUd7Dwn2
 miLyZku019Q0GfLpNty00235mIHgvZdMnZtdK1YxvYSbQl8mCqe0Oq4ilF3qb8fM03YU
 h7xgRrmBJ1iI2rMBWFWrEMHvPcg4YYK1PRTZoSoh7wTQKAGqbIZLVyMgFijfVU13KJtE
 nC4AAJgcLJRUrmGgvPEdRLTlH+UH1SszjPSFTEHLEgOIHFl0YPmZU4ugQMJaS7yvp/Lf
 E7d/gHGqCOKvfIyfoNQBl/dC8yhsXahM48zmsWS6sByZlR415zu5yppFFOZIltqCcvXu
 srvA==
X-Gm-Message-State: AFuF++l7I2WUTSHo4vcJr/F4lFZ1xLUc70+MBIZWKcDWd6v2aIu0RjBJ
 LhDxpymYbOdoXahpg8eNmR9bIw8BKAKGB4Ihdgr5lkjCGfxxLhIyB9heOmOwB2mKPl4=
X-Gm-Gg: AYBFou3Jz1EkT5LXMIUBLKEWcgH7WRR4NJihiPjJCGnDMmTa09Ka28cOhGOvWdj/xxG
 eC1km9Rs6NXqvSthqh0LrXBpoib+d/cETXLPwaMNLaRhIq+F5xSPTxofJDbNHpy43gTKrlrGoeg
 xdol1M/+R9UFOy8Xsu0rzhIRb4wl5IzdIOX4XJSUEZx61YtVkUvxvx5DosBJ8sewJxgr1aRpM3M
 Hf9fEimo0S/uzxS9XgW0P7x/BajCii9RcTEIFQT5sOcoK5HmwTkBLtw2jSD4YJ+hVElfkdhKbxA
 nANHStnUizmFB/d98HroNyC+Z4sLrqUORcOXJw5ToA3VrcTWKxmBapQWRCdaw54stFELkxms8zZ
 boRJHq7mfBw9Mycq8hNFfxwbflqE5Wi6J+Hy4duTKDVASardu21xXoSBVZ1cKU08gzomAtNYTLn
 G8a3i+Npftpxxm/CV7YwT20l6G+UStofK2rtFl/GrB5S3Ihfq+7wqHoxUcDka5BXgp/bBFURvtd
 W1Rjm9p+JW4I9OP9kZEWkSHaKE4SOhPJxOSTcApExPDUnkg7lU8xETDQmMHoUfk0xwhH3rMzUzB
 HyLW01ikwj0dIkTjERUDc2HRn0iEDw==
X-Received: by 2002:a05:6808:5190:b0:4b9:a8ac:47c with SMTP id
 5614622812f47-4ca4c17dbe2mr44710b6e.26.1789504529834; 
 Tue, 15 Sep 2026 13:35:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, dmukhin@ford.com
Cc: ilias.apalodimas@linaro.org, mikhail.kshevetskiy@iopsys.eu, 
 quentin.schulz@cherry.de, sjg@chromium.org, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260901221113.969840-3-dmukhin@ford.com>
References: <20260901221113.969840-3-dmukhin@ford.com>
Subject: Re: [PATCH v3] disk: update partition type reporting
Message-Id: <178950452877.931545.16995982029239960928.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 01 Sep 2026 15:11:15 -0700, dmukhin@ford.com wrote:

> Partition drivers currently report "U-Boot" as the human-readable
> partition type. This does not describe the actual partition and can be
> misleading to the users of this information.
> 
> Update the human-readable partition type from "U-Boot" to
> partition-specific type.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] disk: update partition type reporting
      commit: 11cde642ee8309597832875aca105c91f846cfbc
-- 
Tom


