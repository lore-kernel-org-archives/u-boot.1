Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB8C5B56A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 05:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B110440824;
	Wed, 12 Aug 2026 05:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSeWsUIfL-2H; Wed, 12 Aug 2026 05:50:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 675EC407C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786513852;
	bh=FzNrG3uDoz28PrbXYQyJOezK2jZtoz4hS+3ce1o+9tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ptHbwYDtMx7NiCnKj3fdpAezP+anMQP8H91Widk3Ft/nWwHxAj8+/9z1pSDRgvrcT
	 7K63Qm4k1dz5rJkov0q8aGFqBSXP+9j9Bc1WPt7WBSYaD7f1uX6VlF7dXcOcl/5PPr
	 nRa6WnKn8cGNidOJEOJTW9g3hec1HF0vU588g0Ehw4hYQ6DdC7F2eXABdIjGdEml50
	 2l9jIu24uurEs5SRNHcxqVHXvSZq+n4AfxD3CXO1z22sbYUOSz7zslgqil5GafMgKy
	 K8vIuQD8GDjgC6N6RyUdO+hqm091PGeAeMLMqWKeXMbywGneVIbWmBCFm/cD3SBTov
	 UEeUUMjfx0pgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 675EC407C2;
	Wed, 12 Aug 2026 05:50:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 690021F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 05:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53628401AD
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 05:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZn82TVroBjK for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 05:50:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 18A724019A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18A724019A
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18A724019A
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 05:50:46 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1ACCA1F8D6;
 Wed, 12 Aug 2026 07:50:43 +0200 (CEST)
Date: Wed, 12 Aug 2026 07:50:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] toradex: select EVENT for TDX_CFG_BLOCK
Message-ID: <20260812055021.GA7756@francesco-nb>
References: <20260807112545.1883789-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807112545.1883789-1-mehmet.fide@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dolcini.it; s=default; t=1786513843;
 bh=FzNrG3uDoz28PrbXYQyJOezK2jZtoz4hS+3ce1o+9tY=; h=From:To:Subject;
 b=RnRSi8dzWGa1tmk38Kgb+jnuqgnUcMCJHBNQ2L0BaIGU0xEMZ9Ch/hLlkBnELnI7N
 A8v2gkDl8ZsYI0Z06aOW1MtDVtIALb5+LBXxkqfMSZw5VXMqXISndEH41m90v2ZaKp
 uTspv3i9Ep9XgxGVlxIT8ZiOND174g6N02jy86agLjHoFSQtlLb1xHsG5BKAjexIGI
 d+Jd/9Pj6CNobVPnlBO+ji6O+s6Y2ZOwZ7sTCkH1zF27V/quDF2saQq/0/CnDh1iRy
 vXyxkr7XgYKREEW6zIgp5be8DO8+2RkSHF/ZohHaErQtGyFQ6p4StItpIT7wuD4K6u
 IpYIcxXGDQI+Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=dolcini.it
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=RnRSi8dz
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

On Fri, Aug 07, 2026 at 01:25:45PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> The Toradex config block is read by settings_r(), which is reachable
> only as an event spy:
> 
>   EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
> 
> board_r.c does call INITCALL_EVT(EVT_SETTINGS_R) unconditionally, but
> with CONFIG_EVENT disabled event_notify_null() is an empty inline, so
> the spy is never reached and settings_r() never runs. Nothing else
> selects EVENT for colibri_vf, and CONFIG_EVENT has no prompt, so a
> defconfig cannot turn it on by itself.
> 
> The effect is that serial#, ethaddr and eth1addr are never populated
> from the config block. serial# in turn is what fdt_root() copies into
> the device tree as "serial-number", so Linux loses
> /proc/device-tree/serial-number along with anything deriving a MAC
> address or a device identity from it. The failure is quiet: a module
> whose saved environment predates the conversion to the event framework
> keeps the old values and looks healthy until the environment is
> rewritten.
> 
> Verified on a Colibri VF50. Before the change "printenv serial#"
> reports "not defined" and no "MISSING TORADEX CONFIG BLOCK" is
> printed, which is the signature of the spy never running. After it the
> banner shows
> 
>   Model: Toradex 0013 Colibri VF50 128MB IT V1.2B
>   Serial#: 03135809
> 
> and Linux finds /proc/device-tree/serial-number again.
> 
> TDX_CFG_BLOCK cannot work without the spy, so select what it needs.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

