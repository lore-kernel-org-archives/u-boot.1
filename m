Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84EDE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86DBE8718A;
	Mon,  2 Oct 2023 03:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="IjnpMWJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8782870C4; Mon,  2 Oct 2023 03:22:16 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5458E87104
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a9cd066db5so2299589766b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UL3+4vJeqT3SfC9e13/d9XDF7ZepK7hJJgTJ7z+oJqM=;
 b=IjnpMWJVGxtyFEbHi+eSux9jW/pKALC7/G9qNyT5AML20s/4rThacX48VPBv21kxea
 KsdruEc2DXdBL4R3f9YLZdHDXkRbm6qZ/9B0wqregQ852SDxKss9NoRMKd9xK2+3oX5w
 3Adg1s491F58kaLbVPFtmpLwHY7maWZa/qAE/nQrRYFypb5Ms7q7ORt1gW4at3KcVLwB
 NQk+yZoGJBlw9OJS5zVcVqestQ4yn1tXlT84uz4sienrJXbF8hlQhlZZbMGYJ8ztA0qo
 7Q7hdhLJE+gO60iBAxzFYU294rrtBbYxb/+5MM+AChWgs2R1W/O3tGVi2qeVPXBc/mcT
 g7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UL3+4vJeqT3SfC9e13/d9XDF7ZepK7hJJgTJ7z+oJqM=;
 b=c+7clK5+oBBJl596QTYlR7m2fsKHx/6cgHlahJSlAKDbz3oMB2YCK+tggtzp8yq4Cw
 n0RMtVAtPjygNFKA1TnFaUIXMKWEsDsczrGWRo4ENS58TsLFxirLDr2w00qsWEUaE6Xi
 BRtgwTfNra1J4nwCZyTka1ykLYgdB6xDtk8DkEnxMS4z2ry59fdV+hrxaRoHzkQq1KAD
 1BnEIc3Cavh6/BsmFKLxXqvkHWvO992ODYhCpi3ThheYZT0zTqsF1Lr4Z1bN9TIAfgjf
 G5/NeDWsH2zRudw6/v+/k+DtsrosiIOpFXxpw4p486w0U30HACrLpz+OR2LmaOtCDj0H
 qibQ==
X-Gm-Message-State: AOJu0Yx7RKwdZ6IMWmafZ7BUb9813qvIFFBkE5FzslyplXGt3ObegY2s
 nR90eJsRP58p/p6zXwyxNViyqqpZ9Olr1Wwxpk6P/Q==
X-Google-Smtp-Source: AGHT+IGBkSvqyUdTNIttdfYWjJrrAKyRR6OcIP9r1okW3ivRk5NvK51k8lkrB4VOMhQMVooSFGBSq6o6kg5ATFI6Vhc=
X-Received: by 2002:a17:906:cc2:b0:9ad:a59f:331a with SMTP id
 l2-20020a1709060cc200b009ada59f331amr8455434ejh.57.1696209723722; Sun, 01 Oct
 2023 18:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-9-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-9-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:44 -0600
Message-ID: <CAPnjgZ0zz49XxW7hREZeQLxzL3TOZLUkAJ-18pn27vJGfqKnDg@mail.gmail.com>
Subject: Re: [PATCHv10 08/15] net/lwip: implement wget cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Tue, 26 Sept 2023 at 03:45, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> U-Boot recently got support for an alternative network stack using LWIP.
> Replace wget command with the LWIP variant while keeping the output and
> error messages identical.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  include/net/lwip.h             |  14 +++++
>  net/lwip/Makefile              |   1 +
>  net/lwip/apps/http/Makefile    |   6 ++
>  net/lwip/apps/http/lwip-wget.c | 105 +++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 net/lwip/apps/http/Makefile
>  create mode 100644 net/lwip/apps/http/lwip-wget.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
