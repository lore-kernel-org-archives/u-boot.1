Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE0606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jkAOGYlt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4pBPrYJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 660858120D;
	Tue, 17 Nov 2026 15:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7FlQ0ZZvgOz; Tue, 17 Nov 2026 15:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3AA7811EB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927873;
	b=SY3xnp6YuNN7faAdeGLGyPRialK8udRaOMOknvBxBhcqEJs3+vujDDo6FLD9Tx5j4pyQ
	 ORodJ2sOUdHXcJjwGfnGPy7FQGawqd88Bkfmabmmp+C31HWTN93gV3VlF+TMYRRz1sj7G
	 y7sRNVdkIR0Vxiw/HKPyQpSdXZkp3OfLAWFaXKZV7EZWFeCxaGtDYZDFbxMQM554gdtTZ
	 tRXI5ZvwZ/LAkRvtBTr3rgq/QIdZBHoyh9YFwJU/U2E1SiNip5v0Thn9owB1JO2wxEEzI
	 o9uE6QfU0kz2vZJHySfTKqtdu16jElibrGqd+UqUOpANebNU15D0gu+DBO30ga3507Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C0InE+SL0IlVxxydJtmBs0dN6+LrbGVAbT0ENaDwa9E=;
	b=ohi/vhAUU8S7V6CIQr94hc73ZWnBZf+FMoV5QR0sTnFYtOt//FkNkL8oaOHvlOYBtXaR
	 1dsOedQrKeLjmLWCUF4mjDvcJjH8AT7mVELDCeMnx0nTlqeYXjdBybdxGb2VPOlR4zHoK
	 oH2yfSpQnOT5egr6z9OwnOgwE7KvR3WKdm+6worT/aGELm2rzcC2NnoEEDZKh7rnTro9N
	 vqojlu9DXuh3mrETkAADQhdXwZRHWQcqI0X/tVQXuh1fUzUf5cuUExtvj2WuVKIVZ57nv
	 SSxEM4piuZzIfEN7a4rm8wiHbK3TvjcqtJaEpwADNmLj904qbSqDytjTsLJDn4N5MLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927873;
	bh=C0InE+SL0IlVxxydJtmBs0dN6+LrbGVAbT0ENaDwa9E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jkAOGYltr3HepdM2Tdv0cjz6BCEdlE7pq9KGmt007JbzIRRPuEyYct/kUpFQUGp/O
	 qsF/Q1XpQoHp6f4dT77RTvHwxFv6NZaJRIFJ4whFHUOFp1AA1VTW1vaiDomSV6MQXv
	 FNALcGxdHZ4XEVf3f6uETd+IPICcN+ZBFgzP3byJDfFUsEmSXnPbKcCqMw6wTQIf1k
	 l1HYFVHcbdq4kP+oZy1RAuDcNHeoCIyN+6P9xOtD3GfGAQjfPvd4q6pDfxe+f6smp+
	 9DzNEZdoRi/I7tysmTlfgYvqiN+UYrlVC7kPx0o9effYxjchLpI+rgrltng6q49QOF
	 /cPSoD2IbGlLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3AA7811EB;
	Tue, 17 Nov 2026 15:04:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B261E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6ABF407E2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mIcRqUQOhcGt for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 263704055F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=I4pBPrYJ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 263704055F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB20F623A8;
 Tue, 17 Nov 2026 15:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0A1F000C7;
 Tue, 17 Nov 2026 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927860;
 bh=C0InE+SL0IlVxxydJtmBs0dN6+LrbGVAbT0ENaDwa9E=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=I4pBPrYJfWjIP76FsnYTfUQOC+91OR34l4bPdBVeP7wKqVTCln0f0OUI2XVdQlraX
 +e8YaIvLaZ7ZA0gf5f0g2dWhlrXEt1rF3qklNG5nj786c5GL/6ne82fDesY4HBMpGq
 FiLA/WAG+7gT3X9QTooSZ0cP2FO7P+AOzI3hUgh2Q/yYdLzvYkkeyH/4sCi25+0ScE
 8fJdmkTeZQ2gGiPe9XvCFZypaPHUmV8ZY9fC/9CbyDao+5hnl0HE/uP0giHGsnSYo4
 ETteYqjiSYY0uTHm0YOi3irSSXB0Eo5YDQIPqrworyAOBfSiCvIjuD1CoyPHZzGVZl
 YXYxsTYUqSjDg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] usb: gadget: f_sdp: report a closed part as the
 boot ROM does
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <76f24ab2-df43-4951-bdde-399aed2489a9@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <76f24ab2-df43-4951-bdde-399aed2489a9@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784367.252888.2397855892377279993.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=639;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=YZAvgG8VJpt+jThXlH034kHxGvOmUF0rDFVMHmLUNz0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/GzoH7OZNwYfSUvMAgqIgXL8zZ2rof5/KXKRu
 UKR7ru4CGaJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs6AAKCRAZDR20Zk4Z
 NdfICADL8cPj7cEo47wnleaBgW/VUSp8mtesPRUZ1sL7AaZQCZ4ls64RR4vf5RbRC+MngMxhd4N
 t22GH8gs+53OmiJVG6yAwZC2dk6Bcy8gAD48cbZZLVlo9zUU9djDTn5BY49nsndCOrYSv3jktzy
 qLLL5C8Odt1HIm3vqrXi4gZluNba8ipGY2dpwrp6ZmHsFupsySnOT9aB99tv1ROFiioVTd7w8fp
 c46j9MUn9qRFp8+UABDavmeEqIYhPMkRaEEfDgLqw4m4BRbN9HAnOKxdgiSJdhORVjLeQZ/SWw4
 wzDoc75k4LQKr3Su1Ec+TjqBpBN5B3mDwyTQMz40vPl3Iwsh
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
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 07:18:13 +0000, Ana Bobillo <anabobillo3@gmail.com> wrote:
> The SDP gadget implements the serial download protocol of the i.MX boot
> ROM, but always reports SDP_SECURITY_OPEN in its HAB security report
> (report 3), also on a part whose secure boot is fused closed, where the
> ROM reports SDP_SECURITY_CLOSED.
> 
> Add sdp_is_closed(), a weak hook that says whether secure boot is
> enforced, false by default so that other platforms are unchanged, and
> implement it for i.MX:
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
