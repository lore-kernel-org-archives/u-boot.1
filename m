Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFE1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 00:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C3884A3C;
	Mon, 13 Jul 2026 02:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GKT3eoco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD5684A0F; Mon, 13 Jul 2026 02:19:22 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A6B84A4B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 02:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69c5f6f7a40so2477282a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 17:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783901960; cv=none;
 d=google.com; s=arc-20260327;
 b=f1OeSpsOITONaraR6zgUzxuGAQwxg1NkPZ26qRCstV40j2YfNbVNtfMwScxio4nJsf
 VjR3uDwCGtQFnk1MN54is2oi4xNISfX6LmZEwlwECgBtOZaBRQJr2oX1XGEczwjMBL+o
 SHxnVO+yK/2VEpxcapkPrzZzdAqb+HJaWvnHhIf5jdGZrRai059m7dSVoUghArFpG7ks
 xq4ffRffR+ZZXzaHNnRGeo8ThUDCK0Jio8tjF4b9iEuNdGf6VUmn7OJtWHASpmW+vqSW
 hodmu5EJpQnHHWDCCvjE1S5H3I0VcuBlKusbICa3hTqxqUQDbyyE3pMDVH/auVivdknv
 wkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FccGbho/1X/zr+s5nJkKQEfkI8dZO1pA+hkLXV6RLsc=;
 fh=EEQIRgfuMtwQmXdjfdH5RZ1j5rBzQhaEFZ9mu3M+W/M=;
 b=SiOnSWau+sAwU7XvmWRR8ykAeyFSErsZxeTbAXeRD0/7D5hF+QavmJizw8B8l+SN36
 v6yz0dMSvLjqZlOt3WCNs7gSSRM7zk4k/AKBhvZYvnR8CRSXomAG0woCNi082NV5B9VX
 02417xEP30z930vadf1xVBEqYGxw6qYFU27g/6QCT9a3qbZpoS7Ee874O5dVx/WpCn47
 VMoVpKJ72+3P16Pf0loT/4LCTYMeIg5vZY8rFgH9u14ysc/HOI4t5218OgTH918RGF3l
 KV1BoIOtcp/a8+JwoRSjqZPsEOp4XzdxLMeIBKPD5jcGNCD2QVwbBYChBTl3cJzjXm7u
 w8YQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783901960; x=1784506760; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FccGbho/1X/zr+s5nJkKQEfkI8dZO1pA+hkLXV6RLsc=;
 b=GKT3eocozNTU6HbSFWeruyHY/NOmlW7bB1JD5lCX69UVL0bSIEaor718x9Jv0zDHXB
 qlw5+f7lhbE6NEwMJlosnYwwOmn3Q6otgI7fJlFSP0OYPYiFOM5Y9+7MzO0MaYOxGSMm
 DEtD3RYJ/z+fNQ/agBAclyRPgl+dIWbsPG6vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783901960; x=1784506760;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FccGbho/1X/zr+s5nJkKQEfkI8dZO1pA+hkLXV6RLsc=;
 b=cSEXp5tu42pgrUbn23OhGneCCQpMYON6z5kthO3ViA3xnvwBhVZfdnXLwnZE5pvGCf
 hcYOR6zlK/52hbyOOnp9a1SABWwfJZ/6d78A0kYhCBCpNMW4OQupGFOT0KSplfytTsvL
 6P7Tge36dlIhthTJYTDAF1gScUagjHaoneGYtsfYU7K0fPap4vF/VubRzCneEP6bQvU+
 LCqD0x/gzqAua0YhHNzPeYGuFjwnAvOpD81er2ADXWSa9opCNe4a5QhBgFhjynp/F9/d
 V+hTXzpCByJZ68h8WiT5TsY/2XpwGVfpKgv+XtAWGQKEE2k9JSeASz+EglMN/fEoKhxF
 CiRA==
X-Gm-Message-State: AOJu0Yyr+WdY2q96ah2JF8pd6/BxMsiDSRgguIf1KuO8yIZ6ustPMh6l
 AzmrwoiC24SpsZxRWVvHQ0wWiVszL6v69Dq6jywlwqkgFnqVA2aVKKe+whL95FwO2TTATNKGSLm
 U1gM76cqB2w2k80rWghGXD+VZS1J6mRaa83nRcf0d
X-Gm-Gg: AfdE7cmPB6MMPq5QpWbRD79NZhri+BFiONNQKSqMPS7s+H4lZU5NWktTgEeMF4wj5fl
 QbK38gTC6ArX+7lzHROjeZsSSPf7tBlM8QBarykN0TnFVnXgFRUYUlJOpnXqg+Ydgku+bkxSOKK
 4+YU0MDgYgpPwRVwRGILy2pLiWWHbuAnqXOPC5/JKVTVofiqVbTIE/CO3YS5TGL0tqoeiHeUxOX
 x6YPyGHEStdVvj6waz6EgjC2gtUKrsjYq1CPdzn90UriDrCNkZZxBtmMnHFEQGHtzyfyUjnbXBE
 rfodJQ==
X-Received: by 2002:a05:6402:448b:b0:69a:596f:ba0d with SMTP id
 4fb4d7f45d1cf-69c5f254768mr3053902a12.33.1783901960172; Sun, 12 Jul 2026
 17:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-3-8b3bd4d265ef@cherry.de>
In-Reply-To: <20260708-other-contrib-v1-3-8b3bd4d265ef@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 18:19:07 -0600
X-Gm-Features: AUfX_mzXDBpWhxtNelLU51OTTcg-dEIgPsuc0I2wAXJxP90VB2TaSWEjWC37e1k
Message-ID: <CAFLszTjySPoiJf5vNHw_BrX+aQttQu6b4NfEkm31ZvQYpb2ngA@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: CONTRIBUTE: explicitly list tests and
 documentation as welcome contributions
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tony Dinh <mibodhi@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-07-08T17:21:12, Quentin Schulz <foss+uboot@0leil.net> wrote:
> doc: CONTRIBUTE: explicitly list tests and documentation as welcome contributions
>
> We don't have too many people looking at those at the moment, so having
> people getting into the project by adding tests or documentation is I
> believe a good thing so let's encourage those specific contributions.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> doc/CONTRIBUTE.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
