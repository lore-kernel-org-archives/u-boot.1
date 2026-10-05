Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1327CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C3A3605EA;
	Mon,  5 Oct 2026 07:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pw0WnA4JYKUW; Mon,  5 Oct 2026 07:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D6DF7605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791186352;
	b=X5LhO0cVpinJpFskHKH4nXGvZa4UGvwzQ4IpRoRsnkVzBBrlb2Wcu0+MiB6HbJe8RHaJ
	 Rw9DvhN0MZvrNGvEltItnTMRTkf/fgIPxu1ZPwxZEWOyVCCDi4nt4WsVXl27a7exOoQ8Z
	 WigN27MGcPFvH0/JBilOChNy1AEd97L7OKXe5VHGOIU7VaI26pRQch0+Xh7sGVyPlu9Yd
	 gFzv4RTUfRmX/mHS0wKnc7wN7Zr0KYHiLuTjHxWDNLtCSl7fqY0p7g5dKkdrpNlHbqxHB
	 s/EgWz0MSdt+nfblKTZQB1sIwCY9XKouvejIyyIlCUusUN25Vgdl6NB4dwdQf+JzVSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791186352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
	 X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fYdCMrJDztdbhcn1PxpL/MWRbv7ODDqSw9f9CGb7b3c=;
	b=T9eUunFkAykNW0mkq2wP5ddGnLh2/ZfcPqhJzpeR70iCOQKvfJxkAyt3W3Gu1tWYtl8c
	 xPNjtG49ao8V8O8yvQm6CPKBgoo3+kHfSViwkN/Yxu/LCqzf854YEdqSGJzTZQqxcCY+v
	 mt30CGsRylTy4Yj2yxSaz3TCDm+1+gRDsUVWLH8LQjh/zq/TUNj2osdL/+evXPSmG0kxm
	 16zbiJB+IIAG7BEehrpaOxpuhniOfKOHiYNY4ZtAJqoEDtF5KYdRW4OhZRz7txKJ6Uf8p
	 lxw7FcqozLV0ZixZgg5oTPSFtrlOGVk42OV7dg3DOkMhpL/Btg0uWNpuN4eenOAGXJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791186352;
	bh=fYdCMrJDztdbhcn1PxpL/MWRbv7ODDqSw9f9CGb7b3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0q+G620pxfbd2km9rYDN4N4JdVTntwxlqutrKj9wMPY3MSrBNUliKoYNATR5Tjn/y
	 o2UP0Rhtd3W/5uKqx4QZihIxrHO0m9tIi9J2FtUvt1TznBrWnSXLDCD8NlNknvOi/z
	 +z+s/2/X/muR3lRMbQTOXuD/IKpFRpv8HemDqrBLktYINjjo/ujry5vdjNJUgkeVFT
	 BAR2cbSeEjM9WIkphWZn+xo6ytEoaYO7qmD3I9jGJYKEphQtKcGISWYmVkmQFdUCSs
	 pkF7Kk/Dys3T0La4I8T+U4o3Y6OsQFf8IfK432W35U7hMDwuY5pVYTIetoU11gB+MK
	 4T11XggFd6BzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6DF7605F9;
	Mon,  5 Oct 2026 07:45:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 540891A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45345405B3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybl3uPpIGYdj for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:44:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7E28F405B1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791186286;
 b=QRQERzVorBaHR3wItmNQ0V6YVWqgXhWDpsY4EAXDIeWlAgc/6k/Mr6NUrdlamks2hN9R
 QzUW1QVvBB5zSFf9ofsEvnxQEza63iAFYFm07Vp6Sx9niOVtR0/ZIdW7YQs1OksthS7Nu
 uvuvQpixjgeCl0cdKxVZWYNMH3TXDlTAXa4vUNAV6u7D7kCgQhxGCrz29K85dy6o0K6kD
 +YzC3n/lk8rkxxJnorHAPqTQ2bJ+XISZxXtHkIgFybGxzlLdTBD4mGhzfsVmCgeT+Lc5T
 ocPTwMFFZDKTSvfK2ZlDxnVaWGTkVNqnY7Gtz1z4T/rSv+mvEjKjEnmiiCtGhxT/F1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791186286;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=fYdCMrJDztdbhcn1PxpL/MWRbv7ODDqSw9f9CGb7b3c=;
 b=bVN63/jq1V4/B8adakj29+s5HjH8bIflLxMWu2Khm4IKYq2Vuid/Wg09aO9KIp6fWcAv
 zfhQZpZEYCeMm5R7z1Mjnrc8C6a2odInPcHFB9aHrwWmzVJMZbHK+W8YVq3gmYWb/A6Nr
 hYzl72J0Tms6VePc6ArUIK5l6g2fXJXD3xWtqJ3SZNdN8nGPFz6FAa2InspEqti3xb5U7
 R7BV/RxAwEyyUhHBkboKp7iwoCCFUbn4yCFQ6h49RARYuZVKjoeuXu0NIVsexF/mWJJd2
 vi7XWX63rsQcTUlDqzcgLmpV2JWQWLglW9LkcCTPEEJXlW97BpB7a6z++PElJom8fNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pvtz0csq; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pvtz0csq
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E28F405B1
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:44:45 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hyry14xbPzKmBG;
 Mon, 05 Oct 2026 09:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791186281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYdCMrJDztdbhcn1PxpL/MWRbv7ODDqSw9f9CGb7b3c=;
 b=pvtz0csqEgmDv8xDmV9iMJOxSCZ8xmxRGOBy1Jn7U/TsDlmdGa+m9LrHczr0EwN9YsAn/c
 v9FU5777+6wcAJefDEquXSZRidcfgx/FN3ir9bczkaJxByhOR+fJQL/YWLvRhTF91WWgew
 ylsSQ2Jh1+zNKdISrpeX9/Qxv1TgsphTrinMlrim/XqOaCELmjWU2nbVvtCRpd4+fWUyMR
 QCqZ2RKEsDD50plrRe8GocOne6piY9gfEIEaOkW8ayT0XD8N4uOLh8lUd4z6VZsm1xx9yw
 aGGbifBVOzwY0xdsrNyzhgX92p/BWj4oxT9OohbwmsCAYVat9ychXbY1d17+zA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Bruno Banelli <bbanelli@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: xhci-mvebu: use regulator_set_enable_if_allowed()
Date: Mon,  5 Oct 2026 09:44:37 +0200
Message-ID: <20261005074440.589817-1-stefan.roese@mailbox.org>
In-Reply-To: <be41cf36-9142-47a3-828c-c54e4c669de7@mailbox.org>
References: <20260822092053.63884-1-bbanelli@gmail.com>
 <be41cf36-9142-47a3-828c-c54e4c669de7@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rycwdrdaz55wo5u86rxae331nizawwog
X-MBO-RS-ID: 0ef7d8dec625d19558a
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

Hi Marek,

On 23.08.26 11:40, Marek Vasut wrote:

[...]

> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

This one and "usb: xhci-mvebu: use dev_err() instead of printf()" were
delegated to me in patchwork, which is probably why they are still
sitting there. Both only touch drivers/usb/host/, so I've moved them
over to you. Could you please pick them up via the usb tree?

Thanks,
Stefan
