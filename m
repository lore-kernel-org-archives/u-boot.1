Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BC5CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 17:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83F8A6074C;
	Mon,  5 Oct 2026 17:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3y_pfoSI_d-z; Mon,  5 Oct 2026 17:55:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D9B0960730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791222920;
	b=bdt3stoJgqXuc5T/NuHWkrKFVTBoUv+kMnUDmk8WLVRcU5o/m/TANr8tztZ7TFZKtTeZ
	 nMr7LMjp+ZNlHqGvawHeIce7eXerPZaQkDTSeLBnBYmunGbFw4SL2DLfEPD2wYK/AnHX1
	 mCX1+iQHeHS2RPTbhbZdLcUbeZKb/UIkn6+wGa0ekUCC4xB5UOMCY5QIFyVerlURjt7mU
	 uK63HlnJkmprYAFZfkAB13OmP58w8rybqO6e/1kbH5519R54gVkv9a+7JiVDac3Rqu39q
	 L0qPZguN6LaJYW6zvKjt9GxZBy8CRwj9aBbdCrsNNuh+pK/68odOZjMF5q7gdZeyn6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791222920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yLwdveoZDYv4NHRl4/unyJ37YUmx01u7qEKM4MCw81w=;
	b=KSqKsDOCxHfg+YXJw38uVgjfgYCLpEX9DqFgBtLKquac66r5v8/E9s1dfFA9Y2q0aQH0
	 62k5pLimuADRtF9fj0pwEoHT7ij5L+XS6So50mYj0P56NiHS00sVg35UFzpw0eHLsgiV2
	 snkqqycuBci0qMcrr0IRW6DTTDq0w7Lkjy5anVktOXQgoT3NQ+lBcqoltdxpVmdW5nB/q
	 BGTyjEOThVuA3mA6IDHyQgkr1v/a5fpzOKY5ss9Q1ALFaHvp1h8lD4ZI/opZhJqAlCF5e
	 H4j5DpVEK2sCcZl/szoUkuYwrcc48vYcqbDdxtbZfP4Ya6lZrzaCy6VHuVlMDoM0o1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791222920;
	bh=yLwdveoZDYv4NHRl4/unyJ37YUmx01u7qEKM4MCw81w=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eMDvg9W2s7NMu7GiqmWnSmFGRY18iOT1Bzl5BKSuVkdd7gptfXXxJ1Q1seaM0Gsci
	 uLxanbTsSGaOwaMZrpBZRtai2dWxx0qFrrygzVmowLU0QXfKuBeR9uTEYIzU6H4asF
	 iSYqzOgWTbXNcOdpKmlgU0bsEUE/qtqk6bT/RfASd8rD2bE9RtH6dykgyl0BJ1h223
	 +5+N61DZwSDvB4naI2VTn+3lGhHvLe/OZxZHimmuVSe5ggH5QcOJ6P0mCAscoOWch0
	 NP+Xbh6x3ELv82fC9O6VUaYax1A/Zf38kfyshRu7X8J8iVmq9n9sEobZ9ssuo7GkUd
	 pTXBxcwKqF2aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9B0960730;
	Mon,  5 Oct 2026 17:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F5832F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C907240670
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usc_JiWRkgkS for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 17:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B9DE440669
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791221745;
 b=jpKA7sodQifKA9gFx32OrS89dQF7gdF9oLYdUmz/XU2yyiKPJkHVic8HF38cFZwuEOSY
 t/T4D9ymoQJubY9wTJfvx0YN5YA0BpOtkICns3teOHkGwUeBdEzRKgqA04dqFC3DUT1kI
 VA10n462FrYy6j31QRBODh74MTdIdpgMWI11X74iD2wsp2oTVjVadtDcg8+fIaVmSNeUJ
 8sEg71PGzibZxkO9IyduKuxPE1xNZSnaHISgJW7V7Wq1FyBXsVmHNV1civQ9EN/gOkw6e
 fTp3QNnwO1VH4X3IROnOLxFYc6g3QnTbUfS2/RPrxxWjwnIla01jLHcknaV6QSV12ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791221745;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=yLwdveoZDYv4NHRl4/unyJ37YUmx01u7qEKM4MCw81w=;
 b=f656UhYLyTRRZD4agrBQJVBBPY4s7Gk6XnHFCSlgBQtjEYMm6BEy8xmjsY1zjP/XWyUU
 9NY+tpyy7SFY7ytO5qDsIFNhc5UB0ukuDkLEzzB5R4ZpNIsWOPM/xNvXzKTAmZSpsbc7B
 LTphqh0wSR0AEhLet66dugSeMFuGPYOftQTvEMt47+LIGphy3BqOEc/f4u27W+BYFGfLS
 /Vlh9kt5hcpKE2inmOw2d7qaXXrLscv8/xZxqlBF1tnTh80uaFZ12gTQct1Ar5SxvNBlf
 xdv02dams0Lf1txCnCMXE4ajMyAlogz7ZQqkicekzSwzkclP8IsF/GhPTE3Tifofj0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=sDx6apDt; 
 arc=none smtp.remote-ip=185.70.43.103
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.103;
 helo=mail-43103.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=sDx6apDt
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch
 [185.70.43.103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9DE440669
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791221742; x=1791480942;
 bh=yLwdveoZDYv4NHRl4/unyJ37YUmx01u7qEKM4MCw81w=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=sDx6apDtMgeZHNVg8y/ItFfn1OcsFgJVBIHMRZ42QMOzwga6UrWNLyLi/tltU7i7G
 zhNM5I+i1f4dTUAKTjYChY1foDANbzQXZnI5ugkM1dTcQL587mCU7MRHHDnsdoW6Xq
 uMSoEaF//IP2jRCEP+cyaRvTrGa76c2pC8Z5oVy7waPLjMT0Nh9wCmTZeUmVpmWlnw
 T1y1i3AON5a1iTDETw9TVEVu97iUV5jb/8szH3K+B49hgZeHWaf/pyVgXRpkviuM0J
 q7JSOTUZmTHfNWg46WOAS5Vmtc25y06GelYJcIQ/rgkXT1buWIkhmpJkucEgjths1S
 R3xdVdZ7dIIEw==
Date: Mon, 05 Oct 2026 17:35:35 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2] clk: spacemit: program the mux when setting a mix
 clock's rate
Message-ID: <20261005T133204-0400.clkmux-rename-reply.DaveWK225@protonmail.com>
In-Reply-To: <20261004021830-GKD68132@kernel.org>
References: <5aa2337bcb969568749c4728354164d5a6c88f27.1790975596.git.DaveWK225@protonmail.com>
 <25a05161c25d59a153acde52f798e5fcf570bd41.1790993264.git.DaveWK225@protonmail.com>
 <20261004021830-GKD68132@kernel.org>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 715f0c8dc315a53f0f994937a02c0b4774b0dab1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Yixun,

Thanks for the review. I've prepared v3 with
ccu_mux_current_parent_index() and ccu_mux_wanted_parent_index(),
updated every caller, and renamed the hardware-index local to index.

There are no functional changes from v2, and I've added your
Reviewed-by. Exact-base replay and the naming-only comparison pass.
Both board configurations build successfully.

During testing I found a separate overlapping DDR firmware copy in SPL;
I've sent that fix separately. With it included, the combined firmware
passed DDR initialization, FIT verification and automatic EFI/FreeBSD
boot on both the 2 GiB R2S and the 4 GiB RV2. These are combined-firmware
warm-boot results, not isolated tests of the clock patch. Cold boot of
the corrected firmware remains untested.

Thanks,
Dave

