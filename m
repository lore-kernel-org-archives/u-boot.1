Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E54FFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7BB846C3;
	Wed, 29 Apr 2026 08:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P68VulN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B120B846CE; Wed, 29 Apr 2026 08:42:25 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9992784198
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65890a6ca20so3408740d50.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777444939; cv=none;
 d=google.com; s=arc-20240605;
 b=JqpLvTyv2/3UMUy9M8OiB9irlOWUFzt5emC5BoHsRqYMrJLlGppAcvDR0yglvv3OnG
 AbXRm2LNxldO40BiPlRxXsFcb8Y7jXJj/u3Hqc2aNJTajdM07LmZppVyBLwyuRSJuFU4
 A4GzaMjpwNYzaz6y2onsXWBCTlEBuhvfm+reYaxmjEJ+HYnA7znV3T7ISn3Ksy+zPRtn
 SfilmTytBssq78KqEIdsLq1ZT2aEkK8ZmSyyqs3s+sknZcEtXMxPv5Hf5nWjhYOLvcn+
 c6AW6U2pA/W2jORIoTK/WlfgzNhvO3lbNaTQMmvIVvhf0dRB3PCUu81WfCOE+hinjgIh
 Zcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1rZPW5bLqh9AHitfJ9HFwcdovM/QWl/qCJLS/RTrkWA=;
 fh=l2qtrYfpljVhK0A8Xu2UV6Useb7rNIrCl9bBsAWFkyw=;
 b=Ca7nBwxKM2Yhcvw0pLBl4o0c3tQqy6KNojI6ymgD18knbW6DHNnNABwkYnvjVUiwms
 nRlW+LN/vx+lOuzHdnUvbKIoELxNQFmUJVnJrqQZQyzZVQk2tVXdlgawaiQSwdHPjUka
 BgO8ckKnP4neoXArtp6iG2ElYi3fcf4CPljzQAtMz9/xpcUTK0jTKBVTZV9CYA/d8FXF
 tX9d2z4MN19DF/PhYTXyReGfZVKb2UD7zmJaDYo1ua8ztWWhw5TGQLdATxO7VqflgfEz
 PK6G92on9KyqsZ3MhQgZKKNrlgN2EZ3wASCSE9hep2/x73BN/Inszk5DNSCHV8GwTU5a
 XqyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777444939; x=1778049739; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1rZPW5bLqh9AHitfJ9HFwcdovM/QWl/qCJLS/RTrkWA=;
 b=P68VulN377vMkcJ4buBCww8nSBK1XMu4RHosV2sx3HAYIfYwTbn4qAMYxL9rEJAxde
 8U+9xrmffHAJuusG8uRdD2V68jLoKbGOSZDdpQ0oG4X4y/PDRBCN/iQ55/+m+39JP4Hh
 w4R4WeTcD5Wn0WOKA+L0r2g+FUIDfYiBG+PZiBVXbRaWKpOrh9XEauJAueWaJsK8YTli
 8i5L/kgp/qo3M1etM8bjPcn8C89IY2FGRh15IDZzjDy2a2c5f9hKryauDjVXSCj7V8eq
 YgwC+kl+QhoUu/V0KraCRjNC7hpueiwgDw102ahKZt4Wcz9KYLAVqzHnL1OGj8tN0BMY
 wdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777444939; x=1778049739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rZPW5bLqh9AHitfJ9HFwcdovM/QWl/qCJLS/RTrkWA=;
 b=BsYjf/d+DPnu5TscKvD9ltXQgWW0Wtp3ZZk32r/Yfb9z/opp9arwkA7KwmvJAgb+78
 tsYxpFkAI+ot85uZnUMVCpnDEbwzlmTjze08RY1r1J9J/lndrAEje8fb+4vNid77HwNo
 9mHbtK3E5njU9Bzo8ttSd1V/4tPIfKR4cG8+n7mj8xBVI2ZEq0zFRlLWPvottIWXDUJA
 y/W46Xdqyt84xtZNcGVnEP+Xm+aGpnFc8CrO5BSNJ8rTwJr4y8vB64/IzJcEWqhif0vy
 J/RdOefpR3jtosW9DzEUuxQElaK9rsRXL4Ty81KQL6pcsM3KITWtBgJotKBe+elQgF/u
 xCcQ==
X-Gm-Message-State: AOJu0Yywu8Bi5V/uWSCzCzRq3bgCpKVuPNrsiCTcMAZ6huuJjhTfIkQn
 D1Qnltq5WL3tO79WZxrPk89Vu3U+iJ+TrZZEdrGiW9Yta9ncsBtA8zfRjcq/Yr7LseSUq5wZLOd
 0mHDFdrprC5nxqMi8054v+CfaCsQI+tIWqXJ3rDpoGw==
X-Gm-Gg: AeBDietux0oGaFINVbBPU1xknm/EE7qNNIBAW8KBw2Qi4lfH3CwHyCRm3/88sAsuJYp
 ZUyYRoScDEgb4BDEPtlvgBFZm6m1/r1fxtTUzMHUE8Qo81KCCJqKKHIDsLDA39+XhAIZf3fkR5A
 FExcxdyn9snQxwoM4hwxAvyv35RU3KEzeVIvgRugOHdRUDYfzo8sur35Dr0pYmZfzLIfYArBqEJ
 G9uI5/ROx1ouY+nNkkVZSeCdWV8XdwzA9B4I37P2hm9ugwvNeaEoJwTGQsQWPkXuvqwqYhGDDNF
 tYpJbTPcXDCfX33WjoVvNGBBt4Qm4A1qC6DsYjycIlGyz7YNh0/V8+h8BCMWQ3JZWWUyVpqJ6r2
 f+YJdzNh4aW7XTym1l7uuAIUaMpGnc0RcAHWr3UlClEnJ5ckXzZ+iPIvlxv1WNoe9mDGrpOaih4
 aGHRaUfqvfkGGn1TTtcYiVA/tcbPE3gT3yA/69XXSRlisosG9nnby9OTC7p4LRPuyMuuYiG0hW5
 /fcYOczet+D1VOXSasMYqXnKpL4b7oWlUlXBv+L0jrhgznkq0vAI2fcx4Cnrwgegaz/J3RcjCjn
 P5UsB3pakjdARjZU6V31h5ernNYCijV/Q4x3CE9iTkSHExMjPEfzwLmsA62gBJazfJBbx4iBCbi
 7hJAewTci8vkbuRqz
X-Received: by 2002:a53:d851:0:b0:651:be68:77e3 with SMTP id
 956f58d0204a3-65bfb6e34c9mr2297195d50.31.1777444939238; Tue, 28 Apr 2026
 23:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
In-Reply-To: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Apr 2026 09:41:42 +0300
X-Gm-Features: AVHnY4KZufmIKgNHwwhDdMT9mDDDfAbJat_2oR3lteEDeB3ZKIr0pcwnXHRYbtY
Message-ID: <CAC_iWjKG1PwHC+nHcYpJ2ZfzXrZJYGMceyqeDCNjuDgojRhA4w@mail.gmail.com>
Subject: Re: [PATCH] bloblist: fix pointer comparison in bloblist_apply_blobs()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 29 Apr 2026 at 09:30, Michal Simek <michal.simek@amd.com> wrote:
>
> The rec_from_blob() function returns a pointer, but the code was
> comparing it using "rec <= 0" which is incorrect for pointer types.
> Pointers should be compared using "== NULL" or "!= NULL".
>
> Addresses-Coverity-ID: CID 645841: Incorrect expression (BAD_COMPARE)
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  common/bloblist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index afed968ce01d..d084be899588 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -300,7 +300,7 @@ int bloblist_apply_blobs(uint tag, int (*func)(void **data, int size))
>                         }
>
>                         rec = rec_from_blob(blob - dat_off);
> -                       if (rec <= 0) {
> +                       if (!rec) {
>                                 log_err("Blob corrupted\n");
>                                 return -ENOENT;
>                         }
> --
> 2.43.0
>
> base-commit: e995dcb19c89c5c697b57380831167ff238b0d07
