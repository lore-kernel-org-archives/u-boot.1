Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BE606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cpcw1Qpb;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SKYh9VeM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E1576075E;
	Tue, 27 Oct 2026 13:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DNPChJVFqnGU; Tue, 27 Oct 2026 13:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F84860786
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793106472;
	b=ILDeTe85MFZidROP/S74PV6fnlXBeUwJLRib/9S8N80j5LmwshnrZZnViU03r+DzRAOM
	 0d9CzS3lOzJ0HcMKxKczoV95xt8MZAQhdqN2K4bvYOlXBEgiWyrKVxL4rNYm95jqNtLRR
	 EX1pKY3/TJht3twQYdcpDlwGiyZ4g5Uug2af8OUvleDNgIIIxUhSP3XaAGaB6fC7YCAC1
	 7FkqFFYUSG/i+1h1+LztnrxYX3T1ekXMvJR8L3qAbfkEche+vrzg91U6g3+wmS+JayqTd
	 4lrgeoQTg16GB33OGeR98zTYqEJLfktGwMGKg+0qe7EozW6c6Z7bBIywZUdNZ8Xr+og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793106472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gIgpUt18MmA5mdZ68N8+GSf+yXbKx8YS37zPZ+pnXNM=;
	b=Qpm3OsT0drJv8qh5oh5htx7QVLkbfLNmyXIZmD6lv8/h1nHR16pbFCMjGgO0sSQab20B
	 h2g1k3efu71Zn9b05O9q9ydWEfftjC3HNOScDbpzz+W18lcqW72Y716DEjkUwIzybLXoh
	 jQbaxQbQbLdoiih4x+hloLL81pOhCkif/VNT+G4/6H8cE4drFZX6JOLNbaFxDUbn3NlDq
	 gB4vDjlay8nMagUA3PsP1jLX3RyaPKHoOHU9moassqHSFZwz6y2nt+AlDUcMD6J0clXDG
	 lMhVZ6adGbQeJk6DKy8cXbTtmHUbwkG7IomAoT+NSHC5lvqaFBdXN8duOzOHQDB4slQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793106472;
	bh=gIgpUt18MmA5mdZ68N8+GSf+yXbKx8YS37zPZ+pnXNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cpcw1Qpbzw3loA+VE+TCiLWXEQg6CI8tdhkhpLgJU+xAmhNO/PvaAh17lUqigqgBz
	 rNBAVwiw//TbwSTdZJmhwxqc6wSPvg6xYId4M2tHF03flRJ2j8MIs+bQrzVxlWL3dM
	 CfEMoPa+dZhZnTa5bNSBTsS3SABSFbTPbFGvrqCQIunGjtUcBbOMjmqh5BBXJsRV4h
	 R1WLE69jvAJm5pV6BnH0JfH2MthlMZ+n2m0YHsBtdzGMtJinlRrrTnoH769s63g+7g
	 1mYCuFlfP6ZESbv5aOANFPRYTmHixUEEcvpGaiAF9o6ORULQ6FwDjxafbbd/OD2Lcw
	 TelsuCjOCh45A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F84860786;
	Tue, 27 Oct 2026 13:07:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24FA23D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1714B40545
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9149PpeOduv for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E20FB4053C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793105522;
 b=I7ipvsiLBS+5QxSG/VgXWIxYW16PKMRsvGTulOMucrg18dVerTC1PtLzGrXO3j54GJLg
 r3KrJJlQp1t2w7rEmUtc3+BHxjLilqxI9NsXYkmoIfSdeXy8stYtUcPABOn5HCW4kZw3G
 coXFnxqFj8OCeOTfTdkQePeyd81nrRFGQYbDy3z3VkRjmeEE7A76o4FfX0qXCnaVwFhbR
 gTpkGqh9+67nqSHehVuFwGE9UAG1AWETqThlvKuL9L+bXL19Ad1FXhdObdjXNEwNj4YAX
 ASRYezLKaLsWaxNTVHRMG3zvbq/h9xYNZkNGDXB0KRxWMVFFQD007dZFdyVWN8q5FvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793105522;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=gIgpUt18MmA5mdZ68N8+GSf+yXbKx8YS37zPZ+pnXNM=;
 b=kj60CujkkWvswMlKe3UxmYknDovH6NXq+5KNO3MjYOX/Okm1Fb0ebmX2yOljh6/sf+Ra
 uiz7UGqQx268GbqdNI1MeexB/X+wXQ/6oKfWL4vqxOuoQE9WvAwYY+iHVI9HOjKwFNzha
 tuwjoe94Sag36IZxedWx3WO1zoqR36N9goxRU4zMh11SdfYcyHmXcBeUZRhpgI1KtD6yz
 rM0u+67IW+JMeqLJvaukXhGjUxL5HicIUssrj6eH/8WFM0vdkL2YuCyI1LDZOZUHdTZA5
 eBB71JNd46+IvPpXw1igkF+XDaBK8yy4M+YXguYUaZm2Kp8n+uz2UVTqQ5kG3V/wnTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SKYh9VeM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SKYh9VeM
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E20FB4053C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:52:01 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c40db84b4b5so43986466b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793105519; x=1793710319;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gIgpUt18MmA5mdZ68N8+GSf+yXbKx8YS37zPZ+pnXNM=;
 b=SKYh9VeM4WXN16o1m+uRLUzPRkmbLG/ELdg8O62BhR3PDkvO6p/gCEYz0K/19G1QSL
 AI5rsTTgEb9d5cGyi3J5xb18NHk07TFTcLYS9rP+kbbnoO0S37MhDr5u986uMBT0iswC
 tsf9zd97KiXDMdrZg4+l2L9Yx0ImCDDF2aMPZ+t3qr/PIkdEF0I4EcXa45bFwsB9COfE
 QHL6xaaM8gvCI/fNvBhLf5X3Gz/c7zIFjplFRiUV0KAzSi+tmmFHZEtPHtF3VhFENS54
 yx3bqg0aQyNDg1qVoj1pUwJ2a87x+fsv7H98tLPtEY3cqadKQh00xNyLumuvj7BNgS4d
 Y1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105519; x=1793710319;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gIgpUt18MmA5mdZ68N8+GSf+yXbKx8YS37zPZ+pnXNM=;
 b=L17DXRtgxhIYs/+uBONeLl1C1O+/52+QyqPbB7oyPQMeNqEAldZnGcBRtOQFjAYkWZ
 jeEoSXQ6g9xghehfW0epZgP/1ENIYGFDoPRSd+nP9bGoFvDc48Tdzth9VmetzvebdLVN
 lWuQhrr0s+pqcwAveRcyW3L/NuzKyaHsxwmMeAn4Be0k6jCbSfq+bkcg68Bg/+8Qrrr9
 68EXqMZEoRpbWaovys3837eA+2I26ijG/r/gibjXnJPaxz0nkTQc3g4RuySq+vJOcM+u
 76nKrQfUTFO7h8HyXEawb734dWOmMSCNY2XAx5Ctp64u7SVedU8blre4GwxueKp29XKp
 y2HQ==
X-Gm-Message-State: AFq9FYKO6DlCfDLIGN8dabKMNVoTf4rz0b6YN5dbJxHGN0ubzyVjMeGu
 Lk5I7JOFGJmw8OyN4vnGyZybahcG8Dw+GnLcNs2kCu5XmzoEEeAJh8iCxa5aIM+R3II=
X-Gm-Gg: AYBFou1SIo6kcHneVD5TmaHHgJXUIw4n6707WWGA7YakYP6T+HXAye8CPcRTbV9u2aZ
 7v5teamm5LxrJw9fqEhQdev86jDcCNjncO6pVY1P/oX05Qyv/ShLh33+g6asx9enK93H5MKxuj/
 fqLrhUaDc/G5Fg4O4EL2pJR09n6OeVbYlL5/BDDzbNHV69ZdU6SOvr6IhHtSBfovX9kSyTOV/I7
 MOrAVIwzptfP400kY9wZy7fDxZ/vdnbdH1s73wGcu/eG1cAcXF4bqGdxrUCIr1cOgVZhwYYDVlP
 O+u5uLWn5us/g/vZ0qA/8Q12xLEzP8ONh6o7FH83QIdEiJ8K5+vLGavYWVyH9zTf7jkfe82X3j/
 LF2gKrTB+5BRs01Rn85itsX/63o0QWPJpGUBKUELpe8Bf1SpYy9YcPCCNbcSpg+Go1Jhqk+QBze
 64N0fjjvs2ebl1pvS9yYc7t001sUPuIFDLaTMfwLi/m3x5kQT5D450sSjipU6T9FHATfb43kW8x
 ehg9+1/IVBT+diXXUUNZbJ2cxM3UJWZmDWTOcTh5WskSnOthxcoEUbYNMLGvQbs9qitzLBlm/+e
 VchsqSmYkMRRCw==
X-Received: by 2002:a17:906:aacf:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c46bdbfef75mr1071016566b.4.1793105519184; 
 Tue, 27 Oct 2026 05:51:59 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd5202d9sm449120666b.32.2026.10.27.05.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:51:58 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:51:56 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 06/26] usb: dwc3: make the core driver build in U-Boot
Message-ID: <auCebKc24W9Ffc4v@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-7-anders.roxell@linaro.org>
 <154369a8-9922-48eb-bf1f-777ed8113c36@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154369a8-9922-48eb-bf1f-777ed8113c36@mailbox.org>
X-Mailman-Approved-At: Tue, 27 Oct 2026 13:07:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 13:42, Marek Vasut wrote:
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> > Adapt the DWC3 core files to U-Boot: core, io, Makefile and the omap and
> > ti phy glue.
> > 
> > core.c is a big diff because the kernel file is trimmed to what U-Boot
> > builds. The main changes: rename struct device to udevice, use
> > generic_phy_init() instead of phy_init(), and drop the host-only and DRD
> > paths U-Boot does not use.
> > 
> > U-Boot gets the dwc3 clocks in the glue driver through the DM clock
> > framework, not in the core. So dwc3_clk_enable() is dropped. We kept
> > dwc3_clk_disable() in dwc3_core_exit(), but the core never gets these
> > clocks, so it does nothing. It can go in a follow-up.
> > 
> > Keep the U-Boot Makefile instead of the kernel one. The kernel Makefile
> > lists glue drivers and core files that we do not import, like dwc3-qcom,
> > dwc3-pci, host.c, drd.c and ulpi.c. The source files are not there and
> > the CONFIG symbols do not exist in our Kconfig, so those lines are dead
> > text. Only keep the entries we can build.
> > 
> > Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >   drivers/usb/dwc3/Makefile     |   17 +-
> >   drivers/usb/dwc3/core.c       | 1761 ++++++++-------------------------
> How do you think I can review this ?

Fair point. In v10 it is four patches:
- remove the code U-Boot does not use
- bring back the U-Boot entry points
- adapt to the U-Boot APIs
- fix up io.h, the Makefile and the TI glue

Cheers,
Anders
