Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7CACA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24E6560B57;
	Wed, 30 Sep 2026 17:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gia9VIjnrxM; Wed, 30 Sep 2026 17:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2B28A6070E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790787755;
	b=hI8iBhIsraylxCi4JLJXpuaZoVTrFNnpUSn7iMlaozO3r1OAhwgVnc3qQCGyLzOzbujd
	 XYdW+QoaMKqWM1ILujtUAPhEuuLKP2aChb/A57rL1emu2Fi4uKrLFZARgpaeRYqpvihci
	 aTKvZIvREV4ulsz/PWqHtAh0bjXf5HOaBMGlT9WEBHfknNNSPdCxOdDdIRJqhSO3Icw6Q
	 unYHXL1vHOYblUNAxJHEjVUF8XwG6lGTBlwtoFh0fEnqJgfXx9B/8zhkNOe1W0vwRX3Ox
	 77DpZI++jzQlKIYNNV+TtBRwg1rblKJmJhYUZuiyGcT1yYwdl1fFZvtbXHjj8EBacDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790787755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4GQCalet3sDJrou+S5TA9FqKk+2l5/4HIEhu3UqGGEQ=;
	b=Rk8b/aeDJJk1IKWo47q08+B5k9Itob8whI/O3f3+QA22RoFcSZvyI62a2+WvlWATMnST
	 YDtSXiMTdLuwetIOIzRpwAdaLl7FmiebgQxfS89nhAo9H3/LCENH3UQZM1L53PZpghR3r
	 V81hdykLwcoKJA+zNhJH3VPVmaKYGBxWOy/KDK4/sRJgTbBxFxeM1QfO6Og3IKBbLEiJF
	 1M1ed+nD7FnTaRktrJRgIO6+OKdcvBkSGffOM6GQDBvGd5q0RTocMngoNyBrC61PezNmB
	 JRlAo8D6N27WdTF5MWtGPqYyOkQMKfM/V07fkD0XrB/RN615MwNE6+uYI8m1OsrFHyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790787755;
	bh=4GQCalet3sDJrou+S5TA9FqKk+2l5/4HIEhu3UqGGEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P3T5rFAlb+pxjZJfx3A9BDCqIdvuRRmstI/Z0eMMgdthtnBZJAyQmz7kQqEsXVwaP
	 fkvcGbSXzrd7xxgd1GXCdxm3ZRK+bRr5StrTF1XdrDI5KDk8EDwbxbZx5pvyzXyTpM
	 bUKs9A2+0djhf4eehvJeMUq/ag8h2IsziK0hZGbJVtCxoEi+D6YQpGdv+HqzTnBP7Z
	 FhkBJXzjRr8BJ9JTyxDizFc5CVbs3y/VC79h2508yPXsie605xae/QU2mkO8KR7nNr
	 3pyhrdk9YGWH7e5nbBKzqn09jv0ZYzcdLrNKsiCW4WOC9niosyEFplVWH90F/lTL7d
	 +2mS6haoAz2HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B28A6070E;
	Wed, 30 Sep 2026 17:02:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A39324E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BB08806FF
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATFnhm8OCifc for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:02:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0C33D806F2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790787753;
 b=hoX4H2vNWUmFnvk3Jm8DgzQLWwVUUSP4haNgApyUldrfyxna4J7WT+TFVwDDk9J154Mp
 CUFiCcANtgRl2FOR8v/riDlpmeiLMwhBijNoT/7Lxl1rCk0rVnMiDjepva7GUdtoN9IKV
 ox/VUyRfQT9025ofeuMaRlmy5OPmVuYQi/0hhq0gz6BPYLOUe4tq+EaVkww3IoLhaCfuw
 G4E09+uO4yvYfNohWLjka0IAk4t+1GtKr7R4BqMUcSQ8PFoNNIXwcgFZQpvckg6sNenIt
 al64xHUD1s+lCXBAZ0nQ+lXViawdRpk5cmYJEm8faDvf19an9w7tsp51ckmVsbaL2GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790787753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=4GQCalet3sDJrou+S5TA9FqKk+2l5/4HIEhu3UqGGEQ=;
 b=V9H/37dRpW4OWpq3ND8jG+0y7EWsYPgTElUYncU6bGuM0LGpSkk1rYFosLSAKLhimsVx
 uJNI/WHxVTDb7p+E9DCVD3i2gI5HzTPxpqmtI7l8I9r7XFiXFIba4i+vZ/NotiQroRbKN
 2s1L/Rhnqynu44H6TRb6qjGhUe1CdlIoCmCOzw3dC625X6kdF4lScfDOCd19MH5R2a/Ze
 aWwbX0w5Aqzu5RFtwEOa20CA8dU42CYseu/Sx4eabc0BEVwECDtYIMx8iTv/qRIPCtCHW
 549gKq0w+YjWbxpqeici/xhIL9iP6VS1d9JgDRkQicIyUJ0boF6QZVrX2jiOK/kCGFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="L/wd7ZJJ"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::d;
 helo=mail-wr2-x0d.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L/wd7ZJJ
Received: from mail-wr2-x0d.google.com (mail-wr2-x0d.google.com
 [IPv6:2a00:1450:4864:30::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C33D806F2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:02:31 +0000 (UTC)
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-48b024549a2so668535f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790787749; x=1791392549;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4GQCalet3sDJrou+S5TA9FqKk+2l5/4HIEhu3UqGGEQ=;
 b=L/wd7ZJJ9T9OtduBJDyIEld7AkzNlT0+RAzsFexlcRpzq7KkEIrnxNGDCo9uia2vM8
 CnFc89SuvSupKBjOKRZbUEaX+CFU9PrIwkX3c30Vf785C1B0e0Bgv/F32FdPVkfJoYF+
 1DaC6lwm8DMUBxMxUVsa8/joJtfZGZGuCbZNJxBICFByvv+5mN2tHyaNpPt4ob3CSAlA
 MHMlX4oxCHGd5mU9omAet3I0fu8IV/cCNWK8VMTi5AFZg4qQ4Jtz6BNE/U9psa/VszNM
 GJDWSAIQarCDDFo7S479m+iIraWzsUSgGPDtar7YGSU9XmmlFMn0JwiGZzsam+Q/vm45
 f2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787749; x=1791392549;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4GQCalet3sDJrou+S5TA9FqKk+2l5/4HIEhu3UqGGEQ=;
 b=ovzWg2cC5eDEjlU34yZypnmXIyp6iQW4oSgVpPrfWy0nOdftaxNFTSWycXGb/Y1CvZ
 hY4pq6dHaJZjFwm0zUa/HNMmD7YVkJcpVY3Mw3MaMjO2H+DGy0w1mBbVM4j06VIXcK1G
 ZzI9u8U2YztVIByBiKD9rObHvdZvSiCpfqD1/juC4Sw6vKtu+gIucTB4zRwN2DnsmCLC
 5Mp1POguTbdvbfKx8wlKSK7wXYQ+0OpSjHb8sKgNXkWE3Dt9q35s9GVbCaRly94U58am
 3bNnB1gLbisF+DvAFWnFx21M2s4oW514KD2iRcSB2blBPU1hB1WOHovqP1UuqW0ECTxF
 ehhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVFlRCnw77NW20WNGQZRhkx2jRe8t/WoBcLcvkIeZC/r0sWZ7XY6NDh3rKftu0ml+RNZ4VhlQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k9daLMFgX5nZU16RWUPZaHHBPFGsK4dPQ9LL0ehJR2nznCKeko
 bFsnDHAk8s8vya6uFIra6UhpMFrAMsEQiWbbpxl22aLp4S1OTFfAsgz72rUgJuAhL+4=
X-Gm-Gg: AYBFou26fqSG41Brvj4/kCFO4IMIG+kHkmgarJob8Vo/k18hbK23n0KdUG+4fYbKNDX
 udNODGZ/s5TttUJq4aa+Pb+n8OBMOACNtazqwl8fbBM0+URBSobqxQE+jgB5Zk5Edbib8ctQzw7
 moMYMHvaFwhi5GDnkC9a4G4UBKvfKogf+pgCn6vLK3Gxyay7Geq+TkvoR3dPO9YPsU2rluXF/bv
 HYvb/zPuiOQO0s3GM1eZXMOmImKlOjs6jvCZq/qNaOx37tVFvWDAzhGVXSLClpt/6hwavaS43Qf
 K9nBthXfAGjHfjeuLYVfnAsbXsRA0+yau2gJJv0ADLlgWnR5QMcFvEOklzzyp3SKEQmmiaQkqjV
 S3C/mnwCwuu4UF0ApYEmyUyC0Bk0EkTkH0JiwGGBxKm6G5IHvaffNIZXM6wYWHcsqDNB1FrwHAq
 0kCphajKXVUrQlDlhALi17W1/yAFlO8oxN/OcD2w1grqEmMeZbqej5z27mtM8xsUJugQQopfKYp
 DzmANiWKMy0a6qNRT2VIsqeaAbC1xXNk+Z5oFrB04NST57EZHT+PQC0W8X/0VPPnBl3eapmIncr
 d4U=
X-Received: by 2002:a05:600d:4446:20b0:49c:fc6e:8cb1 with SMTP id
 5b1f17b1804b1-4a01b121075mr28260005e9.21.1790787749365; 
 Wed, 30 Sep 2026 10:02:29 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (mob-83-225-28-196.net.vodafone.it. [83.225.28.196])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9b1sm426230f8f.4.2026.09.30.10.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:02:28 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:02:25 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
Subject: Re: [PATCH v3 0/4] Add Genio 510 and 700 BootROM download agents
Message-ID: <ar1AIUxkbhHtYBqj@macbook.homenet.telecomitalia.it>
References: <20260930-ccaione-upstream-mt8390-da-v3-0-ae6091c7eda0@baylibre.com>
 <267d5e88-808b-4b6c-b5d7-40097be1c170@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267d5e88-808b-4b6c-b5d7-40097be1c170@cherry.de>
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

On Wed, Sep 30, 2026 at 16:47:33 +0100, Quentin Schulz wrote:
> Hi Carlo,

Hi Quentin,
 
> Had a glance at this (am not really interested in Mediatek :) ), and the
> single question I would have is:
> 
> why have SPL_ in the middle of the Kconfig symbol?
> 
> Can't you just have
> 
> SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT for SPL
> MTK_BROM_DOWNLOAD_AGENT_FASTBOOT for proper
> 
> so you can use CONFIG_IS_ENABLED(MTK_BROM_DOWNLOAD_AGENT_FASTBOOT)? You can
> always use IS_ENABLED(CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) if you
> want to check the symbol for a specific stage.

Well, not a bad idea at all :) I need to check there are no weird edge
cases but in theory it is a nice cleanup. Thanks for the suggestion (I
will still wait a bit for more reviews before pushing a new revision).

cheers and thanks,

--
Carlo Caione
