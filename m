Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3E5CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 13:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC21C838AE;
	Fri, 31 Oct 2025 14:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nj7jAsDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57830838CC; Fri, 31 Oct 2025 14:13:41 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBB3836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 14:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 07EFF602FD;
 Fri, 31 Oct 2025 13:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E17C4CEE7;
 Fri, 31 Oct 2025 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761916417;
 bh=aleNY2Ho6nFvxYNxm3tTeIjNpVMU/XZcYsmzH8WFkmI=;
 h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
 b=Nj7jAsDrQnSdIAJH7lZvUujJ5Bua3okEERKy2KVP5YrAx2PSiwYOsRSGRqRVGepBd
 usGqQ+RYWQw7J7G+kBwwlIMXGudOvL8AiDaBSaabhfqcSKxBDlH7A/U8vSSx2hBzVw
 /jrbxp6Pw+bhBJDoI1uzWrPtRCGH+W5VzlfvQpRY3syXFFy5kYoJA/q07GKsLKtMCA
 8y1RTdS+hAhdEfjHx4nCRS1LOkD9/8WNoQeYwEDx9Fa5fkC1AFM/LSVDDj0YH8MLoK
 2vYNroz9oFvO8Pq0mFOKpEpJrLLeispVk/LUBt1HUNarr8iM2hSkNB0YQ++yDsSMlE
 lLhuwddMV+iDA==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=09aae78760389620ada6db613e940cef2e37729600902e165fca94b54db6;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 31 Oct 2025 14:13:33 +0100
Message-Id: <DDWJ8Q2MPP5D.2HMK9EU3A220O@kernel.org>
Subject: Re: [PATCH] common/spl: fix endless loop in spl_fit_append_fdt()
Cc: "Simon Glass" <sjg@chromium.org>, "Marek Vasut" <marex@denx.de>,
 <u-boot@lists.denx.de>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.0
References: <20251027110523.1105773-1-mwalle@kernel.org>
 <20251027230358.GD6688@bill-the-cat>
In-Reply-To: <20251027230358.GD6688@bill-the-cat>
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

--09aae78760389620ada6db613e940cef2e37729600902e165fca94b54db6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Oct 28, 2025 at 12:03 AM CET, Tom Rini wrote:
> On Mon, Oct 27, 2025 at 12:05:21PM +0100, Michael Walle wrote:
>
>> Technically, commit 24bf44cf88e7 ("spl: fit: Do not fail immediately if
>> an overlay is not available") introduced that regression as the code
>> will never advance if spl_fit_get_image_name() will return an error. But
>> at that time, spl_fit_get_image_node() was used in spl_fit_append_fdt()
>> which calls fdt_subnode_offset() to get the image node. And I presume
>> the commit was about the latter failing gracefully and trying the next
>> one.
>>=20
>> But with commit b13eaf3bb4e6 ("spl: fit: Add board level function to
>> decide application of DTO") that behavior changed and the loop in
>> spl_fit_append_fdt() no longer uses spl_fit_get_image_node() but
>> spl_fit_get_image_name() directly. Thus it doesn't make any sense to not
>> break the loop if that fails.
>>=20
>> Also, the original use case of commit 24bf44cf88e7 ("spl: fit: Do not
>> fail immediately if an overlay is not available") is preserved because
>> spl_subnode_offset() is now called within the loop and errors are
>> handled gracefully (and advancing the index).
>>=20
>> Fixes: b13eaf3bb4e6 ("spl: fit: Add board level function to decide appli=
cation of DTO")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>
> Thanks for explaining what's going on in such detail.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Please don't pick this up. There will be a v2 as this is breaking
any subsequent code in the loop.

-michael

--09aae78760389620ada6db613e940cef2e37729600902e165fca94b54db6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaQS1/RIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gp9gGA7bwn5zMZ1m6ibSx5Tjal5orjM8OUsfxX
GU6jKQHcXYck21/CcwHfymS02JC102+qAYC3qaEgYiyTLt7voKDOHUnp/Aytyw2Z
IJEPaEP/htU/mteTW1jFhMIQLzPNBJn7B0M=
=Tikx
-----END PGP SIGNATURE-----

--09aae78760389620ada6db613e940cef2e37729600902e165fca94b54db6--
