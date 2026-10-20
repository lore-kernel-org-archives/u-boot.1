Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A07606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YkFAurF8;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvsYxjc5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3471280D62;
	Tue, 20 Oct 2026 11:49:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVorua5yl3Hl; Tue, 20 Oct 2026 11:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A591280CD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792496951;
	b=hyQaQ02u9b6waekjZ2f2NPeNDaOTyDSbkORjdx7YOinrYpCW/c9hVpTTgyJ2CxylvWvH
	 xq56OYMA3GW/wladfqOPNuUb9uV6w4na4D/XLUX3pi6b3GygkuD6S+575hUJyGZdVY0rB
	 hBo14oQPpEqWGC1IryGeXlb1TyPaSXCpfMo3sRkfZhyigdaQS9Ah1QHn44lAa5hgTfjVP
	 EIAWDxQxwFf2RyJjTf1Z8BRayoLwVOYRvpmm8C+y2ihO6h3mG8D8wUM9DJRkKBu6apQVI
	 74ljGWmJVnnMQ9WL+jNPj3BzH192C7LF8vHGRXz18IM6JeTyOlY0yVYaQCVOsa+wnoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792496951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wfub/P04i3upTkRIao0bymrxKu0kPP+ZVSD3H1h2SyQ=;
	b=dYGsb7ntDVOY1MhHBK6xFHCRcHjmIVX1+JZvRcRdH/Zv9wRX7q/Wgqa5AvxkA4jjyyhD
	 zqS6o7OhfgbFiPf0KZjy5LR9CulWBv3yOutudrS1PX4WbSut+uoayZuV8RfxlGYL8vCZw
	 AXJX2Pjilrz5qEopR9bug8cPTfZ7rXqVQhcxV9DGesuxigWpWkEzeJLXhwHaS3id2J9Fr
	 CcZhXPG6nOfEi8FwWMmfc5kt6X+LLqHHyt0Vv+PvgtiexVaOGLxDkSk2OHjTEBesGwId1
	 NqIkGjJUJ41LJM8+/fcy+kiTg5pXzXeCLGstOiAEvTGwVAZ+WuUS3Xe9Nhr8RdYmJTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792496951;
	bh=wfub/P04i3upTkRIao0bymrxKu0kPP+ZVSD3H1h2SyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YkFAurF8af189FwqZtDd/uDEJjr0dSGu5CmgLDyj2Z0ZVlQU3q1loawJaLdqcmNL1
	 P69NVb2LOJBxfFAJU6SNbQvDAkUYAKSaJcaqMaBmb+K6dqU8eFcrRwK0GDx3K1GbYI
	 OaVijXHgt3UYecos1Vt7jF3743N99BL7Uo1dGvLU77bsIk5VXEfOS11+mY1SDulWFp
	 wFQICxr8IxuAlFtCVgle7GkKo741LNzf4c1+xwLkhTaAJNvrERVaMEu3rDfncDKh9R
	 1FiawUbnu30cRI2PkwaKnIINsAvTkBodbqR45BYtgesxO9XvM3PARUgSnHuDx395Y0
	 BEPFVXH1c+Z4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A591280CD8;
	Tue, 20 Oct 2026 11:49:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B53A61AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B626405FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WngQsMTgOLM for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:49:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D40D4405F6
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792496949;
 b=kM4HanGhTUW1wo30icDpUaipMqobqJYua1V+57OFqnuIjeQ0IoJ86iPq98YjfNb1bLR0
 HbL6wo0svUStKsJHqwXuCHAROEWZhvuzR/iZPTOdbNy9BJnLbTw7oUFRmmrF+yMZGGAGL
 X4rgJkesTbGwMfyflbkOmPYa4i0NoE7IJtBDj0acF1covbBHDAETyns9Wv3yMmnNeVjPC
 4RsM7yiVzZVomj/gyp8eOrwzYKv/d77zLcDbrOZWZ9ifCrhUUq/Dc9U0IOqCwqamFMK/t
 /VoR4+y11CzzL+HQR3NBKP5xHxWJEXuUdTo2q6K8p0Y3sHk06ZOAwBNGmQwVp1TDhAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792496949;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=wfub/P04i3upTkRIao0bymrxKu0kPP+ZVSD3H1h2SyQ=;
 b=T/NTJbeg7ASodwITr1RZhQg3Yj/gVujh0VE3Doa84K1Tu4RS0MrHFhQUzJrPjYl3ROWm
 wbAnQWN3y7mwD6XF05HJjMU9FmNTO+bsui8Zzxy9uk1Lxo/MkekinQ1ZIadVtoM9hc3Hy
 IjNx+BvNNu6JQHhxCOw3uL3hbKDt6pCWHZDG/ebTcLpnt5SQM13lJ/Au3qc2lfRRQJFBP
 PxBiynXDqHOovp6DkJ97S2kWWo97Jf0bnTYPLf15YsMMlXhOLbMDUssA8C671zmmE/kHo
 qPYFaYQsVdXt+0cKIxKQjuPQ5890/AfxSWUbFX+Ta6Y97Ni5+hNKXp2jEVrm9KXQkpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lvsYxjc5; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lvsYxjc5
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D40D4405F6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:49:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2B7F60098;
 Tue, 20 Oct 2026 11:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BE1F000C4;
 Tue, 20 Oct 2026 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792496946;
 bh=wfub/P04i3upTkRIao0bymrxKu0kPP+ZVSD3H1h2SyQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=lvsYxjc51UPbudaZre74o+9AHvi5AAVFfuhm0By4dGZmRSHf/pD7mOMKaNVqLWTMX
 rRaOjgs6pIdJBXLXHpL4so6XYJlXUIp+y+0wHvFWwVSg/PHKTj6IEdOIFXYhKAe8fb
 8ZsKZsGWm85joQmMgkLWxkoiC/xhLD+C2Quc03HEDXCJ5dNdQFDhryfdyMPFbBEEVW
 U0dnOuohyCHpf4MTdh7IVExGQRx8EGGt1yTEy4Ue9C2RwuJQDQDFYoYeuRJoT41XPA
 9Z1FGUj8CInTwO16qlMYLnNtgSO3IaHUd3bbmQ7j9G/9qtMn9Helmi5fYq+bmRflLU
 8IGjhMreduL3Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Loic Poulain <loic.poulain@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20261016203927.6362-1-nacht@dxdmail.cc>
References: <20261016203927.6362-1-nacht@dxdmail.cc>
Subject: Re: [PATCH v2] usb: gadget: acm: do not requeue failed RX requests
Message-Id: <179249694459.2653968.1540590519327479418.b4-ty@b4>
Date: Tue, 20 Oct 2026 13:49:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 16 Oct 2026 22:39:27 +0200, Nizat Mikayilli wrote:
> acm_rx_complete() pushes the received data into the RX buffer and
> queues the request again, regardless of its completion status.
> 
> When an endpoint is disabled, the UDC gives back its queued requests
> with an error status such as -ESHUTDOWN.  This happens when the ACM
> function is disabled on a bus reset or disconnect, or when the usbacm
> console is stopped.  Requeueing such a request from its completion
> handler puts it back on the endpoint that is being flushed.  With DWC3,
> dwc3_remove_requests() then gives the same request back again and
> again, usb_ep_disable() never returns, and gadget teardown stalls.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: acm: do not requeue failed RX requests
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6ca402e0034f2a23f10a29ce3e4245f2a4544a4e

--
Mattijs
