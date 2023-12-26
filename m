Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DDEC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414568787E;
	Tue, 26 Dec 2023 10:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CcQ0bHfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA6E8788E; Tue, 26 Dec 2023 10:47:14 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B89878C6
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9bc8939d0so195347b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584028; x=1704188828; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lclzigs+gF0EuF+Lo0i6BSxeWb77HSahIlrjVL7ChU=;
 b=CcQ0bHfUcRhLxvoVoJowQvobZu6p2z6Oyv+oTNtBuIDoMdtWXQSlWaZ7AtSbqHjd+j
 doOLDU6YWvKMzpLS3JZxsCALYlVF74NVprQVrQLphrem+AP5X3aSJ2VHl8qlWWUWHPoz
 fAKdfPN1+MnclcWZpgjwxW8jfEa3r55qhwYfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584028; x=1704188828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lclzigs+gF0EuF+Lo0i6BSxeWb77HSahIlrjVL7ChU=;
 b=OOiqQK7cmpJUhUCSdCXQYN323hHPNQB9OYp0YQZXNKkBp/vc5+Lwd+Y/7f6mo/E8nP
 oYzHLWYft1296HS01azV4kqNs4hEGLZAG/tcqb0qAc97EU4t+M7JFvJimvRzGlBopK7d
 g0GxmaSD0G+Ax9ex5/EY5/h2eLNknJo//i6ls7BVAsf0GE/L19cxcKs99yAiQsJG4iLr
 BLcnwn6+sUqjR7niYdfSz893WroTkGm+/p+xQihgpjRtymAmy/QD2nm194JXaP+f2MB6
 gIr3AQ9NgpyMTl4IHQCGHskRDyASEd9h/nvmh3La3tekReYnLHCNiOmcuJ0fXdxqHthr
 6lpw==
X-Gm-Message-State: AOJu0YyzNxRyogwQ+Sf4kD2lraD61yA2EIPs5jm5FFlbwTrnufMAlT/1
 0GHLDhRI5ok28XWTe1/yJp3BHpbfGUtmoFg871y9rgirvOU2le2d/fbDrUZA/g==
X-Google-Smtp-Source: AGHT+IHUVG9Oobq0gKmrRk25hULuJq0n9iaHZrGC25TdVjoOPWoUY1GxMybLrK7T8BxwYII6F8mA82MatKCM7YWV40g=
X-Received: by 2002:a05:6a00:1791:b0:6d9:d770:bb70 with SMTP id
 s17-20020a056a00179100b006d9d770bb70mr280983pfg.33.1703584028267; Tue, 26 Dec
 2023 01:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20231222201617.79950-1-xypron.glpk@gmx.de>
In-Reply-To: <20231222201617.79950-1-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:56 +0000
Message-ID: <CAFLszThfWcXK25bQjwJgUA=_1+DaBZNw3y=QNQiwB7XRQBNr+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: type2: contained object handles
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 22, 2023 at 8:21=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> The type 2 structure must include information about the contained objects=
.
> It is fine to set the number of contained object handles to 0.
>
> Add the missing field.
>
> Fixes: 721e992a8af5 ("x86: Add SMBIOS table support")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  include/smbios.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index e601283d29..88c19ae062 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -139,6 +139,7 @@ struct __packed smbios_type2 {
>         u8 chassis_location;
>         u16 chassis_handle;
>         u8 board_type;
> +       u8 number_contained_objects;

num_contained_objs would be shorter

Reviewed-by: Simon Glass <sjg@chromium.org>


>         char eos[SMBIOS_STRUCT_EOS_BYTES];
>  };
>
> --
> 2.43.0
>
