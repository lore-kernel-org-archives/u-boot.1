Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D346CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDF786D6C;
	Thu, 21 Sep 2023 03:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="BIFtnel7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2A686D21; Thu, 21 Sep 2023 03:06:08 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AED86D3A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59bdad64411so5287037b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ImqS2mEcMdRiJ4Pur04wjcX45xuUiiKRsPrpeH6bt3c=;
 b=BIFtnel7ATWdmVBGQahkveDI3NHu6+gQy1soT4X99RDd+8ni/u1ssZ3tmcx1mNtcEo
 Xl7WE54R9XFbnMua71I55lW9pqpxEZvCRkjrYAVCECuEf+ijVgRYnaLSFkzocfhD4Gia
 3cDU3fP1NbAaA4wtwQepY0xz6F98WI3Wi7uJumgnah9vMqr7JwEq5dRZKSsp5TZpNvk/
 u7eN9UhvB6VU15XPNs0Fdz2c0YHYW7ZKfzezdroxRY8iS7OYUyjs4wD8WFZ/pVmJHWec
 gbiTTHhCa9AZyPUKK0t1ipMdPoE5LMNv0Pg7IGVz1vOvGNdH7egL6XctM3X+ifE8fyMU
 SCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImqS2mEcMdRiJ4Pur04wjcX45xuUiiKRsPrpeH6bt3c=;
 b=dIJF1Yfe6xaK5w7CjPxF39F3WXL3fc/t9mvbaOZYo+njsNhIk2tQ7uQ4wzu4wzmf3c
 3LsPD4HN06pVRRz59z2hFDyt8F2QtuiKnoV+v/t8CJwGD65GXn68aKFXuYH2bgNNr88h
 B1Cop3nz04FonkclrLvUX6AfdA9PXXKPPuMD0rLdkUckbzxFVxS+F6YFwAqX2u4V6Yql
 gSW8glEFKTmKaMXfw9oEPCpM+9Ri7bZ7j1n/9OL//aEW9aXfQJFL1mk0WlZ+RF81Mbgj
 YgHX4knJIxUc/3YqaECQ/3F0kCuUsNc0ryrhfCXbShxI/v25FDkh7Bz2WutQhSOyPW4b
 oaCA==
X-Gm-Message-State: AOJu0YxgAnwIJVfJ3RjE/PVSihm+WTKs9AAbDPbZUkH1XECNjbDuOkLP
 d9Q4ht4134y2MKPsce3gZvYUJH4YwC6UNo85QUSkgw==
X-Google-Smtp-Source: AGHT+IHGamS19v9qn9yLwbxmLef38HGGLAfrxFkmoEgauYeMChynGzdmSxMhrIDQRnILo3IsRYKm1UuaYuftWUqhNrQ=
X-Received: by 2002:a0d:dd4f:0:b0:55a:3ce9:dc3d with SMTP id
 g76-20020a0ddd4f000000b0055a3ce9dc3dmr4136239ywe.13.1695258357403; Wed, 20
 Sep 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911163536.20735-1-avromanov@salutedevices.com>
 <20230911163536.20735-4-avromanov@salutedevices.com>
In-Reply-To: <20230911163536.20735-4-avromanov@salutedevices.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 20 Sep 2023 19:03:19 -0600
Message-ID: <CAPnjgZ3RHoQ62XQfPAnnCSj9W0vODO=1RZ-vo=bfGY0QWHMsHw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] sandbox: dts: add meson secure monitor node
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, narmstrong@baylibre.com, 
 takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, 
 marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, 
 jh80.chung@samsung.com, paul.barker@sancloud.com, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, kernel@sberdevices.ru
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

On Mon, 11 Sept 2023 at 10:35, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> We need this to test UCLASS_SM.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  arch/sandbox/dts/test.dts | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
