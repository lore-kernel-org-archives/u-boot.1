Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4EC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BE4E40CC3;
	Fri, 25 Sep 2026 13:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-0zJNFegeL3; Fri, 25 Sep 2026 13:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E0C5740CE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344707;
	b=TnfRojFcrbiIKBFImhrU+rxdxfxaz+FFErvQTxpcQMhq1PAzY9x9Phrz0AWOnhYlqlUl
	 hailq9Ap65CYIzGbw2pzjJHfiAq4eldQFQkEP/K0sflmzhgyDiwwbVT8fHnWiKIT5TJ8T
	 3Sox3fkfEJROwWOJzj2DustniUvES8LE7jb1S+H2YoAweVZxr3RbEk8AcgsthatsGKLhc
	 0R+OL2PaKEnGEj+ArdiwC+cK+ABCll0DgcaUE9DzVgKz8M8UXqacYLP/g/cG+l+/weCWe
	 wG/3INQsuzhYTSTh4a0Gid8Duc++XI3z8bKAFSlFO/qzzlBQhYsvbq9CG/1EebP8J4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Cvkgt1jmB45186ww61ylrBV9W3+Y86JiAJZRcVIro+Q=;
	b=NY9sLrOdB+sFxX8g66E/dyyW7QYCjAHKoPOyAll1aKJi/+pqEvgUqLB74viaU7YvQ+E0
	 9wOoFqITvJmruVeI3Gdav9j9vEBEV+XklwpT4Efa6D03q8FnOwIhHZIW8LfAVjy4hhmeZ
	 /Br1sGROy3qKRRh5V3Gs6H8JLPhU+QehO9tmOXkCYn1awMtIIyXtNgVoZaVCyZ02AlvI2
	 GMUMNUUT6wHgkNnVNumO9Tz62vW/LUH8YbSHeewELm1dwwadQyVhuCvaeCofQeDSNWuK/
	 wpNkhnPZ/j+00f/0IOi76Eeo6v5Qs6qu81lTM508iRmN/MIWipoxV8bPYaUjx81OIPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344707;
	bh=Cvkgt1jmB45186ww61ylrBV9W3+Y86JiAJZRcVIro+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqURCRY6RfcHIuXsrSbqDzKnKl4oJEJSaR7sU675PtGiTuL+YJS5eBtU4jQtP+fPM
	 Z+FnLl2xEZDS928W1HGZvxTj0CaPhhpp+73opWXDq7u6htQUoGN3xZHZumQro+RBgJ
	 dnsJ4+ft2T4UfFSx7lUZajG9DZImZHFT5sMssWTqY2iDvEAZNAktvZ8PFw/rlQk71O
	 YqjnPntyIzrqitTq1KvrSiMnF85p51fpIOXx/7bi0iXeleJjgjGyKQ3yqtCyr0C96x
	 rD3JbHQ2duO9sHFFT+lNysDEOBKVSblVgwgjpxzWpBW7i09uxVBtnYKuoqVUIGtzJQ
	 Fwq7NSU2VEZNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0C5740CE1;
	Fri, 25 Sep 2026 13:58:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7FF435A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEE06404B2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qryzpSwtIZKG for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 13F1A4005E
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790344705;
 b=XHmMqhyON74ig2x5v5ZlpnTroslFRRoRF5cBXwbHG72IP4QChqUUTxamk0giGhvfR5Dn
 oXNAzNOkdC8h0Sr05zKE0hu7exrQifUv5p97zifvd04eWTRyFW+l7veEcZBPWGA+xXgR8
 LVvNcdFKnvtyipMuVcJBgosaYop4ivD2z8COTp5CKtjtigWH98g23XChYrr/iCKAt9TyD
 gkpTh8EtrpjXCIuhmrx98y9UtVkr2P0Ycw86x4lOclHYlXy5Q0z8I/egB0cFRi1DVnGog
 A4yGIaBJQ82p91opQmN1kPOSdoQBwESLSI6QjYZ19XluYQ/U9mXxfO9AnFv6M4NEZIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344705;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Cvkgt1jmB45186ww61ylrBV9W3+Y86JiAJZRcVIro+Q=;
 b=q32OCaB/wWXIjDAH/fxnsZLjaOKsFJK7Y/hhRBxwH/4r91DIHS6fSa0ypRZIYyJVIvQe
 R0nV2uPYSQMRimK91Zfy+Iz9ReWnLRmq56lfeiovn1l+pO7rFvb2DGUsN+QmFy5tl83h6
 gLCn6B+gDLyFnrhjLaA2FtZWODaG8V0uWsxmMCQOpCUssEQ93gVKDkydagB+85NpvvCpq
 mnX/W1rq2k2G9V+gmRR3CdWNYWVkuL+VQMhpKBpzsEK+9+UqIcfTCVBhV1zOpahEXlV9A
 0ZfUHI+xT2NRMsY4o+/Ks6WGGXJYDYpPrJkvA6g967DMRwjoZxY/9j+F7QWP8rMrL1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Wq5dzuod; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Wq5dzuod
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13F1A4005E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:58:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37F2060235;
 Fri, 25 Sep 2026 13:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685521F000FF;
 Fri, 25 Sep 2026 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790344701;
 bh=Cvkgt1jmB45186ww61ylrBV9W3+Y86JiAJZRcVIro+Q=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Wq5dzuodEF5iJAjzv54xxzz3zG+SGrcAjRBJuUN1RXy07Rr+ex7uJ2NH5ZgGtbvav
 7gmjvfFSalXC9f8YQTBdWtE/nHtbS2lQ35gwKdi8kBOgLGtkvV43rD/P3vPIV9cIhP
 B7P8z6hQkeCZPplpa0IdCBT2BpBnkmszkBH2vMxN0ioRcu3wOclhY015or7J6x516+
 VczbRAcRk5PCdQFC/8uo087zYpVUtwEUFVRteab1HHgb2kLwtr6MDpceb7Emku4kBv
 2cz23/cmgeky9UTl7z/n7lTrLV8nDlGyME3cBN3SEOH6902ZRI81SEfU7jp3PIJSaA
 6rTHWQIyECZog==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
In-Reply-To: <20260903020231.1278473-1-marex@nabladev.com>
References: <20260903020231.1278473-1-marex@nabladev.com>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Synchronously tear
 interface down
Message-Id: <179034469970.469265.3013487861631214003.b4-ty@kernel.org>
Date: Fri, 25 Sep 2026 15:58:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Thu, 03 Sep 2026 04:02:00 +0200, Marek Vasut wrote:
> After fsg_unbind() is called on UMS teardown, the fsg_main_thread()
> which also invokes handle_exception() is unlikely to run afterward.
> Therefore, any exceptions raised in fsg_unbind(), and also exceptions
> raised in fsg_common_release() which is called from both fsg_unbind()
> and fsg_common_init() fail path, will remain unhandled.
> 
> This leads to a problem where FSG_STATE_TERMINATED/EXIT handling is
> not performed on UMS exit and the do_set_interface(..., NULL) which
> shuts down endpoints is also not performed, leaving the endpoints
> enabled.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: f_mass_storage: Synchronously tear interface down
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/b49d784c2346c0cd84330fe11e0a1a5edb674a67

--
Mattijs
