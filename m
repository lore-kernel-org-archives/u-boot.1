Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B819606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e/jNTavV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CmiOdFAa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC37340CAE;
	Fri, 30 Oct 2026 14:10:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coDBXGYtyUZg; Fri, 30 Oct 2026 14:10:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1797340CB4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793369438;
	b=nDTLcRK8xSXffI4ePg6PNUFL2vDyf7I85MV+p83zKV1oeFZMmYudt1Y01phtqjWlc5zu
	 ZEsSylhNyMEijDMBeA1/431gZTAwU6VyOuduCe3kCqBP3NmjooCZmAi3DR7dOM7vEjCU1
	 M9xXWZ4a9Ljis+TAdDLj78+bTpBvTva7129xKorwQtPXcKsHJ6SPL9gbOahPVa/vsGfdl
	 ya+s2zMYPovANTKFMU4Mh3UaKg2r4CARwepOTZKDQdoKlJcfR1DKcAZzVfMMIisOzPVLq
	 orPi42lQCJagGFKiFAfnr/h40ROGel0ppDt/4SmqkC8skp6wCMbCj6Ew4rfVVL30m2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793369438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nqe259QGXR+fucChVGkq/eWzcybDwTDU35mItu0xlNE=;
	b=HCi60WmFLLRUOD7Nelle0GFS70/nOFlyNRfDwvQLiIDaI54RPZaUHjOMEIaho2F23W2g
	 wQB1VNLD+v8w8qMyKcdSYy9vDLmb+aUKTbvXN1tjmtcEjgOu80RW10sa2Z4u6NGy/GJQJ
	 63Wnz7ImPTa5npU7VEcs5Xoo4yrb6CIo4hSOhNJqAh++YGxmhGbSfiHY9iP0DMqtedkIk
	 UFDAJFMcCfi+k2mSaIW5dfdezQXKasrMnvsFIHv1+nw9LQkk72l8f9ohHFLkncw1/l+4o
	 yxzwBKQsitWo6RsBXPeNky37UXnCucVqXDLvOaGXdxqOVmPmntmkQNlmOOQfut6Egsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CmiOdFAa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793369438;
	bh=Nqe259QGXR+fucChVGkq/eWzcybDwTDU35mItu0xlNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e/jNTavVReA70ODIqPzVdjFUMUz6ofM7nvuTg53ul5r2x4PxCiw50tcIN6AcSjiss
	 T65QQGLAgcaBwpSsNbbTjPmI0EiTj1B8PS7NFZdkIZOJtVAHlWjPEhX9OXrNIkXmEx
	 dCERLafhUtPwxgcWM0NfDEetZHbcRt5JH6VYz/MevfqMv2xnRZnVSPyXTRa6+D6x//
	 WsSTCrpYIcvweI78gu0Xu9reHFbHgrpdQCcIidCnRuvCChcTavKb95YciAjPwja/qr
	 YRknJd+mIKJBl8JuLj+VSANXH6DOh0gzREyyo/uw0AyC+88Pi02b6ABBhYfTnIzEk4
	 7xX89YTRo+Hpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1797340CB4;
	Fri, 30 Oct 2026 14:10:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53E6F362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39F0540CB4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgBhVM3uwJMp for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:10:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 708E940CAE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793369435;
 b=P4/EM7YxNiIC7Mc1MrPusJix1vzeZCS3elR9EHcZo8xkD1wEhl5b1bkcV5CWZ/M4JNIH
 NsuYQ29faGtMz6gSnWp7O60HV9UTK2MsMujTt7N4p/v5xIdCIEwJR96/ShuwiFmUCMX+I
 O0aISZ9p1AZ9ITWjsRicZp1gdv4HB+7ixksirrO5ihDs2pEVt+7y2aNYOrNTluTrfp5NW
 ufyd2PUOPdY5kOHYQ+pLKc7KMD3LIbqwkcOAKQHa0+O/jU0W4FPbsW3jjR+4hxJl8aWvJ
 lZokS7vTL68bf/eHmEmOhGDYP5X3dD8+Nui0XSX6NU0BjLghXf8rFXHo0wsvvVsgl9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793369435;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Nqe259QGXR+fucChVGkq/eWzcybDwTDU35mItu0xlNE=;
 b=rHBTmMAE0AE76HlQndSmz1uwr1i7PzCgvm4/Xyd0w+l4a/oo+N2tCLPwpcrO9C9hdWs8
 6KH84l9j0pHUqTDn2ByKAwDAqGAsb7gpwrzGo2wTVfRgQ97HR49+XIaERq5195rcZRDuE
 aOD+Cn8OQnHAhbAtiJfJdXiSmMMqKjBjYkR04PxCd/b+5xZUpURAUQ6dToEZVDp5ubDlT
 6ls/kI3g1e9828EWkIuQGmu+tQ50BmQ15aCKbKLFRUrK9eG3x0OE94KkpdFDFZtS7U5Fi
 xriAGMhi8Alrntz+SQDNX71Xs5zsso092DHafvsdfbYhgrz46Rd8teF/llpm1gYu4mw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CmiOdFAa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CmiOdFAa
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 708E940CAE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:10:32 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso5636765e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793369431; x=1793974231;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nqe259QGXR+fucChVGkq/eWzcybDwTDU35mItu0xlNE=;
 b=CmiOdFAaZeCW47LmFihb1QID9fH8IZMLlJQ6qZjV8E/mjMX7Q+sMuxrL5V5oXQ3G32
 uw9AoWZ206pFRi79f+axKADM/wm1XVqQJaUtlSSEPvZ+aGFsQ/AyTTq69yfdBsRy7MdZ
 KZWzpZHl5+hFI51x2G173all0RK5nCpqbItvOtvcJVp436pMkljsZqf9JW3Hkuf8EXH+
 uM5MkLRefeZYoHbf4/0KjoS0u9C5/g4EvG1VpFqFmMILr//UM4OP4SnqBhKywmRFu+MB
 2spH5tbwJSKa/K7uTuDjRKUkkdxUkGYM4k//lPmVD2QjUNg5sRl2Z+niPP6jUkdFdu4W
 iNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369431; x=1793974231;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nqe259QGXR+fucChVGkq/eWzcybDwTDU35mItu0xlNE=;
 b=aqhukCDzajce8gMFJmIUjfbhj7w9nbpnwWmvWp7Wp/sEEwXnmprWlsP+nUQVrM2GQn
 TDx3BK4p8IqQV28STHRBeP35aZ/L/2Okqbh+n1wXuaKyDy+myhA32NFNeytpfDUwhr9o
 GDqYbQo3gT7vk6d8Y1reljZlXygxC5ipmGytqDSPwD936KYhtzTBWfDCPfk+XHnFN0v1
 E67745htDuKZSPe3mcvcL4UZUaNDQCrk/8c0GPCajMHVGY2Nd3WDLSOiGjrlcunb588I
 nPjmjtgP97mdoNhAWCwT6JiZfJxF+ad4nYEeGAUJaHbGWoZVYSGy5+m237FnW8rjM84f
 evvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByf4vJ5LLwi0XdzOK3fNSFx42uCZJD5FEQWY4eZlzk/VREipGQf2s0b4FhY9GlyrItF49swSxM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ7a9tPXLLZy/Jnol+dsE96Uy6O0B6f2fYELYYBCI40yADxWSAl
 /T51Uh7ILEzlqVTz9tnVfthBqQ/x8P4SRsB5ZtlTGmWzRUQDycwS31Rk7wTy60edngo=
X-Gm-Gg: AYBFou1GUwHIg33hQPb/jT2xYAy+NfHTZCG/EsISfOnNdJSnwVYKXm5Qmetl1poK2FY
 MPaOUddgWi6BKiJU8BvLQ9B0LfG9Yn925EnX+OO1+f8AYQ9j92SnRcoADEsEDUe4yvqTuhZlJNu
 v6AIbtZzps7wmjxoOKpKIXpzNevFZpnbJCH0vGNgn+c2+zVSMCtuzX3NyjwXytAXVn7yN2yTtgv
 lW7Ndj2vxZWJq1diDxCCjGfbUu1YS9GF5VsA3hZ1WDh5KvnALy2GI5JEbULy1G0g+7bruF42RVy
 xBIfXZYP25iWxup9YGUM8OiKT6g3OtOq5XL2E3Ied3DLTQr6QYfW2qKCjbaQ6EYGWZaP/ZhViKC
 Qj7izjBplejZLvQq7WqsjejHmqJEmLv8A8J5iDQMqnUZfC7lgBydx88m6mkwHu5Ob6Q/Oz120Tk
 5XvbOPo8dP69Ez9BA4t3phrf9h0CGVhvv9Yn+IHWY8oqOFdAWAECTaduu7k7cbJMlXVTHL9xs2T
 th4FAhz38puVqKApipB4Jd7NulZPzcYRbpKs+6Gt03W8+7zLKbAZKsCiSqKHt5P741ogQ+/nXfa
 HptUY2pUSaJh6RYgxXIWO0iDZnWV2CI7B8WrCoccTc8vaRMOafu8IT5GMIN/P3vW8bsRffzCs7i
 UhmDNCSbaIUJG/hkktH8V9xJ7bTSWllwiHR3/+WJ1kDIAMg==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr53577635e9.23.1793369431057; 
 Fri, 30 Oct 2026 07:10:31 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac081d1944sm37410035e9.2.2026.10.30.07.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:30 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:10:27 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH 0/2] arm: mediatek: mt8188: run SPL and pre-relocation
 U-Boot with caches
Message-ID: <auSkjhR5ep_3AFvL@macbook.homenet.telecomitalia.it>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 09:57:40 +0100, Steffen Dirkwinkel wrote:
> Running u-boot without caches is slow, especially if using rsa
> signatures. This series turns the caches in u-boot spl and proper on
> early.

Hi Steffen,

interestingly this is going to conflict with my work at [0] but mine
was specific to DA so I welcome this effort to expand the fix to SPL as
well :)

[0] https://lore.kernel.org/all/20261022-ccaione-upstream-mt8390-da-v5-4-58982fe11312@baylibre.com/

--
Carlo Caione
