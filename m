Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17D5CA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BE2640D8C;
	Thu,  1 Oct 2026 09:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZ28E1Ldcqpz; Thu,  1 Oct 2026 09:56:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2973D40D89
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790848586;
	b=Zyosuw9jnTDN2isMCFBvAQspCerjPAbOAufvAZG2TJ8PC7DG3bhIlVY8iwNI/nodhuYZ
	 8U+ofxVsPoWQtKD4kjXKwL/IwZAQmdlxdtXefElvDUSX84NfgccIdC1tTHPmruDdl+DhZ
	 Qx8g+iwPysmd2pJFoVlapm4MrrGaNUbuxRxnZgpRc8dvXBmnICou81XE0fyKt15wNkr/Q
	 46pT6GvGyGgZ3NVZgkH2GUmnLjxyoivMSMfpn2prhQ2ZicZbVpUY8TPN+0IrLL349C09f
	 y8mUW1DZcnWm1HnB4hDKkUnYBgllPXYo5zIF6OWf8BjQwc3jBAXdaA+NcjuqeACwx8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790848586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H6fzTZvSk0Zn1Ceim+VNU070OCmdkGBLeL78PfVrnzI=;
	b=brkuqrrkvInK7WZ5VaCTOCmApzqxGeFAKQ9cEjKMrO+s7fgr6EA+LbtnCXK65/CB9uMO
	 5cu6EJsYUrck6uZ/lC+ELxBF7pWiWlVReCauXJZjmHa8Mr5DMWAnKNTXOA6glaWDwhfqV
	 jkMoYUIrZabEcuKguidpoLpWQobRpAD2MYvIIWOciCgRBFcewNhc6Asjn0fcRObYgNUzI
	 fv8qPRRsOYlEiQJ7fA5kgjqExWaGX1QfycrI+56RN55k4VB/KZrjDdEABWyjZWiv3ZkLR
	 887m5z0pi0u5vtC4JWZ//jZz8nxLIFg7f8FN1xZ4/fZvJzWBj0GhcImD6nOKlmCbC/w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N2fUp8nn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790848586;
	bh=H6fzTZvSk0Zn1Ceim+VNU070OCmdkGBLeL78PfVrnzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NTs4aYGAd6rzd8RbcmdDJBtuYPOXmwW44fq0Euf57KdnaX3JK5R3pOwzOUdGx2PDL
	 HBp5XjO2fNW24JZKPWyZ+QnDrmPMe9E7NGHXajpxy0ElPmr/TxaMaS1eYlWgUmN6ZE
	 KlQtAa0M14qaZAYHxBM/3dIu4fSPdz6d8gbEaTjOXkCAmMPU8R3J9rTfjKrou7ZT5n
	 00rLVoepsrk6GfyDpls5Vvb5nP6rP6aNcN8gCYTYMADyMaHDQXzm9l4ftUNKsip9uR
	 +HEwfLoUfF9YbFenFspb+dhOeFQXdPtDtfL4LdsRXUIVITwVH4d+cNjQnV6QKMk863
	 IaXbRW8JiYE7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2973D40D89;
	Thu,  1 Oct 2026 09:56:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9829B34D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5760340D6D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XE7B6UyvAlGF for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 09:56:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2B86840D64
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790848580;
 b=eu4F77Trh68a9qx8ko3CcI2K51wlzkbTVnZ4yMLU9e0cAgQ4IsSefD4JKnA1WNZyMSNf
 jegYqHhj/awAEYGWAtdt/SigseHJoWCxN3faiUNOxDO5vsyYhDAZwwMPPOEQDaGA56NPZ
 VQPvnRDryHrKP2LseWDdiPb0854PtlQDXX5tu2bhfuLIFBjXIf2myHQGnNhdaacfJHpYV
 dEvBci9a2/33BeTLB2fc6dEpgYUKBGcoMZ6k0Ug9e2HJuGmhMWhHGkg3t5srYTyIXJGJz
 X+SZHVXx9FXefLqtQimt21lDZHsO/28wNRRVxeQDf/2OlGW4H5SaesaalVWsBzU+HCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790848580;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=H6fzTZvSk0Zn1Ceim+VNU070OCmdkGBLeL78PfVrnzI=;
 b=pfqK+82U+HnGeKclJSI+2P977PcgCpGLIy/S90sA9FdMcZJ8tFVkPa+2Pz6B1BS0YxVd
 bWO9B734437EPQuuMyeaU81LPsS03935W5S3woujMl/GTYd2g5x2FZyMXTF7mWWQb/Pbh
 ULxjZ+9kvQJEgRW1xQ2Dpa2xVS0glNjP0NR8Lmu85sLU8snr0tgsSylEDkGMNTKk/XGHO
 6TA2+9LxHzmDw6JwzGN3YWzwdXX6bo9JPnUX7c0ooPOaFtzTasf3nWRmjNswGSoYGCFL0
 oNmr6mJW2rThyiYkSwF8ZrD51i+HfwBJrFlrqPgmEFKeQLzrhFBTmzI5dohY1yoHXAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=N2fUp8nn; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=N2fUp8nn
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B86840D64
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 09:56:19 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so35240985e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848578; x=1791453378;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H6fzTZvSk0Zn1Ceim+VNU070OCmdkGBLeL78PfVrnzI=;
 b=N2fUp8nnSqBUziNiwB3PNqeu8BckyslF1FuZ90o5cEKWFjur6cJbg3+moO4ChBtrdC
 pTtjJVCWeRw3bZo/2O7/SK9ialI++0FcyJDebCp3rT4AT8wBnGS1IEPUokMhz1gR4Axf
 ADUwCef4Zc3IqDzQPJGilzQhCWwEH/jdB1+dWmp7U9Yg0BRIg9ZP3KQwN/ZB546hKJKe
 gSCFXW5Wd13TkeGtVxAeqtfGNAAQXZhO5P9YZG71hCvfxk14e3Vz0Cn6fMHe4hOH/zZ0
 suoNIEsKppWeLJICci+g3dvnJLMol9qCL+ydZuTjary1ldley7B2WLuUWKhIwg3Y1C2L
 X+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848578; x=1791453378;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H6fzTZvSk0Zn1Ceim+VNU070OCmdkGBLeL78PfVrnzI=;
 b=WETfqen/j6HT6lMXKoqfLYxThoafbz9mhv0JJTiRobDgEp4tR0+aPZPcqq6QlQcWab
 /XOPd70je/Npvpbw66NHEZJ6mo9gEKPDzO2PROfvXN3gYi3jD7UcQyKmiufOcrdtMGd/
 PPCHRwntYOPH0vHkryISZ+canL14cq2GphKCXDIfmQeermRExtXh3v6jssXbs01VAtGh
 TUzR9TMFk6HbriGMKYEF7LmOloJt1FA6pbhEHNiWyrsnLhYaVhWmAcLaLoEilmgwyjyq
 ty8qpxy5hkEK45L2uG2qZy1xDFBbGPcoV22odYOdVGH5Zo5uOOumjL0EXuetRTt4WaGP
 Gsmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuIHbRnOsjY0yx4ICQsBt1PWBxwb1AJeIbe/7ubQzwkKtEdLOLcXvRaygM3PdJLxqDrj+xcXY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n7WyrOSPl8nsnM85J+ian1QWDzTAIssufs6M2HN8WhyMDeoVgD
 CGVZrCOKE1vVBIw+JGkGqhZPXZj7J7W78JNQQT8oEaa+EyxJawsdclLcFvnviDs5cOvFC8noLIx
 GEv7Y
X-Gm-Gg: AYBFou1WbSEU9w4TsVH+0PV32yViGD3l5IjFxGdSqfvSuSnoFDW6rAyl5HEwsnK/x7v
 eByOUQXwwGMgwcrED0bsNT6hQWV0zaMSm95QBm6N2+TwDgV0hUOHXNMwKoR5cmt0Kq8tSwc9lin
 NMiK2kss2+kSROPtPdPpAsYq64NE3W3KAUij+6dYfhoTkdBmJIbXneQ6rV50l3Hya1TmwS0bg9a
 HuEiidLWdnJ/U+j+d7K8qenL7bXy/g/5zPqdbxYttVzjmskjL6tU1TCWNYIqBCCylwqCEc3a374
 1NojZcq5DyFjHHOsqAWkR98+42jHuehmhpVqHB1XnW8h7mQwK5TYo47T3BZ3huGUXhS3YJcV8S6
 e4PCGUl2wPMnn1i4ynLhgu98GJNSw/ujCNT3YIzG/I7FzjV8UqfY1PlWInV2LL6hz8sYujDbUkm
 t8GgJAxsX4pTVz7VCLfbKzcYsi0wWBoEqafvYfYhp2fKNdF3syEPLAePM1zauZ/r9kTvSHFtaN4
 wTIwV2oWRquWu3+Yeo0V45jzKimr+F+/S9Zo1EWb6WiWguaUvdarbetobFYjA==
X-Received: by 2002:a05:600c:3486:b0:49e:823a:9dec with SMTP id
 5b1f17b1804b1-4a01ad9d8b5mr60891355e9.3.1790848577900; 
 Thu, 01 Oct 2026 02:56:17 -0700 (PDT)
Received: from toyger.tail248178.ts.net (p5b29ec5a.dip0.t-ipconnect.de.
 [91.41.236.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f922ac4sm54012045e9.6.2026.10.01.02.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:56:16 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 William Bright <william.bright@imd-tec.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
Subject: Re: [PATCH v2 0/2] Add support for SM8550/QCS8550 SoC based platform
Message-Id: <179084857612.7191.16352654880080594667.b4-ty@b4>
Date: Thu, 01 Oct 2026 11:56:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Thu, 23 Jul 2026 11:30:50 +0100, William Bright wrote:
> These patches add support for the SM8550 (Snapdragon 8 Gen 2) and
> QCS8550 (DragonWing Q8). Both of these share SoCs share the same
> codename of kalama and the QCS8550 is a variant of the SM8550 with the
> modem removed.
> 
> Please see [1] for details about the SM8550 and [2] for details
> regarding the QCS8550. The upstream kernel patch that added support for
> the QCS8550 can be found at [3].
> 
> [...]

Applied, thanks!

[1/2] doc: board: qualcomm: document SM8550/QCS8550 building/flashing
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9e4e6b9f3c4b
[2/2] configs: add sm8550_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8c1db5ed0745

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

