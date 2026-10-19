Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93664CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21FA56075B;
	Mon, 19 Oct 2026 08:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jD3VOf0iAE-c; Mon, 19 Oct 2026 08:57:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E00646076D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400273;
	b=GfslsVhmoh9M04gnSXfMXXnzj64C93rOBSy2r42WYZFIDGwspzfY6KSRZix/auSkZoBz
	 kftH03dHp/s5hc62iRg8UXbb2k1hu7kjrPLx6r527EKBncMdU92ja5Wjx0yTzdJdZPmtf
	 UicvyQyNdiNfFuHfGUCozDFeYQs1jgh7SQG3JL+HDjOoMR3P46zMqqx0+EYLnnsxvFLzr
	 1EEfq7CZffKJZJ7xHzPx8a8gu75D8IoRMIY/KIXWEo47trSkV6YeKf0L/wR/6kj6+H4IV
	 aq3GIjjeEbDoTWGEEaO3ZZmztkug6xIscSwIej184ggi3aDxG154RQE5gug8iDg2Aow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400273;
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
	bh=j/DsO3maE6LnhpJKAF9GX/gvQLOYLK8fUuzcLM6iRHg=;
	b=su+J/pogWMS7HoStZBR7LUxUQNurY8uSMGc9AKcx0MtJEvxABMRzexP3YJJcyiwSMecV
	 XFWa5P68zd2RzEeW1SmP4swyoYZC+vUIn9wbT4oQtensMYsWTRuaBzTkPLkt/G4IY0fJL
	 8JxiTGZZpVA7bJjS9RFaNut3QAFZIpQDUQmPzjz9LNNFDKfE10zJzkJen0kCes9A+ZBbV
	 aonyNPEgNuvgy74+mPYW7SB6TyWd+a1ZbDbjsglosrO8sAs/9O9NSXhkVsbv2Ch7juLvZ
	 053MxaBx8JXLO0z49v6v8q3fa7Zl4yKp55y0xqiRWDPnsJYNuDj68qm9p7FYz3TTPbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400273;
	bh=j/DsO3maE6LnhpJKAF9GX/gvQLOYLK8fUuzcLM6iRHg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qhw4qVFS8P06nIv5EI9ycsAGkpQe9MD1F+mq1LS2ecDyzc+1fiq2thY1C5IfdE2+v
	 JwZo/hGgcn/JWupKADolTA/S3qpD9FOCroKykQv0pwoKeJ2v+VeLaNgN6UCjOJZPnK
	 N5hzbKWkrC4BzZnfs5JwdkkKUgLnhCfNNFVff73+KYG0DxNZt+bBRuKNWcfa1dzdtt
	 6X14H7Zo3q4tozA7KqwYWwHkQ/wDoH4NoG6Ax6P7wckNenpsaZK2FhLkSlMDfVFDbC
	 V61PwUMzO8Cn+pdYkx/NWDExb4G6YMv8XlcAlWY6XlPfUvEzaCNgzD5sMfBYZPRqGW
	 OjCwiAr6iDUzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E00646076D;
	Mon, 19 Oct 2026 08:57:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E75BD7E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5043580E15
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXgZWBgRP7y1 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D34580D00
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400264;
 b=rMsNNYKl68AFY6fGT5KnYc+U70MivawyKmqM6A6mhS99ZRQf75uG/Fh8nnvDGR9v/nQ8
 iJqIurowMXYV41Bjg9TaJcihTzoU+/o8bJ48Om5ZThRxQ5NwU18sUlDXEZoM8xUWncA+K
 U3lFh9t+1L3KYWDSuaWLKAmr222+opN/aNj8s/Uxc3Bu/FMAZ3yqii1l/IMQdyLBgXfzn
 QdVk1DpRdypeMr55a803Jm1Iz8GQkYK6h4PZw5Ks0CBBkOC0Tjoq8boifx5TWkOKrz4RW
 9vWTdYPkMSXApZ6EeV9+sx3zqFW+YDz1MEagliqivBhgazetNn+I9SfJmKlN6DNLuXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=j/DsO3maE6LnhpJKAF9GX/gvQLOYLK8fUuzcLM6iRHg=;
 b=nFOPY8vRRSkMwH02vlaY9Nlp0t6pFlf8N/OXR5u2ysYydaHaPwDrwtATD50SkWUYEJZg
 65C73FPCmXCXp/gd11+VrHT12wERL1Nc2uQOHWdxqfa0rcTThwWC0uY8X+5Mn54+sO4z0
 7DkRa+k5lIO2yWCOueiIDnxkGGLN+g85RqnNIR+/I4vXdov4UZC4uZSc2Tm5B5CfcwZ7e
 EeU4u7u+xU+omAIhNjx3fEQ29A4QqWJTNv0oksYGRQu7VimJeNxvaXM0INYZuKrSTus0V
 VmkMvoUpSMoOIpsQ4bUwUjGwUrcgOOGClr0y2cUYtzW+A7tfpl7DSYmyvmI3ZFdeQJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RpqTK2Hi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RpqTK2Hi
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D34580D00
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:42 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2dc63f8d8aso286951466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400261; x=1793005061;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j/DsO3maE6LnhpJKAF9GX/gvQLOYLK8fUuzcLM6iRHg=;
 b=RpqTK2Hi+NSITmpyY9owlkWYqjsaA5yYL52bThA7Y5FpecxU8MJ2fM3ikfB969tIxi
 ++21GGQF7i1kLQiuW3UXGiaYx/degupphq3S8WabILsMW2pCqgRL24DR88i+YGMbH4N+
 TB7k76cSdSav4B23ckCKElqZ2SUQhf+sn30KuhU0uUsCkSFEIXgSoL5+Tdd1UUsvAYil
 XKq6kIev3gqWOx3sZPnTwuqRcHs2PX513jOaKjZzc/DOKcurbqEcx6Vke/BbSv+Ypop8
 z0oySCNHknI9r1PIUzEQah7oPwMwAHKTVVqec9jomzNc0kuNcMm67w2ELkSxZQuqAo2p
 qjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400261; x=1793005061;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j/DsO3maE6LnhpJKAF9GX/gvQLOYLK8fUuzcLM6iRHg=;
 b=OTKEEZvAhs9lwp73QmqsWlAUDUT5aW2T4i1SgJLl9BLCNaZebAzY4b3gJj/ddqPThK
 ll5gT5P1Dg3bUM4HJ3Z2NaEZDAvxFDopP6Ox7ZfzCI1LIcZEgwUyZoOgRMFVXfl8W9d6
 VG+MrRNkFWJXIcal5ucInqkBmLrqiMOdp9baKNs6PO7gKnMmdXEUTVLC3pQ4apTeqMFo
 5ZL2s7+hFm8zIkpZ8VuuVfnEVbeeZzNgRdmEEqvFvCzOaZMLUO0NbEqe3+t1L02qtlc1
 5QMSxECzpo3wNXw9xCCHhT/Cilc9QiXpfg/zJ9nzV8DD6EgsKslAchPWFJlsQat+CN8i
 uc0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp2roB74TIsjJS/akIqOeP4ohdWJ4hgjbKSsspFbSXI+6MyE2SBd6LV5UOvcVEQsCLcQcu9Eg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL+HyOM9ZDq7Wl2riAy78kXal53FzaxsxtQrf4G7MMXs15O7nAi
 w3Jclr5/yp2fGLxJEN2tetZ8S1vLNO9A+U28qyKL241FPOfOR5WORET8bU7Ky7lM4+A=
X-Gm-Gg: AYBFou0lm+V0SGmdBkrERqisRAEWPnj8L0jlfQnTOY27UNnh/hFDFb13mZW+EQR/e1O
 WP8u1099uaLhcUyyBew2yQPKlSzJRiI9JLwEOKgFL+4K0Un7Y9/UHNDn6NdwAzC4y7OkWgxynQX
 rTJ43qcBoXI6mh/ECGXCzNpqYdqhqpwgoyfUWfnDUUrTDNWJSXQdrxR49iwqEmfF0ozHd/awPdF
 lwML0YLaoFEH6Z3mAgR/dGijY39JdLXP5QBMTxEmzVTe0yKU7zt1UvDSge1iUUiRmozO/zetA8B
 BkOsSk7ocYRIDSUwCmD5j2yZZdui+zzjhxm/aP07Aj0kkuEDLLP0VWnwgUoIjfXfPmZt+z2lYu1
 fepoIJhd+Hs1/A1Oiq5fDcdipKtCf0qltXoCIuZ4gDm1W2m3XmSqpec6wQxZtEvKTdw4zhZ309+
 0IIKFEZAq8D41uHRke90DrlT9wcZu2oYaJzBGeM4+xtQ3A5Z2NRirNnijUHH8QoCj4CELug2fDQ
 fnaXwvH+0XqefJujmNF
X-Received: by 2002:a17:907:6d26:b0:c41:731c:534 with SMTP id
 a640c23a62f3a-c419e43f9c6mr474733766b.24.1792400260666; 
 Mon, 19 Oct 2026 01:57:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/10] test/py: android: Drop verbose printing and
 unused return
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-3-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-3-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024783.806974.9591864142983200425.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=374;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=UrQMcPMWQKfeuRiJltKxiV0/LaLlY+W8O57JdbpFX1g=;
 b=zh3WkurIF9L3X/H50TBhun7Gm0zfe5msvW7hJHmnZq9s9cELIAZjl+QMC6ZrkHqFPmWrpb8Ai
 04aVOnQWKbwA36oh+8iCnNq5XiwJ7QqSvN1EVj7wQOiWr3GQa7/CQqg
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

On Thu, 15 Oct 2026 15:54:53 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> The setup_android_image() is only called once. The callers does not use
> the return value.
> 
> Drop the unused return. While at it, also remove the verbose printing.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
