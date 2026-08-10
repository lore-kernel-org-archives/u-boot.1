Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6AEC5AE49
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 14:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26F0B80E35;
	Mon, 10 Aug 2026 14:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sOFJRKSwv81q; Mon, 10 Aug 2026 14:20:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F5C280DAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786371620;
	bh=7WImb7iifu6ve+vc19H5lRPSG3WsDMC1hSHa2apEHsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WwNlcEi4DkRF26tx3B6AnOpI6Czb76ITOpsYIfhLcJ8V6IZSJEnPxZMoxo4l4XYXo
	 3zbJ2uloOhqnzUydeKouXB4viWjSSzVgF8kM6ax/XW4iwtHL7scxUqqLj5ATB0sfyA
	 OxYWO0xSDP7N7QGCPuKMNw9gyfvG1GUEtYqyuP5FSha1Mv/yVxtO/wOfF3vpJWJ0c8
	 hRVsftmjDVBfzs20sd9DTouMXSvMlxD4Y8jWT6vjEvB2BBYJvKuPiSSXoGWphkimQR
	 74aT4OhceKQKu6HGdzJ0OujImdwm5DwYsYj4MlN9v03dXnCVqaUIxN5tMlqYLtW9km
	 UzNukykG2bz8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F5C280DAE;
	Mon, 10 Aug 2026 14:20:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A950F10E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B38F80DAE
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsUxxEM7ydSF for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 14:20:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::10; helo=mta1.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7126880CBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7126880CBC
Received: from mta1.migadu.com (out-16.mta1.migadu.com
 [IPv6:2001:41d0:203:375::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7126880CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:20:18 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: from meli-email.org (160.90.43.132)
 by mta10.migadu.com with ESMTPS id 8cdf74a3979e0ad0;
 Mon, 10 Aug 2026 14:14:11 +0000
X-Migadu-Scanner: mta10.migadu.com
Date: Mon, 10 Aug 2026 14:12:29 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 0/4] Add Amlogic T7 (A311D2) and Khadas VIM4 support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com>
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
Message-ID: <tjk4vd.es3a7srwhle@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=9Vq7BOLm8E2zkypRWwgoHhY9ynJDS7GlyVDeVGTFM3k=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371616; v=1; x=1786976416;
 b=I+M6i8hUSNBb8WrfgUallBCX8+ElzHmQ5NF2Gwp8L6y+G7WEysmaa3Mn44EPHFXyQ4g7WKgx
 081t1UpbrnOUs3pcvn12RPDYAhGRnmgWsmZpAPHwSA31WDOO5ZBXCQxVUwbCRo6lh5JKWKyT01w
 GjQ1T2BSX0mbEAhXOFBuUA9+etor94HyPyo4XcYolaYaXe/Xr8FcMlOIunOyZd1x+gNGpXsQIoZ
 aJYWxeq1De4fwE0Q7U7/fhqqzGE0QRsgAeAOmLzU4KBqrxbqwIfu3bXup2vKIMKyHmomKzLy1iH
 1Pg/p4F25Nw+RO+Q1KTZgKwDQQKyXDedDaN946QHxkjRQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=I+M6i8hU
X-Mailman-Original-Authentication-Results: mta10.migadu.com;
	none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>This series adds initial mainline support for the Amlogic T7 SoC
>family and the Khadas VIM4 board (A311D2):
> - S4-generation UART support
> - the T7 platform code
> - VIM4 board and defconfig
> - VIM4 documentation
>
>Tested on a Khadas VIM4 board, both chainloaded from the vendor U-Boot
>(tftpboot) and cold-booted from an SD card.
>
>Lucas Tanure (4):
>  serial: meson: add Amlogic S4 UART support
>  arm: meson: add Amlogic T7 SoC family support
>  board: amlogic: add Khadas VIM4 support
>  doc: board: amlogic: add Khadas VIM4 documentation
>

You made a typo on my email address, I'm funderscore@postmarketos.org,
not funderscore@postmasteros.org ;) I still received your patchset
though (via u-boot-amlogic/u-boot ML), this is just for future patch
revisions.

Best regards,
Ferass
