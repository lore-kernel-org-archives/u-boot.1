Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E2606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wl3cUlT/;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UoU3tkLx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAA6F6071C;
	Thu, 12 Nov 2026 22:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11xdQLQ2kUjn; Thu, 12 Nov 2026 22:09:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F848606CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794521396;
	b=JPQEPMWc2TelsJeYTiCZCjjfdXCuz+ciYxevnF4H0ibFAAbkE7j4h7+EDz+XtBZG/lZB
	 N/lLFELNAzEcxGKZfNF7trIWnW39VN2fARUZKdvdIL+4fOtsIggex8tu+XJ7lLjtZPzPR
	 DPSMTkD8ZG/g0kb+VThvyULkFZGThkiTKbCsDE+2Ivs/HcpapuHR7o+VMxQPyVjnUyUgt
	 kR3me37EGfUXQK7b56CTGZd2EeijvRccUrUTtg6Lw/Xcg3dkKokeVh3MDqaRNuMkD18D2
	 eDWuigA+YIpDW3N855osGyU0V7RtVLt5g3sN7+F1xS+NbsNkV3k0mYsi7e8nkugpA8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794521396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f/F/6HWoYVPz+/4NUBxYi7PThg1NkIWsK8Gv4hVrXQM=;
	b=AsnQ4hwV0qinMFPH1meZP3Kn9CZoTygxjbpS8LJ4jP0hqEARs5uLsxpkBHgpIGrDQBCh
	 hokM73hl1ql71cbsR09Rbn5kjG+Xrhr96qb4esRAf4ISukjsSoDAsiqrVcxUl34ggvaAa
	 KC9RK+C3It+ppDNPx7rf3nd0gFR+Y424j8DajZc0/zPYAXxHsp/RmULq6lM7iiVJplhs6
	 Ou1VFVjefzKCwPcs/KvlGa2uurBl9QzL/liPuG2k1E3oFh0XGf8KLKQZdLblTAOo6fkGD
	 /QsNb7tIcJ+bhkefNDhRinPXsHUAB/QtlkEHuyD5BWpAy9npBYExbumZQyfL2W9P0uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UoU3tkLx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794521396;
	bh=f/F/6HWoYVPz+/4NUBxYi7PThg1NkIWsK8Gv4hVrXQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wl3cUlT/vLGVu3upro33YuaMTMfCYwHBKyENinf8B/IMQBHLc4EDT7kBalBHhtg+l
	 JXsm7CXMhNsTzsrEwZmCURdkeJ5pSthvYNRwiFIfbig+8bZ69CPCphvtGzFqH7Y7kh
	 oYx2A+KLpFNG5UufVIo2eLcnBSiYPOLrDmvBT+XKsj+nps8mpnXDobhF0N+TDyaDp7
	 zWUNj9JLBwMAOnPqGdDKYec8ofCBQIpTPuchvDQDvEDer/mFJWxacmFgxJ52Led08a
	 VVZHhXN+AEjGswm8x/HgbptBS9PYwGlDZTRJWRC/x+9pab/U+uB6X0sWnE2ltqUUfT
	 6axv9rex0m4Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F848606CF;
	Thu, 12 Nov 2026 22:09:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D77981370
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B48CA606CF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QDFz-NTm1AX8 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 22:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9357606A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UoU3tkLx
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9357606A7
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:09:52 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so3376245e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794521391; x=1795126191;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f/F/6HWoYVPz+/4NUBxYi7PThg1NkIWsK8Gv4hVrXQM=;
 b=UoU3tkLxb2P0FMyt+SSdiQlbE0tDq4LnvOayj8TUdEwdKZva4Prh+IhAaQ0/Ew+v3v
 c3rNkZ+AzbgEXAHVWbiLf9tj24W9N7PQcoL7Uf2mVsG7XuskoLBmxLRFT5ndxGtBh1Q3
 LCVQ2XWsJnz9Z4Kr5jrbnj1zRoX8vEQQSLjXpejR4u+UPF+HGRx27DBfN1qqs1Vsq9sJ
 REwycPGj+xKerjch5E3pHCh3NbB13S2EvFoIdwA/sDXTlTfROD1M2SJGGTgV66Oeq5fS
 d7gMa8TN1yBal4eVuOnqAECON5P4pyiEfq8idBWJ8Zw31QIGdxp0iCrGbq83WWjvNneH
 Od/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794521391; x=1795126191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/F/6HWoYVPz+/4NUBxYi7PThg1NkIWsK8Gv4hVrXQM=;
 b=jeX3E3rVjw5KJwZLzi4OKQryVQuJTVbXDWTsA7jGRmSQ41cYsmjpXEMQ6jVMpICZII
 FW2iQc+VGrmVfOMaiAIm04SEwR0XNdfOev72dnF9GLdkRHN8C7/adFZ7P71fuILB1V58
 lmwFskUiZTpOHCPIAQj6VM47cWPrc8WLK7+a4wcTPTJiNml6U+PQgGS8taUUkaDsiTou
 e3FG9pIprbpxopQyRrH0NQ+q0ruZN5HLxO2QA3rwMP/LqIs9W/0O4yyuOxLC+tWiIiJs
 0TAZGAhw1h3E5O+6eMRSQh/HnV5/FbSvN0zQKoMtA3Vaxm8ujl5piHlax1R6HxqX9iaV
 vGtA==
X-Forwarded-Encrypted: i=1;
 AL+hErE4abfUcNPNGzNIYpawgAI0EcAy7FfWuTxNKrDIc+LcBqkfW0DKTeQ6NiLd+UyPMw6Nfwxv1Ws=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ikQXzgiwkFDVEbCBvLoSnbSbqr6sLf4r0mDOpQqHay+x4xNip
 txfC26o22gDs1zUTQ3STccKt7cTPyJOSEMX/5McrP7vJ4XI68clu3JrLb3ZCYz89/fw=
X-Gm-Gg: AYBFou1DejVoX5tejEq6ytA30Gl81t52lLxIS9uJJtGjrg3OD7c874qJ/ui+hbSkPcu
 WtXky4IsK2aYe9MlpIie1GKFrL+dUo6BSosMMKy2HGlDyGXlSZTidbR3PqYyWPYxnyNdbDcuYhG
 LMXZi3jBASo9MOhM8GtGIGIUl7tdKvMsEICyZyKe0MVHrn8HV4zAK9Xck0G3dtEww3EZ4dSUM/o
 H08zXpoZoWAQPX7paiGf2EaWBNs6Cn+u8qcn6X4o5/6fSqH1Wawz3vPo0ID02igRFLhP8KRib3A
 F2tuxuL6ePE3NDT7nmM+igkMLTMtcBsaMfaNIXPr9OWIxexAc1Cmw8yYcaQ4d/m6N+530zW2OY9
 +1ca9P2id3d8W3y1QnHREj3qoZC50XjJr2SnFBLaY1jMTIKb5OffEQeY7xt/1LFhB2CKMdhK428
 0SFVUfpdpjZhf643pH+vUIHPYmuplS0g4Ygo61vOOZLeOQ+CBIxmAHZ/rkjpsieVOIjgUwp2ePR
 ZWqokzBXDYXAiwkmriECyhLgS9NhGUiWcZnqGrs+NaZylHco4/FbrP7I/USBLZrsSpdHQhC+qwK
 7ivad0QzMZvIGZWT2ezgXD8ovf6xLgab9w9Pij4JH4/v4lFKGYNqod4XmlqNfxtGM14bhTpQj0t
 IfwP6kJdRs3Y1
X-Received: by 2002:a05:600c:b99:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4bb55a92e7fmr11672845e9.18.1794521390949; 
 Thu, 12 Nov 2026 14:09:50 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56716f86sm2788775e9.3.2026.11.12.14.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:09:50 -0800 (PST)
Date: Thu, 12 Nov 2026 23:09:46 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org,
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 01/10] binman: allow a control devicetree separate from
 the image description
Message-ID: <avY3RL80pHsZoiFO@macbook>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261112-mtk-genio-binman-dtb-v1-1-65cfc9329c50@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-1-65cfc9329c50@baylibre.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 15:14:56 +0100, David Lechner wrote:
> Add a --u-boot-dtb option to 'binman build' that gives the U-Boot
> control devicetree to use for u-boot-dtb entries, including the ones in
> expanded u-boot entries.

Hi David,

I think you should take care also of 'binman replace' when using the new
separate control devicetree support.

PrepareFromLoadedData() still assumes that each embedded DTB contains a
/binman node:

  image_node = dtb.GetNode('/binman')
  if 'multiple-images' in image_node.props:

With --u-boot-dtb, the control DTB no longer contains that node, so
replacement fails with:

  AttributeError: 'NoneType' object has no attribute 'props'

Besides that this is a cool work.

Thanks,

--
Carlo Caione
