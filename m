Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E56606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X6sugDpK;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KK9OTGmj;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=umbN6228
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A8A980D1C;
	Fri, 30 Oct 2026 02:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL7cNWF8GSlx; Fri, 30 Oct 2026 02:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 781E180DFA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793326451;
	b=iFhHD3rvXdvyQqBaq8QuE5q0K/k7Ez1wJH0HfquUnavA7TFrVSaIYam0z5HWSrwcQQiv
	 Qh2NWYJZV+1yrmC3YiXtf1pRVLb1WJkyox/KOuWbFW/+wzJeaq9STiSgXkdDlzCDjLBdQ
	 PpqTO5RH6Z2GHyXRvNwVg+IY3IjUlTbWBFRstInMGh3dDgZ3obgp5+PIDHgz81oJ/rZfk
	 b3xv43d3sYu9Szi4dw7ZY6RobnUVu45WIS1bNmP0K3NFSduiAdLz5qGvklGBE50p4GuPz
	 AkyomY7DFyUvBY7KxwL3cN5xBCDxl/xqvh8+xZ0OVCEia39u4Dtv1p4Vw3MXFIeqAOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793326451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XYpkAC+2cD3KaZArgEBZwdRPIDN3cc0jVuO/v4n+OKo=;
	b=CxTqB18LLqvBdZEGtXu5QMLKB4050RQIKoBuNLXdIHZ+dY4AOunHL2jUVOc2TDB61Oie
	 J7HMY3vSpoid76QKGyTQMifJthFMNR7gAwwFEyGIs8fIVS4SYEHl5K8W38SrZwLilqYct
	 nJKg4JajZprphxmYelUGGOPp97ZjfGrG7CUyv3SwBN8ckYmZsrbviQLZLcF62HEFCN53M
	 hfkRFNCi/dquREsHpA4YPN3qG3gt62VFK/hUeZpU2ji8eNFO1QneI1irp2GNVrac5VA2D
	 c+kB/Kx0ZlvY3WQ5D7S3ELJZVEdn3qlPL1zEfyEQ0YjK+SDhsRNVitKwGfXpD7QcZIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KK9OTGmj;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=umbN6228;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793326451;
	bh=XYpkAC+2cD3KaZArgEBZwdRPIDN3cc0jVuO/v4n+OKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X6sugDpKvAZz8Ht7Gr8wpVYk1EgS3tb2Hu0e6DTLnBkuT5dMDqqbwqLtKa1yN7gAK
	 0v7cQnm36rcq4Dva4fUp28V4Cra6WjEUN+h6PWqplGix3ylxrAz5+4/n22+DKGj8AZ
	 vCf3agZRVF0U9Ut2ZRD3txcPA1Woc0oNCDgHLsU91wI1iu5tPDlFJUOM4YU3U5cnzr
	 2CpuTANeX/cn0q+WKDL+qrq7k9sZz5anY+eVl5s2QwxQLf2Tx+nYb7i/XotzTfB/Jx
	 5mUzB06OWOZCcR1yTzBhfazWQ0KdIvMZF82VRusSiZRUX98wcjLG8182JeJAFpX20x
	 jDWQtJh5m/1qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 781E180DFA;
	Fri, 30 Oct 2026 02:14:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 99793712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 7F4AE80DFA
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id lV-ZE9Zdc49I for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 02:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A7E680D1C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793326449;
 b=kZVo4aHqUG448IMCG8lbLZq2u1nFYE5GyIP+atScNi8LeNA2lJ3Vk4rNYzrAJ3NLRAWN
 FJ2ZO3USsgRQzZH7/7R+q8qiQaPP/9LF8rcFFAqMJOGCRjhbf1arnyFPrk0nTRzXyG7k3
 HtMbRzMNzFU39QQjZ6eyAIzpltkiukEmjkH1mUfpHyH9+WpTG8zZcKGfcTCxykc3t0q9R
 tSESUX8kpM3C5GwvpvA7NrvfpO3ZBmsLBCbJpmLQVWF93DTUjTx/bySV9/VBhkiulEkmM
 KKVaStYvi/Evk1DGOgwlpd31XktwaaQkKppzgBbc5R8zzzxLzkFNXlMNLB30Ln7mKMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793326449;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=XYpkAC+2cD3KaZArgEBZwdRPIDN3cc0jVuO/v4n+OKo=;
 b=jYf1HGe4BvYciPM9+YsMvQ8/PLcOubJy27arXgZM6U6z7jlmAGZQfslzLymXskO6tTQk
 Dcca+a9DJb5+bPO7EAt84lztBBiRGRyR0XMaqTuPfW4g5ngG959Dgp5XC7VWXZV8KH12F
 bN+xWh9ovfDA/BGFqlQfzIXhwSQdUBEhvMskTma7ixjx5KzyA6qHEsVLO+D2BZOCJu+zc
 xwCVqApcT6I3hQfUEnmukRC/+3C79BVU7cb0CjPkSeTHWQ9jMsUt5SRtivMMvvuQ843lE
 oKy75GTN5h6EPw3B0pFlccVQtQc8TCTMXg1/LwWZVVOPepXBL1cQtz3RHG0deA1d3qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=KK9OTGmj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=umbN6228; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=KK9OTGmj; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=umbN6228
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 4A7E680D1C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326447; bh=XYpkAC+2cD3KaZArgEBZwdR
 PIDN3cc0jVuO/v4n+OKo=; b=KK9OTGmjXdGZmzzXsT8rJNLOtHVZ90KrFPecL/PPSZnUZpvIlL
 mCOVkPmJLcZO3AlpyVAd0SCqhvJ3lVMmheSvx+vhwLYCGqHpKPHGCq9WYmVxVOXs7ieU67Er+4N
 Eux06Uaekcixp1ebD7swzQpw4IjPINr8NdOaCzeozRU02RkEzZ0aOuoCa/APRCQQKqrHXZLXuG3
 VtqBInll04TeowT9J5pZ9buqASYPU9TRbuSLKPv2DpFHhNn+oe93tcadFiq5ra/kxwyTIzfrYTd
 U4oFb9OP41HjKjLafW73yhvh96L8IH2TMJhDKd27ySnLuM3Xihe09yXWf+CVGEGwrdQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1793326447; bh=XYpkAC+2cD3KaZArgEBZwdR
 PIDN3cc0jVuO/v4n+OKo=; b=umbN6228JjZTJ/GOmjGydMQPY4NrLj4NAp3P1L+ezn4ZlUIgp0
 bt3D9HnftWFZiLu6kj2x3jqwZ1GlM4hq1xDg==;
From: Bradley Morgan <brads@mainlining.org>
To: u-boot@lists.u-boot-project.org,
	Bradley Morgan <brads@mainlining.org>
Cc: trini@konsulko.com
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
Date: Fri, 30 Oct 2026 02:14:08 +0000
Message-ID: <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030020832.26572-1-brads@mainlining.org>
References: <20261030020832.26572-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
> There is almost nothing in doc/arch/ for powerpc, so this adds a folder
> like the x86 one, with four pages:
> 
> - an overview: what the port is, the cpu families, the boards, how to
>   build it, the config options people ask about
> 
> - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>   CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
> 
> [...]

Applied to next at u-boot-ppc, Thanks!

[1/4] doc: arch/powerpc: add an overview
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
[2/4] doc: arch/powerpc: document the mpc85xx boot images
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
[3/4] doc: arch/powerpc: add a PBL guide
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
[4/4] doc: arch/powerpc: add a booting and porting guide
      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
--- Thanks!
