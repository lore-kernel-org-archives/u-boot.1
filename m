Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946EE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352C487481;
	Mon,  2 Oct 2023 03:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="IBr5xUKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC2887104; Mon,  2 Oct 2023 03:22:26 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67755871C4
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso1592433566b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209728; x=1696814528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U+rhJg4gO1CW9PReZYdGjpqq+WCQ/vxkzXCzXit5gQ4=;
 b=IBr5xUKB5IDQSXYiqf8IPQVA5IurgNoQjDvsAeu+PQOfFGHI4HdWCxZYSYr61XvfCn
 3OImU6KGcYOubCYigPLLPl1fwVIKZgVJfzCeCbrF9vJD0q3XyEtK5IFCTuuVUvdZ/wiT
 eY1/Xh4CqjxTaYBiOZPln65W3HcsmkttNkMnXclrjjw8P06l7fe7CZbrnhlmbAmBQWFD
 eIXIT/fqHq8elNCWmsdwuKs9+uLY9F0PVnEnzJI8GydKT1weGgdGhg4UQEK36PI44tbV
 tAChyTWhxyeL+eTB+kjhUu3aG8yGD2mwXRu1jwIepAnHqU+IdgA+dP5iBLFTlvFj5nvK
 dg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209728; x=1696814528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+rhJg4gO1CW9PReZYdGjpqq+WCQ/vxkzXCzXit5gQ4=;
 b=jh3Bplg4T7gCpo5jFNuip/hUql5aDxCWW8CgM10L7Ut7lgjffCEKxtPKsHXwRpfKzv
 gyIdJwBa95hlt4YNgg5+csYVM2HzJAO6uErz83/iVMlCBKIwXHIqVGpFwi4pnBxoaLZu
 u1xVmZhGLVve7X/TsVoe1rf15XwPNN/hxn8Zwk2frImvmmdds3nVOLN2VlNM7/AJoSzX
 MZyWIgnpm3yH/KSEG4MxQC+Gj0iWz56ls2uwtuhGhF9FoLeb/yHjsutD57CUJJou6NWC
 Do24KWImM5fZUsgCy4L0GmEubgUTMUJNVowsftLl9itaGx795GzrMpAxoGz2e/ETNEwu
 PZgA==
X-Gm-Message-State: AOJu0Yy936foR0mxwkked3HjSjbC88tFVHZ3yUD18FY1dJRtKBcf2sMp
 GEDx9k3bMrt3nGwERUm27OmR7zyWR1cdHnYr6diScQ==
X-Google-Smtp-Source: AGHT+IHzGZxRF/9P4lhUd1pNnc7JUfZap3HkSFEtFZiMPTnn4W4LtTQQMBWIfWtucF9Pv7CiLY5s09Cmz5aYTZmzuGY=
X-Received: by 2002:a17:907:7897:b0:9ae:64b4:18b3 with SMTP id
 ku23-20020a170907789700b009ae64b418b3mr8397103ejc.37.1696209728504; Sun, 01
 Oct 2023 18:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-13-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-13-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:46 -0600
Message-ID: <CAPnjgZ24P+Ld4uuqrhjpNfPNc_x9L3Y2Q93RfhwM=qchqPPdKw@mail.gmail.com>
Subject: Re: [PATCHv10 12/15] net/lwip: update .gitignore with lwIP
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
> ignore lwIP library code and reused files from the lwIP.
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  net/lwip/.gitignore | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 net/lwip/.gitignore

Reviewed-by: Simon Glass <sjg@chromium.org>
