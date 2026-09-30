Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E771CCA5FC1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 20:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93929811E3;
	Wed, 30 Sep 2026 20:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DA-2qKKJmNmI; Wed, 30 Sep 2026 20:15:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D5BE6811DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790799323;
	b=ekeLepfAOaCDcjJ30lGCHo4R8xrO5otoFilAIKQ5TF+Lk0mb3I3YdTkCbQxmHBitga94
	 K4NRhb0f5WfdsUGHYa5TYBclc1SvxdoKSaa/Fdc0Pydr6rAnIElk7eTGIR/00FtcDylGz
	 YOSpvzxvyCLemtp82ad+5FqC2xP4JJnIs8aG2YutFhFXSl2xjzDqwqGOIUEjOM571oOgT
	 jX48PDQFFdQ4aHD+Xv92OADppmK2stWPbKl2WG+TmKePUjgltKXemqsMnD6QBTd+9mdv5
	 O6jrmxDqRTdzf5dcN7wNqlGT+GU+CQOXo+AiQjehfOpMDXwVyFY1HjZncZrTjBtXrQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790799323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zO1++/SrQ8YxjEIAdsK1YL30iQWMgWpngeGYPkAfxuI=;
	b=NqdtSwLWbvd7tPlVMLs+l8VVeI/ssw4SNVnNELW0t+1VZ3Q33nRYbyxgQP45FLGKuflr
	 YLSXvifdH3jKt4JBooc9ASAwExCbqpfJz3XI9eWK8o3OTaAOV1WnOBQzyT7CV+8KzNzgH
	 BaRqz3pT5Xlqyz+eEoeEf9e56hTraqoGu3EIWUNqTJ+F4FVu/6JZWg18dYDy0Qkv/Q59s
	 2MOInYaRCKANMEZnE5pKpc7eBvmDgXin0QtrAjqwBqph1Q0f8o6HwPNRTL9C70wMygJnW
	 0sAt1t+Fa9T6vmBDQKGQ8Wy/b7tR5YQXwxxdmogtirraOhE0P2euX7ERr2M9D3kAxow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790799323;
	bh=zO1++/SrQ8YxjEIAdsK1YL30iQWMgWpngeGYPkAfxuI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kOM6W2X4plYwaohZNvNe3rd7oLXB+3moOXsxssTtf7YPcq/R2ChrFaoe9oczJhCWN
	 QxWg4zlRCASsxaExzzPz2uhYU+x0W0WPkiG7g+kt8sIWH1mWu+tc9IlOCFzl8tW+7o
	 NmctbrT7feoZ/TYHldecB9Au9Kc7RC2JJy/LzuIW4QgjobIYjHI0sF1Yw96S5YwZ1I
	 3GZCWyphlKOu1NRL72exWmelNK64fEXJxiQF2u+z6/GwV2ZYJz+v1qqVfQJuB2eA7w
	 8OF5/xF8ShbqKkvwSgn9Wljc3WbgYIE755iahkHzQi1L31d30KgXPuAjE8fF84c8tf
	 3kB5RitZdKtGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5BE6811DD;
	Wed, 30 Sep 2026 20:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B7FA24E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 391D540497
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D01dwTIbyjxx for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8469F40489
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790799313;
 b=ZOTkXb4Aj+WVBFOvc+DB/ge6tpJlFcEGWMUDrNrk9GhB6UMbQnf8DpHTHG4anBWhKzpZ
 N6kavJE5fFYR23RNpKE59WbR4grLjdbeAC3WXz5Wpi8bpzmANbBODPl87dJ96Jvf0zl+y
 e/Dik6EUrzO6Lxt7qFCpy9Du0qEdR9DTZIRyi8nZlziyB9tfUjoPzpt4cQsE76o7gtmOH
 xsd3Dc6lXr+bgICTEvVIzXQ9pAE4aKOj91a1649P+6D37b23qkLB98t6nFdnPRcV4gz4j
 qW6h3jOm7MOPqDUo4FdL4rTxAQTIxkUuDhLPSr90zHC/02QyVT71P0R9eEnJgcct/mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790799313;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=zO1++/SrQ8YxjEIAdsK1YL30iQWMgWpngeGYPkAfxuI=;
 b=fGQuJ2ITdSgFkFF6BhH7E2XrfTMxfRQy+xpejeENGBMNfAEF/eL/3TIyYOXVzudQ0agB
 Is/+1jqMz8GzaN6jjCCbhBrbEVLvSklejBbdlcSScL1c3VzPKaaQfjQ3W6aSXHDq0ZOFh
 nRQdtMHeJ3HsX2CjzGB7DwqCnDB6yka9X2hYnFWy2msUbr/eZDBd1hFUC4yNog4mGw9ta
 LrxYS2teMnQGpmVJiJNJ3u7QA4/QtFMBWvsGfkk1jO6q2ksRU/x4p1CezDf4XFeUrw7qk
 GCctDMEbm85wC6epu+CBNjbguBwwVCbtoelmWek7e7ZHRUEDmQPKgJjSH37ZsHSAkhw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IZTySkNu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::e;
 helo=mail-oa2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IZTySkNu
Received: from mail-oa2-x0e.google.com (mail-oa2-x0e.google.com
 [IPv6:2607:f8b0:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8469F40489
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 20:15:13 +0000 (UTC)
Received: by mail-oa2-x0e.google.com with SMTP id
 586e51a60fabf-49df0f3a690so121295fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790799312; x=1791404112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zO1++/SrQ8YxjEIAdsK1YL30iQWMgWpngeGYPkAfxuI=;
 b=IZTySkNuIGrsrhFU6E2Ki1KTHJ3oWlxLUPKx6pSMcCPXNCaqpIobPR71D8REjcJI3j
 sSZQGe9u9a0pfFPDeTacT4VCCMKqWrWWiYtMuiSA6hGeQlf75IeuaJenHSCzcmuz7hHT
 PxObD6DVzraGj1+aLwhbarqG8oUGkhg2K2+t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799312; x=1791404112;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zO1++/SrQ8YxjEIAdsK1YL30iQWMgWpngeGYPkAfxuI=;
 b=LqFD5soEi6QPzou9eik1woK2X0NSWYNLvi1FXFEsAG4y6uqIFxXdmTZyM0nlooATbo
 4S9GNX82uzvXx6MnXIor+gb73Jtxu1bpAGFDmVi3OBIyAMEOiWKXDIO48OE8RX/hTpoc
 Fu2OYcbyetQKN3wFxXB/VO/851P2niBst2ohKeocFGOX9aWzjSNz6Oad/XLKaIcuSf0e
 6xR+pCbm7n1L+5WcMNqAQuckqQ2MfcqvBA6VFm245miEBnrijSW7EugV8k4HLjZZtRlZ
 oh3WDewMoJbPguBh3sBnALu/E7EO/jBEhO+zCCswX8EJKYVIHT9QCH7XWPHpcDXJUKUy
 KpRQ==
X-Gm-Message-State: AFuF++nKDT2MOrteGzKJvCngNj5r5pz7B8RYDNnMZqYJQzVxz0C1H7ko
 L+gfLv7HL4e4p96MJW0P+Gli1VUcvz8QAKIAvC5JXxXoTYjovuSO5ZL4WAK0ZqItYDg=
X-Gm-Gg: AYBFou2fC4/PRkDASw9Sf8Ivob6W2HimSzGRpYT8GK6GQSGAESJojWjVRkHiNBlrK+i
 fp2XaNbdf+S10S1wSUoa8QkJ/GnfxkXJUKIUz1EECwGOn5aJUJUfuzUk0zUFkEblH7rFXpzeawe
 7FTa7bMZGpFAFJsrIsswCTvg/9ba9xOz8A97A3btGRkSHpVLFLg+aVlTag28DR3hFUfB/TOdzZh
 8hJurvoWZ1eZ8zwjMeVZ+8KWHaUiMdg/tOfY24/gRnxMW84AvzxyZSr+VFTVgvqWqwC6zcDOIaZ
 CgDN04w/aQn00X9XtWzNGo9IIRWhsnbihMYx1jx7goxX7K4cnGTqcqtb3EhRIxbEH2/qUFepWfQ
 h6sb19QkKCiP231DBg9JXCJXomMIJ6JyrEDejgx+UgTzsbSLD2+ncCNGXT1j7JBj/CzqRdiq++V
 qmiPsRZYZtf+T3Qot2G9vlSifpRM3ffH8BFiTatL1OzT0bu+CMwa63vpUMZ/FWS0JrbCAvDgnpa
 T8ptcmjza04uHFiYrYZf1ValS9u5/5BAXxWnU3F3FQ2F17nJ1+hyKEgETzU6sW3vwzPMC6YZo0G
 TG8s6yc6BmylwtzV+g==
X-Received: by 2002:a05:6820:1509:b0:6dc:beeb:34bb with SMTP id
 006d021491bc7-6dcf681c69dmr2467236eaf.84.1790799311985; 
 Wed, 30 Sep 2026 13:15:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-821281a797dsm821896a34.3.2026.09.30.13.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:15:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pengpeng Hou <hppiscas@163.com>
Cc: Mario Six <mario.six@gdsys.cc>, Rasmus Villemoes <ravi@prevas.dk>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260906044953.28168-1-hppiscas@163.com>
References: <20260906044953.28168-1-hppiscas@163.com>
Subject: Re: [PATCH] mpc83xx: Fix MPC837X cache way-lock dependencies
Message-Id: <179079931127.506059.3479027088904472919.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 14:15:11 -0600
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

On Sun, 06 Sep 2026 12:49:53 +0800, Pengpeng Hou wrote:

> The HID Kconfig migration retained ARCH_MPC8379 in the cache way-lock
> conditions, but MPC837x processors are represented by ARCH_MPC837X.
> ARCH_MPC8379 is undefined, so the additional instruction and data cache
> way-lock choices are hidden on the MPC837XERDB target.
> 
> Use the architecture symbol selected by the target so the HID2_IWLCK
> and HID2_DWLCK values can cover the remaining cache ways.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mpc83xx: Fix MPC837X cache way-lock dependencies
      commit: 8c6c54c9e767ecc0443742b92e25120414562123
-- 
Tom


