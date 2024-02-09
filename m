Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE4FC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 21:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D698087E6D;
	Fri,  9 Feb 2024 22:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="pgkCj7nR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C6287E73; Fri,  9 Feb 2024 15:25:04 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B3E87CC1
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rYRoI-0000MK-9l; Fri, 09 Feb 2024 09:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=zi5f7f6UVetnFmN7hcnLShXefnWdp+5/9jGlg7EMoEg=; b=pgkCj7nRM8zLqlI26uEV
 AxUiD+iMPSxYxNqz9dxTZtzGyvSsrh+Eg+IfuEelplwWFn1Y1u7sZqKxpOLjgFcd9aMfsRRUaqBu8
 rBf9+cPvniTPLZUmQM3IShHSY08A/BYNH6ZnFkFcYb+kXRiZl2oNxZrTpFtbM5FY3DDuwnyu8QaZN
 euAKpbQJtLdR6FJP/Z7ojgXJ+TShMyH1IkPYQm9OHauazwj4tzNx4uBgjXifTMDQMiS6Brvy6lrjV
 FND874N7ncPwXOyv0ymlNtxWGzEFh4zLM5sSCfUdMYLnLxUDZstiMvBPv4YcGzR0gHF1F+bS+O7PU
 VLtXr6oJcO7FFA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Shiji Yang
 <yangshiji66@outlook.com>,  Ye Li <ye.li@nxp.com>,  =?utf-8?Q?S=C3=A9bast?=
 =?utf-8?Q?ien?= Szymanski
 <sebastien.szymanski@armadeus.com>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] imx93_var_som: Enable AHAB support
In-Reply-To: <CAOMZO5CmE40nKAnhdnMxHxwQy8bJ=Fvd42VPUDb7cpVYVQneAg@mail.gmail.com>
 (Fabio Estevam's message of "Fri, 9 Feb 2024 07:35:23 -0300")
References: <20240208094518.391-1-othacehe@gnu.org>
 <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
 <87le7uyset.fsf@gnu.org>
 <CAOMZO5CmE40nKAnhdnMxHxwQy8bJ=Fvd42VPUDb7cpVYVQneAg@mail.gmail.com>
Date: Fri, 09 Feb 2024 15:24:55 +0100
Message-ID: <875xyxzpe0.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 09 Feb 2024 22:27:02 +0100
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


> This is what I am concerned about: this hang causes the board to brick
> and can no
> longer be recovered since it has the fuse programmed to close the device, right?

Once the board is closed you can only boot from signed images. If the
signed image is not working (hanging during relocation for instance),
then you can always boot from a new one. All the interfaces: SD-card,
UART, USB are still usable.

I have tried many u-boot versions on my closed board until I had
something working. So, no you do not end-up with a brick unless you
cannot sign your image properly anymore.

Or maybe I missed your point?

Thanks,

Mathieu

