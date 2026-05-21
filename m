Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C320CD5BB1
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 13:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EB2844CF;
	Thu, 21 May 2026 15:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C137184673; Thu, 21 May 2026 15:28:34 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F525805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id E2CD568D07; Thu, 21 May 2026 15:28:30 +0200 (CEST)
Received: from localhost (dynamic-077-007-233-044.77.7.pool.telefonica.de
 [77.7.233.44]) by verein.lst.de (Postfix) with ESMTPSA id F346D6732A;
 Thu, 21 May 2026 15:28:27 +0200 (CEST)
Date: Thu, 21 May 2026 15:28:23 +0200
From: Torsten Duwe <duwe@lst.de>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/9] ARM: RPi5: Enable PCIe
Message-ID: <20260521152823.1913f2bd@lst.de>
In-Reply-To: <431cb228-c0f2-49e9-a3cf-9869fc954d1c@linaro.org>
References: <20260516113940.647CE68BEB@verein.lst.de>
 <431cb228-c0f2-49e9-a3cf-9869fc954d1c@linaro.org>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 18 May 2026 10:02:04 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 5/16/26 13:39, Torsten Duwe wrote:
> > Basic PCIe support for the RPi5. This is the prerequisite for PCIe
> > slot adapters / HATs and NVMe storage. Those might require their own
> > supporting drivers or changes.
> > 
> > Changes from v2:
> >    - fix wrong subject prefixes
> >    - make reset drivers only found on the RPi5 depend on
> > ARCH_BCM283X
> >    - some patches Reviewed-by Peter Robinson
> 
> It seems you completely ignored by comments and review on v2:
> https://lore.kernel.org/all/bcad697e-56f8-4256-8d24-41c5ef644ff8@linaro.org/
> https://lore.kernel.org/all/f46be233-e35e-4a42-8663-342e9913e784@linaro.org/#t
> https://lore.kernel.org/all/5ba58555-78cd-454f-9fcc-5aaec5fd4205@linaro.org/
> https://lore.kernel.org/all/0d1c9e66-62c5-491f-9fba-97f262a1153d@linaro.org/
> https://lore.kernel.org/all/fc11057b-edd2-428b-a67d-1cc22bd79492@linaro.org/

You're very well right. I kept actively checking the list for about a
week after my submission, and haven't checked again before v3,
apologies.

V4 including your feedback is coming...

	Torsten
