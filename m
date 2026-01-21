Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A5ECA5FDD
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 14:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D6C8341A;
	Wed, 21 Jan 2026 15:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Df3ID9Ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961A68397D; Wed, 21 Jan 2026 15:07:55 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FCF83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 15:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1DE3F1FE32;
 Wed, 21 Jan 2026 15:07:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1769004472;
 bh=jWPa8L2WZLhTCkEDG09d6BoKsfPtBHwUMWcqKYVALXw=; h=From:To:Subject;
 b=Df3ID9Arlbz4wk75jNaBNdPPxsZfcgwZNffYpCteV44cyBEv9kCOxMhx61yMPNGTQ
 DCYepkzLdzPpdj/BdcM+ej7cLnfPYSwAPemznzSj+hJqawZydEKIj/5qCjekjO/Zce
 DcAFIQjr+a2nzvm4SA2EiskaX215qW3uLzaUne/QWpqM+tAikvaxWKaRAVjQLmFtf8
 DUNQgd990SFOqC2B9+JxRa/b0BGVx1QBnMv3fnIFhA+Izk7D85LJtckN8EFJ7WwmZj
 E/paJv/mF5SOsFHmBFptf6yuijfp/U5mv2eq1i1m0VRQqKFGhBXBXt+5/Jfh5necZB
 TRfOMlw/pLQrQ==
Date: Wed, 21 Jan 2026 15:07:47 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Suhaas Joshi <s-joshi@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com
Subject: Re: [PATCH v2 0/5] Firewall ATF and OP-TEE memory regions in Sitara
Message-ID: <20260121140747.GA112150@francesco-nb>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
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

Hello,
thanks for your patch

On Wed, Jan 21, 2026 at 11:17:07AM +0530, Suhaas Joshi wrote:
> This series starts by replacing the hard-coded addresses in firewall
> templates that are defined in k3-binman.dtsi, by Kconfigs. Using
> Kconfigs would make it easier for someone to move ATF and OP-TEE to
> another location, since they wouldn't have to fiddle with the firewall
> configs in the dtsi files.
> 
> The rest of the commits in this series add firewall configs to each
> device's dtsi file.

If I understand correctly the change, you should change also the other
k3 boards, not just the TI one.

Francesco



