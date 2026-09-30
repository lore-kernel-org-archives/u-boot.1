Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07918CA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0C2940844;
	Wed, 30 Sep 2026 17:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aq1LFtLaNZys; Wed, 30 Sep 2026 17:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1361F4086C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788662;
	b=EVbQ730TH+HQ1gINfeVWRNHH8uOo/ijwNKLepICEGjxYCNznTuO3kCApfjUVvs0y6QMy
	 lhqFEEVMvSpdBRwPFrkyj1UH9YlakyugWxTlYlpt/NOvSHce34/hFIjJEjlhpZO+gAMtS
	 zrpaYzajbCg/eGXoJfpO4oz4gKXCbs12JcxsWYFx3i5Dox5+Oavn37W9enGVI3EhwHe06
	 LeYA/4C72s/G92TzjVQQ+wZYK3kWnbHc8gSFy0omtvyYnHfCZ6kR49KAgiROiN6a3JWw9
	 CrDyLUN2yjaV/xzSd4SulL9onFncvUU0Neo9BWmZF3iex3QCCxBExfewwV3yXCff2bQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=agDOR1rSXSeRNyqnr3BXbSlHqmCarDUnojwmKBjtGPo=;
	b=pN/gsLumc1gtHoUYC/n6agsj/9Ku7LHk4YdTEW3ANU2jmygi6q+h8ns96G+1TtH2dXpB
	 2Sl9PKN7RnQj0yMfjfCisLNEJSYtv3A+7mtN6zFRXyTSUinnvmDKUgliPh8OMuZ0ng/oO
	 XZhjIqxpfQmRnAkiFyJvYK3pYZPHinBH8KE1qQwDZao333w+y0hlk6mf0OgtZES3bPKr/
	 WBxkhbVaSvj+gtQSFhL1TqPJyLoQQAd1avAQ7Bg9mOIBg0ZxFzFGO26yf5xMZYDQpcDid
	 tkj0B/m41OdtPImxi4p+KDpQU2BBOEeoMXIxPmAolJqMWrKZNF2fxE8cz/EVBWQ+mig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788662;
	bh=agDOR1rSXSeRNyqnr3BXbSlHqmCarDUnojwmKBjtGPo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUsC9rMgcO5jc7UaB+VxErtQMqt1qY9wlks2Kw4oLPYQmZ8xVDTjLGPxcvUoqjiqx
	 ieZqY8mCVjW8IhOBFuBsTVydGv9fEUL7koutIVcxeE7m2UaN03amtnvLP4/ZKqXujZ
	 fdkVwDXlw8k6PvwHU4TiG/zeD0lBAHYAQ7K0J2Ek//T3VmdzED93ePfU0av8Kyhvul
	 2NPuQeXkwQUPtxLcon99+p/O0QKELceNiCPfIwiAxl4Qgh/oe4IIzeW/EG1QNTd/n9
	 sxK7VmHHiaio35iDSCQjFfH/IcAGl9YE22P02LN8kXsaU9ciP5ZiIDsFFJEQwbuiP/
	 lJzCk2tMDEiQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1361F4086C;
	Wed, 30 Sep 2026 17:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 659F224E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A2CB80EB0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFzAftlapWCB for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96D0B80D32
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::28"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788653;
 b=hEMjO/MsxZgHdqx9qn0ZejaYFyrpm6JW/8MX5n31EqX8+X/Sg+IyyQs2D3SlUKycXS06
 z12ZRNjbYdeXmtsUsbtnbKGypqC/01ythO7lm3sd6HOgtbXbs1X5XUBU7IT6dC1uwZLcD
 3S0YFlkyN6ZovtP9YUDlu1MEg6vuC3OazcYKkhdmidhI1D37p45EHMuVFkIlw8Jh3dAzO
 KU88Rozmuaxw99X8C7bdTWgPh6mcT28p3M07woi+Fz90ANOWLPvOGJ072MYvVpBEwytxt
 P4jYdVvnfbSNh9MuUyh/dIJt327PcXGuoPnTBwcQlZwzU20PZM32I2hRntKrEyu4ABQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=agDOR1rSXSeRNyqnr3BXbSlHqmCarDUnojwmKBjtGPo=;
 b=chLLJ4YOfCTGBgVx2/mgrXQqbUrGXAFfl4F5mVhWfnDPjiIvW2EHtUaWH+OC/Er3Du3l
 AXPtxZ95WsZf/XK6POe8arB+buOD6jT798F94ridWyOgNku3daeqyOwwsUqRE/rxLqWwV
 bCoB8ht9jRgJvyvkryUXHmjUhabuBw6AEXBUddHGvvtolOjMxw+tiK13IeGekLAhTkSBE
 tdreRAJrGdiviqnTqzilI01OI2tyQcUHMiKyRych5WwOGwBxGuabBhDC7DoAwluc9wDA6
 UjzViwJZMJWELy5EL3pc+mdPeBGSE0j17rlLLSykmFT8oJHL/5ky/ZoOW8jltX4cc4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N5WWii7I; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::28"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::28; helo=mail-oo2-x28.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N5WWii7I
Received: from mail-oo2-x28.google.com (mail-oo2-x28.google.com
 [IPv6:2607:f8b0:4864:31::28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96D0B80D32
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:33 +0000 (UTC)
Received: by mail-oo2-x28.google.com with SMTP id
 006d021491bc7-6d762782f99so2109078eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788652; x=1791393452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=agDOR1rSXSeRNyqnr3BXbSlHqmCarDUnojwmKBjtGPo=;
 b=N5WWii7IZkF4eE7iy4h0qaIx+fPolkMhX4tyiKilVzXWHOMfjkTO1/PK8zrltDI6AR
 iCE0HfxrTUogNtawbhC49oMGonka2vTmLIcDeL5uYYgPcxxwNH3Ffhp9Y215oFuT0P3Y
 z/r3xsKYNGdNjpF8vfr/1t9oJW8NQ5sfL2DSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788652; x=1791393452;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=agDOR1rSXSeRNyqnr3BXbSlHqmCarDUnojwmKBjtGPo=;
 b=Bkwi7dUq47HxeZUVLryfNxCXvMlc86uquFHjmwhU0nIqBPDAIP2N6jaHLtabmrUJ/6
 5aj6HKT5ExwDFx6cRB656RGFjrhFvMO/6yQI8ziR2RI/Wck9cZHqMCOEU3KIqf2UaVOa
 ZotnynFJMHOnnq7dp31EYSV6hIVnZ2gFcmc2XKYfILNOPuTJrVyXTuVKwOP08rIcr3I+
 lrdxukNgze41J2gRwbmespwbilJb1OzmC5bJEdKUTxh7UDCR66aMn3/NXxEZpySDi4Hf
 Be6OBDQ9BeoRtc/cjtssRjGXknerAOtN9mrxGxZFlHyIj5KGQ6kNfbLzV2+Srjk1mjA7
 phXA==
X-Gm-Message-State: AFuF++nUe0EE+8bKE142Q5sJiNZXtT8ajO8I1YEXfCFGMyJwQQIYHrOD
 yNT0pHshsaUUe7+Is9RSUN6PhgG/ORBFEPf7ZjzfbAJxTxRR1hX1CTH6KgQsnz3x7M8=
X-Gm-Gg: AYBFou2FHpSAQksRSTc4/z5Y24FjEZ65q3xVoN9KOq/iRTPoCvL40sf0urNmOzHVmjI
 LvqHhBa7Wc4VbAxUVWiFU1PFJeWONUe1LA1WkohwXV2HGNDZr5TprWhPVc/VPfpdBD6ErsFIFWx
 ezOBc538Mb9J+7711xwsdVc9EWDADXsn57iKI9b62ig4sTjWBO0VwtGIFkpkdqHrp5tudn3aoIT
 ZaQO+4++wrJXdKHeJRIaMyUkdcKfaX+DDzT0rCBMgeJgbVPW8tS1acWNPOWF3Ubos1mzEirQCuM
 iQe0RVejircmAwqQ+GpOv8W4LG8+k9WrmO53A4+P7i03T9wADVDJJhkHIMDCuRlPSDuajAwlv81
 kXYUbx1zMYpkdxMZa4L2sIh56MrI3CifW8aN1Kf1Yasv/bo4aBRpq6OHnImccnU2zW7JaNabF5Q
 5wCe0y2vC7Mhr+6lkpSvBSbqd2eceZdO52TYyNDj3VbSW+m41RCBhfANJCvRAQhAwCDfHfIp4He
 NKrpuY8skJP5hb6mUlPPjeXHGMSNQXgEmo4/+rEWpz0TLDEfMs4uU5iTDZXKb0Nb83aOBeTdZTk
 A0U0SvIk1io/AfeSvw==
X-Received: by 2002:a05:6820:4df3:b0:6ae:8fc0:dbaf with SMTP id
 006d021491bc7-6dcf1fa7093mr2201825eaf.1.1790788652006; 
 Wed, 30 Sep 2026 10:17:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Adam Ford <aford173@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260913155217.84107-1-aford173@gmail.com>
References: <20260913155217.84107-1-aford173@gmail.com>
Subject: Re: [PATCH] board: logicpd: Remove i.MX6 SOM support
Message-Id: <179078865065.467656.10397758668854757072.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:30 -0600
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

On Sun, 13 Sep 2026 10:52:17 -0500, Adam Ford wrote:

> Remove the Logic PD i.MX6 SOM board support along with its defconfig,
> config header, device tree files and Kconfig target.
> 
> 

Applied to u-boot/main, thanks!

[1/1] board: logicpd: Remove i.MX6 SOM support
      commit: 08addf800f497272f175bfd2213952c845b0324b
-- 
Tom


