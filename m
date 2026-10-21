Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13960A263C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UEKDwGw1;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pquz6iQp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 248E3608F8;
	Wed, 21 Oct 2026 13:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhzNAEX5jI6A; Wed, 21 Oct 2026 13:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FCEF6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588414;
	b=C5VfKZIctLelecRL/g4RABS3esK8y7NaprHf5O5a7IW+MqEiAsnOgnrkVWRbv6d4Obiv
	 vxPNGnmMJkM5HMS2/vKPlCSqcOlyrmsVPg7tYrO6barKpU0Eeqqc0TkPLkePMAAyyBXhY
	 m3BNSWY5jt93Z2fyjHyWg36rr0OuU9Esu9iE6E6Kzjq0Zr4BV6k84YyQrtgZLAZu9cJ1t
	 iarie08r2N6YtKAixjIQrQfugICUEw9+3EyB0A8XJHjBH/Mu9UGMuJearaXprCH/ZSFGL
	 NeFWvxxfTrdCcYynudSwJWIWYXrVfZdYr0qlW56YQAnHts7+6IBipO9lbqIo9Fm6qrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
	b=dCgJuGDtLzFoOZBV6EMTKMzrcCtbsS59RYrd4iN8W2Lf8Qd0rDGkpA9eoQPS71v/TmsZ
	 mSOD9mjjnJEqf8x/DV0PsTRJ5C07hAUB8Aqf0LEe0C284F2eBO4e/PPEk57LvKACiSGg1
	 RPzewO8+ZSTQmsBTbgOGrWak6fE+OaJSyjurBaL0aRXSwiVBxtmSH6AZPdKP15GUl+MtK
	 K3r5D3o1koR1v4RulZERTw0XZzwuP4ShGDsLiKSTAlyTPxS4RrVIY1lKy4yQsyD1amb/f
	 xE6dl0cQsFJAf9VhUGfuY7B05+PL6hFMCS23xliKIrmPiYdf++P/ehdoHuI17hcdPSA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pquz6iQp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588414;
	bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEKDwGw1RHOIGyEeczvTOV83yHghmSFCq6IpM29P+D6Wm/9t5zR2l5HumR4Y/KZR+
	 ami1Bc4A68FSswUnoOSvtZ9aGjNJGRTDSUmk4AJ0g1ob7pFTfXu2OKwx2ocsZP39uV
	 OGuV7lFE37N1RE/AtMh8A1JrwzmWGSUlgBHfvzzrzwYVG230c9OK0id4Oa2dw5exWv
	 tWSKD51SoWNnwaUwsbsnIjykL9ZjS7A1b5urhSnJg8BtnqvO3RBoLh9CdgnnkLbNcj
	 Qyc6hR7L53id3ukVtt3cNObpDhZbm6INAX8uA7jmQzfvm7Pox/wFBzDasXCoPTL0R4
	 WfhfHGjfX8F5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FCEF6084A;
	Wed, 21 Oct 2026 13:13:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93FD223A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FB236084A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 54ZNiBv4rZh1 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3B3460844
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588411;
 b=G6jsTNgsxGzs/iRrR411sGmztCHrx4dqD5SZcfs6eH478fCFu+otRKiHMovmN0D8yKVf
 iOMdxJSfuS542hymoaBGlDGw1fG9f6o06nHh0WVhVmQZeDXLKl2/IJdZHCVme6LT9aUqo
 LgbWQdvcXoCVOKXdGtx32Bp8yW8bIGKD6NwXgwCqnIW/8dI6HyiqKmpjlJ+/NcxkqsNor
 Xg/MJJGodfxU0ZQfMHg/g8/HBY8ulq1sm2OXL38rQ7HciMu9pBTSBN8+bTAEcBDSz2hPt
 OnACAYU2OFrQ3wDgnYbDmz820bg4DRxmHdIa0QZNwzDaPrtl/2mIvtp7oz/qGA4G/lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588411;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
 b=Gc23sFXR6YIg2Yq4iNMqrf6yhOtVX/xRkDV0FfJ/oqohRMB78RZzyrWouhUPunpTng29
 BCBCga+lsNLE6HzrrVVj0PjKco++MAecYtFCYUoEFCujE/+zGpZgcJFhs4twU0e+5/tKy
 LXBf2xnaPTreSyZnmofXolLIp4FlmpQPxdxZ92J5A5u6/FW2o2tFfQuocpcHVBj75w+7P
 KBD9+8cd8ybjt8O3K2M5FrAaNF4QCv371q4rpcMplSmsUqNUe1yL4Um9pj7QlGEK0JrTZ
 Pngf+tfpPo5HxNA7LgKqaf580thIgSSRzwn9SY8G1oi7VAhttlh+b131LZxrh/WBJZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pquz6iQp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Pquz6iQp
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3B3460844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:31 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so6402105ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588411; cv=none;
 d=google.com; s=arc-20260327;
 b=VQ9kJsaT9VkFw5tbjcQ4WJ/EIehIE/CM+4WpcgILXF0cF0dh4Oe5h9NWp/ItRMdnwv
 vhThAhICIlwgrR3a50q3WXYf9iwwxgxJjziO1tL+w2yEQ2G97b6uwpdFUyrxHi9gDDTF
 gSJR/7b6+b6s5N1v+39SvhOanHx5lFrG6Lxlu2qtFEB4psP63J8oWiRQDZt3zeogisP2
 yQICr1/jys2iMsXThYHWX6yoFlkf9PbdpTFAyLZWHGe96hi3BqO5bLzrt0cd7Bldei52
 ID6gka9H3UTGbia4ZNSbFfKic2qpmFd/gX4NVxIRqnc6+wGzN69yGnOzNztAy/ef302R
 jnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
 fh=NE69m14VdS+iLI1i0Nk+Z7UEeZ7dZqybdllMvaA72+o=;
 b=J1vZymYXkq5Ssldda9ZiGwxX2zJ+x3c3mgIMksAZctuK4TBR6kqLz+87KtZIMMy0zA
 NEcf0vqBjOCXJl6GVp0OvmIyyhDC0lQXpfUx1+aHWRcnXJ+zXbygbNpkDQ/89xdteanE
 i8rBSeSlgi7MpDJCKpZ2xpiJSkK5h2KFIYu1fcAol/dFqEiLK6V6uWvVO59G9r4Jeq33
 3BH8VH/gRPan+xqdYYtH0FiTtFiDMx44p5ZA/kxgXnt+olS/S5rNz+Qv2mY8yFA0TKsY
 tqzb6ZskVlHyZwbOHyI+5qNB0kkCwjiLQECegNOR+eKX3ylnP4vtvZRDo54lG2EmMoWi
 KCGQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588411; x=1793193211;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
 b=Pquz6iQpFtDthGhe9pEfKFpaiH29p4PO8yEwDn6Y52AmYzSJKknExQ7YmCAaa4kU2n
 Nu24tilTWHuZ41t4jmFrKJFDZ1Wk5+ZWY4Q4lhS4l109n37f45SQpck0LA/6Avkp6cks
 m+Ni+A4ZMQB5aecNWdOQ+Fcf4iQyWPpA87J/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588411; x=1793193211;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rvg8IvwXTUisE2PfIxQ8zUGCKVsgPYa7lJqLThom7rA=;
 b=H4bX5sIiY2ilssZjrJbYvmG4A+SOLRZ1ulQea0hyS49QzSMf4Zzn5yWIV/L7ZBAXc8
 nbZJfb5U3SnJFGUMwgNDRCjyWph6Yqd98kFArD+Lb8TW0s3hhFavtQLhSYeqMUy0/Qh/
 a16m4/844DELZUAxLe/oJTfD7+6flJTzyddzfUiB1y2vGSHTf//dLCL4LYIcgdHNiURc
 VjUABkVfAND/K9YO8zAolJMwjXxSmS9LQAFqXHUXYoO5lIBZWSphOHAjmscFH8oNKT3Y
 Qp5NMoFfk83ytKYhu6/PBZkMaHhRKftJ+9U+TJL4OVh0dXLcY9xUn6KARJnOghjh4Ivf
 2J+w==
X-Gm-Message-State: AFq9FYJzIyJbuNczwz9A6q19aOsbVN2jcU2ch8OL/9Hqv9MryZ4u6VH2
 XshEWYsTarp2pGtqBXcQVGm3b4uogez9EhKaSaL74w1rgCFTiHYO9bb1yiaTc2qgO9AqKo8C/GE
 ps/4DZKb84uLoq7vPQg4jBGLkb7faGdpB4rkvm5Q3
X-Gm-Gg: AYBFou0Vio4+pkpJPs82R3jc6F3u/0sXT1kYNbARNvcsINFULZgcapQL/pB4VcXPc9z
 Q9CV47ER0hddByJ2jBjcFEn5ZdE6/7yAi1uhSvRTMUiqBbbCGRQT4GSYXNHEok37RufzCgTLEqI
 W6zK9AYQp67fKmTxASh0k7cwUBPpyqRw+rsIja3t07A7wLVW9oHIjStc/EFcWavu2yQJ2TonuEf
 OsX1XONS3ipXHRD2hWnElHOd7/pwsIcGP839dCyKpLlt36dmFsZeFLw45DZcO1u4vOlrqc19plW
 UZ+p3gi6izmSoPYakyXGCmhytw9AudxcBkhoS+s+wEMhnZrXHBMQcfByfJQAGvnXNyViVUM7GWj
 hUE/mKcKy4WDVEu7jfi7/5E9cEJYTwj15Ot0=
X-Received: by 2002:a17:903:1a30:b0:2e8:3cab:3af1 with SMTP id
 d9443c01a7336-2ea43c1e91emr18662745ad.23.1792588410712; Wed, 21 Oct 2026
 06:13:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 15:13:25 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 13:29:59 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260824-improve-logging-on-missing-uclass-v2-1-4bee2cdff72b@baylibre.com>
References: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
 <20260824-improve-logging-on-missing-uclass-v2-1-4bee2cdff72b@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 15:13:25 +0200
X-Gm-Features: AclHuK9AA1kPsc3DBZAIdnblx9pFAn5L23q5YpK4DwKyoDULK9lmt86v6EKJniM
Message-ID: <CAFLszTi+FsB2TSKYi9W5Zc=QZtxsqcEo3PL7S0TmvFj1=nJbgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dm: add dm_err() and a driver model log verbosity
 choice
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-08-24T08:44:18, Julien Stephan <jstephan@baylibre.com> wrote:
> dm: add dm_err() and a driver model log verbosity choice
>
> When a fatal driver model error occurs the board often cannot boot, yet
> without any extra debug option enabled such errors are not shown: driver
> model only had dm_warn(), emitted at WARNING level (or DEBUG when DM_WARN
> was disabled). A fatal error deserves a message that is visible out of
> the box.
>
> Add a dm_err() helper, logging at ERROR level, and replace the DM_WARN /
> SPL_DM_WARN boolean options with a per-stage verbosity choice:
>
>   - DM_NONE: degrade all messages to DEBUG level (smallest size);
>   - DM_ERR:  emit dm_err() at ERROR level only (default);
>   - DM_WARN: emit both dm_warn() and dm_err().
>
> Each level includes the ones below it, so selecting warnings never
> silences errors. A disabled level is not removed entirely: it degrades to
> DEBUG level, which is compiled out by default but can still be displayed
> when debug logging is enabled (e.g. DEBUG defined or a high enough log
> level). So even DM_NONE can still show these messages as debug output.
> Production builds can drop the strings by selecting a lower level, while a
> fatal error is shown by default during development, including in SPL/TPL.
>
> Note this changes the default behaviour: driver model errors are now
> emitted by default (previously nothing was shown unless DM_WARN was
> enabled).
>
> The existing DM_DEBUG option is deliberately left untouched here. It works
> differently: it adds -DDEBUG to drivers/core/ via the Makefile rather than
> selecting a log level, and it is not phase-aware. Unifying it into this
> choice, along with converting the DM core debug() statements to
> log()/dm_dbg() (as recommended in the "To Do" section of
> doc/develop/logging.rst), could be done as a follow-up series.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
>  drivers/core/Kconfig | 75 +++++++++++++++++++++++++++++++++++++++++++---------
>  include/dm/util.h    | 19 +++++++++++--
>  2 files changed, 79 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
