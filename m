Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFD1CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9ABE84D1E;
	Fri,  8 May 2026 19:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCB884DB6; Fri,  8 May 2026 19:47:41 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B8584CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wLPIU-000000006hl-22t6; Fri, 08 May 2026 17:47:34 +0000
Date: Fri, 8 May 2026 18:47:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Wade Sparks <wsparks@vulncheck.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 Disclosures <disclosure@vulncheck.com>
Subject: Re: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
Message-ID: <af4hsnMuwzEKHZF3@makrotopia.org>
References: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
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

On Fri, May 08, 2026 at 01:20:44PM -0400, Wade Sparks wrote:
> Hello U-Boot mailing list,
> 
> [...]
> We have provisionally allocated the following CVE IDs, which have been
> shared with the researcher but will remain private until public disclosure:
> 
>    - *CVE-2026-29007* - Out-of-Bounds Read in TCP Options Parser
>    - *CVE-2026-29008* - Integer Underflow in TCP Payload Length
>    - *CVE-2026-29009* - Buffer Overflow via NFS Symlink Chain
> 
> Please be aware that none of this information is public at this moment and
> all parties involved are considered under embargo. The researcher has
> provided us with a comprehensive technical report including reproduction
> steps. Once an appropriate point of contact is identified, we'd be happy to
> share those materials with your team.

Well, you've just posed it to a public mailing list, which even
includes a search-engine indexed public archive. The mere description
of the CVEs above already tells a lot (I'm sure any decent LLM can
identify the vuln just based on the CVE title given the sourcecode
repo), and should not have been made public before the fixes have
landed, and users have been given time to pick them up.

So I suppose you have to act fast now. Tom, Simon and Marek are the
primary contact points (I'm just an external contributor, do NOT share
any details with me).
