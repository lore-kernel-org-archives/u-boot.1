Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C24C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C46DF80D2B;
	Sun, 27 Sep 2026 16:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOixFWvT6gQ8; Sun, 27 Sep 2026 16:46:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C1DE80E3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527584;
	b=RzQOLwaBRGsCeyQWTzdr/0jN2K34oNcsvs77SttRTs59A52XWWdUmnIqPKPpy0jfTE72
	 zlqfP3ys7KJrmFQjcWO/l3zMoB9sT4ZwUHELrH+UsfBktu4SPyG63HfXBOyqmq0XqR/+5
	 2jeFPRPbq67u7JdzPRn1Fj3gBACxtmEhmfKAsyXjT2Q1sSU54bUDOg5Y4uuyTu8LOqzaU
	 Q927SSY97rJTs19gBLMC2cxzLo9+6cot4hBvqmvZtbw/6VOySBhPuJQ4AQhM8tA41vmxX
	 c4ftvtFlb5khhcS5yw4qQurZ6O0Ii2K9FYYyHCxXPw0uT2YHbaBf8E+poCOXT/yXxvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
	b=mNQWxbShNOn04qUhlpB7qHsMbaLMlySZyLnbmtRf814XaZKkxFZR9E/fWEfoRcRfzNDE
	 RWoWQ0s2TY+mEJUYOP4a1HiClK+H1LeLMu/YUGIoaEcn97zsGZfhMBoQF5UaWCA8LHHNS
	 UWPiMkBPSyiz2OGZ0yxLXjvsCqnm4nFy831Glt8KBfvZg75bYWlJVGuF4Io+WUyszmAbu
	 qSzVety6xkW7ERVH5wFmB5xbYJTg7wgQB79gtuGRF8yil9YvSEvEXRODxnTo1ylJWwPW0
	 6aE6qOldNLEjG9XSPeGJvsO2XnCoQCPPjYojl0P+F1u6S0jmPNNyzgx92pWsiqoPwTA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527584;
	bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVYBCbi9DuH6OXcm+4I+3TvFl6gTaX/GAAQ69qi4m2h0j56DbYe6By3wGMc2WnjP9
	 Hb9/HyfRddOC5uaB7M86e0OG+1vZy7k1AZhRN+HEx6v9pUjFaHMtsPN3vcWpw39fbX
	 UTAfs34pCuEfuxqRol5zXGWWX7AmH0y2XE5HD7ILXZtcZJpLJ64Xy3Z3RmJSkorWNx
	 Q7KPLqZZyFGX56GYGKO3nmPWi0VvQWzm5L5eCeYs5FAh2M8Be5TM631fWu7QlqRm/A
	 7QCEa9nTTHkR8BleVAhsZcJ9WKd+WwBvMJyGkMD0+YycSy3VBxMiX/Spt+SpcsPIb7
	 26FBr6hQjVMrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C1DE80E3E;
	Sun, 27 Sep 2026 16:46:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC40D3D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FC4760611
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwmA5SJaXtRo for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:46:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 926E5605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527582;
 b=Zhrlqlaod/rBO83LrvJ8DKLgyRqVY4C3SOAHWY23VWfLHwyajBmmsS6yY2qy+d3IcCRG
 uzEZHAsfm4j3gDVW4bRLkG4G/G+BssZjhjHbv5WANO4KANHDCd/0NPFVipcVIU3QKgThF
 pzwDd+/9EfcIaOVsZzAL4qX7E6avItrQARgaXczcFdFHtaXzvnPecMrWmxH8ChsI656dT
 S/XqfMPf8oHetAUaatJStYLgt+IYi29K84v2pVYwbuwmuX3aSQY/dDFHeoEX3Pz+FRVnb
 oG2ZL4oiHzDNkIGehUixcI4hQGmCmlVyp34SH84pEMy/jNzKgIZvl4Cn1uX5laeL0fQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
 b=HtHqlI2ft0X7/pF/zYqT8NgEznWMLwunHe7+hRnRfgnGq3HjdwEjCEj03vYMgpOijKQp
 UGf7TseO2S8F/w648mBRVdS+cA7Kdap6xrsoS2pVyVa/9N4rWKjLqKBAfctYxPoeZcvaK
 kN9Weem7cesNygiGO5AHpWP5BZU5mSHAD6Lfa7bwHfMH2f76xJ2yIKIWogLHnDQ4FpqRL
 NtAw/5sptUX8IDYLhkepoobwlh5WbvRHRlv1YWNjYENr8xHGcEVKHfptWAmaq7CUkCBno
 FPmaQZElNVnRZYLhbOfxVGXkXEHZCxdA+Ie3PIISvZ+/6E7gfbHLun5NX6XmQx/MxHw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iB6g6el8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iB6g6el8
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 926E5605E4
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:46:21 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac62c88c7cso1187619a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527579; cv=none;
 d=google.com; s=arc-20260327;
 b=Lf4S9ME9gmUQIHHpFJSI95BybJS3lf+gP2NK1SJiDCIXSJRLuAUCAmoJ9J9fY+DMST
 rGODwwhkHplHME9XemticQA3mm/IqdWG/GEZfxVbILA0CX2ytFxxOansZPiVrQt9pMJA
 OChmWcZzPHzjAdZvSNnIqtPMFLjxPTMxVkNCF4zgU/fdWPhmuN9s1qdvGrQm+LBoX75v
 hxDSAxDkZ4IjsIigwrkxcFP3fCWNdmhDX+piS+EF1VA/HgvlVxVnoj7ek7V3qQJ2+Sy8
 A9PzFze+V5k3dIRVx93KM92EzwwDwzHPH4rLv0+RGUtvtPe9ev9Dt6z+E59wNDbOGLfB
 dY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
 fh=wfL3Xsnfqx5o3IbejQXruFwm0C8wD/XS/JZItac1c+I=;
 b=YHBwqdvUQ32HWbKrhWOfLGGZxLkKJ8Vcy1LMX5u80OXHphI7oWznlkubuqrUfi96w+
 qiPGf8vIG8Oq3sTgrh1T0DMQ/srkIj9udQEysD6dtlny09foKZX6TU0RUAQKS2y5i8e7
 0rHtBI2NRpN1daqGMEQ0Q8LI62Vtw4kXXFbOidk3QZLtWBoF6Yu0XuGmVUtuVNk3SQy/
 CIrsR8t8i9C0veYxSZsX0AH+zTHYQxsealqgx1OP4lRuFsoZzyjN8cOc1uYOtFIFt9rr
 O9vUfjqsj+vJPHe+kH5FBtt72jYOEo8M8pEURl9m0eOKN2zQd6wu+pS0z6Gllf8A8g6h
 UNbg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527579; x=1791132379;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
 b=iB6g6el8fJySBUl0kNmUaNRrHhid+WXLYqBdzEXIbDrEKsgPe728GphbeFiyqaQRas
 pthez24MvnD8PIDj2Z4piAd6DvJVMnDYiy/LJizmwg9t1CJvfp34TqXlYZGot9gasQ2M
 2nMntHCdzAR4D3ah0ToJvSp6j/DufhfDpYL8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527579; x=1791132379;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6//JKaQraIR6nvv+Jj+CVArGRzf4ebkgEG0+weQ3zWY=;
 b=dnanj4WEXfBwGOO6FtmIpYlxiQkEJXm+dDgphmJeP3KAk0D28KhIeAABpJF+qn3VVt
 dOEANjRZUlC70oTclkIgzpNiqvDLG7YU+ZIMLy+bEF07e3IOqs2XeDL7YDNdqk3/nQsw
 pMwGK3vz9A9aL5eZrxJrZ92EWE2hcdxXS+geN9Wwn9ax65Ynlf3g0i5WgbqoCobwINUX
 0AJ8DK/sqUA80t5t1rZCNkkuhf/otYh+4EwMGv/qzeiQgm5aPs11gvhfHH63jgHkDWDp
 tUYkN2E1goCqwMLYdK08HPeBTOHkSxuCHmZzfNIgtLjOvcEzTq3jftFasf1djJoPpTKT
 elJQ==
X-Gm-Message-State: AFq9FYJ+PdvnDyHnW79DWUjCtd044Tl6mEydfp5KpqHyFj1DuXku2Gj2
 IG8IXK+xZhsZYuHsNwIuEwOsjKqcOxooUvIpIRWoi1waWfQHoY01GnoQur5gVOrl5IbtYoLHwho
 e13hD8Sb1Lr2goW6Z2e5WMeiLD58eKoFPDcQ7BxS2
X-Gm-Gg: AYBFou062DRfzWctMrPYCc/jzeLzCCpIGHe+3fg9y7W1J1u01SBBAmeEgD5Cny61VTx
 Vyija705r22MpdrbPHW3U17cr5Fso0zUNrSkwVXEw70NnAe/OLfRj9tRjT2Jsekyn3DtbPTMGuQ
 BmRE9gJv0vdkQS0gCGTzRmDQNi4am8O0XMCOMx3l/Zr3Lj/gL+dSOL5OvDMrGsjirJLzXlnWt54
 tLyTY7RMOHnSl7XuNNkgRcch+fAn4xuKGCuoAZHJ10VRrb9xnu04Pb53YJefdyZigM/ga9Xg7BW
 wEPwOl6IVp9/2ettPoMRZKIPSiT+zdabNHKiqYXoNirIUw+/+CJGSA==
X-Received: by 2002:a05:6402:360b:b0:6a7:ee55:dccd with SMTP id
 4fb4d7f45d1cf-6aae8eb5635mr6053768a12.28.1790527579114; Sun, 27 Sep 2026
 09:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
 <20260924055459.125648-4-aristo.chen@canonical.com>
In-Reply-To: <20260924055459.125648-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:45:58 -0600
X-Gm-Features: AclHuK9KE7nCZUDIqawU5oxiuI51hjFeNmOVkMAcM5rclv6g596eWlnCByjreN8
Message-ID: <CAFLszTj4Kv6ZGkX7WJpDUzeu0vjmi2NWc2e=5a5-K8ED=2RLAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] boot: fit: use constants for FIT property names
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de, Anshul Dalal <anshuld@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anton Ivanov <anton@binarly.io>
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

On 2026-09-24T05:54:48, Aristo Chen <aristo.chen@canonical.com> wrote:
> boot: fit: use constants for FIT property names
>
> Commit 634dcda25924 ("boot/fit: use constants for property strings")
> switched boot/common_fit.c and boot/image-fit.c to the property name
> constants in include/image.h, but a few literals are left in boot/:
>
> - fdt_offset() in boot_fit.c reads "data-offset" and "data-size" from
>   the FDT image node; use FIT_DATA_OFFSET_PROP and FIT_DATA_SIZE_PROP.
> - boot_get_fpga() reads the "compatible" property of the FPGA image
>   node. Commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
>   for conf's compatible prop") added FIT_COMPAT_PROP and noted that FPGA
>   image nodes carry the same property; use it there too.
> - fit_image_load_storage() looks up the dm-verity subnode by a literal
>   name; use FIT_VERITY_NODENAME like the rest of the dm-verity code.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> boot/boot_fit.c    | 4 ++--
>  boot/image-board.c | 3 ++-
>  boot/image-fit.c   | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
