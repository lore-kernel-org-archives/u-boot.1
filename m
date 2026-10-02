Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB6CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 15:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF60540BE4;
	Fri,  2 Oct 2026 15:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5wAP9bHiA5XK; Fri,  2 Oct 2026 15:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CED2040BD3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790954893;
	b=j20/go+GyuEHYwGfx5c/w7MDBJUK6vOrUP32NY9MUhEvhUweV7K6qOBrqJTIybi3wC6C
	 XrHhUrhSzlXTTw394hec4kYy1bVJz0t9jBoLvySi9djzhiA3B+OFArrPuJtvzkKSgvPHV
	 5J41u4kxADqAvYLGRokXx/ICCs7vu/YM7W3bL7nUFLm2Ty7FdC5NF/oa2q61Iw312sHjX
	 ohH4kEH4HfkD5GEQZ9006SZRqlKTCtghv049PdBflCYIGu61mNRUUekdw1ZN6K4ag6Spj
	 O/YJpFApRpP2qqN7vz/+gnt1Lqw6vG5opHUPeWNomWMqKQSrQivknvLwxXIXPFoLD5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790954893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cO4PWhQJXXaDejT5PshzoyKr9X3dyvy+6SMzLdyXiLc=;
	b=RjaHAV4dno4d8m/hNYjijcY62yTIbTbLlSRMDeIUcVyPqN8ny9iQCnYrAtZraIi4Hjkq
	 YAMAQ0NHI02AYKFSLhIHBkHzkFbwaCHEtXVQb4rKBhtjh0mJGINQvlu1Tg7V6dq4aK2Ge
	 n+ylgrUhuyXc9eBmT6c9Jj7LGX8GHT4/u/TgE7LKCGPgOIDIhWYpAblTiaM4robacJ1oM
	 RKuzvIlXCGu1T6A0apBTQZm6QBaoxEswaMYRwr4EUOF3TmcyCkViBcyOr53sZnqbj6LE2
	 8yzTxUmJEL1tBwB8RLarUpLllr1JZsMYT8nNV0lYtWDaEGjhJHnSfP5/XN6IR+Abubg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jFV1Yoot;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790954892;
	bh=cO4PWhQJXXaDejT5PshzoyKr9X3dyvy+6SMzLdyXiLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1K6vNuq/gwDT1OvqxxBtPuXbKAewNwOMksoEjwaarEKPR3tFcDdIP8TUzx9y/BG4W
	 BdXtlq8bTbLftiAczp1AlRSklU1rFogy5Fy/kTH/bujM1K7yR17T8elptTRU6TtZwA
	 cSd8cBX9CU1U3XwhkN/QxLD3/1gAYPRPmIg0K4763QWnx4/CX6VXdh4j5AvBlyTHMK
	 47kBrUUn/EAkCsTMHuGy66wtILnvWhl2sud3oCdFdU3yTHj66A857Wm461njSZb8of
	 LqIJiU1z4ZEbNsERawore44Hrcj8rps6QMW0asMdXf55eDDLHRN+niURYm/8PZNpP6
	 4vglbn3ylm8+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED2040BD3;
	Fri,  2 Oct 2026 15:28:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BBDB2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D22040BD3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYiEgevx-qLS for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 15:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC09A40B91
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790954887;
 b=X+aNyGrPxDhVeCYNLTTtJKudErv7Vd2H0do7rPzJJ90HdXdwoDafrTLm0e/JWuWsbROI
 M8EMWFVdKn8AytB/6Bu7ffrArUOlAEU6mwTyWmxnQpNsPbKgv46mgI2j1Hv1iozJi8Gwx
 DsN4GMPDfShRM8E5LZsCQRtCPTda0Z2FmNZsxgwxhbz2Hbd/NTEa4CTU0f3oMhHjxqFq2
 ssLgCycwqTvTooVYsv05c9LHuBMV+fLv9eJxCSvBqVnioLy3/uiMOaDkD7HhQX/uC4NEF
 XW3jkRkOAhzMyOjiG1DQGEX/A0V+oz+XBrI9pziC3qisWS1VVHI61vWk/tfZutFyuOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790954887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=cO4PWhQJXXaDejT5PshzoyKr9X3dyvy+6SMzLdyXiLc=;
 b=HmxoRHNXo/1BAFP97uIS291vD/ickG8VM/ti+1zr9O6zAb4OkZHj/SOif03nPjyKXnyf
 yb8OrXYBuShvU5E8zAC/1zzhqdhNIgm1ml0OskXKnRLrOj5DwVYBakB1wPzUOUS0ysNzO
 OAp6TnVNwurRoTbP2MOxM/dqEvcijdtQolOr9l1o3+pXrdeWotbk+M55UuTX5u5+RKxH4
 Dflo96UzfDLEfGMJPHaXBkVRe2R1HDxBEzp1umwQWjvg9M6g7PJgeGVG+s2dRcmdVzqTx
 V/uB7ZrZa1GPguhXVl4fJTBtY3ijak/VQ5mOocX7/R48Z1afBRbR6voVd272wHduc4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jFV1Yoot; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jFV1Yoot
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC09A40B91
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 15:28:06 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-483c65c2fa7so41581fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790954885; x=1791559685;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cO4PWhQJXXaDejT5PshzoyKr9X3dyvy+6SMzLdyXiLc=;
 b=jFV1YootaawwdgRCb8yi0jWy/47Xsb/yW0ireii5rOlVJA7lb/9bBIlXytdOt0pjQn
 bPgpMLBKX+dOJppaITSmVnBZrDPiUCDvvD1Ry6Skj7DM/DkxbWh6Xv91kVV4XS1GP8yv
 FtJ/MiS5q3PtAF4KMTdRmKSq2Cxb0a/iNa26o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954885; x=1791559685;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cO4PWhQJXXaDejT5PshzoyKr9X3dyvy+6SMzLdyXiLc=;
 b=Fuc6WyY4qUVN5gtQdtb1U3TkeaJXZM/Dxnx8xipJ52MBrLJHjs0qxzsY4LWyQ048oD
 332WNaLgUuftuV2pQyeS5V+cWqQivRGNoXYJ9DJDuCesW12A8igtm3lq2vPvbt6vHlD1
 aMKlyUVlnJ/hIxg8Eue/Us3UDnJT5cYOyrwM59Z5abOqsM3dl5QPEnrGlDkylfcxuAgq
 KX2fccDBlyoclzC4uraR2XRHd8SUfy4umLy2C3EvJ5rnCD/cgEJwNQ9ntgIsp6aQrHqq
 0tc6C+KhdBSGxVxXGCs3MC5ZuT9JBr7a9YegEl0vJkKWH/3eDSGMdOnhNJc9mfJ79JeW
 zuNQ==
X-Gm-Message-State: AFuF++kQ3RJZB6NveJJZnyGtnLtkpoGs/t/twSqwM5YSnYr0Fv5dmu6O
 s/Qwe4m90u8aVbfLcRXM89X2JM1ThoI0z/sgTNO1g4BF3kuEasEkzo+AzfCGHRLbbBY=
X-Gm-Gg: AYBFou2ynpfoox5LH/JKfY1enD8aGgsUHwcIpuBa0Tg+yiXEtL0ryfCBttc8ANfWoS/
 i2TX4mcBFtWBJ3CWgrgR54eP4vhjyBJeW8OhI458Aed8LT1zp3eQ9npCGZsPzMy9jRTnHlfpGfX
 7FucmczOgBcL2AZQm1cUYlZx5jxEArmdul7sBM/Ss3nweUcE9RdCFMF40CyqZASwQIxk54KgLPp
 SxJ+OmPqRc0oJiqEaJZxMG5nZckUS7ib2pv0k+1FyXUVnbf7+v22gcoz7S3KOhbpRwEVXdgfiJy
 300OGvOyCdFlLphBKUJMCOzymzv5yN5M/HGZC0Pl9SVVhhKUa77GVmAhZd5oEu1EJe8Zq2X0R6c
 ltp9EWMKsDYBibxs3paxvNJmR1U1mxLhv6CC/exbBoCfeuKEM9d6ticqh9Mm/jw357g3669H4aD
 zZNhnFTXKwEUATvzeSR2EzjIZ7CpYzRSW+HBzYDoilatDe6oz/3MnCbO2yMwPZDzgeCXsQoiwIg
 oFMXmMcARHT8pJUnDDhpBv3UEt85mr6joCFMWlobE1Iw6Toox3MTuwG8fIgeA3+5IIHeH4mR8bw
 1sDu7iG1d7h6fnFG6OdJ/xiV+aNpmw==
X-Received: by 2002:a05:6808:2381:b0:4e5:c2b4:33a4 with SMTP id
 5614622812f47-4f52b4ae259mr2497522b6e.50.1790954884914; 
 Fri, 02 Oct 2026 08:28:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5251e3956sm2194227b6e.15.2026.10.02.08.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:28:04 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:28:01 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 04/10] nvmxip: Make NVM XIP devices available in SPL
Message-ID: <20261002152801.GU858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-4-bc44cf0e0289@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RIbL8yJnUp53Pvmc"
Content-Disposition: inline
In-Reply-To: <20261002-mt2824-v1-4-bc44cf0e0289@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--RIbL8yJnUp53Pvmc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 03:02:22PM +0200, Beno=EEt Monin wrote:

> Add the SPL variant of the NVMXIP option and build the driver when it
> is enabled for the current phase. This allows the SPL to use the block
> devices emulated on top of a directly mapped non-volatile memory (XIP)
> to read data, such as the next stage image or a firmware, from the
> memory-mapped flash.
>=20
> Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>

Ugh, I wish drivers/mtd/Makefile was more like the rest of the
Makefiles, but it's not, and so adding the line there as this patch does
is correct.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--RIbL8yJnUp53Pvmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/NgQAKCRAr4qD1Cr/k
CrzSAQDH7URi7qCfmgl3PdZme0gybRaAiVwT2j41osCVbslTdwEAmGNBvrK92utD
LD+ebz4pAWMD8mRBzvTQ7vL4GcJE+wI=
=oUdw
-----END PGP SIGNATURE-----

--RIbL8yJnUp53Pvmc--
