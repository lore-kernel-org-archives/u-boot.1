Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E9E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63252869C8;
	Sat,  7 Oct 2023 22:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vfzM0gsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D836D86D61; Sat,  7 Oct 2023 22:19:11 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDD2869C8
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so332745366b.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696709947; x=1697314747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zArO69o+8CfMqYbQMdZDO9gO3I+1xCAd6we+462qm5Q=;
 b=vfzM0gsAnU44QBvZG5Nl5SEDVqJ5PAIwxZy99X/LlpWkBN1eLhANIyabC6Zh7u7E/L
 Zz+FPPv6OUGlaSpqkYZ2BtowrLfDk7BplwdntSfTyZSVbBJDrFLushzuAuQcfSRiVUId
 WwXREGAtYQw2oYSZ8048WQhFUG3tgMHDzn4/xtpd4Gbc8TdJ6DTBz9MqNZ+JPCMmmMvF
 OdrjiXr+D3HQRq/tUDo5oT0kgm8bp2DZkTV05HNrkUfrWagvkbajLr+uIiN3KzrQ0ZO/
 eF5xMUEGKihBX1D0iQZvUuDFspOwLg7X0lktDvcSAbcWnkA+kqUTBVT2AV6MziWdTvYu
 Lsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696709947; x=1697314747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zArO69o+8CfMqYbQMdZDO9gO3I+1xCAd6we+462qm5Q=;
 b=fLf0skEHBU8KOA7hh+bNHdHF2HOivSrJiPXWxbDRb18vqil4VtBwfYcq/zr+OWJDaW
 DSyrYDZTyDl19lkoGE0QZalcoRpidcz04fMTus11U0q4LU9WcI/+QveuvqPo7cjw3rYH
 +U4MAfEDBADJ74P6s8u+RR2LBgJHMmqYdNt/bRPpW6dr5SrC9i9WYD+m/J/X/YtDSxh4
 JBcPghh6RBOmNqRjIyM3k9A20jQa+6TZtHDSKlcEf4WohWzwZdsdbLDnT/nWLIEeZhXT
 yaV0L2MkZYAkdgS4JedKZDSzbkeh8UOUvriL8pDs8py+tYqZDUVIrCAPmRMkT/wy2Vom
 HHcA==
X-Gm-Message-State: AOJu0YxYt02ZU3+PvyGWV6k7ZRq7g6NMaRQDWNTrllnla9Pq4gOXKmjy
 oGLTaPMms7cxY/kmDYOZnBFoRMnCIgN/QqbkyrAdKg==
X-Google-Smtp-Source: AGHT+IEa165opOX0w6ngSw7364AxtAm64M57vx40/jct5xfTm3FijftJ3/pJ3ZbYpDpiQYLipSlzoxvEtnHwQnOiVH8=
X-Received: by 2002:a17:907:2711:b0:9b2:6c58:87a2 with SMTP id
 w17-20020a170907271100b009b26c5887a2mr9971336ejk.29.1696709946842; Sat, 07
 Oct 2023 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231007191308.2222470-1-trini@konsulko.com>
In-Reply-To: <20231007191308.2222470-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Sat, 7 Oct 2023 14:18:54 -0600
Message-ID: <CAPnjgZ3hsaTzPLbx4h+C3PbfF1oNfh6pOVO9eykphGboEnkjgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] command.h: Add a U_BOOT_LONGHELP macro
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sat, 7 Oct 2023 at 13:13, Tom Rini <trini@konsulko.com> wrote:
>
> In order to be able to discard unused long help texts without further
> linker lists, add a macro for defining the long help messages which uses
> __maybe_unused.  This allows us to discard them as unreferenced as part
> of the link.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/command.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
