Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77D5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C748870B7;
	Wed, 20 Dec 2023 05:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mpQ9yRst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B5687630; Wed, 20 Dec 2023 05:46:45 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C88D87527
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a235eb41251so370855066b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047602; x=1703652402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VhIOQNjmNnws5NLFK6NzKqIF62YFshtAD6147f39W4I=;
 b=mpQ9yRstPoT6g791Hks2NLzSC3HkpWQF+E7R4Bg6vsIxKoeACid0naF26xp2YwD5ip
 fTP6+CStliIe3MnWEV+JP+Hs9DBO9S9B/AolUlN7mQEdBAWw6afRv6tlInO/geeYMV8H
 P4R35Zc6qFm0urIXyYHQQ9IrIeNFBY0dV0Chw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047602; x=1703652402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VhIOQNjmNnws5NLFK6NzKqIF62YFshtAD6147f39W4I=;
 b=TpeH2Ka6aWD+uxgkcjTnxpdOE2E69sUQPFDETS7bss4GWgVHyMxVwlgoKECk2Db4JI
 V1YvgS5/ZeM/O7I4nQ8JFbBjRotwImybnJizvWgcLr5b6dZjZwau4QUuqME3Xmgjzqx6
 tMnQCpnQ9UXzIDAiC8Pqsu5sa1wWi+/At+woDazlCzpL8Iu7fql6m2Gbmi7PCCursuCM
 wQlLUbgtX1v/2nRSMdfImPf4cohbTwfugK1dpq/TXIwfAHqYhaiSixDPiebPMWj9e5aR
 tBOPCRWpJfxxr1jTGtFgsfMsV4c6MElosgosFwsz4EAH3zpE1xyRN0vu9Hl60jbecX/H
 Vj9A==
X-Gm-Message-State: AOJu0YyIG/r1nCVrHAB42u4t3PIf8hV+QU16AW8kr94YYDqfypI82SHv
 sNd6V1TIWnfSuW1zXEOHk8XiqE33/LyqtgfsV4+7eA==
X-Google-Smtp-Source: AGHT+IFjgrCjMKMPR7DckXiZVNd1hDL3HL80zDzNIAB0q3ITg2+0859Qtt7ogqx+79CJo9NMltB/9akq4pEJ2iWqNjQ=
X-Received: by 2002:a17:907:c9a2:b0:a23:3629:f7b9 with SMTP id
 uj34-20020a170907c9a200b00a233629f7b9mr1582602ejc.90.1703047602586; Tue, 19
 Dec 2023 20:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:30 -0700
Message-ID: <CAPnjgZ303PP1B0zwiybV=m72bu2A7eQokg5GvW4XCE3Jc_y34w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] arm: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Tue, 19 Dec 2023 at 08:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         let tables in global data depend on CONFIG_(SPL_)ACPI
> v2:
>         new patch
> ---
>  arch/arm/include/asm/global_data.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
