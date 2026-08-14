Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8320DC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD9DD60AC2;
	Fri, 14 Aug 2026 18:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WyaGMRkFkTvu; Fri, 14 Aug 2026 18:52:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA9D0606DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786733546;
	bh=J6P1FJ0mhPZ1uzGeqPSncU16h2GX789Mhv24uGX3t78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXRwdsoM2whChJQ79eCdCWSVj7Pc4dRfYgYOlbNCi1DVCbPjNlgzkumwCYaHcSO52
	 htLTT0q7tuvLF5Dl+yW+A4/6wbYBNRiXgKQja5LIIdm7YhTgwbdoESREmTjnnLaFtO
	 qF6VxbFPLFVkWfQeUkq+vLg78ZPAeQFgyGUIDDqn88p5miXFZXkoAPp/R4j9fMPZ9d
	 q5xxYiJz8jdijQX2FAZk9N/SijdtUOYNciqfhe9W1KEM6nqsZOy/9QHNLRDld1/qQ4
	 xFzVANHuS8AhfY5hUIU07R7abFKsfKoWLP/0lDiTOuS4WSSCiUp15ViD+aqLQDQo+Z
	 yBioCVBI96svQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA9D0606DC;
	Fri, 14 Aug 2026 18:52:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FDD8361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81DC58127A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvWWEuETnEfq for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:52:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6362681255
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6362681255
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HsPwao+P
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6362681255
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:24 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso213195466b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786733542; cv=none;
 d=google.com; s=arc-20260327;
 b=Ig+Ri4HavsVURpc42ey21WdqHjf36N77ERg72zvwKR6vs+WdzYPIINFYqJTuRqLJlH
 ZHyJeXuUkuuTLqeiIstzlmYw/xyuQbwiDHvdwb8k51oiqkYWU+CaYd6+2QyF5eJDK7ib
 ORpwCLo8UORd0tuXZLR9mkfcVt8MQTL0aZllHBmDeoNKvAn1nQI4MmWDP4BU601fM3fo
 bzYWOrTUYruj8UU1oDQgoV6ZNqsm5fXZ2laHNGutFJjcaF/1JMuTvH9jpQ3kfVBj5mWw
 YiQg1KJzDsMRdGiEhgdY+Sn0nOwnVc/XylFTCm7X2hbaHIlZmgptMXCG8mt1Oc0yZTZd
 Wr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J6P1FJ0mhPZ1uzGeqPSncU16h2GX789Mhv24uGX3t78=;
 fh=QCyI+D0jDsvYu5Ssk26o7d4/gDazT+HcRrO4eg7RvWk=;
 b=jCzw4ey0iypPJurSSowUmIGTQY6EhiuA9zNB+98ZQrX5oiWVLZF3KLrIoTAarOanxF
 8pW3SE1DzjHpRAuNIqvmeZvRIVWfh4qP67S/5YtNeD2+2z5nEc5bdH++8XkIwzwRUmpj
 DrDhjZbcfOBpq+nFgAvAUbNJQl0h8AbCDSO4KQUndzY+why5VIgp+qck0h7ehjT9+50n
 kLbTx+dVReMV4am+2V4lZJJGNDVHOfEQ+W/ml3aWE0Ypl/1udVXsLy+endAI9tCxKbKt
 LG7OM9xxsk8WcwmKKULPeayajvhZbxsXf6yfh6eCw2xP6mraeyiTAMBiIoWVvK6M6J41
 6M6w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786733542; x=1787338342;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J6P1FJ0mhPZ1uzGeqPSncU16h2GX789Mhv24uGX3t78=;
 b=HsPwao+P6u3WYWDiHSTG4U/LZXifKJhRQ5eBY+U5zlClX+7d9mZ2f0z8FUxNvD62fL
 CvqJeRlJHnxIkMWeOGIatRmlVoZ6dnZLN9EhEctckEf3Ubbjqkk1H8T3UMCKt5gMXg+/
 my+/wCobYtWt1IxDHrbDBS72Kjh5T+jsnJYek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786733542; x=1787338342;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J6P1FJ0mhPZ1uzGeqPSncU16h2GX789Mhv24uGX3t78=;
 b=KTcPcGWN5kWWOQQCK6KUfBjQprMlqgUVliQNnx3oMSHu+BejJjFIW+bbPbsc1nKi1k
 kEJRaeLXu/jY2JbzMr56lE8o49YpItaxBPC68PJ9zbgfSmu8M1GBuyCSaUYPrCjjy0LG
 zGsT0vat3B6PajfrR4qmLvUQjLFcr4f/kf5idaHX/oMNL+hC7lY+8r5nZJCFRvI6Wq8U
 TAC+JWA2zi6W8n0fTqU9Bm+N7VRT2dxqC5iv+NeFGeEEeC9pmRYoDO/x8eqRG6dHSm8c
 WFCdScf5MIz2ln4+NTNj5zbDZ6RpyU34r+B9SvEX52CM0e4Ok9+bTICQc0Nv8WuhbTL8
 +SAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPSlnWf58mY1ZKsZKZ71nGZpEETcWj59sSYcJoE7wywDLsdpDkhzy0LRFSdUdNJySYLQUlYag=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxT/P5WbRsqJGcPBVdsodL4ApsgSdqSoGcogcx7uvVShKTaqsX+
 /JaIBrYyp/Ksqtg0Pr6NbhFG924ZD/gnIFsUpauAfMMfWaUGvn119ozzTxr0dfz4p+rgH6BIMHV
 G1K/Fx/CK3Lv3ss9xv7RnpFhbHt7OmpgNMlvyT1XK
X-Gm-Gg: AR+sD10ERkgKt8sLi58X8081OUKqCUFQM+oCtXRPwGG2s4o1KtRf9LuJwy95iLYJWVV
 cjpPD98d4lwepl6Kgz9AtsPV48IJ46tRerbk2o7f4tdZYLtBBp6EqkE1c7hrVJmnfSJUzg5DYzu
 Y4VBSvfY8GSf3fimojFCsM1LhRbKRuwsbV55feUBRgmAU+qoTg/C19wr8iL7KlMY7CxwoqNnghz
 0DUTDRdKcHEt62rFbLS66qsGwUjz7Q3Ns6GQG/Qdj0QlKv2rVyWJ1xyZhzDvKTMUam3GeOqQdOp
 ZcKn3MhoIdUyyoLgSTBp1allYuMZPgnq4qWLyE+KBR8=
X-Received: by 2002:a17:907:9994:b0:c1f:e9d3:a3f0 with SMTP id
 a640c23a62f3a-c2129ac8464mr389184966b.7.1786733542306; Fri, 14 Aug 2026
 11:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
 <bcd1ab49-dee7-4f99-962f-1d4876e7758e@gmail.com>
In-Reply-To: <bcd1ab49-dee7-4f99-962f-1d4876e7758e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 12:52:10 -0600
X-Gm-Features: AUfX_mye_gNolnfFgzETr_7wkTRr2Li43Xy0WJhKkXfltkGIVZHW7pW-gY11o-c
Message-ID: <CAFLszThmQuWdHoA4yN6X4Ssmn4Wer0WkMgL30+qBBcycLrfNOA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] rockchip: doc: add notes section
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, 
 eddie.cai.linux@gmail.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-13T20:54:05, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: add notes section
>
> Add a notes section for things that don't need
> a chapter. Include some rk3036/rk3066 cases.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
