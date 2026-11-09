Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03400606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kBwrIEyC;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ak0qRWXA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBAA040596;
	Mon,  9 Nov 2026 16:21:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzxHP4o1vv_G; Mon,  9 Nov 2026 16:21:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34F54405A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794241314;
	b=BFmhCbGT5sE9Ub0yERZVf14134lft8ORBAAEmNAy+eStlMsloO2d/uDRdOpOac9Enygj
	 eWQ9Wl/fKjNW0pe4j16fG0VbOC9TF0RyGai4gOiqHajMAdEWFoXg0ufEmoSgXrZGggPr5
	 mS9qYsmkjfk5DcA+HvwN9qozUi4/g+Fl2xloFwgP8M4VHoPn+nHIpPQHHi0GJ4epY0gmj
	 buhvxAdm/OpJKgc+9ZOzdyteAyzhfLuvDbU6TTKkO0NWBADSZQzGdvF4Ml6HIsC9MvC5C
	 NIdXZtZlv8aIm/kSuTFzidvFy3zVybFrtRJ9ASJM4z2e3cu8TJzlkU9BK0qqe47rMsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794241314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UAE4yIQ5ZHCbpecDdDCeoA/8KvWuoZb9WzPpLBcQu1w=;
	b=MOVLbWqTaa45B9gqCW9C7EwCRgb1TFnqmzqszOb2wqBPQ1Zh1Gb5n3qiTY3seUKU1B5f
	 1MCawI9iT4mUpJogJkNg3+HGmuhUgzHdrqwPjc5TuI3MMJd8zaQg5pOIgz1hdyd0dKOxG
	 ZCJs6cKFg+8FHGjepMQ5ckTXMRLEVRdJvx+Jt4VE0jPF6zolhH3tO7V9/uXdjnhwXs4GN
	 KD1WdQMXqMf+N/vCc2594v5OoGPeuj8XJUbqzcjPaJnWpUK2zGVzZq+qmrAMz/c75rhKM
	 GOivVFovrC8mSrnXKO0usuCBIymHQHDiYM+KRLQKScMZnXZnPnSeSmtFRFK8ofyG6mg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ak0qRWXA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794241314;
	bh=UAE4yIQ5ZHCbpecDdDCeoA/8KvWuoZb9WzPpLBcQu1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kBwrIEyC7iyLDWhsXFxsfGdxjE2D21k9A0UWy4Ti3TYyT92vuTacmiTubuEo3W7yN
	 sMZzjVK3pJbA11cncgfv0daFXEWB6RCPKnv1Ol+tHjuDl0i4IrOeSXQFUCOi0k3bmD
	 wDN7VByvk0GuX3xnkKfIPiebqf4b0kWgndWvGqDGf8097KCzrDPS9iXXvcMQEf+u0r
	 2zzrt5fzxDYu2gHHmTCw3sTQ7/V0GWASNzycm4O1Wz9Diu8H7PoVgufisaByoHhF1D
	 Y+503FoUxP6lnPFm7YdKQC1NxThgAdv8btCFOWMfc/n0Qc/FQZQU0sh/bhf/CN7O7t
	 MBJCxdb9EiRng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34F54405A1;
	Mon,  9 Nov 2026 16:21:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4A621E3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A669B405A1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSHHsqMOhYnd for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 16:21:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A5AE40596
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ak0qRWXA
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A5AE40596
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 16:21:49 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-704597ef1d8so343543eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 08:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794241309; x=1794846109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UAE4yIQ5ZHCbpecDdDCeoA/8KvWuoZb9WzPpLBcQu1w=;
 b=ak0qRWXA990/N6uimQtlBInHjeqqsPl7iyET+cr2tXgFmcgS9CHNu1jF3aF1Xw9yGR
 coH0FHNBeLSZFKylCktNPkn6e90xjSdtt8EkRXZDK2L62FOt6S0hhVHqpG7D9Exkjo79
 n3stzGnZU/bmm+s33sHun51CTHyhctVjN8X3tUY6Nc0PfX/b2MNRIVq/8p52CLvfINQf
 PidprPTLoeF1fiUr3Oz0JvVUvUmoCe6qnMAj+UQAu52GglmH7BHGSVbRmPkEusXcv106
 zdz3AQHU2nFgERQ4/5R/9l8yiU/5pFzdm4bbjTyZ0Vv4wD2RRzcAIwJIu5T0LYmEJ1Pi
 ZOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794241309; x=1794846109;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAE4yIQ5ZHCbpecDdDCeoA/8KvWuoZb9WzPpLBcQu1w=;
 b=ZBJwDdgnwn1gF6VPCViaClFuHKczE7je59SwxVj51UW6Mr3c4QBt8wm9JAYItjhfSy
 Vep0o7BAAMDxJy7aYWCXtPN6zbvzSPJRc7JETFqloH8yzbXWSGUyNdJcpIFsNqx5eei2
 xXIoi3Oh73cXwrebYr/kMpIIsha8cCxiMyAcL0o/aJYvWegpH+5K95olcXa68AQ/07wR
 xM6B2xCd9AV+myL2O3I4Hme1MIKxJb64EzduGUGL+tHdLAVYVQN0Cs/KdXh2Y9z/qf4X
 4JjSIi51Y1y6W3stj3+BjyDEOZVkJKeWntS1aou2ChJ7Y4ggeugBAEVgvSE+U1gSH1yl
 YD/A==
X-Forwarded-Encrypted: i=1;
 AL+hErFJ1TSpNHFkCxn5hUzQ6IuZMfRGtD25643nbYsYMETMHTIAXTOCjMAciH0y0Ww6Fbwr1MmXmJA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+tZytedclCIElHUq1bSMlhOoHN3ZBmr0t+f7dysJFJ7LsMBr+5
 Rmuhi8LK5X0zdAdt0Fw3Eb8NpZqRH088iRl4OJYSuO0v40IvrsD0czMwSacc1nOTL4U=
X-Gm-Gg: AYBFou1MdLDMqn9M8FpPMuKui05KDIPnn6QoC2ZfP4XTSJj/G7fPp3eU86DBQDimImT
 jXoRW4wHAMn3YMCihGY30F2L7SdC32YoG2ACUmw0gJhwFSqFBXyXeOt1R6iZ28edD1U3RPwWA22
 ggA/+ULzm7fW2k5cDJjErAMhWecK+nYfDN9Ei28+KG04vjT1Nqi3CzSm2vqF+sF2/PtoNUnIs3R
 7g/wfAXpWPQr73kIcgE3WoKtACtWdUh4pAIG7c9hmYF8D4Qj2/wbMyD/ENZmnJ7lYzWxBVAhVyi
 h9bRZwyKTG65AI4ki8bUi40UZRqz7aNqaGPFel5Orjoi/XqRgxMETU4kg0eNC92NQtdzyZhN2wD
 NgcGy3wlRHx6Dbj9qyNe7lYy1c9EtZ45NedqlTBHnbB/+yhUoZXsq6pUvLiZC8UrzHXL9p29Qeg
 sd1mOoqs6bpfjcVEyKId81PkBDbmfwEsOOnQYcYMkYhG7IezbdI80Kb18Vd9UkFZW69tsoKDRjg
 XycLpi565HnngrZWJ+s//YIP2T7GX07AGnLqUU8b0A5hTeBboWarab/yFJUsx4wG+9jexQPRmCl
 R7JQhizJAKahq22DVWG+DdfPz3DqKSjdjA==
X-Received: by 2002:a05:6820:221a:b0:6f6:96f1:1bb with SMTP id
 006d021491bc7-7170f290571mr2115078eaf.36.1794241308912; 
 Mon, 09 Nov 2026 08:21:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8fb94fsm3517051eaf.13.2026.11.09.08.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:21:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261012-clk-mediatek-apmixed-fdivs-offs-v2-1-683cbab13829@baylibre.com>
References: <20261012-clk-mediatek-apmixed-fdivs-offs-v2-1-683cbab13829@baylibre.com>
Subject: Re: [PATCH v2] clk: mediatek: drop unused fdivs_offs from apmixed
 trees
Message-Id: <179424129537.3924283.8189652320627504284.b4-ty@b4>
Date: Mon, 09 Nov 2026 10:21:35 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=342; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=yN9t17wMmRcKUFSsg/7pJ5zAS0r5VdydpqPMUKGhDVk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq8fMS00t4hDi0Z0jStwx/S6IbLdqw4kLEdKBQh
 XbrBgeLiU6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavHzEhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A79UH/3Fqh6i9aF9dqQPAA18MmZ2hZosvP/aOkRpVoWL
 qNbM4Yp7s7KfbAYHhFZjFWLTRylPI+Np/ef318p0b1IO7zf1TG1cR/N16qut5rVWoKZqRphsrPe
 3WDpya01Sg/pH+QolWVyXg4dgIE8t4+mVVUMnQr+DN1FXzEKM5dRYB9r5dFFA0buZxVjHCy31TC
 EcdffTxPUuspBiqD3n+DP6F4ScZvefZ8nO8mE5S/s7qoRmc/kK5q4FqCEboUyOonyeFrLXkfrCl
 2TRQMyiKFURE3UsCrLROyFgHekCZj80YCsjqt6c5IiMi2gWuCrdZ/wauP0AycPZCvrI5na+Bty7
 Fgfo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 16:32:28 -0500, David Lechner wrote:
> clk: mediatek: drop unused fdivs_offs from apmixed trees

Applied to mediatek-for-next, thanks!

[1/1] clk: mediatek: drop unused fdivs_offs from apmixed trees
      commit: c6aa9456dce08dd830db0a43d9cb4d69348c5318

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

