Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F5CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B14DB80F87;
	Mon, 19 Oct 2026 08:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nl2UUmgwB-AP; Mon, 19 Oct 2026 08:57:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9DE280F76
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400274;
	b=fQVk4QjZQSjDfuUlUGhYN4vHi0mnNpAZiuvy4WwF+KyvklUY2dOExqcKj2Kv3RcDMBXR
	 n0lL+iDCg7GimwVDKQviHx7kSg8paIN0aIa6U2g4AuIU/4HLjGyhSZgGsdgMx34VrqxdC
	 HYws+7Vj6ZC5bhYmUk9puw+VTIswBWHvT/x+E58uaEXLr3UQyU0gWe7VmdLZkdzdmKQe4
	 kWBAZEh0oKTjsqJvs3gdz6eKPAGHALEXjUADHZK/NacR8YvyxE2FSOBaIMD1TGANHnrTR
	 5A4HLh4x8pCcQigZNUiLzPYnYhKeeWVNVAsDL92jWy/wuTLG0qR55EYsgO0MxUnU4NA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400274;
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
	bh=tMffpnSXGheJXJhobyPRtfd9OVAvLVpyOcnY+edkjoE=;
	b=GjtXldP12EG/F9hZ/z0ZqYXD/SuHmfONF67t5wmEvQQfG7NCO9LEiUO4qKzljoUC/xgB
	 pRm5yRS9ixPKnfXEWbiACDkYHGceZQm8i29Kk40LrMYeLl/10GibVLvzG2duYwJxTxBZN
	 j3iSwBuCHnHpVSpu/lqIUhyce/+f2PPUdh4x8LW3FY4gH2rFIQe5UFHSCeq18ml+Mwh0Y
	 yZV2mQ1+dvVx61VUyu+s+Vd4TyrGVPhuZe0qlHWL/fzepX3uWahgrvY+LBne+kXIOpovy
	 mAJxCP8P84N/XS+LKjZUlKfTEAMGPLOxOhGRG1jQAE8DBIlOWTbJKhXDEwcVco29OwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=c3VQcIpA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400274;
	bh=tMffpnSXGheJXJhobyPRtfd9OVAvLVpyOcnY+edkjoE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FY/pr30VlTk8037xRphhCvZ7dm1gYpLdGxUr4JVsiNLUPvUXtFFEUkpEpsWkyISUL
	 k7Z81SzACOGjQsVEPulcexs1gP03+7cSSibUhXA57fAsZD9mkh0RcstWuyy4Mg8xU5
	 TL+Z3RuCsrIFUMi4fNGczsQz/Cn2snIDcWzSdtbjaqigpLs0hIfsB3Myb45fUltutB
	 DmSOFxuWQMbXbjVtBoV6xrl+Ibp7m1M4ToB05ypQa9akMmIhDloESwFVBYIrAerh0e
	 mGOJpmRws459BqqBj+udxGGi6qX84exOuUnkLi7UVUQA1+7h0vrj+p4J5WyVyAkz0A
	 PTCMSeEj4PmeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9DE280F76;
	Mon, 19 Oct 2026 08:57:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A017975
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 902CB80F71
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZ6lpYw3S5w1 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9182F80E15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400267;
 b=CBxx4eS6SUxk+ocL+b3jlGAWFnKGzkgmRE79pizYd5G2g/F8cenFHyeYEZrEP49ONlqB
 Pt5fHeew3subifGA64DLzajptI61HGl/cHhaB7vOhj/vmtrAI1xBEiFSWtXjTcDDPguTF
 oHSe4+hPfX2CG3LnkCVPoIipa7l8wVouM7bmJeQoOGJM4s8EvFAxcHDHTb5Wdrwpoo+4G
 OPWJeOOo1/XCIdVJAbESRXhQbfEmwBru/bAcBYYgoQC+Gi2VAtOOFsVyZatVH95ABHiDq
 3onqkylBfvrSxroBEnnViDiAHmHkp4uqIONT7YnayjkK+dVLdPwVzjnmPEbCF0ifUjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=tMffpnSXGheJXJhobyPRtfd9OVAvLVpyOcnY+edkjoE=;
 b=oWJfPie9ai3nBrMl5N84mberFHgslkAUxvtLtTagaFaSn6POpfGUn09W7HOBoF7Mj1hG
 1egHonFHdxVLrrp2dRwyuFoNKHViVEBC0cpKw7wuUqkIoufg2ngpiv4Xx8/AaWJkGR9mJ
 P4RxQNzccjUmZhL3iYg8trOoVHpGjFHHuGVHPW6+V4JH710LnuDtB86FtJNmE9+9icjlp
 xh4sQhwvs5irD6DotrB/AxayGkBC/ZxwDd83fL5YTtH0Eoxcg6bMkJejtBFBurAo4kMm2
 XRWGoLyJ0CgwUez39X5MBGMJ3T/UcYk+0oYSF2T18H6cw2Yv57R89N5wmfY6DVSxLNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=c3VQcIpA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c3VQcIpA
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9182F80E15
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso286957666b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400263; x=1793005063;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tMffpnSXGheJXJhobyPRtfd9OVAvLVpyOcnY+edkjoE=;
 b=c3VQcIpAqFcnCB5TXq2xtV7XH8c0wPKIp2IY3bgKwqKA2wg2Mc4Fgy8GX58AnYNz8q
 tmEubOuNszVb1bEG87MqdwSdGniEb0sBocz1gFdzzMJqaofk+gpM9R+wco6u1JEG85if
 GwzIGrAJBsgWydaTWrK7bQ0WSp86kXq+3JYfVQxAWYeY8V8rgTGMJIHt2wkBmpQC/yCN
 v2dzfj0WiASqFcegCfuyqU22D+RIHgid9irOpqfP4B9yrbCOECsAWB+z+bRDaypwfuJm
 t7A/JGIExMzUIXR5+4fO6tClqlBtR54iRl4X6aNVFB0xIDsu7GD2Hs7APkDKE3HC0FHK
 Ks9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400263; x=1793005063;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMffpnSXGheJXJhobyPRtfd9OVAvLVpyOcnY+edkjoE=;
 b=t7wFafC4aAjePxYbI85bSZVlAVNidmiNsXPFsRXPmMeQOSfQjoE3IeyDwtO5JJzBT+
 nFaB+BxVf7kt/I1+JVbpWJuLifXaH6CkuxeJhQ170+DgFhgW8QVuOKvPfhraJH5Rv3Nb
 Dp04UZMIMaBJ2KHFD8QsOWAigYEUyqum0B8/ofJcZoTRmGgTflrSBubbF3Hm2sLCDj10
 Hl/8nlAActgQhsKCTqWvhoU5xiXScCZDILxqDyWutLJtA6Y5WPmplC5fxXXarSm/eqan
 n9aeBvCueAFgrVe8s0zYkB9fTKBfsEBRYiE27UqSZzGPZpdWXTAVFXVQ/sU9mMKZNKle
 14Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBww9yQ7qNR52q9BYveemQVdxQveM8JQlH1N5YH9gdFppDdyLZYMC5bHm9X4z/j7Uv408KERLF8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKm82omwwiiTWC+5oyaTaOU0+SPFwQGFYo1nA6e60nVSnTqGDA0
 kpvfUQHxnMwI+JZKbpXfMKs2rQBEuGKfo3h5CP0x09NPNHcR9fhlfEBy+w/QomXBDjw=
X-Gm-Gg: AYBFou3qid6IIDDla1YJ5SNuCRwrJrgbY4Vcy5gQwWCoyc0fcmj/ATl/DqOjr7AmdtX
 KAIUTz626FDtjDpPfYVe5t9ICBY08MGotGs6NBqfLkx9F8WIOlmD7sOf20YsnE4KG7Y+nkHUa6r
 AjaFmVaL64fTcC5UkKazhVTuMcnByvADqNtGIwCBdsjjJeKokFiHGNlpADZOdhS2/1mAQyAixpO
 tk5k+mNYBxuMlWeKxp7zDbw16m3BKO4ASfOqNKFn/Paf07JCNPZPnxXl6e5ZPFS5DWQflOjuru2
 afDFBARqBIHCtvo0hAxMUuuaIH6RTXJr6hYzUtszRmHh8/+Aj+urXVu82Y52WwMxPik+BYzj2zA
 UoaAndupFGvrt8MvsRM9XUtkdiPUAUgrMD37js3/drpzL1uAkhrRLWmvNfG9H8bwjFQ3IunDYqr
 NjKA6Dug4heUwdXE2sv/UB8RcIUp2zRU7/HyfnmMM6YBLqUOlpdq2LQ7S0heo5Egd+jymbRf1Be
 Zj1xWSR/gIGPtyPI70L
X-Received: by 2002:a17:907:5c9:b0:c2e:7fe7:288e with SMTP id
 a640c23a62f3a-c419ef256c9mr450062966b.32.1792400263213; 
 Mon, 19 Oct 2026 01:57:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:42 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/10] test/py: android: Add setup_android_v{4,2}_image
 subfunctions
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-6-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-6-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024784.806974.12689676373646294396.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=353;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=X4/+536y+4i3zz4xkps9PDujuiTQ/M0pZb1SWruZyM4=;
 b=RNcn0D/aI8PK4xN0FmdsYPoOxPMlQdK5iDI7s0AXsDjoxuezAYQDlEsFVUA6C5O3t8jveDdby
 YBvp6a2a8dDBhwmA1Vx2amIcO5nOb5TpHuwyLVXmpkARQpVhVPHLovP
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:56 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> To split out the logic even further, do each image creation in a
> separate function.
> 
> This will make it cleaner to add future images as well.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
