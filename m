Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E3BFA3728
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 17:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D994584248;
	Fri,  2 Jan 2026 18:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215DD83B1E; Fri,  2 Jan 2026 17:03:21 +0100 (CET)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CA6C83AB7
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 17:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linkmauve@linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id F29CEF434C7; Fri, 02 Jan 2026 17:03:17 +0100 (CET)
Date: Fri, 2 Jan 2026 17:03:17 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add missing =?utf-8?B?4oCcbmV0?= =?utf-8?B?4oCd?= prefix
 in help net
Message-ID: <aVfsRY3_yW3gZudR@luna>
References: <20251227181852.4404-1-linkmauve@linkmauve.fr>
 <e2529768-467d-4bf5-a27f-9e50b8defdb1@forissier.org>
 <20260102154336.GF6124@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102154336.GF6124@bill-the-cat>
Jabber-ID: linkmauve@linkmauve.fr
X-Mailman-Approved-At: Fri, 02 Jan 2026 18:18:30 +0100
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

Hi,

On Fri, Jan 02, 2026 at 09:43:36AM -0600, Tom Rini wrote:
> On Fri, Jan 02, 2026 at 04:19:03PM +0100, Jerome Forissier wrote:
> 
> > On 12/27/25 19:18, Emmanuel Gil Peyrot wrote:
> > > From: Link Mauve <linkmauve@linkmauve.fr>
> > > 
> > > The usage of the net sub-system was missing the complete command for “net
> > > stats”.
> > > 
> > > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > 
> > Not sure this is a valid S-o-b as per the U-Boot guidelines (real name
> > required?). Tom?
> 
> As that is presumably Emmanuel's pseudonym, I would prefer their real
> name, yes. It's also a trivial enough change that I don't think we need
> to be overly concerned.

I use both names undistinguishly, so pick whichever feels more real to
you.  I am more well-known as Link Mauve even outside of the Internet,
but haven’t changed my legal name to include it so far.

> 
> -- 
> Tom

-- 
Link Mauve
