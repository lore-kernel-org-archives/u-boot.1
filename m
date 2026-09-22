Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350BC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 14:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34C8940763;
	Tue, 22 Sep 2026 14:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wnq29IF_mS9y; Tue, 22 Sep 2026 14:18:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CDED3406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790086733;
	b=LAwtej9kx8gnN5Jrg5bS4SrKuDzbxMOR6CRGSzCRrId13ZlO/aADUwtQdFrSFnEzlrw9
	 7HHy81RNfefgdixWOcXI6T6EyPZZZhwoBDvHTg/1HIFNKbWFdT2wxjTzMgyu+2n+nyi8f
	 e2tnKn1ZETaAUwftkZGIoWcP4ro0bTQAnlBmlYgbo9qnUqpyjO1x6ZWGpBerZr0VrgQaG
	 Jx/p81WESmImk/bNbU2TQMV7PNVS+62jHc+yOYMgZMvnekl9ag76IeO9uGeg6atK4zBvj
	 pz6gt+PB+rBb7KE2nMM5umPP9PZcCRZCxQ8wPuW0qQhrFdUf5E7mthpYnNk31lYgTKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790086733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tzaJCvWAg7vJ2Wwh7+g7k/SyBv+E9cwve++WasM4BHE=;
	b=sjXEilQPmntOgk9IBu8ad05MpIr40ftmOCpz/sG/X4bIy5SzAc1G6SNZtrHbhiFe6ioA
	 HOxGmYD2E+4XEracr/kWCUGTj+M/s/NEYmxhJbx6PR6KVD96cJB/R2pweeckIhtvzpkrZ
	 /pjHD9g9E3l6z3OWTLP22BAbbvXtiEdAFMCyOh95OYRWWCkmUt73zRbNzZlUJUSlyzApD
	 9+XPzINL+elOvQEj111jPwONHC4nBLGDDt45IpGXWq31jB9lp36dtUL9D9zpM6kB9ufyf
	 EKbp5pUd2ysvoWizEK9xB3mPUm16QbWZS2X/LrwFtZ13/V7JqHOL1CO/f1vpamo+ocA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790086732;
	bh=tzaJCvWAg7vJ2Wwh7+g7k/SyBv+E9cwve++WasM4BHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xlla6exxfELFMSVyrf8VmoGqRS+4gxd9K4uj0yVD333wSMCdrjRVtX5Y525Or6A3y
	 fD0XmwugTMA6JR7HPuYVt5IaW3Tf+6seIX+ACYvaPQzytkoQE+2eDSWIWjpYI/Wmpf
	 tqsGEPX8sDOYR9XjdD6rvvW+o3eWryK3dFovaLwJiCLHELeJ8cWgNmjOMqKefERh49
	 RgWqfRJVKQjz9vj02cP3akMjBgGB/PllrsUCx5G7+YZ0nk883MJHWX5lQTimRZ9Qup
	 grsqhi6wnaIRBgJn9LZsBJ3kuylK6oVA2qkidGeloN44/f6sh3+UvsuNM8nIuJrM9Q
	 bjGp9DnQ5gEOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDED3406E6;
	Tue, 22 Sep 2026 14:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6CF135A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C65160638
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usIM6RTBe474 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 14:18:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 16E0460616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790086730;
 b=bVTzu8RqG4Y5i+RdvxGVDWYndhqpcE9qQ4RqruPHlxRwfydB8xht2sCNydtFaoz6BTdy
 fBCLUMXpwF/avrNXLMvPiKCWDvy8JNV6l41p8bCloLtIVh2dsZt2OLZ4VQXCzG0y6OQ5X
 mBc/eHEwS4rW75Uxwq/ZC0z+0vQmw+N4eiiUbu4C2G8P7RYy1abICy/vMbsVuyoJPFV+P
 ZYkDx+EMe+fe9wuH8X/EeBdR8miBD7Vq33dd3whrB+glqdYk2ji6pmpp4jnfOQiRqkCyR
 BqBHX7q19ErpRyxzkOqNkiT9yVWkIfg+WCVyWDHmA9Ai6XIgGVUiMygIiss4sOAr6uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790086730;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=tzaJCvWAg7vJ2Wwh7+g7k/SyBv+E9cwve++WasM4BHE=;
 b=mIRbtShvejJNgvGecdtHLnKaIiLps64VJX6AbcI7OVPb2/1JLJYAJdHNXCWYMvpmTeOQ
 pMzKWU1THl8e/7DOQ+4TaKBGkiBXjH+i6Ci4sn5EjO2xhzkjij5be43Aj9dcoxJVDk98K
 myzaYMkiMPGRoSEciAdt3seazDWDS8c3xuaxG88zoLzwORp3G2hgF2N1ebMHi2keorfUZ
 sjmZNFnfjdxCr2jIs09lnnzJoprpszMT0KQUQvZY8Vy7IKYxHkI1Pn8lmFY44sxrOiBxp
 qqbxFikvo/LZYDbryfTNTChXCeppcpNUpfYuVwb8aZzzX85nefWnLg77jx6WHCPzfYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=dolcini.it; 
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=muMmjdMV; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=muMmjdMV
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16E0460616
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 14:18:47 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id CC86C21DAC;
 Tue, 22 Sep 2026 16:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1790086724;
 bh=tzaJCvWAg7vJ2Wwh7+g7k/SyBv+E9cwve++WasM4BHE=; h=From:To:Subject;
 b=muMmjdMVRyVwn97/UaK3AxL0W9TWkvj3CLrGBCT4i5tGP0piV5q+lABjC9k59v/i3
 bgeN2EOxTkenxotj/wz5WGq+diBJz2OcaiJti905jGVjOyOlvycMPSf/JLcT4740YR
 motCrqFRd+/j5tGsxlteJfKOq9HYVMiQhRWXZipnHtWxjBc3GaKdidjPZ6s9FnuwDJ
 SLQlLA/9hjNdE2ElwBFq9u2mowI8CDyobY63rRvN9e0d13Cj9AnSYiVW3oBRPt1wLr
 2fWq7KUtJ4JloVLIrJg6zLWt1tVCE2jdES9nmfsZB8kl8sm5Pwq8SyH4Z7HIMbAtid
 wTDJJLW5vAFsg==
Date: Tue, 22 Sep 2026 16:18:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ye Li <ye.li@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, festevam@gmail.com,
 u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com,
 qijian.guo@nxp.com, francesco.dolcini@toradex.com,
 emanuele.ghidoli@toradex.com
Subject: Re: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and
 U-Boot
Message-ID: <20260922141839.GA242194@francesco-nb>
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
 <20260922053742.GA8706@francesco-nb>
 <b914014f-b904-475e-8903-d8c9505aa896@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b914014f-b904-475e-8903-d8c9505aa896@oss.nxp.com>
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

Hello Ye,

On Tue, Sep 22, 2026 at 05:32:01PM +0800, Ye Li wrote:
> On 9/22/2026 1:38 PM, Francesco Dolcini wrote:
> > On Tue, Sep 22, 2026 at 10:24:02AM +0800, ye.li@oss.nxp.com wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > > 
> > > This patch series enables icache and dcache at the earliest possible
> > > point in the SPL and U-Boot boot flow for iMX95, iMX94, and iMX952
> > > platforms, significantly reducing boot time.
> > > 
> > 
> > You did not update the Toradex boards (that are the only iMX95 boards
> > not from NXP currently present in U-Boot).
> > 
> > Is something that should be done?
> 
> Yes, I only update NXP boards. By default, the u-boot early caches are
> enabled in the patch set, no change needed for Toradex board. To enable
> caches in SPL, Toradex boards need to update codes like patch #4 to define
> the CFG_SYS_SECURE_SDRAM_BASE/SIZE and move arch_cpu_init().

Is something that you can do and make sense to be done as part of this
series?

> > > On iMX9x platforms using SCMI, the DDR size is not known until the
> > > System Manager (SM) is queried via SCMI during DM init.
> > 
> > Emanuele: is this the same also for Toradex boards? I think for us is
> > different. Any significant implication because of that?
> > 
> The default board_phy_sdram_size gets the DDR size from SM. If Toradex
> boards don't override it, you are using same way. This allow single u-boot
> image working for boards with different DDR size.

We have the same binary images using the same U-Boot/OEI and SM and
everything for board with different memory. But to have this we had to
deviate from what NXP does.

Francesco

