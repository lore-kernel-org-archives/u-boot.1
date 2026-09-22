Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5DFC98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F71040692;
	Wed, 23 Sep 2026 01:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SytrnSzGMw2o; Wed, 23 Sep 2026 01:09:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B543A40698
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790125761;
	b=XsI9Eecv72v5xyoIBONv+vS9ao7dStWrvKKm/pP4w0GyHk2QNfki2yOsLgSBgsxu7pwS
	 klG9nCI1KsSkPhHpIijDRz0+IvHk+Ndzt05dS6x/UbxuYfpc7JEg938seK6gaVnnO8rqW
	 rYfS/0le6JRr4vi5enGaC2C3rF51tNVN0qU7TG7lJiClG2gvd8xeho3eb1e8azJN3QR0n
	 JqNRK2EYa8M4Fj1TMK2+2GXRnkP2luKYqySa2PvYfWs3dTS2hGDJO7IAKpJ6/X3Y/vuhC
	 J1PWzjkgnoyFL0xvoaYUxbiQaCZhtGXZE05ui9D4Uom2Ygk6sGAA2fJgqd72wLKBAag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790125761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
	b=fvlqc3YBxsrlVYOXFZW8+qRyPxTZkBs8c31NkQwi08SBmWYdrs2pxvOxjqBGReFqSIdD
	 ++Dsj8nJaQV2L59+yOuri/vFtdFuqCBtnnKW5Fk3HcpsHyyL9Qsm7gNAJPDOmGjl4UBdx
	 ieRmcz8Ym4sJymLunBFsZABGs3Ni6+8RdzzZIi0YUVo/8HDijijO4h0ME/4O0CCbbJft2
	 qKk/8Tqi1dVvNN3zyuqP90IPn8YZg2nCOzGtxLSOM/po1jZIt1hnN7B7GqFmUyvP7opSU
	 LLku2vtg7dW/Ux7+8/Sbq5hXsCwg7DvG7ehwhWy9afW6cZnkifm2MR4ZkqVzAfnMYtw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790125761;
	bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrbYNYgKywBPrTKaz6L8tuRINTLZ05LST4EZA1zwFht0y4Ji8r2aaznqDmvbij6Gl
	 87Xoo5SJ4AxNpqPhR5qMW36QO8MSADdTW40rXEHpf4cOe5hKfk4zOQ70VZ7+wPs94N
	 fZa+y8QYA3hdBm2Pj2vuGXohBUI34M+pLH/ZpDLYvhY8r7QoLDu2Js6RDD9tcjbQ7Q
	 2/NRkekwiTmF6fDwDQDrZoZM2aV3qGMcVu5Dt+ZIDTU4cJJNpK9FZLCAD2Fth4tMJW
	 ZqyjsA5l367mIjWhM3bMTfgVywslkpDTERgFtdL/rP3JSHtQrRGjdwjSlqE1EC+l50
	 EbWsuWnv/GtdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B543A40698;
	Wed, 23 Sep 2026 01:09:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34211D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21FF9606D0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_yvezKDZNoQ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 18:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1B0126061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790102829;
 b=pMzPf2y9tls++99txD8I0MgfZmPg7EoZvX23eSQY4Nk024abk4mSWud33lbTlrj8SmAj
 CAv2N4Z5qJhT8f+5GkdWMxQhfCOAryWhYYdapdRPQCM8uOOGA06+9m0J9cW49bpM0Eon9
 PlulONJeDM/m/L3nnjApFcCzay9cZ4MDz108cddYKthyto9HA/EkVtSzhhuXq55HG/BgL
 H9aM5M6E3EPTRWwtceBwagyq4hS9E39gaVXif9nQ5imVyEu6eeXalnCGCximtwcnIwf7P
 9uecmeysBdQSQIFW/nxJQl6RDvqF8HBdWyBtq08hoY/mZH2bXHHV5firThC3u3/Fy3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790102829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
 b=ZKeZceG0uyBO3JE7Vdz/2h1m9VzDff6R/vAk16h4m6sS6EZcBPkwfZpe637Vm2q+sJsR
 wOfCoUSzVjQMzx+1WXVMY9M05PnVU/oqclouepSnhT9m+6JtCyKCtxDjrSLyozyTPDJ7s
 1o1ss/O2H58S+CfGdyaFyLw3NY3Luh2Jo5eub6f1e8akBCvJ3zOmS4xWNNbKDvjzYB85x
 019lEPq4XGBfkt0No7mw5T3TL60nu5K3YMt45COuO5HIj9VkyrddcLCqRdUKNZrS9j52Z
 uuDx05SXMs27INS/2qlvOBBmG43QQGl3y/8Nf0ewYyUVx5KhH1B5s1OQ6BlxFyFIH6g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=D9Mtfk+e; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=asrinivasan@tenstorrent.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=D9Mtfk+e
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B0126061D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:47:07 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 00721157ae682-85d4eb63f0aso2191837b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 11:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790102826; cv=none;
 d=google.com; s=arc-20260327;
 b=gfLD2/c82CEFthyQQNO0JaRVjO9nK8ICJu5epICtoGzFiylpRSC0TvQHgRN7MdQ9To
 MnQauq9aAglWIXBZjEJVJk4lBwAowxfgk6JETb60Ro9FwJ193E0wTHazOV6aupCOFrf4
 W3J9Yrlq2dvrGnJdjVomsDAeXhcuya/UCdacKCybi2VNmu/qv8gKjIlhfTZnyyoAoWYJ
 B0+bqBSYlKj5nuL5z60oM7Z6shcN5lxOyZa6uE9MKHjJC0ZTluaUXuPJGymR6QoGNiBK
 yNOOdx+8x+8I6wk5b6YQKI6a4o4We3McU1sgLUzhj/y+XjeCdDi48LY9aW+01QciFu4I
 4m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
 fh=EqxML61kZdBO0R683F4FyPb3X0M3Ofx/hMkeOaI4CR4=;
 b=fL7Esp+Xws+kGlMQcEnjuszoPISSyQV5vk6C/J4dDTWu1rvkj2+eGYVjLErJ2IVJeB
 +cNK9WpX77WqIM8ViEXntZqtgyYPdowwSBDh/SgKi+ZWwSPUooyA/jUBPG1if8N5odtg
 1oLY3Oi8B0mz9Arc8c0WnYxVgJwDviKYP9gShDpWAe0fOWxFcbqiPt9Yu86aRBsGpVJ8
 2UCL7cdb1WzneEm/wVfWJgO8BcKhif9D69WNI4G0bkHfoF0pYd74NqsyEOdSnv/drfFf
 T3egsGpvCdegDuanMkTebHGftYbi8RtFMg+4dF53+qeDmiaWG7tTu0SaJJKw+iulBV7f
 fABQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790102826; x=1790707626;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
 b=D9Mtfk+eEidGfZ0v0iIJy1LfpTPJP0SN7cYSISi6wqd+gk+N4IfTDI3ufVg4NzQ4Ie
 JR5+EzPW46uFF+AAtIdETVOkLJBQrfH9d+c1W6U5OyN8NZIcU3rQvqKLUDQaH1Ksmpkb
 vc7rjwMBV8ZCxd1LiOewc9QPf/15EAX9h2IAWcj5ix7oSJi8tFN47j64vO5Fk/qO1X3u
 P5FhJxQgBkt3vBc2HLglIwN0tw2/e7csSfXlpZAxO7wHOoF2Y/6OekpK5/HEV4tz2K6/
 ZriKpnyel9ffUemmbGZFGzGhCKs46LA93zaLYIJ36P9LkVq/iWEzNclQjwoqTU4AYqc6
 2Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102826; x=1790707626;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DKXW6dWv43a8/PCWYpCiGDLSCfrZigRz6henJ0ejOpc=;
 b=Wk9iO0wKxg5OWJEqwkzUW0M13G18pCuHlnsPdi8x+4mXlVLOtxr5UnAUd+2SmrvCD4
 bQ1JikAlwop4LSQSkQHaCGHlsq/WVEH0MGhVY1QdH0QbhfAfihohpVe9bXWNNLOIRg2Q
 fNJyIOvUejoJV3CslKgKsPoMFu+GFtEqNBNqsuoC2ZQpgymrEC9hVUuYrj86Yu1Ss3XZ
 mJ10EHILVlwIktOztGNQNxNnhAF0jzkKUyC8le2SRMthoIHa2fs/F5uQLK8P8697RWRb
 Asv19ltLsU6dJW8jrV2gmwnwtGk6rk9Xvlx8//WzL39VCrDQl92hfUIQ8rIhHPjehnS+
 5tMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgzKtssl9ph6CnRfbToWwlxbjI0flotbetp4zBb3BsgAVb5aFb4saSakfaxHKbVC3zk3xo/hc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mkZ6FwH7S9ysu0bQsUUwWOeqBjPwoc3HfYxmUgkBDRo1FL888W
 eZq5rsbpTGwjgkqzP7Hf5ifYjx++mZOT7XSn3+jeuKIomTrp+2DE5OT64ljizApJJAWyzyMW1qC
 tsW1Xc6kbicM3d2G1UqXf0NORLSfShrSqEsnieiyWzg==
X-Gm-Gg: AYBFou0KAkEWJIRMdfziEEbqh+EDOCHV2RP3KeXcxpr34LEmAb2lT3Oagtfz29dTHSB
 Zi0b9qc7btV6SmjP32qEdNwIzZ4PzsduuA1f+l/30PJvSKLdidtnRuOfxQgGcRc44Tg7PHbLfgT
 MgTyg6x478wXSe7qIhbiJSyWXi2SlxLIVlbeHCGgSaJAw5KkAzXBUeOqbdYDKN5kvxENb/eMDiV
 sKRIi7npBkyiIbC3cGINLKe4/e6tO7LBoCGfJtAd9bs4/WMHNtw8QCkpxbOv4+biodCnKNAu9i4
 JCGAo8gAFVa8KHwHmWSrBLEaqpM/EGEMNYeybKWSh7hOTI8Ez+DWrxBv7A9i8O5e2UFEDWkX7Fm
 R+hqCHy6BjQ==
X-Received: by 2002:a05:690c:7:b0:873:5c6b:a327 with SMTP id
 00721157ae682-8a45ea5bed2mr2099847b3.33.1790102826377; Tue, 22 Sep 2026
 11:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
In-Reply-To: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
From: Anirudh Srinivasan <asrinivasan@tenstorrent.com>
Date: Tue, 22 Sep 2026 13:46:55 -0500
X-Gm-Features: AclHuK99tnR6HwLkcZfgOhrGvabjpOhCs42lUQ3W1ARGAh4d7APgCQ_a_gi4lXM
Message-ID: <CAEev2e-vk1on05HHcdZhkukCEQ1C8knG1GAQcYjtwbrAuemrHw@mail.gmail.com>
Subject: Re: [PATCH 0/2] SPI/NOR Flash Fixes
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Ssunk <ssunkkan@gmail.com>, 
 Jeffrey Yu <jeyu@issi.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Flaviu Nistor <flaviu.nistor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 23 Sep 2026 01:09:19 +0000
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

Hi all,

On Mon, Aug 3, 2026 at 2:01=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Adds a new Micron NOR Flash Device ID and a fix to the Designware SPI
> driver to not try dual/quad/octal modes.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Anirudh Srinivasan (2):
>       mtd: spi-nor-ids: Add variant of mt25qu256a chip
>       spi: dw: Add supports_op function to reject unsupported transfer mo=
des
>
>  drivers/mtd/spi/spi-nor-ids.c |  2 ++
>  drivers/spi/designware_spi.c  | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)

Patch 1 in this series got an Rb (with a request for a minor wording
change). Patch 2 hasn't received any replies. I'm sending a gentle
reminder regarding Patch 2, in case anyone has comments.

I can send another revision for Patch 1 if needed (or it can be fixed
up while being applied).

Regards
Anirudh Srinivasan

> ---
> base-commit: 5c215cb75c3723cbf77c36cbac3e60b001721c79
> change-id: 20260803-spi_fixes-586ef497b80a
>
> Best regards,
> --
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
