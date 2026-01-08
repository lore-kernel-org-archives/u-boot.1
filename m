Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7384D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8FF84150;
	Thu,  8 Jan 2026 18:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dKIDyHQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6FA8415D; Thu,  8 Jan 2026 18:17:57 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095BB84144
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 60938C1ECBE;
 Thu,  8 Jan 2026 17:17:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95B356072B;
 Thu,  8 Jan 2026 17:17:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4A2DA103C8824; Thu,  8 Jan 2026 18:17:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1767892668; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HcjXNN4/nArYqqlMdRijc+jITb5B7lTLxC8nSytzkx4=;
 b=dKIDyHQnjYtbGpejjCryVK1Kdo3jVi+LZr7ZSkodcnZIIZ/OFTYRRxzV7v7tvuk+ngSquJ
 iUzS2kuSaE2lmxLpg/L1mhuxA0C9Q6oS6SIuxVIicJIwTGE0ALwaBY/sE3ygVIgtpgl/S1
 gu53A//iHVoXIzxG1ZAEPMy5kKYf32KHhryS7jXbwH1wiitvYXu4Sf3CvfG/8GuNGanzGD
 hvSqVrwnAnypwV1D/kySkDl7DJ9+o6ez4FiUo+eQXrSPp3vZOeh8oKfnlBeomoHeKBPw+o
 hDjKGeS8gBIIF1evvGqkZRMXsWcWo0MPvg4utdoIvso4sEXMVZKB6li0BUOX/A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Peter Suti <peter.suti@streamunlimited.com>
Cc: u-boot@lists.denx.de,  Radek =?utf-8?Q?Dost=C3=A1l?=
 <radek.dostal@streamunlimited.com>,
 Tom Rini <trini@konsulko.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,  Heinrich Schuchardt
 <xypron.glpk@gmx.de>,  Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH 1/2] cmd: mtd: fix read failure on default full
 partition read with bad blocks
In-Reply-To: <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
 (Peter Suti's message of "Tue, 16 Dec 2025 14:40:41 +0100")
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 08 Jan 2026 18:17:46 +0100
Message-ID: <87zf6oxbut.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 08 Jan 2026 18:51:53 +0100
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

On 16/12/2025 at 14:40:41 +01, Peter Suti <peter.suti@streamunlimited.com> =
wrote:

> When performing an 'mtd read' on a NAND partition, the presence of bad
> blocks can cause the command to fail with error -22 (EINVAL) if the
> requested size is equal to (or close to) the partition size.
> When size is not provided, the whole partition is read by default.
>
> This issue occurs because the bad block skipping logic increments the
> physical read offset ('off') without decrementing the 'remaining' byte
> count. If enough bad blocks are skipped, the 'off' pointer eventually
> slides past the end of the partition boundary ('mtd->size') while
> 'remaining' is still non-zero. The subsequent call to 'mtd_read_oob'
> then fails its internal boundary checks.
>
> The Scenario:
>   Partition Size: 0x1200000
>   Bad Blocks:     1
>   Command:        mtd read swufit ${loadaddr}
>                   (Defaults to reading full 0x1200000 bytes)
>
>   1. U-Boot attempts to read 0x1200000 valid bytes.
>   2. It encounters the bad block and skips it (off +=3D mtd->erasesize).
>   3. To satisfy the full request, it must read
>      (0x1200000 + mtd->erasesize) physical bytes.
>   4. The read pointer 'off' exceeds 'mtd->size'.
>   5. Command aborts with: "Read on swufit failed with error -22".
>
> Add a boundary check at the start of the read loop. If the read pointer
> 'off' reaches the end of the physical device, check if the user explicitly
> requested a size (argc >=3D 2).
>
> * If no size was specified (default read): Stop the read gracefully,
>   print a notice, and return success. We assume the user wants "all
>   available data" up to the physical limit.
> * If a size was explicitly specified: Continue standard execution. This
>   will result in an error (-22) as expected, since the specific requireme=
nt
>   cannot be met.
>
> It is physically impossible to read the full logical size of a partition
> if it contains bad blocks (as the bad blocks consume physical space
> required for the data). In this case, truncating the read is reasonable.
> For common use cases like loading FIT images (which often
> contain padding at the end), missing the trailing 0xFF data is acceptable,
> whereas failing the entire load operation is not.
>
> Also add some logging when bad blocks are encountered.
>
> NOTE: This changes the behavior of 'mtd read' when no size is provided.
>       Previously, it failed if the full read was impossible. Now, it
>       succeeds with a truncated buffer. The caller is responsible for
>       verifying data integrity (e.g., via fitImage hash verification).

Thanks for the improvement!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
