Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60C606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FXvnUFFA;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cHsZLi9b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9842C40560;
	Thu, 22 Oct 2026 20:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzHfK5QPisSB; Thu, 22 Oct 2026 20:39:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F19040537
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792701545;
	b=YrTLR5ZSFf1goQVEHVmn/tnyGHcP/bm5XYxYEZkRtAG/j1a1r4Xtef8AsoUn7M9NoWNq
	 iICGPSzdAmmOPkj4LrNtO+IhF1jfKJUkgXpvPsoUWI41EP1G9g3xXtBfLjRE4hgFlRUIs
	 3RNGo8hCoHAT8KYzgKi5U50reauqNjnJroIV2hdu9/EslE241BXOBai3goTcNae3u1PT3
	 +11PIBxeBjoWfZ8Zg8C1UpDzz+jBNzcscaVK71mtkvvlCZITlYW9hDnjiqvfmGNI9vk6V
	 p9RnSCLc8vbbm8qO1n4+tkfmvpKoRLFzu0WA82v6rpAmdNLmZ+kmTZkCem8MFgCCt/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792701545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HjkmNG8f/+UIAoiy3DvojfAuWRq428NDq9yOCUHuAVM=;
	b=fu36Squ7wTz1LkQh5oBfrabdlK35DfJXPwU9hHjdKkQeAOtbFtMPaLAYaJ9H2+KdVwuV
	 /eAd38eXiMdcH+QwWH8yzKfxeU17/pY7UTWqF9TFc9JBcD0mS75Xtu5wOTvyet9nKuTlI
	 z6CqqL8b+QArH7GI+1e0n0z/q6PyXU15McGTUvXFc7B5/jSMp9oCD3+uTG2wWRk+OjxAl
	 el2/ZmrRTIsdbYCna7ZQY0mVVsjaRrvSwZzxEtcsWaR6XxYX29ydleb5c0w6zvMXHgByS
	 2JXCLeVrMQ303IKlHJU6OoTkY6cWK30jh5pH+FjsQ/iohJhnWdMl6pZckIuHgXsaz6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792701545;
	bh=HjkmNG8f/+UIAoiy3DvojfAuWRq428NDq9yOCUHuAVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXvnUFFADLFf+3dfd1jGEkPG2XYfOT6pYQngOHru6wVsWOSZ8dCBOV7f/qB8JLerv
	 3b7b/5FX/rnpAO5Bgrwgv869Wz4agJm7bOou/t4RSPpShnbeFWFOqwP9+SUmSirxTm
	 5ZCSG9VAiQL96/X7noj5KTaJHlyWfCWKi2k2Q7BeCe4hTgjPhOcRQbWhfDInCX1o88
	 cPiEUIFnG0oTfk9nQhDXdksT37/J1XrgqqP7ck0Ol3QGLdQVz5tAN1H++K45VhuFmA
	 8sATqEZOKnB3TEX+8kY+sFCiyBpxJWe9oSVRUhYY6qLPuKKJCK6EX9Zr1jAbAlSx8l
	 mpFRNz8In/79w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F19040537;
	Thu, 22 Oct 2026 20:39:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2D504BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D00AB401BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lxM3g0YAhQmZ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 20:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7587540086
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792701542;
 b=RHdazzZ5IWBrKDHTCEPZ6GFJoFWqQytHulIpahYCpSPkoTpsSxECzirjFjqJTDemJZRs
 Gi/al0EA68MVu0uUpUu3sRngF/Wspfj8NQ1dqY7bscMoHADE+zA48yET73MTsKypXIuw8
 HZZTY+zLCa8gyfH8Fh3dGGcLkfTBGuksW88KBeQTw9ut2Axasx9zF4ZBCtSf6R5Z7M++l
 HbZ+Wip77Tcm0/LhPGNoqcyYIp2y9O2Q8AJBoNpd8suo0Vg93uCFMpexcbIDBM7/mmrRI
 TieNH1DA+zR+HIyqZDgsrNuMJ7Sc/wUUeh0hOKJ0Q0mR1yWhvFG0B0ot8hAdsQ/n+nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792701542;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=HjkmNG8f/+UIAoiy3DvojfAuWRq428NDq9yOCUHuAVM=;
 b=sjJB27aVdgCIFO/oHcsqlcQuNRAiLDCgUtLAk9dJmXBexIzhHyWJ9nWRwoRIKLsoDiiy
 I1tEXfPokPKJ9b8I5Zec4YpoNthgiYo8YuqliALYZXpPbaJumhA9PNiOAKcmLjCpdxLlV
 ggmk41qHgJOJv5Ui86rMOFYSyswpqsW7mocazhRYWwlZDZEFOOPWjKdWkWX/gjrSTIj9X
 4wm+proh//buij4c2hUnJZYbJXqwQYQnxH60gLLkZcv2jynmWnni1yRBuvXQ0VBQbzbeL
 lD9ODzouSyR16vKHDgoHfQlFSEO0nIIO50hLwUv933g5DMRQQpPjyWp9SMhVfCEjwqw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cHsZLi9b; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cHsZLi9b
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7587540086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:39:01 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6f8a519e215so140242eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792701541; x=1793306341;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HjkmNG8f/+UIAoiy3DvojfAuWRq428NDq9yOCUHuAVM=;
 b=cHsZLi9bNwsr8TZYg1Zsegz/gtkn+S5tNzBUa2cpQSb4wureo064+rfDkGZRY31r+t
 d97cZWsIFl5y5IWyylvfYKxc3TiNmnZFf7hx39cL1PYDuW7lRJ+VgDyROcJ8SZdh8JLC
 nmhVnEpBLh7nRo96OGlPqZJAx8GG6dgpfaM1W/3oSCe7YVFXl8V3YBBv0cgvcw4rus0M
 ahY+NSjOcDiArTtfBibQVCVp7u1gvM6FpkyaIDKpS/ItPeS1Nb6cWsr4ym22oB6Wydcl
 SOsexK1yr8pejv3sznQOXovfJ8nd91U34KvqMRMPx4oruOV5fq5UWt8ncN0m8cITyGTp
 9btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792701541; x=1793306341;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HjkmNG8f/+UIAoiy3DvojfAuWRq428NDq9yOCUHuAVM=;
 b=bdos+qKqM3kHdNiPKD3ziT0XZ9eEQIbHAkcM7M6Yw1nWVd4RzLpuk5e1aeLbm69HR7
 HrYM5D2+EUseR29NHvPRReyUzwf6Gsfw9lY/xwBv6cz8QsZxLFu3/wpvX4t1kWmHD1j6
 53GT0LFyj8MeGcEE3zIN6t750KLWxgXYOt1I9EqN8sLU+6dIfVrYJzFkDlsfSS0cwMqz
 GIY+45tezx8n24mj2aV+lU5B4WmDCedcg48T/wna0PaZD0iPuYx51+70qC1S3k1hF8jd
 qgSKsB3Uee0iDhlR4qsmH7KvBhgy36RfkEvxoV2iAa64cqbG0xfGVShnEZ1UeSyQbHaK
 tvAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByN1r7lo0Zd1T8rahTLuWaNVoNVB24HUMXrzkI2WLCq/VroAOvXwcTECpmbUc66nUXCZtOmyco=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKBKqNrDdOubA8YlFW17XfJZCZAah3KoO+KdZF0SJGO/nT7M7qH
 Tf+mEWIeNY2wlyaBXeFAibHxXNxJlMIJ5L8L1Q9JHtn8n4aMC8FxHxKTgu8amT48qts=
X-Gm-Gg: AYBFou2Ucl30Jj0BovzjLVGL0bmyp3N2H44EofO7s3m4HvMR6/mEFP63uQ5t3OHYd0A
 8kMqo0GE12EWt7cKLGtj0eDk0BYqMyutldvCoY4bDkuktbK0gOHGAAx54YwynDcnnGnxdiUSSsM
 hK47P0GzbHe3aF0sgB/0QOegMkbR4UNgC6YgPTauNZHsesg4gjWPAYoALoPSLXcysm5IrMYlY2K
 ntc/geOzpsam9cqkINuHzzrXQgXx14oGI7wUVJkIFvNDxyOpL6yQcSuki40Qfp0rpJ0AxDwviDI
 RvfY9BzamoM4FYc654ig+SDJxWNiNmZq7dFqOQ9qYdPQyxnyDeVLqK87TrmwE5xtNXlAk1g7Jrg
 X7OXf6mXKTLulKM1YYvfscljJFjGsVvs2aDRH2ki0EAFVEvRlkYOXk9xZxiQ6qzmAAiNb5cV6Df
 btWVjHw3SYoxaEO3fDxCXw2wYkp2h4eyUtVmp7dFFHeKCVFx2vVEzyReE51wKoZ5UbpMC+htvB2
 4xd3cWJ25ytpuER+q2SIPFwndYMus5psbNAXC2i2wPmZXlw08IjJsCrjwgFLj+hXavWzcfN8XSQ
 edLu/Ms=
X-Received: by 2002:a05:6820:a101:b0:6d9:aea6:8bc0 with SMTP id
 006d021491bc7-70b88af90e0mr237325eaf.43.1792701540796; 
 Thu, 22 Oct 2026 13:39:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b2d48e6sm176634eaf.10.2026.10.22.13.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:39:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com>
References: <20261005-mtk-video-panel-startek-078-v4-1-2b18dc72ddb4@baylibre.com>
Subject: Re: [PATCH v4] video: panel-startek-kd070fhfid078: new driver
Message-Id: <179270153033.3711947.14463102680973552022.b4-ty@b4>
Date: Thu, 22 Oct 2026 15:38:50 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=322; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=epJFA7+ujjOwUgMRgFwITr1ynKo/+ucRHLj8PujcLfc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2nRbNbdhPaJmOpYrAlpCsnnWu+n3HZ741HkYr
 bb8/csMhnOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatp0WxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+IkH/0d6AUaRPD7LWa7X7nObVmbWqUyQGfHJ2itn2RB
 izw/G1KXn6hmlJB1scjwyNZlQRYdHFQ5ChImG9B9iEsebVu7sFNIz0MzNDPdWUp7lF/KCebv4m/
 8lxiQ1TYVPTBTjm6fBqsTZv/A/MWqNgI5N9N+b7Cj/FZ0xJVFpqcge6hvoPGFjW21TJ77WwiTfs
 MhPJ+iS5ExDg5GUhfkqGlNAJcvQ/cBEkMf4BPakJ7NjXt/6lGYCnesoNnMnNPhMiNmMm4h7sVtq
 TIRtrIwRXcv1GATypH+05eY9tBDQoEMWqaaobTaFb85ZK+/dmJIRu3LXH5wI3jqanDw3XRyYXT3
 oPnU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 05 Oct 2026 15:51:02 -0500, David Lechner wrote:
> video: panel-startek-kd070fhfid078: new driver

Applied to mediatek-for-main, thanks!

[1/1] video: panel-startek-kd070fhfid078: new driver
      commit: 5e1db331ad4bd1a2f5f8f9dd0c25f058d6aaaa20

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

