Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16315606A335
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AvUtLND/;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=LnwywsvU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D3C74077B;
	Mon, 16 Nov 2026 16:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZFAEi-0TgaH; Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 908C94078E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845644;
	b=ePlXfee7BTbS522p3ILAzU0Z/gfV4mAhgYtz4LoisRuxxM1viqY6gzcjiRVFhSkpaipd
	 EgzhK/zbSgZZ910XPPsqj5yaJ3ATeH2pA7Fy/72xdyN+bePJi7fkp46lagcDw5SzHarLu
	 laPKU3n/V3Q4YYOrdGPlOQ40xz0EVKePzyBXQalYePkBZwrhQAV8GucJjjIdbQOUE5usP
	 u7VcE7aMktoffRmKXqdHxOYr85BNzPamcsJ+aj6cAR485vtvpawEGZ/SefQ906gMHcsjg
	 ol/TmpDKx1BLnfIQSmx2rHMtP9IegJAHeKQZrSet/bSHh6/VrtrqKf0xhY+KfBYPwbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8kaIUsfTjskksP6ifFEqOa00knQHUcNWQqGOGnKwayU=;
	b=ZLInTRpAFtqa6NjKYYRD7qarHFYPqf/mlJTYpAhzPvh3K/bC9fma4q4Sq+pRzyQOeFKg
	 7j4vE6uv0xd7NgeYRlOe8fyagQTnGnDVpXoG7ZKszQfA64/TtbdWf/lmbSAltX1xaZoFY
	 es0py0qcbH3gCUtnoJ9CgZXruND0OR9ssAuN0z7uuNQmLm/AuyQZDhovK8jIU1M2+XdMV
	 15lK5/7g1AZKB8AalrJ9P3mytXVMYe5bIgZ9wALdNX8YHzIZIHjq1MaQORzGSA3C1GR/z
	 TfIF6zar2Qzuc1e1979R0v5/kZlmB23DLDs3n7pHWwKabw/1TfBUtZsDVno2oTwMY2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845644;
	bh=8kaIUsfTjskksP6ifFEqOa00knQHUcNWQqGOGnKwayU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvUtLND/b3PrTZF/9lJzbG0eHhxA3lXg9bQCIWiHljF3J80w66GEIQ2Vc6WE19Y5w
	 MANkKBYgeydSfPAhbOjYG3cGvXTIk379TeCtyIZOk/30xHviTZS4cRQu5DHwpqaqwa
	 QoJjNCkRDvMMoKusPeQmpLT0FtFqUVNe7olnSxGJDzXfnbmQdAzsiX7wX7lSh4k3Hb
	 bseglMTytZSf7vJTVoQrFhAMcy8eNZSOEOTA5A1rPzk/XgUrLmj9010ZMZdEaRWE5X
	 qqUKoh9540ko505p+pDXq1Gl9imYCflwxauNBlN3e5Wzh2TGjiN1Cx+neR+qNf2j6U
	 V0JpLTpMj1TTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 908C94078E;
	Mon, 16 Nov 2026 16:14:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1627B169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDCEE402B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id of91NI1nc65T for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF7244009E
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.125.25.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.9;
 helo=smtp-1909.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=LnwywsvU
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF7244009E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:14:00 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jStGG0qWdz2KtN;
 Mon, 16 Nov 2026 17:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794845637;
 bh=8kaIUsfTjskksP6ifFEqOa00knQHUcNWQqGOGnKwayU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=LnwywsvUzWPkh4RADlHPPqsw/ZqIwxSZLPDCz9zIqtvUiHYuxEPbD80HJ8r/Szw9Y
 NLLwf3ytE+el51vWxhEN8ScblSE8KqhNaNgXa2g/ZdtlovfHCQg5X7gmvRptX9wqBY
 QVgSih1SpAf3QbkT4XaHOTmAt749BZY4VZkQLucmlmzL7kK+Es0EEch7Py2CZftu6u
 bTw7zC+kLkD8e/E7IIcTa4yWspmFKPNr+jI4E+ajO12NmS1vZ0KEC6G3FohYyKOgh8
 qk2RUan7r+dXxr/8CVm5w83Tf+MVaf04RnqOmAt19qCl+hN3ihh3XLE7jQmyLyHXlv
 FNJoqXwN9FTzg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jStGD3qkkzvnw; Mon, 16 Nov 2026 17:13:56 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Cunhao Lu <1579567540@qq.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Anshul Dalal <anshuld@ti.com>, Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261023-lpddr5x-size-fix-v2-1-508af15a8200@qq.com>
References: <20261023-lpddr5x-size-fix-v2-1-508af15a8200@qq.com>
Subject: Re: [PATCH v2] rockchip: ram: Fix LPDDR5X size decoding
Message-Id: <179484562584.1840799.9607120740574550358.b4-ty@b4>
Date: Mon, 16 Nov 2026 17:13:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 11:10:23 +0800, Cunhao Lu wrote:
> The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
> bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
> 0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.
> 
> Replace the DDR5 symbol with LPDDR5X as type 10. Apply the existing
> LPDDR5 bank decoding to LPDDR5X so the same register values yield
> 4 GiB. The type value matches include/soc/rockchip/rockchip_grf.h in
> the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.04), thanks!

[1/1] rockchip: ram: Fix LPDDR5X size decoding
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/45a8c263a3fb5fc1cc02d844e2fe6e9e7894ff4d

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

