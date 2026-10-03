Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99524CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 685918143E;
	Sat,  3 Oct 2026 13:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9VEioT72bMR; Sat,  3 Oct 2026 13:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B86EC81426
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034913;
	b=JYmi7L5Ogu08kTqqacBToR7xxYLNxHqEQoDHboVnBGJSOcfv/jpZ0gta056i6xeqSjnJ
	 z3k9Z5uCr3PYf6noYqY4mJ7RXfox/5jwA7n0rU6zBCaQlbByEoHPw0r/4MVyL1CbdqSY1
	 Qvv81FvzqAiewBO7FEJpMeA3zdkfR+UzQTv6wvSMxxoikbEYN5NNygKdg47Lpsk19ebBD
	 +c09zu5t8yQO4YyUxzeb+zOVCwhWS3MQdI6MT5gXupo3frSClgcKEFYp+0fVPsE1aaxwz
	 6qbac2LFkuyWsP5O6OzrE0DqqUUDie+7T6+/8QDeL9C87/HYr2Q3ixlg5/sQKQytKxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
	b=I69t3QKghRLEnbRXg6MrxueOp1tfXDM8KPIdtcqHB3A2qtQ5WmL8XrrIMZt1WM2L4kKz
	 jOfUfCPlZtlbSd9dUkd25pEZQH5IxgS8UwxLCSznS/vKuLuvaPyN0sG0MMhVZAmViydXu
	 +uhDWrCneCZpOb9S7HMQ4b+jAK+ooSPt7emgkRuLlBxOWEZgZCV5AeNthx/ItWSkJP5Yg
	 J1I//cVqBDqfHyn6XVzRsjnIhXAs5MRT0MRclyrNmOp2OgAy6jZRhgI0XudG1QO3TOzpB
	 yGiPeDJAGk7l4zDl7onbFhcUV/kqLR2Ze0iaeFyNDn9oS23N+VFhOqtx8Ye6xb2BMag==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034913;
	bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIGpGidhKzfolSTR8j86tJDbfqPIfSR6vaut9k3+I4+Q6OG+uQ3ZVk/dKZm966w4Z
	 z8ACUwf7azfAupHBUpFqY93/cDFQViX4sUSyZlD6U6cIUU1KavLDSg86G5doxHc4NP
	 1Kssc6EsdEa0+VUJNIMBBmJkoTFrSfuMbrLJ7rcws8YALHmOv7qkxWKpRTzz39oGWI
	 iIPWJbSl/qeLoIRkEIcry8wY5pxbtIy1T4YSxsXMbaSt0l+wpyzZa3AV6pGHN8Y+ye
	 2i76gMKjC/VNrDtYFaedACLAit3rXsRqoaVTPWxUyAw5KH3eKHSLRa0Q37Iyx/t057
	 ARHRWvWK+ahLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B86EC81426;
	Sat,  3 Oct 2026 13:41:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFD7A179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1B4C414C3
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmGmuATbJaC4 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A1F41414BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034911;
 b=E7t7xxPY82fzO/530wWDfxlDVFlZxYb2EXqdiJ4wy0jHDTXmFVhO/fnAX9rdfj2vPkYk
 Pigo2YjgJvmfXN+7OqcD38Fi8TttG9tqLoYY2md9xdwcN8VaKbbjojkel+P0evrurZtvx
 pkMrkrsZ27JT6Ye9yrnCJYZtwXGZwVrqjfP6WZIuwFybbGVuMON4c9QwmkuLTXhDFesaJ
 DChVVQn4gz6ffVyPbzEPWf2qJmMZ9cOnQqrZmbNNu5JsIRoefu1r52DypW7KyYRFc8gT4
 mKaWkhV3leItlugxzJLykaZitip7x789SFQwPzj7Ttsxi+l8c6ExI7EPZdFJOF2eiBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
 b=GMspGLm0a7PbDVnB88OC7+urL7kcAWRKJ2roxdeNAPJ5zbl5RllW+gb3RFaFtOOJiMCY
 Agg2CP7eJlp8prYt7t1yOUgaJDwc6op0AxrudsXXH8V5LSNLwSn1hY0InEWs14vwGSxwT
 1w9gRCeZOJwMFFr6oAWDYAjeG84joG6Sz8S1mKYW7PpHzvWSXeIN7LHdlURsyn5sNqYII
 eJuiVsJyaUiO9herqgHUOz8FFKSkXDDMNaUsAQcNIbBKcW8mAcxAyF07guXc3bioWT4gA
 6Rl4SV//JpHEM74pnIT9/wxOtA/08b08XyPip+FyONotJ6ja5jk9ce1klOr3ukcj9Cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=K0EwFqLq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=K0EwFqLq
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1F41414BB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:50 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso533375a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034909; cv=none;
 d=google.com; s=arc-20260327;
 b=LLxurVyQ9I4V5hW/PhFo28EVz80IQoJXAUGsTPH3xkLWN9YOuzAsKOXfDwjz18ANG2
 VbAvMYH7aqHTF5/lQJ7cgMhah1K+PnqIzmYvgE59wflLKjBC7tHWySdCzzaNfTP5KyjU
 0jMblCeMPb+dhKz7ve8UpkCqcnRSnKY6bSaRzZaIR+29RZvLiD56hfhPzq//zgnQ19dI
 iuVVxKwJ0FEWactNpbnKv17QqU2DL07xn2zNa1jRei4UW1crMvaY3CcxlQfHk7psNKfx
 Cvr3YPBalWfNxGDA7Lu8JwtUhJP/qf5Wx7mYHATIagoDc2vh88C8ztJYWlODQdg9yYMZ
 Rq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=ii+byKWaYtuEsh2Bha766Eag7fKuKbev5yz73rMXVDY41SpfxBd1G2v8TVvu6jJafu
 nznJkl5uYR1CYG5AzadLKOMlPbFruh/jB+o2Z6YNCpbxPqpTcURf97cQJen7AYrgcEP+
 qYAIb2tiNAOQbzow1UeG96SSjwb6piw25mDQSB2D/3y62Hbvhg6HlHm1QxhKFz80O5ov
 A7mZzAatsHT7j70jbx8a291uqZLWcRYNYmW048ox5qDQveMeYfOuncAjAdYNdPOYX1y3
 PeKHSsdIb8hyfkoiWBrXv8tO2hlp6WBBi5FjeJSb5OzYwEM58KCFjtDBpUTj2jGOfds7
 HxjA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034909; x=1791639709;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
 b=K0EwFqLqEGM8qWevCH3IpIB7VcsgWuUW5rjVls63jOMg7m/tlqiviUoSiQRwjFDL57
 cmRyphdAbGicZQ9v82rcGGf00KTtO/jWAgDSbz4U/ab2IyoPZG5SknQ8rSdAk9t1vMzL
 hC0C3yDsl68ylKAy+ECRYEKbX6uH2c2CRLlEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034909; x=1791639709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CBvOddVqpoo6KfxK8aCt7CNAKtk8zfeQGtU2hCaYOJk=;
 b=o1rluRwy832MUWN4XW0UfCZgTZR5XyQfgUxulEYX91zGB3J6xRn8Q7finAXJGZzBTt
 XT9lpHO5/6k9ayyQObmgSFTZbk/i/lbbrvxxKsXDNBvxAv06ZdCTOR/vNZUfw8FFAVdu
 4D8MZnigv2ueLogHdUPsA+R4xODXV6BNUUoCVuSaq0pOfhwStEmK4EOK/+CFDw5eLOPk
 42NWekJVezm66iS0QOFrMZSPf2NpaopuRsoWMQph0OvhKPsOxj9FVcYbwQjFlVUFSE2V
 sSINB09LvoOO7suBhFNfiMpEbUjvkEAinwOBYhWQkqDAdOz3E0fxxLFjGdUJZ8JBKXEW
 bGdw==
X-Gm-Message-State: AFq9FYIC6M2pJP1A3MBxA/YKRUQTacMkz3i2Hj0yBqshLjKePFavd1SO
 1LbVN19Dat4r6Ze4Kt7YA6x08mt7dpWvhTPi7LFx5cS0axTWC44vjg5eb0BzN/UH5LDefEFjt4Y
 J8nBmrR8UQgcXHq5Dl1wMVFnAkJdZh/bVA5dv2gig
X-Gm-Gg: AYBFou0sS9W1yqD0c5KobLn/3QtsEfsbM5PxKNsSHikYck+k5H9RtZxg34WR9onNe4g
 TXQ61C3dCtBkgMFy11P5SwUZMWQTbnpvh9e453lWOqIrgId3KGTMyYBBrFHWOnWTctt+gL2IiRY
 tKSGryLPMHyG94TqD3bty1VJU49i7yjsMAa9A/CSPqeEcD9a6oBNp6OVMcQHIqMCfvKIhIbU/Z6
 CpDEuAiHsnod9K7Xun2+TLAZPFNVQujHZUpR1DBEIQD0h/MkzHdzsLDVZ8Ljd9NwI090wYmV+3A
 1FZrFuWDH2ABoPHftR60wfD31lcEsivoN4l+BLolYkzF8dbQsKRKshMe+kV3zCRdWw==
X-Received: by 2002:a05:6402:378e:b0:6aa:9284:9a99 with SMTP id
 4fb4d7f45d1cf-6af9e022bb4mr4794595a12.6.1791034908697; Sat, 03 Oct 2026
 06:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:13 +0100
X-Gm-Features: AclHuK_pvA6ATXGfUIBwmHpMf03DYfMTk2Ve8goVPlQJbnAol-zAemefB2tWdK8
Message-ID: <CAFLszTjYA8J4V1mEOAe9_0Wdv66y4iawoZWfbaOPMPteNXooyw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] sandbox: spl: Enable zstd
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> sandbox: spl: Enable zstd
>
> Nothing in the tree had SPL_ZSTD set, so nothing noticed that it could
> not link. Turn it on where the SPL FIT loader is exercised, so a build
> says so next time.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> configs/sandbox_spl_defconfig | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
> @@ -230,6 +230,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
>  CONFIG_ZSTD=y
>  CONFIG_SPL_LZMA=y
> +CONFIG_SPL_ZSTD=y

I built sandbox_spl with this and it does what the commit message
says: zstd and xxhash end up in the SPL image via image_decomp() and
the SPL tests still pass.

But this is only a link test. Nothing actually runs zstd_decompress()
in SPL, so the 94KB workspace allocation and the SPL_ZSTD_LIB_MINIFY
build are not exercised, and zstd is the main point of this series.
The previous patch already has create_fit() taking a compression name,
with image_compression() choosing it, so please can you add
FIT_INTERNAL_ZSTD and FIT_EXTERNAL_ZSTD cases with a canned blob, as
is done for lzma_compressed? That would also check the xxhash linkage
at runtime. You would need image_supported() to check CONFIG_SPL_ZSTD
for those, and do_spl_test_load() to pick the blob by type rather than
assuming LZMA.

That could go in this patch, or a following one.

Regards,
Simon
