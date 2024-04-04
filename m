Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78DECD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143AA883CD;
	Thu,  4 Apr 2024 10:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Wt0Hgxka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B878883D3; Thu,  4 Apr 2024 10:07:53 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95AE8825A
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E46AC1FA13;
 Thu,  4 Apr 2024 10:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1712218069;
 bh=f3hnphOVOLc2SEGKHkNm/+bjnn9ytmdyE5U1usAW0HE=; h=From:To:Subject;
 b=Wt0HgxkaNiVupNre5XXKhtTrn3GFA7pbb2MMiwXa7plHENNheYzdOCSWrxu3DzLDk
 7P+5fu6EkKxeKVDXA/nojWlfE2PQCiDEMl+sudbQ1saSycPWhCyLLLp9RRQQam0aCm
 +PSZjUBj36Yti/VIMMJhHXGRVB1onMiKk6CVhBiqsDnZY3hM0tizRSmQKEy/7GyeDb
 CsFcdPgu6yOOhBGb4I/m2FXi9JkX26eTbovj3NuijmmF5TH2MWmbbRHUTdb2FHifCV
 urOePAYZTfETbiWSpQRVdbUz/vE8LnWMv+xCjQH/qPyeDp1jMDI6PEJbSBlsO5nHu4
 Ou7lTrBbBW3kA==
Date: Thu, 4 Apr 2024 10:07:45 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH 2/2] arm: dts: k3: binman: am625: add support for signing
 TIFSSTUB Images
Message-ID: <20240404080745.GA7072@francesco-nb>
References: <20240403120309.4026170-1-d-gole@ti.com>
 <20240403120309.4026170-3-d-gole@ti.com>
 <967ef615-58f8-48e7-bb8e-1c9903e771db@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967ef615-58f8-48e7-bb8e-1c9903e771db@ti.com>
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

On Thu, Apr 04, 2024 at 10:20:21AM +0530, Neha Malcom Francis wrote:
> On 03/04/24 17:33, Dhruva Gole wrote:
> > From: Kamlesh Gurudasani <kamlesh@ti.com>
> > 
> > Add support for signing of TIFSSTUB images for HSSE, HSFS and GP devices
> > and include them in tispl.bin and tispl.bin_unsigned.
> > 
> > Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>

[...]

> > @@ -270,7 +406,8 @@
> >   				conf-0 {
> >   					description = "k3-am625-sk";
> >   					firmware = "atf";
> > -					loadables = "tee", "dm", "spl";
> > +					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
> > +						  "tifsstub-gp", "dm", "spl";
> >   					fdt = "fdt-0";
> >   				};
> >   			};
> 
> 
> If there are multiple boards that will support TIFSSTUB in future, I would

I would assume that this will be the case. Verdin AM62 would need the
same, for example.

Francesco

