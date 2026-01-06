Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5746CE9D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430A783FAF;
	Tue,  6 Jan 2026 17:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TrO/NjlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8CD83FBC; Tue,  6 Jan 2026 17:22:39 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ABC283F9B
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8052725de4so162573466b.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716557; x=1768321357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=unhQvvqoEfZ5gRyqDk/2gspSg6Eca6XvJTVDLWOCn7A=;
 b=TrO/NjlDOFLnnVfmeiM1oRwnyCvJajhORwMrTuCzEPD4Ar+R5EEL+Bt0fgSUHqxA/8
 RSlk/bEB3uqtqrBgJLy+FVMGV3DJwUh/MazRYlv9FwRHbOHf7XDehQcfPWnCnPcwvZII
 qM1jrREPxCdPb3GCeP6Z24hlOLmEYDjwWLuec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716557; x=1768321357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unhQvvqoEfZ5gRyqDk/2gspSg6Eca6XvJTVDLWOCn7A=;
 b=hmXf1zyQFj1rZdxJicVhRq1DcmidnH6+CAQfaN6Z4zj1txahlrLLleptkaBaTEx1os
 kkx2coiQo35ebXapajqivT/nGLPyVojBhMJhsm86FUROymuFxd85thRItcbiJoblqAey
 v9719qgbBN8eA/IYUDiEzKXmImzXQtBvWus2iHL9YEh/vYJFNm+zbtfnmxRHICGMYcyP
 eTm7ww634s8rMc0ijPKuBDsFas5cjmQyeOd2sA6RwzMNBKesdfJ4IWF9oTRq2ZdQW4Qk
 KpmHaaZD6iFTIdO4vG/urNIsjkIFSuc5JE0oCxTcKccq+3cQsB87jRvuVEhH1a6oYBFE
 yomw==
X-Gm-Message-State: AOJu0YwEHt9JhC4rpz+IuKa8V+rgetju22u1jBy0oDYucGSuHoJVWWJe
 QmPIgYgILoFZpb79nZCKDODcOZhsqz8NHkPSxXD5eIBpuaYRKS1nFbbuT5i6wAvJjmWL9Z/p4hV
 jBtzHpehkO7xs25Gkzy4p5jm3LdvUeK61YUyr0liq
X-Gm-Gg: AY/fxX4W9YzTACWMXc2ZryxLUE/vx54idW5osYtha3w1T6oacc8fjO/gy3LJ9FHFKr3
 tDP97jBuDoayrwa7QpsBCHQpdaQGyM9931+0spI9ThOiRtZlLUAl5uH+jD5UVh04hNXzcVfv1Nw
 1rw6pHrso51ZOIABl45kys5jjKNw56+1d1oxyc2E1nd67tdUY++6V8ZZ2fUvpdpUVCpU5mMRG5A
 MCICY1LSFpLS0ehyurTX3mgEnnS7dNiBWo7f6IO+Nb/iIFf38PpBKKDD6N9B6Md2VL7PA==
X-Google-Smtp-Source: AGHT+IEjY5uOgg71t0bGGlZhzWu9dCyoDgtvhBZ2Rx/RiZiMvLeTyAtwE6qOz+XCwuF5QZv3QeS7VErYO928drXIJY8=
X-Received: by 2002:a17:907:3f16:b0:b83:3716:ca69 with SMTP id
 a640c23a62f3a-b8426c820b9mr372042966b.21.1767716557511; Tue, 06 Jan 2026
 08:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
 <20260106111034.889964-3-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260106111034.889964-3-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:18 -0700
X-Gm-Features: AQt7F2r157J1yexlUhL3E-Bbk2RnnUI-rEth_ieUsiPqycfKBXiAqcYx7VkadQ8
Message-ID: <CAFLszTi6bm8uvQhBy6TGTW9qMHdHmxx=rdVyygO0CKfBQynkGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binman: Accept pkcs11 URI tokens for capsule
 updates
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, trini@konsulko.com
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

On Tue, 6 Jan 2026 at 04:11, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> With pkcs11 support in mkeficapsule we can now accept URI
> tokens and not only files.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/etype/efi_capsule.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
