Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E637C98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBC9F40791;
	Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCW8TmFCNNG4; Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1F13B40756
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527582;
	b=CgQE9ULGAlG7laKE3RTbUycSdRKwm5s+CDp4YtPvRZA3Hti+rL9X0CXMA3V9kYBPxyRM
	 dW4+mDsp2kL5FPTM2ZGE3kZ939tSVwA5ayl5Ec8+GkqjfKsOftxW6sv5rWSXC1qC0pJ3W
	 kXedmqcRDfk4/5M+N4KQRHfePf1HYZ+pQENqDgvSk35bQtExf92+VA58gahjDaAMsf0Qb
	 DOHp08L/Rer4cmXsggMMsvjjZXOjJf5nqEAL/QyPWoBRV8NpS2YivKlhUWkSa3bMU9gxr
	 52m+qdo7KD4bu6sGX68hWPas0mKkxVI5Nge0Ivsf56mGyQKavIQEB8aHLPAkhFedtWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
	b=QpiT9uaIMm4PZoO5fXgd1rFzwUkgsYliB8hVC9YEyy0ciIm06V5K6RdR9xU6FDyCvPNC
	 JtLiT9Qw3iYCATOUIiOZvBw/FmjNqZOEcpQhASxrFuSXAz0gR40nLWa0g7XftMRMxHYHw
	 OxrfWcysZXLSmd2Fwjtp+eTWU9LLRYJdSJywMilV4QEycKCCY7vMaA7276ENZHfDJQlam
	 Gf+x8ltSaz9hL9MPHJEQA9pbwnEhT20xc3Mc/AsVkqB1/FVE2v6WRX37/ebm53WUO/VEB
	 IN8eEth9YOoPH8D/A8ChJlQzcxhwu83GLJTnBSx2y010KF89DnrE/7njBjOyg4nQEqQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527582;
	bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lguDH3NLDArqfyZfl+WBssVI5YFcvYp+VgSCJ7sbXic38Y+c/TNL+VcGXWVaEoRGE
	 uX2ybjhGOCYbCwrrwZJEmDRuNtl46PBnv9x3uD4ku6weP0BxibcUZ8AB9FIh3MzMBH
	 TykIFo5NsXvDc0MV5U4XmlHhZ50ofWGs1Rj35QMrEgjwG6WcUQ5CLvZpvSv7Rq69AQ
	 /zq4gSkoGabX/zUOHm4QNCxHtLFXKw9PruVMR3GrAQFlAl5TI/FSzgkWcA7YriV++Z
	 5UhnNv9pTKBfsavIK21pz+nXoOXVyMV5icfRG8MhCOBq+GOHY2xchyNDCgTF+5WNTL
	 RX790nGFj7rwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F13B40756;
	Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58DEA194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A56F40068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHnlkmZwU6OL for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:46:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 341624002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527579;
 b=HJuFTfCBbI/CZRFt+cRz5SuFB3B7sgSWSvjN5G7SMpAF5LGzMsrF4Oonwp4j+APOvABy
 zQbCm2tRPhbpYF+d8hB1bOS2Bc8h9v088NhNKJqJtpr8KH0b15/pYKNjvvVVXu5iNbF2R
 9RpO3mShzwnP7qEnEdhI+FhWkP5u82dEnLZCB8bnJGg+OOQyY0sBoFJqauhS79yftIrva
 htbw9enXlFwm9YSSzMSi4zsOFT/HEGCrTiBBf9o4A2q2d7XG/kxA2QhKj0jgi37wN324X
 Ts8gAzPf6gVyzLO7jNnxIxlr6wEJFLt7Alho2+cJNaXIN4HYEmQf3Q9M01oDDqTb6ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527579;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
 b=RCPufdlKRLqNJjMRrSrm/5JAu1JAt9dxyzRRihmH0tRIJv9JrfDvL1OIO7z0m4EFNs78
 oJpNcbZhf8X1a0+4ZEs1R7bftysqOolPFsEtWtYxmodN6yib8IbuK+zimZ2lZIiFiscmy
 Uc95O/Rzx6eQTCfzNjn9Zv7mlGCqb43iB6LG5MeMzvGlewubKZ8fYLEtgU+uyNrmVGYX6
 MKfbuly3n/gfQsh4Yrg/RSzA0BKklZqZIAiBojRcoHhFlgvnVocelw3xRjzKhzOv+xKmS
 9jfETKZYoUj1R2xcLhhgnxfb8l7me6YdMkt+1JxBBqZMp9ChcsOYcUGC0PgoX5NNcsA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Aeq+LyCr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::d;
 helo=mail-ej2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Aeq+LyCr
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com
 [IPv6:2a00:1450:4864:34::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 341624002B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:18 +0000 (UTC)
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2dcdc386ddso56123566b.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527577; cv=none;
 d=google.com; s=arc-20260327;
 b=caccnvjANzRQqUXSjmqhORoETioRH48Aj+wpBf08ZUUYVwrEEHCFLophdA13lNUSdE
 UsfLQmijez0C+owhgyWYQVJOibp4EWEm4wcVxMxrubiRJztXva06S81d7cAI0YzrjzEX
 P/7hYY2+xOPTFUyZkDWl+XquhGalLDKHcLP09a6dcIxamBvL+YtPDYGi0YG3KN4RUfWj
 c3jwY0FDmJnG9c0f4CpM6WCSNTgY1GZjBYn1q2Xs6GPY7Iu6ZUR64n8GYdDd0k9N96pR
 P4E6Z436vYpFakt7RxMi1g/DH/cSb7ahrsHU6Eo3vz6fHJCpzaZOVYvRTF9wxivNKk6n
 oMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
 fh=4B7FMck9Ngx9nuOmeSA6fGRXQa9ko6a68e21FCCuDm0=;
 b=mDGv70DLamjBWVTYMgB1ZQbZYOWJEdO58hI39JHQKObnnEtvzlryGbj2kqcuOW4w0k
 SrIIWTOQ9h691hEnbCZGdqH2WPU0b1W0oYt8uI/fJ5N26brMAUT/zOGRknjkjnmSWlsv
 hdmMaQdtpCsGEnuK96BrJyTsFUx/2tn87KFI9NbOvAaz0KRbJOGMlcIgzakSr37TWgGi
 55GDCPEGOBqOCyhFTm4GcXdYY9i759iuaKMhzD+Nt2p0tk23yESdIn+K1gngudJkgcry
 88Z9KgQ0WRqliyhjVotbrFJmcUfZvq463N6BgVGLgSdy/uD44qKl1wrB1XtJk06U/L3R
 kBvA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527577; x=1791132377;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
 b=Aeq+LyCrFrslHDVWRPSPtSqBFlqZHicho3AO0qEa8DwHkB9fc+mH15KOLBtRHVx4t8
 xSr2A5yuM5Q1GJOvVuDC/X94/057Dismq+n8BFpbcurczcA7mhRS9EufJugtF6gz2HCQ
 Q173tjbAk7DhfMWLM+3+lvt72IMytrYyS6yv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527577; x=1791132377;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ArqkKKPJNcZTwTAGrcAYoPHIDZzHuSTD46aTv6VCOK0=;
 b=rHCxvGSERfghEVW4V8c8+SAu5Kd8e9jP4ac/1eu9ggwfEfP2yq31ToYgaAGtv2gHbu
 gUVKmNKbzYaJS0GIRgZ7ekv3fC7ynqXJ2jxjpCPrNFK80DTxEiVEsQSiFzwI+nRT+12O
 IPhdeiOG75TaBL6fgtM/M202fvzEb1apcsmtLxSq3nuq3AniWAKjw+UAHo0taGtbuf3D
 lGvk96VAMqrLMg09YfhkdXJb8D+dTWiwOuekDX2/RWGSXfzJsgSq4Y6NMN+BtSZxDR7d
 mlpXZ0OvE0MZwhcTO71gJqRwdNhKgMVOqkGQS4N7RbWzXQLlelw2A10V1gbx6ptAxUY1
 BO2Q==
X-Gm-Message-State: AFq9FYK8Liq/6Ybm2Zc2W9UiBznaISKQoD0/jVClAuhO/gmLtyV4cXeb
 p0iGT4EiWopvnAX4hcBeeWOaSJ7iCVWiq7iPogYJxdZraRPv4f0CDwoPvf60deD+nb3MdQQ0Oqx
 0AqnlFyPQRZEFPJO7PXMcrFVi6vTvJSXoVi1cJnRP
X-Gm-Gg: AYBFou2aGUke08lmkxf+tB133KHUgffZ0i3tav1TKw5yC6LecNx+UBoSyvV7jYUEKQC
 TaLGsI2NrU8u9Hu7ij5JoX0p46ZLNeJQIDHeV6QDSf3NF6N2QMkGVNjxF6HBMKAi0Sp4epQ4Hdy
 967uZWm8p9wI9nwoiBo9NcGNN2d+Cwriz+uCxH1Ki1oDoepnwQHdJpKRwzfS7fVNe/1UI68iLJd
 E1TjbIuGIf3q4vLxP4sPLNSb5u2nwJN3cAcLa5dWt6zZiaB09N2ToHpjGUdPXgGFJsHpqZcY9lG
 z7rMpAZ9VZ8sFQD3tMsAU10DXzu6CV6xBXbSIyRMIzZmZhNSJxUtTssVDPtKCcVI
X-Received: by 2002:a05:6402:e96:b0:6a6:757d:6311 with SMTP id
 4fb4d7f45d1cf-6aac8ed463bmr9067211a12.9.1790527576734; Sun, 27 Sep 2026
 09:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
 <20260924055459.125648-3-aristo.chen@canonical.com>
In-Reply-To: <20260924055459.125648-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:45:57 -0600
X-Gm-Features: AclHuK8KG7fgByat5fS69EbRP5mzq7HdpGK-CwwfzpR7CMbzqxVsbBr9LZFGiH8
Message-ID: <CAFLszTiEnFSQzq3NVkxnc8GqagHVTZv=XV=5yGEecF7LOG3JLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tools: mkimage: use the name argument in
 fdt_property_file()
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-24T05:54:48, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: use the name argument in fdt_property_file()
>
> fdt_property_file() takes the property name as an argument but ignores
> it and always writes a literal "data" property. Every caller passes
> FIT_DATA_PROP, so use the argument.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/fit_image.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
