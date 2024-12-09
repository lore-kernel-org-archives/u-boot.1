Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F18E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFC989721;
	Mon,  9 Dec 2024 19:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="WYCQD8UK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9EC889724; Mon,  9 Dec 2024 17:58:16 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCA089710
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 95934240105
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1733763494; bh=xb03SoLGJPxYDSbqZ0WTPyWYJJsuwLdchRSK2YmMhEo=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=WYCQD8UKFO5k0h1UpShay+Ou1gGQIpdmCiKLieMWtgyWk/hNcRiIPSIbYzR7/ocYj
 FcR7UfieioX694w5swtHKV+ll9rM9Qdo0rCefHP3xPAVbJtg3Za3on8qltsJzehMd4
 lvP2P26hyaO1U6ikRIw54jJ1pDyN+u5IF0Bmh6ymi0OuEKpRixUo57toOQNM5UDyag
 aSQOw79BpdGfuuAkmhENsi0xBmc1oov2wEBhnmL6kZOkjZ4HiPp+Q2tqBdzEFDLfac
 Cuvm1sIOfRsSneds4QrIa4PSIqWMzfu8k/DaXZyjY4AhreP4rYQCxkC0hA0oSbwt57
 ipTvviOsMAE5w==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4Y6Sjf0gFVz6tvs;
 Mon,  9 Dec 2024 17:58:14 +0100 (CET)
Date: Mon,  9 Dec 2024 16:58:13 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: j.ne@posteo.net, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] cmd: ufetch: Show CPU architecture under "CPU"
Message-ID: <Z1chpQhSV1VdD5W2@probook>
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-3-df861318bd49@posteo.net>
 <5bcf5c84-9d45-4ae1-a3b0-613b800101fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bcf5c84-9d45-4ae1-a3b0-613b800101fa@linaro.org>
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

On Mon, Dec 09, 2024 at 04:09:30PM +0100, Caleb Connolly wrote:
> Thanks for the patch!
> 
> On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > When looking at ufetch output it isn't immediately obvious which CPU
> > architecture the presented board has. This patch therefore adds the CPU
> > architecture string (for example "powerpc") to the "CPU:" line.
> 
> It would be nice to have the proper fancy name, but this is an
> improvement nonetheless.

True

> > 
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
[...]
> > -			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> > +			printf("CPU: " RESET CONFIG_SYS_ARCH ", %d (1 in use)\n", n_cpus);
> 
> This will read like
> 
> CPU: arm 4 (1 in use)
> 
> which is a bit hard to parse at a glance. How about
> 
> CPU: arm [4 cores]
> 
> or some other separator between SYS_ARCH and the core count?

Ah yup, good idea. I also struggled with reading this line as it was;
"4 cores" or similar makes it clear what the number means.


-- jn
