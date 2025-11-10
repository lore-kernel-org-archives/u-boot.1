Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BBCCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 18:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB5D83980;
	Mon, 10 Nov 2025 19:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hf8KkgDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9585B839A5; Mon, 10 Nov 2025 19:32:39 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743FF835B3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 19:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c704bdd57aso727186a34.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762799556; x=1763404356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjdoZsdkfAxhnsqlIneR7/xlc+slO3sARjjd6OczWno=;
 b=hf8KkgDlqq+XyOpDpxM8QxG7t84s1wEyP+DVP4FmabIWGiIgmo1R+/ofcZnjAcbtlB
 rWCuxMDsVr0MSwmtVZpG+TQHuMBeOScCbzYCkrQp1xV+ytw3LTQZRTCQcgzvpjwoSseZ
 fO4W4E8ZN3zwXO2nhPj79P3OngxEGmZV7QPg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762799556; x=1763404356;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjdoZsdkfAxhnsqlIneR7/xlc+slO3sARjjd6OczWno=;
 b=EUbDR6oVpwRCMq645Wbjfw5Vqslr0WptlzgmICR0J7vQWDwTJGW+BOFbInO2IsqTOu
 xuaszJzt7GzyNzN97xB6SMaFawbYcNDHsm5ekkL5XvgCi6clppp5CCjk8cIj1eI7zpb0
 xxmPkuikOoW1Z1B5RUV8ljD+IyeTyqUXelM938uJdBEXVE4alySHes/LSin0aDEF4X2g
 vaA4EmQjNtUdY4Q0QGtwEMQey8OmDagbYGAzSPXDpb3IuPOXjqObOZxZXlIlYcNylMfn
 EDTRaLm/XwGlaiJD3Wg97jmPqZZPJL+YHxwHLVcUwMh++05tDPRop1TLCvReiQkWDRm3
 XCfw==
X-Gm-Message-State: AOJu0YxH3ZQ0PyR5T4QIZybb8jpU6dyTIgc0EedTfz5ECS3nbAg5zmzY
 vWLMKud7DCzMPMsUX3A4F8XM0NUTPNkCLJzXwF8Xp2Tfu1WFtNgAYF9mc+ceMorMg5xkpyfPYFb
 kAm659CkC7A==
X-Gm-Gg: ASbGncvnQQeR1Lgo91K5Y2SO8x2mQF6R1CaIVV3FxuBjvy/plUcz3oYbaIuJZw34eXi
 ppYxzc0H6pxZGUVLC/7+hJt0sgz5GegnMuCggHMEdOWjPUxH03ipbcp0PPzV/cl3/2v1eZJqjaw
 zE5/VZqsIlBwHLOc+TqdxZmCIKzNQVspxb8J3EG/YHtPFzZCmMHRlM3Hl79qspEXXcgIM19aQKc
 8KRTGze/6IE2NJy1p7ipJRd6Km/uWoTIHhF0YBrzV1mKOM4hC3BJ0i1Wh01gRHxny8YklpVWVdr
 q1I83LVO4T0wL6QwPL+t3QDXn+KR+uV7DU6EQ8GhwAaxeNJZaVeiBRzSxfg++OVGCSTD4cV4Iv7
 XJakeoUQAngDKtUKiR8rcYYPiJw07OJhoTk9J7oVFD/QUi6xy2ss5Iz4rYTY8Efw2KZZObEhyEp
 wHPNR1fZLzjKS0Uv+VJyg372lMblSSR34+2RFBFA==
X-Google-Smtp-Source: AGHT+IEtDT5NzFq/zK7RIR7NfYc4REn1teWd1FNkQ0j7SrM93/ENMctHmBCqn41gQLz7EBldPTtOKg==
X-Received: by 2002:a05:6830:2b0b:b0:7c5:3798:fa3f with SMTP id
 46e09a7af769-7c6fd778da3mr5885606a34.2.1762799556162; 
 Mon, 10 Nov 2025 10:32:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c70228c9d6sm3296054a34.17.2025.11.10.10.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:32:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20251102200814.3059463-1-trini@konsulko.com>
References: <20251102200814.3059463-1-trini@konsulko.com>
Subject: Re: [PATCH] dm: Remove pre-schema tag support
Message-Id: <176279955517.2661974.2605210153595437001.b4-ty@konsulko.com>
Date: Mon, 10 Nov 2025 12:32:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Sun, 02 Nov 2025 14:08:12 -0600, Tom Rini wrote:

> Support for using "u-boot,dm-..." rather than "bootph-..." has been
> deprecated since February 2023. Any platforms using this have had a
> console message saying to migrate by 2023.07. Go and remove all support
> here now, for the v2026.01 release.
> 
> The results of this change that aren't clear from the above are that we
> still have a checkpatch.pl error message, and document in
> doc/develop/spl.rst that they have been migrated since 2023. We also
> change the key2dtsi.py tool to use the correct bootph phase rather than
> the legacy phase.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] dm: Remove pre-schema tag support
      commit: 6d04828b45202312c93892b4be834809c795d4d2
-- 
Tom


