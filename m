Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211D606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LsB9onm4;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=icNHOSBL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D61C60607;
	Mon, 23 Nov 2026 11:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdUYC_HwiVmB; Mon, 23 Nov 2026 11:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8904A6073B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795431782;
	b=qjeOVkOeFFLIQ02nAJjGROSQukJmtXJOLemCQZ0HYLBk53aQ8YRel65vs8WMAVc4O8UR
	 Byl4hNjRvrVZOUfIeJeOqwhYJySQhTo/2PZa8vEFgQ/UVeHnoST+s9cd5y1ohHPDWZN6j
	 GkLc5UVrVdqyAQF3Y4NET05y0VUgyf1nPFgxTwWfqrnY/inR/IytaTOXOvKs/pF3wPsUo
	 GNcp7mWwskdLb3w3utW1I6sGsX8MoXE4g6OOjRntln9RhytWB6Wnz5TqHH3pQpM/peZwy
	 ou3nypspv3XQ5HFrAGbiOFqPSUGbimacITC5VJgH9wxYDNQ8Z18ZqFjSDN98L/l/KOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795431782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mVQlWcSM8El5MhmfwehX3Ha7ZIyVwP+XZAinWXHbWCI=;
	b=fVWYEo9lclqi+pn1nMSa78hpDw/xFJxvdZn9U5zKljZxofYykDj0uXSyUTR7YapctFtn
	 VMgwAMK/g3tu/0xyveatpR4zxNTq77AUBfH5vePtEjlvUqkP+jfT9NzeZRG/59keEuTCg
	 GfALlK+Z/m8jkZ7Qz5VMW5qDPNhQPVb3GnhnQFNofd3a/aaB2Jx2BXtTtazEyRm+KFYfi
	 efMcaXNwvrYWeScZV5FayACMxufYRdJ3n6lzAQmQmbznpMJEDljjDlobAhCvaoqeY81uF
	 lLNy4IU6YJycsd1z357kQXupjFIvSVyckgIhc6lPzSXGIT0pcW/U/tDT0ybHrJFGjWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795431782;
	bh=mVQlWcSM8El5MhmfwehX3Ha7ZIyVwP+XZAinWXHbWCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LsB9onm4llpwhUGvv4oHvrIQ9M/TAgWU5pxj+93vEH+B8D01c1ZlxjUXmFJ01Bx3f
	 itRMy6QIufdTzwgqYlSSJItpaQsDyOeE4O/4YJXh9gfySBlhyY4T2+FChfniF8xSye
	 5uUEwlBOHBEvj4Li+0tj1A/B5platkTC0k6I7fe74L/goXT5Pm8RM5XbC9DIB/c0FJ
	 q6rp/mx/Z2/x99+gu5soFK5WzeR4/JINXJdK8euZAsgUDn2kkXePqUT0dkC2LgmSJi
	 1WgkfTL2s5yMawtCp9D3kGC/qzrh3akxeq2wNKE30ivZD4/dpz/ERR+stnzHfdCOWJ
	 jBSDvjWIgr05g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8904A6073B;
	Mon, 23 Nov 2026 11:03:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 776FB371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D13E80DEB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u21bh-6P29tK for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5519080766
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=icNHOSBL
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5519080766
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:02:58 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so3010412f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795431776; x=1796036576;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mVQlWcSM8El5MhmfwehX3Ha7ZIyVwP+XZAinWXHbWCI=;
 b=icNHOSBL3jPNEFNfGyRwI6xXL6irOr30mnzoGa2iG4SWxORqz1DQnlmE2fnZ1037CO
 8gRT0UQbBZBECDVFFMf8dvHlsAL2EAxDnExnHlkUH0mIXtU3cUVkizy/t4vp2FTMFPvA
 EBT/SZuBAJ6caBl6L6os2ZpDOZ8UV0hNgzNMe0aZV65jqU+smQd/cIAOYu5gViF3oIVo
 EflVNU/H8vrzEodemA4S69qH/zI3n3FZk4khYADT+2spkpGyzLLD5cHpDBksYU5BtFip
 qphzZ9PjiQgB3qwsJsVD7J98zq+QbTHLx7S9JSFYGHUo200tW6+pevCoQj7kGc1UYFsv
 ai4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795431776; x=1796036576;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mVQlWcSM8El5MhmfwehX3Ha7ZIyVwP+XZAinWXHbWCI=;
 b=Qu4IZkY0vLMcpE4vkGt13LvDwlp7cC1WoDnci+PZJ+LnOIh1/vABWd2OcXs67NQCoJ
 tv0/px2vebtwjYVywJXMJkdnOzG9gEIszGaui98+WEw46IWRB3jVFLJu4sQinApSCbt+
 /iEBNLMVtCFzkmSk+rNjZcULKgpb60NVz78JVeuaU8I5gMTwBgppY8v46o7cMClYPP2U
 BMRtKuR1DstBL44v2yCTyLsqmpT7Mh8zvbnqow4lagr13kEGT3k/F2dK3d8E07XCPCh9
 nAI0T42tx8bN1KjtJfde6NmBruv8kLOaVUsZAjgTQIDVQ02fO1a8BdfdLjwgtHAtyVVF
 y8Lg==
X-Forwarded-Encrypted: i=1;
 AL+hErHHbzWP0BEPNRdCCrv9pVe5REQKnFg18eS2dPjcpEQMrVoD6UD+r6Tfyg/8QGI1PhxKTKYY8/4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Ho2YLNft3gkFEZbZWg6gqRLnjF4DRXyXysEPt1qYomBeKECnx
 kBSob4WBr6EXS/dkFQI/7kYAt6jY/0pDrIqJDNfUND4m459rJm7qG8pRrcA+F2Fx5RE=
X-Gm-Gg: AZFdTZdfZ/rIgnSSoFPjbJXFes/Fom7n0KwoAavGmvLlpt/QJng51a18J/AmvA8d05B
 /5zd5krMVFs6UIUXFpMs4WTnG+VwR7qLYgwVwA1K9wz8fPJ9QoKA+BIxboWdXzAsVESjs94ISN5
 KEPRphpe6y+abp4e5/vsnDDYOOVNFhE/icYSoY9ApHOh0FsXmeorA7XplLbMIJAf7c0bVQ67Gjb
 mYdlv6o/h6h6507ZT0McTzAkit7Sh3Hdmxbz576C4Oi5Pta6zmZVZeiM+8zfB+0xoLXwNZ8h8B5
 VrBJHitHrEPRohjd4UrS3/yUKKoky5+6ebsFEqkntzz1dNn7rsGflLEXlwjJEWl2ZLSKfrKkc2X
 WTxlRailovuK52EnGXSkCNKv6W8xoKA236Ab17yvvOSTecva0kJwnVJ81OfplTZppxhp6Dg//xK
 YLmm7OeFWjx9Ie6rYv0t3bM8ouCEgmUAJf4KcmxPWRz5cBqviDK92Fp+jk7Rxcfmp9AUgKrCe4t
 9JsyBfGnugnyF9xv6LMtKn1Ofu4XPWfbCi6lTX0iOgEUTly9vZtxGVSvrlnTFTSvilHY07smddK
 TC4igTDhHx2PYwJwabZYfDx9gHGQIqlRG7XQW66pSRbDODHXKGR61lw6/CiYDZIGYk5KC6TbdlL
 2M7Ae8iEXaT9N
X-Received: by 2002:a05:6000:46c7:b0:4aa:31cf:9307 with SMTP id
 ffacd0b85a97d-4abb2168f5emr12931555f8f.14.1795431776366; 
 Mon, 23 Nov 2026 03:02:56 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm22232480f8f.59.2026.11.23.03.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:02:55 -0800 (PST)
Date: Mon, 23 Nov 2026 12:02:54 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v3 0/2] arm: mediatek: run SPL and pre-relocation U-Boot
 with caches
Message-ID: <awQdJ8kezWwnoV2y@macbook>
References: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 17:29:17 +0100, Steffen Dirkwinkel wrote:
> Running u-boot without caches is slow, especially if using rsa
> signatures. This series turns the caches in u-boot spl and proper on
> early.

Just tested on the G700 I have and it works as expected.

Tested-by: Carlo Caione <ccaione@baylibre.com>

--
Carlo Caione
