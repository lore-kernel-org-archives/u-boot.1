Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61126606A32F
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v2C3oosd;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QlTcr0o7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E190D60A9A;
	Wed, 18 Nov 2026 21:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDhbHRMjyAaB; Wed, 18 Nov 2026 21:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A65E460708
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795037024;
	b=UKpAh6raVfKSImBIv9HDQchwOG9g3nWFBGFOf1JKAxM5QXPEPM5wQL9np/ul6gCqnDq/
	 yxE8AolSWueLUHsQGKa4CYMJld9YJOUyml5Lry46O2M4nZuOm6d24hr3Xw10MANLkIgia
	 ZO8aVnahFBydJfTp33AjSmZskQeodV5lGGEBm0rmLT08Pvapo0bHFn60R7xxemPMqxUL/
	 lYymXAKy2KJa7W/61HIcv9+9ra1sjxczSbaJ+XXmveqxS9H3OgYk7kCObry9kCIbKYclj
	 r63AZdqmotMYLQb51K0Vd4j4B9UkIpX3IJf19xyk1SVqyj1Z9J3ddo/wLzJaxhJDiSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795037024;
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
	bh=1WvlMuxJXbjU/coVMEkXmtlYer94EWk5bQh1r8o41zc=;
	b=PGmw3IRIKTRCVBSMSO9LbHQ0eF+Ty3NIjMCnf3AVfgzr6Rw7uwVCcKKrhbMK0sFIPYCk
	 jXocYCcbE34K2uBzrmX/d7530XnA6r2D9Q/RydiC482r+5t6LqbHUwl9q7mbOWHSGe/rI
	 2W4sYzMShD/ZWwMauezOlQAPg7kLjlkrQe0B98+FrJmzvjISXvKInAC4w0qG5d+ehM9wr
	 T+KlR+TxrM6J57VmH2U4AQPVj+zhmqRL1m0leTMRXPPG5PJQW3VVQN+WHoKfGebVUGPdQ
	 is5lEXu2ELJiSDFcZovpgcWIvhvrqGDuGRRREdYQgP7g4luRhAiGO9TG6Yom5bBnW1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795037024;
	bh=1WvlMuxJXbjU/coVMEkXmtlYer94EWk5bQh1r8o41zc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v2C3oosdTy6sUkz1mqTqj7gdIxblht/q+Yv+o56huceayMcL9Yj29qJxk0bDI2N0j
	 H32cWvk/vMjy7jXxYMgnhIWJS6z8u5JZ0rwPVDlzUmwtNFEluMtaJVqzEAd8M0OmYy
	 U3u77tpvgdw1UbRc4wg8EAReofAA/RI8LYBVa1AuWLNySElctkF9U4ID06hORLwfuH
	 T3FSmcCA2zhRJ0CAviPfFSLKYzMEeWSHOsiqk5wt3o/K19G13OYdFlQ+FyjXqr2ln6
	 mXRmXxB8zc7S8RlE/3FC7UCK9pr1Qf+My7BTaVwNeEIwvhxy2ZCn2p3hFDgQtVa+Ml
	 BhsoGlC36UO1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A65E460708;
	Wed, 18 Nov 2026 21:23:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07BEA22B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E254480C66
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fkEYvyDt6bX for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE21C80BF5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QlTcr0o7
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE21C80BF5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:37 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so18636145e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795037015; x=1795641815;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1WvlMuxJXbjU/coVMEkXmtlYer94EWk5bQh1r8o41zc=;
 b=QlTcr0o7NourSln6Joz328/5g1JdAcF71AM2JTRFLvQfXfjZ8/jN/qGiM1U27lcjZd
 G5PPk9q5N4k3W620csZ9/Z7kWDY3L96x1E1LmXXIq8f+dw4MTzRwfHpi6yWY4cxtJjys
 YCRS3enoQD4vJ1KGUAgAOsbfxximeTQ+72tOT7LUvJBoGFYmQYq7+mOKXjmfA9xgiu9Z
 GLiCr3p31KHyawSe6vu+6YpC6Md16uaMLKqxDY65MhmMv9rWRskgBE0ak4d0QoWYaGDt
 flZE0bAp07UJXD6gqycwQSndg0wCLnfrl5MXETUcc0Ozd8fY0sHHEY65G4C4Kcpi/49n
 1+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037015; x=1795641815;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1WvlMuxJXbjU/coVMEkXmtlYer94EWk5bQh1r8o41zc=;
 b=kkps72fOzsLKKUj4It7dwtis/Cjqxb1FAZFr60RFbmdZQB9aI8cxqWTkT4WAU1WZ/a
 rB1FM0+iexEYYdbYpWs+xGtkwPh+H2kU1PcKDFvzmm+u5/jwiZr1Jfzp89Fkr3fBXIZK
 kgKSRASii+Vds2sBxLBeNi2nKCQAdSzUSK25UcMqjA6UyDazejlIgMXW8GAalr1I95F/
 VwZ5np+KOY88GkSE4vEFuRnPVIN5XdX8v9n1vxmPqpcdsirpf+q7wJHwI9ZMoMBcXifR
 +EzQXWvlFFNethJfQLM2D34fgS45YlE7dm+owzof41JRUCYx2j8ygf3cQmfwxjA5Klpy
 rthw==
X-Forwarded-Encrypted: i=1;
 AL+hErE0PPyZnAKFuQwaZVAFt8BnAWUdikwhRmym+2vcbtqcGBUC9SHAvoMeyTEHwWAF+FBN5Xqb00Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Jop4V/5Qo3J+wvsndp7izfB0LPRIO9Ey40K15u/KsBKmmXTKM
 kMT9jKCveMBRLQQeBWFgSpSBTf78c9KHthjnr3eD6AG2WVKB8PW6Pd/QQISx+8oNJGo=
X-Gm-Gg: AYBFou3QkJFTrB6syvNVJCu4SD26lW7i50U49ntpCbgq42pCbTimlUXIhlx+ZCtoTvU
 R8tT1jlIcglwcmPMQ9wMuvSoRSAtZEzgmPWu8gSFdI4wZt/b/Nv7zZiVxD9aFwCi7q5hteHAFHB
 OZDT+6zalLOt0iXdpFTVUmZ+ae2zStrT6NbbrQlyTDJKM4psai/QfG6wcdSQAQ/G2BqLSg7LS8M
 7TKL+QoqGZkLoz/hNKn/EeNVUp7mJmTALPeEFRNH3Nzvmo0zAp2bGwxlcY0Sjpf/4EqWAnQKmyh
 yZfybXcLEkKuN7RFxHWdmObSXraI2toMjCPjEEo3yZbAR9TBzulMdIksVcShRD8d35eSZwVQjB5
 LDRGa9ENOf9d1qOMEVYkRvOkNUBLcCsFxeM6rV3zPXg6KfJrGXzWtWemQSoeqBfNtM5KT3j5iuD
 l31dsUSt1V2KokABj1l2YvBwbihHRcLqhh+MbzDAlZiZ/ayZnOPfVuUEHl0cpkqieUTMGeyvx+d
 ddbVSpX1x5vNB5j6QK6M1S8NQe8QdJ49att0Z0lHrKrO0asqAvnj543WIJ4gOxbCHSlzmnC3g9a
 zHjsPAQ/fiyAONvh5+jt5pvu7C5pY9ww/WtMu/aU1kwWFBBDI6M=
X-Received: by 2002:a05:600c:698d:b0:4bb:6947:3e1d with SMTP id
 5b1f17b1804b1-4bb7da2c0a2mr71382805e9.20.1795037015508; 
 Wed, 18 Nov 2026 13:23:35 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm7383280f8f.9.2026.11.18.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:23:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] android: sync bootloader_message.h with AOSP (misc
 system space)
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-2-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-2-47d17e8a5d92@gmail.com>
Date: Wed, 18 Nov 2026 22:23:30 +0100
Message-Id: <179503701091.2286122.15450086962310485896.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795037013; l=733;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=KNa7wnOjSsiPNs2FPhDRyJDnX9jgkPuWe0yILrC6l6g=;
 b=zRguH8SoxmSMgDolJjB/raA1Dh9YSaTHWNk86dNgrVmIbXkhlCYxbAHWpSk/31amKOJFX5bqx
 gYf42mlRMOdBoPC23aTqhPewO3xpyaRASweEBCJd5GYkgHlopf4iJSN
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 10:13:33 +0100, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> Android uses the "system space" of the misc partition (32 KiB in) to
> pass messages to the bootloader: the Virtual A/B merge status, the Arm
> MTE mode and kernel command line flags. Add their definitions from
> bootloader_message_core.h at android-17.0.0_r1 [1], copied verbatim like
> the rest of the file so that later syncs stay a plain diff.
> 
> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/tags/android-17.0.0_r1/bootloader_message/include/bootloader_message/bootloader_message_core.h
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
