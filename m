Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B32606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M4tX7WG0;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NVch960n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1405D40740;
	Tue,  3 Nov 2026 16:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UeBvGnYCeHj; Tue,  3 Nov 2026 16:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A18D40692
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793724678;
	b=RKw6soQY7AYmrMTIOk97He46vHAl0P7IoquxMT6RSWA2m1UmEpxzddhtcr1rDLI5LkKk
	 Rc2V4ewRXYp6SIG8juVgrywwSBlPcs185EeQ9aXtkamzIT5xo+2cwdkLd2hYF+2DVqMIe
	 NzUrLw9q3hlCb8Q3s0C6oxorAJonWVTSinnmnOpyzheUasT3sf2Kfkj6osrQrxtCvVs8c
	 s64OVg0vwXMpLmvY0QC/KTqQhaNCX4TNkBTVw5AtdjO0YE8B7t2QmMxUoYoSwE0GSZwhj
	 wNdFn61nQsgv6AA5T0xfokwZt27OYv2dJ4CQnaf4zGnSqxtZi9IJWe/1PhFcs58Bz8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yzCV2/0s5dcafIPXtHANjWVs0F+nXu9oDEaj/xX3S9s=;
	b=YdKzW49R1N/FMcJ4gZ7HdtJi7Ntvz+9rwdVygOjXXVF2yp1gKGpZTgTCYzH05gk8LfXj
	 zv729xa6H3UIauDNGPlRxgB17kGl97R+haAqla2Aj4/6bqgMY/bF+4KRqyBKa0M33VXnC
	 MP4WiPOJ27gDmDzORcCx5fCl/JNC8eoDVq9Cio2V2sFhmcrCl3kADXrjuDq4FizIxKqa2
	 K5V301/cYnOChhlf5P0V830POSC/Zg8BBEPiPOdAygc47jAw4zOdlEltUVPp1xQTMn2rz
	 bbS4LcfXBcsuBVePcfTRiCkf6Y/fr7+5jt00aNSM547iPBI7xu1OKiuWMHrGasn5PBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724678;
	bh=yzCV2/0s5dcafIPXtHANjWVs0F+nXu9oDEaj/xX3S9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M4tX7WG0p+3EJw1j3EO85uLTDw4GuXw4zFWftjlyHZizhL91S5PE349qLsZ4HFrSa
	 nnTJ+nLm7c63s4NW1zQbf8igj7jJkDapvM/qyZhBaaALNyyI7oqg3QYzv0z5+H1Msq
	 Hu4Vpee0+sG1SIR+rlqinvA0LxsR+FXdNwYPnMC9XgdsO6aV7T/oxZAWmQ54RC5vuS
	 T6PnoNqA6+i/mIUHNVTs/DntMGeAR2fsNvV/7BbR0LPFRlpPAxGfZl+aXmsJTaoSI0
	 zk78jZK5edjoO43ch0Gvm6Nmx0QkETXg+U/rVoOR2DobVD5XOA0U4cYOC2qdeVS7OC
	 Ilm1ASZ7CHPyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A18D40692;
	Tue,  3 Nov 2026 16:51:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3352D356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25165606D9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WyQJaCQ0kyR for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DA4C605B5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724675;
 b=Isec9Gm1HENXKfOSGbs54F6Q+Q1puAVBGZ/JPwuDEe+zGuA0eAMVnPTja5DD27gYiUms
 tdir7VTuFHh4mqhzH0AySDQbVv/zrubk5VjDusDID8ldVe/KGV6HE9qgxQA010NBt98uZ
 1MAqlexDbWnl0PyiC145bwBPQ/NZmy1faliEbgrn0amfYcIvftreUn423qCt9gK+Nha1w
 +xTHr0naRdS/lAZu5ymV07RFTQhIYrKA4dMWCnlBoBSoKiRpH+gKLwoDyLjjL0LnIZVya
 j+0/PxQTDSwiByJTwNVFW+gsKQ8hgB2xDpte98rDG6OxC2KFS+zocvJNNBVsRgW2lOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724675;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=yzCV2/0s5dcafIPXtHANjWVs0F+nXu9oDEaj/xX3S9s=;
 b=FfcXBep5oiU9qamKR8/5qwB1cClOxmMsQmSx6VU+08302H8/PSKhL63fohcPSQcU5EBO
 5wzlGRG7jK/dInjxjjG0LdohY2U+k5x9UcNsNuJxHLIFMHwPFZ6FFLNJmK6G43VngVmJq
 Ba2QJ3STNPUCuc4r62381ESXgnCL1eU3RRJ86eEs1MzYN/Pq2Hp8PfsnJvrY5hVKdiMm0
 iYOlSWkvmv6sDf6iHsjSGNw99kzLgzJA8mfvbLUQQ7YEirj1xNpYnagYf+OcX8SFnSyJj
 vXD5wfdX2FsB94dT1dmzkhNUF6UO32ShZoSw5pqX6rVFK88gyUfb6gsmzKXRMg/sRyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NVch960n; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NVch960n
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DA4C605B5
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:51:14 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso21032175e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793724673; x=1794329473;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yzCV2/0s5dcafIPXtHANjWVs0F+nXu9oDEaj/xX3S9s=;
 b=NVch960nKDZqx/ahO6ba9ZejOJrNDY++ppZMy75L09yG7wCA/lQhWPgTd41uazu61e
 WqUM1AZOrKZ7hrLgMXXrG7v9CQzHfk0KBkaAAYfz41cT64tj9WJD3i2HnVYAZ2k4re+l
 F2RMTG8kshfQuf3Pe9u3PPS/RKCv6EajGN+4DTbTMfhpM2WUghPozsrSnVnMlidkfqcv
 VTqAXV84OnwySiiCOxTKUGMaFwJtWsp7Zgb/Yxeq4W/Cpt1hDtlZqTw4XM4r8qJfFy5G
 PgXWdWHizdfeKN0AlC8h2BkzUaX6mpcoCy+alKqjBprP3NY3hGmkgAJsE1g435dqHpQc
 GKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724673; x=1794329473;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yzCV2/0s5dcafIPXtHANjWVs0F+nXu9oDEaj/xX3S9s=;
 b=1l/UCTdCv5scY1A7aaUNFw16YZ3/98IVn4JPITFoCztkbF30s2ly4nG8emWzvkMxMN
 OfC7uGig4z5mGt/oarcakbPpqxfJg0fS/Mv4Z7ynjVXOeGNUm3zyEWxjXtOQ0Pp9iXjO
 u7oU81Eg44GqWJAjGDsc0rTiWYpf5QVpvusi7ACu59Y8F8sXAktrpAXUoO3liQSVw584
 oMbowx763PQage65Icvxo4r0LGP+0sLRi/YjMXZ7bU7hKAGTGLLnn9hmowWUPyAxJ/6A
 V+GE8xj7ZDNsrvX8CXD1sboVuzrN6AiwdGY+OaLX/TQ46wxGf0GDCtpXWcitGrLnn0L8
 UiRw==
X-Gm-Message-State: APuU4Z+T465kO95xa66Co2yuWUviIP9iBv/qwOqJJvrQPbAZvpWwlNYY
 NwXqw1dKlNobGXpZZvTT+W6CfPczssKH+wu5f9UOe0IGcn1LpaM/vJAaPJMLErO4cVgWKRNM9r0
 nT4Hjhq4=
X-Gm-Gg: AYBFou2UjHBMYNnQ+vQwJFOo/iszom/drwoB0ZBQC9PV/wkiwTqmSIZI2T/37XLRE2C
 XQkqxLBPz+OZ3hr3OAXLzVOoQ1kERy/sCl24gSLx9SdfIBDmEyp0fC5SfpqqsqpMTTE0f5z/c5q
 jCk44ZHHa3Q5/9WFYKtl0x4D/OzIqdTjCuOfSvM4Rd/2nawwbhmD3LsQK5OqSG5OMxKWWK3wj2x
 Tp0rGpnvCnZbDQ6uwby1UwSDsCQbxUaccwGccLf0Q1b0+yU6zEmFrC/IRyyeHCknqV7/3H0t6JC
 fLtYoxzS7hNCqh0CoYVr1Q2xxiIemu4yfZXKVcLaPjDwsaXADKbWu1Dtng6D/z/0j7H7/f6BY/8
 HiMA1TOrc1uGDZnhj13mi+EE0fH5ElQ7qJl4DcoJa4c7yIaU+G9vdGJmYRN+tODQuSBSy/Y/dqA
 cwnIK95zfPPSWePYseO/MSrIGKC1NlGR0rqmnc6A0DhsK+b5gIZzUJkjxr5oTUBKTQoF6o24SWP
 so311KJ69Q7bSVj0wvv65FLxmaa0xTX4FTzVBDxe31kP1oRzm/Aqb1qHMpeof2/UsPbBXEe7lWF
 aDiL4mjCE4penfpXxMvla4MT5P57im3CK1dhoO+YuwnS7vhLiCUzklysOrOM4IK621MkJ/xVvnM
 YPg==
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id
 5b1f17b1804b1-4ac150b38abmr307353815e9.3.1793724672928; 
 Tue, 03 Nov 2026 08:51:12 -0800 (PST)
Received: from macbook (net-93-150-243-29.cust.dsl.teletu.it. [93.150.243.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm79708035e9.0.2026.11.03.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:51:12 -0800 (PST)
Date: Tue, 3 Nov 2026 17:51:10 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 York Sun <york.sun@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Day <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Alexey Charkov <alchark@flipper.net>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 3/6] spl: ram: allow loading FIT images from a supplied
 buffer
Message-ID: <auoQVAmA6CWHVMaO@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-3-d29df15fb9b8@baylibre.com>
 <179370057187.349126.11782363973041228093.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179370057187.349126.11782363973041228093.b4-review@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:09:31 +0100, Mattijs Korpershoek wrote:
> Hi Carlo,
> 
> Thank you for the patch.
> 
> > RAM FIT loading currently assumes a configured image address. Downloaded
> > images need the same loader with a caller-provided buffer and length so
> > reads cannot run beyond the received data.
> > 
> > Expose a reusable RAM FIT loader with header validation, bounded reads
> > and overlap-safe copying. Keep preloaded images working when their buffer
> > size is unknown. Add tests for embedded and external FIT data.
> > 
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d1f51d9197d9..f464e0bd2bce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1923,5 +1923,6 @@ Q:	http://patchwork.ozlabs.org/project/uboot/list/
> >  S:	Maintained
> >  T:	git https://git.u-boot-project.org/u-boot/u-boot.git
> >  F:	configs/tools-only_defconfig
> > +F:	test/image/spl_ram.c
> >  F:	*
> >  F:	*/
> > diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> > index 0c501cf02f28..ee588ef4718b 100644
> > --- a/common/spl/spl_ram.c
> > +++ b/common/spl/spl_ram.c
> > @@ -16,32 +16,39 @@
> >  #include <spl.h>
> >  #include <linux/libfdt.h>
> >  
> > -static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
> > +struct spl_ram_image {
> > +	const void *data;
> > +	size_t size;
> > +};
> > +
> > +static ulong spl_ram_load_read(struct spl_load_info *load, ulong offset,
> 
> Why changing sector -> offset? It makes the diff more difficult to read and
> as far as I understand, the callers are still passing the same argument to
> this function.

It was just for the sake of clarity. I'll dump this.
 
> >  			       ulong count, void *buf)
> >  {
> > -	ulong addr = 0;
> > -
> > -	debug("%s: sector %lx, count %lx, buf %lx\n",
> > -	      __func__, sector, count, (ulong)buf);
> 
> Why is this dropped? It's not mentioned in the commit message.

Ooops, I'll restore it.

> Rest looks good, thanks
> 
> -- 
> Mattijs Korpershoek <mkorpershoek@kernel.org>

Thanks,

--
Carlo Caione
