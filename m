Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB14ECD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3E2848B4;
	Mon, 25 May 2026 17:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ln6cvYW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA958848BC; Mon, 25 May 2026 17:15:17 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB058482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bd124546379so1482565166b.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722115; cv=none;
 d=google.com; s=arc-20240605;
 b=kVi6wStbosC6b7argYth0jnf8ncwMEnjkKZM7pwEjD2jHRzHchsyyE6C5rE4P4a2rs
 6vPsRJxREHqjGNr0EVvA7bbNNBewMP+fDImDqBEhYCZz4osgY0quwngNxJQYAUDO4kFs
 Tca0zF+GzklBRsVqeJuj6HZ6t3fYfZ/xxvw+p5evnJtNDlQxVntzJsBse1dD2TXQktbJ
 sfYjKhQeCX/H2HbbpSPdh+CaN882eSvuaTL4W5BkfL/b+EP7ohlBtb77wZEz0XMRmOly
 qRpmc3lOGn5g5BJ2KtxsQw+AsLtTGYlHh/FaQxfiRkIshYfEWTqnH6et47GMx8+RT4h6
 43Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t1JgccnpfK4SjoTwEi456Sosv/B5D/kuFgxXVvYMWZc=;
 fh=5YhLnYExn+RFXJMHrXa6E+9YNQ7PdWKEtG4iQ2WFeRA=;
 b=eenAJxnBydUUXom1HbFkk/u1sjQlbivC1faVaF386J0qSnQMT7tCy4eiNO5ZLrbaOQ
 Qyg5YpB+zvFEmgR/IzTz8I9jPVZSF3WH5FCpr0BGj4YLV2Eb3sqKmUNK7SjeUVSDV189
 5xgCCoSBzhHSopeJnp1Paf+RnxhDODsRTJmCJ8JOJD1Gwy8XfWmUaeHckUAcCq3c8lno
 hCBABqTM1yvMNAKkWVpd5NYwB2ainWobdGmkyOvFLr0ySOzkdBj47SlchZA2panGMyda
 KT7+qbvg45VcBFxhEMQhNQju6c0uD9BF0H3CibIMYx0NHr9UuYqP3sa/MApQvmLtEN/0
 l9hA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722115; x=1780326915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t1JgccnpfK4SjoTwEi456Sosv/B5D/kuFgxXVvYMWZc=;
 b=ln6cvYW1qkpzf4bDKgPDSaErhqUBaj0lJxc6jqahlBOH4dIdhIvkargvR53ODxJEhh
 FfURGOYAJ70/bHsybA5ajcwBc3WsiYp4z9X+Q/abT0fJ/XtpGCbqIL+rFV/pIVYn+k0S
 WsPh3pdjxSPu+68wWIwoW3w6w+yjuhb3jOPwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722115; x=1780326915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1JgccnpfK4SjoTwEi456Sosv/B5D/kuFgxXVvYMWZc=;
 b=aqkkjfxEyVQPCMOXUdt/h1vFCRpJDS3AFGMPbmDnZSbX9/rkG3O5jbD2dN46ZjADVK
 LzsZv3kX6bkl6Lrnl/whn/oicO4NCrSs/tTPW7/ezX0iIKNKJ8tH1pIUF1ubSlvqJUHc
 gkNTbdo1Q2JWeRism1CllfLdMgW/9ER0q/8GdfJVEbeOFc2spDq4ZQEu0cNjivqkLtAz
 teP8MGBQMesDJQah5N35+4mhOyxQ5uNip6RLdR5GpGdG2K2FEkAkR04sFMDcCBKJkcUp
 AvVaMIhONfPaUQkp4uVZEcPcIrEzO6p7h5z9dPsklVrwmdWrlmT1quEJzS5zG0UuoNBg
 x13A==
X-Gm-Message-State: AOJu0Yy64IqaaGvsUzoVp+fRqlGEcPXkm/bIi+ssf5QjC+blvr3jL97x
 d4T+hkgylo7cm0B/md6GWSOOo2CM1xDS27Q/AOqMoKvLGV36bmMU22c7EnQ+u30yUPv8PlBUTvH
 WyjCi/Y9xDMDH9/ve4LNpWp679sBITnbbOGIm90cf
X-Gm-Gg: Acq92OGx+/wqjGvVfsPWBSx1xQhOchY8wHPy16b0nEZ6W5ippfwBYCY5F7u5IXReuut
 DPOXYPzURJm3uH4qOW/Jg7iutm0BvqPH/HUAQi9rgUhJFHSTunzl8M7+A2enQTjNOUqjlv9eNDF
 1nhf00XJGoxNHGb8P61WiZ7L/WAH9N17ovLGQCg/9j5BbfvYl1WaUdhAOsfxfXbYWNTzjxsFqD3
 ywNwLdUeZlC7BglOI6lNpaor9ncFKwnPe9pvKM8e9iCaxlcu+v4N86mdFZZBJcEgo8jhs4VOTKh
 NiuyDhpKFJKvC8s3
X-Received: by 2002:a17:907:7717:b0:be2:9d25:3da0 with SMTP id
 a640c23a62f3a-be29d253db6mr1838166b.25.1779722115355; Mon, 25 May 2026
 08:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB28056BB07D2C25BD5409444DDA032@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28056BB07D2C25BD5409444DDA032@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:15:01 -0600
X-Gm-Features: AVHnY4JSWsN34BpN9xItFss3ek3a2HC7S1Z6BWZC47dyPmf4ovd-qWhShInKkCM
Message-ID: <CAFLszTh-bUvU+x36Dh7J5HEaSxuXurECtdidbFhkdOEv59NV9w@mail.gmail.com>
Subject: Re: [PATCH v2] boot: cedit: Check ofnode_read_prop return value
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-18T14:39:27, Francois Berder <fberder@outlook.fr> wrote:
> boot: cedit: Check ofnode_read_prop return value
>
> In h_read_settings, val variable could be NULL due to
> ofnode_read_prop returning an error. This variable
> would then be used as the src in strcpy.
>
> Add a NULL check after calling ofnode_read_prop.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> boot/cedit.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
