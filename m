Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADA2C54E60
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303B087D35;
	Mon, 11 Mar 2024 12:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="w0coDxAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D92583414; Mon, 11 Mar 2024 12:34:54 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459FF87D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3C80B1FA9C;
 Mon, 11 Mar 2024 12:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1710156890;
 bh=8E68U+5CpfQtB0/8yIMYvVcR0PWE61GtsGqLWMmD24o=; h=From:To:Subject;
 b=w0coDxAq8wq6lob7Q7WRAj+nCjkMgWJ+fk+4DkmXJ4p/mXJM+BDCkzfZ1O+uYtHu8
 uiZEXeAwnrgWfcRks9uRo7nAWHrFVLywFlqxkUn1qMn0aJnRMSe7h+mi8WFANfEdON
 rEJRE9SASw0SS0khyt8jh8nAAkKlB4J0UJzu35NLSOO4t4eUNBi9EKf805sr7EhrtI
 0pTIBGS0CTGccLaG/AwqlkvH98L90nScb4a3AgW+cShtQuf9xif0a6gxnrLaCEkLZP
 BIDnLXyo5JlmPkIapsAJZuzLjSevhrhhNuwyEKqCdBdCdrAeJ0E0LwvhVWc93928xI
 qp5cS0LUckdhw==
Date: Mon, 11 Mar 2024 12:34:40 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Parth Pancholi <parth105105@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: colibri-imx7: enable watchdog
Message-ID: <20240311113440.GA13671@francesco-nb>
References: <20240307152302.2338472-1-parth105105@gmail.com>
 <CAOMZO5DrVC9+=_EGX7ADYFk57MfLbEv1YjcdKRCPSFZ1_yHmpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DrVC9+=_EGX7ADYFk57MfLbEv1YjcdKRCPSFZ1_yHmpw@mail.gmail.com>
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

Hello Fabio,

On Mon, Mar 11, 2024 at 07:44:02AM -0300, Fabio Estevam wrote:
> On Thu, Mar 7, 2024 at 12:23 PM Parth Pancholi <parth105105@gmail.com> wrote:
> > From: Parth Pancholi <parth.pancholi@toradex.com>
> >
> > Enable watchdog functionality for Toradex's Colibri iMX7 (NAND/EMMC)
> > modules.
> 
> You described what the patch does, but the reason is missing.
> 
> Is the reason for this patch to fix the 'reset' command regression
> like you did at:
> https://gitlab.com/u-boot/u-boot/-/commit/be23b1331fb35b7d5a095ef2c0b522c1f241eee9
> ?
> 
> Please send a v2 with an improved commit log.

No, on colibri-imx7 the reset is already working, it uses the PMIC so
it's not affected by the issue that was affecting most of our other
boards.

The reason for enabling the watchdog here is just an improvement to
improve reliability, given we have it enabled on other boards with no
drawback it seems nice and consistent to enable it.

Francesco

