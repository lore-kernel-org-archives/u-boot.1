Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C522CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF9C86E03;
	Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448175;
	bh=qZSgs1EVPM5Odqiaiun6MKqVNk0oAvnpOjUIcm25s3I=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=FCmTPTZaOnkLHEUH8i0df558oBgTe+BUtbTdrZ1pHpsgBCdsKUY/mT8/MEllRTA/e
	 XpU+qCe4SGsmwMXuur2E63SlsEiLI5TAlSdj6W+bjH8WfZSMrMTIjnYmZRDJ0lYyac
	 6+w5BUUIOCxwTsRrJRIfy+Jj7w7hPw1LauzYsVolID0wOxVNyAO68c15iETEmElf+q
	 WR25TOkj+Twk1kGlpqbD2NO953T2hl+raIDfjQK5itx9c0oYgweRRsRIxOoO++vsv4
	 W3IiknHpdhkE0LKgJACkH6kemkzyYFhJwlGn41r/XnIYejTf0qvFibc4AhAECSwFLm
	 Cl6QUTdbRGH3Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA1A86DFF; Mon, 16 Oct 2023 11:22:13 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EA286DDE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BT25nzsz1r2sp;
 Mon, 16 Oct 2023 11:21:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BT25hbvz1qqlS;
 Mon, 16 Oct 2023 11:21:58 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id ZfD3Q8hE0MnL; Mon, 16 Oct 2023 11:21:58 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:21:58 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
X-Patchwork-Id: 1836731
X-Patchwork-Delegate: sbabic@denx.de
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,u-boot@lists.denx.de
Subject: [PATCH resend 1/2] imx: spl_imx_romapi: avoid tricky use of
 spl_load_simple_fit() to get full FIT size
In-reply-to: <20230919134932.134678-2-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092213.3AA1A86DFF@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:22:02 +0200 (CEST)
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

> Currently, spl_imx_romapi uses a somewhat tricky workaround for the
> fact that a FIT image with external data doesn't directly allow one to
> know the full size of the file: It does a dummy spl_load_simple_fit(),
> having the ->read callback remember the largest offset requested, and
> then does a last call to rom_api_download_image() to fetch the
> remaining part of the full FIT image.
> We can avoid that by just keeping track of how much we have downloaded
> already, and if the ->read() requests something outside the current
> valid buffer, fetch up to the end of the current request.
> The current method also suffers from not working when CONFIG_IMX_HAB
> is enabled: While in that case u-boot.itb is not built with external
> data, so the fdt header does contain the full size of the dtb
> structure. However, it does not account for the extra CONFIG_CSF_SIZE
> added by board_spl_fit_size_align(). And also, the data it hands out
> during the first dummy spl_load_simple_fit() is of course garbage, and
> wouldn't pass the verification.
> So we really need to call spl_load_simple_fit() only once, let that
> figure out just how big the FIT image is (including whatever data, CSF
> or "ordinary" external data, has been tacked on beyond the fdt
> structure), and always provide valid data from the ->read callback.
> This only affects the CONFIG_SPL_LOAD_FIT case - I don't have any
> hardware or experience with the CONFIG_SPL_LOAD_IMX_CONTAINER case, so
> I leave that alone for now.
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
