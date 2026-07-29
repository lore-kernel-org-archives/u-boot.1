Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983E8C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B6E140B6C;
	Wed, 29 Jul 2026 13:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0hiF5TGzPgO; Wed, 29 Jul 2026 13:40:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36B4440B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332458;
	bh=Qh17w5E1NzzNR/ViYT+LwEC9CjdxIPo2rv+fg8F8uVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Knp+6mY6Uys9aklKCBUBaoznFSWbF70PbEEVGakZLLxv+aXHlxLU0mceqrf4dEN/+
	 8LF7TSdBnd8lk+jLKEewJdUFa34XmbLcSIsDckxhEBrRj48zPb2IQl4GQMT5aM2WD9
	 ADlICIpmPYm5hYnIv1gj1wS+7CZJI6XU6Jg2QhX2GIkXO9nKJvKVWKrUp0iv4znJ9E
	 auTt4znd599bmhHBz+Qj/cE2Mu0ikrDJCLHWgT4std00ObGOjFOJWmQSlLgeFbW62N
	 zH/UGCtBDuklOnvTWQPkernYZnZ2CwSDyryrSwZcUxoxArYqlKHDUeRyTlvkoJF0YE
	 pQUjp7rFqsZSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36B4440B0A;
	Wed, 29 Jul 2026 13:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C19194
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A866740267
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2DVX9DI_b_p for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:40:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A52254025D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A52254025D
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A52254025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:52 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69ffb48d599so1528661a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332450; cv=none;
 d=google.com; s=arc-20260327;
 b=BG4rBiJzjHqwd1vJMxCkLMjIYJr1oTWUKMFaOJcMBsTGYEko2lKHH/3EMJbIWjqBA6
 7VamyeL+7f+U392WLQbQ4PQEVK5Z+OjVhAUX+wc9a0mhe3w3pdRzqsyyBKxHYnJFP/+L
 5QOQJZTmLjKbQnMVbAhdLI/NlwjiBMSULCeIN2zq+Hmb/HZF5QoihgDgh/tfAkuF9Oon
 Yaj4z4z1CCt8QzskYN33rRz/xp/+V45njJ0iv4te6hCFwUySmSJcm7kCA2IMGWWKJa+A
 gPu+JjuFf/8QFPVtPb28uFxnn4CeTH+Zkt+yoqpBOXcqCjJVDQC6xCwWEEd/+U+ZRl5E
 Y0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qh17w5E1NzzNR/ViYT+LwEC9CjdxIPo2rv+fg8F8uVA=;
 fh=58uDsqbXFO60LIYvsSlCaTenXBYJPR9lhUl3N2ckeXo=;
 b=cYNDwyG+sO3Ts+6RGYsCbzzOsjlC+hIOITaPJZc2yb+0et+TCMLhl/++ld0dqhYFqK
 PPnYQcJsoTQwyu78C5ndPfT3hJY9kTsN2vTVuL+i4c27MGNawjV8EwOQeGI41aB+AE2B
 YwA2kwH6gmtJxbaBZ/18D96V2MyR3F5IrcRP4wA5Kk+aF13NprgWJpFkTB2zGCddx8Jd
 o7Oirge88/UibQqfpuEkF04HraBdA926ieANBXjPCq6wPktSMve6nv8lTC8do0oDz40R
 fmDnJBNs9IhZwjl5S1H3ObJrjjtIIHaot1TsU7+X5XKtvA5TpL4APOXnCL2RNhmb54Fw
 rYnw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332450; x=1785937250;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qh17w5E1NzzNR/ViYT+LwEC9CjdxIPo2rv+fg8F8uVA=;
 b=RYYCAvIArX+kz+10RrcSGWLYR3br/cVm8Wx6n6mBvGPOeYFMIPGJ+uJOuWtg5x8czn
 PWmUO0ypWWEy+W0NrbgASLSWomeNZP90zTuMHEuCu2FDryVawef7NeD/ZzoAgO9bLGSx
 GasU1UvgJ1VNIzSIslj2FOWXCUNcYaUeMFESHt10kSNg8Z8KVsC/cIsdisLKfkw6CT7z
 KQYOjCjKOJAiCPWY8tCiHdBCqvtSBxtLrEx8UUMpYpj0Tz6KUu8xl4emDhtXfLlkO0WI
 33FyZ3aQ4REGJfSdh4dEkqNJ/svn3uXRcV9fLoztrxRcOukrd07QhrmGDD0vHXE3AHnI
 Culg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7FtjonPIdWu4ZXVQZ5h1+XrujLgCoV6UUnPqy0U9LEr3HD825jVLasbFXumwMS3Buj/XJKQM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YysYkUPJhjC/kDjYmu2n2zC80nWMaclWftVgHQW4qo8sSRpQgI7
 R540HQY6XbeV1ajdV7ZNKqW3BE69Xz19U0LG+37PK6v9v2jPWrLbs2e4d5BW/9Y+ahv6Ab3TkLu
 qCV9drMtcWD5dIy5gguqXZatzGNl9UOFivGORRzasFIxqQ60taRk=
X-Gm-Gg: AR+sD11T37B6eVIk/+Wyo6y+e8XtoJi5yvUtg15oJW8XJc6hARVYz2vGxCUYTmZL+s5
 8b2ZHzNT11j8uT09iEI1jz34vDV7XgjSQ3wtS2VQUpQIqht255IrJK2np+1Zx+CZgMgMC1em6Sb
 XIZg/WEJJvwgShO1tEGowZTaWvp6RS8bfr4uTx4zTMsy2g+7V4Gz+nGuI3x/O1tKPTimUTSNYAl
 iDXBdKD75R5T+DuqlwlWiAC1akoDr6QXbRUl00q1P/jg56uxRNnkmc1N43XPdyAgv1DiUKErDrC
 74q4W1iNr7EgD53hIoVERdASWjlya32/qXNtBh8jJCg=
X-Received: by 2002:a05:6402:1907:b0:69a:1932:7807 with SMTP id
 4fb4d7f45d1cf-6a034a882a0mr3693986a12.37.1785332450452; Wed, 29 Jul 2026
 06:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <a0bbdb53-d3d6-4f2a-9a18-5502dbb1c571@gmail.com>
In-Reply-To: <a0bbdb53-d3d6-4f2a-9a18-5502dbb1c571@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:34 -0600
X-Gm-Features: AUfX_myqK-5iJYWvT2kkVEQyCLUgQ53Kg5Rnk7xihoEOGM02zOJksmwufje06i8
Message-ID: <CAFLszTjDS-KGkfJFFrc4qc8CyoJg5BiMVEJw_LKFxDwvfo0xgQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] rockchip: doc: remove TODO
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332450; x=1785937250;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qh17w5E1NzzNR/ViYT+LwEC9CjdxIPo2rv+fg8F8uVA=;
 b=EEa+J9tIL3QVnz/TLFprXjg59E6UK6+tU1xnq4mTs4IrGT7lBQYKL20WMAQ+GAnYZj
 o/R6XJ6PqEoT7cFstQkANXGgAaEAhh+/ivcG2+qd+KnEE14nba3URLfbyt5uBwwpNFW8
 iIItaR+zX6aCy6qpHPDbCp67fd1DT319ag8Jg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EEa+J9tI
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

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: remove TODO
>
> Don't try to guess the future consensus. And don't add
> a TODO if you don't have the intent to send an immediate
> follow up. Remove the TODO in a constantly changing document.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
