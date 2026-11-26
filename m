Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F565606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qY+paIzH;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flQTyzan
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD98A608EF;
	Thu, 26 Nov 2026 10:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cIk-GTeOAJ-m; Thu, 26 Nov 2026 10:57:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C6B2608E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690654;
	b=WFghUFsJ/yJ+2frp2+f09KYnblEvXpDENH4zEEKVnmHlZRHwijN3PUe9pmQnvD2gmWkH
	 bD1G1HmoMpfT115PFt5VPcurN/xmiy+t64713zS79BnRq/9YOgh+hAa+njvGcxWfgZPPy
	 DGJLWPnsIAx39jkgh98vr6iAAPVZjTcC5yms+2286VSCHLT6C5rDtkmEMZD/2BcPh7nc3
	 +qGqdfAeTvbkU/g2YDVFMEsjS7Yww4PQp15RTVSAAXFqrTMK9VDhJ9Ls80ardr/Oc4ku6
	 /mK28Y4mjbVmvhOiXp2el+gdAodiuZalqIHvxujBo9kgVPhjdkIol6H+29Izfmj0f4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZkwM5h90GA3BialWi5BEfBpV2yvJqh/vL3zM1HmqtbU=;
	b=Zm91eXam5JAwJtFXGZc5Wli9SIf+UoO7niiQ9Ss5HRov6IhwiNqQA2VmmpIpDSb0LxMK
	 a/FxPxuTnTTnASgErUO20OyBdDEAaBWzJomn86Hm4W+P5cq2M2fDZ9WgN3hf6So8O/u4F
	 XKuNZ0JzXKj6g2OEqBRVUexQ/XW/YChKY6taImBvcQ27JuCX5J3OLQVy49ds5RRPJIbjr
	 dUQJgnA2I+lq7vgxT3LXfhnhur9DBw7+T6d8EpO985SAlT9vYE2jauARR1eMI66VZGvpU
	 s5Kr5rPzU8v8FeLcdAuug7rIFfQO6gZlc37g2tnuwq5y9T6rqm9AquEzb1Cw8DkfCPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690654;
	bh=ZkwM5h90GA3BialWi5BEfBpV2yvJqh/vL3zM1HmqtbU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qY+paIzHbRmt7XGJNWnqbUWNmadYektQ3GbN0HioJ+zR2yKJr2WFqf3itxMYZghVM
	 Q07I3nM8AF53C4TdYBc+/tluYIg6WbsU8g1J/tQEzL9l4amy8MVmDxSG6K5MgRVGol
	 DNn4amt3CbHTfYhc6q27t/BY5dmksqWd5NAuIP4mdAXPWvAd/0yGdQu7E5HrS1p2z7
	 xC+QWbP2VamwIP6UsezLNFWtDC2Awdsu04c/e6wqIsTJWkdwVF8Ah6NZUR8v3ze2xF
	 y0Zbz99XHqspLEsgRjcWMKo9o65wxWpUYkb50gisW34ImxWM2/C5gDu9U6h/I40+8y
	 j0SW4mUU3W+Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C6B2608E4;
	Thu, 26 Nov 2026 10:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 621A710B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 488F840249
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WVdM3CZ_ex0 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:57:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E4D5401CD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=flQTyzan
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E4D5401CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:57:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49A6A60DE7;
 Thu, 26 Nov 2026 10:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE01F000C0;
 Thu, 26 Nov 2026 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795690649;
 bh=ZkwM5h90GA3BialWi5BEfBpV2yvJqh/vL3zM1HmqtbU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=flQTyzancX0XIEKX4lh0XbxhuAuFRIzeY1vXA6Suj5SYaopqm0lu9rJ39qF72IVX0
 02njXok4oUurWP/Gbe7ntaY+LLUYlHs6Shjxqsjpk/yCzY/8zR+vh6y40AjQF1casE
 hOBKIKrhPe4BKl0jcJPCIoek7DKUT4bfg+pnD3VlBf4bXJZl06kjCHGozg7X4M0QGD
 Ql2o6QhFKVB6ViE6hMFWKz+OduZJC1DZNGDgYdews9Q/g1pvCwJSimaoPQG3Up8ABL
 0LOK/4L3zVOUMqQYiCh1nl8shU+hJi9XLYd4iGm4TjyP5qcQrcBGZy3oB04F/mH8HG
 gvfbnoLebqHJQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] lib: sparse: fix raw chunk bounce buffer size with
 large blocks
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261117-sparse-bounce-buffer-size-v1-1-bb0c4f7eb99f@baylibre.com>
References: <20261117-sparse-bounce-buffer-size-v1-1-bb0c4f7eb99f@baylibre.com>
Date: Thu, 26 Nov 2026 11:57:24 +0100
Message-Id: <179569064498.2141121.9269220371335043325.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=xYqvkKCYHrRqKEhLyeKvmGKhDMUdUTUkQMKYLlG3570=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCBCWHIJzUZXCWT4QedWyyRom4xeOq4weDJSmx
 tyFT6yFTZaJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgQlgAKCRAZDR20Zk4Z
 NcmFB/9VhfgsMk/U7Q9Y8HdMOa02n/n3drdbN1g6E4hrlKSfSq2etEfPpAaw+ZdC3RQtUls8cno
 iXvTDY5jrgOdasxGcTs5t6WlOeLC/duH1uTPliszTg9jJbNN9QJ3FJp5BrvAhOoE2P5tRwizDl+
 tRCSd4w+LPi6LbUQUXb9la/WoOEpw2hZsfwBQJn87yLmCHSMgJBIqEQ9cDjnoQilGuzeJ/cSIso
 tWKiDqfwBAdgctox2qn7t8gxB5ROnD5nCfxfSjhQNfPXCyN37382hOg0iAop9fwisEMIC9HP8cr
 NDiUcwHuDFtPKHliHdWxS20Gq34P7ArEo9AJRAcrikL9V6Ei
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

Hi David,

Thank you for the patch.

> Limit the bounce buffer for raw chunks to 8 MiB instead of
> FASTBOOT_MAX_BLK_WRITE blocks. That is the same with 512-byte blocks,
> but 64 MiB with the 4 KiB blocks of UFS, which is too much to allocate
> with a small heap.

Have you tried to increase CONFIG_SYS_MALLOC_LEN ? Or is that not
possible because the system that you are testing does not have that much
ram?

> 
> Fixes: b1aade87ca1f ("lib: sparse: allocate FASTBOOT_MAX_BLK_WRITE instead of small number")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

b1aade87ca1f purposely did this change to improve flashing performance.
I'm a bit reluctant to pick this up without this being tested (see if it
causes flash time regressions or not).

Did you benchmark anything with this change?
Or can you justify that this should not impact the performance on eMMC?

Thanks,
Mattijs

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
