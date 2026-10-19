Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2FDCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08E3F80F74;
	Mon, 19 Oct 2026 08:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNm2VNy7GnFv; Mon, 19 Oct 2026 08:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1717B80F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400269;
	b=nYf1e93ahxSmr5kqKK5z0XFJfFr6RHpT7q2pujdQ1IXLkiUmhGKioeHPJpvydWhEIslG
	 clR5S8JLJek8xXcBA+cybVwRxSGsn4ooFctvFOrPIxj987uToDu1EtYhQ8p5qrPAatTcH
	 PUiu43jSwsyF7iH00rbggX+u8SysGkWLctY+1PggESouBiAWvbS3v3wyaN4RGuF4CNlld
	 I3FBePR83Af1FrRxMGSnFnhxDSmDdW2PZ3o/bJxwis3jtCVst7JBWPx0aDP5KzzCj/9Fv
	 IH+TsfxQ5bMs6VCRwuJqGEbseVK/iRw4mSxRnU0fYr8FKxO6pvQdv1mQxFLj7wOFbGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400269;
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
	bh=FfQ1qmLrd0gpbTgpObH9oG0g3PtXptjAfTl4bIggBL0=;
	b=KxvyXopjFadwqvvzYl+zvgJOsBEIBZPZJsF7lSUT/JV8qqHwdz742Ce2Zc2hmg0ZRjf6
	 b6JrVEsSYz3u1LexRA6yA3Vl67eprmm36JWj58CSjsPmQaed5DkCR02ecQKRyiVloshsr
	 SUu3gv7Dx4FR4JARsgeY8Xkkxz8MT2MlU5aZT2A4k5RmT61ngLrbeJZLjJ0wHS0B1WhCl
	 R9qB4q0Vfa3SVZzvZjaaN9A0sl/LBhU81gfILBYu7CaCVXfonSFz1CEPJNfzlF+Py8Z8r
	 zP4cRqw4z/EmUehD5DBn5FNIGNjBLxroQbcY+wajx2EOK2ovPEIAMyaAGuDy+Zgxh5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400269;
	bh=FfQ1qmLrd0gpbTgpObH9oG0g3PtXptjAfTl4bIggBL0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/28JFYGgKkZ3xyT7Hus6xWmrHGtyFi2Otj83qcgifp4ObgjUjIjtXtc3Xp/JlR1l
	 IprohlnsQcO1E3D+A8PbafHU13xoDV7RsS2AeG/2vb4Rk0EG3Ja40YzcMiTyn5Ygl9
	 A0WfsXzcMBh81GKiAxHcgNQ24LSi2rx8gUZkjezjUs76fHhdC6w5usByHNXVXAYRuO
	 C7sc8RzcLkfNd34zmGz5PLGFXp56bfzWy/8usWZXUleuPZuPmUihJNy4sX8B0SS0DQ
	 uDkb4pM/CX0N1wDiAuChHfWlblWn3XfuJ5kjPcmHPtQ509D7/FnGsULmZ5YmSdxr0D
	 3Cy3nHdPUNOCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1717B80F6E;
	Mon, 19 Oct 2026 08:57:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43C542A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29C9060600
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WU1vzDFFdujZ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 345926072D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400263;
 b=q6dbJT990tRjUjGLuyeP7VFBEEUMWB9yIX/rbui9AV0gEKH9nukBuzn2Z+O13I4wxTuX
 HhuYoPCBzjY/tNbaBmnggraTm0m3qlXt/NGNiYklb5r8pO7FvX3LPjXj67fbw4DF/xKVI
 ahxCykRLuR32DY+Vkh0HPBeoCsJfaacTASKWfO3utn3wYkI8vbJ35LPpJPkBsHuBjCULk
 ooSCdqfFacdQuAeRWFLSVgNiYNsw8PhmiM4jbS135FYRE5DV1/NnY/WmhOPxUZiVs5ZYb
 3FqOcvPnD7aHCrAKZQxzK0y1RXz2njgn9v8jwKzU+5llPAE2E7qnabH/FWmIm3B/s9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400263;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=FfQ1qmLrd0gpbTgpObH9oG0g3PtXptjAfTl4bIggBL0=;
 b=RPY9cGRddm3LpMMRG3VJjbVfv9rFiPuQCes8yQDITEJekPcwxcD7v118F/+FbiKX89q1
 ou8Rp1IfH+RQZbFwRTEfLltUjt0gfKoowRme9O0TiWMkxkR1hW/H8q6wevO7/mbvQCR8D
 l3U3V1iPvJ1ApiNC4OPRpOyBcdkIG99TKvRUi1aBYmfd/L/OOH5OvwYem2Swa5LZ5lC7Y
 saYD4X5P8tbsDKJ38/4N+a7ZF6B3sTiH/jRCJC2WpxHGfCPDt0jLpS6DGQSwjTV4LZS7X
 Uv6TbPiUhGcluNg6atMU0EvAcCqPYY2bzck4IYD6drs6WN/smMW/0zVuqE6OXcQ7jgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VnkJ1yvU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VnkJ1yvU
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 345926072D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:41 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso36991566b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400260; x=1793005060;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FfQ1qmLrd0gpbTgpObH9oG0g3PtXptjAfTl4bIggBL0=;
 b=VnkJ1yvUSoN6CGL/BRlJBE0TWhJaL98zYpCinH1OZltgi5RzUWBKfGE4hqM7DYU/Hr
 3UOo9BjKh7t8btq0/FEqBpHauRkd9pQaWyukWn+66nI9KogILz4uehCEhJQayOw8V/6n
 IUU6LdZ6WURuryOcJnj6k02IDlzP40StXOSh2FTfVBaRY8IJHeKKJ8xXgfpUyXymy9QC
 NYl6CO+R+aOHGT9QdEmCYGqzXt8SMbJmLURyAyH7Baww2Ark0tocQ/YdVPUYFARThCDb
 Ag3KQcvJq5geO6eW3/vDb+9uDj3SYwpo9kTZ2YhG4fizC9R/syuG2nwZUKI4KbMagkYQ
 CfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400260; x=1793005060;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FfQ1qmLrd0gpbTgpObH9oG0g3PtXptjAfTl4bIggBL0=;
 b=VKnY92p8okrjZO1i+jATWEchVHSXmLDJ3b8/P+pjhOxtmaZHa7jF21ieDEMdBbARZa
 8sHiSQUq4uYg3wSK4mG43ybay2hxCukmlgqRfBUtCz+rX44MVtANlSuWXt8WMU4ezrNn
 e1jIVBhT+o4E9sOwqvZhR3brDANpkV875k8Mx8iHdWftJznzuZrcXJH7uwhyA7BzGmSE
 zzZbes0p2Jnzrj9H1iQQxmTK+tlng7uJV6QAxdy0hJNs3efmvErRzLJBMKzXs5eVAFDp
 LtEFLIsKecHLnlD0fZI5faq4nrAmNKH+J4EylrNZg6Pi9vRyTY0VN1NYlrXmCGwHw5P9
 Gt2g==
X-Forwarded-Encrypted: i=1;
 AKwUvByYIjF/rL/FYl6AKUAsLpuIZQXVxcs5WqhlT5nrsWUEZWaLfCHfwBt2r2HRTjsS1Au85bZVHnU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIGEbmt57IFJ9o+UiWNWGqqiVEJXqg5iCVEx2ib6e/Fyjjh5U60
 0Y8rBg+JckY1UOEK/JERjificZn2anmkGCSoDARdfreTXxVcms5Nl+3/6QAtsLNHR4s=
X-Gm-Gg: AYBFou36eKOJGnxeHp6rXQ9+rgGXzrU+2Dh3pqUfkJZd1jEW1eGqZnvNF0f66XVzzEb
 QI8zlOpcRSOyT1gW8Hr/7M6ojU2SFZRvkCSBUuQtnn4kj72hhaFqeTB28DVSum9jsVbMpVDgz9T
 2W6cZo26IrO6HdY7tRgTASicwkixm3asXvxr7VvKTIo7ybjMFUKDwn9wTan9Yz0xzrqsL/J5BbA
 uOHS7lgNGeIFGaGcrFl/g8+ze+Y+SV/TcCLFQUedrhLemsEi0WD1BKxfRdA/yMkc+m48xvFiDH8
 +SCP5/gYa+uspYpxnVMqF8Wjje3zBVTpa1ukFt9YgePCZOKZr9edYCcr9ey8ECLS+7pKF82LdV8
 WtG7+j4VWbRBqghOQqV6ddi1js9eH+GovgqQg5Q4Njg8iYARuJNCXBmtnazTEWLqX68ogfL0VDy
 Q3CwASBeV17HwOueTGAupjR+Tt/+sYhexRXY80sysoBWxQfokdZkvrAOPMbSLqvssCoryxjF58I
 sHcrF3nLWJj9kaO87AC
X-Received: by 2002:a17:907:c605:10b0:c42:a326:78a9 with SMTP id
 a640c23a62f3a-c42a3267e26mr215740466b.42.1792400259983; 
 Mon, 19 Oct 2026 01:57:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:39 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/10] test/py: android: Move android image creation to
 a dedicated file
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-2-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-2-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024782.806974.446488410542238048.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=508;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=rANIWyvZNHYLWvYPtuAlznzinQQuH4P47IJChgUYSmA=;
 b=EFUEf585e+qeVW4dZkLABFl2AbudfwoM5PARChb+oLwalZEOn2UbveAYksuc0M2mKT7IKjUnl
 1I6cqgxQgBKBwZWwpGgKoUZ0icEFqO0bFg00MSJMX0OZlUH9gpudiOl
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

On Thu, 15 Oct 2026 15:54:52 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> The image creation code in test_ut is huge and difficult to follow.
> The android part contain code duplications when making mmc7.img/mmc8.img.
> 
> To prepare some code refactoring, move the Android specific bits into a
> dedicated file under test_android/.
> 
> No functional change.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
