Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990ECCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D238D4066A;
	Mon, 19 Oct 2026 08:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAHvM1ZmWJUa; Mon, 19 Oct 2026 08:57:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2379940740
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400271;
	b=pPh0WFepFPD0EMeq7R/qvoMZq1L3D+WwBq2ZwLI3wM/doVGq4WR3egG9fRu4bw0nsL6Z
	 lzxVOMt/pxCleJ4qoC+R81qCoV6TsRQWS3FTrq8HR/8VkGHtosO0CgfmF3AP83l07yQJG
	 7+4WSxc2p/5ZWPo3y82mFevPQR/28vIliu8jeJUo1ta1oPqvFu6fpnzga4plerQHH4wTZ
	 WL4XxLIM26M2zz1iQeY0yWwuGmI8/JBEI4bWLurYnJ5rz3XktPzzE4rK9eAGk8JiWbZId
	 BX4M3fr3aaMizC7SWMddJgHs7Fne7Q/0AL7Ds4yPY38REQLNKoL1uq00AU+OOpZiObg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CaZfDK52kMpgb/bWY91SZBgh5bEnyiN8jmOnD2zkbnA=;
	b=IlBxqodTdJXJ+Ueb9bkHyGukO9Q2k4vcelKkZRxW5bgMKFR8aInqYl/DIRutdp5HtYJL
	 RDshj61J9ff1SS0t9cgSWrh1t+YA/JxY4NoyPkay+RTIXd6WwvN+k6fUL8GC8BduQDk7A
	 +9ryzx/ye5Se8jPTee8zsXzqdyhMadwraxOuqeS22t3x0LB90g/bIhMOkXcWkr7iY/rlF
	 c7pny3sGrm7cZ4C2eyxppC+izaxfZ1iDt6mDiYguLVMEJgXFsKr5f3/y+84f3EbCuN8tz
	 lj3tZo79WUtvW3p3cwPmR7C5gHc3j0Os7McDHf6FSJiiNYg7P0aSMgCPjLmoAvlRXuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400271;
	bh=CaZfDK52kMpgb/bWY91SZBgh5bEnyiN8jmOnD2zkbnA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAoKArvkgMOILZzN96mYJ5HPPlAyqMXNtXPBvtjTGbgejXyd5uPcuvbG+SWYx+FM/
	 LRJrujcApw8ZlzZiFagpkmC4ZZZllZ7gwfAwnZ7D0YeL/TOrQQHcF2kWsNGrpqWHwV
	 SW/4ENnuDrM50utfmXoVi521l0YP7swTnJUAFVB0ZAnuMAz8gavjjSiK/oCgvH3ghu
	 Zy/M7/o/NBabV5wf4sHVvy7V4PZtJLQ71nVz9o3puf0tRNPoFWjC7A1NxN5TZiNBdz
	 +O6Dz+nveuU1H4YGAF6+28qPozfSL75oGkxX7k3fOh/lVc/ZqJYFpTm4vtgTY1iZex
	 gjLQ8b+h8+Jsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2379940740;
	Mon, 19 Oct 2026 08:57:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50EB51DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43273401EB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElWW3hIkkEhC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1BAF440062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400264;
 b=hSDNqootYuykHsOVT2CHqeqV1fJJAHlsnvrtK+4MvKmO0xrt5L65+nq8d+jkJAV/ji6Y
 M/nQOA6rlkH2YRAS/rIe5uYvK4qWMU3eEpU8WNm2s1EFqQEjdw1i3aN/YngFLSP1LVG7A
 v8ELBkFO0ofbDbIlurQn0qajsyIjjoiOWucGAsVDM9Tgizwgegm7tLU58UThaoZdDGJB9
 NxgHAud9HR/5XhiInbWuNANwar2jyqoiQQ+MkwU2SvINmE+INEZ8MCJ9iNCtMZDQiCTMW
 03tpNOKYp3W8ZzbmsldS62R9//0+R4hPStz0XcAUKqnpz9BXJ1JuLiKviANb3QE8P0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=CaZfDK52kMpgb/bWY91SZBgh5bEnyiN8jmOnD2zkbnA=;
 b=PhymnA2c3tpeJg+dG7r9h4RSXca1da6SjnILw0THbFNCXclKVjmmNdD/e5A1kdxEgskM
 EM2mS9L5fxy6ZRfhUXB3LoUHdPn0UXT+HJKz7HM6fiPkTnvSq8LJ8Aj3zAn1L5IuSHUur
 LPqiBTkc7ZNzGW96IjeAPC9PtZOZ2pEuTXvaWRucTtkYO0mj8V2pWvB/3FwRVp2gS3+z4
 m769Or/N5L1mzvXJojmq00F5beKAE2Wje+L+PP7zl7BYfnOxFsy8dbc6MPy/PC6bTofMb
 9+h1L6kuNrU6TxQdbxXzZia3gOXCUcX/7Otg/8PzAH9wld52ZptQwpE6+nESWAm01/g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cytWz7tC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cytWz7tC
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BAF440062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso215055266b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400261; x=1793005061;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CaZfDK52kMpgb/bWY91SZBgh5bEnyiN8jmOnD2zkbnA=;
 b=cytWz7tCBas1WWsxvbVB3haCA7WtbJDXEx1XS76wbi9YD5ymUFDowzx7Nm2qBIHwXs
 Js8QZWKs4X3wKoYrwjFavKrilnaan/3Nk7oEDzjGDFXTDpYdnS5wI8uXvDm9n1QbITr5
 pJQdSqtP2Ilze/BeuzAAenHIS92mhJrFSPipR5SF9QSQF3hbcqp20K6/1WZYtwVqq6Je
 /Zvv52VoUtI9tX+AMN27dJiAL6en5ZAbyXAnGPevAsMvYF6Z0ZJJamI8u580U42siIlo
 qjnCjQTUh27IPeJv92T6al8x2445ut7ex9s4ZSGX14EYsPzwv758wLqjh2PP4w0wEe9g
 KdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400261; x=1793005061;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CaZfDK52kMpgb/bWY91SZBgh5bEnyiN8jmOnD2zkbnA=;
 b=LlfkYvRKEbR9EEIODpkS9eCZT+7sLORuusYYnztb8bbDMwdH+ULfbVF53onlBYxB53
 Ny+3EMJDjbYwjvZGGpk5g59UsqJrDoqV5yBOfEMwLxFd1TQDmqzsd67Qha7Q75tBC4U3
 rBgyCwnA585bZURegoxdFoaiwd4BPaxQyUp1EUCQgAJlANnbG2LcqWJkvVtI9TR0yYFs
 z7JeGFsQS0wQ34afqiJDGHN1mK0sE6Tj9f18YUjqju1KT34mdFhaCKFKr54wEQK9FCex
 nfqNc9skkvtQCy1QMtsa0POs8M3o24JETWkioNF5D5BuMtgsr9gnarPHBtT7Rc2/eszI
 nb6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3oIyVvWmSWG0DYA84lvWcDTLhGojIqQwM0L7XOlLpGQwUh6TPOIcsOuv+jipRf5arSbzEQrc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZQ8nnisPtH4mGM7Ffwyjhu8Q83nfu47+VrSTZ9R4eto2F9D4J
 1rQB/pRO9IqG+KhKwZFeHDXAeUZq6Y1YKkF/xw7HussG1yzyyJIXQTYysFopzp5BQ50=
X-Gm-Gg: AYBFou0KLiY8Romul/fEH9FhM3y8wJv/n/jdtr8SwruCNmvLs4Y6ci0PwsKheBzAwm8
 kGaLMtLM8LfLhMXSAd0+tFwM9pI7n3uqViv3OGsWyBCQdPhkbRSDdL1SRCJTZYTJFh7t5mFOhZv
 Awq34a96JJZUru07TvNilY5kfVPY2CGmzaGvc3UIn8wjvD+X5u23WOyGsXycliSxu17+YFqAgTa
 LYTEIrL+GNLvLmPt9PANlB4T9LSt5oHpFX9pPFhsqU9Ta9cnKe9d0v2B5gOjf0L3LjXfWATxrZL
 0GFREXjkdj+S6lgOdUxDjSaB0BBN4Nb4e5VF6ATGL5onJeHKTs8B+7m1DGrj0cJwRgnmborQ/Cg
 yG6gZ2GzMUkP0Krz3oLbV813eHa6Y35NQo7/SIKZFVETj8zZH6mlVA/rT1ivLwIpCWh4uYArJ3j
 URa+qKteXUsdGtDuYgRdEHUSyayD56rvWl4ik2MxFc2xv/T1lzgaHaIniTsErj1P258ALhwxXN5
 m4/8P4mxDp0ULlt4oLI
X-Received: by 2002:a17:907:3f1f:b0:c2e:4e08:19ab with SMTP id
 a640c23a62f3a-c419df3e373mr485967166b.16.1792400261320; 
 Mon, 19 Oct 2026 01:57:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:41 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/10] test/py: android: Use for loop to create the
 images / update disks
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-4-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-4-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024783.806974.14476850745465202049.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=452;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=SBSACemYHrau8M5ebBlAneE+cc7DhfetlGKbSUu2Waw=;
 b=xEYAJynzA/DqeQw+5JzrJkF96mPFL7/6a11jEV2ToSc00GPZBwqAxjS1qiS45WQGDXB8GPr+4
 V/LMwq7EJnjCnZ2x6uxLO3Kj/WljdgpE8IklnovZUdsuTdJfxCtNadK
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:54 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> setup_android_image() creates 2 mmcX.img files:
> 
> * mmc7.img: For boot image v4 support
> * mmc8.img: For boot image v2 support
> 
> There is quite some code that's common for both images. Currently,
> most code is duplicated.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
