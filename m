Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA885C44516
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 00:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A5580517;
	Sat, 18 Jul 2026 02:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FbjaryTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 636AC84119; Sat, 18 Jul 2026 02:08:01 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4391083314
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 02:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-44cf70de986so2942035fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784333278; x=1784938078; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DomtA85Mfh7xto3flTGTzz9rpr008DsQ+m3grxfQHfQ=;
 b=FbjaryTUplq+MbBHnaaezEYVgNpVyZ0bRZ11d0ta/Mrxa7c23wMxC9E7DVC+7QyDro
 +Hb18IzlTvsg7vcTxekIlOGu5ZtJweQIdefdNNchK/CugT6AZ6PrQo3HtO21n7vFEBiJ
 7OGCS2e/h1reN4ZQCUUU6ja1/jazA8tiat8fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784333278; x=1784938078;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DomtA85Mfh7xto3flTGTzz9rpr008DsQ+m3grxfQHfQ=;
 b=FXrtS1VmNNdYs/CymQ5Qm+/NAeE7b6NhHKEoKnSKwnG4kKc1fIfDvsuKzQpxJ0HlWE
 ZZKEdtx3d1gdaCTnzNib1B7fhoNvy2XzAElO+3b1dgpATW32f29XMHmk/EkVFhdl90X+
 5DbkAL1JkSCJEVAs6CPkINmdAzPOz41T0ekMs+63gq7H8i6zJgtyazGU+J+OtHKyVm6s
 CwGGuA0qHjrE1nX4GpNJ68ydUjPYrXg/nMa50qAyn0i+EDSxmVPA2Prgn7FHef/Lxn/e
 e1Ufm7++8xyqIcutfeuECNnS7TowLhiRwm1V09WTM+wN4NNq3Cnn3WMyhihbevV4BQpF
 GEsg==
X-Gm-Message-State: AOJu0Yy32lw/4OM6wfKv2hSwVfhA2vaUgjWDL1xTPafsernVQAjL55C/
 S92jJ5R5pD8xMDfePyXK9z5zQMulj+IRHcLi3LIiZVWn6YmysFKf6J6h+0sxWpq+qTYooo/deyl
 cQwoSiG0=
X-Gm-Gg: AfdE7cnS7uQhUh/a1/7W5cYJj/bp1t7PA9FNIwDrESPfusV40HZdLFPS5G55C1XBoZJ
 omntxsdaPfu6Z0/4owstn40AAA1DdHGKONssBnUoEyHIlu9k6HjQ9/7gFkJtELMfk48VZzABLes
 Kn9W/6smkJBn27uJVUg5nVMvvsLE0Nur3wFHKNxwcmLSF1XL8QF7VvHuwA7+XdxixqkYam2Zs0x
 UWH/BVewCoqDYLKz3YkeOpBemPunP+C4nG11YDUFSZbF0G3jFO9/pkuyqkd1So6oseVSJqdwawW
 Q18/7BoyNxvQXSspLqONlKhRT/G6HTYPNjc0JP3ORKDta52iEDF+RSapTr6JGD7cDe1nkb2hE84
 fM8Pgo+x2gHdJiZAQ267VOUc/Io9HOAdyMUEoaeoEVMCo4dDuGbsvhDHZLEKnfhkeK+zpwf+C/H
 OvZ6czp0xrhsQ9uzoPhZQn01drpf/+iMzKiGnadm3UjPQpEpuhC0SxQEgSPCR3Or+YIhamfkWOT
 OTfX/lSV8PI1Ls3gupdzEL6nA==
X-Received: by 2002:a05:6871:82b:b0:455:1b6e:df34 with SMTP id
 586e51a60fabf-456904da0fbmr2106594fac.42.1784333277954; 
 Fri, 17 Jul 2026 17:07:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-93-175.totalplay.net.
 [187.190.93.175]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0be46asm2275893fac.2.2026.07.17.17.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 17:07:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20260707224842.261424-1-trini@konsulko.com>
References: <20260707224842.261424-1-trini@konsulko.com>
Subject: Re: [PATCH] bloblist: Rename GD_FLG_BLOBLIST_READY to
 GD_FLG_BLOBLIST_HANDOFF
Message-Id: <178433327718.1719219.13563784118810024694.b4-ty@konsulko.com>
Date: Fri, 17 Jul 2026 18:07:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 07 Jul 2026 16:48:42 -0600, Tom Rini wrote:

> Now that we have made bloblist have distinct "find" and "create"
> functions, the global data tag "GD_FLG_BLOBLIST_READY" doesn't quite
> make sense anymore. Rename it to GD_FLG_BLOBLIST_HANDOFF.
> 
> 

Applied to u-boot/main, thanks!

[1/1] bloblist: Rename GD_FLG_BLOBLIST_READY to GD_FLG_BLOBLIST_HANDOFF
      commit: a1a944f25c10dfa2ae3b344acbbeac39dc929bb8
-- 
Tom


