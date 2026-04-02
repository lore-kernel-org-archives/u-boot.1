Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5E91112249
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8A1840F5;
	Thu,  2 Apr 2026 02:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elPjdq0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BA58416F; Thu,  2 Apr 2026 02:18:00 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9872D83CE3
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 02:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9910707d82so40214366b.1
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 01 Apr 2026 17:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089078; cv=none;
 d=google.com; s=arc-20240605;
 b=H3tmqQQOzxCifh13pEmqpb4FuPaj2Isg7nj9LHGF2Xj+ASanqppESyTWYw4IH5/F79
 d6P0kz4sGKVPWLNv7V6OlqkGtCqB480STlLundB3ed1d80TXQiDUoa9CRsNvJ04LHh46
 25HKP9soN5+dGMacM8/+0eorKRV4DpVPD2iHPsjT+KAVBjOn20DL/AFJRK0aAZ5lBKzm
 lpBnhUM4RUDI5dKNK1vX0J/vl6aH2X+ICp7xkBuIPVm0aHqqI+2kGew9+vITtqSLKO1Q
 skzkLaJzSPxDa10har+QG65PfUigR8Li5HCVbGC8UA/qo2D8uhQicL6rsFcYraNU7Dm+
 dXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OUMIfeona1TTCBWbByrq/U/J+Qx8tMtqlGlCd174DuM=;
 fh=9TDulO0I6MI9vfeA1WHTiIGUZyP1e5TeVuLgfg0Zzlw=;
 b=bKj1wxZJ44llKGr95BVc5HC1EmtEfvgVcnTYZZrVRoF5D3CbL/BNSIb2UhWdoOYMKf
 lcIMr45tk2TMpdaVVJExmnsRcdz/oL23pR9i0mUgLpQB6Oj95p1WhY7dCSWc8ynDGQkg
 WNAq9v7fJ5WI4m3oidqglyhRlpZ0y66Jjr194XmbhJVFUEtwC9tGpg8jqT5rMzYzFiPm
 kdYwStN01kau15+QKKkGHEnpFYqhf7jdRXJdhpU43iOpeC2tVh4sKKYE9L2v+zoyqJU2
 VNsKTSa584l/biXKISzfQY0mnvbqURrTeGSDI+Ji7XlvCpoiYg6f85xULTSTzNpCULhR
 CV6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775089078; x=1775693878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OUMIfeona1TTCBWbByrq/U/J+Qx8tMtqlGlCd174DuM=;
 b=elPjdq0emHOUpUTye1kCCB1t5Cu8Z8o+KCHyqyCB/KXTj64oJ7PLwhOZe1fTf/90aM
 izKhkY+MiseVv011bFJUIngwTO+B8fyUFE9iWeuLqfM6S8HfS37Agc19VxpZ5AaPbamn
 BvZ+QYRUnXODjUuIkiEjPsb+blS9puPCa3PyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775089078; x=1775693878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUMIfeona1TTCBWbByrq/U/J+Qx8tMtqlGlCd174DuM=;
 b=AtKlbrn3d/VICkf1LC3sHIgZno+W3t3VfDkj+iV2q74eK7oqDlNtrrgBOLBwuo3CrX
 rk+QCaKBEHmZ90CBw/RJenVYY1MDMa9ti03v32w0oeslz8B41ZZ7Sy8vJga3+ylSnWUb
 qZfvfyoV/Kfr+H/RwDh8KY5KDJ7gAZAnhQL0qNbGZQB9cY0u/szCEPgV6Y/Ip82sEHzl
 Uyw3bW2v2Qrxuz1AltK4a9xdMTRhW0i9+sFcArta1/CtIErEiViCzePVLwslRqB8qoCP
 W0mM2FALCwQzLciGmXZNLJTzyi6nwOIEmsdYky/MxcWjCuQW1VQvATXMWnkfnGe7n9Lu
 /+qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFQQMHr86nhdAAGmZa1ZLARMo/1SuoNCWLGHWGcOZnCfFjHCGE2BwvqrC1QVzsW63t5sR61jY=@lists.denx.de
X-Gm-Message-State: AOJu0YxcebS3yvuEoFESaaR8QiioqoVcFfTKv92WagoT/FUxKYB/o/Sw
 U1gifqvlla2V8Sy9Oz3W24ZTIPLIxiV80vP7tLbfQrrC/kIyMEx4L7TGda4AcSx2/F/KP4UqjtT
 kW4+Y28vEqxJ1+0uiSabo7bSSjMwKb3RXmTqyMrLz
X-Gm-Gg: ATEYQzwKhqRHgUF73ojY+p3MuPnjKWtFcxB9c3RPQ7WbeP9+BMxfgoRnnEjN/HkzBXB
 h9IC39YexCQVOoQhS++gkNLVPTxfMxqR90tF5sv/ylGTehoODdf8ypmsFUOcKwTSzrR2wYQ7UVF
 hofOCLbYlame6y68ye+pK3eLuUgE3nXsrOPf3QvVFHSLJizQp4aT8qOTPUcrJH3uM4rIL3RbFzg
 iwmJoQYg7f1XTgW49EO0DYrzUxORTPlPa8yRQgLh1BGSc3xxwFhfwYSlkV6mIUt7k9qZgZLfOq1
 aq3BWQ==
X-Received: by 2002:a17:906:39cb:b0:b98:9da:4d94 with SMTP id
 a640c23a62f3a-b9c13ca1a20mr311890266b.48.1775089077985; Wed, 01 Apr 2026
 17:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260401153525.1541415-1-yan.wang@softathome.com>
 <20260401153525.1541415-3-yan.wang@softathome.com>
In-Reply-To: <20260401153525.1541415-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 20:17:44 -0400
X-Gm-Features: AQROBzDXvXjuzc0u3kN5N4AOEEIZDMg82yPbvAdCZWbbikUNlsaP2JoSI96pyvg
Message-ID: <CAFLszTh00RBQfxwubQL_SpDCnBhLrkNMWUjsQ_7dCmZd03xBUQ@mail.gmail.com>
Subject: Re: [3/3] binman: etype: collection: Set build_done on the referenced
 entries
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, 
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de, 
 u-boot@lists.denx.de
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

Hi Yan,

On 2026-04-01T15:35:23, yan wang <yan.wang@softathome.com> wrote:
> binman: etype: collection: Set build_done on the referenced entries
> binman: etype: collection: Set build_done on the referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Resolve each phandle to its Entry and mark
> it with build_done to avoid rebuilding the same entry data multiple
> times.
>
> This is important for certain cases where rebuilding may change
> the data content, e.g. due to timestamp or random IVs.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>

> diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
> @@ -51,6 +51,14 @@ class Entry_collection(Entry):
> +            # Mark referenced entries as build_done to avoid rebuilding
> +            node = self.section._node.GetFdt().LookupPhandle(entry_phandle)
> +            if node:
> +                entry = self.section.FindEntryByNode(node)
> +                if entry:
> +                    entry.build_done = True

This duplicates the phandle lookup that GetContentsByPhandle() already
performs. GetContentsByPhandle() calls LookupPhandle() and
FindEntryByNode(), and then you repeat those same calls here.

Also, GetContentsByPhandle() raises an exception if node or entry is
not found, so the conditional checks here would never evaluate to
false after a successful call returns entry_data.

Please can you refactor this to avoid the duplicate lookup? One option
is to have GetContentsByPhandle() return the entry as well as the
data, or set build_done itself. What do you think?

Regards,
Simon
