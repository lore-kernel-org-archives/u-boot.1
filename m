Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9F5CFB451
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 18:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94158899C;
	Mon,  7 Oct 2024 20:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94E188B11; Mon,  7 Oct 2024 20:17:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFFA688618
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A5B1F2A87E9;
 Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id I9Apv1IdvIQd; Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 38B6B2A87F9;
 Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id P6is6QJ2PLWD; Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 by lithops.sigma-star.at (Postfix) with ESMTP id 0FC052A87E9;
 Mon,  7 Oct 2024 20:17:45 +0200 (CEST)
Date: Mon, 7 Oct 2024 20:17:44 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Message-ID: <642493278.20599.1728325064957.JavaMail.zimbra@nod.at>
In-Reply-To: <20241007171505.GC4737@bill-the-cat>
References: <20241007171505.GC4737@bill-the-cat>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF131
 (Linux)/8.8.12_GA_3809)
Thread-Topic: New Defects reported by Coverity Scan for Das U-Boot
Thread-Index: nzecgGtfD9PeJKmg/C5sMrqyzq/xhA==
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Tom Rini" <trini@konsulko.com>
> An: "u-boot" <u-boot@lists.denx.de>
> CC: "Simon Glass" <sjg@chromium.org>, "Joao Marcos Costa" <jmcosta944@gma=
il.com>, "Thomas Petazzoni"
> <thomas.petazzoni@bootlin.com>, "Jerome Forissier" <jerome.forissier@lina=
ro.org>, "Sughosh Ganu"
> <sughosh.ganu@linaro.org>, "Caleb Connolly" <caleb.connolly@linaro.org>, =
"richard" <richard@nod.at>
> Gesendet: Montag, 7. Oktober 2024 19:15:05
> Betreff: Fwd: New Defects reported by Coverity Scan for Das U-Boot

> Now that I've merged next to master, there's a number of issues to
> address.

AFAICT, all issues in fs/{ext4, squashfs} are not new.
Looks more like Coverity re-scanned these files because they have been touc=
hed
by my fixes.

Later this week I'll have more time to triage these issues and post fixes.

Thanks,
//richard
