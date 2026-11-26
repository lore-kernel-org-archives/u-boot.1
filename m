Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2B606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UeFBpaRa;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N7IHFokh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4F0860A52;
	Thu, 26 Nov 2026 13:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O79CUw1jrPYH; Thu, 26 Nov 2026 13:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36B0D60A68
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698775;
	b=O1m8ugwVrGCas3bOk3ik/5zipMd5bzU+oV8DrFq9qp19Qy/ef3rpDaO4NVWBo+arwcxU
	 tC3XhqTgJ9wCXekRrK07G3t3jYAROFTfl1ZN2kwaLuyM/KAiwENQUs6A9TumsZEqGYygi
	 6z+jsuEdqB3XDv4hJYOuoOS6ay1SfOI0Cg5BAMWWSjYTxYC4liUwIOng2DyR1twC9pSkg
	 GymoP6UupWQZSdSRcHddwuFH/2fTbkj4bYyCGofs5zorduV348C0Vwk6x8ojVpDWEyf1U
	 CeJFp61COvG254B+N4ZDSEyQEUUJeBbeF5vC1N2/yPKzzJxA6K95OvqLgKXeGwk1LOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1zE+lPQ2mVoBm4i2mKyhWeRNe8dzQmiGUgBHXOOf66o=;
	b=EwichdPWZstkSu1spg/DvtvHXXy/MwwcgXfMhB2lcXhOe50EKlpIg2FhDRSX0UpvMg5T
	 ktzy0NxBw4bQaeo7kzyORsRRIYfb9IfyrlOXMoMriAXVTN2hLDNcHsUYcwhhCgwEoE8az
	 DC4Y2tdvHlhqXOXzWholfvJu0U+ZCRzOz3+ld0cqv+w8pW92iF1LSb96Vw+5Km56+G+oW
	 jyhcS+RtxpL6zzNNFh0DhPWo4taowaZcdrWKVIe/orr3GgfhQGJIMxf5k/3d3bMmDgMYF
	 NpH0t8UxwIjSMXKOZOe1i1SReH/gRmIFEPD/B8Bx3WWFK7f+31ODfvj0GR4te7KM/xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698775;
	bh=1zE+lPQ2mVoBm4i2mKyhWeRNe8dzQmiGUgBHXOOf66o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UeFBpaRacTmVtv3XEd+EiPPjsFqabYJhKAMXyQt/1Mis3jQo5PZCWKBzd0fiA5u+e
	 mku4v17TGtCHusGdM5dEobtpPSq+Wqi09GJlSWU9iggYW5bT92QflwTC4WxBeWz2zF
	 21jJDM1CiDKRswRIEzkKsLztzSKmltmGHVrBFFiwYZadIW8k24rH3OUA39wOsNMtIV
	 w3ozdGThpoH2hrblc6B9+4hbccV6gaI22Ge8gXaGWDq4K8yje5PfZJPurDy6AJ+aiZ
	 Yq+pkUi1iXFGP/aSARAhIiPy+Fawxpyi62Bx7//jrd9gq1BY6bn/mB4NL+lQSY6Evi
	 5y6TxMWH8XHcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36B0D60A68;
	Thu, 26 Nov 2026 13:12:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23CB132D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 092458112F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TMi5ZuC1cu7 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:12:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D80E81115
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=N7IHFokh
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D80E81115
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:12:51 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so44971185e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795698770; x=1796303570;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1zE+lPQ2mVoBm4i2mKyhWeRNe8dzQmiGUgBHXOOf66o=;
 b=N7IHFokhuVmKbYxk52h5LLTozZP4FQOSdht7kQa3cvUvJpvPL1OMH1XWiola7eHqYt
 XPGtO9mFb2MUjP6WMtM3By9ixlXchNKRIe690OVR72C+buO81bbfQYdY8jqtqeBNVFaF
 +cLjqkAlEb9eftJgYZAqIiYx3QdIfJfKQ2aIBzJeyC82iGNNtXfvnTO8mlhHcH5CsSN0
 PPZ4/EGfbs3ur8HCsAo+6u3S9XOy7m7iJ/LG3a4v2KyfG03iQc4npZNSAxnaQG0GZ0O5
 GQfsmnHAeYfkhqxcr2PbdTUTpqTAX9gDpf4TXzMZ6UClv49NkSaM1/DfY3uvGdwqPOpf
 3GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795698770; x=1796303570;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1zE+lPQ2mVoBm4i2mKyhWeRNe8dzQmiGUgBHXOOf66o=;
 b=FMPU9UFXB3Q2jHjIj54/SfnljW53mvM4pQsc7rjl+qDRYc2/O0UFgyJWJrDUgApduz
 6+QWXFJ+rNW5pcwmEGZFwi4bOe9mXADCYgRsDbjzudGFcVOuvmmNipE86m+M3RECMOVv
 CPEBChl9kPq8DTEmsDmAx75wYxjihkLGXYp6iYGzIJ9yXRbTLYN/d/HpLM1XFxOnYP41
 jVAPKIeQdfpEy5RZElmrdTKx8a+hcsmC4bUhjiugiarMaFWvKHQ+vWwexo2KAfR+tPNF
 SFBI41RXpwgCd9XXhPMJKkDbie8C+VZsex2AXS8Hn9hX11CBCEUMXtzDodyCCr9cHFdP
 IR7Q==
X-Gm-Message-State: APuU4Z96hYPLXFwd4DYP7BC3CXLb4lIOdaMTv74eB3simtsFRNupop6b
 /dlIKmMF515Q+GRYod7VFmFTIWurCjzOjv35FDjvybpEumvpceL6i9qAR3iQ/X3+mPA=
X-Gm-Gg: AZFdTZdNH3dkNkRZEI3kxmE4jUKONP5V+6zXh3tQ4f3DaIk/f0gra18Nc+h14zmdq0S
 ZNTuThceMAhUW/KqnnEoOoH5DEOuMAXpASl7QKTCfoTYz1bGw+DGM+LZxeRrvfMEYmL+l4NM7Zk
 xkk9vGtBDibjBDXv+jvM5a5XY0KXfBdyA7Tpa1ljpQeip0plWwkDs+hEci6T5O9PnBzTfWnAAx3
 RSkHuBwwfoa8LBFsJ34SOmZFjW6GimotJMtmJwckpSozutbV5QVNaGdyCjmc1XSiz/JbrcrYpP1
 EwPlpwX08VDwmETmoezwm+szKoJrUjyvfO2Cw/mK039ctkiImgj5pA5whPXXjUZc9XmY+GvDDiv
 wx7lEfKl/IJWBPWDItJjYO7wkrYCA5g3hrlJhU+SsnpKTNH8JoB6vFycX4M7KHHLNLyk6zcQXj5
 xixa/rG84Ov64DaKVtRfoUttDwsmhaA8cVk38p3lIiLCeT5UAzuGEbo1Y6+WA+5aPmdkGV7bo2u
 IKAEbmQtUNgJR2aH+DuUEZfrUXPXgIKrRgxKiudEm+teHVv7a5cWNqm9QqGX58mLrfug1SxwGou
 hZ2ERiXgpv08x0/LOFiR4EAMPJdMBntW1wxBpoq+B+zsTj9Jli/t1JCrQopH7qv4yk5/E0ja
X-Received: by 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4bb8880b984mr491721195e9.14.1795698769949; 
 Thu, 26 Nov 2026 05:12:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm232624425e9.4.2026.11.26.05.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:12:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: spacemit: k3: use dummy clock to solve parent lookup
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261121-05-spacemit-k3-clk-dummy-v1-1-966f095638a9@kernel.org>
References: <20261121-05-spacemit-k3-clk-dummy-v1-1-966f095638a9@kernel.org>
Date: Thu, 26 Nov 2026 14:12:47 +0100
Message-Id: <179569876734.2402123.14735167185376437596.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795698769; l=924;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=yPXzQgtNPZXILMngX+rPLBedqSSxfCkaZ8rUsySgmd8=;
 b=m3pMZa6fFXH2F2FR1odbEfooDFhNqcWsuKI0ZXfYDoal/3saHR8QEACsju0rXsncu5oEKiWCG
 7bW1MtlNtmvA6dOUYG7d5sqRI7YThe7TWSdb3U8xhAk17HyxCj+CCw0
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 21 Nov 2026 03:29:57 +0000, Yixun Lan <dlan@kernel.org> wrote:

Hi Yixun,

> Clock named "external_clk" is defined outside the clock subset tree
> which is not registered yet, fallback to use "clock-dummy" instead,
> so the framework can resolve the parent clock lookup successfully.
> 
> As the result, it fixes following clock warning:
>  clk_register: failed to get external_clk device (parent of espi_sclk)

Tested on a K3 Pico-ITX booting through your SPI NOR SPL series
(with Anand's pinctrl v2 and Junhui's LPDDR5 v1): without this patch
the warning shows up in both SPL and U-Boot proper, with it both are
clean. On main with U-Boot proper started by the vendor FSBL, the
warning does not show up at all.

Thanks,
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
