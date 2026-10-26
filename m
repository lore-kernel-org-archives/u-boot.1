Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE1606A337
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t23ypJIJ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XZkOnsRr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FE1C40561;
	Mon, 26 Oct 2026 10:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55ghK7mFckNV; Mon, 26 Oct 2026 10:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6D3C440562
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793009430;
	b=UeK/1he+DQh2eBhFp/+wGTtNZBXV5Kn+4uVNrR0UzhZfWYR0D9XMRjJ0WgNZu/cV5ASo
	 l3Ceu+UtiBJNXnPmxvo4iiC1fsV/XfKCBNQ1SEcYiahCNxuYhcFfyLEVeh39quEogLxPM
	 vNTGBQ4t0f7wWwWWhui7m324XgxfDosLDHi4Qd53dacspIvKc1QROQT0EJJoYWa+IfV7C
	 KH+x6PZOuJOcUZ98C+LQ+uDF2FsesDqaHMF4M9QAHG2NRRuE1ePdGv0LlAgO8B8hiTJBp
	 XM9EuuRnVqPzLBr6bUOE0fc9CAiUQ6K6On/C5EJshQozheckCQyJT0SMEwZ0/LFohxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793009430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xWUxrBaRtnxs/bZ+4DuyaEHG2B0N3qKARXzicrnTv44=;
	b=OIZQO/KBAGhJCaCZe1Hz3yjrrxi3lOEsOJ33QbwO0kV5L9JtO5wvMubQJhebeqz7GA8q
	 R2VHOK80DM167p8Bagy+gyM0rbhr7zpH58r4kMs37f60AqiPKzzIhscqDAd02bdnEdD0R
	 H0dX6V4/kQQdrO2RU0LqUsv+B6d/PcCYKlCXjdcAXD8N5Flsy4YrgvAhXfNPaeF6KPK5l
	 xFuDyFPlU1KPeAFFxNMqzY9q0s9JfknAtJ40QpTRAhK2utzMNQ9x351RcY7UPzU74uM6b
	 CaaKLMgtGHUeGE5nzxlNYFQ/KqrmJZ5ZXP7Tac2vZUaA2pt0SFuSLLPPSjWTj5w+GYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793009430;
	bh=xWUxrBaRtnxs/bZ+4DuyaEHG2B0N3qKARXzicrnTv44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t23ypJIJK25xhC1l8/hbP1uv2a5/ukqbAXzVuR+fH6q7+qrTrfUuyHnodateTMOPV
	 edXUhk6TIkkrpLmLqbH0vdhH8guD5Xnn4O6UiICoJBUMqvTZ9ScYDtGt29e2iKwbBM
	 oPpYkiOuLEUH/GUTS3aCuXUyjGXssOBy101NtHwFqEfjASFXK4ROXqi6H2AcED+mh2
	 ON8YRSxRxJ2JH5qBXWC4tvoYKsMhjK+Q1bWO3OTpBcXzNlgDudn7oLdcmfccqOfUAq
	 i3e7o37ubu0FIG5cWTk9o2XGmrvDLUdf9E7JEyY2jxRvvyStedEkcggDMdVCeTDsH4
	 ew/4iLJ2ok/jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D3C440562;
	Mon, 26 Oct 2026 10:10:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CB8E43
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52A536061B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBSKeTsLWnzR for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 10:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D00DB60607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793009428;
 b=VR1LFXF9oLemhPxOUMrecHB25At28M9Meo/4SlK3A79PbPJNKDQda3YKs4FuyAOBnIb4
 9rlgnqPKef5SFLL/SKnoyFKJ9Q8pjC2KK5jftFmu4ODNDPfrKD3w6e6Ec3E8/hd4EZDfE
 yr3DCruu6304ItCf3acRdtxaj/G9AdMpJx+d9Q/0rFIEV4/vTp3IBUx6jrXqFs46jNSXi
 vRwzF5rtR5khZPcvYw5Y2K/AgTeAtCodgw6SHWR9GwpwLQEuc6ZJy+ICtY3HSd9JyqyIx
 QaNeCtsC/7iai5G5Bn6wf/HKYZd0C8/hVSi4O4KEbVeTH+uyzFjzzKpqMscOwoPvCPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793009428;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To;
 bh=xWUxrBaRtnxs/bZ+4DuyaEHG2B0N3qKARXzicrnTv44=;
 b=sGIgNoBtcsrZIiOPmEjIknSy4RadE695SUQENGmZfP9H4lO6XweT3vlogc7km4dkuq+x
 dzKlaPy4UCGZr8+1wBhRKNY0TPtHWdhWb8Mvu3agRKlzy6L9XFqEXgy6dEpvqHZJ3WbpJ
 9H/B1K6JPSQLO1nCWuL1XSORyFYD2kcCo/l9B/zIS9cPZe/N728V0hYZMzzKi3ofVjq1I
 J33uPf37DQ3TPVR2S7H2CAEtWOSAjlgYiuz5b7B3XqfFGEptvhDCWnyE9iF0ehvMUJbtE
 1Uwot29eWjYeEzycYPvq7lzv0DYMvAfzyLNMuRAze76OHLagOHMks/lxOR++AMyQTpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XZkOnsRr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XZkOnsRr
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D00DB60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:10:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso21199465e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793009425; x=1793614225;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xWUxrBaRtnxs/bZ+4DuyaEHG2B0N3qKARXzicrnTv44=;
 b=XZkOnsRr4Ios7ZTF10Qgu2xsLmFw+rzQ021tgvkKVBue5/v/sv6nyicQzl8c0ByNCs
 OoNaGGONH5G94AbmA+nGNpIapNhBQvA5IEBcGfvjwD0U7Uo+NJaEHip++Z5kOsd5wRcW
 Em+H0+0ZvGhFZ4bXWbLCQ2WhFJllhxZRPDsWk9tvLZHhsG5loQWA65ClPcNOVWmEaFvi
 VaMm3+ysZugk9FYG+cWixj8UQdBTbNkOzmd+1r+kp52yOhtMQx2C5r23L3MTCfjvtxoH
 ZWC3F8qTXihy8zHjSn/2UrjsK+X/48QLBeQOTkFnQ8l34Ip0K7FUfr8VVmGiwWviPNNF
 HShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009425; x=1793614225;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xWUxrBaRtnxs/bZ+4DuyaEHG2B0N3qKARXzicrnTv44=;
 b=GTXZA/lmUg/bKacn0xmIZY/OBJF72+gAf4SdXyGdE08OlmIPqozWDW/G42/AVvSXM5
 R9WShkjHJqI4Vnu/ykhYMCkK4xbGGk+IP1PaiUh/X9xY4pTo0N/0dJyPQx1SFvCkq0yc
 FPyYYnULSp/N2em9Wub07/l7c5pbl6UXAtRQgVnfvqjDC3iS2MbdZVpIDXQuFhljZyEw
 DlkuImnp6u9GQQsmc/64iHpAGvMSYXA+gpaRIthSXu7kNZGnx9OpqyjntzRO8lr5Miv3
 tgBODQn4FKWfeOumtdHPfF14D4ZxP6Ma5jWang+dvC5DZ1PVC9K7Nuy4Ji04XkGPDvt0
 Bu6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByeGguUZVvO7F52/t7eKmS2B535b3LnX4LDVJV27YNPkdPs8WqiK0ArZMH9pf0tvu3Tzt+xZ9E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJyoWvUAz2swzl5qa4DxGGCSHRylRgbtjyiw/1obqBSWE7byR0K
 hSIOZ+9v1QJkWLKoX3HJxfQhIk4qn9vq/UL3YT4PZAICqArEr/2BMt3rKnbPF3KPIvKObnev15B
 r23Sm
X-Gm-Gg: AYBFou3ZJ4ymLRKtXGfuYq7oYM9rpJt4KWqrZ+SkYJlWZ0WxjwuuGqMv+XHravVqkyw
 ia170xII6ITWahGWCSO44xgVR0UOLZg06yxrGKgtjcFYKcrQqghGvZcn+Pp4Mf8IZyhH/w7acma
 9KVwFYM48SDilxT2QMRn4VyfSOWqHyeMPIRdH8S82gU42rXjPSy2pi/ABjkdVZ+H3azRP45z0WY
 oArk3Q7BiafxylZKhEILUFI4OQq2567OxdGzGUKShbHnNmNwxuOMe46xoJ5Se/vp7aW9pflz5s8
 kqH1I71muFoGp1bjpx0siFySla9DPbrqHIbXJ/KlnkPX7qWqZuDjZNR5ZrnfNYXxDeyEIDWdYqr
 FqayieslljSKIuC4Qat9ZWP8701QJaxFnrSjPEebp0zvlhTy+O4n6jT7idcSbgH6AlJODe59oFf
 j88BMeZ56KRNAvvl3lq9OQnvAOTv83Uod019S6CmznCzMsIVdZDShMzPVK/K2R/fwK2sIFVvMBf
 vXEZrBSA57X0ew/bHGtL1g+Cirzh5NOmJGAU3lbJrjHHC4TG2xJbQl/REXKcDZIg20yZ5YrOO9K
 I0xzqL9/CI38Ppd67SpyECkUBJqu3nPeJh4P2PzKjqKNj2n8wfnq9Dx5yw32VqvjMgw8LGn8
X-Received: by 2002:a05:600c:3115:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4a35ac9f6a7mr118738955e9.21.1793009425184; 
 Mon, 26 Oct 2026 03:10:25 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359ff2189sm217704605e9.1.2026.10.26.03.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:10:24 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:10:22 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 7/7] doc: board: mediatek: document Genio 520 and 720 boot
Message-ID: <at8kDWMc8mmUKmeT@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-7-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023-mtk-genio-720-spl-v1-7-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:13 +0100, David Lechner wrote:
> Add a board page for the Genio 520 and Genio 720 EVKs. It describes
> how to build U-Boot proper as BL33 for the platform's own BL2, and the
> DRAM description that the earlier boot stage passes in a transfer list.
> 
> It also describes the optional U-Boot SPL boot chain. This covers the
> DDR-loader handoff contract, the MT8189 image layout and the eMMC
> BootROM size limit, as well as the build and install steps.

[...]

> +U-Boot proper applies the overlay to its devicetree and passes the reserved
> +regions on to the OS. The transfer list is passed to U-Boot in ``x0`` to
> +``x3``, following the register convention of the Firmware Handoff
> +specification. Without a transfer list, U-Boot uses the ``memory`` node of its
> +own devicetree, which describes 8 GiB of DRAM.

I'm confused how the DRAM reservations propagated when the OS boots with
a separate DTB.

As far as I can see, the firmware overlay is applied only to U-Boot’s
control DT. The normal OS DT fixups update the memory banks, but do
not copy these additional reserved-memory nodes. This also applies with
OF_UPSTREAM: the control DT and the DTB passed to Linux can still be
separate trees.

If the distro supplies a DTB without these reservations, Linux could
therefore use the DRAM-controller tracking buffers, even though U-Boot
correctly reserves them.

Am I missing an existing fixup that handles this? Otherwise, I think we
need to propagate these reservations into the OS DT before booting. The
documentation currently says they are passed to the OS, but that appears
to depend on which DTB is used.

Cheers!

--
Carlo Caione
