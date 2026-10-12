Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F81ECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 015C780C76;
	Mon, 12 Oct 2026 09:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29s9Yh8BI9xW; Mon, 12 Oct 2026 09:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 418E580C6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791796715;
	b=jVPtrfQD0mUxuRZlTAGXgb807zjqbVg2yU6aZrg19m9SHx99nKqw1mG6w717B0dYznRp
	 kq2QKv6OQzmBGBVHkmRGfj7eNnLKBiWgreBl5PX3mW9s/hbnuiVlJZdkgqmPWFqIWJCT3
	 ZH3phryK9Q70gSWfmRrUIoyczA5zTb7Z5IvfPEGv6zaSVHZNDQzEp/FUD6xFHgMJZy344
	 Mu6n+rfyzmzmCfWBgkvR0/vsZL+bQKOUjrtHLhmGuRA4xurVFf3gps7U/zOxmDkFmBavV
	 Z54oO42ZRoZ0Xi01/uRWSE15+aH1ouT6u3idSIybPQvQEdK+UERem+NEIsm9cZKwkFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791796715;
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
	bh=7CTW+vbaX04LDaxn3uV+sAWmwxNT9YBahQ79ad6MXi0=;
	b=ism96emHZxmftj0VKRsEOBZPmiKLX6QnN0zg+wQLhv15ZBQfMBfOjto2W7VsDuOyDlar
	 gjx5uXRszS0CVB78ZnP2hwGRKIWPQKoHyhBh3ct7GLArPU3/HHESQuDksD1OGoyOdZRhb
	 5+8e3smB5x3wlg0NPOHyFPVQ//2vjgkMRb/I9Zr/i4wyAlHg1IYhgqyzBnaMr4r2cIHVZ
	 kSqRLHfXcQlpYX3xZ0iH6YYNzk+U+ePXr0DYEb/CIeFhGzs+Dr0blR0kdJDDDf7SEBLM6
	 iifs8BvUQtoxxyBWn7pFws6MN4OnRs5be9W6osGy2FUXd1hVvZJgFUcjkGLyvGgjkDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791796715;
	bh=7CTW+vbaX04LDaxn3uV+sAWmwxNT9YBahQ79ad6MXi0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSeXzx0ruRjHlepvEBAnLplGXEtl5AZRrM5J70t3JS4po4DFl1p7VlFaFrsDdqpaY
	 Zn+YYqrcpg8+8y02NXRSOxW1H32RsQ72RMbOB30fV2Txt6IadSQHfgbpdxta1/5OV3
	 PMBs4WDbcJdlknawfXZZLmhpB1oXOTGaWavKi4O5ByIz0H9taIVwcCNS1UFSmrUmSX
	 zgODKPzlZtwkdI1yjeaqNiwc7lNTEvH0IqO5eNCsFgVsr2XJrnt7FTEw1LfK7SREQI
	 f+sbJC1gmTmjqgPGVpE8f7tgJBMB88B29tOLnjxFLjl+uaCpWHVs97zH/+W+DtIBYV
	 TzdZ+APQo69FQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 418E580C6F;
	Mon, 12 Oct 2026 09:18:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AFA3179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E50FD405D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:18:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7R-4jS5GChoi for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:18:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FB82405CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791796712;
 b=cK+HD7LAn2wTi7mK7K5olGCRFfIFztetqDO4xHcdlYS6HhdsUa80DqRnlqhk1Aa8wOnH
 b1NTCUvOJ9wMgMnjfCNWkDKb+vUVUIWUVETYqqjC1CyCIKPPL6S7WXojARE+uXe5CzIYc
 D2BIDHnD3wL3m6VRU/GDYFZ4wqCqoR8aR6CgtjXHF8TPlw5b5S1DExFWlrLCgtbjcssbd
 Zm+gsw9cAEfngteZn0GuRkyCWEoYsGBa1qdK+xyeVeXT0sZIiKc4ebMkzFJgfyBaZyScW
 qGLJyE1+Tr++QcmYnpVXxwRGStH1kmMQmJ9/hUZpmBC3OTwrZ2qlnC+v0yy/0WCsteQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791796712;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=7CTW+vbaX04LDaxn3uV+sAWmwxNT9YBahQ79ad6MXi0=;
 b=oZq/4AVJpRcyEgmuNEJp53XoZGIDPImLPNsgJ8COLya87d8TVloj1dE6JB/d/PfOm4iy
 xiy6RwuKLtdrSSGgsXRHc9HC+MtaaAvWC0jYSy+x5Lvzt0iR88YkmDDWNG9Bk6VcuJ+VP
 aaweWQRpP+ge+awucbpBiGHFOAP21H2NUzrRKtL3Ahyc7JfRHyzauNkUN6Bhxvk9LC1KA
 iGqzTSfZKRwP+hQevWgz/XHEcOklDex3iFDaO8MR+zdUOiSkpb9XpjhkCXCvedarAk1Tc
 tAmxqI/jkfzaMADyZUBUId07otjW+SQ9Bg7abtbsqzjAKIu7NFF13LMSeSZ/p6ML+eA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cyNNqzpJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cyNNqzpJ
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FB82405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:18:29 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so683928f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791796707; x=1792401507;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7CTW+vbaX04LDaxn3uV+sAWmwxNT9YBahQ79ad6MXi0=;
 b=cyNNqzpJRzNkkfjM4Tt88mO+FlqE+ctCt71Lxd+TFF4jR1ydh8ATaPnnLfIGKq1V65
 bOFhxsJwaiszuTqPPr1akBZqzy413Y3uK2RKLF8oKv7W6xitUUeDWgmzwvySZoZAwS5s
 K3H6piwwLJii5Q12w1t6yoBNf6awkD3wDeN8uZ5RMggB8ajasRWRxIjkwJtKSIPOWuK7
 R2Ouu5e3k5IfPnRS2+ynVJqXqz8YE+52WXkOVeZL2rAcbxeaeAfSIq1gi3e4o1ydITab
 PNqbjBc5ldVdqwgz9SUaP0FwdgUSK/evU2E482dOwvNbJYhhIiIV7Za82gHJ5Mp6JJYL
 eW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791796707; x=1792401507;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CTW+vbaX04LDaxn3uV+sAWmwxNT9YBahQ79ad6MXi0=;
 b=1FompBvC29ffD8KOdaNKqy9zydF5p1tLfwg/Kuzan+/7kuqoex7dGWSzNelCRZ5l00
 yyvMFNvlNM7TJg6P27Howf/62Gx3mmsIyePkyPaPf9uIinjTeskzcVO47LTNJYfmDhWg
 Ej4xWur5ZuERjD8Oe+NJsqfX5F8spENjAL296fQ4UWGzEwPGcO+2vhfXeEIS+JoaqZcl
 NASwE2d0CJ+mG9DI1jaJuawZHMmoK5huXKsRHo/RzIGJONBI4+m4qkeMjpPvM+M12F3Q
 bYsui928N+ArhABuoA9HScylklBuOAc3xOTZ2u9Ivn4btY9E477/kfPnQGJeOjXkpHmZ
 t8ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1Gr/MCgmOWq7JkXrCJYYEcsN0pGallDdYZnRfmdSs+FBB6utm7MyE8XwXxVWDpG2AtE5adPc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL8v37KS9//nNaagjVX2EvBuefoZB+ckvK+ChPIzrnjNbAM4Sbf
 NqCZtoyvPnA6ISAaGGa91c+PVWCkgBkhTmhXZvObAjM7DZw8W70Jdmx2hXTn2z8IX54=
X-Gm-Gg: AYBFou2KrDKdL2SFEdm+sZs//psaCkVCfgG3K4TInbPmBG79z5IWS54wBRmUwQrd5mr
 4FP0MbK3RNUrgkeBIhF8R2w6cyZWd2yWKDg3EpDfFc7YDHjRYcC0xaC1E3Vb9w3KFz3PCnMV6Os
 o/ZyvZEC3U6oK/wKI1MCcdhPu64agfQZezSgQ/jRO8g4wzBLyrnmZZi1vnvp/Z+9Cx/unQ5iqNR
 v8XYP6Fm6bqlqGMkfphe5T4pqzugUrvZ4T0q0Tb4lKmKJtquUccODL1iT45TGAu+vYFPPMO9eec
 3NPPdSH7vN5PrVvHqAFAqFlCBH6uOvGnixrwAWZkBO7lzgOrGk98+3qfTP1SLnB68W50zQssfXB
 hVwyeB1vB66FLSwgiYcc2coBowS36QindWjNCKP7jVQ0V/Jdd0bPtzuRyj9p+kP9ptnWptqV2Ho
 nGG8XU2DGoQX40azPmAgPSB4iF7lbpkCJE9MRpX3UOMmFFC7sBGBZHej6coNSzEPLyIbvzB3hoS
 ee+DXqMCqgPbYq6IeocKCKkpMoV8uDALxt2b+MeyWwFl4n2cZrAOVic73X07axPeQ1EVSDn6J4f
 fJlVFLm74nNW1cOUE3ZSXW4OFLiSdq68wzJ5NIiqNlUPxlJ7bxXpn6M=
X-Received: by 2002:a05:600c:524a:b0:4a1:8824:c9ba with SMTP id
 5b1f17b1804b1-4a18e49234fmr166788135e9.18.1791796707138; 
 Mon, 12 Oct 2026 02:18:27 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aac6a4sm18639362f8f.28.2026.10.12.02.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 02:18:26 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] video: panel-startek-kd070fhfid078: new driver
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com>
References: <20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com>
Date: Mon, 12 Oct 2026 11:18:42 +0200
Message-Id: <179179672268.53105.172941928313757733.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791796726; l=533;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=xb4FPshv59YxB4dCA/806Lt7e7sOwOXGzWjumoPExWo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDNazlb7F/ZLD69CY3utVG0B5uBZMDvmNDt9w33znhciSFjAPZ/7y9ZpWE1STjlz7AT0R3nhd73
 8mmES+cZgjAA=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Mon, 05 Oct 2026 15:51:02 -0500, David Lechner <dlechner@baylibre.com> wrote:
> Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
> used on the MediaTek Genio 360 EVK board.
> 
> The display mode, DSI mode flags, init sequence and register names follow
> the upstream Linux driver panel-himax-hx8279.c, which is what the
> "himax,hx8279" fallback compatible in the device tree binds to.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
