Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0208FC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 08:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EE5E40471;
	Sun,  6 Sep 2026 08:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YB2rSRjgciv2; Sun,  6 Sep 2026 08:04:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DE3D6404F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788681896;
	b=LMU9Xb9UDBpiN2YKTbQ7Hcnie1QOip6W6+7qbs3m3X4OAcLbI7wDn9RpHrdMOybNruR6
	 Rb6l/MgwNS4LOwpSzBYfxcUtGiRKXGZ2eJZhZGKhPZmH6kvCYRzUl1rC5dp4sef6FgXW4
	 M3MLThUlesqRKHk+0IB8SndIF5RLrRFpAL4R8lqJxSdnhLvGaa+WF/BI6508DDkgi3dHU
	 Dbv5BpPKXpvcR/027SgrrjHQAs5/s/HT8quyobvRrYt1R8nDf7FuC6nLwar6N2dFTKGrc
	 jssMQFn/0vwtyDZux5v/HYubMYhq4TijKXgprKxKG5+uQszKOr5MTkSuVmpAUqcEcAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788681896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=daijM7ZFCjhq/qxsGiS3i8BiOkzjO/TJCeePYrD+IC8=;
	b=ojqq0x3n3A/eewp3xfslsvhbqfkDVk+1ilTX6rJdJAmvRKTEUxyrzomZ4+CCPFAx0a7y
	 tktb8PS3WxKYGmrsWa38OoURqoKxx+cFUJ5mwyePCe0vP+tH5FJF0uPzDLIal/bWCVTS9
	 f97sE+prnrbAq4jTx3ime7uieuX/oN62gW5pGtHcm29s/uGhWF/mdExrgS7ZKk4uOxf9c
	 LUeqIQR/B03i9F+U8FDWffavCvX4WazNUt50HwPw3arfDL3LH6HCEOGQENcdX/qN0JhYn
	 wJz5V7UnCgl0CkEYoPPQiRt3VNPofMCx6wfpmoDIjKZPLjWNj5YQo3F8pqpNdKUJOpg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fQasmonD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788681896;
	bh=daijM7ZFCjhq/qxsGiS3i8BiOkzjO/TJCeePYrD+IC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJIxyMFkugU+yi2DBe2eYgW6Oo6tlB/g25Iq9DOXpmbd0+wbh+rcNxUzxhlL55WrH
	 tdFwB6q+iBL46EuViRVLduQMN+In6EMxqr9xJRmHhI+JeYCmRZ8vdxMyCI5jUoWIRb
	 kVCuMBV0nAQP+5cmwfJ4RIowQKV1X9/i3Cmzqb3ojlF0YxoKMpTxgGRKqajpI3SlOn
	 yY/7q7rTxG4XWf2mCz83ixtcZ3A7BH21R9i6x7e4VbuWv9bzF2mOrTtyE7xWjsrcjF
	 x+qjIp0ICX7SbT/PQXFqJyzT/SKtTEnsxnYc4IH6MzlJXrEPq66ZVBwM+Au8vCUGnq
	 c2fF+F7hJvfzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE3D6404F9;
	Sun,  6 Sep 2026 08:04:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABE56990
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D0CA404F9
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5D-JfdNj-NdP for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 08:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D17AA40471
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788681893;
 b=XEm/j/rFozl+OPvUqHPoOmDTEH+SBsQ4hHljsmhqzxMg4m/uMsV4Ec1KAwAU4O2pLr4f
 sUypays2+DK2fHz47qm97gCFKbwAubA/92MGpNCPm1gDTOcIPWrLqbLwApJseqegDzT7A
 bnysA9aJ7SnsXjY/Dtojj4MrR8g8Mc3GteC1jHgStscjfSXAF+clikBUfCRiIYcEZzDnd
 VELvlo04WAkBDwJcolPPDByPMCTlnyqw5KEOPR9dx+DnhoK1Jd0YDjbkO0yjNVt82CHgQ
 JzItoCOcvpQVk/lZeM14wA6zbOLLK2lijkY6auD/RIsYdc0WwHP6IM0NuCX2IqVp0GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788681893;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=daijM7ZFCjhq/qxsGiS3i8BiOkzjO/TJCeePYrD+IC8=;
 b=Yj9ivyzKzOjmKdZFsgD8hwlVUQUzyAX2TZ2hAZIVClO9qzBe66faoRlxa+F2s/NCqdcu
 DLKXhQXz5Ydhtn78G3ToWqqvMXdzFtLLXm87aLfeERGK6WwzJoLqLoFJtG77jyoI3jFr9
 fVbki2fjzXtplQkFaniV63Mdgx/WPLHUS2TvovVwDDDWOGH9mDJj7kiNvgV0QUnog9ZRE
 6LA3DVZF8sbh3vpZaF4SkWSeXJGsur+isY9KoTEHlWu4YPaEXlLEGk9adPCrunDL98zCt
 Iqt7V89R9rq1rBp2rM9f6LIhiiTmRuqccyRay3DwFv+vMq9JqtJdPQrs671qP3YaXDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fQasmonD; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fQasmonD
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D17AA40471
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:04:50 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso25610045e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788681889; x=1789286689;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=daijM7ZFCjhq/qxsGiS3i8BiOkzjO/TJCeePYrD+IC8=;
 b=fQasmonDF8d3bEBhXwHA9H9VtwDPdJbHKcoAnGm+A+RBMWugwq0t3NkPIG4ZHCaK9i
 ssWfDSvCcWQ9MS8uolC+LXpzXQwl/jN763IoKseeg+OxRHxRdd4Ow19hrxl+Ika5wlR0
 6GndHyvnhsyCItRU/+45KVBYnGK1MC+C7SaNNDeplCBPZKGO7FLeLD/O1bVFVL5T0pum
 zI52IKiPAQtUPJNMSzjt/y5d8//FRy89kS555IJ5QnRpqQqowlwI+umlOyCqjymPZ0gg
 WBzrQB7m8SMDf08+28iL5xKRsTspyTUKa8sBvL0fkpDEDM2keU56qgTAYn8q92BaxUOx
 XaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788681889; x=1789286689;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=daijM7ZFCjhq/qxsGiS3i8BiOkzjO/TJCeePYrD+IC8=;
 b=a8/VorQZQKQtKXgGT2co/+wYMLA2i8mMrZayneMTS+GgO4f8AKd+8LVlAfTSmdPG2p
 y+OdiIr791dJMwHAscYACWX5lznjjZlkXr4BjtYN96u1QavHz24Sw8uzOupJ7pZnCFzT
 bRNOwWo/lTytWgcgHmS52fhqOgg0tp0AFOOl45hwBOyXykuKv2yZux1R9KMthBhSybpe
 e4cWbrLWaoX/gk0xf6OOt2LAfRDJtVA54GEJk7PBdbcjPli3Irnw2zPFlFxAmT7Zn3Ei
 hABsFqzQ8ud/mVIwIMr9G4V6SVntAg3NpJQLfs6RT3757NCL3is41METOx8A6Vr9LqvM
 sdAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBymr7gy2xx17GfCiInomggcLsx7aezmkhRXKTEplTSxbDitHWzJM/Q3HSYnn1Lmzs/8PHeaSvM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k4cfosbTdMu6BfuRDNgovtcfNjXhLEo1lLIRPEZ84NyyGelTTX
 UoT5zDSv4j6y5a2ojarL+j1auSaU+C4nznHj/9jD3OkMPrbJp06po7z3rW9SXYCeJzM=
X-Gm-Gg: AYBFou2Ak8WXRM4e+CuaFxYwn1INCF8wsz2y66FUJiRRszp7T0X2AaRsir4oo0khweg
 Qo0lGQbEMfl1a7F8nnUcy9I+li6VU/mUQhu37l7bw5bKE/aWm3fUo62VrxzPX468a4si8bVeyO6
 YeMeCwMlYPi5ZaKUZLb/syLqJEHNzidCEmUFt3+NBzWn1KI22FIFAvNLemRCFcuhxKy7GYJNtKW
 Wi+KLXgX94Fkt85vFU1jIcNiYX0EZyl4+adxYqbiAvIAg5EuiyVFKXTh4yaylo2CV1xwav+xK0q
 Hy9yigNjBKZWrvHpPP63H4ZX0NQoR7w1KtGAF2geyHIC7WaE/GUBY6tm0PAKJkiDzgllKsr4fh1
 VK4xEqUN95YFNr9xb4w5SWbOElV3ceYz4CTrhJrVstqljfWrpzcpgdyQbR6LYWMERhFhgqGEwN+
 YG7jdEH9AdCvhIYZs10KCtkxWxFh3Sg26sqehWoqC2Q064cgAugRfImcNU3yRASxhm74ah9qY2x
 smdTCy5vNppshRguWaRjrP/9Jwspxa9pCW9I0LzDeFiOdc=
X-Received: by 2002:a05:600c:1990:b0:49c:f512:2361 with SMTP id
 5b1f17b1804b1-49cf82524a2mr234594825e9.14.1788681888305; 
 Sun, 06 Sep 2026 01:04:48 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm257912885e9.10.2026.09.06.01.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 01:04:47 -0700 (PDT)
Date: Sun, 6 Sep 2026 10:04:46 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Alexey Charkov <alchark@gmail.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v5 0/6] Add Genio 510 and Genio 700 SPL boot support
Message-ID: <ap0ecfNQ_RWYTGvb@macbook>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
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

On Thu, Aug 27, 2026 at 09:34:57 +0100, Carlo Caione wrote:
> The Genio 510 and Genio 700 boot chains use a platform DDR loader built
> separately from U-Boot to initialize DRAM before entering U-Boot SPL. Add
> the shared SPL devicetree and configuration needed to initialize the debug
> UART, watchdog, pinctrl and eMMC, then load a conventional FIT from the
> bootloaders GPT partition.
 
Do not review this. I received some off-list suggestions that I'm going
to implement in V6.

Cheers,

--
Carlo Caione
