Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0057AE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF1C896F8;
	Mon,  9 Dec 2024 19:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="W1IGQpwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79E489710; Mon,  9 Dec 2024 17:51:55 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF903896E2
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 76484240103
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:51:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1733763113; bh=QImGHsxi9AImDG2wrZLi5VgQP4Xf2M1hus7vzEdYXo8=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=W1IGQpwpnRQ8duW80chmW58s8T/D1SJZ/AzP5Y3//fS2BD/E+e3Rb72rui6V0SRAt
 WJ4qmocPW8GvXkd811xOIez5gF0O4bUmenYPle903zEjRlmua55ulqQT4Grh8EXk7q
 R+sveBj/l7o2duAiZ0bXtCnOn9/I8AxpFTBzuqm+2s2D2IUzjYECULC4lmnndr1Tp5
 D+1DjMzk5yeD5kHCNRb9o9VtQriJJ6RlYlSURyFWnPCoOGRtHhlfUTPZ0X7TzdHYTF
 rfViPt0ZpMzn/2D93qr6q6jGZJqZULszHBlAAgFtxlKxhrOK3iMHHSQJbNBBEB5v5a
 EI6DOlmz3sRtw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Y6SZJ5VFJz6tvs;
 Mon,  9 Dec 2024 17:51:52 +0100 (CET)
Date: Mon,  9 Dec 2024 16:51:52 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: j.ne@posteo.net, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] cmd: Allow building ufetch without CONFIG_BLK
Message-ID: <Z1cgKCUyvspIe7Nb@probook>
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-2-df861318bd49@posteo.net>
 <3367bf91-1715-416b-b6d9-751f385971d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3367bf91-1715-416b-b6d9-751f385971d4@linaro.org>
X-Mailman-Approved-At: Mon, 09 Dec 2024 19:13:30 +0100
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

On Mon, Dec 09, 2024 at 04:04:50PM +0100, Caleb Connolly wrote:
> On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > The ufetch command is still quite useful on systems without block
> > device support; remove the CONFIG_BLK dependency and make sure the code
> > compiles/works with and without CONFIG_BLK.
> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> 
> Small nit below, but with that:
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
[...]
> >  		default:
> > +#ifdef CONFIG_BLK
> > +			struct udevice *dev;
> 
> At least without the #ifdef, I see a warning "A label followed by a
> declaration is a C23 extension".

Ah, I wondered about this. Apparently I have a compiler that uses C23 as
the default, so I didn't see the warning. I'll fix it in the next revision.

> So to be on the safe side please put this section in a block:
> 
> 		default: {

An alternative that I prefer because it's a bit less intrusive with
regards to indentation, is to use a semicolon:

		default:;
			/* code with the same indentation as usual */
			/* and no closing brace to remember */

What do you think?


-- jn
