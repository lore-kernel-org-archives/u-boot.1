Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bf8ZKje5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZxXg6Ch
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE9C5408EE;
	Wed, 18 Nov 2026 10:56:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxjmr3e5Pu7b; Wed, 18 Nov 2026 10:56:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E354408D4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794999399;
	b=b1yn8NxaOgy/sug0Qbw/f45z2E2OPv16KfvRHw+XnOcURk3gvkTxH3HgxSP7w6unaJ+u
	 pOdAiuAADSG4BD9ofw6oLlHFEx83URWEqAUCrE2KkQ8dRF2tV0kNpGrq3pZT5BaTmpS/p
	 bg0eRZIsbBOj0Habnrt4nppkExGnxCdvmLdJqewNGy6Wr8v8//y3VVgHlFsWOoxtn2Cvt
	 lEGXqS8a3kRBsncqPc1flMTMP76+fW3/7kP5NEl2xbgQMdv1QwFvhzGX8C2uH29cQIuj+
	 hLRbezqHMDRmoNKwV189JMVoM0o76Rxoh7n3avN1YZcRSF2situgtm3iVK+klxwiqCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yz2Ql7QmaY2s8vnxR1Jks2SHxLt08YymDe4Nxhunz7g=;
	b=b+CbQ2TfQJ7OoVxc3fEtzJdxLs8XX5dyhjxBZ9IWh0fhal9SSzNK9vkR9YWHb2u7h0x0
	 /GueSPXE7SCfv6++3/CRPvyHK3lhWD573SZIgqzwazo8sj7ZeOigmXBdEoKATcXG9P/FD
	 E48UTPJooqHx6YfN8AGBy+cQqXxPGFYFwGjoKYUETTktE8sDR0csX8+er+Hi6VbF12lv9
	 z472zBCIrbIyxwgNud0Hp9DXwbPvT2jXb64Lp0SDWMHrgvuFpx+GNUQfa8+wfNEJ2swGH
	 ZP9kb3nzueLf3IdRvgzzDMcpS8N+XA8NwLcTaNjALupXWoA3l+FlTq6WY2DISbis/gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794999399;
	bh=yz2Ql7QmaY2s8vnxR1Jks2SHxLt08YymDe4Nxhunz7g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bf8ZKje5BvpUxTZtM8khB3Y9xNQVt2g/3yNl+tNurMnj4L9iEHX6ZpaUh2lMbrTnM
	 dbSHxmirJRCxDCS/T3D6N69XIgmrwec3IBUMLIig24CIkH3ATnU54BgpwCuHzn//kQ
	 TNMD8mNsbQJ9OI04MpY9z/t+9cvBp+FMOBM0QEg90y5KqYcndgQqEsEbFI/y9RVj4p
	 81NJMGGbtl93+S+DFBZ58rUdwT7HdRVlxGUtdERzDw84lBJ9HN8xl1lg102ZuRWNmX
	 i7gJ1DhPN0LHgNw82jDBK6KalXYZYAYxTuVCOko0LSgBWOK/7WL4qsCQ7c2F4P380I
	 elcMlxIXPO4MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E354408D4;
	Wed, 18 Nov 2026 10:56:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 158779F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFA70810E2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j6aZ-gI8klmn for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C365810E0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VZxXg6Ch
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C365810E0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:56:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4104611D9;
 Wed, 18 Nov 2026 10:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB66F1F000C4;
 Wed, 18 Nov 2026 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794999393;
 bh=yz2Ql7QmaY2s8vnxR1Jks2SHxLt08YymDe4Nxhunz7g=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=VZxXg6Chm+YLQ54lf7/pAFRKNGRxAXjxzEU1PRwkXgCr/TZw2fF0oGACL/CX6ZkWW
 q4dbcTzk1Cm+rha8CFcZVH++qCgQM3Eys+OhYHtzL5PYRaZBjCloygEhCUN0aq1/T/
 PupzXXAPxSpHbEfrW1GS612FXHTloyqeE3xqC8NRThwdUd8GTaZruKygDS1n2Ag2u5
 4lT5sj1/p9xJZ/IxqH29Cav31a+Hx0UE5uqo8rEBQOkAf+xDhgzX5PKRhzhE1AKZ3v
 HfX3QCR9yKBsni0YT0Lx69fuO4jQeSEM2GcPLrLvKf4ZcUg2Xz9sfj+jm7Xqv1waLR
 0sNwM1okvZfpw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] usb: dwc3-generic: Always bind clock and reset to
 parent device
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Fabrice GASNIER <fabrice.gasnier@foss.st.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
In-Reply-To: <20261029045837.813288-1-marex@nabladev.com>
References: <20261029045837.813288-1-marex@nabladev.com>
Date: Wed, 18 Nov 2026 11:56:28 +0100
Message-Id: <179499938892.273140.16829741085628807322.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=686;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=sKZUBCX1NaKrdLs7TprmFYAux/FRcgvwiMo4SL/Wwqw=;
 b=owGbwMvMwMUoySu7Jc1P0pTxtFoSQ9bfljjNREUNk9pJptfchWKTKria1H5JRVtcLpFUjW04t
 kY8JKeT0ZiFgZGLQVZMkUXvpdPybfJZ+4KF1zLADGJlApnCwMUpABPZ4sP+i+nDD6b3SjviQjhi
 vxUJ9que1p9j+XzWDMVUyZybU5euTPmbMHnPrOOsB+JWdh2uNdHLPm6vPUfgs8bTsuXMd++FLjM
 5erHE5O8iSV+vTdd0tGdaPZnVvj139uuS+sLK05ZmEvz696/09/lUXJDbZCnpeH/l/cWHxLdVaD
 z79v+3CL+e/ORDgYve2035IBhi7hfmVOF4aGP+bMXT0lrzpk1wmdDuYaA7P/dxS5qQGWdo4V/x4
 9OMtntEfZxwduGkn4JBwTfe8tqUBd9zSTdrvii49tOyxVoSH7v/HrJ+E9MvVSSYU5Fm8ENpRVHZ
 4VTP6bweXJJVuhtWius6GIRXmu5vqshMXvkpda7yqsxtAA==
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 05:58:13 +0100, Marek Vasut <marex@nabladev.com> wrote:
> In case a DT subnode describes the controller clocks and resets, make
> sure that both the clocks and resets are bound to the parent device.
> 
> This fixes an object lifetime issue, where both reset_get_bulk() and
> clk_get_bulk() internally call devm_kcalloc(dev, ...). In case the
> udevice *dev passed into either function is that of a subnode instead
> of the parent node, then the managed memory is also bound to the
> subnode device instead of the parent device.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
