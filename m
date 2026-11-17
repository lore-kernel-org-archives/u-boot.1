Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C628606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y4STv5w2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T12PXwOe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5448B8120E;
	Tue, 17 Nov 2026 15:04:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQEHAhzsa60y; Tue, 17 Nov 2026 15:04:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DFB581210
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927875;
	b=NEXek0P7WslgqJygKgtrphM3qL/9bBZ5EnyJ7itMCtTEuZ80wnSQs76M3xT1oPInW1YH
	 fO4xMr1OFqEZSPV9cfupGhWGbzhPvxjaZzhxx/2acFl7ihQgE9A7Wb+jcaArMr/c/UgfQ
	 6sEjtXlWmJ/mGJgWQoRUhjfPwMwUbnwYYxTFDIM/VnCAFmGGsd89qhKVj0uaVyuTFtGcL
	 9Np1gRAEBIQpvHNExW7uEgFjDOnGq8IJc/qI6vPcKHj+f11HggULdyMT+R130Lkjt9ZW4
	 zOhUkj1JGBHAAA0pd6JEUhwVzh0G0c4ErnhdYZMJQqZUA9iaGx3cm9lLTLlmeKoCRVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G3Gi36CP60f/+YgXQefsv/tAFp9Ha9stpYGwuvsj6RI=;
	b=JuXyVtiAf7z4mT7glV7Im+Atn1xuQz4iIWJE5fZG3Y2KMJi5E/gMDu9AdU1yj0Y28Fw5
	 Kyf5CT8gaG5oHcZXDLFS2PzpAOH49oOS8NFWg8mJCmDbZF2tGw2hpZBmV8phCxRo1fvKy
	 puSphKL9p++45pEnAGLTOgp7oVwyRWC3mnNaglJgiPcSrcYO4W0OBP4sa8QWgvmkMX38g
	 PbErqfVMoW/lOVPmB2Jyl/cwJQGi2e/59X8PKToNKHIl+PxGnQYooiheM3U/ZZ8v9NKUb
	 fOm2H8ipKspFtLGM0bKmK+5VFX2ioQ1DvzhgJISEVS7/hoEPuvcGt8sdJLIehVt1J0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T12PXwOe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927875;
	bh=G3Gi36CP60f/+YgXQefsv/tAFp9Ha9stpYGwuvsj6RI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4STv5w2N0w7oWkaxDyUh0YPENc7UwQulyHkqoC4T44+vqstSgwC0xNRtBXmVi4It
	 j7xlOwQi6Oo3Gt1TEaYh6f38LYupqJLE/sHGLgNC3gRP7bhqL7/XRPD/5BS0glA7TC
	 Y6fs2N2U5Y1xNEXS4Mh3UNariv6jxp/uETHlkBXIJXbpGqFCiN7SYK9xZdzCfUFxe/
	 2QV4+kE3BOTVvI7OdeMPDQq/7ERbyaFkqnv+/AmpsazAaK+ISSo/0+NPk873LWiSYR
	 K0tc5rIqYrXKvpNkzLAh+w0KYsiml9DLLMhqOnlJ051283dwKrZqbG8wC+/jjIRZMi
	 /7+p7dq1aXzsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DFB581210;
	Tue, 17 Nov 2026 15:04:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91BD0D5B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70138811FB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ISZzK8sj_Rw for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 694E8811EA
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=T12PXwOe
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 694E8811EA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7B47635B2;
 Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379041F000CA;
 Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927862;
 bh=G3Gi36CP60f/+YgXQefsv/tAFp9Ha9stpYGwuvsj6RI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=T12PXwOegIHY/B9RAn6uwhy4POKGdu5lSd3nQfu89VpUHd8vTwqabWARY39mELuhP
 7b17j/h6zqLTk6mdz2IaMGHoSaEPSUdoKoUignsuFYYWhUat7zOb5+sGfVlO6tuUxw
 XQ8QlgDkfpC6k0QGE2IJGnC1p78vBucNjd5stU9sBUZPARVIgKabtNfHiPsE1+M1RD
 EBRy+EhDQuOXJoFA17BiX0e3OFNpRIc9VBvKdYlzXnaKZ7YaFz9bAoNSekmH5haXQJ
 hOq58rVVJRJDDVCcNtdxKIWwHlQ2yVM6OWLp328ZYjLGElNy2A2SVh/0g9xsZ+noUp
 3O7GZs2AfySMg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/6] usb: gadget: f_sdp: refuse unauthenticated loads
 on a closed part
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
In-Reply-To: <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3369ea11-628e-4e70-82b1-9a42afd54598@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784367.252888.17611718272373396749.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=587;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=XeWzRHIFK9NjS3OUlZN3OmGpO9ugM68o607RQTxelPY=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/GzoZP2ujzpWmMmCYYo3i/AKkGPZYrmKWvjYJ
 /pKJgT55NqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs6AAKCRAZDR20Zk4Z
 NU6VB/0ZDR1Sd5XZ9DCdaMY+BH0w4O1Zm1WQ2gGAOn81gIEmI93lTzN8x9bm2BnZGgUJCndLKTG
 IHgWkhxSG4UtoMpHId0iZVys0OdVbRMm09XbNMOM8cnNXBATCg/2oFYXoGpaG8gblY8vVs3QUd1
 foXIWgX0wjA+JgbYP7erppB4zyYeQ7OtUV9FQPKA6L0NkBJchoBmemcbocUSL3U9A0KcXxGgv/1
 eUIVKttereK0KHy1tYs+AH+ur31XPLStAgcM+U0yUDmL1ENTBmjZpQy5TwJIeOidK7YBDeJ79iV
 rndWmVBoJjGe0HQlnzwdZknGxjJ8zCKUrJ6JKTgo5ZZZeZY2
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

On Wed, 04 Nov 2026 07:18:16 +0000, Ana Bobillo <anabobillo3@gmail.com> wrote:
> On a part with secure boot fused closed, the i.MX boot ROM's serial
> download mode only runs an image it has authenticated, and NXP treats a
> ROM that reads out memory there as a vulnerability (CVE-2022-45163).
> The SDP gadget in SPL takes the ROM's place in that chain but does none
> of this, so a host on the USB port of a closed part can run any code it
> sends:
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
